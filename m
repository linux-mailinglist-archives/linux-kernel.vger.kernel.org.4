Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E655B6C37B8
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 18:06:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230491AbjCURGS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 13:06:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjCURFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 13:05:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCA5038648;
        Tue, 21 Mar 2023 10:05:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B65E861D4B;
        Tue, 21 Mar 2023 17:05:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0FB6C4339B;
        Tue, 21 Mar 2023 17:05:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679418340;
        bh=C1pXIKcYXgIYJfFHBMJTCXmJm8Vs0Ul2UXGUIO4IPTk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h2XpFCx7BM5H7J1ITuq/dgmg4sqooPmS8gf9gaNY1F93LuBQgEIhm0kzgy1AAxd+z
         S3aAxNYJNUOjC9+ASjL3un+ZaHg8QGQK/XTRf5YBfNSUkWg8B/CduHLzz3a4A8Agd1
         TYytQLNrXGTcoK53O3o9qGJSNx2WgVnwVPdklx9YZxjSfNpMAl9wA7GsQegnHbgtYu
         H5bRAbo8sn4G3TO5w+yEonQzFfHLlrZtrKuBAh5vDyHPaXQiOmUFI0+Wkly4wiHDbM
         Fqb+4xBMpaTVz5+9/3ctzo1421rN1w+UvGgtFOaBkw9qRh3fxq7P5Qz59JfQ3Q5mSR
         WHvazZZz15yPQ==
From:   Mike Rapoport <rppt@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     David Hildenbrand <david@redhat.com>,
        Doug Berger <opendmb@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH v2 03/14] mm: move most of core MM initialization to mm/mm_init.c
Date:   Tue, 21 Mar 2023 19:05:02 +0200
Message-Id: <20230321170513.2401534-4-rppt@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230321170513.2401534-1-rppt@kernel.org>
References: <20230321170513.2401534-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Mike Rapoport (IBM)" <rppt@kernel.org>

The bulk of memory management initialization code is spread all over
mm/page_alloc.c and makes navigating through page allocator
functionality difficult.

Move most of the functions marked __init and __meminit to mm/mm_init.c
to make it better localized and allow some more spare room before
mm/page_alloc.c reaches 10k lines.

No functional changes.

Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>
Acked-by: David Hildenbrand <david@redhat.com>
---
 include/linux/gfp.h |    5 -
 mm/cma.c            |    1 +
 mm/internal.h       |   38 +-
 mm/mm_init.c        | 2304 ++++++++++++++++++++++++++++++++++
 mm/page_alloc.c     | 2866 ++++---------------------------------------
 5 files changed, 2614 insertions(+), 2600 deletions(-)

diff --git a/include/linux/gfp.h b/include/linux/gfp.h
index 65a78773dcca..7c554e4bd49f 100644
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -361,9 +361,4 @@ extern struct page *alloc_contig_pages(unsigned long nr_pages, gfp_t gfp_mask,
 #endif
 void free_contig_range(unsigned long pfn, unsigned long nr_pages);
 
-#ifdef CONFIG_CMA
-/* CMA stuff */
-extern void init_cma_reserved_pageblock(struct page *page);
-#endif
-
 #endif /* __LINUX_GFP_H */
diff --git a/mm/cma.c b/mm/cma.c
index a7263aa02c92..6268d6620254 100644
--- a/mm/cma.c
+++ b/mm/cma.c
@@ -33,6 +33,7 @@
 #include <linux/kmemleak.h>
 #include <trace/events/cma.h>
 
+#include "internal.h"
 #include "cma.h"
 
 struct cma cma_areas[MAX_CMA_AREAS];
diff --git a/mm/internal.h b/mm/internal.h
index fce94775819c..2a925de49393 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -202,6 +202,8 @@ pmd_t *mm_find_pmd(struct mm_struct *mm, unsigned long address);
  * in mm/page_alloc.c
  */
 
+extern char * const zone_names[MAX_NR_ZONES];
+
 /*
  * Structure for holding the mostly immutable allocation parameters passed
  * between functions involved in allocations, including the alloc_pages*
@@ -366,7 +368,29 @@ extern void __putback_isolated_page(struct page *page, unsigned int order,
 extern void memblock_free_pages(struct page *page, unsigned long pfn,
 					unsigned int order);
 extern void __free_pages_core(struct page *page, unsigned int order);
+
+static inline void prep_compound_head(struct page *page, unsigned int order)
+{
+	struct folio *folio = (struct folio *)page;
+
+	set_compound_page_dtor(page, COMPOUND_PAGE_DTOR);
+	set_compound_order(page, order);
+	atomic_set(&folio->_entire_mapcount, -1);
+	atomic_set(&folio->_nr_pages_mapped, 0);
+	atomic_set(&folio->_pincount, 0);
+}
+
+static inline void prep_compound_tail(struct page *head, int tail_idx)
+{
+	struct page *p = head + tail_idx;
+
+	p->mapping = TAIL_MAPPING;
+	set_compound_head(p, head);
+	set_page_private(p, 0);
+}
+
 extern void prep_compound_page(struct page *page, unsigned int order);
+
 extern void post_alloc_hook(struct page *page, unsigned int order,
 					gfp_t gfp_flags);
 extern int user_min_free_kbytes;
@@ -377,6 +401,7 @@ extern void free_unref_page_list(struct list_head *list);
 extern void zone_pcp_reset(struct zone *zone);
 extern void zone_pcp_disable(struct zone *zone);
 extern void zone_pcp_enable(struct zone *zone);
+extern void zone_pcp_init(struct zone *zone);
 
 extern void *memmap_alloc(phys_addr_t size, phys_addr_t align,
 			  phys_addr_t min_addr,
@@ -474,7 +499,12 @@ isolate_migratepages_range(struct compact_control *cc,
 
 int __alloc_contig_migrate_range(struct compact_control *cc,
 					unsigned long start, unsigned long end);
-#endif
+
+/* Free whole pageblock and set its migration type to MIGRATE_CMA. */
+void init_cma_reserved_pageblock(struct page *page);
+
+#endif /* CONFIG_COMPACTION || CONFIG_CMA */
+
 int find_suitable_fallback(struct free_area *area, unsigned int order,
 			int migratetype, bool only_stealable, bool *can_steal);
 
@@ -679,6 +709,12 @@ static inline loff_t fadvise_calc_endbyte(loff_t offset, loff_t len)
 }
 
 /* Memory initialisation debug and verification */
+#ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT
+DECLARE_STATIC_KEY_TRUE(deferred_pages);
+
+bool __init deferred_grow_zone(struct zone *zone, unsigned int order);
+#endif /* CONFIG_DEFERRED_STRUCT_PAGE_INIT */
+
 enum mminit_level {
 	MMINIT_WARNING,
 	MMINIT_VERIFY,
diff --git a/mm/mm_init.c b/mm/mm_init.c
index c1883362e71d..68d0187c7886 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -14,7 +14,14 @@
 #include <linux/notifier.h>
 #include <linux/sched.h>
 #include <linux/mman.h>
+#include <linux/memblock.h>
+#include <linux/page-isolation.h>
+#include <linux/padata.h>
+#include <linux/nmi.h>
+#include <linux/buffer_head.h>
+#include <linux/kmemleak.h>
 #include "internal.h"
+#include "shuffle.h"
 
 #ifdef CONFIG_DEBUG_MEMORY_INIT
 int __meminitdata mminit_loglevel;
@@ -198,3 +205,2300 @@ static int __init mm_sysfs_init(void)
 	return 0;
 }
 postcore_initcall(mm_sysfs_init);
