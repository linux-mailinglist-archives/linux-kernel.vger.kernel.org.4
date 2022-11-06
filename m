Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1996061E37E
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 17:42:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbiKFQms (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 11:42:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbiKFQmp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 11:42:45 -0500
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3254AAE6E
        for <linux-kernel@vger.kernel.org>; Sun,  6 Nov 2022 08:42:44 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id z1so5993534qkl.9
        for <linux-kernel@vger.kernel.org>; Sun, 06 Nov 2022 08:42:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xtzGKfnRZ1p7+0H8FLRZSOOcROCnLbN2i4aRELH2gIs=;
        b=mPxcuDCHI6uEJkr54Ot1KN78OTE6ZR03MaaJCu6fHPbbTUazYYSLnmYWRFrCyqtmCv
         n5dvXfupGjebNGX0uouOfopvCLG63cgkPcYwP+jmQvPgda08O3/xBsdT0/HNnK6T1dKc
         uCKgXO37fqxLv4B+Hg0tutGkG5C46VyzlC5AOLG1ZPdeA3kkhprHqZ2F/zZkBScdtIHB
         4Ot5Eoqgx+YPREux7JA5ReYeFkcXttWe+oIro4ySTdcqgPu6BHsYXluGUaoHhtYy2O+q
         /HyquHuEYMPR9BT9Ta0jsYaiJntEWoPL14RG4IEzy3YXalfYazjxU8gWC5xq+IUqb76b
         GlWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xtzGKfnRZ1p7+0H8FLRZSOOcROCnLbN2i4aRELH2gIs=;
        b=UadCqxjMKeWZ75qi1zXRIVzd5RsCeTTP5a1ESxsRbPmiFLSZSu+VPAY92466EII1O7
         KuQRTcf+1s1TfVJJ45ZaC9FDbrmKsU1FO5M9vGN+50y8fjaqM8bGRxsc+EMEh8GzSDZY
         ulNRH3/D2jjtwuCKe0TrVaWkSl61N9UzXaWntrJckAzy6yfJXjaicPN90rRAWqfgS/8M
         CzZPohbZKTLSWnF8q2HDYMgq++yU68v1t6EK2o8X9MkTY17FWkGshtlhGOZDp27pdzL/
         uk8bxYODkjhFDNR+6+WyT/NycDK32vNnCeunqFQDytsaBes8fxh8REhoAXVu/xr3nI3n
         Q4Zw==
X-Gm-Message-State: ACrzQf0MlSqnoMFy70ZXVkFpDjQcMp+0mAT25qm+513ZIeI8mvsX87qY
        kYDK+4Plwjj1gTqrm+LYkF3suQ==
X-Google-Smtp-Source: AMsMyM6bM23PKQsi3mvKscEqL7WRtuLZhaQENUE9kYYsuItOB0o3GUdfL/xeeV7k+P9ZGMjYPdzw8w==
X-Received: by 2002:a05:620a:909:b0:6fa:1031:33a5 with SMTP id v9-20020a05620a090900b006fa103133a5mr32557125qkv.496.1667752963069;
        Sun, 06 Nov 2022 08:42:43 -0800 (PST)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id q53-20020a05620a2a7500b006fab68c7e87sm3591041qkp.70.2022.11.06.08.42.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Nov 2022 08:42:42 -0800 (PST)
Date:   Sun, 6 Nov 2022 08:42:32 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Mel Gorman <mgorman@techsingularity.net>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>, Vlastimil Babka <vbabka@suse.cz>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: [PATCH v2] mm/page_alloc: Leave IRQs enabled for per-cpu page
 allocations
In-Reply-To: <20221104142259.5hohev5hzvwanbi2@techsingularity.net>
Message-ID: <97b7ae87-797c-4ebb-d2d3-9415975188@google.com>
References: <20221104142259.5hohev5hzvwanbi2@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Nov 2022, Mel Gorman wrote:

> Changelog since v1
>  o Use trylock in free_unref_page_list due to IO completion from softirq
>    context
> 
> The pcp_spin_lock_irqsave protecting the PCP lists is IRQ-safe as a task
> allocating from the PCP must not re-enter the allocator from IRQ context.
> In each instance where IRQ-reentrancy is possible, the lock is acquired using
> pcp_spin_trylock_irqsave() even though IRQs are disabled and re-entrancy
> is impossible.
> 
> Demote the lock to pcp_spin_lock avoids an IRQ disable/enable in the common
> case at the cost of some IRQ allocations taking a slower path. If the PCP
> lists need to be refilled, the zone lock still needs to disable IRQs but
> that will only happen on PCP refill and drain. If an IRQ is raised when
> a PCP allocation is in progress, the trylock will fail and fallback to
> using the buddy lists directly. Note that this may not be a universal win
> if an interrupt-intensive workload also allocates heavily from interrupt
> context and contends heavily on the zone->lock as a result.
> 
> [yuzhao@google.com: Reported lockdep issue on IO completion from softirq]
> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>

Hi Mel, I think you Cc'ed me for the purpose of giving this patch a
run, and reporting if it's not good.  That is the case, I'm afraid.

I first tried it on a v6.1-rc3, and very soon crashed under load with
something about PageBuddy in the output.  When I reverted, no problem;
I thought maybe it's dependent on other commits in akpm's tree.

Later I tried on current mm-unstable: which is living up to the name
in other ways, but when other issues patched, it soon crashed under
load, GPF probably for non-canonical address 0xdead0000000000f8
in compact_zone < compact_zone_order < try_to_compact_pages <
.... < shmem_alloc_hugefolio < ...

I do try to exercise compaction as hard as I can, even to the point
of having a hack in what used to be called shmem_getpage_gfp(),
reverting to the stronger attempt to get huge pages, before Rik
weakened the effect of huge=always with vma_thp_gfp_mask() in 5.12:
so shmem is probably applying stronger flags for compaction than it
would in your tree - I'm using
GFP_TRANSHUGE_LIGHT | __GFP_RECLAIM | __GFP_NORETRY there.

Sorry for not giving you more info, I'm rather hoping that compaction
is relevant, and will give you a clue (maybe that capture code, which
surprised us once before??).  What I'm really trying to do is fix
the bug in Linus's rmap/TLB series, and its interaction with my
rmap series, and report back on his series (asking for temporary
drop), before next-20221107 goes down in flames.

I'd advocate for dropping this patch of yours too; but if it's giving
nobody else any trouble, I can easily continue to patch it out.

Hugh

> ---
>  mm/page_alloc.c | 122 ++++++++++++++++++++++++--------------------------------
>  1 file changed, 53 insertions(+), 69 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index e20ade858e71..ae410adf36fb 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -170,21 +170,12 @@ static DEFINE_MUTEX(pcp_batch_high_lock);
>  	_ret;								\
>  })
>  
> -#define pcpu_spin_lock_irqsave(type, member, ptr, flags)		\
> +#define pcpu_spin_trylock(type, member, ptr)				\
>  ({									\
>  	type *_ret;							\
>  	pcpu_task_pin();						\
>  	_ret = this_cpu_ptr(ptr);					\
> -	spin_lock_irqsave(&_ret->member, flags);			\
> -	_ret;								\
> -})
> -
> -#define pcpu_spin_trylock_irqsave(type, member, ptr, flags)		\
> -({									\
> -	type *_ret;							\
> -	pcpu_task_pin();						\
> -	_ret = this_cpu_ptr(ptr);					\
> -	if (!spin_trylock_irqsave(&_ret->member, flags)) {		\
> +	if (!spin_trylock(&_ret->member)) {				\
>  		pcpu_task_unpin();					\
>  		_ret = NULL;						\
>  	}								\
> @@ -197,27 +188,16 @@ static DEFINE_MUTEX(pcp_batch_high_lock);
>  	pcpu_task_unpin();						\
>  })
>  
> -#define pcpu_spin_unlock_irqrestore(member, ptr, flags)			\
> -({									\
> -	spin_unlock_irqrestore(&ptr->member, flags);			\
> -	pcpu_task_unpin();						\
> -})
> -
>  /* struct per_cpu_pages specific helpers. */
>  #define pcp_spin_lock(ptr)						\
>  	pcpu_spin_lock(struct per_cpu_pages, lock, ptr)
>  
> -#define pcp_spin_lock_irqsave(ptr, flags)				\
> -	pcpu_spin_lock_irqsave(struct per_cpu_pages, lock, ptr, flags)
> -
> -#define pcp_spin_trylock_irqsave(ptr, flags)				\
> -	pcpu_spin_trylock_irqsave(struct per_cpu_pages, lock, ptr, flags)
> +#define pcp_spin_trylock(ptr)						\
> +	pcpu_spin_trylock(struct per_cpu_pages, lock, ptr)
>  
>  #define pcp_spin_unlock(ptr)						\
>  	pcpu_spin_unlock(lock, ptr)
>  
> -#define pcp_spin_unlock_irqrestore(ptr, flags)				\
> -	pcpu_spin_unlock_irqrestore(lock, ptr, flags)
>  #ifdef CONFIG_USE_PERCPU_NUMA_NODE_ID
>  DEFINE_PER_CPU(int, numa_node);
>  EXPORT_PER_CPU_SYMBOL(numa_node);
> @@ -1546,6 +1526,7 @@ static void free_pcppages_bulk(struct zone *zone, int count,
>  					struct per_cpu_pages *pcp,
>  					int pindex)
>  {
> +	unsigned long flags;
>  	int min_pindex = 0;
>  	int max_pindex = NR_PCP_LISTS - 1;
>  	unsigned int order;
> @@ -1561,8 +1542,7 @@ static void free_pcppages_bulk(struct zone *zone, int count,
>  	/* Ensure requested pindex is drained first. */
>  	pindex = pindex - 1;
>  
> -	/* Caller must hold IRQ-safe pcp->lock so IRQs are disabled. */
> -	spin_lock(&zone->lock);
> +	spin_lock_irqsave(&zone->lock, flags);
>  	isolated_pageblocks = has_isolate_pageblock(zone);
>  
>  	while (count > 0) {
> @@ -1610,7 +1590,7 @@ static void free_pcppages_bulk(struct zone *zone, int count,
>  		} while (count > 0 && !list_empty(list));
>  	}
>  
> -	spin_unlock(&zone->lock);
> +	spin_unlock_irqrestore(&zone->lock, flags);
>  }
>  
>  static void free_one_page(struct zone *zone,
> @@ -3124,10 +3104,10 @@ static int rmqueue_bulk(struct zone *zone, unsigned int order,
>  			unsigned long count, struct list_head *list,
>  			int migratetype, unsigned int alloc_flags)
>  {
> +	unsigned long flags;
>  	int i, allocated = 0;
>  
> -	/* Caller must hold IRQ-safe pcp->lock so IRQs are disabled. */
> -	spin_lock(&zone->lock);
> +	spin_lock_irqsave(&zone->lock, flags);
>  	for (i = 0; i < count; ++i) {
>  		struct page *page = __rmqueue(zone, order, migratetype,
>  								alloc_flags);
> @@ -3161,7 +3141,7 @@ static int rmqueue_bulk(struct zone *zone, unsigned int order,
>  	 * pages added to the pcp list.
>  	 */
>  	__mod_zone_page_state(zone, NR_FREE_PAGES, -(i << order));
> -	spin_unlock(&zone->lock);
> +	spin_unlock_irqrestore(&zone->lock, flags);
>  	return allocated;
>  }
>  
> @@ -3178,16 +3158,9 @@ void drain_zone_pages(struct zone *zone, struct per_cpu_pages *pcp)
>  	batch = READ_ONCE(pcp->batch);
>  	to_drain = min(pcp->count, batch);
>  	if (to_drain > 0) {
> -		unsigned long flags;
> -
> -		/*
> -		 * free_pcppages_bulk expects IRQs disabled for zone->lock
> -		 * so even though pcp->lock is not intended to be IRQ-safe,
> -		 * it's needed in this context.
> -		 */
> -		spin_lock_irqsave(&pcp->lock, flags);
> +		spin_lock(&pcp->lock);
>  		free_pcppages_bulk(zone, to_drain, pcp, 0);
> -		spin_unlock_irqrestore(&pcp->lock, flags);
> +		spin_unlock(&pcp->lock);
>  	}
>  }
>  #endif
> @@ -3201,12 +3174,9 @@ static void drain_pages_zone(unsigned int cpu, struct zone *zone)
>  
>  	pcp = per_cpu_ptr(zone->per_cpu_pageset, cpu);
>  	if (pcp->count) {
> -		unsigned long flags;
> -
> -		/* See drain_zone_pages on why this is disabling IRQs */
> -		spin_lock_irqsave(&pcp->lock, flags);
> +		spin_lock(&pcp->lock);
>  		free_pcppages_bulk(zone, pcp->count, pcp, 0);
> -		spin_unlock_irqrestore(&pcp->lock, flags);
> +		spin_unlock(&pcp->lock);
>  	}
>  }
>  
> @@ -3472,7 +3442,6 @@ static void free_unref_page_commit(struct zone *zone, struct per_cpu_pages *pcp,
>   */
>  void free_unref_page(struct page *page, unsigned int order)
>  {
> -	unsigned long flags;
>  	unsigned long __maybe_unused UP_flags;
>  	struct per_cpu_pages *pcp;
>  	struct zone *zone;
> @@ -3500,10 +3469,10 @@ void free_unref_page(struct page *page, unsigned int order)
>  
>  	zone = page_zone(page);
>  	pcp_trylock_prepare(UP_flags);
> -	pcp = pcp_spin_trylock_irqsave(zone->per_cpu_pageset, flags);
> +	pcp = pcp_spin_trylock(zone->per_cpu_pageset);
>  	if (pcp) {
>  		free_unref_page_commit(zone, pcp, page, migratetype, order);
> -		pcp_spin_unlock_irqrestore(pcp, flags);
> +		pcp_spin_unlock(pcp);
>  	} else {
>  		free_one_page(zone, page, pfn, order, migratetype, FPI_NONE);
>  	}
> @@ -3515,10 +3484,10 @@ void free_unref_page(struct page *page, unsigned int order)
>   */
>  void free_unref_page_list(struct list_head *list)
>  {
> +	unsigned long __maybe_unused UP_flags;
>  	struct page *page, *next;
>  	struct per_cpu_pages *pcp = NULL;
>  	struct zone *locked_zone = NULL;
> -	unsigned long flags;
>  	int batch_count = 0;
>  	int migratetype;
>  
> @@ -3547,11 +3516,26 @@ void free_unref_page_list(struct list_head *list)
>  
>  		/* Different zone, different pcp lock. */
>  		if (zone != locked_zone) {
> -			if (pcp)
> -				pcp_spin_unlock_irqrestore(pcp, flags);
> +			if (pcp) {
> +				pcp_spin_unlock(pcp);
> +				pcp_trylock_finish(UP_flags);
> +			}
>  
> +			/*
> +			 * trylock is necessary as pages may be getting freed
> +			 * from IRQ or SoftIRQ context after an IO completion.
> +			 */
> +			pcp_trylock_prepare(UP_flags);
> +			pcp = pcp_spin_trylock(zone->per_cpu_pageset);
> +			if (!pcp) {
> +				pcp_trylock_finish(UP_flags);
> +				list_del(&page->lru);
> +				free_one_page(page_zone(page), page,
> +					      page_to_pfn(page), 0, migratetype,
> +					      FPI_NONE);
> +				continue;
> +			}
>  			locked_zone = zone;
> -			pcp = pcp_spin_lock_irqsave(locked_zone->per_cpu_pageset, flags);
>  		}
>  
>  		/*
> @@ -3566,18 +3550,23 @@ void free_unref_page_list(struct list_head *list)
>  		free_unref_page_commit(zone, pcp, page, migratetype, 0);
>  
>  		/*
> -		 * Guard against excessive IRQ disabled times when we get
> -		 * a large list of pages to free.
> +		 * Guard against excessive IRQ disabled times when freeing
> +		 * a large list of pages. Lock will be reacquired if
> +		 * necessary on the next iteration.
>  		 */
>  		if (++batch_count == SWAP_CLUSTER_MAX) {
> -			pcp_spin_unlock_irqrestore(pcp, flags);
> +			pcp_spin_unlock(pcp);
> +			pcp_trylock_finish(UP_flags);
>  			batch_count = 0;
> -			pcp = pcp_spin_lock_irqsave(locked_zone->per_cpu_pageset, flags);
> +			pcp = NULL;
> +			locked_zone = NULL;
>  		}
>  	}
>  
> -	if (pcp)
> -		pcp_spin_unlock_irqrestore(pcp, flags);
> +	if (pcp) {
> +		pcp_spin_unlock(pcp);
> +		pcp_trylock_finish(UP_flags);
> +	}
>  }
>  
>  /*
> @@ -3778,15 +3767,11 @@ static struct page *rmqueue_pcplist(struct zone *preferred_zone,
>  	struct per_cpu_pages *pcp;
>  	struct list_head *list;
>  	struct page *page;
> -	unsigned long flags;
>  	unsigned long __maybe_unused UP_flags;
>  
> -	/*
> -	 * spin_trylock may fail due to a parallel drain. In the future, the
> -	 * trylock will also protect against IRQ reentrancy.
> -	 */
> +	/* spin_trylock may fail due to a parallel drain or IRQ reentrancy. */
>  	pcp_trylock_prepare(UP_flags);
> -	pcp = pcp_spin_trylock_irqsave(zone->per_cpu_pageset, flags);
> +	pcp = pcp_spin_trylock(zone->per_cpu_pageset);
>  	if (!pcp) {
>  		pcp_trylock_finish(UP_flags);
>  		return NULL;
> @@ -3800,7 +3785,7 @@ static struct page *rmqueue_pcplist(struct zone *preferred_zone,
>  	pcp->free_factor >>= 1;
>  	list = &pcp->lists[order_to_pindex(migratetype, order)];
>  	page = __rmqueue_pcplist(zone, order, migratetype, alloc_flags, pcp, list);
> -	pcp_spin_unlock_irqrestore(pcp, flags);
> +	pcp_spin_unlock(pcp);
>  	pcp_trylock_finish(UP_flags);
>  	if (page) {
>  		__count_zid_vm_events(PGALLOC, page_zonenum(page), 1 << order);
> @@ -5368,7 +5353,6 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
>  			struct page **page_array)
>  {
>  	struct page *page;
> -	unsigned long flags;
>  	unsigned long __maybe_unused UP_flags;
>  	struct zone *zone;
>  	struct zoneref *z;
> @@ -5450,9 +5434,9 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
>  	if (unlikely(!zone))
>  		goto failed;
>  
> -	/* Is a parallel drain in progress? */
> +	/* spin_trylock may fail due to a parallel drain or IRQ reentrancy. */
>  	pcp_trylock_prepare(UP_flags);
> -	pcp = pcp_spin_trylock_irqsave(zone->per_cpu_pageset, flags);
> +	pcp = pcp_spin_trylock(zone->per_cpu_pageset);
>  	if (!pcp)
>  		goto failed_irq;
>  
> @@ -5471,7 +5455,7 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
>  		if (unlikely(!page)) {
>  			/* Try and allocate at least one page */
>  			if (!nr_account) {
> -				pcp_spin_unlock_irqrestore(pcp, flags);
> +				pcp_spin_unlock(pcp);
>  				goto failed_irq;
>  			}
>  			break;
> @@ -5486,7 +5470,7 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
>  		nr_populated++;
>  	}
>  
> -	pcp_spin_unlock_irqrestore(pcp, flags);
> +	pcp_spin_unlock(pcp);
>  	pcp_trylock_finish(UP_flags);
>  
>  	__count_zid_vm_events(PGALLOC, zone_idx(zone), nr_account);
> 
