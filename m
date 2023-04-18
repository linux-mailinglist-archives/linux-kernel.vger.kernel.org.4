Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BBDA6E6CC5
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 21:14:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232896AbjDRTOH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 15:14:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232913AbjDRTNq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 15:13:46 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A69B6E8E
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 12:13:27 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id z1so19837245qti.5
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 12:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20221208.gappssmtp.com; s=20221208; t=1681845206; x=1684437206;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yvli2ztOIxf68cKgZ+2R5Rhio4udTEYI5UCWBnx3AD8=;
        b=POy4P8vqdPiLeVSxt76e8jJPxRl/eozN6LB9E3d68P5jpjweAEUzrlWviGMg34u66M
         DX44ULcevGJYU1hFf1mgK6kd8RFLuTvhIJeohRXfelo0YUOwbJ2hiSsbpjgzctQtJMmk
         aB8zg6UGDs1xRfRvOwzO+9s5eIWHOX8MZqZ9UQkd5da4H1q7eayqraQwt5iMYeDJ3wrF
         2BEBL1DvnoTbl0fLZxWCzY8F3sCBapTDuPbo3yEPRPlXgpKT8Aqj+HuVZ1Ex7zqT3+Rx
         7Z4lWFsd7xtsn4IW/qycOjrNsmfsYyltylCVUG3/5TIBnIDCJksCo9fcXBl148+k7yVp
         25HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681845206; x=1684437206;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yvli2ztOIxf68cKgZ+2R5Rhio4udTEYI5UCWBnx3AD8=;
        b=N+OhLchQwX9UrqE3E55VQ+bciYZEUkThRjRBr0GwETAGy3FMXYDH9PCNPH905IT3ir
         I4VyEQAPVFVY6+o/E1kIpD5DRZdYyoJBgpoI2ciKLJKp/AmTTgLtY9tXoxK2TdRO4sSd
         8miTiZzJFpolzpFUBvbzFlPvRn1muGoDa4l8nKaNFjwH6IAB2ezfPzEC442dQyYiTe5q
         KdHCqtkKXERdyRDiAW/3pXFJwlc/u8qcRgDhXmWWcdF4Hf2aJu1qniGni3sMbVJY69Zz
         FmekhgLprUhTMPqvmv2pCA7CtgIfJ1FcgufRE26znCmYseoFb4bFNElwyz7kJ2w7dVb3
         JIdA==
X-Gm-Message-State: AAQBX9dxsoWteLshHYoQXKzWr95Ut1Ed3vq+RXNxQFaQyVyiT2mhmN01
        VTM1UlOrf63MXN0opHAykF2suA==
X-Google-Smtp-Source: AKy350ZdHSWRh7iDOoY7e2deWBswJWxcHm+J7bJRVccNErJ7bE6cTwx7vNM6q+rfQXee9INBqqd6Cw==
X-Received: by 2002:ac8:578d:0:b0:3bf:c3be:758e with SMTP id v13-20020ac8578d000000b003bfc3be758emr1593777qta.16.1681845206131;
        Tue, 18 Apr 2023 12:13:26 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:e646])
        by smtp.gmail.com with ESMTPSA id p23-20020a05620a22f700b0074ad04609f8sm1217427qki.117.2023.04.18.12.13.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 12:13:25 -0700 (PDT)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     linux-mm@kvack.org
Cc:     Kaiyang Zhao <kaiyang2@cs.cmu.edu>,
        Mel Gorman <mgorman@techsingularity.net>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Rientjes <rientjes@google.com>,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: [RFC PATCH 06/26] mm: page_alloc: consolidate free page accounting
Date:   Tue, 18 Apr 2023 15:12:53 -0400
Message-Id: <20230418191313.268131-7-hannes@cmpxchg.org>
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

Free page accounting currently happens a bit too high up the call
stack, where it has to deal with guard pages, compaction capturing,
block stealing and even page isolation. This is subtle and fragile,
and makes it difficult to hack on the code.

Push the accounting down to where pages enter and leave the physical
freelists, where all these higher-level exceptions are of no concern.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 include/linux/page-isolation.h |   2 +-
 include/linux/vmstat.h         |   8 --
 mm/internal.h                  |   5 --
 mm/page_alloc.c                | 153 +++++++++++++++++----------------
 mm/page_isolation.c            |  13 ++-
 5 files changed, 83 insertions(+), 98 deletions(-)

