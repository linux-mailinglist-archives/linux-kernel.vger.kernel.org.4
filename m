Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64F0D5EE972
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 00:34:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234733AbiI1Wew (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 18:34:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234582AbiI1WeZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 18:34:25 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 137E3FE66A;
        Wed, 28 Sep 2022 15:34:05 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id y2so8878999qtv.5;
        Wed, 28 Sep 2022 15:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=DEXyAVVZTwjXHLz6TLbcaFBwG1eIHET55TmuRMjtAC8=;
        b=mvoi09XGyZecBM4bUAQhNKHLRNMAyjZJsvIEtBFhl7CXvFbJQphsG5lNcE/3eysAFk
         VKG/T0mz3affytowEU/UjtHjYhPkHvVj0Ai+/tnp6AzL+u41WXFqCtnfd7YCm3i0Af7z
         dei199HOvzGCsOGRNVMy3UY3PaG1EO77MtGg7AdyhyxFmT6UvboWu+pp5fIyO/aiL3oG
         BLf963tZWwtxHm837fxn0XLrI5bpyjmbVUjlGQV+p11qUHjDRsHJW6IOIJ2FkU3H3wRa
         elmtE8tr24QaF94RaAPb2ahqb0KQN+6m61Z6yRcXYTLeb54tH6tuMmFj9Tdb4+l7s9gp
         L39A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=DEXyAVVZTwjXHLz6TLbcaFBwG1eIHET55TmuRMjtAC8=;
        b=2V4gRh1eu9XYPegYfqh2TOyteXnEhXJ+Ulu76r54CBnPZLA3BxBK8kjnbm3ZWK3S5L
         F9xHvYENrKI8SqkNTGo8X02OpXVV7r9KNQ9O3dZwWyH35aS5yxcl2WMNgM6+T68Qa38y
         e7x1uZbcl4T1DX20SbIr6hjXbLizIns9MJ1qLMOKFAKd/kI3mMIuzQEQ4ECq2w81IHzK
         2Sr9aOvM+szJim8OLb+pxqWFKe48Ur1YjKqwTDFXsvDXfmTSnlAjUkT5IbPU/govInNZ
         1hFH/24k+dkf0y6wzzD1W907jQOXv2opcjqFJxjUgrpd/mEy24eCqyOELHg37OfvJTxV
         g81A==
X-Gm-Message-State: ACrzQf0AT8weTlS3r83WfaqeoLHvgbb8suqhYLeOPXhaywGZD9PYiDqq
        3GZKAMKDuv0HXQOz5AU8/a2yANSGPMA=
X-Google-Smtp-Source: AMsMyM4zK5Ad43j5BEB/FAjyYbGE4juEGhx6jkVPsOw3+Vy3Yucdoes2I5POjKQyImNAwv8ia7KmKg==
X-Received: by 2002:ac8:5750:0:b0:35c:cb1b:2639 with SMTP id 16-20020ac85750000000b0035ccb1b2639mr41854qtx.183.1664404443601;
        Wed, 28 Sep 2022 15:34:03 -0700 (PDT)
Received: from stbirv-lnx-3.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id j188-20020a37b9c5000000b006bb83c2be40sm3963481qkf.59.2022.09.28.15.34.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 15:34:03 -0700 (PDT)
From:   Doug Berger <opendmb@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, Mike Rapoport <rppt@kernel.org>,
        Borislav Petkov <bp@suse.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Muchun Song <songmuchun@bytedance.com>,
        KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>,
        Mel Gorman <mgorman@suse.de>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Doug Berger <opendmb@gmail.com>
Subject: [PATCH v2 7/9] mm/dmb: Introduce Designated Movable Blocks
Date:   Wed, 28 Sep 2022 15:32:59 -0700
Message-Id: <20220928223301.375229-8-opendmb@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220928223301.375229-1-opendmb@gmail.com>
References: <20220928223301.375229-1-opendmb@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Designated Movable Blocks are blocks of memory that are composed
of one or more adjacent memblocks that have the MEMBLOCK_MOVABLE
designation. These blocks must be reserved before receiving that
designation and will be located in the ZONE_MOVABLE zone rather
than any other zone that may span them.

Signed-off-by: Doug Berger <opendmb@gmail.com>
---
 include/linux/dmb.h | 29 +++++++++++++++
 mm/Kconfig          | 12 ++++++
 mm/Makefile         |  1 +
 mm/dmb.c            | 91 +++++++++++++++++++++++++++++++++++++++++++++
 mm/memblock.c       |  6 ++-
 mm/page_alloc.c     | 84 ++++++++++++++++++++++++++++++++++-------
 6 files changed, 209 insertions(+), 14 deletions(-)
 create mode 100644 include/linux/dmb.h
 create mode 100644 mm/dmb.c

diff --git a/include/linux/dmb.h b/include/linux/dmb.h
new file mode 100644
index 000000000000..fa2976c0fa21
--- /dev/null
+++ b/include/linux/dmb.h
@@ -0,0 +1,29 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __DMB_H__
+#define __DMB_H__
+
+#include <linux/memblock.h>
+
+/*
+ * the buddy -- especially pageblock merging and alloc_contig_range()
+ * -- can deal with only some pageblocks of a higher-order page being
+ *  MIGRATE_MOVABLE, we can use pageblock_nr_pages.
+ */
+#define DMB_MIN_ALIGNMENT_PAGES pageblock_nr_pages
+#define DMB_MIN_ALIGNMENT_BYTES (PAGE_SIZE * DMB_MIN_ALIGNMENT_PAGES)
+
+enum {
+	DMB_DISJOINT = 0,
+	DMB_INTERSECTS,
+	DMB_MIXED,
+};
+
+struct dmb;
+
+extern int dmb_intersects(unsigned long spfn, unsigned long epfn);
+
+extern int dmb_reserve(phys_addr_t base, phys_addr_t size,
+		       struct dmb **res_dmb);
+extern void dmb_init_region(struct memblock_region *region);
+
+#endif
diff --git a/mm/Kconfig b/mm/Kconfig
index 0331f1461f81..7739edde5d4d 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -868,6 +868,18 @@ config CMA_AREAS
 
 	  If unsure, leave the default value "7" in UMA and "19" in NUMA.
 
+config DMB_COUNT
+	int "Maximum count of Designated Movable Blocks"
+	default 19 if NUMA
+	default 7
+	help
+	  Designated Movable Blocks are blocks of memory that can be used
+	  by the page allocator exclusively for movable pages. They are
+	  managed in ZONE_MOVABLE but may overlap with other zones. This
+	  parameter sets the maximum number of DMBs in the system.
+
+	  If unsure, leave the default value "7" in UMA and "19" in NUMA.
+
 config MEM_SOFT_DIRTY
 	bool "Track memory changes"
 	depends on CHECKPOINT_RESTORE && HAVE_ARCH_SOFT_DIRTY && PROC_FS
diff --git a/mm/Makefile b/mm/Makefile
index 9a564f836403..d0b469a494f2 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -67,6 +67,7 @@ obj-y += page-alloc.o
 obj-y += init-mm.o
 obj-y += memblock.o
 obj-y += $(memory-hotplug-y)
+obj-y += dmb.o
 
 ifdef CONFIG_MMU
 	obj-$(CONFIG_ADVISE_SYSCALLS)	+= madvise.o
diff --git a/mm/dmb.c b/mm/dmb.c
new file mode 100644
index 000000000000..f6c4e2662e0f
--- /dev/null
+++ b/mm/dmb.c
@@ -0,0 +1,91 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Designated Movable Block
+ */
+
+#define pr_fmt(fmt) "dmb: " fmt
+
+#include <linux/dmb.h>
+
+struct dmb {
+	unsigned long start_pfn;
+	unsigned long end_pfn;
+};
+
+static struct dmb dmb_areas[CONFIG_DMB_COUNT];
+static unsigned int dmb_area_count;
+
+int dmb_intersects(unsigned long spfn, unsigned long epfn)
+{
+	int i;
+	struct dmb *dmb;
+
+	if (spfn >= epfn)
+		return DMB_DISJOINT;
+
+	for (i = 0; i < dmb_area_count; i++) {
+		dmb = &dmb_areas[i];
+		if (spfn >= dmb->end_pfn)
+			continue;
+		if (epfn <= dmb->start_pfn)
+			return DMB_DISJOINT;
+		if (spfn >= dmb->start_pfn && epfn <= dmb->end_pfn)
+			return DMB_INTERSECTS;
+		else
+			return DMB_MIXED;
+	}
+
+	return DMB_DISJOINT;
+}
+EXPORT_SYMBOL(dmb_intersects);
+
+int __init dmb_reserve(phys_addr_t base, phys_addr_t size,
+		       struct dmb **res_dmb)
+{
+	struct dmb *dmb;
+
+	/* Sanity checks */
+	if (!size || !memblock_is_region_reserved(base, size))
+		return -EINVAL;
+
+	/* ensure minimal alignment required by mm core */
+	if (!IS_ALIGNED(base | size, DMB_MIN_ALIGNMENT_BYTES))
+		return -EINVAL;
+
+	if (dmb_area_count == ARRAY_SIZE(dmb_areas)) {
+		pr_warn("Not enough slots for DMB reserved regions!\n");
+		return -ENOSPC;
+	}
+
+	/*
+	 * Each reserved area must be initialised later, when more kernel
+	 * subsystems (like slab allocator) are available.
+	 */
+	dmb = &dmb_areas[dmb_area_count++];
+
+	dmb->start_pfn = PFN_DOWN(base);
+	dmb->end_pfn = PFN_DOWN(base + size);
+	if (res_dmb)
+		*res_dmb = dmb;
+
+	memblock_mark_movable(base, size);
+	return 0;
+}
+
+void __init dmb_init_region(struct memblock_region *region)
+{
+	unsigned long pfn;
+	int i;
+
+	for (pfn = memblock_region_memory_base_pfn(region);
+	     pfn < memblock_region_memory_end_pfn(region);
+	     pfn += pageblock_nr_pages) {
+		struct page *page = pfn_to_page(pfn);
+
+		for (i = 0; i < pageblock_nr_pages; i++)
+			set_page_zone(page + i, ZONE_MOVABLE);
+
+		/* free reserved pageblocks to page allocator */
+		init_reserved_pageblock(page);
+	}
+}
diff --git a/mm/memblock.c b/mm/memblock.c
index 5d6a210d98ec..9eb91acdeb75 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -16,6 +16,7 @@
 #include <linux/kmemleak.h>
 #include <linux/seq_file.h>
 #include <linux/memblock.h>
+#include <linux/dmb.h>
 
 #include <asm/sections.h>
 #include <linux/io.h>
@@ -2090,13 +2091,16 @@ static void __init memmap_init_reserved_pages(void)
 	for_each_reserved_mem_range(i, &start, &end)
 		reserve_bootmem_region(start, end);
 
-	/* and also treat struct pages for the NOMAP regions as PageReserved */
 	for_each_mem_region(region) {
+		/* treat struct pages for the NOMAP regions as PageReserved */
 		if (memblock_is_nomap(region)) {
 			start = region->base;
 			end = start + region->size;
 			reserve_bootmem_region(start, end);
 		}
+		/* move Designated Movable Block pages to ZONE_MOVABLE */
+		if (memblock_is_movable(region))
+			dmb_init_region(region);
 	}
 }
 
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 6d4470b0daba..cd31f26b0d21 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -75,6 +75,7 @@
 #include <linux/khugepaged.h>
 #include <linux/buffer_head.h>
 #include <linux/delayacct.h>
