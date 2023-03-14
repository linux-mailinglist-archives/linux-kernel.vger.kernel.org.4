Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C04A6B8F43
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 11:08:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbjCNKIr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 06:08:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbjCNKIo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 06:08:44 -0400
Received: from mailbox.box.xen0n.name (mail.xen0n.name [115.28.160.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5220F193FA
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 03:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xen0n.name; s=mail;
        t=1678788519; bh=UlF9o1yLWkxEdUooLn6xfypQXhMX54BMJYPtBqcg/ds=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=sL9bqKWIwOBO+lc4CA0PFOdcqZOHAuZpZ0A6k1+DKtveyKpByY5pT2NManaDFR1ZG
         zdEpQtaSVJH7YlbnnQa6PSct5Zj+m8qnG53NybmeU74nc+2DjtIkvomsPEbJa69Ylb
         OYC3VJ86V5zjdYqaAXHPPiGckWE+EckV8LKDFQuk=
Received: from [100.100.33.167] (unknown [220.248.53.61])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mailbox.box.xen0n.name (Postfix) with ESMTPSA id 124B3600DA;
        Tue, 14 Mar 2023 18:08:39 +0800 (CST)
Message-ID: <69caee37-e5b7-8eef-e2c2-410ffc5392a1@xen0n.name>
Date:   Tue, 14 Mar 2023 18:08:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [PATCH] LoongArch: Make WriteCombine configurable for ioremap()
Content-Language: en-US
To:     Huacai Chen <chenhuacai@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>
Cc:     loongarch@lists.linux.dev, Xuefeng Li <lixuefeng@loongson.cn>,
        Guo Ren <guoren@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-kernel@vger.kernel.org, loongson-kernel@lists.loongnix.cn
References: <20230314085433.4078119-1-chenhuacai@loongson.cn>
From:   WANG Xuerui <kernel@xen0n.name>
In-Reply-To: <20230314085433.4078119-1-chenhuacai@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/3/14 16:54, Huacai Chen wrote:
> LoongArch maintains cache coherency in hardware, but when works with

but when paired with current LS7A chipsets

> LS7A chipsets the WUC attribute (Weak-ordered UnCached, which is similar
> to WriteCombine) is out of the scope of cache coherency machanism for
> PCIe devices (this is a PCIe protocol violation, may be fixed in newer

which may be fixed

> chipsets).
> 
> This means WUC can only used for write-only memory regions now, so this
> option is disabled by default (means WUC falls back to SUC for ioremap).

by default, making ioremap_wc silently fallback to SUC.

> You can enable this option if the kernel is ensured to run on bug-free
> hardwares.

if you can ensure the kernel will always be running on hardware without 
this bug

> 
> Suggested-by: WANG Xuerui <kernel@xen0n.name>
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> ---
>   arch/loongarch/Kconfig          | 14 ++++++++++++++
>   arch/loongarch/include/asm/io.h |  5 +++++
>   2 files changed, 19 insertions(+)
> 
> diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
> index 0d11738a861a..e3f5c422636f 100644
> --- a/arch/loongarch/Kconfig
> +++ b/arch/loongarch/Kconfig
> @@ -446,6 +446,20 @@ config ARCH_IOREMAP
>   	  protection support. However, you can enable LoongArch DMW-based
>   	  ioremap() for better performance.
>   
> +config ARCH_WRITECOMBINE
> +	bool "Enable WriteCombine (WUC) for ioremap()"
> +	help
> +	  LoongArch maintains cache coherency in hardware, but with LS7A
> +	  chipsets the WUC attribute (Weak-ordered UnCached, which is similar
> +	  to WriteCombine) is out of the scope of cache coherency machanism
> +	  for PCIe devices (this is a PCIe protocol violation, may be fixed
> +	  in newer chipsets).
> +
> +	  This means WUC can only used for write-only memory regions now, so
> +	  this option is disabled by default (means WUC falls back to SUC for
> +	  ioremap). You can enable this option if the kernel is ensured to run
> +	  on bug-free hardwares.

Fix text here like with the commit message.

Then add a "If unsure, say N" line to serve as a warning?

> +
>   config ARCH_STRICT_ALIGN
>   	bool "Enable -mstrict-align to prevent unaligned accesses" if EXPERT
>   	default y
> diff --git a/arch/loongarch/include/asm/io.h b/arch/loongarch/include/asm/io.h
> index 402a7d9e3a53..079ef897ed1a 100644
> --- a/arch/loongarch/include/asm/io.h
> +++ b/arch/loongarch/include/asm/io.h
> @@ -54,8 +54,13 @@ static inline void __iomem *ioremap_prot(phys_addr_t offset, unsigned long size,
>    * @offset:    bus address of the memory
>    * @size:      size of the resource to map
>    */
> +#ifdef CONFIG_ARCH_WRITECOMBINE
>   #define ioremap_wc(offset, size)	\
>   	ioremap_prot((offset), (size), pgprot_val(PAGE_KERNEL_WUC))
> +#else
> +#define ioremap_wc(offset, size)	\
> +	ioremap_prot((offset), (size), pgprot_val(PAGE_KERNEL_SUC))
> +#endif
>   
>   #define ioremap_cache(offset, size)	\
>   	ioremap_prot((offset), (size), pgprot_val(PAGE_KERNEL))

I'll test this later tonight with my RX 6400. See you in a few hours...

-- 
WANG "xen0n" Xuerui

Linux/LoongArch mailing list: https://lore.kernel.org/loongarch/

