Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6DC66E6CD9
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 21:15:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232840AbjDRTP2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 15:15:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232894AbjDRTOH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 15:14:07 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57E76B74E
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 12:13:45 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id e13so12950925qvd.8
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 12:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20221208.gappssmtp.com; s=20221208; t=1681845225; x=1684437225;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xFydGPrrlcR5ue8H0k4/5BgZKiD2zceF6yJIdiDg/e0=;
        b=tVrrto59kTHt+5P8OO0NTl96kO6fYFXftlF9A3CAuw7mkP6vDPrG6Y7lZfcyBzps7q
         /gMDUjmhruC6JAgv2lNt70nZGvgEKZPuKRjT85XlnbmpS0gHScOiwvV0CeKGtkebfUO5
         GuRu2B/dbtgriKFhkU+bqrvVfqiYW8ac4FZqca9W6ySikMkgizqrdHAjbR5vdbcQrVed
         qXeZWHFuDKk0K/VtTx0r2tcS0PQ0RyfZX+iVchXZvObxU+M15TeBNYCSjPyOC7INUTz4
         z7Q+PUSdqHdSQo5iQxaxwIudluosvB0gAAvUePxiBSpUWodkFxlz3QjRjOpnT/xEQ3i/
         lkaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681845225; x=1684437225;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xFydGPrrlcR5ue8H0k4/5BgZKiD2zceF6yJIdiDg/e0=;
        b=YvWK3xjf4VoWOC9RWW7es9YiZHuRb3uq88I6vug7YwHKkLt7hzfN76GEh/5dyZ6TuU
         ZJrEI84kXqxHnJiQQXzKrSg1V0sg/rIj/+Ux5dk1n1+a/XpG/Geh9J3y585oUE2OkjZm
         e9lNZuncfYzLco2vOr1+qFgbetXWePgW02AAQdm92Wp6eMNWeWgPK1zfySiOVOWVGY9+
         aFet7bgdfN4thBXzGapZIqZn03NuqFUnGW9O2R8fwfnD5GE8bH9JTGhSN68W2W/LvL9Z
         Nk1e+ebk5hZQV1ssr2w6YrnZwMa0Y/BnXnsS/Jrd0lnFcrcx9RdO7BrF3Z9P2UcpGhgW
         0gFQ==
X-Gm-Message-State: AAQBX9fdEIfiZkNNC9gi4vPE6oprXg6ALaT3FpGKN2BK4gQU1lucbXDc
        HvE0Jhhs5ghjIfXr4DOfMNai+3Oy7GUlIh/vuzk=
X-Google-Smtp-Source: AKy350aY/eDWP5VAtiKzy0kcSE6ktwznpTC01RhU2t2EYa7ev5AWfpSsbruwvnwNAwe0Wpm5J/BisA==
X-Received: by 2002:ad4:5b8b:0:b0:570:ccb9:a4d0 with SMTP id 11-20020ad45b8b000000b00570ccb9a4d0mr20299103qvp.16.1681845224818;
        Tue, 18 Apr 2023 12:13:44 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:e646])
        by smtp.gmail.com with ESMTPSA id pp26-20020a056214139a00b005dd8b934571sm3935790qvb.9.2023.04.18.12.13.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 12:13:44 -0700 (PDT)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     linux-mm@kvack.org
Cc:     Kaiyang Zhao <kaiyang2@cs.cmu.edu>,
        Mel Gorman <mgorman@techsingularity.net>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Rientjes <rientjes@google.com>,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: [RFC PATCH 22/26] mm: page_alloc: manage free memory in whole pageblocks
Date:   Tue, 18 Apr 2023 15:13:09 -0400
Message-Id: <20230418191313.268131-23-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230418191313.268131-1-hannes@cmpxchg.org>
References: <20230418191313.268131-1-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Right now, allocation requests only reclaim (and compact) for their
exact order. Since the majority of allocation requests are smaller
than a pageblock, this is likely to result in partial blocks being
freed, which are subsequently fragmented by fallbacks. This defeats
the allocator's efforts to group pageblocks by mobility.

Fix this mismatch between the allocator and reclaim/compaction: make
the pageblock the default unit for free memory by enforcing watermarks
against MIGRATE_FREE blocks, and have reclaim/compaction produce them.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 include/linux/compaction.h |   1 -
 mm/compaction.c            |  65 ++++---------
 mm/internal.h              |   1 +
 mm/page_alloc.c            | 183 ++++++++++++++++++++++---------------
 mm/vmscan.c                |   6 +-
 5 files changed, 131 insertions(+), 125 deletions(-)

