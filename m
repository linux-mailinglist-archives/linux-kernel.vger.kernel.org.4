Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68CD96B56D6
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 01:41:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbjCKAkw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 19:40:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230372AbjCKAkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 19:40:32 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7AA814089C;
        Fri, 10 Mar 2023 16:40:10 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id l18so7766502qtp.1;
        Fri, 10 Mar 2023 16:40:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678495209;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5jXGljhJMOsOLQ0WVWyx9Qh8aJ4axzukipUofLqyH0c=;
        b=E6LvORJlN2jcni/5ioUWmsjOnXgl7B775URlFqKgBop4b56C+en9J/o5VQci/Gr3HZ
         mDdqxrmhy35dEWIEr0ibeFXQqzumxlSJvxH0I05R+AxhZTacM9/FvPnPJwWedeUC3cvi
         pQeNNZX6OTbmRuNopd8WQ1Ls+zrYG6cPajDLFXJgfwUMMroLFQt144s5fzywH9RwVKGB
         dmBEqLB4kzE3dqcZNzL4WQn30AqT97RuhmZuQIzcafVEHXu3L1817x/L3l9h/Gi2ryuc
         MrvohJM2ORGZfictxJHfVmKJwsQQjwobLzwvo9n/kzxDzegIeFbxcKr7T/9FtgMrtnZZ
         mFBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678495209;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5jXGljhJMOsOLQ0WVWyx9Qh8aJ4axzukipUofLqyH0c=;
        b=wCrNJ4AngMSblqHI3WNxmVOo5fqFUAhrU9uwTILpP7crsDFq10YMGVRXIAKcT9/8dY
         wynqxZQ30bK4jzqVk5SFRnQsUfCftxVhBSaIv/BmQqNCdDQkcDyqHdn7K/RKy1Bjju+5
         XcwONWM8do8KmEpKh43ioreWmLid6zJv3ZCB/FLlwgcWPxBIEPoh2PZwXVfCzR7uFh7S
         P0LdbLPX9DCctsq7zQbfsjx9IcqHgrVNVUOM/oh+aalameWZbyesrDwaEUT6TppidLKv
         ss4v0CEmN4ikjn3f0vEKnksmF+MTns8ZY6G5OnXp4ml0zsPm9OCWQE7IQniW9wadXsMy
         wBCA==
X-Gm-Message-State: AO0yUKVpto3NaC/IE36gL54ro3MxQxmDp3YFSpDTVFok2UgNiQNgeYf5
        TWRjCaxaSd0t0VYF99XCYuE=
X-Google-Smtp-Source: AK7set82JZQLeG0mnfSCEhr7dXawy4oS4wEWrjbePSKQBRygykBuuvLPI0fUBxrCTyPQT+oR+bashA==
X-Received: by 2002:a05:622a:590:b0:3a7:e625:14f with SMTP id c16-20020a05622a059000b003a7e625014fmr44499078qtb.9.1678495208862;
        Fri, 10 Mar 2023 16:40:08 -0800 (PST)
Received: from stbirv-lnx-1.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id a5-20020ac84345000000b003bfaff2a6b9sm868874qtn.10.2023.03.10.16.40.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 16:40:08 -0800 (PST)
From:   Doug Berger <opendmb@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, Mike Rapoport <rppt@kernel.org>,
        Borislav Petkov <bp@suse.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Kim Phillips <kim.phillips@amd.com>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>,
        Mel Gorman <mgorman@suse.de>,
        Muchun Song <songmuchun@bytedance.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Sukadev Bhattiprolu <quic_sukadev@quicinc.com>,
        Rik van Riel <riel@surriel.com>,
        Roman Gushchin <guro@fb.com>, Minchan Kim <minchan@kernel.org>,
        Chris Goldsworthy <quic_cgoldswo@quicinc.com>,
        "Georgi Djakov" <quic_c_gdjako@quicinc.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Doug Berger <opendmb@gmail.com>
