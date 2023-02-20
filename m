Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F45969CA30
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 12:49:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231896AbjBTLtM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 06:49:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231877AbjBTLtI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 06:49:08 -0500
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10D881A65E
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 03:49:03 -0800 (PST)
Received: by mail-ed1-f41.google.com with SMTP id da10so4803448edb.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 03:49:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BvCEsTm2ceYew1jDTl5DCI2eQ1K4Kl+LDZ7WMSZ1bCI=;
        b=lYDU8RNwAR0/RA7McwLKCmlhaDrtSa4rug0u/l2PZwzQeSQ9RO/l19wI5UKfX21LUb
         aAhNuMPAbS2JTe5vTGhYyTEFKPHl+DeNADD/FPyCiInU3sd3FpjPBCMK91X1n7HfoOkv
         ZreRCJEtEoboVT2uBFoKy2qTgjVyTAs88trLxStszB/NyDnZ3xgn5mbTHku8R4h+Ts8i
         7CQvHSkHv916dMjln/cYtQ9oe3r/o4LCVaLBVxrF6HwJX2myZYUhBbG4Mibaa1/4lJpx
         TqE4cousK3/c/OAoWlKKTUN5iFLZFE81uI48/wVhFx1bjXgpfWk44c2C5EXAjxP6UU1S
         w6bA==
X-Gm-Message-State: AO0yUKW9N+igZfvjslfAK3Ivt2dTRHsyxC6soFC+hFL2a9Y7wTUCqoL1
        PUj9Dxzoj7aTY9a9osFlYZ0=
X-Google-Smtp-Source: AK7set/hJz6ucFu3dJ3WMS3V/R7Rn5NX8MKjemRiQ7MhralJhnsZfT2GLCVUy3nCp9TY3fbsxnhgmA==
X-Received: by 2002:a05:6402:203b:b0:4ad:7b13:96a2 with SMTP id ay27-20020a056402203b00b004ad7b1396a2mr1479574edb.26.1676893741509;
        Mon, 20 Feb 2023 03:49:01 -0800 (PST)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:49? ([2a0b:e7c0:0:107::aaaa:49])
        by smtp.gmail.com with ESMTPSA id v11-20020a50c40b000000b004acaa4d51bdsm964635edf.32.2023.02.20.03.49.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Feb 2023 03:49:00 -0800 (PST)
Message-ID: <dcaaf7d5-b2d5-dbb9-f3fe-2232ee525cc8@kernel.org>
Date:   Mon, 20 Feb 2023 12:48:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] vc_screen: don't clobber return value in vcs_read
Content-Language: en-US
To:     linux@weissschuh.net, George Kennedy <george.kennedy@oracle.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        Storm Dragon <stormdragon2976@gmail.com>
References: <Y/KtG9vK0oz0nQrN@hotmail.com>
 <20230220064612.1783-1-linux@weissschuh.net>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20230220064612.1783-1-linux@weissschuh.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20. 02. 23, 7:46, linux@weissschuh.net wrote:
> From: Thomas Weißschuh <linux@weissschuh.net>
> 
> Commit 226fae124b2d
> ("vc_screen: move load of struct vc_data pointer in vcs_read() to avoid UAF")
> moved the call to vcs_vc() into the loop.
> While doing this it also moved the unconditional assignment of
> "ret = -ENXIO".
> This unconditional assignment was valid outside the loop but within it
> it clobbers the actual value of ret.
> 
> To avoid this only assign "ret = -ENXIO" when actually needed.

Not sure -- I cannot find it -- but hasn't George fixed this yet?

> Reported-by: Storm Dragon <stormdragon2976@gmail.com>
> Link: https://lore.kernel.org/lkml/Y%2FKS6vdql2pIsCiI@hotmail.com/
> Fixes: 226fae124b2d ("vc_screen: move load of struct vc_data pointer in vcs_read() to avoid UAF")
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> 
> ---
> 
> @Storm Could you validate this patch?
> ---
>   drivers/tty/vt/vc_screen.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/vt/vc_screen.c b/drivers/tty/vt/vc_screen.c
> index f566eb1839dc..2ef519a40a87 100644
> --- a/drivers/tty/vt/vc_screen.c
> +++ b/drivers/tty/vt/vc_screen.c
> @@ -403,10 +403,11 @@ vcs_read(struct file *file, char __user *buf, size_t count, loff_t *ppos)
>   		unsigned int this_round, skip = 0;
>   		int size;
>   
> -		ret = -ENXIO;
>   		vc = vcs_vc(inode, &viewed);
> -		if (!vc)
> +		if (!vc) {
> +			ret = -ENXIO;
>   			goto unlock_out;
> +		}
>   
>   		/* Check whether we are above size each round,
>   		 * as copy_to_user at the end of this loop
> 
> base-commit: c9c3395d5e3dcc6daee66c6908354d47bf98cb0c

-- 
js
suse labs

