Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 202A164EE42
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 16:54:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231563AbiLPPyC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 10:54:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231492AbiLPPxk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 10:53:40 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57BFF6F0DB
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 07:52:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671205956;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=75WLafdrG2VCO1SJG5HZ0fON/RGaffQASLSh3g0vcGk=;
        b=LjM1O358OXmS2cPFxhybSvIwbd+v8Y9LbHlv7Ig5L6mQp+HITSzCjjCsnGjsDHyQeZjsgt
        yumqXH68rOlx/dNF4mXV/j1Jb9MVgXaUCxtzUayTvfiuGB9yCk0dY4L7wCIduL2nXwUP5M
        VdNh8DKMJqfKwrZYbSsXvLg8D2mNzLM=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-614-ha_DKkYnNfm_9vjFUe_QIQ-1; Fri, 16 Dec 2022 10:52:35 -0500
X-MC-Unique: ha_DKkYnNfm_9vjFUe_QIQ-1
Received: by mail-qt1-f200.google.com with SMTP id p20-20020ac84614000000b003a977d7a2ecso654633qtn.23
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 07:52:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=75WLafdrG2VCO1SJG5HZ0fON/RGaffQASLSh3g0vcGk=;
        b=O2jn/cmwgtK0PqvmsNcfgaJLsCRNFP1wRrHvxmQc0Ows/TngVcPcM01mLT2mV2hm7E
         JcmyaBloG32tkefTxNl0wIz2vT1VtI/EXxG584mV9Y+lzIr/9TyryxCnoBzRP4itL7y2
         hfop6Vj8HN9kLJsMiB4cQ9HceKYmJcnEav+MZ6Nnid8/+ZiIHZ8LwAp50NU6/ytXhZi7
         ImifSUPh0E4B8Bmfm7D4zZ8eXuZOFL4GMWNY/2dmWDCkmRjHRzoWnQvp25zfq3sZzI15
         bAm5XPgQqrvzQ4ThPEqveDGHjvzcLt/t+eAOTiqtzDocsDoRPpf1hMK0jmF5FLnQ8qWl
         PmZg==
X-Gm-Message-State: AFqh2kp6fNxfCt5nwC9/7IVIbj9U7WDjKWxpGDQcRbqC9uVJNuoXc45Q
        ChI1rHtQF8XqXA3kqds6nGGS4R6mxmmOLaA7EgBQqNEH8hqePLxCqn9+AC4rmoLdnVmYl63fCbX
        n3Q0/YuRdeloZWbSM4SLXc/GrCWvZxvTAaRybr+rC7+FMtPNQgon5yCTGZkXhP2fJEUQmAGw38Q
        ==
X-Received: by 2002:ac8:545a:0:b0:3a9:763b:4a6d with SMTP id d26-20020ac8545a000000b003a9763b4a6dmr2397210qtq.10.1671205953138;
        Fri, 16 Dec 2022 07:52:33 -0800 (PST)
X-Google-Smtp-Source: AMrXdXuv8NHiTHmsEqW/Az++9jPo/C9YVLUnT2LppWFbkrYlLQllWbZoKp1kPpJu4n0rC4ntRJAVZA==
X-Received: by 2002:ac8:545a:0:b0:3a9:763b:4a6d with SMTP id d26-20020ac8545a000000b003a9763b4a6dmr2397157qtq.10.1671205952717;
        Fri, 16 Dec 2022 07:52:32 -0800 (PST)
Received: from x1n.redhat.com (bras-base-aurron9127w-grc-45-70-31-26-132.dsl.bell.ca. [70.31.26.132])
        by smtp.gmail.com with ESMTPSA id s21-20020a05620a0bd500b006fa4ac86bfbsm202359qki.55.2022.12.16.07.52.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Dec 2022 07:52:32 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     David Hildenbrand <david@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Rik van Riel <riel@surriel.com>, peterx@redhat.com,
        Miaohe Lin <linmiaohe@huawei.com>,
        Jann Horn <jannh@google.com>,
        James Houghton <jthoughton@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v4 9/9] mm/hugetlb: Introduce hugetlb_walk()
Date:   Fri, 16 Dec 2022 10:52:29 -0500
Message-Id: <20221216155229.2043750-1-peterx@redhat.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221216155100.2043537-1-peterx@redhat.com>
References: <20221216155100.2043537-1-peterx@redhat.com>
MIME-Version: 1.0
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
Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 fs/hugetlbfs/inode.c    |  4 +---
 fs/userfaultfd.c        |  6 ++----
 include/linux/hugetlb.h | 37 +++++++++++++++++++++++++++++++++++++
 mm/hugetlb.c            | 31 +++++++++++++------------------
 mm/page_vma_mapped.c    |  9 ++++++---
 mm/pagewalk.c           |  4 +---
 6 files changed, 60 insertions(+), 31 deletions(-)

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
index 887e20472051..4e27ff526873 100644
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
index d755e2a7c0db..b6b10101bea7 100644
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
@@ -1229,4 +1235,35 @@ bool want_pmd_share(struct vm_area_struct *vma, unsigned long addr);
 #define flush_hugetlb_tlb_range(vma, addr, end)	flush_tlb_range(vma, addr, end)
 #endif
 
