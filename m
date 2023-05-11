Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 051066FEC10
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 08:58:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237319AbjEKG5o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 02:57:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237290AbjEKG5G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 02:57:06 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E646F65A4
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 23:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683788222; x=1715324222;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RtpJnJoiDOQL8uVnT1eOMbez+/iH4nG6NJyM/c5vcVE=;
  b=DY+retuuKe5x0HAOS1wlf5dETb89K+kLv6DJoOFiQtPqnXCE6IkbU5v2
   K//sn9v2pYFYVcd55j6VYBvN3EUIl38c5lWFWVoNd5B81TkigUFcQrYwh
   mQyeooWPM3vO0YsKNdb4eG/EyAK1+90qZq0w6YaT8yF32d172CSQTZYbB
   Mi+AX9T/Ir5KTtGmLxpaPX2My7BMRynI+c0+zm9lmdxs3WWT8xDzfN2qx
   xVu0sKZ1EPvDz2L+y5Y2vjsa+jCiWqTsRwz/3mx2w0400jbV5j/WbLgRo
   fPOTYmjV5xBHYBn+L8BkU+2XBcWVgh+F3aFNJjoeV7MTvlPRXwuJ938ja
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10706"; a="436744489"
X-IronPort-AV: E=Sophos;i="5.99,266,1677571200"; 
   d="scan'208";a="436744489"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2023 23:56:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10706"; a="823855265"
X-IronPort-AV: E=Sophos;i="5.99,266,1677571200"; 
   d="scan'208";a="823855265"
Received: from chaoyan1-mobl2.ccr.corp.intel.com (HELO yhuang6-mobl2.ccr.corp.intel.com) ([10.255.31.95])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2023 23:56:36 -0700
From:   Huang Ying <ying.huang@intel.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        Arjan Van De Ven <arjan@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Huang Ying <ying.huang@intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Johannes Weiner <jweiner@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: [RFC 2/6] mm: add struct zone_type_struct to describe zone type
Date:   Thu, 11 May 2023 14:56:03 +0800
Message-Id: <20230511065607.37407-3-ying.huang@intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230511065607.37407-1-ying.huang@intel.com>
References: <20230511065607.37407-1-ying.huang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Multiple zone instances may be created for one zone type in the
following patch in series.  After that, struct zone is used to
describe zone instance only.  To describe zone type, another data
structure (struct zone_type_struct) is defined in this patch.  The
most important information used during run time is the start and last
zone indexes (start/last_zone_idx) of all zone instances of a zone
type in a NUMA node.  Other fields are used during system
initialization to initialize struct zone.

The zone fields in page->flags are used for zone instance index.  So,
the zone type of a page needs to be gotten via struct zone.

Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: David Hildenbrand <david@redhat.com>
Cc: Johannes Weiner <jweiner@redhat.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
Cc: Matthew Wilcox <willy@infradead.org>
---
 include/linux/mm.h     |  36 --------
 include/linux/mmzone.h | 195 ++++++++++++++++++++++++++++-------------
 mm/page_alloc.c        |  92 ++++++++++++++-----
 3 files changed, 203 insertions(+), 120 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index f159a0c61bfd..ab867b719ffa 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1454,22 +1454,6 @@ static inline int page_zone_id(struct page *page)
 	return (page->flags >> ZONEID_PGSHIFT) & ZONEID_MASK;
 }
 
-#ifdef NODE_NOT_IN_PAGE_FLAGS
-extern int page_to_nid(const struct page *page);
-#else
-static inline int page_to_nid(const struct page *page)
-{
-	struct page *p = (struct page *)page;
-
-	return (PF_POISONED_CHECK(p)->flags >> NODES_PGSHIFT) & NODES_MASK;
-}
-#endif
-
-static inline int folio_nid(const struct folio *folio)
-{
-	return page_to_nid(&folio->page);
-}
-
 #ifdef CONFIG_NUMA_BALANCING
 /* page access time bits needs to hold at least 4 seconds */
 #define PAGE_ACCESS_TIME_MIN_BITS	12
@@ -1659,26 +1643,6 @@ static inline void page_kasan_tag_reset(struct page *page) { }
 
 #endif /* CONFIG_KASAN_SW_TAGS || CONFIG_KASAN_HW_TAGS */
 
