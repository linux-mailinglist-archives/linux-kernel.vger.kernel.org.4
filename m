Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07D61607C80
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 18:40:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231363AbiJUQkG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 12:40:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231145AbiJUQir (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 12:38:47 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C94B12892E2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 09:37:42 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id v17-20020a259d91000000b006b4c31c0640so3722736ybp.18
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 09:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xcIc6o2q1ZWtyzFetKZVD9MlAzdaCFh0Vvt9+xlVO4U=;
        b=RBhXCh4+M6IU1RPOCl/mMwL/StlmI///zFvgKrj30KQcO9AVvs3UiO61F1asmizkBs
         xj35V7Esrs0WYRxwoyhm7vvnHyJsjHl37OhS9h/vWxsEHfNinNfICaG7CudxLzL06C2/
         ZNuGUVrCoCLtVIzeXI+CZNkVbBFWX4dzCSWr/REeJH2L4rNTqx80kStlB6xJeNxzmo+p
         um0YkZS3Pl93a17EcSQA2mJP+JIyDjPEhxfNNRk/fLvPyR7v7qRC28tNFCPNiLrxtNze
         fip6KSAYskk7JdwZzlm12LEGDesz9sLZXePmgdnFbFD5TgEwuKmoBgaXaElakdHSJy4e
         /oeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xcIc6o2q1ZWtyzFetKZVD9MlAzdaCFh0Vvt9+xlVO4U=;
        b=K77a7pBx5/UP9rQHJJDCY2tNyz1L4IiiQgQUT9FCgfeUN3e3YdeyeGak42kcwhH4AL
         UniH3gsFxdMZDLfXhHI+hSJS7yJqdEmtwAnjyyexSNPOoM7RtrwVtQpjGl0iLWLRSa2p
         Ja88GVEPIs6WvgSfY98w0fBKbUgXHE2rpmjLSRFB3Vjxj60yobHwB1xqXp5CPM0zx2bc
         K0dAWSmeOkV6045J7jpf+WmYrNbBbX9OSGA4wsWoLJAo//x0S4aAbUrs/U3yK11z9p87
         KSBHSnpwF5iU64spGcr/d/CX4pUUKSedxr61kHedqH1jOSNBCjoID/erMReOc7yzGgLY
         2tug==
X-Gm-Message-State: ACrzQf1cl6GxfBDbNyw5bU9lbS5GcHq8XNtyh2PO9IDnGia5iFzzDUBE
        MI+2oxmk8J6QhOD81BLJRLWKpPUAixU4WA0h
X-Google-Smtp-Source: AMsMyM4u8CD3I4d/tpVW86y/KkJ5f8bn6NYPFbZDH2CmgCL5LSoZ0MSJDJQ0DAkF1J5yuH1SLUcG/xHay8AE1gFf
X-Received: from jthoughton.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:2a4f])
 (user=jthoughton job=sendgmr) by 2002:a5b:8c2:0:b0:6bc:272:4f42 with SMTP id
 w2-20020a5b08c2000000b006bc02724f42mr17980966ybq.555.1666370261433; Fri, 21
 Oct 2022 09:37:41 -0700 (PDT)
Date:   Fri, 21 Oct 2022 16:36:43 +0000
In-Reply-To: <20221021163703.3218176-1-jthoughton@google.com>
Mime-Version: 1.0
References: <20221021163703.3218176-1-jthoughton@google.com>
X-Mailer: git-send-email 2.38.0.135.g90850a2211-goog
Message-ID: <20221021163703.3218176-28-jthoughton@google.com>
Subject: [RFC PATCH v2 27/47] hugetlb: add HGM support for hugetlb_fault and hugetlb_no_page
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

Signed-off-by: James Houghton <jthoughton@google.com>
---
 mm/hugetlb.c | 90 +++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 64 insertions(+), 26 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 16b0d192445c..2ee2c48ee79c 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -118,6 +118,18 @@ enum hugetlb_level hpage_size_to_level(unsigned long sz)
 	return HUGETLB_LEVEL_PGD;
 }
 
