Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81E6A6F0FBA
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 02:42:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344432AbjD1AmF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 20:42:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344679AbjD1Aly (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 20:41:54 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AABE3C3C
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 17:41:52 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-5144902c15eso5480849a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 17:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682642511; x=1685234511;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/o5oEUz9QY3MpW1sWxeWWzj/nFi9LBqOWOdS4qpvdww=;
        b=H3Aow8dqpsTl+l8cACpDA0oGPYleJ8rZzl0l4HNzNXUQLqmNjqSWtnGmjDEbYTT2ug
         rimuWS5nO+TuUPapY0M0aNes9nsnlU4VRybeQAvHLUWI3zxVov2KJc4PtUvWGG5q23ft
         BocnV5I6j9gGFe7suFnGIyh9nycSkCjfU6iEEVM5hafPAUe8G6Tgmbovev4CAZzjn/F1
         bkNlgHQsxB2naDkK+Ksj/yf6Bi8WCjSulS2hbY0+guIEGzgoHIuXLH3p/5g3TFI6ei8X
         zj7r82kI5QrxhOf73CJ3SqQm925ACvT/lcFvzS2U4C9P0wCgLPd2ZzT2atfl/Lm0T9tR
         9Cyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682642511; x=1685234511;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/o5oEUz9QY3MpW1sWxeWWzj/nFi9LBqOWOdS4qpvdww=;
        b=OFBcDrpwP1BSVi+/9hqYyb3bgqGEykBVQwmQKtqjVxFcm6rd7xeA4HWz7CzEf/vCMj
         Xdj7jHomBs2vqbhAV31forQ0dGIdaUB4wBHcubQzCMyi385hWFl26V0h1Rse6tud6qVt
         ZuBMSQA+EjYrv3Eo+fdCTBn9A5bPWRcXm+nIpemrUrOVMtURKE4/MpRBmQfHlMqZSto2
         8J6cfWHGlabQJ/NiIrccpAfvRDwP1DYDNxufyyLZ1OI7Ob+94fppGqN/UL7EKNB+yng3
         XQcGkYtbUoS+0jTbh4SuWZJLrLTqFDiAgCvRfMiHEdPoZk4An90vngdARRmFqAArrn+d
         GaNg==
X-Gm-Message-State: AC+VfDw2pSp3wdG1ZZEKWbWcwlTDn3AchqeW/4+crVkbjAGTkQrJbLJc
        HgVBQEnpkvmKE1HXE27tQWe+4RKmb/k2dA==
X-Google-Smtp-Source: ACHHUZ7EYI0v8TfE0cDAj+VsJnuUzkACUMZNzRrqX/ygIrQzIMk/uWr3EPO/bWYVpDd5SGvb73zYw7w2ENsYGQ==
X-Received: from yjq3.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:272f])
 (user=jiaqiyan job=sendgmr) by 2002:a63:6985:0:b0:517:ce37:756e with SMTP id
 e127-20020a636985000000b00517ce37756emr815534pgc.7.1682642511665; Thu, 27 Apr
 2023 17:41:51 -0700 (PDT)
Date:   Fri, 28 Apr 2023 00:41:36 +0000
In-Reply-To: <20230428004139.2899856-1-jiaqiyan@google.com>
Mime-Version: 1.0
References: <20230428004139.2899856-1-jiaqiyan@google.com>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Message-ID: <20230428004139.2899856-5-jiaqiyan@google.com>
Subject: [RFC PATCH v1 4/7] mm/memory_failure: unmap raw HWPoison PTEs when possible
From:   Jiaqi Yan <jiaqiyan@google.com>
To:     mike.kravetz@oracle.com, peterx@redhat.com, naoya.horiguchi@nec.com
Cc:     songmuchun@bytedance.com, duenwen@google.com,
        axelrasmussen@google.com, jthoughton@google.com,
        rientjes@google.com, linmiaohe@huawei.com, shy828301@gmail.com,
        baolin.wang@linux.alibaba.com, wangkefeng.wang@huawei.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Jiaqi Yan <jiaqiyan@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a folio's VMA is HGM eligible, try_to_unmap_one now only unmaps
the raw HWPOISON page (previously split and mapped at PTE size).
If HGM failed to be enabled on eligible VMA or splitting failed,
try_to_unmap_one fails.

For VMS that is not HGM eligible, try_to_unmap_one still unmaps
the whole P*D.

When only the raw HWPOISON subpage is unmapped but others keep mapped,
the old way in memory_failure to check if unmapping successful doesn't
work. So introduce is_unmapping_successful() to cover both existing and
new unmapping behavior.

