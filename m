Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B336728D1F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 03:34:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237787AbjFIBeL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 21:34:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbjFIBeK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 21:34:10 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81E4E30E6
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 18:34:08 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-565e6beb7aaso11623887b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 18:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686274447; x=1688866447;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wdvmzniCtM+nQioqQdrwu6IzqdoeozaKC+WtG0d7jzc=;
        b=Oi7q9zQXAnHzVKo/FhCPs8tzz9nacAj7GeJ1aGGBUrWEYASbA/COShPsGhE7TSY1ih
         bxVmRvKdrmFR5jXzZRTgemTvq61YU0XHRU70b1d3QdbaFwgY+kX5E2pxmuHyonISfka/
         2mIjcxl1BRTJLCdi9tDPNj4z8xlbHAAh2ERkE6DkidseXIGdbxnscT3F7ARVo5KkhPVF
         m5RsG7gDmqBonOEOuZYs+SmyuTOVvsJthOrxfrS4j3QsaT2MI33gyJZxrSrSJZSC8FPD
         R5ZnuYh4R1BXHnQy+G2iJxg5x1Uo6TM759fPwJnBzBOJAwDjI9gtM3K7QZ52HU2U68va
         CGEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686274447; x=1688866447;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wdvmzniCtM+nQioqQdrwu6IzqdoeozaKC+WtG0d7jzc=;
        b=V3IOVHubJcLZ0Z3D4GWvl5wrMmduS5nQ+DTdipApQkxmXEaIrmnPnydCRqKDX7zpUw
         RSDQrLtwxplWpGK2JjZApWiYWrReln4/Dt973227ZtvcpxlHGc0XycH8ovYtxviERqIO
         nrb863IC2XIP0OYZd1dUlPyMDdfIdxSagmkYZwYxAbJu7g1x8TOcEcVU6bJPEWUYW2r6
         W+ArFyHbQkN4Xhv3wtNsJCDshOhbzDIBVK39gn9st3aTr+J7M5dRCeNSdaPaZxNOGiwz
         7nXS9H9qyCjGz/ci6AsEIZQ/lHMP4ZEoQhpD48x12P/V0Yay4KkkefJa75kLu6mdWlGb
         XFQw==
X-Gm-Message-State: AC+VfDwbT7qOAg948G6GOeqMxw1zGau3dtbsA/h7qAT5UxOxKPY9Kgz+
        aT8LNXFbCIGI8odlNP7hxDBqCw==
X-Google-Smtp-Source: ACHHUZ5Q/YHvHVewBNkmQMz1HqeMOeXDnHdCMp674SssIxi8mNPsiGfn7zCsWmM3qzcif+cYyekxpQ==
X-Received: by 2002:a0d:cb50:0:b0:54d:ea34:c31 with SMTP id n77-20020a0dcb50000000b0054dea340c31mr1301109ywd.29.1686274447361;
        Thu, 08 Jun 2023 18:34:07 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id q67-20020a818046000000b0054f83731ad2sm314580ywf.0.2023.06.08.18.34.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 18:34:06 -0700 (PDT)
Date:   Thu, 8 Jun 2023 18:34:03 -0700 (PDT)
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
Subject: [PATCH v2 20/32] mm/madvise: clean up pte_offset_map_lock() scans
In-Reply-To: <c1c9a74a-bc5b-15ea-e5d2-8ec34bc921d@google.com>
Message-ID: <cc4d9a88-9da6-362-50d9-6735c2b125c6@google.com>
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

Came here to make madvise's several pte_offset_map_lock() scans advance
to next extent on failure, and remove superfluous pmd_trans_unstable()
and pmd_none_or_trans_huge_or_clear_bad() calls.  But also did some
nearby cleanup.

swapin_walk_pmd_entry(): don't name an address "index"; don't drop the
lock after every pte, only when calling out to read_swap_cache_async().

madvise_cold_or_pageout_pte_range() and madvise_free_pte_range():
prefer "start_pte" for pointer, orig_pte usually denotes a saved pte
value; leave lazy MMU mode before unlocking; merge the success and
failure paths after split_folio().

Signed-off-by: Hugh Dickins <hughd@google.com>
---
 mm/madvise.c | 122 ++++++++++++++++++++++++++++-----------------------
 1 file changed, 68 insertions(+), 54 deletions(-)

