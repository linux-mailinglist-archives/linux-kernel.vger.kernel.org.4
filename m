Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6989165E8E4
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 11:22:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232917AbjAEKW2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 05:22:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232874AbjAEKUx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 05:20:53 -0500
Received: from mail-vs1-xe49.google.com (mail-vs1-xe49.google.com [IPv6:2607:f8b0:4864:20::e49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7F2D559E8
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 02:19:38 -0800 (PST)
Received: by mail-vs1-xe49.google.com with SMTP id j68-20020a676e47000000b003c860388b23so6349928vsc.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 02:19:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=D85Uov3Vr9+M/n7WNaDbBuEuFLe7i/N1k26DEBJc4Oo=;
        b=Fc+sFoa0jzCWo3hJ/NOaTUhKo/Ryani/NbeUDYNYcfhk7QQC6IXT8SsP8RkpxdgQH0
         Boa0nJMUokcB7P333Ef2yEOjw4nVlYYEEjKGQIu6pJHSa/sd/3BcY0VeYH8OQ7Ull7iD
         RZidov6eS7oRCowhc+nmf87KUuctR7UFMLVm7HW4S88jfAaN6OtaeNBZWA+IhO0nSuMt
         3o/wfdL6uSYfAutpej7givW+b5zwSgmNlC9Aes9ldYfBsTRoMBs8tJvrkPpLBLkF1Gue
         jGQhMxLX3e6eD9v4YR/phB1VaySb2QLjouCRE8nhl5DlmoHI5vi/DDIvbIlCxmosvGfr
         rr2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D85Uov3Vr9+M/n7WNaDbBuEuFLe7i/N1k26DEBJc4Oo=;
        b=uKWWxlKWTzSylhgQtoGYuKJaYV5EzmnU1U4TNZUttyCQincCwFz7eNHXIomPD6h9YN
         Xq5WUfdeyubExL4RE9Yp0piCyO8UvpsqyaA1NmIkJPqSWUjw9gLNo4ME5LXizQvAGH1Y
         XWRa2Vjn/QeSmyJ/SBnbd0TmKaVpv/oQ/NUpKyPVZwBtXeNT9/08+XHlri91OuBsaGcn
         76ztarrVrIYVPdfY6rLjhed7seAS9BcRTqxTg4HSnSBfESZHBbgOt5U+x+6KQjW7umSn
         mlASkIad1WcV3mm5BdIxP3JQ+iD7kSriOE7sOnzniEGzNrKiEtY+5wnqKPpY7XoEiQ8F
         99pg==
X-Gm-Message-State: AFqh2kqjHK5pY1E1mQK3Y2R21Vv8xSMrHATD9wPXmBHNRM1aKzJTEpJJ
        y/lmD5whFKJMESlUoAZgEQqxWcv+KaUKODUu
X-Google-Smtp-Source: AMrXdXtKzLn8QHs3kEDlKhCPd1a8JiEnPA2DYqJZosaypmuepOntKXSSgRH/++rLw3+DjzBbsl1PvOkHnG0diFXv
X-Received: from jthoughton.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:2a4f])
 (user=jthoughton job=sendgmr) by 2002:a05:6130:a19:b0:4aa:585:d7c2 with SMTP
 id bx25-20020a0561300a1900b004aa0585d7c2mr4446498uab.48.1672913978000; Thu,
 05 Jan 2023 02:19:38 -0800 (PST)
Date:   Thu,  5 Jan 2023 10:18:28 +0000
In-Reply-To: <20230105101844.1893104-1-jthoughton@google.com>
Mime-Version: 1.0
References: <20230105101844.1893104-1-jthoughton@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20230105101844.1893104-31-jthoughton@google.com>
Subject: [PATCH 30/46] hugetlb: add high-granularity migration support
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
 mm/hugetlb.c            |  2 +-
 mm/mempolicy.c          | 24 +++++++++++++++++++-----
 mm/migrate.c            | 18 ++++++++++--------
 4 files changed, 36 insertions(+), 16 deletions(-)

diff --git a/include/linux/swapops.h b/include/linux/swapops.h
index 3a451b7afcb3..6ef80763e629 100644
--- a/include/linux/swapops.h
+++ b/include/linux/swapops.h
@@ -68,6 +68,8 @@
 
 static inline bool is_pfn_swap_entry(swp_entry_t entry);
 
