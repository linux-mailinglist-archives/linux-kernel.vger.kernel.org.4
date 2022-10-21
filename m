Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07502607C82
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 18:40:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231192AbiJUQk1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 12:40:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231285AbiJUQi4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 12:38:56 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACA922892F4
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 09:37:44 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-368e6c449f2so34163127b3.5
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 09:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mfAGmPTzD6IaWh4r35NYR4uvUMh+9qxawpYMgnabsqo=;
        b=ladT4IDF0faYkS6EsLyPL4iAwSYt3vTPNcCtHgK4GO6UxLr3iGow3ilNz77qQtTxdU
         teVbA5i21qZ5PUXIY4R9n+Nlp+jikEryrw14TrwV+/URh3HfX3Ah8cih1kOfbXrR5NfU
         7R9L/opxCj6oXyy8sYYGZV+1ooqMBwsfrmEH7fhy8ZHX6lySQFd9UiHPWrK2rd9KNFSB
         3/duJ13bOFufz9wC+afwg6lg1M05SolVDmt/Bc7HfN7Dz/OhlEzPe8dGy1s/Dxw1eJ9b
         MfoCnqg3qGFaYulat7qBcu0qc1uAQ7885pfCKUPqkcpv+B/hepRO/OQQPPnKwTrNgY8F
         3D8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mfAGmPTzD6IaWh4r35NYR4uvUMh+9qxawpYMgnabsqo=;
        b=w4cgXpb30uI194akcyr776dFfpqiQ69s+QmMKHqlh7bvU3aTMCjAR51weJBvUmUM8U
         JrS8+QZpFWycdAo+1n6qW6X7KdFaAS2P8lNXjrU3uiyGKiwL86/5dEq0EPvAgEaomZRO
         t5FRdhxrlMhZ3Qp8mxvbVNS6kIP03lL1z/tCeeDK2ueSpkmzQCoBbUPIhpmMRtxcGPLz
         zGYcEkQHSmyZ1Ata6RsfM7YOVlct7v1jf7j6cYq7nHrIAfe7iMeyoEz4KSwcCkG2ehOp
         jVFhT+iI4J5ChGXvivdqsSvIIQwUc2Iv1FowdIUfQXMQHxYZx059azZQrevWo/3RtnLS
         mYMw==
X-Gm-Message-State: ACrzQf25MCKJ9uy5TudcjzwjNCdxKLHmzIhOTTjezKjPuRhZF1EoFGmO
        DBa94Gi+fRXU85wy3g+C5mslkUmWol2OE9xn
X-Google-Smtp-Source: AMsMyM5VI5g5y4qDnJ3t6eUtwrmz7+9GTBb9pTvZ+FXVDF2XmHcHaa8WGqrF89WshyvGQ2ReYotP8PNTRlH1p2sC
X-Received: from jthoughton.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:2a4f])
 (user=jthoughton job=sendgmr) by 2002:a25:c704:0:b0:6c1:9494:f584 with SMTP
 id w4-20020a25c704000000b006c19494f584mr17803486ybe.98.1666370263251; Fri, 21
 Oct 2022 09:37:43 -0700 (PDT)
Date:   Fri, 21 Oct 2022 16:36:45 +0000
In-Reply-To: <20221021163703.3218176-1-jthoughton@google.com>
Mime-Version: 1.0
References: <20221021163703.3218176-1-jthoughton@google.com>
X-Mailer: git-send-email 2.38.0.135.g90850a2211-goog
Message-ID: <20221021163703.3218176-30-jthoughton@google.com>
Subject: [RFC PATCH v2 29/47] hugetlb: add high-granularity migration support
From:   James Houghton <jthoughton@google.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Peter Xu <peterx@redhat.com>
Cc:     David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mina Almasry <almasrymina@google.com>,
        "Zach O'Keefe" <zokeefe@google.com>,
        Manish Mishra <manish.mishra@nutanix.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Yang Shi <shy828301@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        James Houghton <jthoughton@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To prevent queueing a hugepage for migration multiple times, we use
last_page to keep track of the last page we saw in queue_pages_hugetlb,
and if the page we're looking at is last_page, then we skip it.

For the non-hugetlb cases, last_page, although unused, is still updated
so that it has a consistent meaning with the hugetlb case.

This commit adds a check in hugetlb_fault for high-granularity migration
PTEs.

Signed-off-by: James Houghton <jthoughton@google.com>
---
 include/linux/swapops.h |  8 ++++++--
 mm/hugetlb.c            | 15 ++++++++++++++-
 mm/mempolicy.c          | 24 +++++++++++++++++++-----
 mm/migrate.c            | 18 +++++++++++-------
 4 files changed, 50 insertions(+), 15 deletions(-)

