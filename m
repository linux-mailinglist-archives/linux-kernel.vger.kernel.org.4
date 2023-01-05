Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5C3565E8E5
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 11:22:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232797AbjAEKWZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 05:22:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232718AbjAEKUv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 05:20:51 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 052F45004E
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 02:19:35 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-4755eb8a57bso287393857b3.12
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 02:19:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=52Lc/VSk0yIghq22praJapn3lwvkCPBnf2CxE486HBM=;
        b=Zx/5LSq7vJ/Y7mzopiStfT2/J3Nk5Y/hwcDUw2EZUveXn48NopEe92bJctEe8AHRHb
         R4+NwkrLiB3Ui7F8085MNdLcPt4SgmkuRV80nXw5KvqkQh5nlPVpAeOmFBTYO/yyBK2R
         mfAGLc+fybaVayC+0em2EDp6HTBg/HUz57DWEpLbV1cSXcNeF2gtIk8xfD6FrGxUk4Ap
         emm5dAP/C0b01sNxXNKH99hzKuCt/6gecSgkdNuQIvP8mfymZ8FnbtLiZReUszJrDuC7
         KppRcHq+DOV0gvkrTGcEapdiAAhjR3UU0kRqrCKj5VHgUxOeotl97qLhxViO6fj5HHq5
         NEGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=52Lc/VSk0yIghq22praJapn3lwvkCPBnf2CxE486HBM=;
        b=sU0diBzKb5CIvLNAK8kPMedWo/M796eDX3WPAjj+IfGOH0ho/OrzfI1+HfxQDcHjwr
         PPGVbvT/gEB0DwGqJSiU1f+IhxqHg0tMHP7ZVwnDvwyddhLWEd8uga07FiDQ0v2u6Ac4
         ryAeHR6fIrpYGcpjiprp7Ewm8nPYHpRjvT1ykHlXyZofshs3lv1J9aMPO0ykyv8v6mJD
         vcbNMXy2UwogCjZ498G45zhR1Y7oi6OEdaOkyEshGL0ECvVrcoZY6jNawGEvSwv6zaIf
         MYpCoCcqNuhc7mlKfm2IP+PXrhZ5Zm69FmExndCj0OP9lqjWtFahNyJLwmARySQFeWNM
         Up4w==
X-Gm-Message-State: AFqh2kopUKoXfVtZ5qVMD6CjG6D7l0mNEPAhwwgDp6LeeSqxzxcYgxv/
        PHuaCta7Ki1Sjn2TEQVMlzhmgTlcYM3ICdv8
X-Google-Smtp-Source: AMrXdXuLctd/ohOHSTBjXBqVjUo3TAHquo6zIzDgau3k7Zts/IwTA/w1vO+rM3veE/HEW3N4JvkEeZQUmL8K/PtT
X-Received: from jthoughton.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:2a4f])
 (user=jthoughton job=sendgmr) by 2002:a0d:e2c1:0:b0:474:1969:ed89 with SMTP
 id l184-20020a0de2c1000000b004741969ed89mr3636781ywe.175.1672913975233; Thu,
 05 Jan 2023 02:19:35 -0800 (PST)
Date:   Thu,  5 Jan 2023 10:18:26 +0000
In-Reply-To: <20230105101844.1893104-1-jthoughton@google.com>
Mime-Version: 1.0
References: <20230105101844.1893104-1-jthoughton@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20230105101844.1893104-29-jthoughton@google.com>
Subject: [PATCH 28/46] hugetlb: add HGM support for hugetlb_fault and hugetlb_no_page
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

Update the page fault handler to support high-granularity page faults.
While handling a page fault on a partially-mapped HugeTLB page, if the
PTE we find with hugetlb_pte_walk is none, then we will replace it with
a leaf-level PTE to map the page. To give some examples:
1. For a completely unmapped 1G page, it will be mapped with a 1G PUD.
2. For a 1G page that has its first 512M mapped, any faults on the
   unmapped sections will result in 2M PMDs mapping each unmapped 2M
   section.
3. For a 1G page that has only its first 4K mapped, a page fault on its
   second 4K section will get a 4K PTE to map it.

Unless high-granularity mappings are created via UFFDIO_CONTINUE, it is
impossible for hugetlb_fault to create high-granularity mappings.

This commit does not handle hugetlb_wp right now, and it doesn't handle
HugeTLB page migration and swap entries.

The BUG_ON in huge_pte_alloc is removed, as it is not longer valid when
HGM is possible. HGM can be disabled if the VMA lock cannot be allocated
after a VMA is split, yet high-granularity mappings may still exist.