+struct hugetlb_pte;
+
 /* Clear all flags but only keep swp_entry_t related information */
 static inline pte_t pte_swp_clear_flags(pte_t pte)
 {
@@ -339,7 +341,8 @@ extern void migration_entry_wait(struct mm_struct *mm, pmd_t *pmd,
 #ifdef CONFIG_HUGETLB_PAGE
 extern void __migration_entry_wait_huge(struct vm_area_struct *vma,
 					pte_t *ptep, spinlock_t *ptl);
-extern void migration_entry_wait_huge(struct vm_area_struct *vma, pte_t *pte);
+extern void migration_entry_wait_huge(struct vm_area_struct *vma,
+					struct hugetlb_pte *hpte);
 #endif	/* CONFIG_HUGETLB_PAGE */
 #else  /* CONFIG_MIGRATION */
 static inline swp_entry_t make_readable_migration_entry(pgoff_t offset)
@@ -369,7 +372,8 @@ static inline void migration_entry_wait(struct mm_struct *mm, pmd_t *pmd,
 #ifdef CONFIG_HUGETLB_PAGE
 static inline void __migration_entry_wait_huge(struct vm_area_struct *vma,
 					       pte_t *ptep, spinlock_t *ptl) { }
-static inline void migration_entry_wait_huge(struct vm_area_struct *vma, pte_t *pte) { }
+static inline void migration_entry_wait_huge(struct vm_area_struct *vma,
+						struct hugetlb_pte *hpte) { }
 #endif	/* CONFIG_HUGETLB_PAGE */
 static inline int is_writable_migration_entry(swp_entry_t entry)
 {
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 8e690a22456a..2fb95ecafc63 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -6269,7 +6269,7 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 			 * be released there.
 			 */
 			mutex_unlock(&hugetlb_fault_mutex_table[hash]);
-			migration_entry_wait_huge(vma, hpte.ptep);
+			migration_entry_wait_huge(vma, &hpte);
 			return 0;
 		} else if (unlikely(is_hugetlb_entry_hwpoisoned(entry)))
 			ret = VM_FAULT_HWPOISON_LARGE |
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index e5859ed34e90..6c4c3c923fa2 100644
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
 	ptl = hugetlb_pte_lock(hpte);
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
@@ -739,6 +752,7 @@ queue_pages_range(struct mm_struct *mm, unsigned long start, unsigned long end,
 		.start = start,
 		.end = end,
 		.first = NULL,
+		.last_page = NULL,
 	};
 
 	err = walk_page_range(mm, start, end, &queue_pages_walk_ops, &qp);
diff --git a/mm/migrate.c b/mm/migrate.c
index 0062689f4878..c30647b75459 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -195,6 +195,9 @@ static bool remove_migration_pte(struct folio *folio,
 		/* pgoff is invalid for ksm pages, but they are never large */
 		if (folio_test_large(folio) && !folio_test_hugetlb(folio))
 			idx = linear_page_index(vma, pvmw.address) - pvmw.pgoff;
+		else if (folio_test_hugetlb(folio))
+			idx = (pvmw.address & ~huge_page_mask(hstate_vma(vma)))/
+				PAGE_SIZE;
 		new = folio_page(folio, idx);
 
 #ifdef CONFIG_ARCH_ENABLE_THP_MIGRATION
@@ -244,14 +247,15 @@ static bool remove_migration_pte(struct folio *folio,
 
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
@@ -267,7 +271,7 @@ static bool remove_migration_pte(struct folio *folio,
 			mlock_page_drain_local();
 
 		trace_remove_migration_pte(pvmw.address, pte_val(pte),
-					   compound_order(new));
+					   pvmw.pte_order);
 
 		/* No need to invalidate - it was non-present before */
 		update_mmu_cache(vma, pvmw.address, pvmw.pte);
@@ -358,12 +362,10 @@ void __migration_entry_wait_huge(struct vm_area_struct *vma,
 	}
 }
 
-void migration_entry_wait_huge(struct vm_area_struct *vma, pte_t *pte)
+void migration_entry_wait_huge(struct vm_area_struct *vma,
+				struct hugetlb_pte *hpte)
 {
-	spinlock_t *ptl = huge_pte_lockptr(huge_page_shift(hstate_vma(vma)),
-					   vma->vm_mm, pte);
-
-	__migration_entry_wait_huge(vma, pte, ptl);
+	__migration_entry_wait_huge(vma, hpte->ptep, hpte->ptl);
 }
 #endif
 
-- 
2.39.0.314.g84b9a713c41-goog

