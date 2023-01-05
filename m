Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3049865E8ED
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 11:23:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233008AbjAEKWy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 05:22:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232784AbjAEKV3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 05:21:29 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B5A158328
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 02:19:45 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id y66-20020a25c845000000b00733b5049b6fso36236672ybf.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 02:19:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3FgXUHA3tnp9ag/KdcrsQO8+AooEilqNmGGLS4NLvAo=;
        b=CQ2ZAMvCUZJv/+eIPckh0cru0bcQh2zSN2X8UydOAYOHip0mnvLnjMTpx+nekpYPri
         PgSqIhuQRNSfE3cy5gmX64ME2FE79V7tZA1HzCajMGW/OTeRieb6CfAI5RCC+jjsnkgi
         P1AqjuWmCe+IBSuxFW0Sx6Yi8H2eOhRCeKbnXhh618YloM81ctLM2MDeHXdprNgFIwKI
         DnNxI3YwFHfZjuMqooj0PPDF7pJlqgONVEwWBBjnUtuxxCEahkMIAqGF8l2UH+JCve2z
         UX89Ln9ApsOrMPYb3Pi/fXmim/GTGmCNYZtKYdlY+XWMpNKMbgBdacdNGn0bNgJJOMnv
         zQ/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3FgXUHA3tnp9ag/KdcrsQO8+AooEilqNmGGLS4NLvAo=;
        b=yWrqXJE55nKEvQ4wiQKmEsBpFXw+CjZe/E4xnwQlwMrPtRdQsoK8guZUtceSZIj3qh
         bLPP0V/0BqonHTVc6MtJjrWaKORfvSkLfwWp0yvwG59e5gyNSIX/pb+MaydPufV//L5k
         5arF+uA9Cw7HHj5PvZR57nD9/VPwADxuZHcjpWfTCi44L1hHdqJ6REVG+BlDtr9KpWdj
         JtGoNt1o4YLmbAdbsyOel6ytJqhsk5AgTq8p0panfHQhQuKjmndThpqAZHBEnCLfRrvj
         6wGlrEpaDe8//HMiwKwq0xvomfzfG5fZ+A7jPZ4VD3MpeDsnPUDbJ/eHcX6t59ZfzRCI
         lIeQ==
X-Gm-Message-State: AFqh2kpz4ztTMuCWq3QvtjVpTH7//mO/CUnrBv7/FpN7NGWrFK7/rr2y
        SnX/qD6IIWfa56WKKu8iI55rVVhrb8TKmvbN
X-Google-Smtp-Source: AMrXdXuzD5Zl8Kd66cl2YeIf0CBaeSj8tkfJ7XrLcfARYCSDgpp3FWj9tMfFIQw7/JsTh4ne2tp478HqHQuoawqr
X-Received: from jthoughton.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:2a4f])
 (user=jthoughton job=sendgmr) by 2002:a81:a209:0:b0:4af:16a7:5334 with SMTP
 id w9-20020a81a209000000b004af16a75334mr1111907ywg.159.1672913984631; Thu, 05
 Jan 2023 02:19:44 -0800 (PST)
Date:   Thu,  5 Jan 2023 10:18:33 +0000
In-Reply-To: <20230105101844.1893104-1-jthoughton@google.com>
Mime-Version: 1.0
References: <20230105101844.1893104-1-jthoughton@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20230105101844.1893104-36-jthoughton@google.com>
Subject: [PATCH 35/46] hugetlb: add MADV_COLLAPSE for hugetlb
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

This is a necessary extension to the UFFDIO_CONTINUE changes. When
userspace finishes mapping an entire hugepage with UFFDIO_CONTINUE, the
kernel has no mechanism to automatically collapse the page table to map
the whole hugepage normally. We require userspace to inform us that they
would like the mapping to be collapsed; they do this with MADV_COLLAPSE.

If userspace has not mapped all of a hugepage with UFFDIO_CONTINUE, but
only some, hugetlb_collapse will cause the requested range to be mapped
as if it were UFFDIO_CONTINUE'd already. The effects of any
UFFDIO_WRITEPROTECT calls may be undone by a call to MADV_COLLAPSE for
intersecting address ranges.

