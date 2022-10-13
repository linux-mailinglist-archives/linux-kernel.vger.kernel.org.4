Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC4A95FD7A1
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 12:10:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbiJMKKa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 06:10:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbiJMKK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 06:10:26 -0400
Received: from outbound-smtp25.blacknight.com (outbound-smtp25.blacknight.com [81.17.249.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37FCE59267
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 03:10:18 -0700 (PDT)
Received: from mail.blacknight.com (pemlinmail04.blacknight.ie [81.17.254.17])
        by outbound-smtp25.blacknight.com (Postfix) with ESMTPS id 17C10CAE2D
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 11:10:17 +0100 (IST)
Received: (qmail 7339 invoked from network); 13 Oct 2022 10:10:16 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.198.246])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 13 Oct 2022 10:10:16 -0000
Date:   Thu, 13 Oct 2022 11:10:13 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Yu Zhao <yuzhao@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH 1/1] mm/page_alloc: Leave IRQs enabled for per-cpu page
 allocations
Message-ID: <20221013101013.g37bxlswarm3owfe@techsingularity.net>
References: <20220824141802.23395-1-mgorman@techsingularity.net>
 <CAOUHufbxqn5gjYxnZDLsRtaKgtauFXwL+qq_829Eg5PSJaSPgg@mail.gmail.com>
 <20221010142208.ctsasloh7hbudupc@techsingularity.net>
 <a7092c47-63ef-200a-8968-7e3402e19a38@suse.cz>
 <CAOUHufYck0whrXAYBN9mO6CTairoJ0cG9YyU79pMPvYjrXLrOg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <CAOUHufYck0whrXAYBN9mO6CTairoJ0cG9YyU79pMPvYjrXLrOg@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 10, 2022 at 04:09:14PM -0600, Yu Zhao wrote:
> > I didn't (try to) reproduce this, but FWIW the report looked legit to
> > me, as after the patch, pcp_spin_trylock() has to be used for both
> > allocation and freeing to be IRQ safe. free_unref_page() uses it, so
> > it's fine. But as the stack trace in the report shows,
> > free_unref_page_list() does pcp_spin_lock() and not _trylock, and that's
> > IMHO the problem.
> 
> If this is not the case, please let me know and I'll try repro again.

Can you try testing this patch please on top of v6.0? It passed light
testing for me but I never got the lockdep warning.

--8<--
mm/page_alloc: Leave IRQs enabled for per-cpu page allocations

The pcp_spin_lock_irqsave protecting the PCP lists is IRQ-safe as a task
allocating from the PCP must not re-enter the allocator from IRQ context.
In each instance where IRQ-reentrancy is possible, the lock is acquired using
pcp_spin_trylock_irqsave() even though IRQs are disabled and re-entrancy
is impossible.

Demote the lock to pcp_spin_lock avoids an IRQ disable/enable in the common
case at the cost of some IRQ allocations taking a slower path. If the PCP
lists need to be refilled, the zone lock still needs to disable IRQs but
that will only happen on PCP refill and drain. If an IRQ is raised when
a PCP allocation is in progress, the trylock will fail and fallback to
using the buddy lists directly. Note that this may not be a universal win
if an interrupt-intensive workload also allocates heavily from interrupt
context and contends heavily on the zone->lock as a result.

[yuzhao@google.com: Reported lockdep issue on IO completion from softirq]
Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 mm/page_alloc.c | 122 ++++++++++++++++++++++++--------------------------------
 1 file changed, 53 insertions(+), 69 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index d04211f0ef0b..55feaacfebb1 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -169,21 +169,12 @@ static DEFINE_MUTEX(pcp_batch_high_lock);
 	_ret;								\
 })
 
