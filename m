Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 818BB724D68
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 21:44:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239519AbjFFTnt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 15:43:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239272AbjFFTmp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 15:42:45 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F078610FF;
        Tue,  6 Jun 2023 12:42:42 -0700 (PDT)
Date:   Tue, 06 Jun 2023 19:42:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686080561;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KjnzqfWbKN0lWTQevjZg+jFIEJw+nyPMD6D3jbh7A7g=;
        b=v+m9PW596Dr4ZvmJ2sP04RyYJV1+JSyJFwq6d9sEJsO4LCUGkQUjmTpEkVSm37wVN6HBQa
        fYza8bL/KzGzgM3RZg16NJ2Ro54piXAQOEWl9rmLW+G5slafMo1oAr5M9V8vvNwYKW2bPT
        mtNA5LMjiXD+YSI7Rz5etZ0Fy0W55J2kx55eGUlR2RfRT1m443Eya/RcAN1lZPmFmoZYSQ
        n8XF1Zuvtj4HXqMUWp4r5B1t6etHIb1NjQ5jkunjCZLZN6GUiD61mBZpZ1lpJr9//H5oEQ
        bXq8hjLs3EHXzxtuYhL+Zu5UOAmD5jdnHhfZY2/ytk+turjjxwwE9R5Ywyn8/A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686080561;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KjnzqfWbKN0lWTQevjZg+jFIEJw+nyPMD6D3jbh7A7g=;
        b=Zu1IoARc0xGBwnNB+7PyKHJXT6q8obReDLHvKRCfBw0k+vL58cUmT7YV1VGxeUqXRezzqF
        K8Y0euBypSaasJBQ==
From:   "tip-bot2 for Kirill A. Shutemov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cc] mm: Add support for unaccepted memory
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mike Rapoport <rppt@linux.ibm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230606142637.5171-2-kirill.shutemov@linux.intel.com>
References: <20230606142637.5171-2-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Message-ID: <168608056109.404.15658636823816200955.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/cc branch of tip:

Commit-ID:     dcdfdd40fa82b6704d2841938e5c8ec3051eb0d6
Gitweb:        https://git.kernel.org/tip/dcdfdd40fa82b6704d2841938e5c8ec3051eb0d6
Author:        Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
AuthorDate:    Tue, 06 Jun 2023 17:26:29 +03:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 06 Jun 2023 16:38:22 +02:00

mm: Add support for unaccepted memory

UEFI Specification version 2.9 introduces the concept of memory
acceptance. Some Virtual Machine platforms, such as Intel TDX or AMD
SEV-SNP, require memory to be accepted before it can be used by the
guest. Accepting happens via a protocol specific to the Virtual Machine
platform.

There are several ways the kernel can deal with unaccepted memory:

 1. Accept all the memory during boot. It is easy to implement and it
    doesn't have runtime cost once the system is booted. The downside is
    very long boot time.

    Accept can be parallelized to multiple CPUs to keep it manageable
    (i.e. via DEFERRED_STRUCT_PAGE_INIT), but it tends to saturate
    memory bandwidth and does not scale beyond the point.

 2. Accept a block of memory on the first use. It requires more
    infrastructure and changes in page allocator to make it work, but
    it provides good boot time.

    On-demand memory accept means latency spikes every time kernel steps
    onto a new memory block. The spikes will go away once workload data
    set size gets stabilized or all memory gets accepted.

 3. Accept all memory in background. Introduce a thread (or multiple)
    that gets memory accepted proactively. It will minimize time the
    system experience latency spikes on memory allocation while keeping
    low boot time.

    This approach cannot function on its own. It is an extension of #2:
    background memory acceptance requires functional scheduler, but the
    page allocator may need to tap into unaccepted memory before that.

    The downside of the approach is that these threads also steal CPU
    cycles and memory bandwidth from the user's workload and may hurt
    user experience.

Implement #1 and #2 for now. #2 is the default. Some workloads may want
to use #1 with accept_memory=eager in kernel command line. #3 can be
implemented later based on user's demands.

Support of unaccepted memory requires a few changes in core-mm code:

  - memblock accepts memory on allocation. It serves early boot memory
    allocations and doesn't limit them to pre-accepted pool of memory.

  - page allocator accepts memory on the first allocation of the page.
    When kernel runs out of accepted memory, it accepts memory until the
    high watermark is reached. It helps to minimize fragmentation.

