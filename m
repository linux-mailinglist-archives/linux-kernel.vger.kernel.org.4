Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D6BF64626D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 21:33:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbiLGUdh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 15:33:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbiLGUdQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 15:33:16 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CEA87E406
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 12:32:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670445120;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DOnWN4xjgNQJFSPMI7LR+EFJPU3TVyZrxc0oybMi1t4=;
        b=AQrYTfs8CzDBc6GXHjm4jOc0Lv5I5xFiBUgNgDIqyIKUs5Uwlyw2xJ2hq5OWt0rdQseaU5
        qLlqyUNB0cxi+Zarpn+ybQkVrFe4MAw7qyrvMsr0HWQz8wxc2KMHFXGPTepfVQLX/bT5ui
        97VgkrGgADB3fM2pEBCOOmPE+BTc7nI=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-3-SD7aH9C_NQelOocEH2WD1w-1; Wed, 07 Dec 2022 15:31:59 -0500
X-MC-Unique: SD7aH9C_NQelOocEH2WD1w-1
Received: by mail-qt1-f197.google.com with SMTP id cd6-20020a05622a418600b003a54cb17ad9so38675084qtb.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Dec 2022 12:31:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DOnWN4xjgNQJFSPMI7LR+EFJPU3TVyZrxc0oybMi1t4=;
        b=nmYPx2itvtyCZndz2EoysCMLKeUanBcxWdIksdXXkXVZz7TyjHpUsgXHNoYQ0b71Xp
         xsaZg0oWw8c8bYHlwlq14PabqFMxuJUiTat+nIgPEJHonTi8IzTDrML3H9lBk3G4InhR
         aZI4MxG5MoqMlVn39c9jRLCQiXbI6/oCGlHlUO5RBkDFR3mZ6HqtmL4Yw85SlSY1Oy1v
         ZKusQT74wTftO7lCR8WcY+xbYGwb9sJdu4XQUKFYmsbmtX1pCOcaubPds1Q+LQ5l2+IG
         3i6mpPGSgnFsCvvfEG+3pdnYGYV/izBAJtB9E+alkhKnxImLO/1IMWIebCfvwVrrnpij
         MqAg==
X-Gm-Message-State: ANoB5pkB83OWqoxj/RSCTYtdzeSA9byw1Ug8tfeeOo+sDRR1S9I1G8eA
        MDMaPLdXJBjABDb/GNI04SLMBExjraIpl4KqfR1EJQY73f+7FcvohjUqoeHo+/8LQjc5ZEAs56P
        JDxvAwo068tiU/6DEmlB0Krge
X-Received: by 2002:ac8:7112:0:b0:3a6:88c8:2c36 with SMTP id z18-20020ac87112000000b003a688c82c36mr1643149qto.49.1670445118804;
        Wed, 07 Dec 2022 12:31:58 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7SKKVjMc7L3Uy3ewffwC9JgUfvzhyXrbwHzt/3mnovhEfXvkyWEB/JDyZxPGC4rLCS8j2F8A==
X-Received: by 2002:ac8:7112:0:b0:3a6:88c8:2c36 with SMTP id z18-20020ac87112000000b003a688c82c36mr1643131qto.49.1670445118505;
        Wed, 07 Dec 2022 12:31:58 -0800 (PST)
Received: from x1n.redhat.com (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id u17-20020a05620a455100b006fa22f0494bsm17916710qkp.117.2022.12.07.12.31.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 12:31:58 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Jann Horn <jannh@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>, peterx@redhat.com,
        James Houghton <jthoughton@google.com>,
        Rik van Riel <riel@surriel.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v2 09/10] mm/hugetlb: Introduce hugetlb_walk()
Date:   Wed,  7 Dec 2022 15:31:56 -0500
Message-Id: <20221207203156.651077-1-peterx@redhat.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221207203034.650899-1-peterx@redhat.com>
References: <20221207203034.650899-1-peterx@redhat.com>
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
 include/linux/hugetlb.h | 39 +++++++++++++++++++++++++++++++++++++++
 mm/hugetlb.c            | 32 +++++++++++++-------------------
 mm/page_vma_mapped.c    |  2 +-
 mm/pagewalk.c           |  4 +---
 6 files changed, 57 insertions(+), 30 deletions(-)

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
index 81efd9b9baa2..1c20cbbf3d22 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -2,6 +2,7 @@
 #ifndef _LINUX_HUGETLB_H
 #define _LINUX_HUGETLB_H
 
+#include <linux/mm.h>
 #include <linux/mm_types.h>
 #include <linux/mmdebug.h>
 #include <linux/fs.h>