-#define pcpu_spin_lock_irqsave(type, member, ptr, flags)		\
+#define pcpu_spin_trylock(type, member, ptr)				\
 ({									\
 	type *_ret;							\
 	pcpu_task_pin();						\
 	_ret = this_cpu_ptr(ptr);					\
-	spin_lock_irqsave(&_ret->member, flags);			\
-	_ret;								\
-})
-
-#define pcpu_spin_trylock_irqsave(type, member, ptr, flags)		\
-({									\
-	type *_ret;							\
-	pcpu_task_pin();						\
-	_ret = this_cpu_ptr(ptr);					\
-	if (!spin_trylock_irqsave(&_ret->member, flags)) {		\
+	if (!spin_trylock(&_ret->member)) {				\
 		pcpu_task_unpin();					\
 		_ret = NULL;						\
 	}								\
@@ -196,27 +187,16 @@ static DEFINE_MUTEX(pcp_batch_high_lock);
 	pcpu_task_unpin();						\
 })
 
-#define pcpu_spin_unlock_irqrestore(member, ptr, flags)			\
-({									\
-	spin_unlock_irqrestore(&ptr->member, flags);			\
-	pcpu_task_unpin();						\
-})
-
 /* struct per_cpu_pages specific helpers. */
 #define pcp_spin_lock(ptr)						\
 	pcpu_spin_lock(struct per_cpu_pages, lock, ptr)
 
-#define pcp_spin_lock_irqsave(ptr, flags)				\
-	pcpu_spin_lock_irqsave(struct per_cpu_pages, lock, ptr, flags)
-
-#define pcp_spin_trylock_irqsave(ptr, flags)				\
-	pcpu_spin_trylock_irqsave(struct per_cpu_pages, lock, ptr, flags)
+#define pcp_spin_trylock(ptr)						\
+	pcpu_spin_trylock(struct per_cpu_pages, lock, ptr)
 
 #define pcp_spin_unlock(ptr)						\
 	pcpu_spin_unlock(lock, ptr)
 
-#define pcp_spin_unlock_irqrestore(ptr, flags)				\
-	pcpu_spin_unlock_irqrestore(lock, ptr, flags)
 #ifdef CONFIG_USE_PERCPU_NUMA_NODE_ID
 DEFINE_PER_CPU(int, numa_node);
 EXPORT_PER_CPU_SYMBOL(numa_node);
@@ -1536,6 +1516,7 @@ static void free_pcppages_bulk(struct zone *zone, int count,
 					struct per_cpu_pages *pcp,
 					int pindex)
 {
+	unsigned long flags;
 	int min_pindex = 0;
 	int max_pindex = NR_PCP_LISTS - 1;
 	unsigned int order;
@@ -1551,8 +1532,7 @@ static void free_pcppages_bulk(struct zone *zone, int count,
 	/* Ensure requested pindex is drained first. */
 	pindex = pindex - 1;
 
-	/* Caller must hold IRQ-safe pcp->lock so IRQs are disabled. */
-	spin_lock(&zone->lock);
+	spin_lock_irqsave(&zone->lock, flags);
 	isolated_pageblocks = has_isolate_pageblock(zone);
 
 	while (count > 0) {
@@ -1601,7 +1581,7 @@ static void free_pcppages_bulk(struct zone *zone, int count,
 		} while (count > 0 && !list_empty(list));
 	}
 
-	spin_unlock(&zone->lock);
+	spin_unlock_irqrestore(&zone->lock, flags);
 }
 
 static void free_one_page(struct zone *zone,
@@ -3118,10 +3098,10 @@ static int rmqueue_bulk(struct zone *zone, unsigned int order,
 			unsigned long count, struct list_head *list,
 			int migratetype, unsigned int alloc_flags)
 {
+	unsigned long flags;
 	int i, allocated = 0;
 
-	/* Caller must hold IRQ-safe pcp->lock so IRQs are disabled. */
-	spin_lock(&zone->lock);
+	spin_lock_irqsave(&zone->lock, flags);
 	for (i = 0; i < count; ++i) {
 		struct page *page = __rmqueue(zone, order, migratetype,
 								alloc_flags);
@@ -3155,7 +3135,7 @@ static int rmqueue_bulk(struct zone *zone, unsigned int order,
 	 * pages added to the pcp list.
 	 */
 	__mod_zone_page_state(zone, NR_FREE_PAGES, -(i << order));
-	spin_unlock(&zone->lock);
+	spin_unlock_irqrestore(&zone->lock, flags);
 	return allocated;
 }
 
@@ -3172,16 +3152,9 @@ void drain_zone_pages(struct zone *zone, struct per_cpu_pages *pcp)
 	batch = READ_ONCE(pcp->batch);
 	to_drain = min(pcp->count, batch);
 	if (to_drain > 0) {
-		unsigned long flags;
-
-		/*
-		 * free_pcppages_bulk expects IRQs disabled for zone->lock
-		 * so even though pcp->lock is not intended to be IRQ-safe,
-		 * it's needed in this context.
-		 */
-		spin_lock_irqsave(&pcp->lock, flags);
+		spin_lock(&pcp->lock);
 		free_pcppages_bulk(zone, to_drain, pcp, 0);
-		spin_unlock_irqrestore(&pcp->lock, flags);
+		spin_unlock(&pcp->lock);
 	}
 }
 #endif
@@ -3195,12 +3168,9 @@ static void drain_pages_zone(unsigned int cpu, struct zone *zone)
 
 	pcp = per_cpu_ptr(zone->per_cpu_pageset, cpu);
 	if (pcp->count) {
-		unsigned long flags;
-
-		/* See drain_zone_pages on why this is disabling IRQs */
-		spin_lock_irqsave(&pcp->lock, flags);
+		spin_lock(&pcp->lock);
 		free_pcppages_bulk(zone, pcp->count, pcp, 0);
-		spin_unlock_irqrestore(&pcp->lock, flags);
+		spin_unlock(&pcp->lock);
 	}
 }
 
@@ -3466,7 +3436,6 @@ static void free_unref_page_commit(struct zone *zone, struct per_cpu_pages *pcp,
  */
 void free_unref_page(struct page *page, unsigned int order)
 {
-	unsigned long flags;
 	unsigned long __maybe_unused UP_flags;
 	struct per_cpu_pages *pcp;
 	struct zone *zone;
@@ -3494,10 +3463,10 @@ void free_unref_page(struct page *page, unsigned int order)
 
 	zone = page_zone(page);
 	pcp_trylock_prepare(UP_flags);
-	pcp = pcp_spin_trylock_irqsave(zone->per_cpu_pageset, flags);
+	pcp = pcp_spin_trylock(zone->per_cpu_pageset);
 	if (pcp) {
 		free_unref_page_commit(zone, pcp, page, migratetype, order);
-		pcp_spin_unlock_irqrestore(pcp, flags);
+		pcp_spin_unlock(pcp);
 	} else {
 		free_one_page(zone, page, pfn, order, migratetype, FPI_NONE);
 	}
@@ -3509,10 +3478,10 @@ void free_unref_page(struct page *page, unsigned int order)
  */
 void free_unref_page_list(struct list_head *list)
 {
+	unsigned long __maybe_unused UP_flags;
 	struct page *page, *next;
 	struct per_cpu_pages *pcp = NULL;
 	struct zone *locked_zone = NULL;
-	unsigned long flags;
 	int batch_count = 0;
 	int migratetype;
 
@@ -3541,11 +3510,26 @@ void free_unref_page_list(struct list_head *list)
 
 		/* Different zone, different pcp lock. */
 		if (zone != locked_zone) {
-			if (pcp)
-				pcp_spin_unlock_irqrestore(pcp, flags);
+			if (pcp) {
+				pcp_spin_unlock(pcp);
+				pcp_trylock_finish(UP_flags);
+			}
 
+			/*
+			 * trylock is necessary as pages may be getting freed
+			 * from IRQ or SoftIRQ context after an IO completion.
+			 */
+			pcp_trylock_prepare(UP_flags);
+			pcp = pcp_spin_trylock(zone->per_cpu_pageset);
+			if (!pcp) {
+				pcp_trylock_finish(UP_flags);
+				list_del(&page->lru);
+				free_one_page(page_zone(page), page,
+					      page_to_pfn(page), 0, migratetype,
+					      FPI_NONE);
+				continue;
+			}
 			locked_zone = zone;
-			pcp = pcp_spin_lock_irqsave(locked_zone->per_cpu_pageset, flags);
 		}
 
 		/*
@@ -3560,18 +3544,23 @@ void free_unref_page_list(struct list_head *list)
 		free_unref_page_commit(zone, pcp, page, migratetype, 0);
 
 		/*
-		 * Guard against excessive IRQ disabled times when we get
-		 * a large list of pages to free.
+		 * Guard against excessive IRQ disabled times when freeing
+		 * a large list of pages. Lock will be reacquired if
+		 * necessary on the next iteration.
 		 */
 		if (++batch_count == SWAP_CLUSTER_MAX) {
-			pcp_spin_unlock_irqrestore(pcp, flags);
+			pcp_spin_unlock(pcp);
+			pcp_trylock_finish(UP_flags);
 			batch_count = 0;
-			pcp = pcp_spin_lock_irqsave(locked_zone->per_cpu_pageset, flags);
+			pcp = NULL;
+			locked_zone = NULL;
 		}
 	}
 
-	if (pcp)
-		pcp_spin_unlock_irqrestore(pcp, flags);
+	if (pcp) {
+		pcp_spin_unlock(pcp);
+		pcp_trylock_finish(UP_flags);
+	}
 }
 
 /*
@@ -3783,15 +3772,11 @@ static struct page *rmqueue_pcplist(struct zone *preferred_zone,
 	struct per_cpu_pages *pcp;
 	struct list_head *list;
 	struct page *page;
-	unsigned long flags;
 	unsigned long __maybe_unused UP_flags;
 
-	/*
-	 * spin_trylock may fail due to a parallel drain. In the future, the
-	 * trylock will also protect against IRQ reentrancy.
-	 */
+	/* spin_trylock may fail due to a parallel drain or IRQ reentrancy. */
 	pcp_trylock_prepare(UP_flags);
-	pcp = pcp_spin_trylock_irqsave(zone->per_cpu_pageset, flags);
+	pcp = pcp_spin_trylock(zone->per_cpu_pageset);
 	if (!pcp) {
 		pcp_trylock_finish(UP_flags);
 		return NULL;
@@ -3805,7 +3790,7 @@ static struct page *rmqueue_pcplist(struct zone *preferred_zone,
 	pcp->free_factor >>= 1;
 	list = &pcp->lists[order_to_pindex(migratetype, order)];
 	page = __rmqueue_pcplist(zone, order, migratetype, alloc_flags, pcp, list);
-	pcp_spin_unlock_irqrestore(pcp, flags);
+	pcp_spin_unlock(pcp);
 	pcp_trylock_finish(UP_flags);
 	if (page) {
 		__count_zid_vm_events(PGALLOC, page_zonenum(page), 1);
@@ -5363,7 +5348,6 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
 			struct page **page_array)
 {
 	struct page *page;
-	unsigned long flags;
 	unsigned long __maybe_unused UP_flags;
 	struct zone *zone;
 	struct zoneref *z;
@@ -5445,9 +5429,9 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
 	if (unlikely(!zone))
 		goto failed;
 
-	/* Is a parallel drain in progress? */
+	/* spin_trylock may fail due to a parallel drain or IRQ reentrancy. */
 	pcp_trylock_prepare(UP_flags);
-	pcp = pcp_spin_trylock_irqsave(zone->per_cpu_pageset, flags);
+	pcp = pcp_spin_trylock(zone->per_cpu_pageset);
 	if (!pcp)
 		goto failed_irq;
 
@@ -5466,7 +5450,7 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
 		if (unlikely(!page)) {
 			/* Try and allocate at least one page */
 			if (!nr_account) {
-				pcp_spin_unlock_irqrestore(pcp, flags);
+				pcp_spin_unlock(pcp);
 				goto failed_irq;
 			}
 			break;
@@ -5481,7 +5465,7 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
 		nr_populated++;
 	}
 
-	pcp_spin_unlock_irqrestore(pcp, flags);
+	pcp_spin_unlock(pcp);
 	pcp_trylock_finish(UP_flags);
 
 	__count_zid_vm_events(PGALLOC, zone_idx(zone), nr_account);
