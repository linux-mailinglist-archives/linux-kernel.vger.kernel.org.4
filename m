Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E1DE736579
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 09:57:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231752AbjFTH5n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 03:57:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231715AbjFTH5Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 03:57:16 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41C6FE72
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 00:56:37 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id af79cd13be357-762490831f6so278759085a.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 00:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687247796; x=1689839796;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6+vwC/lRMNRi87hMBE1YekLdovsofTWKPL6p1SpVoTA=;
        b=aVESce+35OzsmAlAStgyGN3RAj7WDCAE8sHC0KoMDM6cH2/moaTq02nEqNPwD3/T+W
         noO2Ww2L93Fcf5p9VnVnxgvjusPf47iNS1mjXHxFvgvoI/RPajs6xy2hlJm3pPwx/ukk
         EEVdSHMxTCdD+Z/QL780HcIsKFRRn53QQIJPB599L7CCSrk3CJVO4ksGsL2XLtesId9S
         XBJIAQuaqrldCBAWpVU1/KQoK1mGqrJ3H9wgg6dhtt5FIThtuxRlpvzAq0tV3zGFdrNA
         jHvRkgQ7WhWy8ZMMUEOCC7EiG5C12tuJVl2FBkFi/jQT8V3wZP59XIwC46nMyksOaHFh
         Ka8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687247796; x=1689839796;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6+vwC/lRMNRi87hMBE1YekLdovsofTWKPL6p1SpVoTA=;
        b=YLEjONs3cUd8hVQcncwWOneBErN4ptU6/ljMX9wgNqhj2rWFSghbEMfvRCG9I3v3l+
         I4BufDFpRE3dWbhomV1axbHsvm2zXI0uKepLhv0IganUr9YT+UfIsERbJxWoaE+45mg6
         /N2mVLRT0qZHnRLI0iZc/OiNn0YmmK77nkgaoL6HIsiWNyiacnV51192iRp11NYkKLSX
         wxhf+RKNpwARWJsvzFquj5PEQBRNA+ru9d4Xy5p7XDclFMDr+9IObp0NirdX7+ZNuVwg
         CKFD44zqkzNFyj4TeCBcT7EsiBHei47SVNfNqNHcCQ56YwPKXu94vT27ocpEZNNz+X9Z
         2OkA==
X-Gm-Message-State: AC+VfDyYmMnQEq7T5X+zJrZpSir0aFksTzZsjv9Xb6aFk96RFXnNpnsF
        EmQJ2GzzisKddPsPkMm37zCI4g==
X-Google-Smtp-Source: ACHHUZ7b5Od5F2ztLp7089p/6rSzydLtc+ipnNwtJnuDVoDpL+0rndgulPeJ/Tox+jZ/pysI1HkLKw==
X-Received: by 2002:a05:622a:1708:b0:3f0:ac80:1ed7 with SMTP id h8-20020a05622a170800b003f0ac801ed7mr15885756qtk.45.1687247796145;
        Tue, 20 Jun 2023 00:56:36 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id v25-20020a25fc19000000b00bab9a67a4cesm257974ybd.29.2023.06.20.00.56.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 00:56:35 -0700 (PDT)
Date:   Tue, 20 Jun 2023 00:56:31 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
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
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Jann Horn <jannh@google.com>,
        Vishal Moola <vishal.moola@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        linux-arm-kernel@lists.infradead.org, sparclinux@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH v2 10/12] mm/khugepaged: collapse_pte_mapped_thp() with
 mmap_read_lock()
In-Reply-To: <54cb04f-3762-987f-8294-91dafd8ebfb0@google.com>
Message-ID: <f99eb35-635c-8447-8a27-378d11d1e097@google.com>
References: <54cb04f-3762-987f-8294-91dafd8ebfb0@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bring collapse_and_free_pmd() back into collapse_pte_mapped_thp().
It does need mmap_read_lock(), but it does not need mmap_write_lock(),
nor vma_start_write() nor i_mmap lock nor anon_vma lock.  All racing
paths are relying on pte_offset_map_lock() and pmd_lock(), so use those.

Follow the pattern in retract_page_tables(); and using pte_free_defer()
removes most of the need for tlb_remove_table_sync_one() here; but call
pmdp_get_lockless_sync() to use it in the PAE case.

