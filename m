Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C437736DE4
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 15:50:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230470AbjFTNul (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 09:50:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232846AbjFTNuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 09:50:13 -0400
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D75D61986;
        Tue, 20 Jun 2023 06:49:50 -0700 (PDT)
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-30a9df84328so1034230f8f.0;
        Tue, 20 Jun 2023 06:49:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687268989; x=1689860989;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hlxEnYUT/GBNJ3ibxmMMF9Ie5mQ6Tr4qzFp00sesHFs=;
        b=il2iSWXv34zrjXyWte/+CiwCeP7svryEVofFYKpwYo3CPzeA1DrbCkyF/EKQUuHgC+
         cLREohQc8qVIV2xWilkGwH9KCY6UFTIDvekNz7EDlPOSfC0imMrZrhM2UUqxtptjnQkE
         ZjrKQiJPwdPMqhWw3tBmGM3yP1+r8nQGjH7oL4/E/fIfQzqXIJSXY23Bu3DeaPrwDXhW
         8lBUUq1+WG1YuLT5mmeWIu6QQOv62NrrtxJMmE0+fWrEwikpgqCXaJu8Ay5O+tEm1V8z
         YpIW5nUOFywf3GHE2pdWmksu9blZ/IM0eUEXDUrvfe36aHRE8YS+4GcmNn0UYyYnswe2
         nbFg==
X-Gm-Message-State: AC+VfDwdFBGei9Xx/0rfJqVg1xlN8LUXdcaw8+ws0AFNnp3L/tuPhBrJ
        1e7W6IjOyHJBy/HAeiBoZoPBp6TJg/I=
X-Google-Smtp-Source: ACHHUZ7dfSygVmSYoeR8bcP0LWtDsP3kSnE1m9tFQ7YhYMY1daxOcmdm5XHD3k6L8NIykPxUMXsgdg==
X-Received: by 2002:a5d:66d0:0:b0:311:166b:b3b0 with SMTP id k16-20020a5d66d0000000b00311166bb3b0mr8870155wrw.7.1687268988999;
        Tue, 20 Jun 2023 06:49:48 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id m13-20020adff38d000000b003113ed02080sm2044736wro.95.2023.06.20.06.49.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jun 2023 06:49:48 -0700 (PDT)
Message-ID: <380cde65-8794-cfbc-237f-30a8d7e9330c@grimberg.me>
Date:   Tue, 20 Jun 2023 16:49:45 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH blktests v1 1/3] nvme/048: Check for queue count check
 directly
Content-Language: en-US
To:     Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Shin'ichiro Kawasaki <shinichiro@fastmail.com>,
        Hannes Reinecke <hare@suse.de>,
        James Smart <jsmart2021@gmail.com>,
        Martin Belanger <Martin.Belanger@dell.com>
References: <20230620132703.20648-1-dwagner@suse.de>
 <20230620132703.20648-2-dwagner@suse.de>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230620132703.20648-2-dwagner@suse.de>
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


> The test monitored the state changes live -> resetting -> connecting ->
> live, to figure out the queue count change was successful.
> 
> The fc transport is reconnecting very fast and the state transitions
> are not observed by the current approach.
> 
> So instead trying to monitor the state changes, let's just wait for the
> live state and the correct queue number.
> 
> As queue count is depending on the number of online CPUs we explicitly
> use 1 and 2 for the max_queue count. This means the queue_count value
> needs to reach either 2 or 3 (admin queue included).
> 
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>   tests/nvme/048 | 35 ++++++++++++++++++++++++-----------
>   1 file changed, 24 insertions(+), 11 deletions(-)
> 
> diff --git a/tests/nvme/048 b/tests/nvme/048
> index 81084f0440c2..3dc5169132de 100755
> --- a/tests/nvme/048
> +++ b/tests/nvme/048
> @@ -42,6 +42,26 @@ nvmf_wait_for_state() {
>   	return 0
>   }
>   
> +nvmf_wait_for_queue_count() {
> +	local subsys_name="$1"
> +	local queue_count="$2"
> +	local nvmedev
> +
> +	nvmedev=$(_find_nvme_dev "${subsys_name}")
> +
> +	queue_count_file="/sys/class/nvme-fabrics/ctl/${nvmedev}/queue_count"
> +
> +	nvmf_wait_for_state "${subsys_name}" "live" || return 1
> +
> +	queue_count=$((queue_count + 1))
> +	if grep -q "${queue_count}" "${queue_count_file}"; then
> +		return 0
> +	fi
> +
> +	echo "expected queue count ${queue_count} not set"
> +	return 1
> +}
> +
>   set_nvmet_attr_qid_max() {
>   	local nvmet_subsystem="$1"
>   	local qid_max="$2"
> @@ -56,10 +76,7 @@ set_qid_max() {
>   	local qid_max="$3"
>   
>   	set_nvmet_attr_qid_max "${subsys_name}" "${qid_max}"
> -
> -	# Setting qid_max forces a disconnect and the reconntect attempt starts
> -	nvmf_wait_for_state "${subsys_name}" "connecting" || return 1
> -	nvmf_wait_for_state "${subsys_name}" "live" || return 1
> +	nvmf_wait_for_queue_count "${subsys_name}" "${qid_max}" || return 1

Why not simply wait for live? The connecting is obviously racy...

>   
>   	return 0
>   }
> @@ -77,12 +94,8 @@ test() {
>   
>   	_setup_nvmet
>   
> -	hostid="$(uuidgen)"
> -	if [ -z "$hostid" ] ; then
> -		echo "uuidgen failed"
> -		return 1
> -	fi
> -	hostnqn="nqn.2014-08.org.nvmexpress:uuid:${hostid}"
> +	hostid="${def_hostid}"
> +	hostnqn="${def_hostnqn}"
>   
>   	truncate -s "${nvme_img_size}" "${file_path}"
>   
> @@ -103,7 +116,7 @@ test() {
>   			echo FAIL
>   		else
>   			set_qid_max "${port}" "${subsys_name}" 1 || echo FAIL
> -			set_qid_max "${port}" "${subsys_name}" 128 || echo FAIL
> +			set_qid_max "${port}" "${subsys_name}" 2 || echo FAIL
>   		fi
>   
>   		_nvme_disconnect_subsys "${subsys_name}"