diff --git a/include/linux/page-isolation.h b/include/linux/page-isolation.h
index 0ab089e89db4..b519fffb3dee 100644
--- a/include/linux/page-isolation.h
+++ b/include/linux/page-isolation.h
@@ -35,7 +35,7 @@ static inline bool is_migrate_isolate(int migratetype)
 
 void set_pageblock_migratetype(struct page *page, int migratetype);
 int move_freepages_block(struct zone *zone, struct page *page,
-				int migratetype, int *num_movable);
+			 int old_mt, int new_mt, int *num_movable);
 
 int start_isolate_page_range(unsigned long start_pfn, unsigned long end_pfn,
 			     int migratetype, int flags, gfp_t gfp_flags);
diff --git a/include/linux/vmstat.h b/include/linux/vmstat.h
index 19cf5b6892ce..219ccf3f91cd 100644
--- a/include/linux/vmstat.h
+++ b/include/linux/vmstat.h
@@ -481,14 +481,6 @@ static inline void node_stat_sub_folio(struct folio *folio,
 	mod_node_page_state(folio_pgdat(folio), item, -folio_nr_pages(folio));
 }
 
-static inline void __mod_zone_freepage_state(struct zone *zone, int nr_pages,
-					     int migratetype)
-{
-	__mod_zone_page_state(zone, NR_FREE_PAGES, nr_pages);
-	if (is_migrate_cma(migratetype))
-		__mod_zone_page_state(zone, NR_FREE_CMA_PAGES, nr_pages);
-}
-
 extern const char * const vmstat_text[];
 
 static inline const char *zone_stat_name(enum zone_stat_item item)
diff --git a/mm/internal.h b/mm/internal.h
index bcf75a8b032d..024affd4e4b5 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -781,11 +781,6 @@ static inline bool is_migrate_highatomic(enum migratetype migratetype)
 	return migratetype == MIGRATE_HIGHATOMIC;
 }
 
-static inline bool is_migrate_highatomic_page(struct page *page)
-{
-	return get_pageblock_migratetype(page) == MIGRATE_HIGHATOMIC;
-}
-
 void setup_zone_pageset(struct zone *zone);
 
 struct migration_target_control {
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index d3d01019ce77..b9366c002334 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -843,7 +843,7 @@ static int __init debug_guardpage_minorder_setup(char *buf)
 early_param("debug_guardpage_minorder", debug_guardpage_minorder_setup);
 
 static inline bool set_page_guard(struct zone *zone, struct page *page,
-				unsigned int order, int migratetype)
+				  unsigned int order
 {
 	if (!debug_guardpage_enabled())
 		return false;
@@ -854,15 +854,12 @@ static inline bool set_page_guard(struct zone *zone, struct page *page,
 	__SetPageGuard(page);
 	INIT_LIST_HEAD(&page->buddy_list);
 	set_page_private(page, order);
-	/* Guard pages are not available for any usage */
-	if (!is_migrate_isolate(migratetype))
-		__mod_zone_freepage_state(zone, -(1 << order), migratetype);
 
 	return true;
 }
 
 static inline void clear_page_guard(struct zone *zone, struct page *page,
-				unsigned int order, int migratetype)
+				    unsigned int order)
 {
 	if (!debug_guardpage_enabled())
 		return;
@@ -870,14 +867,12 @@ static inline void clear_page_guard(struct zone *zone, struct page *page,
 	__ClearPageGuard(page);
 
 	set_page_private(page, 0);
-	if (!is_migrate_isolate(migratetype))
-		__mod_zone_freepage_state(zone, (1 << order), migratetype);
 }
 #else
 static inline bool set_page_guard(struct zone *zone, struct page *page,
-			unsigned int order, int migratetype) { return false; }
+			unsigned int order) { return false; }
 static inline void clear_page_guard(struct zone *zone, struct page *page,
-				unsigned int order, int migratetype) {}
+				unsigned int order) {}
 #endif
 
 /*
@@ -994,24 +989,36 @@ compaction_capture(struct capture_control *capc, struct page *page,
 }
 #endif /* CONFIG_COMPACTION */
 
