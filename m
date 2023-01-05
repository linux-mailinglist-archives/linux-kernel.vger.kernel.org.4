Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A559965E8D2
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 11:20:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232690AbjAEKUd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 05:20:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232593AbjAEKTl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 05:19:41 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 139E65370E
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 02:19:14 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-46a518991cfso343225017b3.18
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 02:19:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2Vt58mLGL5M8YpW+S8eBdfZehWuEGnsVXCCJx2houLg=;
        b=FAFveYt9nBF0eFfaA1d0Tv7HE5xVwqFCRHNy2MmHG8kjRiH1IJ9npxQOlM0OPPr9x0
         SOVsSNTwUscRwlguA9nGCrhEAEgibLkiSxGoSBRrXyiTEZUYuMRPxRxyfuuinve75ZiS
         b63qtgYDL7WfBK69glJ4RMOKf3QPMUJGqEe/PQ3lN23K5qmqgGr6+syabeOfq80mm59A
         aqLVtsA1nxHBiLCtySePm+DxyeSOS0NdLf5oXMQa6tQk1Fla5YNZga5tHOyH+tx+EP0G
         l5qkwogI70U832FjytD4NOveDXyTFLX+2z3zmQ8We0Ne3ob7c9NV3FWN7gNIpfjzemkn
         +pgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2Vt58mLGL5M8YpW+S8eBdfZehWuEGnsVXCCJx2houLg=;
        b=RbTxKHXcaR4KsLG/UlBMSD1IvXWZPuw9vH3YeKKo4S8oT0bpnkHVLw4zwR65e/umFl
         fKVj4u8xxpM41+Xobx/s3mbvevR4LLKOst8lgW4tkF1ORW4BeKB7NmvFd9FvLrDawNRQ
         VTSrLYY5lk4oQm9cdfuxVpeFaT7sYrqTelg9ByccMP+u3nnNSp3oeEchCmKa2vhdJM0T
         0ogN18xQ/UQJuwmRtNBZmshvyVL+Zg3wvuMPkwVeD1riHEkAwuiA8rMSgUC7X9s9v1Vp
         7T6AuUWe0K5IRiK4YQvD680JFCa4fF+2/sF0vNXWp3BWNidQj7vNAZpBDIXxsMEIW9pw
         MmcQ==
X-Gm-Message-State: AFqh2kqLJI81xvtUGVH4tl+LvyhQiftrGsrM/3cxerNXKSh6C/Gf6t7M
        qoywMzKBsKO7NkUxzPDOeHFfC1NX3VGvV8wf
X-Google-Smtp-Source: AMrXdXsG407xQfqrIOR0gOSXoyOo4VMzkb16AaBSb+fslYRZShBcxhwqLEDLjbewemEoWrf7Hfx25vDRkIb8v9+b
X-Received: from jthoughton.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:2a4f])
 (user=jthoughton job=sendgmr) by 2002:a25:850e:0:b0:6f8:42d8:2507 with SMTP
 id w14-20020a25850e000000b006f842d82507mr6177141ybk.110.1672913953310; Thu,
 05 Jan 2023 02:19:13 -0800 (PST)
Date:   Thu,  5 Jan 2023 10:18:11 +0000
In-Reply-To: <20230105101844.1893104-1-jthoughton@google.com>
Mime-Version: 1.0
References: <20230105101844.1893104-1-jthoughton@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20230105101844.1893104-14-jthoughton@google.com>
Subject: [PATCH 13/46] hugetlb: add hugetlb_hgm_walk and hugetlb_walk_step
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

hugetlb_hgm_walk implements high-granularity page table walks for
HugeTLB. It is safe to call on non-HGM enabled VMAs; it will return
immediately.

hugetlb_walk_step implements how we step forwards in the walk. For
architectures that don't use GENERAL_HUGETLB, they will need to provide
their own implementation.

Signed-off-by: James Houghton <jthoughton@google.com>
---
 include/linux/hugetlb.h |  35 +++++--
 mm/hugetlb.c            | 213 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 242 insertions(+), 6 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index ad9d19f0d1b9..2fcd8f313628 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -239,6 +239,14 @@ u32 hugetlb_fault_mutex_hash(struct address_space *mapping, pgoff_t idx);
 pte_t *huge_pmd_share(struct mm_struct *mm, struct vm_area_struct *vma,
 		      unsigned long addr, pud_t *pud);
 