EFI code will provide two helpers if the platform supports unaccepted
memory:

 - accept_memory() makes a range of physical addresses accepted.

 - range_contains_unaccepted_memory() checks anything within the range
   of physical addresses requires acceptance.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Acked-by: Mike Rapoport <rppt@linux.ibm.com>	# memblock
Link: https://lore.kernel.org/r/20230606142637.5171-2-kirill.shutemov@linux.intel.com
---
 drivers/base/node.c    |   7 ++-
 fs/proc/meminfo.c      |   5 +-
 include/linux/mm.h     |  19 ++++-
 include/linux/mmzone.h |   8 ++-
 mm/memblock.c          |   9 ++-
 mm/mm_init.c           |   7 ++-
 mm/page_alloc.c        | 173 ++++++++++++++++++++++++++++++++++++++++-
 mm/vmstat.c            |   3 +-
 8 files changed, 231 insertions(+)

diff --git a/drivers/base/node.c b/drivers/base/node.c
index b46db17..6559759 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -449,6 +449,9 @@ static ssize_t node_read_meminfo(struct device *dev,
 			     "Node %d FileHugePages: %8lu kB\n"
 			     "Node %d FilePmdMapped: %8lu kB\n"
 #endif
+#ifdef CONFIG_UNACCEPTED_MEMORY
+			     "Node %d Unaccepted:     %8lu kB\n"
+#endif
 			     ,
 			     nid, K(node_page_state(pgdat, NR_FILE_DIRTY)),
 			     nid, K(node_page_state(pgdat, NR_WRITEBACK)),
@@ -478,6 +481,10 @@ static ssize_t node_read_meminfo(struct device *dev,
 			     nid, K(node_page_state(pgdat, NR_FILE_THPS)),
 			     nid, K(node_page_state(pgdat, NR_FILE_PMDMAPPED))
 #endif
+#ifdef CONFIG_UNACCEPTED_MEMORY
+			     ,
+			     nid, K(sum_zone_node_page_state(nid, NR_UNACCEPTED))
+#endif
 			    );
 	len += hugetlb_report_node_meminfo(buf, len, nid);
 	return len;
diff --git a/fs/proc/meminfo.c b/fs/proc/meminfo.c
index b43d0bd..8dca4d6 100644
--- a/fs/proc/meminfo.c
+++ b/fs/proc/meminfo.c
@@ -168,6 +168,11 @@ static int meminfo_proc_show(struct seq_file *m, void *v)
 		    global_zone_page_state(NR_FREE_CMA_PAGES));
 #endif
 
+#ifdef CONFIG_UNACCEPTED_MEMORY
+	show_val_kb(m, "Unaccepted:     ",
+		    global_zone_page_state(NR_UNACCEPTED));
+#endif
+
 	hugetlb_report_meminfo(m);
 
 	arch_report_meminfo(m);
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 27ce770..d9174d4 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3816,4 +3816,23 @@ madvise_set_anon_name(struct mm_struct *mm, unsigned long start,
 }
 #endif
 
+#ifdef CONFIG_UNACCEPTED_MEMORY
+
+bool range_contains_unaccepted_memory(phys_addr_t start, phys_addr_t end);
+void accept_memory(phys_addr_t start, phys_addr_t end);
+
+#else
+
+static inline bool range_contains_unaccepted_memory(phys_addr_t start,
+						    phys_addr_t end)
+{
+	return false;
+}
+
+static inline void accept_memory(phys_addr_t start, phys_addr_t end)
+{
+}
+
+#endif
+
 #endif /* _LINUX_MM_H */
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index a4889c9..6c1c2fc 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -143,6 +143,9 @@ enum zone_stat_item {
 	NR_ZSPAGES,		/* allocated in zsmalloc */
 #endif
 	NR_FREE_CMA_PAGES,
+#ifdef CONFIG_UNACCEPTED_MEMORY
+	NR_UNACCEPTED,
+#endif
 	NR_VM_ZONE_STAT_ITEMS };
 
 enum node_stat_item {
@@ -910,6 +913,11 @@ struct zone {
 	/* free areas of different sizes */
 	struct free_area	free_area[MAX_ORDER + 1];
 
+#ifdef CONFIG_UNACCEPTED_MEMORY
+	/* Pages to be accepted. All pages on the list are MAX_ORDER */
+	struct list_head	unaccepted_pages;
+#endif
+
 	/* zone flags, see below */
 	unsigned long		flags;
 
diff --git a/mm/memblock.c b/mm/memblock.c
index 3feafea..50b9211 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -1436,6 +1436,15 @@ done:
 		 */
 		kmemleak_alloc_phys(found, size, 0);
 
+	/*
+	 * Some Virtual Machine platforms, such as Intel TDX or AMD SEV-SNP,
+	 * require memory to be accepted before it can be used by the
+	 * guest.
+	 *
+	 * Accept the memory of the allocated buffer.
+	 */
+	accept_memory(found, found + size);
+
 	return found;
 }
 
diff --git a/mm/mm_init.c b/mm/mm_init.c
index 7f7f9c6..1cfc08e 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -1375,6 +1375,10 @@ static void __meminit zone_init_free_lists(struct zone *zone)
 		INIT_LIST_HEAD(&zone->free_area[order].free_list[t]);
 		zone->free_area[order].nr_free = 0;
 	}
