Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB14670B488
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 07:25:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbjEVFZf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 01:25:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbjEVFZb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 01:25:31 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B15FEAA
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 22:25:29 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id 3f1490d57ef6-b9a7e639656so10801845276.0
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 22:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684733129; x=1687325129;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NBl0ppCRA8l25HwCsBAYjZw+ZZ23COv4vEuhAo6MgQs=;
        b=Cd3nHwxaC/nh6HEQWhU6+zHLQfimMyJGpQmSRQFhhW/GPP873cSkYFOiS5uVG1tykM
         Ryshue+/dZ9gOhxIxMYC4NRprObjBBWLSBCffW9HayG++u4h8tLgWq5NECMQwyEn52g4
         13GfY4O2VekWiqVxfPenJhxKSjbH9x7XqjT7KEDC9iyAKT/BVUfykNPLsCku8blfINLG
         XrU8Vy7pHm8Cw4m+KEkicTGibPauERe+Pk26G/c3KRes7WKtltas6Fuf97+EzswuIMvR
         NjmExJ27Xjr53poHCBGkRWEPVuUwRpPQE56LGrkD5LJsjNMZNI4MUNIfvWEA+VYa9OvY
         6Vyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684733129; x=1687325129;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NBl0ppCRA8l25HwCsBAYjZw+ZZ23COv4vEuhAo6MgQs=;
        b=ZG2h7xmMLO0zlVnx8Jwvydn+5SFq673bfVjTpmGW1EEFbNnczaHOi83MTXXEflPpo+
         LNxsUgRZFgXbtgv9CBAh8tn2CccldJ2wcnfKAW83KZpDuhdgA7ppOHQZHCi2kdaWN5fz
         zQlt4mzpWrX6q7bcKLt0VxwFN69OGRKsXT+atWhUxJBO5o2ciBHHXBGrKX97jIil3GJX
         mTz2MQKzYket6np77rCZ2Ajwu+6d5HGgfUVwidF4h94t+E7HF0qXH2efer7icGYD5ING
         V1YNrT7HlDydEXl+Szri9w8DYr67A285K/z0X2ENWnkdnLPR56/Spnm1urtKQcibcScU
         1TCQ==
X-Gm-Message-State: AC+VfDzyjDrWSbH2XC/PyhLR3cauZWiSkmJhTR1qrXqR05RsMysM+SIy
        5//+hsuNI54ULUcCvWct4un4Gw==
X-Google-Smtp-Source: ACHHUZ73cLvyzajJn77JRRVp9Omy0BAayWsdbmLAc2xDyGvyYdthxJkt0VkVvx7l16HAMXlwEB2XiA==
X-Received: by 2002:a05:6902:1101:b0:ba7:3df3:6df5 with SMTP id o1-20020a056902110100b00ba73df36df5mr12099433ybu.38.1684733128711;
        Sun, 21 May 2023 22:25:28 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id x7-20020a259a07000000b00b8f6ec5a955sm1267873ybn.49.2023.05.21.22.25.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 May 2023 22:25:28 -0700 (PDT)
Date:   Sun, 21 May 2023 22:25:25 -0700 (PDT)
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
Subject: [PATCH 28/31] mm/memory: allow pte_offset_map[_lock]() to fail
In-Reply-To: <68a97fbe-5c1e-7ac6-72c-7b9c6290b370@google.com>
Message-ID: <c2f8c6d-d86c-de6c-f90-1aed3cfce5b3@google.com>
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

copy_pte_range(): use pte_offset_map_nolock(), and allow for it to fail;
but with a comment on some further assumptions that are being made there.

zap_pte_range() and zap_pmd_range(): adjust their interaction so that
a pte_offset_map_lock() failure in zap_pte_range() leads to a retry in
zap_pmd_range(); remove call to pmd_none_or_trans_huge_or_clear_bad().

Allow pte_offset_map_lock() to fail in many functions.  Update comment
on calling pte_alloc() in do_anonymous_page().  Remove redundant calls
to pmd_trans_unstable(), pmd_devmap_trans_unstable(), pmd_none() and
pmd_bad(); but leave pmd_none_or_clear_bad() calls in free_pmd_range()
and copy_pmd_range(), those do simplify the next level down.

Signed-off-by: Hugh Dickins <hughd@google.com>
---
 mm/memory.c | 172 +++++++++++++++++++++++++---------------------------
 1 file changed, 82 insertions(+), 90 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 2eb54c0d5d3c..c7b920291a72 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1012,13 +1012,25 @@ copy_pte_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
 	progress = 0;
 	init_rss_vec(rss);
 