+int hugetlb_full_walk(struct hugetlb_pte *hpte, struct vm_area_struct *vma,
+		      unsigned long addr);
+void hugetlb_full_walk_continue(struct hugetlb_pte *hpte,
+				struct vm_area_struct *vma, unsigned long addr);
+int hugetlb_full_walk_alloc(struct hugetlb_pte *hpte,
+			    struct vm_area_struct *vma, unsigned long addr,
+			    unsigned long target_sz);
+
 struct address_space *hugetlb_page_mapping_lock_write(struct page *hpage);
 
 extern int sysctl_hugetlb_shm_group;
@@ -288,6 +296,8 @@ pte_t *huge_pte_alloc(struct mm_struct *mm, struct vm_area_struct *vma,
 pte_t *huge_pte_offset(struct mm_struct *mm,
 		       unsigned long addr, unsigned long sz);
 unsigned long hugetlb_mask_last_page(struct hstate *h);
+int hugetlb_walk_step(struct mm_struct *mm, struct hugetlb_pte *hpte,
+		      unsigned long addr, unsigned long sz);
 int huge_pmd_unshare(struct mm_struct *mm, struct vm_area_struct *vma,
 				unsigned long addr, pte_t *ptep);
 void adjust_range_if_pmd_sharing_possible(struct vm_area_struct *vma,
@@ -1067,6 +1077,8 @@ void hugetlb_register_node(struct node *node);
 void hugetlb_unregister_node(struct node *node);
 #endif
 
+enum hugetlb_level hpage_size_to_level(unsigned long sz);
+
 #else	/* CONFIG_HUGETLB_PAGE */
 struct hstate {};
 
@@ -1259,6 +1271,11 @@ static inline void hugetlb_register_node(struct node *node)
 static inline void hugetlb_unregister_node(struct node *node)
 {
 }
+
+static inline enum hugetlb_level hpage_size_to_level(unsigned long sz)
+{
+	return HUGETLB_LEVEL_PTE;
+}
 #endif	/* CONFIG_HUGETLB_PAGE */
 
 #ifdef CONFIG_HUGETLB_HIGH_GRANULARITY_MAPPING
@@ -1333,12 +1350,8 @@ __vma_has_hugetlb_vma_lock(struct vm_area_struct *vma)
 	return (vma->vm_flags & VM_MAYSHARE) && vma->vm_private_data;
 }
 
-/*
- * Safe version of huge_pte_offset() to check the locks.  See comments
- * above huge_pte_offset().
- */
-static inline pte_t *
-hugetlb_walk(struct vm_area_struct *vma, unsigned long addr, unsigned long sz)
+static inline void
+hugetlb_walk_lock_check(struct vm_area_struct *vma)
 {
 #if defined(CONFIG_HUGETLB_PAGE) && \
 	defined(CONFIG_ARCH_WANT_HUGE_PMD_SHARE) && defined(CONFIG_LOCKDEP)
@@ -1360,6 +1373,16 @@ hugetlb_walk(struct vm_area_struct *vma, unsigned long addr, unsigned long sz)
 			     !lockdep_is_held(
 				 &vma->vm_file->f_mapping->i_mmap_rwsem));
 #endif
+}
+
+/*
+ * Safe version of huge_pte_offset() to check the locks.  See comments
+ * above huge_pte_offset().
+ */
+static inline pte_t *
+hugetlb_walk(struct vm_area_struct *vma, unsigned long addr, unsigned long sz)
+{
+	hugetlb_walk_lock_check(vma);
 	return huge_pte_offset(vma->vm_mm, addr, sz);
 }
 
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 2160cbaf3311..aa8e59cbca69 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -94,6 +94,29 @@ static int hugetlb_acct_memory(struct hstate *h, long delta);
 static void hugetlb_vma_lock_free(struct vm_area_struct *vma);
 static void __hugetlb_vma_unlock_write_free(struct vm_area_struct *vma);
 
