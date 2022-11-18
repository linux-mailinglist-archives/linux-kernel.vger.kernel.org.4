Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D972062EACB
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 02:14:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240936AbiKRBOA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 20:14:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240932AbiKRBNc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 20:13:32 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5250985EE8
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 17:12:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668733948;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qhNG9bVlD1FFKnsASjagzPbRT3g9EE2vJHNL4cDHL60=;
        b=Ft0mOJfvUgJDpj22dC3JTFDnRnO5vixWE3HDXQSVDmh6ZseKzr1XK13bbpAA7QVCOde8Kz
        XWiPagz5ymQaFw69h98HWy8+XZvoYiz6ZuEOYjgT1bVMqrdLDblJm5PjVSUyXrVBi1DTnQ
        +kFGnl228BEvYdlxtU/s6yT0wt17PDI=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-302-jz18JnGOP6WaAuD2dmqxGQ-1; Thu, 17 Nov 2022 20:11:40 -0500
X-MC-Unique: jz18JnGOP6WaAuD2dmqxGQ-1
Received: by mail-qk1-f198.google.com with SMTP id x2-20020a05620a448200b006fa7dad5c1cso4404247qkp.10
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 17:11:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qhNG9bVlD1FFKnsASjagzPbRT3g9EE2vJHNL4cDHL60=;
        b=akAT2+jWI2rBt/NKz5uwD+rCBVI2o1F68kqVGdU/+327WhlAC0TUdmDrlkjCsKKdEI
         55EUuMm+DG3eI2XrXmn20HJtpHKIRE6yQR3kqwYHZHmxFNVItqs4loBbvMykcMjw489z
         +tnTn0R0m5SDi4zWA0UP97gZi3W73Ra46070XeBILu2FYo+ysaERkyNcAu62R6EArhY1
         t466kvL9A3keXlcRQn0x5VwEq7EsTp35OLJ3pWEWnMQPzGp0X80gCG3enqgxuYsdUyER
         5o+F+e04aOPwgbYQIhfciO1/VNRLMnYSi3Hje9KVZ598olmvv71hSoWa3/GQBkbeu0pd
         1N8Q==
X-Gm-Message-State: ANoB5pnAsxV/P22WzuIKnBFDkqW9EFvLcKACFN5b3sJIjDh7CR8uppQX
        Pv94s83xF4QOjs7YHnv6nyhJzQPtN9oO1BmitvD8CEgf8bwvaWWlHOds/SgLGqtCwRZbPEDKP16
        lMUZwStJokTw1dp9p2Bx74pU9NknsJqEEFfTI8riLETVtXNnEB/l+14jXPRdgbspO6Y+m2JvP2Q
        ==
X-Received: by 2002:a05:620a:1345:b0:6f8:cdc2:b7a2 with SMTP id c5-20020a05620a134500b006f8cdc2b7a2mr4025145qkl.132.1668733897307;
        Thu, 17 Nov 2022 17:11:37 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4uP5nsobxUnrOU2Lysw6mCLTzR3h7mZxUqm52XhJt+bnVXiO5fslhFD3Bo224uvm+vlLV2vg==
X-Received: by 2002:a05:620a:1345:b0:6f8:cdc2:b7a2 with SMTP id c5-20020a05620a134500b006f8cdc2b7a2mr4025109qkl.132.1668733896876;
        Thu, 17 Nov 2022 17:11:36 -0800 (PST)
