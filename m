Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D12AC65EDE3
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 14:54:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232575AbjAENxy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 08:53:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234460AbjAENxC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 08:53:02 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2C865B166
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 05:49:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6E70B61A88
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 13:49:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BB47C433EF;
        Thu,  5 Jan 2023 13:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672926598;
        bh=JwtdquvK2NuWznsH/OeSliz8CLxrTgmD6mgCCGrT8gI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MHYM34NQrY2W3dFwCSGihfFkw+dBI53gqAPNhlnRBQ4D8YU0AhkVCotcGCdkEf7ex
         f/k2tvo2NjHswyEj3Ya/stB4E+wmPEzlGdPSJrJmMp5/ceqoTLOukaVkNk33HzIfH7
         4kGBk70hYqJ13SFe0fCGqeKsj/t8dTuDgLfzkWOsMxNpbamDsKJV8xPZBrxXwnktXq
         bxa4OLpxbhZ1D409RTw3Ew5VtqtP7OMBrDl2MxqGVsvNas0y1YXsP3vXg47s60PS4h
         kSInOpvPfP1avByKzNrCeDM9cXzf2mMuyxtfWbJQmNOo5W2O28C0Q5qjW88vGeWZaF
         D7XzKc3nrJ9KA==
Date:   Thu, 5 Jan 2023 15:49:44 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, NeilBrown <neilb@suse.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 6/6] mm: discard __GFP_ATOMIC
Message-ID: <Y7bVeE1gtSmS25td@kernel.org>
References: <20221129151701.23261-1-mgorman@techsingularity.net>
 <20221129151701.23261-7-mgorman@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221129151701.23261-7-mgorman@techsingularity.net>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mel,

On Tue, Nov 29, 2022 at 03:17:01PM +0000, Mel Gorman wrote:
> From: NeilBrown <neilb@suse.de>
> 
> __GFP_ATOMIC serves little purpose.  Its main effect is to set
> ALLOC_HARDER which adds a few little boosts to increase the chance of an
> allocation succeeding, one of which is to lower the water-mark at which it
> will succeed.
> 
> It is *always* paired with __GFP_HIGH which sets ALLOC_HIGH which also
> adjusts this watermark.  It is probable that other users of __GFP_HIGH
> should benefit from the other little bonuses that __GFP_ATOMIC gets.
> 
> __GFP_ATOMIC also gives a warning if used with __GFP_DIRECT_RECLAIM.
> There is little point to this.  We already get a might_sleep() warning if
> __GFP_DIRECT_RECLAIM is set.
> 
> __GFP_ATOMIC allows the "watermark_boost" to be side-stepped.  It is
> probable that testing ALLOC_HARDER is a better fit here.
> 
> __GFP_ATOMIC is used by tegra-smmu.c to check if the allocation might
> sleep.  This should test __GFP_DIRECT_RECLAIM instead.
> 
> This patch:
>  - removes __GFP_ATOMIC
>  - allows __GFP_HIGH allocations to ignore watermark boosting as well
>    as GFP_ATOMIC requests.
>  - makes other adjustments as suggested by the above.
> 
> The net result is not change to GFP_ATOMIC allocations.  Other
> allocations that use __GFP_HIGH will benefit from a few different extra
> privileges.  This affects:
>   xen, dm, md, ntfs3
>   the vermillion frame buffer
>   hibernation
>   ksm
>   swap
> all of which likely produce more benefit than cost if these selected
> allocation are more likely to succeed quickly.
> 
> [mgorman: Minor adjustments to rework on top of a series]
> Link: https://lkml.kernel.org/r/163712397076.13692.4727608274002939094@noble.neil.brown.name
> Signed-off-by: NeilBrown <neilb@suse.de>
> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
> ---
>  Documentation/mm/balance.rst   |  2 +-

Documentation/core-api/memory-allocation.rst needs an update as well, and
there are other mentions of GFP_ATOMIC in Documentation/

