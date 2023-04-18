Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E8B46E6CDA
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 21:15:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232241AbjDRTPK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 15:15:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232902AbjDRTOI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 15:14:08 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0951BB85
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 12:13:46 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id op30so18259762qvb.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 12:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20221208.gappssmtp.com; s=20221208; t=1681845226; x=1684437226;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+cRr9qK9Ai5PrhDW9GBX61DMQfs8tenll5tn8q6xhSs=;
        b=wmmelD/et9ZFdJKWhHdBu3DZw0uP+uxtuqLIKxl7QWQ1gLIf0x4Dl4qBY5A5PexoJr
         OhMqGiuUdTE3V0nKLvSyHZAoIjUGav09Njn4JLlk8e/qdWSaEO8AbhxXtKfhN9YvxCXg
         l0z11YLxPSDIF42CiCn8RarJvNYgRQLIQ2zqvd+pz+X9iu9cWQQc/1+jMyxJFIG9sCWT
         OLKvnFIUidWTWQ+1Jb0/Pu2fD7pUcAOpyiK/lAooYzOXHFLzWNIhXh6zDBh53/UdDun2
         oq1Tk9nVl3BXreuO2iAOhtOPWohJqF8SUU3eIRYB0cpXOnSCLJoCqIqVgvyWWmUEwzmF
         gGiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681845226; x=1684437226;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+cRr9qK9Ai5PrhDW9GBX61DMQfs8tenll5tn8q6xhSs=;
        b=VcLZkeRPj+pv/9o69wqLZvj8pL76AykOTG0AFwCNyA6NlSR51cl+Ya2J7A2A3ogV6M
         k5mSftB28xNd93Rxgs/hPoCDi4MCDmlUiZtTsiDa2JY7Q73XOjfA3ZpgNiGOCO21glXg
         RA9WnQqe8E2k/QG5qfm5WddIkUcY9yXJE6hqu9wRHin5N4SWhypU7VDc5VmMlvS4NPiD
         9a3w2WWHwkwxJmZdxCYTHwuJxFqAlQQxs/qUDCQ8JLjgLpe4d4ZZqxZEPiF5GpcsW8Hu
         bSY4B/s4aXjn1XNKFwi6pxYH9WYOBf1xcIFMP8uqKxm6Qz+d2vce8pmLWfaUl+9AZy2r
         9WyA==
X-Gm-Message-State: AAQBX9eTxcTm6jWYxsDCZxHUKx3xeDLvuMlyipatTAiUBiTVOD8s+s2j
        +l7KwbqUAi+bmmaEnw8Ns0o29A==
X-Google-Smtp-Source: AKy350bbq+tUiFNnGALyl/LWu3vvTMgXSZpDDXIn0FD09vHJTVesFePd2LgKVoVwrtg0UDf72P1fJA==
X-Received: by 2002:a05:6214:21c8:b0:5f1:5f73:aed4 with SMTP id d8-20020a05621421c800b005f15f73aed4mr4057561qvh.15.1681845225932;
        Tue, 18 Apr 2023 12:13:45 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:e646])
        by smtp.gmail.com with ESMTPSA id lu8-20020a0562145a0800b005eab96abc9esm3844744qvb.140.2023.04.18.12.13.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 12:13:45 -0700 (PDT)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     linux-mm@kvack.org
Cc:     Kaiyang Zhao <kaiyang2@cs.cmu.edu>,
        Mel Gorman <mgorman@techsingularity.net>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Rientjes <rientjes@google.com>,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: [RFC PATCH 23/26] mm: page_alloc: kill highatomic
Date:   Tue, 18 Apr 2023 15:13:10 -0400
Message-Id: <20230418191313.268131-24-hannes@cmpxchg.org>
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

The highatomic reserves are blocks set aside specifically for
higher-order atomic allocations. Since watermarks are now required to
be met in pageblocks, this is no longer necessary.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 include/linux/gfp.h    |   2 -
 include/linux/mmzone.h |   6 +-
 mm/internal.h          |   5 --
 mm/page_alloc.c        | 187 ++---------------------------------------
 mm/vmstat.c            |   1 -
 5 files changed, 10 insertions(+), 191 deletions(-)

