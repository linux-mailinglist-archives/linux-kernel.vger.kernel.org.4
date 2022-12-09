Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F877648732
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 18:03:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbiLIRDd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 12:03:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbiLIRCf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 12:02:35 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 570BE83EA3
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 09:01:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670605295;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L7MEdlvbVLjBM5+9KWX/Vi/7wZkpFuDB6TgvbozGtp8=;
        b=ALLs3XnLcXLLa8WdL4YW2EIiGGQaPCd12kHJz24J6N4jC9s0/UV9hXJKMiExIYojMxY54p
        MJnSOoIUsS0TXf6PS5F5h+t0O732BEG3AFxnY0Dlw9IJLQOKVHhK2uqBGzrIZ+SQHkcfFw
        AtiwEZWwCCIRSmDC9LZElbg9e/wic3M=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-589-VRaWzlQQNaG6vpX4V6qVAw-1; Fri, 09 Dec 2022 12:01:34 -0500
X-MC-Unique: VRaWzlQQNaG6vpX4V6qVAw-1
Received: by mail-pg1-f200.google.com with SMTP id p7-20020a631e47000000b0047691854a86so3393896pgm.16
        for <linux-kernel@vger.kernel.org>; Fri, 09 Dec 2022 09:01:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L7MEdlvbVLjBM5+9KWX/Vi/7wZkpFuDB6TgvbozGtp8=;
        b=a2a/f1Tku/pXPNCDv7upF+fZmi/wOtZHN6c0ZHwddwESwaPc7iM/7ctxlBBAmhuGfk
         LL9f40K7RaBe/5PUUnFH5f9rX8PJK6C/ukMhLNZSeLXevjr3Qk0EYjZCWsR1aEM1W65Q
         C2l8122oKNUuml1BYJgJXUw4PUo3g8dErjpGRLJA0MnoJdvwisLVEl9x4xQW6dtQTJst
         YrCee06NUCVFVT7eB+vOeAyFCDgyE95cfuVwG0J5cjVMbh+ephSWwW5t1xMJKcsNBkSn
         BrzZSXVySUijl1PtBzqnn7B6t/G4mgWJ1MOZv9DSFRHgZErgU9btrgZrlSTMfXnV4ef0
         gyGw==
X-Gm-Message-State: ANoB5pmLm3PWNoPirPGlkVByzOU1peUtIrgaiA2BMpn4wrXW8ZBP/PnB
        nh500HbL2iFBRsmYjXXT0Gm3etfkXdW2Sr97bvdVeI9CGL2p6vUYvdz9O15VimcOUjYGWh8FN3C
        rQvqcofpMHHqgGdWNIaZOApWR
X-Received: by 2002:a05:6a20:9f4a:b0:9d:efbf:6618 with SMTP id ml10-20020a056a209f4a00b0009defbf6618mr9037913pzb.38.1670605292396;
        Fri, 09 Dec 2022 09:01:32 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4691rJPo5hULuegymNELlZK/OS4Isy0pkxFdZAl/xogaBGdec9hd8nNWbKv9OTMLROMYo/pQ==
X-Received: by 2002:a05:6a20:9f4a:b0:9d:efbf:6618 with SMTP id ml10-20020a056a209f4a00b0009defbf6618mr9037889pzb.38.1670605292058;
        Fri, 09 Dec 2022 09:01:32 -0800 (PST)
Received: from x1n.redhat.com (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id q7-20020a05620a0d8700b006cf38fd659asm178907qkl.103.2022.12.09.09.01.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Dec 2022 09:01:30 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Hildenbrand <david@redhat.com>,
        Nadav Amit <nadav.amit@gmail.com>, peterx@redhat.com,
        Andrea Arcangeli <aarcange@redhat.com>,
        Jann Horn <jannh@google.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        James Houghton <jthoughton@google.com>,
        Rik van Riel <riel@surriel.com>,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v3 9/9] mm/hugetlb: Introduce hugetlb_walk()
Date:   Fri,  9 Dec 2022 12:01:00 -0500
Message-Id: <20221209170100.973970-10-peterx@redhat.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221209170100.973970-1-peterx@redhat.com>
References: <20221209170100.973970-1-peterx@redhat.com>
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

