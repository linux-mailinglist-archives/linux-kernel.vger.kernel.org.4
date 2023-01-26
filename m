Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FFB167D534
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 20:15:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231630AbjAZTPl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 14:15:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbjAZTPi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 14:15:38 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EFB8D6185
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 11:15:36 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6F2BC4B3;
        Thu, 26 Jan 2023 11:16:18 -0800 (PST)
Received: from [10.57.89.209] (unknown [10.57.89.209])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 292133F64C;
        Thu, 26 Jan 2023 11:15:34 -0800 (PST)
Message-ID: <555fca66-81b6-3406-eac1-140c00669477@arm.com>
Date:   Thu, 26 Jan 2023 19:15:26 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [RFC] mm: Allow ZONE_DMA32 to be disabled via kernel command line
Content-Language: en-GB
To:     Georgi Djakov <quic_c_gdjako@quicinc.com>, catalin.marinas@arm.com,
        will@kernel.org
Cc:     dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        hch@lst.de, m.szyprowski@samsung.com,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, djakov@kernel.org
References: <20230126164352.17562-1-quic_c_gdjako@quicinc.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20230126164352.17562-1-quic_c_gdjako@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-01-26 16:43, Georgi Djakov wrote:
> From: Chris Goldsworthy <quic_cgoldswo@quicinc.com>
> 
> It's useful to have an option to disable the ZONE_DMA32 during boot as
> CONFIG_ZONE_DMA32 is by default enabled (on multiplatform kernels for
> example). There are platforms that do not use this zone and in some high
> memory pressure scenarios this would help on easing kswapd (to leave file
> backed memory intact / unreclaimed). When the ZONE_DMA32 is enabled on
> these platforms - kswapd is woken up more easily and drains the file cache
> which leads to some performance issues.
> 
> Signed-off-by: Chris Goldsworthy <quic_cgoldswo@quicinc.com>
> [georgi: updated commit text]
> Signed-off-by: Georgi Djakov <quic_c_gdjako@quicinc.com>
> ---
> The main question here is whether we can have a kernel command line
> option to disable CONFIG_ZONE_DMA32 during boot (at least on arm64).
> I can imagine this being useful also for Linux distros.

FWIW I'd say that "disabled" and "left empty then awkwardly tiptoed 
around in a few places" are very different notions...

However, I'm just going to take a step back and read the commit message 
a few more times... Given what it claims, I can't help but ask why 
wouldn't we want a parameter to control kswapd's behaviour and address 
that issue directly, rather than a massive hammer that breaks everyone 
allocating explicitly or implicitly with __GFP_DMA32 (especially on 
systems where it doesn't normally matter because all memory is below 4GB 
anyway), just to achieve one rather niche side-effect?

Thanks,
Robin.

