Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B93769B6CC
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 01:31:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230235AbjBRAav (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 19:30:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229902AbjBRA3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 19:29:55 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35B7F68ADE
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 16:29:17 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5365a2b9e4fso19060707b3.15
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 16:29:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wrKlKZ6ZakLkTbIJ1oX0i57iaJAjsrq7KWEmG7MzQmY=;
        b=mCbQikAQ3LLbb2MaLcCfnhff3PiBABnQwSQf9LWl30IUncwsLCnlc7QcDea1N/QLsC
         vfw0K2950rSrhIHrRGtEn7vPNXstlIlDJme+x9X1Tl4rCeL5TE1nmFxc78IZG7kUcuGZ
         gWnC/qKD/qWIT+WrgA2/XtwBBmqj4uwswcowjU0CsCy/gmEKNQpD5PEKpeYu26k0gax4
         wFF1AM3BcKLwDBazsiY337gPGCphNPaNpVDV9c2Psll+/miIIyYrv4fm4pZwi/PDcjtw
         80annwRMmYnG6AnPnD+aevt1DhBv/jq/mj8pS2S8t5MLt/H13U85E5EeFDuqgEKiranZ
         zR4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wrKlKZ6ZakLkTbIJ1oX0i57iaJAjsrq7KWEmG7MzQmY=;
        b=BQqYQjQYsrYR78XhUJM+9WcpXXlCwoHZ50K+ougp4+iO7ha8WvWPNVv5w4zDwTI4GX
         f2k6+AXF9xNvVYrp1QEINkQruQB7RB9ZrVw1hCbOSO0fdKQGGuq6w1TM8rDn1aCXcB+Y
         Ke9/5igPuLCGgiQ0TkglXehG4UP2qMcd33zRk+7DvLYcAiSKcxE/JLUDToJ+DdyTxGbx
         w/0V6aI3wbwwaHvMv9/1EoJmK0F0oNDxzD/UsvR/PLqVReMjskrJ3w119uxXgvqHhbrN
         8JIahQYps8AoNxwoWjNP22Xypa7LHwA613sZMN2zf59APYJsEVPGjn1SvqH+fp8DhbDj
         4kZg==
X-Gm-Message-State: AO0yUKWB+7ampr/f/F5D+bl/cwBQdBYcpgf7v2zNyko/ksXmuWxrnkxS
        8AUSjiJohdhImxNzdGwFQvS/LaguEviyiPug
X-Google-Smtp-Source: AK7set/ChT8w1lRpdLXETNdy5AqAngOnJfnNB3h58M/w44KB78rgBAvvKVVzRYFSwR4a8k+Uo0NqEoJrPiNJtx6Y
X-Received: from jthoughton.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:2a4f])
 (user=jthoughton job=sendgmr) by 2002:a05:6902:1024:b0:8fc:686c:cf87 with
 SMTP id x4-20020a056902102400b008fc686ccf87mr53605ybt.4.1676680156885; Fri,
 17 Feb 2023 16:29:16 -0800 (PST)
Date:   Sat, 18 Feb 2023 00:28:06 +0000
In-Reply-To: <20230218002819.1486479-1-jthoughton@google.com>
Mime-Version: 1.0
References: <20230218002819.1486479-1-jthoughton@google.com>
X-Mailer: git-send-email 2.39.2.637.g21b0678d19-goog
Message-ID: <20230218002819.1486479-34-jthoughton@google.com>
Subject: [PATCH v2 33/46] hugetlb: userfaultfd: add support for
 high-granularity UFFDIO_CONTINUE
From:   James Houghton <jthoughton@google.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Peter Xu <peterx@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mina Almasry <almasrymina@google.com>,
        "Zach O'Keefe" <zokeefe@google.com>,
        Manish Mishra <manish.mishra@nutanix.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Yang Shi <shy828301@gmail.com>,
        Frank van der Linden <fvdl@google.com>,
        Jiaqi Yan <jiaqiyan@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        James Houghton <jthoughton@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes here are similar to the changes made for hugetlb_no_page.

Pass vmf->real_address to userfaultfd_huge_must_wait because
vmf->address may be rounded down to the hugepage size, and a
high-granularity page table walk would look up the wrong PTE. Also
change the call to userfaultfd_must_wait in the same way for
consistency.