+	/*
+	 * copy_pmd_range()'s prior pmd_none_or_clear_bad(src_pmd), and the
+	 * error handling here, assume that exclusive mmap_lock on dst and src
+	 * protects anon from unexpected THP transitions; with shmem and file
+	 * protected by mmap_lock-less collapse skipping areas with anon_vma
+	 * (whereas vma_needs_copy() skips areas without anon_vma).  A rework
+	 * can remove such assumptions later, but this is good enough for now.
+	 */
 	dst_pte = pte_alloc_map_lock(dst_mm, dst_pmd, addr, &dst_ptl);
 	if (!dst_pte) {
 		ret = -ENOMEM;
 		goto out;
 	}
-	src_pte = pte_offset_map(src_pmd, addr);
-	src_ptl = pte_lockptr(src_mm, src_pmd);
+	src_pte = pte_offset_map_nolock(src_mm, src_pmd, addr, &src_ptl);
+	if (!src_pte) {
+		pte_unmap_unlock(dst_pte, dst_ptl);
+		/* ret == 0 */
+		goto out;
+	}
 	spin_lock_nested(src_ptl, SINGLE_DEPTH_NESTING);
 	orig_src_pte = src_pte;
 	orig_dst_pte = dst_pte;
@@ -1083,8 +1095,7 @@ copy_pte_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
 	} while (dst_pte++, src_pte++, addr += PAGE_SIZE, addr != end);
 
 	arch_leave_lazy_mmu_mode();
-	spin_unlock(src_ptl);
-	pte_unmap(orig_src_pte);
+	pte_unmap_unlock(orig_src_pte, src_ptl);
 	add_mm_rss_vec(dst_mm, rss);
 	pte_unmap_unlock(orig_dst_pte, dst_ptl);
 	cond_resched();
@@ -1388,10 +1399,11 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 	swp_entry_t entry;
 
 	tlb_change_page_size(tlb, PAGE_SIZE);
-again:
 	init_rss_vec(rss);
-	start_pte = pte_offset_map_lock(mm, pmd, addr, &ptl);
-	pte = start_pte;
+	start_pte = pte = pte_offset_map_lock(mm, pmd, addr, &ptl);
+	if (!pte)
+		return addr;
+
 	flush_tlb_batched_pending(mm);
 	arch_enter_lazy_mmu_mode();
 	do {
@@ -1507,17 +1519,10 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 	 * If we forced a TLB flush (either due to running out of
 	 * batch buffers or because we needed to flush dirty TLB
 	 * entries before releasing the ptl), free the batched
-	 * memory too. Restart if we didn't do everything.
+	 * memory too. Come back again if we didn't do everything.
 	 */
-	if (force_flush) {
-		force_flush = 0;
+	if (force_flush)
 		tlb_flush_mmu(tlb);
-	}
-
-	if (addr != end) {
-		cond_resched();
-		goto again;
-	}
 
 	return addr;
 }
@@ -1536,8 +1541,10 @@ static inline unsigned long zap_pmd_range(struct mmu_gather *tlb,
 		if (is_swap_pmd(*pmd) || pmd_trans_huge(*pmd) || pmd_devmap(*pmd)) {
 			if (next - addr != HPAGE_PMD_SIZE)
 				__split_huge_pmd(vma, pmd, addr, false, NULL);
-			else if (zap_huge_pmd(tlb, vma, pmd, addr))
-				goto next;
+			else if (zap_huge_pmd(tlb, vma, pmd, addr)) {
+				addr = next;
+				continue;
+			}
 			/* fall through */
 		} else if (details && details->single_folio &&
 			   folio_test_pmd_mappable(details->single_folio) &&
@@ -1550,20 +1557,14 @@ static inline unsigned long zap_pmd_range(struct mmu_gather *tlb,
 			 */
 			spin_unlock(ptl);
 		}
-
-		/*
-		 * Here there can be other concurrent MADV_DONTNEED or
-		 * trans huge page faults running, and if the pmd is
-		 * none or trans huge it can change under us. This is
-		 * because MADV_DONTNEED holds the mmap_lock in read
-		 * mode.
-		 */
-		if (pmd_none_or_trans_huge_or_clear_bad(pmd))
-			goto next;
-		next = zap_pte_range(tlb, vma, pmd, addr, next, details);
-next:
-		cond_resched();
-	} while (pmd++, addr = next, addr != end);
+		if (pmd_none(*pmd)) {
+			addr = next;
+			continue;
+		}
+		addr = zap_pte_range(tlb, vma, pmd, addr, next, details);
+		if (addr != next)
+			pmd--;
+	} while (pmd++, cond_resched(), addr != end);
 
 	return addr;
 }