diff --git a/mm/madvise.c b/mm/madvise.c
index b5ffbaf616f5..0af64c4a8f82 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -188,37 +188,43 @@ static int madvise_update_vma(struct vm_area_struct *vma,
 
 #ifdef CONFIG_SWAP
 static int swapin_walk_pmd_entry(pmd_t *pmd, unsigned long start,
-	unsigned long end, struct mm_walk *walk)
+		unsigned long end, struct mm_walk *walk)
 {
 	struct vm_area_struct *vma = walk->private;
-	unsigned long index;
 	struct swap_iocb *splug = NULL;
+	pte_t *ptep = NULL;
+	spinlock_t *ptl;
+	unsigned long addr;
 
-	if (pmd_none_or_trans_huge_or_clear_bad(pmd))
-		return 0;
-
-	for (index = start; index != end; index += PAGE_SIZE) {
+	for (addr = start; addr < end; addr += PAGE_SIZE) {
 		pte_t pte;
 		swp_entry_t entry;
 		struct page *page;
-		spinlock_t *ptl;
-		pte_t *ptep;
 
-		ptep = pte_offset_map_lock(vma->vm_mm, pmd, index, &ptl);
+		if (!ptep++) {
+			ptep = pte_offset_map_lock(vma->vm_mm, pmd, addr, &ptl);
+			if (!ptep)
+				break;
+		}
+
 		pte = *ptep;
-		pte_unmap_unlock(ptep, ptl);
-
 		if (!is_swap_pte(pte))
 			continue;
 		entry = pte_to_swp_entry(pte);
 		if (unlikely(non_swap_entry(entry)))
 			continue;
 
+		pte_unmap_unlock(ptep, ptl);
+		ptep = NULL;
+
 		page = read_swap_cache_async(entry, GFP_HIGHUSER_MOVABLE,
-					     vma, index, false, &splug);
+					     vma, addr, false, &splug);
 		if (page)
 			put_page(page);
 	}
+
+	if (ptep)
+		pte_unmap_unlock(ptep, ptl);
 	swap_read_unplug(splug);
 	cond_resched();
 
@@ -340,7 +346,7 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
 	bool pageout = private->pageout;
 	struct mm_struct *mm = tlb->mm;
 	struct vm_area_struct *vma = walk->vma;
-	pte_t *orig_pte, *pte, ptent;
+	pte_t *start_pte, *pte, ptent;
 	spinlock_t *ptl;
 	struct folio *folio = NULL;
 	LIST_HEAD(folio_list);
@@ -422,11 +428,11 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
 	}
 
 regular_folio:
-	if (pmd_trans_unstable(pmd))
-		return 0;
 #endif
 	tlb_change_page_size(tlb, PAGE_SIZE);
