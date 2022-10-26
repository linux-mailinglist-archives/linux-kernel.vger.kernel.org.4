Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25E1360E572
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 18:29:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233406AbiJZQ3e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 12:29:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231681AbiJZQ33 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 12:29:29 -0400
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 310C8B82;
        Wed, 26 Oct 2022 09:29:25 -0700 (PDT)
Received: by mail-pl1-f177.google.com with SMTP id j12so14633571plj.5;
        Wed, 26 Oct 2022 09:29:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iuF9INKJr1wDQrykXWEEecn7e+vfn86O2X3BqBHpzhI=;
        b=mRz2y7lC5sS/dprVmWHdXVjoq/Au/s1dVzawB4smEZhaDVd1IDi9rNH6vzhlSfqFvH
         c2ADhqoVV0s/uLmsyzYwDxwgDVhVc70WotkYeNI1w3O15ocL1P2rrJ82hXttwX93PCnV
         ZaG+nmk9HuxFTjwTRmoBzeR1V9tTwjf+ItKT3vHDUtjN3ymH2n+InDi3O12uLbII4DJb
         w5iAjG9cMZ5fP1WyYzCe6Hb/WeBp3KL/ffCW6M4HcDfxQvqM5ahhQu79v563DJGq8NDj
         nc6j5pO19/iXqtijLxbKQbExZpaG+Yz3uSg0xVcXz41clEjixLc1NocfNDGNZ+pFHIM/
         gt0Q==
X-Gm-Message-State: ACrzQf1hR54grn+/+6t+vX3YDuiLcNPFsb2Vxohano17IjNoLauTTDOO
        zhLF1DDQHFI4OOojng/UBbo=
X-Google-Smtp-Source: AMsMyM6rE6ykzxp3LR8lIe03IcZV2ilJqJ5CV8kOpdQjJWk1iqplm1AhrfC+D/JzEAWClq0swELpWg==
X-Received: by 2002:a17:902:e944:b0:179:dee4:f115 with SMTP id b4-20020a170902e94400b00179dee4f115mr46199532pll.141.1666801764386;
        Wed, 26 Oct 2022 09:29:24 -0700 (PDT)
Received: from ?IPV6:2601:642:4c02:32f2:10:c576:6431:785e? ([2601:642:4c02:32f2:10:c576:6431:785e])
        by smtp.gmail.com with ESMTPSA id ne16-20020a17090b375000b00210c84b8ae5sm1301067pjb.35.2022.10.26.09.29.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Oct 2022 09:29:23 -0700 (PDT)
Message-ID: <30ea2fa3-0e4d-788b-b990-3bdb9e687377@acm.org>
Date:   Wed, 26 Oct 2022 09:29:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH] block: simplify blksize_bits() implementation
Content-Language: en-US
To:     Dawei Li <set_pte_at@outlook.com>, axboe@kernel.dk
Cc:     hch@lst.de, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <TYCP286MB2323169D81A806A7C1F7FDF1CA309@TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <TYCP286MB2323169D81A806A7C1F7FDF1CA309@TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/26/22 08:14, Dawei Li wrote:
> Convert current looping-based implementation into bit operation,
> which can bring improvement for:
> 
> 1) bitops is more efficient for its arch-level optimization.

As far as I know blksize_bits() is not used in the hot path so 
performance of this function is not critical.

> 2) Given that blksize_bits() is inline, _if_ @size is compile-time
> constant, it's possible that order_base_2() _may_ make output
> compile-time evaluated, depending on code context and compiler behavior.
> 
> Signed-off-by: Dawei Li <set_pte_at@outlook.com>
> ---
>   include/linux/blkdev.h | 7 +------
>   1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index 50e358a19d98..117061c8b9a1 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -1349,12 +1349,7 @@ static inline int blk_rq_aligned(struct request_queue *q, unsigned long addr,
>   /* assumes size > 256 */
>   static inline unsigned int blksize_bits(unsigned int size)
>   {
> -	unsigned int bits = 8;
> -	do {
> -		bits++;
> -		size >>= 1;
> -	} while (size > 256);
> -	return bits;
> +	return size > 512 ? order_base_2(size) : 9;
>   }

How about optimizing this function even further by eliminating the 
ternary operator, e.g. as follows (untested)?

         return order_base_2(size >> SECTOR_SHIFT) + SECTOR_SHIFT;

Thanks,

Bart.