For the new unmapping behavior, store how many times a raw HWPOISON page
is expected to be unmapped, and how many times it is actually unmapped
in try_to_unmap_one(). A HWPOISON raw page is expected to be unmapped
from a VMA if splitting succeeded in try_to_split_huge_mapping(), so
unmap_success = (nr_expected_unamps == nr_actual_unmaps).

Old folio_set_hugetlb_hwpoison returns -EHWPOISON if a folio has any
raw HWPOISON subpage, and try_memory_failure_hugetlb won't attempt
recovery actions again because recovery used to be done on the entire
hugepage. With the new unmapping behavior, this doesn't hold. More
subpages in the hugepage can become corrupted, and needs to be recovered
(i.e. unmapped) individually. New folio_set_hugetlb_hwpoison returns
0 after adding a new raw subpage to raw_hwp_list.

Unmapping raw HWPOISON page requires allocating raw_hwp_page
successfully in folio_set_hugetlb_hwpoison, so try_memory_failure_hugetlb
now may fail due to OOM.

Signed-off-by: Jiaqi Yan <jiaqiyan@google.com>
---
 include/linux/mm.h  |  20 ++++++-
 mm/memory-failure.c | 140 ++++++++++++++++++++++++++++++++++++++------
 mm/rmap.c           |  38 +++++++++++-
 3 files changed, 175 insertions(+), 23 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 4496d7bdd3ea..dc192f98cb1d 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3522,20 +3522,38 @@ enum mf_action_page_type {
  */
 extern const struct attribute_group memory_failure_attr_group;
 
-#ifdef CONFIG_HUGETLB_PAGE
 /*
  * Struct raw_hwp_page represents information about "raw error page",
  * constructing singly linked list from ->_hugetlb_hwpoison field of folio.
+ * @node: the node in folio->_hugetlb_hwpoison list.
+ * @page: the raw HWPOISON page struct.
+ * @nr_vmas_mapped: the number of VMAs that map @page when detected.
+ * @nr_expected_unmaps: if a VMA that maps @page when detected is eligible
+ *   for high granularity mapping, @page is expected to be unmapped.
+ * @nr_actual_unmaps: how many times the raw page is actually unmapped.
  */
 struct raw_hwp_page {
 	struct llist_node node;
 	struct page *page;
+	int nr_vmas_mapped;
+	int nr_expected_unmaps;
+	int nr_actual_unmaps;
 };
 
+#ifdef CONFIG_HUGETLB_PAGE
 static inline struct llist_head *raw_hwp_list_head(struct folio *folio)
 {
 	return (struct llist_head *)&folio->_hugetlb_hwpoison;
 }
+
+struct raw_hwp_page *find_in_raw_hwp_list(struct folio *folio,
+					  struct page *subpage);
+#else
+static inline struct raw_hwp_page *find_in_raw_hwp_list(struct folio *folio,
+							struct page *subpage)
+{
+	return NULL;
+}
 #endif
 
 #if defined(CONFIG_TRANSPARENT_HUGEPAGE) || defined(CONFIG_HUGETLBFS)
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 48e62d04af17..47b935918ceb 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1120,10 +1120,10 @@ static int me_swapcache_clean(struct page_state *ps, struct page *p)
 }
 
 /*
- * Huge pages. Needs work.
- * Issues:
- * - Error on hugepage is contained in hugepage unit (not in raw page unit.)
- *   To narrow down kill region to one page, we need to break up pmd.
+ * Huge pages.
+ * - Without HGM: Error on hugepage is contained in hugepage unit (not in
+ *   raw page unit).
+ * - With HGM: Kill region is narrowed down to just one page.
  */
 static int me_huge_page(struct page_state *ps, struct page *p)
 {
@@ -1131,6 +1131,7 @@ static int me_huge_page(struct page_state *ps, struct page *p)
 	struct page *hpage = compound_head(p);
 	struct address_space *mapping;
 	bool extra_pins = false;
+	struct raw_hwp_page *hwp_page = find_in_raw_hwp_list(page_folio(p), p);
 
 	if (!PageHuge(hpage))
 		return MF_DELAYED;
@@ -1157,7 +1158,8 @@ static int me_huge_page(struct page_state *ps, struct page *p)
 		}
 	}
 
-	if (has_extra_refcount(ps, p, extra_pins))
+	if (hwp_page->nr_expected_unmaps == 0 &&
+	    has_extra_refcount(ps, p, extra_pins))
 		res = MF_FAILED;
 
 	return res;
