Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 752EB69B6C1
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 01:31:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbjBRA3k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 19:29:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbjBRA3S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 19:29:18 -0500
Received: from mail-ua1-x94a.google.com (mail-ua1-x94a.google.com [IPv6:2607:f8b0:4864:20::94a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BA966ABE3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 16:28:57 -0800 (PST)
Received: by mail-ua1-x94a.google.com with SMTP id j4-20020ab06004000000b0068b93413c63so812928ual.18
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 16:28:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1676680136;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=uRKYla0TQmxQv6jLt3zA0HnNAsQhQcQxeVgRZIxAfD0=;
        b=aY3F+EdXtCUshFPXDCNcttdzNX+c4LbhQi1SlJKFNgfqHWfMJ9vDmVr9sTpieHk05X
         o4uR5QadzoXUGRF67oJyJbtK2h79UlcD3xZm62j78SP9Oa4ap24kfVkt0+OF4A/n+edW
         7IAq9oxJqPxznoi+TtMM93uAoNkDnONQ+ts18nLlvOqmoYn3iH/qQKh7/ZFGrihwcuj9
         1V4KX6t2Pwg0FKhmdUmpWWjWMENeKOVdjc9494RWzzvR00UMehx3hUstaQ0j8uMeOex4
         5VuSVQoGMANGWUUusrSYOeAZy9IVSY0n/qOvAGec/mTz8lN3nGuzMNi0BmdrRxSyqNfw
         Sbbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1676680136;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uRKYla0TQmxQv6jLt3zA0HnNAsQhQcQxeVgRZIxAfD0=;
        b=sPrLLK6vsihjMt6o+NwR2KqE6PQrEr644HtbFMBmmTBWpgWrDhW25qcndTV3emU9JK
         fTZgdnrr9wnFkytlrXY5NDmrELsG40qIXingdbA3uLTDCuIKZ2ROh2qo3ytj1OsQ0zKU
         KMYBrd49zPEPqXfGbNKOcTpAk9DLSqv82itM/orswCTERqs63h5HRyVpkRvtZgBk2Rxb
         Fly7ZLSqB48BpyMqE2ZwJzShyEehR33yiVOOPz5gy7FGxNF/eLdUaOz+UomMb5JD5GYv
         X2WuBJl9UkQGTAFcOMyPvTh3GbP1soH40SW7tF9yVHf0DvtCXjjypYQgDXDVdenrL5tc
         7XRQ==
X-Gm-Message-State: AO0yUKVPN32B/j2XVD4urBD9a5+99ggPeEZaZV2OD85tFL1GO/QO388P
        jrJ+fBmPdoEjJp0TlGM4J04NarKq3QHGkoTv
X-Google-Smtp-Source: AK7set/GEorAyYMaCd0jNzqquEaNj7jwa1sYuJrs5tjMlDyYAqUGDdv0CU5O6YV9UsW4yKpSO/jg62VpebURY2U0
X-Received: from jthoughton.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:2a4f])
 (user=jthoughton job=sendgmr) by 2002:a05:6102:153:b0:417:159c:218b with SMTP
 id a19-20020a056102015300b00417159c218bmr652647vsr.13.1676680136399; Fri, 17
 Feb 2023 16:28:56 -0800 (PST)
Date:   Sat, 18 Feb 2023 00:27:46 +0000
In-Reply-To: <20230218002819.1486479-1-jthoughton@google.com>
Mime-Version: 1.0
References: <20230218002819.1486479-1-jthoughton@google.com>
X-Mailer: git-send-email 2.39.2.637.g21b0678d19-goog
Message-ID: <20230218002819.1486479-14-jthoughton@google.com>
Subject: [PATCH v2 13/46] hugetlb: add hugetlb_hgm_walk and hugetlb_walk_step
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

hugetlb_hgm_walk implements high-granularity page table walks for
HugeTLB. It is safe to call on non-HGM enabled VMAs; it will return
immediately.

hugetlb_walk_step implements how we step forwards in the walk. For
architectures that don't use GENERAL_HUGETLB, they will need to provide
their own implementation.

The broader API that should be used is
hugetlb_full_walk[,alloc|,continue].

