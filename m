Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FFC563C894
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 20:39:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235837AbiK2TjC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 14:39:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236463AbiK2Thb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 14:37:31 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E930A64552
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 11:35:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669750547;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rIOUAJrVD+5ozo92pUGGgS61bSj8F1LiHfipiIThQWE=;
        b=Iq5ze4PsAccH1uiXcAwHSiBqOlhIGk1woxz/esJVgwoRyT8VpRMk3msDHPMXwIDym9sBMq
        uCQ7ljefwTpoZo+HKKC0Un20QEsolJXE9ybFxCDw1W07aQUWTRghQJ6Y20tzHzMyL8dwyZ
        Z4+Gm+16nC5TuTqL6Mf12SeKH+N4f/E=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-513-EclHKSCcPeq6MAIPNOW9Rg-1; Tue, 29 Nov 2022 14:35:45 -0500
X-MC-Unique: EclHKSCcPeq6MAIPNOW9Rg-1
Received: by mail-qk1-f199.google.com with SMTP id bj4-20020a05620a190400b006fc7c5d454cso16904884qkb.14
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 11:35:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rIOUAJrVD+5ozo92pUGGgS61bSj8F1LiHfipiIThQWE=;
        b=GEvmQJ54yaIhkee5JbfE0oASzq7JdvPA3Kn1vWD1HmcJhQZzdb77m5Yb6g8u80eXLx
         p/jRlUDsIcM4Jn3jA8YWrMmvvgp8BFposc53t9j4P+ox1rVsDkdori+xio5V3BCZCxcE
         llYxJcbf0MLqvV2fgBcHnmM66gJUb6i7blum9Tcm8R1NZJhBZP9UB33ztcAQ9I0u/oNp
         V3vcWeF3m8HwXpIwOIW3qIyLCwuk3/SAphCfckxSpbIEWr0YnIOLpttHWTwqvrMnOAKK
         nRWkhiLt08501nY9yh5RhVvfhmC43RrXVRWvdsiF+P/teGLLJhNn8uys+wh+fCRtSYWx
         au0A==
X-Gm-Message-State: ANoB5pn7KKlvAmf5n+1iFBbYLuvJyJAAwbNyilbcCJXUIrF8TbTE/KLc
        zeIHsVittbr96Tf5e7HmuRMpcpa9BT1qHU7rJ0eL2G1roZfh0RFWpDx1/z49PNnoMBVHQK5dDRD
        zRK3fuizULlXqPE7uc2BEeN6C
X-Received: by 2002:ac8:47c5:0:b0:3a5:6a0e:db3c with SMTP id d5-20020ac847c5000000b003a56a0edb3cmr54798767qtr.398.1669750545250;
        Tue, 29 Nov 2022 11:35:45 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4C39MBXCtpMl9smeazapfgsP2CIC564Nh2CynrssdJQQDFrjOEpHDtdGLhHXiFwSNHGgoeMg==
X-Received: by 2002:ac8:47c5:0:b0:3a5:6a0e:db3c with SMTP id d5-20020ac847c5000000b003a56a0edb3cmr54798742qtr.398.1669750544917;
        Tue, 29 Nov 2022 11:35:44 -0800 (PST)
