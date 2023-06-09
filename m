Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7BA1728D3A
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 03:43:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237910AbjFIBmt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 21:42:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237849AbjFIBmr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 21:42:47 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F276F1BF0
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 18:42:45 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id 3f1490d57ef6-bb3a77abd7bso1301453276.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 18:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686274965; x=1688866965;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=p1k5/eahjbWsfa/uahTffpcykz1TgCrP6tjOVjA4Rhk=;
        b=kXMH2hIQkmF2USapaQhiZcpKUKkNYVjPRafKmj8hC8uAM6lWt8Cg7WyWV3i5oVqEWA
         bi93PCMA7PjdAzeBItn2fVWVBY+/9qgI6tMfBLEeEpjUthSCUQOS9R5oolpPexMofMwP
         pSgpjbezGBNl2+s7mdLUqylcEDr0Rzwx/U2TjkwQG91WnUJpoHZuxPDmnmO/Yv7J8FdM
         cwm5pnD7LoAthDQwPzAWpV55QbduVNRTxBSVVH445+SgGv+mnH4NOD/8k4MMNgeNCGj5
         /35hYwKb/TBzCQeOI3M6UpGu01ZJaZLpaHwXWmcS91MANZ+pzrD8lrdrhALbZ0SuH8aW
         G/vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686274965; x=1688866965;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p1k5/eahjbWsfa/uahTffpcykz1TgCrP6tjOVjA4Rhk=;
        b=HY5JXU6BuAeEX5zvLmfXktHcqZG8hsUicq4rViqofVF1QwOnXZlI5MXIQb/aSBQZf9
         dNjDBhamY7GllGywm+08Ew6EoCqFFfvvRqtS57D700mO7msq2DvZpp6cONBv5SxlbhAw
         svFhUBuEeZ/oebYhq/OUDegswsSZaRw3BU3pBDvBJq3TZIABRFN7Dpop241ZgrowVWNB
         BTciCSDRMhOvaRGssxa9qoO/w4pWYAR/wG4Qn199ZCavQ0Eeta03Fy+qfI6pXkcPXlyK
         Avzm4rtzR3OH3GrHOeMSGOSabJO9mtPDnkTOWCVzigFjEz/YXtj6MWaTCabVnC2gK+nZ
         bfqA==
X-Gm-Message-State: AC+VfDyKf67mjAUiAIv5ueWRYLkFZdE1+h2oCIb6Fl3ZTmmtTskBducO
        ihx4EpqTCV6LZseGIYlpVrIozg==
X-Google-Smtp-Source: ACHHUZ5fn3kW9FeGHNpW1xzpcB4LGHphf3k1hTSF+y3EK3Em0GkiW50KAIuHoFANUJ/kQPH4MzH72g==
X-Received: by 2002:a25:ab53:0:b0:ba8:972d:e380 with SMTP id u77-20020a25ab53000000b00ba8972de380mr1240110ybi.22.1686274964991;
        Thu, 08 Jun 2023 18:42:44 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id e188-20020a251ec5000000b00baca49c80dcsm615573ybe.28.2023.06.08.18.42.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 18:42:43 -0700 (PDT)
Date:   Thu, 8 Jun 2023 18:42:40 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Yang Shi <shy828301@gmail.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Peter Xu <peterx@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Alistair Popple <apopple@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Steven Price <steven.price@arm.com>,
        SeongJae Park <sj@kernel.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Huang Ying <ying.huang@intel.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Zack Rusin <zackr@vmware.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Minchan Kim <minchan@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Song Liu <song@kernel.org>,
        Thomas Hellstrom <thomas.hellstrom@linux.intel.com>,
        Ryan Roberts <ryan.roberts@arm.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH v2 27/32] mm/khugepaged: allow pte_offset_map[_lock]() to
 fail
In-Reply-To: <c1c9a74a-bc5b-15ea-e5d2-8ec34bc921d@google.com>
Message-ID: <6513e85-d798-34ec-3762-7c24ffb9329@google.com>
References: <c1c9a74a-bc5b-15ea-e5d2-8ec34bc921d@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__collapse_huge_page_swapin(): don't drop the map after every pte, it
only has to be dropped by do_swap_page(); give up if pte_offset_map()
fails; trace_mm_collapse_huge_page_swapin() at the end, with result;
fix comment on returned result; fix vmf.pgoff, though it's not used.

collapse_huge_page(): use pte_offset_map_lock() on the _pmd returned
from clearing; allow failure, but it should be impossible there.
hpage_collapse_scan_pmd() and collapse_pte_mapped_thp() allow for
pte_offset_map_lock() failure.