+
+#ifdef CONFIG_UNACCEPTED_MEMORY
+	INIT_LIST_HEAD(&zone->unaccepted_pages);
+#endif
 }
 
 void __meminit init_currently_empty_zone(struct zone *zone,
@@ -1960,6 +1964,9 @@ static void __init deferred_free_range(unsigned long pfn,
 		return;
 	}
 
+	/* Accept chunks smaller than MAX_ORDER upfront */
+	accept_memory(PFN_PHYS(pfn), PFN_PHYS(pfn + nr_pages));
+
 	for (i = 0; i < nr_pages; i++, page++, pfn++) {
 		if (pageblock_aligned(pfn))
 			set_pageblock_migratetype(page, MIGRATE_MOVABLE);
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 47421be..d239fba 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -387,6 +387,12 @@ EXPORT_SYMBOL(nr_node_ids);
 EXPORT_SYMBOL(nr_online_nodes);
 #endif
 
+static bool page_contains_unaccepted(struct page *page, unsigned int order);
+static void accept_page(struct page *page, unsigned int order);
+static bool try_to_accept_memory(struct zone *zone, unsigned int order);
+static inline bool has_unaccepted_memory(void);
+static bool __free_unaccepted(struct page *page);
+
 int page_group_by_mobility_disabled __read_mostly;
 
 #ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT
@@ -1481,6 +1487,13 @@ void __free_pages_core(struct page *page, unsigned int order)
 
 	atomic_long_add(nr_pages, &page_zone(page)->managed_pages);
 
+	if (page_contains_unaccepted(page, order)) {
+		if (order == MAX_ORDER && __free_unaccepted(page))
+			return;
+
+		accept_page(page, order);
+	}
+
 	/*
 	 * Bypass PCP and place fresh pages right to the tail, primarily
 	 * relevant for memory onlining.
@@ -3159,6 +3172,9 @@ static inline long __zone_watermark_unusable_free(struct zone *z,
 	if (!(alloc_flags & ALLOC_CMA))
 		unusable_free += zone_page_state(z, NR_FREE_CMA_PAGES);
 #endif
+#ifdef CONFIG_UNACCEPTED_MEMORY
+	unusable_free += zone_page_state(z, NR_UNACCEPTED);
+#endif
 
 	return unusable_free;
 }
@@ -3458,6 +3474,11 @@ retry:
 				       gfp_mask)) {
 			int ret;
 
+			if (has_unaccepted_memory()) {
+				if (try_to_accept_memory(zone, order))
+					goto try_this_zone;
+			}
+
 #ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT
 			/*
 			 * Watermark failed for this zone, but see if we can
@@ -3510,6 +3531,11 @@ try_this_zone:
 
 			return page;
 		} else {
+			if (has_unaccepted_memory()) {
+				if (try_to_accept_memory(zone, order))
+					goto try_this_zone;
+			}
+
 #ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT
 			/* Try again if zone has deferred pages */
 			if (deferred_pages_enabled()) {
@@ -7215,3 +7241,150 @@ bool has_managed_dma(void)
 	return false;
 }
 #endif /* CONFIG_ZONE_DMA */
+
+#ifdef CONFIG_UNACCEPTED_MEMORY
+
+/* Counts number of zones with unaccepted pages. */
+static DEFINE_STATIC_KEY_FALSE(zones_with_unaccepted_pages);
+
+static bool lazy_accept = true;
+
+static int __init accept_memory_parse(char *p)
+{
+	if (!strcmp(p, "lazy")) {
+		lazy_accept = true;
+		return 0;
+	} else if (!strcmp(p, "eager")) {
+		lazy_accept = false;
+		return 0;
+	} else {
+		return -EINVAL;
+	}
+}
+early_param("accept_memory", accept_memory_parse);
+
+static bool page_contains_unaccepted(struct page *page, unsigned int order)
+{
+	phys_addr_t start = page_to_phys(page);
+	phys_addr_t end = start + (PAGE_SIZE << order);
+
+	return range_contains_unaccepted_memory(start, end);
+}
+
+static void accept_page(struct page *page, unsigned int order)
+{
+	phys_addr_t start = page_to_phys(page);
+
+	accept_memory(start, start + (PAGE_SIZE << order));
+}
+
+static bool try_to_accept_memory_one(struct zone *zone)
+{
+	unsigned long flags;
+	struct page *page;
+	bool last;
+
+	if (list_empty(&zone->unaccepted_pages))
+		return false;
+
+	spin_lock_irqsave(&zone->lock, flags);
+	page = list_first_entry_or_null(&zone->unaccepted_pages,
+					struct page, lru);
+	if (!page) {
+		spin_unlock_irqrestore(&zone->lock, flags);
+		return false;
+	}
+
+	list_del(&page->lru);
+	last = list_empty(&zone->unaccepted_pages);
+
+	__mod_zone_freepage_state(zone, -MAX_ORDER_NR_PAGES, MIGRATE_MOVABLE);
+	__mod_zone_page_state(zone, NR_UNACCEPTED, -MAX_ORDER_NR_PAGES);
+	spin_unlock_irqrestore(&zone->lock, flags);
+
+	accept_page(page, MAX_ORDER);
+
+	__free_pages_ok(page, MAX_ORDER, FPI_TO_TAIL);
+
+	if (last)
+		static_branch_dec(&zones_with_unaccepted_pages);
+
+	return true;
+}
+
+static bool try_to_accept_memory(struct zone *zone, unsigned int order)
+{
+	long to_accept;
+	int ret = false;
+
+	/* How much to accept to get to high watermark? */
+	to_accept = high_wmark_pages(zone) -
+		    (zone_page_state(zone, NR_FREE_PAGES) -
+		    __zone_watermark_unusable_free(zone, order, 0));
+
+	/* Accept at least one page */
+	do {
+		if (!try_to_accept_memory_one(zone))
+			break;
+		ret = true;
+		to_accept -= MAX_ORDER_NR_PAGES;
+	} while (to_accept > 0);
+
+	return ret;
+}
+
+static inline bool has_unaccepted_memory(void)
+{
+	return static_branch_unlikely(&zones_with_unaccepted_pages);
+}
+
+static bool __free_unaccepted(struct page *page)
+{
+	struct zone *zone = page_zone(page);
+	unsigned long flags;
+	bool first = false;
+
+	if (!lazy_accept)
+		return false;
+
+	spin_lock_irqsave(&zone->lock, flags);
+	first = list_empty(&zone->unaccepted_pages);
+	list_add_tail(&page->lru, &zone->unaccepted_pages);
+	__mod_zone_freepage_state(zone, MAX_ORDER_NR_PAGES, MIGRATE_MOVABLE);
+	__mod_zone_page_state(zone, NR_UNACCEPTED, MAX_ORDER_NR_PAGES);
+	spin_unlock_irqrestore(&zone->lock, flags);
+
+	if (first)
+		static_branch_inc(&zones_with_unaccepted_pages);
+
+	return true;
+}
+
+#else
+
+static bool page_contains_unaccepted(struct page *page, unsigned int order)
+{
+	return false;
+}
+
+static void accept_page(struct page *page, unsigned int order)
+{
+}
+
+static bool try_to_accept_memory(struct zone *zone, unsigned int order)
+{
+	return false;
+}
+
+static inline bool has_unaccepted_memory(void)
+{
+	return false;
+}
+
+static bool __free_unaccepted(struct page *page)
+{
+	BUILD_BUG();
+	return false;
+}
+
+#endif /* CONFIG_UNACCEPTED_MEMORY */
diff --git a/mm/vmstat.c b/mm/vmstat.c
index c280463..282349c 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1180,6 +1180,9 @@ const char * const vmstat_text[] = {
 	"nr_zspages",
 #endif
 	"nr_free_cma",
+#ifdef CONFIG_UNACCEPTED_MEMORY
+	"nr_unaccepted",
+#endif
 
 	/* enum numa_stat_item counters */
 #ifdef CONFIG_NUMA