This commit is co-opting the same madvise mode that has been introduced
to synchronously collapse THPs. The function that does THP collapsing
has been renamed to madvise_collapse_thp.

As with the rest of the high-granularity mapping support, MADV_COLLAPSE
is only supported for shared VMAs right now.

MADV_COLLAPSE has the same synchronization as huge_pmd_unshare.

Signed-off-by: James Houghton <jthoughton@google.com>
---
 include/linux/huge_mm.h |  12 +--
 include/linux/hugetlb.h |   8 ++
 mm/hugetlb.c            | 164 ++++++++++++++++++++++++++++++++++++++++
 mm/khugepaged.c         |   4 +-
 mm/madvise.c            |  18 ++++-
 5 files changed, 197 insertions(+), 9 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index a1341fdcf666..5d1e3c980f74 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -218,9 +218,9 @@ void __split_huge_pud(struct vm_area_struct *vma, pud_t *pud,
 
 int hugepage_madvise(struct vm_area_struct *vma, unsigned long *vm_flags,
 		     int advice);
-int madvise_collapse(struct vm_area_struct *vma,
-		     struct vm_area_struct **prev,
-		     unsigned long start, unsigned long end);
+int madvise_collapse_thp(struct vm_area_struct *vma,
+			 struct vm_area_struct **prev,
+			 unsigned long start, unsigned long end);
 void vma_adjust_trans_huge(struct vm_area_struct *vma, unsigned long start,
 			   unsigned long end, long adjust_next);
 spinlock_t *__pmd_trans_huge_lock(pmd_t *pmd, struct vm_area_struct *vma);
@@ -367,9 +367,9 @@ static inline int hugepage_madvise(struct vm_area_struct *vma,
 	return -EINVAL;
 }
 
-static inline int madvise_collapse(struct vm_area_struct *vma,
-				   struct vm_area_struct **prev,
-				   unsigned long start, unsigned long end)
+static inline int madvise_collapse_thp(struct vm_area_struct *vma,
+				       struct vm_area_struct **prev,
+				       unsigned long start, unsigned long end)
 {
 	return -EINVAL;
 }
diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index c8524ac49b24..e1baf939afb6 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -1298,6 +1298,8 @@ bool hugetlb_hgm_eligible(struct vm_area_struct *vma);
 int hugetlb_alloc_largest_pte(struct hugetlb_pte *hpte, struct mm_struct *mm,
 			      struct vm_area_struct *vma, unsigned long start,
 			      unsigned long end);
+int hugetlb_collapse(struct mm_struct *mm, struct vm_area_struct *vma,
+		     unsigned long start, unsigned long end);
 #else
 static inline bool hugetlb_hgm_enabled(struct vm_area_struct *vma)
 {
@@ -1318,6 +1320,12 @@ int hugetlb_alloc_largest_pte(struct hugetlb_pte *hpte, struct mm_struct *mm,
 {
 	return -EINVAL;
 }
+static inline
+int hugetlb_collapse(struct mm_struct *mm, struct vm_area_struct *vma,
+		     unsigned long start, unsigned long end)
+{
+	return -EINVAL;
+}
 #endif
 
 static inline spinlock_t *huge_pte_lock(struct hstate *h,
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 5b6215e03fe1..388c46c7e77a 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -7852,6 +7852,170 @@ int hugetlb_alloc_largest_pte(struct hugetlb_pte *hpte, struct mm_struct *mm,
 	return 0;
 }
 
+static bool hugetlb_hgm_collapsable(struct vm_area_struct *vma)
+{
+	if (!hugetlb_hgm_eligible(vma))
+		return false;
+	if (!vma->vm_private_data)	/* vma lock required for collapsing */
+		return false;
+	return true;
+}
+
+/*
+ * Collapse the address range from @start to @end to be mapped optimally.
+ *
+ * This is only valid for shared mappings. The main use case for this function
+ * is following UFFDIO_CONTINUE. If a user UFFDIO_CONTINUEs an entire hugepage
+ * by calling UFFDIO_CONTINUE once for each 4K region, the kernel doesn't know
+ * to collapse the mapping after the final UFFDIO_CONTINUE. Instead, we leave
+ * it up to userspace to tell us to do so, via MADV_COLLAPSE.
+ *
+ * Any holes in the mapping will be filled. If there is no page in the
+ * pagecache for a region we're collapsing, the PTEs will be cleared.
+ *
+ * If high-granularity PTEs are uffd-wp markers, those markers will be dropped.
+ */
+int hugetlb_collapse(struct mm_struct *mm, struct vm_area_struct *vma,
+			    unsigned long start, unsigned long end)
+{
+	struct hstate *h = hstate_vma(vma);
+	struct address_space *mapping = vma->vm_file->f_mapping;
+	struct mmu_notifier_range range;
+	struct mmu_gather tlb;
+	unsigned long curr = start;
+	int ret = 0;
+	struct page *hpage, *subpage;
+	pgoff_t idx;
+	bool writable = vma->vm_flags & VM_WRITE;
+	bool shared = vma->vm_flags & VM_SHARED;
+	struct hugetlb_pte hpte;
+	pte_t entry;
+
+	/*
+	 * This is only supported for shared VMAs, because we need to look up
+	 * the page to use for any PTEs we end up creating.
+	 */
+	if (!shared)
+		return -EINVAL;
+
+	/* If HGM is not enabled, there is nothing to collapse. */
+	if (!hugetlb_hgm_enabled(vma))
+		return 0;
+
+	/*
+	 * We lost the VMA lock after splitting, so we can't safely collapse.
+	 * We could improve this in the future (like take the mmap_lock for
+	 * writing and try again), but for now just fail with ENOMEM.
+	 */
+	if (unlikely(!hugetlb_hgm_collapsable(vma)))
+		return -ENOMEM;
+
+	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, vma, mm,
+				start, end);
+	mmu_notifier_invalidate_range_start(&range);
+	tlb_gather_mmu(&tlb, mm);
+
+	/*
+	 * Grab the VMA lock and mapping sem for writing. This will prevent
+	 * concurrent high-granularity page table walks, so that we can safely
+	 * collapse and free page tables.
+	 *
+	 * This is the same locking that huge_pmd_unshare requires.
+	 */
+	hugetlb_vma_lock_write(vma);
+	i_mmap_lock_write(vma->vm_file->f_mapping);
+
+	while (curr < end) {
+		ret = hugetlb_alloc_largest_pte(&hpte, mm, vma, curr, end);
+		if (ret)
+			goto out;
+
+		entry = huge_ptep_get(hpte.ptep);
+
+		/*
+		 * There is no work to do if the PTE doesn't point to page
+		 * tables.
+		 */
+		if (!pte_present(entry))
+			goto next_hpte;
+		if (hugetlb_pte_present_leaf(&hpte, entry))
+			goto next_hpte;
+
+		idx = vma_hugecache_offset(h, vma, curr);
+		hpage = find_get_page(mapping, idx);
+
+		if (hpage && !HPageMigratable(hpage)) {
+			/*
+			 * Don't collapse a mapping to a page that is pending
+			 * a migration. Migration swap entries may have placed
+			 * in the page table.
+			 */
+			ret = -EBUSY;
+			put_page(hpage);
+			goto out;
+		}
+
+		if (hpage && PageHWPoison(hpage)) {
+			/*
+			 * Don't collapse a mapping to a page that is
+			 * hwpoisoned.
+			 */
+			ret = -EHWPOISON;
+			put_page(hpage);
+			/*
+			 * By setting ret to -EHWPOISON, if nothing else
+			 * happens, we will tell userspace that we couldn't
+			 * fully collapse everything due to poison.
+			 *
+			 * Skip this page, and continue to collapse the rest
+			 * of the mapping.
+			 */
+			curr = (curr & huge_page_mask(h)) + huge_page_size(h);
+			continue;
+		}
+
+		/*
+		 * Clear all the PTEs, and drop ref/mapcounts
+		 * (on tlb_finish_mmu).
+		 */
+		__unmap_hugepage_range(&tlb, vma, curr,
+			curr + hugetlb_pte_size(&hpte),
+			NULL,
+			ZAP_FLAG_DROP_MARKER);
+		/* Free the PTEs. */
+		hugetlb_free_pgd_range(&tlb,
+				curr, curr + hugetlb_pte_size(&hpte),
+				curr, curr + hugetlb_pte_size(&hpte));
+		if (!hpage) {
+			huge_pte_clear(mm, curr, hpte.ptep,
+					hugetlb_pte_size(&hpte));
+			goto next_hpte;
+		}
+
+		page_dup_file_rmap(hpage, true);
+
+		subpage = hugetlb_find_subpage(h, hpage, curr);
+		entry = make_huge_pte_with_shift(vma, subpage,
+						 writable, hpte.shift);
+		set_huge_pte_at(mm, curr, hpte.ptep, entry);
+next_hpte:
+		curr += hugetlb_pte_size(&hpte);
+
+		if (curr < end) {
+			/* Don't hold the VMA lock for too long. */
+			hugetlb_vma_unlock_write(vma);
+			cond_resched();
+			hugetlb_vma_lock_write(vma);
+		}
+	}
+out:
+	i_mmap_unlock_write(vma->vm_file->f_mapping);
+	hugetlb_vma_unlock_write(vma);
+	tlb_finish_mmu(&tlb);
+	mmu_notifier_invalidate_range_end(&range);
+	return ret;
+}
+
 #endif /* CONFIG_HUGETLB_HIGH_GRANULARITY_MAPPING */
 
 /*
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index e1c7c1f357ef..cbeb7f00f1bf 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -2718,8 +2718,8 @@ static int madvise_collapse_errno(enum scan_result r)
 	}
 }
 
-int madvise_collapse(struct vm_area_struct *vma, struct vm_area_struct **prev,
-		     unsigned long start, unsigned long end)
+int madvise_collapse_thp(struct vm_area_struct *vma, struct vm_area_struct **prev,
+			 unsigned long start, unsigned long end)
 {
 	struct collapse_control *cc;
 	struct mm_struct *mm = vma->vm_mm;
diff --git a/mm/madvise.c b/mm/madvise.c
index 04ee28992e52..fec47e9f845b 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -1029,6 +1029,18 @@ static int madvise_split(struct vm_area_struct *vma,
 	return 0;
 }
 
+static int madvise_collapse(struct vm_area_struct *vma,
+			    struct vm_area_struct **prev,
+			    unsigned long start, unsigned long end)
+{
+	if (is_vm_hugetlb_page(vma)) {
+		*prev = vma;
+		return hugetlb_collapse(vma->vm_mm, vma, start, end);
+	}
+
+	return madvise_collapse_thp(vma, prev, start, end);
+}
+
 /*
  * Apply an madvise behavior to a region of a vma.  madvise_update_vma
  * will handle splitting a vm area into separate areas, each area with its own
@@ -1205,6 +1217,9 @@ madvise_behavior_valid(int behavior)
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 	case MADV_HUGEPAGE:
 	case MADV_NOHUGEPAGE:
+#endif
+#if defined(CONFIG_HUGETLB_HIGH_GRANULARITY_MAPPING) || \
+		defined(CONFIG_TRANSPARENT_HUGEPAGE)
 	case MADV_COLLAPSE:
 #endif
 #ifdef CONFIG_HUGETLB_HIGH_GRANULARITY_MAPPING
@@ -1398,7 +1413,8 @@ int madvise_set_anon_name(struct mm_struct *mm, unsigned long start,
  *  MADV_NOHUGEPAGE - mark the given range as not worth being backed by
  *		transparent huge pages so the existing pages will not be
  *		coalesced into THP and new pages will not be allocated as THP.
- *  MADV_COLLAPSE - synchronously coalesce pages into new THP.
+ *  MADV_COLLAPSE - synchronously coalesce pages into new THP, or, for HugeTLB
+ *		pages, collapse the mapping.
  *  MADV_DONTDUMP - the application wants to prevent pages in the given range
  *		from being included in its core dump.
  *  MADV_DODUMP - cancel MADV_DONTDUMP: no longer exclude from core dump.
-- 
2.39.0.314.g84b9a713c41-goog