+/*
+ * hpage_size_to_level() - convert @sz to the corresponding page table level
+ *
+ * @sz must be less than or equal to a valid hugepage size.
+ */
+enum hugetlb_level hpage_size_to_level(unsigned long sz)
+{
+	/*
+	 * We order the conditionals from smallest to largest to pick the
+	 * smallest level when multiple levels have the same size (i.e.,
+	 * when levels are folded).
+	 */
+	if (sz < PMD_SIZE)
+		return HUGETLB_LEVEL_PTE;
+	if (sz < PUD_SIZE)
+		return HUGETLB_LEVEL_PMD;
+	if (sz < P4D_SIZE)
+		return HUGETLB_LEVEL_PUD;
+	if (sz < PGDIR_SIZE)
+		return HUGETLB_LEVEL_P4D;
+	return HUGETLB_LEVEL_PGD;
+}
+
 static inline bool subpool_is_free(struct hugepage_subpool *spool)
 {
 	if (spool->count)
@@ -7276,6 +7299,153 @@ bool want_pmd_share(struct vm_area_struct *vma, unsigned long addr)
 }
 #endif /* CONFIG_ARCH_WANT_HUGE_PMD_SHARE */
 
+/* hugetlb_hgm_walk - walks a high-granularity HugeTLB page table to resolve
+ * the page table entry for @addr. We might allocate new PTEs.
+ *
+ * @hpte must always be pointing at an hstate-level PTE or deeper.
+ *
+ * This function will never walk further if it encounters a PTE of a size
+ * less than or equal to @sz.
+ *
+ * @alloc determines what we do when we encounter an empty PTE. If false,
+ * we stop walking. If true and @sz is less than the current PTE's size,
+ * we make that PTE point to the next level down, going until @sz is the same
+ * as our current PTE.
+ *
+ * If @alloc is false and @sz is PAGE_SIZE, this function will always
+ * succeed, but that does not guarantee that hugetlb_pte_size(hpte) is @sz.
+ *
+ * Return:
+ *	-ENOMEM if we couldn't allocate new PTEs.
+ *	-EEXIST if the caller wanted to walk further than a migration PTE,
+ *		poison PTE, or a PTE marker. The caller needs to manually deal
+ *		with this scenario.
+ *	-EINVAL if called with invalid arguments (@sz invalid, @hpte not
+ *		initialized).
+ *	0 otherwise.
+ *
+ *	Even if this function fails, @hpte is guaranteed to always remain
+ *	valid.
+ */
+static int hugetlb_hgm_walk(struct mm_struct *mm, struct vm_area_struct *vma,
+			    struct hugetlb_pte *hpte, unsigned long addr,
+			    unsigned long sz, bool alloc)
+{
+	int ret = 0;
+	pte_t pte;
+
+	if (WARN_ON_ONCE(sz < PAGE_SIZE))
+		return -EINVAL;
+
+	if (WARN_ON_ONCE(!hpte->ptep))
+		return -EINVAL;
+
+	/* We have the same synchronization requirements as hugetlb_walk. */
+	hugetlb_walk_lock_check(vma);
+
+	while (hugetlb_pte_size(hpte) > sz && !ret) {
+		pte = huge_ptep_get(hpte->ptep);
+		if (!pte_present(pte)) {
+			if (!alloc)
+				return 0;
+			if (unlikely(!huge_pte_none(pte)))
+				return -EEXIST;
+		} else if (hugetlb_pte_present_leaf(hpte, pte))
+			return 0;
+		ret = hugetlb_walk_step(mm, hpte, addr, sz);
+	}
+
+	return ret;
+}
+
+static int hugetlb_hgm_walk_uninit(struct hugetlb_pte *hpte,
+				   pte_t *ptep,
+				   struct vm_area_struct *vma,
+				   unsigned long addr,
+				   unsigned long target_sz,
+				   bool alloc)
+{
+	struct hstate *h = hstate_vma(vma);
+
+	hugetlb_pte_populate(vma->vm_mm, hpte, ptep, huge_page_shift(h),
+			     hpage_size_to_level(huge_page_size(h)));
+	return hugetlb_hgm_walk(vma->vm_mm, vma, hpte, addr, target_sz,
+				alloc);
+}
+
+/*
+ * hugetlb_full_walk_continue - continue a high-granularity page-table walk.
+ *
+ * If a user has a valid @hpte but knows that @hpte is not a leaf, they can
+ * attempt to continue walking by calling this function.
+ *
+ * This function may never fail, but @hpte might not change.
+ *
+ * If @hpte is not valid, then this function is a no-op.
+ */
+void hugetlb_full_walk_continue(struct hugetlb_pte *hpte,
+				struct vm_area_struct *vma,
+				unsigned long addr)
+{
+	/* hugetlb_hgm_walk will never fail with these arguments. */
+	WARN_ON_ONCE(hugetlb_hgm_walk(vma->vm_mm, vma, hpte, addr,
+				PAGE_SIZE, false));
+}
+
+/*
+ * hugetlb_full_walk - do a high-granularity page-table walk; never allocate.
+ *
+ * This function can only fail if we find that the hstate-level PTE is not
+ * allocated. Callers can take advantage of this fact to skip address regions
+ * that cannot be mapped in that case.
+ *
+ * If this function succeeds, @hpte is guaranteed to be valid.
+ */
+int hugetlb_full_walk(struct hugetlb_pte *hpte,
+		      struct vm_area_struct *vma,
+		      unsigned long addr)
+{
+	struct hstate *h = hstate_vma(vma);
+	unsigned long sz = huge_page_size(h);
+	/*
+	 * We must mask the address appropriately so that we pick up the first
+	 * PTE in a contiguous group.
+	 */
+	pte_t *ptep = hugetlb_walk(vma, addr & huge_page_mask(h), sz);
+
+	if (!ptep)
+		return -ENOMEM;
+
+	/* hugetlb_hgm_walk_uninit will never fail with these arguments. */
+	WARN_ON_ONCE(hugetlb_hgm_walk_uninit(hpte, ptep, vma, addr,
+				PAGE_SIZE, false));
+	return 0;
+}
+
+/*
+ * hugetlb_full_walk_alloc - do a high-granularity walk, potentially allocate
+ *	new PTEs.
+ */
+int hugetlb_full_walk_alloc(struct hugetlb_pte *hpte,
+				   struct vm_area_struct *vma,
+				   unsigned long addr,
+				   unsigned long target_sz)
+{
+	struct hstate *h = hstate_vma(vma);
+	unsigned long sz = huge_page_size(h);
+	/*
+	 * We must mask the address appropriately so that we pick up the first
+	 * PTE in a contiguous group.
+	 */
+	pte_t *ptep = huge_pte_alloc(vma->vm_mm, vma, addr & huge_page_mask(h),
+				     sz);
+
+	if (!ptep)
+		return -ENOMEM;
+
+	return hugetlb_hgm_walk_uninit(hpte, ptep, vma, addr, target_sz, true);
+}
+
 #ifdef CONFIG_ARCH_WANT_GENERAL_HUGETLB
 pte_t *huge_pte_alloc(struct mm_struct *mm, struct vm_area_struct *vma,
 			unsigned long addr, unsigned long sz)
