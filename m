Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9669A5E75AB
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 10:26:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231293AbiIWI0Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 04:26:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231273AbiIWI0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 04:26:22 -0400
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DF43122046
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 01:26:20 -0700 (PDT)
Date:   Fri, 23 Sep 2022 17:26:13 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1663921579;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JaQoYM+j6Sz5drFI7/Nc5YLnUcsI4Slr+gq1hLPyp+8=;
        b=HJjn/ySuGyYyuDyy8S0NeoXOQKQdoAK5rmFjbD9D//E6F8nEE5HuM5iiD53H/1VPDkuDHw
        J1dPRUHtPjrvQdAYO+Chx4kK0Vvj43vhBlxrB5hjH6F9juwOFhGdFkOi0T4tdMcmnNgPO0
        Ringhrtz7uVRPjeEDb/gRpJ3B1S6zJU=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
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
Subject: [PATCH v4 4/4] mm/hwpoison: introduce per-memory_block hwpoison
 counter counter
Message-ID: <20220923082613.GB1357512@ik1-406-35019.vs.sakura.ne.jp>
References: <20220921091359.25889-1-naoya.horiguchi@linux.dev>
 <20220921091359.25889-5-naoya.horiguchi@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220921091359.25889-5-naoya.horiguchi@linux.dev>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
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
a memory section is onlined because a new memory devices is installed or
because previous failed offline operations are undone.  Especially if
there's a hwpoisoned memory, it's unclear what the best option is.

So introduce a new mechanism to make struct memory_block remember that
a memory block has hwpoisoned memory inside it. And make any online event
fail if the onlined memory block contains hwpoison.  struct memory_block
is freed and reallocated over ACPI-based hotremove/hotplug, but not over
sysfs-based hotremove/hotplug.  So it's desirable to implement hwpoison
counter on this struct.

Note that clear_hwpoisoned_pages() is relocated to be called earlier than
now, just before unregistering struct memory_block.  Otherwise, the
per-memory_block hwpoison counter is freed and we fail to adjust global
hwpoison counter properly.

Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
---
ChangeLog v3 -> v4:
- fixed build error (https://lore.kernel.org/linux-mm/202209231134.tnhKHRfg-lkp@intel.com/)
  by using memblk_nr_poison() to access to the member ->nr_hwpoison
---
 drivers/base/memory.c  | 41 +++++++++++++++++++++++++++++++++++++++++
 include/linux/memory.h |  3 +++
 include/linux/mm.h     |  8 ++++++++
 mm/internal.h          |  8 --------
 mm/memory-failure.c    | 31 ++++++++++---------------------
 mm/sparse.c            |  2 --
 6 files changed, 62 insertions(+), 31 deletions(-)

diff --git a/drivers/base/memory.c b/drivers/base/memory.c
index 9aa0da991cfb..f470bbfc68d0 100644
--- a/drivers/base/memory.c
+++ b/drivers/base/memory.c
@@ -183,6 +183,9 @@ static int memory_block_online(struct memory_block *mem)
 	struct zone *zone;
 	int ret;
 
+	if (memblk_nr_poison(start_pfn))
+		return -EHWPOISON;
+
 	zone = zone_for_pfn_range(mem->online_type, mem->nid, mem->group,
 				  start_pfn, nr_pages);
 
@@ -864,6 +867,7 @@ void remove_memory_block_devices(unsigned long start, unsigned long size)
 		mem = find_memory_block_by_id(block_id);
 		if (WARN_ON_ONCE(!mem))
 			continue;
+		clear_hwpoisoned_pages(memblk_nr_poison(start));
 		unregister_memory_block_under_nodes(mem);
 		remove_memory_block(mem);
 	}
@@ -1164,3 +1168,40 @@ int walk_dynamic_memory_groups(int nid, walk_memory_groups_func_t func,
 	}
 	return ret;
 }
