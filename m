Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D00BC69B6D6
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 01:32:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230209AbjBRAb1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 19:31:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230148AbjBRAaM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 19:30:12 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92C5A6A073
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 16:29:31 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id y33-20020a25ad21000000b00953ffdfbe1aso2197142ybi.23
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 16:29:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=H5Ss3Q8p6Tm/C0evsWap3MC9xTDp36cPJKkNtoaVKGQ=;
        b=PyoCsPHZKLuSeDOLvIw+lkPHKwn65TPzd0CfsjOfssDvwh0+NtYbibsVfgVsSmNssl
         qradQv+EgXsSDZiodu5lljG1t2o7w6TQ698wIv5JgVXeUBOB3Wnz/Bcq5yevJLKg+nve
         VjJMx+Txfk3k/LgV2w2hnh91g802PdgQo2AseWuhEWbpXHvGj7DQ7qL06+fGAKkwmyeX
         eLgkDxIvUSbfleeEETs9PQLkB3WeTXxJkEgHYOVpxDZGz96scTefQeiZRq4DuIrveLRP
         xg9PkBMYr1jykjB8E7MRM4w0AuZAeJ4hrxxNWXPe2GYe6/W0zfWOPuKMd0nX/tiporx7
         sscg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H5Ss3Q8p6Tm/C0evsWap3MC9xTDp36cPJKkNtoaVKGQ=;
        b=DCv3v9qUbqnOBwm9qYfSZ2sB8aFXYQT/35Kswiqe0Ez7FplF9Mj052MCrOJlJ7iSCs
         CMkmCzKUR64pzuFEFnDE2VRF2RnZIXDuvOGXMKM3/gE0s/B8NGAe/TsUhHgxSm58BLQv
         DF5xB/19y37frKRva10Y3ABSWL3VTO08mg5qPCXXpOFEMG8lsiqwta6DphEIk7Vl0Psh
         cFYeNSS57o0/4FghkjEvRwO9BpQtQtvrO5GJ9cqd4jNhs5wRJpJJbhKeqVKsG7jtxBwS
         FykV3yZhQZ8tr6GD25HCTkTWPb4Lhp1/Zx3waSQpG6Mry6aIQmLqPn49U/5F/cSwdI38
         ekvw==
X-Gm-Message-State: AO0yUKVHQ1lkRVjjfTZVU6xRhxOBCSSucoSFd0IyTaIvTdSMORF9GpnL
        GUoU9YOH2f97fWiELPQMYMuewzsH7uwJbfs7
X-Google-Smtp-Source: AK7set9/STmUDdPiVjVMlyX9HVfyhKJ5jo2Gv2WTisaTY68C7uxLi9/y0Dvn93Bgqo0KqJ6aTwnqpO+gxhHqoPwi
X-Received: from jthoughton.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:2a4f])
 (user=jthoughton job=sendgmr) by 2002:a05:6902:107:b0:914:1ef3:e98a with SMTP
 id o7-20020a056902010700b009141ef3e98amr168149ybh.213.1676680158302; Fri, 17
 Feb 2023 16:29:18 -0800 (PST)
Date:   Sat, 18 Feb 2023 00:28:07 +0000
In-Reply-To: <20230218002819.1486479-1-jthoughton@google.com>
Mime-Version: 1.0
References: <20230218002819.1486479-1-jthoughton@google.com>
X-Mailer: git-send-email 2.39.2.637.g21b0678d19-goog
Message-ID: <20230218002819.1486479-35-jthoughton@google.com>
Subject: [PATCH v2 34/46] hugetlb: add MADV_COLLAPSE for hugetlb
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

MADV_COLLAPSE for HugeTLB takes the mmap_lock for writing.

It is important that we check PageHWPoison before checking
!HPageMigratable, as PageHWPoison implies !HPageMigratable.
!PageHWPoison && !HPageMigratable means that the page has been isolated
for migration.