+#include <linux/dmb.h>
 #include <asm/sections.h>
 #include <asm/tlbflush.h>
 #include <asm/div64.h>
@@ -433,6 +434,7 @@ static unsigned long required_kernelcore __initdata;
 static unsigned long required_kernelcore_percent __initdata;
 static unsigned long required_movablecore __initdata;
 static unsigned long required_movablecore_percent __initdata;
+static unsigned long min_dmb_pfn[MAX_NUMNODES] __initdata;
 static unsigned long zone_movable_pfn[MAX_NUMNODES] __initdata;
 bool mirrored_kernelcore __initdata_memblock;
 
@@ -2165,7 +2167,7 @@ static int __init deferred_init_memmap(void *data)
 	}
 zone_empty:
 	/* Sanity check that the next zone really is unpopulated */
-	WARN_ON(++zid < MAX_NR_ZONES && populated_zone(++zone));
+	WARN_ON(++zid < ZONE_MOVABLE && populated_zone(++zone));
 
 	pr_info("node %d deferred pages initialised in %ums\n",
 		pgdat->node_id, jiffies_to_msecs(jiffies - start));
@@ -6899,6 +6901,10 @@ static void __init memmap_init_zone_range(struct zone *zone,
 	unsigned long zone_end_pfn = zone_start_pfn + zone->spanned_pages;
 	int nid = zone_to_nid(zone), zone_id = zone_idx(zone);
 
+	/* Skip overlap of ZONE_MOVABLE */
+	if (zone_id == ZONE_MOVABLE && zone_start_pfn < *hole_pfn)
+		zone_start_pfn = *hole_pfn;
+
 	start_pfn = clamp(start_pfn, zone_start_pfn, zone_end_pfn);
 	end_pfn = clamp(end_pfn, zone_start_pfn, zone_end_pfn);
 
@@ -7348,6 +7354,9 @@ static unsigned long __init zone_spanned_pages_in_node(int nid,
 				node_start_pfn, node_end_pfn,
 				zone_start_pfn, zone_end_pfn);
 
+	if (zone_type == ZONE_MOVABLE && min_dmb_pfn[nid])
+		*zone_start_pfn = min(*zone_start_pfn, min_dmb_pfn[nid]);
+
 	/* Check that this node has pages within the zone's required range */
 	if (*zone_end_pfn < node_start_pfn || *zone_start_pfn > node_end_pfn)
 		return 0;
@@ -7416,12 +7425,17 @@ static unsigned long __init zone_absent_pages_in_node(int nid,
 			&zone_start_pfn, &zone_end_pfn);
 	nr_absent = __absent_pages_in_range(nid, zone_start_pfn, zone_end_pfn);
 
+	if (zone_type == ZONE_MOVABLE && min_dmb_pfn[nid]) {
+		zone_start_pfn = min(zone_start_pfn, min_dmb_pfn[nid]);
+		nr_absent += zone_movable_pfn[nid] - zone_start_pfn;
+	}
+
 	/*
 	 * ZONE_MOVABLE handling.
-	 * Treat pages to be ZONE_MOVABLE in ZONE_NORMAL as absent pages
+	 * Treat pages to be ZONE_MOVABLE in other zones as absent pages
 	 * and vice versa.
 	 */
-	if (mirrored_kernelcore && zone_movable_pfn[nid]) {
+	if (zone_movable_pfn[nid]) {
 		unsigned long start_pfn, end_pfn;
 		struct memblock_region *r;
 
@@ -7431,6 +7445,21 @@ static unsigned long __init zone_absent_pages_in_node(int nid,
 			end_pfn = clamp(memblock_region_memory_end_pfn(r),
 					zone_start_pfn, zone_end_pfn);
 
+			if (memblock_is_movable(r)) {
+				if (zone_type != ZONE_MOVABLE) {
+					nr_absent += end_pfn - start_pfn;
+					continue;
+				}
+
+				end_pfn = min(end_pfn, zone_movable_pfn[nid]);
+				if (start_pfn < zone_movable_pfn[nid])
+					nr_absent -=  end_pfn - start_pfn;
+				continue;
+			}
+
+			if (!mirrored_kernelcore)
+				continue;
+
 			if (zone_type == ZONE_MOVABLE &&
 			    memblock_is_mirror(r))
 				nr_absent += end_pfn - start_pfn;
@@ -7450,6 +7479,15 @@ static void __init calculate_node_totalpages(struct pglist_data *pgdat,
 {
 	unsigned long realtotalpages = 0;
 	enum zone_type i;
+	int nid = pgdat->node_id;
+
+	/*
+	 * If Designated Movable Blocks are defined on this node, ensure that
+	 * zone_movable_pfn is also defined for this node.
+	 */
+	if (min_dmb_pfn[nid] && !zone_movable_pfn[nid])
+		zone_movable_pfn[nid] = min(node_end_pfn,
+				arch_zone_highest_possible_pfn[movable_zone]);
 
 	for (i = 0; i < MAX_NR_ZONES; i++) {
 		struct zone *zone = pgdat->node_zones + i;
@@ -7457,12 +7495,12 @@ static void __init calculate_node_totalpages(struct pglist_data *pgdat,
 		unsigned long spanned, absent;
 		unsigned long size, real_size;
 
-		spanned = zone_spanned_pages_in_node(pgdat->node_id, i,
+		spanned = zone_spanned_pages_in_node(nid, i,
 						     node_start_pfn,
 						     node_end_pfn,
 						     &zone_start_pfn,
 						     &zone_end_pfn);
-		absent = zone_absent_pages_in_node(pgdat->node_id, i,
+		absent = zone_absent_pages_in_node(nid, i,
 						   node_start_pfn,
 						   node_end_pfn);
 
@@ -7922,15 +7960,23 @@ unsigned long __init find_min_pfn_with_active_regions(void)
 static unsigned long __init early_calculate_totalpages(void)
 {
 	unsigned long totalpages = 0;
-	unsigned long start_pfn, end_pfn;
-	int i, nid;
+	struct memblock_region *r;
 
-	for_each_mem_pfn_range(i, MAX_NUMNODES, &start_pfn, &end_pfn, &nid) {
-		unsigned long pages = end_pfn - start_pfn;
+	for_each_mem_region(r) {
+		unsigned long start_pfn, end_pfn, pages;
+		int nid;
 
-		totalpages += pages;
-		if (pages)
+		nid = memblock_get_region_node(r);
+		start_pfn = memblock_region_memory_base_pfn(r);
+		end_pfn = memblock_region_memory_end_pfn(r);
+
+		pages = end_pfn - start_pfn;
+		if (pages) {
+			totalpages += pages;
 			node_set_state(nid, N_MEMORY);
+			if (memblock_is_movable(r) && !min_dmb_pfn[nid])
+				min_dmb_pfn[nid] = start_pfn;
+		}
 	}
 	return totalpages;
 }
@@ -7943,7 +7989,7 @@ static unsigned long __init early_calculate_totalpages(void)
  */
 static void __init find_zone_movable_pfns_for_nodes(void)
 {
-	int i, nid;
+	int nid;
 	unsigned long usable_startpfn;
 	unsigned long kernelcore_node, kernelcore_remaining;
 	/* save the state before borrow the nodemask */
@@ -8071,13 +8117,24 @@ static void __init find_zone_movable_pfns_for_nodes(void)
 		kernelcore_remaining = kernelcore_node;
 
 		/* Go through each range of PFNs within this node */
-		for_each_mem_pfn_range(i, nid, &start_pfn, &end_pfn, NULL) {
+		for_each_mem_region(r) {
 			unsigned long size_pages;
 
+			if (memblock_get_region_node(r) != nid)
+				continue;
+
+			start_pfn = memblock_region_memory_base_pfn(r);
+			end_pfn = memblock_region_memory_end_pfn(r);
 			start_pfn = max(start_pfn, zone_movable_pfn[nid]);
 			if (start_pfn >= end_pfn)
 				continue;
 
+			/* Skip over Designated Movable Blocks */
+			if (memblock_is_movable(r)) {
+				zone_movable_pfn[nid] = end_pfn;
+				continue;
+			}
+
 			/* Account for what is only usable for kernelcore */
 			if (start_pfn < usable_startpfn) {
 				unsigned long kernel_pages;
@@ -8226,6 +8283,7 @@ void __init free_area_init(unsigned long *max_zone_pfn)
 	}
 
 	/* Find the PFNs that ZONE_MOVABLE begins at in each node */
+	memset(min_dmb_pfn, 0, sizeof(min_dmb_pfn));
 	memset(zone_movable_pfn, 0, sizeof(zone_movable_pfn));
 	find_zone_movable_pfns_for_nodes();
 
-- 
2.25.1