+
+#ifdef CONFIG_MEMORY_FAILURE
+
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
+unsigned long memblk_nr_poison(unsigned long pfn)
+{
+	const unsigned long block_id = pfn_to_block_id(pfn);
+	struct memory_block *mem = find_memory_block_by_id(block_id);
+
+	if (mem)
+		return atomic_long_read(&mem->nr_hwpoison);
+	return 0;
+}
+
+#else
+unsigned long memblk_nr_poison(unsigned long pfn)
+{
+	return 0;
+}
+#endif
diff --git a/include/linux/memory.h b/include/linux/memory.h
index aa619464a1df..74e6b3ad947f 100644
--- a/include/linux/memory.h
+++ b/include/linux/memory.h
@@ -85,6 +85,9 @@ struct memory_block {
 	unsigned long nr_vmemmap_pages;
 	struct memory_group *group;	/* group (if any) for this block */
 	struct list_head group_next;	/* next block inside memory group */
+#ifdef CONFIG_MEMORY_FAILURE
+	atomic_long_t nr_hwpoison;
+#endif
 };
 
 int arch_get_memory_phys_device(unsigned long start_pfn);
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 2bb5d1596041..5445943bbb4b 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3280,6 +3280,9 @@ extern int soft_offline_page(unsigned long pfn, int flags);
 #ifdef CONFIG_MEMORY_FAILURE
 extern int __get_huge_page_for_hwpoison(unsigned long pfn, int flags);
 extern void num_poisoned_pages_inc(unsigned long pfn);
+extern void memblk_nr_poison_inc(unsigned long pfn);
+extern void memblk_nr_poison_sub(unsigned long pfn, long i);
+extern void clear_hwpoisoned_pages(long nr_poison);
 #else
 static inline int __get_huge_page_for_hwpoison(unsigned long pfn, int flags)
 {
@@ -3289,7 +3292,12 @@ static inline int __get_huge_page_for_hwpoison(unsigned long pfn, int flags)
 static inline void num_poisoned_pages_inc(unsigned long pfn)
 {
 }
+
+static inline void clear_hwpoisoned_pages(long nr_poison)
+{
+}
 #endif
+extern unsigned long memblk_nr_poison(unsigned long pfn);
 
 #ifndef arch_memory_failure
 static inline int arch_memory_failure(unsigned long pfn, int flags)
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
index a069d43bc87f..03479895086d 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -74,14 +74,17 @@ atomic_long_t num_poisoned_pages __read_mostly = ATOMIC_LONG_INIT(0);
 
 static bool hw_memory_failure __read_mostly = false;
 
-static inline void num_poisoned_pages_inc(unsigned long pfn)
+void num_poisoned_pages_inc(unsigned long pfn)
 {
 	atomic_long_inc(&num_poisoned_pages);
+	memblk_nr_poison_inc(pfn);
 }
 
 static inline void num_poisoned_pages_sub(unsigned long pfn, long i)
 {
 	atomic_long_sub(i, &num_poisoned_pages);
+	if (pfn != -1UL)
+		memblk_nr_poison_sub(pfn, i);
 }
 
 /*
@@ -2414,6 +2417,10 @@ int unpoison_memory(unsigned long pfn)
 unlock_mutex:
 	mutex_unlock(&mf_mutex);
 	if (!ret || freeit) {
+		/*
+		 * TODO: per-memory_block counter might break when the page
+		 * size to be unpoisoned is larger than a memory_block.
+		 */
 		num_poisoned_pages_sub(pfn, count);
 		unpoison_pr_info("Unpoison: Software-unpoisoned page %#lx\n",
 				 page_to_pfn(p), &unpoison_rs);
@@ -2618,25 +2625,7 @@ int soft_offline_page(unsigned long pfn, int flags)
 	return ret;
 }
 
-void clear_hwpoisoned_pages(struct page *memmap, int nr_pages)
+void clear_hwpoisoned_pages(long nr_poison)
 {
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
-		num_poisoned_pages_sub(total);
+	num_poisoned_pages_sub(-1UL, nr_poison);
 }
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
2.37.3.518.g79f2338b37

