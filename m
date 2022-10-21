Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69B95607C70
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 18:38:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231255AbiJUQil (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 12:38:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230426AbiJUQhw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 12:37:52 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18765285285
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 09:37:32 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id d8-20020a25bc48000000b00680651cf051so3721773ybk.23
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 09:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jGDNGpgyd+LktDdBqcgk2eFzL/51App81iFIhhA8QvM=;
        b=WvssnA576m2gIOjqFAeA/o9F21XVuqPBOfjdLDQe3yj3f7sCXH/DyQZifeomZgACso
         tq9jSZfo+HUQwrmpjel2ODEauK1LcfzwDDEk6ffGwYPc4Y5s7gAYkqNbIaP2xTzfrsxZ
         pIO+v90Vr8xsUYHX9E/VLnIFshVrB0JCnxxBwAK2yJQEFzngwXTyf9t/ysQ0xxvch87r
         Zi7MRBeyl8crtyxZjZWkPZLEPtcOooB2n7nKJms7jG/Tpde/Q+Lx3dNw5d7IMczHqnN3
         CZBfpX0lsEsL0bCzuxums79HAP7Zr4yoEeRp/oAqhslrlEQnEUwcSQPm09TnYI39AuL+
         zA3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jGDNGpgyd+LktDdBqcgk2eFzL/51App81iFIhhA8QvM=;
        b=hC6D6hEH6V4wK6TfUw0c/4wGF030xw/4irph6+WTy2WaCbzeGps3cfvpZGbxUBtL+8
         e4UbO/sfRpBr1J+6TipXUWrpQJdJqJ83b47HZGnKnvXIo6YwdURHuePxCooc6/Kd0hWK
         LLzYLoZLoYLr8iQtItENGamdZaCvT7y3l54n4tIAGLgSfz8YgrDnxPf45Mc6qjwLsvNV
         6mjRnqPmec8QDV3YaunAalrGBruST8fA5UbYSDzkULtn2ZpYiMls7i3nMfZlhWIFOiiO
         w6bEAWeI6YG2Miec/wtziP4XIMmLZiq42/rTQN6lTcDIEvAOOzTc0bu4Yu1SYygZLFvT
         dUZg==
X-Gm-Message-State: ACrzQf1tESkLz4/DRfQc9ywOUYNJESyl42lX9vRZt1VDy8M9PMyBivPe
        3XL7WkLKK6G7zibLkF9MkF+y8EtR+V3Zux1e
X-Google-Smtp-Source: AMsMyM7S7b4xi7h0rwSX6ZHP74KAZnjzSP+ITPpkxvpF7yvakbmq9b7FArr2IxSbKG/6i0vwlb/HkHrAOF9sGOQp
X-Received: from jthoughton.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:2a4f])
 (user=jthoughton job=sendgmr) by 2002:a0d:d601:0:b0:368:6e24:d23a with SMTP
 id y1-20020a0dd601000000b003686e24d23amr8805625ywd.82.1666370251617; Fri, 21
 Oct 2022 09:37:31 -0700 (PDT)
Date:   Fri, 21 Oct 2022 16:36:32 +0000
In-Reply-To: <20221021163703.3218176-1-jthoughton@google.com>
Mime-Version: 1.0
References: <20221021163703.3218176-1-jthoughton@google.com>
X-Mailer: git-send-email 2.38.0.135.g90850a2211-goog
Message-ID: <20221021163703.3218176-17-jthoughton@google.com>
Subject: [RFC PATCH v2 16/47] hugetlb: make unmapping compatible with
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
 mm/hugetlb.c              | 76 +++++++++++++++++++++++++--------------
 2 files changed, 52 insertions(+), 30 deletions(-)

diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
index 492dce43236e..c378a44915a9 100644
--- a/include/asm-generic/tlb.h
+++ b/include/asm-generic/tlb.h
@@ -566,9 +566,9 @@ static inline void tlb_flush_p4d_range(struct mmu_gather *tlb,
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
@@ -577,7 +577,7 @@ static inline void tlb_flush_p4d_range(struct mmu_gather *tlb,
 			tlb_flush_pmd_range(tlb, address, _sz);	\
 		else						\
 			tlb_flush_pte_range(tlb, address, _sz);	\
-		__tlb_remove_tlb_entry(tlb, ptep, address);	\
+		__tlb_remove_tlb_entry(tlb, hpte.ptep, address);\
 	} while (0)
 
 /**
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 74a4afda1a7e..227150c25763 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5221,10 +5221,10 @@ static void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct
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
 	struct mmu_notifier_range range;
@@ -5235,11 +5235,6 @@ static void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct
 	BUG_ON(start & ~huge_page_mask(h));
 	BUG_ON(end & ~huge_page_mask(h));
 
-	/*
-	 * This is a hugetlb vma, all the pte entries should point
-	 * to huge page.
-	 */
-	tlb_change_page_size(tlb, sz);
 	tlb_start_vma(tlb, vma);
 
 	/*
@@ -5251,26 +5246,35 @@ static void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct
 	mmu_notifier_invalidate_range_start(&range);
 	last_addr_mask = hugetlb_mask_last_page(h);
 	address = start;
-	for (; address < end; address += sz) {
-		ptep = huge_pte_offset(mm, address, sz);
+
+	while (address < end) {
+		pte_t *ptep = huge_pte_offset(mm, address, sz);
+
 		if (!ptep) {
 			address |= last_addr_mask;
+			address += sz;
 			continue;
 		}
+		hugetlb_pte_populate(&hpte, ptep, huge_page_shift(h),
+				hpage_size_to_level(huge_page_size(h)));
+		hugetlb_hgm_walk(mm, vma, &hpte, address,
+				PAGE_SIZE, /*stop_at_none=*/true);
 
-		ptl = huge_pte_lock(h, mm, ptep);
-		if (huge_pmd_unshare(mm, vma, address, ptep)) {
+		ptl = hugetlb_pte_lock(mm, &hpte);
+		if (huge_pmd_unshare(mm, vma, address, hpte.ptep)) {
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
@@ -5287,25 +5291,36 @@ static void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct
 			 */
 			if (pte_swp_uffd_wp_any(pte) &&
 			    !(zap_flags & ZAP_FLAG_DROP_MARKER))
-				set_huge_pte_at(mm, address, ptep,
+				set_huge_pte_at(mm, address, hpte.ptep,
 						make_pte_marker(PTE_MARKER_UFFD_WP));
 			else
 #endif
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
@@ -5315,27 +5330,34 @@ static void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct
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
 #ifdef CONFIG_PTE_MARKER_UFFD_WP
 		/* Leave a uffd-wp pte marker if needed */
 		if (huge_pte_uffd_wp(pte) &&
 		    !(zap_flags & ZAP_FLAG_DROP_MARKER))
-			set_huge_pte_at(mm, address, ptep,
+			set_huge_pte_at(mm, address, hpte.ptep,
 					make_pte_marker(PTE_MARKER_UFFD_WP));
 #endif
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
 	mmu_notifier_invalidate_range_end(&range);
 	tlb_end_vma(tlb, vma);
-- 
2.38.0.135.g90850a2211-goog

