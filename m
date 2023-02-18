Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AF9669B6C4
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 01:31:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbjBRA37 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 19:29:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbjBRA33 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 19:29:29 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D9D56C012
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 16:29:01 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5365a2b9e4fso19055427b3.15
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 16:29:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Of81VsYOGaJiC6DFXM6sxGYcirLfRpMhUkY/yI+h7kc=;
        b=faTIHphcD3M2ErzVxaHvUUDOZt6TLoZA4Xzil1xu0/G1//a74JWzTWI0tyBHfpuNha
         JuiaDE7sP9JLYbJHclSCn1zLcoQow2nzU2lXYNGugjxvfih5hgYInPRhhLcCctGhNLo3
         KwFJIDeU1tiOhE1xHmEihdXHq7cGiCAhH0q2zoPtNQjwpXYxrAP0w6dyKJSxmBEiRhDd
         7V/h4dydjcI+nPCAOZLKD8SpPxrMq1uA1FOYjkSBWBh0f82wcANh+dEFe2hWIerkaZPV
         R7mY45T1lGt6PPZpw4zMX2iPUJ6tZ/5sKy1qlMP0mc3wUXq6LpfnZyl3pSM6f22otbp5
         BCNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Of81VsYOGaJiC6DFXM6sxGYcirLfRpMhUkY/yI+h7kc=;
        b=dpe7MO5yNPjJOD6pNxRuArZ7++05XNtRPP8xXitwwP3HTMVFevvgFpgg6YonnxYYqG
         eY0MOVA15pZ6I1g4FtanrJYSwOtDQgJ9P2rBPLde1sW+ey016G1Vo8fC16JM+nvNYulj
         +2tNx5LLD0hbO05cnV5+xbjsBOPvloZehtkxSUbLSXtj8mtTiMXxEyt1W9FFEOz4/d4t
         GZiiOagUHShfD9aFRAmE9qKM3So62cDuzW6SK1KWQ/dQQQVWqTuavJ70dGc6NgcAEYlK
         PKSG9nZbZADSlPA+2KnMm1EKG9NzKoztLrV5paXcdYSj0+sZbhxwTYHBFoThxm9wEzkF
         uE4g==
X-Gm-Message-State: AO0yUKUCkRCKGExYhIeAB3biDJOYmrjFQPJSxlM6WIKLnQ4bZCt/kqIU
        qUPc9lYYqwEglHxqx4AEWiVjNf/ryU5gxqUm
X-Google-Smtp-Source: AK7set9tTFKkYw3kZzJu84DBO6wAm5FU1Hz3uatyB+dq4su6im3hpPVARJ7+PJEJD7fhUdzldcN3emm0/I1SXTEb
X-Received: from jthoughton.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:2a4f])
 (user=jthoughton job=sendgmr) by 2002:a5b:889:0:b0:95b:7778:5158 with SMTP id
 e9-20020a5b0889000000b0095b77785158mr63089ybq.12.1676680140991; Fri, 17 Feb
 2023 16:29:00 -0800 (PST)
Date:   Sat, 18 Feb 2023 00:27:51 +0000
In-Reply-To: <20230218002819.1486479-1-jthoughton@google.com>
Mime-Version: 1.0
References: <20230218002819.1486479-1-jthoughton@google.com>
X-Mailer: git-send-email 2.39.2.637.g21b0678d19-goog
Message-ID: <20230218002819.1486479-19-jthoughton@google.com>
Subject: [PATCH v2 18/46] hugetlb: add HGM support to __unmap_hugepage_range
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

Enlighten __unmap_hugepage_range to deal with high-granularity mappings.
This doesn't change its API; it still must be called with hugepage
alignment, but it will correctly unmap hugepages that have been mapped
at high granularity.

Eventually, functionality here can be expanded to allow users to call
MADV_DONTNEED on PAGE_SIZE-aligned sections of a hugepage, but that is
not done here.

Introduce hugetlb_remove_rmap to properly decrement mapcount for
high-granularity-mapped HugeTLB pages.

Signed-off-by: James Houghton <jthoughton@google.com>

diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
index b46617207c93..31267471760e 100644
--- a/include/asm-generic/tlb.h
+++ b/include/asm-generic/tlb.h
@@ -598,9 +598,9 @@ static inline void tlb_flush_p4d_range(struct mmu_gather *tlb,
 		__tlb_remove_tlb_entry(tlb, ptep, address);	\
 	} while (0)
 