Signed-off-by: James Houghton <jthoughton@google.com>

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 70bd867eba94..fa63a56ebaf0 100644
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
@@ -358,9 +358,9 @@ static inline int hugepage_madvise(struct vm_area_struct *vma,
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
index e0e51bb06112..6cd4ae08d84d 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -1278,6 +1278,8 @@ bool hugetlb_hgm_eligible(struct vm_area_struct *vma);
 int hugetlb_alloc_largest_pte(struct hugetlb_pte *hpte, struct mm_struct *mm,
 			      struct vm_area_struct *vma, unsigned long start,
 			      unsigned long end);
+int hugetlb_collapse(struct mm_struct *mm, unsigned long start,
+		     unsigned long end);
 #else
 static inline bool hugetlb_hgm_enabled(struct vm_area_struct *vma)
 {
@@ -1298,6 +1300,12 @@ int hugetlb_alloc_largest_pte(struct hugetlb_pte *hpte, struct mm_struct *mm,
 {
 	return -EINVAL;
 }
+static inline
+int hugetlb_collapse(struct mm_struct *mm, unsigned long start,
+		     unsigned long end)
+{
+	return -EINVAL;
+}
 #endif
 
 static inline spinlock_t *huge_pte_lock(struct hstate *h,
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index a00b4ac07046..c4d189e5f1fd 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -8014,6 +8014,158 @@ int hugetlb_alloc_largest_pte(struct hugetlb_pte *hpte, struct mm_struct *mm,
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
+static int __hugetlb_collapse(struct mm_struct *mm, struct vm_area_struct *vma,
+			      unsigned long start, unsigned long end)
+{
+	struct hstate *h = hstate_vma(vma);
+	struct address_space *mapping = vma->vm_file->f_mapping;
+	struct mmu_notifier_range range;
+	struct mmu_gather tlb;
+	unsigned long curr = start;
+	int ret = 0;
+	struct folio *folio;
+	struct page *subpage;
+	pgoff_t idx;
+	bool writable = vma->vm_flags & VM_WRITE;
+	struct hugetlb_pte hpte;
+	pte_t entry;
+	spinlock_t *ptl;
+
+	/*
+	 * This is only supported for shared VMAs, because we need to look up
+	 * the page to use for any PTEs we end up creating.
+	 */
+	if (!(vma->vm_flags & VM_MAYSHARE))
+		return -EINVAL;
+
+	/* If HGM is not enabled, there is nothing to collapse. */
+	if (!hugetlb_hgm_enabled(vma))
+		return 0;
+
+	tlb_gather_mmu(&tlb, mm);
+
+	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, mm, start, end);
+	mmu_notifier_invalidate_range_start(&range);
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
+		folio = filemap_get_folio(mapping, idx);
+
+		if (folio && folio_test_hwpoison(folio)) {
+			/*
+			 * Don't collapse a mapping to a page that is
+			 * hwpoisoned. The entire page will be poisoned.
+			 *
+			 * When HugeTLB supports poisoning PAGE_SIZE bits of
+			 * the hugepage, the logic here can be improved.
+			 *
+			 * Skip this page, and continue to collapse the rest
+			 * of the mapping.
+			 */
+			folio_put(folio);
+			curr = (curr & huge_page_mask(h)) + huge_page_size(h);
+			continue;
+		}
+
+		if (folio && !folio_test_hugetlb_migratable(folio)) {
+			/*
+			 * Don't collapse a mapping to a page that is pending
+			 * a migration. Migration swap entries may have placed
+			 * in the page table.
+			 */
+			ret = -EBUSY;
+			folio_put(folio);
+			goto out;
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
+
+		ptl = hugetlb_pte_lock(&hpte);
+
+		if (!folio) {
+			huge_pte_clear(mm, curr, hpte.ptep,
+					hugetlb_pte_size(&hpte));
+			spin_unlock(ptl);
+			goto next_hpte;
+		}
+
+		subpage = hugetlb_find_subpage(h, folio, curr);
+		entry = make_huge_pte_with_shift(vma, subpage,
+						 writable, hpte.shift);
+		hugetlb_add_file_rmap(subpage, hpte.shift, h, vma);
+		set_huge_pte_at(mm, curr, hpte.ptep, entry);
+		spin_unlock(ptl);
+next_hpte:
+		curr += hugetlb_pte_size(&hpte);
+	}
+out:
+	mmu_notifier_invalidate_range_end(&range);
+	tlb_finish_mmu(&tlb);
+
+	return ret;
+}
+
+int hugetlb_collapse(struct mm_struct *mm, unsigned long start,
+		     unsigned long end)
+{
+	int ret = 0;
+	struct vm_area_struct *vma;
+
+	mmap_write_lock(mm);
+	while (start < end || ret) {
+		vma = find_vma(mm, start);
+		if (!vma || !is_vm_hugetlb_page(vma)) {
+			ret = -EINVAL;
+			break;
+		}
+		ret = __hugetlb_collapse(mm, vma, start,
+				end < vma->vm_end ? end : vma->vm_end);
+		start = vma->vm_end;
+	}
+	mmap_write_unlock(mm);
+	return ret;
+}
+
 #endif /* CONFIG_HUGETLB_HIGH_GRANULARITY_MAPPING */
 
 /*
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 8dbc39896811..58cda5020537 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -2750,8 +2750,8 @@ static int madvise_collapse_errno(enum scan_result r)
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
index 8c004c678262..e121d135252a 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -1028,6 +1028,24 @@ static int madvise_split(struct vm_area_struct *vma,
 #endif
 }
 
+static int madvise_collapse(struct vm_area_struct *vma,
+			    struct vm_area_struct **prev,
+			    unsigned long start, unsigned long end)
+{
+	if (is_vm_hugetlb_page(vma)) {
+		struct mm_struct *mm = vma->vm_mm;
+		int ret;
+
+		*prev = NULL; /* tell sys_madvise we dropped the mmap lock */
+		mmap_read_unlock(mm);
+		ret = hugetlb_collapse(mm, start, end);
+		mmap_read_lock(mm);
+		return ret;
+	}
+
+	return madvise_collapse_thp(vma, prev, start, end);
+}
+
 /*
  * Apply an madvise behavior to a region of a vma.  madvise_update_vma
  * will handle splitting a vm area into separate areas, each area with its own
@@ -1204,6 +1222,9 @@ madvise_behavior_valid(int behavior)
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 	case MADV_HUGEPAGE:
 	case MADV_NOHUGEPAGE:
+#endif
+#if defined(CONFIG_HUGETLB_HIGH_GRANULARITY_MAPPING) || \
+		defined(CONFIG_TRANSPARENT_HUGEPAGE)
 	case MADV_COLLAPSE:
 #endif
 #ifdef CONFIG_HUGETLB_HIGH_GRANULARITY_MAPPING
@@ -1397,7 +1418,8 @@ int madvise_set_anon_name(struct mm_struct *mm, unsigned long start,
  *  MADV_NOHUGEPAGE - mark the given range as not worth being backed by
  *		transparent huge pages so the existing pages will not be
  *		coalesced into THP and new pages will not be allocated as THP.
- *  MADV_COLLAPSE - synchronously coalesce pages into new THP.
+ *  MADV_COLLAPSE - synchronously coalesce pages into new THP, or, for HugeTLB
+ *		pages, collapse the mapping.
  *  MADV_SPLIT - allow HugeTLB pages to be mapped at PAGE_SIZE. This allows
  *		UFFDIO_CONTINUE to accept PAGE_SIZE-aligned regions.
  *  MADV_DONTDUMP - the application wants to prevent pages in the given range
-- 
2.39.2.637.g21b0678d19-goog