@@ -7343,6 +7513,49 @@ pte_t *huge_pte_offset(struct mm_struct *mm,
 	return (pte_t *)pmd;
 }
 
+/*
+ * hugetlb_walk_step() - Walk the page table one step to resolve the page
+ * (hugepage or subpage) entry at address @addr.
+ *
+ * @sz always points at the final target PTE size (e.g. PAGE_SIZE for the
+ * lowest level PTE).
+ *
+ * @hpte will always remain valid, even if this function fails.
+ *
+ * Architectures that implement this function must ensure that if @hpte does
+ * not change levels, then its PTL must also stay the same.
+ */
+int hugetlb_walk_step(struct mm_struct *mm, struct hugetlb_pte *hpte,
+		      unsigned long addr, unsigned long sz)
+{
+	pte_t *ptep;
+	spinlock_t *ptl;
+
+	switch (hpte->level) {
+	case HUGETLB_LEVEL_PUD:
+		ptep = (pte_t *)hugetlb_alloc_pmd(mm, hpte, addr);
+		if (IS_ERR(ptep))
+			return PTR_ERR(ptep);
+		hugetlb_pte_populate(mm, hpte, ptep, PMD_SHIFT,
+				     HUGETLB_LEVEL_PMD);
+		break;
+	case HUGETLB_LEVEL_PMD:
+		ptep = hugetlb_alloc_pte(mm, hpte, addr);
+		if (IS_ERR(ptep))
+			return PTR_ERR(ptep);
+		ptl = pte_lockptr(mm, (pmd_t *)hpte->ptep);
+		__hugetlb_pte_populate(hpte, ptep, PAGE_SHIFT,
+				       HUGETLB_LEVEL_PTE, ptl);
+		hpte->ptl = ptl;
+		break;
+	default:
+		WARN_ONCE(1, "%s: got invalid level: %d (shift: %d)\n",
+				__func__, hpte->level, hpte->shift);
+		return -EINVAL;
+	}
+	return 0;
+}
+
 /*
  * Return a mask that can be used to update an address to the last huge
  * page in a page table page mapping size.  Used to skip non-present
-- 
2.39.0.314.g84b9a713c41-goog