Document the last special case in the page_vma_mapped_walk() path where we
don't need any more lock to call hugetlb_walk().

Taking vma lock there is not needed because either: (1) potential callers
of hugetlb pvmw holds i_mmap_rwsem already (from one rmap_walk()), or (2)
the caller will not walk a hugetlb vma at all so the hugetlb code path not
reachable (e.g. in ksm or uprobe paths).

It's slightly implicit for future page_vma_mapped_walk() callers on that
lock requirement.  But anyway, when one day this rule breaks, one will get
a straightforward warning in hugetlb_walk() with lockdep, then there'll be
a way out.

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 fs/hugetlbfs/inode.c    |  4 +---
 fs/userfaultfd.c        |  6 ++----
 include/linux/hugetlb.h | 39 +++++++++++++++++++++++++++++++++++++++
 mm/hugetlb.c            | 32 +++++++++++++-------------------
 mm/page_vma_mapped.c    |  9 ++++++---
 mm/pagewalk.c           |  4 +---
 6 files changed, 62 insertions(+), 32 deletions(-)

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
index 969f4be967c6..6a278941ec84 100644
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
index d755e2a7c0db..a5e87ec7fa6e 100644
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
+ * this is only a common interface to implement arch-specific
+ * walker. Please use hugetlb_walk() instead, because that will attempt to
+ * verify the locking for you.
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
index 9d8bb6508288..b20120d14a71 100644
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
@@ -6228,7 +6228,7 @@ struct page *hugetlb_follow_page_mask(struct vm_area_struct *vma,
 		return NULL;
 
 	hugetlb_vma_lock_read(vma);
-	pte = huge_pte_offset(mm, haddr, huge_page_size(h));
+	pte = hugetlb_walk(vma, haddr, huge_page_size(h));
 	if (!pte)
 		goto out_unlock;
 
@@ -6293,8 +6293,8 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
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
@@ -6480,7 +6480,7 @@ unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
 	last_addr_mask = hugetlb_mask_last_page(h);
 	for (; address < end; address += psize) {
 		spinlock_t *ptl;
-		ptep = huge_pte_offset(mm, address, psize);
+		ptep = hugetlb_walk(vma, address, psize);
 		if (!ptep) {
 			address |= last_addr_mask;
 			continue;
@@ -6858,12 +6858,6 @@ void adjust_range_if_pmd_sharing_possible(struct vm_area_struct *vma,
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
@@ -7029,8 +7023,8 @@ pte_t *huge_pmd_share(struct mm_struct *mm, struct vm_area_struct *vma,
 
 		saddr = page_table_shareable(svma, vma, addr, idx);
 		if (saddr) {
-			spte = huge_pte_offset(svma->vm_mm, saddr,
-					       vma_mmu_pagesize(svma));
+			spte = hugetlb_walk(svma, saddr,
+					    vma_mmu_pagesize(svma));
 			if (spte) {
 				get_page(virt_to_page(spte));
 				break;
@@ -7388,7 +7382,7 @@ void hugetlb_unshare_all_pmds(struct vm_area_struct *vma)
 	hugetlb_vma_lock_write(vma);
 	i_mmap_lock_write(vma->vm_file->f_mapping);
 	for (address = start; address < end; address += PUD_SIZE) {
-		ptep = huge_pte_offset(mm, address, sz);
+		ptep = hugetlb_walk(vma, address, sz);
 		if (!ptep)
 			continue;
 		ptl = huge_pte_lock(h, mm, ptep);
diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
index 93e13fc17d3c..f3729b23dd0e 100644
--- a/mm/page_vma_mapped.c
+++ b/mm/page_vma_mapped.c
@@ -168,9 +168,12 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
 		/* The only possible mapping was handled on last iteration */
 		if (pvmw->pte)
 			return not_found(pvmw);
-
-		/* when pud is not present, pte will be NULL */
-		pvmw->pte = huge_pte_offset(mm, pvmw->address, size);
+		/*
+                 * All callers that get here will already hold the
+                 * i_mmap_rwsem.  Therefore, no additional locks need to be
+                 * taken before calling hugetlb_walk().
+		 */
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

