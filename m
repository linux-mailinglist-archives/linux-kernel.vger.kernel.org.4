Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A52B6FEC11
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 08:58:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237375AbjEKG5v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 02:57:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237209AbjEKG5H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 02:57:07 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78AF165A0
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 23:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683788222; x=1715324222;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0fpIlmEmhQzZhdjZIu/GLjRIRbkhithDNZ+WoYQQvaU=;
  b=FYclZn/co8HlhA1FiqNnru5qgHCJGZ0sW+eHi2uWKOBLfQMzKNOc8Ixg
   owLLIpG3BRJ49BxqNBQ6P10NFQL1HIm8vFxHj4dwH23Vu10T/MY1qdlWi
   28hIWkxzUpoTh2fKce8Gz4KhSy3R1sUu9WHzLCLoZKPjJGZxv/rdutoZ1
   Szinj9ydmGxnjWqJ5UWQW/ozdAMx9GwukF1+lhcHDWXnzMbdItPEk47kz
   +0kcUtPSmxbDlYmsPxBv1fIB6fw4CkmHP/8z7ubp/qdI+Yf7t49DVQ+2A
   WOwIWJrijvrGufRwBlFUwY7cI6X/fqAEEh+Hg6bUR452fkpjkrjF3atNt
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10706"; a="436744475"
X-IronPort-AV: E=Sophos;i="5.99,266,1677571200"; 
   d="scan'208";a="436744475"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2023 23:56:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10706"; a="823855248"
X-IronPort-AV: E=Sophos;i="5.99,266,1677571200"; 
   d="scan'208";a="823855248"
Received: from chaoyan1-mobl2.ccr.corp.intel.com (HELO yhuang6-mobl2.ccr.corp.intel.com) ([10.255.31.95])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2023 23:56:32 -0700
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
Subject: [RFC 1/6] mm: distinguish zone type and zone instance explicitly
Date:   Thu, 11 May 2023 14:56:02 +0800
Message-Id: <20230511065607.37407-2-ying.huang@intel.com>
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

In current kernel, there is only 1 zone instance at most for each zone
type in each NUMA node.  So, zone type and zone instance are used
inter-changeable in source code.  For example, to specify the highest
zone type to reclaim pages from via kswapd, there is
"kswapd_highest_zoneidx" instead of "kswapd_highest_zone_type" field
in struct pglist_data.

In the following patch in this series, multiple zone instances may be
created for one zone type.  So, in this patch, the zone instance and
zone type usage in source code are checked and changed if necessary to
distinguish them explicitly.

Although the line number of the patch is large, it only makes changes
mechanically.

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
 arch/x86/mm/init.c                |   2 +-
 drivers/crypto/omap-crypto.c      |   2 +-
 drivers/crypto/omap-sham.c        |   2 +-
 drivers/virtio/virtio_mem.c       |   2 +-
 include/linux/compaction.h        |   8 +-
 include/linux/gfp.h               |   4 +-
 include/linux/mm.h                |   6 +-
 include/linux/mm_inline.h         |  10 +-
 include/linux/mmzone.h            | 112 +++++++++-------
 include/linux/page-flags-layout.h |  12 ++
 include/linux/page-flags.h        |   4 +-
 include/linux/vmstat.h            |   4 +-
 include/trace/events/oom.h        |   6 +-
 kernel/bounds.c                   |   1 +
 lib/show_mem.c                    |   2 +-
 mm/compaction.c                   |  58 ++++-----
 mm/internal.h                     |  18 +--
 mm/memory_hotplug.c               |  36 +++---
 mm/mempolicy.c                    |   4 +-
 mm/memremap.c                     |   6 +-
 mm/migrate.c                      |   6 +-
 mm/mmzone.c                       |   8 +-
 mm/oom_kill.c                     |   4 +-
 mm/page-writeback.c               |   9 +-
 mm/page_alloc.c                   | 190 ++++++++++++++-------------
 mm/page_isolation.c               |   2 +-
 mm/shmem.c                        |   2 +-
 mm/slab.c                         |   4 +-
 mm/slub.c                         |   4 +-
 mm/vmscan.c                       | 205 ++++++++++++++++--------------
 30 files changed, 397 insertions(+), 336 deletions(-)

diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
index cb258f58fdc8..83e174df1391 100644
--- a/arch/x86/mm/init.c
+++ b/arch/x86/mm/init.c
@@ -1024,7 +1024,7 @@ void __init memblock_find_dma_reserve(void)
 
 void __init zone_sizes_init(void)
 {
-	unsigned long max_zone_pfns[MAX_NR_ZONES];
+	unsigned long max_zone_pfns[MAX_NR_ZONE_TYPES];
 
 	memset(max_zone_pfns, 0, sizeof(max_zone_pfns));
 
diff --git a/drivers/crypto/omap-crypto.c b/drivers/crypto/omap-crypto.c
index a4cc6bf146ec..f6bba1fc1ff9 100644
--- a/drivers/crypto/omap-crypto.c
+++ b/drivers/crypto/omap-crypto.c
@@ -102,7 +102,7 @@ static int omap_crypto_check_sg(struct scatterlist *sg, int total, int bs,
 		if (!IS_ALIGNED(sg->length, bs))
 			return OMAP_CRYPTO_NOT_ALIGNED;
 #ifdef CONFIG_ZONE_DMA
-		if (page_zonenum(sg_page(sg)) != ZONE_DMA)
+		if (page_zone_type(sg_page(sg)) != ZONE_DMA)
 			return OMAP_CRYPTO_NOT_ALIGNED;
 #endif
 
diff --git a/drivers/crypto/omap-sham.c b/drivers/crypto/omap-sham.c
index cbeda59c6b19..d2c4f3a2c2f4 100644
--- a/drivers/crypto/omap-sham.c
+++ b/drivers/crypto/omap-sham.c
@@ -782,7 +782,7 @@ static int omap_sham_align_sgs(struct scatterlist *sg,
 		}
 
 #ifdef CONFIG_ZONE_DMA
-		if (page_zonenum(sg_page(sg_tmp)) != ZONE_DMA) {
+		if (page_zone_type(sg_page(sg_tmp)) != ZONE_DMA) {
 			aligned = false;
 			break;
 		}
diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
index 0c2892ec6817..4fdb3e3e3b5e 100644
--- a/drivers/virtio/virtio_mem.c
+++ b/drivers/virtio/virtio_mem.c
@@ -2201,7 +2201,7 @@ static bool virtio_mem_bbm_bb_is_movable(struct virtio_mem *vm,
 		page = pfn_to_online_page(pfn);
 		if (!page)
 			continue;
-		if (page_zonenum(page) != ZONE_MOVABLE)
+		if (page_zone_type(page) != ZONE_MOVABLE)
 			return false;
 	}
 
diff --git a/include/linux/compaction.h b/include/linux/compaction.h
index 52a9ff65faee..0a75f8764c03 100644
--- a/include/linux/compaction.h
+++ b/include/linux/compaction.h
@@ -97,7 +97,7 @@ extern enum compact_result try_to_compact_pages(gfp_t gfp_mask,
 		struct page **page);
 extern void reset_isolation_suitable(pg_data_t *pgdat);
 extern enum compact_result compaction_suitable(struct zone *zone, int order,
-		unsigned int alloc_flags, int highest_zoneidx);
+		unsigned int alloc_flags, enum zone_type highest_zone_type);
 
 extern void compaction_defer_reset(struct zone *zone, int order,
 				bool alloc_success);
@@ -179,7 +179,7 @@ bool compaction_zonelist_suitable(struct alloc_context *ac, int order,
 
 extern void kcompactd_run(int nid);
 extern void kcompactd_stop(int nid);
-extern void wakeup_kcompactd(pg_data_t *pgdat, int order, int highest_zoneidx);
+extern void wakeup_kcompactd(pg_data_t *pgdat, int order, enum zone_type highest_zone_type);
 
 #else
 static inline void reset_isolation_suitable(pg_data_t *pgdat)
@@ -187,7 +187,7 @@ static inline void reset_isolation_suitable(pg_data_t *pgdat)
 }
 
 static inline enum compact_result compaction_suitable(struct zone *zone, int order,
-					int alloc_flags, int highest_zoneidx)
+					int alloc_flags, enum zone_type highest_zone_type)
 {
 	return COMPACT_SKIPPED;
 }
@@ -220,7 +220,7 @@ static inline void kcompactd_stop(int nid)
 }
 
 static inline void wakeup_kcompactd(pg_data_t *pgdat,
-				int order, int highest_zoneidx)
+				int order, enum zone_type highest_zone_type)
 {
 }
 
diff --git a/include/linux/gfp.h b/include/linux/gfp.h
index 65a78773dcca..60b5f43792ec 100644
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -87,11 +87,11 @@ static inline bool gfpflags_allow_blocking(const gfp_t gfp_flags)
  * GFP_ZONES_SHIFT must be <= 2 on 32 bit platforms.
  */
 
-#if defined(CONFIG_ZONE_DEVICE) && (MAX_NR_ZONES-1) <= 4
+#if defined(CONFIG_ZONE_DEVICE) && (MAX_NR_ZONE_TYPES-1) <= 4
 /* ZONE_DEVICE is not a valid GFP zone specifier */
 #define GFP_ZONES_SHIFT 2
 #else
-#define GFP_ZONES_SHIFT ZONES_SHIFT
+#define GFP_ZONES_SHIFT ZONE_TYPES_SHIFT
 #endif
 
 #if 16 * GFP_ZONES_SHIFT > BITS_PER_LONG
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 1f79667824eb..f159a0c61bfd 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1661,7 +1661,7 @@ static inline void page_kasan_tag_reset(struct page *page) { }
 
 static inline struct zone *page_zone(const struct page *page)
 {
-	return &NODE_DATA(page_to_nid(page))->node_zones[page_zonenum(page)];
+	return &NODE_DATA(page_to_nid(page))->node_zones[page_zone_idx(page)];
 }
 
 static inline pg_data_t *page_pgdat(const struct page *page)
@@ -2840,7 +2840,7 @@ static inline unsigned long get_num_physpages(void)
  * free_area_init() passing in the PFN each zone ends at. At a basic
  * usage, an architecture is expected to do something like
  *
