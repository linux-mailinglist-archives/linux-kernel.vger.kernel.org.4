Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99BE0607C71
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 18:38:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231268AbiJUQip (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 12:38:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231136AbiJUQiI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 12:38:08 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF6DA2852A1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 09:37:34 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-36ab1ae386bso3385327b3.16
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 09:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=X13wx2njoRAvoh4E0IMJVfrDZ5s4WLay4B3IFLQbLEY=;
        b=Sa9tlTSvMy27PkqCy85zUMB7NXscw1SeftIzcgjHIdZeuKi35UjClC0+e61EdsQTSl
         NMLCrfPUooY7jzsHIfTKQHEnm6IUVAUYCi3yYETPsKUeFPWIFi4VRk+XusoX6DEnlweI
         lFO+cIJ76Sk+AjPePBoVFpvlnw2U1gr7dRgFq3DrzIDAhWlVL+NEO/0ro9fFwSCY/mjx
         7ZtzekH0PrfJEZhy6u5zJ6NFUTk/+Y3IJrfcH7Gs6tO7dALKjpojag4k7ICH4rINP9Vg
         6A/PZUKktjf3jROcDajl8cuELh+tfbsO8Bbf5at999k7ONKuVzu9yjryfOrezKepLD6u
         XbIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X13wx2njoRAvoh4E0IMJVfrDZ5s4WLay4B3IFLQbLEY=;
        b=JUci/z6Xz3Jkw0tNmAu0sk9mykq59RyahbUfMgpkK/OeDsiBYVdbY0tQlWMJ2j2OZa
         Tl7Qv2py/g3ZvThLqGhO84ormcrvnFPdrTQ2wvNd0I46h5zqYj2gTOTQtMJa6GqbADDC
         jjwxtWFuDoCZyNQDM1WFmSSnXPRvx5RI+2wJLWe55CcwQrRfWNWtsTK4cePEO0y617us
         43VpEu590M9otyqvGgd8ROZV3mQ1sCO+LTjAHMumogT40zWJ6LIwX4fNnFXLpP55BJ6f
         QZBOgEvGxBM1DSIHB5Xy+xhq5keiaGZ6xpxX8OW9MZK11Bg1BSGTW2DTdK2Jxo5ne8zl
         6APA==
X-Gm-Message-State: ACrzQf3ZexEpK9aENtV4GiHZomThr2efAwfYwcNSINMB+rQ/SDXdEeth
        NsX8Cylfc43G8pcVEM1D4zmblPVprd6TMUBw
X-Google-Smtp-Source: AMsMyM5FTyzfLTC0XnU5k1S4/Yvtcod5ACm9RndBlBmN969+ez/t051FnxhOla7v7Xs6v4smN/AXXJR7XNVGPYEB
X-Received: from jthoughton.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:2a4f])
 (user=jthoughton job=sendgmr) by 2002:a25:87:0:b0:6c3:b703:ef69 with SMTP id
 129-20020a250087000000b006c3b703ef69mr17587149yba.126.1666370253374; Fri, 21
 Oct 2022 09:37:33 -0700 (PDT)
Date:   Fri, 21 Oct 2022 16:36:34 +0000
In-Reply-To: <20221021163703.3218176-1-jthoughton@google.com>
Mime-Version: 1.0
References: <20221021163703.3218176-1-jthoughton@google.com>
X-Mailer: git-send-email 2.38.0.135.g90850a2211-goog
Message-ID: <20221021163703.3218176-19-jthoughton@google.com>
Subject: [RFC PATCH v2 18/47] hugetlb: enlighten follow_hugetlb_page to
 support HGM
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

This enables high-granularity mapping support in GUP.

One important change here is that, before, we never needed to grab the
VMA lock, but now, to prevent someone from collapsing the page tables
out from under us, we grab it for reading when doing high-granularity PT
walks.

In case it is confusing, pfn_offset is the offset (in PAGE_SIZE units)
that vaddr points to within the subpage that hpte points to.

Signed-off-by: James Houghton <jthoughton@google.com>
---
 mm/hugetlb.c | 76 ++++++++++++++++++++++++++++++++++++----------------
 1 file changed, 53 insertions(+), 23 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 2d096cef53cd..d76ab32fb6d3 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -6382,11 +6382,9 @@ static void record_subpages_vmas(struct page *page, struct vm_area_struct *vma,
 	}
 }
 
