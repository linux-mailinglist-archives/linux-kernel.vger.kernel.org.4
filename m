Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE2485EF146
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 11:06:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235258AbiI2JGX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 05:06:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235070AbiI2JGP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 05:06:15 -0400
Received: from mailbox.box.xen0n.name (mail.xen0n.name [115.28.160.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18BC513FB51
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 02:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xen0n.name; s=mail;
        t=1664442370; bh=v4Nz7Jr2tjqnvU3MJV3TmU9VvLwxiiT/yn1JMflNNoE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=vDUaD3Qlhrphs8xVf5FCF/IqXZGpL+GpDr6S7H3lKKalrf5tM21mLXVd/st+LyyQV
         rTxfuusunkxeLVAzGxppsJaJ3t0cf7C24e+ojO1HmXf23TFV29x8nH5qb+HPFqsQSj
         +cxYTzHbaWne1dw56EBX8UuELRG30JryTU9GBi5c=
Received: from [192.168.9.172] (unknown [101.228.138.200])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mailbox.box.xen0n.name (Postfix) with ESMTPSA id 9A2FE60094;
        Thu, 29 Sep 2022 17:06:10 +0800 (CST)
Message-ID: <1776fe36-b954-b2c9-a2c1-157363f25ce2@xen0n.name>
Date:   Thu, 29 Sep 2022 17:06:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:107.0) Gecko/20100101
 Thunderbird/107.0a1
Subject: Re: [PATCH V3] LoongArch: Fix cpu name after s3/s4
To:     Jianmin Lv <lvjianmin@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>
Cc:     linux-kernel@vger.kernel.org, loongarch@lists.linux.dev
References: <20220929085530.8742-1-lvjianmin@loongson.cn>
Content-Language: en-US
From:   WANG Xuerui <kernel@xen0n.name>
In-Reply-To: <20220929085530.8742-1-lvjianmin@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/29/22 16:55, Jianmin Lv wrote:
> On coming back from s3/s4, the cpu name will be overwritten
> in cpu_probe path of seconary cpu, so we don't overwrite it
> if it has been initialized.

The sentences are confusing, first "the CPU name will be overwritten" 
then "don't overwrite it if initialized" -- seems the CPU name will get 
overwritten despite the patch's clear intent.

Better to keep it simple: "Don't overwrite the CPU name on coming back 
from S3/S4 if it is already initialized."

>
> Signed-off-by: Jianmin Lv <lvjianmin@loongson.cn>
>
> diff --git a/arch/loongarch/kernel/cpu-probe.c b/arch/loongarch/kernel/cpu-probe.c
> index 529ab8f44ec6..255a09876ef2 100644
> --- a/arch/loongarch/kernel/cpu-probe.c
> +++ b/arch/loongarch/kernel/cpu-probe.c
> @@ -187,7 +187,9 @@ static inline void cpu_probe_loongson(struct cpuinfo_loongarch *c, unsigned int
>   	uint64_t *vendor = (void *)(&cpu_full_name[VENDOR_OFFSET]);
>   	uint64_t *cpuname = (void *)(&cpu_full_name[CPUNAME_OFFSET]);
>   
> -	__cpu_full_name[cpu] = cpu_full_name;
> +	if (!__cpu_full_name[cpu])
> +		__cpu_full_name[cpu] = cpu_full_name;
> +
>   	*vendor = iocsr_read64(LOONGARCH_IOCSR_VENDOR);
>   	*cpuname = iocsr_read64(LOONGARCH_IOCSR_CPUNAME);
>   

Otherwise LGTM.

Reviewed-by: WANG Xuerui <git@xen0n.name>

-- 
WANG "xen0n" Xuerui

Linux/LoongArch mailing list: https://lore.kernel.org/loongarch/