Signed-off-by: James Houghton <jthoughton@google.com>

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 9d839519c875..726d581158b1 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -223,6 +223,14 @@ u32 hugetlb_fault_mutex_hash(struct address_space *mapping, pgoff_t idx);
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
@@ -272,6 +280,8 @@ pte_t *huge_pte_alloc(struct mm_struct *mm, struct vm_area_struct *vma,
 pte_t *huge_pte_offset(struct mm_struct *mm,
 		       unsigned long addr, unsigned long sz);
 unsigned long hugetlb_mask_last_page(struct hstate *h);
+int hugetlb_walk_step(struct mm_struct *mm, struct hugetlb_pte *hpte,
+		      unsigned long addr, unsigned long sz);
 int huge_pmd_unshare(struct mm_struct *mm, struct vm_area_struct *vma,
 				unsigned long addr, pte_t *ptep);
 void adjust_range_if_pmd_sharing_possible(struct vm_area_struct *vma,
@@ -1054,6 +1064,8 @@ void hugetlb_register_node(struct node *node);
 void hugetlb_unregister_node(struct node *node);
 #endif
 
+enum hugetlb_level hpage_size_to_level(unsigned long sz);
+
 #else	/* CONFIG_HUGETLB_PAGE */
 struct hstate {};
 
@@ -1246,6 +1258,11 @@ static inline void hugetlb_register_node(struct node *node)
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
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index bb424cdf79e4..810c05feb41f 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -97,6 +97,29 @@ static void __hugetlb_vma_unlock_write_free(struct vm_area_struct *vma);
 static void hugetlb_unshare_pmds(struct vm_area_struct *vma,
 		unsigned long start, unsigned long end);
 
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
@@ -7315,6 +7338,154 @@ bool want_pmd_share(struct vm_area_struct *vma, unsigned long addr)
 }
 #endif /* CONFIG_ARCH_WANT_HUGE_PMD_SHARE */
 
+/* __hugetlb_hgm_walk - walks a high-granularity HugeTLB page table to resolve
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
+static int __hugetlb_hgm_walk(struct mm_struct *mm, struct vm_area_struct *vma,
+			      struct hugetlb_pte *hpte, unsigned long addr,
+			      unsigned long sz, bool alloc)
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
+/*
+ * hugetlb_hgm_walk - Has the same behavior as __hugetlb_hgm_walk but will
+ * initialize @hpte with hstate-level PTE pointer @ptep.
+ */
+static int hugetlb_hgm_walk(struct hugetlb_pte *hpte,
+			    pte_t *ptep,
+			    struct vm_area_struct *vma,
+			    unsigned long addr,
+			    unsigned long target_sz,
+			    bool alloc)
+{
+	struct hstate *h = hstate_vma(vma);
+
+	hugetlb_pte_init(vma->vm_mm, hpte, ptep, huge_page_shift(h),
+			 hpage_size_to_level(huge_page_size(h)));
+	return __hugetlb_hgm_walk(vma->vm_mm, vma, hpte, addr, target_sz,
+				  alloc);
+}
+
+/*
+ * hugetlb_full_walk_continue - continue a high-granularity page-table walk.
+ *
+ * If a user has a valid @hpte but knows that @hpte is not a leaf, they can
+ * attempt to continue walking by calling this function.
+ *
+ * This function will never fail, but @hpte might not change.
+ *
+ * If @hpte hasn't been initialized, then this function's behavior is
+ * undefined.
+ */
+void hugetlb_full_walk_continue(struct hugetlb_pte *hpte,
+				struct vm_area_struct *vma,
+				unsigned long addr)
+{
+	/* __hugetlb_hgm_walk will never fail with these arguments. */
+	WARN_ON_ONCE(__hugetlb_hgm_walk(vma->vm_mm, vma, hpte, addr,
+					PAGE_SIZE, false));
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
+	/* hugetlb_hgm_walk will never fail with these arguments. */
+	WARN_ON_ONCE(hugetlb_hgm_walk(hpte, ptep, vma, addr, PAGE_SIZE, false));
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
+	return hugetlb_hgm_walk(hpte, ptep, vma, addr, target_sz, true);
+}
+
 #ifdef CONFIG_ARCH_WANT_GENERAL_HUGETLB
 pte_t *huge_pte_alloc(struct mm_struct *mm, struct vm_area_struct *vma,
 			unsigned long addr, unsigned long sz)
@@ -7382,6 +7553,48 @@ pte_t *huge_pte_offset(struct mm_struct *mm,
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
+		hugetlb_pte_init(mm, hpte, ptep, PMD_SHIFT,
+				 HUGETLB_LEVEL_PMD);
+		break;
+	case HUGETLB_LEVEL_PMD:
+		ptep = hugetlb_alloc_pte(mm, hpte, addr);
+		if (IS_ERR(ptep))
+			return PTR_ERR(ptep);
+		ptl = pte_lockptr(mm, (pmd_t *)hpte->ptep);
+		__hugetlb_pte_init(hpte, ptep, PAGE_SHIFT,
+				   HUGETLB_LEVEL_PTE, ptl);
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
2.39.2.637.g21b0678d19-goog