First check the VMA, in case page tables are being torn down: from JannH.
Confirm the preliminary find_pmd_or_thp_or_none() once page lock has been
acquired and the page looks suitable: from then on its state is stable.

However, collapse_pte_mapped_thp() was doing something others don't:
freeing a page table still containing "valid" entries.  i_mmap lock did
stop a racing truncate from double-freeing those pages, but we prefer
collapse_pte_mapped_thp() to clear the entries as usual.  Their TLB
flush can wait until the pmdp_collapse_flush() which follows, but the
mmu_notifier_invalidate_range_start() has to be done earlier.

Do the "step 1" checking loop without mmu_notifier: it wouldn't be good
for khugepaged to keep on repeatedly invalidating a range which is then
found unsuitable e.g. contains COWs.  "step 2", which does the clearing,
must then be more careful (after dropping ptl to do mmu_notifier), with
abort prepared to correct the accounting like "step 3".  But with those
entries now cleared, "step 4" (after dropping ptl to do pmd_lock) is kept
safe by the huge page lock, which stops new PTEs from being faulted in.

Signed-off-by: Hugh Dickins <hughd@google.com>
---
 mm/khugepaged.c | 172 ++++++++++++++++++++++--------------------------
 1 file changed, 77 insertions(+), 95 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index f7a0f7673127..060ac8789a1e 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1485,7 +1485,7 @@ static bool khugepaged_add_pte_mapped_thp(struct mm_struct *mm,
 	return ret;
 }
 
-/* hpage must be locked, and mmap_lock must be held in write */
+/* hpage must be locked, and mmap_lock must be held */
 static int set_huge_pmd(struct vm_area_struct *vma, unsigned long addr,
 			pmd_t *pmdp, struct page *hpage)
 {
@@ -1497,7 +1497,7 @@ static int set_huge_pmd(struct vm_area_struct *vma, unsigned long addr,
 	};
 
 	VM_BUG_ON(!PageTransHuge(hpage));
-	mmap_assert_write_locked(vma->vm_mm);
+	mmap_assert_locked(vma->vm_mm);
 
 	if (do_set_pmd(&vmf, hpage))
 		return SCAN_FAIL;
@@ -1506,48 +1506,6 @@ static int set_huge_pmd(struct vm_area_struct *vma, unsigned long addr,
 	return SCAN_SUCCEED;
 }
 
-/*
- * A note about locking:
- * Trying to take the page table spinlocks would be useless here because those
- * are only used to synchronize:
- *
- *  - modifying terminal entries (ones that point to a data page, not to another
- *    page table)
- *  - installing *new* non-terminal entries
- *
- * Instead, we need roughly the same kind of protection as free_pgtables() or
- * mm_take_all_locks() (but only for a single VMA):
- * The mmap lock together with this VMA's rmap locks covers all paths towards
- * the page table entries we're messing with here, except for hardware page
- * table walks and lockless_pages_from_mm().
- */
-static void collapse_and_free_pmd(struct mm_struct *mm, struct vm_area_struct *vma,
-				  unsigned long addr, pmd_t *pmdp)
-{
-	pmd_t pmd;
-	struct mmu_notifier_range range;
-
-	mmap_assert_write_locked(mm);
-	if (vma->vm_file)
-		lockdep_assert_held_write(&vma->vm_file->f_mapping->i_mmap_rwsem);
-	/*
-	 * All anon_vmas attached to the VMA have the same root and are
-	 * therefore locked by the same lock.
-	 */
-	if (vma->anon_vma)
-		lockdep_assert_held_write(&vma->anon_vma->root->rwsem);
-
-	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, mm, addr,
-				addr + HPAGE_PMD_SIZE);
-	mmu_notifier_invalidate_range_start(&range);
-	pmd = pmdp_collapse_flush(vma, addr, pmdp);
-	tlb_remove_table_sync_one();
-	mmu_notifier_invalidate_range_end(&range);
-	mm_dec_nr_ptes(mm);
-	page_table_check_pte_clear_range(mm, addr, pmd);
-	pte_free(mm, pmd_pgtable(pmd));
-}
-
 /**
  * collapse_pte_mapped_thp - Try to collapse a pte-mapped THP for mm at
  * address haddr.
@@ -1563,26 +1521,29 @@ static void collapse_and_free_pmd(struct mm_struct *mm, struct vm_area_struct *v
 int collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr,
 			    bool install_pmd)
 {
+	struct mmu_notifier_range range;
+	bool notified = false;
 	unsigned long haddr = addr & HPAGE_PMD_MASK;
 	struct vm_area_struct *vma = vma_lookup(mm, haddr);
 	struct page *hpage;
 	pte_t *start_pte, *pte;
-	pmd_t *pmd;
-	spinlock_t *ptl;
-	int count = 0, result = SCAN_FAIL;
+	pmd_t *pmd, pgt_pmd;
+	spinlock_t *pml, *ptl;
+	int nr_ptes = 0, result = SCAN_FAIL;
 	int i;
 
-	mmap_assert_write_locked(mm);
+	mmap_assert_locked(mm);
+
+	/* First check VMA found, in case page tables are being torn down */
+	if (!vma || !vma->vm_file ||
+	    !range_in_vma(vma, haddr, haddr + HPAGE_PMD_SIZE))
+		return SCAN_VMA_CHECK;
 
 	/* Fast check before locking page if already PMD-mapped */
 	result = find_pmd_or_thp_or_none(mm, haddr, &pmd);
 	if (result == SCAN_PMD_MAPPED)
 		return result;
 