+
+static unsigned long arch_zone_lowest_possible_pfn[MAX_NR_ZONES] __initdata;
+static unsigned long arch_zone_highest_possible_pfn[MAX_NR_ZONES] __initdata;
+static unsigned long zone_movable_pfn[MAX_NUMNODES] __initdata;
+
+static unsigned long required_kernelcore __initdata;
+static unsigned long required_kernelcore_percent __initdata;
+static unsigned long required_movablecore __initdata;
+static unsigned long required_movablecore_percent __initdata;
+
+static unsigned long nr_kernel_pages __initdata;
+static unsigned long nr_all_pages __initdata;
+static unsigned long dma_reserve __initdata;
+
+bool deferred_struct_pages __meminitdata;
+
+static DEFINE_PER_CPU(struct per_cpu_nodestat, boot_nodestats);
+
+static int __init cmdline_parse_core(char *p, unsigned long *core,
+				     unsigned long *percent)
+{
+	unsigned long long coremem;
+	char *endptr;
+
+	if (!p)
+		return -EINVAL;
+
+	/* Value may be a percentage of total memory, otherwise bytes */
+	coremem = simple_strtoull(p, &endptr, 0);
+	if (*endptr == '%') {
+		/* Paranoid check for percent values greater than 100 */
+		WARN_ON(coremem > 100);
+
+		*percent = coremem;
+	} else {
+		coremem = memparse(p, &p);
+		/* Paranoid check that UL is enough for the coremem value */
+		WARN_ON((coremem >> PAGE_SHIFT) > ULONG_MAX);
+
+		*core = coremem >> PAGE_SHIFT;
+		*percent = 0UL;
+	}
+	return 0;
+}
+
+/*
+ * kernelcore=size sets the amount of memory for use for allocations that
+ * cannot be reclaimed or migrated.
+ */
+static int __init cmdline_parse_kernelcore(char *p)
+{
+	/* parse kernelcore=mirror */
+	if (parse_option_str(p, "mirror")) {
+		mirrored_kernelcore = true;
+		return 0;
+	}
+
+	return cmdline_parse_core(p, &required_kernelcore,
+				  &required_kernelcore_percent);
+}
+early_param("kernelcore", cmdline_parse_kernelcore);
+
+/*
+ * movablecore=size sets the amount of memory for use for allocations that
+ * can be reclaimed or migrated.
+ */
+static int __init cmdline_parse_movablecore(char *p)
+{
+	return cmdline_parse_core(p, &required_movablecore,
+				  &required_movablecore_percent);
+}
+early_param("movablecore", cmdline_parse_movablecore);
+
+/*
+ * early_calculate_totalpages()
+ * Sum pages in active regions for movable zone.
+ * Populate N_MEMORY for calculating usable_nodes.
+ */
+static unsigned long __init early_calculate_totalpages(void)
+{
+	unsigned long totalpages = 0;
+	unsigned long start_pfn, end_pfn;
+	int i, nid;
+
+	for_each_mem_pfn_range(i, MAX_NUMNODES, &start_pfn, &end_pfn, &nid) {
+		unsigned long pages = end_pfn - start_pfn;
+
+		totalpages += pages;
+		if (pages)
+			node_set_state(nid, N_MEMORY);
+	}
+	return totalpages;
+}
+
+/*
+ * This finds a zone that can be used for ZONE_MOVABLE pages. The
+ * assumption is made that zones within a node are ordered in monotonic
+ * increasing memory addresses so that the "highest" populated zone is used
+ */
+static void __init find_usable_zone_for_movable(void)
+{
+	int zone_index;
+	for (zone_index = MAX_NR_ZONES - 1; zone_index >= 0; zone_index--) {
+		if (zone_index == ZONE_MOVABLE)
+			continue;
+
+		if (arch_zone_highest_possible_pfn[zone_index] >
+				arch_zone_lowest_possible_pfn[zone_index])
+			break;
+	}
+
+	VM_BUG_ON(zone_index == -1);
+	movable_zone = zone_index;
+}
+
+/*
+ * Find the PFN the Movable zone begins in each node. Kernel memory
+ * is spread evenly between nodes as long as the nodes have enough
+ * memory. When they don't, some nodes will have more kernelcore than
+ * others
+ */
+static void __init find_zone_movable_pfns_for_nodes(void)
+{
+	int i, nid;
+	unsigned long usable_startpfn;
+	unsigned long kernelcore_node, kernelcore_remaining;
+	/* save the state before borrow the nodemask */
+	nodemask_t saved_node_state = node_states[N_MEMORY];
+	unsigned long totalpages = early_calculate_totalpages();
+	int usable_nodes = nodes_weight(node_states[N_MEMORY]);
+	struct memblock_region *r;
+
+	/* Need to find movable_zone earlier when movable_node is specified. */
+	find_usable_zone_for_movable();
+
+	/*
+	 * If movable_node is specified, ignore kernelcore and movablecore
+	 * options.
+	 */
+	if (movable_node_is_enabled()) {
+		for_each_mem_region(r) {
+			if (!memblock_is_hotpluggable(r))
+				continue;
+
+			nid = memblock_get_region_node(r);
+
+			usable_startpfn = PFN_DOWN(r->base);
+			zone_movable_pfn[nid] = zone_movable_pfn[nid] ?
+				min(usable_startpfn, zone_movable_pfn[nid]) :
+				usable_startpfn;
+		}
+
+		goto out2;
+	}
+
+	/*
+	 * If kernelcore=mirror is specified, ignore movablecore option
+	 */
+	if (mirrored_kernelcore) {
+		bool mem_below_4gb_not_mirrored = false;
+
+		for_each_mem_region(r) {
+			if (memblock_is_mirror(r))
+				continue;
+
+			nid = memblock_get_region_node(r);
+
+			usable_startpfn = memblock_region_memory_base_pfn(r);
+
+			if (usable_startpfn < PHYS_PFN(SZ_4G)) {
+				mem_below_4gb_not_mirrored = true;
+				continue;
+			}
+
+			zone_movable_pfn[nid] = zone_movable_pfn[nid] ?
+				min(usable_startpfn, zone_movable_pfn[nid]) :
+				usable_startpfn;
+		}
+
+		if (mem_below_4gb_not_mirrored)
+			pr_warn("This configuration results in unmirrored kernel memory.\n");
+
+		goto out2;
+	}
+
+	/*
+	 * If kernelcore=nn% or movablecore=nn% was specified, calculate the
+	 * amount of necessary memory.
+	 */
+	if (required_kernelcore_percent)
+		required_kernelcore = (totalpages * 100 * required_kernelcore_percent) /
+				       10000UL;
+	if (required_movablecore_percent)
+		required_movablecore = (totalpages * 100 * required_movablecore_percent) /
+					10000UL;
+
+	/*
+	 * If movablecore= was specified, calculate what size of
+	 * kernelcore that corresponds so that memory usable for
+	 * any allocation type is evenly spread. If both kernelcore
+	 * and movablecore are specified, then the value of kernelcore
+	 * will be used for required_kernelcore if it's greater than
+	 * what movablecore would have allowed.
+	 */
+	if (required_movablecore) {
+		unsigned long corepages;
+
+		/*
+		 * Round-up so that ZONE_MOVABLE is at least as large as what
+		 * was requested by the user
+		 */
+		required_movablecore =
+			roundup(required_movablecore, MAX_ORDER_NR_PAGES);
+		required_movablecore = min(totalpages, required_movablecore);
+		corepages = totalpages - required_movablecore;
+
+		required_kernelcore = max(required_kernelcore, corepages);
+	}
+
+	/*
+	 * If kernelcore was not specified or kernelcore size is larger
+	 * than totalpages, there is no ZONE_MOVABLE.
+	 */
+	if (!required_kernelcore || required_kernelcore >= totalpages)
+		goto out;
+
+	/* usable_startpfn is the lowest possible pfn ZONE_MOVABLE can be at */
+	usable_startpfn = arch_zone_lowest_possible_pfn[movable_zone];
+
+restart:
+	/* Spread kernelcore memory as evenly as possible throughout nodes */
+	kernelcore_node = required_kernelcore / usable_nodes;
+	for_each_node_state(nid, N_MEMORY) {
+		unsigned long start_pfn, end_pfn;
+
+		/*
+		 * Recalculate kernelcore_node if the division per node
+		 * now exceeds what is necessary to satisfy the requested
+		 * amount of memory for the kernel
+		 */
+		if (required_kernelcore < kernelcore_node)
+			kernelcore_node = required_kernelcore / usable_nodes;
+
+		/*
+		 * As the map is walked, we track how much memory is usable
+		 * by the kernel using kernelcore_remaining. When it is
+		 * 0, the rest of the node is usable by ZONE_MOVABLE
+		 */
+		kernelcore_remaining = kernelcore_node;
+
+		/* Go through each range of PFNs within this node */
+		for_each_mem_pfn_range(i, nid, &start_pfn, &end_pfn, NULL) {
+			unsigned long size_pages;
+
+			start_pfn = max(start_pfn, zone_movable_pfn[nid]);
+			if (start_pfn >= end_pfn)
+				continue;
+
+			/* Account for what is only usable for kernelcore */
+			if (start_pfn < usable_startpfn) {
+				unsigned long kernel_pages;
+				kernel_pages = min(end_pfn, usable_startpfn)
+								- start_pfn;
+
+				kernelcore_remaining -= min(kernel_pages,
+							kernelcore_remaining);
+				required_kernelcore -= min(kernel_pages,
+							required_kernelcore);
+
+				/* Continue if range is now fully accounted */
+				if (end_pfn <= usable_startpfn) {
+
+					/*
+					 * Push zone_movable_pfn to the end so
+					 * that if we have to rebalance
+					 * kernelcore across nodes, we will
+					 * not double account here
+					 */
+					zone_movable_pfn[nid] = end_pfn;
+					continue;
+				}
+				start_pfn = usable_startpfn;
+			}
+
+			/*
+			 * The usable PFN range for ZONE_MOVABLE is from
+			 * start_pfn->end_pfn. Calculate size_pages as the
+			 * number of pages used as kernelcore
+			 */
+			size_pages = end_pfn - start_pfn;
+			if (size_pages > kernelcore_remaining)
+				size_pages = kernelcore_remaining;
+			zone_movable_pfn[nid] = start_pfn + size_pages;
+
+			/*
+			 * Some kernelcore has been met, update counts and
+			 * break if the kernelcore for this node has been
+			 * satisfied
+			 */
+			required_kernelcore -= min(required_kernelcore,
+								size_pages);
+			kernelcore_remaining -= size_pages;
+			if (!kernelcore_remaining)
+				break;
+		}
+	}
+
+	/*
+	 * If there is still required_kernelcore, we do another pass with one
+	 * less node in the count. This will push zone_movable_pfn[nid] further
+	 * along on the nodes that still have memory until kernelcore is
+	 * satisfied
+	 */
+	usable_nodes--;
+	if (usable_nodes && required_kernelcore > usable_nodes)
+		goto restart;
+
+out2:
+	/* Align start of ZONE_MOVABLE on all nids to MAX_ORDER_NR_PAGES */
+	for (nid = 0; nid < MAX_NUMNODES; nid++) {
+		unsigned long start_pfn, end_pfn;
+
+		zone_movable_pfn[nid] =
+			roundup(zone_movable_pfn[nid], MAX_ORDER_NR_PAGES);
+
+		get_pfn_range_for_nid(nid, &start_pfn, &end_pfn);
+		if (zone_movable_pfn[nid] >= end_pfn)
+			zone_movable_pfn[nid] = 0;
+	}
+
+out:
+	/* restore the node_state */
+	node_states[N_MEMORY] = saved_node_state;
+}
+
+static void __meminit __init_single_page(struct page *page, unsigned long pfn,
+				unsigned long zone, int nid)
+{
+	mm_zero_struct_page(page);
+	set_page_links(page, zone, nid, pfn);
+	init_page_count(page);
+	page_mapcount_reset(page);
+	page_cpupid_reset_last(page);
+	page_kasan_tag_reset(page);
+
+	INIT_LIST_HEAD(&page->lru);
+#ifdef WANT_PAGE_VIRTUAL
+	/* The shift won't overflow because ZONE_NORMAL is below 4G. */
+	if (!is_highmem_idx(zone))
+		set_page_address(page, __va(pfn << PAGE_SHIFT));
+#endif
+}
+
+#ifdef CONFIG_NUMA
+/*
+ * During memory init memblocks map pfns to nids. The search is expensive and
+ * this caches recent lookups. The implementation of __early_pfn_to_nid
+ * treats start/end as pfns.
+ */
+struct mminit_pfnnid_cache {
+	unsigned long last_start;
+	unsigned long last_end;
+	int last_nid;
+};
+
+static struct mminit_pfnnid_cache early_pfnnid_cache __meminitdata;
+
+/*
+ * Required by SPARSEMEM. Given a PFN, return what node the PFN is on.
+ */
+static int __meminit __early_pfn_to_nid(unsigned long pfn,
+					struct mminit_pfnnid_cache *state)
+{
+	unsigned long start_pfn, end_pfn;
+	int nid;
+
+	if (state->last_start <= pfn && pfn < state->last_end)
+		return state->last_nid;
+
+	nid = memblock_search_pfn_nid(pfn, &start_pfn, &end_pfn);
+	if (nid != NUMA_NO_NODE) {
+		state->last_start = start_pfn;
+		state->last_end = end_pfn;
+		state->last_nid = nid;
+	}
+
+	return nid;
+}
+
+int __meminit early_pfn_to_nid(unsigned long pfn)
+{
+	static DEFINE_SPINLOCK(early_pfn_lock);
+	int nid;
+
+	spin_lock(&early_pfn_lock);
+	nid = __early_pfn_to_nid(pfn, &early_pfnnid_cache);
+	if (nid < 0)
+		nid = first_online_node;
+	spin_unlock(&early_pfn_lock);
+
+	return nid;
+}
+#endif /* CONFIG_NUMA */
+
+#ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT
+static inline void pgdat_set_deferred_range(pg_data_t *pgdat)
+{
+	pgdat->first_deferred_pfn = ULONG_MAX;
+}
+
+/* Returns true if the struct page for the pfn is initialised */
+static inline bool __meminit early_page_initialised(unsigned long pfn)
+{
+	int nid = early_pfn_to_nid(pfn);
+
+	if (node_online(nid) && pfn >= NODE_DATA(nid)->first_deferred_pfn)
+		return false;
+
+	return true;
+}
+
+/*
+ * Returns true when the remaining initialisation should be deferred until
+ * later in the boot cycle when it can be parallelised.
+ */
+static bool __meminit
+defer_init(int nid, unsigned long pfn, unsigned long end_pfn)
+{
+	static unsigned long prev_end_pfn, nr_initialised;
+
+	if (early_page_ext_enabled())
+		return false;
+	/*
+	 * prev_end_pfn static that contains the end of previous zone
+	 * No need to protect because called very early in boot before smp_init.
+	 */
+	if (prev_end_pfn != end_pfn) {
+		prev_end_pfn = end_pfn;
+		nr_initialised = 0;
+	}
+
+	/* Always populate low zones for address-constrained allocations */
+	if (end_pfn < pgdat_end_pfn(NODE_DATA(nid)))
+		return false;
+
+	if (NODE_DATA(nid)->first_deferred_pfn != ULONG_MAX)
+		return true;
+	/*
+	 * We start only with one section of pages, more pages are added as
+	 * needed until the rest of deferred pages are initialized.
+	 */
+	nr_initialised++;
+	if ((nr_initialised > PAGES_PER_SECTION) &&
+	    (pfn & (PAGES_PER_SECTION - 1)) == 0) {
+		NODE_DATA(nid)->first_deferred_pfn = pfn;
+		return true;
+	}
+	return false;
+}
+
+static void __meminit init_reserved_page(unsigned long pfn)
+{
+	pg_data_t *pgdat;
+	int nid, zid;
+
+	if (early_page_initialised(pfn))
+		return;
+
+	nid = early_pfn_to_nid(pfn);
+	pgdat = NODE_DATA(nid);
+
+	for (zid = 0; zid < MAX_NR_ZONES; zid++) {
+		struct zone *zone = &pgdat->node_zones[zid];
+
+		if (zone_spans_pfn(zone, pfn))
+			break;
+	}
+	__init_single_page(pfn_to_page(pfn), pfn, zid, nid);
+}
+#else
+static inline void pgdat_set_deferred_range(pg_data_t *pgdat) {}
+
+static inline bool early_page_initialised(unsigned long pfn)
+{
+	return true;
+}
+
+static inline bool defer_init(int nid, unsigned long pfn, unsigned long end_pfn)
+{
+	return false;
+}
+
+static inline void init_reserved_page(unsigned long pfn)
+{
+}
+#endif /* CONFIG_DEFERRED_STRUCT_PAGE_INIT */
+
+/*
+ * Initialised pages do not have PageReserved set. This function is
+ * called for each range allocated by the bootmem allocator and
+ * marks the pages PageReserved. The remaining valid pages are later
+ * sent to the buddy page allocator.
+ */
+void __meminit reserve_bootmem_region(phys_addr_t start, phys_addr_t end)
+{
+	unsigned long start_pfn = PFN_DOWN(start);
+	unsigned long end_pfn = PFN_UP(end);
+
+	for (; start_pfn < end_pfn; start_pfn++) {
+		if (pfn_valid(start_pfn)) {
+			struct page *page = pfn_to_page(start_pfn);
+
+			init_reserved_page(start_pfn);
+
+			/* Avoid false-positive PageTail() */
+			INIT_LIST_HEAD(&page->lru);
+
+			/*
+			 * no need for atomic set_bit because the struct
+			 * page is not visible yet so nobody should
+			 * access it yet.
+			 */
+			__SetPageReserved(page);
+		}
+	}
+}
+
+/* If zone is ZONE_MOVABLE but memory is mirrored, it is an overlapped init */
+static bool __meminit
+overlap_memmap_init(unsigned long zone, unsigned long *pfn)
+{
+	static struct memblock_region *r;
+
+	if (mirrored_kernelcore && zone == ZONE_MOVABLE) {
+		if (!r || *pfn >= memblock_region_memory_end_pfn(r)) {
+			for_each_mem_region(r) {
+				if (*pfn < memblock_region_memory_end_pfn(r))
+					break;
+			}
+		}
+		if (*pfn >= memblock_region_memory_base_pfn(r) &&
+		    memblock_is_mirror(r)) {
+			*pfn = memblock_region_memory_end_pfn(r);
+			return true;
+		}
+	}
+	return false;
+}
+
+/*
+ * Only struct pages that correspond to ranges defined by memblock.memory
+ * are zeroed and initialized by going through __init_single_page() during
+ * memmap_init_zone_range().
+ *
+ * But, there could be struct pages that correspond to holes in
+ * memblock.memory. This can happen because of the following reasons:
+ * - physical memory bank size is not necessarily the exact multiple of the
+ *   arbitrary section size
+ * - early reserved memory may not be listed in memblock.memory
+ * - memory layouts defined with memmap= kernel parameter may not align
+ *   nicely with memmap sections
+ *
+ * Explicitly initialize those struct pages so that:
+ * - PG_Reserved is set
+ * - zone and node links point to zone and node that span the page if the
+ *   hole is in the middle of a zone
+ * - zone and node links point to adjacent zone/node if the hole falls on
+ *   the zone boundary; the pages in such holes will be prepended to the
+ *   zone/node above the hole except for the trailing pages in the last
+ *   section that will be appended to the zone/node below.
+ */
+static void __init init_unavailable_range(unsigned long spfn,
+					  unsigned long epfn,
+					  int zone, int node)
+{
+	unsigned long pfn;
+	u64 pgcnt = 0;
+
+	for (pfn = spfn; pfn < epfn; pfn++) {
+		if (!pfn_valid(pageblock_start_pfn(pfn))) {
+			pfn = pageblock_end_pfn(pfn) - 1;
+			continue;
+		}
+		__init_single_page(pfn_to_page(pfn), pfn, zone, node);
+		__SetPageReserved(pfn_to_page(pfn));
+		pgcnt++;
+	}
+
+	if (pgcnt)
+		pr_info("On node %d, zone %s: %lld pages in unavailable ranges",
+			node, zone_names[zone], pgcnt);
+}
+
+/*
+ * Initially all pages are reserved - free ones are freed
+ * up by memblock_free_all() once the early boot process is
+ * done. Non-atomic initialization, single-pass.
+ *
+ * All aligned pageblocks are initialized to the specified migratetype
+ * (usually MIGRATE_MOVABLE). Besides setting the migratetype, no related
+ * zone stats (e.g., nr_isolate_pageblock) are touched.
+ */
+void __meminit memmap_init_range(unsigned long size, int nid, unsigned long zone,
+		unsigned long start_pfn, unsigned long zone_end_pfn,
+		enum meminit_context context,
+		struct vmem_altmap *altmap, int migratetype)
+{
+	unsigned long pfn, end_pfn = start_pfn + size;
+	struct page *page;
+
+	if (highest_memmap_pfn < end_pfn - 1)
+		highest_memmap_pfn = end_pfn - 1;
+
+#ifdef CONFIG_ZONE_DEVICE
+	/*
+	 * Honor reservation requested by the driver for this ZONE_DEVICE
+	 * memory. We limit the total number of pages to initialize to just
+	 * those that might contain the memory mapping. We will defer the
+	 * ZONE_DEVICE page initialization until after we have released
+	 * the hotplug lock.
+	 */
+	if (zone == ZONE_DEVICE) {
+		if (!altmap)
+			return;
+
+		if (start_pfn == altmap->base_pfn)
+			start_pfn += altmap->reserve;
+		end_pfn = altmap->base_pfn + vmem_altmap_offset(altmap);
+	}
+#endif
+
+	for (pfn = start_pfn; pfn < end_pfn; ) {
+		/*
+		 * There can be holes in boot-time mem_map[]s handed to this
+		 * function.  They do not exist on hotplugged memory.
+		 */
+		if (context == MEMINIT_EARLY) {
+			if (overlap_memmap_init(zone, &pfn))
+				continue;
+			if (defer_init(nid, pfn, zone_end_pfn)) {
+				deferred_struct_pages = true;
+				break;
+			}
+		}
+
+		page = pfn_to_page(pfn);
+		__init_single_page(page, pfn, zone, nid);
+		if (context == MEMINIT_HOTPLUG)
+			__SetPageReserved(page);
+
+		/*
+		 * Usually, we want to mark the pageblock MIGRATE_MOVABLE,
+		 * such that unmovable allocations won't be scattered all
+		 * over the place during system boot.
+		 */
+		if (pageblock_aligned(pfn)) {
+			set_pageblock_migratetype(page, migratetype);
+			cond_resched();
+		}
+		pfn++;
+	}
+}
+
+static void __init memmap_init_zone_range(struct zone *zone,
+					  unsigned long start_pfn,
+					  unsigned long end_pfn,
+					  unsigned long *hole_pfn)
+{
+	unsigned long zone_start_pfn = zone->zone_start_pfn;
+	unsigned long zone_end_pfn = zone_start_pfn + zone->spanned_pages;
+	int nid = zone_to_nid(zone), zone_id = zone_idx(zone);
+
+	start_pfn = clamp(start_pfn, zone_start_pfn, zone_end_pfn);
+	end_pfn = clamp(end_pfn, zone_start_pfn, zone_end_pfn);
+
+	if (start_pfn >= end_pfn)
+		return;
+
+	memmap_init_range(end_pfn - start_pfn, nid, zone_id, start_pfn,
+			  zone_end_pfn, MEMINIT_EARLY, NULL, MIGRATE_MOVABLE);
+
+	if (*hole_pfn < start_pfn)
+		init_unavailable_range(*hole_pfn, start_pfn, zone_id, nid);
+
+	*hole_pfn = end_pfn;
+}
+
+static void __init memmap_init(void)
+{
+	unsigned long start_pfn, end_pfn;
+	unsigned long hole_pfn = 0;
+	int i, j, zone_id = 0, nid;
+
+	for_each_mem_pfn_range(i, MAX_NUMNODES, &start_pfn, &end_pfn, &nid) {
+		struct pglist_data *node = NODE_DATA(nid);
+
+		for (j = 0; j < MAX_NR_ZONES; j++) {
+			struct zone *zone = node->node_zones + j;
+
+			if (!populated_zone(zone))
+				continue;
+
+			memmap_init_zone_range(zone, start_pfn, end_pfn,
+					       &hole_pfn);
+			zone_id = j;
+		}
+	}
+
+#ifdef CONFIG_SPARSEMEM
+	/*
+	 * Initialize the memory map for hole in the range [memory_end,
+	 * section_end].
+	 * Append the pages in this hole to the highest zone in the last
+	 * node.
+	 * The call to init_unavailable_range() is outside the ifdef to
+	 * silence the compiler warining about zone_id set but not used;
+	 * for FLATMEM it is a nop anyway
+	 */
+	end_pfn = round_up(end_pfn, PAGES_PER_SECTION);
+	if (hole_pfn < end_pfn)
+#endif
+		init_unavailable_range(hole_pfn, end_pfn, zone_id, nid);
+}
+
+#ifdef CONFIG_ZONE_DEVICE
+static void __ref __init_zone_device_page(struct page *page, unsigned long pfn,
+					  unsigned long zone_idx, int nid,
+					  struct dev_pagemap *pgmap)
+{
+
+	__init_single_page(page, pfn, zone_idx, nid);
+
+	/*
+	 * Mark page reserved as it will need to wait for onlining
+	 * phase for it to be fully associated with a zone.
+	 *
+	 * We can use the non-atomic __set_bit operation for setting
+	 * the flag as we are still initializing the pages.
+	 */
+	__SetPageReserved(page);
+
+	/*
+	 * ZONE_DEVICE pages union ->lru with a ->pgmap back pointer
+	 * and zone_device_data.  It is a bug if a ZONE_DEVICE page is
+	 * ever freed or placed on a driver-private list.
+	 */
+	page->pgmap = pgmap;
+	page->zone_device_data = NULL;
+
+	/*
+	 * Mark the block movable so that blocks are reserved for
+	 * movable at startup. This will force kernel allocations
+	 * to reserve their blocks rather than leaking throughout
+	 * the address space during boot when many long-lived
+	 * kernel allocations are made.
+	 *
+	 * Please note that MEMINIT_HOTPLUG path doesn't clear memmap
+	 * because this is done early in section_activate()
+	 */
+	if (pageblock_aligned(pfn)) {
+		set_pageblock_migratetype(page, MIGRATE_MOVABLE);
+		cond_resched();
+	}
+
+	/*
+	 * ZONE_DEVICE pages are released directly to the driver page allocator
+	 * which will set the page count to 1 when allocating the page.
+	 */
+	if (pgmap->type == MEMORY_DEVICE_PRIVATE ||
+	    pgmap->type == MEMORY_DEVICE_COHERENT)
+		set_page_count(page, 0);
+}
+
+/*
+ * With compound page geometry and when struct pages are stored in ram most
+ * tail pages are reused. Consequently, the amount of unique struct pages to
+ * initialize is a lot smaller that the total amount of struct pages being
+ * mapped. This is a paired / mild layering violation with explicit knowledge
+ * of how the sparse_vmemmap internals handle compound pages in the lack
+ * of an altmap. See vmemmap_populate_compound_pages().
+ */
+static inline unsigned long compound_nr_pages(struct vmem_altmap *altmap,
+					      unsigned long nr_pages)
+{
+	return is_power_of_2(sizeof(struct page)) &&
+		!altmap ? 2 * (PAGE_SIZE / sizeof(struct page)) : nr_pages;
+}
+
+static void __ref memmap_init_compound(struct page *head,
+				       unsigned long head_pfn,
+				       unsigned long zone_idx, int nid,
+				       struct dev_pagemap *pgmap,
+				       unsigned long nr_pages)
+{
+	unsigned long pfn, end_pfn = head_pfn + nr_pages;
+	unsigned int order = pgmap->vmemmap_shift;
+
+	__SetPageHead(head);
+	for (pfn = head_pfn + 1; pfn < end_pfn; pfn++) {
+		struct page *page = pfn_to_page(pfn);
+
+		__init_zone_device_page(page, pfn, zone_idx, nid, pgmap);
+		prep_compound_tail(head, pfn - head_pfn);
+		set_page_count(page, 0);
+
+		/*
+		 * The first tail page stores important compound page info.
+		 * Call prep_compound_head() after the first tail page has
+		 * been initialized, to not have the data overwritten.
+		 */
+		if (pfn == head_pfn + 1)
+			prep_compound_head(head, order);
+	}
+}
+
+void __ref memmap_init_zone_device(struct zone *zone,
+				   unsigned long start_pfn,
+				   unsigned long nr_pages,
+				   struct dev_pagemap *pgmap)
+{
+	unsigned long pfn, end_pfn = start_pfn + nr_pages;
+	struct pglist_data *pgdat = zone->zone_pgdat;
+	struct vmem_altmap *altmap = pgmap_altmap(pgmap);
+	unsigned int pfns_per_compound = pgmap_vmemmap_nr(pgmap);
+	unsigned long zone_idx = zone_idx(zone);
+	unsigned long start = jiffies;
+	int nid = pgdat->node_id;
+
+	if (WARN_ON_ONCE(!pgmap || zone_idx != ZONE_DEVICE))
+		return;
+
+	/*
+	 * The call to memmap_init should have already taken care
+	 * of the pages reserved for the memmap, so we can just jump to
+	 * the end of that region and start processing the device pages.
+	 */
+	if (altmap) {
+		start_pfn = altmap->base_pfn + vmem_altmap_offset(altmap);
+		nr_pages = end_pfn - start_pfn;
+	}
+
+	for (pfn = start_pfn; pfn < end_pfn; pfn += pfns_per_compound) {
+		struct page *page = pfn_to_page(pfn);
+
+		__init_zone_device_page(page, pfn, zone_idx, nid, pgmap);
+
+		if (pfns_per_compound == 1)
+			continue;
+
+		memmap_init_compound(page, pfn, zone_idx, nid, pgmap,
+				     compound_nr_pages(altmap, pfns_per_compound));
+	}
+
+	pr_info("%s initialised %lu pages in %ums\n", __func__,
+		nr_pages, jiffies_to_msecs(jiffies - start));
+}
+#endif
+
+/*
+ * The zone ranges provided by the architecture do not include ZONE_MOVABLE
+ * because it is sized independent of architecture. Unlike the other zones,
+ * the starting point for ZONE_MOVABLE is not fixed. It may be different
+ * in each node depending on the size of each node and how evenly kernelcore
+ * is distributed. This helper function adjusts the zone ranges
+ * provided by the architecture for a given node by using the end of the
+ * highest usable zone for ZONE_MOVABLE. This preserves the assumption that
+ * zones within a node are in order of monotonic increases memory addresses
+ */
+static void __init adjust_zone_range_for_zone_movable(int nid,
+					unsigned long zone_type,
+					unsigned long node_start_pfn,
+					unsigned long node_end_pfn,
+					unsigned long *zone_start_pfn,
+					unsigned long *zone_end_pfn)
+{
+	/* Only adjust if ZONE_MOVABLE is on this node */
+	if (zone_movable_pfn[nid]) {
+		/* Size ZONE_MOVABLE */
+		if (zone_type == ZONE_MOVABLE) {
+			*zone_start_pfn = zone_movable_pfn[nid];
+			*zone_end_pfn = min(node_end_pfn,
+				arch_zone_highest_possible_pfn[movable_zone]);
+
+		/* Adjust for ZONE_MOVABLE starting within this range */
+		} else if (!mirrored_kernelcore &&
+			*zone_start_pfn < zone_movable_pfn[nid] &&
+			*zone_end_pfn > zone_movable_pfn[nid]) {
+			*zone_end_pfn = zone_movable_pfn[nid];
+
+		/* Check if this whole range is within ZONE_MOVABLE */
+		} else if (*zone_start_pfn >= zone_movable_pfn[nid])
+			*zone_start_pfn = *zone_end_pfn;
+	}
+}
+
+/*
+ * Return the number of holes in a range on a node. If nid is MAX_NUMNODES,
+ * then all holes in the requested range will be accounted for.
+ */
+unsigned long __init __absent_pages_in_range(int nid,
+				unsigned long range_start_pfn,
+				unsigned long range_end_pfn)
+{
+	unsigned long nr_absent = range_end_pfn - range_start_pfn;
+	unsigned long start_pfn, end_pfn;
+	int i;
+
+	for_each_mem_pfn_range(i, nid, &start_pfn, &end_pfn, NULL) {
+		start_pfn = clamp(start_pfn, range_start_pfn, range_end_pfn);
+		end_pfn = clamp(end_pfn, range_start_pfn, range_end_pfn);
+		nr_absent -= end_pfn - start_pfn;
+	}
+	return nr_absent;
+}
+
+/**
+ * absent_pages_in_range - Return number of page frames in holes within a range
+ * @start_pfn: The start PFN to start searching for holes
+ * @end_pfn: The end PFN to stop searching for holes
+ *
+ * Return: the number of pages frames in memory holes within a range.
+ */
+unsigned long __init absent_pages_in_range(unsigned long start_pfn,
+							unsigned long end_pfn)
+{
+	return __absent_pages_in_range(MAX_NUMNODES, start_pfn, end_pfn);
+}
+
+/* Return the number of page frames in holes in a zone on a node */
+static unsigned long __init zone_absent_pages_in_node(int nid,
+					unsigned long zone_type,
+					unsigned long node_start_pfn,
+					unsigned long node_end_pfn)
+{
+	unsigned long zone_low = arch_zone_lowest_possible_pfn[zone_type];
+	unsigned long zone_high = arch_zone_highest_possible_pfn[zone_type];
+	unsigned long zone_start_pfn, zone_end_pfn;
+	unsigned long nr_absent;
+
+	/* When hotadd a new node from cpu_up(), the node should be empty */
+	if (!node_start_pfn && !node_end_pfn)
+		return 0;
+
+	zone_start_pfn = clamp(node_start_pfn, zone_low, zone_high);
+	zone_end_pfn = clamp(node_end_pfn, zone_low, zone_high);
+
+	adjust_zone_range_for_zone_movable(nid, zone_type,
+			node_start_pfn, node_end_pfn,
+			&zone_start_pfn, &zone_end_pfn);
+	nr_absent = __absent_pages_in_range(nid, zone_start_pfn, zone_end_pfn);
+
+	/*
+	 * ZONE_MOVABLE handling.
+	 * Treat pages to be ZONE_MOVABLE in ZONE_NORMAL as absent pages
+	 * and vice versa.
+	 */
+	if (mirrored_kernelcore && zone_movable_pfn[nid]) {
+		unsigned long start_pfn, end_pfn;
+		struct memblock_region *r;
+
+		for_each_mem_region(r) {
+			start_pfn = clamp(memblock_region_memory_base_pfn(r),
+					  zone_start_pfn, zone_end_pfn);
+			end_pfn = clamp(memblock_region_memory_end_pfn(r),
+					zone_start_pfn, zone_end_pfn);
+
+			if (zone_type == ZONE_MOVABLE &&
+			    memblock_is_mirror(r))
+				nr_absent += end_pfn - start_pfn;
+
+			if (zone_type == ZONE_NORMAL &&
+			    !memblock_is_mirror(r))
+				nr_absent += end_pfn - start_pfn;
+		}
+	}
+
+	return nr_absent;
+}
+
+/*
+ * Return the number of pages a zone spans in a node, including holes
+ * present_pages = zone_spanned_pages_in_node() - zone_absent_pages_in_node()
+ */
+static unsigned long __init zone_spanned_pages_in_node(int nid,
+					unsigned long zone_type,
+					unsigned long node_start_pfn,
+					unsigned long node_end_pfn,
+					unsigned long *zone_start_pfn,
+					unsigned long *zone_end_pfn)
+{
+	unsigned long zone_low = arch_zone_lowest_possible_pfn[zone_type];
+	unsigned long zone_high = arch_zone_highest_possible_pfn[zone_type];
+	/* When hotadd a new node from cpu_up(), the node should be empty */
+	if (!node_start_pfn && !node_end_pfn)
+		return 0;
+
+	/* Get the start and end of the zone */
+	*zone_start_pfn = clamp(node_start_pfn, zone_low, zone_high);
+	*zone_end_pfn = clamp(node_end_pfn, zone_low, zone_high);
+	adjust_zone_range_for_zone_movable(nid, zone_type,
+				node_start_pfn, node_end_pfn,
+				zone_start_pfn, zone_end_pfn);
+
+	/* Check that this node has pages within the zone's required range */
+	if (*zone_end_pfn < node_start_pfn || *zone_start_pfn > node_end_pfn)
+		return 0;
+
+	/* Move the zone boundaries inside the node if necessary */
+	*zone_end_pfn = min(*zone_end_pfn, node_end_pfn);
+	*zone_start_pfn = max(*zone_start_pfn, node_start_pfn);
+
+	/* Return the spanned pages */
+	return *zone_end_pfn - *zone_start_pfn;
+}
+
+static void __init calculate_node_totalpages(struct pglist_data *pgdat,
+						unsigned long node_start_pfn,
+						unsigned long node_end_pfn)
+{
+	unsigned long realtotalpages = 0, totalpages = 0;
+	enum zone_type i;
+
+	for (i = 0; i < MAX_NR_ZONES; i++) {
+		struct zone *zone = pgdat->node_zones + i;
+		unsigned long zone_start_pfn, zone_end_pfn;
+		unsigned long spanned, absent;
+		unsigned long size, real_size;
+
+		spanned = zone_spanned_pages_in_node(pgdat->node_id, i,
+						     node_start_pfn,
+						     node_end_pfn,
+						     &zone_start_pfn,
+						     &zone_end_pfn);
+		absent = zone_absent_pages_in_node(pgdat->node_id, i,
+						   node_start_pfn,
+						   node_end_pfn);
+
+		size = spanned;
+		real_size = size - absent;
+
+		if (size)
+			zone->zone_start_pfn = zone_start_pfn;
+		else
+			zone->zone_start_pfn = 0;
+		zone->spanned_pages = size;
+		zone->present_pages = real_size;
+#if defined(CONFIG_MEMORY_HOTPLUG)
+		zone->present_early_pages = real_size;
+#endif
+
+		totalpages += size;
+		realtotalpages += real_size;
+	}
+
+	pgdat->node_spanned_pages = totalpages;
+	pgdat->node_present_pages = realtotalpages;
+	pr_debug("On node %d totalpages: %lu\n", pgdat->node_id, realtotalpages);
+}
+
+static unsigned long __init calc_memmap_size(unsigned long spanned_pages,
+						unsigned long present_pages)
+{
+	unsigned long pages = spanned_pages;
+
+	/*
+	 * Provide a more accurate estimation if there are holes within
+	 * the zone and SPARSEMEM is in use. If there are holes within the
+	 * zone, each populated memory region may cost us one or two extra
+	 * memmap pages due to alignment because memmap pages for each
+	 * populated regions may not be naturally aligned on page boundary.
+	 * So the (present_pages >> 4) heuristic is a tradeoff for that.
+	 */
+	if (spanned_pages > present_pages + (present_pages >> 4) &&
+	    IS_ENABLED(CONFIG_SPARSEMEM))
+		pages = present_pages;
+
+	return PAGE_ALIGN(pages * sizeof(struct page)) >> PAGE_SHIFT;
+}
+
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+static void pgdat_init_split_queue(struct pglist_data *pgdat)
+{
+	struct deferred_split *ds_queue = &pgdat->deferred_split_queue;
+
+	spin_lock_init(&ds_queue->split_queue_lock);
+	INIT_LIST_HEAD(&ds_queue->split_queue);
+	ds_queue->split_queue_len = 0;
+}
+#else
+static void pgdat_init_split_queue(struct pglist_data *pgdat) {}
+#endif
+
+#ifdef CONFIG_COMPACTION
+static void pgdat_init_kcompactd(struct pglist_data *pgdat)
+{
+	init_waitqueue_head(&pgdat->kcompactd_wait);
+}
+#else
+static void pgdat_init_kcompactd(struct pglist_data *pgdat) {}
+#endif
+
+static void __meminit pgdat_init_internals(struct pglist_data *pgdat)
+{
+	int i;
+
+	pgdat_resize_init(pgdat);
+	pgdat_kswapd_lock_init(pgdat);
+
+	pgdat_init_split_queue(pgdat);
+	pgdat_init_kcompactd(pgdat);
+
+	init_waitqueue_head(&pgdat->kswapd_wait);
+	init_waitqueue_head(&pgdat->pfmemalloc_wait);
+
+	for (i = 0; i < NR_VMSCAN_THROTTLE; i++)
+		init_waitqueue_head(&pgdat->reclaim_wait[i]);
+
+	pgdat_page_ext_init(pgdat);
+	lruvec_init(&pgdat->__lruvec);
+}
+
+static void __meminit zone_init_internals(struct zone *zone, enum zone_type idx, int nid,
+							unsigned long remaining_pages)
+{
+	atomic_long_set(&zone->managed_pages, remaining_pages);
+	zone_set_nid(zone, nid);
+	zone->name = zone_names[idx];
+	zone->zone_pgdat = NODE_DATA(nid);
+	spin_lock_init(&zone->lock);
+	zone_seqlock_init(zone);
+	zone_pcp_init(zone);
+}
+
+static void __meminit zone_init_free_lists(struct zone *zone)
+{
+	unsigned int order, t;
+	for_each_migratetype_order(order, t) {
+		INIT_LIST_HEAD(&zone->free_area[order].free_list[t]);
+		zone->free_area[order].nr_free = 0;
+	}
+}
+
+void __meminit init_currently_empty_zone(struct zone *zone,
+					unsigned long zone_start_pfn,
+					unsigned long size)
+{
+	struct pglist_data *pgdat = zone->zone_pgdat;
+	int zone_idx = zone_idx(zone) + 1;
+
+	if (zone_idx > pgdat->nr_zones)
+		pgdat->nr_zones = zone_idx;
+
+	zone->zone_start_pfn = zone_start_pfn;
+
+	mminit_dprintk(MMINIT_TRACE, "memmap_init",
+			"Initialising map node %d zone %lu pfns %lu -> %lu\n",
+			pgdat->node_id,
+			(unsigned long)zone_idx(zone),
+			zone_start_pfn, (zone_start_pfn + size));
+
+	zone_init_free_lists(zone);
+	zone->initialized = 1;
+}
+
+#ifndef CONFIG_SPARSEMEM
+/*
+ * Calculate the size of the zone->blockflags rounded to an unsigned long
+ * Start by making sure zonesize is a multiple of pageblock_order by rounding
+ * up. Then use 1 NR_PAGEBLOCK_BITS worth of bits per pageblock, finally
+ * round what is now in bits to nearest long in bits, then return it in
+ * bytes.
+ */
+static unsigned long __init usemap_size(unsigned long zone_start_pfn, unsigned long zonesize)
+{
+	unsigned long usemapsize;
+
+	zonesize += zone_start_pfn & (pageblock_nr_pages-1);
+	usemapsize = roundup(zonesize, pageblock_nr_pages);
+	usemapsize = usemapsize >> pageblock_order;
+	usemapsize *= NR_PAGEBLOCK_BITS;
+	usemapsize = roundup(usemapsize, 8 * sizeof(unsigned long));
+
+	return usemapsize / 8;
+}
+
+static void __ref setup_usemap(struct zone *zone)
+{
+	unsigned long usemapsize = usemap_size(zone->zone_start_pfn,
+					       zone->spanned_pages);
+	zone->pageblock_flags = NULL;
+	if (usemapsize) {
+		zone->pageblock_flags =
+			memblock_alloc_node(usemapsize, SMP_CACHE_BYTES,
+					    zone_to_nid(zone));
+		if (!zone->pageblock_flags)
+			panic("Failed to allocate %ld bytes for zone %s pageblock flags on node %d\n",
+			      usemapsize, zone->name, zone_to_nid(zone));
+	}
+}
+#else
+static inline void setup_usemap(struct zone *zone) {}
+#endif /* CONFIG_SPARSEMEM */
+
+#ifdef CONFIG_HUGETLB_PAGE_SIZE_VARIABLE
+
+/* Initialise the number of pages represented by NR_PAGEBLOCK_BITS */
+void __init set_pageblock_order(void)
+{
+	unsigned int order = MAX_ORDER;
+
+	/* Check that pageblock_nr_pages has not already been setup */
+	if (pageblock_order)
+		return;
+
+	/* Don't let pageblocks exceed the maximum allocation granularity. */
+	if (HPAGE_SHIFT > PAGE_SHIFT && HUGETLB_PAGE_ORDER < order)
+		order = HUGETLB_PAGE_ORDER;
+
+	/*
+	 * Assume the largest contiguous order of interest is a huge page.
+	 * This value may be variable depending on boot parameters on IA64 and
+	 * powerpc.
+	 */
+	pageblock_order = order;
+}
+#else /* CONFIG_HUGETLB_PAGE_SIZE_VARIABLE */
+
+/*
+ * When CONFIG_HUGETLB_PAGE_SIZE_VARIABLE is not set, set_pageblock_order()
+ * is unused as pageblock_order is set at compile-time. See
+ * include/linux/pageblock-flags.h for the values of pageblock_order based on
+ * the kernel config
+ */
+void __init set_pageblock_order(void)
+{
+}
+
+#endif /* CONFIG_HUGETLB_PAGE_SIZE_VARIABLE */
+
+/*
+ * Set up the zone data structures
+ * - init pgdat internals
+ * - init all zones belonging to this node
+ *
+ * NOTE: this function is only called during memory hotplug
+ */
+#ifdef CONFIG_MEMORY_HOTPLUG
+void __ref free_area_init_core_hotplug(struct pglist_data *pgdat)
+{
+	int nid = pgdat->node_id;
+	enum zone_type z;
+	int cpu;
+
+	pgdat_init_internals(pgdat);
+
+	if (pgdat->per_cpu_nodestats == &boot_nodestats)
+		pgdat->per_cpu_nodestats = alloc_percpu(struct per_cpu_nodestat);
+
+	/*
+	 * Reset the nr_zones, order and highest_zoneidx before reuse.
+	 * Note that kswapd will init kswapd_highest_zoneidx properly
+	 * when it starts in the near future.
+	 */
+	pgdat->nr_zones = 0;
+	pgdat->kswapd_order = 0;
+	pgdat->kswapd_highest_zoneidx = 0;
+	pgdat->node_start_pfn = 0;
+	for_each_online_cpu(cpu) {
+		struct per_cpu_nodestat *p;
+
+		p = per_cpu_ptr(pgdat->per_cpu_nodestats, cpu);
+		memset(p, 0, sizeof(*p));
+	}
+
+	for (z = 0; z < MAX_NR_ZONES; z++)
+		zone_init_internals(&pgdat->node_zones[z], z, nid, 0);
+}
+#endif
+
+/*
+ * Set up the zone data structures:
+ *   - mark all pages reserved
+ *   - mark all memory queues empty
+ *   - clear the memory bitmaps
+ *
+ * NOTE: pgdat should get zeroed by caller.
+ * NOTE: this function is only called during early init.
+ */
+static void __init free_area_init_core(struct pglist_data *pgdat)
+{
+	enum zone_type j;
+	int nid = pgdat->node_id;
+
+	pgdat_init_internals(pgdat);
+	pgdat->per_cpu_nodestats = &boot_nodestats;
+
+	for (j = 0; j < MAX_NR_ZONES; j++) {
+		struct zone *zone = pgdat->node_zones + j;
+		unsigned long size, freesize, memmap_pages;
+
+		size = zone->spanned_pages;
+		freesize = zone->present_pages;
+
+		/*
+		 * Adjust freesize so that it accounts for how much memory
+		 * is used by this zone for memmap. This affects the watermark
+		 * and per-cpu initialisations
+		 */
+		memmap_pages = calc_memmap_size(size, freesize);
+		if (!is_highmem_idx(j)) {
+			if (freesize >= memmap_pages) {
+				freesize -= memmap_pages;
+				if (memmap_pages)
+					pr_debug("  %s zone: %lu pages used for memmap\n",
+						 zone_names[j], memmap_pages);
+			} else
+				pr_warn("  %s zone: %lu memmap pages exceeds freesize %lu\n",
+					zone_names[j], memmap_pages, freesize);
+		}
+
+		/* Account for reserved pages */
+		if (j == 0 && freesize > dma_reserve) {
+			freesize -= dma_reserve;
+			pr_debug("  %s zone: %lu pages reserved\n", zone_names[0], dma_reserve);
+		}
+
+		if (!is_highmem_idx(j))
+			nr_kernel_pages += freesize;
+		/* Charge for highmem memmap if there are enough kernel pages */
+		else if (nr_kernel_pages > memmap_pages * 2)
+			nr_kernel_pages -= memmap_pages;
+		nr_all_pages += freesize;
+
+		/*
+		 * Set an approximate value for lowmem here, it will be adjusted
+		 * when the bootmem allocator frees pages into the buddy system.
+		 * And all highmem pages will be managed by the buddy system.
+		 */
+		zone_init_internals(zone, j, nid, freesize);
+
+		if (!size)
+			continue;
+
+		set_pageblock_order();
+		setup_usemap(zone);
+		init_currently_empty_zone(zone, zone->zone_start_pfn, size);
+	}
+}
+
+void __init *memmap_alloc(phys_addr_t size, phys_addr_t align,
+			  phys_addr_t min_addr, int nid, bool exact_nid)
+{
+	void *ptr;
+
+	if (exact_nid)
+		ptr = memblock_alloc_exact_nid_raw(size, align, min_addr,
+						   MEMBLOCK_ALLOC_ACCESSIBLE,
+						   nid);
+	else
+		ptr = memblock_alloc_try_nid_raw(size, align, min_addr,
+						 MEMBLOCK_ALLOC_ACCESSIBLE,
+						 nid);
+
+	if (ptr && size > 0)
+		page_init_poison(ptr, size);
+
+	return ptr;
+}
+
+#ifdef CONFIG_FLATMEM
+static void __init alloc_node_mem_map(struct pglist_data *pgdat)
+{
+	unsigned long __maybe_unused start = 0;
+	unsigned long __maybe_unused offset = 0;
+
+	/* Skip empty nodes */
+	if (!pgdat->node_spanned_pages)
+		return;
+
+	start = pgdat->node_start_pfn & ~(MAX_ORDER_NR_PAGES - 1);
+	offset = pgdat->node_start_pfn - start;
+	/* ia64 gets its own node_mem_map, before this, without bootmem */
+	if (!pgdat->node_mem_map) {
+		unsigned long size, end;
+		struct page *map;
+
+		/*
+		 * The zone's endpoints aren't required to be MAX_ORDER
+		 * aligned but the node_mem_map endpoints must be in order
+		 * for the buddy allocator to function correctly.
+		 */
+		end = pgdat_end_pfn(pgdat);
+		end = ALIGN(end, MAX_ORDER_NR_PAGES);
+		size =  (end - start) * sizeof(struct page);
+		map = memmap_alloc(size, SMP_CACHE_BYTES, MEMBLOCK_LOW_LIMIT,
+				   pgdat->node_id, false);
+		if (!map)
+			panic("Failed to allocate %ld bytes for node %d memory map\n",
+			      size, pgdat->node_id);
+		pgdat->node_mem_map = map + offset;
+	}
+	pr_debug("%s: node %d, pgdat %08lx, node_mem_map %08lx\n",
+				__func__, pgdat->node_id, (unsigned long)pgdat,
+				(unsigned long)pgdat->node_mem_map);
+#ifndef CONFIG_NUMA
+	/*
+	 * With no DISCONTIG, the global mem_map is just set as node 0's
+	 */
+	if (pgdat == NODE_DATA(0)) {
+		mem_map = NODE_DATA(0)->node_mem_map;
+		if (page_to_pfn(mem_map) != pgdat->node_start_pfn)
+			mem_map -= offset;
+	}
+#endif
+}
+#else
+static inline void alloc_node_mem_map(struct pglist_data *pgdat) { }
+#endif /* CONFIG_FLATMEM */
+
+/**
+ * get_pfn_range_for_nid - Return the start and end page frames for a node
+ * @nid: The nid to return the range for. If MAX_NUMNODES, the min and max PFN are returned.
+ * @start_pfn: Passed by reference. On return, it will have the node start_pfn.
+ * @end_pfn: Passed by reference. On return, it will have the node end_pfn.
+ *
+ * It returns the start and end page frame of a node based on information
+ * provided by memblock_set_node(). If called for a node
+ * with no available memory, a warning is printed and the start and end
+ * PFNs will be 0.
+ */
+void __init get_pfn_range_for_nid(unsigned int nid,
+			unsigned long *start_pfn, unsigned long *end_pfn)
+{
+	unsigned long this_start_pfn, this_end_pfn;
+	int i;
+
+	*start_pfn = -1UL;
+	*end_pfn = 0;
+
+	for_each_mem_pfn_range(i, nid, &this_start_pfn, &this_end_pfn, NULL) {
+		*start_pfn = min(*start_pfn, this_start_pfn);
+		*end_pfn = max(*end_pfn, this_end_pfn);
+	}
+
+	if (*start_pfn == -1UL)
+		*start_pfn = 0;
+}
+
+static void __init free_area_init_node(int nid)
+{
+	pg_data_t *pgdat = NODE_DATA(nid);
+	unsigned long start_pfn = 0;
+	unsigned long end_pfn = 0;
+
+	/* pg_data_t should be reset to zero when it's allocated */
+	WARN_ON(pgdat->nr_zones || pgdat->kswapd_highest_zoneidx);
+
+	get_pfn_range_for_nid(nid, &start_pfn, &end_pfn);
+
+	pgdat->node_id = nid;
+	pgdat->node_start_pfn = start_pfn;
+	pgdat->per_cpu_nodestats = NULL;
+
+	if (start_pfn != end_pfn) {
+		pr_info("Initmem setup node %d [mem %#018Lx-%#018Lx]\n", nid,
+			(u64)start_pfn << PAGE_SHIFT,
+			end_pfn ? ((u64)end_pfn << PAGE_SHIFT) - 1 : 0);
+	} else {
+		pr_info("Initmem setup node %d as memoryless\n", nid);
+	}
+
+	calculate_node_totalpages(pgdat, start_pfn, end_pfn);
+
+	alloc_node_mem_map(pgdat);
+	pgdat_set_deferred_range(pgdat);
+
+	free_area_init_core(pgdat);
+	lru_gen_init_pgdat(pgdat);
+}
+
+/* Any regular or high memory on that node ? */
+static void check_for_memory(pg_data_t *pgdat, int nid)
+{
+	enum zone_type zone_type;
+
+	for (zone_type = 0; zone_type <= ZONE_MOVABLE - 1; zone_type++) {
+		struct zone *zone = &pgdat->node_zones[zone_type];
+		if (populated_zone(zone)) {
+			if (IS_ENABLED(CONFIG_HIGHMEM))
+				node_set_state(nid, N_HIGH_MEMORY);
+			if (zone_type <= ZONE_NORMAL)
+				node_set_state(nid, N_NORMAL_MEMORY);
+			break;
+		}
+	}
+}
+
+#if MAX_NUMNODES > 1
+/*
+ * Figure out the number of possible node ids.
+ */
+void __init setup_nr_node_ids(void)
+{
+	unsigned int highest;
+
+	highest = find_last_bit(node_possible_map.bits, MAX_NUMNODES);
+	nr_node_ids = highest + 1;
+}
+#endif
+
+static void __init free_area_init_memoryless_node(int nid)
+{
+	free_area_init_node(nid);
+}
+
+/*
+ * Some architectures, e.g. ARC may have ZONE_HIGHMEM below ZONE_NORMAL. For
+ * such cases we allow max_zone_pfn sorted in the descending order
+ */
+bool __weak arch_has_descending_max_zone_pfns(void)
+{
+	return false;
+}
+
+/**
+ * free_area_init - Initialise all pg_data_t and zone data
+ * @max_zone_pfn: an array of max PFNs for each zone
+ *
+ * This will call free_area_init_node() for each active node in the system.
+ * Using the page ranges provided by memblock_set_node(), the size of each
+ * zone in each node and their holes is calculated. If the maximum PFN
+ * between two adjacent zones match, it is assumed that the zone is empty.
+ * For example, if arch_max_dma_pfn == arch_max_dma32_pfn, it is assumed
+ * that arch_max_dma32_pfn has no pages. It is also assumed that a zone
+ * starts where the previous one ended. For example, ZONE_DMA32 starts
+ * at arch_max_dma_pfn.
+ */
+void __init free_area_init(unsigned long *max_zone_pfn)
+{
+	unsigned long start_pfn, end_pfn;
+	int i, nid, zone;
+	bool descending;
+
+	/* Record where the zone boundaries are */
+	memset(arch_zone_lowest_possible_pfn, 0,
+				sizeof(arch_zone_lowest_possible_pfn));
+	memset(arch_zone_highest_possible_pfn, 0,
+				sizeof(arch_zone_highest_possible_pfn));
+
+	start_pfn = PHYS_PFN(memblock_start_of_DRAM());
+	descending = arch_has_descending_max_zone_pfns();
+
+	for (i = 0; i < MAX_NR_ZONES; i++) {
+		if (descending)
+			zone = MAX_NR_ZONES - i - 1;
+		else
+			zone = i;
+
+		if (zone == ZONE_MOVABLE)
+			continue;
+
+		end_pfn = max(max_zone_pfn[zone], start_pfn);
+		arch_zone_lowest_possible_pfn[zone] = start_pfn;
+		arch_zone_highest_possible_pfn[zone] = end_pfn;
+
+		start_pfn = end_pfn;
+	}
+
+	/* Find the PFNs that ZONE_MOVABLE begins at in each node */
+	memset(zone_movable_pfn, 0, sizeof(zone_movable_pfn));
+	find_zone_movable_pfns_for_nodes();
+
+	/* Print out the zone ranges */
+	pr_info("Zone ranges:\n");
+	for (i = 0; i < MAX_NR_ZONES; i++) {
+		if (i == ZONE_MOVABLE)
+			continue;
+		pr_info("  %-8s ", zone_names[i]);
+		if (arch_zone_lowest_possible_pfn[i] ==
+				arch_zone_highest_possible_pfn[i])
+			pr_cont("empty\n");
+		else
+			pr_cont("[mem %#018Lx-%#018Lx]\n",
+				(u64)arch_zone_lowest_possible_pfn[i]
+					<< PAGE_SHIFT,
+				((u64)arch_zone_highest_possible_pfn[i]
+					<< PAGE_SHIFT) - 1);
+	}
+
+	/* Print out the PFNs ZONE_MOVABLE begins at in each node */
+	pr_info("Movable zone start for each node\n");
+	for (i = 0; i < MAX_NUMNODES; i++) {
+		if (zone_movable_pfn[i])
+			pr_info("  Node %d: %#018Lx\n", i,
+			       (u64)zone_movable_pfn[i] << PAGE_SHIFT);
+	}
+
+	/*
+	 * Print out the early node map, and initialize the
+	 * subsection-map relative to active online memory ranges to
+	 * enable future "sub-section" extensions of the memory map.
+	 */
+	pr_info("Early memory node ranges\n");
+	for_each_mem_pfn_range(i, MAX_NUMNODES, &start_pfn, &end_pfn, &nid) {
+		pr_info("  node %3d: [mem %#018Lx-%#018Lx]\n", nid,
+			(u64)start_pfn << PAGE_SHIFT,
+			((u64)end_pfn << PAGE_SHIFT) - 1);
+		subsection_map_init(start_pfn, end_pfn - start_pfn);
+	}
+
+	/* Initialise every node */
+	mminit_verify_pageflags_layout();
+	setup_nr_node_ids();
+	for_each_node(nid) {
+		pg_data_t *pgdat;
+
+		if (!node_online(nid)) {
+			pr_info("Initializing node %d as memoryless\n", nid);
+
+			/* Allocator not initialized yet */
+			pgdat = arch_alloc_nodedata(nid);
+			if (!pgdat)
+				panic("Cannot allocate %zuB for node %d.\n",
+				       sizeof(*pgdat), nid);
+			arch_refresh_nodedata(nid, pgdat);
+			free_area_init_memoryless_node(nid);
+
+			/*
+			 * We do not want to confuse userspace by sysfs
+			 * files/directories for node without any memory
+			 * attached to it, so this node is not marked as
+			 * N_MEMORY and not marked online so that no sysfs
+			 * hierarchy will be created via register_one_node for
+			 * it. The pgdat will get fully initialized by
+			 * hotadd_init_pgdat() when memory is hotplugged into
+			 * this node.
+			 */
+			continue;
+		}
+
+		pgdat = NODE_DATA(nid);
+		free_area_init_node(nid);
+
+		/* Any memory on that node */
+		if (pgdat->node_present_pages)
+			node_set_state(nid, N_MEMORY);
+		check_for_memory(pgdat, nid);
+	}
+
+	memmap_init();
+}
+
+/**
+ * node_map_pfn_alignment - determine the maximum internode alignment
+ *
+ * This function should be called after node map is populated and sorted.
+ * It calculates the maximum power of two alignment which can distinguish
+ * all the nodes.
+ *
+ * For example, if all nodes are 1GiB and aligned to 1GiB, the return value
+ * would indicate 1GiB alignment with (1 << (30 - PAGE_SHIFT)).  If the
+ * nodes are shifted by 256MiB, 256MiB.  Note that if only the last node is
+ * shifted, 1GiB is enough and this function will indicate so.
+ *
+ * This is used to test whether pfn -> nid mapping of the chosen memory
+ * model has fine enough granularity to avoid incorrect mapping for the
+ * populated node map.
+ *
+ * Return: the determined alignment in pfn's.  0 if there is no alignment
+ * requirement (single node).
+ */
+unsigned long __init node_map_pfn_alignment(void)
+{
+	unsigned long accl_mask = 0, last_end = 0;
+	unsigned long start, end, mask;
+	int last_nid = NUMA_NO_NODE;
+	int i, nid;
+
+	for_each_mem_pfn_range(i, MAX_NUMNODES, &start, &end, &nid) {
+		if (!start || last_nid < 0 || last_nid == nid) {
+			last_nid = nid;
+			last_end = end;
+			continue;
+		}
+
+		/*
+		 * Start with a mask granular enough to pin-point to the
+		 * start pfn and tick off bits one-by-one until it becomes
+		 * too coarse to separate the current node from the last.
+		 */
+		mask = ~((1 << __ffs(start)) - 1);
+		while (mask && last_end <= (start & (mask << 1)))
+			mask <<= 1;
+
+		/* accumulate all internode masks */
+		accl_mask |= mask;
+	}
+
+	/* convert mask to number of pages */
+	return ~accl_mask + 1;
+}
+
+#ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT
+static void __init deferred_free_range(unsigned long pfn,
+				       unsigned long nr_pages)
+{
+	struct page *page;
+	unsigned long i;
+
+	if (!nr_pages)
+		return;
+
+	page = pfn_to_page(pfn);
+
+	/* Free a large naturally-aligned chunk if possible */
+	if (nr_pages == pageblock_nr_pages && pageblock_aligned(pfn)) {
+		set_pageblock_migratetype(page, MIGRATE_MOVABLE);
+		__free_pages_core(page, pageblock_order);
+		return;
+	}
+
+	for (i = 0; i < nr_pages; i++, page++, pfn++) {
+		if (pageblock_aligned(pfn))
+			set_pageblock_migratetype(page, MIGRATE_MOVABLE);
+		__free_pages_core(page, 0);
+	}
+}
+
+/* Completion tracking for deferred_init_memmap() threads */
+static atomic_t pgdat_init_n_undone __initdata;
+static __initdata DECLARE_COMPLETION(pgdat_init_all_done_comp);
+
+static inline void __init pgdat_init_report_one_done(void)
+{
+	if (atomic_dec_and_test(&pgdat_init_n_undone))
+		complete(&pgdat_init_all_done_comp);
+}
+
+/*
+ * Returns true if page needs to be initialized or freed to buddy allocator.
+ *
+ * We check if a current large page is valid by only checking the validity
+ * of the head pfn.
+ */
+static inline bool __init deferred_pfn_valid(unsigned long pfn)
+{
+	if (pageblock_aligned(pfn) && !pfn_valid(pfn))
+		return false;
+	return true;
+}
+
+/*
+ * Free pages to buddy allocator. Try to free aligned pages in
+ * pageblock_nr_pages sizes.
+ */
+static void __init deferred_free_pages(unsigned long pfn,
+				       unsigned long end_pfn)
+{
+	unsigned long nr_free = 0;
+
+	for (; pfn < end_pfn; pfn++) {
+		if (!deferred_pfn_valid(pfn)) {
+			deferred_free_range(pfn - nr_free, nr_free);
+			nr_free = 0;
+		} else if (pageblock_aligned(pfn)) {
+			deferred_free_range(pfn - nr_free, nr_free);
+			nr_free = 1;
+		} else {
+			nr_free++;
+		}
+	}
+	/* Free the last block of pages to allocator */
+	deferred_free_range(pfn - nr_free, nr_free);
+}
+
+/*
+ * Initialize struct pages.  We minimize pfn page lookups and scheduler checks
+ * by performing it only once every pageblock_nr_pages.
+ * Return number of pages initialized.
+ */
+static unsigned long  __init deferred_init_pages(struct zone *zone,
+						 unsigned long pfn,
+						 unsigned long end_pfn)
+{
+	int nid = zone_to_nid(zone);
+	unsigned long nr_pages = 0;
+	int zid = zone_idx(zone);
+	struct page *page = NULL;
+
+	for (; pfn < end_pfn; pfn++) {
+		if (!deferred_pfn_valid(pfn)) {
+			page = NULL;
+			continue;
+		} else if (!page || pageblock_aligned(pfn)) {
+			page = pfn_to_page(pfn);
+		} else {
+			page++;
+		}
+		__init_single_page(page, pfn, zid, nid);
+		nr_pages++;
+	}
+	return (nr_pages);
+}
+
+/*
+ * This function is meant to pre-load the iterator for the zone init.
+ * Specifically it walks through the ranges until we are caught up to the
+ * first_init_pfn value and exits there. If we never encounter the value we
+ * return false indicating there are no valid ranges left.
+ */
+static bool __init
+deferred_init_mem_pfn_range_in_zone(u64 *i, struct zone *zone,
+				    unsigned long *spfn, unsigned long *epfn,
+				    unsigned long first_init_pfn)
+{
+	u64 j;
+
+	/*
+	 * Start out by walking through the ranges in this zone that have
+	 * already been initialized. We don't need to do anything with them
+	 * so we just need to flush them out of the system.
+	 */
+	for_each_free_mem_pfn_range_in_zone(j, zone, spfn, epfn) {
+		if (*epfn <= first_init_pfn)
+			continue;
+		if (*spfn < first_init_pfn)
+			*spfn = first_init_pfn;
+		*i = j;
+		return true;
+	}
+
+	return false;
+}
+
+/*
+ * Initialize and free pages. We do it in two loops: first we initialize
+ * struct page, then free to buddy allocator, because while we are
+ * freeing pages we can access pages that are ahead (computing buddy
+ * page in __free_one_page()).
+ *
+ * In order to try and keep some memory in the cache we have the loop
+ * broken along max page order boundaries. This way we will not cause
+ * any issues with the buddy page computation.
+ */
+static unsigned long __init
+deferred_init_maxorder(u64 *i, struct zone *zone, unsigned long *start_pfn,
+		       unsigned long *end_pfn)
+{
+	unsigned long mo_pfn = ALIGN(*start_pfn + 1, MAX_ORDER_NR_PAGES);
+	unsigned long spfn = *start_pfn, epfn = *end_pfn;
+	unsigned long nr_pages = 0;
+	u64 j = *i;
+
+	/* First we loop through and initialize the page values */
+	for_each_free_mem_pfn_range_in_zone_from(j, zone, start_pfn, end_pfn) {
+		unsigned long t;
+
+		if (mo_pfn <= *start_pfn)
+			break;
+
+		t = min(mo_pfn, *end_pfn);
+		nr_pages += deferred_init_pages(zone, *start_pfn, t);
+
+		if (mo_pfn < *end_pfn) {
+			*start_pfn = mo_pfn;
+			break;
+		}
+	}
+
+	/* Reset values and now loop through freeing pages as needed */
+	swap(j, *i);
+
+	for_each_free_mem_pfn_range_in_zone_from(j, zone, &spfn, &epfn) {
+		unsigned long t;
+
+		if (mo_pfn <= spfn)
+			break;
+
+		t = min(mo_pfn, epfn);
+		deferred_free_pages(spfn, t);
+
+		if (mo_pfn <= epfn)
+			break;
+	}
+
+	return nr_pages;
+}
+
+static void __init
+deferred_init_memmap_chunk(unsigned long start_pfn, unsigned long end_pfn,
+			   void *arg)
+{
+	unsigned long spfn, epfn;
+	struct zone *zone = arg;
+	u64 i;
+
+	deferred_init_mem_pfn_range_in_zone(&i, zone, &spfn, &epfn, start_pfn);
+
+	/*
+	 * Initialize and free pages in MAX_ORDER sized increments so that we
+	 * can avoid introducing any issues with the buddy allocator.
+	 */
+	while (spfn < end_pfn) {
+		deferred_init_maxorder(&i, zone, &spfn, &epfn);
+		cond_resched();
+	}
+}
+
+/* An arch may override for more concurrency. */
+__weak int __init
+deferred_page_init_max_threads(const struct cpumask *node_cpumask)
+{
+	return 1;
+}
+
+/* Initialise remaining memory on a node */
+static int __init deferred_init_memmap(void *data)
+{
+	pg_data_t *pgdat = data;
+	const struct cpumask *cpumask = cpumask_of_node(pgdat->node_id);
+	unsigned long spfn = 0, epfn = 0;
+	unsigned long first_init_pfn, flags;
+	unsigned long start = jiffies;
+	struct zone *zone;
+	int zid, max_threads;
+	u64 i;
+
+	/* Bind memory initialisation thread to a local node if possible */
+	if (!cpumask_empty(cpumask))
+		set_cpus_allowed_ptr(current, cpumask);
+
+	pgdat_resize_lock(pgdat, &flags);
+	first_init_pfn = pgdat->first_deferred_pfn;
+	if (first_init_pfn == ULONG_MAX) {
+		pgdat_resize_unlock(pgdat, &flags);
+		pgdat_init_report_one_done();
+		return 0;
+	}
+
+	/* Sanity check boundaries */
+	BUG_ON(pgdat->first_deferred_pfn < pgdat->node_start_pfn);
+	BUG_ON(pgdat->first_deferred_pfn > pgdat_end_pfn(pgdat));
+	pgdat->first_deferred_pfn = ULONG_MAX;
+
+	/*
+	 * Once we unlock here, the zone cannot be grown anymore, thus if an
+	 * interrupt thread must allocate this early in boot, zone must be
+	 * pre-grown prior to start of deferred page initialization.
+	 */
+	pgdat_resize_unlock(pgdat, &flags);
+
+	/* Only the highest zone is deferred so find it */
+	for (zid = 0; zid < MAX_NR_ZONES; zid++) {
+		zone = pgdat->node_zones + zid;
+		if (first_init_pfn < zone_end_pfn(zone))
+			break;
+	}
+
+	/* If the zone is empty somebody else may have cleared out the zone */
+	if (!deferred_init_mem_pfn_range_in_zone(&i, zone, &spfn, &epfn,
+						 first_init_pfn))
+		goto zone_empty;
+
+	max_threads = deferred_page_init_max_threads(cpumask);
+
+	while (spfn < epfn) {
+		unsigned long epfn_align = ALIGN(epfn, PAGES_PER_SECTION);
+		struct padata_mt_job job = {
+			.thread_fn   = deferred_init_memmap_chunk,
+			.fn_arg      = zone,
+			.start       = spfn,
+			.size        = epfn_align - spfn,
+			.align       = PAGES_PER_SECTION,
+			.min_chunk   = PAGES_PER_SECTION,
+			.max_threads = max_threads,
+		};
+
+		padata_do_multithreaded(&job);
+		deferred_init_mem_pfn_range_in_zone(&i, zone, &spfn, &epfn,
+						    epfn_align);
+	}
+zone_empty:
+	/* Sanity check that the next zone really is unpopulated */
+	WARN_ON(++zid < MAX_NR_ZONES && populated_zone(++zone));
+
+	pr_info("node %d deferred pages initialised in %ums\n",
+		pgdat->node_id, jiffies_to_msecs(jiffies - start));
+
+	pgdat_init_report_one_done();
+	return 0;
+}
+
+/*
+ * If this zone has deferred pages, try to grow it by initializing enough
+ * deferred pages to satisfy the allocation specified by order, rounded up to
+ * the nearest PAGES_PER_SECTION boundary.  So we're adding memory in increments
+ * of SECTION_SIZE bytes by initializing struct pages in increments of
+ * PAGES_PER_SECTION * sizeof(struct page) bytes.
+ *
+ * Return true when zone was grown, otherwise return false. We return true even
+ * when we grow less than requested, to let the caller decide if there are
+ * enough pages to satisfy the allocation.
+ *
+ * Note: We use noinline because this function is needed only during boot, and
+ * it is called from a __ref function _deferred_grow_zone. This way we are
+ * making sure that it is not inlined into permanent text section.
+ */
+bool __init deferred_grow_zone(struct zone *zone, unsigned int order)
+{
+	unsigned long nr_pages_needed = ALIGN(1 << order, PAGES_PER_SECTION);
+	pg_data_t *pgdat = zone->zone_pgdat;
+	unsigned long first_deferred_pfn = pgdat->first_deferred_pfn;
+	unsigned long spfn, epfn, flags;
+	unsigned long nr_pages = 0;
+	u64 i;
+
+	/* Only the last zone may have deferred pages */
+	if (zone_end_pfn(zone) != pgdat_end_pfn(pgdat))
+		return false;
+
+	pgdat_resize_lock(pgdat, &flags);
+
+	/*
+	 * If someone grew this zone while we were waiting for spinlock, return
+	 * true, as there might be enough pages already.
+	 */
+	if (first_deferred_pfn != pgdat->first_deferred_pfn) {
+		pgdat_resize_unlock(pgdat, &flags);
+		return true;
+	}
+
+	/* If the zone is empty somebody else may have cleared out the zone */
+	if (!deferred_init_mem_pfn_range_in_zone(&i, zone, &spfn, &epfn,
+						 first_deferred_pfn)) {
+		pgdat->first_deferred_pfn = ULONG_MAX;
+		pgdat_resize_unlock(pgdat, &flags);
+		/* Retry only once. */
+		return first_deferred_pfn != ULONG_MAX;
+	}
+
+	/*
+	 * Initialize and free pages in MAX_ORDER sized increments so
+	 * that we can avoid introducing any issues with the buddy
+	 * allocator.
+	 */
+	while (spfn < epfn) {
+		/* update our first deferred PFN for this section */
+		first_deferred_pfn = spfn;
+
+		nr_pages += deferred_init_maxorder(&i, zone, &spfn, &epfn);
+		touch_nmi_watchdog();
+
+		/* We should only stop along section boundaries */
+		if ((first_deferred_pfn ^ spfn) < PAGES_PER_SECTION)
+			continue;
+
+		/* If our quota has been met we can stop here */
+		if (nr_pages >= nr_pages_needed)
+			break;
+	}
+
+	pgdat->first_deferred_pfn = spfn;
+	pgdat_resize_unlock(pgdat, &flags);
+
+	return nr_pages > 0;
+}
+
+#endif /* CONFIG_DEFERRED_STRUCT_PAGE_INIT */
+
+#ifdef CONFIG_CMA
+void __init init_cma_reserved_pageblock(struct page *page)
+{
+	unsigned i = pageblock_nr_pages;
+	struct page *p = page;
+
+	do {
+		__ClearPageReserved(p);
+		set_page_count(p, 0);
+	} while (++p, --i);
+
+	set_pageblock_migratetype(page, MIGRATE_CMA);
+	set_page_refcounted(page);
+	__free_pages(page, pageblock_order);
+
+	adjust_managed_page_count(page, pageblock_nr_pages);
+	page_zone(page)->cma_pages += pageblock_nr_pages;
+}
+#endif
+
+void __init page_alloc_init_late(void)
+{
+	struct zone *zone;
+	int nid;
+
+#ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT
+
+	/* There will be num_node_state(N_MEMORY) threads */
+	atomic_set(&pgdat_init_n_undone, num_node_state(N_MEMORY));
+	for_each_node_state(nid, N_MEMORY) {
+		kthread_run(deferred_init_memmap, NODE_DATA(nid), "pgdatinit%d", nid);
+	}
+
+	/* Block until all are initialised */
+	wait_for_completion(&pgdat_init_all_done_comp);
+
+	/*
+	 * We initialized the rest of the deferred pages.  Permanently disable
+	 * on-demand struct page initialization.
+	 */
+	static_branch_disable(&deferred_pages);
+
+	/* Reinit limits that are based on free pages after the kernel is up */
+	files_maxfiles_init();
+#endif
+
+	buffer_init();
+
+	/* Discard memblock private memory */
+	memblock_discard();
+
+	for_each_node_state(nid, N_MEMORY)
+		shuffle_free_memory(NODE_DATA(nid));
+
+	for_each_populated_zone(zone)
+		set_zone_contiguous(zone);
+}
+
+#ifndef __HAVE_ARCH_RESERVED_KERNEL_PAGES
+/*
+ * Returns the number of pages that arch has reserved but
+ * is not known to alloc_large_system_hash().
+ */
+static unsigned long __init arch_reserved_kernel_pages(void)
+{
+	return 0;
+}
+#endif
+
+/*
+ * Adaptive scale is meant to reduce sizes of hash tables on large memory
+ * machines. As memory size is increased the scale is also increased but at
+ * slower pace.  Starting from ADAPT_SCALE_BASE (64G), every time memory
+ * quadruples the scale is increased by one, which means the size of hash table
+ * only doubles, instead of quadrupling as well.
+ * Because 32-bit systems cannot have large physical memory, where this scaling
+ * makes sense, it is disabled on such platforms.
+ */
+#if __BITS_PER_LONG > 32
+#define ADAPT_SCALE_BASE	(64ul << 30)
+#define ADAPT_SCALE_SHIFT	2
+#define ADAPT_SCALE_NPAGES	(ADAPT_SCALE_BASE >> PAGE_SHIFT)
+#endif
+
+/*
+ * allocate a large system hash table from bootmem
+ * - it is assumed that the hash table must contain an exact power-of-2
+ *   quantity of entries
+ * - limit is the number of hash buckets, not the total allocation size
+ */
+void *__init alloc_large_system_hash(const char *tablename,
+				     unsigned long bucketsize,
+				     unsigned long numentries,
+				     int scale,
+				     int flags,
+				     unsigned int *_hash_shift,
+				     unsigned int *_hash_mask,
+				     unsigned long low_limit,
+				     unsigned long high_limit)
+{
+	unsigned long long max = high_limit;
+	unsigned long log2qty, size;
+	void *table;
+	gfp_t gfp_flags;
+	bool virt;
+	bool huge;
+
+	/* allow the kernel cmdline to have a say */
+	if (!numentries) {
+		/* round applicable memory size up to nearest megabyte */
+		numentries = nr_kernel_pages;
+		numentries -= arch_reserved_kernel_pages();
+
+		/* It isn't necessary when PAGE_SIZE >= 1MB */
+		if (PAGE_SIZE < SZ_1M)
+			numentries = round_up(numentries, SZ_1M / PAGE_SIZE);
+
+#if __BITS_PER_LONG > 32
+		if (!high_limit) {
+			unsigned long adapt;
+
+			for (adapt = ADAPT_SCALE_NPAGES; adapt < numentries;
+			     adapt <<= ADAPT_SCALE_SHIFT)
+				scale++;
+		}
+#endif
+
+		/* limit to 1 bucket per 2^scale bytes of low memory */
+		if (scale > PAGE_SHIFT)
+			numentries >>= (scale - PAGE_SHIFT);
+		else
+			numentries <<= (PAGE_SHIFT - scale);
+
+		/* Make sure we've got at least a 0-order allocation.. */
+		if (unlikely(flags & HASH_SMALL)) {
+			/* Makes no sense without HASH_EARLY */
+			WARN_ON(!(flags & HASH_EARLY));
+			if (!(numentries >> *_hash_shift)) {
+				numentries = 1UL << *_hash_shift;
+				BUG_ON(!numentries);
+			}
+		} else if (unlikely((numentries * bucketsize) < PAGE_SIZE))
+			numentries = PAGE_SIZE / bucketsize;
+	}
+	numentries = roundup_pow_of_two(numentries);
+
+	/* limit allocation size to 1/16 total memory by default */
+	if (max == 0) {
+		max = ((unsigned long long)nr_all_pages << PAGE_SHIFT) >> 4;
+		do_div(max, bucketsize);
+	}
+	max = min(max, 0x80000000ULL);
+
+	if (numentries < low_limit)
+		numentries = low_limit;
+	if (numentries > max)
+		numentries = max;
+
+	log2qty = ilog2(numentries);
+
+	gfp_flags = (flags & HASH_ZERO) ? GFP_ATOMIC | __GFP_ZERO : GFP_ATOMIC;
+	do {
+		virt = false;
+		size = bucketsize << log2qty;
+		if (flags & HASH_EARLY) {
+			if (flags & HASH_ZERO)
+				table = memblock_alloc(size, SMP_CACHE_BYTES);
+			else
+				table = memblock_alloc_raw(size,
+							   SMP_CACHE_BYTES);
+		} else if (get_order(size) > MAX_ORDER || hashdist) {
+			table = vmalloc_huge(size, gfp_flags);
+			virt = true;
+			if (table)
+				huge = is_vm_area_hugepages(table);
+		} else {
+			/*
+			 * If bucketsize is not a power-of-two, we may free
+			 * some pages at the end of hash table which
+			 * alloc_pages_exact() automatically does
+			 */
+			table = alloc_pages_exact(size, gfp_flags);
+			kmemleak_alloc(table, size, 1, gfp_flags);
+		}
+	} while (!table && size > PAGE_SIZE && --log2qty);
+
+	if (!table)
+		panic("Failed to allocate %s hash table\n", tablename);
+
+	pr_info("%s hash table entries: %ld (order: %d, %lu bytes, %s)\n",
+		tablename, 1UL << log2qty, ilog2(size) - PAGE_SHIFT, size,
+		virt ? (huge ? "vmalloc hugepage" : "vmalloc") : "linear");
+
+	if (_hash_shift)
+		*_hash_shift = log2qty;
+	if (_hash_mask)
+		*_hash_mask = (1 << log2qty) - 1;
+
+	return table;
+}
+
+/**
+ * set_dma_reserve - set the specified number of pages reserved in the first zone
+ * @new_dma_reserve: The number of pages to mark reserved
+ *
+ * The per-cpu batchsize and zone watermarks are determined by managed_pages.
+ * In the DMA zone, a significant percentage may be consumed by kernel image
+ * and other unfreeable allocations which can skew the watermarks badly. This
+ * function may optionally be used to account for unfreeable pages in the
+ * first zone (e.g., ZONE_DMA). The effect will be lower watermarks and
+ * smaller per-cpu batchsize.
+ */
+void __init set_dma_reserve(unsigned long new_dma_reserve)
+{
+	dma_reserve = new_dma_reserve;
+}
+
+void __init memblock_free_pages(struct page *page, unsigned long pfn,
+							unsigned int order)
+{
+	if (!early_page_initialised(pfn))
+		return;
+	if (!kmsan_memblock_free_pages(page, order)) {
+		/* KMSAN will take care of these pages. */
+		return;
+	}
+	__free_pages_core(page, order);
+}
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index e1149d54d738..c56c147bdf27 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -72,9 +72,7 @@
 #include <linux/lockdep.h>
 #include <linux/nmi.h>
 #include <linux/psi.h>