-/* Used for pages not on another list */
-static inline void add_to_free_list(struct page *page, struct zone *zone,
-				    unsigned int order, int migratetype)
+static inline void account_freepages(struct page *page, struct zone *zone,
+				     int nr_pages, int migratetype)
 {
-	struct free_area *area = &zone->free_area[order];
+	if (is_migrate_isolate(migratetype))
+		return;
 
-	list_add(&page->buddy_list, &area->free_list[migratetype]);
-	area->nr_free++;
+	__mod_zone_page_state(zone, NR_FREE_PAGES, nr_pages);
+
+	if (is_migrate_cma(migratetype))
+		__mod_zone_page_state(zone, NR_FREE_CMA_PAGES, nr_pages);
 }
 
 /* Used for pages not on another list */
-static inline void add_to_free_list_tail(struct page *page, struct zone *zone,
-					 unsigned int order, int migratetype)
+static inline void add_to_free_list(struct page *page, struct zone *zone,
+				    unsigned int order, int migratetype,
+				    bool tail)
 {
 	struct free_area *area = &zone->free_area[order];
 
-	list_add_tail(&page->buddy_list, &area->free_list[migratetype]);
+	VM_WARN_ONCE(get_pageblock_migratetype(page) != migratetype,
+		     "page type is %lu, passed migratetype is %d (nr=%d)\n",
+		     get_pageblock_migratetype(page), migratetype, 1 << order);
+
+	if (tail)
+		list_add_tail(&page->buddy_list, &area->free_list[migratetype]);
+	else
+		list_add(&page->buddy_list, &area->free_list[migratetype]);
 	area->nr_free++;
+
+	account_freepages(page, zone, 1 << order, migratetype);
 }
 
 /*
@@ -1020,16 +1027,23 @@ static inline void add_to_free_list_tail(struct page *page, struct zone *zone,
  * allocation again (e.g., optimization for memory onlining).
  */
 static inline void move_to_free_list(struct page *page, struct zone *zone,
-				     unsigned int order, int migratetype)
+				     unsigned int order, int old_mt, int new_mt)
 {
 	struct free_area *area = &zone->free_area[order];
 
-	list_move_tail(&page->buddy_list, &area->free_list[migratetype]);
+	list_move_tail(&page->buddy_list, &area->free_list[new_mt]);
+
+	account_freepages(page, zone, -(1 << order), old_mt);
+	account_freepages(page, zone, 1 << order, new_mt);
 }
 
 static inline void del_page_from_free_list(struct page *page, struct zone *zone,
-					   unsigned int order)
+					   unsigned int order, int migratetype)
 {
+        VM_WARN_ONCE(get_pageblock_migratetype(page) != migratetype,
+		     "page type is %lu, passed migratetype is %d (nr=%d)\n",
+		     get_pageblock_migratetype(page), migratetype, 1 << order);
+
 	/* clear reported state and update reported page count */
 	if (page_reported(page))
 		__ClearPageReported(page);
@@ -1038,6 +1052,8 @@ static inline void del_page_from_free_list(struct page *page, struct zone *zone,
 	__ClearPageBuddy(page);
 	set_page_private(page, 0);
 	zone->free_area[order].nr_free--;
+
+	account_freepages(page, zone, -(1 << order), migratetype);
 }
 
 /*
@@ -1104,23 +1120,21 @@ static inline void __free_one_page(struct page *page,
 	VM_BUG_ON_PAGE(page->flags & PAGE_FLAGS_CHECK_AT_PREP, page);
 
 	VM_BUG_ON(migratetype == -1);
-	if (likely(!is_migrate_isolate(migratetype)))
-		__mod_zone_freepage_state(zone, 1 << order, migratetype);
-
 	VM_BUG_ON_PAGE(pfn & ((1 << order) - 1), page);
 	VM_BUG_ON_PAGE(bad_range(zone, page), page);
 
 	while (order < MAX_ORDER - 1) {
-		if (compaction_capture(capc, page, order, migratetype)) {
-			__mod_zone_freepage_state(zone, -(1 << order),
-								migratetype);
+		int buddy_mt;
+
+		if (compaction_capture(capc, page, order, migratetype))
 			return;
-		}
 
 		buddy = find_buddy_page_pfn(page, pfn, order, &buddy_pfn);
 		if (!buddy)
 			goto done_merging;
 
+		buddy_mt = get_pageblock_migratetype(buddy);
+
 		if (unlikely(order >= pageblock_order)) {
 			/*
 			 * We want to prevent merge between freepages on pageblock
@@ -1128,8 +1142,6 @@ static inline void __free_one_page(struct page *page,
 			 * pageblock isolation could cause incorrect freepage or CMA
 			 * accounting or HIGHATOMIC accounting.
 			 */
-			int buddy_mt = get_pageblock_migratetype(buddy);
-
 			if (migratetype != buddy_mt
 					&& (!migratetype_is_mergeable(migratetype) ||
 						!migratetype_is_mergeable(buddy_mt)))
@@ -1141,9 +1153,9 @@ static inline void __free_one_page(struct page *page,
 		 * merge with it and move up one order.
 		 */
 		if (page_is_guard(buddy))
-			clear_page_guard(zone, buddy, order, migratetype);
+			clear_page_guard(zone, buddy, order);
 		else
-			del_page_from_free_list(buddy, zone, order);
+			del_page_from_free_list(buddy, zone, order, buddy_mt);
 		combined_pfn = buddy_pfn & pfn;
 		page = page + (combined_pfn - pfn);
 		pfn = combined_pfn;
@@ -1160,10 +1172,7 @@ static inline void __free_one_page(struct page *page,
 	else
 		to_tail = buddy_merge_likely(pfn, buddy_pfn, page, order);
 
-	if (to_tail)
-		add_to_free_list_tail(page, zone, order, migratetype);
-	else
-		add_to_free_list(page, zone, order, migratetype);
+	add_to_free_list(page, zone, order, migratetype, to_tail);
 
 	/* Notify page reporting subsystem of freed page */
 	if (!(fpi_flags & FPI_SKIP_REPORT_NOTIFY))
@@ -1205,10 +1214,8 @@ int split_free_page(struct page *free_page,
 	}
 
 	mt = get_pageblock_migratetype(free_page);
-	if (likely(!is_migrate_isolate(mt)))
-		__mod_zone_freepage_state(zone, -(1UL << order), mt);
+	del_page_from_free_list(free_page, zone, order, mt);
 
-	del_page_from_free_list(free_page, zone, order);
 	for (pfn = free_page_pfn;
 	     pfn < free_page_pfn + (1UL << order);) {
 		int mt = get_pfnblock_migratetype(pfn_to_page(pfn), pfn);
@@ -2352,10 +2359,10 @@ static inline void expand(struct zone *zone, struct page *page,
 		 * Corresponding page table entries will not be touched,
 		 * pages will stay not present in virtual address space
 		 */
-		if (set_page_guard(zone, &page[size], high, migratetype))
+		if (set_page_guard(zone, &page[size], high))
 			continue;
 
-		add_to_free_list(&page[size], zone, high, migratetype);
+		add_to_free_list(&page[size], zone, high, migratetype, false);
 		set_buddy_order(&page[size], high);
 	}
 }
@@ -2559,11 +2566,15 @@ struct page *__rmqueue_smallest(struct zone *zone, unsigned int order,
 
 	/* Find a page of the appropriate size in the preferred list */
 	for (current_order = order; current_order < MAX_ORDER; ++current_order) {
+		int actual_mt;
+
 		area = &(zone->free_area[current_order]);
 		page = get_page_from_free_area(area, migratetype);
 		if (!page)
 			continue;
-		del_page_from_free_list(page, zone, current_order);
+		/* move_freepages_block() may strand types on wrong list */
+		actual_mt = get_pageblock_migratetype(page);
+		del_page_from_free_list(page, zone, current_order, actual_mt);
 		expand(zone, page, order, current_order, migratetype);
 		set_pcppage_migratetype(page, migratetype);
 		trace_mm_page_alloc_zone_locked(page, order, migratetype,
@@ -2606,7 +2617,7 @@ static inline struct page *__rmqueue_cma_fallback(struct zone *zone,
  */
 static int move_freepages(struct zone *zone,
 			  unsigned long start_pfn, unsigned long end_pfn,
-			  int migratetype, int *num_movable)
+			  int old_mt, int new_mt, int *num_movable)
 {
 	struct page *page;
 	unsigned long pfn;
@@ -2633,7 +2644,7 @@ static int move_freepages(struct zone *zone,
 		VM_BUG_ON_PAGE(page_zone(page) != zone, page);
 
 		order = buddy_order(page);
-		move_to_free_list(page, zone, order, migratetype);
+		move_to_free_list(page, zone, order, old_mt, new_mt);
 		pfn += 1 << order;
 		pages_moved += 1 << order;
 	}
@@ -2642,7 +2653,7 @@ static int move_freepages(struct zone *zone,
 }
 
 int move_freepages_block(struct zone *zone, struct page *page,
-				int migratetype, int *num_movable)
+			 int old_mt, int new_mt, int *num_movable)
 {
 	unsigned long start_pfn, end_pfn, pfn;
 
@@ -2659,8 +2670,8 @@ int move_freepages_block(struct zone *zone, struct page *page,
 	if (!zone_spans_pfn(zone, end_pfn))
 		return 0;
 
-	return move_freepages(zone, start_pfn, end_pfn, migratetype,
-								num_movable);
+	return move_freepages(zone, start_pfn, end_pfn,
+			      old_mt, new_mt, num_movable);
 }
 
 static void change_pageblock_range(struct page *pageblock_page,
@@ -2786,8 +2797,9 @@ static void steal_suitable_fallback(struct zone *zone, struct page *page,
 	if (!whole_block)
 		goto single_page;
 
-	free_pages = move_freepages_block(zone, page, start_type,
-						&movable_pages);
+	free_pages = move_freepages_block(zone, page, old_block_type,
+					  start_type, &movable_pages);
+
 	/*
 	 * Determine how many pages are compatible with our allocation.
 	 * For movable allocation, it's the number of movable pages which
@@ -2825,7 +2837,8 @@ static void steal_suitable_fallback(struct zone *zone, struct page *page,
 	return;
 
 single_page:
-	move_to_free_list(page, zone, current_order, start_type);
+	move_to_free_list(page, zone, current_order,
+			  old_block_type, start_type);
 }
 
 /*
@@ -2895,7 +2908,7 @@ static void reserve_highatomic_pageblock(struct page *page, struct zone *zone,
 	if (migratetype_is_mergeable(mt)) {
 		zone->nr_reserved_highatomic += pageblock_nr_pages;
 		set_pageblock_migratetype(page, MIGRATE_HIGHATOMIC);
-		move_freepages_block(zone, page, MIGRATE_HIGHATOMIC, NULL);
+		move_freepages_block(zone, page, mt, MIGRATE_HIGHATOMIC, NULL);
 	}
 
 out_unlock:
@@ -2935,11 +2948,13 @@ static bool unreserve_highatomic_pageblock(const struct alloc_context *ac,
 		spin_lock_irqsave(&zone->lock, flags);
 		for (order = 0; order < MAX_ORDER; order++) {
 			struct free_area *area = &(zone->free_area[order]);
+			int mt;
 
 			page = get_page_from_free_area(area, MIGRATE_HIGHATOMIC);
 			if (!page)
 				continue;
 
+			mt = get_pageblock_migratetype(page);
 			/*
 			 * In page freeing path, migratetype change is racy so
 			 * we can counter several free pages in a pageblock
@@ -2947,7 +2962,7 @@ static bool unreserve_highatomic_pageblock(const struct alloc_context *ac,
 			 * from highatomic to ac->migratetype. So we should
 			 * adjust the count once.
 			 */
-			if (is_migrate_highatomic_page(page)) {
+			if (is_migrate_highatomic(mt)) {
 				/*
 				 * It should never happen but changes to
 				 * locking could inadvertently allow a per-cpu
@@ -2970,8 +2985,8 @@ static bool unreserve_highatomic_pageblock(const struct alloc_context *ac,
 			 * may increase.
 			 */
 			set_pageblock_migratetype(page, ac->migratetype);
-			ret = move_freepages_block(zone, page, ac->migratetype,
-									NULL);
+			ret = move_freepages_block(zone, page, mt,
+						   ac->migratetype, NULL);
 			if (ret) {
 				spin_unlock_irqrestore(&zone->lock, flags);
 				return ret;
@@ -3142,18 +3157,7 @@ static int rmqueue_bulk(struct zone *zone, unsigned int order,
 		 */
 		list_add_tail(&page->pcp_list, list);
 		allocated++;
-		if (is_migrate_cma(get_pcppage_migratetype(page)))
-			__mod_zone_page_state(zone, NR_FREE_CMA_PAGES,
-					      -(1 << order));
 	}
-
-	/*
-	 * i pages were removed from the buddy list even if some leak due
-	 * to check_pcp_refill failing so adjust NR_FREE_PAGES based
-	 * on i. Do not confuse with 'allocated' which is the number of
-	 * pages added to the pcp list.
-	 */
-	__mod_zone_page_state(zone, NR_FREE_PAGES, -(i << order));
 	spin_unlock_irqrestore(&zone->lock, flags);
 	return allocated;
 }
@@ -3615,11 +3619,9 @@ int __isolate_free_page(struct page *page, unsigned int order)
 		watermark = zone->_watermark[WMARK_MIN] + (1UL << order);
 		if (!zone_watermark_ok(zone, 0, watermark, 0, ALLOC_CMA))
 			return 0;
-
-		__mod_zone_freepage_state(zone, -(1UL << order), mt);
 	}
 
-	del_page_from_free_list(page, zone, order);
+	del_page_from_free_list(page, zone, order, mt);
 
 	/*
 	 * Set the pageblock if the isolated page is at least half of a
@@ -3715,8 +3717,6 @@ struct page *rmqueue_buddy(struct zone *preferred_zone, struct zone *zone,
 				return NULL;
 			}
 		}
-		__mod_zone_freepage_state(zone, -(1 << order),
-					  get_pcppage_migratetype(page));
 		spin_unlock_irqrestore(&zone->lock, flags);
 	} while (check_new_pages(page, order));
 
@@ -9578,8 +9578,9 @@ void __offline_isolated_pages(unsigned long start_pfn, unsigned long end_pfn)
 
 		BUG_ON(page_count(page));
 		BUG_ON(!PageBuddy(page));
+		VM_WARN_ON(get_pageblock_migratetype(page) != MIGRATE_ISOLATE);
 		order = buddy_order(page);
-		del_page_from_free_list(page, zone, order);
+		del_page_from_free_list(page, zone, order, MIGRATE_ISOLATE);
 		pfn += (1 << order);
 	}
 	spin_unlock_irqrestore(&zone->lock, flags);
@@ -9630,11 +9631,12 @@ static void break_down_buddy_pages(struct zone *zone, struct page *page,
 			current_buddy = page + size;
 		}
 
-		if (set_page_guard(zone, current_buddy, high, migratetype))
+		if (set_page_guard(zone, current_buddy, high))
 			continue;
 
 		if (current_buddy != target) {
-			add_to_free_list(current_buddy, zone, high, migratetype);
+			add_to_free_list(current_buddy, zone, high,
+					 migratetype, false);
 			set_buddy_order(current_buddy, high);
 			page = next_page;
 		}
@@ -9662,12 +9664,11 @@ bool take_page_off_buddy(struct page *page)
 			int migratetype = get_pfnblock_migratetype(page_head,
 								   pfn_head);
 
-			del_page_from_free_list(page_head, zone, page_order);
+			del_page_from_free_list(page_head, zone, page_order,
+						migratetype);
 			break_down_buddy_pages(zone, page_head, page, 0,
 						page_order, migratetype);
 			SetPageHWPoisonTakenOff(page);
-			if (!is_migrate_isolate(migratetype))
-				__mod_zone_freepage_state(zone, -1, migratetype);
 			ret = true;
 			break;
 		}
diff --git a/mm/page_isolation.c b/mm/page_isolation.c
index b67800f7f6b1..e119a37ac661 100644
--- a/mm/page_isolation.c
+++ b/mm/page_isolation.c
@@ -183,10 +183,8 @@ static int set_migratetype_isolate(struct page *page, int migratetype, int isol_
 
 		set_pageblock_migratetype(page, MIGRATE_ISOLATE);
 		zone->nr_isolate_pageblock++;
-		nr_pages = move_freepages_block(zone, page, MIGRATE_ISOLATE,
-									NULL);
-
-		__mod_zone_freepage_state(zone, -nr_pages, mt);
+		nr_pages = move_freepages_block(zone, page, mt,
+						MIGRATE_ISOLATE, NULL);
 		spin_unlock_irqrestore(&zone->lock, flags);
 		return 0;
 	}
@@ -251,10 +249,9 @@ static void unset_migratetype_isolate(struct page *page, int migratetype)
 	 * onlining - just onlined memory won't immediately be considered for
 	 * allocation.
 	 */
-	if (!isolated_page) {
-		nr_pages = move_freepages_block(zone, page, migratetype, NULL);
-		__mod_zone_freepage_state(zone, nr_pages, migratetype);
-	}
+	if (!isolated_page)
+		nr_pages = move_freepages_block(zone, page, MIGRATE_ISOLATE,
+						migratetype, NULL);
 	set_pageblock_migratetype(page, migratetype);
 	if (isolated_page)
 		__putback_isolated_page(page, order, migratetype);
-- 
2.39.2

