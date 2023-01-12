Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F9E2666C28
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 09:12:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238488AbjALIM1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 03:12:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236706AbjALIMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 03:12:18 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F26B01B1D6
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 00:12:15 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id F2AA03E79B;
        Thu, 12 Jan 2023 08:12:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1673511134; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Eg5Iw+h41SFhoXURLxb/9RXfgOqng51BxAIDUlyBdr0=;
        b=ZEH5EC0uCTFg0heKjDQfUyN+o+juXmFrnvoBLp3evZUqH3sXOGhG6gqOTWp4Povnyd0SN2
        kbQ5CTpt61FKIK8b71iIJfd7JopAYzmEZCtPwiiJkUbZQUJxtkhH38/50AntBCfmIPbWdk
        mIWdG1ZDrbQ0QzED9744ve7tcRwY7r0=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D3CE9134B3;
        Thu, 12 Jan 2023 08:12:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id /UhjMd3Av2MTaQAAMHmgww
        (envelope-from <mhocko@suse.com>); Thu, 12 Jan 2023 08:12:13 +0000
Date:   Thu, 12 Jan 2023 09:12:13 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        NeilBrown <neilb@suse.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 7/7] mm: discard __GFP_ATOMIC
Message-ID: <Y7/A3Yf4kmsJNpoK@dhcp22.suse.cz>
References: <20230109151631.24923-1-mgorman@techsingularity.net>
 <20230109151631.24923-8-mgorman@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230109151631.24923-8-mgorman@techsingularity.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 09-01-23 15:16:31, Mel Gorman wrote:
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
> Acked-by: Vlastimil Babka <vbabka@suse.cz>

Forgot to ack this one yesterday
Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  Documentation/mm/balance.rst   |  2 +-
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
> index 412b5a46374c..9db52bc4ce19 100644
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
> index d34dc636b81c..46b4e6c414a3 100644
> --- a/lib/test_printf.c
> +++ b/lib/test_printf.c
> @@ -674,17 +674,17 @@ flags(void)
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
> index 23a37588073a..71b1111427f3 100644
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
> index 2217bab2dbb2..7244ab522028 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -4086,13 +4086,14 @@ static inline bool zone_watermark_fast(struct zone *z, unsigned int order,
>  	if (__zone_watermark_ok(z, order, mark, highest_zoneidx, alloc_flags,
>  					free_pages))
>  		return true;
> +
>  	/*
> -	 * Ignore watermark boosting for GFP_ATOMIC order-0 allocations
> +	 * Ignore watermark boosting for __GFP_HIGH order-0 allocations
>  	 * when checking the min watermark. The min watermark is the
>  	 * point where boosting is ignored so that kswapd is woken up
>  	 * when below the low watermark.
>  	 */
> -	if (unlikely(!order && (gfp_mask & __GFP_ATOMIC) && z->watermark_boost
> +	if (unlikely(!order && (alloc_flags & ALLOC_MIN_RESERVE) && z->watermark_boost
>  		&& ((alloc_flags & ALLOC_WMARK_MASK) == WMARK_MIN))) {
>  		mark = z->_watermark[WMARK_MIN];
>  		return __zone_watermark_ok(z, order, mark, highest_zoneidx,
> @@ -5057,14 +5058,6 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
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
> index e20656c431a4..173d407dce92 100644
> --- a/tools/perf/builtin-kmem.c
> +++ b/tools/perf/builtin-kmem.c
> @@ -641,7 +641,6 @@ static const struct {
>  	{ "__GFP_HIGHMEM",		"HM" },
>  	{ "GFP_DMA32",			"D32" },
>  	{ "__GFP_HIGH",			"H" },
> -	{ "__GFP_ATOMIC",		"_A" },
>  	{ "__GFP_IO",			"I" },
>  	{ "__GFP_FS",			"F" },
>  	{ "__GFP_NOWARN",		"NWR" },
> -- 
> 2.35.3

-- 
Michal Hocko
SUSE Labs
