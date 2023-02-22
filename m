Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25EE469FA18
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 18:25:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231722AbjBVRZT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 12:25:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbjBVRZR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 12:25:17 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9FC6D410B1;
        Wed, 22 Feb 2023 09:24:47 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 996D41063;
        Wed, 22 Feb 2023 09:25:28 -0800 (PST)
Received: from [10.57.16.42] (unknown [10.57.16.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CE2E83F881;
        Wed, 22 Feb 2023 09:24:43 -0800 (PST)
Message-ID: <e9d882f4-d57d-f6b4-7ae0-bbfea0f5aa59@arm.com>
Date:   Wed, 22 Feb 2023 17:24:36 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH 3/3] of: address: Use dma_default_coherent to determine
 default coherency
Content-Language: en-GB
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>, linux-mips@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        tsbogend@alpha.franken.de, mpe@ellerman.id.au,
        paul.walmsley@sifive.com, palmer@dabbelt.com, robh+dt@kernel.org,
        hch@lst.de, m.szyprowski@samsung.com,
        linux-riscv@lists.infradead.org
References: <20230222133712.8079-1-jiaxun.yang@flygoat.com>
 <20230222133712.8079-4-jiaxun.yang@flygoat.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20230222133712.8079-4-jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-02-22 13:37, Jiaxun Yang wrote:
> As for now all arches have dma_default_coherent matched with default
> DMA coherency for of devices, so there is no need to have a standalone
> config option.
> 
> This also fixes a case that for some MIPS platforms, coherency information
> is not carried in devicetree and kernel will override dma_default_coherent
> at early boot.
> 
> Note for PowerPC: CONFIG_OF_DMA_DEFUALT_COHERENT was only selected when
> CONFIG_NOT_COHERENT_CACHE is false, in this case dma_default_coherent will
> be true, so it still matches present behavior.
> 
> Note for RISC-V: dma_default_coherent is set to true at init code in this
> series.

OK, so the fundamental problem here is that we have two slightly 
different conflicting mechanisms, the ex-PowerPC config option, and the 
ex-MIPS dma_default_coherent for which of_dma_is_coherent() has 
apparently been broken forever.

I'd agree that it's worth consolidating the two, but please separate out 
the fix as below, so it's feasible to backport without having to muck 
about in arch code.

> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
>   arch/powerpc/Kconfig | 1 -
>   arch/riscv/Kconfig   | 1 -
>   drivers/of/Kconfig   | 4 ----
>   drivers/of/address.c | 2 +-
>   4 files changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index 2c9cdf1d8761..c67e5da714f7 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -272,7 +272,6 @@ config PPC
>   	select NEED_PER_CPU_PAGE_FIRST_CHUNK	if PPC64
>   	select NEED_SG_DMA_LENGTH
>   	select OF
> -	select OF_DMA_DEFAULT_COHERENT		if !NOT_COHERENT_CACHE
>   	select OF_EARLY_FLATTREE
>   	select OLD_SIGACTION			if PPC32
>   	select OLD_SIGSUSPEND
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 1d46a268ce16..406c6816d289 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -119,7 +119,6 @@ config RISCV
>   	select MODULES_USE_ELF_RELA if MODULES
>   	select MODULE_SECTIONS if MODULES
>   	select OF
> -	select OF_DMA_DEFAULT_COHERENT
>   	select OF_EARLY_FLATTREE
>   	select OF_IRQ
>   	select PCI_DOMAINS_GENERIC if PCI
> diff --git a/drivers/of/Kconfig b/drivers/of/Kconfig
> index 644386833a7b..e40f10bf2ba4 100644
> --- a/drivers/of/Kconfig
> +++ b/drivers/of/Kconfig
> @@ -102,8 +102,4 @@ config OF_OVERLAY
>   config OF_NUMA
>   	bool
>   
> -config OF_DMA_DEFAULT_COHERENT
> -	# arches should select this if DMA is coherent by default for OF devices
> -	bool
> -
>   endif # OF
> diff --git a/drivers/of/address.c b/drivers/of/address.c
> index 4c0b169ef9bf..23ade4919853 100644
> --- a/drivers/of/address.c
> +++ b/drivers/of/address.c
> @@ -1103,7 +1103,7 @@ phys_addr_t __init of_dma_get_max_cpu_address(struct device_node *np)
>   bool of_dma_is_coherent(struct device_node *np)
>   {
>   	struct device_node *node;
> -	bool is_coherent = IS_ENABLED(CONFIG_OF_DMA_DEFAULT_COHERENT);
> +	bool is_coherent = dma_default_coherent;

AFAICS, all you should actually need is a single self-contained addition 
here, something like:

+	/*
+	 * DT-based MIPS doesn't use OF_DMA_DEFAULT_COHERENT, but
+	 * might override the system-wide default at runtime.
+	 */
+#if defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_DEVICE) || \
+	defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU) || \
+	defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU_ALL)
+	is_coherent = dma_default_coherent;
+#endif

>   
>   	node = of_node_get(np);
>   

Then *after* that's fixed, we can do a more comprehensive refactoring to 
merge the two mechanisms properly. FWIW I think I'd prefer an approach 
closer to the first one, where config options control the initial value 
of dma_default_coherent rather than architectures having to override it 
unconditionally (and TBH I'd also like to have a generic config symbol 
for whether an arch supports per-device coherency or not).

Thanks,
Robin.
