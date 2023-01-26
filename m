Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A14B67D8EA
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 23:57:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233024AbjAZW5E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 17:57:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbjAZW5C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 17:57:02 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84DA52942C
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 14:57:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 027C9B81F3D
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 22:56:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEB52C433D2;
        Thu, 26 Jan 2023 22:56:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674773817;
        bh=zCe67ocfpC6zy4xRPoMccT9H8OiRW/uumpEJQMrr5C8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=he5YX+Sv4QL4bkhj5YNRvhhPaIkGF0yiCr3GD+z56IfcIRtT/O3yBqlBE1x5cqznU
         uGWqd43u/yYVzKLFofT3QSF0MjAFQfVTu7yVe5jKuuUvJ104dXaE/kcpEIBQmLacfg
         HDxNM5sucrKo0R3M08gREJVXeeozs3wUo6DAajfWGdm2juj/ASYNrQ9NzCxJYKk7A3
         q9TaRJumrggHOoco6LwKIhvLLF/Qt2MClHxcadov/cLfMU62nZJ2hj5TgD9E/hEY8z
         bLszD83bG4s3C29yYkIYZgNXIVGMn4VSUVK1VD/KFSOCvO9rh+bobO0222Ph1R/TV0
         X77zu5h7Uu9RA==
Message-ID: <4c00ee1b-c2d6-b543-9135-9116912255c7@kernel.org>
Date:   Fri, 27 Jan 2023 00:56:50 +0200
MIME-Version: 1.0
Subject: Re: [RFC] mm: Allow ZONE_DMA32 to be disabled via kernel command line
To:     Dave Hansen <dave.hansen@intel.com>,
        Georgi Djakov <quic_c_gdjako@quicinc.com>,
        catalin.marinas@arm.com, will@kernel.org
Cc:     dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        hch@lst.de, m.szyprowski@samsung.com, robin.murphy@arm.com,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, quic_cgoldswo@quicinc.com,
        quic_sukadev@quicinc.com
References: <20230126164352.17562-1-quic_c_gdjako@quicinc.com>
 <dca84e05-e376-c593-74fa-37c58f30767a@intel.com>
Content-Language: en-US
From:   Georgi Djakov <djakov@kernel.org>
In-Reply-To: <dca84e05-e376-c593-74fa-37c58f30767a@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,

Thanks for the detailed review and comments!

On 26.01.23 20:51, Dave Hansen wrote:
> On 1/26/23 08:43, Georgi Djakov wrote:
>> From: Chris Goldsworthy <quic_cgoldswo@quicinc.com>
>>
>> It's useful to have an option to disable the ZONE_DMA32 during boot as
>> CONFIG_ZONE_DMA32 is by default enabled (on multiplatform kernels for
>> example). There are platforms that do not use this zone and in some high
>> memory pressure scenarios this would help on easing kswapd (to leave file
>> backed memory intact / unreclaimed). When the ZONE_DMA32 is enabled on
>> these platforms - kswapd is woken up more easily and drains the file cache
>> which leads to some performance issues.
> 
> Any chance you could expound on "some performance issues", maybe with
> actual workloads and numbers?

The goal is to prevent any reclaim at all or defer it as much as possible.
I can gather some numbers, but let me explain the scenario first. Let's say
you have 100 processes and you put some to sleep. After some time kswapd
reclaims file cached memory. You wake one of these processes back and some
lagging is observed because files have to be re-opened, as they were reclaimed
from the file cache.

> 
> Also, what are the practical implications here?  There are obviously an
> ever decreasing number of 32-bit DMA devices out there.  Somebody that
> has one and uses this option might be sad because now they're stuck
> using ZONE_DMA which is quite tiny.

True. There are side effects indeed.

I think that Robin's suggestion to try to control kswapd's behavior is
really something worth exploring!

Thanks,
Georgi