+static inline bool __vma_shareable_lock(struct vm_area_struct *vma)
+{
+	return (vma->vm_flags & VM_MAYSHARE) && vma->vm_private_data;
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
+	if (__vma_shareable_lock(vma))
+		WARN_ON_ONCE(!lockdep_is_held(&vma_lock->rw_sema) &&
+			     !lockdep_is_held(
+				 &vma->vm_file->f_mapping->i_mmap_rwsem));
+#endif
+	return huge_pte_offset(vma->vm_mm, addr, sz);
+}
+
 #endif /* _LINUX_HUGETLB_H */
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 33fe73e1e589..21dc37ff0896 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -258,11 +258,6 @@ static inline struct hugepage_subpool *subpool_vma(struct vm_area_struct *vma)
 /*
  * hugetlb vma_lock helper routines
  */
-static bool __vma_shareable_lock(struct vm_area_struct *vma)
-{
-	return vma->vm_flags & VM_MAYSHARE && vma->vm_private_data;
-}
-
 void hugetlb_vma_lock_read(struct vm_area_struct *vma)
 {
 	if (__vma_shareable_lock(vma)) {
@@ -4959,7 +4954,7 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 	} else {
 		/*
 		 * For shared mappings the vma lock must be held before
-		 * calling huge_pte_offset in the src vma. Otherwise, the
+		 * calling hugetlb_walk() in the src vma. Otherwise, the
 		 * returned ptep could go away if part of a shared pmd and
 		 * another thread calls huge_pmd_unshare.
 		 */
@@ -4969,7 +4964,7 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 	last_addr_mask = hugetlb_mask_last_page(h);
 	for (addr = src_vma->vm_start; addr < src_vma->vm_end; addr += sz) {
 		spinlock_t *src_ptl, *dst_ptl;
-		src_pte = huge_pte_offset(src, addr, sz);
+		src_pte = hugetlb_walk(src_vma, addr, sz);
 		if (!src_pte) {
 			addr |= last_addr_mask;
 			continue;
@@ -5176,7 +5171,7 @@ int move_hugetlb_page_tables(struct vm_area_struct *vma,
 	hugetlb_vma_lock_write(vma);
 	i_mmap_lock_write(mapping);
 	for (; old_addr < old_end; old_addr += sz, new_addr += sz) {
-		src_pte = huge_pte_offset(mm, old_addr, sz);
+		src_pte = hugetlb_walk(vma, old_addr, sz);
 		if (!src_pte) {
 			old_addr |= last_addr_mask;
 			new_addr |= last_addr_mask;
@@ -5239,7 +5234,7 @@ static void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct
 	last_addr_mask = hugetlb_mask_last_page(h);
 	address = start;
 	for (; address < end; address += sz) {
-		ptep = huge_pte_offset(mm, address, sz);
+		ptep = hugetlb_walk(vma, address, sz);
 		if (!ptep) {
 			address |= last_addr_mask;
 			continue;
@@ -5552,7 +5547,7 @@ static vm_fault_t hugetlb_wp(struct mm_struct *mm, struct vm_area_struct *vma,
 			mutex_lock(&hugetlb_fault_mutex_table[hash]);
 			hugetlb_vma_lock_read(vma);
 			spin_lock(ptl);
-			ptep = huge_pte_offset(mm, haddr, huge_page_size(h));
+			ptep = hugetlb_walk(vma, haddr, huge_page_size(h));
 			if (likely(ptep &&
 				   pte_same(huge_ptep_get(ptep), pte)))
 				goto retry_avoidcopy;
@@ -5590,7 +5585,7 @@ static vm_fault_t hugetlb_wp(struct mm_struct *mm, struct vm_area_struct *vma,
 	 * before the page tables are altered
 	 */
 	spin_lock(ptl);
-	ptep = huge_pte_offset(mm, haddr, huge_page_size(h));
+	ptep = hugetlb_walk(vma, haddr, huge_page_size(h));
 	if (likely(ptep && pte_same(huge_ptep_get(ptep), pte))) {
 		/* Break COW or unshare */
 		huge_ptep_clear_flush(vma, haddr, ptep);
@@ -6376,7 +6371,7 @@ struct page *hugetlb_follow_page_mask(struct vm_area_struct *vma,
 		return NULL;
 
 	hugetlb_vma_lock_read(vma);
-	pte = huge_pte_offset(mm, haddr, huge_page_size(h));
+	pte = hugetlb_walk(vma, haddr, huge_page_size(h));
 	if (!pte)
 		goto out_unlock;
 
@@ -6441,8 +6436,8 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
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
@@ -6633,7 +6628,7 @@ unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
 	last_addr_mask = hugetlb_mask_last_page(h);
 	for (; address < end; address += psize) {
 		spinlock_t *ptl;
-		ptep = huge_pte_offset(mm, address, psize);
+		ptep = hugetlb_walk(vma, address, psize);
 		if (!ptep) {
 			address |= last_addr_mask;
 			continue;
@@ -7040,8 +7035,8 @@ pte_t *huge_pmd_share(struct mm_struct *mm, struct vm_area_struct *vma,
 
 		saddr = page_table_shareable(svma, vma, addr, idx);
 		if (saddr) {
-			spte = huge_pte_offset(svma->vm_mm, saddr,
-					       vma_mmu_pagesize(svma));
+			spte = hugetlb_walk(svma, saddr,
+					    vma_mmu_pagesize(svma));
 			if (spte) {
 				get_page(virt_to_page(spte));
 				break;
@@ -7358,7 +7353,7 @@ void hugetlb_unshare_all_pmds(struct vm_area_struct *vma)
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