-static inline bool __follow_hugetlb_must_fault(unsigned int flags, pte_t *pte,
+static inline bool __follow_hugetlb_must_fault(unsigned int flags, pte_t pteval,
 					       bool *unshare)
 {
-	pte_t pteval = huge_ptep_get(pte);
-
 	*unshare = false;
 	if (is_swap_pte(pteval))
 		return true;
@@ -6478,12 +6476,20 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
 	struct hstate *h = hstate_vma(vma);
 	int err = -EFAULT, refs;
 
+	/*
+	 * Grab the VMA lock for reading now so no one can collapse the page
+	 * table from under us.
+	 */
+	hugetlb_vma_lock_read(vma);
+
 	while (vaddr < vma->vm_end && remainder) {
-		pte_t *pte;
+		pte_t *ptep, pte;
 		spinlock_t *ptl = NULL;
 		bool unshare = false;
 		int absent;
-		struct page *page;
+		unsigned long pages_per_hpte;
+		struct page *page, *subpage;
+		struct hugetlb_pte hpte;
 
 		/*
 		 * If we have a pending SIGKILL, don't keep faulting pages and
@@ -6499,13 +6505,22 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
 		 * each hugepage.  We have to make sure we get the
 		 * first, for the page indexing below to work.
 		 *
-		 * Note that page table lock is not held when pte is null.
+		 * Note that page table lock is not held when ptep is null.
 		 */
-		pte = huge_pte_offset(mm, vaddr & huge_page_mask(h),
-				      huge_page_size(h));
-		if (pte)
-			ptl = huge_pte_lock(h, mm, pte);
-		absent = !pte || huge_pte_none(huge_ptep_get(pte));
+		ptep = huge_pte_offset(mm, vaddr & huge_page_mask(h),
+				       huge_page_size(h));
+		if (ptep) {
+			hugetlb_pte_populate(&hpte, ptep, huge_page_shift(h),
+					hpage_size_to_level(huge_page_size(h)));
+			hugetlb_hgm_walk(mm, vma, &hpte, vaddr,
+					PAGE_SIZE,
+					/*stop_at_none=*/true);
+			ptl = hugetlb_pte_lock(mm, &hpte);
+			ptep = hpte.ptep;
+			pte = huge_ptep_get(ptep);
+		}
+
+		absent = !ptep || huge_pte_none(pte);
 
 		/*
 		 * When coredumping, it suits get_dump_page if we just return
@@ -6516,12 +6531,19 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
 		 */
 		if (absent && (flags & FOLL_DUMP) &&
 		    !hugetlbfs_pagecache_present(h, vma, vaddr)) {
-			if (pte)
+			if (ptep)
 				spin_unlock(ptl);
 			remainder = 0;
 			break;
 		}
 
+		if (!absent && pte_present(pte) &&
+				!hugetlb_pte_present_leaf(&hpte, pte)) {
+			/* We raced with someone splitting the PTE, so retry. */
+			spin_unlock(ptl);
+			continue;
+		}
+
 		/*
 		 * We need call hugetlb_fault for both hugepages under migration
 		 * (in which case hugetlb_fault waits for the migration,) and
@@ -6537,7 +6559,10 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
 			vm_fault_t ret;
 			unsigned int fault_flags = 0;
 
-			if (pte)
+			/* Drop the lock before entering hugetlb_fault. */
+			hugetlb_vma_unlock_read(vma);
+
+			if (ptep)
 				spin_unlock(ptl);
 			if (flags & FOLL_WRITE)
 				fault_flags |= FAULT_FLAG_WRITE;
@@ -6560,7 +6585,7 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
 			if (ret & VM_FAULT_ERROR) {
 				err = vm_fault_to_errno(ret, flags);
 				remainder = 0;
-				break;
+				goto out;
 			}
 			if (ret & VM_FAULT_RETRY) {
 				if (locked &&
@@ -6578,11 +6603,14 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
 				 */
 				return i;
 			}
+			hugetlb_vma_lock_read(vma);
 			continue;
 		}
 
-		pfn_offset = (vaddr & ~huge_page_mask(h)) >> PAGE_SHIFT;
-		page = pte_page(huge_ptep_get(pte));
+		pfn_offset = (vaddr & ~hugetlb_pte_mask(&hpte)) >> PAGE_SHIFT;
+		subpage = pte_page(pte);
+		pages_per_hpte = hugetlb_pte_size(&hpte) / PAGE_SIZE;
+		page = compound_head(subpage);
 
 		VM_BUG_ON_PAGE((flags & FOLL_PIN) && PageAnon(page) &&
 			       !PageAnonExclusive(page), page);
@@ -6592,21 +6620,21 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
 		 * and skip the same_page loop below.
 		 */
 		if (!pages && !vmas && !pfn_offset &&
-		    (vaddr + huge_page_size(h) < vma->vm_end) &&
-		    (remainder >= pages_per_huge_page(h))) {
-			vaddr += huge_page_size(h);
-			remainder -= pages_per_huge_page(h);
-			i += pages_per_huge_page(h);
+		    (vaddr + pages_per_hpte < vma->vm_end) &&
+		    (remainder >= pages_per_hpte)) {
+			vaddr += pages_per_hpte;
+			remainder -= pages_per_hpte;
+			i += pages_per_hpte;
 			spin_unlock(ptl);
 			continue;
 		}
 
 		/* vaddr may not be aligned to PAGE_SIZE */
-		refs = min3(pages_per_huge_page(h) - pfn_offset, remainder,
+		refs = min3(pages_per_hpte - pfn_offset, remainder,
 		    (vma->vm_end - ALIGN_DOWN(vaddr, PAGE_SIZE)) >> PAGE_SHIFT);
 
 		if (pages || vmas)
-			record_subpages_vmas(nth_page(page, pfn_offset),
+			record_subpages_vmas(nth_page(subpage, pfn_offset),
 					     vma, refs,
 					     likely(pages) ? pages + i : NULL,
 					     vmas ? vmas + i : NULL);
@@ -6637,6 +6665,8 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
 
 		spin_unlock(ptl);
 	}
+	hugetlb_vma_unlock_read(vma);
+out:
 	*nr_pages = remainder;
 	/*
 	 * setting position is actually required only if remainder is
-- 
2.38.0.135.g90850a2211-goog

