Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6D1E65E8D6
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 11:21:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232906AbjAEKVG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 05:21:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232621AbjAEKT4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 05:19:56 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4614B395E1
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 02:19:21 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-4700580ca98so305708967b3.9
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 02:19:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3kWM8DYu7DnV7Jv/QGJ6f3ppiIBnNL94nY50ZsYLZ48=;
        b=L2aTbeQAeNJJeiUCuWw/dfwAL4UVIBqWGH55xL0ZJpLs3sGFv6hFcIvCc0Ga7d/ieX
         hjmwK3ib7/cchvS/YNI5B2b8qO3orIA5BWZwCv046KSsSk68EciP1H12pdFZ0JnY3ID3
         pYb07IsQSWYw/0QL7lCbsdokm5Jdl9QVO58MurdRYCOYSbQ0K1s+CTWgqBbCQMbN52p3
         rBm+Mj78x+W8YyDclWaBCjNduKppB0sC5WajJ2RRtfrhbf2j86ceAoNxktgW6316luJG
         DMu0s3GTU3x/vCtEgoRMt2pwviQKJhe3xm5AQwX5rbR/oBcVLAk0J73laj0wxnS/nDXd
         glUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3kWM8DYu7DnV7Jv/QGJ6f3ppiIBnNL94nY50ZsYLZ48=;
        b=Up5cXJ2IgAH1VIX2OCrSLL2YhQW5d539HjgZaLQbzGeTX7ylaR2U4GaEaKncJl4j0V
         goOP0P4kTeC2b9thtDwy6YnfysfQtBlhh26+ckaCIvchixchYDW5jt3jPURHH0UeP4B2
         bs23mWissfy2zoTPePZp6ALMpRGIQj2zZcKYgxuY3lpqfzCgD6a6zhM1TaDBAxGVHLF9
         +bbsKs8/7oBQGRteuIMmtxqgTw2y6EAlBWmnMKYyTtGJ4o1sHj8Cb0L6W0QhSyVHGHXz
         jD9zEmaXFgmNEJBv9/OR3oLoUDOiA4UMON7zdC3Ha8TxUC2Z2Y0RyeMqdsrNvSjzzY8y
         1eTQ==
X-Gm-Message-State: AFqh2kph8w/cqC09MRs+/pnkfGbPntgGCZL0OrzZbfspElNwam3vm6gX
        8kvza/ndK708SBAio5nv68GuDjSF5MF/s9Mc
X-Google-Smtp-Source: AMrXdXvqOEL7ovL3FbMjk4okDrWCxN+YTjALnEUL0oRXnxb5KqHby493dqSvh11l+d52AF7sViTIqr3WdL+KcRjD
X-Received: from jthoughton.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:2a4f])
 (user=jthoughton job=sendgmr) by 2002:a25:aa4f:0:b0:717:e051:5d2d with SMTP
 id s73-20020a25aa4f000000b00717e0515d2dmr5822098ybi.474.1672913960512; Thu,
 05 Jan 2023 02:19:20 -0800 (PST)
Date:   Thu,  5 Jan 2023 10:18:15 +0000
In-Reply-To: <20230105101844.1893104-1-jthoughton@google.com>
Mime-Version: 1.0
References: <20230105101844.1893104-1-jthoughton@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20230105101844.1893104-18-jthoughton@google.com>
Subject: [PATCH 17/46] hugetlb: make unmapping compatible with
 high-granularity mappings
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

Enlighten __unmap_hugepage_range to deal with high-granularity mappings.
This doesn't change its API; it still must be called with hugepage
alignment, but it will correctly unmap hugepages that have been mapped
at high granularity.

The rules for mapcount and refcount here are:
 1. Refcount and mapcount are tracked on the head page.
 2. Each page table mapping into some of an hpage will increase that
    hpage's mapcount and refcount by 1.

Eventually, functionality here can be expanded to allow users to call
MADV_DONTNEED on PAGE_SIZE-aligned sections of a hugepage, but that is
not done here.

Signed-off-by: James Houghton <jthoughton@google.com>
---
 include/asm-generic/tlb.h |  6 ++--
 mm/hugetlb.c              | 74 ++++++++++++++++++++++++---------------
 2 files changed, 48 insertions(+), 32 deletions(-)

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
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 3a75833d7aba..dfd6c1491ac3 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5384,10 +5384,10 @@ static void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct
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
@@ -5397,35 +5397,33 @@ static void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct
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
@@ -5441,24 +5439,35 @@ static void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct
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
@@ -5468,25 +5477,32 @@ static void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct
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
+		page_remove_rmap(hpage, vma, true);
 
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
 
-- 
2.39.0.314.g84b9a713c41-goog