-	if (!vma || !vma->vm_file ||
-	    !range_in_vma(vma, haddr, haddr + HPAGE_PMD_SIZE))
-		return SCAN_VMA_CHECK;
-
 	/*
 	 * If we are here, we've succeeded in replacing all the native pages
 	 * in the page cache with a single hugepage. If a mm were to fault-in
@@ -1612,6 +1573,7 @@ int collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr,
 		goto drop_hpage;
 	}
 
+	result = find_pmd_or_thp_or_none(mm, haddr, &pmd);
 	switch (result) {
 	case SCAN_SUCCEED:
 		break;
@@ -1625,27 +1587,10 @@ int collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr,
 		goto drop_hpage;
 	}
 
-	/* Lock the vma before taking i_mmap and page table locks */
-	vma_start_write(vma);
-
-	/*
-	 * We need to lock the mapping so that from here on, only GUP-fast and
-	 * hardware page walks can access the parts of the page tables that
-	 * we're operating on.
-	 * See collapse_and_free_pmd().
-	 */
-	i_mmap_lock_write(vma->vm_file->f_mapping);
-
-	/*
-	 * This spinlock should be unnecessary: Nobody else should be accessing
-	 * the page tables under spinlock protection here, only
-	 * lockless_pages_from_mm() and the hardware page walker can access page
-	 * tables while all the high-level locks are held in write mode.
-	 */
 	result = SCAN_FAIL;
 	start_pte = pte_offset_map_lock(mm, pmd, haddr, &ptl);
-	if (!start_pte)
-		goto drop_immap;
+	if (!start_pte)		/* mmap_lock + page lock should prevent this */
+		goto drop_hpage;
 
 	/* step 1: check all mapped PTEs are to the right huge page */
 	for (i = 0, addr = haddr, pte = start_pte;
@@ -1671,57 +1616,94 @@ int collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr,
 		 */
 		if (hpage + i != page)
 			goto abort;
-		count++;
 	}
 
