Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEAE6607C84
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 18:40:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231332AbiJUQkh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 12:40:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231321AbiJUQjC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 12:39:02 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C37E2852A0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 09:37:51 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-367c2e72a6dso34353827b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 09:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9XBceLY8DUUPXaMS6s0AnMTF5dFEtD/aKN5y5ep44a8=;
        b=OgH1PzymDfy3mw5S5P/GrBugnAOY7dXplImrNOPJNzGgEj5Ynkk+R2pxayxr0P31L+
         I7KeAWrzVvfqQft9BqHY8unXCkX4tbl4+yOLciSqD0qIO+ksbnyovctrGta/pIV8JNaG
         W6hTpfrnvPg+23rAzFRCtUicfoL9p4+j7RCT+Huce0P9QHhJj1qJU0NBfwFm3ad7u1Th
         CIpBC/83vC+apa7HIzMVeXUPgw0BhfSreH1K/aS4Ytz1C/SF7HhYjjJiarG3JHxSYM/N
         OlbY1e6bk+zMD25bt+/pLDkYPVZFHVfTiNohjOvsYUlfTvGIg+EDo6vuDIqJC1bsWShr
         W5sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9XBceLY8DUUPXaMS6s0AnMTF5dFEtD/aKN5y5ep44a8=;
        b=KsUut/ItvzqkeYaTORn+oMAlBxYO7ZsOpEuBcRwPh3QSJjmbhgBuG2WzsfIcweT2tg
         fmvTHPj3Bl4OPqYhVQut6X6qgPfgNPnVOMO2Zdo5/gN3mmL7iA2zrUcq49sZ6WppXaf2
         fXcFe0EgdQ1YHApw+fIWjtbaieVFvLH9nLD8FiADZmzxFZjtAUtHXAlkQzpvnuO4U/h9
         qxxjzpBY8JQbpkO2juabnxf90tOmBUebD+bPLtqjmWDRQ4CKeK0COtxa9g05sshHNKsS
         PM3cFt+1kgY9O645BOPmYypNSjSLc22NFp5CC63pg+xKOQK1sLbU5GR0lIQ6CDTs9n5W
         2TVw==
X-Gm-Message-State: ACrzQf3y3m4YlkxxbviSRZQ62TESxYIlgm/9f9wJVV0b94BcTh0q8Og0
        7c+RN51K53kBKyWb4nCzULTGKdQ9DMgezzRo
X-Google-Smtp-Source: AMsMyM56wfg6tebFxMZ6dZr5I9ipUQ4dmY2vdBMm2uXtPrwrmCPjNUqRAXwKZ9096wT8uJYWAxw1NCWSaLMcXzXh
X-Received: from jthoughton.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:2a4f])
 (user=jthoughton job=sendgmr) by 2002:a25:5:0:b0:6c5:3855:d87b with SMTP id
 5-20020a250005000000b006c53855d87bmr18032790yba.84.1666370270050; Fri, 21 Oct
 2022 09:37:50 -0700 (PDT)
Date:   Fri, 21 Oct 2022 16:36:52 +0000
In-Reply-To: <20221021163703.3218176-1-jthoughton@google.com>
Mime-Version: 1.0
References: <20221021163703.3218176-1-jthoughton@google.com>
X-Mailer: git-send-email 2.38.0.135.g90850a2211-goog
Message-ID: <20221021163703.3218176-37-jthoughton@google.com>
Subject: [RFC PATCH v2 36/47] hugetlb: add MADV_COLLAPSE for hugetlb
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

