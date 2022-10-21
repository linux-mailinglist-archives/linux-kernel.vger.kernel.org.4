Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EDBC607C77
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 18:39:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231340AbiJUQjV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 12:39:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231173AbiJUQiP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 12:38:15 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7727C285286
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 09:37:36 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id p66-20020a257445000000b006ca0ba7608fso3732378ybc.7
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 09:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jeZGXnq9ppZX6Bn3Ab6ADEhW+p+OYv5o03S1VkTLnuk=;
        b=tbNvguBzB1ZQ4lsC5+9mg7RWgx9DLFVbmF5v6BFznCk26QFFQdPaNiWrYza+kxDylE
         tEa7a8XUOhkliOlVXdX6cyfm8TE9X0VEvk/pj5HJUcnfc7FgSAESb7fi8f7w8gA576cO
         LYwJodJrSLZqWi2/eMrO03DghELV+IjVJYCQF4i3lW2FOVdNkbcytuaue/e5g9HIMMWF
         uNu1bQ+0pIqtKnUyor0k37TH4YOlWSMHgWWcV4CAVeufrCm6C4lzViN3BceDaEdp7Rlw
         gCQWhWp3Lo+C7PMV0hXo81mJTBpOeDjRf2UNTijPurz0+pu6m8vVHSiJIopwA6humXkP
         4dgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jeZGXnq9ppZX6Bn3Ab6ADEhW+p+OYv5o03S1VkTLnuk=;
        b=CZWHe0HDhmcaqt8rwVsj4xwi9Gc1fWjXf0s7NucKl83zryrovKG1SjYOaJ1miAfiaC
         2Nj4LPJm892h9FO2/vGM/1VhXUtMauEZEt6+uVY6GMF5EqCFC6Vf4SWfNq/Do8ljlqP+
         KC2fnLeyLimm4JwvdqMQnZrYN9MbC5CMTmKWhSEP0GFIZC0DwODyvix15PAJtUYyqB3j
         SYPof2vN04EVMbU+hgMwDtW+ByQGdgnoVAXai+Xoe01ElmUocl1mCv1GjhnK8aKib6Y4
         FrfcYnFstP3+p0UlR5jIUiURhJJHn1ttTwIQ/im4k+SB/kkWgFXZT7mxFkVxGrasb+WX
         toVg==
X-Gm-Message-State: ACrzQf0ny2lYAM2j2cLp5a+5rOE2v7FrJQzRUKA/aaXIqNRluxFiI4iG
        SXkAmQVsfJwMRubppVjpu8+K0uLyD4HOZr0V
X-Google-Smtp-Source: AMsMyM7QWTBVTDYOl/TUbDnTqd5zxQWVq73p6o4dP7bFkvXD+6XB7O77ZjXS/hAWz+IG055NLGtAnntOHHr7ZsbD
X-Received: from jthoughton.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:2a4f])
 (user=jthoughton job=sendgmr) by 2002:a81:df08:0:b0:352:f2f2:580c with SMTP
 id c8-20020a81df08000000b00352f2f2580cmr17379566ywn.40.1666370254979; Fri, 21
 Oct 2022 09:37:34 -0700 (PDT)
Date:   Fri, 21 Oct 2022 16:36:36 +0000
In-Reply-To: <20221021163703.3218176-1-jthoughton@google.com>
Mime-Version: 1.0
References: <20221021163703.3218176-1-jthoughton@google.com>
X-Mailer: git-send-email 2.38.0.135.g90850a2211-goog
Message-ID: <20221021163703.3218176-21-jthoughton@google.com>
Subject: [RFC PATCH v2 20/47] hugetlb: use struct hugetlb_pte for walk_hugetlb_range
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

The main change in this commit is to walk_hugetlb_range to support
walking HGM mappings, but all walk_hugetlb_range callers must be updated
to use the new API and take the correct action.

Listing all the changes to the callers:

For s390 changes, we simply ignore HGM PTEs (we don't support s390 yet).

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
---
 arch/s390/mm/gmap.c      | 20 ++++++++--
 fs/proc/task_mmu.c       | 83 +++++++++++++++++++++++++++++-----------
 include/linux/pagewalk.h | 11 ++++--
 mm/damon/vaddr.c         | 57 +++++++++++++++++----------
 mm/hmm.c                 | 21 ++++++----
 mm/memory-failure.c      | 17 ++++----
 mm/mempolicy.c           | 12 ++++--
 mm/mincore.c             | 17 ++++++--
 mm/mprotect.c            | 18 ++++++---
 mm/pagewalk.c            | 32 +++++++++++++---
 10 files changed, 203 insertions(+), 85 deletions(-)

diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
index 02d15c8dc92e..d65c15b5dccb 100644
--- a/arch/s390/mm/gmap.c
+++ b/arch/s390/mm/gmap.c
@@ -2622,13 +2622,25 @@ static int __s390_enable_skey_pmd(pmd_t *pmd, unsigned long addr,
 	return 0;
 }
 
-static int __s390_enable_skey_hugetlb(pte_t *pte, unsigned long addr,
-				      unsigned long hmask, unsigned long next,
+static int __s390_enable_skey_hugetlb(struct hugetlb_pte *hpte,
+				      unsigned long addr,
 				      struct mm_walk *walk)
 {
-	pmd_t *pmd = (pmd_t *)pte;
+	struct hstate *h = hstate_vma(walk->vma);
+	pmd_t *pmd;
 	unsigned long start, end;
-	struct page *page = pmd_page(*pmd);
+	struct page *page;
+
+	if (huge_page_size(h) != hugetlb_pte_size(hpte))
+		/* Ignore high-granularity PTEs. */
+		return 0;
+
+	if (!pte_present(huge_ptep_get(hpte->ptep)))
+		/* Ignore non-present PTEs. */
+		return 0;
+
+	pmd = (pmd_t *)pte;
+	page = pmd_page(*pmd);
 
 	/*
 	 * The write check makes sure we do not set a key on shared
diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 8a74cdcc9af0..be78cdb7677e 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -720,18 +720,28 @@ static void show_smap_vma_flags(struct seq_file *m, struct vm_area_struct *vma)
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
@@ -740,9 +750,9 @@ static int smaps_hugetlb_range(pte_t *pte, unsigned long hmask,
 		int mapcount = page_mapcount(page);
 
 		if (mapcount >= 2)
-			mss->shared_hugetlb += huge_page_size(hstate_vma(vma));
+			mss->shared_hugetlb += hugetlb_pte_size(hpte);
 		else
-			mss->private_hugetlb += huge_page_size(hstate_vma(vma));
+			mss->private_hugetlb += hugetlb_pte_size(hpte);
 	}
 	return 0;
 }
@@ -1561,22 +1571,31 @@ static int pagemap_pmd_range(pmd_t *pmdp, unsigned long addr, unsigned long end,
 
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
@@ -1857,10 +1876,16 @@ static struct page *can_gather_numa_stats_pmd(pmd_t pmd,
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
@@ -1872,6 +1897,7 @@ static int gather_pte_stats(pmd_t *pmd, unsigned long addr,
 		struct page *page;
 
 		page = can_gather_numa_stats_pmd(*pmd, vma, addr);
+		priv->last_page = page;
 		if (page)
 			gather_stats(page, md, pmd_dirty(*pmd),
 				     HPAGE_PMD_SIZE/PAGE_SIZE);
@@ -1885,6 +1911,7 @@ static int gather_pte_stats(pmd_t *pmd, unsigned long addr,
 	orig_pte = pte = pte_offset_map_lock(walk->mm, pmd, addr, &ptl);
 	do {
 		struct page *page = can_gather_numa_stats(*pte, vma, addr);
+		priv->last_page = page;
 		if (!page)
 			continue;
 		gather_stats(page, md, pte_dirty(*pte), 1);
@@ -1895,19 +1922,25 @@ static int gather_pte_stats(pmd_t *pmd, unsigned long addr,
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
@@ -1937,9 +1970,15 @@ static int show_numa_map(struct seq_file *m, void *v)
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
 
@@ -1969,7 +2008,7 @@ static int show_numa_map(struct seq_file *m, void *v)
 		seq_puts(m, " huge");
 
 	/* mmap_lock is held by m_start */
-	walk_page_vma(vma, &show_numa_ops, md);
+	walk_page_vma(vma, &show_numa_ops, &numa_map_private);
 
 	if (!md->pages)
 		goto out;
diff --git a/include/linux/pagewalk.h b/include/linux/pagewalk.h
index 2f8f6cc980b4..7ed065ea5dba 100644
--- a/include/linux/pagewalk.h
+++ b/include/linux/pagewalk.h
@@ -3,6 +3,7 @@
 #define _LINUX_PAGEWALK_H
 
 #include <linux/mm.h>
+#include <linux/hugetlb.h>
 
 struct mm_walk;
 
@@ -21,7 +22,10 @@ struct mm_walk;
  *			depth is -1 if not known, 0:PGD, 1:P4D, 2:PUD, 3:PMD.
  *			Any folded depths (where PTRS_PER_P?D is equal to 1)
  *			are skipped.
- * @hugetlb_entry:	if set, called for each hugetlb entry
+ * @hugetlb_entry:	if set, called for each hugetlb entry. In the presence
+ *			of high-granularity hugetlb entries, @hugetlb_entry is
+ *			called only for leaf-level entries (i.e., hstate-level
+ *			page table entries are ignored if they are not leaves).
  * @test_walk:		caller specific callback function to determine whether
  *			we walk over the current vma or not. Returning 0 means
  *			"do page table walk over the current vma", returning
@@ -47,9 +51,8 @@ struct mm_walk_ops {
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
index 15f03df66db6..42845e1b560d 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -330,48 +330,55 @@ static int damon_mkold_pmd_entry(pmd_t *pmd, unsigned long addr,
 }
 
 #ifdef CONFIG_HUGETLB_PAGE
-static void damon_hugetlb_mkold(pte_t *pte, struct mm_struct *mm,
+static void damon_hugetlb_mkold(struct hugetlb_pte *hpte, pte_t entry,
+				struct mm_struct *mm,
 				struct vm_area_struct *vma, unsigned long addr)
 {
 	bool referenced = false;
-	pte_t entry = huge_ptep_get(pte);
 	struct page *page = pte_page(entry);
+	struct page *hpage = compound_head(page);
 
-	get_page(page);
+	get_page(hpage);
 
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
 
 	if (referenced)
-		set_page_young(page);
+		set_page_young(hpage);
 
-	set_page_idle(page);
-	put_page(page);
+	set_page_idle(hpage);
+	put_page(hpage);
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
+	ptl = hugetlb_pte_lock(walk->mm, hpte);
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
@@ -484,31 +491,39 @@ static int damon_young_pmd_entry(pmd_t *pmd, unsigned long addr,
 }
 
 #ifdef CONFIG_HUGETLB_PAGE
-static int damon_young_hugetlb_entry(pte_t *pte, unsigned long hmask,
-				     unsigned long addr, unsigned long end,
+static int damon_young_hugetlb_entry(struct hugetlb_pte *hpte,
+				     unsigned long addr,
 				     struct mm_walk *walk)
 {
 	struct damon_young_walk_private *priv = walk->private;
 	struct hstate *h = hstate_vma(walk->vma);
-	struct page *page;
+	struct page *page, *hpage;
 	spinlock_t *ptl;
 	pte_t entry;
 
-	ptl = huge_pte_lock(h, walk->mm, pte);
+	ptl = hugetlb_pte_lock(walk->mm, hpte);
 	entry = huge_ptep_get(pte);
 	if (!pte_present(entry))
 		goto out;
 
+	if (!hugetlb_pte_present_leaf(hpte, entry))
+		/*
+		 * We raced with someone splitting a blank PTE. Treat this PTE
+		 * as if it were blank.
+		 */
+		goto out;
+
 	page = pte_page(entry);
-	get_page(page);
+	hpage = compound_head(page);
+	get_page(hpage);
 
-	if (pte_young(entry) || !page_is_idle(page) ||
+	if (pte_young(entry) || !page_is_idle(hpage) ||
 	    mmu_notifier_test_young(walk->mm, addr)) {
 		*priv->page_sz = huge_page_size(h);
 		priv->young = true;
 	}
 
-	put_page(page);
+	put_page(hpage);
 
 out:
 	spin_unlock(ptl);
diff --git a/mm/hmm.c b/mm/hmm.c
index 3850fb625dda..76679b46ad5e 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -469,27 +469,34 @@ static int hmm_vma_walk_pud(pud_t *pudp, unsigned long start, unsigned long end,
 #endif
 
 #ifdef CONFIG_HUGETLB_PAGE
-static int hmm_vma_walk_hugetlb_entry(pte_t *pte, unsigned long hmask,
-				      unsigned long start, unsigned long end,
+static int hmm_vma_walk_hugetlb_entry(struct hugetlb_pte *hpte,
+				      unsigned long start,
 				      struct mm_walk *walk)
 {
 	unsigned long addr = start, i, pfn;
 	struct hmm_vma_walk *hmm_vma_walk = walk->private;
 	struct hmm_range *range = hmm_vma_walk->range;
-	struct vm_area_struct *vma = walk->vma;
 	unsigned int required_fault;
 	unsigned long pfn_req_flags;
 	unsigned long cpu_flags;
+	unsigned long hmask = hugetlb_pte_mask(hpte);
+	unsigned int order = hugetlb_pte_shift(hpte) - PAGE_SHIFT;
+	unsigned long end = start + hugetlb_pte_size(hpte);
 	spinlock_t *ptl;
 	pte_t entry;
 
-	ptl = huge_pte_lock(hstate_vma(vma), walk->mm, pte);
-	entry = huge_ptep_get(pte);
+	ptl = hugetlb_pte_lock(walk->mm, hpte);
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
@@ -593,7 +600,7 @@ int hmm_range_fault(struct hmm_range *range)
 		 * in pfns. All entries < last in the pfn array are set to their
 		 * output, and all >= are still at their input values.
 		 */
-	} while (ret == -EBUSY);
+	} while (ret == -EBUSY || ret == -EAGAIN);
 	return ret;
 }
 EXPORT_SYMBOL(hmm_range_fault);
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index bead6bccc7f2..505efba59d29 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -628,6 +628,7 @@ static int check_hwpoisoned_entry(pte_t pte, unsigned long addr, short shift,
 				unsigned long poisoned_pfn, struct to_kill *tk)
 {
 	unsigned long pfn = 0;
+	unsigned long base_pages_poisoned = (1UL << shift) / PAGE_SIZE;
 
 	if (pte_present(pte)) {
 		pfn = pte_pfn(pte);
@@ -638,7 +639,8 @@ static int check_hwpoisoned_entry(pte_t pte, unsigned long addr, short shift,
 			pfn = swp_offset_pfn(swp);
 	}
 
-	if (!pfn || pfn != poisoned_pfn)
+	if (!pfn || pfn < poisoned_pfn ||
+			pfn >= poisoned_pfn + base_pages_poisoned)
 		return 0;
 
 	set_to_kill(tk, addr, shift);
@@ -704,16 +706,15 @@ static int hwpoison_pte_range(pmd_t *pmdp, unsigned long addr,
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
index 61aa9aedb728..275bc549590e 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -558,8 +558,8 @@ static int queue_pages_pte_range(pmd_t *pmd, unsigned long addr,
 	return addr != end ? -EIO : 0;
 }
 
-static int queue_pages_hugetlb(pte_t *pte, unsigned long hmask,
-			       unsigned long addr, unsigned long end,
+static int queue_pages_hugetlb(struct hugetlb_pte *hpte,
+			       unsigned long addr,
 			       struct mm_walk *walk)
 {
 	int ret = 0;
@@ -570,8 +570,12 @@ static int queue_pages_hugetlb(pte_t *pte, unsigned long hmask,
 	spinlock_t *ptl;
 	pte_t entry;
 
-	ptl = huge_pte_lock(hstate_vma(walk->vma), walk->mm, pte);
-	entry = huge_ptep_get(pte);
+	/* We don't migrate high-granularity HugeTLB mappings for now. */
+	if (hugetlb_hgm_enabled(walk->vma))
+		return -EINVAL;
+
+	ptl = hugetlb_pte_lock(walk->mm, hpte);
+	entry = huge_ptep_get(hpte->ptep);
 	if (!pte_present(entry))
 		goto unlock;
 	page = pte_page(entry);
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
index 99762403cc8f..9975b86035e0 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -524,12 +524,16 @@ static int prot_none_pte_entry(pte_t *pte, unsigned long addr,
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
@@ -572,8 +576,10 @@ mprotect_fixup(struct mmu_gather *tlb, struct vm_area_struct *vma,
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
index bb33c1e8c017..2318aae98f1e 100644
--- a/mm/pagewalk.c
+++ b/mm/pagewalk.c
@@ -3,6 +3,7 @@
 #include <linux/highmem.h>
 #include <linux/sched.h>
 #include <linux/hugetlb.h>
+#include <linux/minmax.h>
 
 /*
  * We want to know the real level where a entry is located ignoring any
@@ -301,20 +302,39 @@ static int walk_hugetlb_range(unsigned long addr, unsigned long end,
 	pte_t *pte;
 	const struct mm_walk_ops *ops = walk->ops;
 	int err = 0;
+	struct hugetlb_pte hpte;
+
+	if (hugetlb_hgm_enabled(vma))
+		/*
+		 * We could potentially do high-granularity walks. Grab the
+		 * VMA lock to prevent PTEs from becoming invalid.
+		 */
+		hugetlb_vma_lock_read(vma);
 
 	do {
-		next = hugetlb_entry_end(h, addr, end);
 		pte = huge_pte_offset(walk->mm, addr & hmask, sz);
-
-		if (pte)
-			err = ops->hugetlb_entry(pte, hmask, addr, next, walk);
-		else if (ops->pte_hole)
-			err = ops->pte_hole(addr, next, -1, walk);
+		if (!pte) {
+			next = hugetlb_entry_end(h, addr, end);
+			if (ops->pte_hole)
+				err = ops->pte_hole(addr, next, -1, walk);
+		} else {
+			hugetlb_pte_populate(&hpte, pte, huge_page_shift(h),
+					hpage_size_to_level(sz));
+			hugetlb_hgm_walk(walk->mm, vma, &hpte, addr,
+					PAGE_SIZE,
+					/*stop_at_none=*/true);
+			err = ops->hugetlb_entry(
+					&hpte, addr, walk);
+			next = min(addr + hugetlb_pte_size(&hpte), end);
+		}
 
 		if (err)
 			break;
 	} while (addr = next, addr != end);
 
+	if (hugetlb_hgm_enabled(vma))
+		hugetlb_vma_unlock_read(vma);
+
 	return err;
 }
 
-- 
2.38.0.135.g90850a2211-goog

