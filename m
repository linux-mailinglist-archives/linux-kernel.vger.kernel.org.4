Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 696856B0336
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 10:42:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbjCHJl5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 04:41:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbjCHJlj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 04:41:39 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3497B53E1
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 01:41:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 72C626170A
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 09:41:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78284C433A4;
        Wed,  8 Mar 2023 09:41:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678268492;
        bh=8DLovPxnQy1OCrJZdJAEGK7t0D40yssgi5Mxz0RgWek=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V6FAK2+t6gSHB91y9VkD/0zOfXhNUhq+sMc5AX4IQuRsdMaWCpYJCn1tHJeqYnOLY
         RWQ8R3BcCx3KjA7HQiX4FWRwiXskDus+nGuTU/h7Wao7lKZmWu32p94flaMQoKhkjv
         nL3jFqNz9nbN+CXPwNbIimjP38J1yfRIKOOiHu1l6hqqXu2wHBe6fikO0N0rwDw4rV
         jpSOfwYDrUpzaXm9lANUnmHiYWQ34T2LFwbVrf8z2Ilhgv3JEnwwcpcBlhfjLrjayl
         W8CcmajJxQHjkRZKa9pmK4E32ysqR4p5Fy+FD17Vl8xGoLMRnRfcR+TZrgX9jnjemr
         Axe7yl8DldgkA==
From:   Mike Rapoport <rppt@kernel.org>
To:     linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Mike Rapoport <rppt@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Song Liu <song@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        x86@kernel.org
Subject: [RFC PATCH 3/5] mm/unmapped_alloc: add shrinker
Date:   Wed,  8 Mar 2023 11:41:04 +0200
Message-Id: <20230308094106.227365-4-rppt@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230308094106.227365-1-rppt@kernel.org>
References: <20230308094106.227365-1-rppt@kernel.org>
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

Allow shrinking unmapped caches when there is a memory pressure.

Signed-off-by: Mike Rapoport(IBM) <rppt@kernel.org>
---
 mm/internal.h       |  2 ++
 mm/page_alloc.c     | 12 ++++++-
 mm/unmapped-alloc.c | 86 ++++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 98 insertions(+), 2 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index 8d84cceab467..aa2934594dcf 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1064,4 +1064,6 @@ static inline struct page *unmapped_pages_alloc(gfp_t gfp, int order)
 static inline void unmapped_pages_free(struct page *page, int order) {}
 #endif
 
+void __free_unmapped_page(struct page *page, unsigned int order);
+
 #endif	/* __MM_INTERNAL_H */
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 01f18e7529b0..ece213fac27a 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -123,6 +123,11 @@ typedef int __bitwise fpi_t;
  */
 #define FPI_SKIP_KASAN_POISON	((__force fpi_t)BIT(2))
 
+/*
+ * Free pages from the unmapped cache
+ */
+#define FPI_UNMAPPED		((__force fpi_t)BIT(3))
+
 /* prevent >1 _updater_ of zone percpu pageset ->high and ->batch fields */
 static DEFINE_MUTEX(pcp_batch_high_lock);
 #define MIN_PERCPU_PAGELIST_HIGH_FRACTION (8)
@@ -1467,7 +1472,7 @@ static __always_inline bool free_pages_prepare(struct page *page,
 					   PAGE_SIZE << order);
 	}
 
