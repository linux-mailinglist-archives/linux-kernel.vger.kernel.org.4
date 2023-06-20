Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22A1B736E49
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 16:07:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232964AbjFTOHw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 10:07:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232412AbjFTOHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 10:07:50 -0400
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DD5BE58;
        Tue, 20 Jun 2023 07:07:48 -0700 (PDT)
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-3f9b38e4e29so4545135e9.0;
        Tue, 20 Jun 2023 07:07:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687270066; x=1689862066;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HHDvUdN+oRU2iMEgn1t7pRaNmxE6JGuZWiNo/5GWyY4=;
        b=fanKIq653AXr40+x6WNYh2jKarV/9YzrnxBNkNMyQ8Bs7xN6axcqMEgFBubSYzZDas
         vaXJtyyKK8d1j10WyluNFmaBecleyKsD7LEX/F4mQRRTQkdomPCCpmcMcBIEHo8MuOhf
         fDQXmZriSdZxgVgsmrZlUWiPlgqshxHFVy+Kf3UHfIqNq/akMtsVoSomb0yxKt2BtY1Y
         PJt0JmaKhWEH4tOdJKBCNlgZU+e4gstju63hAw9TMoWmNOzpxgGxB7U1wITaufSzoyot
         urjgjP9YTu87+ZqiVI6b74oA2uqa0AmD0Aq/f6ocpaJ80o2L3kXquKu1p4ckUrqrshba
         VRWA==
X-Gm-Message-State: AC+VfDydjvqT+liM/lvs3WPrIYaPwOPMHqtBQ/gYoQ7l3r9MJ3Ez3TG1
        cIuaPeJ3QmKAh0zUQX1vP48=
X-Google-Smtp-Source: ACHHUZ6piCilQNu/uvBXQjuiMjhYHBZ+tN2L+h9TcYR7FRPajQG6f85LOzKioBcz99YGAe6CKWcu1A==
X-Received: by 2002:a05:600c:6349:b0:3f9:b3f9:fac4 with SMTP id du9-20020a05600c634900b003f9b3f9fac4mr3677814wmb.1.1687270066361;
        Tue, 20 Jun 2023 07:07:46 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id n6-20020a7bcbc6000000b003f7e4d143cfsm2453909wmi.15.2023.06.20.07.07.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jun 2023 07:07:45 -0700 (PDT)
Message-ID: <af640019-b867-d488-0443-797a75ba4195@grimberg.me>
Date:   Tue, 20 Jun 2023 17:07:43 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH blktests v1 2/3] nvme/rc: Avoid triggering host nvme-cli
 autoconnect
Content-Language: en-US
To:     Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Shin'ichiro Kawasaki <shinichiro@fastmail.com>,
        Hannes Reinecke <hare@suse.de>,
        James Smart <jsmart2021@gmail.com>,
        Martin Belanger <Martin.Belanger@dell.com>
References: <20230620132703.20648-1-dwagner@suse.de>
 <20230620132703.20648-3-dwagner@suse.de>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230620132703.20648-3-dwagner@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> When the host has enabled the udev/systemd autoconnect services for the
> fc transport it interacts with blktests and make tests break.
> 
> nvme-cli learned to ignore connects attemps when using the
> --context command line option paired with a volatile configuration. Thus
> we can mark all the resources created by blktests and avoid any
> interaction with the systemd autoconnect scripts.

Hmm... is this hapenning with non-fc as well?