@@ -1497,24 +1499,30 @@ static void try_to_split_huge_mapping(struct folio *folio,
 	unsigned long poisoned_addr;
 	unsigned long head_addr;
 	struct hugetlb_pte hpte;
+	struct raw_hwp_page *hwp_page = NULL;
 
 	if (WARN_ON(!mapping))
 		return;
 
 	VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
 
+	hwp_page = find_in_raw_hwp_list(folio, poisoned_page);
+	VM_BUG_ON_PAGE(!hwp_page, poisoned_page);
+
 	pgoff_start = folio_pgoff(folio);
 	pgoff_end = pgoff_start + folio_nr_pages(folio) - 1;
 
 	vma_interval_tree_foreach(vma, &mapping->i_mmap, pgoff_start, pgoff_end) {
+		++hwp_page->nr_vmas_mapped;
+
 		/* Enable HGM on HGM-eligible VMAs. */
 		if (!hugetlb_hgm_eligible(vma))
 			continue;
 
 		i_mmap_assert_locked(vma->vm_file->f_mapping);
 		if (hugetlb_enable_hgm_vma(vma)) {
-			pr_err("Failed to enable HGM on eligible VMA=[%#lx, %#lx)\n",
-				vma->vm_start, vma->vm_end);
+			pr_err("%#lx: failed to enable HGM on eligible VMA=[%#lx, %#lx)\n",
+				page_to_pfn(poisoned_page), vma->vm_start, vma->vm_end);
 			continue;
 		}
 
@@ -1528,15 +1536,21 @@ static void try_to_split_huge_mapping(struct folio *folio,
 		 * lock on vma->vm_file->f_mapping, which caller
 		 * (e.g. hwpoison_user_mappings) should already acquired.
 		 */
-		if (hugetlb_full_walk(&hpte, vma, head_addr))
+		if (hugetlb_full_walk(&hpte, vma, head_addr)) {
+			pr_err("%#lx: failed to PT-walk with HGM on eligible VMA=[%#lx, %#lx)\n",
+				page_to_pfn(poisoned_page), vma->vm_start, vma->vm_end);
 			continue;
+		}
 
 		if (hugetlb_split_to_shift(vma->vm_mm, vma, &hpte,
 					   poisoned_addr, PAGE_SHIFT)) {
-			pr_err("Failed to split huge mapping: pfn=%#lx, vaddr=%#lx in VMA=[%#lx, %#lx)\n",
+			pr_err("%#lx: Failed to split huge mapping: vaddr=%#lx in VMA=[%#lx, %#lx)\n",
 				page_to_pfn(poisoned_page), poisoned_addr,
 				vma->vm_start, vma->vm_end);
+			continue;
 		}
+
+		++hwp_page->nr_expected_unmaps;
 	}
 }
 #else
@@ -1546,6 +1560,47 @@ static void try_to_split_huge_mapping(struct folio *folio,
 }
 #endif /* CONFIG_HUGETLB_HIGH_GRANULARITY_MAPPING */
 
+static bool is_unmapping_successful(struct folio *folio,
+				    struct page *poisoned_page)
+{
+	bool unmap_success = false;
+	struct raw_hwp_page *hwp_page = find_in_raw_hwp_list(folio, poisoned_page);
+
+	if (!folio_test_hugetlb(folio) ||
+	    folio_test_anon(folio) ||
+	    !IS_ENABLED(CONFIG_HUGETLB_HIGH_GRANULARITY_MAPPING)) {
+		unmap_success = folio_mapped(folio);
+		if (!unmap_success)
+			pr_err("%#lx: failed to unmap page (mapcount=%d)\n",
+				page_to_pfn(poisoned_page),
+				page_mapcount(folio_page(folio, 0)));
+
+		return unmap_success;
+	}
+
+	VM_BUG_ON_PAGE(!hwp_page, poisoned_page);
+
+	/*
+	 * Unmapping may not happen for some VMA:
+	 * - HGM-eligible VMA but @poisoned_page is not faulted yet: nothing
+	 *   needs to be done at this point yet until page fault handling.
+	 * - HGM-non-eliggible VMA: mapcount decreases by nr_subpages for each VMA,
+	 *   but not tracked so cannot tell if successfully unmapped from such VMA.
+	 */
+	if (hwp_page->nr_vmas_mapped != hwp_page->nr_expected_unmaps)
+		pr_info("%#lx: mapped by %d VMAs but %d unmappings are expected\n",
+			page_to_pfn(poisoned_page), hwp_page->nr_vmas_mapped,
+			hwp_page->nr_expected_unmaps);
+
+	unmap_success = hwp_page->nr_expected_unmaps == hwp_page->nr_actual_unmaps;
+
+	if (!unmap_success)
+		pr_err("%#lx: failed to unmap page (folio_mapcount=%d)\n",
+			page_to_pfn(poisoned_page), folio_mapcount(folio));
+
+	return unmap_success;
+}
+
 /*
  * Do all that is necessary to remove user space mappings. Unmap
  * the pages and send SIGBUS to the processes if the data was dirty.
@@ -1631,10 +1686,7 @@ static bool hwpoison_user_mappings(struct page *p, unsigned long pfn,
 		try_to_unmap(folio, ttu);
 	}
 
-	unmap_success = !page_mapped(hpage);
-	if (!unmap_success)
-		pr_err("%#lx: failed to unmap page (mapcount=%d)\n",
-		       pfn, page_mapcount(hpage));
+	unmap_success = is_unmapping_successful(folio, p);
 
 	/*
 	 * try_to_unmap() might put mlocked page in lru cache, so call
@@ -1827,6 +1879,31 @@ EXPORT_SYMBOL_GPL(mf_dax_kill_procs);
 
 #ifdef CONFIG_HUGETLB_PAGE
 
+/*
+ * Given a HWPOISON @subpage as raw page, find its location in @folio's
+ * _hugetlb_hwpoison. Return NULL if @subpage is not in the list.
+ */
+struct raw_hwp_page *find_in_raw_hwp_list(struct folio *folio,
+					  struct page *subpage)
+{
+	struct llist_node *t, *tnode;
+	struct llist_head *raw_hwp_head = raw_hwp_list_head(folio);
+	struct raw_hwp_page *hwp_page = NULL;
+	struct raw_hwp_page *p;
+
+	VM_BUG_ON_PAGE(PageHWPoison(subpage), subpage);
+
+	llist_for_each_safe(tnode, t, raw_hwp_head->first) {
+		p = container_of(tnode, struct raw_hwp_page, node);
+		if (subpage == p->page) {
+			hwp_page = p;
+			break;
+		}
+	}
+
+	return hwp_page;
+}
+
 static unsigned long __folio_free_raw_hwp(struct folio *folio, bool move_flag)
 {
 	struct llist_head *head;
@@ -1837,6 +1914,9 @@ static unsigned long __folio_free_raw_hwp(struct folio *folio, bool move_flag)
 	llist_for_each_safe(tnode, t, head->first) {
 		struct raw_hwp_page *p = container_of(tnode, struct raw_hwp_page, node);
 
+		/* Ideally raw HWPoison pages are fully unmapped if possible. */
+		WARN_ON(p->nr_expected_unmaps != p->nr_actual_unmaps);
+
 		if (move_flag)
 			SetPageHWPoison(p->page);
 		else
@@ -1853,7 +1933,8 @@ static int folio_set_hugetlb_hwpoison(struct folio *folio, struct page *page)
 	struct llist_head *head;
 	struct raw_hwp_page *raw_hwp;
 	struct llist_node *t, *tnode;
-	int ret = folio_test_set_hwpoison(folio) ? -EHWPOISON : 0;
+	bool has_hwpoison = folio_test_set_hwpoison(folio);
+	bool hgm_enabled = IS_ENABLED(CONFIG_HUGETLB_HIGH_GRANULARITY_MAPPING);
 
 	/*
 	 * Once the hwpoison hugepage has lost reliable raw error info,
@@ -1873,9 +1954,20 @@ static int folio_set_hugetlb_hwpoison(struct folio *folio, struct page *page)
 	raw_hwp = kmalloc(sizeof(struct raw_hwp_page), GFP_ATOMIC);
 	if (raw_hwp) {
 		raw_hwp->page = page;
+		raw_hwp->nr_vmas_mapped = 0;
+		raw_hwp->nr_expected_unmaps = 0;
+		raw_hwp->nr_actual_unmaps = 0;
 		llist_add(&raw_hwp->node, head);
+		if (hgm_enabled)
+			/*
+			 * A new raw poisoned page. Don't return
+			 * HWPOISON. Error event will be counted
+			 * in action_result().
+			 */
+			return 0;
+
 		/* the first error event will be counted in action_result(). */
-		if (ret)
+		if (has_hwpoison)
 			num_poisoned_pages_inc(page_to_pfn(page));
 	} else {
 		/*
@@ -1889,8 +1981,16 @@ static int folio_set_hugetlb_hwpoison(struct folio *folio, struct page *page)
 		 * used any more, so free it.
 		 */
 		__folio_free_raw_hwp(folio, false);
+
+		/*
+		 * HGM relies on raw_hwp allocated and inserted to raw_hwp_list.
+		 */
+		if (hgm_enabled)
+			return -ENOMEM;
 	}
-	return ret;
+
+	BUG_ON(hgm_enabled);
+	return has_hwpoison ? -EHWPOISON : 0;
 }
 
 static unsigned long folio_free_raw_hwp(struct folio *folio, bool move_flag)
@@ -1936,6 +2036,7 @@ int __get_huge_page_for_hwpoison(unsigned long pfn, int flags,
 	struct page *page = pfn_to_page(pfn);
 	struct folio *folio = page_folio(page);
 	int ret = 2;	/* fallback to normal page handling */
+	int set_page_hwpoison = 0;
 	bool count_increased = false;
 
 	if (!folio_test_hugetlb(folio))
@@ -1956,8 +2057,9 @@ int __get_huge_page_for_hwpoison(unsigned long pfn, int flags,
 			goto out;
 	}
 
-	if (folio_set_hugetlb_hwpoison(folio, page)) {
-		ret = -EHWPOISON;
+	set_page_hwpoison = folio_set_hugetlb_hwpoison(folio, page);
+	if (set_page_hwpoison) {
+		ret = set_page_hwpoison;
 		goto out;
 	}
 
@@ -2004,7 +2106,7 @@ static int try_memory_failure_hugetlb(unsigned long pfn, int flags, int *hugetlb
 			res = kill_accessing_process(current, folio_pfn(folio), flags);
 		}
 		return res;
-	} else if (res == -EBUSY) {
+	} else if (res == -EBUSY || res == -ENOMEM) {
 		if (!(flags & MF_NO_RETRY)) {
 			flags |= MF_NO_RETRY;
 			goto retry;
diff --git a/mm/rmap.c b/mm/rmap.c
index d3bc81466902..4cfaa34b001e 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1453,6 +1453,8 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 	struct mmu_notifier_range range;
 	enum ttu_flags flags = (enum ttu_flags)(long)arg;
 	bool page_poisoned;
+	bool hgm_eligible = hugetlb_hgm_eligible(vma);
+	struct raw_hwp_page *hwp_page;
 
 	/*
 	 * When racing against e.g. zap_pte_range() on another cpu,
@@ -1525,6 +1527,29 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 			 * in the case where the hugetlb page is poisoned.
 			 */
 			VM_BUG_ON_FOLIO(!page_poisoned, folio);
+
+			/*
+			 * When VMA is not HGM eligible, unmap at hugepage's
+			 * original P*D.
+			 *
+			 * When HGM is eligible:
+			 * - if original P*D is split to smaller P*Ds and
+			 *   PTEs, we skip subpage if it is not raw HWPoison
+			 *   page, or it was but was already unmapped.
+			 * - if original P*D is not split, skip unmapping
+			 *   and memory_failure result will be MF_IGNORED.
+			 */
+			if (hgm_eligible) {
+				if (pvmw.pte_order > 0)
+					continue;
+				hwp_page = find_in_raw_hwp_list(folio, subpage);
+				if (hwp_page == NULL)
+					continue;
+				if (hwp_page->nr_expected_unmaps ==
+				    hwp_page->nr_actual_unmaps)
+					continue;
+			}
+
 			/*
 			 * huge_pmd_unshare may unmap an entire PMD page.
 			 * There is no way of knowing exactly which PMDs may
@@ -1760,12 +1785,19 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 		 *
 		 * See Documentation/mm/mmu_notifier.rst
 		 */
-		if (folio_test_hugetlb(folio))
+		if (!folio_test_hugetlb(folio))
+			page_remove_rmap(subpage, vma, false);
+		else {
 			hugetlb_remove_rmap(subpage,
 					pvmw.pte_order + PAGE_SHIFT,
 					hstate_vma(vma), vma);
-		else
-			page_remove_rmap(subpage, vma, false);
+			if (hgm_eligible) {
+				VM_BUG_ON_FOLIO(pvmw.pte_order > 0, folio);
+				VM_BUG_ON_FOLIO(!hwp_page, folio);
+				VM_BUG_ON_FOLIO(subpage != hwp_page->page, folio);
+				++hwp_page->nr_actual_unmaps;
+			}
+		}
 
 		if (vma->vm_flags & VM_LOCKED)
 			mlock_drain_local();
-- 
2.40.1.495.gc816e09b53d-goog

