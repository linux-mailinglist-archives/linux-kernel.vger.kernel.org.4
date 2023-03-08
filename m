Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 021AE6B0335
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 10:42:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230123AbjCHJly (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 04:41:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbjCHJlh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 04:41:37 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62B71B1ED1
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 01:41:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 7B9C2CE1F10
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 09:41:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E1AAC4339B;
        Wed,  8 Mar 2023 09:41:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678268484;
        bh=yWy9YBr3QRwlwUhGDvVMLg0rTuhOsa1avYZumFur5Fc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g2gtD1xhW3u8pPRbZe/MH1SYrnQyB3Pg3cb3uhQHhN6UnNrqhop4CTR6FmDAcS2St
         YCjcuOxw+R2wN9J/DVCCiwFM1JQcWLMMdg1T7gVK2z2YpXDqJruWy/AlgmPjaCy147
         JGJvvZPr9xvET4zf6lp6RmFzW7BMjIPm/A2p+scS/WAQF9qM78NbN+qaLFs0wooc6t
         H+Ixc0EkDbJU229EW9sLUolO7nPNsXja4Aq4l/mDMesoTliZWImHdvrCLOpMy+NyMW
         VntaGV1oKqnqu8ipRu6ukpj4mvrmJREPGAWAm85CMkMG5ERTOgugoBXvyVkB9UWYpg
         bkJ8fmxQCrpmg==
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
Subject: [RFC PATCH 1/5] mm: intorduce __GFP_UNMAPPED and unmapped_alloc()
Date:   Wed,  8 Mar 2023 11:41:02 +0200
Message-Id: <20230308094106.227365-2-rppt@kernel.org>
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

When set_memory or set_direct_map APIs used to change attribute or
permissions for chunks of several pages, the large PMD that maps these
pages in the direct map must be split. Fragmenting the direct map in such
manner causes TLB pressure and, eventually, performance degradation.

To avoid excessive direct map fragmentation, add ability to allocate
"unmapped" pages with __GFP_UNMAPPED flag that will cause removal of the
allocated pages from the direct map and use a cache of the unmapped pages.

This cache is replenished with higher order pages with preference for
PMD_SIZE pages when possible so that there will be fewer splits of large
pages in the direct map.

The cache is implemented as a buddy allocator, so it can serve high order
allocations of unmapped pages.

Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>
---
 arch/x86/Kconfig                |   3 +
 include/linux/gfp_types.h       |  11 +-
 include/linux/page-flags.h      |   6 +
 include/linux/pageblock-flags.h |  28 +++++
 include/trace/events/mmflags.h  |  10 +-
 mm/Kconfig                      |   4 +
 mm/Makefile                     |   1 +
 mm/internal.h                   |  22 ++++
 mm/page_alloc.c                 |  29 ++++-
 mm/unmapped-alloc.c             | 215 ++++++++++++++++++++++++++++++++
 10 files changed, 325 insertions(+), 4 deletions(-)
 create mode 100644 mm/unmapped-alloc.c

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index a825bf031f49..735f691d449c 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -35,6 +35,9 @@ config X86_64
 	select ARCH_HAS_ELFCORE_COMPAT
 	select ZONE_DMA32
 
+config ARCH_WANTS_GFP_UNMAPPED
+	def_bool y if X86_64
+
 config FORCE_DYNAMIC_FTRACE
 	def_bool y
 	depends on X86_32
diff --git a/include/linux/gfp_types.h b/include/linux/gfp_types.h
index 5088637fe5c2..234122b434dd 100644
--- a/include/linux/gfp_types.h
+++ b/include/linux/gfp_types.h
@@ -60,6 +60,12 @@ typedef unsigned int __bitwise gfp_t;
 #else
 #define ___GFP_NOLOCKDEP	0
 #endif
+#ifdef CONFIG_UNMAPPED_ALLOC
+#define ___GFP_UNMAPPED		0x10000000u
+#else
+#define ___GFP_UNMAPPED		0
+#endif
+
 /* If the above are modified, __GFP_BITS_SHIFT may need updating */
 
 /*
@@ -101,12 +107,15 @@ typedef unsigned int __bitwise gfp_t;
  * node with no fallbacks or placement policy enforcements.
  *
  * %__GFP_ACCOUNT causes the allocation to be accounted to kmemcg.
+ *
+ * %__GFP_UNMAPPED removes the allocated pages from the direct map.
  */
 #define __GFP_RECLAIMABLE ((__force gfp_t)___GFP_RECLAIMABLE)
 #define __GFP_WRITE	((__force gfp_t)___GFP_WRITE)
 #define __GFP_HARDWALL   ((__force gfp_t)___GFP_HARDWALL)
 #define __GFP_THISNODE	((__force gfp_t)___GFP_THISNODE)
 #define __GFP_ACCOUNT	((__force gfp_t)___GFP_ACCOUNT)
+#define __GFP_UNMAPPED	((__force gfp_t)___GFP_UNMAPPED)
 
 /**
  * DOC: Watermark modifiers
@@ -252,7 +261,7 @@ typedef unsigned int __bitwise gfp_t;
 #define __GFP_NOLOCKDEP ((__force gfp_t)___GFP_NOLOCKDEP)
 
 /* Room for N __GFP_FOO bits */
-#define __GFP_BITS_SHIFT (27 + IS_ENABLED(CONFIG_LOCKDEP))
+#define __GFP_BITS_SHIFT (28 + IS_ENABLED(CONFIG_LOCKDEP))
 #define __GFP_BITS_MASK ((__force gfp_t)((1 << __GFP_BITS_SHIFT) - 1))
 
 /**
diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index a7e3a3405520..e66dbfdba8f2 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -922,6 +922,7 @@ static inline bool is_page_hwpoison(struct page *page)
 #define PG_offline	0x00000100
 #define PG_table	0x00000200
 #define PG_guard	0x00000400
+#define PG_unmapped	0x00000800
 
 #define PageType(page, flag)						\
 	((page->page_type & (PAGE_TYPE_BASE | flag)) == PAGE_TYPE_BASE)
@@ -992,6 +993,11 @@ PAGE_TYPE_OPS(Table, table)
  */
 PAGE_TYPE_OPS(Guard, guard)
 
+/*
+ * Marks pages in free lists of unmapped allocator.
+ */
+PAGE_TYPE_OPS(Unmapped, unmapped)
+
 extern bool is_free_buddy_page(struct page *page);
 
 PAGEFLAG(Isolated, isolated, PF_ANY);
diff --git a/include/linux/pageblock-flags.h b/include/linux/pageblock-flags.h
index 5f1ae07d724b..bb6f5ec83881 100644
--- a/include/linux/pageblock-flags.h
+++ b/include/linux/pageblock-flags.h
@@ -21,6 +21,9 @@ enum pageblock_bits {
 			/* 3 bits required for migrate types */
 	PB_migrate_skip,/* If set the block is skipped by compaction */
 
+	PB_unmapped = 7,/* if set the block has pages unmapped in the direct
+			   map */
+
 	/*
 	 * Assume the bits will always align on a word. If this assumption
 	 * changes then get/set pageblock needs updating.
@@ -95,4 +98,29 @@ static inline void set_pageblock_skip(struct page *page)
 }
 #endif /* CONFIG_COMPACTION */
 
+#ifdef CONFIG_UNMAPPED_ALLOC
+#define get_pageblock_unmapped(page)                         \
+       get_pfnblock_flags_mask(page, page_to_pfn(page),        \
+                       (1 << (PB_unmapped)))
+#define clear_pageblock_unmapped(page) \
+       set_pfnblock_flags_mask(page, 0, page_to_pfn(page),     \
+                       (1 << PB_unmapped))
+#define set_pageblock_unmapped(page) \
+       set_pfnblock_flags_mask(page, (1 << PB_unmapped),     \
+                       page_to_pfn(page),                      \
+                       (1 << PB_unmapped))
+#else /* CONFIG_UNMAPPED_ALLOC */
+static inline bool get_pageblock_unmapped(struct page *page)
+{
+       return false;
+}
+static inline void clear_pageblock_unmapped(struct page *page)
+{
+}
+static inline void set_pageblock_unmapped(struct page *page)
+{
+}
+#endif /* CONFIG_UNMAPPED_ALLOC */
+
+
 #endif	/* PAGEBLOCK_FLAGS_H */
diff --git a/include/trace/events/mmflags.h b/include/trace/events/mmflags.h
index 9db52bc4ce19..951d294a3840 100644
--- a/include/trace/events/mmflags.h
+++ b/include/trace/events/mmflags.h
@@ -61,9 +61,17 @@
 #define __def_gfpflag_names_kasan
 #endif
 
+#ifdef CONFIG_UNMAPPED_ALLOC
+#define __def_gfpflag_names_unmapped			\
+	, gfpflag_string(__GFP_UNMAPPED)
+#else
+#define __def_gfpflag_names_unmapped
+#endif
+
 #define show_gfp_flags(flags)						\
 	(flags) ? __print_flags(flags, "|",				\
-	__def_gfpflag_names __def_gfpflag_names_kasan			\
+	__def_gfpflag_names __def_gfpflag_names_kasan 			\
+	__def_gfpflag_names_unmapped					\
 	) : "none"
 
 #ifdef CONFIG_MMU
diff --git a/mm/Kconfig b/mm/Kconfig
index 4751031f3f05..404be73e00e8 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -1202,6 +1202,10 @@ config LRU_GEN_STATS
 	  This option has a per-memcg and per-node memory overhead.
 # }
 
+config UNMAPPED_ALLOC
+	def_bool y
+	depends on ARCH_WANTS_GFP_UNMAPPED
+
 source "mm/damon/Kconfig"
 
 endmenu
diff --git a/mm/Makefile b/mm/Makefile
index 8e105e5b3e29..9143303295af 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -138,3 +138,4 @@ obj-$(CONFIG_IO_MAPPING) += io-mapping.o
 obj-$(CONFIG_HAVE_BOOTMEM_INFO_NODE) += bootmem_info.o
 obj-$(CONFIG_GENERIC_IOREMAP) += ioremap.o
 obj-$(CONFIG_SHRINKER_DEBUG) += shrinker_debug.o
+obj-$(CONFIG_UNMAPPED_ALLOC) += unmapped-alloc.o
diff --git a/mm/internal.h b/mm/internal.h
index 7920a8b7982e..8d84cceab467 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1042,4 +1042,26 @@ struct vma_prepare {
 	struct vm_area_struct *remove;
 	struct vm_area_struct *remove2;
 };
+
+/*
+ * mm/unmapped-alloc.c
+ */
+#ifdef CONFIG_UNMAPPED_ALLOC
+int unmapped_alloc_init(void);
+struct page *unmapped_pages_alloc(gfp_t gfp, int order);
+void unmapped_pages_free(struct page *page, int order);
+#else
+static inline int unmapped_alloc_init(void)
+{
+	return 0;
+}
+
+static inline struct page *unmapped_pages_alloc(gfp_t gfp, int order)
+{
+	return NULL;
+}
+
+static inline void unmapped_pages_free(struct page *page, int order) {}
+#endif
+
 #endif	/* __MM_INTERNAL_H */
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index ac1fc986af44..01f18e7529b0 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -589,7 +589,7 @@ void set_pfnblock_flags_mask(struct page *page, unsigned long flags,
 	unsigned long bitidx, word_bitidx;
 	unsigned long word;
 
-	BUILD_BUG_ON(NR_PAGEBLOCK_BITS != 4);
+	BUILD_BUG_ON(NR_PAGEBLOCK_BITS != 8);
 	BUILD_BUG_ON(MIGRATE_TYPES > (1 << PB_migratetype_bits));
 
 	bitmap = get_pageblock_bitmap(page, pfn);
@@ -746,6 +746,13 @@ static inline bool pcp_allowed_order(unsigned int order)
 	return false;
 }
 
+static inline bool pcp_allowed(unsigned int order, gfp_t gfp)
+{
+	if (unlikely(gfp & __GFP_UNMAPPED))
+		return false;
+	return pcp_allowed_order(order);
+}
+
 static inline void free_the_page(struct page *page, unsigned int order)
 {
 	if (pcp_allowed_order(order))		/* Via pcp? */
@@ -1460,6 +1467,11 @@ static __always_inline bool free_pages_prepare(struct page *page,
 					   PAGE_SIZE << order);
 	}
 
+	if (get_pageblock_unmapped(page)) {
+		unmapped_pages_free(page, order);
+		return false;
+	}
+
 	kernel_poison_pages(page, 1 << order);
 
 	/*
@@ -3525,6 +3537,13 @@ void free_unref_page_list(struct list_head *list)
 	/* Prepare pages for freeing */
 	list_for_each_entry_safe(page, next, list, lru) {
 		unsigned long pfn = page_to_pfn(page);
+
+		if (get_pageblock_unmapped(page)) {
+			list_del(&page->lru);
+			unmapped_pages_free(page, 0);
+			continue;
+		}
+
 		if (!free_unref_page_prepare(page, pfn, 0)) {
 			list_del(&page->lru);
 			continue;
@@ -3856,7 +3875,7 @@ struct page *rmqueue(struct zone *preferred_zone,
 	 */
 	WARN_ON_ONCE((gfp_flags & __GFP_NOFAIL) && (order > 1));
 
-	if (likely(pcp_allowed_order(order))) {
+	if (likely(pcp_allowed(order, gfp_flags))) {
 		/*
 		 * MIGRATE_MOVABLE pcplist could have the pages on CMA area and
 		 * we need to skip it when CMA area isn't allowed.
@@ -5581,6 +5600,11 @@ struct page *__alloc_pages(gfp_t gfp, unsigned int order, int preferred_nid,
 			&alloc_gfp, &alloc_flags))
 		return NULL;
 
+	if (alloc_gfp & __GFP_UNMAPPED) {
+		page = unmapped_pages_alloc(gfp, order);
+		goto out;
+	}
+
 	/*
 	 * Forbid the first pass from falling back to types that fragment
 	 * memory until all local zones are considered.
@@ -8437,6 +8461,7 @@ void __init free_area_init(unsigned long *max_zone_pfn)
 	}
 
 	memmap_init();
+	unmapped_alloc_init();
 }
 
 static int __init cmdline_parse_core(char *p, unsigned long *core,
diff --git a/mm/unmapped-alloc.c b/mm/unmapped-alloc.c
new file mode 100644
index 000000000000..fb2d54204a3c
--- /dev/null
+++ b/mm/unmapped-alloc.c
@@ -0,0 +1,215 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/gfp.h>
+#include <linux/mmzone.h>
+#include <linux/printk.h>
+#include <linux/spinlock.h>
+#include <linux/set_memory.h>
+
+#include <asm/tlbflush.h>
+
+#include "internal.h"
+
+struct unmapped_free_area {
+	struct list_head	free_list;
+	spinlock_t		lock;
+	unsigned long		nr_free;
+	unsigned long		nr_cached;
+};
+
+static struct unmapped_free_area free_area[MAX_ORDER];
+
+static inline void add_to_free_list(struct page *page, unsigned int order)
+{
+	struct unmapped_free_area *area = &free_area[order];
+
+	list_add(&page->buddy_list, &area->free_list);
+	area->nr_free++;
+}
+
+static inline void del_page_from_free_list(struct page *page, unsigned int order)
+{
+	list_del(&page->buddy_list);
+	__ClearPageUnmapped(page);
+	set_page_private(page, 0);
+	free_area[order].nr_free--;
+}
+
+static inline void set_unmapped_order(struct page *page, unsigned int order)
+{
+	set_page_private(page, order);
+	__SetPageUnmapped(page);
+}
+
+static inline bool page_is_unmapped_buddy(struct page *page, struct page *buddy,
+					  unsigned int order)
+{
+	if (!PageUnmapped(buddy))
+		return false;
+
+	if (buddy_order(buddy) != order)
+		return false;
+
+	return true;
+}
+
+static struct page *find_unmapped_buddy_page_pfn(struct page *page,
+						 unsigned long pfn,
+						 unsigned int order,
+						 unsigned long *buddy_pfn)
+{
+	unsigned long __buddy_pfn = __find_buddy_pfn(pfn, order);
+	struct page *buddy;
+
+	buddy = page + (__buddy_pfn - pfn);
+	if (buddy_pfn)
+		*buddy_pfn = __buddy_pfn;
+
+	if (page_is_unmapped_buddy(page, buddy, order))
+		return buddy;
+
+	return NULL;
+}
+
+static inline void __free_one_page(struct page *page, unsigned int order,
+				   bool cache_refill)
+{
+	unsigned long pfn = page_to_pfn(page);
+	unsigned long buddy_pfn;
+	unsigned long combined_pfn;
+	struct page *buddy;
+	unsigned long flags;
+
+	spin_lock_irqsave(&free_area->lock, flags);
+
+	if (cache_refill) {
+		set_pageblock_unmapped(page);
+		free_area[order].nr_cached++;
+	}
+
+	while (order < MAX_ORDER - 1) {
+		buddy = find_unmapped_buddy_page_pfn(page, pfn, order,
+						     &buddy_pfn);
+		if (!buddy)
+			break;
+
+		del_page_from_free_list(buddy, order);
+		combined_pfn = buddy_pfn & pfn;
+		page = page + (combined_pfn - pfn);
+		pfn = combined_pfn;
+		order++;
+	}
+
+	set_unmapped_order(page, order);
+	add_to_free_list(page, order);
+	spin_unlock_irqrestore(&free_area->lock, flags);
+}
+
+static inline void expand(struct page *page, int low, int high)
+{
+	unsigned long size = 1 << high;
+
+	while (high > low) {
+		high--;
+		size >>= 1;
+
+		add_to_free_list(&page[size], high);
+		set_unmapped_order(&page[size], high);
+	}
+}
+
+static struct page *__rmqueue_smallest(unsigned int order)
+{
+	unsigned int current_order;
+	struct unmapped_free_area *area;
+	struct page *page = NULL;
+	unsigned long flags;
+
+	spin_lock_irqsave(&free_area->lock, flags);
+
+	/* Find a page of the appropriate size in the preferred list */
+	for (current_order = order; current_order < MAX_ORDER; ++current_order) {
+		area = &free_area[current_order];
+		page = list_first_entry_or_null(&area->free_list, struct page,
+						lru);
+		if (!page)
+			continue;
+
+		del_page_from_free_list(page, current_order);
+		expand(page, order, current_order);
+
+		break;
+	}
+
+	spin_unlock_irqrestore(&free_area->lock, flags);
+
+	return page;
+}
+
+/* FIXME: have PMD_ORDER at last available in include/linux */
+#define PMD_ORDER	(PMD_SHIFT - PAGE_SHIFT)
+
+struct page *unmapped_pages_alloc(gfp_t gfp, int order)
+{
+
+	int cache_order = PMD_ORDER;
+	struct page *page;
+
+	page = __rmqueue_smallest(order);
+	if (page)
+		goto out;
+
+	gfp &= ~__GFP_UNMAPPED;
+	while (cache_order >= order) {
+		page = alloc_pages(gfp | __GFP_ZERO, cache_order);
+		if (page)
+			break;
+		cache_order--;
+	}
+
+	if (page) {
+		unsigned long addr = (unsigned long)page_address(page);
+		unsigned long nr_pages = (1 << order);
+		unsigned long size = PAGE_SIZE * nr_pages;
+
+		/* FIXME: set_direct_map_invalid_noflush may fail */
+		for (int i = 0; i < nr_pages; i++)
+			set_direct_map_invalid_noflush(page + i);
+
+		flush_tlb_kernel_range(addr, addr + size);
+
+		/*
+		 * FIXME: have this under lock so that allocation running
+		 * in parallel won't steal all pages from the newly cached
+		 * ones
+		 */
+		__free_one_page(page, cache_order, true);
+		page = __rmqueue_smallest(order);
+
+	}
+
+out:
+	if (page) {
+		/* FIXME: __prep_new_page() expects page count of 0 */
+		set_page_count(page, 0);
+		post_alloc_hook(page, order, GFP_KERNEL);
+	}
+
+	return page;
+}
+
+void unmapped_pages_free(struct page *page, int order)
+{
+	__free_one_page(page, order, false);
+}
+
+int unmapped_alloc_init(void)
+{
+	for (int order = 0; order < MAX_ORDER; order++) {
+		struct unmapped_free_area *area = &free_area[order];
+		INIT_LIST_HEAD(&area->free_list);
+		spin_lock_init(&area->lock);
+	}
+
+	return 0;
+}
-- 
2.35.1