>  drivers/iommu/tegra-smmu.c     |  4 ++--
>  include/linux/gfp_types.h      | 12 ++++--------
>  include/trace/events/mmflags.h |  1 -
>  lib/test_printf.c              |  8 ++++----
>  mm/internal.h                  |  2 +-
>  mm/page_alloc.c                | 13 +++----------
>  tools/perf/builtin-kmem.c      |  1 -
>  8 files changed, 15 insertions(+), 28 deletions(-)
> 
> diff --git a/Documentation/mm/balance.rst b/Documentation/mm/balance.rst
> index 6a1fadf3e173..e38e9d83c1c7 100644
> --- a/Documentation/mm/balance.rst
> +++ b/Documentation/mm/balance.rst
> @@ -6,7 +6,7 @@ Memory Balancing
>  
>  Started Jan 2000 by Kanoj Sarcar <kanoj@sgi.com>
>  
> -Memory balancing is needed for !__GFP_ATOMIC and !__GFP_KSWAPD_RECLAIM as
> +Memory balancing is needed for !__GFP_HIGH and !__GFP_KSWAPD_RECLAIM as
>  well as for non __GFP_IO allocations.
>  
>  The first reason why a caller may avoid reclaim is that the caller can not
> diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
> index 5b1af40221ec..af8d0e685260 100644
> --- a/drivers/iommu/tegra-smmu.c
> +++ b/drivers/iommu/tegra-smmu.c
> @@ -671,12 +671,12 @@ static struct page *as_get_pde_page(struct tegra_smmu_as *as,
>  	 * allocate page in a sleeping context if GFP flags permit. Hence
>  	 * spinlock needs to be unlocked and re-locked after allocation.
>  	 */
> -	if (!(gfp & __GFP_ATOMIC))
> +	if (gfpflags_allow_blocking(gfp))
>  		spin_unlock_irqrestore(&as->lock, *flags);
>  
>  	page = alloc_page(gfp | __GFP_DMA | __GFP_ZERO);
>  
> -	if (!(gfp & __GFP_ATOMIC))
> +	if (gfpflags_allow_blocking(gfp))
>  		spin_lock_irqsave(&as->lock, *flags);
>  
>  	/*
> diff --git a/include/linux/gfp_types.h b/include/linux/gfp_types.h
> index d88c46ca82e1..5088637fe5c2 100644
> --- a/include/linux/gfp_types.h
> +++ b/include/linux/gfp_types.h
> @@ -31,7 +31,7 @@ typedef unsigned int __bitwise gfp_t;
>  #define ___GFP_IO		0x40u
>  #define ___GFP_FS		0x80u
>  #define ___GFP_ZERO		0x100u
> -#define ___GFP_ATOMIC		0x200u
> +/* 0x200u unused */
>  #define ___GFP_DIRECT_RECLAIM	0x400u
>  #define ___GFP_KSWAPD_RECLAIM	0x800u
>  #define ___GFP_WRITE		0x1000u
> @@ -116,11 +116,8 @@ typedef unsigned int __bitwise gfp_t;
>   *
>   * %__GFP_HIGH indicates that the caller is high-priority and that granting
>   * the request is necessary before the system can make forward progress.
> - * For example, creating an IO context to clean pages.
> - *
> - * %__GFP_ATOMIC indicates that the caller cannot reclaim or sleep and is
> - * high priority. Users are typically interrupt handlers. This may be
> - * used in conjunction with %__GFP_HIGH
> + * For example creating an IO context to clean pages and requests
> + * from atomic context.
>   *
>   * %__GFP_MEMALLOC allows access to all memory. This should only be used when
>   * the caller guarantees the allocation will allow more memory to be freed
> @@ -135,7 +132,6 @@ typedef unsigned int __bitwise gfp_t;
>   * %__GFP_NOMEMALLOC is used to explicitly forbid access to emergency reserves.
>   * This takes precedence over the %__GFP_MEMALLOC flag if both are set.
>   */
> -#define __GFP_ATOMIC	((__force gfp_t)___GFP_ATOMIC)
>  #define __GFP_HIGH	((__force gfp_t)___GFP_HIGH)
>  #define __GFP_MEMALLOC	((__force gfp_t)___GFP_MEMALLOC)
>  #define __GFP_NOMEMALLOC ((__force gfp_t)___GFP_NOMEMALLOC)
> @@ -329,7 +325,7 @@ typedef unsigned int __bitwise gfp_t;
>   * version does not attempt reclaim/compaction at all and is by default used
>   * in page fault path, while the non-light is used by khugepaged.
>   */
> -#define GFP_ATOMIC	(__GFP_HIGH|__GFP_ATOMIC|__GFP_KSWAPD_RECLAIM)
> +#define GFP_ATOMIC	(__GFP_HIGH|__GFP_KSWAPD_RECLAIM)
>  #define GFP_KERNEL	(__GFP_RECLAIM | __GFP_IO | __GFP_FS)
>  #define GFP_KERNEL_ACCOUNT (GFP_KERNEL | __GFP_ACCOUNT)
>  #define GFP_NOWAIT	(__GFP_KSWAPD_RECLAIM)
> diff --git a/include/trace/events/mmflags.h b/include/trace/events/mmflags.h
> index e87cb2b80ed3..11524cda4a95 100644
> --- a/include/trace/events/mmflags.h
> +++ b/include/trace/events/mmflags.h
> @@ -31,7 +31,6 @@
>  	gfpflag_string(__GFP_HIGHMEM),		\
>  	gfpflag_string(GFP_DMA32),		\
>  	gfpflag_string(__GFP_HIGH),		\
> -	gfpflag_string(__GFP_ATOMIC),		\
>  	gfpflag_string(__GFP_IO),		\
>  	gfpflag_string(__GFP_FS),		\
>  	gfpflag_string(__GFP_NOWARN),		\
> diff --git a/lib/test_printf.c b/lib/test_printf.c
> index 4bd15a593fbd..fe13de1bed5f 100644
> --- a/lib/test_printf.c
> +++ b/lib/test_printf.c
> @@ -686,17 +686,17 @@ flags(void)
>  	gfp = GFP_ATOMIC|__GFP_DMA;
>  	test("GFP_ATOMIC|GFP_DMA", "%pGg", &gfp);
>  
> -	gfp = __GFP_ATOMIC;
> -	test("__GFP_ATOMIC", "%pGg", &gfp);
> +	gfp = __GFP_HIGH;
> +	test("__GFP_HIGH", "%pGg", &gfp);
>  
>  	/* Any flags not translated by the table should remain numeric */
>  	gfp = ~__GFP_BITS_MASK;
>  	snprintf(cmp_buffer, BUF_SIZE, "%#lx", (unsigned long) gfp);
>  	test(cmp_buffer, "%pGg", &gfp);
>  
> -	snprintf(cmp_buffer, BUF_SIZE, "__GFP_ATOMIC|%#lx",
> +	snprintf(cmp_buffer, BUF_SIZE, "__GFP_HIGH|%#lx",
>  							(unsigned long) gfp);
> -	gfp |= __GFP_ATOMIC;
> +	gfp |= __GFP_HIGH;
>  	test(cmp_buffer, "%pGg", &gfp);
>  
>  	kfree(cmp_buffer);
> diff --git a/mm/internal.h b/mm/internal.h
> index 98b1e526559d..48926b290cd5 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -24,7 +24,7 @@ struct folio_batch;
>  #define GFP_RECLAIM_MASK (__GFP_RECLAIM|__GFP_HIGH|__GFP_IO|__GFP_FS|\
>  			__GFP_NOWARN|__GFP_RETRY_MAYFAIL|__GFP_NOFAIL|\
>  			__GFP_NORETRY|__GFP_MEMALLOC|__GFP_NOMEMALLOC|\
> -			__GFP_ATOMIC|__GFP_NOLOCKDEP)
> +			__GFP_NOLOCKDEP)
>  
>  /* The GFP flags allowed during early boot */
>  #define GFP_BOOT_MASK (__GFP_BITS_MASK & ~(__GFP_RECLAIM|__GFP_IO|__GFP_FS))
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 6bee987ec9a3..ad6c4705a79d 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -4081,13 +4081,14 @@ static inline bool zone_watermark_fast(struct zone *z, unsigned int order,
>  	if (__zone_watermark_ok(z, order, mark, highest_zoneidx, alloc_flags,
>  					free_pages))
>  		return true;
> +
>  	/*
> -	 * Ignore watermark boosting for GFP_ATOMIC order-0 allocations
> +	 * Ignore watermark boosting for GFP_HIGH order-0 allocations
>  	 * when checking the min watermark. The min watermark is the
>  	 * point where boosting is ignored so that kswapd is woken up
>  	 * when below the low watermark.
>  	 */
> -	if (unlikely(!order && (gfp_mask & __GFP_ATOMIC) && z->watermark_boost
> +	if (unlikely(!order && (alloc_flags & ALLOC_MIN_RESERVE) && z->watermark_boost
>  		&& ((alloc_flags & ALLOC_WMARK_MASK) == WMARK_MIN))) {
>  		mark = z->_watermark[WMARK_MIN];
>  		return __zone_watermark_ok(z, order, mark, highest_zoneidx,
> @@ -5052,14 +5053,6 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
>  	unsigned int zonelist_iter_cookie;
>  	int reserve_flags;
>  
> -	/*
> -	 * We also sanity check to catch abuse of atomic reserves being used by
> -	 * callers that are not in atomic context.
> -	 */
> -	if (WARN_ON_ONCE((gfp_mask & (__GFP_ATOMIC|__GFP_DIRECT_RECLAIM)) ==
> -				(__GFP_ATOMIC|__GFP_DIRECT_RECLAIM)))
> -		gfp_mask &= ~__GFP_ATOMIC;
> -
>  restart:
>  	compaction_retries = 0;
>  	no_progress_loops = 0;
> diff --git a/tools/perf/builtin-kmem.c b/tools/perf/builtin-kmem.c
> index ebfab2ca1702..4a06d83f2ac5 100644
> --- a/tools/perf/builtin-kmem.c
> +++ b/tools/perf/builtin-kmem.c
> @@ -640,7 +640,6 @@ static const struct {
>  	{ "__GFP_HIGHMEM",		"HM" },
>  	{ "GFP_DMA32",			"D32" },
>  	{ "__GFP_HIGH",			"H" },
> -	{ "__GFP_ATOMIC",		"_A" },
>  	{ "__GFP_IO",			"I" },
>  	{ "__GFP_FS",			"F" },
>  	{ "__GFP_NOWARN",		"NWR" },
> -- 
> 2.35.3
> 
> 

-- 
Sincerely yours,
Mike.