@@ -196,6 +197,11 @@ pte_t *huge_pte_alloc(struct mm_struct *mm, struct vm_area_struct *vma,
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
@@ -1229,4 +1235,37 @@ bool want_pmd_share(struct vm_area_struct *vma, unsigned long addr);
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
+#if defined(CONFIG_HUGETLB_PAGE) && \
+	defined(CONFIG_ARCH_WANT_HUGE_PMD_SHARE) && defined(CONFIG_LOCKDEP)
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
index f42399522805..e3500c087893 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -4814,7 +4814,7 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 	} else {
 		/*
 		 * For shared mappings the vma lock must be held before
-		 * calling huge_pte_offset in the src vma. Otherwise, the
+		 * calling hugetlb_walk() in the src vma. Otherwise, the
 		 * returned ptep could go away if part of a shared pmd and
 		 * another thread calls huge_pmd_unshare.
 		 */
@@ -4824,7 +4824,7 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 	last_addr_mask = hugetlb_mask_last_page(h);
 	for (addr = src_vma->vm_start; addr < src_vma->vm_end; addr += sz) {
 		spinlock_t *src_ptl, *dst_ptl;
-		src_pte = huge_pte_offset(src, addr, sz);
+		src_pte = hugetlb_walk(src_vma, addr, sz);
 		if (!src_pte) {
 			addr |= last_addr_mask;
 			continue;
@@ -5028,7 +5028,7 @@ int move_hugetlb_page_tables(struct vm_area_struct *vma,
 	hugetlb_vma_lock_write(vma);
 	i_mmap_lock_write(mapping);
 	for (; old_addr < old_end; old_addr += sz, new_addr += sz) {
-		src_pte = huge_pte_offset(mm, old_addr, sz);
+		src_pte = hugetlb_walk(vma, old_addr, sz);
 		if (!src_pte) {
 			old_addr |= last_addr_mask;
 			new_addr |= last_addr_mask;
@@ -5091,7 +5091,7 @@ static void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct
 	last_addr_mask = hugetlb_mask_last_page(h);
 	address = start;
 	for (; address < end; address += sz) {
-		ptep = huge_pte_offset(mm, address, sz);
+		ptep = hugetlb_walk(vma, address, sz);
 		if (!ptep) {
 			address |= last_addr_mask;
 			continue;
@@ -5404,7 +5404,7 @@ static vm_fault_t hugetlb_wp(struct mm_struct *mm, struct vm_area_struct *vma,
 			mutex_lock(&hugetlb_fault_mutex_table[hash]);
 			hugetlb_vma_lock_read(vma);
 			spin_lock(ptl);
-			ptep = huge_pte_offset(mm, haddr, huge_page_size(h));
+			ptep = hugetlb_walk(vma, haddr, huge_page_size(h));
 			if (likely(ptep &&
 				   pte_same(huge_ptep_get(ptep), pte)))
 				goto retry_avoidcopy;
@@ -5442,7 +5442,7 @@ static vm_fault_t hugetlb_wp(struct mm_struct *mm, struct vm_area_struct *vma,
 	 * before the page tables are altered
 	 */
 	spin_lock(ptl);
-	ptep = huge_pte_offset(mm, haddr, huge_page_size(h));
+	ptep = hugetlb_walk(vma, haddr, huge_page_size(h));
 	if (likely(ptep && pte_same(huge_ptep_get(ptep), pte))) {
 		/* Break COW or unshare */
 		huge_ptep_clear_flush(vma, haddr, ptep);
@@ -6227,7 +6227,7 @@ struct page *hugetlb_follow_page_mask(struct vm_area_struct *vma,
 		return NULL;
 
 	hugetlb_vma_lock_read(vma);
-	pte = huge_pte_offset(mm, haddr, huge_page_size(h));
+	pte = hugetlb_walk(vma, haddr, huge_page_size(h));
 	if (!pte)
 		goto out_unlock;
 
@@ -6292,8 +6292,8 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
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
@@ -6479,7 +6479,7 @@ unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
 	last_addr_mask = hugetlb_mask_last_page(h);
 	for (; address < end; address += psize) {
 		spinlock_t *ptl;
-		ptep = huge_pte_offset(mm, address, psize);
+		ptep = hugetlb_walk(vma, address, psize);
 		if (!ptep) {
 			address |= last_addr_mask;
 			continue;
@@ -6857,12 +6857,6 @@ void adjust_range_if_pmd_sharing_possible(struct vm_area_struct *vma,
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
@@ -7028,8 +7022,8 @@ pte_t *huge_pmd_share(struct mm_struct *mm, struct vm_area_struct *vma,
 
 		saddr = page_table_shareable(svma, vma, addr, idx);
 		if (saddr) {
-			spte = huge_pte_offset(svma->vm_mm, saddr,
-					       vma_mmu_pagesize(svma));
+			spte = hugetlb_walk(svma, saddr,
+					    vma_mmu_pagesize(svma));
 			if (spte) {
 				get_page(virt_to_page(spte));
 				break;
@@ -7387,7 +7381,7 @@ void hugetlb_unshare_all_pmds(struct vm_area_struct *vma)
 	hugetlb_vma_lock_write(vma);
 	i_mmap_lock_write(vma->vm_file->f_mapping);
 	for (address = start; address < end; address += PUD_SIZE) {
-		ptep = huge_pte_offset(mm, address, sz);
+		ptep = hugetlb_walk(vma, address, sz);
 		if (!ptep)
 			continue;
 		ptl = huge_pte_lock(h, mm, ptep);
diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
index 93e13fc17d3c..e97b2e23bd28 100644
--- a/mm/page_vma_mapped.c
+++ b/mm/page_vma_mapped.c
@@ -170,7 +170,7 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
 			return not_found(pvmw);
 
 		/* when pud is not present, pte will be NULL */
-		pvmw->pte = huge_pte_offset(mm, pvmw->address, size);
+		pvmw->pte = hugetlb_walk(vma, pvmw->address, size);
 		if (!pvmw->pte)
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