-#define tlb_remove_huge_tlb_entry(h, tlb, ptep, address)	\
+#define tlb_remove_huge_tlb_entry(tlb, hpte, address)	\
 	do {							\
-		unsigned long _sz = huge_page_size(h);		\
+		unsigned long _sz = hugetlb_pte_size(&hpte);	\
 		if (_sz >= P4D_SIZE)				\
 			tlb_flush_p4d_range(tlb, address, _sz);	\
 		else if (_sz >= PUD_SIZE)			\
@@ -609,7 +609,7 @@ static inline void tlb_flush_p4d_range(struct mmu_gather *tlb,
 			tlb_flush_pmd_range(tlb, address, _sz);	\
 		else						\
 			tlb_flush_pte_range(tlb, address, _sz);	\
-		__tlb_remove_tlb_entry(tlb, ptep, address);	\
+		__tlb_remove_tlb_entry(tlb, hpte.ptep, address);\
 	} while (0)
 
 /**
diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index b767b6889dea..1a1a71868dfd 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -160,6 +160,9 @@ struct hugepage_subpool *hugepage_new_subpool(struct hstate *h, long max_hpages,
 						long min_hpages);
 void hugepage_put_subpool(struct hugepage_subpool *spool);
 
+void hugetlb_remove_rmap(struct page *subpage, unsigned long shift,
+			 struct hstate *h, struct vm_area_struct *vma);
+
 void hugetlb_dup_vma_private(struct vm_area_struct *vma);
 void clear_vma_resv_huge_pages(struct vm_area_struct *vma);
 int hugetlb_sysctl_handler(struct ctl_table *, int, void *, size_t *, loff_t *);
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index ed1d806020de..ecf1a28dbaaa 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -120,6 +120,28 @@ enum hugetlb_level hpage_size_to_level(unsigned long sz)
 	return HUGETLB_LEVEL_PGD;
 }
 
+void hugetlb_remove_rmap(struct page *subpage, unsigned long shift,
+			 struct hstate *h, struct vm_area_struct *vma)
+{
+	struct page *hpage = compound_head(subpage);
+
+	if (shift == huge_page_shift(h)) {
+		VM_BUG_ON_PAGE(subpage != hpage, subpage);
+		page_remove_rmap(hpage, vma, true);
+	} else {
+		unsigned long nr_subpages = 1UL << (shift - PAGE_SHIFT);
+		struct page *final_page = &subpage[nr_subpages];
+
+		VM_BUG_ON_PAGE(HPageVmemmapOptimized(hpage), hpage);
+		/*
+		 * Decrement the mapcount on each page that is getting
+		 * unmapped.
+		 */
+		for (; subpage < final_page; ++subpage)
+			page_remove_rmap(subpage, vma, false);
+	}
+}
+
 static inline bool subpool_is_free(struct hugepage_subpool *spool)
 {
 	if (spool->count)
@@ -5466,10 +5488,10 @@ static void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct
 {
 	struct mm_struct *mm = vma->vm_mm;
 	unsigned long address;
-	pte_t *ptep;
+	struct hugetlb_pte hpte;
 	pte_t pte;
 	spinlock_t *ptl;
-	struct page *page;
+	struct page *hpage, *subpage;
 	struct hstate *h = hstate_vma(vma);
 	unsigned long sz = huge_page_size(h);
 	unsigned long last_addr_mask;
@@ -5479,35 +5501,33 @@ static void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct
 	BUG_ON(start & ~huge_page_mask(h));
 	BUG_ON(end & ~huge_page_mask(h));
 
-	/*
-	 * This is a hugetlb vma, all the pte entries should point
-	 * to huge page.
-	 */
-	tlb_change_page_size(tlb, sz);
 	tlb_start_vma(tlb, vma);
 
 	last_addr_mask = hugetlb_mask_last_page(h);
 	address = start;
-	for (; address < end; address += sz) {
-		ptep = hugetlb_walk(vma, address, sz);
-		if (!ptep) {
-			address |= last_addr_mask;
+
+	while (address < end) {
+		if (hugetlb_full_walk(&hpte, vma, address)) {
+			address = (address | last_addr_mask) + sz;
 			continue;
 		}
 
-		ptl = huge_pte_lock(h, mm, ptep);
-		if (huge_pmd_unshare(mm, vma, address, ptep)) {
+		ptl = hugetlb_pte_lock(&hpte);
+		if (hugetlb_pte_size(&hpte) == sz &&
+		    huge_pmd_unshare(mm, vma, address, hpte.ptep)) {
 			spin_unlock(ptl);
 			tlb_flush_pmd_range(tlb, address & PUD_MASK, PUD_SIZE);
 			force_flush = true;
 			address |= last_addr_mask;
+			address += sz;
 			continue;
 		}
 
-		pte = huge_ptep_get(ptep);
+		pte = huge_ptep_get(hpte.ptep);
+
 		if (huge_pte_none(pte)) {
 			spin_unlock(ptl);
-			continue;
+			goto next_hpte;
 		}
 
 		/*
@@ -5523,24 +5543,35 @@ static void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct
 			 */
 			if (pte_swp_uffd_wp_any(pte) &&
 			    !(zap_flags & ZAP_FLAG_DROP_MARKER))
-				set_huge_pte_at(mm, address, ptep,
+				set_huge_pte_at(mm, address, hpte.ptep,
 						make_pte_marker(PTE_MARKER_UFFD_WP));
 			else
-				huge_pte_clear(mm, address, ptep, sz);
+				huge_pte_clear(mm, address, hpte.ptep,
+						hugetlb_pte_size(&hpte));
+			spin_unlock(ptl);
+			goto next_hpte;
+		}
+
+		if (unlikely(!hugetlb_pte_present_leaf(&hpte, pte))) {
+			/*
+			 * We raced with someone splitting out from under us.
+			 * Retry the walk.
+			 */
 			spin_unlock(ptl);
 			continue;
 		}
 
-		page = pte_page(pte);
+		subpage = pte_page(pte);
+		hpage = compound_head(subpage);
 		/*
 		 * If a reference page is supplied, it is because a specific
 		 * page is being unmapped, not a range. Ensure the page we
 		 * are about to unmap is the actual page of interest.
 		 */
 		if (ref_page) {
-			if (page != ref_page) {
+			if (hpage != ref_page) {
 				spin_unlock(ptl);
-				continue;
+				goto next_hpte;
 			}
 			/*
 			 * Mark the VMA as having unmapped its page so that
@@ -5550,25 +5581,32 @@ static void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct
 			set_vma_resv_flags(vma, HPAGE_RESV_UNMAPPED);
 		}
 
-		pte = huge_ptep_get_and_clear(mm, address, ptep);
-		tlb_remove_huge_tlb_entry(h, tlb, ptep, address);
+		pte = huge_ptep_get_and_clear(mm, address, hpte.ptep);
+		tlb_change_page_size(tlb, hugetlb_pte_size(&hpte));
+		tlb_remove_huge_tlb_entry(tlb, hpte, address);
 		if (huge_pte_dirty(pte))
-			set_page_dirty(page);
+			set_page_dirty(hpage);
 		/* Leave a uffd-wp pte marker if needed */
 		if (huge_pte_uffd_wp(pte) &&
 		    !(zap_flags & ZAP_FLAG_DROP_MARKER))
-			set_huge_pte_at(mm, address, ptep,
+			set_huge_pte_at(mm, address, hpte.ptep,
 					make_pte_marker(PTE_MARKER_UFFD_WP));
-		hugetlb_count_sub(pages_per_huge_page(h), mm);
-		page_remove_rmap(page, vma, true);
+		hugetlb_count_sub(hugetlb_pte_size(&hpte)/PAGE_SIZE, mm);
+		hugetlb_remove_rmap(subpage, hpte.shift, h, vma);
 
 		spin_unlock(ptl);
-		tlb_remove_page_size(tlb, page, huge_page_size(h));
 		/*
-		 * Bail out after unmapping reference page if supplied
+		 * Lower the reference count on the head page.
+		 */
+		tlb_remove_page_size(tlb, hpage, sz);
+		/*
+		 * Bail out after unmapping reference page if supplied,
+		 * and there's only one PTE mapping this page.
 		 */
-		if (ref_page)
+		if (ref_page && hugetlb_pte_size(&hpte) == sz)
 			break;
+next_hpte:
+		address += hugetlb_pte_size(&hpte);
 	}
 	tlb_end_vma(tlb, vma);
 
@@ -5846,7 +5884,7 @@ static vm_fault_t hugetlb_wp(struct mm_struct *mm, struct vm_area_struct *vma,
 		/* Break COW or unshare */
 		huge_ptep_clear_flush(vma, haddr, ptep);
 		mmu_notifier_invalidate_range(mm, range.start, range.end);
-		page_remove_rmap(old_page, vma, true);
+		hugetlb_remove_rmap(old_page, huge_page_shift(h), h, vma);
 		hugepage_add_new_anon_rmap(new_folio, vma, haddr);
 		set_huge_pte_at(mm, haddr, ptep,
 				make_huge_pte(vma, &new_folio->page, !unshare));
-- 
2.39.2.637.g21b0678d19-goog

