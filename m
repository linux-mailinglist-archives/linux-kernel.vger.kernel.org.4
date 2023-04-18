Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 097456E6CD2
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 21:15:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232605AbjDRTOd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 15:14:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232844AbjDRTOC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 15:14:02 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB2B3C147
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 12:13:32 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id js7so10389891qvb.5
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 12:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20221208.gappssmtp.com; s=20221208; t=1681845212; x=1684437212;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5cDejj0JwuwHnUJP/oEtDQ+Dx04Y5ly69JDrx/A+L3g=;
        b=CMPWhKkMWeLbM1Rq+FTNlaR0dSWXr97zWbAFsGnhIYGtP+CzQS0HVHu9IoQvtoACE8
         mhYIBqbKGjtBs+LtkNOHMbMHPLnpfnolTnLtMYSphbh3QM/YHVg9xGMX5JifyMhJRDZN
         RvXl9lXXUKC1e1qgby2qHSWtJc2hSDPS51QzKdNqBwfuWtGPigSB5OT3E52N3lqpNtBI
         r4M586z/x6k8gKidXuSXIy+fp2eMvjQvShdWfKbhEZC/kyJxnvrBCpaNZNxoThlYVR5D
         o6a1X3kolTsoZyqQip7R4cFUcH4uGzvAAHQyusAJPnGmI3LEgBvst3Dp6eXqmeXOlajY
         VOcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681845212; x=1684437212;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5cDejj0JwuwHnUJP/oEtDQ+Dx04Y5ly69JDrx/A+L3g=;
        b=O0oHWUg91uV9IZq/Ab7O6hbVAqnnhd+iy/FN4SV857gcU9eyDUrGwRkAZW5FanZMO0
         ioiXWVFA9eOtEAHUd0zDcN57VdC/M10awR+QU7c6+zEt+0yE22pTj/JPS7k7F59sNk83
         ocFyG6oqlQYo0aBEkTg9AqnPPTgS3vjuxxLTzN9IggseETy7ZXxkLZ338tKIc/+1vo8B
         HxDU00YOZ4vQh2wHqos9VsR0b9XekuBFGhuIh6VqdHpt1/METTTowS/SNpsKj3F1slKE
         lN8MVckmpTkcShxFy6VTWIv/SqU3dg9BEZLhLPAk2TKW6KyLTG6NPRPTz8ObUO3V61Jj
         Gtwg==
X-Gm-Message-State: AAQBX9cEpFCMqNOJ9Qsz33AdZgHXqoJrf/SyHmbi6XeZTDjhx1QZkPbE
        yDfXQ1ZqlU16/+Zg+LcRx3V62g==
X-Google-Smtp-Source: AKy350aMgOd3m7oKqMvaJHVobJC6wjWKHn3Vg6kPYlU6Q91voRGhTKGXzatfaK4cnRY78f9Dp31ahQ==
X-Received: by 2002:a05:6214:e81:b0:5ee:b788:2f48 with SMTP id hf1-20020a0562140e8100b005eeb7882f48mr26312276qvb.31.1681845211935;
        Tue, 18 Apr 2023 12:13:31 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:e646])
        by smtp.gmail.com with ESMTPSA id i2-20020a0cf942000000b005ef529dc39esm3619309qvo.108.2023.04.18.12.13.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 12:13:31 -0700 (PDT)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     linux-mm@kvack.org
Cc:     Kaiyang Zhao <kaiyang2@cs.cmu.edu>,
        Mel Gorman <mgorman@techsingularity.net>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Rientjes <rientjes@google.com>,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: [RFC PATCH 11/26] mm: page_alloc: introduce MIGRATE_FREE
Date:   Tue, 18 Apr 2023 15:12:58 -0400
Message-Id: <20230418191313.268131-12-hannes@cmpxchg.org>
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

To cut down on type mixing, put empty pageblocks on separate freelists
and make them the first fallback preference before stealing space from
incompatible blocks.