Signed-off-by: James Houghton <jthoughton@google.com>
---
 include/linux/huge_mm.h |  12 ++--
 include/linux/hugetlb.h |   8 +++
 mm/hugetlb.c            | 142 ++++++++++++++++++++++++++++++++++++++++
 mm/khugepaged.c         |   4 +-
 mm/madvise.c            |  24 ++++++-
 5 files changed, 181 insertions(+), 9 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 5d861905df46..fc2813db5e2e 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -226,9 +226,9 @@ void __split_huge_pud(struct vm_area_struct *vma, pud_t *pud,
 
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
@@ -373,9 +373,9 @@ static inline int hugepage_madvise(struct vm_area_struct *vma,
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
index 00c22a84a1c6..5378b98cc7b8 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -1276,6 +1276,8 @@ int enable_hugetlb_hgm(struct vm_area_struct *vma);
 int hugetlb_alloc_largest_pte(struct hugetlb_pte *hpte, struct mm_struct *mm,
 			      struct vm_area_struct *vma, unsigned long start,
 			      unsigned long end);
+int hugetlb_collapse(struct mm_struct *mm, struct vm_area_struct *vma,
+		     unsigned long start, unsigned long end);
 #else
 static inline bool hugetlb_hgm_enabled(struct vm_area_struct *vma)
 {
@@ -1297,6 +1299,12 @@ int hugetlb_alloc_largest_pte(struct hugetlb_pte *hpte, struct mm_struct *mm,
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
index c25d3cd73ac9..d80db81a1fa5 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -7921,6 +7921,148 @@ int hugetlb_alloc_largest_pte(struct hugetlb_pte *hpte, struct mm_struct *mm,
 	return 0;
 }
 
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
+	if (!hugetlb_hgm_enabled(vma))
+		return 0;
+
+	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, vma, mm,
+				start, end);
+	mmu_notifier_invalidate_range_start(&range);
+	tlb_gather_mmu(&tlb, mm);
+
+	/*
+	 * Grab the lock VMA lock for writing. This will prevent concurrent
+	 * high-granularity page table walks, so that we can safely collapse
+	 * and free page tables.
+	 */
+	hugetlb_vma_lock_write(vma);
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
+	hugetlb_vma_unlock_write(vma);
+	tlb_finish_mmu(&tlb);
+	mmu_notifier_invalidate_range_end(&range);
+	return ret;
+}
+
 #endif /* CONFIG_HUGETLB_HIGH_GRANULARITY_MAPPING */
 
 /*
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 4734315f7940..70796824e9d2 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -2555,8 +2555,8 @@ static int madvise_collapse_errno(enum scan_result r)
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
index 2baa93ca2310..6aed9bd68476 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -986,6 +986,24 @@ static long madvise_remove(struct vm_area_struct *vma,
 	return error;
 }
 
+static int madvise_collapse(struct vm_area_struct *vma,
+			    struct vm_area_struct **prev,
+			    unsigned long start, unsigned long end)
+{
+	/* Only allow collapsing for HGM-enabled, shared mappings. */
+	if (is_vm_hugetlb_page(vma)) {
+		*prev = vma;
+		if (!hugetlb_hgm_eligible(vma))
+			return -EINVAL;
+		if (!hugetlb_hgm_enabled(vma))
+			return 0;
+		return hugetlb_collapse(vma->vm_mm, vma, start, end);
+	}
+
+	return madvise_collapse_thp(vma, prev, start, end);
+
+}
+
 /*
  * Apply an madvise behavior to a region of a vma.  madvise_update_vma
  * will handle splitting a vm area into separate areas, each area with its own
@@ -1157,6 +1175,9 @@ madvise_behavior_valid(int behavior)
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 	case MADV_HUGEPAGE:
 	case MADV_NOHUGEPAGE:
+#endif
+#if defined(CONFIG_HUGETLB_HIGH_GRANULARITY_MAPPING) || \
+		defined(CONFIG_TRANSPARENT_HUGEPAGE)
 	case MADV_COLLAPSE:
 #endif
 	case MADV_DONTDUMP:
@@ -1347,7 +1368,8 @@ int madvise_set_anon_name(struct mm_struct *mm, unsigned long start,
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
2.38.0.135.g90850a2211-goog