- * unsigned long max_zone_pfns[MAX_NR_ZONES] = {max_dma, max_normal_pfn,
+ * unsigned long max_zone_pfns[MAX_NR_ZONE_TYPES] = {max_dma, max_normal_pfn,
  * 							 max_highmem_pfn};
  * for_each_valid_physical_page_range()
  *	memblock_add_node(base, size, nid, MEMBLOCK_NONE)
@@ -2866,7 +2866,7 @@ extern int __meminit early_pfn_to_nid(unsigned long pfn);
 #endif
 
 extern void set_dma_reserve(unsigned long new_dma_reserve);
-extern void memmap_init_range(unsigned long, int, unsigned long,
+extern void memmap_init_range(unsigned long, int, enum zone_type, unsigned long,
 		unsigned long, unsigned long, enum meminit_context,
 		struct vmem_altmap *, int migratetype);
 extern void setup_per_zone_wmarks(void);
diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
index de1e622dd366..03d4dc39a891 100644
--- a/include/linux/mm_inline.h
+++ b/include/linux/mm_inline.h
@@ -175,7 +175,7 @@ static inline void lru_gen_update_size(struct lruvec *lruvec, struct folio *foli
 				       int old_gen, int new_gen)
 {
 	int type = folio_is_file_lru(folio);
-	int zone = folio_zonenum(folio);
+	int zone = folio_zone_idx(folio);
 	int delta = folio_nr_pages(folio);
 	enum lru_list lru = type * LRU_INACTIVE_FILE;
 	struct lru_gen_folio *lrugen = &lruvec->lrugen;
@@ -223,7 +223,7 @@ static inline bool lru_gen_add_folio(struct lruvec *lruvec, struct folio *folio,
 	unsigned long flags;
 	int gen = folio_lru_gen(folio);
 	int type = folio_is_file_lru(folio);
-	int zone = folio_zonenum(folio);
+	int zone = folio_zone_idx(folio);
 	struct lru_gen_folio *lrugen = &lruvec->lrugen;
 
 	VM_WARN_ON_ONCE_FOLIO(gen != -1, folio);
@@ -317,7 +317,7 @@ void lruvec_add_folio(struct lruvec *lruvec, struct folio *folio)
 	if (lru_gen_add_folio(lruvec, folio, false))
 		return;
 
-	update_lru_size(lruvec, lru, folio_zonenum(folio),
+	update_lru_size(lruvec, lru, folio_zone_idx(folio),
 			folio_nr_pages(folio));
 	if (lru != LRU_UNEVICTABLE)
 		list_add(&folio->lru, &lruvec->lists[lru]);
@@ -337,7 +337,7 @@ void lruvec_add_folio_tail(struct lruvec *lruvec, struct folio *folio)
 	if (lru_gen_add_folio(lruvec, folio, true))
 		return;
 
-	update_lru_size(lruvec, lru, folio_zonenum(folio),
+	update_lru_size(lruvec, lru, folio_zone_idx(folio),
 			folio_nr_pages(folio));
 	/* This is not expected to be used on LRU_UNEVICTABLE */
 	list_add_tail(&folio->lru, &lruvec->lists[lru]);
@@ -353,7 +353,7 @@ void lruvec_del_folio(struct lruvec *lruvec, struct folio *folio)
 
 	if (lru != LRU_UNEVICTABLE)
 		list_del(&folio->lru);
-	update_lru_size(lruvec, lru, folio_zonenum(folio),
+	update_lru_size(lruvec, lru, folio_zone_idx(folio),
 			-folio_nr_pages(folio));
 }
 
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 9fb1b03b83b2..b269a05d5a97 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -796,10 +796,12 @@ enum zone_type {
 #ifdef CONFIG_ZONE_DEVICE
 	ZONE_DEVICE,
 #endif
-	__MAX_NR_ZONES
+	__MAX_NR_ZONE_TYPES
 
 };
 
+#define __MAX_NR_ZONES	__MAX_NR_ZONE_TYPES
+
 #ifndef __GENERATING_BOUNDS_H
 
 #define ASYNC_AND_SYNC 2
@@ -822,7 +824,7 @@ struct zone {
 	 * recalculated at runtime if the sysctl_lowmem_reserve_ratio sysctl
 	 * changes.
 	 */
-	long lowmem_reserve[MAX_NR_ZONES];
+	long lowmem_reserve[MAX_NR_ZONE_TYPES];
 
 #ifdef CONFIG_NUMA
 	int node;
@@ -1072,21 +1074,31 @@ static inline bool zone_is_empty(struct zone *zone)
 #define KASAN_TAG_MASK		((1UL << KASAN_TAG_WIDTH) - 1)
 #define ZONEID_MASK		((1UL << ZONEID_SHIFT) - 1)
 
-static inline enum zone_type page_zonenum(const struct page *page)
+static inline int page_zone_idx(const struct page *page)
 {
 	ASSERT_EXCLUSIVE_BITS(page->flags, ZONES_MASK << ZONES_PGSHIFT);
 	return (page->flags >> ZONES_PGSHIFT) & ZONES_MASK;
 }
 
-static inline enum zone_type folio_zonenum(const struct folio *folio)
+static inline enum zone_type page_zone_type(const struct page *page)
 {
-	return page_zonenum(&folio->page);
+	return page_zone_idx(page);
+}
+
+static inline int folio_zone_idx(const struct folio *folio)
+{
+	return page_zone_idx(&folio->page);
+}
+
+static inline enum zone_type folio_zone_type(const struct folio *folio)
+{
+	return page_zone_type(&folio->page);
 }
 
 #ifdef CONFIG_ZONE_DEVICE
 static inline bool is_zone_device_page(const struct page *page)
 {
-	return page_zonenum(page) == ZONE_DEVICE;
+	return page_zone_type(page) == ZONE_DEVICE;
 }
 
 /*
@@ -1128,10 +1140,15 @@ static inline bool folio_is_zone_device(const struct folio *folio)
 
 static inline bool is_zone_movable_page(const struct page *page)
 {
-	return page_zonenum(page) == ZONE_MOVABLE;
+	return page_zone_type(page) == ZONE_MOVABLE;
 }
 #endif
 
+static inline int last_zone_idx(struct pglist_data *pgdat, enum zone_type zt)
+{
+	return zt;
+}
+
 /*
  * Return true if [start_pfn, start_pfn + nr_pages) range has a non-empty
  * intersection with the given zone
@@ -1176,7 +1193,7 @@ enum {
  */
 struct zoneref {
 	struct zone *zone;	/* Pointer to actual zone */
-	int zone_idx;		/* zone_idx(zoneref->zone) */
+	int zone_type;		/* zone_type_num(zoneref->zone) */
 };
 
 /*
@@ -1190,7 +1207,7 @@ struct zoneref {
  * a struct zoneref are
  *
  * zonelist_zone()	- Return the struct zone * for an entry in _zonerefs
- * zonelist_zone_idx()	- Return the index of the zone for an entry
+ * zonelist_zone_type()	- Return the type of the zone for an entry
  * zonelist_node_idx()	- Return the index of the node for an entry
  */
 struct zonelist {
@@ -1261,6 +1278,7 @@ typedef struct pglist_data {
 	struct zonelist node_zonelists[MAX_ZONELISTS];
 
 	int nr_zones; /* number of populated zones in this node */
+	int nr_zone_types;
 #ifdef CONFIG_FLATMEM	/* means !SPARSEMEM */
 	struct page *node_mem_map;
 #ifdef CONFIG_PAGE_EXTENSION
@@ -1301,13 +1319,13 @@ typedef struct pglist_data {
 #endif
 	struct task_struct *kswapd;	/* Protected by kswapd_lock */
 	int kswapd_order;
-	enum zone_type kswapd_highest_zoneidx;
+	enum zone_type kswapd_highest_zone_type;
 
 	int kswapd_failures;		/* Number of 'reclaimed == 0' runs */
 
 #ifdef CONFIG_COMPACTION
 	int kcompactd_max_order;
-	enum zone_type kcompactd_highest_zoneidx;
+	enum zone_type kcompactd_highest_zone_type;
 	wait_queue_head_t kcompactd_wait;
 	struct task_struct *kcompactd;
 	bool proactive_compact_trigger;
@@ -1402,15 +1420,15 @@ static inline unsigned long pgdat_end_pfn(pg_data_t *pgdat)
 
 void build_all_zonelists(pg_data_t *pgdat);
 void wakeup_kswapd(struct zone *zone, gfp_t gfp_mask, int order,
-		   enum zone_type highest_zoneidx);
+		   enum zone_type highest_zone_type);
 bool __zone_watermark_ok(struct zone *z, unsigned int order, unsigned long mark,
-			 int highest_zoneidx, unsigned int alloc_flags,
+			 enum zone_type highest_zone_type, unsigned int alloc_flags,
 			 long free_pages);
 bool zone_watermark_ok(struct zone *z, unsigned int order,
-		unsigned long mark, int highest_zoneidx,
+		unsigned long mark, enum zone_type highest_zone_type,
 		unsigned int alloc_flags);
 bool zone_watermark_ok_safe(struct zone *z, unsigned int order,
-		unsigned long mark, int highest_zoneidx);
+		unsigned long mark, enum zone_type highest_zone_type);
 /*
  * Memory initialization context, use to differentiate memory added by
  * the platform statically or via memory hotplug interface.
@@ -1440,15 +1458,17 @@ int local_memory_node(int node_id);
 static inline int local_memory_node(int node_id) { return node_id; };
 #endif
 
-/*
- * zone_idx() returns 0 for the ZONE_DMA zone, 1 for the ZONE_NORMAL zone, etc.
- */
 #define zone_idx(zone)		((zone) - (zone)->zone_pgdat->node_zones)
 
+/*
+ * zone_type_num() returns 0 for the ZONE_DMA zone, 1 for the ZONE_NORMAL zone, etc.
+ */
+#define zone_type_num(zone)	zone_idx(zone)
+
 #ifdef CONFIG_ZONE_DEVICE
 static inline bool zone_is_zone_device(struct zone *zone)
 {
-	return zone_idx(zone) == ZONE_DEVICE;
+	return zone_type_num(zone) == ZONE_DEVICE;
 }
 #else
 static inline bool zone_is_zone_device(struct zone *zone)
@@ -1495,11 +1515,11 @@ static inline void zone_set_nid(struct zone *zone, int nid) {}
 
 extern int movable_zone;
 
-static inline int is_highmem_idx(enum zone_type idx)
+static inline int is_highmem_type(enum zone_type type)
 {
 #ifdef CONFIG_HIGHMEM
-	return (idx == ZONE_HIGHMEM ||
-		(idx == ZONE_MOVABLE && movable_zone == ZONE_HIGHMEM));
+	return (type == ZONE_HIGHMEM ||
+		(type == ZONE_MOVABLE && movable_zone == ZONE_HIGHMEM));
 #else
 	return 0;
 #endif
@@ -1514,7 +1534,7 @@ static inline int is_highmem_idx(enum zone_type idx)
  */
 static inline int is_highmem(struct zone *zone)
 {
-	return is_highmem_idx(zone_idx(zone));
+	return is_highmem_type(zone_type_num(zone));
 }
 
 #ifdef CONFIG_ZONE_DMA
@@ -1533,7 +1553,7 @@ int min_free_kbytes_sysctl_handler(struct ctl_table *, int, void *, size_t *,
 		loff_t *);
 int watermark_scale_factor_sysctl_handler(struct ctl_table *, int, void *,
 		size_t *, loff_t *);
-extern int sysctl_lowmem_reserve_ratio[MAX_NR_ZONES];
+extern int sysctl_lowmem_reserve_ratio[MAX_NR_ZONE_TYPES];
 int lowmem_reserve_ratio_sysctl_handler(struct ctl_table *, int, void *,
 		size_t *, loff_t *);
 int percpu_pagelist_high_fraction_sysctl_handler(struct ctl_table *, int,
@@ -1599,9 +1619,9 @@ static inline struct zone *zonelist_zone(struct zoneref *zoneref)
 	return zoneref->zone;
 }
 
-static inline int zonelist_zone_idx(struct zoneref *zoneref)
+static inline int zonelist_zone_type(struct zoneref *zoneref)
 {
-	return zoneref->zone_idx;
+	return zoneref->zone_type;
 }
 
 static inline int zonelist_node_idx(struct zoneref *zoneref)
@@ -1610,13 +1630,13 @@ static inline int zonelist_node_idx(struct zoneref *zoneref)
 }
 
 struct zoneref *__next_zones_zonelist(struct zoneref *z,
-					enum zone_type highest_zoneidx,
+					enum zone_type highest_zone_type,
 					nodemask_t *nodes);
 
 /**
- * next_zones_zonelist - Returns the next zone at or below highest_zoneidx within the allowed nodemask using a cursor within a zonelist as a starting point
+ * next_zones_zonelist - Returns the next zone at or below highest_zone_type within the allowed nodemask using a cursor within a zonelist as a starting point
  * @z: The cursor used as a starting point for the search
- * @highest_zoneidx: The zone index of the highest zone to return
+ * @highest_zone_type: The highest zone type to return
  * @nodes: An optional nodemask to filter the zonelist with
  *
  * This function returns the next zone at or below a given zone index that is
@@ -1625,22 +1645,22 @@ struct zoneref *__next_zones_zonelist(struct zoneref *z,
  * being examined. It should be advanced by one before calling
  * next_zones_zonelist again.
  *
- * Return: the next zone at or below highest_zoneidx within the allowed
+ * Return: the next zone at or below highest_zone_type within the allowed
  * nodemask using a cursor within a zonelist as a starting point
  */
 static __always_inline struct zoneref *next_zones_zonelist(struct zoneref *z,
-					enum zone_type highest_zoneidx,
+					enum zone_type highest_zone_type,
 					nodemask_t *nodes)
 {
-	if (likely(!nodes && zonelist_zone_idx(z) <= highest_zoneidx))
+	if (likely(!nodes && zonelist_zone_type(z) <= highest_zone_type))
 		return z;
-	return __next_zones_zonelist(z, highest_zoneidx, nodes);
+	return __next_zones_zonelist(z, highest_zone_type, nodes);
 }
 
 /**
- * first_zones_zonelist - Returns the first zone at or below highest_zoneidx within the allowed nodemask in a zonelist
+ * first_zones_zonelist - Returns the first zone at or below highest_zone_type within the allowed nodemask in a zonelist
  * @zonelist: The zonelist to search for a suitable zone
- * @highest_zoneidx: The zone index of the highest zone to return
+ * @highest_zone_type: The highest zone type to return
  * @nodes: An optional nodemask to filter the zonelist with
  *
  * This function returns the first zone at or below a given zone index that is
@@ -1655,11 +1675,11 @@ static __always_inline struct zoneref *next_zones_zonelist(struct zoneref *z,
  * Return: Zoneref pointer for the first suitable zone found
  */
 static inline struct zoneref *first_zones_zonelist(struct zonelist *zonelist,
-					enum zone_type highest_zoneidx,
+					enum zone_type highest_zone_type,
 					nodemask_t *nodes)
 {
 	return next_zones_zonelist(zonelist->_zonerefs,
-							highest_zoneidx, nodes);
+							highest_zone_type, nodes);
 }
 
 /**
@@ -1667,22 +1687,22 @@ static inline struct zoneref *first_zones_zonelist(struct zonelist *zonelist,
  * @zone: The current zone in the iterator
  * @z: The current pointer within zonelist->_zonerefs being iterated
  * @zlist: The zonelist being iterated
- * @highidx: The zone index of the highest zone to return
+ * @high_type: The zone type of the highest zone to return
  * @nodemask: Nodemask allowed by the allocator
  *
  * This iterator iterates though all zones at or below a given zone index and
  * within a given nodemask
  */
-#define for_each_zone_zonelist_nodemask(zone, z, zlist, highidx, nodemask) \
-	for (z = first_zones_zonelist(zlist, highidx, nodemask), zone = zonelist_zone(z);	\
+#define for_each_zone_zonelist_nodemask(zone, z, zlist, high_type, nodemask) \
+	for (z = first_zones_zonelist(zlist, high_type, nodemask), zone = zonelist_zone(z);	\
 		zone;							\
-		z = next_zones_zonelist(++z, highidx, nodemask),	\
+		z = next_zones_zonelist(++z, high_type, nodemask),	\
 			zone = zonelist_zone(z))
 
-#define for_next_zone_zonelist_nodemask(zone, z, highidx, nodemask) \
+#define for_next_zone_zonelist_nodemask(zone, z, high_type, nodemask) \
 	for (zone = z->zone;	\
 		zone;							\
-		z = next_zones_zonelist(++z, highidx, nodemask),	\
+		z = next_zones_zonelist(++z, high_type, nodemask),	\
 			zone = zonelist_zone(z))
 
 
@@ -1691,12 +1711,12 @@ static inline struct zoneref *first_zones_zonelist(struct zonelist *zonelist,
  * @zone: The current zone in the iterator
  * @z: The current pointer within zonelist->zones being iterated
  * @zlist: The zonelist being iterated
- * @highidx: The zone index of the highest zone to return
+ * @high_type: The zone type of the highest zone to return
  *
  * This iterator iterates though all zones at or below a given zone index.
  */
-#define for_each_zone_zonelist(zone, z, zlist, highidx) \
-	for_each_zone_zonelist_nodemask(zone, z, zlist, highidx, NULL)
+#define for_each_zone_zonelist(zone, z, zlist, high_type)			\
+	for_each_zone_zonelist_nodemask(zone, z, zlist, high_type, NULL)
 
 /* Whether the 'nodes' are all movable nodes */
 static inline bool movable_only_nodes(nodemask_t *nodes)
diff --git a/include/linux/page-flags-layout.h b/include/linux/page-flags-layout.h
index 7d79818dc065..fcf194125768 100644
--- a/include/linux/page-flags-layout.h
+++ b/include/linux/page-flags-layout.h
@@ -12,6 +12,18 @@
  * are used to select a priority ordered list of memory zones which
  * match the requested limits. See gfp_zone() in include/linux/gfp.h
  */
+#if MAX_NR_ZONE_TYPES < 2
+#define ZONE_TYPES_SHIFT 0
+#elif MAX_NR_ZONE_TYPES <= 2
+#define ZONE_TYPES_SHIFT 1
+#elif MAX_NR_ZONE_TYPES <= 4
+#define ZONE_TYPES_SHIFT 2
+#elif MAX_NR_ZONE_TYPES <= 8
+#define ZONE_TYPES_SHIFT 3
+#else
+#error ZONE_TYPES_SHIFT "Too many zone types configured"
+#endif
+
 #if MAX_NR_ZONES < 2
 #define ZONES_SHIFT 0
 #elif MAX_NR_ZONES <= 2
diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index a7e3a3405520..8917d2ed57bb 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -530,8 +530,8 @@ PAGEFLAG(Readahead, readahead, PF_NO_COMPOUND)
  * Must use a macro here due to header dependency issues. page_zone() is not
  * available at this point.
  */
-#define PageHighMem(__p) is_highmem_idx(page_zonenum(__p))
-#define folio_test_highmem(__f)	is_highmem_idx(folio_zonenum(__f))
+#define PageHighMem(__p) is_highmem_type(page_zone_type(__p))
+#define folio_test_highmem(__f)	is_highmem_type(folio_zone_type(__f))
 #else
 PAGEFLAG_FALSE(HighMem, highmem)
 #endif
diff --git a/include/linux/vmstat.h b/include/linux/vmstat.h
index 19cf5b6892ce..c5496d2bbaf7 100644
--- a/include/linux/vmstat.h
+++ b/include/linux/vmstat.h
@@ -125,8 +125,8 @@ static inline void vm_events_fold_cpu(int cpu)
 #define count_vm_tlb_events(x, y) do { (void)(y); } while (0)
 #endif
 
-#define __count_zid_vm_events(item, zid, delta) \
-	__count_vm_events(item##_NORMAL - ZONE_NORMAL + zid, delta)
+#define __count_zt_vm_events(item, zt, delta) \
+	__count_vm_events(item##_NORMAL - ZONE_NORMAL + zt, delta)
 
 /*
  * Zone and node-based page accounting with per cpu differentials.
diff --git a/include/trace/events/oom.h b/include/trace/events/oom.h
index 26a11e4a2c36..4ed6470c25c9 100644
--- a/include/trace/events/oom.h
+++ b/include/trace/events/oom.h
@@ -43,7 +43,7 @@ TRACE_EVENT(reclaim_retry_zone,
 
 	TP_STRUCT__entry(
 		__field(	int, node)
-		__field(	int, zone_idx)
+		__field(	int, zone_type)
 		__field(	int,	order)
 		__field(	unsigned long,	reclaimable)
 		__field(	unsigned long,	available)
@@ -54,7 +54,7 @@ TRACE_EVENT(reclaim_retry_zone,
 
 	TP_fast_assign(
 		__entry->node = zone_to_nid(zoneref->zone);
-		__entry->zone_idx = zoneref->zone_idx;
+		__entry->zone_type = zoneref->zone_type;
 		__entry->order = order;
 		__entry->reclaimable = reclaimable;
 		__entry->available = available;
@@ -64,7 +64,7 @@ TRACE_EVENT(reclaim_retry_zone,
 	),
 
 	TP_printk("node=%d zone=%-8s order=%d reclaimable=%lu available=%lu min_wmark=%lu no_progress_loops=%d wmark_check=%d",
-			__entry->node, __print_symbolic(__entry->zone_idx, ZONE_TYPE),
+			__entry->node, __print_symbolic(__entry->zone_type, ZONE_TYPE),
 			__entry->order,
 			__entry->reclaimable, __entry->available, __entry->min_wmark,
 			__entry->no_progress_loops,
diff --git a/kernel/bounds.c b/kernel/bounds.c
index b529182e8b04..0f10e07d7ecd 100644
--- a/kernel/bounds.c
+++ b/kernel/bounds.c
@@ -17,6 +17,7 @@ int main(void)
 {
 	/* The enum constants to put into include/generated/bounds.h */
 	DEFINE(NR_PAGEFLAGS, __NR_PAGEFLAGS);
+	DEFINE(MAX_NR_ZONE_TYPES, __MAX_NR_ZONE_TYPES);
 	DEFINE(MAX_NR_ZONES, __MAX_NR_ZONES);
 #ifdef CONFIG_SMP
 	DEFINE(NR_CPUS_BITS, ilog2(CONFIG_NR_CPUS));
diff --git a/lib/show_mem.c b/lib/show_mem.c
index 0d7585cde2a6..2db18780f0c7 100644
--- a/lib/show_mem.c
+++ b/lib/show_mem.c
@@ -27,7 +27,7 @@ void __show_mem(unsigned int filter, nodemask_t *nodemask, int max_zone_idx)
 			total += zone->present_pages;
 			reserved += zone->present_pages - zone_managed_pages(zone);
 
-			if (is_highmem_idx(zoneid))
+			if (is_highmem(zone))
 				highmem += zone->present_pages;
 		}
 	}
diff --git a/mm/compaction.c b/mm/compaction.c
index 5a9501e0ae01..10d6072ec493 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -2176,7 +2176,7 @@ static enum compact_result compact_finished(struct compact_control *cc)
 
 static enum compact_result __compaction_suitable(struct zone *zone, int order,
 					unsigned int alloc_flags,
-					int highest_zoneidx,
+					enum zone_type highest_zone_type,
 					unsigned long wmark_target)
 {
 	unsigned long watermark;
@@ -2189,7 +2189,7 @@ static enum compact_result __compaction_suitable(struct zone *zone, int order,
 	 * If watermarks for high-order allocation are already met, there
 	 * should be no need for compaction at all.
 	 */
-	if (zone_watermark_ok(zone, order, watermark, highest_zoneidx,
+	if (zone_watermark_ok(zone, order, watermark, highest_zone_type,
 								alloc_flags))
 		return COMPACT_SUCCESS;
 
@@ -2199,7 +2199,7 @@ static enum compact_result __compaction_suitable(struct zone *zone, int order,
 	 * watermark and alloc_flags have to match, or be more pessimistic than
 	 * the check in __isolate_free_page(). We don't use the direct
 	 * compactor's alloc_flags, as they are not relevant for freepage
-	 * isolation. We however do use the direct compactor's highest_zoneidx
+	 * isolation. We however do use the direct compactor's highest_zone_type
 	 * to skip over zones where lowmem reserves would prevent allocation
 	 * even if compaction succeeds.
 	 * For costly orders, we require low watermark instead of min for
@@ -2210,7 +2210,7 @@ static enum compact_result __compaction_suitable(struct zone *zone, int order,
 	watermark = (order > PAGE_ALLOC_COSTLY_ORDER) ?
 				low_wmark_pages(zone) : min_wmark_pages(zone);
 	watermark += compact_gap(order);
-	if (!__zone_watermark_ok(zone, 0, watermark, highest_zoneidx,
+	if (!__zone_watermark_ok(zone, 0, watermark, highest_zone_type,
 						ALLOC_CMA, wmark_target))
 		return COMPACT_SKIPPED;
 
@@ -2226,12 +2226,12 @@ static enum compact_result __compaction_suitable(struct zone *zone, int order,
  */
 enum compact_result compaction_suitable(struct zone *zone, int order,
 					unsigned int alloc_flags,
-					int highest_zoneidx)
+					enum zone_type highest_zone_type)
 {
 	enum compact_result ret;
 	int fragindex;
 
-	ret = __compaction_suitable(zone, order, alloc_flags, highest_zoneidx,
+	ret = __compaction_suitable(zone, order, alloc_flags, highest_zone_type,
 				    zone_page_state(zone, NR_FREE_PAGES));
 	/*
 	 * fragmentation index determines if allocation failures are due to
@@ -2273,7 +2273,7 @@ bool compaction_zonelist_suitable(struct alloc_context *ac, int order,
 	 * retrying the reclaim.
 	 */
 	for_each_zone_zonelist_nodemask(zone, z, ac->zonelist,
-				ac->highest_zoneidx, ac->nodemask) {
+				ac->highest_zone_type, ac->nodemask) {
 		unsigned long available;
 		enum compact_result compact_result;
 
@@ -2286,7 +2286,7 @@ bool compaction_zonelist_suitable(struct alloc_context *ac, int order,
 		available = zone_reclaimable_pages(zone) / order;
 		available += zone_page_state_snapshot(zone, NR_FREE_PAGES);
 		compact_result = __compaction_suitable(zone, order, alloc_flags,
-				ac->highest_zoneidx, available);
+				ac->highest_zone_type, available);
 		if (compact_result == COMPACT_CONTINUE)
 			return true;
 	}
@@ -2318,7 +2318,7 @@ compact_zone(struct compact_control *cc, struct capture_control *capc)
 
 	cc->migratetype = gfp_migratetype(cc->gfp_mask);
 	ret = compaction_suitable(cc->zone, cc->order, cc->alloc_flags,
-							cc->highest_zoneidx);
+							cc->highest_zone_type);
 	/* Compaction is likely to fail */
 	if (ret == COMPACT_SUCCESS || ret == COMPACT_SKIPPED)
 		return ret;
@@ -2520,7 +2520,7 @@ compact_zone(struct compact_control *cc, struct capture_control *capc)
 
 static enum compact_result compact_zone_order(struct zone *zone, int order,
 		gfp_t gfp_mask, enum compact_priority prio,
-		unsigned int alloc_flags, int highest_zoneidx,
+		unsigned int alloc_flags, enum zone_type highest_zone_type,
 		struct page **capture)
 {
 	enum compact_result ret;
@@ -2532,7 +2532,7 @@ static enum compact_result compact_zone_order(struct zone *zone, int order,
 		.mode = (prio == COMPACT_PRIO_ASYNC) ?
 					MIGRATE_ASYNC :	MIGRATE_SYNC_LIGHT,
 		.alloc_flags = alloc_flags,
-		.highest_zoneidx = highest_zoneidx,
+		.highest_zone_type = highest_zone_type,
 		.direct_compaction = true,
 		.whole_zone = (prio == MIN_COMPACT_PRIORITY),
 		.ignore_skip_hint = (prio == MIN_COMPACT_PRIORITY),
@@ -2605,7 +2605,7 @@ enum compact_result try_to_compact_pages(gfp_t gfp_mask, unsigned int order,
 
 	/* Compact each zone in the list */
 	for_each_zone_zonelist_nodemask(zone, z, ac->zonelist,
-					ac->highest_zoneidx, ac->nodemask) {
+					ac->highest_zone_type, ac->nodemask) {
 		enum compact_result status;
 
 		if (prio > MIN_COMPACT_PRIORITY
@@ -2615,7 +2615,7 @@ enum compact_result try_to_compact_pages(gfp_t gfp_mask, unsigned int order,
 		}
 
 		status = compact_zone_order(zone, order, gfp_mask, prio,
-				alloc_flags, ac->highest_zoneidx, capture);
+				alloc_flags, ac->highest_zone_type, capture);
 		rc = max(status, rc);
 
 		/* The allocation should succeed, stop compacting */
@@ -2755,7 +2755,7 @@ int compaction_proactiveness_sysctl_handler(struct ctl_table *table, int write,
 
 			pgdat->proactive_compact_trigger = true;
 			trace_mm_compaction_wakeup_kcompactd(pgdat->node_id, -1,
-							     pgdat->nr_zones - 1);
+							     pgdat->nr_zone_types - 1);
 			wake_up_interruptible(&pgdat->kcompactd_wait);
 		}
 	}
@@ -2815,16 +2815,16 @@ static bool kcompactd_node_suitable(pg_data_t *pgdat)
 {
 	int zoneid;
 	struct zone *zone;
-	enum zone_type highest_zoneidx = pgdat->kcompactd_highest_zoneidx;
+	enum zone_type highest_zone_type = pgdat->kcompactd_highest_zone_type;
 
-	for (zoneid = 0; zoneid <= highest_zoneidx; zoneid++) {
+	for (zoneid = 0; zoneid <= last_zone_idx(pgdat, highest_zone_type); zoneid++) {
 		zone = &pgdat->node_zones[zoneid];
 
 		if (!populated_zone(zone))
 			continue;
 
 		if (compaction_suitable(zone, pgdat->kcompactd_max_order, 0,
-					highest_zoneidx) == COMPACT_CONTINUE)
+					highest_zone_type) == COMPACT_CONTINUE)
 			return true;
 	}
 
@@ -2842,16 +2842,16 @@ static void kcompactd_do_work(pg_data_t *pgdat)
 	struct compact_control cc = {
 		.order = pgdat->kcompactd_max_order,
 		.search_order = pgdat->kcompactd_max_order,
-		.highest_zoneidx = pgdat->kcompactd_highest_zoneidx,
+		.highest_zone_type = pgdat->kcompactd_highest_zone_type,
 		.mode = MIGRATE_SYNC_LIGHT,
 		.ignore_skip_hint = false,
 		.gfp_mask = GFP_KERNEL,
 	};
 	trace_mm_compaction_kcompactd_wake(pgdat->node_id, cc.order,
-							cc.highest_zoneidx);
+							cc.highest_zone_type);
 	count_compact_event(KCOMPACTD_WAKE);
 
-	for (zoneid = 0; zoneid <= cc.highest_zoneidx; zoneid++) {
+	for (zoneid = 0; zoneid <= last_zone_idx(pgdat, cc.highest_zone_type); zoneid++) {
 		int status;
 
 		zone = &pgdat->node_zones[zoneid];
@@ -2861,7 +2861,7 @@ static void kcompactd_do_work(pg_data_t *pgdat)
 		if (compaction_deferred(zone, cc.order))
 			continue;
 
-		if (compaction_suitable(zone, cc.order, 0, zoneid) !=
+		if (compaction_suitable(zone, cc.order, 0, zone_type_num(zone)) !=
 							COMPACT_CONTINUE)
 			continue;
 
@@ -2897,16 +2897,16 @@ static void kcompactd_do_work(pg_data_t *pgdat)
 
 	/*
 	 * Regardless of success, we are done until woken up next. But remember
-	 * the requested order/highest_zoneidx in case it was higher/tighter
+	 * the requested order/highest_zone_type in case it was higher/tighter
 	 * than our current ones
 	 */
 	if (pgdat->kcompactd_max_order <= cc.order)
 		pgdat->kcompactd_max_order = 0;
-	if (pgdat->kcompactd_highest_zoneidx >= cc.highest_zoneidx)
-		pgdat->kcompactd_highest_zoneidx = pgdat->nr_zones - 1;
+	if (pgdat->kcompactd_highest_zone_type >= cc.highest_zone_type)
+		pgdat->kcompactd_highest_zone_type = pgdat->nr_zone_types - 1;
 }
 
-void wakeup_kcompactd(pg_data_t *pgdat, int order, int highest_zoneidx)
+void wakeup_kcompactd(pg_data_t *pgdat, int order, enum zone_type highest_zone_type)
 {
 	if (!order)
 		return;
@@ -2914,8 +2914,8 @@ void wakeup_kcompactd(pg_data_t *pgdat, int order, int highest_zoneidx)
 	if (pgdat->kcompactd_max_order < order)
 		pgdat->kcompactd_max_order = order;
 
-	if (pgdat->kcompactd_highest_zoneidx > highest_zoneidx)
-		pgdat->kcompactd_highest_zoneidx = highest_zoneidx;
+	if (pgdat->kcompactd_highest_zone_type > highest_zone_type)
+		pgdat->kcompactd_highest_zone_type = highest_zone_type;
 
 	/*
 	 * Pairs with implicit barrier in wait_event_freezable()
@@ -2928,7 +2928,7 @@ void wakeup_kcompactd(pg_data_t *pgdat, int order, int highest_zoneidx)
 		return;
 
 	trace_mm_compaction_wakeup_kcompactd(pgdat->node_id, order,
-							highest_zoneidx);
+							highest_zone_type);
 	wake_up_interruptible(&pgdat->kcompactd_wait);
 }
 
@@ -2951,7 +2951,7 @@ static int kcompactd(void *p)
 	set_freezable();
 
 	pgdat->kcompactd_max_order = 0;
-	pgdat->kcompactd_highest_zoneidx = pgdat->nr_zones - 1;
+	pgdat->kcompactd_highest_zone_type = pgdat->nr_zone_types - 1;
 
 	while (!kthread_should_stop()) {
 		unsigned long pflags;
diff --git a/mm/internal.h b/mm/internal.h
index 7920a8b7982e..e9e439fa89fe 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -207,10 +207,10 @@ pmd_t *mm_find_pmd(struct mm_struct *mm, unsigned long address);
  * between functions involved in allocations, including the alloc_pages*
  * family of functions.
  *
- * nodemask, migratetype and highest_zoneidx are initialized only once in
+ * nodemask, migratetype and highest_zone_type are initialized only once in
  * __alloc_pages() and then never change.
  *
- * zonelist, preferred_zone and highest_zoneidx are set first in
+ * zonelist, preferred_zone and highest_zone_type are set first in
  * __alloc_pages() for the fast path, and might be later changed
  * in __alloc_pages_slowpath(). All other functions pass the whole structure
  * by a const pointer.
@@ -222,16 +222,16 @@ struct alloc_context {
 	int migratetype;
 
 	/*
-	 * highest_zoneidx represents highest usable zone index of
+	 * highest_zone_type represents highest usable zone type of
 	 * the allocation request. Due to the nature of the zone,
-	 * memory on lower zone than the highest_zoneidx will be
-	 * protected by lowmem_reserve[highest_zoneidx].
+	 * memory on lower zone than the highest_zone_type will be
+	 * protected by lowmem_reserve[highest_zone_type].
 	 *
-	 * highest_zoneidx is also used by reclaim/compaction to limit
-	 * the target zone since higher zone than this index cannot be
+	 * highest_zone_type is also used by reclaim/compaction to limit
+	 * the target zone since higher zone than this type cannot be
 	 * usable for this allocation request.
 	 */
-	enum zone_type highest_zoneidx;
+	enum zone_type highest_zone_type;
 	bool spread_dirty_pages;
 };
 
@@ -439,7 +439,7 @@ struct compact_control {
 	int order;			/* order a direct compactor needs */
 	int migratetype;		/* migratetype of direct compactor */
 	const unsigned int alloc_flags;	/* alloc flags of a direct compactor */
-	const int highest_zoneidx;	/* zone index of a direct compactor */
+	const enum zone_type highest_zone_type;	/* zone type of a direct compactor */
 	enum migrate_mode mode;		/* Async or sync migration mode */
 	bool ignore_skip_hint;		/* Scan blocks even if marked skip */
 	bool no_set_skip_hint;		/* Don't mark blocks for skipping */
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index db3b270254f1..24df4acbeeae 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -626,7 +626,7 @@ static void node_states_check_changes_online(unsigned long nr_pages,
 
 	if (!node_state(nid, N_MEMORY))
 		arg->status_change_nid = nid;
-	if (zone_idx(zone) <= ZONE_NORMAL && !node_state(nid, N_NORMAL_MEMORY))
+	if (zone_type_num(zone) <= ZONE_NORMAL && !node_state(nid, N_NORMAL_MEMORY))
 		arg->status_change_nid_normal = nid;
 }
 
@@ -717,7 +717,7 @@ void __ref move_pfn_range_to_zone(struct zone *zone, unsigned long start_pfn,
 	 * expects the zone spans the pfn range. All the pages in the range
 	 * are reserved so nobody should be touching them so we should be safe
 	 */
-	memmap_init_range(nr_pages, nid, zone_idx(zone), start_pfn, 0,
+	memmap_init_range(nr_pages, nid, zone_type_num(zone), zone_idx(zone), start_pfn, 0,
 			 MEMINIT_HOTPLUG, altmap, migratetype);
 
 	set_zone_contiguous(zone);
@@ -731,7 +731,7 @@ struct auto_movable_stats {
 static void auto_movable_stats_account_zone(struct auto_movable_stats *stats,
 					    struct zone *zone)
 {
-	if (zone_idx(zone) == ZONE_MOVABLE) {
+	if (zone_type_num(zone) == ZONE_MOVABLE) {
 		stats->movable_pages += zone->present_pages;
 	} else {
 		stats->kernel_early_pages += zone->present_early_pages;
@@ -837,14 +837,14 @@ static struct zone *default_kernel_zone_for_pfn(int nid, unsigned long start_pfn
 	struct pglist_data *pgdat = NODE_DATA(nid);
 	int zid;
 
-	for (zid = 0; zid < ZONE_NORMAL; zid++) {
+	for (zid = 0; zid < last_zone_idx(pgdat, ZONE_NORMAL); zid++) {
 		struct zone *zone = &pgdat->node_zones[zid];
 
 		if (zone_intersects(zone, start_pfn, nr_pages))
 			return zone;
 	}
 
-	return &pgdat->node_zones[ZONE_NORMAL];
+	return &pgdat->node_zones[last_zone_idx(pgdat, ZONE_NORMAL)];
 }
 
 /*
@@ -904,6 +904,7 @@ static struct zone *auto_movable_zone_for_pfn(int nid,
 {
 	unsigned long online_pages = 0, max_pages, end_pfn;
 	struct page *page;
+	pg_data_t *pgdat;
 
 	if (!auto_movable_ratio)
 		goto kernel_zone;
@@ -952,8 +953,9 @@ static struct zone *auto_movable_zone_for_pfn(int nid,
 	    !auto_movable_can_online_movable(nid, group, nr_pages))
 		goto kernel_zone;
 #endif /* CONFIG_NUMA */
+	pgdat = NODE_DATA(nid);
 
-	return &NODE_DATA(nid)->node_zones[ZONE_MOVABLE];
+	return &pgdat->node_zones[last_zone_idx(pgdat, ZONE_MOVABLE)];
 kernel_zone:
 	return default_kernel_zone_for_pfn(nid, pfn, nr_pages);
 }
@@ -963,7 +965,8 @@ static inline struct zone *default_zone_for_pfn(int nid, unsigned long start_pfn
 {
 	struct zone *kernel_zone = default_kernel_zone_for_pfn(nid, start_pfn,
 			nr_pages);
-	struct zone *movable_zone = &NODE_DATA(nid)->node_zones[ZONE_MOVABLE];
+	pg_data_t *pgdat = NODE_DATA(nid);
+	struct zone *movable_zone = &pgdat->node_zones[last_zone_idx(pgdat, ZONE_MOVABLE)];
 	bool in_kernel = zone_intersects(kernel_zone, start_pfn, nr_pages);
 	bool in_movable = zone_intersects(movable_zone, start_pfn, nr_pages);
 
@@ -986,11 +989,13 @@ struct zone *zone_for_pfn_range(int online_type, int nid,
 		struct memory_group *group, unsigned long start_pfn,
 		unsigned long nr_pages)
 {
+	pg_data_t *pgdat = NODE_DATA(nid);
+
 	if (online_type == MMOP_ONLINE_KERNEL)
 		return default_kernel_zone_for_pfn(nid, start_pfn, nr_pages);
 
 	if (online_type == MMOP_ONLINE_MOVABLE)
-		return &NODE_DATA(nid)->node_zones[ZONE_MOVABLE];
+		return &pgdat->node_zones[last_zone_idx(pgdat, ZONE_MOVABLE)];
 
 	if (online_policy == ONLINE_POLICY_AUTO_MOVABLE)
 		return auto_movable_zone_for_pfn(nid, group, start_pfn, nr_pages);
@@ -1006,7 +1011,7 @@ void adjust_present_page_count(struct page *page, struct memory_group *group,
 			       long nr_pages)
 {
 	struct zone *zone = page_zone(page);
-	const bool movable = zone_idx(zone) == ZONE_MOVABLE;
+	const bool movable = zone_type_num(zone) == ZONE_MOVABLE;
 
 	/*
 	 * We only support onlining/offlining/adding/removing of complete
@@ -1734,7 +1739,7 @@ static void node_states_check_changes_offline(unsigned long nr_pages,
 {
 	struct pglist_data *pgdat = zone->zone_pgdat;
 	unsigned long present_pages = 0;
-	enum zone_type zt;
+	int zid;
 
 	arg->status_change_nid = NUMA_NO_NODE;
 	arg->status_change_nid_normal = NUMA_NO_NODE;
@@ -1747,9 +1752,9 @@ static void node_states_check_changes_offline(unsigned long nr_pages,
 	 * thus we can determine that we need to clear the node from
 	 * node_states[N_NORMAL_MEMORY].
 	 */
-	for (zt = 0; zt <= ZONE_NORMAL; zt++)
-		present_pages += pgdat->node_zones[zt].present_pages;
-	if (zone_idx(zone) <= ZONE_NORMAL && nr_pages >= present_pages)
+	for (zid = 0; zid <= last_zone_idx(pgdat, ZONE_NORMAL); zid++)
+		present_pages += pgdat->node_zones[zid].present_pages;
+	if (zone_type_num(zone) <= ZONE_NORMAL && nr_pages >= present_pages)
 		arg->status_change_nid_normal = zone_to_nid(zone);
 
 	/*
@@ -1761,7 +1766,8 @@ static void node_states_check_changes_offline(unsigned long nr_pages,
 	 * we know that the node will become empty, and so, we can clear
 	 * it for N_MEMORY as well.
 	 */
-	present_pages += pgdat->node_zones[ZONE_MOVABLE].present_pages;
+	for (; zid <= last_zone_idx(pgdat, ZONE_MOVABLE); zid++)
+		present_pages += pgdat->node_zones[zid].present_pages;
 
 	if (nr_pages >= present_pages)
 		arg->status_change_nid = zone_to_nid(zone);
@@ -2182,7 +2188,7 @@ static int try_offline_memory_block(struct memory_block *mem, void *arg)
 	 * by offlining code ... so we don't care about that.
 	 */
 	page = pfn_to_online_page(section_nr_to_pfn(mem->start_section_nr));
-	if (page && zone_idx(page_zone(page)) == ZONE_MOVABLE)
+	if (page && zone_type_num(page_zone(page)) == ZONE_MOVABLE)
 		online_type = MMOP_ONLINE_MOVABLE;
 
 	rc = device_offline(&mem->dev);
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 2068b594dc88..0e0ce31a623c 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -1923,9 +1923,9 @@ unsigned int mempolicy_slab_node(void)
 		 * first node.
 		 */
 		struct zonelist *zonelist;
-		enum zone_type highest_zoneidx = gfp_zone(GFP_KERNEL);
+		enum zone_type highest_zone_type = gfp_zone(GFP_KERNEL);
 		zonelist = &NODE_DATA(node)->node_zonelists[ZONELIST_FALLBACK];
-		z = first_zones_zonelist(zonelist, highest_zoneidx,
+		z = first_zones_zonelist(zonelist, highest_zone_type,
 							&policy->nodes);
 		return z->zone ? zone_to_nid(z->zone) : node;
 	}
diff --git a/mm/memremap.c b/mm/memremap.c
index bee85560a243..367dbee677a4 100644
--- a/mm/memremap.c
+++ b/mm/memremap.c
@@ -172,6 +172,7 @@ static int pagemap_range(struct dev_pagemap *pgmap, struct mhp_params *params,
 	const bool is_private = pgmap->type == MEMORY_DEVICE_PRIVATE;
 	struct range *range = &pgmap->ranges[range_id];
 	struct dev_pagemap *conflict_pgmap;
+	pg_data_t *pgdat;
 	int error, is_ram;
 
 	if (WARN_ONCE(pgmap_altmap(pgmap) && range_id > 0,
@@ -247,10 +248,11 @@ static int pagemap_range(struct dev_pagemap *pgmap, struct mhp_params *params,
 					params);
 	}
 
+	pgdat = NODE_DATA(nid);
 	if (!error) {
 		struct zone *zone;
 
-		zone = &NODE_DATA(nid)->node_zones[ZONE_DEVICE];
+		zone = &pgdat->node_zones[last_zone_idx(pgdat, ZONE_DEVICE)];
 		move_pfn_range_to_zone(zone, PHYS_PFN(range->start),
 				PHYS_PFN(range_len(range)), params->altmap,
 				MIGRATE_MOVABLE);
@@ -264,7 +266,7 @@ static int pagemap_range(struct dev_pagemap *pgmap, struct mhp_params *params,
 	 * Initialization of the pages has been deferred until now in order
 	 * to allow us to do the work while not holding the hotplug lock.
 	 */
-	memmap_init_zone_device(&NODE_DATA(nid)->node_zones[ZONE_DEVICE],
+	memmap_init_zone_device(&pgdat->node_zones[last_zone_idx(pgdat, ZONE_DEVICE)],
 				PHYS_PFN(range->start),
 				PHYS_PFN(range_len(range)), pgmap);
 	if (pgmap->type != MEMORY_DEVICE_PRIVATE &&
diff --git a/mm/migrate.c b/mm/migrate.c
index db3f154446af..d4a07dc6736f 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -2029,7 +2029,7 @@ struct page *alloc_migration_target(struct page *page, unsigned long private)
 	struct folio *hugetlb_folio = NULL;
 	struct folio *new_folio = NULL;
 	int nid;
-	int zidx;
+	enum zone_type zt;
 
 	mtc = (struct migration_target_control *)private;
 	gfp_mask = mtc->gfp_mask;
@@ -2055,8 +2055,8 @@ struct page *alloc_migration_target(struct page *page, unsigned long private)
 		gfp_mask |= GFP_TRANSHUGE;
 		order = folio_order(folio);
 	}
-	zidx = zone_idx(folio_zone(folio));
-	if (is_highmem_idx(zidx) || zidx == ZONE_MOVABLE)
+	zt = zone_type_num(folio_zone(folio));
+	if (is_highmem_type(zt) || zt == ZONE_MOVABLE)
 		gfp_mask |= __GFP_HIGHMEM;
 
 	new_folio = __folio_alloc(gfp_mask, order, nid, mtc->nmask);
diff --git a/mm/mmzone.c b/mm/mmzone.c
index 68e1511be12d..78538ac5c33e 100644
--- a/mm/mmzone.c
+++ b/mm/mmzone.c
@@ -52,9 +52,9 @@ static inline int zref_in_nodemask(struct zoneref *zref, nodemask_t *nodes)
 #endif /* CONFIG_NUMA */
 }
 
-/* Returns the next zone at or below highest_zoneidx in a zonelist */
+/* Returns the next zone at or below highest_zone_type in a zonelist */
 struct zoneref *__next_zones_zonelist(struct zoneref *z,
-					enum zone_type highest_zoneidx,
+					enum zone_type highest_zone_type,
 					nodemask_t *nodes)
 {
 	/*
@@ -62,10 +62,10 @@ struct zoneref *__next_zones_zonelist(struct zoneref *z,
 	 * Only filter based on nodemask if it's set
 	 */
 	if (unlikely(nodes == NULL))
-		while (zonelist_zone_idx(z) > highest_zoneidx)
+		while (zonelist_zone_type(z) > highest_zone_type)
 			z++;
 	else
-		while (zonelist_zone_idx(z) > highest_zoneidx ||
+		while (zonelist_zone_type(z) > highest_zone_type ||
 				(z->zone && !zref_in_nodemask(z, nodes)))
 			z++;
 
diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index 044e1eed720e..1d141e1b621c 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -252,7 +252,7 @@ static enum oom_constraint constrained_alloc(struct oom_control *oc)
 {
 	struct zone *zone;
 	struct zoneref *z;
-	enum zone_type highest_zoneidx = gfp_zone(oc->gfp_mask);
+	enum zone_type highest_zone_type = gfp_zone(oc->gfp_mask);
 	bool cpuset_limited = false;
 	int nid;
 
@@ -292,7 +292,7 @@ static enum oom_constraint constrained_alloc(struct oom_control *oc)
 
 	/* Check this allocation failure is caused by cpuset's wall function */
 	for_each_zone_zonelist_nodemask(zone, z, oc->zonelist,
-			highest_zoneidx, oc->nodemask)
+			highest_zone_type, oc->nodemask)
 		if (!cpuset_zone_allowed(zone, oc->gfp_mask))
 			cpuset_limited = true;
 
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 516b1aa247e8..44ca082a5c95 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -302,16 +302,19 @@ static unsigned long highmem_dirtyable_memory(unsigned long total)
 	int node;
 	unsigned long x = 0;
 	int i;
+	pg_data_t *pgdat;
 
 	for_each_node_state(node, N_HIGH_MEMORY) {
-		for (i = ZONE_NORMAL + 1; i < MAX_NR_ZONES; i++) {
+		pgdat = NODE_DATA(node);
+		for (i = last_zone_idx(pgdat, ZONE_NORMAL) + 1; i < MAX_NR_ZONES; i++) {
 			struct zone *z;
 			unsigned long nr_pages;
 
-			if (!is_highmem_idx(i))
+			z = &pgdat->node_zones[i];
+
+			if (!is_highmem(z))
 				continue;
 
-			z = &NODE_DATA(node)->node_zones[i];
 			if (!populated_zone(z))
 				continue;
 
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 8e39705c7bdc..04a3af90a5a8 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -344,7 +344,7 @@ static void __free_pages_ok(struct page *page, unsigned int order,
  * TBD: should special case ZONE_DMA32 machines here - in those we normally
  * don't need any ZONE_NORMAL reservation
  */
-int sysctl_lowmem_reserve_ratio[MAX_NR_ZONES] = {
+int sysctl_lowmem_reserve_ratio[MAX_NR_ZONE_TYPES] = {
 #ifdef CONFIG_ZONE_DMA
 	[ZONE_DMA] = 256,
 #endif
@@ -408,8 +408,8 @@ static unsigned long nr_kernel_pages __initdata;
 static unsigned long nr_all_pages __initdata;
 static unsigned long dma_reserve __initdata;
 
-static unsigned long arch_zone_lowest_possible_pfn[MAX_NR_ZONES] __initdata;
-static unsigned long arch_zone_highest_possible_pfn[MAX_NR_ZONES] __initdata;
+static unsigned long arch_zone_lowest_possible_pfn[MAX_NR_ZONE_TYPES] __initdata;
+static unsigned long arch_zone_highest_possible_pfn[MAX_NR_ZONE_TYPES] __initdata;
 static unsigned long required_kernelcore __initdata;
 static unsigned long required_kernelcore_percent __initdata;
 static unsigned long required_movablecore __initdata;
@@ -1638,7 +1638,7 @@ static void __meminit __init_single_page(struct page *page, unsigned long pfn,
 	INIT_LIST_HEAD(&page->lru);
 #ifdef WANT_PAGE_VIRTUAL
 	/* The shift won't overflow because ZONE_NORMAL is below 4G. */
-	if (!is_highmem_idx(zone))
+	if (!is_highmem(page_zone(page)))
 		set_page_address(page, __va(pfn << PAGE_SHIFT));
 #endif
 }
@@ -2941,7 +2941,7 @@ static bool unreserve_highatomic_pageblock(const struct alloc_context *ac,
 	int order;
 	bool ret;
 
-	for_each_zone_zonelist_nodemask(zone, z, zonelist, ac->highest_zoneidx,
+	for_each_zone_zonelist_nodemask(zone, z, zonelist, ac->highest_zone_type,
 								ac->nodemask) {
 		/*
 		 * Preserve at least one pageblock unless memory pressure
@@ -3749,7 +3749,7 @@ struct page *rmqueue_buddy(struct zone *preferred_zone, struct zone *zone,
 		spin_unlock_irqrestore(&zone->lock, flags);
 	} while (check_new_pages(page, order));
 
-	__count_zid_vm_events(PGALLOC, page_zonenum(page), 1 << order);
+	__count_zt_vm_events(PGALLOC, page_zone_type(page), 1 << order);
 	zone_statistics(preferred_zone, zone, 1);
 
 	return page;
@@ -3825,7 +3825,7 @@ static struct page *rmqueue_pcplist(struct zone *preferred_zone,
 	pcp_spin_unlock(pcp);
 	pcp_trylock_finish(UP_flags);
 	if (page) {
-		__count_zid_vm_events(PGALLOC, page_zonenum(page), 1 << order);
+		__count_zt_vm_events(PGALLOC, page_zone_type(page), 1 << order);
 		zone_statistics(preferred_zone, zone, 1);
 	}
 	return page;
@@ -3878,7 +3878,7 @@ struct page *rmqueue(struct zone *preferred_zone,
 	/* Separate test+clear to avoid unnecessary atomics */
 	if (unlikely(test_bit(ZONE_BOOSTED_WATERMARK, &zone->flags))) {
 		clear_bit(ZONE_BOOSTED_WATERMARK, &zone->flags);
-		wakeup_kswapd(zone, 0, 0, zone_idx(zone));
+		wakeup_kswapd(zone, 0, 0, zone_type_num(zone));
 	}
 
 	VM_BUG_ON_PAGE(page && bad_range(zone, page), page);
@@ -3994,7 +3994,7 @@ static inline long __zone_watermark_unusable_free(struct zone *z,
  * to check in the allocation paths if no pages are free.
  */
 bool __zone_watermark_ok(struct zone *z, unsigned int order, unsigned long mark,
-			 int highest_zoneidx, unsigned int alloc_flags,
+			 enum zone_type highest_zone_type, unsigned int alloc_flags,
 			 long free_pages)
 {
 	long min = mark;
@@ -4037,7 +4037,7 @@ bool __zone_watermark_ok(struct zone *z, unsigned int order, unsigned long mark,
 	 * are not met, then a high-order request also cannot go ahead
 	 * even if a suitable page happened to be free.
 	 */
-	if (free_pages <= min + z->lowmem_reserve[highest_zoneidx])
+	if (free_pages <= min + z->lowmem_reserve[highest_zone_type])
 		return false;
 
 	/* If this is an order-0 request then the watermark is fine */
@@ -4072,14 +4072,14 @@ bool __zone_watermark_ok(struct zone *z, unsigned int order, unsigned long mark,
 }
 
 bool zone_watermark_ok(struct zone *z, unsigned int order, unsigned long mark,
-		      int highest_zoneidx, unsigned int alloc_flags)
+		enum zone_type highest_zone_type, unsigned int alloc_flags)
 {
-	return __zone_watermark_ok(z, order, mark, highest_zoneidx, alloc_flags,
+	return __zone_watermark_ok(z, order, mark, highest_zone_type, alloc_flags,
 					zone_page_state(z, NR_FREE_PAGES));
 }
 
 static inline bool zone_watermark_fast(struct zone *z, unsigned int order,
-				unsigned long mark, int highest_zoneidx,
+				unsigned long mark, enum zone_type highest_zone_type,
 				unsigned int alloc_flags, gfp_t gfp_mask)
 {
 	long free_pages;
@@ -4099,11 +4099,11 @@ static inline bool zone_watermark_fast(struct zone *z, unsigned int order,
 
 		/* reserved may over estimate high-atomic reserves. */
 		usable_free -= min(usable_free, reserved);
-		if (usable_free > mark + z->lowmem_reserve[highest_zoneidx])
+		if (usable_free > mark + z->lowmem_reserve[highest_zone_type])
 			return true;
 	}
 
-	if (__zone_watermark_ok(z, order, mark, highest_zoneidx, alloc_flags,
+	if (__zone_watermark_ok(z, order, mark, highest_zone_type, alloc_flags,
 					free_pages))
 		return true;
 
@@ -4116,7 +4116,7 @@ static inline bool zone_watermark_fast(struct zone *z, unsigned int order,
 	if (unlikely(!order && (alloc_flags & ALLOC_MIN_RESERVE) && z->watermark_boost
 		&& ((alloc_flags & ALLOC_WMARK_MASK) == WMARK_MIN))) {
 		mark = z->_watermark[WMARK_MIN];
-		return __zone_watermark_ok(z, order, mark, highest_zoneidx,
+		return __zone_watermark_ok(z, order, mark, highest_zone_type,
 					alloc_flags, free_pages);
 	}
 
@@ -4124,14 +4124,14 @@ static inline bool zone_watermark_fast(struct zone *z, unsigned int order,
 }
 
 bool zone_watermark_ok_safe(struct zone *z, unsigned int order,
-			unsigned long mark, int highest_zoneidx)
+			unsigned long mark, enum zone_type highest_zone_type)
 {
 	long free_pages = zone_page_state(z, NR_FREE_PAGES);
 
 	if (z->percpu_drift_mark && free_pages < z->percpu_drift_mark)
 		free_pages = zone_page_state_snapshot(z, NR_FREE_PAGES);
 
-	return __zone_watermark_ok(z, order, mark, highest_zoneidx, 0,
+	return __zone_watermark_ok(z, order, mark, highest_zone_type, 0,
 								free_pages);
 }
 
@@ -4173,7 +4173,7 @@ alloc_flags_nofragment(struct zone *zone, gfp_t gfp_mask)
 	if (!zone)
 		return alloc_flags;
 
-	if (zone_idx(zone) != ZONE_NORMAL)
+	if (zone_type_num(zone) != ZONE_NORMAL)
 		return alloc_flags;
 
 	/*
@@ -4222,7 +4222,7 @@ get_page_from_freelist(gfp_t gfp_mask, unsigned int order, int alloc_flags,
 	 */
 	no_fallback = alloc_flags & ALLOC_NOFRAGMENT;
 	z = ac->preferred_zoneref;
-	for_next_zone_zonelist_nodemask(zone, z, ac->highest_zoneidx,
+	for_next_zone_zonelist_nodemask(zone, z, ac->highest_zone_type,
 					ac->nodemask) {
 		struct page *page;
 		unsigned long mark;
@@ -4278,7 +4278,7 @@ get_page_from_freelist(gfp_t gfp_mask, unsigned int order, int alloc_flags,
 
 		mark = wmark_pages(zone, alloc_flags & ALLOC_WMARK_MASK);
 		if (!zone_watermark_fast(zone, order, mark,
-				       ac->highest_zoneidx, alloc_flags,
+				       ac->highest_zone_type, alloc_flags,
 				       gfp_mask)) {
 			int ret;
 
@@ -4312,7 +4312,7 @@ get_page_from_freelist(gfp_t gfp_mask, unsigned int order, int alloc_flags,
 			default:
 				/* did we reclaim enough */
 				if (zone_watermark_ok(zone, order, mark,
-					ac->highest_zoneidx, alloc_flags))
+					ac->highest_zone_type, alloc_flags))
 					goto try_this_zone;
 
 				continue;
@@ -4475,7 +4475,7 @@ __alloc_pages_may_oom(gfp_t gfp_mask, unsigned int order,
 	if (gfp_mask & (__GFP_RETRY_MAYFAIL | __GFP_THISNODE))
 		goto out;
 	/* The OOM killer does not needlessly kill tasks for lowmem */
-	if (ac->highest_zoneidx < ZONE_NORMAL)
+	if (ac->highest_zone_type < ZONE_NORMAL)
 		goto out;
 	if (pm_suspended_storage())
 		goto out;
@@ -4683,9 +4683,9 @@ should_compact_retry(struct alloc_context *ac, unsigned int order, int alloc_fla
 	 * watermarks are OK.
 	 */
 	for_each_zone_zonelist_nodemask(zone, z, ac->zonelist,
-				ac->highest_zoneidx, ac->nodemask) {
+				ac->highest_zone_type, ac->nodemask) {
 		if (zone_watermark_ok(zone, 0, min_wmark_pages(zone),
-					ac->highest_zoneidx, alloc_flags))
+					ac->highest_zone_type, alloc_flags))
 			return true;
 	}
 	return false;
@@ -4842,14 +4842,14 @@ static void wake_all_kswapds(unsigned int order, gfp_t gfp_mask,
 	struct zoneref *z;
 	struct zone *zone;
 	pg_data_t *last_pgdat = NULL;
-	enum zone_type highest_zoneidx = ac->highest_zoneidx;
+	enum zone_type highest_zone_type = ac->highest_zone_type;
 
-	for_each_zone_zonelist_nodemask(zone, z, ac->zonelist, highest_zoneidx,
+	for_each_zone_zonelist_nodemask(zone, z, ac->zonelist, highest_zone_type,
 					ac->nodemask) {
 		if (!managed_zone(zone))
 			continue;
 		if (last_pgdat != zone->zone_pgdat) {
-			wakeup_kswapd(zone, gfp_mask, order, highest_zoneidx);
+			wakeup_kswapd(zone, gfp_mask, order, highest_zone_type);
 			last_pgdat = zone->zone_pgdat;
 		}
 	}
@@ -4991,7 +4991,7 @@ should_reclaim_retry(gfp_t gfp_mask, unsigned order,
 	 * screwed and have to go OOM.
 	 */
 	for_each_zone_zonelist_nodemask(zone, z, ac->zonelist,
-				ac->highest_zoneidx, ac->nodemask) {
+				ac->highest_zone_type, ac->nodemask) {
 		unsigned long available;
 		unsigned long reclaimable;
 		unsigned long min_wmark = min_wmark_pages(zone);
@@ -5005,7 +5005,7 @@ should_reclaim_retry(gfp_t gfp_mask, unsigned order,
 		 * reclaimable pages?
 		 */
 		wmark = __zone_watermark_ok(zone, order, min_wmark,
-				ac->highest_zoneidx, alloc_flags, available);
+				ac->highest_zone_type, alloc_flags, available);
 		trace_reclaim_retry_zone(z, order, reclaimable,
 				available, min_wmark, *no_progress_loops, wmark);
 		if (wmark) {
@@ -5099,7 +5099,7 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
 	 * could end up iterating over non-eligible zones endlessly.
 	 */
 	ac->preferred_zoneref = first_zones_zonelist(ac->zonelist,
-					ac->highest_zoneidx, ac->nodemask);
+					ac->highest_zone_type, ac->nodemask);
 	if (!ac->preferred_zoneref->zone)
 		goto nopage;
 
@@ -5110,7 +5110,7 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
 	 */
 	if (cpusets_insane_config() && (gfp_mask & __GFP_HARDWALL)) {
 		struct zoneref *z = first_zones_zonelist(ac->zonelist,
-					ac->highest_zoneidx,
+					ac->highest_zone_type,
 					&cpuset_current_mems_allowed);
 		if (!z->zone)
 			goto nopage;
@@ -5200,7 +5200,7 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
 	if (!(alloc_flags & ALLOC_CPUSET) || reserve_flags) {
 		ac->nodemask = NULL;
 		ac->preferred_zoneref = first_zones_zonelist(ac->zonelist,
-					ac->highest_zoneidx, ac->nodemask);
+					ac->highest_zone_type, ac->nodemask);
 	}
 
 	/* Attempt with potentially adjusted zonelist and alloc_flags */
@@ -5343,7 +5343,7 @@ static inline bool prepare_alloc_pages(gfp_t gfp_mask, unsigned int order,
 		struct alloc_context *ac, gfp_t *alloc_gfp,
 		unsigned int *alloc_flags)
 {
-	ac->highest_zoneidx = gfp_zone(gfp_mask);
+	ac->highest_zone_type = gfp_zone(gfp_mask);
 	ac->zonelist = node_zonelist(preferred_nid, gfp_mask);
 	ac->nodemask = nodemask;
 	ac->migratetype = gfp_migratetype(gfp_mask);
@@ -5376,7 +5376,7 @@ static inline bool prepare_alloc_pages(gfp_t gfp_mask, unsigned int order,
 	 * may get reset for allocations that ignore memory policies.
 	 */
 	ac->preferred_zoneref = first_zones_zonelist(ac->zonelist,
-					ac->highest_zoneidx, ac->nodemask);
+					ac->highest_zone_type, ac->nodemask);
 
 	return true;
 }
@@ -5460,7 +5460,7 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
 	gfp = alloc_gfp;
 
 	/* Find an allowed local zone that meets the low watermark. */
-	for_each_zone_zonelist_nodemask(zone, z, ac.zonelist, ac.highest_zoneidx, ac.nodemask) {
+	for_each_zone_zonelist_nodemask(zone, z, ac.zonelist, ac.highest_zone_type, ac.nodemask) {
 		unsigned long mark;
 
 		if (cpusets_enabled() && (alloc_flags & ALLOC_CPUSET) &&
@@ -5475,7 +5475,7 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
 
 		mark = wmark_pages(zone, alloc_flags & ALLOC_WMARK_MASK) + nr_pages;
 		if (zone_watermark_fast(zone, 0,  mark,
-				zonelist_zone_idx(ac.preferred_zoneref),
+				zonelist_zone_type(ac.preferred_zoneref),
 				alloc_flags, gfp)) {
 			break;
 		}
@@ -5527,7 +5527,7 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
 	pcp_spin_unlock(pcp);
 	pcp_trylock_finish(UP_flags);
 
-	__count_zid_vm_events(PGALLOC, zone_idx(zone), nr_account);
+	__count_zt_vm_events(PGALLOC, zone_type_num(zone), nr_account);
 	zone_statistics(ac.preferred_zoneref->zone, zone, nr_account);
 
 out:
@@ -6029,20 +6029,20 @@ EXPORT_SYMBOL(si_meminfo);
 #ifdef CONFIG_NUMA
 void si_meminfo_node(struct sysinfo *val, int nid)
 {
-	int zone_type;		/* needs to be signed */
+	int zid;		/* needs to be signed */
 	unsigned long managed_pages = 0;
 	unsigned long managed_highpages = 0;
 	unsigned long free_highpages = 0;
 	pg_data_t *pgdat = NODE_DATA(nid);
 
-	for (zone_type = 0; zone_type < MAX_NR_ZONES; zone_type++)
-		managed_pages += zone_managed_pages(&pgdat->node_zones[zone_type]);
+	for (zid = 0; zid < MAX_NR_ZONES; zid++)
+		managed_pages += zone_managed_pages(&pgdat->node_zones[zid]);
 	val->totalram = managed_pages;
 	val->sharedram = node_page_state(pgdat, NR_SHMEM);
 	val->freeram = sum_zone_node_page_state(nid, NR_FREE_PAGES);
 #ifdef CONFIG_HIGHMEM
-	for (zone_type = 0; zone_type < MAX_NR_ZONES; zone_type++) {
-		struct zone *zone = &pgdat->node_zones[zone_type];
+	for (zid = 0; zid < MAX_NR_ZONES; zid++) {
+		struct zone *zone = &pgdat->node_zones[zid];
 
 		if (is_highmem(zone)) {
 			managed_highpages += zone_managed_pages(zone);
@@ -6288,7 +6288,7 @@ void __show_free_areas(unsigned int filter, nodemask_t *nodemask, int max_zone_i
 			K(this_cpu_read(zone->per_cpu_pageset->count)),
 			K(zone_page_state(zone, NR_FREE_CMA_PAGES)));
 		printk("lowmem_reserve[]:");
-		for (i = 0; i < MAX_NR_ZONES; i++)
+		for (i = 0; i < MAX_NR_ZONE_TYPES; i++)
 			printk(KERN_CONT " %ld", zone->lowmem_reserve[i]);
 		printk(KERN_CONT "\n");
 	}
@@ -6343,7 +6343,7 @@ void __show_free_areas(unsigned int filter, nodemask_t *nodemask, int max_zone_i
 static void zoneref_set_zone(struct zone *zone, struct zoneref *zoneref)
 {
 	zoneref->zone = zone;
-	zoneref->zone_idx = zone_idx(zone);
+	zoneref->zone_type = zone_type_num(zone);
 }
 
 /*
@@ -6354,17 +6354,17 @@ static void zoneref_set_zone(struct zone *zone, struct zoneref *zoneref)
 static int build_zonerefs_node(pg_data_t *pgdat, struct zoneref *zonerefs)
 {
 	struct zone *zone;
-	enum zone_type zone_type = MAX_NR_ZONES;
+	int zid = MAX_NR_ZONES;
 	int nr_zones = 0;
 
 	do {
-		zone_type--;
-		zone = pgdat->node_zones + zone_type;
+		zid--;
+		zone = pgdat->node_zones + zid;
 		if (populated_zone(zone)) {
 			zoneref_set_zone(zone, &zonerefs[nr_zones++]);
-			check_highest_zone(zone_type);
+			check_highest_zone(zone_type_num(zone));
 		}
-	} while (zone_type);
+	} while (zid);
 
 	return nr_zones;
 }
@@ -6484,7 +6484,7 @@ static void build_zonelists_in_node_order(pg_data_t *pgdat, int *node_order,
 		zonerefs += nr_zones;
 	}
 	zonerefs->zone = NULL;
-	zonerefs->zone_idx = 0;
+	zonerefs->zone_type = 0;
 }
 
 /*
@@ -6499,7 +6499,7 @@ static void build_thisnode_zonelists(pg_data_t *pgdat)
 	nr_zones = build_zonerefs_node(pgdat, zonerefs);
 	zonerefs += nr_zones;
 	zonerefs->zone = NULL;
-	zonerefs->zone_idx = 0;
+	zonerefs->zone_type = 0;
 }
 
 /*
@@ -6599,7 +6599,7 @@ static void build_zonelists(pg_data_t *pgdat)
 	}
 
 	zonerefs->zone = NULL;
-	zonerefs->zone_idx = 0;
+	zonerefs->zone_type = 0;
 }
 
 #endif	/* CONFIG_NUMA */
@@ -6757,11 +6757,11 @@ void __ref build_all_zonelists(pg_data_t *pgdat)
 
 /* If zone is ZONE_MOVABLE but memory is mirrored, it is an overlapped init */
 static bool __meminit
-overlap_memmap_init(unsigned long zone, unsigned long *pfn)
+overlap_memmap_init(enum zone_type zt, unsigned long *pfn)
 {
 	static struct memblock_region *r;
 
-	if (mirrored_kernelcore && zone == ZONE_MOVABLE) {
+	if (mirrored_kernelcore && zt == ZONE_MOVABLE) {
 		if (!r || *pfn >= memblock_region_memory_end_pfn(r)) {
 			for_each_mem_region(r) {
 				if (*pfn < memblock_region_memory_end_pfn(r))
@@ -6786,9 +6786,9 @@ overlap_memmap_init(unsigned long zone, unsigned long *pfn)
  * (usually MIGRATE_MOVABLE). Besides setting the migratetype, no related
  * zone stats (e.g., nr_isolate_pageblock) are touched.
  */
-void __meminit memmap_init_range(unsigned long size, int nid, unsigned long zone,
-		unsigned long start_pfn, unsigned long zone_end_pfn,
-		enum meminit_context context,
+void __meminit memmap_init_range(unsigned long size, int nid, enum zone_type zt,
+		unsigned long zone, unsigned long start_pfn,
+		unsigned long zone_end_pfn, enum meminit_context context,
 		struct vmem_altmap *altmap, int migratetype)
 {
 	unsigned long pfn, end_pfn = start_pfn + size;
@@ -6805,7 +6805,7 @@ void __meminit memmap_init_range(unsigned long size, int nid, unsigned long zone
 	 * ZONE_DEVICE page initialization until after we have released
 	 * the hotplug lock.
 	 */
-	if (zone == ZONE_DEVICE) {
+	if (zt == ZONE_DEVICE) {
 		if (!altmap)
 			return;
 
@@ -6951,7 +6951,7 @@ void __ref memmap_init_zone_device(struct zone *zone,
 	unsigned long start = jiffies;
 	int nid = pgdat->node_id;
 
-	if (WARN_ON_ONCE(!pgmap || zone_idx != ZONE_DEVICE))
+	if (WARN_ON_ONCE(!pgmap || zone_type_num(zone) != ZONE_DEVICE))
 		return;
 
 	/*
@@ -7042,6 +7042,7 @@ static void __init memmap_init_zone_range(struct zone *zone,
 	unsigned long zone_start_pfn = zone->zone_start_pfn;
 	unsigned long zone_end_pfn = zone_start_pfn + zone->spanned_pages;
 	int nid = zone_to_nid(zone), zone_id = zone_idx(zone);
+	enum zone_type zt = zone_type_num(zone);
 
 	start_pfn = clamp(start_pfn, zone_start_pfn, zone_end_pfn);
 	end_pfn = clamp(end_pfn, zone_start_pfn, zone_end_pfn);
@@ -7049,7 +7050,7 @@ static void __init memmap_init_zone_range(struct zone *zone,
 	if (start_pfn >= end_pfn)
 		return;
 
-	memmap_init_range(end_pfn - start_pfn, nid, zone_id, start_pfn,
+	memmap_init_range(end_pfn - start_pfn, nid, zt, zone_id, start_pfn,
 			  zone_end_pfn, MEMINIT_EARLY, NULL, MIGRATE_MOVABLE);
 
 	if (*hole_pfn < start_pfn)
@@ -7377,8 +7378,10 @@ void __meminit init_currently_empty_zone(struct zone *zone,
 	struct pglist_data *pgdat = zone->zone_pgdat;
 	int zone_idx = zone_idx(zone) + 1;
 
-	if (zone_idx > pgdat->nr_zones)
+	if (zone_idx > pgdat->nr_zones) {
 		pgdat->nr_zones = zone_idx;
+		pgdat->nr_zone_types = zone_type_num(zone) + 1;
+	}
 
 	zone->zone_start_pfn = zone_start_pfn;
 
@@ -7428,18 +7431,18 @@ void __init get_pfn_range_for_nid(unsigned int nid,
  */
 static void __init find_usable_zone_for_movable(void)
 {
-	int zone_index;
-	for (zone_index = MAX_NR_ZONES - 1; zone_index >= 0; zone_index--) {
-		if (zone_index == ZONE_MOVABLE)
+	int zt;
+	for (zt = MAX_NR_ZONE_TYPES - 1; zt >= 0; zt--) {
+		if (zt == ZONE_MOVABLE)
 			continue;
 
-		if (arch_zone_highest_possible_pfn[zone_index] >
-				arch_zone_lowest_possible_pfn[zone_index])
+		if (arch_zone_highest_possible_pfn[zt] >
+				arch_zone_lowest_possible_pfn[zt])
 			break;
 	}
 
-	VM_BUG_ON(zone_index == -1);
-	movable_zone = zone_index;
+	VM_BUG_ON(zt == -1);
+	movable_zone = zt;
 }
 
 /*
@@ -7780,12 +7783,12 @@ static void __meminit pgdat_init_internals(struct pglist_data *pgdat)
 	lruvec_init(&pgdat->__lruvec);
 }
 
-static void __meminit zone_init_internals(struct zone *zone, enum zone_type idx, int nid,
+static void __meminit zone_init_internals(struct zone *zone, enum zone_type zt, int nid,
 							unsigned long remaining_pages)
 {
 	atomic_long_set(&zone->managed_pages, remaining_pages);
 	zone_set_nid(zone, nid);
-	zone->name = zone_names[idx];
+	zone->name = zone_names[zt];
 	zone->zone_pgdat = NODE_DATA(nid);
 	spin_lock_init(&zone->lock);
 	zone_seqlock_init(zone);
@@ -7812,13 +7815,14 @@ void __ref free_area_init_core_hotplug(struct pglist_data *pgdat)
 		pgdat->per_cpu_nodestats = alloc_percpu(struct per_cpu_nodestat);
 
 	/*
-	 * Reset the nr_zones, order and highest_zoneidx before reuse.
-	 * Note that kswapd will init kswapd_highest_zoneidx properly
+	 * Reset the nr_zones, order and highest_zone_type before reuse.
+	 * Note that kswapd will init kswapd_highest_zone_type properly
 	 * when it starts in the near future.
 	 */
 	pgdat->nr_zones = 0;
+	pgdat->nr_zone_types = 0;
 	pgdat->kswapd_order = 0;
-	pgdat->kswapd_highest_zoneidx = 0;
+	pgdat->kswapd_highest_zone_type = 0;
 	pgdat->node_start_pfn = 0;
 	for_each_online_cpu(cpu) {
 		struct per_cpu_nodestat *p;
@@ -7849,7 +7853,7 @@ static void __init free_area_init_core(struct pglist_data *pgdat)
 	pgdat_init_internals(pgdat);
 	pgdat->per_cpu_nodestats = &boot_nodestats;
 
-	for (j = 0; j < MAX_NR_ZONES; j++) {
+	for (j = 0; j < MAX_NR_ZONE_TYPES; j++) {
 		struct zone *zone = pgdat->node_zones + j;
 		unsigned long size, freesize, memmap_pages;
 
@@ -7862,7 +7866,7 @@ static void __init free_area_init_core(struct pglist_data *pgdat)
 		 * and per-cpu initialisations
 		 */
 		memmap_pages = calc_memmap_size(size, freesize);
-		if (!is_highmem_idx(j)) {
+		if (!is_highmem_type(j)) {
 			if (freesize >= memmap_pages) {
 				freesize -= memmap_pages;
 				if (memmap_pages)
@@ -7879,7 +7883,7 @@ static void __init free_area_init_core(struct pglist_data *pgdat)
 			pr_debug("  %s zone: %lu pages reserved\n", zone_names[0], dma_reserve);
 		}
 
-		if (!is_highmem_idx(j))
+		if (!is_highmem_type(j))
 			nr_kernel_pages += freesize;
 		/* Charge for highmem memmap if there are enough kernel pages */
 		else if (nr_kernel_pages > memmap_pages * 2)
@@ -7968,7 +7972,7 @@ static void __init free_area_init_node(int nid)
 	unsigned long end_pfn = 0;
 
 	/* pg_data_t should be reset to zero when it's allocated */
-	WARN_ON(pgdat->nr_zones || pgdat->kswapd_highest_zoneidx);
+	WARN_ON(pgdat->nr_zones || pgdat->kswapd_highest_zone_type);
 
 	get_pfn_range_for_nid(nid, &start_pfn, &end_pfn);
 
@@ -8305,14 +8309,17 @@ static void __init find_zone_movable_pfns_for_nodes(void)
 /* Any regular or high memory on that node ? */
 static void check_for_memory(pg_data_t *pgdat, int nid)
 {
-	enum zone_type zone_type;
+        int zid;
 
-	for (zone_type = 0; zone_type <= ZONE_MOVABLE - 1; zone_type++) {
-		struct zone *zone = &pgdat->node_zones[zone_type];
+	for (zid = 0; zid <= MAX_NR_ZONES; zid++) {
+		struct zone *zone = &pgdat->node_zones[zid];
+		enum zone_type zt = zone_type_num(zone);
+		if (zt >= ZONE_MOVABLE)
+			break;
 		if (populated_zone(zone)) {
 			if (IS_ENABLED(CONFIG_HIGHMEM))
 				node_set_state(nid, N_HIGH_MEMORY);
-			if (zone_type <= ZONE_NORMAL)
+			if (zt <= ZONE_NORMAL)
 				node_set_state(nid, N_NORMAL_MEMORY);
 			break;
 		}
@@ -8356,9 +8363,9 @@ void __init free_area_init(unsigned long *max_zone_pfn)
 	start_pfn = PHYS_PFN(memblock_start_of_DRAM());
 	descending = arch_has_descending_max_zone_pfns();
 
-	for (i = 0; i < MAX_NR_ZONES; i++) {
+	for (i = 0; i < MAX_NR_ZONE_TYPES; i++) {
 		if (descending)
-			zone = MAX_NR_ZONES - i - 1;
+			zone = MAX_NR_ZONE_TYPES - i - 1;
 		else
 			zone = i;
 
@@ -8378,7 +8385,7 @@ void __init free_area_init(unsigned long *max_zone_pfn)
 
 	/* Print out the zone ranges */
 	pr_info("Zone ranges:\n");
-	for (i = 0; i < MAX_NR_ZONES; i++) {
+	for (i = 0; i < MAX_NR_ZONE_TYPES; i++) {
 		if (i == ZONE_MOVABLE)
 			continue;
 		pr_info("  %-8s ", zone_names[i]);
@@ -8703,7 +8710,8 @@ static void calculate_totalreserve_pages(void)
 {
 	struct pglist_data *pgdat;
 	unsigned long reserve_pages = 0;
-	enum zone_type i, j;
+	int i;
+	enum zone_type j;
 
 	for_each_online_pgdat(pgdat) {
 
@@ -8715,7 +8723,7 @@ static void calculate_totalreserve_pages(void)
 			unsigned long managed_pages = zone_managed_pages(zone);
 
 			/* Find valid and maximum lowmem_reserve in the zone */
-			for (j = i; j < MAX_NR_ZONES; j++) {
+			for (j = i; j < MAX_NR_ZONE_TYPES; j++) {
 				if (zone->lowmem_reserve[j] > max)
 					max = zone->lowmem_reserve[j];
 			}
@@ -8746,13 +8754,13 @@ static void setup_per_zone_lowmem_reserve(void)
 	enum zone_type i, j;
 
 	for_each_online_pgdat(pgdat) {
-		for (i = 0; i < MAX_NR_ZONES - 1; i++) {
+		for (i = 0; i < MAX_NR_ZONE_TYPES - 1; i++) {
 			struct zone *zone = &pgdat->node_zones[i];
 			int ratio = sysctl_lowmem_reserve_ratio[i];
 			bool clear = !ratio || !zone_managed_pages(zone);
 			unsigned long managed_pages = 0;
 
-			for (j = i + 1; j < MAX_NR_ZONES; j++) {
+			for (j = i + 1; j < MAX_NR_ZONE_TYPES; j++) {
 				struct zone *upper_zone = &pgdat->node_zones[j];
 
 				managed_pages += zone_managed_pages(upper_zone);
@@ -9023,7 +9031,7 @@ int lowmem_reserve_ratio_sysctl_handler(struct ctl_table *table, int write,
 
 	proc_dointvec_minmax(table, write, buffer, length, ppos);
 
-	for (i = 0; i < MAX_NR_ZONES; i++) {
+	for (i = 0; i < MAX_NR_ZONE_TYPES; i++) {
 		if (sysctl_lowmem_reserve_ratio[i] < 1)
 			sysctl_lowmem_reserve_ratio[i] = 0;
 	}
@@ -9764,7 +9772,7 @@ bool has_managed_dma(void)
 	struct pglist_data *pgdat;
 
 	for_each_online_pgdat(pgdat) {
-		struct zone *zone = &pgdat->node_zones[ZONE_DMA];
+		struct zone *zone = &pgdat->node_zones[last_zone_idx(pgdat, ZONE_DMA)];
 
 		if (managed_zone(zone))
 			return true;
diff --git a/mm/page_isolation.c b/mm/page_isolation.c
index 47fbc1696466..00dfec51d88d 100644
--- a/mm/page_isolation.c
+++ b/mm/page_isolation.c
@@ -69,7 +69,7 @@ static struct page *has_unmovable_pages(unsigned long start_pfn, unsigned long e
 		 * pages then it should be reasonably safe to assume the rest
 		 * is movable.
 		 */
-		if (zone_idx(zone) == ZONE_MOVABLE)
+		if (zone_type_num(zone) == ZONE_MOVABLE)
 			continue;
 
 		/*
diff --git a/mm/shmem.c b/mm/shmem.c
index 448f393d8ab2..8295db298fa4 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1622,7 +1622,7 @@ static struct folio *shmem_alloc_and_acct_folio(gfp_t gfp, struct inode *inode,
  */
 static bool shmem_should_replace_folio(struct folio *folio, gfp_t gfp)
 {
-	return folio_zonenum(folio) > gfp_zone(gfp);
+	return folio_zone_type(folio) > gfp_zone(gfp);
 }
 
 static int shmem_replace_folio(struct folio **foliop, gfp_t gfp,
diff --git a/mm/slab.c b/mm/slab.c
index edbe722fb906..2734034d93ac 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -3072,7 +3072,7 @@ static void *fallback_alloc(struct kmem_cache *cache, gfp_t flags)
 	struct zonelist *zonelist;
 	struct zoneref *z;
 	struct zone *zone;
-	enum zone_type highest_zoneidx = gfp_zone(flags);
+	enum zone_type highest_zone_type = gfp_zone(flags);
 	void *obj = NULL;
 	struct slab *slab;
 	int nid;
@@ -3090,7 +3090,7 @@ static void *fallback_alloc(struct kmem_cache *cache, gfp_t flags)
 	 * Look through allowed nodes for objects available
 	 * from existing per node queues.
 	 */
-	for_each_zone_zonelist(zone, z, zonelist, highest_zoneidx) {
+	for_each_zone_zonelist(zone, z, zonelist, highest_zone_type) {
 		nid = zone_to_nid(zone);
 
 		if (cpuset_zone_allowed(zone, flags) &&
diff --git a/mm/slub.c b/mm/slub.c
index 39327e98fce3..9ef2105eb3a4 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2318,7 +2318,7 @@ static void *get_any_partial(struct kmem_cache *s, struct partial_context *pc)
 	struct zonelist *zonelist;
 	struct zoneref *z;
 	struct zone *zone;
-	enum zone_type highest_zoneidx = gfp_zone(pc->flags);
+	enum zone_type highest_zone_type = gfp_zone(pc->flags);
 	void *object;
 	unsigned int cpuset_mems_cookie;
 
@@ -2347,7 +2347,7 @@ static void *get_any_partial(struct kmem_cache *s, struct partial_context *pc)
 	do {
 		cpuset_mems_cookie = read_mems_allowed_begin();
 		zonelist = node_zonelist(mempolicy_slab_node(), pc->flags);
-		for_each_zone_zonelist(zone, z, zonelist, highest_zoneidx) {
+		for_each_zone_zonelist(zone, z, zonelist, highest_zone_type) {
 			struct kmem_cache_node *n;
 
 			n = get_node(s, zone_to_nid(zone));
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 9c1c5e8b24b8..c8a9e454f8a8 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -143,8 +143,8 @@ struct scan_control {
 	/* Scan (total_size >> priority) pages at once */
 	s8 priority;
 
-	/* The highest zone to isolate folios for reclaim from */
-	s8 reclaim_idx;
+	/* The highest zone type to isolate folios for reclaim from */
+	s8 reclaim_zt;
 
 	/* This context's GFP mask */
 	gfp_t gfp_mask;
@@ -2230,6 +2230,7 @@ static unsigned long isolate_lru_folios(unsigned long nr_to_scan,
 		enum lru_list lru)
 {
 	struct list_head *src = &lruvec->lists[lru];
+	pg_data_t *pgdat = lruvec_pgdat(lruvec);
 	unsigned long nr_taken = 0;
 	unsigned long nr_zone_taken[MAX_NR_ZONES] = { 0 };
 	unsigned long nr_skipped[MAX_NR_ZONES] = { 0, };
@@ -2249,8 +2250,8 @@ static unsigned long isolate_lru_folios(unsigned long nr_to_scan,
 		nr_pages = folio_nr_pages(folio);
 		total_scan += nr_pages;
 
-		if (folio_zonenum(folio) > sc->reclaim_idx) {
-			nr_skipped[folio_zonenum(folio)] += nr_pages;
+		if (folio_zone_type(folio) > sc->reclaim_zt) {
+			nr_skipped[folio_zone_idx(folio)] += nr_pages;
 			move_to = &folios_skipped;
 			goto move;
 		}
@@ -2284,7 +2285,7 @@ static unsigned long isolate_lru_folios(unsigned long nr_to_scan,
 		}
 
 		nr_taken += nr_pages;
-		nr_zone_taken[folio_zonenum(folio)] += nr_pages;
+		nr_zone_taken[folio_zone_idx(folio)] += nr_pages;
 		move_to = dst;
 move:
 		list_move(&folio->lru, move_to);
@@ -2302,15 +2303,18 @@ static unsigned long isolate_lru_folios(unsigned long nr_to_scan,
 
 		list_splice(&folios_skipped, src);
 		for (zid = 0; zid < MAX_NR_ZONES; zid++) {
+			enum zone_type zt;
+
 			if (!nr_skipped[zid])
 				continue;
 
-			__count_zid_vm_events(PGSCAN_SKIP, zid, nr_skipped[zid]);
+			zt = zone_type_num(&pgdat->node_zones[zid]);
+			__count_zt_vm_events(PGSCAN_SKIP, zt, nr_skipped[zid]);
 			skipped += nr_skipped[zid];
 		}
 	}
 	*nr_scanned = total_scan;
-	trace_mm_vmscan_lru_isolate(sc->reclaim_idx, sc->order, nr_to_scan,
+	trace_mm_vmscan_lru_isolate(sc->reclaim_zt, sc->order, nr_to_scan,
 				    total_scan, skipped, nr_taken,
 				    sc->may_unmap ? 0 : ISOLATE_UNMAPPED, lru);
 	update_lru_sizes(lruvec, lru, nr_zone_taken);
@@ -3039,7 +3043,8 @@ static void get_scan_count(struct lruvec *lruvec, struct scan_control *sc,
 		unsigned long low, min;
 		unsigned long scan;
 
-		lruvec_size = lruvec_lru_size(lruvec, lru, sc->reclaim_idx);
+		lruvec_size = lruvec_lru_size(lruvec, lru,
+					      last_zone_idx(pgdat, sc->reclaim_zt));
 		mem_cgroup_protection(sc->target_mem_cgroup, memcg,
 				      &min, &low);
 
@@ -3757,7 +3762,7 @@ static void update_batch_size(struct lru_gen_mm_walk *walk, struct folio *folio,
 			      int old_gen, int new_gen)
 {
 	int type = folio_is_file_lru(folio);
-	int zone = folio_zonenum(folio);
+	int zone = folio_zone_idx(folio);
 	int delta = folio_nr_pages(folio);
 
 	VM_WARN_ON_ONCE(old_gen >= MAX_NR_GENS);
@@ -4305,7 +4310,7 @@ static bool inc_min_seq(struct lruvec *lruvec, int type, bool can_swap)
 			VM_WARN_ON_ONCE_FOLIO(folio_test_unevictable(folio), folio);
 			VM_WARN_ON_ONCE_FOLIO(folio_test_active(folio), folio);
 			VM_WARN_ON_ONCE_FOLIO(folio_is_file_lru(folio) != type, folio);
-			VM_WARN_ON_ONCE_FOLIO(folio_zonenum(folio) != zone, folio);
+			VM_WARN_ON_ONCE_FOLIO(folio_zone_idx(folio) != zone, folio);
 
 			new_gen = folio_inc_gen(lruvec, folio, false);
 			list_move_tail(&folio->lru, &lrugen->folios[new_gen][type][zone]);
@@ -4833,7 +4838,7 @@ static bool sort_folio(struct lruvec *lruvec, struct folio *folio, int tier_idx)
 	bool success;
 	int gen = folio_lru_gen(folio);
 	int type = folio_is_file_lru(folio);
-	int zone = folio_zonenum(folio);
+	int zone = folio_zone_idx(folio);
 	int delta = folio_nr_pages(folio);
 	int refs = folio_lru_refs(folio);
 	int tier = lru_tier_from_refs(refs);
@@ -4935,6 +4940,7 @@ static int scan_folios(struct lruvec *lruvec, struct scan_control *sc,
 	int remaining = MAX_LRU_BATCH;
 	struct lru_gen_folio *lrugen = &lruvec->lrugen;
 	struct mem_cgroup *memcg = lruvec_memcg(lruvec);
+	struct pglist_data *pgdat = lruvec_pgdat(lruvec);
 
 	VM_WARN_ON_ONCE(!list_empty(list));
 
@@ -4943,7 +4949,7 @@ static int scan_folios(struct lruvec *lruvec, struct scan_control *sc,
 
 	gen = lru_gen_from_seq(lrugen->min_seq[type]);
 
-	for (zone = sc->reclaim_idx; zone >= 0; zone--) {
+	for (zone = last_zone_idx(pgdat, sc->reclaim_zt); zone >= 0; zone--) {
 		LIST_HEAD(moved);
 		int skipped = 0;
 		struct list_head *head = &lrugen->folios[gen][type][zone];
@@ -4955,7 +4961,7 @@ static int scan_folios(struct lruvec *lruvec, struct scan_control *sc,
 			VM_WARN_ON_ONCE_FOLIO(folio_test_unevictable(folio), folio);
 			VM_WARN_ON_ONCE_FOLIO(folio_test_active(folio), folio);
 			VM_WARN_ON_ONCE_FOLIO(folio_is_file_lru(folio) != type, folio);
-			VM_WARN_ON_ONCE_FOLIO(folio_zonenum(folio) != zone, folio);
+			VM_WARN_ON_ONCE_FOLIO(folio_zone_idx(folio) != zone, folio);
 
 			scanned += delta;
 
@@ -4974,8 +4980,11 @@ static int scan_folios(struct lruvec *lruvec, struct scan_control *sc,
 		}
 
 		if (skipped) {
+			enum zone_type zt;
+
 			list_splice(&moved, head);
-			__count_zid_vm_events(PGSCAN_SKIP, zone, skipped);
+			zt = zone_type_num(&pgdat->node_zones[zone]);
+			__count_zt_vm_events(PGSCAN_SKIP, zt, skipped);
 		}
 
 		if (!remaining || isolated >= MIN_LRU_BATCH)
@@ -4992,7 +5001,7 @@ static int scan_folios(struct lruvec *lruvec, struct scan_control *sc,
 	__count_vm_events(PGSCAN_ANON + type, isolated);
 
 	/*
-	 * There might not be eligible folios due to reclaim_idx. Check the
+	 * There might not be eligible folios due to reclaim_zt. Check the
 	 * remaining to prevent livelock if it's not making progress.
 	 */
 	return isolated || !remaining ? scanned : 0;
@@ -5594,7 +5603,7 @@ static bool drain_evictable(struct lruvec *lruvec)
 			VM_WARN_ON_ONCE_FOLIO(folio_test_unevictable(folio), folio);
 			VM_WARN_ON_ONCE_FOLIO(folio_test_active(folio), folio);
 			VM_WARN_ON_ONCE_FOLIO(folio_is_file_lru(folio) != type, folio);
-			VM_WARN_ON_ONCE_FOLIO(folio_zonenum(folio) != zone, folio);
+			VM_WARN_ON_ONCE_FOLIO(folio_zone_idx(folio) != zone, folio);
 
 			success = lru_gen_del_folio(lruvec, folio, false);
 			VM_WARN_ON_ONCE(!success);
@@ -6022,7 +6031,7 @@ static ssize_t lru_gen_seq_write(struct file *file, const char __user *src,
 		.may_writepage = true,
 		.may_unmap = true,
 		.may_swap = true,
-		.reclaim_idx = MAX_NR_ZONES - 1,
+		.reclaim_zt = MAX_NR_ZONE_TYPES - 1,
 		.gfp_mask = GFP_KERNEL,
 	};
 
@@ -6363,12 +6372,12 @@ static inline bool should_continue_reclaim(struct pglist_data *pgdat,
 		return false;
 
 	/* If compaction would go ahead or the allocation would succeed, stop */
-	for (z = 0; z <= sc->reclaim_idx; z++) {
+	for (z = 0; z <= last_zone_idx(pgdat, sc->reclaim_zt); z++) {
 		struct zone *zone = &pgdat->node_zones[z];
 		if (!managed_zone(zone))
 			continue;
 
-		switch (compaction_suitable(zone, sc->order, 0, sc->reclaim_idx)) {
+		switch (compaction_suitable(zone, sc->order, 0, sc->reclaim_zt)) {
 		case COMPACT_SUCCESS:
 		case COMPACT_CONTINUE:
 			return false;
@@ -6569,7 +6578,7 @@ static inline bool compaction_ready(struct zone *zone, struct scan_control *sc)
 	unsigned long watermark;
 	enum compact_result suitable;
 
-	suitable = compaction_suitable(zone, sc->order, 0, sc->reclaim_idx);
+	suitable = compaction_suitable(zone, sc->order, 0, sc->reclaim_zt);
 	if (suitable == COMPACT_SUCCESS)
 		/* Allocation should succeed already. Don't reclaim. */
 		return true;
@@ -6588,7 +6597,7 @@ static inline bool compaction_ready(struct zone *zone, struct scan_control *sc)
 	 */
 	watermark = high_wmark_pages(zone) + compact_gap(sc->order);
 
-	return zone_watermark_ok_safe(zone, 0, watermark, sc->reclaim_idx);
+	return zone_watermark_ok_safe(zone, 0, watermark, sc->reclaim_zt);
 }
 
 static void consider_reclaim_throttle(pg_data_t *pgdat, struct scan_control *sc)
@@ -6647,11 +6656,11 @@ static void shrink_zones(struct zonelist *zonelist, struct scan_control *sc)
 	orig_mask = sc->gfp_mask;
 	if (buffer_heads_over_limit) {
 		sc->gfp_mask |= __GFP_HIGHMEM;
-		sc->reclaim_idx = gfp_zone(sc->gfp_mask);
+		sc->reclaim_zt = gfp_zone(sc->gfp_mask);
 	}
 
 	for_each_zone_zonelist_nodemask(zone, z, zonelist,
-					sc->reclaim_idx, sc->nodemask) {
+					sc->reclaim_zt, sc->nodemask) {
 		/*
 		 * Take care memory controller reclaiming has small influence
 		 * to global LRU.
@@ -6763,7 +6772,7 @@ static unsigned long do_try_to_free_pages(struct zonelist *zonelist,
 	delayacct_freepages_start();
 
 	if (!cgroup_reclaim(sc))
-		__count_zid_vm_events(ALLOCSTALL, sc->reclaim_idx, 1);
+		__count_zt_vm_events(ALLOCSTALL, sc->reclaim_zt, 1);
 
 	do {
 		if (!sc->proactive)
@@ -6787,7 +6796,7 @@ static unsigned long do_try_to_free_pages(struct zonelist *zonelist,
 	} while (--sc->priority >= 0);
 
 	last_pgdat = NULL;
-	for_each_zone_zonelist_nodemask(zone, z, zonelist, sc->reclaim_idx,
+	for_each_zone_zonelist_nodemask(zone, z, zonelist, sc->reclaim_zt,
 					sc->nodemask) {
 		if (zone->zone_pgdat == last_pgdat)
 			continue;
@@ -6815,7 +6824,7 @@ static unsigned long do_try_to_free_pages(struct zonelist *zonelist,
 
 	/*
 	 * We make inactive:active ratio decisions based on the node's
-	 * composition of memory, but a restrictive reclaim_idx or a
+	 * composition of memory, but a restrictive reclaim_zt or a
 	 * memory.low cgroup setting can exempt large amounts of
 	 * memory from reclaim. Neither of which are very common, so
 	 * instead of doing costly eligibility calculations of the
@@ -6852,7 +6861,7 @@ static bool allow_direct_reclaim(pg_data_t *pgdat)
 	if (pgdat->kswapd_failures >= MAX_RECLAIM_RETRIES)
 		return true;
 
-	for (i = 0; i <= ZONE_NORMAL; i++) {
+	for (i = 0; i <= last_zone_idx(pgdat, ZONE_NORMAL); i++) {
 		zone = &pgdat->node_zones[i];
 		if (!managed_zone(zone))
 			continue;
@@ -6872,8 +6881,8 @@ static bool allow_direct_reclaim(pg_data_t *pgdat)
 
 	/* kswapd must be awake if processes are being throttled */
 	if (!wmark_ok && waitqueue_active(&pgdat->kswapd_wait)) {
-		if (READ_ONCE(pgdat->kswapd_highest_zoneidx) > ZONE_NORMAL)
-			WRITE_ONCE(pgdat->kswapd_highest_zoneidx, ZONE_NORMAL);
+		if (READ_ONCE(pgdat->kswapd_highest_zone_type) > ZONE_NORMAL)
+			WRITE_ONCE(pgdat->kswapd_highest_zone_type, ZONE_NORMAL);
 
 		wake_up_interruptible(&pgdat->kswapd_wait);
 	}
@@ -6930,7 +6939,7 @@ static bool throttle_direct_reclaim(gfp_t gfp_mask, struct zonelist *zonelist,
 	 */
 	for_each_zone_zonelist_nodemask(zone, z, zonelist,
 					gfp_zone(gfp_mask), nodemask) {
-		if (zone_idx(zone) > ZONE_NORMAL)
+		if (zone_type_num(zone) > ZONE_NORMAL)
 			continue;
 
 		/* Throttle based on the first usable node */
@@ -6977,7 +6986,7 @@ unsigned long try_to_free_pages(struct zonelist *zonelist, int order,
 	struct scan_control sc = {
 		.nr_to_reclaim = SWAP_CLUSTER_MAX,
 		.gfp_mask = current_gfp_context(gfp_mask),
-		.reclaim_idx = gfp_zone(gfp_mask),
+		.reclaim_zt = gfp_zone(gfp_mask),
 		.order = order,
 		.nodemask = nodemask,
 		.priority = DEF_PRIORITY,
@@ -6987,7 +6996,7 @@ unsigned long try_to_free_pages(struct zonelist *zonelist, int order,
 	};
 
 	/*
-	 * scan_control uses s8 fields for order, priority, and reclaim_idx.
+	 * scan_control uses s8 fields for order, priority, and reclaim_zt.
 	 * Confirm they are large enough for max values.
 	 */
 	BUILD_BUG_ON(MAX_ORDER > S8_MAX);
@@ -7027,7 +7036,7 @@ unsigned long mem_cgroup_shrink_node(struct mem_cgroup *memcg,
 		.target_mem_cgroup = memcg,
 		.may_writepage = !laptop_mode,
 		.may_unmap = 1,
-		.reclaim_idx = MAX_NR_ZONES - 1,
+		.reclaim_zt = MAX_NR_ZONE_TYPES - 1,
 		.may_swap = !noswap,
 	};
 
@@ -7066,7 +7075,7 @@ unsigned long try_to_free_mem_cgroup_pages(struct mem_cgroup *memcg,
 		.nr_to_reclaim = max(nr_pages, SWAP_CLUSTER_MAX),
 		.gfp_mask = (current_gfp_context(gfp_mask) & GFP_RECLAIM_MASK) |
 				(GFP_HIGHUSER_MOVABLE & ~GFP_RECLAIM_MASK),
-		.reclaim_idx = MAX_NR_ZONES - 1,
+		.reclaim_zt = MAX_NR_ZONE_TYPES - 1,
 		.target_mem_cgroup = memcg,
 		.priority = DEF_PRIORITY,
 		.may_writepage = !laptop_mode,
@@ -7121,7 +7130,7 @@ static void kswapd_age_node(struct pglist_data *pgdat, struct scan_control *sc)
 	} while (memcg);
 }
 
-static bool pgdat_watermark_boosted(pg_data_t *pgdat, int highest_zoneidx)
+static bool pgdat_watermark_boosted(pg_data_t *pgdat, enum zone_type highest_zone_type)
 {
 	int i;
 	struct zone *zone;
@@ -7133,7 +7142,7 @@ static bool pgdat_watermark_boosted(pg_data_t *pgdat, int highest_zoneidx)
 	 * start prematurely when there is no boosting and a lower
 	 * zone is balanced.
 	 */
-	for (i = highest_zoneidx; i >= 0; i--) {
+	for (i = last_zone_idx(pgdat, highest_zone_type); i >= 0; i--) {
 		zone = pgdat->node_zones + i;
 		if (!managed_zone(zone))
 			continue;
@@ -7147,9 +7156,9 @@ static bool pgdat_watermark_boosted(pg_data_t *pgdat, int highest_zoneidx)
 
 /*
  * Returns true if there is an eligible zone balanced for the request order
- * and highest_zoneidx
+ * and highest_zone_type
  */
-static bool pgdat_balanced(pg_data_t *pgdat, int order, int highest_zoneidx)
+static bool pgdat_balanced(pg_data_t *pgdat, int order, enum zone_type highest_zone_type)
 {
 	int i;
 	unsigned long mark = -1;
@@ -7159,7 +7168,7 @@ static bool pgdat_balanced(pg_data_t *pgdat, int order, int highest_zoneidx)
 	 * Check watermarks bottom-up as lower zones are more likely to
 	 * meet watermarks.
 	 */
-	for (i = 0; i <= highest_zoneidx; i++) {
+	for (i = 0; i <= last_zone_idx(pgdat, highest_zone_type); i++) {
 		zone = pgdat->node_zones + i;
 
 		if (!managed_zone(zone))
@@ -7169,12 +7178,12 @@ static bool pgdat_balanced(pg_data_t *pgdat, int order, int highest_zoneidx)
 			mark = wmark_pages(zone, WMARK_PROMO);
 		else
 			mark = high_wmark_pages(zone);
-		if (zone_watermark_ok_safe(zone, order, mark, highest_zoneidx))
+		if (zone_watermark_ok_safe(zone, order, mark, highest_zone_type))
 			return true;
 	}
 
 	/*
-	 * If a node has no managed zone within highest_zoneidx, it does not
+	 * If a node has no managed zone within highest_zone_type, it does not
 	 * need balancing by definition. This can happen if a zone-restricted
 	 * allocation tries to wake a remote kswapd.
 	 */
@@ -7201,7 +7210,7 @@ static void clear_pgdat_congested(pg_data_t *pgdat)
  * Returns true if kswapd is ready to sleep
  */
 static bool prepare_kswapd_sleep(pg_data_t *pgdat, int order,
-				int highest_zoneidx)
+				enum zone_type highest_zone_type)
 {
 	/*
 	 * The throttled processes are normally woken up in balance_pgdat() as
@@ -7223,7 +7232,7 @@ static bool prepare_kswapd_sleep(pg_data_t *pgdat, int order,
 	if (pgdat->kswapd_failures >= MAX_RECLAIM_RETRIES)
 		return true;
 
-	if (pgdat_balanced(pgdat, order, highest_zoneidx)) {
+	if (pgdat_balanced(pgdat, order, highest_zone_type)) {
 		clear_pgdat_congested(pgdat);
 		return true;
 	}
@@ -7247,7 +7256,7 @@ static bool kswapd_shrink_node(pg_data_t *pgdat,
 
 	/* Reclaim a number of pages proportional to the number of zones */
 	sc->nr_to_reclaim = 0;
-	for (z = 0; z <= sc->reclaim_idx; z++) {
+	for (z = 0; z <= last_zone_idx(pgdat, sc->reclaim_zt); z++) {
 		zone = pgdat->node_zones + z;
 		if (!managed_zone(zone))
 			continue;
@@ -7276,12 +7285,12 @@ static bool kswapd_shrink_node(pg_data_t *pgdat,
 
 /* Page allocator PCP high watermark is lowered if reclaim is active. */
 static inline void
-update_reclaim_active(pg_data_t *pgdat, int highest_zoneidx, bool active)
+update_reclaim_active(pg_data_t *pgdat, enum zone_type highest_zone_type, bool active)
 {
 	int i;
 	struct zone *zone;
 
-	for (i = 0; i <= highest_zoneidx; i++) {
+	for (i = 0; i <= last_zone_idx(pgdat, highest_zone_type); i++) {
 		zone = pgdat->node_zones + i;
 
 		if (!managed_zone(zone))
@@ -7295,15 +7304,15 @@ update_reclaim_active(pg_data_t *pgdat, int highest_zoneidx, bool active)
 }
 
 static inline void
-set_reclaim_active(pg_data_t *pgdat, int highest_zoneidx)
+set_reclaim_active(pg_data_t *pgdat, enum zone_type highest_zone_type)
 {
-	update_reclaim_active(pgdat, highest_zoneidx, true);
+	update_reclaim_active(pgdat, highest_zone_type, true);
 }
 
 static inline void
-clear_reclaim_active(pg_data_t *pgdat, int highest_zoneidx)
+clear_reclaim_active(pg_data_t *pgdat, enum zone_type highest_zone_type)
 {
-	update_reclaim_active(pgdat, highest_zoneidx, false);
+	update_reclaim_active(pgdat, highest_zone_type, false);
 }
 
 /*
@@ -7319,7 +7328,7 @@ clear_reclaim_active(pg_data_t *pgdat, int highest_zoneidx)
  * or lower is eligible for reclaim until at least one usable zone is
  * balanced.
  */
-static int balance_pgdat(pg_data_t *pgdat, int order, int highest_zoneidx)
+static int balance_pgdat(pg_data_t *pgdat, int order, enum zone_type highest_zone_type)
 {
 	int i;
 	unsigned long nr_soft_reclaimed;
@@ -7347,7 +7356,7 @@ static int balance_pgdat(pg_data_t *pgdat, int order, int highest_zoneidx)
 	 * stall or direct reclaim until kswapd is finished.
 	 */
 	nr_boost_reclaim = 0;
-	for (i = 0; i <= highest_zoneidx; i++) {
+	for (i = 0; i <= last_zone_idx(pgdat, highest_zone_type); i++) {
 		zone = pgdat->node_zones + i;
 		if (!managed_zone(zone))
 			continue;
@@ -7358,7 +7367,7 @@ static int balance_pgdat(pg_data_t *pgdat, int order, int highest_zoneidx)
 	boosted = nr_boost_reclaim;
 
 restart:
-	set_reclaim_active(pgdat, highest_zoneidx);
+	set_reclaim_active(pgdat, highest_zone_type);
 	sc.priority = DEF_PRIORITY;
 	do {
 		unsigned long nr_reclaimed = sc.nr_reclaimed;
@@ -7366,7 +7375,7 @@ static int balance_pgdat(pg_data_t *pgdat, int order, int highest_zoneidx)
 		bool balanced;
 		bool ret;
 
-		sc.reclaim_idx = highest_zoneidx;
+		sc.reclaim_zt = highest_zone_type;
 
 		/*
 		 * If the number of buffer_heads exceeds the maximum allowed
@@ -7384,7 +7393,7 @@ static int balance_pgdat(pg_data_t *pgdat, int order, int highest_zoneidx)
 				if (!managed_zone(zone))
 					continue;
 
-				sc.reclaim_idx = i;
+				sc.reclaim_zt = zone_type_num(zone);
 				break;
 			}
 		}
@@ -7396,7 +7405,7 @@ static int balance_pgdat(pg_data_t *pgdat, int order, int highest_zoneidx)
 		 * on the grounds that the normal reclaim should be enough to
 		 * re-evaluate if boosting is required when kswapd next wakes.
 		 */
-		balanced = pgdat_balanced(pgdat, sc.order, highest_zoneidx);
+		balanced = pgdat_balanced(pgdat, sc.order, highest_zone_type);
 		if (!balanced && nr_boost_reclaim) {
 			nr_boost_reclaim = 0;
 			goto restart;
@@ -7404,7 +7413,7 @@ static int balance_pgdat(pg_data_t *pgdat, int order, int highest_zoneidx)
 
 		/*
 		 * If boosting is not active then only reclaim if there are no
-		 * eligible zones. Note that sc.reclaim_idx is not used as
+		 * eligible zones. Note that sc.reclaim_zt is not used as
 		 * buffer_heads_over_limit may have adjusted it.
 		 */
 		if (!nr_boost_reclaim && balanced)
@@ -7491,13 +7500,13 @@ static int balance_pgdat(pg_data_t *pgdat, int order, int highest_zoneidx)
 		pgdat->kswapd_failures++;
 
 out:
-	clear_reclaim_active(pgdat, highest_zoneidx);
+	clear_reclaim_active(pgdat, highest_zone_type);
 
 	/* If reclaim was boosted, account for the reclaim done in this pass */
 	if (boosted) {
 		unsigned long flags;
 
-		for (i = 0; i <= highest_zoneidx; i++) {
+		for (i = 0; i <= last_zone_idx(pgdat, highest_zone_type); i++) {
 			if (!zone_boosts[i])
 				continue;
 
@@ -7512,7 +7521,7 @@ static int balance_pgdat(pg_data_t *pgdat, int order, int highest_zoneidx)
 		 * As there is now likely space, wakeup kcompact to defragment
 		 * pageblocks.
 		 */
-		wakeup_kcompactd(pgdat, pageblock_order, highest_zoneidx);
+		wakeup_kcompactd(pgdat, pageblock_order, highest_zone_type);
 	}
 
 	snapshot_refaults(NULL, pgdat);
@@ -7530,22 +7539,22 @@ static int balance_pgdat(pg_data_t *pgdat, int order, int highest_zoneidx)
 }
 
 /*
- * The pgdat->kswapd_highest_zoneidx is used to pass the highest zone index to
- * be reclaimed by kswapd from the waker. If the value is MAX_NR_ZONES which is
- * not a valid index then either kswapd runs for first time or kswapd couldn't
+ * The pgdat->kswapd_highest_zone_type is used to pass the highest zone type to
+ * be reclaimed by kswapd from the waker. If the value is MAX_NR_ZONE_TYPES which is
+ * not a valid type then either kswapd runs for first time or kswapd couldn't
  * sleep after previous reclaim attempt (node is still unbalanced). In that
- * case return the zone index of the previous kswapd reclaim cycle.
+ * case return the zone type of the previous kswapd reclaim cycle.
  */
-static enum zone_type kswapd_highest_zoneidx(pg_data_t *pgdat,
-					   enum zone_type prev_highest_zoneidx)
+static enum zone_type kswapd_highest_zone_type(pg_data_t *pgdat,
+					   enum zone_type prev_highest_zone_type)
 {
-	enum zone_type curr_idx = READ_ONCE(pgdat->kswapd_highest_zoneidx);
+	enum zone_type curr_type = READ_ONCE(pgdat->kswapd_highest_zone_type);
 
-	return curr_idx == MAX_NR_ZONES ? prev_highest_zoneidx : curr_idx;
+	return curr_type == MAX_NR_ZONE_TYPES ? prev_highest_zone_type : curr_type;
 }
 
 static void kswapd_try_to_sleep(pg_data_t *pgdat, int alloc_order, int reclaim_order,
-				unsigned int highest_zoneidx)
+				enum zone_type highest_zone_type)
 {
 	long remaining = 0;
 	DEFINE_WAIT(wait);
@@ -7562,7 +7571,7 @@ static void kswapd_try_to_sleep(pg_data_t *pgdat, int alloc_order, int reclaim_o
 	 * eligible zone balanced that it's also unlikely that compaction will
 	 * succeed.
 	 */
-	if (prepare_kswapd_sleep(pgdat, reclaim_order, highest_zoneidx)) {
+	if (prepare_kswapd_sleep(pgdat, reclaim_order, highest_zone_type)) {
 		/*
 		 * Compaction records what page blocks it recently failed to
 		 * isolate pages from and skips them in the future scanning.
@@ -7575,19 +7584,19 @@ static void kswapd_try_to_sleep(pg_data_t *pgdat, int alloc_order, int reclaim_o
 		 * We have freed the memory, now we should compact it to make
 		 * allocation of the requested order possible.
 		 */
-		wakeup_kcompactd(pgdat, alloc_order, highest_zoneidx);
+		wakeup_kcompactd(pgdat, alloc_order, highest_zone_type);
 
 		remaining = schedule_timeout(HZ/10);
 
 		/*
-		 * If woken prematurely then reset kswapd_highest_zoneidx and
+		 * If woken prematurely then reset kswapd_highest_zone_type and
 		 * order. The values will either be from a wakeup request or
 		 * the previous request that slept prematurely.
 		 */
 		if (remaining) {
-			WRITE_ONCE(pgdat->kswapd_highest_zoneidx,
-					kswapd_highest_zoneidx(pgdat,
-							highest_zoneidx));
+			WRITE_ONCE(pgdat->kswapd_highest_zone_type,
+					kswapd_highest_zone_type(pgdat,
+							highest_zone_type));
 
 			if (READ_ONCE(pgdat->kswapd_order) < reclaim_order)
 				WRITE_ONCE(pgdat->kswapd_order, reclaim_order);
@@ -7602,7 +7611,7 @@ static void kswapd_try_to_sleep(pg_data_t *pgdat, int alloc_order, int reclaim_o
 	 * go fully to sleep until explicitly woken up.
 	 */
 	if (!remaining &&
-	    prepare_kswapd_sleep(pgdat, reclaim_order, highest_zoneidx)) {
+	    prepare_kswapd_sleep(pgdat, reclaim_order, highest_zone_type)) {
 		trace_mm_vmscan_kswapd_sleep(pgdat->node_id);
 
 		/*
@@ -7644,7 +7653,7 @@ static void kswapd_try_to_sleep(pg_data_t *pgdat, int alloc_order, int reclaim_o
 static int kswapd(void *p)
 {
 	unsigned int alloc_order, reclaim_order;
-	unsigned int highest_zoneidx = MAX_NR_ZONES - 1;
+	enum zone_type highest_zone_type = MAX_NR_ZONE_TYPES - 1;
 	pg_data_t *pgdat = (pg_data_t *)p;
 	struct task_struct *tsk = current;
 	const struct cpumask *cpumask = cpumask_of_node(pgdat->node_id);
@@ -7668,25 +7677,25 @@ static int kswapd(void *p)
 	set_freezable();
 
 	WRITE_ONCE(pgdat->kswapd_order, 0);
-	WRITE_ONCE(pgdat->kswapd_highest_zoneidx, MAX_NR_ZONES);
+	WRITE_ONCE(pgdat->kswapd_highest_zone_type, MAX_NR_ZONE_TYPES);
 	atomic_set(&pgdat->nr_writeback_throttled, 0);
 	for ( ; ; ) {
 		bool ret;
 
 		alloc_order = reclaim_order = READ_ONCE(pgdat->kswapd_order);
-		highest_zoneidx = kswapd_highest_zoneidx(pgdat,
-							highest_zoneidx);
+		highest_zone_type = kswapd_highest_zone_type(pgdat,
+							highest_zone_type);
 
 kswapd_try_sleep:
 		kswapd_try_to_sleep(pgdat, alloc_order, reclaim_order,
-					highest_zoneidx);
+					highest_zone_type);
 
-		/* Read the new order and highest_zoneidx */
+		/* Read the new order and highest_zone_type */
 		alloc_order = READ_ONCE(pgdat->kswapd_order);
-		highest_zoneidx = kswapd_highest_zoneidx(pgdat,
-							highest_zoneidx);
+		highest_zone_type = kswapd_highest_zone_type(pgdat,
+							highest_zone_type);
 		WRITE_ONCE(pgdat->kswapd_order, 0);
-		WRITE_ONCE(pgdat->kswapd_highest_zoneidx, MAX_NR_ZONES);
+		WRITE_ONCE(pgdat->kswapd_highest_zone_type, MAX_NR_ZONE_TYPES);
 
 		ret = try_to_freeze();
 		if (kthread_should_stop())
@@ -7707,10 +7716,10 @@ static int kswapd(void *p)
 		 * but kcompactd is woken to compact for the original
 		 * request (alloc_order).
 		 */
-		trace_mm_vmscan_kswapd_wake(pgdat->node_id, highest_zoneidx,
+		trace_mm_vmscan_kswapd_wake(pgdat->node_id, highest_zone_type,
 						alloc_order);
 		reclaim_order = balance_pgdat(pgdat, alloc_order,
-						highest_zoneidx);
+						highest_zone_type);
 		if (reclaim_order < alloc_order)
 			goto kswapd_try_sleep;
 	}
@@ -7728,10 +7737,10 @@ static int kswapd(void *p)
  * needed.
  */
 void wakeup_kswapd(struct zone *zone, gfp_t gfp_flags, int order,
-		   enum zone_type highest_zoneidx)
+		   enum zone_type highest_zone_type)
 {
 	pg_data_t *pgdat;
-	enum zone_type curr_idx;
+	enum zone_type curr_type;
 
 	if (!managed_zone(zone))
 		return;
@@ -7740,10 +7749,10 @@ void wakeup_kswapd(struct zone *zone, gfp_t gfp_flags, int order,
 		return;
 
 	pgdat = zone->zone_pgdat;
-	curr_idx = READ_ONCE(pgdat->kswapd_highest_zoneidx);
+	curr_type = READ_ONCE(pgdat->kswapd_highest_zone_type);
 
-	if (curr_idx == MAX_NR_ZONES || curr_idx < highest_zoneidx)
-		WRITE_ONCE(pgdat->kswapd_highest_zoneidx, highest_zoneidx);
+	if (curr_type == MAX_NR_ZONE_TYPES || curr_type < highest_zone_type)
+		WRITE_ONCE(pgdat->kswapd_highest_zone_type, highest_zone_type);
 
 	if (READ_ONCE(pgdat->kswapd_order) < order)
 		WRITE_ONCE(pgdat->kswapd_order, order);
@@ -7753,8 +7762,8 @@ void wakeup_kswapd(struct zone *zone, gfp_t gfp_flags, int order,
 
 	/* Hopeless node, leave it to direct reclaim if possible */
 	if (pgdat->kswapd_failures >= MAX_RECLAIM_RETRIES ||
-	    (pgdat_balanced(pgdat, order, highest_zoneidx) &&
-	     !pgdat_watermark_boosted(pgdat, highest_zoneidx))) {
+	    (pgdat_balanced(pgdat, order, highest_zone_type) &&
+	     !pgdat_watermark_boosted(pgdat, highest_zone_type))) {
 		/*
 		 * There may be plenty of free memory available, but it's too
 		 * fragmented for high-order allocations.  Wake up kcompactd
@@ -7763,11 +7772,11 @@ void wakeup_kswapd(struct zone *zone, gfp_t gfp_flags, int order,
 		 * ratelimit its work.
 		 */
 		if (!(gfp_flags & __GFP_DIRECT_RECLAIM))
-			wakeup_kcompactd(pgdat, order, highest_zoneidx);
+			wakeup_kcompactd(pgdat, order, highest_zone_type);
 		return;
 	}
 
-	trace_mm_vmscan_wakeup_kswapd(pgdat->node_id, highest_zoneidx, order,
+	trace_mm_vmscan_wakeup_kswapd(pgdat->node_id, highest_zone_type, order,
 				      gfp_flags);
 	wake_up_interruptible(&pgdat->kswapd_wait);
 }
@@ -7786,7 +7795,7 @@ unsigned long shrink_all_memory(unsigned long nr_to_reclaim)
 	struct scan_control sc = {
 		.nr_to_reclaim = nr_to_reclaim,
 		.gfp_mask = GFP_HIGHUSER_MOVABLE,
-		.reclaim_idx = MAX_NR_ZONES - 1,
+		.reclaim_zt = MAX_NR_ZONE_TYPES - 1,
 		.priority = DEF_PRIORITY,
 		.may_writepage = 1,
 		.may_unmap = 1,
@@ -7948,7 +7957,7 @@ static int __node_reclaim(struct pglist_data *pgdat, gfp_t gfp_mask, unsigned in
 		.may_writepage = !!(node_reclaim_mode & RECLAIM_WRITE),
 		.may_unmap = !!(node_reclaim_mode & RECLAIM_UNMAP),
 		.may_swap = 1,
-		.reclaim_idx = gfp_zone(gfp_mask),
+		.reclaim_zt = gfp_zone(gfp_mask),
 	};
 	unsigned long pflags;
 
-- 
2.39.2