@@ -1905,6 +1906,10 @@ static int insert_pages(struct vm_area_struct *vma, unsigned long addr,
 		const int batch_size = min_t(int, pages_to_write_in_pmd, 8);
 
 		start_pte = pte_offset_map_lock(mm, pmd, addr, &pte_lock);
+		if (!start_pte) {
+			ret = -EFAULT;
+			goto out;
+		}
 		for (pte = start_pte; pte_idx < batch_size; ++pte, ++pte_idx) {
 			int err = insert_page_in_batch_locked(vma, pte,
 				addr, pages[curr_page_idx], prot);
@@ -2572,10 +2577,10 @@ static int apply_to_pte_range(struct mm_struct *mm, pmd_t *pmd,
 		mapped_pte = pte = (mm == &init_mm) ?
 			pte_offset_kernel(pmd, addr) :
 			pte_offset_map_lock(mm, pmd, addr, &ptl);
+		if (!pte)
+			return -EINVAL;
 	}
 
-	BUG_ON(pmd_huge(*pmd));
-
 	arch_enter_lazy_mmu_mode();
 
 	if (fn) {
@@ -2804,7 +2809,6 @@ static inline int __wp_page_copy_user(struct page *dst, struct page *src,
 	int ret;
 	void *kaddr;
 	void __user *uaddr;
-	bool locked = false;
 	struct vm_area_struct *vma = vmf->vma;
 	struct mm_struct *mm = vma->vm_mm;
 	unsigned long addr = vmf->address;
@@ -2830,12 +2834,12 @@ static inline int __wp_page_copy_user(struct page *dst, struct page *src,
 	 * On architectures with software "accessed" bits, we would
 	 * take a double page fault, so mark it accessed here.
 	 */
+	vmf->pte = NULL;
 	if (!arch_has_hw_pte_young() && !pte_young(vmf->orig_pte)) {
 		pte_t entry;
 
 		vmf->pte = pte_offset_map_lock(mm, vmf->pmd, addr, &vmf->ptl);
-		locked = true;
-		if (!likely(pte_same(*vmf->pte, vmf->orig_pte))) {
+		if (unlikely(!vmf->pte || !pte_same(*vmf->pte, vmf->orig_pte))) {
 			/*
 			 * Other thread has already handled the fault
 			 * and update local tlb only
@@ -2857,13 +2861,12 @@ static inline int __wp_page_copy_user(struct page *dst, struct page *src,
 	 * zeroes.
 	 */
 	if (__copy_from_user_inatomic(kaddr, uaddr, PAGE_SIZE)) {
-		if (locked)
+		if (vmf->pte)
 			goto warn;
 
 		/* Re-validate under PTL if the page is still mapped */
 		vmf->pte = pte_offset_map_lock(mm, vmf->pmd, addr, &vmf->ptl);
-		locked = true;
-		if (!likely(pte_same(*vmf->pte, vmf->orig_pte))) {
+		if (unlikely(!vmf->pte || !pte_same(*vmf->pte, vmf->orig_pte))) {
 			/* The PTE changed under us, update local tlb */
 			update_mmu_tlb(vma, addr, vmf->pte);
 			ret = -EAGAIN;
@@ -2888,7 +2891,7 @@ static inline int __wp_page_copy_user(struct page *dst, struct page *src,
 	ret = 0;
 
 pte_unlock:
-	if (locked)
+	if (vmf->pte)
 		pte_unmap_unlock(vmf->pte, vmf->ptl);
 	kunmap_atomic(kaddr);
 	flush_dcache_page(dst);
@@ -3110,7 +3113,7 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
 	 * Re-check the pte - we dropped the lock
 	 */
 	vmf->pte = pte_offset_map_lock(mm, vmf->pmd, vmf->address, &vmf->ptl);
-	if (likely(pte_same(*vmf->pte, vmf->orig_pte))) {
+	if (likely(vmf->pte && pte_same(*vmf->pte, vmf->orig_pte))) {
 		if (old_folio) {
 			if (!folio_test_anon(old_folio)) {
 				dec_mm_counter(mm, mm_counter_file(&old_folio->page));
@@ -3178,19 +3181,20 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
 		/* Free the old page.. */
 		new_folio = old_folio;
 		page_copied = 1;
-	} else {
+		pte_unmap_unlock(vmf->pte, vmf->ptl);
+	} else if (vmf->pte) {
 		update_mmu_tlb(vma, vmf->address, vmf->pte);
+		pte_unmap_unlock(vmf->pte, vmf->ptl);
 	}
 
-	if (new_folio)
-		folio_put(new_folio);
-
-	pte_unmap_unlock(vmf->pte, vmf->ptl);
 	/*
 	 * No need to double call mmu_notifier->invalidate_range() callback as
 	 * the above ptep_clear_flush_notify() did already call it.
 	 */
 	mmu_notifier_invalidate_range_only_end(&range);
+
+	if (new_folio)
+		folio_put(new_folio);
 	if (old_folio) {
 		if (page_copied)
 			free_swap_cache(&old_folio->page);
@@ -3230,6 +3234,8 @@ vm_fault_t finish_mkwrite_fault(struct vm_fault *vmf)
 	WARN_ON_ONCE(!(vmf->vma->vm_flags & VM_SHARED));
 	vmf->pte = pte_offset_map_lock(vmf->vma->vm_mm, vmf->pmd, vmf->address,
 				       &vmf->ptl);
+	if (!vmf->pte)
+		return VM_FAULT_NOPAGE;
 	/*
 	 * We might have raced with another page fault while we released the
 	 * pte_offset_map_lock.
@@ -3591,10 +3597,11 @@ static vm_fault_t remove_device_exclusive_entry(struct vm_fault *vmf)
 
 	vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd, vmf->address,
 				&vmf->ptl);
-	if (likely(pte_same(*vmf->pte, vmf->orig_pte)))
+	if (likely(vmf->pte && pte_same(*vmf->pte, vmf->orig_pte)))
 		restore_exclusive_pte(vma, vmf->page, vmf->address, vmf->pte);
 
-	pte_unmap_unlock(vmf->pte, vmf->ptl);
+	if (vmf->pte)
+		pte_unmap_unlock(vmf->pte, vmf->ptl);
 	folio_unlock(folio);
 	folio_put(folio);
 
@@ -3625,6 +3632,8 @@ static vm_fault_t pte_marker_clear(struct vm_fault *vmf)
 {
 	vmf->pte = pte_offset_map_lock(vmf->vma->vm_mm, vmf->pmd,
 				       vmf->address, &vmf->ptl);
+	if (!vmf->pte)
+		return 0;
 	/*
 	 * Be careful so that we will only recover a special uffd-wp pte into a
 	 * none pte.  Otherwise it means the pte could have changed, so retry.
@@ -3728,11 +3737,9 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 			vmf->page = pfn_swap_entry_to_page(entry);
 			vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd,
 					vmf->address, &vmf->ptl);
-			if (unlikely(!pte_same(*vmf->pte, vmf->orig_pte))) {
-				spin_unlock(vmf->ptl);
-				goto out;
-			}
-
+			if (unlikely(!vmf->pte ||
+				     !pte_same(*vmf->pte, vmf->orig_pte)))
+				goto unlock;
 			/*
 			 * Get a page reference while we know the page can't be
 			 * freed.
@@ -3807,7 +3814,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 			 */
 			vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd,
 					vmf->address, &vmf->ptl);
-			if (likely(pte_same(*vmf->pte, vmf->orig_pte)))
+			if (likely(vmf->pte && pte_same(*vmf->pte, vmf->orig_pte)))
 				ret = VM_FAULT_OOM;
 			goto unlock;
 		}
@@ -3877,7 +3884,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	 */
 	vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd, vmf->address,
 			&vmf->ptl);
-	if (unlikely(!pte_same(*vmf->pte, vmf->orig_pte)))
+	if (unlikely(!vmf->pte || !pte_same(*vmf->pte, vmf->orig_pte)))
 		goto out_nomap;
 
 	if (unlikely(!folio_test_uptodate(folio))) {
@@ -4003,13 +4010,15 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	/* No need to invalidate - it was non-present before */
 	update_mmu_cache(vma, vmf->address, vmf->pte);
 unlock:
-	pte_unmap_unlock(vmf->pte, vmf->ptl);
+	if (vmf->pte)
+		pte_unmap_unlock(vmf->pte, vmf->ptl);
 out:
 	if (si)
 		put_swap_device(si);
 	return ret;
 out_nomap:
-	pte_unmap_unlock(vmf->pte, vmf->ptl);
+	if (vmf->pte)
+		pte_unmap_unlock(vmf->pte, vmf->ptl);
 out_page:
 	folio_unlock(folio);
 out_release:
@@ -4041,22 +4050,12 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
 		return VM_FAULT_SIGBUS;
 
 	/*
-	 * Use pte_alloc() instead of pte_alloc_map().  We can't run
-	 * pte_offset_map() on pmds where a huge pmd might be created
-	 * from a different thread.
-	 *
-	 * pte_alloc_map() is safe to use under mmap_write_lock(mm) or when
-	 * parallel threads are excluded by other means.
-	 *
-	 * Here we only have mmap_read_lock(mm).
+	 * Use pte_alloc() instead of pte_alloc_map(), so that OOM can
+	 * be distinguished from a transient failure of pte_offset_map().
 	 */
 	if (pte_alloc(vma->vm_mm, vmf->pmd))
 		return VM_FAULT_OOM;
 
-	/* See comment in handle_pte_fault() */
-	if (unlikely(pmd_trans_unstable(vmf->pmd)))
-		return 0;
-
 	/* Use the zero-page for reads */
 	if (!(vmf->flags & FAULT_FLAG_WRITE) &&
 			!mm_forbids_zeropage(vma->vm_mm)) {
@@ -4064,6 +4063,8 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
 						vma->vm_page_prot));
 		vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd,
 				vmf->address, &vmf->ptl);
+		if (!vmf->pte)
+			goto unlock;
 		if (vmf_pte_changed(vmf)) {
 			update_mmu_tlb(vma, vmf->address, vmf->pte);
 			goto unlock;
@@ -4104,6 +4105,8 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
 
 	vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd, vmf->address,
 			&vmf->ptl);
+	if (!vmf->pte)
+		goto release;
 	if (vmf_pte_changed(vmf)) {
 		update_mmu_tlb(vma, vmf->address, vmf->pte);
 		goto release;
@@ -4131,7 +4134,8 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
 	/* No need to invalidate - it was non-present before */
 	update_mmu_cache(vma, vmf->address, vmf->pte);
 unlock:
-	pte_unmap_unlock(vmf->pte, vmf->ptl);
+	if (vmf->pte)
+		pte_unmap_unlock(vmf->pte, vmf->ptl);
 	return ret;
 release:
 	folio_put(folio);
@@ -4380,15 +4384,10 @@ vm_fault_t finish_fault(struct vm_fault *vmf)
 			return VM_FAULT_OOM;
 	}
 
-	/*
-	 * See comment in handle_pte_fault() for how this scenario happens, we
-	 * need to return NOPAGE so that we drop this page.
-	 */
-	if (pmd_devmap_trans_unstable(vmf->pmd))
-		return VM_FAULT_NOPAGE;
-
 	vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd,
 				      vmf->address, &vmf->ptl);
+	if (!vmf->pte)
+		return VM_FAULT_NOPAGE;
 
 	/* Re-check under ptl */
 	if (likely(!vmf_pte_changed(vmf))) {
@@ -4630,17 +4629,11 @@ static vm_fault_t do_fault(struct vm_fault *vmf)
 	 * The VMA was not fully populated on mmap() or missing VM_DONTEXPAND
 	 */
 	if (!vma->vm_ops->fault) {
-		/*
-		 * If we find a migration pmd entry or a none pmd entry, which
-		 * should never happen, return SIGBUS
-		 */
-		if (unlikely(!pmd_present(*vmf->pmd)))
+		vmf->pte = pte_offset_map_lock(vmf->vma->vm_mm, vmf->pmd,
+					       vmf->address, &vmf->ptl);
+		if (unlikely(!vmf->pte))
 			ret = VM_FAULT_SIGBUS;
 		else {
-			vmf->pte = pte_offset_map_lock(vmf->vma->vm_mm,
-						       vmf->pmd,
-						       vmf->address,
-						       &vmf->ptl);
 			/*
 			 * Make sure this is not a temporary clearing of pte
 			 * by holding ptl and checking again. A R/M/W update
@@ -5429,10 +5422,9 @@ int follow_pte(struct mm_struct *mm, unsigned long address,
 	pmd = pmd_offset(pud, address);
 	VM_BUG_ON(pmd_trans_huge(*pmd));
 
-	if (pmd_none(*pmd) || unlikely(pmd_bad(*pmd)))
-		goto out;
-
 	ptep = pte_offset_map_lock(mm, pmd, address, ptlp);
+	if (!ptep)
+		goto out;
 	if (!pte_present(*ptep))
 		goto unlock;
 	*ptepp = ptep;
-- 
2.35.3