-	if (get_pageblock_unmapped(page)) {
+	if (!(fpi_flags & FPI_UNMAPPED) && get_pageblock_unmapped(page)) {
 		unmapped_pages_free(page, order);
 		return false;
 	}
@@ -1636,6 +1641,11 @@ static void free_one_page(struct zone *zone,
 	spin_unlock_irqrestore(&zone->lock, flags);
 }
 
+void __free_unmapped_page(struct page *page, unsigned int order)
+{
+	__free_pages_ok(page, order, FPI_UNMAPPED | FPI_TO_TAIL);
+}
+
 static void __meminit __init_single_page(struct page *page, unsigned long pfn,
 				unsigned long zone, int nid)
 {
diff --git a/mm/unmapped-alloc.c b/mm/unmapped-alloc.c
index f74640e9ce9f..89f54383df92 100644
--- a/mm/unmapped-alloc.c
+++ b/mm/unmapped-alloc.c
@@ -4,6 +4,7 @@
 #include <linux/mmzone.h>
 #include <linux/printk.h>
 #include <linux/debugfs.h>
+#include <linux/shrinker.h>
 #include <linux/spinlock.h>
 #include <linux/set_memory.h>
 
@@ -16,6 +17,7 @@ struct unmapped_free_area {
 	spinlock_t		lock;
 	unsigned long		nr_free;
 	unsigned long		nr_cached;
+	unsigned long		nr_released;
 };
 
 static struct unmapped_free_area free_area[MAX_ORDER];
@@ -204,6 +206,82 @@ void unmapped_pages_free(struct page *page, int order)
 	__free_one_page(page, order, false);
 }
 
+static unsigned long unmapped_alloc_count_objects(struct shrinker *sh,
+						  struct shrink_control *sc)
+{
+	unsigned long pages_to_free = 0;
+
+	for (int order = 0; order < MAX_ORDER; order++)
+		pages_to_free += (free_area[order].nr_free << order);
+
+	return pages_to_free;
+}
+
+static unsigned long scan_free_area(struct shrink_control *sc, int order)
+{
+	struct unmapped_free_area *area = &free_area[order];
+	unsigned long nr_pages = (1 << order);
+	unsigned long pages_freed = 0;
+	unsigned long flags;
+	struct page *page;
+
+	spin_lock_irqsave(&area->lock, flags);
+	while (pages_freed < sc->nr_to_scan) {
+
+		page = list_first_entry_or_null(&area->free_list, struct page,
+						lru);
+		if (!page)
+			break;
+
+		del_page_from_free_list(page, order);
+		expand(page, order, order);
+
+		area->nr_released++;
+
+		if (order == pageblock_order)
+			clear_pageblock_unmapped(page);
+
+		spin_unlock_irqrestore(&area->lock, flags);
+
+		for (int i = 0; i < nr_pages; i++)
+			set_direct_map_default_noflush(page + i);
+
+		__free_unmapped_page(page, order);
+
+		pages_freed += nr_pages;
+
+		cond_resched();
+		spin_lock_irqsave(&area->lock, flags);
+	}
+
+	spin_unlock_irqrestore(&area->lock, flags);
+
+	return pages_freed;
+}
+
+static unsigned long unmapped_alloc_scan_objects(struct shrinker *shrinker,
+						 struct shrink_control *sc)
+{
+	sc->nr_scanned = 0;
+
+	for (int order = 0; order < MAX_ORDER; order++) {
+		sc->nr_scanned += scan_free_area(sc, order);
+
+		if (sc->nr_scanned >= sc->nr_to_scan)
+			break;
+
+		sc->nr_to_scan -= sc->nr_scanned;
+	}
+
+	return sc->nr_scanned ? sc->nr_scanned : SHRINK_STOP;
+}
+
+static struct shrinker shrinker = {
+	.count_objects	= unmapped_alloc_count_objects,
+	.scan_objects	= unmapped_alloc_scan_objects,
+	.seeks		= DEFAULT_SEEKS,
+};
+
 int unmapped_alloc_init(void)
 {
 	for (int order = 0; order < MAX_ORDER; order++) {
@@ -237,6 +315,11 @@ static int unmapped_alloc_debug_show(struct seq_file *m, void *private)
 		seq_printf(m, "%5lu ", free_area[order].nr_cached);
 	seq_putc(m, '\n');
 
+	seq_printf(m, "%-10s", "Released:");
+	for (order = 0; order < MAX_ORDER; ++order)
+		seq_printf(m, "%5lu ", free_area[order].nr_released);
+	seq_putc(m, '\n');
+
 	return 0;
 }
 DEFINE_SHOW_ATTRIBUTE(unmapped_alloc_debug);
@@ -245,6 +328,7 @@ static int __init unmapped_alloc_init_late(void)
 {
 	debugfs_create_file("unmapped_alloc", 0444, NULL,
 			    NULL, &unmapped_alloc_debug_fops);
-	return 0;
+
+	return register_shrinker(&shrinker, "mm-unmapped-alloc");
 }
 late_initcall(unmapped_alloc_init_late);
-- 
2.35.1