-static inline struct zone *page_zone(const struct page *page)
-{
-	return &NODE_DATA(page_to_nid(page))->node_zones[page_zone_idx(page)];
-}
-
-static inline pg_data_t *page_pgdat(const struct page *page)
-{
-	return NODE_DATA(page_to_nid(page));
-}
-
-static inline struct zone *folio_zone(const struct folio *folio)
-{
-	return page_zone(&folio->page);
-}
-
-static inline pg_data_t *folio_pgdat(const struct folio *folio)
-{
-	return page_pgdat(&folio->page);
-}
-
 #ifdef SECTION_IN_PAGE_FLAGS
 static inline void set_page_section(struct page *page, unsigned long section)
 {
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index b269a05d5a97..0c569c5fa0d1 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -806,6 +806,8 @@ enum zone_type {
 
 #define ASYNC_AND_SYNC 2
 
+struct zone_type_struct;
+
 struct zone {
 	/* Read-mostly fields */
 
@@ -829,6 +831,7 @@ struct zone {
 #ifdef CONFIG_NUMA
 	int node;
 #endif
+	enum zone_type type;
 	struct pglist_data	*zone_pgdat;
 	struct per_cpu_pages	__percpu *per_cpu_pageset;
 	struct per_cpu_zonestat	__percpu *per_cpu_zonestats;
@@ -1080,75 +1083,13 @@ static inline int page_zone_idx(const struct page *page)
 	return (page->flags >> ZONES_PGSHIFT) & ZONES_MASK;
 }
 
-static inline enum zone_type page_zone_type(const struct page *page)
-{
-	return page_zone_idx(page);
-}
-
 static inline int folio_zone_idx(const struct folio *folio)
 {
 	return page_zone_idx(&folio->page);
 }
 
-static inline enum zone_type folio_zone_type(const struct folio *folio)
-{
-	return page_zone_type(&folio->page);
-}
-
-#ifdef CONFIG_ZONE_DEVICE
-static inline bool is_zone_device_page(const struct page *page)
-{
-	return page_zone_type(page) == ZONE_DEVICE;
-}
-
-/*
- * Consecutive zone device pages should not be merged into the same sgl
- * or bvec segment with other types of pages or if they belong to different
- * pgmaps. Otherwise getting the pgmap of a given segment is not possible
- * without scanning the entire segment. This helper returns true either if
- * both pages are not zone device pages or both pages are zone device pages
- * with the same pgmap.
- */
-static inline bool zone_device_pages_have_same_pgmap(const struct page *a,
-						     const struct page *b)
-{
-	if (is_zone_device_page(a) != is_zone_device_page(b))
-		return false;
-	if (!is_zone_device_page(a))
-		return true;
-	return a->pgmap == b->pgmap;
-}
-
-extern void memmap_init_zone_device(struct zone *, unsigned long,
-				    unsigned long, struct dev_pagemap *);
-#else
-static inline bool is_zone_device_page(const struct page *page)
-{
-	return false;
-}
-static inline bool zone_device_pages_have_same_pgmap(const struct page *a,
-						     const struct page *b)
-{
-	return true;
-}
 #endif
 
-static inline bool folio_is_zone_device(const struct folio *folio)
-{
-	return is_zone_device_page(&folio->page);
-}
-
-static inline bool is_zone_movable_page(const struct page *page)
-{
-	return page_zone_type(page) == ZONE_MOVABLE;
-}
-#endif
-
-static inline int last_zone_idx(struct pglist_data *pgdat, enum zone_type zt)
-{
-	return zt;
-}
-
 /*
  * Return true if [start_pfn, start_pfn + nr_pages) range has a non-empty
  * intersection with the given zone
@@ -1165,6 +1106,18 @@ static inline bool zone_intersects(struct zone *zone,
 	return true;
 }
 
+struct zone_type_struct {
+	int			start_zone_idx;
+	int			last_zone_idx;
+	unsigned long		zts_start_pfn;
+	unsigned long		spanned_pages;
+	unsigned long		present_pages;
+#if defined(CONFIG_MEMORY_HOTPLUG)
+	unsigned long		present_early_pages;
+#endif
+	long zts_lowmem_reserve[MAX_NR_ZONE_TYPES];
+};
+
 /*
  * The "priority" of VM scanning is how much of the queues we will scan in one
  * go. A value of 12 for DEF_PRIORITY implies that we will scan 1/4096th of the
@@ -1263,6 +1216,7 @@ struct memory_failure_stats {
  * per-zone basis.
  */
 typedef struct pglist_data {
+	struct zone_type_struct node_zone_types[MAX_NR_ZONE_TYPES];
 	/*
 	 * node_zones contains just the zones for THIS node. Not all of the
 	 * zones may be populated, but it is the full list. It is referenced by
@@ -1463,7 +1417,7 @@ static inline int local_memory_node(int node_id) { return node_id; };
 /*
  * zone_type_num() returns 0 for the ZONE_DMA zone, 1 for the ZONE_NORMAL zone, etc.
  */
-#define zone_type_num(zone)	zone_idx(zone)
+#define zone_type_num(zone)	((zone)->type)
 
 #ifdef CONFIG_ZONE_DEVICE
 static inline bool zone_is_zone_device(struct zone *zone)
@@ -1739,6 +1693,121 @@ static inline bool movable_only_nodes(nodemask_t *nodes)
 	return (!z->zone) ? true : false;
 }
 
+#ifndef BUILD_VDSO32_64
+#ifdef NODE_NOT_IN_PAGE_FLAGS
+extern int page_to_nid(const struct page *page);
+#else
+static inline int page_to_nid(const struct page *page)
+{
+	struct page *p = (struct page *)page;
+
+	return (PF_POISONED_CHECK(p)->flags >> NODES_PGSHIFT) & NODES_MASK;
+}
+#endif
+
+static inline int folio_nid(const struct folio *folio)
+{
+	return page_to_nid(&folio->page);
+}
+
+static inline struct zone *page_zone(const struct page *page)
+{
+	return &NODE_DATA(page_to_nid(page))->node_zones[page_zone_idx(page)];
+}
+
+static inline enum zone_type page_zone_type(const struct page *page)
+{
+	return page_zone(page)->type;
+}
+
+static inline pg_data_t *page_pgdat(const struct page *page)
+{
+	return NODE_DATA(page_to_nid(page));
+}
+
+static inline struct zone_type_struct *page_zone_type_struct(const struct page *page)
+{
+	return &page_pgdat(page)->node_zone_types[page_zone(page)->type];
+}
+
+static inline struct zone *folio_zone(const struct folio *folio)
+{
+	return page_zone(&folio->page);
+}
+
+static inline enum zone_type folio_zone_type(const struct folio *folio)
+{
+	return page_zone_type(&folio->page);
+}
+
+static inline pg_data_t *folio_pgdat(const struct folio *folio)
+{
+	return page_pgdat(&folio->page);
+}
+
+static inline struct zone_type_struct *folio_zone_type_struct(const struct folio *folio)
+{
+	return page_zone_type_struct(&folio->page);
+}
+
+#ifdef CONFIG_ZONE_DEVICE
+static inline bool is_zone_device_page(const struct page *page)
+{
+	return page_zone_type(page) == ZONE_DEVICE;
+}
+
+/*
+ * Consecutive zone device pages should not be merged into the same sgl
+ * or bvec segment with other types of pages or if they belong to different
+ * pgmaps. Otherwise getting the pgmap of a given segment is not possible
+ * without scanning the entire segment. This helper returns true either if
+ * both pages are not zone device pages or both pages are zone device pages
+ * with the same pgmap.
+ */
+static inline bool zone_device_pages_have_same_pgmap(const struct page *a,
+						     const struct page *b)
+{
+	if (is_zone_device_page(a) != is_zone_device_page(b))
+		return false;
+	if (!is_zone_device_page(a))
+		return true;
+	return a->pgmap == b->pgmap;
+}
+
+extern void memmap_init_zone_device(struct zone *, unsigned long,
+				    unsigned long, struct dev_pagemap *);
+#else
+static inline bool is_zone_device_page(const struct page *page)
+{
+	return false;
+}
+static inline bool zone_device_pages_have_same_pgmap(const struct page *a,
+						     const struct page *b)
+{
+	return true;
+}
+#endif
+
+static inline bool folio_is_zone_device(const struct folio *folio)
+{
+	return is_zone_device_page(&folio->page);
+}
+
+static inline bool is_zone_movable_page(const struct page *page)
+{
+	return page_zone_type(page) == ZONE_MOVABLE;
+}
+#endif /* BUILD_VDSO32_64 */
+
+static inline int start_zone_idx(pg_data_t *pgdat, enum zone_type zt)
+{
+	return pgdat->node_zone_types[zt].start_zone_idx;
+}
+
+static inline int last_zone_idx(pg_data_t *pgdat, enum zone_type zt)
+{
+	return pgdat->node_zone_types[zt].last_zone_idx;
+}
 
 #ifdef CONFIG_SPARSEMEM
 #include <asm/sparsemem.h>
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 04a3af90a5a8..11e7e182bf5c 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -7609,17 +7609,17 @@ static void __init calculate_node_totalpages(struct pglist_data *pgdat,
 	unsigned long realtotalpages = 0, totalpages = 0;
 	enum zone_type i;
 
-	for (i = 0; i < MAX_NR_ZONES; i++) {
-		struct zone *zone = pgdat->node_zones + i;
-		unsigned long zone_start_pfn, zone_end_pfn;
+	for (i = 0; i < MAX_NR_ZONE_TYPES; i++) {
+		struct zone_type_struct *zts = pgdat->node_zone_types + i;
+		unsigned long zts_start_pfn, zts_end_pfn;
 		unsigned long spanned, absent;
 		unsigned long size, real_size;
 
 		spanned = zone_spanned_pages_in_node(pgdat->node_id, i,
 						     node_start_pfn,
 						     node_end_pfn,
-						     &zone_start_pfn,
-						     &zone_end_pfn);
+						     &zts_start_pfn,
+						     &zts_end_pfn);
 		absent = zone_absent_pages_in_node(pgdat->node_id, i,
 						   node_start_pfn,
 						   node_end_pfn);
@@ -7628,13 +7628,13 @@ static void __init calculate_node_totalpages(struct pglist_data *pgdat,
 		real_size = size - absent;
 
 		if (size)
-			zone->zone_start_pfn = zone_start_pfn;
+			zts->zts_start_pfn = zts_start_pfn;
 		else
-			zone->zone_start_pfn = 0;
-		zone->spanned_pages = size;
-		zone->present_pages = real_size;
+			zts->zts_start_pfn = 0;
+		zts->spanned_pages = size;
+		zts->present_pages = real_size;
 #if defined(CONFIG_MEMORY_HOTPLUG)
-		zone->present_early_pages = real_size;
+		zts->present_early_pages = real_size;
 #endif
 
 		totalpages += size;
@@ -7836,6 +7836,27 @@ void __ref free_area_init_core_hotplug(struct pglist_data *pgdat)
 }
 #endif
 
+static void __init zones_init(struct pglist_data *pgdat)
+{
+	enum zone_type j;
+	struct zone_type_struct *zts;
+	struct zone *zone;
+
+	for (j = 0; j < MAX_NR_ZONE_TYPES; j++) {
+		zts = pgdat->node_zone_types + j;
+		zone = pgdat->node_zones + j;
+
+		zts->start_zone_idx = zts->last_zone_idx = zone - pgdat->node_zones;
+		zone->type = j;
+		zone->zone_start_pfn = zts->zts_start_pfn;
+		zone->spanned_pages = zts->spanned_pages;
+		zone->present_pages = zts->present_pages;
+#if defined(CONFIG_MEMORY_HOTPLUG)
+		zone->present_early_pages = zts->present_early_pages;
+#endif
+	}
+}
+
 /*
  * Set up the zone data structures:
  *   - mark all pages reserved
@@ -7847,13 +7868,13 @@ void __ref free_area_init_core_hotplug(struct pglist_data *pgdat)
  */
 static void __init free_area_init_core(struct pglist_data *pgdat)
 {
-	enum zone_type j;
+	int j;
 	int nid = pgdat->node_id;
 
 	pgdat_init_internals(pgdat);
 	pgdat->per_cpu_nodestats = &boot_nodestats;
 
-	for (j = 0; j < MAX_NR_ZONE_TYPES; j++) {
+	for (j = 0; j < MAX_NR_ZONES; j++) {
 		struct zone *zone = pgdat->node_zones + j;
 		unsigned long size, freesize, memmap_pages;
 
@@ -7866,7 +7887,7 @@ static void __init free_area_init_core(struct pglist_data *pgdat)
 		 * and per-cpu initialisations
 		 */
 		memmap_pages = calc_memmap_size(size, freesize);
-		if (!is_highmem_type(j)) {
+		if (!is_highmem(zone)) {
 			if (freesize >= memmap_pages) {
 				freesize -= memmap_pages;
 				if (memmap_pages)
@@ -7883,7 +7904,7 @@ static void __init free_area_init_core(struct pglist_data *pgdat)
 			pr_debug("  %s zone: %lu pages reserved\n", zone_names[0], dma_reserve);
 		}
 
-		if (!is_highmem_type(j))
+		if (!is_highmem(zone))
 			nr_kernel_pages += freesize;
 		/* Charge for highmem memmap if there are enough kernel pages */
 		else if (nr_kernel_pages > memmap_pages * 2)
@@ -7895,7 +7916,7 @@ static void __init free_area_init_core(struct pglist_data *pgdat)
 		 * when the bootmem allocator frees pages into the buddy system.
 		 * And all highmem pages will be managed by the buddy system.
 		 */
-		zone_init_internals(zone, j, nid, freesize);
+		zone_init_internals(zone, zone_type_num(zone), nid, freesize);
 
 		if (!size)
 			continue;
@@ -7993,6 +8014,7 @@ static void __init free_area_init_node(int nid)
 	alloc_node_mem_map(pgdat);
 	pgdat_set_deferred_range(pgdat);
 
+	zones_init(pgdat);
 	free_area_init_core(pgdat);
 	lru_gen_init_pgdat(pgdat);
 }
@@ -8742,6 +8764,17 @@ static void calculate_totalreserve_pages(void)
 	totalreserve_pages = reserve_pages;
 }
 
+static unsigned long zts_managed_pages(pg_data_t *pgdat, struct zone_type_struct *zts)
+{
+	unsigned long managed_pages = 0;
+	int i;
+
+	for (i = zts->start_zone_idx; i <= zts->last_zone_idx; i++)
+		managed_pages += zone_managed_pages(pgdat->node_zones + i);
+
+	return managed_pages;
+}
+
 /*
  * setup_per_zone_lowmem_reserve - called whenever
  *	sysctl_lowmem_reserve_ratio changes.  Ensures that each zone
@@ -8755,20 +8788,37 @@ static void setup_per_zone_lowmem_reserve(void)
 
 	for_each_online_pgdat(pgdat) {
 		for (i = 0; i < MAX_NR_ZONE_TYPES - 1; i++) {
-			struct zone *zone = &pgdat->node_zones[i];
+			struct zone_type_struct *zts = &pgdat->node_zone_types[i];
 			int ratio = sysctl_lowmem_reserve_ratio[i];
-			bool clear = !ratio || !zone_managed_pages(zone);
+			bool clear = !ratio || !zts_managed_pages(pgdat, zts);
 			unsigned long managed_pages = 0;
 
 			for (j = i + 1; j < MAX_NR_ZONE_TYPES; j++) {
-				struct zone *upper_zone = &pgdat->node_zones[j];
+				struct zone_type_struct *upper_zts =
+					&pgdat->node_zone_types[j];
 
-				managed_pages += zone_managed_pages(upper_zone);
+				managed_pages += zts_managed_pages(pgdat, upper_zts);
 
 				if (clear)
-					zone->lowmem_reserve[j] = 0;
+					zts->zts_lowmem_reserve[j] = 0;
 				else
-					zone->lowmem_reserve[j] = managed_pages / ratio;
+					zts->zts_lowmem_reserve[j] = managed_pages / ratio;
+			}
+		}
+	}
+
+	for_each_online_pgdat(pgdat) {
+		for (i = 0; i < MAX_NR_ZONE_TYPES; i++) {
+			struct zone_type_struct *zts = &pgdat->node_zone_types[i];
+			int k, nr_zones;
+
+			nr_zones = zts->last_zone_idx - zts->start_zone_idx + 1;
+			for (k = zts->start_zone_idx; k <= zts->last_zone_idx; k++) {
+				struct zone *zone = pgdat->node_zones + k;
+
+				for (j = i + 1; j < MAX_NR_ZONE_TYPES; j++)
+					zone->lowmem_reserve[j] =
+						zts->zts_lowmem_reserve[j] / nr_zones;
 			}
 		}
 	}
-- 
2.39.2

