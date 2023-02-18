Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D5D269B6CD
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 01:31:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbjBRAaO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 19:30:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230144AbjBRA3l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 19:29:41 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E7526BDCD
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 16:29:04 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-53659b9818dso20129197b3.18
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 16:29:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Wqs0fsEFEjqd+rJsTObxpTCfifnDhyGaJkzr9TFCSvk=;
        b=cJVTi2N6kM66ucMEEndfS5PbMZx/snZYIaX4pqh8wHLpb03XCb5lJGQNTsMPX9uGLM
         3wrM65Jw9kjrzso9alDlQrPBuVrtt7sPBKbdMEoD3wjSNN9aVSq6XDimkW/z3s2yU53N
         01HcXY5734HriS3KEBsLiLM4XpS0m8aYkKnF+jbQkjlqFDqIpmrep+3g8RZmFM7dnjig
         IH2rbnvxfAr1zdpMGTaaiYQFb5fCvbDD9c/lVJg17L/SIZ0Al4fOA+YIO6cW7+D3MDjz
         3rGL2IRT+C4f2EXWISMVmkij1Ys+Tetb9JtllXr0s2awCerx9KT+6hSElNdAsCbda374
         SHaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wqs0fsEFEjqd+rJsTObxpTCfifnDhyGaJkzr9TFCSvk=;
        b=u+N8/bXbdR9yqAGXnvdn+etPMWwFbvIO+c6RibUsWoIO6rc7KfHpHfO/VU8WQWXDYp
         T57BC6dztBoWemt3GDklyJfGlwPLgQxOVwrHl+ZtE4t+l8/jNr2Xnuax3FUqK/ISCiUH
         r9lIamgfWo9KTu+yGAEF/ODPz+YklVcgOe+NBlM5H78svZRFB0JNBquATIYDc3U0fWS3
         8btNfVYkT3BnmpAoIrOemZCoKRlani+MqlPnScZ5GTwyfP9dsqv1X5BTTxNAnONh+cFo
         3Dg59GJrbru8z+LMhlrRQOYKhBz/lAuZxot9/bdfZVykQ/vfQKRuk4LU3RgQLrvnEry1
         PSng==
X-Gm-Message-State: AO0yUKV88JXzHZabA/waC93Bno8iTssEFT+a9W22nmqKpXOXjteUtIEM
        dQzwIHERoSqVkjjXKBa3P58pozXvlAieTbvs
X-Google-Smtp-Source: AK7set8Vb2mEtNk6xau6GwJBBjn11LS8z+AdmXnFLSNyWOrweHaxia9rgscf+J08KFziUFJlJkWb+B9Wav4nPE21
X-Received: from jthoughton.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:2a4f])
 (user=jthoughton job=sendgmr) by 2002:a5b:711:0:b0:97a:956d:6a4 with SMTP id
 g17-20020a5b0711000000b0097a956d06a4mr36513ybq.5.1676680143155; Fri, 17 Feb
 2023 16:29:03 -0800 (PST)
Date:   Sat, 18 Feb 2023 00:27:53 +0000
In-Reply-To: <20230218002819.1486479-1-jthoughton@google.com>
Mime-Version: 1.0
References: <20230218002819.1486479-1-jthoughton@google.com>
X-Mailer: git-send-email 2.39.2.637.g21b0678d19-goog
Message-ID: <20230218002819.1486479-21-jthoughton@google.com>
Subject: [PATCH v2 20/46] hugetlb: add HGM support to follow_hugetlb_page
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

Enable high-granularity mapping support in GUP.

In case it is confusing, pfn_offset is the offset (in PAGE_SIZE units)
that vaddr points to within the subpage that hpte points to.

Signed-off-by: James Houghton <jthoughton@google.com>

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 7321c6602d6f..c26b040f4fb5 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -6634,11 +6634,9 @@ static void record_subpages_vmas(struct page *page, struct vm_area_struct *vma,
 }
 
 static inline bool __follow_hugetlb_must_fault(struct vm_area_struct *vma,
-					       unsigned int flags, pte_t *pte,
+					       unsigned int flags, pte_t pteval,
 					       bool *unshare)
 {
-	pte_t pteval = huge_ptep_get(pte);
-
 	*unshare = false;
 	if (is_swap_pte(pteval))
 		return true;
@@ -6713,11 +6711,13 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
 	int err = -EFAULT, refs;
 
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
@@ -6734,13 +6734,19 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
 		 * each hugepage.  We have to make sure we get the
 		 * first, for the page indexing below to work.
 		 *
-		 * Note that page table lock is not held when pte is null.
+		 * hugetlb_full_walk will mask the address appropriately.
+		 *
+		 * Note that page table lock is not held when ptep is null.
 		 */
-		pte = hugetlb_walk(vma, vaddr & huge_page_mask(h),
-				   huge_page_size(h));
-		if (pte)
-			ptl = huge_pte_lock(h, mm, pte);
-		absent = !pte || huge_pte_none(huge_ptep_get(pte));
+		if (hugetlb_full_walk(&hpte, vma, vaddr)) {
+			ptep = NULL;
+			absent = true;
+		} else {
+			ptl = hugetlb_pte_lock(&hpte);
+			ptep = hpte.ptep;
+			pte = huge_ptep_get(ptep);
+			absent = huge_pte_none(pte);
+		}
 
 		/*
 		 * When coredumping, it suits get_dump_page if we just return
@@ -6751,13 +6757,21 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
 		 */
 		if (absent && (flags & FOLL_DUMP) &&
 		    !hugetlbfs_pagecache_present(h, vma, vaddr)) {
-			if (pte)
+			if (ptep)
 				spin_unlock(ptl);
 			hugetlb_vma_unlock_read(vma);
 			remainder = 0;
 			break;
 		}
 
+		if (!absent && pte_present(pte) &&
+				!hugetlb_pte_present_leaf(&hpte, pte)) {
+			/* We raced with someone splitting the PTE, so retry. */
+			spin_unlock(ptl);
+			hugetlb_vma_unlock_read(vma);
+			continue;
+		}
+
 		/*
 		 * We need call hugetlb_fault for both hugepages under migration
 		 * (in which case hugetlb_fault waits for the migration,) and
@@ -6773,7 +6787,7 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
 			vm_fault_t ret;
 			unsigned int fault_flags = 0;
 
-			if (pte)
+			if (ptep)
 				spin_unlock(ptl);
 			hugetlb_vma_unlock_read(vma);
 
@@ -6822,8 +6836,10 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
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
@@ -6833,22 +6849,22 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
 		 * and skip the same_page loop below.
 		 */
 		if (!pages && !vmas && !pfn_offset &&
-		    (vaddr + huge_page_size(h) < vma->vm_end) &&
-		    (remainder >= pages_per_huge_page(h))) {
-			vaddr += huge_page_size(h);
-			remainder -= pages_per_huge_page(h);
-			i += pages_per_huge_page(h);
+		    (vaddr + hugetlb_pte_size(&hpte) < vma->vm_end) &&
+		    (remainder >= pages_per_hpte)) {
+			vaddr += hugetlb_pte_size(&hpte);
+			remainder -= pages_per_hpte;
+			i += pages_per_hpte;
 			spin_unlock(ptl);
 			hugetlb_vma_unlock_read(vma);
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
-- 
2.39.2.637.g21b0678d19-goog

