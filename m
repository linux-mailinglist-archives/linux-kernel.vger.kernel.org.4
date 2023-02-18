Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA04569B6CB
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 01:31:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbjBRAa1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 19:30:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjBRA3q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 19:29:46 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E8446A042
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 16:29:08 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id g63-20020a25db42000000b00889c54916f2so1740410ybf.14
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 16:29:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=WTnKSuVZCt+rhuzvxEm8L73SzZuvMukxFScaxZ9D8Co=;
        b=L30EdOY7ZdwK//mLU+7411LW4r7AXP+dL/wo9+jXO/WcJ04CoJuWdXFBiiCSNGb46t
         sBaVLxi21hhAwKqlQ42PTpoktSV3w8ZCG6GtaV6zNLoCZsWyIozI7LT3SGds8vUSGtvL
         8bn+t4XSOU3//vae5pDb5V2Wt0nqx+ASlUpTQxUcwOKp6auK0QYbvPxXLS//Whkg8Xep
         plK+8niTC21BXzXzAR2uTAn/GBxuv7yY3ZRhMgy6+GQbwBq7yNFIB3yLNd8/V4O+5B+l
         K1VKQkZL1YOcNbEpaCrjieJj1keaKiBGGAuUTdjO/zQEfWTY5Cm/wW0Vm3cp6E52Cyi6
         zD3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WTnKSuVZCt+rhuzvxEm8L73SzZuvMukxFScaxZ9D8Co=;
        b=0EQQyy4WyF59saCcw0ncJxjXFGXYuH36e6jym9jikNLUgOcyGZC9wj+pGWiP0m2+4z
         efmGDNmuoVvC1j/k6cnoiU+pvNGHfmaBu9hGE7KTh5JlSdrMo0jVDbobn3Yd/4oGukWy
         m8qqCriHUfZivi7GG5+YNxijINapKefmFHASrjjHvK8rpnOnbjPnMmJtkOcNkOf2WfdR
         v9TJcuQBKtTxIrlvmOtcWSY4/NEf3RUphasbvvfQsbC5Gm0LpUxkT+wJ0OUs2YGRe6HM
         o9VEbxNb+lowBW3JW9d9yHkPIApioohy2wSvlJeHsfbQBAvLSXAj9VgZBg6Va0edWU2t
         VkbA==
X-Gm-Message-State: AO0yUKWOY7y+VEIZd7bwNB67p59ohrAZ3sbEylwvKbHPkKK3a1wGYTJX
        LlRXCkchX1XaOBHrQNUJlWhEA30QLmSsZKwO
X-Google-Smtp-Source: AK7set+JZbRX7CDnj+Gizzbk/DH4kxZkKGMSGcEb4+M9JWKbZSU4JEyz12TmXNRwFx+ySFC7KGlj2zgmA6wzw7Gh
X-Received: from jthoughton.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:2a4f])
 (user=jthoughton job=sendgmr) by 2002:a05:6902:154b:b0:97a:ebd:a594 with SMTP
 id r11-20020a056902154b00b0097a0ebda594mr79653ybu.3.1676680147254; Fri, 17
 Feb 2023 16:29:07 -0800 (PST)
Date:   Sat, 18 Feb 2023 00:27:57 +0000
In-Reply-To: <20230218002819.1486479-1-jthoughton@google.com>
Mime-Version: 1.0
References: <20230218002819.1486479-1-jthoughton@google.com>
X-Mailer: git-send-email 2.39.2.637.g21b0678d19-goog
Message-ID: <20230218002819.1486479-25-jthoughton@google.com>
Subject: [PATCH v2 24/46] hugetlb: add HGM support to hugetlb_fault and hugetlb_no_page
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

Update the page fault handler to support high-granularity page faults.
While handling a page fault on a partially-mapped HugeTLB page, if the
PTE we find with hugetlb_pte_walk is none, then we will replace it with
a leaf-level PTE to map the page. To give some examples:
1. For a completely unmapped 1G page, it will be mapped with a 1G PUD.
2. For a 1G page that has its first 512M mapped, any faults on the
   unmapped sections will result in 2M PMDs mapping each unmapped 2M
   section.
3. For a 1G page that has only its first 4K mapped, a page fault on its
   second 4K section will get a 4K PTE to map it.

Unless high-granularity mappings are created via UFFDIO_CONTINUE, it is
impossible for hugetlb_fault to create high-granularity mappings.

This commit does not handle hugetlb_wp right now, and it doesn't handle
HugeTLB page migration and swap entries.

The BUG_ON in huge_pte_alloc is removed, as it is not longer valid when
HGM is possible. HGM can be disabled if the VMA lock cannot be allocated
after a VMA is split, yet high-granularity mappings may still exist.

