Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C69D70B46C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 07:15:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231863AbjEVFPU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 01:15:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231795AbjEVFPL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 01:15:11 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74835A8
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 22:15:10 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-561e919d355so60422787b3.0
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 22:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684732509; x=1687324509;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wdvmzniCtM+nQioqQdrwu6IzqdoeozaKC+WtG0d7jzc=;
        b=cRcUhaoiSgJ38o5WfT/WZeLX6uP++hPYcx9RZxFfGqfMkCU/m1hwojIEJua5ROp1t2
         3gbVLqFCMhxh733PpSF/0qZ8YjtL+7/P2FqSYSUAY16Ac5W48ksKrjIJgFQ08/pbPPf3
         q4tD4wBFecp/AobnrAUouJg1D3xu+hq/x/0yYcV3B7KprXoBoJD5VvXqNme3XhkF8MUs
         ptKdL72dy1i0NG2qsZVUCDca3Hwe/qFNH0+a+76pWfu+QubvXC6ErHyq6G5+PWt8MPaI
         67e8Krgsis/Lu/L/JhEyvnDKGzJIK/fkyJS7kC+QKlqSYLfoaAZoCGiKnWGOJLttwSnL
         hGFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684732509; x=1687324509;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wdvmzniCtM+nQioqQdrwu6IzqdoeozaKC+WtG0d7jzc=;
        b=CDnLzdgX0U5mNQ/db3kVMrjZwaMSJGbaRul28Dk/GarbTdceoi8dmTNg2Ri8jRY8Us
         NkDifg5KLuDrcIJux1Epc7UBDqc9c6cxnmcv6FDR2gR8q8Bq1tPitv67awmwyLDOqNbE
         k5VD8pbkEFy4ctBztmRr4RYzqNEGtmL28E6oC5ChgdOJ5bT9A3l+uv6Qn0VwFH5QMlge
         WuoJ+SW/BhRqLdHnUV8CICHlZbrs/Lhk1hGIwQLBGb+kiOrv97QxLvPV1H3w+GU5Gk+R
         DV0lS6HwZLVjPB7oNcPL2DHv99G+C5G5bApi+VVZweDXOHMXPhWU5VM0Wa/t5X1HaNuX
         7aHA==
X-Gm-Message-State: AC+VfDztB79F94uZKbRWVcV7+I2yWkBkDz/U+G60sPOlB4fB7aCjRJoF
        XBaVvoySKAKzmtc0dH2YUFg2uQ==
X-Google-Smtp-Source: ACHHUZ4FV9kV2YREHnhwIbwygT+rPx4Et9mG+j5eesRA86qgE8Xs1bA3kk0cV5xsWSqbz756kifYvg==
X-Received: by 2002:a0d:e807:0:b0:55a:4ff4:f97d with SMTP id r7-20020a0de807000000b0055a4ff4f97dmr10153523ywe.48.1684732509567;
        Sun, 21 May 2023 22:15:09 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id z73-20020a0dd74c000000b00559d9989490sm1828589ywd.41.2023.05.21.22.15.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 May 2023 22:15:09 -0700 (PDT)
Date:   Sun, 21 May 2023 22:15:06 -0700 (PDT)
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
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 20/31] mm/madvise: clean up pte_offset_map_lock() scans
In-Reply-To: <68a97fbe-5c1e-7ac6-72c-7b9c6290b370@google.com>
Message-ID: <dceac563-49e-fa34-4463-6183224bdca6@google.com>
References: <68a97fbe-5c1e-7ac6-72c-7b9c6290b370@google.com>
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

