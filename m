Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44B926C9952
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 03:26:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231352AbjC0B0w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 21:26:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjC0B0u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 21:26:50 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B41340E3
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 18:26:49 -0700 (PDT)
Received: from dggpemm500006.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4PlFSL5pXMzSpGF;
        Mon, 27 Mar 2023 09:23:14 +0800 (CST)
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 27 Mar 2023 09:26:46 +0800
Subject: Re: [PATCH v2 3/3] arm64: kdump: defer the crashkernel reservation
 for platforms with no DMA memory zones
To:     Baoquan He <bhe@redhat.com>, <linux-kernel@vger.kernel.org>
CC:     <catalin.marinas@arm.com>, <horms@kernel.org>,
        <John.p.donnelly@oracle.com>, <will@kernel.org>,
        <kexec@lists.infradead.org>, <ardb@kernel.org>, <rppt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20230324131838.409996-1-bhe@redhat.com>
 <20230324131838.409996-4-bhe@redhat.com> <ZCBCgkiJ1/QPfgSt@MiWiFi-R3L-srv>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <cf446196-d9fa-5787-8072-9f664c10433a@huawei.com>
Date:   Mon, 27 Mar 2023 09:26:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <ZCBCgkiJ1/QPfgSt@MiWiFi-R3L-srv>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.3 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/3/26 21:02, Baoquan He wrote:
> In commit 031495635b46 ("arm64: Do not defer reserve_crashkernel() for
> platforms with no DMA memory zones"), reserve_crashkernel() is called
> much earlier in arm64_memblock_init() to avoid causing base apge
> mapping on platforms with no DMA meomry zones.
> 
> With taking off protection on crashkernel memory region, no need to call
> reserve_crashkernel() specially in advance. The deferred invocation of
> reserve_crashkernel() in bootmem_init() can cover all cases. So revert
> the commit 031495635b46 now.
> 
> Signed-off-by: Baoquan He <bhe@redhat.com>
> ---
> v1->v2:
> - When trying to revert commit 031495635b46, two hunks were missed in v1
>   post. Remove them in v2. Thanks to Leizhen for pointing out this. 
>   - Remove code comment above arm64_dma_phys_limit definition added
>     in commit 031495635b46;
>   - Move the arm64_dma_phys_limit assignment back into zone_sizes_init()
>     when both CONFIG_ZONE_DMA and CONFIG_ZONE_DMA32 are not enabled.

Reviewed-by: Zhen Lei <thunder.leizhen@huawei.com>

> 
>  arch/arm64/include/asm/memory.h |  5 -----
>  arch/arm64/mm/init.c            | 34 +++------------------------------
>  2 files changed, 3 insertions(+), 36 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
> index 78e5163836a0..efcd68154a3a 100644
> --- a/arch/arm64/include/asm/memory.h
> +++ b/arch/arm64/include/asm/memory.h
> @@ -374,11 +374,6 @@ static inline void *phys_to_virt(phys_addr_t x)
>  })
>  
>  void dump_mem_limit(void);
> -
> -static inline bool defer_reserve_crashkernel(void)
> -{
> -	return IS_ENABLED(CONFIG_ZONE_DMA) || IS_ENABLED(CONFIG_ZONE_DMA32);
> -}
>  #endif /* !ASSEMBLY */
>  
>  /*
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index 58a0bb2c17f1..66e70ca47680 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -61,34 +61,8 @@ EXPORT_SYMBOL(memstart_addr);
>   * unless restricted on specific platforms (e.g. 30-bit on Raspberry Pi 4).
>   * In such case, ZONE_DMA32 covers the rest of the 32-bit addressable memory,
>   * otherwise it is empty.
> - *
> - * Memory reservation for crash kernel either done early or deferred
> - * depending on DMA memory zones configs (ZONE_DMA) --
> - *
> - * In absence of ZONE_DMA configs arm64_dma_phys_limit initialized
> - * here instead of max_zone_phys().  This lets early reservation of
> - * crash kernel memory which has a dependency on arm64_dma_phys_limit.
> - * Reserving memory early for crash kernel allows linear creation of block
> - * mappings (greater than page-granularity) for all the memory bank rangs.
> - * In this scheme a comparatively quicker boot is observed.
> - *
> - * If ZONE_DMA configs are defined, crash kernel memory reservation
> - * is delayed until DMA zone memory range size initialization performed in
> - * zone_sizes_init().  The defer is necessary to steer clear of DMA zone
> - * memory range to avoid overlap allocation.  So crash kernel memory boundaries
> - * are not known when mapping all bank memory ranges, which otherwise means
> - * not possible to exclude crash kernel range from creating block mappings
> - * so page-granularity mappings are created for the entire memory range.
> - * Hence a slightly slower boot is observed.
> - *
> - * Note: Page-granularity mappings are necessary for crash kernel memory
> - * range for shrinking its size via /sys/kernel/kexec_crash_size interface.
>   */
> -#if IS_ENABLED(CONFIG_ZONE_DMA) || IS_ENABLED(CONFIG_ZONE_DMA32)
>  phys_addr_t __ro_after_init arm64_dma_phys_limit;
> -#else
> -phys_addr_t __ro_after_init arm64_dma_phys_limit = PHYS_MASK + 1;
> -#endif
>  
>  /* Current arm64 boot protocol requires 2MB alignment */
>  #define CRASH_ALIGN			SZ_2M
> @@ -248,6 +222,8 @@ static void __init zone_sizes_init(void)
>  	if (!arm64_dma_phys_limit)
>  		arm64_dma_phys_limit = dma32_phys_limit;
>  #endif
> +	if (!arm64_dma_phys_limit)
> +		arm64_dma_phys_limit = PHYS_MASK + 1;
>  	max_zone_pfns[ZONE_NORMAL] = max_pfn;
>  
>  	free_area_init(max_zone_pfns);
> @@ -408,9 +384,6 @@ void __init arm64_memblock_init(void)
>  
>  	early_init_fdt_scan_reserved_mem();
>  
> -	if (!defer_reserve_crashkernel())
> -		reserve_crashkernel();
> -
>  	high_memory = __va(memblock_end_of_DRAM() - 1) + 1;
>  }
>  
> @@ -457,8 +430,7 @@ void __init bootmem_init(void)
>  	 * request_standard_resources() depends on crashkernel's memory being
>  	 * reserved, so do it here.
>  	 */
> -	if (defer_reserve_crashkernel())
> -		reserve_crashkernel();
> +	reserve_crashkernel();
>  
>  	memblock_dump_all();
>  }
> 

-- 
Regards,
  Zhen Lei
