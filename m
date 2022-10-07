Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01F425F727A
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 03:09:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232512AbiJGBIg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 21:08:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232484AbiJGBI3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 21:08:29 -0400
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFBD4FE759
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 18:08:16 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1665104894;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4yLSRqNNw+kVejLJPKTHw5xzf9W+8nJpCUE4MqtITCU=;
        b=lqfvcUEZB2WViA72VEzs5CIZYAFNpcv1qFtK4byZEf6eJvyjkZWnEL+88wNCCnHHNSFM1b
        KOCTo4lrIrB+RwzyijpqXgs28S0vhMif5YDAZGPzY9XLq42MWq//1faJZ0vSO77JlFXdkp
        0+uVBoRyxikj/o/0uRF7Xexw6+Ugx0o=
From:   Naoya Horiguchi <naoya.horiguchi@linux.dev>
To:     linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Hildenbrand <david@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Yang Shi <shy828301@gmail.com>,
        Oscar Salvador <osalvador@suse.de>,
        Muchun Song <songmuchun@bytedance.com>,
        Jane Chu <jane.chu@oracle.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 4/4] mm/hwpoison: introduce per-memory_block hwpoison counter
Date:   Fri,  7 Oct 2022 10:07:06 +0900
Message-Id: <20221007010706.2916472-5-naoya.horiguchi@linux.dev>
In-Reply-To: <20221007010706.2916472-1-naoya.horiguchi@linux.dev>
References: <20221007010706.2916472-1-naoya.horiguchi@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Naoya Horiguchi <naoya.horiguchi@nec.com>

Currently PageHWPoison flag does not behave well when experiencing memory
hotremove/hotplug.  Any data field in struct page is unreliable when the
associated memory is offlined, and the current mechanism can't tell whether
a memory block is onlined because a new memory devices is installed or
because previous failed offline operations are undone.  Especially if
there's a hwpoisoned memory, it's unclear what the best option is.

So introduce a new mechanism to make struct memory_block remember that
a memory block has hwpoisoned memory inside it. And make any online event
fail if the onlining memory block contains hwpoison.  struct memory_block
is freed and reallocated over ACPI-based hotremove/hotplug, but not over
sysfs-based hotremove/hotplug.  So the new counter can distinguish these
cases.

Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
Reported-by: kernel test robot <lkp@intel.com>
---
ChangeLog v5 -> v6:
- fix build errors over memblk_nr_poison_inc() and memblk_nr_poison_sub(),
- pass "struct memory_block *" to memblk_nr_poison() instead of pfn,
- removed clear_hwpoisoned_pages() and call num_poisoned_pages_sub() directly.
- add static keyword to the definition of memblk_nr_poison().
- Mioahe added Reviewed-by for v5, but I have some non trivial changes in
  v6, so let me hold to add it.
- unpoison_memory() properly cancels per-memblk hwpoison counter.

ChangeLog v4 -> v5:
- add Reported-by of lkp bot,
- check both CONFIG_MEMORY_FAILURE and CONFIG_MEMORY_HOTPLUG in introduced #ifdefs,
  intending to fix "undefined reference" errors in aarch64.

ChangeLog v3 -> v4:
- fix build error (https://lore.kernel.org/linux-mm/202209231134.tnhKHRfg-lkp@intel.com/)
  by using memblk_nr_poison() to access to the member ->nr_hwpoison
---
 drivers/base/memory.c  | 40 ++++++++++++++++++++++++++++++++++++++++
 include/linux/memory.h |  3 +++
 include/linux/mm.h     | 18 ++++++++++++++++++
 mm/internal.h          |  8 --------
 mm/memory-failure.c    | 36 +++++++++++-------------------------
 mm/sparse.c            |  2 --
 6 files changed, 72 insertions(+), 35 deletions(-)

diff --git a/drivers/base/memory.c b/drivers/base/memory.c
index 9aa0da991cfb..5d00d8a14c79 100644
--- a/drivers/base/memory.c
+++ b/drivers/base/memory.c
@@ -175,6 +175,17 @@ int memory_notify(unsigned long val, void *v)
 	return blocking_notifier_call_chain(&memory_chain, val, v);
 }
 
