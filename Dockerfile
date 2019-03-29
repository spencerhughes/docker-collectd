FROM debian:stretch-slim
MAINTAINER Spencer Hughes, spencer@somanydoors.ca

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get -qq update && \
    apt-get -qq upgrade && \
    apt-get -qq install \
        git \
        curl \
        gnupg2 \
        apt-utils \
        apt-transport-https \
    && \
    apt-get -qq autoremove && \
    apt-get -qq clean

RUN mkdir -p /usr/share/man/man1 && \
    apt-get -qq update && \
    apt-get -qq install \
        collectd \
        collectd-core \
        collectd-utils \
    && \
    apt-get -qq autoremove && \
    apt-get -qq purge

#RUN echo deb http://deb.debian.org/debian/ unstable main > /etc/apt/sources.list.d/unstable.list && \
#    apt-get -qq update && \
#    apt-get -qq install \
#        autoconf \
#        automake \
#        autotools-dev \
#        bison \
#        build-essential \
#        flex \
#        iptables-dev \
#        libcurl4-gnutls-dev \
#        libdbi0-dev \
#        libesmtp-dev \
#        libganglia1-dev \
#        libgcrypt11-dev \
#        libglib2.0-dev \
#        libhiredis-dev \
#        libltdl-dev \
#        liblvm2-dev \
#        libmemcached-dev \
#        libmnl-dev \
#        libmodbus-dev \
#        libmysqlclient-dev \
#        libopenipmi-dev \
#        liboping-dev \
#        libow-dev \
#        libpcap-dev \
#        libperl-dev \
#        libpq-dev \
#        libprotobuf-c-dev \
#        librabbitmq-dev \
#        librrd-dev \
#        libsensors4-dev \
#        libsnmp-dev \
#        libtokyocabinet-dev \
#        libtokyotyrant-dev \
#        libtool \
#        libupsclient-dev \
#        libvirt-dev \
#        libxml2-dev \
#        libyajl-dev \
#        linux-libc-dev \
#        pkg-config \
#        protobuf-c-compiler \
#        python-dev \
#    && \
#    rm -rf /usr/share/doc/* && \
#    rm -rf /usr/share/info/* && \
#    rm -rf /tmp/* && \
#    rm -rf /var/tmp/* && \
#    apt-get -qq autoremove && \
#    apt-get -qq purge

ADD collectd.conf /etc/collectd/
ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
