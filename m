Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB59F65E8EA
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 11:22:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232987AbjAEKWm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 05:22:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232762AbjAEKU6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 05:20:58 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FA7F574D9
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 02:19:42 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id n203-20020a2572d4000000b0078f09db9888so19455387ybc.18
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 02:19:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zyj8WI6ZHUfTa3QEH+sjYLC8OtvTBOvuUTYLgK/H6sg=;
        b=Rbxv9WG514G9oOVs5vgQcTsbBy3/SRiOX3mNrNz29MS2bMXWY98la+rMNn2ajtmuKI
         RbKhJIhFROdY9YOERK0qYGEoiyq1d3vUSlg1jaKt5uAVqninxjoRWct88Yzwuxfk19z2
         tsUY9QbBNmp7uiYlaf1LkNsrVrEC6ImgJHVLpEkO0iklvaW4mvdOLPz/4kUNPie65iNB
         gl7E3ZTK1v0Ya7fJYqs1A2YDxwbzwmY0HhaZ2uNEUltjjPJr2t9Ft0HjMgP5+BWI5luR
         489kqIQR2WzL51HSVEyA0vbDsaZePxEYeKfvbmKR0o+veu6LHZWmA2Yg2sQObvWtPROx
         y3mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zyj8WI6ZHUfTa3QEH+sjYLC8OtvTBOvuUTYLgK/H6sg=;
        b=3c3fIKX7NKD7RrLkj4LYLTQ85HEQGZBFVrUsaWrl72eX3+amvDTOeSVc2OIayGIrgL
         qMcdytUUXGIA+gz/U6cdLEiIv5fk0t4ZdZFG7WouFnqZcj18nfPC02wv3TOemYRMdRqb
         w4I5C6Ctj436fX4FPe6WOl/8SvQPcERvDbyly/W7MD7OXcr06GVu/Lvp/5WrPG1Sye3q
         wY+L4MUIBqFY5hkdzW704Ph0bjnc/FI/rm9/O1u67vncDM9wmWOos5ifkuuXL+navToh
         hApC4t5ysQfE3oyuVr7LrTRgrq4So2tiFoI1xqR1ddxHG6pjPCDl64OCiq7BBtnZ0dwy
         rmzg==
X-Gm-Message-State: AFqh2kouYsW5gwSiWjtQ7I6b/K8p2xNCXSmp1pSwTunEDIV9FJSkiohz
        +gA2Yi0mRo+wovZEFvFqlYXN/dkVKoYlpL8x
X-Google-Smtp-Source: AMrXdXsRJbSwW4QWtQHu6pc4k3ao5KfbaAEwR/zMMboHR+fKxB3gjjRDTHBpf0yob6aSNifFRjM0nZxDtdvHrdPj
X-Received: from jthoughton.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:2a4f])
 (user=jthoughton job=sendgmr) by 2002:a25:3745:0:b0:75b:b01c:6a2c with SMTP
 id e66-20020a253745000000b0075bb01c6a2cmr5617998yba.166.1672913982057; Thu,
 05 Jan 2023 02:19:42 -0800 (PST)
Date:   Thu,  5 Jan 2023 10:18:31 +0000
In-Reply-To: <20230105101844.1893104-1-jthoughton@google.com>
Mime-Version: 1.0
References: <20230105101844.1893104-1-jthoughton@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20230105101844.1893104-34-jthoughton@google.com>
Subject: [PATCH 33/46] hugetlb: userfaultfd: add support for high-granularity UFFDIO_CONTINUE
From:   James Houghton <jthoughton@google.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Peter Xu <peterx@redhat.com>
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
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
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
---
 fs/userfaultfd.c        | 14 +++----
 include/linux/hugetlb.h | 18 ++++++++-
 mm/hugetlb.c            | 85 +++++++++++++++++++++++++++++++++--------
 mm/userfaultfd.c        | 40 +++++++++++--------
 4 files changed, 119 insertions(+), 38 deletions(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 15a5bf765d43..940ff63096a9 100644
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
index 8a664a9dd0a8..c8524ac49b24 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -224,7 +224,8 @@ unsigned long hugetlb_total_pages(void);
 vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 			unsigned long address, unsigned int flags);
 #ifdef CONFIG_USERFAULTFD
-int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm, pte_t *dst_pte,
+int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
+				struct hugetlb_pte *dst_hpte,
 				struct vm_area_struct *dst_vma,
 				unsigned long dst_addr,
 				unsigned long src_addr,
