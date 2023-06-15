Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CFC9731608
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 13:04:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241926AbjFOLEO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 07:04:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238789AbjFOLEL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 07:04:11 -0400
Received: from out-37.mta0.migadu.com (out-37.mta0.migadu.com [91.218.175.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92B882711
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 04:04:09 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1686827047;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=HXlRY/NnvVbWtv6wBhmhQHVgYiXefGsRRYFYStrDpdY=;
        b=IwVTiMVlmdoBf+k0CgBzwHvE5l+QAJfdPLPFzzIto9INy4+dzmm8mVOLpIgIe935EyPXo5
        Eni9VHiT3AR3SV5BhfM8g9s0PLUHo26qpRkOgcK4A6KcE8Q3IXe2PyIx4K5mGmYh+Xz3Ys
        SdiZ2JNbST6+KC80ypO+aVW0mi3VimQ=
From:   Yajun Deng <yajun.deng@linux.dev>
To:     akpm@linux-foundation.org, rppt@kernel.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Yajun Deng <yajun.deng@linux.dev>
Subject: [PATCH] mm: pass nid to reserve_bootmem_region()
Date:   Thu, 15 Jun 2023 19:03:55 +0800
Message-Id: <20230615110355.1694461-1-yajun.deng@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

early_pfn_to_nid() is called frequently in init_reserved_page(),
it is used to convert PFN to node id. These PFN may belong to the same
memory region, they have the same node id. It is not necessary to call
early_pfn_to_nid() for each PFN.

Pass nid to reserve_bootmem_region() and drop the call to
early_pfn_to_nid() in init_reserved_page().

The following data was tested on my machine, it has 190GB RAM,
and enable CONFIG_DEFERRED_STRUCT_PAGE_INIT.

before the patch:
memmap_init_reserved_pages()  67ms

after the patch:
memmap_init_reserved_pages()  20ms

Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
---
 include/linux/mm.h |  3 ++-
 mm/memblock.c      |  9 ++++++---
 mm/mm_init.c       | 31 +++++++++++++++++++------------
 3 files changed, 27 insertions(+), 16 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 17317b1673b0..39e72ca6bf22 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2964,7 +2964,8 @@ extern unsigned long free_reserved_area(void *start, void *end,
 
 extern void adjust_managed_page_count(struct page *page, long count);
 
-extern void reserve_bootmem_region(phys_addr_t start, phys_addr_t end);
+extern void reserve_bootmem_region(phys_addr_t start,
+				   phys_addr_t end, int nid);
 
 /* Free the reserved page into the buddy system, so it gets managed. */
 static inline void free_reserved_page(struct page *page)
diff --git a/mm/memblock.c b/mm/memblock.c
index ff0da1858778..9e9b9a3473f9 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -2091,18 +2091,21 @@ static void __init memmap_init_reserved_pages(void)
 {
 	struct memblock_region *region;
 	phys_addr_t start, end;
+	int nid;
 	u64 i;
 
 	/* initialize struct pages for the reserved regions */
-	for_each_reserved_mem_range(i, &start, &end)
-		reserve_bootmem_region(start, end);
+	__for_each_mem_range(i, &memblock.reserved, NULL, NUMA_NO_NODE,
+			     MEMBLOCK_NONE, &start, &end, &nid)
+		reserve_bootmem_region(start, end, nid);
 
 	/* and also treat struct pages for the NOMAP regions as PageReserved */
 	for_each_mem_region(region) {
 		if (memblock_is_nomap(region)) {
 			start = region->base;
 			end = start + region->size;
-			reserve_bootmem_region(start, end);
+			nid = region->nid;
+			reserve_bootmem_region(start, end, nid);
 		}
 	}
 }
diff --git a/mm/mm_init.c b/mm/mm_init.c
index d393631599a7..1499efbebc6f 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -646,10 +646,8 @@ static inline void pgdat_set_deferred_range(pg_data_t *pgdat)
 }
 
 /* Returns true if the struct page for the pfn is initialised */
-static inline bool __meminit early_page_initialised(unsigned long pfn)
+static inline bool __meminit early_page_initialised(unsigned long pfn, int nid)
 {
-	int nid = early_pfn_to_nid(pfn);
-
 	if (node_online(nid) && pfn >= NODE_DATA(nid)->first_deferred_pfn)
 		return false;
 
@@ -695,15 +693,14 @@ defer_init(int nid, unsigned long pfn, unsigned long end_pfn)
 	return false;
 }
 
-static void __meminit init_reserved_page(unsigned long pfn)
+static void __meminit init_reserved_page(unsigned long pfn, int nid)
 {
 	pg_data_t *pgdat;
-	int nid, zid;
+	int zid;
 
-	if (early_page_initialised(pfn))
+	if (early_page_initialised(pfn, nid))
 		return;
 
-	nid = early_pfn_to_nid(pfn);
 	pgdat = NODE_DATA(nid);
 
 	for (zid = 0; zid < MAX_NR_ZONES; zid++) {
@@ -717,7 +714,7 @@ static void __meminit init_reserved_page(unsigned long pfn)
 #else
 static inline void pgdat_set_deferred_range(pg_data_t *pgdat) {}
 
-static inline bool early_page_initialised(unsigned long pfn)
+static inline bool early_page_initialised(unsigned long pfn, int nid)
 {
 	return true;
 }
@@ -727,7 +724,7 @@ static inline bool defer_init(int nid, unsigned long pfn, unsigned long end_pfn)
 	return false;
 }
 
-static inline void init_reserved_page(unsigned long pfn)
+static inline void init_reserved_page(unsigned long pfn, int nid)
 {
 }
 #endif /* CONFIG_DEFERRED_STRUCT_PAGE_INIT */
@@ -738,16 +735,20 @@ static inline void init_reserved_page(unsigned long pfn)
  * marks the pages PageReserved. The remaining valid pages are later
  * sent to the buddy page allocator.
  */
-void __meminit reserve_bootmem_region(phys_addr_t start, phys_addr_t end)
+void __meminit reserve_bootmem_region(phys_addr_t start,
+				      phys_addr_t end, int nid)
 {
 	unsigned long start_pfn = PFN_DOWN(start);
 	unsigned long end_pfn = PFN_UP(end);
 
+	if (nid == MAX_NUMNODES)
+		nid = first_online_node;
+
 	for (; start_pfn < end_pfn; start_pfn++) {
 		if (pfn_valid(start_pfn)) {
 			struct page *page = pfn_to_page(start_pfn);
 
-			init_reserved_page(start_pfn);
+			init_reserved_page(start_pfn, nid);
 
 			/* Avoid false-positive PageTail() */
 			INIT_LIST_HEAD(&page->lru);
@@ -2579,7 +2580,13 @@ void __init set_dma_reserve(unsigned long new_dma_reserve)
 void __init memblock_free_pages(struct page *page, unsigned long pfn,
 							unsigned int order)
 {
-	if (!early_page_initialised(pfn))
+	int nid = 0;
+
+#ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT
+	nid = early_pfn_to_nid(pfn);
+#endif
+
+	if (!early_page_initialised(pfn, nid))
 		return;
 	if (!kmsan_memblock_free_pages(page, order)) {
 		/* KMSAN will take care of these pages. */
-- 
2.25.1

