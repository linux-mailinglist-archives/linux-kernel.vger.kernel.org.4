Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 702BE62F255
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 11:17:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241435AbiKRKRz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 05:17:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241526AbiKRKRt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 05:17:49 -0500
Received: from outbound-smtp19.blacknight.com (outbound-smtp19.blacknight.com [46.22.139.246])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95D7C9038B
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 02:17:46 -0800 (PST)
Received: from mail.blacknight.com (pemlinmail03.blacknight.ie [81.17.254.16])
        by outbound-smtp19.blacknight.com (Postfix) with ESMTPS id 4D0D51C456C
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 10:17:45 +0000 (GMT)
Received: (qmail 4454 invoked from network); 18 Nov 2022 10:17:45 -0000
Received: from unknown (HELO morpheus.112glenside.lan) (mgorman@techsingularity.net@[84.203.198.246])
  by 81.17.254.9 with ESMTPA; 18 Nov 2022 10:17:45 -0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Hugh Dickins <hughd@google.com>, Yu Zhao <yuzhao@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 2/2] mm/page_alloc: Leave IRQs enabled for per-cpu page allocations
Date:   Fri, 18 Nov 2022 10:17:14 +0000
Message-Id: <20221118101714.19590-3-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20221118101714.19590-1-mgorman@techsingularity.net>
References: <20221118101714.19590-1-mgorman@techsingularity.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pcp_spin_lock_irqsave protecting the PCP lists is IRQ-safe as a task
allocating from the PCP must not re-enter the allocator from IRQ context.
In each instance where IRQ-reentrancy is possible, the lock is acquired
using pcp_spin_trylock_irqsave() even though IRQs are disabled and
re-entrancy is impossible.

Demote the lock to pcp_spin_lock avoids an IRQ disable/enable in the common
case at the cost of some IRQ allocations taking a slower path. If the PCP
lists need to be refilled, the zone lock still needs to disable IRQs but
that will only happen on PCP refill and drain. If an IRQ is raised when
a PCP allocation is in progress, the trylock will fail and fallback to
using the buddy lists directly. Note that this may not be a universal win
if an interrupt-intensive workload also allocates heavily from interrupt
context and contends heavily on the zone->lock as a result.

