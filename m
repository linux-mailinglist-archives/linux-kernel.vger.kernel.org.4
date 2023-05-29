Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F7C57144B7
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 08:27:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231709AbjE2G1f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 02:27:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231682AbjE2G1X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 02:27:23 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 277FC19D
        for <linux-kernel@vger.kernel.org>; Sun, 28 May 2023 23:26:54 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id 3f1490d57ef6-ba8afcc82c0so5796215276.2
        for <linux-kernel@vger.kernel.org>; Sun, 28 May 2023 23:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685341612; x=1687933612;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=OPZMX1+LA/FvHP0/JC5qx50WzIWIXFewxM+MGzYgG4M=;
        b=Ytf3pJx5ZO2h8JphUMEUM+NgVIXTwIVhtYTQ/lA5Y8cir60w0OXuWtSllgiDhinPaR
         Iy4j/+CUvFlAp4R/CjSOblw5I+znP0kaNSqJXR4VKYKvTUfPb3oYvzoFoZFf0g3HTRPQ
         tAY4R1a5sWTcuBd7Oz6cpvBBwVDFmQiqte1C3YTUpMO9AoANcfZAyiW/btELN35Kv490
         fFp3EQeG93PsokK2axn0N0nvmbnw91onFgB1MigUnnJSNnNJsoUz87zNfUFbsCL7jZ72
         cyBArEZpOY67dIbt6WH+/9VlUHqVGsY29EI6EqLyGxDNiZ8V+VTllfG1NJsbPWUsuh6Y
         4UjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685341612; x=1687933612;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OPZMX1+LA/FvHP0/JC5qx50WzIWIXFewxM+MGzYgG4M=;
        b=dZArGuEZZl+0ysFdi2nbhzpjLv0XjuhXMFscP6iTLbC3XU2t024Y9mVhJA0ypDqTc0
         dbryjS3bsYVA0IZhb97bQMNTS+Aby1y28s0zf/FhIv9fIjrbdwZe8xVcsG//C8id8ME6
         ggw9dFkiTRIJqObLH44BvRlXW4K/1wyTWwMqGZv70P2AV1rWeej5cfltZVTRL+iKebdY
         j/hqs+P3qjJBrJbNuMbG4oYTmoNfNaz2eLvPpidR1yi/KKS4fGcdqBnC5hNpTTK2s4zp
         B4tnxGWfYDjxudJ9bisfNb+I2nlKWdlC1579D+B8KMuiF+U+rRdOanOw5mIffMk+102u
         6z+A==
X-Gm-Message-State: AC+VfDyjqqtqWWcNfcTH40pGMrvZErTqsOPiTXNXtcqw92vLUZXWhFIb
        6ff3HA3imjT5hHpbcF5njAizAQ==
X-Google-Smtp-Source: ACHHUZ5aDBGSE8V0e3lWDnHjHjCYn6fQF4N/hxkcmf1ygogwgzLWM5AgQMYGVJCj77dNUpkBtnYW7w==
X-Received: by 2002:a81:5b55:0:b0:565:ec67:18f4 with SMTP id p82-20020a815b55000000b00565ec6718f4mr4108617ywb.32.1685341612167;
        Sun, 28 May 2023 23:26:52 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id m6-20020a0de306000000b0055a486140b6sm3427593ywe.36.2023.05.28.23.26.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 May 2023 23:26:51 -0700 (PDT)
Date:   Sun, 28 May 2023 23:26:48 -0700 (PDT)
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
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Jann Horn <jannh@google.com>,
        linux-arm-kernel@lists.infradead.org, sparclinux@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 10/12] mm/khugepaged: collapse_pte_mapped_thp() with
 mmap_read_lock()
In-Reply-To: <35e983f5-7ed3-b310-d949-9ae8b130cdab@google.com>
Message-ID: <563340a4-7ac9-7cc8-33d8-f7cc6ef19ea6@google.com>
References: <35e983f5-7ed3-b310-d949-9ae8b130cdab@google.com>
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

Bring collapse_and_free_pmd() back into collapse_pte_mapped_thp().
It does need mmap_read_lock(), but it does not need mmap_write_lock(),
nor vma_start_write() nor i_mmap lock nor anon_vma lock.  All racing
paths are relying on pte_offset_map_lock() and pmd_lock(), so use those.
Follow the pattern in retract_page_tables(); and using pte_free_defer()
removes the need for tlb_remove_table_sync_one() here.