Subject: [PATCH v4 7/9] mm/dmb: Introduce Designated Movable Blocks
Date:   Fri, 10 Mar 2023 16:38:53 -0800
Message-Id: <20230311003855.645684-8-opendmb@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230311003855.645684-1-opendmb@gmail.com>
References: <20230311003855.645684-1-opendmb@gmail.com>
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
 include/linux/dmb.h | 29 ++++++++++++++
 mm/Kconfig          | 12 ++++++
 mm/Makefile         |  1 +
 mm/dmb.c            | 91 +++++++++++++++++++++++++++++++++++++++++++
 mm/memblock.c       |  6 ++-
 mm/page_alloc.c     | 95 ++++++++++++++++++++++++++++++++++++++-------
 6 files changed, 220 insertions(+), 14 deletions(-)
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
index 4751031f3f05..85ac5f136487 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -913,6 +913,18 @@ config CMA_AREAS
 
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
index 8e105e5b3e29..824be8fb11cd 100644
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
index 794a099ec3e2..3db06288a5c0 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -16,6 +16,7 @@
 #include <linux/kmemleak.h>
 #include <linux/seq_file.h>
 #include <linux/memblock.h>
+#include <linux/dmb.h>
 
 #include <asm/sections.h>
 #include <linux/io.h>
@@ -2103,13 +2104,16 @@ static void __init memmap_init_reserved_pages(void)
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
index da1af678995b..26846a9a9fc4 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -76,6 +76,7 @@
 #include <linux/khugepaged.h>
 #include <linux/buffer_head.h>
 #include <linux/delayacct.h>
+#include <linux/dmb.h>
 #include <asm/sections.h>
 #include <asm/tlbflush.h>
 #include <asm/div64.h>
@@ -414,6 +415,8 @@ static unsigned long required_kernelcore __initdata;
 static unsigned long required_kernelcore_percent __initdata;
 static unsigned long required_movablecore __initdata;
 static unsigned long required_movablecore_percent __initdata;
+static unsigned long min_dmb_pfn[MAX_NUMNODES] __initdata;
+static unsigned long max_dmb_pfn[MAX_NUMNODES] __initdata;
 static unsigned long zone_movable_pfn[MAX_NUMNODES] __initdata;
 bool mirrored_kernelcore __initdata_memblock;
 
@@ -2171,7 +2174,7 @@ static int __init deferred_init_memmap(void *data)
 	}
 zone_empty:
 	/* Sanity check that the next zone really is unpopulated */
-	WARN_ON(++zid < MAX_NR_ZONES && populated_zone(++zone));
+	WARN_ON(++zid < ZONE_MOVABLE && populated_zone(++zone));
 
 	pr_info("node %d deferred pages initialised in %ums\n",
 		pgdat->node_id, jiffies_to_msecs(jiffies - start));