> What other ZONE_DMA32 users are left?  Will anyone else care?  There is
> some DMA32 slab and vmalloc() functionality remaining.  Is it impacted?
> 
> What should the default be?  If disable_dma32=0 by default, this seems
> like code that will never get tested.  There are some rather subtle
> relationships between ZONE_DMA32 and other zones that could get missed
> without sufficient testing, like...
> 
> alloc_flags_nofragment() has some rather relevant comments that are left
> unaddressed:
> 
>>          /*
>>           * If ZONE_DMA32 exists, assume it is the one after ZONE_NORMAL and
>>           * the pointer is within zone->zone_pgdat->node_zones[]. Also assume
>>           * on UMA that if Normal is populated then so is DMA32.
>>           */
> 
> This patch appears to break the "on UMA" assumption.
> 
> 
>> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
>> index 58a0bb2c17f1..1a56098c0e19 100644
>> --- a/arch/arm64/mm/init.c
>> +++ b/arch/arm64/mm/init.c
>> @@ -118,6 +118,12 @@ static int __init reserve_crashkernel_low(unsigned long long low_size)
>>   	return 0;
>>   }
>>   
>> +/*
>> + * Provide a run-time mean of disabling ZONE_DMA32 if it is enabled via
>> + * CONFIG_ZONE_DMA32.
>> + */
>> +static bool disable_dma32 __ro_after_init;
> 
> Is this referenced in any hot paths?  It might deserve a static branch.
> 
>> diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
>> index cb258f58fdc8..b8af7e2f21f5 100644
>> --- a/arch/x86/mm/init.c
>> +++ b/arch/x86/mm/init.c
>> @@ -112,6 +112,12 @@ static unsigned long min_pfn_mapped;
>>   
>>   static bool __initdata can_use_brk_pgt = true;
>>   
>> +/*
>> + * Provide a run-time mean of disabling ZONE_DMA32 if it is enabled via
>> + * CONFIG_ZONE_DMA32.
>> + */
>> +static bool disable_dma32 __ro_after_init;
>> +
>>   /*
>>    * Pages returned are already directly mapped.
>>    *
>> @@ -1032,7 +1038,7 @@ void __init zone_sizes_init(void)
>>   	max_zone_pfns[ZONE_DMA]		= min(MAX_DMA_PFN, max_low_pfn);
>>   #endif
>>   #ifdef CONFIG_ZONE_DMA32
>> -	max_zone_pfns[ZONE_DMA32]	= min(MAX_DMA32_PFN, max_low_pfn);
>> +	max_zone_pfns[ZONE_DMA32]	= disable_dma32 ? 0 : min(MAX_DMA32_PFN, max_low_pfn);
>>   #endif
>>   	max_zone_pfns[ZONE_NORMAL]	= max_low_pfn;
>>   #ifdef CONFIG_HIGHMEM
>> @@ -1042,6 +1048,18 @@ void __init zone_sizes_init(void)
>>   	free_area_init(max_zone_pfns);
>>   }
>>   
>> +static int __init early_disable_dma32(char *buf)
>> +{
>> +	if (!buf)
>> +		return -EINVAL;
>> +
>> +	if (!strcmp(buf, "on"))
>> +		disable_dma32 = true;
>> +
>> +	return 0;
>> +}
>> +early_param("disable_dma32", early_disable_dma32);
> 
> Ick.  Is there no way to do this other than a cross-arch copy/paste?
> 
>> diff --git a/include/linux/dma-direct.h b/include/linux/dma-direct.h
>> index 18aade195884..ed69618cf1fc 100644
>> --- a/include/linux/dma-direct.h
>> +++ b/include/linux/dma-direct.h
>> @@ -24,6 +24,28 @@ struct bus_dma_region {
>>   	u64		offset;
>>   };
>>   
>> +static inline bool zone_dma32_is_empty(int node)
>> +{
>> +#ifdef CONFIG_ZONE_DMA32
>> +	pg_data_t *pgdat = NODE_DATA(node);
>> +
>> +	return zone_is_empty(&pgdat->node_zones[ZONE_DMA32]);
>> +#else
>> +	return true;
>> +#endif
>> +}
>> +
>> +static inline bool zone_dma32_are_empty(void)
>> +{
>> +	int node;
>> +
>> +	for_each_node(node)
>> +		if (!zone_dma32_is_empty(node))
>> +			return false;
>> +
>> +	return true;
>> +}
> 
> That for_each_node() loop can be 1024 nodes long.  I hope this isn't in
> any hot paths.  It'll be fine on DMA32 systems because it'll fall out of
> the loop on the first pass.  But, if someone uses your shiny new option,
> they're in for a long loop.
> 
> Oh, and this is:
> 
> #define for_each_node(node)        for_each_node_state(node, N_POSSIBLE)
> 
> Did you really want all *possible* nodes?  Or will
> for_each_online_node() do?
> 
> Also, I'd be rather shocked if there wasn't one-stop-shopping for this
> somewhere.  Consulting your new 'disable_dma32' variable would make this
> function rather cheap.  I suspect a totally empty set of DMA32 will also
> leave its mark in arch_zone_*_possible_pfn[].
> 
>>   static inline dma_addr_t translate_phys_to_dma(struct device *dev,
>>   		phys_addr_t paddr)
>>   {
>> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
>> index 63859a101ed8..754210c65658 100644
>> --- a/kernel/dma/direct.c
>> +++ b/kernel/dma/direct.c
>> @@ -60,7 +60,7 @@ static gfp_t dma_direct_optimal_gfp_mask(struct device *dev, u64 dma_mask,
>>   	*phys_limit = dma_to_phys(dev, dma_limit);
>>   	if (*phys_limit <= DMA_BIT_MASK(zone_dma_bits))
>>   		return GFP_DMA;
>> -	if (*phys_limit <= DMA_BIT_MASK(32))
>> +	if (*phys_limit <= DMA_BIT_MASK(32) && !zone_dma32_is_empty(dev_to_node(dev)))
>>   		return GFP_DMA32;
>>   	return 0;
>>   }
>> @@ -145,7 +145,8 @@ static struct page *__dma_direct_alloc_pages(struct device *dev, size_t size,
>>   
>>   		if (IS_ENABLED(CONFIG_ZONE_DMA32) &&
>>   		    phys_limit < DMA_BIT_MASK(64) &&
>> -		    !(gfp & (GFP_DMA32 | GFP_DMA))) {
>> +		    !(gfp & (GFP_DMA32 | GFP_DMA)) &&
>> +		    !zone_dma32_is_empty(node)) {
>>   			gfp |= GFP_DMA32;
>>   			goto again;
>>   		}
> 
> The zone_dma32_is_empty() value is known at compile-time if
> !CONFIG_ZONE_DMA32.  That would make it redundant to check both.
> 
>> diff --git a/kernel/dma/pool.c b/kernel/dma/pool.c
>> index 4d40dcce7604..8e79903fbda8 100644
>> --- a/kernel/dma/pool.c
>> +++ b/kernel/dma/pool.c
>> @@ -71,7 +71,7 @@ static bool cma_in_zone(gfp_t gfp)
>>   	end = cma_get_base(cma) + size - 1;
>>   	if (IS_ENABLED(CONFIG_ZONE_DMA) && (gfp & GFP_DMA))
>>   		return end <= DMA_BIT_MASK(zone_dma_bits);
>> -	if (IS_ENABLED(CONFIG_ZONE_DMA32) && (gfp & GFP_DMA32))
>> +	if (IS_ENABLED(CONFIG_ZONE_DMA32) && (gfp & GFP_DMA32) && !zone_dma32_are_empty())
>>   		return end <= DMA_BIT_MASK(32);
>>   	return true;
>>   }
>> @@ -153,7 +153,7 @@ static void atomic_pool_work_fn(struct work_struct *work)
>>   	if (IS_ENABLED(CONFIG_ZONE_DMA))
>>   		atomic_pool_resize(atomic_pool_dma,
>>   				   GFP_KERNEL | GFP_DMA);
>> -	if (IS_ENABLED(CONFIG_ZONE_DMA32))
>> +	if (IS_ENABLED(CONFIG_ZONE_DMA32) && !zone_dma32_are_empty())
>>   		atomic_pool_resize(atomic_pool_dma32,
>>   				   GFP_KERNEL | GFP_DMA32);
>>   	atomic_pool_resize(atomic_pool_kernel, GFP_KERNEL);
>> @@ -209,7 +209,7 @@ static int __init dma_atomic_pool_init(void)
>>   		if (!atomic_pool_dma)
>>   			ret = -ENOMEM;
>>   	}
>> -	if (IS_ENABLED(CONFIG_ZONE_DMA32)) {
>> +	if (IS_ENABLED(CONFIG_ZONE_DMA32) && !zone_dma32_are_empty()) {
>>   		atomic_pool_dma32 = __dma_atomic_pool_init(atomic_pool_size,
>>   						GFP_KERNEL | GFP_DMA32);
>>   		if (!atomic_pool_dma32)
>> @@ -224,7 +224,7 @@ postcore_initcall(dma_atomic_pool_init);
>>   static inline struct gen_pool *dma_guess_pool(struct gen_pool *prev, gfp_t gfp)
>>   {
>>   	if (prev == NULL) {
>> -		if (IS_ENABLED(CONFIG_ZONE_DMA32) && (gfp & GFP_DMA32))
>> +		if (IS_ENABLED(CONFIG_ZONE_DMA32) && (gfp & GFP_DMA32) && !zone_dma32_are_empty())
>>   			return atomic_pool_dma32;
>>   		if (atomic_pool_dma && (gfp & GFP_DMA))
>>   			return atomic_pool_dma;
> 
> I think every single call to zone_dma32_are_empty() is !'d.  It seems
> like it chose the wrong polarity.

