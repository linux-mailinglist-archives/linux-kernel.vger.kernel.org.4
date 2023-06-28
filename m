Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79ED47418B5
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 21:11:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230507AbjF1TK6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 15:10:58 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:59678 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjF1TKy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 15:10:54 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E56BD21861;
        Wed, 28 Jun 2023 19:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1687979452; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=y163GLXlIY7qQsdU/MbbES2r1FokRyWxT2xQc4IuSco=;
        b=17CHUniKf0kpKinjDite2jRJXssHfqK40e1/swrE7qF5cXCkgD2qvey1hwhZU8oG00/s0/
        uyLuQgxHC/ZJ7AD0LS7wn6ws8zEfb4d2MXD89ZLYY0sOLqvdpaySzF2DjU2Zww9LQ+8KtF
        GmviuAoMpLFTGt0XuYt/dGdbNIU2p+k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1687979452;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=y163GLXlIY7qQsdU/MbbES2r1FokRyWxT2xQc4IuSco=;
        b=IGpxo9K3rNcAG0ewnJPK+dXjMJIukTj3HK8YG5HtQCL5GCwttnChcPm7gjQoiYCDkZfZpV
        ixTbk3vzz2h4oNDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D6DF0138EF;
        Wed, 28 Jun 2023 19:10:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id /hEmNLyFnGRzIQAAMHmgww
        (envelope-from <dwagner@suse.de>); Wed, 28 Jun 2023 19:10:52 +0000
Date:   Wed, 28 Jun 2023 21:10:52 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Shin'ichiro Kawasaki <shinichiro@wdc.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Hannes Reinecke <hare@suse.de>,
        James Smart <jsmart2021@gmail.com>
Subject: Re: [PATCH blktests v2 2/3] nvme/rc: Avoid triggering host nvme-cli
 autoconnect
Message-ID: <edoiq74rpu6qejs6m3dsvtp73ypjixafp6dsncg7kga7n4uwdr@xc7mgaerwqbk>
References: <20230628151623.11340-1-dwagner@suse.de>
 <20230628151623.11340-3-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230628151623.11340-3-dwagner@suse.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 28, 2023 at 05:16:22PM +0200, Daniel Wagner wrote:
> When the host has enabled the udev/systemd autoconnect services for the
> fc transport it interacts with blktests and make tests break.
> 
> nvme-cli learned to ignore connects attemps when using the --context
> command line option paired with a volatile configuration. Thus we can
> mark all the resources created by blktests and avoid any interaction
> with the systemd autoconnect scripts.
> 
> Only enabled this for the fc transport.
> 
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>  tests/nvme/rc | 81 ++++++++++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 71 insertions(+), 10 deletions(-)
> 
> diff --git a/tests/nvme/rc b/tests/nvme/rc
> index 191f3e2e0c43..06d98f46b471 100644
> --- a/tests/nvme/rc
> +++ b/tests/nvme/rc
> @@ -14,8 +14,8 @@ def_remote_wwnn="0x10001100aa000001"
>  def_remote_wwpn="0x20001100aa000001"
>  def_local_wwnn="0x10001100aa000002"
>  def_local_wwpn="0x20001100aa000002"
> -def_hostnqn="$(cat /etc/nvme/hostnqn 2> /dev/null)"
> -def_hostid="$(cat /etc/nvme/hostid 2> /dev/null)"
> +def_hostnqn="nqn.2014-08.org.nvmexpress:uuid:242d4a24-2484-4a80-8234-d0169409c5e8"
> +def_hostid="242d4a24-2484-4a80-8234-d0169409c5e8"
>  nvme_trtype=${nvme_trtype:-"loop"}
>  nvme_img_size=${nvme_img_size:-"1G"}
>  nvme_num_iter=${nvme_num_iter:-"1000"}
> @@ -161,6 +161,57 @@ _nvme_calc_rand_io_size() {
>  	echo "${io_size_kb}k"
>  }
>  
> +_have_nvme_cli_context() {
> +	# ignore all non-fc transports
> +	if [[ "${nvme_trtype}" == "fc" ]] ||

This should be !=, forgot to merge a fixup to this patch.

> +	   ! nvme connect --help 2>&1 | grep -q -- '--context=<STR>' > /dev/null; then
> +		    return 1
> +	fi
> +	return 0
> +}
> +
> +_setup_nvme_cli() {
> +	local local_wwnn="${1}"
> +	local local_wwpn="${2}"
> +	local remote_wwnn="${3}"
> +	local remote_wwpn="${4}"
> +
> +	if ! _have_nvme_cli_context; then
> +		return
> +	fi
> +
> +	mkdir -p /run/nvme
> +	cat >> /run/nvme/blktests.json <<-EOF
> +	[
> +	  {
> +	    "hostnqn": "${def_hostnqn}",
> +	    "hostid": "${def_hostid}",
> +	    "subsystems": [
> +	      {
> +	        "application": "blktests",
> +	        "nqn": "blktests-subsystem-1",
> +	        "ports": [
> +	          {
> +	            "transport": "fc",
> +	            "traddr": "nn-${remote_wwnn}:pn-${remote_wwpn}",
> +	            "host_traddr": "nn-${local_wwnn}:pn-${local_wwpn}"
> +	          }
> +	        ]
> +	      }
> +	    ]
> +	  }
> +	]
> +	EOF
> +}
> +
> +_cleanup_nvme_cli() {
> +	if ! _have_nvme_cli_context; then
> +		return
> +	fi
> +
> +	rm -f /run/nvme/blktests.json
> +}
> +
>  _nvme_fcloop_add_rport() {
>  	local local_wwnn="$1"
>  	local local_wwpn="$2"
> @@ -193,6 +244,9 @@ _setup_fcloop() {
>  	local remote_wwnn="${3:-$def_remote_wwnn}"
>  	local remote_wwpn="${4:-$def_remote_wwpn}"
>  
> +	_setup_nvme_cli "${local_wwnn}" "${local_wwpn}" \
> +			"${remote_wwnn}" "${remote_wwpn}"
> +
>  	_nvme_fcloop_add_tport "${remote_wwnn}" "${remote_wwpn}"
>  	_nvme_fcloop_add_lport "${local_wwnn}" "${local_wwpn}"
>  	_nvme_fcloop_add_rport "${local_wwnn}" "${local_wwpn}" \
> @@ -235,6 +289,8 @@ _cleanup_fcloop() {
>  	_nvme_fcloop_del_lport "${local_wwnn}" "${local_wwpn}"
>  	_nvme_fcloop_del_rport "${local_wwnn}" "${local_wwpn}" \
>  			       "${remote_wwnn}" "${remote_wwpn}"
> +
> +	_cleanup_nvme_cli
>  }
>  
>  _cleanup_nvmet() {
> @@ -436,18 +492,18 @@ _nvme_connect_subsys() {
>  	trtype="$1"
>  	subsysnqn="$2"
>  
> -	ARGS=(-t "${trtype}" -n "${subsysnqn}")
> +	ARGS=(-t "${trtype}"
> +	      -n "${subsysnqn}"
> +	      --hostnqn="${hostnqn}"
> +	      --hostid="${hostid}")
> +	if _have_nvme_cli_context; then
> +		ARGS+=(--context="blktests")
> +	fi
>  	if [[ "${trtype}" == "fc" ]] ; then
>  		ARGS+=(-a "${traddr}" -w "${host_traddr}")
>  	elif [[ "${trtype}" != "loop" ]]; then
>  		ARGS+=(-a "${traddr}" -s "${trsvcid}")
>  	fi
> -	if [[ "${hostnqn}" != "$def_hostnqn" ]]; then
> -		ARGS+=(--hostnqn="${hostnqn}")
> -	fi
> -	if [[ "${hostid}" != "$def_hostid" ]]; then
> -		ARGS+=(--hostid="${hostid}")
> -	fi
>  	if [[ -n "${hostkey}" ]]; then
>  		ARGS+=(--dhchap-secret="${hostkey}")
>  	fi
> @@ -482,7 +538,12 @@ _nvme_discover() {
>  	local host_traddr="${3:-$def_host_traddr}"
>  	local trsvcid="${3:-$def_trsvcid}"
>  
> -	ARGS=(-t "${trtype}")
> +	ARGS=(-t "${trtype}"
> +	      --hostnqn="${def_hostnqn}"
> +	      --hostid="${def_hostid}")
> +	if _have_nvme_cli_context; then
> +		ARGS+=(--context="blktests")
> +	fi
>  	if [[ "${trtype}" = "fc" ]]; then
>  		ARGS+=(-a "${traddr}" -w "${host_traddr}")
>  	elif [[ "${trtype}" != "loop" ]]; then
> -- 
> 2.41.0
> 