diff --git a/include/linux/gfp.h b/include/linux/gfp.h
index 65a78773dcca..78b5176d354e 100644
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -19,8 +19,6 @@ static inline int gfp_migratetype(const gfp_t gfp_flags)
 	BUILD_BUG_ON((1UL << GFP_MOVABLE_SHIFT) != ___GFP_MOVABLE);
 	BUILD_BUG_ON((___GFP_MOVABLE >> GFP_MOVABLE_SHIFT) != MIGRATE_MOVABLE);
 	BUILD_BUG_ON((___GFP_RECLAIMABLE >> GFP_MOVABLE_SHIFT) != MIGRATE_RECLAIMABLE);
-	BUILD_BUG_ON(((___GFP_MOVABLE | ___GFP_RECLAIMABLE) >>
-		      GFP_MOVABLE_SHIFT) != MIGRATE_HIGHATOMIC);
 
 	if (unlikely(page_group_by_mobility_disabled))
 		return MIGRATE_UNMOVABLE;
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index d1083ab81998..c705f2f7c829 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -44,8 +44,7 @@ enum migratetype {
 	MIGRATE_MOVABLE,
 	MIGRATE_RECLAIMABLE,
 	MIGRATE_PCPTYPES,	/* the number of types on the pcp lists */
-	MIGRATE_HIGHATOMIC = MIGRATE_PCPTYPES,
-	MIGRATE_FREE,
+	MIGRATE_FREE = MIGRATE_PCPTYPES,
 #ifdef CONFIG_CMA
 	/*
 	 * MIGRATE_CMA migration type is designed to mimic the way
@@ -142,7 +141,6 @@ enum zone_stat_item {
 	NR_FREE_UNMOVABLE,
 	NR_FREE_MOVABLE,
 	NR_FREE_RECLAIMABLE,
-	NR_FREE_HIGHATOMIC,
 	NR_FREE_FREE,
 	NR_ZONE_LRU_BASE, /* Used only for compaction and reclaim retry */
 	NR_ZONE_INACTIVE_ANON = NR_ZONE_LRU_BASE,
@@ -713,8 +711,6 @@ struct zone {
 	unsigned long _watermark[NR_WMARK];
 	unsigned long watermark_boost;
 
-	unsigned long nr_reserved_highatomic;
-
 	/*
 	 * We don't know if the memory that we're going to allocate will be
 	 * freeable or/and it will be released eventually, so to avoid totally
diff --git a/mm/internal.h b/mm/internal.h
index 5c76455f8042..24f43f5db88b 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -778,11 +778,6 @@ extern const struct trace_print_flags pageflag_names[];
 extern const struct trace_print_flags vmaflag_names[];
 extern const struct trace_print_flags gfpflag_names[];
 
-static inline bool is_migrate_highatomic(enum migratetype migratetype)
-{
-	return migratetype == MIGRATE_HIGHATOMIC;
-}
-
 void setup_zone_pageset(struct zone *zone);
 
 struct migration_target_control {
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 6f0bfc226c36..e8ae04feb1bd 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -379,7 +379,6 @@ const char * const migratetype_names[MIGRATE_TYPES] = {
 	"Unmovable",
 	"Movable",
 	"Reclaimable",
-	"HighAtomic",
 	"Free",
 #ifdef CONFIG_CMA
 	"CMA",
@@ -1202,7 +1201,7 @@ static inline void __free_one_page(struct page *page,
 			 * We want to prevent merge between freepages on pageblock
 			 * without fallbacks and normal pageblock. Without this,
 			 * pageblock isolation could cause incorrect freepage or CMA
-			 * accounting or HIGHATOMIC accounting.
+			 * accounting.
 			 */
 			if (migratetype != buddy_mt
 					&& (!migratetype_is_mergeable(migratetype) ||
@@ -2797,13 +2796,6 @@ static void steal_suitable_fallback(struct zone *zone, struct page *page,
 
 	old_block_type = get_pageblock_migratetype(page);
 
-	/*
-	 * This can happen due to races and we want to prevent broken
-	 * highatomic accounting.
-	 */
-	if (is_migrate_highatomic(old_block_type))
-		goto single_page;
-
 	/* Take ownership for orders >= pageblock_order */
 	if (current_order >= pageblock_order) {
 		change_pageblock_range(page, current_order, start_type);
@@ -2918,126 +2910,6 @@ int find_suitable_fallback(struct free_area *area, unsigned int order,
 	return -1;
 }
 
-/*
- * Reserve a pageblock for exclusive use of high-order atomic allocations if
- * there are no empty page blocks that contain a page with a suitable order
- */
-static void reserve_highatomic_pageblock(struct page *page, struct zone *zone,
-				unsigned int alloc_order)
-{
-	int mt;
-	unsigned long max_managed, flags;
-
-	/*
-	 * Limit the number reserved to 1 pageblock or roughly 1% of a zone.
-	 * Check is race-prone but harmless.
-	 */
-	max_managed = (zone_managed_pages(zone) / 100) + pageblock_nr_pages;
-	if (zone->nr_reserved_highatomic >= max_managed)
-		return;
-
-	spin_lock_irqsave(&zone->lock, flags);
-
-	/* Recheck the nr_reserved_highatomic limit under the lock */
-	if (zone->nr_reserved_highatomic >= max_managed)
-		goto out_unlock;
-
-	/* Yoink! */
-	mt = get_pageblock_migratetype(page);
-	/* Only reserve normal pageblocks (i.e., they can merge with others) */
-	if (migratetype_is_mergeable(mt)) {
-		zone->nr_reserved_highatomic += pageblock_nr_pages;
-		set_pageblock_migratetype(page, MIGRATE_HIGHATOMIC);
-		move_freepages_block(zone, page, mt, MIGRATE_HIGHATOMIC, NULL);
-	}
-
-out_unlock:
-	spin_unlock_irqrestore(&zone->lock, flags);
-}
-
-/*
- * Used when an allocation is about to fail under memory pressure. This
- * potentially hurts the reliability of high-order allocations when under
- * intense memory pressure but failed atomic allocations should be easier
- * to recover from than an OOM.
- *
- * If @force is true, try to unreserve a pageblock even though highatomic
- * pageblock is exhausted.
- */
-static bool unreserve_highatomic_pageblock(const struct alloc_context *ac,
-						bool force)
-{
-	struct zonelist *zonelist = ac->zonelist;
-	unsigned long flags;
-	struct zoneref *z;
-	struct zone *zone;
-	struct page *page;
-	int order;
-	bool ret;
-
-	for_each_zone_zonelist_nodemask(zone, z, zonelist, ac->highest_zoneidx,
-								ac->nodemask) {
-		/*
-		 * Preserve at least one pageblock unless memory pressure
-		 * is really high.
-		 */
-		if (!force && zone->nr_reserved_highatomic <=
-					pageblock_nr_pages)
-			continue;
-
-		spin_lock_irqsave(&zone->lock, flags);
-		for (order = 0; order < MAX_ORDER; order++) {
-			struct free_area *area = &(zone->free_area[order]);
-			int mt;
-
-			page = get_page_from_free_area(area, MIGRATE_HIGHATOMIC);
-			if (!page)
-				continue;
-
-			mt = get_pageblock_migratetype(page);
-			/*
-			 * In page freeing path, migratetype change is racy so
-			 * we can counter several free pages in a pageblock
-			 * in this loop although we changed the pageblock type
-			 * from highatomic to ac->migratetype. So we should
-			 * adjust the count once.
-			 */
-			if (is_migrate_highatomic(mt)) {
-				/*
-				 * It should never happen but changes to
-				 * locking could inadvertently allow a per-cpu
-				 * drain to add pages to MIGRATE_HIGHATOMIC
-				 * while unreserving so be safe and watch for
-				 * underflows.
-				 */
-				zone->nr_reserved_highatomic -= min(
-						pageblock_nr_pages,
-						zone->nr_reserved_highatomic);
-			}
-
-			/*
-			 * Convert to ac->migratetype and avoid the normal
-			 * pageblock stealing heuristics. Minimally, the caller
-			 * is doing the work and needs the pages. More
-			 * importantly, if the block was always converted to
-			 * MIGRATE_UNMOVABLE or another type then the number
-			 * of pageblocks that cannot be completely freed
-			 * may increase.
-			 */
-			set_pageblock_migratetype(page, ac->migratetype);
-			ret = move_freepages_block(zone, page, mt,
-						   ac->migratetype, NULL);
-			if (ret) {
-				spin_unlock_irqrestore(&zone->lock, flags);
-				return ret;
-			}
-		}
-		spin_unlock_irqrestore(&zone->lock, flags);
-	}
-
-	return false;
-}
-
 /*
  * Try finding a free buddy page on the fallback list and put it on the free
  * list of requested migratetype, possibly along with other pages from the same
@@ -3510,18 +3382,11 @@ void free_unref_page(struct page *page, unsigned int order)
 
 	/*
 	 * We only track unmovable, reclaimable and movable on pcp lists.
-	 * Place ISOLATE pages on the isolated list because they are being
-	 * offlined but treat HIGHATOMIC as movable pages so we can get those
-	 * areas back if necessary. Otherwise, we may have to free
-	 * excessively into the page allocator
 	 */
 	migratetype = get_pcppage_migratetype(page);
 	if (unlikely(migratetype >= MIGRATE_PCPTYPES)) {
-		if (unlikely(is_migrate_isolate(migratetype) || migratetype == MIGRATE_FREE)) {
-			free_one_page(page_zone(page), page, pfn, order, migratetype, FPI_NONE);
-			return;
-		}
-		migratetype = MIGRATE_MOVABLE;
+		free_one_page(page_zone(page), page, pfn, order, migratetype, FPI_NONE);
+		return;
 	}
 
 	zone = page_zone(page);
@@ -3740,24 +3605,11 @@ struct page *rmqueue_buddy(struct zone *preferred_zone, struct zone *zone,
 	unsigned long flags;
 
 	do {
-		page = NULL;
 		spin_lock_irqsave(&zone->lock, flags);
-		/*
-		 * order-0 request can reach here when the pcplist is skipped
-		 * due to non-CMA allocation context. HIGHATOMIC area is
-		 * reserved for high-order atomic allocation, so order-0
-		 * request should skip it.
-		 */
-		if (order > 0 && alloc_flags & ALLOC_HARDER)
-			page = __rmqueue_smallest(zone, order, MIGRATE_HIGHATOMIC);
-		if (!page) {
-			page = __rmqueue(zone, order, migratetype, alloc_flags);
-			if (!page) {
-				spin_unlock_irqrestore(&zone->lock, flags);
-				return NULL;
-			}
-		}
+		page = __rmqueue(zone, order, migratetype, alloc_flags);
 		spin_unlock_irqrestore(&zone->lock, flags);
+		if (!page)
+			return NULL;
 	} while (check_new_pages(page, order));
 
 	__count_zid_vm_events(PGALLOC, page_zonenum(page), 1 << order);
@@ -4003,8 +3855,6 @@ static long __zone_free_pages(struct zone *zone, int alloc_flags, bool safe)
 	 * compaction is necessary to restore the watermarks.
 	 */
 	free_pages = page_state(zone, NR_FREE_FREE, safe);
-	if (alloc_flags & (ALLOC_HARDER | ALLOC_OOM))
-		free_pages += page_state(zone, NR_FREE_HIGHATOMIC, safe);
 	if (IS_ENABLED(CONFIG_CMA) && (alloc_flags & ALLOC_CMA))
 		free_pages += page_state(zone, NR_FREE_CMA_PAGES, safe);
 
@@ -4098,8 +3948,6 @@ bool __zone_watermark_ok(struct zone *z, unsigned int order, unsigned long mark,
 			return true;
 		}
 #endif
-		if (alloc_harder && !free_area_empty(area, MIGRATE_HIGHATOMIC))
-			return true;
 	}
 	return false;
 }
@@ -4340,14 +4188,6 @@ get_page_from_freelist(gfp_t gfp_mask, unsigned int order, int alloc_flags,
 				gfp_mask, alloc_flags, ac->migratetype);
 		if (page) {
 			prep_new_page(page, order, gfp_mask, alloc_flags);
-
-			/*
-			 * If this is a high-order atomic allocation then check
-			 * if the pageblock should be reserved for the future
-			 */
-			if (unlikely(order && (alloc_flags & ALLOC_HARDER)))
-				reserve_highatomic_pageblock(page, zone, order);
-
 			return page;
 		} else {
 #ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT
@@ -4844,7 +4684,6 @@ __alloc_pages_direct_reclaim(gfp_t gfp_mask, unsigned int order,
 	 * Shrink them and try again
 	 */
 	if (!page && !drained) {
-		unreserve_highatomic_pageblock(ac, false);
 		drain_all_pages(NULL);
 		drained = true;
 		goto retry;
@@ -5013,10 +4852,8 @@ should_reclaim_retry(gfp_t gfp_mask, unsigned order,
 	 * Make sure we converge to OOM if we cannot make any progress
 	 * several times in the row.
 	 */
-	if (*no_progress_loops > MAX_RECLAIM_RETRIES) {
-		/* Before OOM, exhaust highatomic_reserve */
-		return unreserve_highatomic_pageblock(ac, true);
-	}
+	if (*no_progress_loops > MAX_RECLAIM_RETRIES)
+		return false;
 
 	/*
 	 * Keep reclaiming pages while there is a chance this will lead
@@ -6129,7 +5966,6 @@ static void show_migration_types(unsigned char type)
 		[MIGRATE_UNMOVABLE]	= 'U',
 		[MIGRATE_MOVABLE]	= 'M',
 		[MIGRATE_RECLAIMABLE]	= 'E',
-		[MIGRATE_HIGHATOMIC]	= 'H',
 		[MIGRATE_FREE]		= 'F',
 #ifdef CONFIG_CMA
 		[MIGRATE_CMA]		= 'C',
@@ -6194,7 +6030,7 @@ void __show_free_areas(unsigned int filter, nodemask_t *nodemask, int max_zone_i
 		" sec_pagetables:%lu bounce:%lu\n"
 		" kernel_misc_reclaimable:%lu\n"
 		" free:%lu free_unmovable:%lu free_movable:%lu\n"
-		" free_reclaimable:%lu free_highatomic:%lu free_free:%lu\n"
+		" free_reclaimable:%lu free_free:%lu\n"
 		" free_cma:%lu free_pcp:%lu\n",
 		global_node_page_state(NR_ACTIVE_ANON),
 		global_node_page_state(NR_INACTIVE_ANON),
@@ -6217,7 +6053,6 @@ void __show_free_areas(unsigned int filter, nodemask_t *nodemask, int max_zone_i
 		global_zone_page_state(NR_FREE_UNMOVABLE),
 		global_zone_page_state(NR_FREE_MOVABLE),
 		global_zone_page_state(NR_FREE_RECLAIMABLE),
-		global_zone_page_state(NR_FREE_HIGHATOMIC),
 		global_zone_page_state(NR_FREE_FREE),
 		global_zone_page_state(NR_FREE_CMA_PAGES),
 		free_pcp);
@@ -6301,13 +6136,11 @@ void __show_free_areas(unsigned int filter, nodemask_t *nodemask, int max_zone_i
 			" free_unmovable:%lukB"
 			" free_movable:%lukB"
 			" free_reclaimable:%lukB"
-			" free_highatomic:%lukB"
 			" free_free:%lukB"
 			" boost:%lukB"
 			" min:%lukB"
 			" low:%lukB"
 			" high:%lukB"
-			" reserved_highatomic:%luKB"
 			" active_anon:%lukB"
 			" inactive_anon:%lukB"
 			" active_file:%lukB"
@@ -6327,13 +6160,11 @@ void __show_free_areas(unsigned int filter, nodemask_t *nodemask, int max_zone_i
 			K(zone_page_state(zone, NR_FREE_UNMOVABLE)),
 			K(zone_page_state(zone, NR_FREE_MOVABLE)),
 			K(zone_page_state(zone, NR_FREE_RECLAIMABLE)),
-			K(zone_page_state(zone, NR_FREE_HIGHATOMIC)),
 			K(zone_page_state(zone, NR_FREE_FREE)),
 			K(zone->watermark_boost),
 			K(min_wmark_pages(zone)),
 			K(low_wmark_pages(zone)),
 			K(high_wmark_pages(zone)),
-			K(zone->nr_reserved_highatomic),
 			K(zone_page_state(zone, NR_ZONE_ACTIVE_ANON)),
 			K(zone_page_state(zone, NR_ZONE_INACTIVE_ANON)),
 			K(zone_page_state(zone, NR_ZONE_ACTIVE_FILE)),
diff --git a/mm/vmstat.c b/mm/vmstat.c
index c8b8e6e259da..a2f7b41564df 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1171,7 +1171,6 @@ const char * const vmstat_text[] = {
 	"nr_free_unmovable",
 	"nr_free_movable",
 	"nr_free_reclaimable",
-	"nr_free_highatomic",
 	"nr_free_free",
 	"nr_zone_inactive_anon",
 	"nr_zone_active_anon",
-- 
2.39.2