diff --git a/include/linux/swapops.h b/include/linux/swapops.h
index 86b95ccb81bb..2939323d0fd2 100644
--- a/include/linux/swapops.h
+++ b/include/linux/swapops.h
@@ -66,6 +66,8 @@
 
 static inline bool is_pfn_swap_entry(swp_entry_t entry);
 
+struct hugetlb_pte;
+
 /* Clear all flags but only keep swp_entry_t related information */
 static inline pte_t pte_swp_clear_flags(pte_t pte)
 {
@@ -346,7 +348,8 @@ extern void migration_entry_wait(struct mm_struct *mm, pmd_t *pmd,
 					unsigned long address);
 #ifdef CONFIG_HUGETLB_PAGE
 extern void __migration_entry_wait_huge(pte_t *ptep, spinlock_t *ptl);
-extern void migration_entry_wait_huge(struct vm_area_struct *vma, pte_t *pte);
+extern void migration_entry_wait_huge(struct vm_area_struct *vma,
+					struct hugetlb_pte *hpte);
 #endif	/* CONFIG_HUGETLB_PAGE */
 #else  /* CONFIG_MIGRATION */
 static inline swp_entry_t make_readable_migration_entry(pgoff_t offset)
@@ -375,7 +378,8 @@ static inline void migration_entry_wait(struct mm_struct *mm, pmd_t *pmd,
 					 unsigned long address) { }
 #ifdef CONFIG_HUGETLB_PAGE
 static inline void __migration_entry_wait_huge(pte_t *ptep, spinlock_t *ptl) { }
-static inline void migration_entry_wait_huge(struct vm_area_struct *vma, pte_t *pte) { }
+static inline void migration_entry_wait_huge(struct vm_area_struct *vma,
+						struct hugetlb_pte *hpte) { }
 #endif	/* CONFIG_HUGETLB_PAGE */
 static inline int is_writable_migration_entry(swp_entry_t entry)
 {
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 2ee2c48ee79c..8dba8d59ebe5 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -6100,9 +6100,11 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 		 * OK as we are only making decisions based on content and
 		 * not actually modifying content here.
 		 */
+		hugetlb_pte_populate(&hpte, ptep, huge_page_shift(h),
+				hpage_size_to_level(huge_page_size(h)));
 		entry = huge_ptep_get(ptep);
 		if (unlikely(is_hugetlb_entry_migration(entry))) {
-			migration_entry_wait_huge(vma, ptep);
+			migration_entry_wait_huge(vma, &hpte);
 			return 0;
 		} else if (unlikely(is_hugetlb_entry_hwpoisoned(entry)))
 			return VM_FAULT_HWPOISON_LARGE |
@@ -6142,7 +6144,18 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 	hugetlb_hgm_walk(mm, vma, &hpte, address, PAGE_SIZE,
 			/*stop_at_none=*/true);
 
+	/*
+	 * Now that we have done a high-granularity walk, check again if we are
+	 * looking at a migration entry.
+	 */
 	entry = huge_ptep_get(hpte.ptep);
+	if (unlikely(is_hugetlb_entry_migration(entry))) {
+		hugetlb_vma_unlock_read(vma);
+		mutex_unlock(&hugetlb_fault_mutex_table[hash]);
+		migration_entry_wait_huge(vma, &hpte);
+		return 0;
+	}
+
 	/* PTE markers should be handled the same way as none pte */
 	if (huge_pte_none_mostly(entry)) {
 		/*
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 275bc549590e..47bf9b16a9c0 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -424,6 +424,7 @@ struct queue_pages {
 	unsigned long start;
 	unsigned long end;
 	struct vm_area_struct *first;
+	struct page *last_page;
 };
 
 /*
@@ -475,6 +476,7 @@ static int queue_pages_pmd(pmd_t *pmd, spinlock_t *ptl, unsigned long addr,
 	flags = qp->flags;
 	/* go to thp migration */
 	if (flags & (MPOL_MF_MOVE | MPOL_MF_MOVE_ALL)) {
+		qp->last_page = page;
 		if (!vma_migratable(walk->vma) ||
 		    migrate_page_add(page, qp->pagelist, flags)) {
 			ret = 1;
@@ -532,6 +534,7 @@ static int queue_pages_pte_range(pmd_t *pmd, unsigned long addr,
 			continue;
 		if (!queue_pages_required(page, qp))
 			continue;
+
 		if (flags & (MPOL_MF_MOVE | MPOL_MF_MOVE_ALL)) {
 			/* MPOL_MF_STRICT must be specified if we get here */
 			if (!vma_migratable(vma)) {
@@ -539,6 +542,8 @@ static int queue_pages_pte_range(pmd_t *pmd, unsigned long addr,
 				break;
 			}
 
+			qp->last_page = page;
+
 			/*
 			 * Do not abort immediately since there may be
 			 * temporary off LRU pages in the range.  Still
@@ -570,15 +575,22 @@ static int queue_pages_hugetlb(struct hugetlb_pte *hpte,
 	spinlock_t *ptl;
 	pte_t entry;
 
-	/* We don't migrate high-granularity HugeTLB mappings for now. */
-	if (hugetlb_hgm_enabled(walk->vma))
-		return -EINVAL;
-
 	ptl = hugetlb_pte_lock(walk->mm, hpte);
 	entry = huge_ptep_get(hpte->ptep);
 	if (!pte_present(entry))
 		goto unlock;
-	page = pte_page(entry);
+
+	if (!hugetlb_pte_present_leaf(hpte, entry)) {
+		ret = -EAGAIN;
+		goto unlock;
+	}
+
+	page = compound_head(pte_page(entry));
+
+	/* We already queued this page with another high-granularity PTE. */
+	if (page == qp->last_page)
+		goto unlock;
+
 	if (!queue_pages_required(page, qp))
 		goto unlock;
 
@@ -605,6 +617,7 @@ static int queue_pages_hugetlb(struct hugetlb_pte *hpte,
 	/* With MPOL_MF_MOVE, we migrate only unshared hugepage. */
 	if (flags & (MPOL_MF_MOVE_ALL) ||
 	    (flags & MPOL_MF_MOVE && page_mapcount(page) == 1)) {
+		qp->last_page = page;
 		if (isolate_hugetlb(page, qp->pagelist) &&
 			(flags & MPOL_MF_STRICT))
 			/*
@@ -740,6 +753,7 @@ queue_pages_range(struct mm_struct *mm, unsigned long start, unsigned long end,
 		.start = start,
 		.end = end,
 		.first = NULL,
+		.last_page = NULL,
 	};
 
 	err = walk_page_range(mm, start, end, &queue_pages_walk_ops, &qp);
diff --git a/mm/migrate.c b/mm/migrate.c
index 8712b694c5a7..197662dd1dc0 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -186,6 +186,9 @@ static bool remove_migration_pte(struct folio *folio,
 		/* pgoff is invalid for ksm pages, but they are never large */
 		if (folio_test_large(folio) && !folio_test_hugetlb(folio))
 			idx = linear_page_index(vma, pvmw.address) - pvmw.pgoff;
+		else if (folio_test_hugetlb(folio))
+			idx = (pvmw.address & ~huge_page_mask(hstate_vma(vma)))/
+				PAGE_SIZE;
 		new = folio_page(folio, idx);
 
 #ifdef CONFIG_ARCH_ENABLE_THP_MIGRATION
@@ -235,14 +238,15 @@ static bool remove_migration_pte(struct folio *folio,
 
 #ifdef CONFIG_HUGETLB_PAGE
 		if (folio_test_hugetlb(folio)) {
+			struct page *hpage = folio_page(folio, 0);
 			unsigned int shift = pvmw.pte_order + PAGE_SHIFT;
 
 			pte = arch_make_huge_pte(pte, shift, vma->vm_flags);
 			if (folio_test_anon(folio))
-				hugepage_add_anon_rmap(new, vma, pvmw.address,
+				hugepage_add_anon_rmap(hpage, vma, pvmw.address,
 						       rmap_flags);
 			else
-				page_dup_file_rmap(new, true);
+				page_dup_file_rmap(hpage, true);
 			set_huge_pte_at(vma->vm_mm, pvmw.address, pvmw.pte, pte);
 		} else
 #endif
@@ -258,7 +262,7 @@ static bool remove_migration_pte(struct folio *folio,
 			mlock_page_drain_local();
 
 		trace_remove_migration_pte(pvmw.address, pte_val(pte),
-					   compound_order(new));
+					   pvmw.pte_order);
 
 		/* No need to invalidate - it was non-present before */
 		update_mmu_cache(vma, pvmw.address, pvmw.pte);
@@ -332,12 +336,12 @@ void __migration_entry_wait_huge(pte_t *ptep, spinlock_t *ptl)
 		migration_entry_wait_on_locked(pte_to_swp_entry(pte), NULL, ptl);
 }
 
-void migration_entry_wait_huge(struct vm_area_struct *vma, pte_t *pte)
+void migration_entry_wait_huge(struct vm_area_struct *vma,
+				struct hugetlb_pte *hpte)
 {
-	spinlock_t *ptl = huge_pte_lockptr(huge_page_shift(hstate_vma(vma)),
-					   vma->vm_mm, pte);
+	spinlock_t *ptl = hugetlb_pte_lockptr(vma->vm_mm, hpte);
 
-	__migration_entry_wait_huge(pte, ptl);
+	__migration_entry_wait_huge(hpte->ptep, ptl);
 }
 #endif
 
-- 
2.38.0.135.g90850a2211-goog