Received: from x1n.redhat.com (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id n1-20020a05620a294100b006fa16fe93bbsm11313013qkp.15.2022.11.29.11.35.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Nov 2022 11:35:44 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     James Houghton <jthoughton@google.com>,
        Jann Horn <jannh@google.com>, peterx@redhat.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        David Hildenbrand <david@redhat.com>
Subject: [PATCH 10/10] mm/hugetlb: Introduce hugetlb_walk()
Date:   Tue, 29 Nov 2022 14:35:26 -0500
Message-Id: <20221129193526.3588187-11-peterx@redhat.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221129193526.3588187-1-peterx@redhat.com>
References: <20221129193526.3588187-1-peterx@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

huge_pte_offset() is the main walker function for hugetlb pgtables.  The
name is not really representing what it does, though.

Instead of renaming it, introduce a wrapper function called hugetlb_walk()
which will use huge_pte_offset() inside.  Assert on the locks when walking
the pgtable.

Note, the vma lock assertion will be a no-op for private mappings.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 fs/hugetlbfs/inode.c    |  4 +---
 fs/userfaultfd.c        |  6 ++----
 include/linux/hugetlb.h | 37 +++++++++++++++++++++++++++++++++++++
 mm/hugetlb.c            | 34 ++++++++++++++--------------------
 mm/page_vma_mapped.c    |  2 +-
 mm/pagewalk.c           |  4 +---
 6 files changed, 56 insertions(+), 31 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index fdb16246f46e..48f1a8ad2243 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -388,9 +388,7 @@ static bool hugetlb_vma_maps_page(struct vm_area_struct *vma,
 {
 	pte_t *ptep, pte;
 
-	ptep = huge_pte_offset(vma->vm_mm, addr,
-			huge_page_size(hstate_vma(vma)));
-
+	ptep = hugetlb_walk(vma, addr, huge_page_size(hstate_vma(vma)));
 	if (!ptep)
 		return false;
 
diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index a602f008dde5..f31fe1a9f4c5 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -237,14 +237,12 @@ static inline bool userfaultfd_huge_must_wait(struct userfaultfd_ctx *ctx,
 					 unsigned long flags,
 					 unsigned long reason)
 {
-	struct mm_struct *mm = ctx->mm;
 	pte_t *ptep, pte;
 	bool ret = true;
 
-	mmap_assert_locked(mm);
-
-	ptep = huge_pte_offset(mm, address, vma_mmu_pagesize(vma));
+	mmap_assert_locked(ctx->mm);
 
+	ptep = hugetlb_walk(vma, address, vma_mmu_pagesize(vma));
 	if (!ptep)
 		goto out;
 
diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 81efd9b9baa2..1a51c45fdf2e 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -196,6 +196,11 @@ pte_t *huge_pte_alloc(struct mm_struct *mm, struct vm_area_struct *vma,
  * huge_pte_offset(): Walk the hugetlb pgtable until the last level PTE.
  * Returns the pte_t* if found, or NULL if the address is not mapped.
  *
+ * IMPORTANT: we should normally not directly call this function, instead
+ * this is only a common interface to implement arch-specific walker.
+ * Please consider using the hugetlb_walk() helper to make sure of the
+ * correct locking is satisfied.
+ *
  * Since this function will walk all the pgtable pages (including not only
  * high-level pgtable page, but also PUD entry that can be unshared
  * concurrently for VM_SHARED), the caller of this function should be
@@ -1229,4 +1234,36 @@ bool want_pmd_share(struct vm_area_struct *vma, unsigned long addr);
 #define flush_hugetlb_tlb_range(vma, addr, end)	flush_tlb_range(vma, addr, end)
 #endif
 
+static inline bool
+__vma_shareable_flags_pmd(struct vm_area_struct *vma)
+{
+	return vma->vm_flags & (VM_MAYSHARE | VM_SHARED) &&
+		vma->vm_private_data;
+}
+
+/*
+ * Safe version of huge_pte_offset() to check the locks.  See comments
+ * above huge_pte_offset().
+ */
+static inline pte_t *
+hugetlb_walk(struct vm_area_struct *vma, unsigned long addr, unsigned long sz)
+{
+#if defined(CONFIG_ARCH_WANT_HUGE_PMD_SHARE) && defined(CONFIG_LOCKDEP)
+	struct hugetlb_vma_lock *vma_lock = vma->vm_private_data;
+
+	/*
+	 * If pmd sharing possible, locking needed to safely walk the
+	 * hugetlb pgtables.  More information can be found at the comment
+	 * above huge_pte_offset() in the same file.
+	 *
+	 * NOTE: lockdep_is_held() is only defined with CONFIG_LOCKDEP.
+	 */
+	if (__vma_shareable_flags_pmd(vma))
+		WARN_ON_ONCE(!lockdep_is_held(&vma_lock->rw_sema) &&
+			     !lockdep_is_held(
+				 &vma->vm_file->f_mapping->i_mmap_rwsem));
+#endif
+	return huge_pte_offset(vma->vm_mm, addr, sz);
+}
+
 #endif /* _LINUX_HUGETLB_H */
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index df645a5824e3..05867e82b467 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -4816,7 +4816,7 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 	} else {
 		/*
 		 * For shared mappings the vma lock must be held before
-		 * calling huge_pte_offset in the src vma. Otherwise, the
+		 * calling hugetlb_walk() in the src vma. Otherwise, the
 		 * returned ptep could go away if part of a shared pmd and
 		 * another thread calls huge_pmd_unshare.
 		 */
@@ -4826,7 +4826,7 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 	last_addr_mask = hugetlb_mask_last_page(h);
 	for (addr = src_vma->vm_start; addr < src_vma->vm_end; addr += sz) {
 		spinlock_t *src_ptl, *dst_ptl;
-		src_pte = huge_pte_offset(src, addr, sz);
+		src_pte = hugetlb_walk(src_vma, addr, sz);
 		if (!src_pte) {
 			addr |= last_addr_mask;
 			continue;
@@ -5030,7 +5030,7 @@ int move_hugetlb_page_tables(struct vm_area_struct *vma,
 	hugetlb_vma_lock_write(vma);
 	i_mmap_lock_write(mapping);
 	for (; old_addr < old_end; old_addr += sz, new_addr += sz) {
-		src_pte = huge_pte_offset(mm, old_addr, sz);
+		src_pte = hugetlb_walk(vma, old_addr, sz);
 		if (!src_pte) {
 			old_addr |= last_addr_mask;
 			new_addr |= last_addr_mask;
@@ -5093,7 +5093,7 @@ static void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct
 	last_addr_mask = hugetlb_mask_last_page(h);
 	address = start;
 	for (; address < end; address += sz) {
-		ptep = huge_pte_offset(mm, address, sz);
+		ptep = hugetlb_walk(vma, address, sz);
 		if (!ptep) {
 			address |= last_addr_mask;
 			continue;
@@ -5406,7 +5406,7 @@ static vm_fault_t hugetlb_wp(struct mm_struct *mm, struct vm_area_struct *vma,
 			mutex_lock(&hugetlb_fault_mutex_table[hash]);
 			hugetlb_vma_lock_read(vma);
 			spin_lock(ptl);
-			ptep = huge_pte_offset(mm, haddr, huge_page_size(h));
+			ptep = hugetlb_walk(vma, haddr, huge_page_size(h));
 			if (likely(ptep &&
 				   pte_same(huge_ptep_get(ptep), pte)))
 				goto retry_avoidcopy;
@@ -5444,7 +5444,7 @@ static vm_fault_t hugetlb_wp(struct mm_struct *mm, struct vm_area_struct *vma,
 	 * before the page tables are altered
 	 */
 	spin_lock(ptl);
-	ptep = huge_pte_offset(mm, haddr, huge_page_size(h));
+	ptep = hugetlb_walk(vma, haddr, huge_page_size(h));
 	if (likely(ptep && pte_same(huge_ptep_get(ptep), pte))) {
 		/* Break COW or unshare */
 		huge_ptep_clear_flush(vma, haddr, ptep);
@@ -5841,7 +5841,7 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 	 * until finished with ptep.  This prevents huge_pmd_unshare from
 	 * being called elsewhere and making the ptep no longer valid.
 	 *
-	 * ptep could have already be assigned via huge_pte_offset.  That
+	 * ptep could have already be assigned via hugetlb_walk().  That
 	 * is OK, as huge_pte_alloc will return the same value unless
 	 * something has changed.
 	 */
@@ -6233,7 +6233,7 @@ struct page *hugetlb_follow_page_mask(struct vm_area_struct *vma,
 		return NULL;
 
 	hugetlb_vma_lock_read(vma);
-	pte = huge_pte_offset(mm, haddr, huge_page_size(h));
+	pte = hugetlb_walk(vma, haddr, huge_page_size(h));
 	if (!pte)
 		goto out_unlock;
 
@@ -6298,8 +6298,8 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
 		 *
 		 * Note that page table lock is not held when pte is null.
 		 */
-		pte = huge_pte_offset(mm, vaddr & huge_page_mask(h),
-				      huge_page_size(h));
+		pte = hugetlb_walk(vma, vaddr & huge_page_mask(h),
+				   huge_page_size(h));
 		if (pte)
 			ptl = huge_pte_lock(h, mm, pte);
 		absent = !pte || huge_pte_none(huge_ptep_get(pte));
@@ -6485,7 +6485,7 @@ unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
 	last_addr_mask = hugetlb_mask_last_page(h);
 	for (; address < end; address += psize) {
 		spinlock_t *ptl;
-		ptep = huge_pte_offset(mm, address, psize);
+		ptep = hugetlb_walk(vma, address, psize);
 		if (!ptep) {
 			address |= last_addr_mask;
 			continue;
@@ -6863,12 +6863,6 @@ void adjust_range_if_pmd_sharing_possible(struct vm_area_struct *vma,
 		*end = ALIGN(*end, PUD_SIZE);
 }
 
-static bool __vma_shareable_flags_pmd(struct vm_area_struct *vma)
-{
-	return vma->vm_flags & (VM_MAYSHARE | VM_SHARED) &&
-		vma->vm_private_data;
-}
-
 void hugetlb_vma_lock_read(struct vm_area_struct *vma)
 {
 	if (__vma_shareable_flags_pmd(vma)) {
@@ -7034,8 +7028,8 @@ pte_t *huge_pmd_share(struct mm_struct *mm, struct vm_area_struct *vma,
 
 		saddr = page_table_shareable(svma, vma, addr, idx);
 		if (saddr) {
-			spte = huge_pte_offset(svma->vm_mm, saddr,
-					       vma_mmu_pagesize(svma));
+			spte = hugetlb_walk(svma, saddr,
+					    vma_mmu_pagesize(svma));
 			if (spte) {
 				get_page(virt_to_page(spte));
 				break;
@@ -7394,7 +7388,7 @@ void hugetlb_unshare_all_pmds(struct vm_area_struct *vma)
 	hugetlb_vma_lock_write(vma);
 	i_mmap_lock_write(vma->vm_file->f_mapping);
 	for (address = start; address < end; address += PUD_SIZE) {
-		ptep = huge_pte_offset(mm, address, sz);
+		ptep = hugetlb_walk(vma, address, sz);
 		if (!ptep)
 			continue;
 		ptl = huge_pte_lock(h, mm, ptep);
diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
index f94ec78b54ff..bb782dea4b42 100644
--- a/mm/page_vma_mapped.c
+++ b/mm/page_vma_mapped.c
@@ -171,7 +171,7 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
 
 		hugetlb_vma_lock_read(vma);
 		/* when pud is not present, pte will be NULL */
-		pvmw->pte = huge_pte_offset(mm, pvmw->address, size);
+		pvmw->pte = hugetlb_walk(vma, pvmw->address, size);
 		if (!pvmw->pte) {
 			hugetlb_vma_unlock_read(vma);
 			return false;
diff --git a/mm/pagewalk.c b/mm/pagewalk.c
index d98564a7be57..cb23f8a15c13 100644
--- a/mm/pagewalk.c
+++ b/mm/pagewalk.c
@@ -305,13 +305,11 @@ static int walk_hugetlb_range(unsigned long addr, unsigned long end,
 	hugetlb_vma_lock_read(vma);
 	do {
 		next = hugetlb_entry_end(h, addr, end);
-		pte = huge_pte_offset(walk->mm, addr & hmask, sz);
-
+		pte = hugetlb_walk(vma, addr & hmask, sz);
 		if (pte)
 			err = ops->hugetlb_entry(pte, hmask, addr, next, walk);
 		else if (ops->pte_hole)
 			err = ops->pte_hole(addr, next, -1, walk);
-
 		if (err)
 			break;
 	} while (addr = next, addr != end);
-- 
2.37.3