diff --git a/include/linux/compaction.h b/include/linux/compaction.h
index 9e1b2c56df62..52b2487ef901 100644
--- a/include/linux/compaction.h
+++ b/include/linux/compaction.h
@@ -10,7 +10,6 @@ enum compact_priority {
 	COMPACT_PRIO_SYNC_FULL,
 	MIN_COMPACT_PRIORITY = COMPACT_PRIO_SYNC_FULL,
 	COMPACT_PRIO_SYNC_LIGHT,
-	MIN_COMPACT_COSTLY_PRIORITY = COMPACT_PRIO_SYNC_LIGHT,
 	DEF_COMPACT_PRIORITY = COMPACT_PRIO_SYNC_LIGHT,
 	COMPACT_PRIO_ASYNC,
 	INIT_COMPACT_PRIORITY = COMPACT_PRIO_ASYNC
diff --git a/mm/compaction.c b/mm/compaction.c
index 8080c04e644a..e33c99eb34a8 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -1784,15 +1784,6 @@ static unsigned long fast_find_migrateblock(struct compact_control *cc)
 	if (cc->order <= PAGE_ALLOC_COSTLY_ORDER)
 		return pfn;
 
-	/*
-	 * Only allow kcompactd and direct requests for movable pages to
-	 * quickly clear out a MOVABLE pageblock for allocation. This
-	 * reduces the risk that a large movable pageblock is freed for
-	 * an unmovable/reclaimable small allocation.
-	 */
-	if (cc->direct_compaction && cc->migratetype != MIGRATE_MOVABLE)
-		return pfn;
-
 	/*
 	 * When starting the migration scanner, pick any pageblock within the
 	 * first half of the search space. Otherwise try and pick a pageblock
@@ -2065,8 +2056,7 @@ static bool should_proactive_compact_node(pg_data_t *pgdat)
 
 static enum compact_result __compact_finished(struct compact_control *cc)
 {
-	unsigned int order;
-	const int migratetype = cc->migratetype;
+	unsigned long mark;
 	int ret;
 
 	/* Compaction run completes if the migrate and free scanner meet */
@@ -2120,39 +2110,16 @@ static enum compact_result __compact_finished(struct compact_control *cc)
 	if (!pageblock_aligned(cc->migrate_pfn))
 		return COMPACT_CONTINUE;
 
-	/* Direct compactor: Is a suitable page free? */
+	/* Done when watermarks are restored */
 	ret = COMPACT_NO_SUITABLE_PAGE;
-	for (order = cc->order; order < MAX_ORDER; order++) {
-		struct free_area *area = &cc->zone->free_area[order];
-		bool can_steal;
-
-		/* Job done if page is free of the right migratetype */
-		if (!free_area_empty(area, migratetype))
-			return COMPACT_SUCCESS;
-
-#ifdef CONFIG_CMA
-		/* MIGRATE_MOVABLE can fallback on MIGRATE_CMA */
-		if (migratetype == MIGRATE_MOVABLE &&
-			!free_area_empty(area, MIGRATE_CMA))
-			return COMPACT_SUCCESS;
-#endif
-		/*
-		 * Job done if allocation would steal freepages from
-		 * other migratetype buddy lists.
-		 */
-		if (find_suitable_fallback(area, order, migratetype,
-						true, &can_steal) != -1)
-			/*
-			 * Movable pages are OK in any pageblock. If we are
-			 * stealing for a non-movable allocation, make sure
-			 * we finish compacting the current pageblock first
-			 * (which is assured by the above migrate_pfn align
-			 * check) so it is as free as possible and we won't
-			 * have to steal another one soon.
-			 */
-			return COMPACT_SUCCESS;
-	}
-
+	if (cc->direct_compaction)
+		mark = wmark_pages(cc->zone,
+				   cc->alloc_flags & ALLOC_WMARK_MASK);
+	else
+		mark = high_wmark_pages(cc->zone);
+	if (zone_watermark_ok(cc->zone, cc->order, mark,
+			      cc->highest_zoneidx, cc->alloc_flags))
+		return COMPACT_SUCCESS;
 out:
 	if (cc->contended || fatal_signal_pending(current))
 		ret = COMPACT_CONTENDED;
@@ -2310,8 +2277,12 @@ compact_zone(struct compact_control *cc, struct capture_control *capc)
 		unsigned long watermark;
 
 		/* Allocation can already succeed, nothing to do */
-		watermark = wmark_pages(cc->zone,
-					cc->alloc_flags & ALLOC_WMARK_MASK);
+		if (cc->direct_compaction)
+			watermark = wmark_pages(cc->zone,
+						cc->alloc_flags &
+						ALLOC_WMARK_MASK);
+		else
+			watermark = high_wmark_pages(cc->zone);
 		if (zone_watermark_ok(cc->zone, cc->order, watermark,
 				      cc->highest_zoneidx, cc->alloc_flags))
 			return COMPACT_SUCCESS;
@@ -2800,7 +2771,7 @@ static bool kcompactd_node_suitable(pg_data_t *pgdat)
 
 		/* Allocation can succeed in any zone, done */
 		if (zone_watermark_ok(zone, pgdat->kcompactd_max_order,
-				      min_wmark_pages(zone),
+				      high_wmark_pages(zone),
 				      highest_zoneidx, 0))
 			return true;
 
@@ -2845,7 +2816,7 @@ static void kcompactd_do_work(pg_data_t *pgdat)
 
 		/* Allocation can already succeed, nothing to do */
 		if (zone_watermark_ok(zone, cc.order,
-				      min_wmark_pages(zone), zoneid, 0))
+				      high_wmark_pages(zone), zoneid, 0))
 			continue;
 
 		if (compaction_suitable(zone, cc.order,
diff --git a/mm/internal.h b/mm/internal.h
index 39f65a463631..5c76455f8042 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -432,6 +432,7 @@ struct compact_control {
  */
 struct capture_control {
 	struct compact_control *cc;
+	int order;
 	int migratetype;
 	struct page *page;
 };
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 18fa2bbba44b..6f0bfc226c36 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1075,7 +1075,7 @@ static inline bool
 compaction_capture(struct zone *zone, struct page *page, int order,
 		   int migratetype, struct capture_control *capc)
 {
-	if (!capc || order < capc->cc->order)
+	if (!capc || order < capc->order)
 		return false;
 
 	/* Do not accidentally pollute CMA or isolated regions*/
@@ -1097,8 +1097,8 @@ compaction_capture(struct zone *zone, struct page *page, int order,
 		return false;
 	}
 
-	if (order > capc->cc->order)
-		expand(zone, page, capc->cc->order, order, migratetype);
+	if (order > capc->order)
+		expand(zone, page, capc->order, order, migratetype);
 
 	capc->page = page;
 	return true;
@@ -3649,15 +3649,15 @@ int __isolate_free_page(struct page *page, unsigned int order)
 	int mt = get_pageblock_migratetype(page);
 
 	if (!is_migrate_isolate(mt)) {
+		long free_pages = zone_page_state(zone, NR_FREE_PAGES);
 		unsigned long watermark;
 		/*
-		 * Obey watermarks as if the page was being allocated. We can
-		 * emulate a high-order watermark check with a raised order-0
-		 * watermark, because we already know our high-order page
-		 * exists.
+		 * Keep a lid on concurrent compaction. MIGRATE_FREE
+		 * watermarks alone cannot be checked here, because
+		 * that's what the caller is trying to produce.
 		 */
 		watermark = zone->_watermark[WMARK_MIN] + (1UL << order);
-		if (!zone_watermark_ok(zone, 0, watermark, 0, ALLOC_CMA))
+		if (!__zone_watermark_ok(zone, 0, watermark, 0, ALLOC_CMA, free_pages))
 			return 0;
 	}
 
@@ -3976,27 +3976,59 @@ noinline bool should_fail_alloc_page(gfp_t gfp_mask, unsigned int order)
 }
 ALLOW_ERROR_INJECTION(should_fail_alloc_page, TRUE);
 
-static inline long __zone_watermark_unusable_free(struct zone *z,
-				unsigned int order, unsigned int alloc_flags)
+static long page_state(struct zone *zone, enum zone_stat_item item, bool safe)
 {
-	const bool alloc_harder = (alloc_flags & (ALLOC_HARDER|ALLOC_OOM));
-	long unusable_free = (1 << order) - 1;
+	if (safe)
+		return zone_page_state_snapshot(zone, item);
+	else
+		return zone_page_state(zone, item);
+}
+
+static long __zone_free_pages(struct zone *zone, int alloc_flags, bool safe)
+{
+	long free_pages;
 
 	/*
-	 * If the caller does not have rights to ALLOC_HARDER then subtract
-	 * the high-atomic reserves. This will over-estimate the size of the
-	 * atomic reserve but it avoids a search.
+	 * Enforce watermarks against MIGRATE_FREE pages. This ensures
+	 * that there is always a reserve of higher-order pages
+	 * maintained for all migratetypes and allocation contexts.
+	 *
+	 * Allocations will still use up any compatible free pages
+	 * that may exist inside claimed blocks first. But the reserve
+	 * prevents smaller allocations from starving out higher-order
+	 * requests (which may not be able to sleep, e.g. highatomic).
+	 *
+	 * The additional memory requirements of this are mininmal. If
+	 * internal free pages already exceed the compact_gap(), only
+	 * compaction is necessary to restore the watermarks.
 	 */
-	if (likely(!alloc_harder))
-		unusable_free += z->nr_reserved_highatomic;
+	free_pages = page_state(zone, NR_FREE_FREE, safe);
+	if (alloc_flags & (ALLOC_HARDER | ALLOC_OOM))
+		free_pages += page_state(zone, NR_FREE_HIGHATOMIC, safe);
+	if (IS_ENABLED(CONFIG_CMA) && (alloc_flags & ALLOC_CMA))
+		free_pages += page_state(zone, NR_FREE_CMA_PAGES, safe);
 
-#ifdef CONFIG_CMA
-	/* If allocation can't use CMA areas don't use free CMA pages */
-	if (!(alloc_flags & ALLOC_CMA))
-		unusable_free += zone_page_state(z, NR_FREE_CMA_PAGES);
-#endif
+	if (!IS_ENABLED(CONFIG_COMPACTION)) {
+		/*
+		 * We can't reasonably defragment without compaction.
+		 * Consider everything and do best-effort grouping.
+		 */
+		free_pages += page_state(zone, NR_FREE_UNMOVABLE, safe);
+		free_pages += page_state(zone, NR_FREE_MOVABLE, safe);
+		free_pages += page_state(zone, NR_FREE_RECLAIMABLE, safe);
+	}
 
-	return unusable_free;
+	return free_pages;
+}
+
+static long zone_free_pages(struct zone *zone, int alloc_flags)
+{
+	return __zone_free_pages(zone, alloc_flags, false);
+}
+
+static long zone_free_pages_safe(struct zone *zone, int alloc_flags)
+{
+	return __zone_free_pages(zone, alloc_flags, true);
 }
 
 /*
@@ -4014,7 +4046,7 @@ bool __zone_watermark_ok(struct zone *z, unsigned int order, unsigned long mark,
 	const bool alloc_harder = (alloc_flags & (ALLOC_HARDER|ALLOC_OOM));
 
 	/* free_pages may go negative - that's OK */
-	free_pages -= __zone_watermark_unusable_free(z, order, alloc_flags);
+	free_pages -= (1 << order) - 1;
 
 	if (alloc_flags & ALLOC_HIGH)
 		min -= min / 2;
@@ -4076,33 +4108,22 @@ bool zone_watermark_ok(struct zone *z, unsigned int order, unsigned long mark,
 		      int highest_zoneidx, unsigned int alloc_flags)
 {
 	return __zone_watermark_ok(z, order, mark, highest_zoneidx, alloc_flags,
-					zone_page_state(z, NR_FREE_PAGES));
+				   zone_free_pages(z, alloc_flags));
 }
 
 static inline bool zone_watermark_fast(struct zone *z, unsigned int order,
 				unsigned long mark, int highest_zoneidx,
 				unsigned int alloc_flags, gfp_t gfp_mask)
 {
-	long free_pages;
-
-	free_pages = zone_page_state(z, NR_FREE_PAGES);
+	long free_pages = zone_free_pages(z, alloc_flags);
 
 	/*
 	 * Fast check for order-0 only. If this fails then the reserves
 	 * need to be calculated.
 	 */
-	if (!order) {
-		long usable_free;
-		long reserved;
-
-		usable_free = free_pages;
-		reserved = __zone_watermark_unusable_free(z, 0, alloc_flags);
-
-		/* reserved may over estimate high-atomic reserves. */
-		usable_free -= min(usable_free, reserved);
-		if (usable_free > mark + z->lowmem_reserve[highest_zoneidx])
-			return true;
-	}
+	if (!order && (free_pages - ((1 << order) - 1) >
+		       mark + z->lowmem_reserve[highest_zoneidx]))
+		return true;
 
 	if (__zone_watermark_ok(z, order, mark, highest_zoneidx, alloc_flags,
 					free_pages))
@@ -4126,13 +4147,8 @@ static inline bool zone_watermark_fast(struct zone *z, unsigned int order,
 bool zone_watermark_ok_safe(struct zone *z, unsigned int order,
 			unsigned long mark, int highest_zoneidx)
 {
-	long free_pages = zone_page_state(z, NR_FREE_PAGES);
-
-	if (z->percpu_drift_mark && free_pages < z->percpu_drift_mark)
-		free_pages = zone_page_state_snapshot(z, NR_FREE_PAGES);
-
 	return __zone_watermark_ok(z, order, mark, highest_zoneidx, 0,
-								free_pages);
+				   zone_free_pages_safe(z, 0));
 }
 
 #ifdef CONFIG_NUMA
@@ -4524,12 +4540,14 @@ __alloc_pages_direct_compact(gfp_t gfp_mask, unsigned int order,
 	unsigned long pflags;
 	unsigned int noreclaim_flag;
 	struct capture_control capc = {
+		.order = order,
 		.migratetype = ac->migratetype,
 		.page = NULL,
 	};
+	int compact_order;
 
-	if (!order)
-		return NULL;
+	/* Use reclaim/compaction to produce neutral blocks */
+	compact_order = max_t(int, order, pageblock_order);
 
 	/*
 	 * Make sure the structs are really initialized before we expose the
@@ -4543,8 +4561,8 @@ __alloc_pages_direct_compact(gfp_t gfp_mask, unsigned int order,
 	delayacct_compact_start();
 	noreclaim_flag = memalloc_noreclaim_save();
 
-	*compact_result = try_to_compact_pages(gfp_mask, order, alloc_flags, ac,
-					       prio, &capc);
+	*compact_result = try_to_compact_pages(gfp_mask, compact_order,
+					       alloc_flags, ac, prio, &capc);
 
 	memalloc_noreclaim_restore(noreclaim_flag);
 	psi_memstall_leave(&pflags);
@@ -4608,13 +4626,12 @@ should_compact_retry(struct alloc_context *ac, int order, int alloc_flags,
 		     enum compact_priority *compact_priority,
 		     int *compaction_retries)
 {
-	int min_priority;
 	bool ret = false;
 	int retries = *compaction_retries;
 	enum compact_priority priority = *compact_priority;
 
-	if (!order)
-		return false;
+	/* Use reclaim/compaction to produce neutral blocks */
+	order = max_t(int, order, pageblock_order);
 
 	if (fatal_signal_pending(current))
 		return false;
@@ -4624,20 +4641,6 @@ should_compact_retry(struct alloc_context *ac, int order, int alloc_flags,
 	 * failed, presumably due to a race. Retry a few times.
 	 */
 	if (compact_result == COMPACT_SUCCESS) {
-		int max_retries = MAX_COMPACT_RETRIES;
-
-		/*
-		 * !costly requests are much more important than
-		 * __GFP_RETRY_MAYFAIL costly ones because they are de
-		 * facto nofail and invoke OOM killer to move on while
-		 * costly can fail and users are ready to cope with
-		 * that. 1/4 retries is rather arbitrary but we would
-		 * need much more detailed feedback from compaction to
-		 * make a better decision.
-		 */
-		if (order > PAGE_ALLOC_COSTLY_ORDER)
-			max_retries /= 4;
-
 		ret = ++(*compaction_retries) <= MAX_COMPACT_RETRIES;
 		goto out;
 	}
@@ -4654,16 +4657,13 @@ should_compact_retry(struct alloc_context *ac, int order, int alloc_flags,
 	/*
 	 * Compaction failed. Retry with increasing priority.
 	 */
-	min_priority = (order > PAGE_ALLOC_COSTLY_ORDER) ?
-			MIN_COMPACT_COSTLY_PRIORITY : MIN_COMPACT_PRIORITY;
-
-	if (*compact_priority > min_priority) {
+	if (*compact_priority > MIN_COMPACT_PRIORITY) {
 		(*compact_priority)--;
 		*compaction_retries = 0;
 		ret = true;
 	}
 out:
-	trace_compact_retry(order, priority, compact_result, retries, max_retries, ret);
+	trace_compact_retry(order, priority, compact_result, retries, MAX_COMPACT_RETRIES, ret);
 	return ret;
 }
 #else
@@ -4822,9 +4822,16 @@ __alloc_pages_direct_reclaim(gfp_t gfp_mask, unsigned int order,
 	struct page *page = NULL;
 	unsigned long pflags;
 	bool drained = false;
+	int reclaim_order;
+
+	/* Use reclaim/compaction to produce neutral blocks */
+	if (IS_ENABLED(CONFIG_COMPACTION))
+		reclaim_order = max_t(int, order, pageblock_order);
+	else
+		reclaim_order = order;
 
 	psi_memstall_enter(&pflags);
-	*did_some_progress = __perform_reclaim(gfp_mask, order, ac);
+	*did_some_progress = __perform_reclaim(gfp_mask, reclaim_order, ac);
 	if (unlikely(!(*did_some_progress)))
 		goto out;
 
@@ -4856,6 +4863,10 @@ static void wake_all_kswapds(unsigned int order, gfp_t gfp_mask,
 	pg_data_t *last_pgdat = NULL;
 	enum zone_type highest_zoneidx = ac->highest_zoneidx;
 
+	/* Use reclaim/compaction to produce neutral blocks */
+	if (IS_ENABLED(CONFIG_COMPACTION))
+		order = max_t(unsigned int, order, pageblock_order);
+
 	for_each_zone_zonelist_nodemask(zone, z, ac->zonelist, highest_zoneidx,
 					ac->nodemask) {
 		if (!managed_zone(zone))
@@ -4970,6 +4981,24 @@ should_reclaim_retry(gfp_t gfp_mask, unsigned order,
 	struct zoneref *z;
 	bool ret = false;
 
+	/*
+	 * In the old world, order-0 pages only need reclaim, and
+	 * higher orders might be present but the order-0 watermarks
+	 * aren't met yet. These things can be fixed by reclaim alone.
+	 *
+	 * In the new world, though, watermark checks are against
+	 * MIGRATE_FREE blocks. That means if the watermarks aren't
+	 * met, reclaim isn't going to be the solution. Neither for
+	 * order-0 nor for anything else. Whether it makes sense to
+	 * retry depends fully on whether compaction should retry.
+	 *
+	 * should_compact_retry() already checks for COMPACT_SKIPPED
+	 * and compaction_zonelist_suitable() to test whether reclaim
+	 * is needed.
+	 */
+	if (IS_ENABLED(CONFIG_COMPACTION))
+		goto schedule;
+
 	/*
 	 * Costly allocations might have made a progress but this doesn't mean
 	 * their order will become available due to high fragmentation so
@@ -5019,6 +5048,7 @@ should_reclaim_retry(gfp_t gfp_mask, unsigned order,
 		}
 	}
 
+schedule:
 	/*
 	 * Memory allocation/reclaim might be called from a WQ context and the
 	 * current implementation of the WQ concurrency control doesn't
@@ -8833,6 +8863,13 @@ static void __setup_per_zone_wmarks(void)
 			    mult_frac(zone_managed_pages(zone),
 				      watermark_scale_factor, 10000));
 
+		/*
+		 * Ensure the watermark delta is a multiple of the
+		 * neutral block that reclaim/compaction produces.
+		 */
+		if (IS_ENABLED(CONFIG_COMPACTION))
+			tmp = ALIGN(tmp, 1 << pageblock_order);
+
 		zone->watermark_boost = 0;
 		zone->_watermark[WMARK_LOW]  = min_wmark_pages(zone) + tmp;
 		zone->_watermark[WMARK_HIGH] = low_wmark_pages(zone) + tmp;
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 14d6116384cc..a7374cd6fe91 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -7438,8 +7438,7 @@ void wakeup_kswapd(struct zone *zone, gfp_t gfp_flags, int order,
 
 	/* Hopeless node, leave it to direct reclaim if possible */
 	if (pgdat->kswapd_failures >= MAX_RECLAIM_RETRIES ||
-	    (pgdat_balanced(pgdat, order, highest_zoneidx) &&
-	     !pgdat_watermark_boosted(pgdat, highest_zoneidx))) {
+	    pgdat_balanced(pgdat, order, highest_zoneidx)) {
 		/*
 		 * There may be plenty of free memory available, but it's too
 		 * fragmented for high-order allocations.  Wake up kcompactd
@@ -7447,8 +7446,7 @@ void wakeup_kswapd(struct zone *zone, gfp_t gfp_flags, int order,
 		 * needed.  If it fails, it will defer subsequent attempts to
 		 * ratelimit its work.
 		 */
-		if (!(gfp_flags & __GFP_DIRECT_RECLAIM))
-			wakeup_kcompactd(pgdat, order, highest_zoneidx);
+		wakeup_kcompactd(pgdat, order, highest_zoneidx);
 		return;
 	}
 
-- 
2.39.2

