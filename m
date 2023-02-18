Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F022369B6C8
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 01:31:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbjBRAao (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 19:30:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230096AbjBRA3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 19:29:49 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5B356C015
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 16:29:12 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id o137-20020a25418f000000b009419f64f6afso2165044yba.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 16:29:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UjVXJ8hdtbHTf+lUAZ4f6x6F3SynSj2CG1xD1+Yj8f8=;
        b=pv9sgXbRSK+ulujLGfdPPPAff8mO5bDv7HpAt6sVLZ6JoZzQXqgTKRKandAavm2wSz
         GaPYHHRdcJpckwms1PVrFc6vNiVTcxAlG6oCUMRdsxDqYTYXzVurmJEml8+ql0/TDF3v
         UCJ95R9PBOaSmpPE4Ic9Jp4SeoUjQgy3yUVhXKTk40u73yY7EVS1bRLPiHZZ1nL8e3sb
         q6IAgfazCkla4E5CBbTWQRtlKAAvX2g0orVfxrreagJHjk3BLCZ3ldDp7zxJzy4vym4x
         NWi0886Mcej8s6rWUU/kKQxFgDeHHLlKOLYF3V4C/36HC2UNIB85Ve9+c4SQOQU3rEkv
         hcBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UjVXJ8hdtbHTf+lUAZ4f6x6F3SynSj2CG1xD1+Yj8f8=;
        b=G/JMY2yUjZjyzJX5icYnwqF2rruwEoV0qq11xPtOKbjcWNvNFT28PQg6oQwi6QWA6u
         DYdZC6bwU2QVtz/RNMix0Z9E6ge0NVV7K/or/bEfttDDjzU+JagJSDWYnVbc7A56jf0I
         PBMSZoKNJxaR5ZQqGqlfKZe4uoRABy4brJA5iAW29V3/ini/7rYBQlXPEFngKk7mX4s9
         gnD6NXP/mo995EZFDCbcQjk8RTzDX65p/mqiE+CZbDRtTutchPzALlqNK0iaGBgUNypT
         7B1uSbia/rVkFwWuCQqLZTzU5QR2wItsX1eTUmS8zPEnzQ88WRTZCpCIaDaUsYU8KI8F
         Qh5Q==
X-Gm-Message-State: AO0yUKVnlpcJ9F7IO0PPIqbZfrB+1t1P3EeoQiF6e3xghQAn5qwR6r3y
        vWZrFDi4jZF0uJHBV0IUffcRygvF7Rux++7/
X-Google-Smtp-Source: AK7set9HSTLEVb4H/dZ4jXxsGK/LepFZp0hDfPakpFLzNJu6RpLhAhLCkF7ri6HXdFjyEvBAOB+uhx84ME7Ia1t3
X-Received: from jthoughton.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:2a4f])
 (user=jthoughton job=sendgmr) by 2002:a5b:c4b:0:b0:8c3:7bc8:7f0e with SMTP id
 d11-20020a5b0c4b000000b008c37bc87f0emr1152747ybr.588.1676680148502; Fri, 17
 Feb 2023 16:29:08 -0800 (PST)
Date:   Sat, 18 Feb 2023 00:27:58 +0000
In-Reply-To: <20230218002819.1486479-1-jthoughton@google.com>
Mime-Version: 1.0
References: <20230218002819.1486479-1-jthoughton@google.com>
X-Mailer: git-send-email 2.39.2.637.g21b0678d19-goog
Message-ID: <20230218002819.1486479-26-jthoughton@google.com>
Subject: [PATCH v2 25/46] hugetlb: use struct hugetlb_pte for walk_hugetlb_range
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

The main change in this commit is to walk_hugetlb_range to support
walking HGM mappings, but all walk_hugetlb_range callers must be updated
to use the new API and take the correct action.

Listing all the changes to the callers:

For s390 changes, we simply BUILD_BUG_ON if HGM is enabled.

