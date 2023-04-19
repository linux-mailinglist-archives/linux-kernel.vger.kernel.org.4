Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 103056E769B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 11:45:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232405AbjDSJpF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 05:45:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232395AbjDSJpD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 05:45:03 -0400
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3529D5FFD;
        Wed, 19 Apr 2023 02:44:45 -0700 (PDT)
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-3f16f792384so7612175e9.0;
        Wed, 19 Apr 2023 02:44:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681897483; x=1684489483;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z0Ki+yrYya/1+WhprlDMDeSQUZpYWApjqzOUYsxVvk4=;
        b=G4n+9Dg5RXBRW+jlf8uO+vpe5IAcQmUjrd4WrLLyXCNhs9dsKPiFaSPQDqqyP0pz3/
         XyY8G4zMHfYO7FTl/8dhQJr71Si+uTJLFrcUeWaXP4gqlBdNH0Jqs9HLjTzQP9p/WUg+
         +k8tjEZLKjed05zKH6rqEkaHn7wWxua76yp8uZFlbvLbgqV3WIuH49s5kpm6qnAgPMo3
         1kdpwCIcwvco4joYkf+41H00AL6yO+A7ASEpBy5YPgNpQbpBhKYPEmr7yGsOGNzI5KGz
         mnKlqu+1vcII6AwC/Ce45aiT7P8gFPrjgiJ4D9qZQz8Yf7Py0eLmlQqlWNM+c0R+t1yc
         DK0w==
X-Gm-Message-State: AAQBX9fwgyKF9WKkvITD7QlCJCcdJ5MZO4Vyg5TDH+kZJ+GRCG2tQryy
        o1jHZWoo+YPxDH76v84FUmQ=
X-Google-Smtp-Source: AKy350YBFr1LPGuBZcbadSoufhTh3lhlQvF26xHbA9eNc8m85K2TgGYF3yYUiNAk4Eu9OfMg9V2rwQ==
X-Received: by 2002:a5d:6905:0:b0:2f9:59a3:eb30 with SMTP id t5-20020a5d6905000000b002f959a3eb30mr7502143wru.0.1681897483633;
        Wed, 19 Apr 2023 02:44:43 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id a12-20020a05600c224c00b003f1788eeffesm1581283wmm.43.2023.04.19.02.44.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Apr 2023 02:44:43 -0700 (PDT)
Message-ID: <3ec250a9-54c7-3e0d-2463-f8faf15cdb58@grimberg.me>
Date:   Wed, 19 Apr 2023 12:44:42 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH blktests v2 2/2] nvme-rc: Cleanup fc resource before
 module unloading
Content-Language: en-US
To:     Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Shin'ichiro Kawasaki <shinichiro@fastmail.com>
References: <20230419084757.24846-1-dwagner@suse.de>
 <20230419084757.24846-3-dwagner@suse.de>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230419084757.24846-3-dwagner@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> Before we unload the module we should cleanup the fc resources first,
> basically reorder the shutdown sequence to be in reverse order of the
> setup path.

If this triggers a bug, then I think it is a good idea to have a
dedicated test that reproduces it if we are changing the default
behavior.

> 
> Also unload the nvme-fcloop after usage.
> 
> While at it also update the rdma stop_soft_rdma before the module
> unloading for the same reasoning.

Why? it creates the wrong reverse ordering.

1. setup soft-rdma
2. setup nvme-rdma

2. teardown nvme-rdma
1. teardown soft-rdma

I don't think we need this change. I mean it is a good test
to have that the rdma device goes away underneath nvme-rdma
but it is good for a dedicated test.

> 
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>   tests/nvme/rc | 12 +++++++-----
>   1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/tests/nvme/rc b/tests/nvme/rc
> index ec0cc2d8d8cc..41f196b037d6 100644
> --- a/tests/nvme/rc
> +++ b/tests/nvme/rc
> @@ -260,18 +260,20 @@ _cleanup_nvmet() {
>   	shopt -u nullglob
>   	trap SIGINT
>   
> -	modprobe -rq nvme-"${nvme_trtype}" 2>/dev/null
> -	if [[ "${nvme_trtype}" != "loop" ]]; then
> -		modprobe -rq nvmet-"${nvme_trtype}" 2>/dev/null
> -	fi
> -	modprobe -rq nvmet 2>/dev/null
>   	if [[ "${nvme_trtype}" == "rdma" ]]; then
>   		stop_soft_rdma
>   	fi
>   	if [[ "${nvme_trtype}" == "fc" ]]; then
>   		_cleanup_fcloop "${def_local_wwnn}" "${def_local_wwpn}" \
>   			        "${def_remote_wwnn}" "${def_remote_wwpn}"
> +		modprobe -rq nvme-fcloop
>   	fi
> +
> +	modprobe -rq nvme-"${nvme_trtype}" 2>/dev/null
> +	if [[ "${nvme_trtype}" != "loop" ]]; then
> +		modprobe -rq nvmet-"${nvme_trtype}" 2>/dev/null
> +	fi
> +	modprobe -rq nvmet 2>/dev/null
>   }
>   
>   _setup_nvmet() {