[yuzhao@google.com: Reported lockdep issue on IO completion from softirq]
[hughd@google.com: Fix list corruption, lock improvements, micro-optimsations]
Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 mm/page_alloc.c | 122 +++++++++++++++++++++---------------------------
 1 file changed, 53 insertions(+), 69 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 1ec54173b8d4..323fec05c4c6 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -170,21 +170,12 @@ static DEFINE_MUTEX(pcp_batch_high_lock);
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
@@ -197,27 +188,16 @@ static DEFINE_MUTEX(pcp_batch_high_lock);
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
@@ -1547,6 +1527,7 @@ static void free_pcppages_bulk(struct zone *zone, int count,
 					struct per_cpu_pages *pcp,
 					int pindex)
 {
+	unsigned long flags;
 	int min_pindex = 0;
 	int max_pindex = NR_PCP_LISTS - 1;
 	unsigned int order;
@@ -1562,8 +1543,7 @@ static void free_pcppages_bulk(struct zone *zone, int count,
 	/* Ensure requested pindex is drained first. */
 	pindex = pindex - 1;
 
-	/* Caller must hold IRQ-safe pcp->lock so IRQs are disabled. */
-	spin_lock(&zone->lock);
+	spin_lock_irqsave(&zone->lock, flags);
 	isolated_pageblocks = has_isolate_pageblock(zone);
 
 	while (count > 0) {
@@ -1611,7 +1591,7 @@ static void free_pcppages_bulk(struct zone *zone, int count,
 		} while (count > 0 && !list_empty(list));
 	}
 
-	spin_unlock(&zone->lock);
+	spin_unlock_irqrestore(&zone->lock, flags);
 }
 
 static void free_one_page(struct zone *zone,
@@ -3125,10 +3105,10 @@ static int rmqueue_bulk(struct zone *zone, unsigned int order,
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
@@ -3162,7 +3142,7 @@ static int rmqueue_bulk(struct zone *zone, unsigned int order,
 	 * pages added to the pcp list.
 	 */
 	__mod_zone_page_state(zone, NR_FREE_PAGES, -(i << order));
-	spin_unlock(&zone->lock);
+	spin_unlock_irqrestore(&zone->lock, flags);
 	return allocated;
 }
 
@@ -3179,16 +3159,9 @@ void drain_zone_pages(struct zone *zone, struct per_cpu_pages *pcp)
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
@@ -3202,12 +3175,9 @@ static void drain_pages_zone(unsigned int cpu, struct zone *zone)
 
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
 
@@ -3473,7 +3443,6 @@ static void free_unref_page_commit(struct zone *zone, struct per_cpu_pages *pcp,
  */
 void free_unref_page(struct page *page, unsigned int order)
 {
-	unsigned long flags;
 	unsigned long __maybe_unused UP_flags;
 	struct per_cpu_pages *pcp;
 	struct zone *zone;
@@ -3501,10 +3470,10 @@ void free_unref_page(struct page *page, unsigned int order)
 
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
@@ -3516,10 +3485,10 @@ void free_unref_page(struct page *page, unsigned int order)
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
 
@@ -3550,11 +3519,26 @@ void free_unref_page_list(struct list_head *list)
 
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
+				free_one_page(zone, page, page_to_pfn(page),
+					      0, migratetype, FPI_NONE);
+				locked_zone = NULL;
+				continue;
+			}
 			locked_zone = zone;
-			pcp = pcp_spin_lock_irqsave(locked_zone->per_cpu_pageset, flags);
+			batch_count = 0;
 		}
 
 		/*
@@ -3569,18 +3553,23 @@ void free_unref_page_list(struct list_head *list)
 		free_unref_page_commit(zone, pcp, page, migratetype, 0);
 
 		/*
-		 * Guard against excessive IRQ disabled times when we get
-		 * a large list of pages to free.
+		 * Guard against excessive lock hold times when freeing
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
@@ -3781,15 +3770,11 @@ static struct page *rmqueue_pcplist(struct zone *preferred_zone,
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
@@ -3803,7 +3788,7 @@ static struct page *rmqueue_pcplist(struct zone *preferred_zone,
 	pcp->free_factor >>= 1;
 	list = &pcp->lists[order_to_pindex(migratetype, order)];
 	page = __rmqueue_pcplist(zone, order, migratetype, alloc_flags, pcp, list);
-	pcp_spin_unlock_irqrestore(pcp, flags);
+	pcp_spin_unlock(pcp);
 	pcp_trylock_finish(UP_flags);
 	if (page) {
 		__count_zid_vm_events(PGALLOC, page_zonenum(page), 1 << order);
@@ -5371,7 +5356,6 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
 			struct page **page_array)
 {
 	struct page *page;
-	unsigned long flags;
 	unsigned long __maybe_unused UP_flags;
 	struct zone *zone;
 	struct zoneref *z;
@@ -5453,9 +5437,9 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
 	if (unlikely(!zone))
 		goto failed;
 
-	/* Is a parallel drain in progress? */
+	/* spin_trylock may fail due to a parallel drain or IRQ reentrancy. */
 	pcp_trylock_prepare(UP_flags);
-	pcp = pcp_spin_trylock_irqsave(zone->per_cpu_pageset, flags);
+	pcp = pcp_spin_trylock(zone->per_cpu_pageset);
 	if (!pcp)
 		goto failed_irq;
 
@@ -5474,7 +5458,7 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
 		if (unlikely(!page)) {
 			/* Try and allocate at least one page */
 			if (!nr_account) {
-				pcp_spin_unlock_irqrestore(pcp, flags);
+				pcp_spin_unlock(pcp);
 				goto failed_irq;
 			}
 			break;
@@ -5489,7 +5473,7 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
 		nr_populated++;
 	}
 
-	pcp_spin_unlock_irqrestore(pcp, flags);
+	pcp_spin_unlock(pcp);
 	pcp_trylock_finish(UP_flags);
 
 	__count_zid_vm_events(PGALLOC, zone_idx(zone), nr_account);
-- 
2.35.3