-	orig_pte = pte = pte_offset_map_lock(vma->vm_mm, pmd, addr, &ptl);
+	start_pte = pte = pte_offset_map_lock(vma->vm_mm, pmd, addr, &ptl);
+	if (!start_pte)
+		return 0;
 	flush_tlb_batched_pending(mm);
 	arch_enter_lazy_mmu_mode();
 	for (; addr < end; pte++, addr += PAGE_SIZE) {
@@ -447,25 +453,28 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
 		 * are sure it's worth. Split it if we are only owner.
 		 */
 		if (folio_test_large(folio)) {
+			int err;
+
 			if (folio_mapcount(folio) != 1)
 				break;
 			if (pageout_anon_only_filter && !folio_test_anon(folio))
 				break;
+			if (!folio_trylock(folio))
+				break;
 			folio_get(folio);
-			if (!folio_trylock(folio)) {
-				folio_put(folio);
-				break;
-			}
-			pte_unmap_unlock(orig_pte, ptl);
-			if (split_folio(folio)) {
-				folio_unlock(folio);
-				folio_put(folio);
-				orig_pte = pte_offset_map_lock(mm, pmd, addr, &ptl);
-				break;
-			}
+			arch_leave_lazy_mmu_mode();
+			pte_unmap_unlock(start_pte, ptl);
+			start_pte = NULL;
+			err = split_folio(folio);
 			folio_unlock(folio);
 			folio_put(folio);
-			orig_pte = pte = pte_offset_map_lock(mm, pmd, addr, &ptl);
+			if (err)
+				break;
+			start_pte = pte =
+				pte_offset_map_lock(mm, pmd, addr, &ptl);
+			if (!start_pte)
+				break;
+			arch_enter_lazy_mmu_mode();
 			pte--;
 			addr -= PAGE_SIZE;
 			continue;
@@ -510,8 +519,10 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
 			folio_deactivate(folio);
 	}
 
-	arch_leave_lazy_mmu_mode();
-	pte_unmap_unlock(orig_pte, ptl);
+	if (start_pte) {
+		arch_leave_lazy_mmu_mode();
+		pte_unmap_unlock(start_pte, ptl);
+	}
 	if (pageout)
 		reclaim_pages(&folio_list);
 	cond_resched();
@@ -612,7 +623,7 @@ static int madvise_free_pte_range(pmd_t *pmd, unsigned long addr,
 	struct mm_struct *mm = tlb->mm;
 	struct vm_area_struct *vma = walk->vma;
 	spinlock_t *ptl;
-	pte_t *orig_pte, *pte, ptent;
+	pte_t *start_pte, *pte, ptent;
 	struct folio *folio;
 	int nr_swap = 0;
 	unsigned long next;
@@ -620,13 +631,12 @@ static int madvise_free_pte_range(pmd_t *pmd, unsigned long addr,
 	next = pmd_addr_end(addr, end);
 	if (pmd_trans_huge(*pmd))
 		if (madvise_free_huge_pmd(tlb, vma, pmd, addr, next))
-			goto next;
-
-	if (pmd_trans_unstable(pmd))
-		return 0;
+			return 0;
 
 	tlb_change_page_size(tlb, PAGE_SIZE);
-	orig_pte = pte = pte_offset_map_lock(mm, pmd, addr, &ptl);
+	start_pte = pte = pte_offset_map_lock(mm, pmd, addr, &ptl);
+	if (!start_pte)
+		return 0;
 	flush_tlb_batched_pending(mm);
 	arch_enter_lazy_mmu_mode();
 	for (; addr != end; pte++, addr += PAGE_SIZE) {
@@ -664,23 +674,26 @@ static int madvise_free_pte_range(pmd_t *pmd, unsigned long addr,
 		 * deactivate all pages.
 		 */
 		if (folio_test_large(folio)) {
+			int err;
+
 			if (folio_mapcount(folio) != 1)
-				goto out;
+				break;
+			if (!folio_trylock(folio))
+				break;
 			folio_get(folio);
-			if (!folio_trylock(folio)) {
-				folio_put(folio);
-				goto out;
-			}
-			pte_unmap_unlock(orig_pte, ptl);
-			if (split_folio(folio)) {
-				folio_unlock(folio);
-				folio_put(folio);
-				orig_pte = pte_offset_map_lock(mm, pmd, addr, &ptl);
-				goto out;
-			}
+			arch_leave_lazy_mmu_mode();
+			pte_unmap_unlock(start_pte, ptl);
+			start_pte = NULL;
+			err = split_folio(folio);
 			folio_unlock(folio);
 			folio_put(folio);
-			orig_pte = pte = pte_offset_map_lock(mm, pmd, addr, &ptl);
+			if (err)
+				break;
+			start_pte = pte =
+				pte_offset_map_lock(mm, pmd, addr, &ptl);
+			if (!start_pte)
+				break;
+			arch_enter_lazy_mmu_mode();
 			pte--;
 			addr -= PAGE_SIZE;
 			continue;
@@ -725,17 +738,18 @@ static int madvise_free_pte_range(pmd_t *pmd, unsigned long addr,
 		}
 		folio_mark_lazyfree(folio);
 	}
-out:
+
 	if (nr_swap) {
 		if (current->mm == mm)
 			sync_mm_rss(mm);
-
 		add_mm_counter(mm, MM_SWAPENTS, nr_swap);
 	}
-	arch_leave_lazy_mmu_mode();
-	pte_unmap_unlock(orig_pte, ptl);
+	if (start_pte) {
+		arch_leave_lazy_mmu_mode();
+		pte_unmap_unlock(start_pte, ptl);
+	}
 	cond_resched();
-next:
+
 	return 0;
 }
 
-- 
2.35.3