> 
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>   tests/nvme/rc | 73 ++++++++++++++++++++++++++++++++++++++++++++-------
>   1 file changed, 63 insertions(+), 10 deletions(-)
> 
> diff --git a/tests/nvme/rc b/tests/nvme/rc
> index 191f3e2e0c43..00117d314a38 100644
> --- a/tests/nvme/rc
> +++ b/tests/nvme/rc
> @@ -14,8 +14,8 @@ def_remote_wwnn="0x10001100aa000001"
>   def_remote_wwpn="0x20001100aa000001"
>   def_local_wwnn="0x10001100aa000002"
>   def_local_wwpn="0x20001100aa000002"
> -def_hostnqn="$(cat /etc/nvme/hostnqn 2> /dev/null)"
> -def_hostid="$(cat /etc/nvme/hostid 2> /dev/null)"
> +def_hostnqn="nqn.2014-08.org.nvmexpress:uuid:242d4a24-2484-4a80-8234-d0169409c5e8"
> +def_hostid="242d4a24-2484-4a80-8234-d0169409c5e8"
>   nvme_trtype=${nvme_trtype:-"loop"}
>   nvme_img_size=${nvme_img_size:-"1G"}
>   nvme_num_iter=${nvme_num_iter:-"1000"}
> @@ -161,6 +161,50 @@ _nvme_calc_rand_io_size() {
>   	echo "${io_size_kb}k"
>   }
>   
> +_nvme_cli_supports_context() {
> +	if ! nvme connect --help 2>&1 | grep -q context > /dev/null; then
> +		    return 1
> +	fi
> +	return 0
> +}

Not a great way to check support.

> +
> +_setup_nvme_cli() {
> +	if ! _nvme_cli_supports_context; then
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
> +	            "traddr": "nn-${def_remote_wwnn}:pn-${def_remote_wwpn}",
> +	            "host_traddr": "nn-${def_local_wwnn}:pn-${def_local_wwpn}"
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
> +	if ! _nvme_cli_supports_context; then
> +		return
> +	fi
> +
> +	rm -f /run/nvme/blktests.json
> +}
> +
>   _nvme_fcloop_add_rport() {
>   	local local_wwnn="$1"
>   	local local_wwpn="$2"
> @@ -235,6 +279,8 @@ _cleanup_fcloop() {
>   	_nvme_fcloop_del_lport "${local_wwnn}" "${local_wwpn}"
>   	_nvme_fcloop_del_rport "${local_wwnn}" "${local_wwpn}" \
>   			       "${remote_wwnn}" "${remote_wwpn}"
> +
> +	_cleanup_nvme_cli
>   }
>   
>   _cleanup_nvmet() {
> @@ -337,6 +383,8 @@ _setup_nvmet() {
>   		def_host_traddr=$(printf "nn-%s:pn-%s" \
>   					 "${def_local_wwnn}" \
>   					 "${def_local_wwpn}")
> +
> +		_setup_nvme_cli
>   	fi
>   }
>   
> @@ -436,18 +484,18 @@ _nvme_connect_subsys() {
>   	trtype="$1"
>   	subsysnqn="$2"
>   
> -	ARGS=(-t "${trtype}" -n "${subsysnqn}")
> +	ARGS=(-t "${trtype}"
> +	      -n "${subsysnqn}"
> +	      --hostnqn="${hostnqn}"
> +	      --hostid="${hostid}")
> +	if _nvme_cli_supports_context; then
> +		ARGS+=(--context="blktests")
> +	fi
>   	if [[ "${trtype}" == "fc" ]] ; then
>   		ARGS+=(-a "${traddr}" -w "${host_traddr}")
>   	elif [[ "${trtype}" != "loop" ]]; then
>   		ARGS+=(-a "${traddr}" -s "${trsvcid}")
>   	fi
> -	if [[ "${hostnqn}" != "$def_hostnqn" ]]; then
> -		ARGS+=(--hostnqn="${hostnqn}")
> -	fi
> -	if [[ "${hostid}" != "$def_hostid" ]]; then
> -		ARGS+=(--hostid="${hostid}")
> -	fi
>   	if [[ -n "${hostkey}" ]]; then
>   		ARGS+=(--dhchap-secret="${hostkey}")
>   	fi
> @@ -482,7 +530,12 @@ _nvme_discover() {
>   	local host_traddr="${3:-$def_host_traddr}"
>   	local trsvcid="${3:-$def_trsvcid}"
>   
> -	ARGS=(-t "${trtype}")
> +	ARGS=(-t "${trtype}"
> +	      --hostnqn="${def_hostnqn}"
> +	      --hostid="${def_hostid}")
> +	if _nvme_cli_supports_context; then
> +		ARGS+=(--context="blktests")
> +	fi
>   	if [[ "${trtype}" = "fc" ]]; then
>   		ARGS+=(-a "${traddr}" -w "${host_traddr}")
>   	elif [[ "${trtype}" != "loop" ]]; then
