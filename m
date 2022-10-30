Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64FA86126FD
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Oct 2022 04:01:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbiJ3DBG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 23:01:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbiJ3DBC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 23:01:02 -0400
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29A5D3120C;
        Sat, 29 Oct 2022 20:01:01 -0700 (PDT)
Received: by mail-pj1-f47.google.com with SMTP id 3-20020a17090a0f8300b00212d5cd4e5eso13151483pjz.4;
        Sat, 29 Oct 2022 20:01:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L57Nna1Rv8qEqcyUYnO8glciVH+3HJrUIebXRiDcDRk=;
        b=4dMdEZdYUivL0mImkS43nFL7OTCPcw6PhGulvX+WZY7SHYI/VX0NODTrUO+RgZMbBr
         54qv0omEmMWBDNaTsLBUm4s0nr27Q87tIV3Dw2UChVGKqdGXxc7urYs/0lYsuFpTZXPI
         eTVG3CVGAnOafuMknuiTUBIjWZnJchNTk2BKcfEsxQoJUBUkgvg3o4H5nUxjeCSxXOKU
         175S33kq8MvObzvTEZOqliTN6YKVYrWfymH0OpXWKaTHiMgbeyqWItPwhVh5KqFJvzH3
         N2eGdemRXQ9ln14z05ca8TxefqysMBO/PJfR3+vdvnkGGEefSAclNhur0a3Cmh5EuIlk
         K2MQ==
X-Gm-Message-State: ACrzQf2BAK0oRZZGwKmjOpsYIayJKjObLO8u1cPq6YDyjs8v9gkZuykM
        k44yzvKbT9Q/eCEwF/xx1so=
X-Google-Smtp-Source: AMsMyM6KEs8BdLvR89JK6qwNIWFT/QJ5AO1dPiPjzuYo+c3mrxv3gKDAf46FxNDMulcSoL/BP6m0MA==
X-Received: by 2002:a17:903:124e:b0:179:da2f:244e with SMTP id u14-20020a170903124e00b00179da2f244emr7357905plh.169.1667098860592;
        Sat, 29 Oct 2022 20:01:00 -0700 (PDT)
Received: from [192.168.3.219] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id w15-20020a17090a028f00b001f94d25bfabsm1662704pja.28.2022.10.29.20.00.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 29 Oct 2022 20:00:59 -0700 (PDT)
Message-ID: <8ccaabc1-2834-dad6-7d46-19bfc2adcc9a@acm.org>
Date:   Sat, 29 Oct 2022 20:00:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v2] block: simplify blksize_bits() implementation
Content-Language: en-US
To:     Dawei Li <set_pte_at@outlook.com>, axboe@kernel.dk
Cc:     hch@lst.de, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <TYCP286MB232371C798BE0500E979E24CCA349@TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <TYCP286MB232371C798BE0500E979E24CCA349@TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM>
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

On 10/29/22 19:17, Dawei Li wrote:
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index 57ed49f20d2e..7b537afe8b38 100644
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
> +	return order_base_2((size + SECTOR_SIZE - 1) >> SECTOR_SHIFT) + SECTOR_SHIFT;
>   }

Why the rounding ("+ SECTOR_SIZE - 1")? The blksize_bits() argument 
should be an argument of two.

Thanks,

Bart.