+#if defined(CONFIG_MEMORY_FAILURE) && defined(CONFIG_MEMORY_HOTPLUG)
+void memblk_nr_poison_inc(unsigned long pfn);
+void memblk_nr_poison_sub(unsigned long pfn, long i);
+static unsigned long memblk_nr_poison(struct memory_block *mem);
+#else
+static inline unsigned long memblk_nr_poison(struct memory_block *mem)
+{
+	return 0;
+}
+#endif
+
 static int memory_block_online(struct memory_block *mem)
 {
 	unsigned long start_pfn = section_nr_to_pfn(mem->start_section_nr);
@@ -183,6 +194,9 @@ static int memory_block_online(struct memory_block *mem)
 	struct zone *zone;
 	int ret;
 
+	if (memblk_nr_poison(mem))
+		return -EHWPOISON;
+
 	zone = zone_for_pfn_range(mem->online_type, mem->nid, mem->group,
 				  start_pfn, nr_pages);
 
@@ -864,6 +878,7 @@ void remove_memory_block_devices(unsigned long start, unsigned long size)
 		mem = find_memory_block_by_id(block_id);
 		if (WARN_ON_ONCE(!mem))
 			continue;
+		num_poisoned_pages_sub(-1UL, memblk_nr_poison(mem));
 		unregister_memory_block_under_nodes(mem);
 		remove_memory_block(mem);
 	}
@@ -1164,3 +1179,28 @@ int walk_dynamic_memory_groups(int nid, walk_memory_groups_func_t func,
 	}
 	return ret;
 }
+
+#if defined(CONFIG_MEMORY_FAILURE) && defined(CONFIG_MEMORY_HOTPLUG)
+void memblk_nr_poison_inc(unsigned long pfn)
+{
+	const unsigned long block_id = pfn_to_block_id(pfn);
+	struct memory_block *mem = find_memory_block_by_id(block_id);
+
+	if (mem)
+		atomic_long_inc(&mem->nr_hwpoison);
+}
+
+void memblk_nr_poison_sub(unsigned long pfn, long i)
+{
+	const unsigned long block_id = pfn_to_block_id(pfn);
+	struct memory_block *mem = find_memory_block_by_id(block_id);
+
+	if (mem)
+		atomic_long_sub(i, &mem->nr_hwpoison);
+}
+
+static unsigned long memblk_nr_poison(struct memory_block *mem)
+{
+	return atomic_long_read(&mem->nr_hwpoison);
+}
+#endif
diff --git a/include/linux/memory.h b/include/linux/memory.h
index aa619464a1df..ad8cd9bb3239 100644
--- a/include/linux/memory.h
+++ b/include/linux/memory.h
@@ -85,6 +85,9 @@ struct memory_block {
 	unsigned long nr_vmemmap_pages;
 	struct memory_group *group;	/* group (if any) for this block */
 	struct list_head group_next;	/* next block inside memory group */
+#if defined(CONFIG_MEMORY_FAILURE) && defined(CONFIG_MEMORY_HOTPLUG)
+	atomic_long_t nr_hwpoison;
+#endif
 };
 
 int arch_get_memory_phys_device(unsigned long start_pfn);
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 17119dbf8fad..f80269e90772 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3280,6 +3280,7 @@ extern int soft_offline_page(unsigned long pfn, int flags);
 extern int __get_huge_page_for_hwpoison(unsigned long pfn, int flags,
 					bool *migratable_cleared);
 extern void num_poisoned_pages_inc(unsigned long pfn);
+extern void num_poisoned_pages_sub(unsigned long pfn, long i);
 #else
 static inline int __get_huge_page_for_hwpoison(unsigned long pfn, int flags,
 					bool *migratable_cleared)