+/*
+ * Find the subpage that corresponds to `addr` in `hpage`.
+ */
+static struct page *hugetlb_find_subpage(struct hstate *h, struct page *hpage,
+				 unsigned long addr)
+{
+	size_t idx = (addr & ~huge_page_mask(h))/PAGE_SIZE;
+
+	BUG_ON(idx >= pages_per_huge_page(h));
+	return &hpage[idx];
+}
+
 static inline bool subpool_is_free(struct hugepage_subpool *spool)
 {
 	if (spool->count)
@@ -5810,13 +5822,13 @@ static inline vm_fault_t hugetlb_handle_userfault(struct vm_area_struct *vma,
  * false if pte changed or is changing.
  */
 static bool hugetlb_pte_stable(struct hstate *h, struct mm_struct *mm,
-			       pte_t *ptep, pte_t old_pte)
+			       struct hugetlb_pte *hpte, pte_t old_pte)
 {
 	spinlock_t *ptl;
 	bool same;
 
-	ptl = huge_pte_lock(h, mm, ptep);
-	same = pte_same(huge_ptep_get(ptep), old_pte);
+	ptl = hugetlb_pte_lock(mm, hpte);
+	same = pte_same(huge_ptep_get(hpte->ptep), old_pte);
 	spin_unlock(ptl);
 
 	return same;
@@ -5825,17 +5837,18 @@ static bool hugetlb_pte_stable(struct hstate *h, struct mm_struct *mm,
 static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 			struct vm_area_struct *vma,
 			struct address_space *mapping, pgoff_t idx,
-			unsigned long address, pte_t *ptep,
+			unsigned long address, struct hugetlb_pte *hpte,
 			pte_t old_pte, unsigned int flags)
 {
 	struct hstate *h = hstate_vma(vma);
 	vm_fault_t ret = VM_FAULT_SIGBUS;
 	int anon_rmap = 0;
 	unsigned long size;
-	struct page *page;
+	struct page *page, *subpage;
 	pte_t new_pte;
 	spinlock_t *ptl;
 	unsigned long haddr = address & huge_page_mask(h);
+	unsigned long haddr_hgm = address & hugetlb_pte_mask(hpte);
 	bool new_page, new_pagecache_page = false;
 	u32 hash = hugetlb_fault_mutex_hash(mapping, idx);
 
@@ -5880,7 +5893,7 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 			 * never happen on the page after UFFDIO_COPY has
 			 * correctly installed the page and returned.
 			 */
-			if (!hugetlb_pte_stable(h, mm, ptep, old_pte)) {
+			if (!hugetlb_pte_stable(h, mm, hpte, old_pte)) {
 				ret = 0;
 				goto out;
 			}
@@ -5904,7 +5917,7 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 			 * here.  Before returning error, get ptl and make
 			 * sure there really is no pte entry.
 			 */
-			if (hugetlb_pte_stable(h, mm, ptep, old_pte))
+			if (hugetlb_pte_stable(h, mm, hpte, old_pte))
 				ret = vmf_error(PTR_ERR(page));
 			else
 				ret = 0;
@@ -5954,7 +5967,7 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 			unlock_page(page);
 			put_page(page);
 			/* See comment in userfaultfd_missing() block above */
-			if (!hugetlb_pte_stable(h, mm, ptep, old_pte)) {
+			if (!hugetlb_pte_stable(h, mm, hpte, old_pte)) {
 				ret = 0;
 				goto out;
 			}
@@ -5979,10 +5992,10 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 		vma_end_reservation(h, vma, haddr);
 	}
 
-	ptl = huge_pte_lock(h, mm, ptep);
+	ptl = hugetlb_pte_lock(mm, hpte);
 	ret = 0;
 	/* If pte changed from under us, retry */
-	if (!pte_same(huge_ptep_get(ptep), old_pte))
+	if (!pte_same(huge_ptep_get(hpte->ptep), old_pte))
 		goto backout;
 
 	if (anon_rmap) {
@@ -5990,20 +6003,25 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 		hugepage_add_new_anon_rmap(page, vma, haddr);
 	} else
 		page_dup_file_rmap(page, true);
-	new_pte = make_huge_pte(vma, page, ((vma->vm_flags & VM_WRITE)
-				&& (vma->vm_flags & VM_SHARED)));
+
+	subpage = hugetlb_find_subpage(h, page, haddr_hgm);
+	new_pte = make_huge_pte_with_shift(vma, subpage,
+			((vma->vm_flags & VM_WRITE)
+			 && (vma->vm_flags & VM_SHARED)),
+			hpte->shift);
 	/*
 	 * If this pte was previously wr-protected, keep it wr-protected even
 	 * if populated.
 	 */
 	if (unlikely(pte_marker_uffd_wp(old_pte)))
 		new_pte = huge_pte_wrprotect(huge_pte_mkuffd_wp(new_pte));
-	set_huge_pte_at(mm, haddr, ptep, new_pte);
+	set_huge_pte_at(mm, haddr_hgm, hpte->ptep, new_pte);
 
-	hugetlb_count_add(pages_per_huge_page(h), mm);
+	hugetlb_count_add(hugetlb_pte_size(hpte) / PAGE_SIZE, mm);
 	if ((flags & FAULT_FLAG_WRITE) && !(vma->vm_flags & VM_SHARED)) {
+		BUG_ON(hugetlb_pte_size(hpte) != huge_page_size(h));
 		/* Optimization, do the COW without a second fault */
-		ret = hugetlb_wp(mm, vma, address, ptep, flags, page, ptl);
+		ret = hugetlb_wp(mm, vma, address, hpte->ptep, flags, page, ptl);
 	}
 
 	spin_unlock(ptl);
@@ -6066,11 +6084,14 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 	u32 hash;
 	pgoff_t idx;
 	struct page *page = NULL;
+	struct page *subpage = NULL;
 	struct page *pagecache_page = NULL;
 	struct hstate *h = hstate_vma(vma);
 	struct address_space *mapping;
 	int need_wait_lock = 0;
 	unsigned long haddr = address & huge_page_mask(h);
+	unsigned long haddr_hgm;
+	struct hugetlb_pte hpte;
 
 	ptep = huge_pte_offset(mm, haddr, huge_page_size(h));
 	if (ptep) {
@@ -6115,15 +6136,22 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 		return VM_FAULT_OOM;
 	}
 
-	entry = huge_ptep_get(ptep);
+	hugetlb_pte_populate(&hpte, ptep, huge_page_shift(h),
+			hpage_size_to_level(huge_page_size(h)));
+	/* Do a high-granularity page table walk. */
+	hugetlb_hgm_walk(mm, vma, &hpte, address, PAGE_SIZE,
+			/*stop_at_none=*/true);
+
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
 
@@ -6137,6 +6165,10 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 	if (!pte_present(entry))
 		goto out_mutex;
 
+	if (!hugetlb_pte_present_leaf(&hpte, entry))
+		/* We raced with someone splitting the entry. */
+		goto out_mutex;
+
 	/*
 	 * If we are going to COW/unshare the mapping later, we examine the
 	 * pending reservations for this page now. This will ensure that any
@@ -6156,14 +6188,17 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 		pagecache_page = find_lock_page(mapping, idx);
 	}
 
-	ptl = huge_pte_lock(h, mm, ptep);
+	ptl = hugetlb_pte_lock(mm, &hpte);
 
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
@@ -6187,7 +6222,8 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 	 * pagecache_page, so here we need take the former one
 	 * when page != pagecache_page or !pagecache_page.
 	 */
-	page = pte_page(entry);
+	subpage = pte_page(entry);
+	page = compound_head(subpage);
 	if (page != pagecache_page)
 		if (!trylock_page(page)) {
 			need_wait_lock = 1;
@@ -6198,7 +6234,8 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 
 	if (flags & (FAULT_FLAG_WRITE|FAULT_FLAG_UNSHARE)) {
 		if (!huge_pte_write(entry)) {
-			ret = hugetlb_wp(mm, vma, address, ptep, flags,
+			BUG_ON(hugetlb_pte_size(&hpte) != huge_page_size(h));
+			ret = hugetlb_wp(mm, vma, address, hpte.ptep, flags,
 					 pagecache_page, ptl);
 			goto out_put_page;
 		} else if (likely(flags & FAULT_FLAG_WRITE)) {
@@ -6206,9 +6243,9 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 		}
 	}
 	entry = pte_mkyoung(entry);
-	if (huge_ptep_set_access_flags(vma, haddr, ptep, entry,
+	if (huge_ptep_set_access_flags(vma, haddr_hgm, hpte.ptep, entry,
 						flags & FAULT_FLAG_WRITE))
-		update_mmu_cache(vma, haddr, ptep);
+		update_mmu_cache(vma, haddr_hgm, hpte.ptep);
 out_put_page:
 	if (page != pagecache_page)
 		unlock_page(page);
@@ -7598,7 +7635,8 @@ pte_t *huge_pte_alloc(struct mm_struct *mm, struct vm_area_struct *vma,
 				pte = (pte_t *)pmd_alloc(mm, pud, addr);
 		}
 	}
-	BUG_ON(pte && pte_present(*pte) && !pte_huge(*pte));
+	BUG_ON(pte && pte_present(*pte) && !pte_huge(*pte) &&
+			!hugetlb_hgm_enabled(vma));
 
 	return pte;
 }
-- 
2.38.0.135.g90850a2211-goog

