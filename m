Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D807873254B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 04:30:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241051AbjFPCa3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 22:30:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240254AbjFPCa1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 22:30:27 -0400
Received: from out-12.mta0.migadu.com (out-12.mta0.migadu.com [91.218.175.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30846297A
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 19:30:26 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1686882624;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=4AulDYoE3pAHZf4DySsjoslFcIuvn9gDgjSjn9hQRpg=;
        b=lUns9qrRG5dfZ9WL7/8dbCUKFyvh2GDPdEBJOsT0sfmn4HOIghJVJCuiumKzOSWrCNwWdn
        cHpKfsBtLbxyMUfqlN8qwaOJPGLM5f6guXxNSlTT4sZzhH6nbRuM61xGUJYDIiaSXHsGEW
        2ZD3fcz5S6RgsfHKRlGpYiG99Cru8/0=
From:   Yajun Deng <yajun.deng@linux.dev>
To:     akpm@linux-foundation.org, rppt@kernel.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Yajun Deng <yajun.deng@linux.dev>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v2] mm: pass nid to reserve_bootmem_region()
Date:   Fri, 16 Jun 2023 10:30:11 +0800
Message-Id: <20230616023011.2952211-1-yajun.deng@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

early_pfn_to_nid() is called frequently in init_reserved_page(), it
returns the node id of the PFN. These PFN are probably from the same
memory region, they have the same node id. It's not necessary to call
early_pfn_to_nid() for each PFN.

Pass nid to eserve_bootmem_region() and drop the call to
early_pfn_to_nid() in init_reserved_page().

The most beneficial function is memmap_init_reserved_pages() if define
CONFIG_DEFERRED_STRUCT_PAGE_INIT.
The following data was tested on x86 machine, it has 190GB RAM,

before:
memmap_init_reserved_pages()  67ms

after:
memmap_init_reserved_pages()  20ms

Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202306160145.juJMr3Bi-lkp@intel.com
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
index ff0da1858778..6dc51dc845e5 100644
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
+			nid = memblock_get_region_node(region);
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