@@ -3290,6 +3291,23 @@ static inline int __get_huge_page_for_hwpoison(unsigned long pfn, int flags,
 static inline void num_poisoned_pages_inc(unsigned long pfn)
 {
 }
+
+static inline void num_poisoned_pages_sub(unsigned long pfn, long i)
+{
+}
+#endif
+
+#if defined(CONFIG_MEMORY_FAILURE) && defined(CONFIG_MEMORY_HOTPLUG)
+extern void memblk_nr_poison_inc(unsigned long pfn);
+extern void memblk_nr_poison_sub(unsigned long pfn, long i);
+#else
+static inline void memblk_nr_poison_inc(unsigned long pfn)
+{
+}
+
+static inline void memblk_nr_poison_sub(unsigned long pfn, long i)
+{
+}
 #endif
 
 #ifndef arch_memory_failure
diff --git a/mm/internal.h b/mm/internal.h
index b3002e03c28f..42ba8b96cab5 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -708,14 +708,6 @@ extern u64 hwpoison_filter_flags_value;
 extern u64 hwpoison_filter_memcg;
 extern u32 hwpoison_filter_enable;
 
-#ifdef CONFIG_MEMORY_FAILURE
-void clear_hwpoisoned_pages(struct page *memmap, int nr_pages);
-#else
-static inline void clear_hwpoisoned_pages(struct page *memmap, int nr_pages)
-{
-}
-#endif
-
 extern unsigned long  __must_check vm_mmap_pgoff(struct file *, unsigned long,
         unsigned long, unsigned long,
         unsigned long, unsigned long);
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index c19a301f16fc..4f5921590b76 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -77,11 +77,14 @@ static bool hw_memory_failure __read_mostly = false;
 inline void num_poisoned_pages_inc(unsigned long pfn)
 {
 	atomic_long_inc(&num_poisoned_pages);
+	memblk_nr_poison_inc(pfn);
 }
 
-static inline void num_poisoned_pages_sub(unsigned long pfn, long i)
+inline void num_poisoned_pages_sub(unsigned long pfn, long i)
 {
 	atomic_long_sub(i, &num_poisoned_pages);
+	if (pfn != -1UL)
+		memblk_nr_poison_sub(pfn, i);
 }
 
 /*
@@ -1706,6 +1709,8 @@ static unsigned long __free_raw_hwp_pages(struct page *hpage, bool move_flag)
 
 		if (move_flag)
 			SetPageHWPoison(p->page);
+		else
+			num_poisoned_pages_sub(page_to_pfn(p->page), 1);
 		kfree(p);
 		count++;
 	}
@@ -2337,6 +2342,7 @@ int unpoison_memory(unsigned long pfn)
 	int ret = -EBUSY;
 	int freeit = 0;
 	unsigned long count = 1;
+	bool huge = false;
 	static DEFINE_RATELIMIT_STATE(unpoison_rs, DEFAULT_RATELIMIT_INTERVAL,
 					DEFAULT_RATELIMIT_BURST);
 
@@ -2385,6 +2391,7 @@ int unpoison_memory(unsigned long pfn)
 	ret = get_hwpoison_page(p, MF_UNPOISON);
 	if (!ret) {
 		if (PageHuge(p)) {
+			huge = true;
 			count = free_raw_hwp_pages(page, false);
 			if (count == 0) {
 				ret = -EBUSY;
@@ -2400,6 +2407,7 @@ int unpoison_memory(unsigned long pfn)
 					 pfn, &unpoison_rs);
 	} else {
 		if (PageHuge(p)) {
+			huge = true;
 			count = free_raw_hwp_pages(page, false);
 			if (count == 0) {
 				ret = -EBUSY;
@@ -2419,7 +2427,8 @@ int unpoison_memory(unsigned long pfn)
 unlock_mutex:
 	mutex_unlock(&mf_mutex);
 	if (!ret || freeit) {
-		num_poisoned_pages_sub(pfn, count);
+		if (!huge)
+			num_poisoned_pages_sub(pfn, 1);
 		unpoison_pr_info("Unpoison: Software-unpoisoned page %#lx\n",
 				 page_to_pfn(p), &unpoison_rs);
 	}
@@ -2622,26 +2631,3 @@ int soft_offline_page(unsigned long pfn, int flags)
 
 	return ret;
 }
-
-void clear_hwpoisoned_pages(struct page *memmap, int nr_pages)
-{
-	int i, total = 0;
-
-	/*
-	 * A further optimization is to have per section refcounted
-	 * num_poisoned_pages.  But that would need more space per memmap, so
-	 * for now just do a quick global check to speed up this routine in the
-	 * absence of bad pages.
-	 */
-	if (atomic_long_read(&num_poisoned_pages) == 0)
-		return;
-
-	for (i = 0; i < nr_pages; i++) {
-		if (PageHWPoison(&memmap[i])) {
-			total++;
-			ClearPageHWPoison(&memmap[i]);
-		}
-	}
-	if (total)
-		num_poisoned_pages_sub(0, total);
-}
diff --git a/mm/sparse.c b/mm/sparse.c
index e5a8a3a0edd7..2779b419ef2a 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -926,8 +926,6 @@ void sparse_remove_section(struct mem_section *ms, unsigned long pfn,
 		unsigned long nr_pages, unsigned long map_offset,
 		struct vmem_altmap *altmap)
 {
-	clear_hwpoisoned_pages(pfn_to_page(pfn) + map_offset,
-			nr_pages - map_offset);
 	section_deactivate(pfn, nr_pages, altmap);
 }
 #endif /* CONFIG_MEMORY_HOTPLUG */
-- 
2.25.1