@@ -1292,16 +1293,31 @@ static inline enum hugetlb_level hpage_size_to_level(unsigned long sz)
 
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
index 1eef6968b1fa..5af6db52f34e 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5936,6 +5936,13 @@ static inline vm_fault_t hugetlb_handle_userfault(struct vm_area_struct *vma,
 						  unsigned long addr,
 						  unsigned long reason)
 {
+	/*
+	 * Don't use the hpage-aligned address if the user has explicitly
+	 * enabled HGM.
+	 */
+	if (hugetlb_hgm_advised(vma) && reason == VM_UFFD_MINOR)
+		haddr = address & PAGE_MASK;
+
 	u32 hash;
 	struct vm_fault vmf = {
 		.vma = vma,
@@ -6420,7 +6427,7 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
  * modifications for huge pages.
  */
 int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
-			    pte_t *dst_pte,
+			    struct hugetlb_pte *dst_hpte,
 			    struct vm_area_struct *dst_vma,
 			    unsigned long dst_addr,
 			    unsigned long src_addr,
@@ -6431,13 +6438,14 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
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
-	struct page *page;
+	struct page *page, *subpage;
 	int writable;
 	bool page_in_pagecache = false;
 
@@ -6452,12 +6460,12 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
 		 * a non-missing case. Return -EEXIST.
 		 */
 		if (vm_shared &&
-		    hugetlbfs_pagecache_present(h, dst_vma, dst_addr)) {
+		    hugetlbfs_pagecache_present(h, dst_vma, haddr)) {
 			ret = -EEXIST;
 			goto out;
 		}
 
-		page = alloc_huge_page(dst_vma, dst_addr, 0);
+		page = alloc_huge_page(dst_vma, haddr, 0);
 		if (IS_ERR(page)) {
 			ret = -ENOMEM;
 			goto out;
@@ -6473,13 +6481,13 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
 			/* Free the allocated page which may have
 			 * consumed a reservation.
 			 */
-			restore_reserve_on_error(h, dst_vma, dst_addr, page);
+			restore_reserve_on_error(h, dst_vma, haddr, page);
 			put_page(page);
 
 			/* Allocate a temporary page to hold the copied
 			 * contents.
 			 */
-			page = alloc_huge_page_vma(h, dst_vma, dst_addr);
+			page = alloc_huge_page_vma(h, dst_vma, haddr);
 			if (!page) {
 				ret = -ENOMEM;
 				goto out;
@@ -6493,14 +6501,14 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
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
 
-		page = alloc_huge_page(dst_vma, dst_addr, 0);
+		page = alloc_huge_page(dst_vma, haddr, 0);
 		if (IS_ERR(page)) {
 			put_page(*pagep);
 			ret = -ENOMEM;
@@ -6548,7 +6556,7 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
 		page_in_pagecache = true;
 	}
 
-	ptl = huge_pte_lock(h, dst_mm, dst_pte);
+	ptl = hugetlb_pte_lock(dst_hpte);
 
 	ret = -EIO;
 	if (PageHWPoison(page))
@@ -6560,7 +6568,7 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
 	 * page backing it, then access the page.
 	 */
 	ret = -EEXIST;
-	if (!huge_pte_none_mostly(huge_ptep_get(dst_pte)))
+	if (!huge_pte_none_mostly(huge_ptep_get(dst_hpte->ptep)))
 		goto out_release_unlock;
 
 	if (page_in_pagecache)
@@ -6577,7 +6585,10 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
 	else
 		writable = dst_vma->vm_flags & VM_WRITE;
 
-	_dst_pte = make_huge_pte(dst_vma, page, writable);
+	subpage = hugetlb_find_subpage(h, page, dst_addr);
+
+	_dst_pte = make_huge_pte_with_shift(dst_vma, subpage, writable,
+			dst_hpte->shift);
 	/*
 	 * Always mark UFFDIO_COPY page dirty; note that this may not be
 	 * extremely important for hugetlbfs for now since swapping is not
@@ -6590,12 +6601,12 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
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
@@ -7780,6 +7791,18 @@ bool hugetlb_hgm_enabled(struct vm_area_struct *vma)
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
@@ -7798,6 +7821,38 @@ static unsigned int __shift_for_hstate(struct hstate *h)
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
index 65ad172add27..2b233d31be24 100644
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
2.39.0.314.g84b9a713c41-goog