Signed-off-by: James Houghton <jthoughton@google.com>
---
 mm/hugetlb.c | 115 ++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 81 insertions(+), 34 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 582d14a206b5..8e690a22456a 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -117,6 +117,18 @@ enum hugetlb_level hpage_size_to_level(unsigned long sz)
 	return HUGETLB_LEVEL_PGD;
 }
 
+/*
+ * Find the subpage that corresponds to `addr` in `hpage`.
+ */
+static struct page *hugetlb_find_subpage(struct hstate *h, struct page *hpage,
+				 unsigned long addr)
+{
+	size_t idx = (addr & ~huge_page_mask(h))/PAGE_SIZE;
+
+	BUG_ON(idx >= pages_per_huge_page(h));
+	return &hpage[idx];
+}
+
 static inline bool subpool_is_free(struct hugepage_subpool *spool)
 {
 	if (spool->count)
@@ -5926,14 +5938,14 @@ static inline vm_fault_t hugetlb_handle_userfault(struct vm_area_struct *vma,
  * Recheck pte with pgtable lock.  Returns true if pte didn't change, or
  * false if pte changed or is changing.
  */
-static bool hugetlb_pte_stable(struct hstate *h, struct mm_struct *mm,
-			       pte_t *ptep, pte_t old_pte)
+static bool hugetlb_pte_stable(struct hstate *h, struct hugetlb_pte *hpte,
+			       pte_t old_pte)
 {
 	spinlock_t *ptl;
 	bool same;
 
-	ptl = huge_pte_lock(h, mm, ptep);
-	same = pte_same(huge_ptep_get(ptep), old_pte);
+	ptl = hugetlb_pte_lock(hpte);
+	same = pte_same(huge_ptep_get(hpte->ptep), old_pte);
 	spin_unlock(ptl);
 
 	return same;
@@ -5942,17 +5954,18 @@ static bool hugetlb_pte_stable(struct hstate *h, struct mm_struct *mm,
 static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 			struct vm_area_struct *vma,
 			struct address_space *mapping, pgoff_t idx,
-			unsigned long address, pte_t *ptep,
+			unsigned long address, struct hugetlb_pte *hpte,
 			pte_t old_pte, unsigned int flags)
 {
 	struct hstate *h = hstate_vma(vma);
 	vm_fault_t ret = VM_FAULT_SIGBUS;
 	int anon_rmap = 0;
 	unsigned long size;
-	struct page *page;
+	struct page *page, *subpage;
 	pte_t new_pte;
 	spinlock_t *ptl;
 	unsigned long haddr = address & huge_page_mask(h);
+	unsigned long haddr_hgm = address & hugetlb_pte_mask(hpte);
 	bool new_page, new_pagecache_page = false;
 	u32 hash = hugetlb_fault_mutex_hash(mapping, idx);
 
@@ -5997,7 +6010,7 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 			 * never happen on the page after UFFDIO_COPY has
 			 * correctly installed the page and returned.
 			 */
-			if (!hugetlb_pte_stable(h, mm, ptep, old_pte)) {
+			if (!hugetlb_pte_stable(h, hpte, old_pte)) {
 				ret = 0;
 				goto out;
 			}
@@ -6021,7 +6034,7 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 			 * here.  Before returning error, get ptl and make
 			 * sure there really is no pte entry.
 			 */
-			if (hugetlb_pte_stable(h, mm, ptep, old_pte))
+			if (hugetlb_pte_stable(h, hpte, old_pte))
 				ret = vmf_error(PTR_ERR(page));
 			else
 				ret = 0;
@@ -6071,7 +6084,7 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 			unlock_page(page);
 			put_page(page);
 			/* See comment in userfaultfd_missing() block above */
-			if (!hugetlb_pte_stable(h, mm, ptep, old_pte)) {
+			if (!hugetlb_pte_stable(h, hpte, old_pte)) {
 				ret = 0;
 				goto out;
 			}
@@ -6096,30 +6109,43 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 		vma_end_reservation(h, vma, haddr);
 	}
 
-	ptl = huge_pte_lock(h, mm, ptep);
+	ptl = hugetlb_pte_lock(hpte);
 	ret = 0;
-	/* If pte changed from under us, retry */
-	if (!pte_same(huge_ptep_get(ptep), old_pte))
+	/*
+	 * If pte changed from under us, retry.
+	 *
+	 * When dealing with high-granularity-mapped PTEs, it's possible that
+	 * a non-contiguous PTE within our contiguous PTE group gets populated,
+	 * in which case, we need to retry here. This is NOT caught here, and
+	 * will need to be addressed when HGM is supported for architectures
+	 * that support contiguous PTEs.
+	 */
+	if (!pte_same(huge_ptep_get(hpte->ptep), old_pte))
 		goto backout;
 
 	if (anon_rmap)
 		hugepage_add_new_anon_rmap(page, vma, haddr);
 	else
 		page_dup_file_rmap(page, true);
-	new_pte = make_huge_pte(vma, page, ((vma->vm_flags & VM_WRITE)
-				&& (vma->vm_flags & VM_SHARED)));
+
+	subpage = hugetlb_find_subpage(h, page, haddr_hgm);
+	new_pte = make_huge_pte_with_shift(vma, subpage,
+			((vma->vm_flags & VM_WRITE)
+			 && (vma->vm_flags & VM_SHARED)),
+			hpte->shift);
 	/*
 	 * If this pte was previously wr-protected, keep it wr-protected even
 	 * if populated.
 	 */
 	if (unlikely(pte_marker_uffd_wp(old_pte)))
 		new_pte = huge_pte_mkuffd_wp(new_pte);
-	set_huge_pte_at(mm, haddr, ptep, new_pte);
+	set_huge_pte_at(mm, haddr_hgm, hpte->ptep, new_pte);
 
-	hugetlb_count_add(pages_per_huge_page(h), mm);
+	hugetlb_count_add(hugetlb_pte_size(hpte) / PAGE_SIZE, mm);
 	if ((flags & FAULT_FLAG_WRITE) && !(vma->vm_flags & VM_SHARED)) {
+		WARN_ON_ONCE(hugetlb_pte_size(hpte) != huge_page_size(h));
 		/* Optimization, do the COW without a second fault */
-		ret = hugetlb_wp(mm, vma, address, ptep, flags, page, ptl);
+		ret = hugetlb_wp(mm, vma, address, hpte->ptep, flags, page, ptl);
 	}
 
 	spin_unlock(ptl);
@@ -6176,17 +6202,20 @@ u32 hugetlb_fault_mutex_hash(struct address_space *mapping, pgoff_t idx)
 vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 			unsigned long address, unsigned int flags)
 {
-	pte_t *ptep, entry;
+	pte_t entry;
 	spinlock_t *ptl;
 	vm_fault_t ret;
 	u32 hash;
 	pgoff_t idx;
 	struct page *page = NULL;
+	struct page *subpage = NULL;
 	struct page *pagecache_page = NULL;
 	struct hstate *h = hstate_vma(vma);
 	struct address_space *mapping;
 	int need_wait_lock = 0;
 	unsigned long haddr = address & huge_page_mask(h);
+	unsigned long haddr_hgm;
+	struct hugetlb_pte hpte;
 
 	/*
 	 * Serialize hugepage allocation and instantiation, so that we don't
@@ -6200,26 +6229,26 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 
 	/*
 	 * Acquire vma lock before calling huge_pte_alloc and hold
-	 * until finished with ptep.  This prevents huge_pmd_unshare from
-	 * being called elsewhere and making the ptep no longer valid.
+	 * until finished with hpte.  This prevents huge_pmd_unshare from
+	 * being called elsewhere and making the hpte no longer valid.
 	 */
 	hugetlb_vma_lock_read(vma);
-	ptep = huge_pte_alloc(mm, vma, haddr, huge_page_size(h));
-	if (!ptep) {
+	if (hugetlb_full_walk_alloc(&hpte, vma, address, 0)) {
 		hugetlb_vma_unlock_read(vma);
 		mutex_unlock(&hugetlb_fault_mutex_table[hash]);
 		return VM_FAULT_OOM;
 	}
 
-	entry = huge_ptep_get(ptep);
+	entry = huge_ptep_get(hpte.ptep);
 	/* PTE markers should be handled the same way as none pte */
-	if (huge_pte_none_mostly(entry))
+	if (huge_pte_none_mostly(entry)) {
 		/*
 		 * hugetlb_no_page will drop vma lock and hugetlb fault
 		 * mutex internally, which make us return immediately.
 		 */
-		return hugetlb_no_page(mm, vma, mapping, idx, address, ptep,
+		return hugetlb_no_page(mm, vma, mapping, idx, address, &hpte,
 				      entry, flags);
+	}
 
 	ret = 0;
 
@@ -6240,7 +6269,7 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 			 * be released there.
 			 */
 			mutex_unlock(&hugetlb_fault_mutex_table[hash]);
-			migration_entry_wait_huge(vma, ptep);
+			migration_entry_wait_huge(vma, hpte.ptep);
 			return 0;
 		} else if (unlikely(is_hugetlb_entry_hwpoisoned(entry)))
 			ret = VM_FAULT_HWPOISON_LARGE |
@@ -6248,6 +6277,10 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 		goto out_mutex;
 	}
 
+	if (!hugetlb_pte_present_leaf(&hpte, entry))
+		/* We raced with someone splitting the entry. */
+		goto out_mutex;
+
 	/*
 	 * If we are going to COW/unshare the mapping later, we examine the
 	 * pending reservations for this page now. This will ensure that any
@@ -6267,14 +6300,17 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 		pagecache_page = find_lock_page(mapping, idx);
 	}
 
-	ptl = huge_pte_lock(h, mm, ptep);
+	ptl = hugetlb_pte_lock(&hpte);
 
 	/* Check for a racing update before calling hugetlb_wp() */
-	if (unlikely(!pte_same(entry, huge_ptep_get(ptep))))
+	if (unlikely(!pte_same(entry, huge_ptep_get(hpte.ptep))))
 		goto out_ptl;
 
+	/* haddr_hgm is the base address of the region that hpte maps. */
+	haddr_hgm = address & hugetlb_pte_mask(&hpte);
+
 	/* Handle userfault-wp first, before trying to lock more pages */
-	if (userfaultfd_wp(vma) && huge_pte_uffd_wp(huge_ptep_get(ptep)) &&
+	if (userfaultfd_wp(vma) && huge_pte_uffd_wp(entry) &&
 	    (flags & FAULT_FLAG_WRITE) && !huge_pte_write(entry)) {
 		struct vm_fault vmf = {
 			.vma = vma,
@@ -6298,7 +6334,8 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 	 * pagecache_page, so here we need take the former one
 	 * when page != pagecache_page or !pagecache_page.
 	 */
-	page = pte_page(entry);
+	subpage = pte_page(entry);
+	page = compound_head(subpage);
 	if (page != pagecache_page)
 		if (!trylock_page(page)) {
 			need_wait_lock = 1;
@@ -6309,7 +6346,9 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 
 	if (flags & (FAULT_FLAG_WRITE|FAULT_FLAG_UNSHARE)) {
 		if (!huge_pte_write(entry)) {
-			ret = hugetlb_wp(mm, vma, address, ptep, flags,
+			WARN_ON_ONCE(hugetlb_pte_size(&hpte) !=
+					huge_page_size(h));
+			ret = hugetlb_wp(mm, vma, address, hpte.ptep, flags,
 					 pagecache_page, ptl);
 			goto out_put_page;
 		} else if (likely(flags & FAULT_FLAG_WRITE)) {
@@ -6317,9 +6356,9 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 		}
 	}
 	entry = pte_mkyoung(entry);
-	if (huge_ptep_set_access_flags(vma, haddr, ptep, entry,
+	if (huge_ptep_set_access_flags(vma, haddr_hgm, hpte.ptep, entry,
 						flags & FAULT_FLAG_WRITE))
-		update_mmu_cache(vma, haddr, ptep);
+		update_mmu_cache(vma, haddr_hgm, hpte.ptep);
 out_put_page:
 	if (page != pagecache_page)
 		unlock_page(page);
@@ -7523,6 +7562,9 @@ int hugetlb_full_walk(struct hugetlb_pte *hpte,
 /*
  * hugetlb_full_walk_alloc - do a high-granularity walk, potentially allocate
  *	new PTEs.
+ *
+ * If @target_sz is 0, then only attempt to allocate the hstate-level PTE, and
+ * walk as far as we can go.
  */
 int hugetlb_full_walk_alloc(struct hugetlb_pte *hpte,
 				   struct vm_area_struct *vma,
@@ -7541,6 +7583,12 @@ int hugetlb_full_walk_alloc(struct hugetlb_pte *hpte,
 	if (!ptep)
 		return -ENOMEM;
 
+	if (!target_sz) {
+		WARN_ON_ONCE(hugetlb_hgm_walk_uninit(hpte, ptep, vma, addr,
+					PAGE_SIZE, false));
+		return 0;
+	}
+
 	return hugetlb_hgm_walk_uninit(hpte, ptep, vma, addr, target_sz, true);
 }
 
@@ -7569,7 +7617,6 @@ pte_t *huge_pte_alloc(struct mm_struct *mm, struct vm_area_struct *vma,
 				pte = (pte_t *)pmd_alloc(mm, pud, addr);
 		}
 	}
-	BUG_ON(pte && pte_present(*pte) && !pte_huge(*pte));
 
 	return pte;
 }
-- 
2.39.0.314.g84b9a713c41-goog

