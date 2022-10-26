Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7BFC60DBFB
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 09:18:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232807AbiJZHSV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 03:18:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231751AbiJZHSR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 03:18:17 -0400
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1A8DBD059;
        Wed, 26 Oct 2022 00:18:16 -0700 (PDT)
Received: by mail-ej1-f48.google.com with SMTP id n12so13512420eja.11;
        Wed, 26 Oct 2022 00:18:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jgrCSgoyKQAcf7Cn8RHYWJzwfMDTCeEL4acz0yVvwcc=;
        b=kWEfo76nU65gaK4Vio7Gf89NJSOvl6f683/pOlM6otWjqfMyEa/3uhWau9vZDZE37U
         C9Mjm7AeAE5UPt7kfSfNUswN2SS1xrCvWBHJJ6mInVmfsE+PaeG0kFTG3aSgDhoWlimX
         VLOAs8pQkINxhGiCB7uibfbCjFlg9MV0zR+Uy+NkSc7DnBHhBeo9ijpr679n9YqsaRAi
         CYrAaIzjsmJhzxvjjjFtWtDaJp9vjy2wignN3YqwsIW86TvTzeASAVaadjd8pMB1/MlD
         SckYwLZ40A3A/m4EvYm3fjSdkhaUOiK1t21pfv4QQIikKWDPSDwuPnzr0Aiq167AyRvU
         Z4aA==
X-Gm-Message-State: ACrzQf0KEo9K/eaaWZw84iW3BO8xgi8FTz9uP6XUAUdQB2Rwl7mmzx7W
        F+x8LVCHINPKf4K1nF/WQwpf0GPGIYTHIg==
X-Google-Smtp-Source: AMsMyM47akiGq5DuCuDFHk2dVM5tb9IybhfihjyBOoI/UghMYjV/ct5kTcFCxew+mCnBf5iYuisMyg==
X-Received: by 2002:a17:907:1dec:b0:7aa:6262:f23f with SMTP id og44-20020a1709071dec00b007aa6262f23fmr10680718ejc.38.1666768695290;
        Wed, 26 Oct 2022 00:18:15 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id c1-20020a170906d18100b0072af4af2f46sm2528312ejz.74.2022.10.26.00.18.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Oct 2022 00:18:14 -0700 (PDT)
Message-ID: <bc107c62-25ab-f959-c5bc-d5bacc511f20@kernel.org>
Date:   Wed, 26 Oct 2022 09:18:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH] block: fix Werror=format with GCC 13
Content-Language: en-US
To:     =?UTF-8?Q?Martin_Li=c5=a1ka?= <mliska@suse.cz>,
        linux-kernel@vger.kernel.org
Cc:     linux-block@vger.kernel.org, axboe@kernel.dk
References: <f70c7a11-e81e-f6b9-a403-315117f4aa3a@suse.cz>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <f70c7a11-e81e-f6b9-a403-315117f4aa3a@suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24. 10. 22, 21:01, Martin Liška wrote:
> Starting with GCC 13, since
> [g3b3083a598ca3f4b] c: C2x enums wider than int [PR36113]
> 
> GCC promotes enum values with larger than integer types to a wider type.
> In case of the anonymous enum type in blk-iocost.c it is:
> 
> enum {
> 	MILLION			= 1000000,
> ...
> 
> 	WEIGHT_ONE		= 1 << 16,
> ...
> 	VTIME_PER_SEC_SHIFT	= 37,
> 	VTIME_PER_SEC		= 1LLU << VTIME_PER_SEC_SHIFT,
> ...
> 
> as seen VTIME_PER_SEC cannot fit into 32-bits (int type), thus one needs
> to use 'long unsigned int' in the format string.
> 
> It fixes then the following 2 warnings:
> 
> block/blk-iocost.c: In function ‘ioc_weight_prfill’:
> block/blk-iocost.c:3035:37: error: format ‘%u’ expects argument of type ‘unsigned int’, but argument 4 has type ‘long unsigned int’ [-Werror=format=]
>   3035 |                 seq_printf(sf, "%s %u\n", dname, iocg->cfg_weight / WEIGHT_ONE);
>        |                                    ~^            ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>        |                                     |                             |
>        |                                     unsigned int                  long unsigned int
>        |                                    %lu
> block/blk-iocost.c: In function ‘ioc_weight_show’:
> block/blk-iocost.c:3045:34: error: format ‘%u’ expects argument of type ‘unsigned int’, but argument 3 has type ‘long unsigned int’ [-Werror=format=]
>   3045 |         seq_printf(sf, "default %u\n", iocc->dfl_weight / WEIGHT_ONE);
>        |                                 ~^     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>        |                                  |                      |
>        |                                  unsigned int           long unsigned int
>        |                                 %lu

But introduces two with gcc-12 ;):
 > block/blk-iocost.c: In function ‘ioc_weight_prfill’:
 > block/blk-iocost.c:3037:38: error: format ‘%lu’ expects argument of 
type ‘long unsigned int’, but argument 4 has type ‘u32’ {aka ‘unsigned 
int’} [-Werror=format=]
 >  3037 |                 seq_printf(sf, "%s %lu\n", dname, 
iocg->cfg_weight / WEIGHT_ONE);
 >       |                                    ~~^ 
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 >       |                                      | 
      |
 >       |                                      long unsigned int 
      u32 {aka unsigned int}
 >       |                                    %u


Note that:
1) the specs says enum behaves as int, or uint in some cases
2) iocc->dfl_weight is u32, i.e. uint
    WEIGHT_ONE is 1 << 16, i.e. int
    so the promotion should be to s32/int. Or not?

I think gcc-13 is wrong -- incosistent with gcc-12 at least.

> Signed-off-by: Martin Liska <mliska@suse.cz>
> ---
>   block/blk-iocost.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/block/blk-iocost.c b/block/blk-iocost.c
> index 495396425bad..f165bac9bffb 100644
> --- a/block/blk-iocost.c
> +++ b/block/blk-iocost.c
> @@ -3032,7 +3032,7 @@ static u64 ioc_weight_prfill(struct seq_file *sf, struct blkg_policy_data *pd,
>   	struct ioc_gq *iocg = pd_to_iocg(pd);
>   
>   	if (dname && iocg->cfg_weight)
> -		seq_printf(sf, "%s %u\n", dname, iocg->cfg_weight / WEIGHT_ONE);
> +		seq_printf(sf, "%s %lu\n", dname, iocg->cfg_weight / WEIGHT_ONE);
>   	return 0;
>   }
>   
> @@ -3042,7 +3042,7 @@ static int ioc_weight_show(struct seq_file *sf, void *v)
>   	struct blkcg *blkcg = css_to_blkcg(seq_css(sf));
>   	struct ioc_cgrp *iocc = blkcg_to_iocc(blkcg);
>   
> -	seq_printf(sf, "default %u\n", iocc->dfl_weight / WEIGHT_ONE);
> +	seq_printf(sf, "default %lu\n", iocc->dfl_weight / WEIGHT_ONE);
>   	blkcg_print_blkgs(sf, blkcg, ioc_weight_prfill,
>   			  &blkcg_policy_iocost, seq_cft(sf)->private, false);
>   	return 0;

thanks,
-- 
js
suse labs

