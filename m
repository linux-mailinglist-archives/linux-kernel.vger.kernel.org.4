Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B60269B6BF
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 01:31:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbjBRAbN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 19:31:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbjBRAaJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 19:30:09 -0500
Received: from mail-ua1-x949.google.com (mail-ua1-x949.google.com [IPv6:2607:f8b0:4864:20::949])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0CED6ABE5
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 16:29:23 -0800 (PST)
Received: by mail-ua1-x949.google.com with SMTP id v19-20020ab02013000000b0068b9f3e0a2dso625893uak.6
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 16:29:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1676680154;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6R+bM0KtFeTkcEJ8SgP6306LOQusudAcElSasV+tkuA=;
        b=dX7/40KBqq/CpQhiOpkAQIzPNluCgT+pqoGZRKlN9aa8QluovsQruDCu/wh6+Xi7HL
         6kLXZgl+5XKDk7FsMYGYtr2yyFU9erZiSo7V2dyAwIFPJO5DAOooAQa2F7w+5zW0Hqdu
         QubYMhLcbqNzMIVdTubD/VkEI82Q/CwfufnycIJ0sLbdRiI6AathfyY49TSn1Ly/A6+9
         +4K1wirIYyv3shJT02BYKt93mVx2ZH0jSU1+ZgamxSym8xZo1mO/BLj8U+ZTd86LEOwb
         MxBJulRTBsOmTowXosHxX9g5jLuhbpjY1XM7qMG0aeLiOSSYz9qPT0kULRTK/B6ula9l
         hMbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1676680154;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6R+bM0KtFeTkcEJ8SgP6306LOQusudAcElSasV+tkuA=;
        b=cJrD3+hq5WY0ANbp4ZCwIe9zpPqlv5jbfkEpLrdx0T1gsqDYCwc0hhmruYOFTLI7Pm
         A59UPSHYbSEHIv7tGF0oFVITc28Fsrd53io/Tm7WKyCr7bDbvaXcXIDrmtDMjKmsX3vg
         OpDcGRnAOxxMhFcj8tQgPQXKvKjcpjWJ8BIfZ5vyJMEx6bid1kePz93SHiraPDG7pHYl
         6cv1Pwf/NeKNIROZBqwb/2ZI993aXIoLFzsE3/n8Bkt9MN9mQVcVu3/TG9VzntpH+Ycp
         SQgOrwDn4pWCDGUcBOXtzN7hvZJB0iCm8kLAyn7xuBWFdUEYiZFPTQv98eFhPMw+9OSq
         N7rg==
X-Gm-Message-State: AO0yUKVKb5T3f9fYJiri3zAP/TCYorE8uaLUhO9ayGkdMrPR9JOFnp0+
        bvKebIu8p5+axqhIfwhjspGyINs5HM9GZ8pS
X-Google-Smtp-Source: AK7set8ydXZ+Dciv1+JvuwKHd4m9xN+HXoJNqOMVwMnv6hYgnClrworMO3PvsXyUer/h8BcS4rjrDLd27tp3RFfQ
X-Received: from jthoughton.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:2a4f])
 (user=jthoughton job=sendgmr) by 2002:a1f:a041:0:b0:401:7fe9:ff7f with SMTP
 id j62-20020a1fa041000000b004017fe9ff7fmr213533vke.5.1676680153948; Fri, 17
 Feb 2023 16:29:13 -0800 (PST)
Date:   Sat, 18 Feb 2023 00:28:03 +0000
In-Reply-To: <20230218002819.1486479-1-jthoughton@google.com>
Mime-Version: 1.0
References: <20230218002819.1486479-1-jthoughton@google.com>
X-Mailer: git-send-email 2.39.2.637.g21b0678d19-goog
Message-ID: <20230218002819.1486479-31-jthoughton@google.com>
Subject: [PATCH v2 30/46] hugetlb: add high-granularity migration support
From:   James Houghton <jthoughton@google.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Peter Xu <peterx@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
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
        Frank van der Linden <fvdl@google.com>,
        Jiaqi Yan <jiaqiyan@google.com>, linux-mm@kvack.org,
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
last_folio to keep track of the last page we saw in queue_pages_hugetlb,
and if the page we're looking at is last_folio, then we skip it.