-	/* step 2: adjust rmap */
+	pte_unmap_unlock(start_pte, ptl);
+	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, mm,
+				haddr, haddr + HPAGE_PMD_SIZE);
+	mmu_notifier_invalidate_range_start(&range);
+	notified = true;
+	start_pte = pte_offset_map_lock(mm, pmd, haddr, &ptl);
+	if (!start_pte)		/* mmap_lock + page lock should prevent this */
+		goto abort;
+
+	/* step 2: clear page table and adjust rmap */
 	for (i = 0, addr = haddr, pte = start_pte;
 	     i < HPAGE_PMD_NR; i++, addr += PAGE_SIZE, pte++) {
 		struct page *page;
 
 		if (pte_none(*pte))
 			continue;
-		page = vm_normal_page(vma, addr, *pte);
-		if (WARN_ON_ONCE(page && is_zone_device_page(page)))
+		/*
+		 * We dropped ptl after the first scan, to do the mmu_notifier:
+		 * page lock stops more PTEs of the hpage being faulted in, but
+		 * does not stop write faults COWing anon copies from existing
+		 * PTEs; and does not stop those being swapped out or migrated.
+		 */
+		if (!pte_present(*pte)) {
+			result = SCAN_PTE_NON_PRESENT;
 			goto abort;
+		}
+		page = vm_normal_page(vma, addr, *pte);
+		if (hpage + i != page)
+			goto abort;
+
+		/*
+		 * Must clear entry, or a racing truncate may re-remove it.
+		 * TLB flush can be left until pmdp_collapse_flush() does it.
+		 * PTE dirty? Shmem page is already dirty; file is read-only.
+		 */
+		pte_clear(mm, addr, pte);
 		page_remove_rmap(page, vma, false);
+		nr_ptes++;
 	}
 
 	pte_unmap_unlock(start_pte, ptl);
 
 	/* step 3: set proper refcount and mm_counters. */
-	if (count) {
-		page_ref_sub(hpage, count);
-		add_mm_counter(vma->vm_mm, mm_counter_file(hpage), -count);
+	if (nr_ptes) {
+		page_ref_sub(hpage, nr_ptes);
+		add_mm_counter(mm, mm_counter_file(hpage), -nr_ptes);
 	}
 
-	/* step 4: remove pte entries */
-	/* we make no change to anon, but protect concurrent anon page lookup */
-	if (vma->anon_vma)
-		anon_vma_lock_write(vma->anon_vma);
+	/* step 4: remove page table */
 
-	collapse_and_free_pmd(mm, vma, haddr, pmd);
+	/* Huge page lock is still held, so page table must remain empty */
+	pml = pmd_lock(mm, pmd);
+	if (ptl != pml)
+		spin_lock_nested(ptl, SINGLE_DEPTH_NESTING);
+	pgt_pmd = pmdp_collapse_flush(vma, haddr, pmd);
+	pmdp_get_lockless_sync();
+	if (ptl != pml)
+		spin_unlock(ptl);
+	spin_unlock(pml);
 
-	if (vma->anon_vma)
-		anon_vma_unlock_write(vma->anon_vma);
-	i_mmap_unlock_write(vma->vm_file->f_mapping);
+	mmu_notifier_invalidate_range_end(&range);
+
+	mm_dec_nr_ptes(mm);
+	page_table_check_pte_clear_range(mm, haddr, pgt_pmd);
+	pte_free_defer(mm, pmd_pgtable(pgt_pmd));
 
 maybe_install_pmd:
 	/* step 5: install pmd entry */
 	result = install_pmd
 			? set_huge_pmd(vma, haddr, pmd, hpage)
 			: SCAN_SUCCEED;
-
+	goto drop_hpage;
+abort:
+	if (nr_ptes) {
+		flush_tlb_mm(mm);
+		page_ref_sub(hpage, nr_ptes);
+		add_mm_counter(mm, mm_counter_file(hpage), -nr_ptes);
+	}
+	if (start_pte)
+		pte_unmap_unlock(start_pte, ptl);
+	if (notified)
+		mmu_notifier_invalidate_range_end(&range);
 drop_hpage:
 	unlock_page(hpage);
 	put_page(hpage);
 	return result;
-
-abort:
-	pte_unmap_unlock(start_pte, ptl);
-drop_immap:
-	i_mmap_unlock_write(vma->vm_file->f_mapping);
-	goto drop_hpage;
 }
 
 static void khugepaged_collapse_pte_mapped_thps(struct khugepaged_mm_slot *mm_slot)
@@ -2857,9 +2839,9 @@ int madvise_collapse(struct vm_area_struct *vma, struct vm_area_struct **prev,
 		case SCAN_PTE_MAPPED_HUGEPAGE:
 			BUG_ON(mmap_locked);
 			BUG_ON(*prev);
-			mmap_write_lock(mm);
+			mmap_read_lock(mm);
 			result = collapse_pte_mapped_thp(mm, addr, true);
-			mmap_write_unlock(mm);
+			mmap_locked = true;
 			goto handle_result;
 		/* Whitelisted set of results where continuing OK */
 		case SCAN_PMD_NULL:
-- 
2.35.3