@@ -7022,6 +7025,10 @@ static void __init memmap_init_zone_range(struct zone *zone,
 	unsigned long zone_end_pfn = zone_start_pfn + zone->spanned_pages;
 	int nid = zone_to_nid(zone), zone_id = zone_idx(zone);
 
+	/* Skip overlap of ZONE_MOVABLE */
+	if (zone_id == ZONE_MOVABLE && zone_start_pfn < *hole_pfn)
+		zone_start_pfn = *hole_pfn;
+
 	start_pfn = clamp(start_pfn, zone_start_pfn, zone_end_pfn);
 	end_pfn = clamp(end_pfn, zone_start_pfn, zone_end_pfn);
 
@@ -7482,6 +7489,12 @@ static unsigned long __init zone_spanned_pages_in_node(int nid,
 				node_start_pfn, node_end_pfn,
 				zone_start_pfn, zone_end_pfn);
 
+	if (zone_type == ZONE_MOVABLE && max_dmb_pfn[nid]) {
+		if (*zone_start_pfn == *zone_end_pfn)
+			*zone_end_pfn = max_dmb_pfn[nid];
+		*zone_start_pfn = min(*zone_start_pfn, min_dmb_pfn[nid]);
+	}
+
 	/* Check that this node has pages within the zone's required range */
 	if (*zone_end_pfn < node_start_pfn || *zone_start_pfn > node_end_pfn)
 		return 0;
@@ -7550,12 +7563,21 @@ static unsigned long __init zone_absent_pages_in_node(int nid,
 			&zone_start_pfn, &zone_end_pfn);
 	nr_absent = __absent_pages_in_range(nid, zone_start_pfn, zone_end_pfn);
 
+	if (zone_type == ZONE_MOVABLE && max_dmb_pfn[nid]) {
+		if (zone_start_pfn == zone_end_pfn)
+			zone_end_pfn = max_dmb_pfn[nid];
+		else
+			zone_end_pfn = zone_movable_pfn[nid];
+		zone_start_pfn = min(zone_start_pfn, min_dmb_pfn[nid]);
+		nr_absent += zone_end_pfn - zone_start_pfn;
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
 
@@ -7565,6 +7587,19 @@ static unsigned long __init zone_absent_pages_in_node(int nid,
 			end_pfn = clamp(memblock_region_memory_end_pfn(r),
 					zone_start_pfn, zone_end_pfn);
 
+			if (memblock_is_movable(r)) {
+				if (zone_type != ZONE_MOVABLE) {
+					nr_absent += end_pfn - start_pfn;
+					continue;
+				}
+
+				nr_absent -=  end_pfn - start_pfn;
+				continue;
+			}
+
+			if (!mirrored_kernelcore)
+				continue;
+
 			if (zone_type == ZONE_MOVABLE &&
 			    memblock_is_mirror(r))
 				nr_absent += end_pfn - start_pfn;
@@ -7584,18 +7619,27 @@ static void __init calculate_node_totalpages(struct pglist_data *pgdat,
 {
 	unsigned long totalpages = 0;
 	enum zone_type i;
+	int nid = pgdat->node_id;
+
+	/*
+	 * If Designated Movable Blocks are defined on this node, ensure that
+	 * zone_movable_pfn is also defined for this node.
+	 */
+	if (max_dmb_pfn[nid] && !zone_movable_pfn[nid])
+		zone_movable_pfn[nid] = min(node_end_pfn,
+				arch_zone_highest_possible_pfn[movable_zone]);
 
 	for (i = 0; i < MAX_NR_ZONES; i++) {
 		struct zone *zone = pgdat->node_zones + i;
 		unsigned long zone_start_pfn, zone_end_pfn;
 		unsigned long spanned, absent, size;
 
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
 
@@ -8047,15 +8091,27 @@ unsigned long __init node_map_pfn_alignment(void)
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
+
+		nid = memblock_get_region_node(r);
+		start_pfn = memblock_region_memory_base_pfn(r);
+		end_pfn = memblock_region_memory_end_pfn(r);
 
-		totalpages += pages;
-		if (pages)
+		pages = end_pfn - start_pfn;
+		if (pages) {
+			totalpages += pages;
 			node_set_state(nid, N_MEMORY);
+			if (memblock_is_movable(r)) {
+				if (start_pfn < min_dmb_pfn[nid])
+					min_dmb_pfn[nid] = start_pfn;
+				if (end_pfn > max_dmb_pfn[nid])
+					max_dmb_pfn[nid] = end_pfn;
+			}
+		}
 	}
 	return totalpages;
 }
@@ -8068,7 +8124,7 @@ static unsigned long __init early_calculate_totalpages(void)
  */
 static void __init find_zone_movable_pfns_for_nodes(void)
 {
-	int i, nid;
+	int nid;
 	unsigned long usable_startpfn;
 	unsigned long kernelcore_node, kernelcore_remaining;
 	/* save the state before borrow the nodemask */
@@ -8196,13 +8252,24 @@ static void __init find_zone_movable_pfns_for_nodes(void)
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
@@ -8351,6 +8418,8 @@ void __init free_area_init(unsigned long *max_zone_pfn)
 	}
 
 	/* Find the PFNs that ZONE_MOVABLE begins at in each node */
+	memset(min_dmb_pfn, 0xff, sizeof(min_dmb_pfn));
+	memset(max_dmb_pfn, 0, sizeof(max_dmb_pfn));
 	memset(zone_movable_pfn, 0, sizeof(zone_movable_pfn));
 	find_zone_movable_pfns_for_nodes();
 
-- 
2.34.1