For the non-hugetlb cases, last_folio, although unused, is still updated
so that it has a consistent meaning with the hugetlb case.

Signed-off-by: James Houghton <jthoughton@google.com>

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
index 86cd51beb02c..39f541b4a0a8 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -6418,7 +6418,7 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 			 * be released there.
 			 */
 			mutex_unlock(&hugetlb_fault_mutex_table[hash]);
-			migration_entry_wait_huge(vma, hpte.ptep);
+			migration_entry_wait_huge(vma, &hpte);
 			return 0;
 		} else if (unlikely(is_hugetlb_entry_hwpoisoned(entry)))
 			ret = VM_FAULT_HWPOISON_LARGE |
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 0f91be88392b..43e210181cce 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -424,6 +424,7 @@ struct queue_pages {
 	unsigned long start;
 	unsigned long end;
 	struct vm_area_struct *first;
+	struct folio *last_folio;
 };
 
 /*
@@ -475,6 +476,7 @@ static int queue_folios_pmd(pmd_t *pmd, spinlock_t *ptl, unsigned long addr,
 	flags = qp->flags;
 	/* go to folio migration */
 	if (flags & (MPOL_MF_MOVE | MPOL_MF_MOVE_ALL)) {
+		qp->last_folio = folio;
 		if (!vma_migratable(walk->vma) ||
 		    migrate_folio_add(folio, qp->pagelist, flags)) {
 			ret = 1;
@@ -539,6 +541,8 @@ static int queue_folios_pte_range(pmd_t *pmd, unsigned long addr,
 				break;
 			}
 
+			qp->last_folio = folio;
+
 			/*
 			 * Do not abort immediately since there may be
 			 * temporary off LRU pages in the range.  Still
@@ -570,15 +574,22 @@ static int queue_folios_hugetlb(struct hugetlb_pte *hpte,
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
-	folio = pfn_folio(pte_pfn(entry));
+
+	if (!hugetlb_pte_present_leaf(hpte, entry)) {
+		ret = -EAGAIN;
+		goto unlock;
+	}
+
+	folio = page_folio(pte_page(entry));
+
+	/* We already queued this page with another high-granularity PTE. */
+	if (folio == qp->last_folio)
+		goto unlock;
+
 	if (!queue_folio_required(folio, qp))
 		goto unlock;
 
@@ -747,6 +758,7 @@ queue_pages_range(struct mm_struct *mm, unsigned long start, unsigned long end,
 		.start = start,
 		.end = end,
 		.first = NULL,
+		.last_folio = NULL,
 	};
 
 	err = walk_page_range(mm, start, end, &queue_pages_walk_ops, &qp);
diff --git a/mm/migrate.c b/mm/migrate.c
index 616afcc40fdc..b26169990532 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -196,6 +196,9 @@ static bool remove_migration_pte(struct folio *folio,
 		/* pgoff is invalid for ksm pages, but they are never large */
 		if (folio_test_large(folio) && !folio_test_hugetlb(folio))
 			idx = linear_page_index(vma, pvmw.address) - pvmw.pgoff;
+		else if (folio_test_hugetlb(folio))
+			idx = (pvmw.address & ~huge_page_mask(hstate_vma(vma)))/
+				PAGE_SIZE;
 		new = folio_page(folio, idx);
 
 #ifdef CONFIG_ARCH_ENABLE_THP_MIGRATION
@@ -247,14 +250,16 @@ static bool remove_migration_pte(struct folio *folio,
 
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
-				page_add_file_rmap(new, vma, true);
+				hugetlb_add_file_rmap(new, shift,
+						hstate_vma(vma), vma);
 			set_huge_pte_at(vma->vm_mm, pvmw.address, pvmw.pte, pte);
 		} else
 #endif
@@ -270,7 +275,7 @@ static bool remove_migration_pte(struct folio *folio,
 			mlock_drain_local();
 
 		trace_remove_migration_pte(pvmw.address, pte_val(pte),
-					   compound_order(new));
+					   pvmw.pte_order);
 
 		/* No need to invalidate - it was non-present before */
 		update_mmu_cache(vma, pvmw.address, pvmw.pte);
@@ -361,12 +366,10 @@ void __migration_entry_wait_huge(struct vm_area_struct *vma,
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
2.39.2.637.g21b0678d19-goog