For smaps, shared_hugetlb (and private_hugetlb, although private
mappings don't support HGM) may now not be divisible by the hugepage
size. The appropriate changes have been made to support analyzing HGM
PTEs.

For pagemap, we ignore non-leaf PTEs by treating that as if they were
none PTEs. We can only end up with non-leaf PTEs if they had just been
updated from a none PTE.

For show_numa_map, the challenge is that, if any of a hugepage is
mapped, we have to count that entire page exactly once, as the results
are given in units of hugepages. To support HGM mappings, we keep track
of the last page that we looked it. If the hugepage we are currently
looking at is the same as the last one, then we must be looking at an
HGM-mapped page that has been mapped at high-granularity, and we've
already accounted for it.

For DAMON, we treat non-leaf PTEs as if they were blank, for the same
reason as pagemap.

For hwpoison, we proactively update the logic to support the case when
hpte is pointing to a subpage within the poisoned hugepage.

For queue_pages_hugetlb/migration, we ignore all HGM-enabled VMAs for
now.

For mincore, we ignore non-leaf PTEs for the same reason as pagemap.

For mprotect/prot_none_hugetlb_entry, we retry the walk when we get a
non-leaf PTE.

Signed-off-by: James Houghton <jthoughton@google.com>

diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
index 5a716bdcba05..e1d41caa8504 100644
--- a/arch/s390/mm/gmap.c
+++ b/arch/s390/mm/gmap.c
@@ -2629,14 +2629,20 @@ static int __s390_enable_skey_pmd(pmd_t *pmd, unsigned long addr,
 	return 0;
 }
 
-static int __s390_enable_skey_hugetlb(pte_t *pte, unsigned long addr,
-				      unsigned long hmask, unsigned long next,
+static int __s390_enable_skey_hugetlb(struct hugetlb_pte *hpte,
+				      unsigned long addr,
 				      struct mm_walk *walk)
 {
-	pmd_t *pmd = (pmd_t *)pte;
+	pmd_t *pmd = (pmd_t *)hpte->ptep;
 	unsigned long start, end;
 	struct page *page = pmd_page(*pmd);
 
+	/*
+	 * We don't support high-granularity mappings yet. If we did, the
+	 * pmd_page() call above would be unsafe.
+	 */
+	BUILD_BUG_ON(IS_ENABLED(CONFIG_HUGETLB_HIGH_GRANULARITY_MAPPING));
+
 	/*
 	 * The write check makes sure we do not set a key on shared
 	 * memory. This is needed as the walker does not differentiate
diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 77b72f42556a..2f293b5dabc0 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -731,27 +731,39 @@ static void show_smap_vma_flags(struct seq_file *m, struct vm_area_struct *vma)
 }
 
 #ifdef CONFIG_HUGETLB_PAGE
-static int smaps_hugetlb_range(pte_t *pte, unsigned long hmask,
-				 unsigned long addr, unsigned long end,
-				 struct mm_walk *walk)
+static int smaps_hugetlb_range(struct hugetlb_pte *hpte,
+				unsigned long addr,
+				struct mm_walk *walk)
 {
 	struct mem_size_stats *mss = walk->private;
 	struct vm_area_struct *vma = walk->vma;
 	struct page *page = NULL;
+	pte_t pte = huge_ptep_get(hpte->ptep);
 
-	if (pte_present(*pte)) {
-		page = vm_normal_page(vma, addr, *pte);
-	} else if (is_swap_pte(*pte)) {
-		swp_entry_t swpent = pte_to_swp_entry(*pte);
+	if (pte_present(pte)) {
+		/* We only care about leaf-level PTEs. */
+		if (!hugetlb_pte_present_leaf(hpte, pte))
+			/*
+			 * The only case where hpte is not a leaf is that
+			 * it was originally none, but it was split from
+			 * under us. It was originally none, so exclude it.
+			 */
+			return 0;
+
+		page = vm_normal_page(vma, addr, pte);
+	} else if (is_swap_pte(pte)) {
+		swp_entry_t swpent = pte_to_swp_entry(pte);
 
 		if (is_pfn_swap_entry(swpent))
 			page = pfn_swap_entry_to_page(swpent);
 	}
 	if (page) {
-		if (page_mapcount(page) >= 2 || hugetlb_pmd_shared(pte))
-			mss->shared_hugetlb += huge_page_size(hstate_vma(vma));
+		unsigned long sz = hugetlb_pte_size(hpte);
+
+		if (page_mapcount(page) >= 2 || hugetlb_pmd_shared(hpte->ptep))
+			mss->shared_hugetlb += sz;
 		else
-			mss->private_hugetlb += huge_page_size(hstate_vma(vma));
+			mss->private_hugetlb += sz;
 	}
 	return 0;
 }
@@ -1569,22 +1581,31 @@ static int pagemap_pmd_range(pmd_t *pmdp, unsigned long addr, unsigned long end,
 
 #ifdef CONFIG_HUGETLB_PAGE
 /* This function walks within one hugetlb entry in the single call */
-static int pagemap_hugetlb_range(pte_t *ptep, unsigned long hmask,
-				 unsigned long addr, unsigned long end,
+static int pagemap_hugetlb_range(struct hugetlb_pte *hpte,
+				 unsigned long addr,
 				 struct mm_walk *walk)
 {
 	struct pagemapread *pm = walk->private;
 	struct vm_area_struct *vma = walk->vma;
 	u64 flags = 0, frame = 0;
 	int err = 0;
-	pte_t pte;
+	unsigned long hmask = hugetlb_pte_mask(hpte);
+	unsigned long end = addr + hugetlb_pte_size(hpte);
+	pte_t pte = huge_ptep_get(hpte->ptep);
+	struct page *page;
 
 	if (vma->vm_flags & VM_SOFTDIRTY)
 		flags |= PM_SOFT_DIRTY;
 
-	pte = huge_ptep_get(ptep);
 	if (pte_present(pte)) {
-		struct page *page = pte_page(pte);
+		/*
+		 * We raced with this PTE being split, which can only happen if
+		 * it was blank before. Treat it is as if it were blank.
+		 */
+		if (!hugetlb_pte_present_leaf(hpte, pte))
+			return 0;
+
+		page = pte_page(pte);
 
 		if (!PageAnon(page))
 			flags |= PM_FILE;
@@ -1865,10 +1886,16 @@ static struct page *can_gather_numa_stats_pmd(pmd_t pmd,
 }
 #endif
 
+struct show_numa_map_private {
+	struct numa_maps *md;
+	struct page *last_page;
+};
+
 static int gather_pte_stats(pmd_t *pmd, unsigned long addr,
 		unsigned long end, struct mm_walk *walk)
 {
-	struct numa_maps *md = walk->private;
+	struct show_numa_map_private *priv = walk->private;
+	struct numa_maps *md = priv->md;
 	struct vm_area_struct *vma = walk->vma;
 	spinlock_t *ptl;
 	pte_t *orig_pte;
@@ -1880,6 +1907,7 @@ static int gather_pte_stats(pmd_t *pmd, unsigned long addr,
 		struct page *page;
 
 		page = can_gather_numa_stats_pmd(*pmd, vma, addr);
+		priv->last_page = page;
 		if (page)
 			gather_stats(page, md, pmd_dirty(*pmd),
 				     HPAGE_PMD_SIZE/PAGE_SIZE);
@@ -1893,6 +1921,7 @@ static int gather_pte_stats(pmd_t *pmd, unsigned long addr,
 	orig_pte = pte = pte_offset_map_lock(walk->mm, pmd, addr, &ptl);
 	do {
 		struct page *page = can_gather_numa_stats(*pte, vma, addr);
+		priv->last_page = page;
 		if (!page)
 			continue;
 		gather_stats(page, md, pte_dirty(*pte), 1);
@@ -1903,19 +1932,25 @@ static int gather_pte_stats(pmd_t *pmd, unsigned long addr,
 	return 0;
 }
 #ifdef CONFIG_HUGETLB_PAGE
-static int gather_hugetlb_stats(pte_t *pte, unsigned long hmask,
-		unsigned long addr, unsigned long end, struct mm_walk *walk)
+static int gather_hugetlb_stats(struct hugetlb_pte *hpte, unsigned long addr,
+		struct mm_walk *walk)
 {
-	pte_t huge_pte = huge_ptep_get(pte);
+	struct show_numa_map_private *priv = walk->private;
+	pte_t huge_pte = huge_ptep_get(hpte->ptep);
 	struct numa_maps *md;
 	struct page *page;
 
-	if (!pte_present(huge_pte))
+	if (!hugetlb_pte_present_leaf(hpte, huge_pte))
+		return 0;
+
+	page = compound_head(pte_page(huge_pte));
+	if (priv->last_page == page)
+		/* we've already accounted for this page */
 		return 0;
 
-	page = pte_page(huge_pte);
+	priv->last_page = page;
 
-	md = walk->private;
+	md = priv->md;
 	gather_stats(page, md, pte_dirty(huge_pte), 1);
 	return 0;
 }
@@ -1945,9 +1980,15 @@ static int show_numa_map(struct seq_file *m, void *v)
 	struct file *file = vma->vm_file;
 	struct mm_struct *mm = vma->vm_mm;
 	struct mempolicy *pol;
+
 	char buffer[64];
 	int nid;
 
+	struct show_numa_map_private numa_map_private;
+
+	numa_map_private.md = md;
+	numa_map_private.last_page = NULL;
+
 	if (!mm)
 		return 0;
 
@@ -1977,7 +2018,7 @@ static int show_numa_map(struct seq_file *m, void *v)
 		seq_puts(m, " huge");
 
 	/* mmap_lock is held by m_start */
-	walk_page_vma(vma, &show_numa_ops, md);
+	walk_page_vma(vma, &show_numa_ops, &numa_map_private);
 
 	if (!md->pages)
 		goto out;
diff --git a/include/linux/pagewalk.h b/include/linux/pagewalk.h
index 27a6df448ee5..f4bddad615c2 100644
--- a/include/linux/pagewalk.h
+++ b/include/linux/pagewalk.h
@@ -3,6 +3,7 @@
 #define _LINUX_PAGEWALK_H
 
 #include <linux/mm.h>
+#include <linux/hugetlb.h>
 
 struct mm_walk;
 
@@ -31,6 +32,10 @@ struct mm_walk;
  *			ptl after dropping the vma lock, or else revalidate
  *			those items after re-acquiring the vma lock and before
  *			accessing them.
+ *			In the presence of high-granularity hugetlb entries,
+ *			@hugetlb_entry is called only for leaf-level entries
+ *			(hstate-level entries are ignored if they are not
+ *			leaves).
  * @test_walk:		caller specific callback function to determine whether
  *			we walk over the current vma or not. Returning 0 means
  *			"do page table walk over the current vma", returning
@@ -58,9 +63,8 @@ struct mm_walk_ops {
 			 unsigned long next, struct mm_walk *walk);
 	int (*pte_hole)(unsigned long addr, unsigned long next,
 			int depth, struct mm_walk *walk);
-	int (*hugetlb_entry)(pte_t *pte, unsigned long hmask,
-			     unsigned long addr, unsigned long next,
-			     struct mm_walk *walk);
+	int (*hugetlb_entry)(struct hugetlb_pte *hpte,
+			     unsigned long addr, struct mm_walk *walk);
 	int (*test_walk)(unsigned long addr, unsigned long next,
 			struct mm_walk *walk);
 	int (*pre_vma)(unsigned long start, unsigned long end,
diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index 1fec16d7263e..0f001950498a 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -330,11 +330,11 @@ static int damon_mkold_pmd_entry(pmd_t *pmd, unsigned long addr,
 }
 
 #ifdef CONFIG_HUGETLB_PAGE
-static void damon_hugetlb_mkold(pte_t *pte, struct mm_struct *mm,
+static void damon_hugetlb_mkold(struct hugetlb_pte *hpte, pte_t entry,
+				struct mm_struct *mm,
 				struct vm_area_struct *vma, unsigned long addr)
 {
 	bool referenced = false;
-	pte_t entry = huge_ptep_get(pte);
 	struct folio *folio = pfn_folio(pte_pfn(entry));
 
 	folio_get(folio);
@@ -342,12 +342,12 @@ static void damon_hugetlb_mkold(pte_t *pte, struct mm_struct *mm,
 	if (pte_young(entry)) {
 		referenced = true;
 		entry = pte_mkold(entry);
-		set_huge_pte_at(mm, addr, pte, entry);
+		set_huge_pte_at(mm, addr, hpte->ptep, entry);
 	}
 
 #ifdef CONFIG_MMU_NOTIFIER
 	if (mmu_notifier_clear_young(mm, addr,
-				     addr + huge_page_size(hstate_vma(vma))))
+				     addr + hugetlb_pte_size(hpte)))
 		referenced = true;
 #endif /* CONFIG_MMU_NOTIFIER */
 
@@ -358,20 +358,26 @@ static void damon_hugetlb_mkold(pte_t *pte, struct mm_struct *mm,
 	folio_put(folio);
 }
 
-static int damon_mkold_hugetlb_entry(pte_t *pte, unsigned long hmask,
-				     unsigned long addr, unsigned long end,
+static int damon_mkold_hugetlb_entry(struct hugetlb_pte *hpte,
+				     unsigned long addr,
 				     struct mm_walk *walk)
 {
-	struct hstate *h = hstate_vma(walk->vma);
 	spinlock_t *ptl;
 	pte_t entry;
 
-	ptl = huge_pte_lock(h, walk->mm, pte);
-	entry = huge_ptep_get(pte);
+	ptl = hugetlb_pte_lock(hpte);
+	entry = huge_ptep_get(hpte->ptep);
 	if (!pte_present(entry))
 		goto out;
 
-	damon_hugetlb_mkold(pte, walk->mm, walk->vma, addr);
+	if (!hugetlb_pte_present_leaf(hpte, entry))
+		/*
+		 * We raced with someone splitting a blank PTE. Treat this PTE
+		 * as if it were blank.
+		 */
+		goto out;
+
+	damon_hugetlb_mkold(hpte, entry, walk->mm, walk->vma, addr);
 
 out:
 	spin_unlock(ptl);
@@ -483,8 +489,8 @@ static int damon_young_pmd_entry(pmd_t *pmd, unsigned long addr,
 }
 
 #ifdef CONFIG_HUGETLB_PAGE
-static int damon_young_hugetlb_entry(pte_t *pte, unsigned long hmask,
-				     unsigned long addr, unsigned long end,
+static int damon_young_hugetlb_entry(struct hugetlb_pte *hpte,
+				     unsigned long addr,
 				     struct mm_walk *walk)
 {
 	struct damon_young_walk_private *priv = walk->private;
@@ -493,11 +499,18 @@ static int damon_young_hugetlb_entry(pte_t *pte, unsigned long hmask,
 	spinlock_t *ptl;
 	pte_t entry;
 
-	ptl = huge_pte_lock(h, walk->mm, pte);
-	entry = huge_ptep_get(pte);
+	ptl = hugetlb_pte_lock(hpte);
+	entry = huge_ptep_get(hpte->ptep);
 	if (!pte_present(entry))
 		goto out;
 
+	if (!hugetlb_pte_present_leaf(hpte, entry))
+		/*
+		 * We raced with someone splitting a blank PTE. Treat this PTE
+		 * as if it were blank.
+		 */
+		goto out;
+
 	folio = pfn_folio(pte_pfn(entry));
 	folio_get(folio);
 
diff --git a/mm/hmm.c b/mm/hmm.c
index 6a151c09de5e..d3e40cfdd4cb 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -468,8 +468,8 @@ static int hmm_vma_walk_pud(pud_t *pudp, unsigned long start, unsigned long end,
 #endif
 
 #ifdef CONFIG_HUGETLB_PAGE
-static int hmm_vma_walk_hugetlb_entry(pte_t *pte, unsigned long hmask,
-				      unsigned long start, unsigned long end,
+static int hmm_vma_walk_hugetlb_entry(struct hugetlb_pte *hpte,
+				      unsigned long start,
 				      struct mm_walk *walk)
 {
 	unsigned long addr = start, i, pfn;
@@ -479,16 +479,24 @@ static int hmm_vma_walk_hugetlb_entry(pte_t *pte, unsigned long hmask,
 	unsigned int required_fault;
 	unsigned long pfn_req_flags;
 	unsigned long cpu_flags;
+	unsigned long hmask = hugetlb_pte_mask(hpte);
+	unsigned int order = hpte->shift - PAGE_SHIFT;
+	unsigned long end = start + hugetlb_pte_size(hpte);
 	spinlock_t *ptl;
 	pte_t entry;
 
-	ptl = huge_pte_lock(hstate_vma(vma), walk->mm, pte);
-	entry = huge_ptep_get(pte);
+	ptl = hugetlb_pte_lock(hpte);
+	entry = huge_ptep_get(hpte->ptep);
+
+	if (!hugetlb_pte_present_leaf(hpte, entry)) {
+		spin_unlock(ptl);
+		return -EAGAIN;
+	}
 
 	i = (start - range->start) >> PAGE_SHIFT;
 	pfn_req_flags = range->hmm_pfns[i];
 	cpu_flags = pte_to_hmm_pfn_flags(range, entry) |
-		    hmm_pfn_flags_order(huge_page_order(hstate_vma(vma)));
+		    hmm_pfn_flags_order(order);
 	required_fault =
 		hmm_pte_need_fault(hmm_vma_walk, pfn_req_flags, cpu_flags);
 	if (required_fault) {
@@ -605,7 +613,7 @@ int hmm_range_fault(struct hmm_range *range)
 		 * in pfns. All entries < last in the pfn array are set to their
 		 * output, and all >= are still at their input values.
 		 */
-	} while (ret == -EBUSY);
+	} while (ret == -EBUSY || ret == -EAGAIN);
 	return ret;
 }
 EXPORT_SYMBOL(hmm_range_fault);
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index a1ede7bdce95..0b37cbc6e8ae 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -676,6 +676,7 @@ static int check_hwpoisoned_entry(pte_t pte, unsigned long addr, short shift,
 				unsigned long poisoned_pfn, struct to_kill *tk)
 {
 	unsigned long pfn = 0;
+	unsigned long base_pages_poisoned = (1UL << shift) / PAGE_SIZE;
 
 	if (pte_present(pte)) {
 		pfn = pte_pfn(pte);
@@ -686,7 +687,8 @@ static int check_hwpoisoned_entry(pte_t pte, unsigned long addr, short shift,
 			pfn = swp_offset_pfn(swp);
 	}
 
-	if (!pfn || pfn != poisoned_pfn)
+	if (!pfn || pfn < poisoned_pfn ||
+			pfn >= poisoned_pfn + base_pages_poisoned)
 		return 0;
 
 	set_to_kill(tk, addr, shift);
@@ -752,16 +754,15 @@ static int hwpoison_pte_range(pmd_t *pmdp, unsigned long addr,
 }
 
 #ifdef CONFIG_HUGETLB_PAGE
-static int hwpoison_hugetlb_range(pte_t *ptep, unsigned long hmask,
-			    unsigned long addr, unsigned long end,
-			    struct mm_walk *walk)
+static int hwpoison_hugetlb_range(struct hugetlb_pte *hpte,
+				  unsigned long addr,
+				  struct mm_walk *walk)
 {
 	struct hwp_walk *hwp = walk->private;
-	pte_t pte = huge_ptep_get(ptep);
-	struct hstate *h = hstate_vma(walk->vma);
+	pte_t pte = huge_ptep_get(hpte->ptep);
 
-	return check_hwpoisoned_entry(pte, addr, huge_page_shift(h),
-				      hwp->pfn, &hwp->tk);
+	return check_hwpoisoned_entry(pte, addr & hugetlb_pte_mask(hpte),
+			hpte->shift, hwp->pfn, &hwp->tk);
 }
 #else
 #define hwpoison_hugetlb_range	NULL
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index a256a241fd1d..0f91be88392b 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -558,8 +558,8 @@ static int queue_folios_pte_range(pmd_t *pmd, unsigned long addr,
 	return addr != end ? -EIO : 0;
 }
 
-static int queue_folios_hugetlb(pte_t *pte, unsigned long hmask,
-			       unsigned long addr, unsigned long end,
+static int queue_folios_hugetlb(struct hugetlb_pte *hpte,
+			       unsigned long addr,
 			       struct mm_walk *walk)
 {
 	int ret = 0;
@@ -570,8 +570,12 @@ static int queue_folios_hugetlb(pte_t *pte, unsigned long hmask,
 	spinlock_t *ptl;
 	pte_t entry;
 
-	ptl = huge_pte_lock(hstate_vma(walk->vma), walk->mm, pte);
-	entry = huge_ptep_get(pte);
+	/* We don't migrate high-granularity HugeTLB mappings for now. */
+	if (hugetlb_hgm_enabled(walk->vma))
+		return -EINVAL;
+
+	ptl = hugetlb_pte_lock(hpte);
+	entry = huge_ptep_get(hpte->ptep);
 	if (!pte_present(entry))
 		goto unlock;
 	folio = pfn_folio(pte_pfn(entry));
@@ -608,7 +612,7 @@ static int queue_folios_hugetlb(pte_t *pte, unsigned long hmask,
 	 */
 	if (flags & (MPOL_MF_MOVE_ALL) ||
 	    (flags & MPOL_MF_MOVE && folio_estimated_sharers(folio) == 1 &&
-	     !hugetlb_pmd_shared(pte))) {
+	     !hugetlb_pmd_shared(hpte->ptep))) {
 		if (!isolate_hugetlb(folio, qp->pagelist) &&
 			(flags & MPOL_MF_STRICT))
 			/*
diff --git a/mm/mincore.c b/mm/mincore.c
index a085a2aeabd8..0894965b3944 100644
--- a/mm/mincore.c
+++ b/mm/mincore.c
@@ -22,18 +22,29 @@
 #include <linux/uaccess.h>
 #include "swap.h"
 
-static int mincore_hugetlb(pte_t *pte, unsigned long hmask, unsigned long addr,
-			unsigned long end, struct mm_walk *walk)
+static int mincore_hugetlb(struct hugetlb_pte *hpte, unsigned long addr,
+			   struct mm_walk *walk)
 {
 #ifdef CONFIG_HUGETLB_PAGE
 	unsigned char present;
+	unsigned long end = addr + hugetlb_pte_size(hpte);
 	unsigned char *vec = walk->private;
+	pte_t pte = huge_ptep_get(hpte->ptep);
 
 	/*
 	 * Hugepages under user process are always in RAM and never
 	 * swapped out, but theoretically it needs to be checked.
 	 */
-	present = pte && !huge_pte_none(huge_ptep_get(pte));
+	present = !huge_pte_none(pte);
+
+	/*
+	 * If the pte is present but not a leaf, we raced with someone
+	 * splitting it. For someone to have split it, it must have been
+	 * huge_pte_none before, so treat it as such.
+	 */
+	if (pte_present(pte) && !hugetlb_pte_present_leaf(hpte, pte))
+		present = false;
+
 	for (; addr != end; vec++, addr += PAGE_SIZE)
 		*vec = present;
 	walk->private = vec;
diff --git a/mm/mprotect.c b/mm/mprotect.c
index 1d4843c97c2a..61263ce9d925 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -564,12 +564,16 @@ static int prot_none_pte_entry(pte_t *pte, unsigned long addr,
 		0 : -EACCES;
 }
 
-static int prot_none_hugetlb_entry(pte_t *pte, unsigned long hmask,
-				   unsigned long addr, unsigned long next,
+static int prot_none_hugetlb_entry(struct hugetlb_pte *hpte,
+				   unsigned long addr,
 				   struct mm_walk *walk)
 {
-	return pfn_modify_allowed(pte_pfn(*pte), *(pgprot_t *)(walk->private)) ?
-		0 : -EACCES;
+	pte_t pte = huge_ptep_get(hpte->ptep);
+
+	if (!hugetlb_pte_present_leaf(hpte, pte))
+		return -EAGAIN;
+	return pfn_modify_allowed(pte_pfn(pte),
+			*(pgprot_t *)(walk->private)) ? 0 : -EACCES;
 }
 
 static int prot_none_test(unsigned long addr, unsigned long next,
@@ -612,8 +616,10 @@ mprotect_fixup(struct vma_iterator *vmi, struct mmu_gather *tlb,
 	    (newflags & VM_ACCESS_FLAGS) == 0) {
 		pgprot_t new_pgprot = vm_get_page_prot(newflags);
 
-		error = walk_page_range(current->mm, start, end,
-				&prot_none_walk_ops, &new_pgprot);
+		do {
+			error = walk_page_range(current->mm, start, end,
+					&prot_none_walk_ops, &new_pgprot);
+		} while (error == -EAGAIN);
 		if (error)
 			return error;
 	}
diff --git a/mm/pagewalk.c b/mm/pagewalk.c
index cb23f8a15c13..05ce242f8b7e 100644
--- a/mm/pagewalk.c
+++ b/mm/pagewalk.c
@@ -3,6 +3,7 @@
 #include <linux/highmem.h>
 #include <linux/sched.h>
 #include <linux/hugetlb.h>
+#include <linux/minmax.h>
 
 /*
  * We want to know the real level where a entry is located ignoring any
@@ -296,20 +297,21 @@ static int walk_hugetlb_range(unsigned long addr, unsigned long end,
 	struct vm_area_struct *vma = walk->vma;
 	struct hstate *h = hstate_vma(vma);
 	unsigned long next;
-	unsigned long hmask = huge_page_mask(h);
-	unsigned long sz = huge_page_size(h);
-	pte_t *pte;
 	const struct mm_walk_ops *ops = walk->ops;
 	int err = 0;
+	struct hugetlb_pte hpte;
 
 	hugetlb_vma_lock_read(vma);
 	do {
-		next = hugetlb_entry_end(h, addr, end);
-		pte = hugetlb_walk(vma, addr & hmask, sz);
-		if (pte)
-			err = ops->hugetlb_entry(pte, hmask, addr, next, walk);
-		else if (ops->pte_hole)
-			err = ops->pte_hole(addr, next, -1, walk);
+		if (hugetlb_full_walk(&hpte, vma, addr)) {
+			next = hugetlb_entry_end(h, addr, end);
+			if (ops->pte_hole)
+				err = ops->pte_hole(addr, next, -1, walk);
+		} else {
+			err = ops->hugetlb_entry(
+					&hpte, addr, walk);
+			next = min(addr + hugetlb_pte_size(&hpte), end);
+		}
 		if (err)
 			break;
 	} while (addr = next, addr != end);
-- 
2.39.2.637.g21b0678d19-goog