This commit introduces hugetlb_alloc_largest_pte which is used to find
the appropriate PTE size to map pages with UFFDIO_CONTINUE.

When MADV_SPLIT is provided, page fault events will report
PAGE_SIZE-aligned address instead of huge_page_size(h)-aligned
addresses, regardless of if UFFD_FEATURE_EXACT_ADDRESS is used.

Signed-off-by: James Houghton <jthoughton@google.com>

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 44d1ee429eb0..bb30001b63ba 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -252,17 +252,17 @@ static inline bool userfaultfd_huge_must_wait(struct userfaultfd_ctx *ctx,
 					 unsigned long flags,
 					 unsigned long reason)
 {
-	pte_t *ptep, pte;
+	pte_t pte;
 	bool ret = true;
+	struct hugetlb_pte hpte;
 
 	mmap_assert_locked(ctx->mm);
 
-	ptep = hugetlb_walk(vma, address, vma_mmu_pagesize(vma));
-	if (!ptep)
+	if (hugetlb_full_walk(&hpte, vma, address))
 		goto out;
 
 	ret = false;
-	pte = huge_ptep_get(ptep);
+	pte = huge_ptep_get(hpte.ptep);
 
 	/*
 	 * Lockless access: we're in a wait_event so it's ok if it
@@ -531,11 +531,11 @@ vm_fault_t handle_userfault(struct vm_fault *vmf, unsigned long reason)
 	spin_unlock_irq(&ctx->fault_pending_wqh.lock);
 
 	if (!is_vm_hugetlb_page(vma))
-		must_wait = userfaultfd_must_wait(ctx, vmf->address, vmf->flags,
-						  reason);
+		must_wait = userfaultfd_must_wait(ctx, vmf->real_address,
+						  vmf->flags, reason);
 	else
 		must_wait = userfaultfd_huge_must_wait(ctx, vma,
-						       vmf->address,
+						       vmf->real_address,
 						       vmf->flags, reason);
 	if (is_vm_hugetlb_page(vma))
 		hugetlb_vma_unlock_read(vma);
diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index a344f9d9eba1..e0e51bb06112 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -201,7 +201,8 @@ unsigned long hugetlb_total_pages(void);
 vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 			unsigned long address, unsigned int flags);
 #ifdef CONFIG_USERFAULTFD
-int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm, pte_t *dst_pte,
+int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
+				struct hugetlb_pte *dst_hpte,
 				struct vm_area_struct *dst_vma,
 				unsigned long dst_addr,
 				unsigned long src_addr,
@@ -1272,16 +1273,31 @@ static inline enum hugetlb_level hpage_size_to_level(unsigned long sz)
 
 #ifdef CONFIG_HUGETLB_HIGH_GRANULARITY_MAPPING
 bool hugetlb_hgm_enabled(struct vm_area_struct *vma);
+bool hugetlb_hgm_advised(struct vm_area_struct *vma);
 bool hugetlb_hgm_eligible(struct vm_area_struct *vma);
+int hugetlb_alloc_largest_pte(struct hugetlb_pte *hpte, struct mm_struct *mm,
+			      struct vm_area_struct *vma, unsigned long start,
+			      unsigned long end);
 #else
 static inline bool hugetlb_hgm_enabled(struct vm_area_struct *vma)
 {
 	return false;
 }
+static inline bool hugetlb_hgm_advised(struct vm_area_struct *vma)
+{
+	return false;
+}
 static inline bool hugetlb_hgm_eligible(struct vm_area_struct *vma)
 {
 	return false;
 }
+static inline
+int hugetlb_alloc_largest_pte(struct hugetlb_pte *hpte, struct mm_struct *mm,
+			      struct vm_area_struct *vma, unsigned long start,
+			      unsigned long end)
+{
+	return -EINVAL;
+}
 #endif
 
 static inline spinlock_t *huge_pte_lock(struct hstate *h,
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 667e82b7a0ff..a00b4ac07046 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -6083,9 +6083,15 @@ static inline vm_fault_t hugetlb_handle_userfault(struct vm_area_struct *vma,
 						  unsigned long reason)
 {
 	u32 hash;
+	/*
+	 * Don't use the hpage-aligned address if the user has explicitly
+	 * enabled HGM.
+	 */
+	bool round_to_pagesize = hugetlb_hgm_advised(vma) &&
+				 reason == VM_UFFD_MINOR;
 	struct vm_fault vmf = {
 		.vma = vma,
-		.address = haddr,
+		.address = round_to_pagesize ? addr & PAGE_MASK : haddr,
 		.real_address = addr,
 		.flags = flags,
 
@@ -6569,7 +6575,7 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
  * modifications for huge pages.
  */
 int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
-			    pte_t *dst_pte,
+			    struct hugetlb_pte *dst_hpte,
 			    struct vm_area_struct *dst_vma,
 			    unsigned long dst_addr,
 			    unsigned long src_addr,
@@ -6580,13 +6586,15 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
 	bool is_continue = (mode == MCOPY_ATOMIC_CONTINUE);
 	struct hstate *h = hstate_vma(dst_vma);
 	struct address_space *mapping = dst_vma->vm_file->f_mapping;
-	pgoff_t idx = vma_hugecache_offset(h, dst_vma, dst_addr);
+	unsigned long haddr = dst_addr & huge_page_mask(h);
+	pgoff_t idx = vma_hugecache_offset(h, dst_vma, haddr);
 	unsigned long size;
 	int vm_shared = dst_vma->vm_flags & VM_SHARED;
 	pte_t _dst_pte;
 	spinlock_t *ptl;
 	int ret = -ENOMEM;
 	struct folio *folio;
+	struct page *subpage;
 	int writable;
 	bool folio_in_pagecache = false;
 
@@ -6601,12 +6609,12 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
 		 * a non-missing case. Return -EEXIST.
 		 */
 		if (vm_shared &&
-		    hugetlbfs_pagecache_present(h, dst_vma, dst_addr)) {
+		    hugetlbfs_pagecache_present(h, dst_vma, haddr)) {
 			ret = -EEXIST;
 			goto out;
 		}
 
-		folio = alloc_hugetlb_folio(dst_vma, dst_addr, 0);
+		folio = alloc_hugetlb_folio(dst_vma, haddr, 0);
 		if (IS_ERR(folio)) {
 			ret = -ENOMEM;
 			goto out;
@@ -6622,13 +6630,13 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
 			/* Free the allocated folio which may have
 			 * consumed a reservation.
 			 */
-			restore_reserve_on_error(h, dst_vma, dst_addr, folio);
+			restore_reserve_on_error(h, dst_vma, haddr, folio);
 			folio_put(folio);
 
 			/* Allocate a temporary folio to hold the copied
 			 * contents.
 			 */
-			folio = alloc_hugetlb_folio_vma(h, dst_vma, dst_addr);
+			folio = alloc_hugetlb_folio_vma(h, dst_vma, haddr);
 			if (!folio) {
 				ret = -ENOMEM;
 				goto out;
@@ -6642,14 +6650,14 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
 		}
 	} else {
 		if (vm_shared &&
-		    hugetlbfs_pagecache_present(h, dst_vma, dst_addr)) {
+		    hugetlbfs_pagecache_present(h, dst_vma, haddr)) {
 			put_page(*pagep);
 			ret = -EEXIST;
 			*pagep = NULL;
 			goto out;
 		}
 
-		folio = alloc_hugetlb_folio(dst_vma, dst_addr, 0);
+		folio = alloc_hugetlb_folio(dst_vma, haddr, 0);
 		if (IS_ERR(folio)) {
 			put_page(*pagep);
 			ret = -ENOMEM;
@@ -6697,7 +6705,7 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
 		folio_in_pagecache = true;
 	}
 
-	ptl = huge_pte_lock(h, dst_mm, dst_pte);
+	ptl = hugetlb_pte_lock(dst_hpte);
 
 	ret = -EIO;
 	if (folio_test_hwpoison(folio))
@@ -6709,11 +6717,13 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
 	 * page backing it, then access the page.
 	 */
 	ret = -EEXIST;
-	if (!huge_pte_none_mostly(huge_ptep_get(dst_pte)))
+	if (!huge_pte_none_mostly(huge_ptep_get(dst_hpte->ptep)))
 		goto out_release_unlock;
 
+	subpage = hugetlb_find_subpage(h, folio, dst_addr);
+
 	if (folio_in_pagecache)
-		page_add_file_rmap(&folio->page, dst_vma, true);
+		hugetlb_add_file_rmap(subpage, dst_hpte->shift, h, dst_vma);
 	else
 		hugepage_add_new_anon_rmap(folio, dst_vma, dst_addr);
 
@@ -6726,7 +6736,8 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
 	else
 		writable = dst_vma->vm_flags & VM_WRITE;
 
-	_dst_pte = make_huge_pte(dst_vma, &folio->page, writable);
+	_dst_pte = make_huge_pte_with_shift(dst_vma, subpage, writable,
+			dst_hpte->shift);
 	/*
 	 * Always mark UFFDIO_COPY page dirty; note that this may not be
 	 * extremely important for hugetlbfs for now since swapping is not
@@ -6739,12 +6750,12 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
 	if (wp_copy)
 		_dst_pte = huge_pte_mkuffd_wp(_dst_pte);
 
-	set_huge_pte_at(dst_mm, dst_addr, dst_pte, _dst_pte);
+	set_huge_pte_at(dst_mm, dst_addr, dst_hpte->ptep, _dst_pte);
 
-	hugetlb_count_add(pages_per_huge_page(h), dst_mm);
+	hugetlb_count_add(hugetlb_pte_size(dst_hpte) / PAGE_SIZE, dst_mm);
 
 	/* No need to invalidate - it was non-present before */
-	update_mmu_cache(dst_vma, dst_addr, dst_pte);
+	update_mmu_cache(dst_vma, dst_addr, dst_hpte->ptep);
 
 	spin_unlock(ptl);
 	if (!is_continue)
@@ -7941,6 +7952,18 @@ bool hugetlb_hgm_enabled(struct vm_area_struct *vma)
 {
 	return vma && (vma->vm_flags & VM_HUGETLB_HGM);
 }
+bool hugetlb_hgm_advised(struct vm_area_struct *vma)
+{
+	/*
+	 * Right now, the only way for HGM to be enabled is if a user
+	 * explicitly enables it via MADV_SPLIT, but in the future, there
+	 * may be cases where it gets enabled automatically.
+	 *
+	 * Provide hugetlb_hgm_advised() now for call sites where care that the
+	 * user explicitly enabled HGM.
+	 */
+	return hugetlb_hgm_enabled(vma);
+}
 /* Should only be used by the for_each_hgm_shift macro. */
 static unsigned int __shift_for_hstate(struct hstate *h)
 {
@@ -7959,6 +7982,38 @@ static unsigned int __shift_for_hstate(struct hstate *h)
 			       (tmp_h) <= &hstates[hugetlb_max_hstate]; \
 			       (tmp_h)++)
 
+/*
+ * Find the HugeTLB PTE that maps as much of [start, end) as possible with a
+ * single page table entry. It is returned in @hpte.
+ */
+int hugetlb_alloc_largest_pte(struct hugetlb_pte *hpte, struct mm_struct *mm,
+			      struct vm_area_struct *vma, unsigned long start,
+			      unsigned long end)
+{
+	struct hstate *h = hstate_vma(vma), *tmp_h;
+	unsigned int shift;
+	unsigned long sz;
+	int ret;
+
+	for_each_hgm_shift(h, tmp_h, shift) {
+		sz = 1UL << shift;
+
+		if (!IS_ALIGNED(start, sz) || start + sz > end)
+			continue;
+		goto found;
+	}
+	return -EINVAL;
+found:
+	ret = hugetlb_full_walk_alloc(hpte, vma, start, sz);
+	if (ret)
+		return ret;
+
+	if (hpte->shift > shift)
+		return -EEXIST;
+
+	return 0;
+}
+
 #endif /* CONFIG_HUGETLB_HIGH_GRANULARITY_MAPPING */
 
 /*
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 53c3d916ff66..b56bc12f600e 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -320,14 +320,16 @@ static __always_inline ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
 {
 	int vm_shared = dst_vma->vm_flags & VM_SHARED;
 	ssize_t err;
-	pte_t *dst_pte;
 	unsigned long src_addr, dst_addr;
 	long copied;
 	struct page *page;
-	unsigned long vma_hpagesize;
+	unsigned long vma_hpagesize, target_pagesize;
 	pgoff_t idx;
 	u32 hash;
 	struct address_space *mapping;
+	bool use_hgm = hugetlb_hgm_advised(dst_vma) &&
+		mode == MCOPY_ATOMIC_CONTINUE;
+	struct hstate *h = hstate_vma(dst_vma);
 
 	/*
 	 * There is no default zero huge page for all huge page sizes as
@@ -345,12 +347,13 @@ static __always_inline ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
 	copied = 0;
 	page = NULL;
 	vma_hpagesize = vma_kernel_pagesize(dst_vma);
+	target_pagesize = use_hgm ? PAGE_SIZE : vma_hpagesize;
 
 	/*
-	 * Validate alignment based on huge page size
+	 * Validate alignment based on the targeted page size.
 	 */
 	err = -EINVAL;
-	if (dst_start & (vma_hpagesize - 1) || len & (vma_hpagesize - 1))
+	if (dst_start & (target_pagesize - 1) || len & (target_pagesize - 1))
 		goto out_unlock;
 
 retry:
@@ -381,13 +384,14 @@ static __always_inline ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
 	}
 
 	while (src_addr < src_start + len) {
+		struct hugetlb_pte hpte;
 		BUG_ON(dst_addr >= dst_start + len);
 
 		/*
 		 * Serialize via vma_lock and hugetlb_fault_mutex.
-		 * vma_lock ensures the dst_pte remains valid even
-		 * in the case of shared pmds.  fault mutex prevents
-		 * races with other faulting threads.
+		 * vma_lock ensures the hpte.ptep remains valid even
+		 * in the case of shared pmds and page table collapsing.
+		 * fault mutex prevents races with other faulting threads.
 		 */
 		idx = linear_page_index(dst_vma, dst_addr);
 		mapping = dst_vma->vm_file->f_mapping;
@@ -395,23 +399,28 @@ static __always_inline ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
 		mutex_lock(&hugetlb_fault_mutex_table[hash]);
 		hugetlb_vma_lock_read(dst_vma);
 
-		err = -ENOMEM;
-		dst_pte = huge_pte_alloc(dst_mm, dst_vma, dst_addr, vma_hpagesize);
-		if (!dst_pte) {
+		if (use_hgm)
+			err = hugetlb_alloc_largest_pte(&hpte, dst_mm, dst_vma,
+							dst_addr,
+							dst_start + len);
+		else
+			err = hugetlb_full_walk_alloc(&hpte, dst_vma, dst_addr,
+						      vma_hpagesize);
+		if (err) {
 			hugetlb_vma_unlock_read(dst_vma);
 			mutex_unlock(&hugetlb_fault_mutex_table[hash]);
 			goto out_unlock;
 		}
 
 		if (mode != MCOPY_ATOMIC_CONTINUE &&
-		    !huge_pte_none_mostly(huge_ptep_get(dst_pte))) {
+		    !huge_pte_none_mostly(huge_ptep_get(hpte.ptep))) {
 			err = -EEXIST;
 			hugetlb_vma_unlock_read(dst_vma);
 			mutex_unlock(&hugetlb_fault_mutex_table[hash]);
 			goto out_unlock;
 		}
 
-		err = hugetlb_mcopy_atomic_pte(dst_mm, dst_pte, dst_vma,
+		err = hugetlb_mcopy_atomic_pte(dst_mm, &hpte, dst_vma,
 					       dst_addr, src_addr, mode, &page,
 					       wp_copy);
 
@@ -423,6 +432,7 @@ static __always_inline ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
 		if (unlikely(err == -ENOENT)) {
 			mmap_read_unlock(dst_mm);
 			BUG_ON(!page);
+			WARN_ON_ONCE(hpte.shift != huge_page_shift(h));
 
 			err = copy_huge_page_from_user(page,
 						(const void __user *)src_addr,
@@ -440,9 +450,9 @@ static __always_inline ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
 			BUG_ON(page);
 
 		if (!err) {
-			dst_addr += vma_hpagesize;
-			src_addr += vma_hpagesize;
-			copied += vma_hpagesize;
+			dst_addr += hugetlb_pte_size(&hpte);
+			src_addr += hugetlb_pte_size(&hpte);
+			copied += hugetlb_pte_size(&hpte);
 
 			if (fatal_signal_pending(current))
 				err = -EINTR;
-- 
2.39.2.637.g21b0678d19-goog