>   .../admin-guide/kernel-parameters.txt         |  5 +++++
>   arch/arm64/mm/init.c                          | 20 ++++++++++++++++-
>   arch/x86/mm/init.c                            | 20 ++++++++++++++++-
>   include/linux/dma-direct.h                    | 22 +++++++++++++++++++
>   kernel/dma/direct.c                           |  5 +++--
>   kernel/dma/pool.c                             |  8 +++----
>   6 files changed, 72 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index cb12df402161..854ff65ac6b0 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -1070,6 +1070,11 @@
>   			Disable Dynamic DMA Window support. Use this
>   			to workaround buggy firmware.
>   
> +	disable_dma32=	[KNL]
> +			Dynamically disable ZONE_DMA32 on kernels compiled with
> +			CONFIG_ZONE_DMA32=y.
> +
> +
>   	disable_ipv6=	[IPV6]
>   			See Documentation/networking/ipv6.rst.
>   
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index 58a0bb2c17f1..1a56098c0e19 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -118,6 +118,12 @@ static int __init reserve_crashkernel_low(unsigned long long low_size)
>   	return 0;
>   }
>   
> +/*
> + * Provide a run-time mean of disabling ZONE_DMA32 if it is enabled via
> + * CONFIG_ZONE_DMA32.
> + */
> +static bool disable_dma32 __ro_after_init;
> +
>   /*
>    * reserve_crashkernel() - reserves memory for crash kernel
>    *
> @@ -244,7 +250,7 @@ static void __init zone_sizes_init(void)
>   	max_zone_pfns[ZONE_DMA] = PFN_DOWN(arm64_dma_phys_limit);
>   #endif
>   #ifdef CONFIG_ZONE_DMA32
> -	max_zone_pfns[ZONE_DMA32] = PFN_DOWN(dma32_phys_limit);
> +	max_zone_pfns[ZONE_DMA32] = disable_dma32 ? 0 : PFN_DOWN(dma32_phys_limit);
>   	if (!arm64_dma_phys_limit)
>   		arm64_dma_phys_limit = dma32_phys_limit;
>   #endif
> @@ -253,6 +259,18 @@ static void __init zone_sizes_init(void)
>   	free_area_init(max_zone_pfns);
>   }
>   
> +static int __init early_disable_dma32(char *buf)
> +{
> +	if (!buf)
> +		return -EINVAL;
> +
> +	if (!strcmp(buf, "on"))
> +		disable_dma32 = true;
> +
> +	return 0;
> +}
> +early_param("disable_dma32", early_disable_dma32);
> +
>   int pfn_is_map_memory(unsigned long pfn)
>   {
>   	phys_addr_t addr = PFN_PHYS(pfn);
> diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
> index cb258f58fdc8..b8af7e2f21f5 100644
> --- a/arch/x86/mm/init.c
> +++ b/arch/x86/mm/init.c
> @@ -112,6 +112,12 @@ static unsigned long min_pfn_mapped;
>   
>   static bool __initdata can_use_brk_pgt = true;
>   
> +/*
> + * Provide a run-time mean of disabling ZONE_DMA32 if it is enabled via
> + * CONFIG_ZONE_DMA32.
> + */
> +static bool disable_dma32 __ro_after_init;
> +
>   /*
>    * Pages returned are already directly mapped.
>    *
> @@ -1032,7 +1038,7 @@ void __init zone_sizes_init(void)
>   	max_zone_pfns[ZONE_DMA]		= min(MAX_DMA_PFN, max_low_pfn);
>   #endif
>   #ifdef CONFIG_ZONE_DMA32
> -	max_zone_pfns[ZONE_DMA32]	= min(MAX_DMA32_PFN, max_low_pfn);
> +	max_zone_pfns[ZONE_DMA32]	= disable_dma32 ? 0 : min(MAX_DMA32_PFN, max_low_pfn);
>   #endif
>   	max_zone_pfns[ZONE_NORMAL]	= max_low_pfn;
>   #ifdef CONFIG_HIGHMEM
> @@ -1042,6 +1048,18 @@ void __init zone_sizes_init(void)
>   	free_area_init(max_zone_pfns);
>   }
>   
> +static int __init early_disable_dma32(char *buf)
> +{
> +	if (!buf)
> +		return -EINVAL;
> +
> +	if (!strcmp(buf, "on"))
> +		disable_dma32 = true;
> +
> +	return 0;
> +}
> +early_param("disable_dma32", early_disable_dma32);
> +
>   __visible DEFINE_PER_CPU_ALIGNED(struct tlb_state, cpu_tlbstate) = {
>   	.loaded_mm = &init_mm,
>   	.next_asid = 1,
> diff --git a/include/linux/dma-direct.h b/include/linux/dma-direct.h
> index 18aade195884..ed69618cf1fc 100644
> --- a/include/linux/dma-direct.h
> +++ b/include/linux/dma-direct.h
> @@ -24,6 +24,28 @@ struct bus_dma_region {
>   	u64		offset;
>   };
>   
> +static inline bool zone_dma32_is_empty(int node)
> +{
> +#ifdef CONFIG_ZONE_DMA32
> +	pg_data_t *pgdat = NODE_DATA(node);
> +
> +	return zone_is_empty(&pgdat->node_zones[ZONE_DMA32]);
> +#else
> +	return true;
> +#endif
> +}
> +
> +static inline bool zone_dma32_are_empty(void)
> +{
> +	int node;
> +
> +	for_each_node(node)
> +		if (!zone_dma32_is_empty(node))
> +			return false;
> +
> +	return true;
> +}
> +
>   static inline dma_addr_t translate_phys_to_dma(struct device *dev,
>   		phys_addr_t paddr)
>   {
> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> index 63859a101ed8..754210c65658 100644
> --- a/kernel/dma/direct.c
> +++ b/kernel/dma/direct.c
> @@ -60,7 +60,7 @@ static gfp_t dma_direct_optimal_gfp_mask(struct device *dev, u64 dma_mask,
>   	*phys_limit = dma_to_phys(dev, dma_limit);
>   	if (*phys_limit <= DMA_BIT_MASK(zone_dma_bits))
>   		return GFP_DMA;
> -	if (*phys_limit <= DMA_BIT_MASK(32))
> +	if (*phys_limit <= DMA_BIT_MASK(32) && !zone_dma32_is_empty(dev_to_node(dev)))
>   		return GFP_DMA32;
>   	return 0;
>   }
> @@ -145,7 +145,8 @@ static struct page *__dma_direct_alloc_pages(struct device *dev, size_t size,
>   
>   		if (IS_ENABLED(CONFIG_ZONE_DMA32) &&
>   		    phys_limit < DMA_BIT_MASK(64) &&
> -		    !(gfp & (GFP_DMA32 | GFP_DMA))) {
> +		    !(gfp & (GFP_DMA32 | GFP_DMA)) &&
> +		    !zone_dma32_is_empty(node)) {
>   			gfp |= GFP_DMA32;
>   			goto again;
>   		}
> diff --git a/kernel/dma/pool.c b/kernel/dma/pool.c
> index 4d40dcce7604..8e79903fbda8 100644
> --- a/kernel/dma/pool.c
> +++ b/kernel/dma/pool.c
> @@ -71,7 +71,7 @@ static bool cma_in_zone(gfp_t gfp)
>   	end = cma_get_base(cma) + size - 1;
>   	if (IS_ENABLED(CONFIG_ZONE_DMA) && (gfp & GFP_DMA))
>   		return end <= DMA_BIT_MASK(zone_dma_bits);
> -	if (IS_ENABLED(CONFIG_ZONE_DMA32) && (gfp & GFP_DMA32))
> +	if (IS_ENABLED(CONFIG_ZONE_DMA32) && (gfp & GFP_DMA32) && !zone_dma32_are_empty())
>   		return end <= DMA_BIT_MASK(32);
>   	return true;
>   }
> @@ -153,7 +153,7 @@ static void atomic_pool_work_fn(struct work_struct *work)
>   	if (IS_ENABLED(CONFIG_ZONE_DMA))
>   		atomic_pool_resize(atomic_pool_dma,
>   				   GFP_KERNEL | GFP_DMA);
> -	if (IS_ENABLED(CONFIG_ZONE_DMA32))
> +	if (IS_ENABLED(CONFIG_ZONE_DMA32) && !zone_dma32_are_empty())
>   		atomic_pool_resize(atomic_pool_dma32,
>   				   GFP_KERNEL | GFP_DMA32);
>   	atomic_pool_resize(atomic_pool_kernel, GFP_KERNEL);
> @@ -209,7 +209,7 @@ static int __init dma_atomic_pool_init(void)
>   		if (!atomic_pool_dma)
>   			ret = -ENOMEM;
>   	}
> -	if (IS_ENABLED(CONFIG_ZONE_DMA32)) {
> +	if (IS_ENABLED(CONFIG_ZONE_DMA32) && !zone_dma32_are_empty()) {
>   		atomic_pool_dma32 = __dma_atomic_pool_init(atomic_pool_size,
>   						GFP_KERNEL | GFP_DMA32);
>   		if (!atomic_pool_dma32)
> @@ -224,7 +224,7 @@ postcore_initcall(dma_atomic_pool_init);
>   static inline struct gen_pool *dma_guess_pool(struct gen_pool *prev, gfp_t gfp)
>   {
>   	if (prev == NULL) {
> -		if (IS_ENABLED(CONFIG_ZONE_DMA32) && (gfp & GFP_DMA32))
> +		if (IS_ENABLED(CONFIG_ZONE_DMA32) && (gfp & GFP_DMA32) && !zone_dma32_are_empty())
>   			return atomic_pool_dma32;
>   		if (atomic_pool_dma && (gfp & GFP_DMA))
>   			return atomic_pool_dma;