Confirm the preliminary find_pmd_or_thp_or_none() once page lock has been
acquired and the page looks suitable: from then on its state is stable.

However, collapse_pte_mapped_thp() was doing something others don't:
freeing a page table still containing "valid" entries.  i_mmap lock did
stop a racing truncate from double-freeing those pages, but we prefer
collapse_pte_mapped_thp() to clear the entries as usual.  Their TLB
flush can wait until the pmdp_collapse_flush() which follows, but the
mmu_notifier_invalidate_range_start() has to be done earlier.

Some cleanup while rearranging: rename "count" to "nr_ptes";
and "step 2" does not need to duplicate the checks in "step 1".

Signed-off-by: Hugh Dickins <hughd@google.com>
---
 mm/khugepaged.c | 131 +++++++++++++++---------------------------------
 1 file changed, 41 insertions(+), 90 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 4fd408154692..2999500abdd5 100644
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
@@ -1563,16 +1521,17 @@ static void collapse_and_free_pmd(struct mm_struct *mm, struct vm_area_struct *v
 int collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr,
 			    bool install_pmd)
 {
+	struct mmu_notifier_range range;
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
 
 	/* Fast check before locking page if already PMD-mapped */
 	result = find_pmd_or_thp_or_none(mm, haddr, &pmd);
@@ -1612,6 +1571,7 @@ int collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr,
 		goto drop_hpage;
 	}
 
+	result = find_pmd_or_thp_or_none(mm, haddr, &pmd);
 	switch (result) {
 	case SCAN_SUCCEED:
 		break;
@@ -1625,27 +1585,14 @@ int collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr,
 		goto drop_hpage;
 	}
 
-	/* Lock the vma before taking i_mmap and page table locks */
-	vma_start_write(vma);
+	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, mm,
+				haddr, haddr + HPAGE_PMD_SIZE);
+	mmu_notifier_invalidate_range_start(&range);
 
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
+		goto abort;
 
 	/* step 1: check all mapped PTEs are to the right huge page */
 	for (i = 0, addr = haddr, pte = start_pte;
@@ -1671,40 +1618,44 @@ int collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr,
 		 */
 		if (hpage + i != page)
 			goto abort;
-		count++;
+		nr_ptes++;
 	}
 
-	/* step 2: adjust rmap */
+	/* step 2: clear page table and adjust rmap */
 	for (i = 0, addr = haddr, pte = start_pte;
 	     i < HPAGE_PMD_NR; i++, addr += PAGE_SIZE, pte++) {
-		struct page *page;
-
 		if (pte_none(*pte))
 			continue;
-		page = vm_normal_page(vma, addr, *pte);
-		if (WARN_ON_ONCE(page && is_zone_device_page(page)))
-			goto abort;
-		page_remove_rmap(page, vma, false);
+
+		/* Must clear entry, or a racing truncate may re-remove it */
+		pte_clear(mm, addr, pte);
+		page_remove_rmap(hpage + i, vma, false);
 	}
 
 	pte_unmap_unlock(start_pte, ptl);
 
 	/* step 3: set proper refcount and mm_counters. */
-	if (count) {
-		page_ref_sub(hpage, count);
-		add_mm_counter(vma->vm_mm, mm_counter_file(hpage), -count);
+	if (nr_ptes) {
+		page_ref_sub(hpage, nr_ptes);
+		add_mm_counter(vma->vm_mm, mm_counter_file(hpage), -nr_ptes);
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
@@ -1718,9 +1669,9 @@ int collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr,
 	return result;
 
 abort:
-	pte_unmap_unlock(start_pte, ptl);
-drop_immap:
-	i_mmap_unlock_write(vma->vm_file->f_mapping);
+	if (start_pte)
+		pte_unmap_unlock(start_pte, ptl);
+	mmu_notifier_invalidate_range_end(&range);
 	goto drop_hpage;
 }
 
@@ -2842,9 +2793,9 @@ int madvise_collapse(struct vm_area_struct *vma, struct vm_area_struct **prev,
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