Signed-off-by: James Houghton <jthoughton@google.com>

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 6c4678b7a07d..86cd51beb02c 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -173,6 +173,18 @@ void hugetlb_add_file_rmap(struct page *subpage, unsigned long shift,
 	}
 }
 
+/*
+ * Find the subpage that corresponds to `addr` in `folio`.
+ */
+static struct page *hugetlb_find_subpage(struct hstate *h, struct folio *folio,
+					 unsigned long addr)
+{
+	size_t idx = (addr & ~huge_page_mask(h))/PAGE_SIZE;
+
+	BUG_ON(idx >= pages_per_huge_page(h));
+	return folio_page(folio, idx);
+}
+
 static inline bool subpool_is_free(struct hugepage_subpool *spool)
 {
 	if (spool->count)
@@ -6072,14 +6084,14 @@ static inline vm_fault_t hugetlb_handle_userfault(struct vm_area_struct *vma,
  * Recheck pte with pgtable lock.  Returns true if pte didn't change, or
  * false if pte changed or is changing.
  */
-static bool hugetlb_pte_stable(struct hstate *h, struct mm_struct *mm,
-			       pte_t *ptep, pte_t old_pte)
+static bool hugetlb_pte_stable(struct hstate *h, struct hugetlb_pte *hpte,
+			       pte_t old_pte)
 {
 	spinlock_t *ptl;
 	bool same;
 
-	ptl = huge_pte_lock(h, mm, ptep);
-	same = pte_same(huge_ptep_get(ptep), old_pte);
+	ptl = hugetlb_pte_lock(hpte);
+	same = pte_same(huge_ptep_get(hpte->ptep), old_pte);
 	spin_unlock(ptl);
 
 	return same;
@@ -6088,7 +6100,7 @@ static bool hugetlb_pte_stable(struct hstate *h, struct mm_struct *mm,
 static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 			struct vm_area_struct *vma,
 			struct address_space *mapping, pgoff_t idx,
-			unsigned long address, pte_t *ptep,
+			unsigned long address, struct hugetlb_pte *hpte,
 			pte_t old_pte, unsigned int flags)
 {
 	struct hstate *h = hstate_vma(vma);
@@ -6096,10 +6108,12 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 	int anon_rmap = 0;
 	unsigned long size;
 	struct folio *folio;
+	struct page *subpage;
 	pte_t new_pte;
 	spinlock_t *ptl;
 	unsigned long haddr = address & huge_page_mask(h);
 	bool new_folio, new_pagecache_folio = false;
+	unsigned long haddr_hgm = address & hugetlb_pte_mask(hpte);
 	u32 hash = hugetlb_fault_mutex_hash(mapping, idx);
 
 	/*
@@ -6143,7 +6157,7 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 			 * never happen on the page after UFFDIO_COPY has
 			 * correctly installed the page and returned.
 			 */
-			if (!hugetlb_pte_stable(h, mm, ptep, old_pte)) {
+			if (!hugetlb_pte_stable(h, hpte, old_pte)) {
 				ret = 0;
 				goto out;
 			}
@@ -6167,7 +6181,7 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 			 * here.  Before returning error, get ptl and make
 			 * sure there really is no pte entry.
 			 */
-			if (hugetlb_pte_stable(h, mm, ptep, old_pte))
+			if (hugetlb_pte_stable(h, hpte, old_pte))
 				ret = vmf_error(PTR_ERR(folio));
 			else
 				ret = 0;
@@ -6217,7 +6231,7 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 			folio_unlock(folio);
 			folio_put(folio);
 			/* See comment in userfaultfd_missing() block above */
-			if (!hugetlb_pte_stable(h, mm, ptep, old_pte)) {
+			if (!hugetlb_pte_stable(h, hpte, old_pte)) {
 				ret = 0;
 				goto out;
 			}
@@ -6242,30 +6256,46 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 		vma_end_reservation(h, vma, haddr);
 	}
 
-	ptl = huge_pte_lock(h, mm, ptep);
+	ptl = hugetlb_pte_lock(hpte);
 	ret = 0;
-	/* If pte changed from under us, retry */
-	if (!pte_same(huge_ptep_get(ptep), old_pte))
+	/*
+	 * If pte changed from under us, retry.
+	 *
+	 * When dealing with high-granularity-mapped PTEs, it's possible that
+	 * a non-contiguous PTE within our contiguous PTE group gets populated,
+	 * in which case, we need to retry here. This is NOT caught here, and
+	 * will need to be addressed when HGM is supported for architectures
+	 * that support contiguous PTEs.
+	 */
+	if (!pte_same(huge_ptep_get(hpte->ptep), old_pte))
 		goto backout;
 
-	if (anon_rmap)
+	subpage = hugetlb_find_subpage(h, folio, haddr_hgm);
+
+	if (anon_rmap) {
+		VM_BUG_ON(&folio->page != subpage);
 		hugepage_add_new_anon_rmap(folio, vma, haddr);
+	}
 	else
-		page_add_file_rmap(&folio->page, vma, true);
-	new_pte = make_huge_pte(vma, &folio->page, ((vma->vm_flags & VM_WRITE)
-				&& (vma->vm_flags & VM_SHARED)));
+		hugetlb_add_file_rmap(subpage, hpte->shift, h, vma);
+
+	new_pte = make_huge_pte_with_shift(vma, subpage,
+			((vma->vm_flags & VM_WRITE)
+			 && (vma->vm_flags & VM_SHARED)),
+			hpte->shift);
 	/*
 	 * If this pte was previously wr-protected, keep it wr-protected even
 	 * if populated.
 	 */
 	if (unlikely(pte_marker_uffd_wp(old_pte)))
 		new_pte = huge_pte_mkuffd_wp(new_pte);
-	set_huge_pte_at(mm, haddr, ptep, new_pte);
+	set_huge_pte_at(mm, haddr_hgm, hpte->ptep, new_pte);
 
-	hugetlb_count_add(pages_per_huge_page(h), mm);
+	hugetlb_count_add(hugetlb_pte_size(hpte) / PAGE_SIZE, mm);
 	if ((flags & FAULT_FLAG_WRITE) && !(vma->vm_flags & VM_SHARED)) {
+		WARN_ON_ONCE(hugetlb_pte_size(hpte) != huge_page_size(h));
 		/* Optimization, do the COW without a second fault */
-		ret = hugetlb_wp(mm, vma, address, ptep, flags, folio, ptl);
+		ret = hugetlb_wp(mm, vma, address, hpte->ptep, flags, folio, ptl);
 	}
 
 	spin_unlock(ptl);
@@ -6322,17 +6352,19 @@ u32 hugetlb_fault_mutex_hash(struct address_space *mapping, pgoff_t idx)
 vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 			unsigned long address, unsigned int flags)
 {
-	pte_t *ptep, entry;
+	pte_t entry;
 	spinlock_t *ptl;
 	vm_fault_t ret;
 	u32 hash;
 	pgoff_t idx;
-	struct page *page = NULL;
-	struct folio *pagecache_folio = NULL;
+	struct page *subpage = NULL;
+	struct folio *pagecache_folio = NULL, *folio = NULL;
 	struct hstate *h = hstate_vma(vma);
 	struct address_space *mapping;
 	int need_wait_lock = 0;
 	unsigned long haddr = address & huge_page_mask(h);
+	unsigned long haddr_hgm;
+	struct hugetlb_pte hpte;
 
 	/*
 	 * Serialize hugepage allocation and instantiation, so that we don't
@@ -6346,26 +6378,26 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 
 	/*
 	 * Acquire vma lock before calling huge_pte_alloc and hold
-	 * until finished with ptep.  This prevents huge_pmd_unshare from
-	 * being called elsewhere and making the ptep no longer valid.
+	 * until finished with hpte.  This prevents huge_pmd_unshare from
+	 * being called elsewhere and making the hpte no longer valid.
 	 */
 	hugetlb_vma_lock_read(vma);
-	ptep = huge_pte_alloc(mm, vma, haddr, huge_page_size(h));
-	if (!ptep) {
+	if (hugetlb_full_walk_alloc(&hpte, vma, address, 0)) {
 		hugetlb_vma_unlock_read(vma);
 		mutex_unlock(&hugetlb_fault_mutex_table[hash]);
 		return VM_FAULT_OOM;
 	}
 
-	entry = huge_ptep_get(ptep);
+	entry = huge_ptep_get(hpte.ptep);
 	/* PTE markers should be handled the same way as none pte */
-	if (huge_pte_none_mostly(entry))
+	if (huge_pte_none_mostly(entry)) {
 		/*
 		 * hugetlb_no_page will drop vma lock and hugetlb fault
 		 * mutex internally, which make us return immediately.
 		 */
-		return hugetlb_no_page(mm, vma, mapping, idx, address, ptep,
+		return hugetlb_no_page(mm, vma, mapping, idx, address, &hpte,
 				      entry, flags);
+	}
 
 	ret = 0;
 
@@ -6386,7 +6418,7 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 			 * be released there.
 			 */
 			mutex_unlock(&hugetlb_fault_mutex_table[hash]);
-			migration_entry_wait_huge(vma, ptep);
+			migration_entry_wait_huge(vma, hpte.ptep);
 			return 0;
 		} else if (unlikely(is_hugetlb_entry_hwpoisoned(entry)))
 			ret = VM_FAULT_HWPOISON_LARGE |
@@ -6394,6 +6426,10 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 		goto out_mutex;
 	}
 
+	if (!hugetlb_pte_present_leaf(&hpte, entry))
+		/* We raced with someone splitting the entry. */
+		goto out_mutex;
+
 	/*
 	 * If we are going to COW/unshare the mapping later, we examine the
 	 * pending reservations for this page now. This will ensure that any
@@ -6413,14 +6449,17 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 		pagecache_folio = filemap_lock_folio(mapping, idx);
 	}
 
-	ptl = huge_pte_lock(h, mm, ptep);
+	ptl = hugetlb_pte_lock(&hpte);
 
 	/* Check for a racing update before calling hugetlb_wp() */
-	if (unlikely(!pte_same(entry, huge_ptep_get(ptep))))
+	if (unlikely(!pte_same(entry, huge_ptep_get(hpte.ptep))))
 		goto out_ptl;
 
+	/* haddr_hgm is the base address of the region that hpte maps. */
+	haddr_hgm = address & hugetlb_pte_mask(&hpte);
+
 	/* Handle userfault-wp first, before trying to lock more pages */
-	if (userfaultfd_wp(vma) && huge_pte_uffd_wp(huge_ptep_get(ptep)) &&
+	if (userfaultfd_wp(vma) && huge_pte_uffd_wp(entry) &&
 	    (flags & FAULT_FLAG_WRITE) && !huge_pte_write(entry)) {
 		struct vm_fault vmf = {
 			.vma = vma,
@@ -6444,18 +6483,21 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 	 * pagecache_folio, so here we need take the former one
 	 * when page != pagecache_folio or !pagecache_folio.
 	 */
-	page = pte_page(entry);
-	if (page_folio(page) != pagecache_folio)
-		if (!trylock_page(page)) {
+	subpage = pte_page(entry);
+	folio = page_folio(subpage);
+	if (folio != pagecache_folio)
+		if (!trylock_page(&folio->page)) {
 			need_wait_lock = 1;
 			goto out_ptl;
 		}
 
-	get_page(page);
+	folio_get(folio);
 
 	if (flags & (FAULT_FLAG_WRITE|FAULT_FLAG_UNSHARE)) {
 		if (!huge_pte_write(entry)) {
-			ret = hugetlb_wp(mm, vma, address, ptep, flags,
+			WARN_ON_ONCE(hugetlb_pte_size(&hpte) !=
+					huge_page_size(h));
+			ret = hugetlb_wp(mm, vma, address, hpte.ptep, flags,
 					 pagecache_folio, ptl);
 			goto out_put_page;
 		} else if (likely(flags & FAULT_FLAG_WRITE)) {
@@ -6463,13 +6505,13 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 		}
 	}
 	entry = pte_mkyoung(entry);
-	if (huge_ptep_set_access_flags(vma, haddr, ptep, entry,
+	if (huge_ptep_set_access_flags(vma, haddr_hgm, hpte.ptep, entry,
 						flags & FAULT_FLAG_WRITE))
-		update_mmu_cache(vma, haddr, ptep);
+		update_mmu_cache(vma, haddr_hgm, hpte.ptep);
 out_put_page:
-	if (page_folio(page) != pagecache_folio)
-		unlock_page(page);
-	put_page(page);
+	if (folio != pagecache_folio)
+		folio_unlock(folio);
+	folio_put(folio);
 out_ptl:
 	spin_unlock(ptl);
 
@@ -6488,7 +6530,7 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 	 * here without taking refcount.
 	 */
 	if (need_wait_lock)
-		wait_on_page_locked(page);
+		wait_on_page_locked(&folio->page);
 	return ret;
 }
 
@@ -7689,6 +7731,9 @@ int hugetlb_full_walk(struct hugetlb_pte *hpte,
 /*
  * hugetlb_full_walk_alloc - do a high-granularity walk, potentially allocate
  *	new PTEs.
+ *
+ * If @target_sz is 0, then only attempt to allocate the hstate-level PTE and
+ * walk as far as we can go.
  */
 int hugetlb_full_walk_alloc(struct hugetlb_pte *hpte,
 				   struct vm_area_struct *vma,
@@ -7707,6 +7752,12 @@ int hugetlb_full_walk_alloc(struct hugetlb_pte *hpte,
 	if (!ptep)
 		return -ENOMEM;
 
+	if (!target_sz) {
+		WARN_ON_ONCE(hugetlb_hgm_walk(hpte, ptep, vma, addr,
+					      PAGE_SIZE, false));
+		return 0;
+	}
+
 	return hugetlb_hgm_walk(hpte, ptep, vma, addr, target_sz, true);
 }
 
@@ -7735,7 +7786,6 @@ pte_t *huge_pte_alloc(struct mm_struct *mm, struct vm_area_struct *vma,
 				pte = (pte_t *)pmd_alloc(mm, pud, addr);
 		}
 	}
-	BUG_ON(pte && pte_present(*pte) && !pte_huge(*pte));
 
 	return pte;
 }
-- 
2.39.2.637.g21b0678d19-goog