Signed-off-by: Hugh Dickins <hughd@google.com>
Reviewed-by: Yang Shi <shy828301@gmail.com>
---
 mm/khugepaged.c | 72 +++++++++++++++++++++++++++++++++----------------
 1 file changed, 49 insertions(+), 23 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 732f9ac393fc..49cfa7cdfe93 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -993,9 +993,8 @@ static int check_pmd_still_valid(struct mm_struct *mm,
  * Only done if hpage_collapse_scan_pmd believes it is worthwhile.
  *
  * Called and returns without pte mapped or spinlocks held.
- * Note that if false is returned, mmap_lock will be released.
+ * Returns result: if not SCAN_SUCCEED, mmap_lock has been released.
  */
-
 static int __collapse_huge_page_swapin(struct mm_struct *mm,
 				       struct vm_area_struct *vma,
 				       unsigned long haddr, pmd_t *pmd,
@@ -1004,23 +1003,35 @@ static int __collapse_huge_page_swapin(struct mm_struct *mm,
 	int swapped_in = 0;
 	vm_fault_t ret = 0;
 	unsigned long address, end = haddr + (HPAGE_PMD_NR * PAGE_SIZE);
+	int result;
+	pte_t *pte = NULL;
 
 	for (address = haddr; address < end; address += PAGE_SIZE) {
 		struct vm_fault vmf = {
 			.vma = vma,
 			.address = address,
-			.pgoff = linear_page_index(vma, haddr),
+			.pgoff = linear_page_index(vma, address),
 			.flags = FAULT_FLAG_ALLOW_RETRY,
 			.pmd = pmd,
 		};
 
-		vmf.pte = pte_offset_map(pmd, address);
-		vmf.orig_pte = *vmf.pte;
-		if (!is_swap_pte(vmf.orig_pte)) {
-			pte_unmap(vmf.pte);
-			continue;
+		if (!pte++) {
+			pte = pte_offset_map(pmd, address);
+			if (!pte) {
+				mmap_read_unlock(mm);
+				result = SCAN_PMD_NULL;
+				goto out;
+			}
 		}
+
+		vmf.orig_pte = *pte;
+		if (!is_swap_pte(vmf.orig_pte))
+			continue;
+
+		vmf.pte = pte;
 		ret = do_swap_page(&vmf);
+		/* Which unmaps pte (after perhaps re-checking the entry) */
+		pte = NULL;
 
 		/*
 		 * do_swap_page returns VM_FAULT_RETRY with released mmap_lock.
@@ -1029,24 +1040,29 @@ static int __collapse_huge_page_swapin(struct mm_struct *mm,
 		 * resulting in later failure.
 		 */
 		if (ret & VM_FAULT_RETRY) {
-			trace_mm_collapse_huge_page_swapin(mm, swapped_in, referenced, 0);
 			/* Likely, but not guaranteed, that page lock failed */
-			return SCAN_PAGE_LOCK;
+			result = SCAN_PAGE_LOCK;
+			goto out;
 		}
 		if (ret & VM_FAULT_ERROR) {
 			mmap_read_unlock(mm);
-			trace_mm_collapse_huge_page_swapin(mm, swapped_in, referenced, 0);
-			return SCAN_FAIL;
+			result = SCAN_FAIL;
+			goto out;
 		}
 		swapped_in++;
 	}
 
+	if (pte)
+		pte_unmap(pte);
+
 	/* Drain LRU add pagevec to remove extra pin on the swapped in pages */
 	if (swapped_in)
 		lru_add_drain();
 
-	trace_mm_collapse_huge_page_swapin(mm, swapped_in, referenced, 1);
-	return SCAN_SUCCEED;
+	result = SCAN_SUCCEED;
+out:
+	trace_mm_collapse_huge_page_swapin(mm, swapped_in, referenced, result);
+	return result;
 }
 
 static int alloc_charge_hpage(struct page **hpage, struct mm_struct *mm,
@@ -1146,9 +1162,6 @@ static int collapse_huge_page(struct mm_struct *mm, unsigned long address,
 				address + HPAGE_PMD_SIZE);
 	mmu_notifier_invalidate_range_start(&range);
 
-	pte = pte_offset_map(pmd, address);
-	pte_ptl = pte_lockptr(mm, pmd);
-
 	pmd_ptl = pmd_lock(mm, pmd); /* probably unnecessary */
 	/*
 	 * This removes any huge TLB entry from the CPU so we won't allow
@@ -1163,13 +1176,18 @@ static int collapse_huge_page(struct mm_struct *mm, unsigned long address,
 	mmu_notifier_invalidate_range_end(&range);
 	tlb_remove_table_sync_one();
 
-	spin_lock(pte_ptl);
-	result =  __collapse_huge_page_isolate(vma, address, pte, cc,
-					       &compound_pagelist);
-	spin_unlock(pte_ptl);
+	pte = pte_offset_map_lock(mm, &_pmd, address, &pte_ptl);
+	if (pte) {
+		result = __collapse_huge_page_isolate(vma, address, pte, cc,
+						      &compound_pagelist);
+		spin_unlock(pte_ptl);
+	} else {
+		result = SCAN_PMD_NULL;
+	}
 
 	if (unlikely(result != SCAN_SUCCEED)) {
-		pte_unmap(pte);
+		if (pte)
+			pte_unmap(pte);
 		spin_lock(pmd_ptl);
 		BUG_ON(!pmd_none(*pmd));
 		/*
@@ -1253,6 +1271,11 @@ static int hpage_collapse_scan_pmd(struct mm_struct *mm,
 	memset(cc->node_load, 0, sizeof(cc->node_load));
 	nodes_clear(cc->alloc_nmask);
 	pte = pte_offset_map_lock(mm, pmd, address, &ptl);
+	if (!pte) {
+		result = SCAN_PMD_NULL;
+		goto out;
+	}
+
 	for (_address = address, _pte = pte; _pte < pte + HPAGE_PMD_NR;
 	     _pte++, _address += PAGE_SIZE) {
 		pte_t pteval = *_pte;
@@ -1622,8 +1645,10 @@ int collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr,
 	 * lockless_pages_from_mm() and the hardware page walker can access page
 	 * tables while all the high-level locks are held in write mode.
 	 */
-	start_pte = pte_offset_map_lock(mm, pmd, haddr, &ptl);
 	result = SCAN_FAIL;
+	start_pte = pte_offset_map_lock(mm, pmd, haddr, &ptl);
+	if (!start_pte)
+		goto drop_immap;
 
 	/* step 1: check all mapped PTEs are to the right huge page */
 	for (i = 0, addr = haddr, pte = start_pte;
@@ -1697,6 +1722,7 @@ int collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr,
 
 abort:
 	pte_unmap_unlock(start_pte, ptl);
+drop_immap:
 	i_mmap_unlock_write(vma->vm_file->f_mapping);
 	goto drop_hpage;
 }
-- 
2.35.3