The neutral block designation will also be handy in subsequent patches
that: simplify compaction; add per-mt freelist counts and make
compaction_suitable() more precise; and ultimately make pageblocks the
basis of free memory management.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 include/linux/mmzone.h |  3 +-
 mm/memory_hotplug.c    |  4 +--
 mm/page_alloc.c        | 63 +++++++++++++++++++++++++++++++-----------
 3 files changed, 51 insertions(+), 19 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 53e55882a4e7..20542e5a0a43 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -45,6 +45,7 @@ enum migratetype {
 	MIGRATE_RECLAIMABLE,
 	MIGRATE_PCPTYPES,	/* the number of types on the pcp lists */
 	MIGRATE_HIGHATOMIC = MIGRATE_PCPTYPES,
+	MIGRATE_FREE,
 #ifdef CONFIG_CMA
 	/*
 	 * MIGRATE_CMA migration type is designed to mimic the way
@@ -88,7 +89,7 @@ static inline bool is_migrate_movable(int mt)
  */
 static inline bool migratetype_is_mergeable(int mt)
 {
-	return mt < MIGRATE_PCPTYPES;
+	return mt < MIGRATE_PCPTYPES || mt == MIGRATE_FREE;
 }
 
 #define for_each_migratetype_order(order, type) \
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index fd40f7e9f176..d7b9f0e70b58 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1129,7 +1129,7 @@ int __ref online_pages(unsigned long pfn, unsigned long nr_pages,
 		build_all_zonelists(NULL);
 
 	/* Basic onlining is complete, allow allocation of onlined pages. */
-	undo_isolate_page_range(pfn, pfn + nr_pages, MIGRATE_MOVABLE);
+	undo_isolate_page_range(pfn, pfn + nr_pages, MIGRATE_FREE);
 
 	/*
 	 * Freshly onlined pages aren't shuffled (e.g., all pages are placed to
@@ -1951,7 +1951,7 @@ int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages,
 
 failed_removal_isolated:
 	/* pushback to free area */
-	undo_isolate_page_range(start_pfn, end_pfn, MIGRATE_MOVABLE);
+	undo_isolate_page_range(start_pfn, end_pfn, MIGRATE_FREE);
 	memory_notify(MEM_CANCEL_OFFLINE, &arg);
 failed_removal_pcplists_disabled:
 	lru_cache_enable();
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 5ebfcf18537b..44da23625f51 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -380,6 +380,7 @@ const char * const migratetype_names[MIGRATE_TYPES] = {
 	"Movable",
 	"Reclaimable",
 	"HighAtomic",
+	"Free",
 #ifdef CONFIG_CMA
 	"CMA",
 #endif
@@ -1222,6 +1223,13 @@ static inline void __free_one_page(struct page *page,
 done_merging:
 	set_buddy_order(page, order);
 
+	/* If we freed one or normal page blocks, mark them free. */
+	if (unlikely(order >= pageblock_order &&
+		     migratetype_is_mergeable(migratetype))) {
+		change_pageblock_range(page, order, MIGRATE_FREE);
+		migratetype = MIGRATE_FREE;
+	}
+
 	if (fpi_flags & FPI_TO_TAIL)
 		to_tail = true;
 	else if (is_shuffle_order(order))
@@ -1961,14 +1969,14 @@ static void __init deferred_free_range(unsigned long pfn,
 
 	/* Free a large naturally-aligned chunk if possible */
 	if (nr_pages == pageblock_nr_pages && pageblock_aligned(pfn)) {
-		set_pageblock_migratetype(page, MIGRATE_MOVABLE);
+		set_pageblock_migratetype(page, MIGRATE_FREE);
 		__free_pages_core(page, pageblock_order);
 		return;
 	}
 
 	for (i = 0; i < nr_pages; i++, page++, pfn++) {
 		if (pageblock_aligned(pfn))
-			set_pageblock_migratetype(page, MIGRATE_MOVABLE);
+			set_pageblock_migratetype(page, MIGRATE_FREE);
 		__free_pages_core(page, 0);
 	}
 }
@@ -2612,10 +2620,10 @@ struct page *__rmqueue_smallest(struct zone *zone, unsigned int order,
  *
  * The other migratetypes do not have fallbacks.
  */
-static int fallbacks[MIGRATE_TYPES][3] = {
-	[MIGRATE_UNMOVABLE]   = { MIGRATE_RECLAIMABLE, MIGRATE_MOVABLE,   MIGRATE_TYPES },
-	[MIGRATE_MOVABLE]     = { MIGRATE_RECLAIMABLE, MIGRATE_UNMOVABLE, MIGRATE_TYPES },
-	[MIGRATE_RECLAIMABLE] = { MIGRATE_UNMOVABLE,   MIGRATE_MOVABLE,   MIGRATE_TYPES },
+static int fallbacks[MIGRATE_TYPES][4] = {
+	[MIGRATE_UNMOVABLE]   = { MIGRATE_FREE, MIGRATE_RECLAIMABLE, MIGRATE_MOVABLE,   MIGRATE_TYPES },
+	[MIGRATE_MOVABLE]     = { MIGRATE_FREE, MIGRATE_RECLAIMABLE, MIGRATE_UNMOVABLE, MIGRATE_TYPES },
+	[MIGRATE_RECLAIMABLE] = { MIGRATE_FREE, MIGRATE_UNMOVABLE,   MIGRATE_MOVABLE,   MIGRATE_TYPES },
 };
 
 #ifdef CONFIG_CMA
@@ -2705,8 +2713,13 @@ int move_freepages_block(struct zone *zone, struct page *page,
  * is worse than movable allocations stealing from unmovable and reclaimable
  * pageblocks.
  */
-static bool can_steal_fallback(unsigned int order, int start_mt)
+static bool can_steal_fallback(unsigned int order, int start_mt,
+			       int fallback_mt)
 {
+	/* The first allocation in a free block *must* claim it. */
+	if (fallback_mt == MIGRATE_FREE)
+		return true;
+
 	/*
 	 * Leaving this order check is intended, although there is
 	 * relaxed order check in next check. The reason is that
@@ -2808,6 +2821,21 @@ static void steal_suitable_fallback(struct zone *zone, struct page *page,
 	free_pages = move_freepages_block(zone, page, old_block_type,
 					  start_type, &movable_pages);
 
+	/*
+	 * If we fell back into a free block, claim the whole thing
+	 */
+	if (old_block_type == MIGRATE_FREE) {
+		set_pageblock_migratetype(page, start_type);
+		if (!free_pages) {
+			/*
+			 * This can leave some non-FREE pages on the
+			 * FREE list. Future fallbacks will get them.
+			 */
+			goto single_page;
+		}
+		return;
+	}
+
 	/*
 	 * Determine how many pages are compatible with our allocation.
 	 * For movable allocation, it's the number of movable pages which
@@ -2873,7 +2901,7 @@ int find_suitable_fallback(struct free_area *area, unsigned int order,
 		if (free_area_empty(area, fallback_mt))
 			continue;
 
-		if (can_steal_fallback(order, migratetype))
+		if (can_steal_fallback(order, migratetype, fallback_mt))
 			*can_steal = true;
 
 		if (!only_stealable)
@@ -3485,7 +3513,7 @@ void free_unref_page(struct page *page, unsigned int order)
 	 */
 	migratetype = get_pcppage_migratetype(page);
 	if (unlikely(migratetype >= MIGRATE_PCPTYPES)) {
-		if (unlikely(is_migrate_isolate(migratetype))) {
+		if (unlikely(is_migrate_isolate(migratetype) || migratetype == MIGRATE_FREE)) {
 			free_one_page(page_zone(page), page, pfn, order, migratetype, FPI_NONE);
 			return;
 		}
@@ -3529,7 +3557,7 @@ void free_unref_page_list(struct list_head *list)
 		 * comment in free_unref_page.
 		 */
 		migratetype = get_pcppage_migratetype(page);
-		if (unlikely(is_migrate_isolate(migratetype))) {
+		if (unlikely(is_migrate_isolate(migratetype) || migratetype == MIGRATE_FREE)) {
 			list_del(&page->lru);
 			free_one_page(page_zone(page), page, pfn, 0, migratetype, FPI_NONE);
 			continue;
@@ -3632,10 +3660,10 @@ int __isolate_free_page(struct page *page, unsigned int order)
 	del_page_from_free_list(page, zone, order, mt);
 
 	/*
-	 * Set the pageblock if the isolated page is at least half of a
-	 * pageblock
+	 * Set the pageblock if the isolated page is from a free block
+	 * or at least half of a pageblock
 	 */
-	if (order >= pageblock_order - 1) {
+	if (mt == MIGRATE_FREE || order >= pageblock_order - 1) {
 		struct page *endpage = page + (1 << order) - 1;
 		for (; page < endpage; page += pageblock_nr_pages) {
 			int mt = get_pageblock_migratetype(page);
@@ -4020,6 +4048,9 @@ bool __zone_watermark_ok(struct zone *z, unsigned int order, unsigned long mark,
 		if (!area->nr_free)
 			continue;
 
+		if (!free_area_empty(area, MIGRATE_FREE))
+			return true;
+
 		for (mt = 0; mt < MIGRATE_PCPTYPES; mt++) {
 			if (!free_area_empty(area, mt))
 				return true;
@@ -6081,6 +6112,7 @@ static void show_migration_types(unsigned char type)
 		[MIGRATE_MOVABLE]	= 'M',
 		[MIGRATE_RECLAIMABLE]	= 'E',
 		[MIGRATE_HIGHATOMIC]	= 'H',
+		[MIGRATE_FREE]		= 'F',
 #ifdef CONFIG_CMA
 		[MIGRATE_CMA]		= 'C',
 #endif
@@ -7025,7 +7057,7 @@ static void __init memmap_init_zone_range(struct zone *zone,
 		return;
 
 	memmap_init_range(end_pfn - start_pfn, nid, zone_id, start_pfn,
-			  zone_end_pfn, MEMINIT_EARLY, NULL, MIGRATE_MOVABLE);
+			  zone_end_pfn, MEMINIT_EARLY, NULL, MIGRATE_FREE);
 
 	if (*hole_pfn < start_pfn)
 		init_unavailable_range(*hole_pfn, start_pfn, zone_id, nid);
@@ -9422,8 +9454,7 @@ static int __alloc_contig_pages(unsigned long start_pfn,
 {
 	unsigned long end_pfn = start_pfn + nr_pages;
 
-	return alloc_contig_range(start_pfn, end_pfn, MIGRATE_MOVABLE,
-				  gfp_mask);
+	return alloc_contig_range(start_pfn, end_pfn, MIGRATE_FREE, gfp_mask);
 }
 
 static bool pfn_range_valid_contig(struct zone *z, unsigned long start_pfn,
-- 
2.39.2