-#include <linux/padata.h>
 #include <linux/khugepaged.h>
-#include <linux/buffer_head.h>
 #include <linux/delayacct.h>
 #include <asm/sections.h>
 #include <asm/tlbflush.h>
@@ -355,7 +353,7 @@ int sysctl_lowmem_reserve_ratio[MAX_NR_ZONES] = {
 	[ZONE_MOVABLE] = 0,
 };
 
-static char * const zone_names[MAX_NR_ZONES] = {
+char * const zone_names[MAX_NR_ZONES] = {
 #ifdef CONFIG_ZONE_DMA
 	 "DMA",
 #endif
@@ -401,17 +399,6 @@ int user_min_free_kbytes = -1;
 int watermark_boost_factor __read_mostly = 15000;
 int watermark_scale_factor = 10;
 
-static unsigned long nr_kernel_pages __initdata;
-static unsigned long nr_all_pages __initdata;
-static unsigned long dma_reserve __initdata;
-
-static unsigned long arch_zone_lowest_possible_pfn[MAX_NR_ZONES] __initdata;
-static unsigned long arch_zone_highest_possible_pfn[MAX_NR_ZONES] __initdata;
-static unsigned long required_kernelcore __initdata;
-static unsigned long required_kernelcore_percent __initdata;
-static unsigned long required_movablecore __initdata;
-static unsigned long required_movablecore_percent __initdata;
-static unsigned long zone_movable_pfn[MAX_NUMNODES] __initdata;
 bool mirrored_kernelcore __initdata_memblock;
 
 /* movable_zone is the "real" zone pages in ZONE_MOVABLE are taken from */
@@ -427,86 +414,36 @@ EXPORT_SYMBOL(nr_online_nodes);
 
 int page_group_by_mobility_disabled __read_mostly;
 
-bool deferred_struct_pages __meminitdata;
-
 #ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT
 /*
  * During boot we initialize deferred pages on-demand, as needed, but once
  * page_alloc_init_late() has finished, the deferred pages are all initialized,
  * and we can permanently disable that path.
  */
-static DEFINE_STATIC_KEY_TRUE(deferred_pages);
+DEFINE_STATIC_KEY_TRUE(deferred_pages);
 
 static inline bool deferred_pages_enabled(void)
 {
 	return static_branch_unlikely(&deferred_pages);
 }
 
-/* Returns true if the struct page for the pfn is initialised */
-static inline bool __meminit early_page_initialised(unsigned long pfn)
-{
-	int nid = early_pfn_to_nid(pfn);
-
-	if (node_online(nid) && pfn >= NODE_DATA(nid)->first_deferred_pfn)
-		return false;
-
-	return true;
-}
-
 /*
- * Returns true when the remaining initialisation should be deferred until
- * later in the boot cycle when it can be parallelised.
+ * deferred_grow_zone() is __init, but it is called from
+ * get_page_from_freelist() during early boot until deferred_pages permanently
+ * disables this call. This is why we have refdata wrapper to avoid warning,
+ * and to ensure that the function body gets unloaded.
  */
-static bool __meminit
-defer_init(int nid, unsigned long pfn, unsigned long end_pfn)
+static bool __ref
+_deferred_grow_zone(struct zone *zone, unsigned int order)
 {
-	static unsigned long prev_end_pfn, nr_initialised;
-
-	if (early_page_ext_enabled())
-		return false;
-	/*
-	 * prev_end_pfn static that contains the end of previous zone
-	 * No need to protect because called very early in boot before smp_init.
-	 */
-	if (prev_end_pfn != end_pfn) {
-		prev_end_pfn = end_pfn;
-		nr_initialised = 0;
-	}
-
-	/* Always populate low zones for address-constrained allocations */
-	if (end_pfn < pgdat_end_pfn(NODE_DATA(nid)))
-		return false;
-
-	if (NODE_DATA(nid)->first_deferred_pfn != ULONG_MAX)
-		return true;
-	/*
-	 * We start only with one section of pages, more pages are added as
-	 * needed until the rest of deferred pages are initialized.
-	 */
-	nr_initialised++;
-	if ((nr_initialised > PAGES_PER_SECTION) &&
-	    (pfn & (PAGES_PER_SECTION - 1)) == 0) {
-		NODE_DATA(nid)->first_deferred_pfn = pfn;
-		return true;
-	}
-	return false;
+       return deferred_grow_zone(zone, order);
 }
 #else
 static inline bool deferred_pages_enabled(void)
 {
 	return false;
 }
-
-static inline bool early_page_initialised(unsigned long pfn)
-{
-	return true;
-}
-
-static inline bool defer_init(int nid, unsigned long pfn, unsigned long end_pfn)
-{
-	return false;
-}
-#endif
+#endif /* CONFIG_DEFERRED_STRUCT_PAGE_INIT */
 
 /* Return a pointer to the bitmap storing bits affecting a block of pages */
 static inline unsigned long *get_pageblock_bitmap(const struct page *page,
@@ -772,26 +709,6 @@ void free_compound_page(struct page *page)
 	free_the_page(page, compound_order(page));
 }
 
-static void prep_compound_head(struct page *page, unsigned int order)
-{
-	struct folio *folio = (struct folio *)page;
-
-	set_compound_page_dtor(page, COMPOUND_PAGE_DTOR);
-	set_compound_order(page, order);
-	atomic_set(&folio->_entire_mapcount, -1);
-	atomic_set(&folio->_nr_pages_mapped, 0);
-	atomic_set(&folio->_pincount, 0);
-}
-
-static void prep_compound_tail(struct page *head, int tail_idx)
-{
-	struct page *p = head + tail_idx;
-
-	p->mapping = TAIL_MAPPING;
-	set_compound_head(p, head);
-	set_page_private(p, 0);
-}
-
 void prep_compound_page(struct page *page, unsigned int order)
 {
 	int i;
@@ -1601,80 +1518,6 @@ static void free_one_page(struct zone *zone,
 	spin_unlock_irqrestore(&zone->lock, flags);
 }
 
-static void __meminit __init_single_page(struct page *page, unsigned long pfn,
-				unsigned long zone, int nid)
-{
-	mm_zero_struct_page(page);
-	set_page_links(page, zone, nid, pfn);
-	init_page_count(page);
-	page_mapcount_reset(page);
-	page_cpupid_reset_last(page);
-	page_kasan_tag_reset(page);
-
-	INIT_LIST_HEAD(&page->lru);
-#ifdef WANT_PAGE_VIRTUAL
-	/* The shift won't overflow because ZONE_NORMAL is below 4G. */
-	if (!is_highmem_idx(zone))
-		set_page_address(page, __va(pfn << PAGE_SHIFT));
-#endif
-}
-
-#ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT
-static void __meminit init_reserved_page(unsigned long pfn)
-{
-	pg_data_t *pgdat;
-	int nid, zid;
-
-	if (early_page_initialised(pfn))
-		return;
-
-	nid = early_pfn_to_nid(pfn);
-	pgdat = NODE_DATA(nid);
-
-	for (zid = 0; zid < MAX_NR_ZONES; zid++) {
-		struct zone *zone = &pgdat->node_zones[zid];
-
-		if (zone_spans_pfn(zone, pfn))
-			break;
-	}
-	__init_single_page(pfn_to_page(pfn), pfn, zid, nid);
-}
-#else
-static inline void init_reserved_page(unsigned long pfn)
-{
-}
-#endif /* CONFIG_DEFERRED_STRUCT_PAGE_INIT */
-
-/*
- * Initialised pages do not have PageReserved set. This function is
- * called for each range allocated by the bootmem allocator and
- * marks the pages PageReserved. The remaining valid pages are later
- * sent to the buddy page allocator.
- */
-void __meminit reserve_bootmem_region(phys_addr_t start, phys_addr_t end)
-{
-	unsigned long start_pfn = PFN_DOWN(start);
-	unsigned long end_pfn = PFN_UP(end);
-
-	for (; start_pfn < end_pfn; start_pfn++) {
-		if (pfn_valid(start_pfn)) {
-			struct page *page = pfn_to_page(start_pfn);
-
-			init_reserved_page(start_pfn);
-
-			/* Avoid false-positive PageTail() */
-			INIT_LIST_HEAD(&page->lru);
-
-			/*
-			 * no need for atomic set_bit because the struct
-			 * page is not visible yet so nobody should
-			 * access it yet.
-			 */
-			__SetPageReserved(page);
-		}
-	}
-}
-
 static void __free_pages_ok(struct page *page, unsigned int order,
 			    fpi_t fpi_flags)
 {
@@ -1733,70 +1576,6 @@ void __free_pages_core(struct page *page, unsigned int order)
 	__free_pages_ok(page, order, FPI_TO_TAIL);
 }
 
-#ifdef CONFIG_NUMA
-
-/*
- * During memory init memblocks map pfns to nids. The search is expensive and
- * this caches recent lookups. The implementation of __early_pfn_to_nid
- * treats start/end as pfns.
- */
-struct mminit_pfnnid_cache {
-	unsigned long last_start;
-	unsigned long last_end;
-	int last_nid;
-};
-
-static struct mminit_pfnnid_cache early_pfnnid_cache __meminitdata;
-
-/*
- * Required by SPARSEMEM. Given a PFN, return what node the PFN is on.
- */
-static int __meminit __early_pfn_to_nid(unsigned long pfn,
-					struct mminit_pfnnid_cache *state)
-{
-	unsigned long start_pfn, end_pfn;
-	int nid;
-
-	if (state->last_start <= pfn && pfn < state->last_end)
-		return state->last_nid;
-
-	nid = memblock_search_pfn_nid(pfn, &start_pfn, &end_pfn);
-	if (nid != NUMA_NO_NODE) {
-		state->last_start = start_pfn;
-		state->last_end = end_pfn;
-		state->last_nid = nid;
-	}
-
-	return nid;
-}
-
-int __meminit early_pfn_to_nid(unsigned long pfn)
-{
-	static DEFINE_SPINLOCK(early_pfn_lock);
-	int nid;
-
-	spin_lock(&early_pfn_lock);
-	nid = __early_pfn_to_nid(pfn, &early_pfnnid_cache);
-	if (nid < 0)
-		nid = first_online_node;
-	spin_unlock(&early_pfn_lock);
-
-	return nid;
-}
-#endif /* CONFIG_NUMA */
-
-void __init memblock_free_pages(struct page *page, unsigned long pfn,
-							unsigned int order)
-{
-	if (!early_page_initialised(pfn))
-		return;
-	if (!kmsan_memblock_free_pages(page, order)) {
-		/* KMSAN will take care of these pages. */
-		return;
-	}
-	__free_pages_core(page, order);
-}
-
 /*
  * Check that the whole (or subset of) a pageblock given by the interval of
  * [start_pfn, end_pfn) is valid and within the same zone, before scanning it
@@ -1867,570 +1646,131 @@ void clear_zone_contiguous(struct zone *zone)
 	zone->contiguous = false;
 }
 
-#ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT
-static void __init deferred_free_range(unsigned long pfn,
-				       unsigned long nr_pages)
-{
-	struct page *page;
-	unsigned long i;
-
-	if (!nr_pages)
-		return;
-
-	page = pfn_to_page(pfn);
-
-	/* Free a large naturally-aligned chunk if possible */
-	if (nr_pages == pageblock_nr_pages && pageblock_aligned(pfn)) {
-		set_pageblock_migratetype(page, MIGRATE_MOVABLE);
-		__free_pages_core(page, pageblock_order);
-		return;
-	}
-
-	for (i = 0; i < nr_pages; i++, page++, pfn++) {
-		if (pageblock_aligned(pfn))
-			set_pageblock_migratetype(page, MIGRATE_MOVABLE);
-		__free_pages_core(page, 0);
-	}
-}
-
-/* Completion tracking for deferred_init_memmap() threads */
-static atomic_t pgdat_init_n_undone __initdata;
-static __initdata DECLARE_COMPLETION(pgdat_init_all_done_comp);
-
-static inline void __init pgdat_init_report_one_done(void)
-{
-	if (atomic_dec_and_test(&pgdat_init_n_undone))
-		complete(&pgdat_init_all_done_comp);
-}
-
 /*
- * Returns true if page needs to be initialized or freed to buddy allocator.
+ * The order of subdivision here is critical for the IO subsystem.
+ * Please do not alter this order without good reasons and regression
+ * testing. Specifically, as large blocks of memory are subdivided,
+ * the order in which smaller blocks are delivered depends on the order
+ * they're subdivided in this function. This is the primary factor
+ * influencing the order in which pages are delivered to the IO
+ * subsystem according to empirical testing, and this is also justified
+ * by considering the behavior of a buddy system containing a single
+ * large block of memory acted on by a series of small allocations.
+ * This behavior is a critical factor in sglist merging's success.
  *
- * We check if a current large page is valid by only checking the validity
- * of the head pfn.
+ * -- nyc
  */
-static inline bool __init deferred_pfn_valid(unsigned long pfn)
+static inline void expand(struct zone *zone, struct page *page,
+	int low, int high, int migratetype)
 {
-	if (pageblock_aligned(pfn) && !pfn_valid(pfn))
-		return false;
-	return true;
-}
-
-/*
- * Free pages to buddy allocator. Try to free aligned pages in
- * pageblock_nr_pages sizes.
- */
-static void __init deferred_free_pages(unsigned long pfn,
-				       unsigned long end_pfn)
-{
-	unsigned long nr_free = 0;
-
-	for (; pfn < end_pfn; pfn++) {
-		if (!deferred_pfn_valid(pfn)) {
-			deferred_free_range(pfn - nr_free, nr_free);
-			nr_free = 0;
-		} else if (pageblock_aligned(pfn)) {
-			deferred_free_range(pfn - nr_free, nr_free);
-			nr_free = 1;
-		} else {
-			nr_free++;
-		}
-	}
-	/* Free the last block of pages to allocator */
-	deferred_free_range(pfn - nr_free, nr_free);
-}
+	unsigned long size = 1 << high;
 
-/*
- * Initialize struct pages.  We minimize pfn page lookups and scheduler checks
- * by performing it only once every pageblock_nr_pages.
- * Return number of pages initialized.
- */
-static unsigned long  __init deferred_init_pages(struct zone *zone,
-						 unsigned long pfn,
-						 unsigned long end_pfn)
-{
-	int nid = zone_to_nid(zone);
-	unsigned long nr_pages = 0;
-	int zid = zone_idx(zone);
-	struct page *page = NULL;
+	while (high > low) {
+		high--;
+		size >>= 1;
+		VM_BUG_ON_PAGE(bad_range(zone, &page[size]), &page[size]);
 
-	for (; pfn < end_pfn; pfn++) {
-		if (!deferred_pfn_valid(pfn)) {
-			page = NULL;
+		/*
+		 * Mark as guard pages (or page), that will allow to
+		 * merge back to allocator when buddy will be freed.
+		 * Corresponding page table entries will not be touched,
+		 * pages will stay not present in virtual address space
+		 */
+		if (set_page_guard(zone, &page[size], high, migratetype))
 			continue;
-		} else if (!page || pageblock_aligned(pfn)) {
-			page = pfn_to_page(pfn);
-		} else {
-			page++;
-		}
-		__init_single_page(page, pfn, zid, nid);
-		nr_pages++;
+
+		add_to_free_list(&page[size], zone, high, migratetype);
+		set_buddy_order(&page[size], high);
 	}
-	return (nr_pages);
 }
 
-/*
- * This function is meant to pre-load the iterator for the zone init.
- * Specifically it walks through the ranges until we are caught up to the
- * first_init_pfn value and exits there. If we never encounter the value we
- * return false indicating there are no valid ranges left.
- */
-static bool __init
-deferred_init_mem_pfn_range_in_zone(u64 *i, struct zone *zone,
-				    unsigned long *spfn, unsigned long *epfn,
-				    unsigned long first_init_pfn)
+static void check_new_page_bad(struct page *page)
 {
-	u64 j;
-
-	/*
-	 * Start out by walking through the ranges in this zone that have
-	 * already been initialized. We don't need to do anything with them
-	 * so we just need to flush them out of the system.
-	 */
-	for_each_free_mem_pfn_range_in_zone(j, zone, spfn, epfn) {
-		if (*epfn <= first_init_pfn)
-			continue;
-		if (*spfn < first_init_pfn)
-			*spfn = first_init_pfn;
-		*i = j;
-		return true;
+	if (unlikely(page->flags & __PG_HWPOISON)) {
+		/* Don't complain about hwpoisoned pages */
+		page_mapcount_reset(page); /* remove PageBuddy */
+		return;
 	}
 
-	return false;
+	bad_page(page,
+		 page_bad_reason(page, PAGE_FLAGS_CHECK_AT_PREP));
 }
 
 /*
- * Initialize and free pages. We do it in two loops: first we initialize
- * struct page, then free to buddy allocator, because while we are
- * freeing pages we can access pages that are ahead (computing buddy
- * page in __free_one_page()).
- *
- * In order to try and keep some memory in the cache we have the loop
- * broken along max page order boundaries. This way we will not cause
- * any issues with the buddy page computation.
+ * This page is about to be returned from the page allocator
  */
-static unsigned long __init
-deferred_init_maxorder(u64 *i, struct zone *zone, unsigned long *start_pfn,
-		       unsigned long *end_pfn)
+static int check_new_page(struct page *page)
 {
-	unsigned long mo_pfn = ALIGN(*start_pfn + 1, MAX_ORDER_NR_PAGES);
-	unsigned long spfn = *start_pfn, epfn = *end_pfn;
-	unsigned long nr_pages = 0;
-	u64 j = *i;
-
-	/* First we loop through and initialize the page values */
-	for_each_free_mem_pfn_range_in_zone_from(j, zone, start_pfn, end_pfn) {
-		unsigned long t;
+	if (likely(page_expected_state(page,
+				PAGE_FLAGS_CHECK_AT_PREP|__PG_HWPOISON)))
+		return 0;
 
-		if (mo_pfn <= *start_pfn)
-			break;
+	check_new_page_bad(page);
+	return 1;
+}
 
-		t = min(mo_pfn, *end_pfn);
-		nr_pages += deferred_init_pages(zone, *start_pfn, t);
+static inline bool check_new_pages(struct page *page, unsigned int order)
+{
+	if (is_check_pages_enabled()) {
+		for (int i = 0; i < (1 << order); i++) {
+			struct page *p = page + i;
 
-		if (mo_pfn < *end_pfn) {
-			*start_pfn = mo_pfn;
-			break;
+			if (unlikely(check_new_page(p)))
+				return true;
 		}
 	}
 
-	/* Reset values and now loop through freeing pages as needed */
-	swap(j, *i);
-
-	for_each_free_mem_pfn_range_in_zone_from(j, zone, &spfn, &epfn) {
-		unsigned long t;
-
-		if (mo_pfn <= spfn)
-			break;
-
-		t = min(mo_pfn, epfn);
-		deferred_free_pages(spfn, t);
-
-		if (mo_pfn <= epfn)
-			break;
-	}
-
-	return nr_pages;
+	return false;
 }
 
-static void __init
-deferred_init_memmap_chunk(unsigned long start_pfn, unsigned long end_pfn,
-			   void *arg)
+static inline bool should_skip_kasan_unpoison(gfp_t flags)
 {
-	unsigned long spfn, epfn;
-	struct zone *zone = arg;
-	u64 i;
+	/* Don't skip if a software KASAN mode is enabled. */
+	if (IS_ENABLED(CONFIG_KASAN_GENERIC) ||
+	    IS_ENABLED(CONFIG_KASAN_SW_TAGS))
+		return false;
 
-	deferred_init_mem_pfn_range_in_zone(&i, zone, &spfn, &epfn, start_pfn);
+	/* Skip, if hardware tag-based KASAN is not enabled. */
+	if (!kasan_hw_tags_enabled())
+		return true;
 
 	/*
-	 * Initialize and free pages in MAX_ORDER sized increments so that we
-	 * can avoid introducing any issues with the buddy allocator.
+	 * With hardware tag-based KASAN enabled, skip if this has been
+	 * requested via __GFP_SKIP_KASAN.
 	 */
-	while (spfn < end_pfn) {
-		deferred_init_maxorder(&i, zone, &spfn, &epfn);
-		cond_resched();
-	}
+	return flags & __GFP_SKIP_KASAN;
 }
 
-/* An arch may override for more concurrency. */
-__weak int __init
-deferred_page_init_max_threads(const struct cpumask *node_cpumask)
+static inline bool should_skip_init(gfp_t flags)
 {
-	return 1;
+	/* Don't skip, if hardware tag-based KASAN is not enabled. */
+	if (!kasan_hw_tags_enabled())
+		return false;
+
+	/* For hardware tag-based KASAN, skip if requested. */
+	return (flags & __GFP_SKIP_ZERO);
 }
 
-/* Initialise remaining memory on a node */
-static int __init deferred_init_memmap(void *data)
+inline void post_alloc_hook(struct page *page, unsigned int order,
+				gfp_t gfp_flags)
 {
-	pg_data_t *pgdat = data;
-	const struct cpumask *cpumask = cpumask_of_node(pgdat->node_id);
-	unsigned long spfn = 0, epfn = 0;
-	unsigned long first_init_pfn, flags;
-	unsigned long start = jiffies;
-	struct zone *zone;
-	int zid, max_threads;
-	u64 i;
-
-	/* Bind memory initialisation thread to a local node if possible */
-	if (!cpumask_empty(cpumask))
-		set_cpus_allowed_ptr(current, cpumask);
-
-	pgdat_resize_lock(pgdat, &flags);
-	first_init_pfn = pgdat->first_deferred_pfn;
-	if (first_init_pfn == ULONG_MAX) {
-		pgdat_resize_unlock(pgdat, &flags);
-		pgdat_init_report_one_done();
-		return 0;
-	}
+	bool init = !want_init_on_free() && want_init_on_alloc(gfp_flags) &&
+			!should_skip_init(gfp_flags);
+	bool zero_tags = init && (gfp_flags & __GFP_ZEROTAGS);
+	int i;
+
+	set_page_private(page, 0);
+	set_page_refcounted(page);
 
-	/* Sanity check boundaries */
-	BUG_ON(pgdat->first_deferred_pfn < pgdat->node_start_pfn);
-	BUG_ON(pgdat->first_deferred_pfn > pgdat_end_pfn(pgdat));
-	pgdat->first_deferred_pfn = ULONG_MAX;
+	arch_alloc_page(page, order);
+	debug_pagealloc_map_pages(page, 1 << order);
 
 	/*
-	 * Once we unlock here, the zone cannot be grown anymore, thus if an
-	 * interrupt thread must allocate this early in boot, zone must be
-	 * pre-grown prior to start of deferred page initialization.
+	 * Page unpoisoning must happen before memory initialization.
+	 * Otherwise, the poison pattern will be overwritten for __GFP_ZERO
+	 * allocations and the page unpoisoning code will complain.
 	 */
-	pgdat_resize_unlock(pgdat, &flags);
-
-	/* Only the highest zone is deferred so find it */
-	for (zid = 0; zid < MAX_NR_ZONES; zid++) {
-		zone = pgdat->node_zones + zid;
-		if (first_init_pfn < zone_end_pfn(zone))
-			break;
-	}
-
-	/* If the zone is empty somebody else may have cleared out the zone */
-	if (!deferred_init_mem_pfn_range_in_zone(&i, zone, &spfn, &epfn,
-						 first_init_pfn))
-		goto zone_empty;
-
-	max_threads = deferred_page_init_max_threads(cpumask);
-
-	while (spfn < epfn) {
-		unsigned long epfn_align = ALIGN(epfn, PAGES_PER_SECTION);
-		struct padata_mt_job job = {
-			.thread_fn   = deferred_init_memmap_chunk,
-			.fn_arg      = zone,
-			.start       = spfn,
-			.size        = epfn_align - spfn,
-			.align       = PAGES_PER_SECTION,
-			.min_chunk   = PAGES_PER_SECTION,
-			.max_threads = max_threads,
-		};
-
-		padata_do_multithreaded(&job);
-		deferred_init_mem_pfn_range_in_zone(&i, zone, &spfn, &epfn,
-						    epfn_align);
-	}
-zone_empty:
-	/* Sanity check that the next zone really is unpopulated */
-	WARN_ON(++zid < MAX_NR_ZONES && populated_zone(++zone));
-
-	pr_info("node %d deferred pages initialised in %ums\n",
-		pgdat->node_id, jiffies_to_msecs(jiffies - start));
-
-	pgdat_init_report_one_done();
-	return 0;
-}
-
-/*
- * If this zone has deferred pages, try to grow it by initializing enough
- * deferred pages to satisfy the allocation specified by order, rounded up to
- * the nearest PAGES_PER_SECTION boundary.  So we're adding memory in increments
- * of SECTION_SIZE bytes by initializing struct pages in increments of
- * PAGES_PER_SECTION * sizeof(struct page) bytes.
- *
- * Return true when zone was grown, otherwise return false. We return true even
- * when we grow less than requested, to let the caller decide if there are
- * enough pages to satisfy the allocation.
- *
- * Note: We use noinline because this function is needed only during boot, and
- * it is called from a __ref function _deferred_grow_zone. This way we are
- * making sure that it is not inlined into permanent text section.
- */
-static noinline bool __init
-deferred_grow_zone(struct zone *zone, unsigned int order)
-{
-	unsigned long nr_pages_needed = ALIGN(1 << order, PAGES_PER_SECTION);
-	pg_data_t *pgdat = zone->zone_pgdat;
-	unsigned long first_deferred_pfn = pgdat->first_deferred_pfn;
-	unsigned long spfn, epfn, flags;
-	unsigned long nr_pages = 0;
-	u64 i;
-
-	/* Only the last zone may have deferred pages */
-	if (zone_end_pfn(zone) != pgdat_end_pfn(pgdat))
-		return false;
-
-	pgdat_resize_lock(pgdat, &flags);
-
-	/*
-	 * If someone grew this zone while we were waiting for spinlock, return
-	 * true, as there might be enough pages already.
-	 */
-	if (first_deferred_pfn != pgdat->first_deferred_pfn) {
-		pgdat_resize_unlock(pgdat, &flags);
-		return true;
-	}
-
-	/* If the zone is empty somebody else may have cleared out the zone */
-	if (!deferred_init_mem_pfn_range_in_zone(&i, zone, &spfn, &epfn,
-						 first_deferred_pfn)) {
-		pgdat->first_deferred_pfn = ULONG_MAX;
-		pgdat_resize_unlock(pgdat, &flags);
-		/* Retry only once. */
-		return first_deferred_pfn != ULONG_MAX;
-	}
-
-	/*
-	 * Initialize and free pages in MAX_ORDER sized increments so
-	 * that we can avoid introducing any issues with the buddy
-	 * allocator.
-	 */
-	while (spfn < epfn) {
-		/* update our first deferred PFN for this section */
-		first_deferred_pfn = spfn;
-
-		nr_pages += deferred_init_maxorder(&i, zone, &spfn, &epfn);
-		touch_nmi_watchdog();
-
-		/* We should only stop along section boundaries */
-		if ((first_deferred_pfn ^ spfn) < PAGES_PER_SECTION)
-			continue;
-
-		/* If our quota has been met we can stop here */
-		if (nr_pages >= nr_pages_needed)
-			break;
-	}
-
-	pgdat->first_deferred_pfn = spfn;
-	pgdat_resize_unlock(pgdat, &flags);
-
-	return nr_pages > 0;
-}
-
-/*
- * deferred_grow_zone() is __init, but it is called from
- * get_page_from_freelist() during early boot until deferred_pages permanently
- * disables this call. This is why we have refdata wrapper to avoid warning,
- * and to ensure that the function body gets unloaded.
- */
-static bool __ref
-_deferred_grow_zone(struct zone *zone, unsigned int order)
-{
-	return deferred_grow_zone(zone, order);
-}
-
-#endif /* CONFIG_DEFERRED_STRUCT_PAGE_INIT */
-
-void __init page_alloc_init_late(void)
-{
-	struct zone *zone;
-	int nid;
-
-#ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT
-
-	/* There will be num_node_state(N_MEMORY) threads */
-	atomic_set(&pgdat_init_n_undone, num_node_state(N_MEMORY));
-	for_each_node_state(nid, N_MEMORY) {
-		kthread_run(deferred_init_memmap, NODE_DATA(nid), "pgdatinit%d", nid);
-	}
-
-	/* Block until all are initialised */
-	wait_for_completion(&pgdat_init_all_done_comp);
-
-	/*
-	 * We initialized the rest of the deferred pages.  Permanently disable
-	 * on-demand struct page initialization.
-	 */
-	static_branch_disable(&deferred_pages);
-
-	/* Reinit limits that are based on free pages after the kernel is up */
-	files_maxfiles_init();
-#endif
-
-	buffer_init();
-
-	/* Discard memblock private memory */
-	memblock_discard();
-
-	for_each_node_state(nid, N_MEMORY)
-		shuffle_free_memory(NODE_DATA(nid));
-
-	for_each_populated_zone(zone)
-		set_zone_contiguous(zone);
-}
-
-#ifdef CONFIG_CMA
-/* Free whole pageblock and set its migration type to MIGRATE_CMA. */
-void __init init_cma_reserved_pageblock(struct page *page)
-{
-	unsigned i = pageblock_nr_pages;
-	struct page *p = page;
-
-	do {
-		__ClearPageReserved(p);
-		set_page_count(p, 0);
-	} while (++p, --i);
-
-	set_pageblock_migratetype(page, MIGRATE_CMA);
-	set_page_refcounted(page);
-	__free_pages(page, pageblock_order);
-
-	adjust_managed_page_count(page, pageblock_nr_pages);
-	page_zone(page)->cma_pages += pageblock_nr_pages;
-}
-#endif
-
-/*
- * The order of subdivision here is critical for the IO subsystem.
- * Please do not alter this order without good reasons and regression
- * testing. Specifically, as large blocks of memory are subdivided,
- * the order in which smaller blocks are delivered depends on the order
- * they're subdivided in this function. This is the primary factor
- * influencing the order in which pages are delivered to the IO
- * subsystem according to empirical testing, and this is also justified
- * by considering the behavior of a buddy system containing a single
- * large block of memory acted on by a series of small allocations.
- * This behavior is a critical factor in sglist merging's success.
- *
- * -- nyc
- */
-static inline void expand(struct zone *zone, struct page *page,
-	int low, int high, int migratetype)
-{
-	unsigned long size = 1 << high;
-
-	while (high > low) {
-		high--;
-		size >>= 1;
-		VM_BUG_ON_PAGE(bad_range(zone, &page[size]), &page[size]);
-
-		/*
-		 * Mark as guard pages (or page), that will allow to
-		 * merge back to allocator when buddy will be freed.
-		 * Corresponding page table entries will not be touched,
-		 * pages will stay not present in virtual address space
-		 */
-		if (set_page_guard(zone, &page[size], high, migratetype))
-			continue;
-
-		add_to_free_list(&page[size], zone, high, migratetype);
-		set_buddy_order(&page[size], high);
-	}
-}
-
-static void check_new_page_bad(struct page *page)
-{
-	if (unlikely(page->flags & __PG_HWPOISON)) {
-		/* Don't complain about hwpoisoned pages */
-		page_mapcount_reset(page); /* remove PageBuddy */
-		return;
-	}
-
-	bad_page(page,
-		 page_bad_reason(page, PAGE_FLAGS_CHECK_AT_PREP));
-}
-
-/*
- * This page is about to be returned from the page allocator
- */
-static int check_new_page(struct page *page)
-{
-	if (likely(page_expected_state(page,
-				PAGE_FLAGS_CHECK_AT_PREP|__PG_HWPOISON)))
-		return 0;
-
-	check_new_page_bad(page);
-	return 1;
-}
-
-static inline bool check_new_pages(struct page *page, unsigned int order)
-{
-	if (is_check_pages_enabled()) {
-		for (int i = 0; i < (1 << order); i++) {
-			struct page *p = page + i;
-
-			if (unlikely(check_new_page(p)))
-				return true;
-		}
-	}
-
-	return false;
-}
-
-static inline bool should_skip_kasan_unpoison(gfp_t flags)
-{
-	/* Don't skip if a software KASAN mode is enabled. */
-	if (IS_ENABLED(CONFIG_KASAN_GENERIC) ||
-	    IS_ENABLED(CONFIG_KASAN_SW_TAGS))
-		return false;
-
-	/* Skip, if hardware tag-based KASAN is not enabled. */
-	if (!kasan_hw_tags_enabled())
-		return true;
-
-	/*
-	 * With hardware tag-based KASAN enabled, skip if this has been
-	 * requested via __GFP_SKIP_KASAN.
-	 */
-	return flags & __GFP_SKIP_KASAN;
-}
-
-static inline bool should_skip_init(gfp_t flags)
-{
-	/* Don't skip, if hardware tag-based KASAN is not enabled. */
-	if (!kasan_hw_tags_enabled())
-		return false;
-
-	/* For hardware tag-based KASAN, skip if requested. */
-	return (flags & __GFP_SKIP_ZERO);
-}
-
-inline void post_alloc_hook(struct page *page, unsigned int order,
-				gfp_t gfp_flags)
-{
-	bool init = !want_init_on_free() && want_init_on_alloc(gfp_flags) &&
-			!should_skip_init(gfp_flags);
-	bool zero_tags = init && (gfp_flags & __GFP_ZEROTAGS);
-	int i;
-
-	set_page_private(page, 0);
-	set_page_refcounted(page);
-
-	arch_alloc_page(page, order);
-	debug_pagealloc_map_pages(page, 1 << order);
-
-	/*
-	 * Page unpoisoning must happen before memory initialization.
-	 * Otherwise, the poison pattern will be overwritten for __GFP_ZERO
-	 * allocations and the page unpoisoning code will complain.
-	 */
-	kernel_unpoison_pages(page, 1 << order);
+	kernel_unpoison_pages(page, 1 << order);
 
 	/*
 	 * As memory initialization might be integrated into KASAN,
@@ -6540,7 +5880,6 @@ static void per_cpu_pages_init(struct per_cpu_pages *pcp, struct per_cpu_zonesta
 #define BOOT_PAGESET_BATCH	1
 static DEFINE_PER_CPU(struct per_cpu_pages, boot_pageset);
 static DEFINE_PER_CPU(struct per_cpu_zonestat, boot_zonestats);
-static DEFINE_PER_CPU(struct per_cpu_nodestat, boot_nodestats);
 
 static void __build_all_zonelists(void *data)
 {
@@ -6654,395 +5993,35 @@ void __ref build_all_zonelists(pg_data_t *pgdat)
 #endif
 }
 
-/* If zone is ZONE_MOVABLE but memory is mirrored, it is an overlapped init */
-static bool __meminit
-overlap_memmap_init(unsigned long zone, unsigned long *pfn)
-{
-	static struct memblock_region *r;
-
-	if (mirrored_kernelcore && zone == ZONE_MOVABLE) {
-		if (!r || *pfn >= memblock_region_memory_end_pfn(r)) {
-			for_each_mem_region(r) {
-				if (*pfn < memblock_region_memory_end_pfn(r))
-					break;
-			}
-		}
-		if (*pfn >= memblock_region_memory_base_pfn(r) &&
-		    memblock_is_mirror(r)) {
-			*pfn = memblock_region_memory_end_pfn(r);
-			return true;
-		}
-	}
-	return false;
-}
-
-/*
- * Initially all pages are reserved - free ones are freed
- * up by memblock_free_all() once the early boot process is
- * done. Non-atomic initialization, single-pass.
- *
- * All aligned pageblocks are initialized to the specified migratetype
- * (usually MIGRATE_MOVABLE). Besides setting the migratetype, no related
- * zone stats (e.g., nr_isolate_pageblock) are touched.
- */
-void __meminit memmap_init_range(unsigned long size, int nid, unsigned long zone,
-		unsigned long start_pfn, unsigned long zone_end_pfn,
-		enum meminit_context context,
-		struct vmem_altmap *altmap, int migratetype)
+static int zone_batchsize(struct zone *zone)
 {
-	unsigned long pfn, end_pfn = start_pfn + size;
-	struct page *page;
+#ifdef CONFIG_MMU
+	int batch;
 
-	if (highest_memmap_pfn < end_pfn - 1)
-		highest_memmap_pfn = end_pfn - 1;
+	/*
+	 * The number of pages to batch allocate is either ~0.1%
+	 * of the zone or 1MB, whichever is smaller. The batch
+	 * size is striking a balance between allocation latency
+	 * and zone lock contention.
+	 */
+	batch = min(zone_managed_pages(zone) >> 10, SZ_1M / PAGE_SIZE);
+	batch /= 4;		/* We effectively *= 4 below */
+	if (batch < 1)
+		batch = 1;
 
-#ifdef CONFIG_ZONE_DEVICE
 	/*
-	 * Honor reservation requested by the driver for this ZONE_DEVICE
-	 * memory. We limit the total number of pages to initialize to just
-	 * those that might contain the memory mapping. We will defer the
-	 * ZONE_DEVICE page initialization until after we have released
-	 * the hotplug lock.
+	 * Clamp the batch to a 2^n - 1 value. Having a power
+	 * of 2 value was found to be more likely to have
+	 * suboptimal cache aliasing properties in some cases.
+	 *
+	 * For example if 2 tasks are alternately allocating
+	 * batches of pages, one task can end up with a lot
+	 * of pages of one half of the possible page colors
+	 * and the other with pages of the other colors.
 	 */
-	if (zone == ZONE_DEVICE) {
-		if (!altmap)
-			return;
+	batch = rounddown_pow_of_two(batch + batch/2) - 1;
 
-		if (start_pfn == altmap->base_pfn)
-			start_pfn += altmap->reserve;
-		end_pfn = altmap->base_pfn + vmem_altmap_offset(altmap);
-	}
-#endif
-
-	for (pfn = start_pfn; pfn < end_pfn; ) {
-		/*
-		 * There can be holes in boot-time mem_map[]s handed to this
-		 * function.  They do not exist on hotplugged memory.
-		 */
-		if (context == MEMINIT_EARLY) {
-			if (overlap_memmap_init(zone, &pfn))
-				continue;
-			if (defer_init(nid, pfn, zone_end_pfn)) {
-				deferred_struct_pages = true;
-				break;
-			}
-		}
-
-		page = pfn_to_page(pfn);
-		__init_single_page(page, pfn, zone, nid);
-		if (context == MEMINIT_HOTPLUG)
-			__SetPageReserved(page);
-
-		/*
-		 * Usually, we want to mark the pageblock MIGRATE_MOVABLE,
-		 * such that unmovable allocations won't be scattered all
-		 * over the place during system boot.
-		 */
-		if (pageblock_aligned(pfn)) {
-			set_pageblock_migratetype(page, migratetype);
-			cond_resched();
-		}
-		pfn++;
-	}
-}
-
-#ifdef CONFIG_ZONE_DEVICE
-static void __ref __init_zone_device_page(struct page *page, unsigned long pfn,
-					  unsigned long zone_idx, int nid,
-					  struct dev_pagemap *pgmap)
-{
-
-	__init_single_page(page, pfn, zone_idx, nid);
-
-	/*
-	 * Mark page reserved as it will need to wait for onlining
-	 * phase for it to be fully associated with a zone.
-	 *
-	 * We can use the non-atomic __set_bit operation for setting
-	 * the flag as we are still initializing the pages.
-	 */
-	__SetPageReserved(page);
-
-	/*
-	 * ZONE_DEVICE pages union ->lru with a ->pgmap back pointer
-	 * and zone_device_data.  It is a bug if a ZONE_DEVICE page is
-	 * ever freed or placed on a driver-private list.
-	 */
-	page->pgmap = pgmap;
-	page->zone_device_data = NULL;
-
-	/*
-	 * Mark the block movable so that blocks are reserved for
-	 * movable at startup. This will force kernel allocations
-	 * to reserve their blocks rather than leaking throughout
-	 * the address space during boot when many long-lived
-	 * kernel allocations are made.
-	 *
-	 * Please note that MEMINIT_HOTPLUG path doesn't clear memmap
-	 * because this is done early in section_activate()
-	 */
-	if (pageblock_aligned(pfn)) {
-		set_pageblock_migratetype(page, MIGRATE_MOVABLE);
-		cond_resched();
-	}
-
-	/*
-	 * ZONE_DEVICE pages are released directly to the driver page allocator
-	 * which will set the page count to 1 when allocating the page.
-	 */
-	if (pgmap->type == MEMORY_DEVICE_PRIVATE ||
-	    pgmap->type == MEMORY_DEVICE_COHERENT)
-		set_page_count(page, 0);
-}
-
-/*
- * With compound page geometry and when struct pages are stored in ram most
- * tail pages are reused. Consequently, the amount of unique struct pages to
- * initialize is a lot smaller that the total amount of struct pages being
- * mapped. This is a paired / mild layering violation with explicit knowledge
- * of how the sparse_vmemmap internals handle compound pages in the lack
- * of an altmap. See vmemmap_populate_compound_pages().
- */
-static inline unsigned long compound_nr_pages(struct vmem_altmap *altmap,
-					      unsigned long nr_pages)
-{
-	return is_power_of_2(sizeof(struct page)) &&
-		!altmap ? 2 * (PAGE_SIZE / sizeof(struct page)) : nr_pages;
-}
-
-static void __ref memmap_init_compound(struct page *head,
-				       unsigned long head_pfn,
-				       unsigned long zone_idx, int nid,
-				       struct dev_pagemap *pgmap,
-				       unsigned long nr_pages)
-{
-	unsigned long pfn, end_pfn = head_pfn + nr_pages;
-	unsigned int order = pgmap->vmemmap_shift;
-
-	__SetPageHead(head);
-	for (pfn = head_pfn + 1; pfn < end_pfn; pfn++) {
-		struct page *page = pfn_to_page(pfn);
-
-		__init_zone_device_page(page, pfn, zone_idx, nid, pgmap);
-		prep_compound_tail(head, pfn - head_pfn);
-		set_page_count(page, 0);
-
-		/*
-		 * The first tail page stores important compound page info.
-		 * Call prep_compound_head() after the first tail page has
-		 * been initialized, to not have the data overwritten.
-		 */
-		if (pfn == head_pfn + 1)
-			prep_compound_head(head, order);
-	}
-}
-
-void __ref memmap_init_zone_device(struct zone *zone,
-				   unsigned long start_pfn,
-				   unsigned long nr_pages,
-				   struct dev_pagemap *pgmap)
-{
-	unsigned long pfn, end_pfn = start_pfn + nr_pages;
-	struct pglist_data *pgdat = zone->zone_pgdat;
-	struct vmem_altmap *altmap = pgmap_altmap(pgmap);
-	unsigned int pfns_per_compound = pgmap_vmemmap_nr(pgmap);
-	unsigned long zone_idx = zone_idx(zone);
-	unsigned long start = jiffies;
-	int nid = pgdat->node_id;
-
-	if (WARN_ON_ONCE(!pgmap || zone_idx != ZONE_DEVICE))
-		return;
-
-	/*
-	 * The call to memmap_init should have already taken care
-	 * of the pages reserved for the memmap, so we can just jump to
-	 * the end of that region and start processing the device pages.
-	 */
-	if (altmap) {
-		start_pfn = altmap->base_pfn + vmem_altmap_offset(altmap);
-		nr_pages = end_pfn - start_pfn;
-	}
-
-	for (pfn = start_pfn; pfn < end_pfn; pfn += pfns_per_compound) {
-		struct page *page = pfn_to_page(pfn);
-
-		__init_zone_device_page(page, pfn, zone_idx, nid, pgmap);
-
-		if (pfns_per_compound == 1)
-			continue;
-
-		memmap_init_compound(page, pfn, zone_idx, nid, pgmap,
-				     compound_nr_pages(altmap, pfns_per_compound));
-	}
-
-	pr_info("%s initialised %lu pages in %ums\n", __func__,
-		nr_pages, jiffies_to_msecs(jiffies - start));
-}
-
-#endif
-static void __meminit zone_init_free_lists(struct zone *zone)
-{
-	unsigned int order, t;
-	for_each_migratetype_order(order, t) {
-		INIT_LIST_HEAD(&zone->free_area[order].free_list[t]);
-		zone->free_area[order].nr_free = 0;
-	}
-}
-
-/*
- * Only struct pages that correspond to ranges defined by memblock.memory
- * are zeroed and initialized by going through __init_single_page() during
- * memmap_init_zone_range().
- *
- * But, there could be struct pages that correspond to holes in
- * memblock.memory. This can happen because of the following reasons:
- * - physical memory bank size is not necessarily the exact multiple of the
- *   arbitrary section size
- * - early reserved memory may not be listed in memblock.memory
- * - memory layouts defined with memmap= kernel parameter may not align
- *   nicely with memmap sections
- *
- * Explicitly initialize those struct pages so that:
- * - PG_Reserved is set
- * - zone and node links point to zone and node that span the page if the
- *   hole is in the middle of a zone
- * - zone and node links point to adjacent zone/node if the hole falls on
- *   the zone boundary; the pages in such holes will be prepended to the
- *   zone/node above the hole except for the trailing pages in the last
- *   section that will be appended to the zone/node below.
- */
-static void __init init_unavailable_range(unsigned long spfn,
-					  unsigned long epfn,
-					  int zone, int node)
-{
-	unsigned long pfn;
-	u64 pgcnt = 0;
-
-	for (pfn = spfn; pfn < epfn; pfn++) {
-		if (!pfn_valid(pageblock_start_pfn(pfn))) {
-			pfn = pageblock_end_pfn(pfn) - 1;
-			continue;
-		}
-		__init_single_page(pfn_to_page(pfn), pfn, zone, node);
-		__SetPageReserved(pfn_to_page(pfn));
-		pgcnt++;
-	}
-
-	if (pgcnt)
-		pr_info("On node %d, zone %s: %lld pages in unavailable ranges",
-			node, zone_names[zone], pgcnt);
-}
-
-static void __init memmap_init_zone_range(struct zone *zone,
-					  unsigned long start_pfn,
-					  unsigned long end_pfn,
-					  unsigned long *hole_pfn)
-{
-	unsigned long zone_start_pfn = zone->zone_start_pfn;
-	unsigned long zone_end_pfn = zone_start_pfn + zone->spanned_pages;
-	int nid = zone_to_nid(zone), zone_id = zone_idx(zone);
-
-	start_pfn = clamp(start_pfn, zone_start_pfn, zone_end_pfn);
-	end_pfn = clamp(end_pfn, zone_start_pfn, zone_end_pfn);
-
-	if (start_pfn >= end_pfn)
-		return;
-
-	memmap_init_range(end_pfn - start_pfn, nid, zone_id, start_pfn,
-			  zone_end_pfn, MEMINIT_EARLY, NULL, MIGRATE_MOVABLE);
-
-	if (*hole_pfn < start_pfn)
-		init_unavailable_range(*hole_pfn, start_pfn, zone_id, nid);
-
-	*hole_pfn = end_pfn;
-}
-
-static void __init memmap_init(void)
-{
-	unsigned long start_pfn, end_pfn;
-	unsigned long hole_pfn = 0;
-	int i, j, zone_id = 0, nid;
-
-	for_each_mem_pfn_range(i, MAX_NUMNODES, &start_pfn, &end_pfn, &nid) {
-		struct pglist_data *node = NODE_DATA(nid);
-
-		for (j = 0; j < MAX_NR_ZONES; j++) {
-			struct zone *zone = node->node_zones + j;
-
-			if (!populated_zone(zone))
-				continue;
-
-			memmap_init_zone_range(zone, start_pfn, end_pfn,
-					       &hole_pfn);
-			zone_id = j;
-		}
-	}
-
-#ifdef CONFIG_SPARSEMEM
-	/*
-	 * Initialize the memory map for hole in the range [memory_end,
-	 * section_end].
-	 * Append the pages in this hole to the highest zone in the last
-	 * node.
-	 * The call to init_unavailable_range() is outside the ifdef to
-	 * silence the compiler warining about zone_id set but not used;
-	 * for FLATMEM it is a nop anyway
-	 */
-	end_pfn = round_up(end_pfn, PAGES_PER_SECTION);
-	if (hole_pfn < end_pfn)
-#endif
-		init_unavailable_range(hole_pfn, end_pfn, zone_id, nid);
-}
-
-void __init *memmap_alloc(phys_addr_t size, phys_addr_t align,
-			  phys_addr_t min_addr, int nid, bool exact_nid)
-{
-	void *ptr;
-
-	if (exact_nid)
-		ptr = memblock_alloc_exact_nid_raw(size, align, min_addr,
-						   MEMBLOCK_ALLOC_ACCESSIBLE,
-						   nid);
-	else
-		ptr = memblock_alloc_try_nid_raw(size, align, min_addr,
-						 MEMBLOCK_ALLOC_ACCESSIBLE,
-						 nid);
-
-	if (ptr && size > 0)
-		page_init_poison(ptr, size);
-
-	return ptr;
-}
-
-static int zone_batchsize(struct zone *zone)
-{
-#ifdef CONFIG_MMU
-	int batch;
-
-	/*
-	 * The number of pages to batch allocate is either ~0.1%
-	 * of the zone or 1MB, whichever is smaller. The batch
-	 * size is striking a balance between allocation latency
-	 * and zone lock contention.
-	 */
-	batch = min(zone_managed_pages(zone) >> 10, SZ_1M / PAGE_SIZE);
-	batch /= 4;		/* We effectively *= 4 below */
-	if (batch < 1)
-		batch = 1;
-
-	/*
-	 * Clamp the batch to a 2^n - 1 value. Having a power
-	 * of 2 value was found to be more likely to have
-	 * suboptimal cache aliasing properties in some cases.
-	 *
-	 * For example if 2 tasks are alternately allocating
-	 * batches of pages, one task can end up with a lot
-	 * of pages of one half of the possible page colors
-	 * and the other with pages of the other colors.
-	 */
-	batch = rounddown_pow_of_two(batch + batch/2) - 1;
-
-	return batch;
+	return batch;
 
 #else
 	/* The deferral and batching of frees should be suppressed under NOMMU
@@ -7064,1352 +6043,210 @@ static int zone_batchsize(struct zone *zone)
 
 static int zone_highsize(struct zone *zone, int batch, int cpu_online)
 {
-#ifdef CONFIG_MMU
-	int high;
-	int nr_split_cpus;
-	unsigned long total_pages;
-
-	if (!percpu_pagelist_high_fraction) {
-		/*
-		 * By default, the high value of the pcp is based on the zone
-		 * low watermark so that if they are full then background
-		 * reclaim will not be started prematurely.
-		 */
-		total_pages = low_wmark_pages(zone);
-	} else {
-		/*
-		 * If percpu_pagelist_high_fraction is configured, the high
-		 * value is based on a fraction of the managed pages in the
-		 * zone.
-		 */
-		total_pages = zone_managed_pages(zone) / percpu_pagelist_high_fraction;
-	}
-
-	/*
-	 * Split the high value across all online CPUs local to the zone. Note
-	 * that early in boot that CPUs may not be online yet and that during
-	 * CPU hotplug that the cpumask is not yet updated when a CPU is being
-	 * onlined. For memory nodes that have no CPUs, split pcp->high across
-	 * all online CPUs to mitigate the risk that reclaim is triggered
-	 * prematurely due to pages stored on pcp lists.
-	 */
-	nr_split_cpus = cpumask_weight(cpumask_of_node(zone_to_nid(zone))) + cpu_online;
-	if (!nr_split_cpus)
-		nr_split_cpus = num_online_cpus();
-	high = total_pages / nr_split_cpus;
-
-	/*
-	 * Ensure high is at least batch*4. The multiple is based on the
-	 * historical relationship between high and batch.
-	 */
-	high = max(high, batch << 2);
-
-	return high;
-#else
-	return 0;
-#endif
-}
-
-/*
- * pcp->high and pcp->batch values are related and generally batch is lower
- * than high. They are also related to pcp->count such that count is lower
- * than high, and as soon as it reaches high, the pcplist is flushed.
- *
- * However, guaranteeing these relations at all times would require e.g. write
- * barriers here but also careful usage of read barriers at the read side, and
- * thus be prone to error and bad for performance. Thus the update only prevents
- * store tearing. Any new users of pcp->batch and pcp->high should ensure they
- * can cope with those fields changing asynchronously, and fully trust only the
- * pcp->count field on the local CPU with interrupts disabled.
- *
- * mutex_is_locked(&pcp_batch_high_lock) required when calling this function
- * outside of boot time (or some other assurance that no concurrent updaters
- * exist).
- */
-static void pageset_update(struct per_cpu_pages *pcp, unsigned long high,
-		unsigned long batch)
-{
-	WRITE_ONCE(pcp->batch, batch);
-	WRITE_ONCE(pcp->high, high);
-}
-
-static void per_cpu_pages_init(struct per_cpu_pages *pcp, struct per_cpu_zonestat *pzstats)
-{
-	int pindex;
-
-	memset(pcp, 0, sizeof(*pcp));
-	memset(pzstats, 0, sizeof(*pzstats));
-
-	spin_lock_init(&pcp->lock);
-	for (pindex = 0; pindex < NR_PCP_LISTS; pindex++)
-		INIT_LIST_HEAD(&pcp->lists[pindex]);
-
-	/*
-	 * Set batch and high values safe for a boot pageset. A true percpu
-	 * pageset's initialization will update them subsequently. Here we don't
-	 * need to be as careful as pageset_update() as nobody can access the
-	 * pageset yet.
-	 */
-	pcp->high = BOOT_PAGESET_HIGH;
-	pcp->batch = BOOT_PAGESET_BATCH;
-	pcp->free_factor = 0;
-}
-
-static void __zone_set_pageset_high_and_batch(struct zone *zone, unsigned long high,
-		unsigned long batch)
-{
-	struct per_cpu_pages *pcp;
-	int cpu;
-
-	for_each_possible_cpu(cpu) {
-		pcp = per_cpu_ptr(zone->per_cpu_pageset, cpu);
-		pageset_update(pcp, high, batch);
-	}
-}
-
-/*
- * Calculate and set new high and batch values for all per-cpu pagesets of a
- * zone based on the zone's size.
- */
-static void zone_set_pageset_high_and_batch(struct zone *zone, int cpu_online)
-{
-	int new_high, new_batch;
-
-	new_batch = max(1, zone_batchsize(zone));
-	new_high = zone_highsize(zone, new_batch, cpu_online);
-
-	if (zone->pageset_high == new_high &&
-	    zone->pageset_batch == new_batch)
-		return;
-
-	zone->pageset_high = new_high;
-	zone->pageset_batch = new_batch;
-
-	__zone_set_pageset_high_and_batch(zone, new_high, new_batch);
-}
-
-void __meminit setup_zone_pageset(struct zone *zone)
-{
-	int cpu;
-
-	/* Size may be 0 on !SMP && !NUMA */
-	if (sizeof(struct per_cpu_zonestat) > 0)
-		zone->per_cpu_zonestats = alloc_percpu(struct per_cpu_zonestat);
-
-	zone->per_cpu_pageset = alloc_percpu(struct per_cpu_pages);
-	for_each_possible_cpu(cpu) {
-		struct per_cpu_pages *pcp;
-		struct per_cpu_zonestat *pzstats;
-
-		pcp = per_cpu_ptr(zone->per_cpu_pageset, cpu);
-		pzstats = per_cpu_ptr(zone->per_cpu_zonestats, cpu);
-		per_cpu_pages_init(pcp, pzstats);
-	}
-
-	zone_set_pageset_high_and_batch(zone, 0);
-}
-
-/*
- * The zone indicated has a new number of managed_pages; batch sizes and percpu
- * page high values need to be recalculated.
- */
-static void zone_pcp_update(struct zone *zone, int cpu_online)
-{
-	mutex_lock(&pcp_batch_high_lock);
-	zone_set_pageset_high_and_batch(zone, cpu_online);
-	mutex_unlock(&pcp_batch_high_lock);
-}
-
-/*
- * Allocate per cpu pagesets and initialize them.
- * Before this call only boot pagesets were available.
- */
-void __init setup_per_cpu_pageset(void)
-{
-	struct pglist_data *pgdat;
-	struct zone *zone;
-	int __maybe_unused cpu;
-
-	for_each_populated_zone(zone)
-		setup_zone_pageset(zone);
-
-#ifdef CONFIG_NUMA
-	/*
-	 * Unpopulated zones continue using the boot pagesets.
-	 * The numa stats for these pagesets need to be reset.
-	 * Otherwise, they will end up skewing the stats of
-	 * the nodes these zones are associated with.
-	 */
-	for_each_possible_cpu(cpu) {
-		struct per_cpu_zonestat *pzstats = &per_cpu(boot_zonestats, cpu);
-		memset(pzstats->vm_numa_event, 0,
-		       sizeof(pzstats->vm_numa_event));
-	}
-#endif
-
-	for_each_online_pgdat(pgdat)
-		pgdat->per_cpu_nodestats =
-			alloc_percpu(struct per_cpu_nodestat);
-}
-
-static __meminit void zone_pcp_init(struct zone *zone)
-{
-	/*
-	 * per cpu subsystem is not up at this point. The following code
-	 * relies on the ability of the linker to provide the
-	 * offset of a (static) per cpu variable into the per cpu area.
-	 */
-	zone->per_cpu_pageset = &boot_pageset;
-	zone->per_cpu_zonestats = &boot_zonestats;
-	zone->pageset_high = BOOT_PAGESET_HIGH;
-	zone->pageset_batch = BOOT_PAGESET_BATCH;
-
-	if (populated_zone(zone))
-		pr_debug("  %s zone: %lu pages, LIFO batch:%u\n", zone->name,
-			 zone->present_pages, zone_batchsize(zone));
-}
-
-void __meminit init_currently_empty_zone(struct zone *zone,
-					unsigned long zone_start_pfn,
-					unsigned long size)
-{
-	struct pglist_data *pgdat = zone->zone_pgdat;
-	int zone_idx = zone_idx(zone) + 1;
-
-	if (zone_idx > pgdat->nr_zones)
-		pgdat->nr_zones = zone_idx;
-
-	zone->zone_start_pfn = zone_start_pfn;
-
-	mminit_dprintk(MMINIT_TRACE, "memmap_init",
-			"Initialising map node %d zone %lu pfns %lu -> %lu\n",
-			pgdat->node_id,
-			(unsigned long)zone_idx(zone),
-			zone_start_pfn, (zone_start_pfn + size));
-
-	zone_init_free_lists(zone);
-	zone->initialized = 1;
-}
-
-/**
- * get_pfn_range_for_nid - Return the start and end page frames for a node
- * @nid: The nid to return the range for. If MAX_NUMNODES, the min and max PFN are returned.
- * @start_pfn: Passed by reference. On return, it will have the node start_pfn.
- * @end_pfn: Passed by reference. On return, it will have the node end_pfn.
- *
- * It returns the start and end page frame of a node based on information
- * provided by memblock_set_node(). If called for a node
- * with no available memory, a warning is printed and the start and end
- * PFNs will be 0.
- */
-void __init get_pfn_range_for_nid(unsigned int nid,
-			unsigned long *start_pfn, unsigned long *end_pfn)
-{
-	unsigned long this_start_pfn, this_end_pfn;
-	int i;
-
-	*start_pfn = -1UL;
-	*end_pfn = 0;
-
-	for_each_mem_pfn_range(i, nid, &this_start_pfn, &this_end_pfn, NULL) {
-		*start_pfn = min(*start_pfn, this_start_pfn);
-		*end_pfn = max(*end_pfn, this_end_pfn);
-	}
-
-	if (*start_pfn == -1UL)
-		*start_pfn = 0;
-}
-
-/*
- * This finds a zone that can be used for ZONE_MOVABLE pages. The
- * assumption is made that zones within a node are ordered in monotonic
- * increasing memory addresses so that the "highest" populated zone is used
- */
-static void __init find_usable_zone_for_movable(void)
-{
-	int zone_index;
-	for (zone_index = MAX_NR_ZONES - 1; zone_index >= 0; zone_index--) {
-		if (zone_index == ZONE_MOVABLE)
-			continue;
-
-		if (arch_zone_highest_possible_pfn[zone_index] >
-				arch_zone_lowest_possible_pfn[zone_index])
-			break;
-	}
-
-	VM_BUG_ON(zone_index == -1);
-	movable_zone = zone_index;
-}
-
-/*
- * The zone ranges provided by the architecture do not include ZONE_MOVABLE
- * because it is sized independent of architecture. Unlike the other zones,
- * the starting point for ZONE_MOVABLE is not fixed. It may be different
- * in each node depending on the size of each node and how evenly kernelcore
- * is distributed. This helper function adjusts the zone ranges
- * provided by the architecture for a given node by using the end of the
- * highest usable zone for ZONE_MOVABLE. This preserves the assumption that
- * zones within a node are in order of monotonic increases memory addresses
- */
-static void __init adjust_zone_range_for_zone_movable(int nid,
-					unsigned long zone_type,
-					unsigned long node_start_pfn,
-					unsigned long node_end_pfn,
-					unsigned long *zone_start_pfn,
-					unsigned long *zone_end_pfn)
-{
-	/* Only adjust if ZONE_MOVABLE is on this node */
-	if (zone_movable_pfn[nid]) {
-		/* Size ZONE_MOVABLE */
-		if (zone_type == ZONE_MOVABLE) {
-			*zone_start_pfn = zone_movable_pfn[nid];
-			*zone_end_pfn = min(node_end_pfn,
-				arch_zone_highest_possible_pfn[movable_zone]);
-
-		/* Adjust for ZONE_MOVABLE starting within this range */
-		} else if (!mirrored_kernelcore &&
-			*zone_start_pfn < zone_movable_pfn[nid] &&
-			*zone_end_pfn > zone_movable_pfn[nid]) {
-			*zone_end_pfn = zone_movable_pfn[nid];
-
-		/* Check if this whole range is within ZONE_MOVABLE */
-		} else if (*zone_start_pfn >= zone_movable_pfn[nid])
-			*zone_start_pfn = *zone_end_pfn;
-	}
-}
-
-/*
- * Return the number of pages a zone spans in a node, including holes
- * present_pages = zone_spanned_pages_in_node() - zone_absent_pages_in_node()
- */
-static unsigned long __init zone_spanned_pages_in_node(int nid,
-					unsigned long zone_type,
-					unsigned long node_start_pfn,
-					unsigned long node_end_pfn,
-					unsigned long *zone_start_pfn,
-					unsigned long *zone_end_pfn)
-{
-	unsigned long zone_low = arch_zone_lowest_possible_pfn[zone_type];
-	unsigned long zone_high = arch_zone_highest_possible_pfn[zone_type];
-	/* When hotadd a new node from cpu_up(), the node should be empty */
-	if (!node_start_pfn && !node_end_pfn)
-		return 0;
-
-	/* Get the start and end of the zone */
-	*zone_start_pfn = clamp(node_start_pfn, zone_low, zone_high);
-	*zone_end_pfn = clamp(node_end_pfn, zone_low, zone_high);
-	adjust_zone_range_for_zone_movable(nid, zone_type,
-				node_start_pfn, node_end_pfn,
-				zone_start_pfn, zone_end_pfn);
-
-	/* Check that this node has pages within the zone's required range */
-	if (*zone_end_pfn < node_start_pfn || *zone_start_pfn > node_end_pfn)
-		return 0;
-
-	/* Move the zone boundaries inside the node if necessary */
-	*zone_end_pfn = min(*zone_end_pfn, node_end_pfn);
-	*zone_start_pfn = max(*zone_start_pfn, node_start_pfn);
-
-	/* Return the spanned pages */
-	return *zone_end_pfn - *zone_start_pfn;
-}
-
-/*
- * Return the number of holes in a range on a node. If nid is MAX_NUMNODES,
- * then all holes in the requested range will be accounted for.
- */
-unsigned long __init __absent_pages_in_range(int nid,
-				unsigned long range_start_pfn,
-				unsigned long range_end_pfn)
-{
-	unsigned long nr_absent = range_end_pfn - range_start_pfn;
-	unsigned long start_pfn, end_pfn;
-	int i;
-
-	for_each_mem_pfn_range(i, nid, &start_pfn, &end_pfn, NULL) {
-		start_pfn = clamp(start_pfn, range_start_pfn, range_end_pfn);
-		end_pfn = clamp(end_pfn, range_start_pfn, range_end_pfn);
-		nr_absent -= end_pfn - start_pfn;
-	}
-	return nr_absent;
-}
-
-/**
- * absent_pages_in_range - Return number of page frames in holes within a range
- * @start_pfn: The start PFN to start searching for holes
- * @end_pfn: The end PFN to stop searching for holes
- *
- * Return: the number of pages frames in memory holes within a range.
- */
-unsigned long __init absent_pages_in_range(unsigned long start_pfn,
-							unsigned long end_pfn)
-{
-	return __absent_pages_in_range(MAX_NUMNODES, start_pfn, end_pfn);
-}
-
-/* Return the number of page frames in holes in a zone on a node */
-static unsigned long __init zone_absent_pages_in_node(int nid,
-					unsigned long zone_type,
-					unsigned long node_start_pfn,
-					unsigned long node_end_pfn)
-{
-	unsigned long zone_low = arch_zone_lowest_possible_pfn[zone_type];
-	unsigned long zone_high = arch_zone_highest_possible_pfn[zone_type];
-	unsigned long zone_start_pfn, zone_end_pfn;
-	unsigned long nr_absent;
-
-	/* When hotadd a new node from cpu_up(), the node should be empty */
-	if (!node_start_pfn && !node_end_pfn)
-		return 0;
-
-	zone_start_pfn = clamp(node_start_pfn, zone_low, zone_high);
-	zone_end_pfn = clamp(node_end_pfn, zone_low, zone_high);
-
-	adjust_zone_range_for_zone_movable(nid, zone_type,
-			node_start_pfn, node_end_pfn,
-			&zone_start_pfn, &zone_end_pfn);
-	nr_absent = __absent_pages_in_range(nid, zone_start_pfn, zone_end_pfn);
-
-	/*
-	 * ZONE_MOVABLE handling.
-	 * Treat pages to be ZONE_MOVABLE in ZONE_NORMAL as absent pages
-	 * and vice versa.
-	 */
-	if (mirrored_kernelcore && zone_movable_pfn[nid]) {
-		unsigned long start_pfn, end_pfn;
-		struct memblock_region *r;
-
-		for_each_mem_region(r) {
-			start_pfn = clamp(memblock_region_memory_base_pfn(r),
-					  zone_start_pfn, zone_end_pfn);
-			end_pfn = clamp(memblock_region_memory_end_pfn(r),
-					zone_start_pfn, zone_end_pfn);
-
-			if (zone_type == ZONE_MOVABLE &&
-			    memblock_is_mirror(r))
-				nr_absent += end_pfn - start_pfn;
-
-			if (zone_type == ZONE_NORMAL &&
-			    !memblock_is_mirror(r))
-				nr_absent += end_pfn - start_pfn;
-		}
-	}
-
-	return nr_absent;
-}
-
-static void __init calculate_node_totalpages(struct pglist_data *pgdat,
-						unsigned long node_start_pfn,
-						unsigned long node_end_pfn)
-{
-	unsigned long realtotalpages = 0, totalpages = 0;
-	enum zone_type i;
-
-	for (i = 0; i < MAX_NR_ZONES; i++) {
-		struct zone *zone = pgdat->node_zones + i;
-		unsigned long zone_start_pfn, zone_end_pfn;
-		unsigned long spanned, absent;
-		unsigned long size, real_size;
-
-		spanned = zone_spanned_pages_in_node(pgdat->node_id, i,
-						     node_start_pfn,
-						     node_end_pfn,
-						     &zone_start_pfn,
-						     &zone_end_pfn);
-		absent = zone_absent_pages_in_node(pgdat->node_id, i,
-						   node_start_pfn,
-						   node_end_pfn);
-
-		size = spanned;
-		real_size = size - absent;
-
-		if (size)
-			zone->zone_start_pfn = zone_start_pfn;
-		else
-			zone->zone_start_pfn = 0;
-		zone->spanned_pages = size;
-		zone->present_pages = real_size;
-#if defined(CONFIG_MEMORY_HOTPLUG)
-		zone->present_early_pages = real_size;
-#endif
-
-		totalpages += size;
-		realtotalpages += real_size;
-	}
-
-	pgdat->node_spanned_pages = totalpages;
-	pgdat->node_present_pages = realtotalpages;
-	pr_debug("On node %d totalpages: %lu\n", pgdat->node_id, realtotalpages);
-}
-
-#ifndef CONFIG_SPARSEMEM
-/*
- * Calculate the size of the zone->blockflags rounded to an unsigned long
- * Start by making sure zonesize is a multiple of pageblock_order by rounding
- * up. Then use 1 NR_PAGEBLOCK_BITS worth of bits per pageblock, finally
- * round what is now in bits to nearest long in bits, then return it in
- * bytes.
- */
-static unsigned long __init usemap_size(unsigned long zone_start_pfn, unsigned long zonesize)
-{
-	unsigned long usemapsize;
-
-	zonesize += zone_start_pfn & (pageblock_nr_pages-1);
-	usemapsize = roundup(zonesize, pageblock_nr_pages);
-	usemapsize = usemapsize >> pageblock_order;
-	usemapsize *= NR_PAGEBLOCK_BITS;
-	usemapsize = roundup(usemapsize, 8 * sizeof(unsigned long));
-
-	return usemapsize / 8;
-}
-
-static void __ref setup_usemap(struct zone *zone)
-{
-	unsigned long usemapsize = usemap_size(zone->zone_start_pfn,
-					       zone->spanned_pages);
-	zone->pageblock_flags = NULL;
-	if (usemapsize) {
-		zone->pageblock_flags =
-			memblock_alloc_node(usemapsize, SMP_CACHE_BYTES,
-					    zone_to_nid(zone));
-		if (!zone->pageblock_flags)
-			panic("Failed to allocate %ld bytes for zone %s pageblock flags on node %d\n",
-			      usemapsize, zone->name, zone_to_nid(zone));
-	}
-}
-#else
-static inline void setup_usemap(struct zone *zone) {}
-#endif /* CONFIG_SPARSEMEM */
-
-#ifdef CONFIG_HUGETLB_PAGE_SIZE_VARIABLE
-
-/* Initialise the number of pages represented by NR_PAGEBLOCK_BITS */
-void __init set_pageblock_order(void)
-{
-	unsigned int order = MAX_ORDER;
-
-	/* Check that pageblock_nr_pages has not already been setup */
-	if (pageblock_order)
-		return;
-
-	/* Don't let pageblocks exceed the maximum allocation granularity. */
-	if (HPAGE_SHIFT > PAGE_SHIFT && HUGETLB_PAGE_ORDER < order)
-		order = HUGETLB_PAGE_ORDER;
-
-	/*
-	 * Assume the largest contiguous order of interest is a huge page.
-	 * This value may be variable depending on boot parameters on IA64 and
-	 * powerpc.
-	 */
-	pageblock_order = order;
-}
-#else /* CONFIG_HUGETLB_PAGE_SIZE_VARIABLE */
-
-/*
- * When CONFIG_HUGETLB_PAGE_SIZE_VARIABLE is not set, set_pageblock_order()
- * is unused as pageblock_order is set at compile-time. See
- * include/linux/pageblock-flags.h for the values of pageblock_order based on
- * the kernel config
- */
-void __init set_pageblock_order(void)
-{
-}
-
-#endif /* CONFIG_HUGETLB_PAGE_SIZE_VARIABLE */
-
-static unsigned long __init calc_memmap_size(unsigned long spanned_pages,
-						unsigned long present_pages)
-{
-	unsigned long pages = spanned_pages;
-
-	/*
-	 * Provide a more accurate estimation if there are holes within
-	 * the zone and SPARSEMEM is in use. If there are holes within the
-	 * zone, each populated memory region may cost us one or two extra
-	 * memmap pages due to alignment because memmap pages for each
-	 * populated regions may not be naturally aligned on page boundary.
-	 * So the (present_pages >> 4) heuristic is a tradeoff for that.
-	 */
-	if (spanned_pages > present_pages + (present_pages >> 4) &&
-	    IS_ENABLED(CONFIG_SPARSEMEM))
-		pages = present_pages;
-
-	return PAGE_ALIGN(pages * sizeof(struct page)) >> PAGE_SHIFT;
-}
-
-#ifdef CONFIG_TRANSPARENT_HUGEPAGE
-static void pgdat_init_split_queue(struct pglist_data *pgdat)
-{
-	struct deferred_split *ds_queue = &pgdat->deferred_split_queue;
-
-	spin_lock_init(&ds_queue->split_queue_lock);
-	INIT_LIST_HEAD(&ds_queue->split_queue);
-	ds_queue->split_queue_len = 0;
-}
-#else
-static void pgdat_init_split_queue(struct pglist_data *pgdat) {}
-#endif
-
-#ifdef CONFIG_COMPACTION
-static void pgdat_init_kcompactd(struct pglist_data *pgdat)
-{
-	init_waitqueue_head(&pgdat->kcompactd_wait);
-}
-#else
-static void pgdat_init_kcompactd(struct pglist_data *pgdat) {}
-#endif
-
-static void __meminit pgdat_init_internals(struct pglist_data *pgdat)
-{
-	int i;
-
-	pgdat_resize_init(pgdat);
-	pgdat_kswapd_lock_init(pgdat);
-
-	pgdat_init_split_queue(pgdat);
-	pgdat_init_kcompactd(pgdat);
-
-	init_waitqueue_head(&pgdat->kswapd_wait);
-	init_waitqueue_head(&pgdat->pfmemalloc_wait);
-
-	for (i = 0; i < NR_VMSCAN_THROTTLE; i++)
-		init_waitqueue_head(&pgdat->reclaim_wait[i]);
-
-	pgdat_page_ext_init(pgdat);
-	lruvec_init(&pgdat->__lruvec);
-}
-
-static void __meminit zone_init_internals(struct zone *zone, enum zone_type idx, int nid,
-							unsigned long remaining_pages)
-{
-	atomic_long_set(&zone->managed_pages, remaining_pages);
-	zone_set_nid(zone, nid);
-	zone->name = zone_names[idx];
-	zone->zone_pgdat = NODE_DATA(nid);
-	spin_lock_init(&zone->lock);
-	zone_seqlock_init(zone);
-	zone_pcp_init(zone);
-}
-
-/*
- * Set up the zone data structures
- * - init pgdat internals
- * - init all zones belonging to this node
- *
- * NOTE: this function is only called during memory hotplug
- */
-#ifdef CONFIG_MEMORY_HOTPLUG
-void __ref free_area_init_core_hotplug(struct pglist_data *pgdat)
-{
-	int nid = pgdat->node_id;
-	enum zone_type z;
-	int cpu;
-
-	pgdat_init_internals(pgdat);
-
-	if (pgdat->per_cpu_nodestats == &boot_nodestats)
-		pgdat->per_cpu_nodestats = alloc_percpu(struct per_cpu_nodestat);
-
-	/*
-	 * Reset the nr_zones, order and highest_zoneidx before reuse.
-	 * Note that kswapd will init kswapd_highest_zoneidx properly
-	 * when it starts in the near future.
-	 */
-	pgdat->nr_zones = 0;
-	pgdat->kswapd_order = 0;
-	pgdat->kswapd_highest_zoneidx = 0;
-	pgdat->node_start_pfn = 0;
-	for_each_online_cpu(cpu) {
-		struct per_cpu_nodestat *p;
-
-		p = per_cpu_ptr(pgdat->per_cpu_nodestats, cpu);
-		memset(p, 0, sizeof(*p));
-	}
-
-	for (z = 0; z < MAX_NR_ZONES; z++)
-		zone_init_internals(&pgdat->node_zones[z], z, nid, 0);
-}
-#endif
-
-/*
- * Set up the zone data structures:
- *   - mark all pages reserved
- *   - mark all memory queues empty
- *   - clear the memory bitmaps
- *
- * NOTE: pgdat should get zeroed by caller.
- * NOTE: this function is only called during early init.
- */
-static void __init free_area_init_core(struct pglist_data *pgdat)
-{
-	enum zone_type j;
-	int nid = pgdat->node_id;
-
-	pgdat_init_internals(pgdat);
-	pgdat->per_cpu_nodestats = &boot_nodestats;
-
-	for (j = 0; j < MAX_NR_ZONES; j++) {
-		struct zone *zone = pgdat->node_zones + j;
-		unsigned long size, freesize, memmap_pages;
-
-		size = zone->spanned_pages;
-		freesize = zone->present_pages;
-
-		/*
-		 * Adjust freesize so that it accounts for how much memory
-		 * is used by this zone for memmap. This affects the watermark
-		 * and per-cpu initialisations
-		 */
-		memmap_pages = calc_memmap_size(size, freesize);
-		if (!is_highmem_idx(j)) {
-			if (freesize >= memmap_pages) {
-				freesize -= memmap_pages;
-				if (memmap_pages)
-					pr_debug("  %s zone: %lu pages used for memmap\n",
-						 zone_names[j], memmap_pages);
-			} else
-				pr_warn("  %s zone: %lu memmap pages exceeds freesize %lu\n",
-					zone_names[j], memmap_pages, freesize);
-		}
-
-		/* Account for reserved pages */
-		if (j == 0 && freesize > dma_reserve) {
-			freesize -= dma_reserve;
-			pr_debug("  %s zone: %lu pages reserved\n", zone_names[0], dma_reserve);
-		}
-
-		if (!is_highmem_idx(j))
-			nr_kernel_pages += freesize;
-		/* Charge for highmem memmap if there are enough kernel pages */
-		else if (nr_kernel_pages > memmap_pages * 2)
-			nr_kernel_pages -= memmap_pages;
-		nr_all_pages += freesize;
-
-		/*
-		 * Set an approximate value for lowmem here, it will be adjusted
-		 * when the bootmem allocator frees pages into the buddy system.
-		 * And all highmem pages will be managed by the buddy system.
-		 */
-		zone_init_internals(zone, j, nid, freesize);
-
-		if (!size)
-			continue;
-
-		set_pageblock_order();
-		setup_usemap(zone);
-		init_currently_empty_zone(zone, zone->zone_start_pfn, size);
-	}
-}
-
-#ifdef CONFIG_FLATMEM
-static void __init alloc_node_mem_map(struct pglist_data *pgdat)
-{
-	unsigned long __maybe_unused start = 0;
-	unsigned long __maybe_unused offset = 0;
-
-	/* Skip empty nodes */
-	if (!pgdat->node_spanned_pages)
-		return;
-
-	start = pgdat->node_start_pfn & ~(MAX_ORDER_NR_PAGES - 1);
-	offset = pgdat->node_start_pfn - start;
-	/* ia64 gets its own node_mem_map, before this, without bootmem */
-	if (!pgdat->node_mem_map) {
-		unsigned long size, end;
-		struct page *map;
-
-		/*
-		 * The zone's endpoints aren't required to be MAX_ORDER
-		 * aligned but the node_mem_map endpoints must be in order
-		 * for the buddy allocator to function correctly.
-		 */
-		end = pgdat_end_pfn(pgdat);
-		end = ALIGN(end, MAX_ORDER_NR_PAGES);
-		size =  (end - start) * sizeof(struct page);
-		map = memmap_alloc(size, SMP_CACHE_BYTES, MEMBLOCK_LOW_LIMIT,
-				   pgdat->node_id, false);
-		if (!map)
-			panic("Failed to allocate %ld bytes for node %d memory map\n",
-			      size, pgdat->node_id);
-		pgdat->node_mem_map = map + offset;
-	}
-	pr_debug("%s: node %d, pgdat %08lx, node_mem_map %08lx\n",
-				__func__, pgdat->node_id, (unsigned long)pgdat,
-				(unsigned long)pgdat->node_mem_map);
-#ifndef CONFIG_NUMA
-	/*
-	 * With no DISCONTIG, the global mem_map is just set as node 0's
-	 */
-	if (pgdat == NODE_DATA(0)) {
-		mem_map = NODE_DATA(0)->node_mem_map;
-		if (page_to_pfn(mem_map) != pgdat->node_start_pfn)
-			mem_map -= offset;
-	}
-#endif
-}
-#else
-static inline void alloc_node_mem_map(struct pglist_data *pgdat) { }
-#endif /* CONFIG_FLATMEM */
-
-#ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT
-static inline void pgdat_set_deferred_range(pg_data_t *pgdat)
-{
-	pgdat->first_deferred_pfn = ULONG_MAX;
-}
-#else
-static inline void pgdat_set_deferred_range(pg_data_t *pgdat) {}
-#endif
-
-static void __init free_area_init_node(int nid)
-{
-	pg_data_t *pgdat = NODE_DATA(nid);
-	unsigned long start_pfn = 0;
-	unsigned long end_pfn = 0;
-
-	/* pg_data_t should be reset to zero when it's allocated */
-	WARN_ON(pgdat->nr_zones || pgdat->kswapd_highest_zoneidx);
-
-	get_pfn_range_for_nid(nid, &start_pfn, &end_pfn);
-
-	pgdat->node_id = nid;
-	pgdat->node_start_pfn = start_pfn;
-	pgdat->per_cpu_nodestats = NULL;
-
-	if (start_pfn != end_pfn) {
-		pr_info("Initmem setup node %d [mem %#018Lx-%#018Lx]\n", nid,
-			(u64)start_pfn << PAGE_SHIFT,
-			end_pfn ? ((u64)end_pfn << PAGE_SHIFT) - 1 : 0);
-	} else {
-		pr_info("Initmem setup node %d as memoryless\n", nid);
-	}
-
-	calculate_node_totalpages(pgdat, start_pfn, end_pfn);
-
-	alloc_node_mem_map(pgdat);
-	pgdat_set_deferred_range(pgdat);
-
-	free_area_init_core(pgdat);
-	lru_gen_init_pgdat(pgdat);
-}
-
-static void __init free_area_init_memoryless_node(int nid)
-{
-	free_area_init_node(nid);
-}
-
-#if MAX_NUMNODES > 1
-/*
- * Figure out the number of possible node ids.
- */
-void __init setup_nr_node_ids(void)
-{
-	unsigned int highest;
-
-	highest = find_last_bit(node_possible_map.bits, MAX_NUMNODES);
-	nr_node_ids = highest + 1;
-}
-#endif
-
-/**
- * node_map_pfn_alignment - determine the maximum internode alignment
- *
- * This function should be called after node map is populated and sorted.
- * It calculates the maximum power of two alignment which can distinguish
- * all the nodes.
- *
- * For example, if all nodes are 1GiB and aligned to 1GiB, the return value
- * would indicate 1GiB alignment with (1 << (30 - PAGE_SHIFT)).  If the
- * nodes are shifted by 256MiB, 256MiB.  Note that if only the last node is
- * shifted, 1GiB is enough and this function will indicate so.
- *
- * This is used to test whether pfn -> nid mapping of the chosen memory
- * model has fine enough granularity to avoid incorrect mapping for the
- * populated node map.
- *
- * Return: the determined alignment in pfn's.  0 if there is no alignment
- * requirement (single node).
- */
-unsigned long __init node_map_pfn_alignment(void)
-{
-	unsigned long accl_mask = 0, last_end = 0;
-	unsigned long start, end, mask;
-	int last_nid = NUMA_NO_NODE;
-	int i, nid;
-
-	for_each_mem_pfn_range(i, MAX_NUMNODES, &start, &end, &nid) {
-		if (!start || last_nid < 0 || last_nid == nid) {
-			last_nid = nid;
-			last_end = end;
-			continue;
-		}
-
-		/*
-		 * Start with a mask granular enough to pin-point to the
-		 * start pfn and tick off bits one-by-one until it becomes
-		 * too coarse to separate the current node from the last.
-		 */
-		mask = ~((1 << __ffs(start)) - 1);
-		while (mask && last_end <= (start & (mask << 1)))
-			mask <<= 1;
-
-		/* accumulate all internode masks */
-		accl_mask |= mask;
-	}
-
-	/* convert mask to number of pages */
-	return ~accl_mask + 1;
-}
-
-/*
- * early_calculate_totalpages()
- * Sum pages in active regions for movable zone.
- * Populate N_MEMORY for calculating usable_nodes.
- */
-static unsigned long __init early_calculate_totalpages(void)
-{
-	unsigned long totalpages = 0;
-	unsigned long start_pfn, end_pfn;
-	int i, nid;
-
-	for_each_mem_pfn_range(i, MAX_NUMNODES, &start_pfn, &end_pfn, &nid) {
-		unsigned long pages = end_pfn - start_pfn;
-
-		totalpages += pages;
-		if (pages)
-			node_set_state(nid, N_MEMORY);
-	}
-	return totalpages;
-}
-
-/*
- * Find the PFN the Movable zone begins in each node. Kernel memory
- * is spread evenly between nodes as long as the nodes have enough
- * memory. When they don't, some nodes will have more kernelcore than
- * others
- */
-static void __init find_zone_movable_pfns_for_nodes(void)
-{
-	int i, nid;
-	unsigned long usable_startpfn;
-	unsigned long kernelcore_node, kernelcore_remaining;
-	/* save the state before borrow the nodemask */
-	nodemask_t saved_node_state = node_states[N_MEMORY];
-	unsigned long totalpages = early_calculate_totalpages();
-	int usable_nodes = nodes_weight(node_states[N_MEMORY]);
-	struct memblock_region *r;
-
-	/* Need to find movable_zone earlier when movable_node is specified. */
-	find_usable_zone_for_movable();
-
-	/*
-	 * If movable_node is specified, ignore kernelcore and movablecore
-	 * options.
-	 */
-	if (movable_node_is_enabled()) {
-		for_each_mem_region(r) {
-			if (!memblock_is_hotpluggable(r))
-				continue;
-
-			nid = memblock_get_region_node(r);
-
-			usable_startpfn = PFN_DOWN(r->base);
-			zone_movable_pfn[nid] = zone_movable_pfn[nid] ?
-				min(usable_startpfn, zone_movable_pfn[nid]) :
-				usable_startpfn;
-		}
-
-		goto out2;
-	}
-
-	/*
-	 * If kernelcore=mirror is specified, ignore movablecore option
-	 */
-	if (mirrored_kernelcore) {
-		bool mem_below_4gb_not_mirrored = false;
-
-		for_each_mem_region(r) {
-			if (memblock_is_mirror(r))
-				continue;
-
-			nid = memblock_get_region_node(r);
-
-			usable_startpfn = memblock_region_memory_base_pfn(r);
-
-			if (usable_startpfn < PHYS_PFN(SZ_4G)) {
-				mem_below_4gb_not_mirrored = true;
-				continue;
-			}
-
-			zone_movable_pfn[nid] = zone_movable_pfn[nid] ?
-				min(usable_startpfn, zone_movable_pfn[nid]) :
-				usable_startpfn;
-		}
-
-		if (mem_below_4gb_not_mirrored)
-			pr_warn("This configuration results in unmirrored kernel memory.\n");
-
-		goto out2;
-	}
-
-	/*
-	 * If kernelcore=nn% or movablecore=nn% was specified, calculate the
-	 * amount of necessary memory.
-	 */
-	if (required_kernelcore_percent)
-		required_kernelcore = (totalpages * 100 * required_kernelcore_percent) /
-				       10000UL;
-	if (required_movablecore_percent)
-		required_movablecore = (totalpages * 100 * required_movablecore_percent) /
-					10000UL;
-
-	/*
-	 * If movablecore= was specified, calculate what size of
-	 * kernelcore that corresponds so that memory usable for
-	 * any allocation type is evenly spread. If both kernelcore
-	 * and movablecore are specified, then the value of kernelcore
-	 * will be used for required_kernelcore if it's greater than
-	 * what movablecore would have allowed.
-	 */
-	if (required_movablecore) {
-		unsigned long corepages;
-
-		/*
-		 * Round-up so that ZONE_MOVABLE is at least as large as what
-		 * was requested by the user
-		 */
-		required_movablecore =
-			roundup(required_movablecore, MAX_ORDER_NR_PAGES);
-		required_movablecore = min(totalpages, required_movablecore);
-		corepages = totalpages - required_movablecore;
-
-		required_kernelcore = max(required_kernelcore, corepages);
-	}
-
-	/*
-	 * If kernelcore was not specified or kernelcore size is larger
-	 * than totalpages, there is no ZONE_MOVABLE.
-	 */
-	if (!required_kernelcore || required_kernelcore >= totalpages)
-		goto out;
-
-	/* usable_startpfn is the lowest possible pfn ZONE_MOVABLE can be at */
-	usable_startpfn = arch_zone_lowest_possible_pfn[movable_zone];
-
-restart:
-	/* Spread kernelcore memory as evenly as possible throughout nodes */
-	kernelcore_node = required_kernelcore / usable_nodes;
-	for_each_node_state(nid, N_MEMORY) {
-		unsigned long start_pfn, end_pfn;
+#ifdef CONFIG_MMU
+	int high;
+	int nr_split_cpus;
+	unsigned long total_pages;
 
+	if (!percpu_pagelist_high_fraction) {
 		/*
-		 * Recalculate kernelcore_node if the division per node
-		 * now exceeds what is necessary to satisfy the requested
-		 * amount of memory for the kernel
+		 * By default, the high value of the pcp is based on the zone
+		 * low watermark so that if they are full then background
+		 * reclaim will not be started prematurely.
 		 */
-		if (required_kernelcore < kernelcore_node)
-			kernelcore_node = required_kernelcore / usable_nodes;
-
+		total_pages = low_wmark_pages(zone);
+	} else {
 		/*
-		 * As the map is walked, we track how much memory is usable
-		 * by the kernel using kernelcore_remaining. When it is
-		 * 0, the rest of the node is usable by ZONE_MOVABLE
+		 * If percpu_pagelist_high_fraction is configured, the high
+		 * value is based on a fraction of the managed pages in the
+		 * zone.
 		 */
-		kernelcore_remaining = kernelcore_node;
-
-		/* Go through each range of PFNs within this node */
-		for_each_mem_pfn_range(i, nid, &start_pfn, &end_pfn, NULL) {
-			unsigned long size_pages;
-
-			start_pfn = max(start_pfn, zone_movable_pfn[nid]);
-			if (start_pfn >= end_pfn)
-				continue;
-
-			/* Account for what is only usable for kernelcore */
-			if (start_pfn < usable_startpfn) {
-				unsigned long kernel_pages;
-				kernel_pages = min(end_pfn, usable_startpfn)
-								- start_pfn;
-
-				kernelcore_remaining -= min(kernel_pages,
-							kernelcore_remaining);
-				required_kernelcore -= min(kernel_pages,
-							required_kernelcore);
-
-				/* Continue if range is now fully accounted */
-				if (end_pfn <= usable_startpfn) {
-
-					/*
-					 * Push zone_movable_pfn to the end so
-					 * that if we have to rebalance
-					 * kernelcore across nodes, we will
-					 * not double account here
-					 */
-					zone_movable_pfn[nid] = end_pfn;
-					continue;
-				}
-				start_pfn = usable_startpfn;
-			}
-
-			/*
-			 * The usable PFN range for ZONE_MOVABLE is from
-			 * start_pfn->end_pfn. Calculate size_pages as the
-			 * number of pages used as kernelcore
-			 */
-			size_pages = end_pfn - start_pfn;
-			if (size_pages > kernelcore_remaining)
-				size_pages = kernelcore_remaining;
-			zone_movable_pfn[nid] = start_pfn + size_pages;
-
-			/*
-			 * Some kernelcore has been met, update counts and
-			 * break if the kernelcore for this node has been
-			 * satisfied
-			 */
-			required_kernelcore -= min(required_kernelcore,
-								size_pages);
-			kernelcore_remaining -= size_pages;
-			if (!kernelcore_remaining)
-				break;
-		}
+		total_pages = zone_managed_pages(zone) / percpu_pagelist_high_fraction;
 	}
 
 	/*
-	 * If there is still required_kernelcore, we do another pass with one
-	 * less node in the count. This will push zone_movable_pfn[nid] further
-	 * along on the nodes that still have memory until kernelcore is
-	 * satisfied
+	 * Split the high value across all online CPUs local to the zone. Note
+	 * that early in boot that CPUs may not be online yet and that during
+	 * CPU hotplug that the cpumask is not yet updated when a CPU is being
+	 * onlined. For memory nodes that have no CPUs, split pcp->high across
+	 * all online CPUs to mitigate the risk that reclaim is triggered
+	 * prematurely due to pages stored on pcp lists.
 	 */
-	usable_nodes--;
-	if (usable_nodes && required_kernelcore > usable_nodes)
-		goto restart;
-
-out2:
-	/* Align start of ZONE_MOVABLE on all nids to MAX_ORDER_NR_PAGES */
-	for (nid = 0; nid < MAX_NUMNODES; nid++) {
-		unsigned long start_pfn, end_pfn;
-
-		zone_movable_pfn[nid] =
-			roundup(zone_movable_pfn[nid], MAX_ORDER_NR_PAGES);
-
-		get_pfn_range_for_nid(nid, &start_pfn, &end_pfn);
-		if (zone_movable_pfn[nid] >= end_pfn)
-			zone_movable_pfn[nid] = 0;
-	}
-
-out:
-	/* restore the node_state */
-	node_states[N_MEMORY] = saved_node_state;
-}
+	nr_split_cpus = cpumask_weight(cpumask_of_node(zone_to_nid(zone))) + cpu_online;
+	if (!nr_split_cpus)
+		nr_split_cpus = num_online_cpus();
+	high = total_pages / nr_split_cpus;
 
-/* Any regular or high memory on that node ? */
-static void check_for_memory(pg_data_t *pgdat, int nid)
-{
-	enum zone_type zone_type;
+	/*
+	 * Ensure high is at least batch*4. The multiple is based on the
+	 * historical relationship between high and batch.
+	 */
+	high = max(high, batch << 2);
 
-	for (zone_type = 0; zone_type <= ZONE_MOVABLE - 1; zone_type++) {
-		struct zone *zone = &pgdat->node_zones[zone_type];
-		if (populated_zone(zone)) {
-			if (IS_ENABLED(CONFIG_HIGHMEM))
-				node_set_state(nid, N_HIGH_MEMORY);
-			if (zone_type <= ZONE_NORMAL)
-				node_set_state(nid, N_NORMAL_MEMORY);
-			break;
-		}
-	}
+	return high;
+#else
+	return 0;
+#endif
 }
 
 /*
- * Some architectures, e.g. ARC may have ZONE_HIGHMEM below ZONE_NORMAL. For
- * such cases we allow max_zone_pfn sorted in the descending order
+ * pcp->high and pcp->batch values are related and generally batch is lower
+ * than high. They are also related to pcp->count such that count is lower
+ * than high, and as soon as it reaches high, the pcplist is flushed.
+ *
+ * However, guaranteeing these relations at all times would require e.g. write
+ * barriers here but also careful usage of read barriers at the read side, and
+ * thus be prone to error and bad for performance. Thus the update only prevents
+ * store tearing. Any new users of pcp->batch and pcp->high should ensure they
+ * can cope with those fields changing asynchronously, and fully trust only the
+ * pcp->count field on the local CPU with interrupts disabled.
+ *
+ * mutex_is_locked(&pcp_batch_high_lock) required when calling this function
+ * outside of boot time (or some other assurance that no concurrent updaters
+ * exist).
  */
-bool __weak arch_has_descending_max_zone_pfns(void)
+static void pageset_update(struct per_cpu_pages *pcp, unsigned long high,
+		unsigned long batch)
 {
-	return false;
+	WRITE_ONCE(pcp->batch, batch);
+	WRITE_ONCE(pcp->high, high);
 }
 
-/**
- * free_area_init - Initialise all pg_data_t and zone data
- * @max_zone_pfn: an array of max PFNs for each zone
- *
- * This will call free_area_init_node() for each active node in the system.
- * Using the page ranges provided by memblock_set_node(), the size of each
- * zone in each node and their holes is calculated. If the maximum PFN
- * between two adjacent zones match, it is assumed that the zone is empty.
- * For example, if arch_max_dma_pfn == arch_max_dma32_pfn, it is assumed
- * that arch_max_dma32_pfn has no pages. It is also assumed that a zone
- * starts where the previous one ended. For example, ZONE_DMA32 starts
- * at arch_max_dma_pfn.
- */
-void __init free_area_init(unsigned long *max_zone_pfn)
+static void per_cpu_pages_init(struct per_cpu_pages *pcp, struct per_cpu_zonestat *pzstats)
 {
-	unsigned long start_pfn, end_pfn;
-	int i, nid, zone;
-	bool descending;
-
-	/* Record where the zone boundaries are */
-	memset(arch_zone_lowest_possible_pfn, 0,
-				sizeof(arch_zone_lowest_possible_pfn));
-	memset(arch_zone_highest_possible_pfn, 0,
-				sizeof(arch_zone_highest_possible_pfn));
-
-	start_pfn = PHYS_PFN(memblock_start_of_DRAM());
-	descending = arch_has_descending_max_zone_pfns();
-
-	for (i = 0; i < MAX_NR_ZONES; i++) {
-		if (descending)
-			zone = MAX_NR_ZONES - i - 1;
-		else
-			zone = i;
-
-		if (zone == ZONE_MOVABLE)
-			continue;
+	int pindex;
 
-		end_pfn = max(max_zone_pfn[zone], start_pfn);
-		arch_zone_lowest_possible_pfn[zone] = start_pfn;
-		arch_zone_highest_possible_pfn[zone] = end_pfn;
+	memset(pcp, 0, sizeof(*pcp));
+	memset(pzstats, 0, sizeof(*pzstats));
 
-		start_pfn = end_pfn;
-	}
+	spin_lock_init(&pcp->lock);
+	for (pindex = 0; pindex < NR_PCP_LISTS; pindex++)
+		INIT_LIST_HEAD(&pcp->lists[pindex]);
 
-	/* Find the PFNs that ZONE_MOVABLE begins at in each node */
-	memset(zone_movable_pfn, 0, sizeof(zone_movable_pfn));
-	find_zone_movable_pfns_for_nodes();
+	/*
+	 * Set batch and high values safe for a boot pageset. A true percpu
+	 * pageset's initialization will update them subsequently. Here we don't
+	 * need to be as careful as pageset_update() as nobody can access the
+	 * pageset yet.
+	 */
+	pcp->high = BOOT_PAGESET_HIGH;
+	pcp->batch = BOOT_PAGESET_BATCH;
+	pcp->free_factor = 0;
+}
 
-	/* Print out the zone ranges */
-	pr_info("Zone ranges:\n");
-	for (i = 0; i < MAX_NR_ZONES; i++) {
-		if (i == ZONE_MOVABLE)
-			continue;
-		pr_info("  %-8s ", zone_names[i]);
-		if (arch_zone_lowest_possible_pfn[i] ==
-				arch_zone_highest_possible_pfn[i])
-			pr_cont("empty\n");
-		else
-			pr_cont("[mem %#018Lx-%#018Lx]\n",
-				(u64)arch_zone_lowest_possible_pfn[i]
-					<< PAGE_SHIFT,
-				((u64)arch_zone_highest_possible_pfn[i]
-					<< PAGE_SHIFT) - 1);
-	}
+static void __zone_set_pageset_high_and_batch(struct zone *zone, unsigned long high,
+		unsigned long batch)
+{
+	struct per_cpu_pages *pcp;
+	int cpu;
 
-	/* Print out the PFNs ZONE_MOVABLE begins at in each node */
-	pr_info("Movable zone start for each node\n");
-	for (i = 0; i < MAX_NUMNODES; i++) {
-		if (zone_movable_pfn[i])
-			pr_info("  Node %d: %#018Lx\n", i,
-			       (u64)zone_movable_pfn[i] << PAGE_SHIFT);
+	for_each_possible_cpu(cpu) {
+		pcp = per_cpu_ptr(zone->per_cpu_pageset, cpu);
+		pageset_update(pcp, high, batch);
 	}
+}
 
-	/*
-	 * Print out the early node map, and initialize the
-	 * subsection-map relative to active online memory ranges to
-	 * enable future "sub-section" extensions of the memory map.
-	 */
-	pr_info("Early memory node ranges\n");
-	for_each_mem_pfn_range(i, MAX_NUMNODES, &start_pfn, &end_pfn, &nid) {
-		pr_info("  node %3d: [mem %#018Lx-%#018Lx]\n", nid,
-			(u64)start_pfn << PAGE_SHIFT,
-			((u64)end_pfn << PAGE_SHIFT) - 1);
-		subsection_map_init(start_pfn, end_pfn - start_pfn);
-	}
-
-	/* Initialise every node */
-	mminit_verify_pageflags_layout();
-	setup_nr_node_ids();
-	for_each_node(nid) {
-		pg_data_t *pgdat;
-
-		if (!node_online(nid)) {
-			pr_info("Initializing node %d as memoryless\n", nid);
-
-			/* Allocator not initialized yet */
-			pgdat = arch_alloc_nodedata(nid);
-			if (!pgdat)
-				panic("Cannot allocate %zuB for node %d.\n",
-				       sizeof(*pgdat), nid);
-			arch_refresh_nodedata(nid, pgdat);
-			free_area_init_memoryless_node(nid);
+/*
+ * Calculate and set new high and batch values for all per-cpu pagesets of a
+ * zone based on the zone's size.
+ */
+static void zone_set_pageset_high_and_batch(struct zone *zone, int cpu_online)
+{
+	int new_high, new_batch;
 
-			/*
-			 * We do not want to confuse userspace by sysfs
-			 * files/directories for node without any memory
-			 * attached to it, so this node is not marked as
-			 * N_MEMORY and not marked online so that no sysfs
-			 * hierarchy will be created via register_one_node for
-			 * it. The pgdat will get fully initialized by
-			 * hotadd_init_pgdat() when memory is hotplugged into
-			 * this node.
-			 */
-			continue;
-		}
+	new_batch = max(1, zone_batchsize(zone));
+	new_high = zone_highsize(zone, new_batch, cpu_online);
 
-		pgdat = NODE_DATA(nid);
-		free_area_init_node(nid);
+	if (zone->pageset_high == new_high &&
+	    zone->pageset_batch == new_batch)
+		return;
 
-		/* Any memory on that node */
-		if (pgdat->node_present_pages)
-			node_set_state(nid, N_MEMORY);
-		check_for_memory(pgdat, nid);
-	}
+	zone->pageset_high = new_high;
+	zone->pageset_batch = new_batch;
 
-	memmap_init();
+	__zone_set_pageset_high_and_batch(zone, new_high, new_batch);
 }
 
-static int __init cmdline_parse_core(char *p, unsigned long *core,
-				     unsigned long *percent)
+void __meminit setup_zone_pageset(struct zone *zone)
 {
-	unsigned long long coremem;
-	char *endptr;
-
-	if (!p)
-		return -EINVAL;
+	int cpu;
 
-	/* Value may be a percentage of total memory, otherwise bytes */
-	coremem = simple_strtoull(p, &endptr, 0);
-	if (*endptr == '%') {
-		/* Paranoid check for percent values greater than 100 */
-		WARN_ON(coremem > 100);
+	/* Size may be 0 on !SMP && !NUMA */
+	if (sizeof(struct per_cpu_zonestat) > 0)
+		zone->per_cpu_zonestats = alloc_percpu(struct per_cpu_zonestat);
 
-		*percent = coremem;
-	} else {
-		coremem = memparse(p, &p);
-		/* Paranoid check that UL is enough for the coremem value */
-		WARN_ON((coremem >> PAGE_SHIFT) > ULONG_MAX);
+	zone->per_cpu_pageset = alloc_percpu(struct per_cpu_pages);
+	for_each_possible_cpu(cpu) {
+		struct per_cpu_pages *pcp;
+		struct per_cpu_zonestat *pzstats;
 
-		*core = coremem >> PAGE_SHIFT;
-		*percent = 0UL;
+		pcp = per_cpu_ptr(zone->per_cpu_pageset, cpu);
+		pzstats = per_cpu_ptr(zone->per_cpu_zonestats, cpu);
+		per_cpu_pages_init(pcp, pzstats);
 	}
-	return 0;
+
+	zone_set_pageset_high_and_batch(zone, 0);
 }
 
 /*
- * kernelcore=size sets the amount of memory for use for allocations that
- * cannot be reclaimed or migrated.
+ * The zone indicated has a new number of managed_pages; batch sizes and percpu
+ * page high values need to be recalculated.
  */
-static int __init cmdline_parse_kernelcore(char *p)
+static void zone_pcp_update(struct zone *zone, int cpu_online)
 {
-	/* parse kernelcore=mirror */
-	if (parse_option_str(p, "mirror")) {
-		mirrored_kernelcore = true;
-		return 0;
-	}
-
-	return cmdline_parse_core(p, &required_kernelcore,
-				  &required_kernelcore_percent);
+	mutex_lock(&pcp_batch_high_lock);
+	zone_set_pageset_high_and_batch(zone, cpu_online);
+	mutex_unlock(&pcp_batch_high_lock);
 }
 
 /*
- * movablecore=size sets the amount of memory for use for allocations that
- * can be reclaimed or migrated.
+ * Allocate per cpu pagesets and initialize them.
+ * Before this call only boot pagesets were available.
  */
-static int __init cmdline_parse_movablecore(char *p)
+void __init setup_per_cpu_pageset(void)
 {
-	return cmdline_parse_core(p, &required_movablecore,
-				  &required_movablecore_percent);
+	struct pglist_data *pgdat;
+	struct zone *zone;
+	int __maybe_unused cpu;
+
+	for_each_populated_zone(zone)
+		setup_zone_pageset(zone);
+
+#ifdef CONFIG_NUMA
+	/*
+	 * Unpopulated zones continue using the boot pagesets.
+	 * The numa stats for these pagesets need to be reset.
+	 * Otherwise, they will end up skewing the stats of
+	 * the nodes these zones are associated with.
+	 */
+	for_each_possible_cpu(cpu) {
+		struct per_cpu_zonestat *pzstats = &per_cpu(boot_zonestats, cpu);
+		memset(pzstats->vm_numa_event, 0,
+		       sizeof(pzstats->vm_numa_event));
+	}
+#endif
+
+	for_each_online_pgdat(pgdat)
+		pgdat->per_cpu_nodestats =
+			alloc_percpu(struct per_cpu_nodestat);
 }
 
-early_param("kernelcore", cmdline_parse_kernelcore);
-early_param("movablecore", cmdline_parse_movablecore);
+__meminit void zone_pcp_init(struct zone *zone)
+{
+	/*
+	 * per cpu subsystem is not up at this point. The following code
+	 * relies on the ability of the linker to provide the
+	 * offset of a (static) per cpu variable into the per cpu area.
+	 */
+	zone->per_cpu_pageset = &boot_pageset;
+	zone->per_cpu_zonestats = &boot_zonestats;
+	zone->pageset_high = BOOT_PAGESET_HIGH;
+	zone->pageset_batch = BOOT_PAGESET_BATCH;
+
+	if (populated_zone(zone))
+		pr_debug("  %s zone: %lu pages, LIFO batch:%u\n", zone->name,
+			 zone->present_pages, zone_batchsize(zone));
+}
 
 void adjust_managed_page_count(struct page *page, long count)
 {
@@ -8509,22 +6346,6 @@ void __init mem_init_print_info(void)
 		);
 }
 
-/**
- * set_dma_reserve - set the specified number of pages reserved in the first zone
- * @new_dma_reserve: The number of pages to mark reserved
- *
- * The per-cpu batchsize and zone watermarks are determined by managed_pages.
- * In the DMA zone, a significant percentage may be consumed by kernel image
- * and other unfreeable allocations which can skew the watermarks badly. This
- * function may optionally be used to account for unfreeable pages in the
- * first zone (e.g., ZONE_DMA). The effect will be lower watermarks and
- * smaller per-cpu batchsize.
- */
-void __init set_dma_reserve(unsigned long new_dma_reserve)
-{
-	dma_reserve = new_dma_reserve;
-}
-
 static int page_alloc_cpu_dead(unsigned int cpu)
 {
 	struct zone *zone;
@@ -8966,149 +6787,6 @@ int percpu_pagelist_high_fraction_sysctl_handler(struct ctl_table *table,
 	return ret;
 }
 
-#ifndef __HAVE_ARCH_RESERVED_KERNEL_PAGES
-/*
- * Returns the number of pages that arch has reserved but
- * is not known to alloc_large_system_hash().
- */
-static unsigned long __init arch_reserved_kernel_pages(void)
-{
-	return 0;
-}
-#endif
-
-/*
- * Adaptive scale is meant to reduce sizes of hash tables on large memory
- * machines. As memory size is increased the scale is also increased but at
- * slower pace.  Starting from ADAPT_SCALE_BASE (64G), every time memory
- * quadruples the scale is increased by one, which means the size of hash table
- * only doubles, instead of quadrupling as well.
- * Because 32-bit systems cannot have large physical memory, where this scaling
- * makes sense, it is disabled on such platforms.
- */
-#if __BITS_PER_LONG > 32
-#define ADAPT_SCALE_BASE	(64ul << 30)
-#define ADAPT_SCALE_SHIFT	2
-#define ADAPT_SCALE_NPAGES	(ADAPT_SCALE_BASE >> PAGE_SHIFT)
-#endif
-
-/*
- * allocate a large system hash table from bootmem
- * - it is assumed that the hash table must contain an exact power-of-2
- *   quantity of entries
- * - limit is the number of hash buckets, not the total allocation size
- */
-void *__init alloc_large_system_hash(const char *tablename,
-				     unsigned long bucketsize,
-				     unsigned long numentries,
-				     int scale,
-				     int flags,
-				     unsigned int *_hash_shift,
-				     unsigned int *_hash_mask,
-				     unsigned long low_limit,
-				     unsigned long high_limit)
-{
-	unsigned long long max = high_limit;
-	unsigned long log2qty, size;
-	void *table;
-	gfp_t gfp_flags;
-	bool virt;
-	bool huge;
-
-	/* allow the kernel cmdline to have a say */
-	if (!numentries) {
-		/* round applicable memory size up to nearest megabyte */
-		numentries = nr_kernel_pages;
-		numentries -= arch_reserved_kernel_pages();
-
-		/* It isn't necessary when PAGE_SIZE >= 1MB */
-		if (PAGE_SIZE < SZ_1M)
-			numentries = round_up(numentries, SZ_1M / PAGE_SIZE);
-
-#if __BITS_PER_LONG > 32
-		if (!high_limit) {
-			unsigned long adapt;
-
-			for (adapt = ADAPT_SCALE_NPAGES; adapt < numentries;
-			     adapt <<= ADAPT_SCALE_SHIFT)
-				scale++;
-		}
-#endif
-
-		/* limit to 1 bucket per 2^scale bytes of low memory */
-		if (scale > PAGE_SHIFT)
-			numentries >>= (scale - PAGE_SHIFT);
-		else
-			numentries <<= (PAGE_SHIFT - scale);
-
-		/* Make sure we've got at least a 0-order allocation.. */
-		if (unlikely(flags & HASH_SMALL)) {
-			/* Makes no sense without HASH_EARLY */
-			WARN_ON(!(flags & HASH_EARLY));
-			if (!(numentries >> *_hash_shift)) {
-				numentries = 1UL << *_hash_shift;
-				BUG_ON(!numentries);
-			}
-		} else if (unlikely((numentries * bucketsize) < PAGE_SIZE))
-			numentries = PAGE_SIZE / bucketsize;
-	}
-	numentries = roundup_pow_of_two(numentries);
-
-	/* limit allocation size to 1/16 total memory by default */
-	if (max == 0) {
-		max = ((unsigned long long)nr_all_pages << PAGE_SHIFT) >> 4;
-		do_div(max, bucketsize);
-	}
-	max = min(max, 0x80000000ULL);
-
-	if (numentries < low_limit)
-		numentries = low_limit;
-	if (numentries > max)
-		numentries = max;
-
-	log2qty = ilog2(numentries);
-
-	gfp_flags = (flags & HASH_ZERO) ? GFP_ATOMIC | __GFP_ZERO : GFP_ATOMIC;
-	do {
-		virt = false;
-		size = bucketsize << log2qty;
-		if (flags & HASH_EARLY) {
-			if (flags & HASH_ZERO)
-				table = memblock_alloc(size, SMP_CACHE_BYTES);
-			else
-				table = memblock_alloc_raw(size,
-							   SMP_CACHE_BYTES);
-		} else if (get_order(size) > MAX_ORDER || hashdist) {
-			table = vmalloc_huge(size, gfp_flags);
-			virt = true;
-			if (table)
-				huge = is_vm_area_hugepages(table);
-		} else {
-			/*
-			 * If bucketsize is not a power-of-two, we may free
-			 * some pages at the end of hash table which
-			 * alloc_pages_exact() automatically does
-			 */
-			table = alloc_pages_exact(size, gfp_flags);
-			kmemleak_alloc(table, size, 1, gfp_flags);
-		}
-	} while (!table && size > PAGE_SIZE && --log2qty);
-
-	if (!table)
-		panic("Failed to allocate %s hash table\n", tablename);
-
-	pr_info("%s hash table entries: %ld (order: %d, %lu bytes, %s)\n",
-		tablename, 1UL << log2qty, ilog2(size) - PAGE_SHIFT, size,
-		virt ? (huge ? "vmalloc hugepage" : "vmalloc") : "linear");
-
-	if (_hash_shift)
-		*_hash_shift = log2qty;
-	if (_hash_mask)
-		*_hash_mask = (1 << log2qty) - 1;
-
-	return table;
-}
-
 #ifdef CONFIG_CONTIG_ALLOC
 #if defined(CONFIG_DYNAMIC_DEBUG) || \
 	(defined(CONFIG_DYNAMIC_DEBUG_CORE) && defined(DYNAMIC_DEBUG_MODULE))
-- 
2.35.1