Received: from x1n.redhat.com (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id l15-20020a05620a28cf00b006bb2cd2f6d1sm1462185qkp.127.2022.11.17.17.11.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 17:11:36 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>, peterx@redhat.com,
        Nadav Amit <nadav.amit@gmail.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        James Houghton <jthoughton@google.com>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Rik van Riel <riel@surriel.com>,
        Andrea Arcangeli <aarcange@redhat.com>
Subject: [PATCH RFC v2 12/12] mm/hugetlb: Introduce hugetlb_walk()
Date:   Thu, 17 Nov 2022 20:11:35 -0500
Message-Id: <20221118011135.2179157-1-peterx@redhat.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221118011025.2178986-1-peterx@redhat.com>
References: <20221118011025.2178986-1-peterx@redhat.com>
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
which will use huge_pte_offset() inside.  Assert on the locks so when
walking the pgtable.

Note, the vma lock assertion will be a no-op for private mappings.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 fs/hugetlbfs/inode.c    |  4 +---
 fs/userfaultfd.c        |  6 ++----
 include/linux/hugetlb.h | 13 +++++++++++++
 mm/hugetlb.c            | 28 ++++++++++++++--------------
 mm/page_vma_mapped.c    |  2 +-
 mm/pagewalk.c           |  4 +---
 6 files changed, 32 insertions(+), 25 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 265508981ba1..ed7934015290 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -390,9 +390,7 @@ static bool hugetlb_vma_maps_page(struct vm_area_struct *vma,
 	bool result = false;
 
 	hugetlb_walker_lock();
-	ptep = huge_pte_offset(vma->vm_mm, addr,
-			huge_page_size(hstate_vma(vma)));
-
+	ptep = hugetlb_walk(vma, addr, huge_page_size(hstate_vma(vma)));
 	if (!ptep)
 		goto out;
 
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
index 8f85ad0d5bdb..e75b1ffb93a5 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -1296,4 +1296,17 @@ bool want_pmd_share(struct vm_area_struct *vma, unsigned long addr);
 #define flush_hugetlb_tlb_range(vma, addr, end)	flush_tlb_range(vma, addr, end)
 #endif
 
+/*
+ * Safe version of huge_pte_offset() to check the locks.  See comments
+ * above huge_pte_offset().
+ */
+static inline pte_t *
+hugetlb_walk(struct vm_area_struct *vma, unsigned long addr, unsigned long sz)
+{
+	if (!hugetlb_walker_locked())
+		hugetlb_vma_assert_locked(vma);
+
+	return huge_pte_offset(vma->vm_mm, addr, sz);
+}
+
 #endif /* _LINUX_HUGETLB_H */
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index e81af6a46c59..6c77ae7a3d94 100644
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
@@ -5839,7 +5839,7 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 	 * until finished with ptep.  This prevents huge_pmd_unshare from
 	 * being called elsewhere and making the ptep no longer valid.
 	 *
-	 * ptep could have already be assigned via huge_pte_offset.  That
+	 * ptep could have already be assigned via hugetlb_walk().  That
 	 * is OK, as huge_pte_alloc will return the same value unless
 	 * something has changed.
 	 */
@@ -6223,7 +6223,7 @@ struct page *hugetlb_follow_page_mask(struct vm_area_struct *vma,
 		return NULL;
 
 	hugetlb_walker_lock();
-	pte = huge_pte_offset(mm, haddr, huge_page_size(h));
+	pte = hugetlb_walk(vma, haddr, huge_page_size(h));
 	if (!pte)
 		goto out_unlock;
 
@@ -6288,8 +6288,8 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
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
@@ -6481,7 +6481,7 @@ unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
 	last_addr_mask = hugetlb_mask_last_page(h);
 	for (; address < end; address += psize) {
 		spinlock_t *ptl;
-		ptep = huge_pte_offset(mm, address, psize);
+		ptep = hugetlb_walk(vma, address, psize);
 		if (!ptep) {
 			address |= last_addr_mask;
 			continue;
@@ -7037,8 +7037,8 @@ pte_t *huge_pmd_share(struct mm_struct *mm, struct vm_area_struct *vma,
 
 		saddr = page_table_shareable(svma, vma, addr, idx);
 		if (saddr) {
-			spte = huge_pte_offset(svma->vm_mm, saddr,
-					       vma_mmu_pagesize(svma));
+			spte = hugetlb_walk(svma, saddr,
+					    vma_mmu_pagesize(svma));
 			/*
 			 * When page ref==0, it means it's probably being
 			 * freed; continue with the next one.
@@ -7400,7 +7400,7 @@ void hugetlb_unshare_all_pmds(struct vm_area_struct *vma)
 	hugetlb_vma_lock_write(vma);
 	i_mmap_lock_write(vma->vm_file->f_mapping);
 	for (address = start; address < end; address += PUD_SIZE) {
-		ptep = huge_pte_offset(mm, address, sz);
+		ptep = hugetlb_walk(vma, address, sz);
 		if (!ptep)
 			continue;
 		ptl = huge_pte_lock(h, mm, ptep);
diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
index 5ac8a89130f6..72d72cd73c8f 100644
--- a/mm/page_vma_mapped.c
+++ b/mm/page_vma_mapped.c
@@ -171,7 +171,7 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
 
 		hugetlb_walker_lock();
 		/* when pud is not present, pte will be NULL */
-		pvmw->pte = huge_pte_offset(mm, pvmw->address, size);
+		pvmw->pte = hugetlb_walk(vma, pvmw->address, size);
 		if (!pvmw->pte) {
 			hugetlb_walker_unlock();
 			return false;
diff --git a/mm/pagewalk.c b/mm/pagewalk.c
index abf310011ab1..469e60b1b096 100644
--- a/mm/pagewalk.c
+++ b/mm/pagewalk.c
@@ -305,13 +305,11 @@ static int walk_hugetlb_range(unsigned long addr, unsigned long end,
 	hugetlb_walker_lock();
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

