Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F19C7607C79
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 18:39:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231168AbiJUQj3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 12:39:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231126AbiJUQiT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 12:38:19 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C3682892CF
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 09:37:39 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-352e29ff8c2so34082087b3.21
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 09:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kLa4FDL78/heGirMrV4t2jI2YXb52QMfSMVBDglb1pI=;
        b=Q5PTuLo7HRBrnlQ1Ey9ThRuaUPzdRht6lDvMahIeRZWgEby1HC2ivIu1k6cVhj8WmR
         oO/uNViSfO/2l5oua1WWbkZ0eHLvVgNvH7kU5i5kmpn4hbwV9AMGBGCX3YqInEpOxWcS
         OQI52pRTR+PnZRAz0BqQAhpT9WrDVcR13NBnsTM4rCctkW7Z+CR0eHFNnJ4WxMOCiJ5T
         SDYleezhNhwhzNFFFV+R09sJxih1+czcs9xyXQDbsEpbaRwdWjhHE0DoJ1w0cD/H3Kzs
         ktG3Exmi3FDbo2/KLeQiGqY7fizeM3zEOYgw8vPiHu8GPzznlIQ9RQAUhOcOYC4PvbiJ
         fpjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kLa4FDL78/heGirMrV4t2jI2YXb52QMfSMVBDglb1pI=;
        b=S5Pn+vXcF4NDfqipAbv+uPT/W+qwI8GV2dzvfzh20BIFRYUwjYvetw0eEUVZN6uhug
         /HRACii/dKCfwJd5wSS2kKKUHJQJY+PNQqDmbGa6PmKcwKcrORqW6+rSOOSeuhkW5QsN
         dfs/pCDd+AEAJWxmr6Bczuzi7ySV878WM3d7vscrvEKKyJXSN5IDCQdj1p8TYzrUBLsA
         qG4Q+E8oI6LXVd0W9+UzJZYy1WK6/++66F3CdXWOxyRDNLLC7pWZiMSa9Er27LfsJLET
         rrRH/duFGiSfNu9lHNwJmOrxHVhd74uGCCM3TwRK9CvVzpdFHf9G0YPcpuar1u2xojVd
         k+/w==
X-Gm-Message-State: ACrzQf1VlWPdrGIsXJ55m50ulvHKIMM0fwSruV2k55IvbI7BQEAGYx8h
        6ETGujgrT6IhvVStlVTruRZh1y0s229l6ZIY
X-Google-Smtp-Source: AMsMyM7h5gdYFH3DD5K/ZNJhJDsbg1FfZUc+C9HxdHoM0T7ZqKXkPe+MqKnLU+sCEA2oMl8JZ8rXkLKHBL6YNc9r
X-Received: from jthoughton.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:2a4f])
 (user=jthoughton job=sendgmr) by 2002:a25:244e:0:b0:6ca:1972:f851 with SMTP
 id k75-20020a25244e000000b006ca1972f851mr10580295ybk.277.1666370258436; Fri,
 21 Oct 2022 09:37:38 -0700 (PDT)
Date:   Fri, 21 Oct 2022 16:36:40 +0000
In-Reply-To: <20221021163703.3218176-1-jthoughton@google.com>
Mime-Version: 1.0
References: <20221021163703.3218176-1-jthoughton@google.com>
X-Mailer: git-send-email 2.38.0.135.g90850a2211-goog
Message-ID: <20221021163703.3218176-25-jthoughton@google.com>
Subject: [RFC PATCH v2 24/47] hugetlb: update page_vma_mapped to do
 high-granularity walks
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

This updates the HugeTLB logic to look a lot more like the PTE-mapped
THP logic. When a user calls us in a loop, we will update pvmw->address
to walk to each page table entry that could possibly map the hugepage
containing pvmw->pfn.

This makes use of the new pte_order so callers know what size PTE
they're getting.

Signed-off-by: James Houghton <jthoughton@google.com>
---
 include/linux/rmap.h |  4 +++
 mm/page_vma_mapped.c | 59 ++++++++++++++++++++++++++++++++++++--------
 mm/rmap.c            | 48 +++++++++++++++++++++--------------
 3 files changed, 83 insertions(+), 28 deletions(-)

diff --git a/include/linux/rmap.h b/include/linux/rmap.h
index e0557ede2951..d7d2d9f65a01 100644
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -13,6 +13,7 @@
 #include <linux/highmem.h>
 #include <linux/pagemap.h>
 #include <linux/memremap.h>
+#include <linux/hugetlb.h>
 
 /*
  * The anon_vma heads a list of private "related" vmas, to scan if
@@ -409,6 +410,9 @@ static inline void page_vma_mapped_walk_done(struct page_vma_mapped_walk *pvmw)
 		pte_unmap(pvmw->pte);
 	if (pvmw->ptl)
 		spin_unlock(pvmw->ptl);
+	if (pvmw->pte && is_vm_hugetlb_page(pvmw->vma) &&
+			hugetlb_hgm_enabled(pvmw->vma))
+		hugetlb_vma_unlock_read(pvmw->vma);
 }
 
 bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw);
diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
index 395ca4e21c56..1994b3f9a4c2 100644
--- a/mm/page_vma_mapped.c
+++ b/mm/page_vma_mapped.c
@@ -133,7 +133,8 @@ static void step_forward(struct page_vma_mapped_walk *pvmw, unsigned long size)
  *
  * Returns true if the page is mapped in the vma. @pvmw->pmd and @pvmw->pte point
  * to relevant page table entries. @pvmw->ptl is locked. @pvmw->address is
- * adjusted if needed (for PTE-mapped THPs).
+ * adjusted if needed (for PTE-mapped THPs and high-granularity--mapped HugeTLB
+ * pages).
  *
  * If @pvmw->pmd is set but @pvmw->pte is not, you have found PMD-mapped page
  * (usually THP). For PTE-mapped THP, you should run page_vma_mapped_walk() in
@@ -166,19 +167,57 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
 	if (unlikely(is_vm_hugetlb_page(vma))) {
 		struct hstate *hstate = hstate_vma(vma);
 		unsigned long size = huge_page_size(hstate);
-		/* The only possible mapping was handled on last iteration */
-		if (pvmw->pte)
-			return not_found(pvmw);
+		struct hugetlb_pte hpte;
+		pte_t *pte;
+		pte_t pteval;
+
+		end = (pvmw->address & huge_page_mask(hstate)) +
+			huge_page_size(hstate);
 
 		/* when pud is not present, pte will be NULL */
-		pvmw->pte = huge_pte_offset(mm, pvmw->address, size);
-		if (!pvmw->pte)
+		pte = huge_pte_offset(mm, pvmw->address, size);
+		if (!pte)
 			return false;
 
-		pvmw->pte_order = huge_page_order(hstate);
-		pvmw->ptl = huge_pte_lock(hstate, mm, pvmw->pte);
-		if (!check_pte(pvmw))
-			return not_found(pvmw);
+		do {
+			hugetlb_pte_populate(&hpte, pte, huge_page_shift(hstate),
+					hpage_size_to_level(size));
+
+			/*
+			 * Do a high granularity page table walk. The vma lock
+			 * is grabbed to prevent the page table from being
+			 * collapsed mid-walk. It is dropped in
+			 * page_vma_mapped_walk_done().
+			 */
+			if (pvmw->pte) {
+				if (pvmw->ptl)
+					spin_unlock(pvmw->ptl);
+				pvmw->ptl = NULL;
+				pvmw->address += PAGE_SIZE << pvmw->pte_order;
+				if (pvmw->address >= end)
+					return not_found(pvmw);
+			} else if (hugetlb_hgm_enabled(vma))
+				/* Only grab the lock once. */
+				hugetlb_vma_lock_read(vma);
+
+retry_walk:
+			hugetlb_hgm_walk(mm, vma, &hpte, pvmw->address,
+					PAGE_SIZE, /*stop_at_none=*/true);
+
+			pvmw->pte = hpte.ptep;
+			pvmw->pte_order = hpte.shift - PAGE_SHIFT;
+			pvmw->ptl = hugetlb_pte_lock(mm, &hpte);
+			pteval = huge_ptep_get(hpte.ptep);
+			if (pte_present(pteval) && !hugetlb_pte_present_leaf(
+						&hpte, pteval)) {
+				/*
+				 * Someone split from under us, so keep
+				 * walking.
+				 */
+				spin_unlock(pvmw->ptl);
+				goto retry_walk;
+			}
+		} while (!check_pte(pvmw));
 		return true;
 	}
 
diff --git a/mm/rmap.c b/mm/rmap.c
index 527463c1e936..a8359584467e 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1552,17 +1552,23 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 			flush_cache_range(vma, range.start, range.end);
 
 			/*
-			 * To call huge_pmd_unshare, i_mmap_rwsem must be
-			 * held in write mode.  Caller needs to explicitly
-			 * do this outside rmap routines.
-			 *
-			 * We also must hold hugetlb vma_lock in write mode.
-			 * Lock order dictates acquiring vma_lock BEFORE
-			 * i_mmap_rwsem.  We can only try lock here and fail
-			 * if unsuccessful.
+			 * If HGM is enabled, we have already grabbed the VMA
+			 * lock for reading, and we cannot safely release it.
+			 * Because HGM-enabled VMAs have already unshared all
+			 * PMDs, we can safely ignore PMD unsharing here.
 			 */
-			if (!anon) {
+			if (!anon && !hugetlb_hgm_enabled(vma)) {
 				VM_BUG_ON(!(flags & TTU_RMAP_LOCKED));
+				/*
+				 * To call huge_pmd_unshare, i_mmap_rwsem must
+				 * be held in write mode.  Caller needs to
+				 * explicitly do this outside rmap routines.
+				 *
+				 * We also must hold hugetlb vma_lock in write
+				 * mode. Lock order dictates acquiring vma_lock
+				 * BEFORE i_mmap_rwsem.  We can only try lock
+				 * here and fail if unsuccessful.
+				 */
 				if (!hugetlb_vma_trylock_write(vma)) {
 					page_vma_mapped_walk_done(&pvmw);
 					ret = false;
@@ -1946,17 +1952,23 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
 			flush_cache_range(vma, range.start, range.end);
 
 			/*
-			 * To call huge_pmd_unshare, i_mmap_rwsem must be
-			 * held in write mode.  Caller needs to explicitly
-			 * do this outside rmap routines.
-			 *
-			 * We also must hold hugetlb vma_lock in write mode.
-			 * Lock order dictates acquiring vma_lock BEFORE
-			 * i_mmap_rwsem.  We can only try lock here and
-			 * fail if unsuccessful.
+			 * If HGM is enabled, we have already grabbed the VMA
+			 * lock for reading, and we cannot safely release it.
+			 * Because HGM-enabled VMAs have already unshared all
+			 * PMDs, we can safely ignore PMD unsharing here.
 			 */
-			if (!anon) {
+			if (!anon && !hugetlb_hgm_enabled(vma)) {
 				VM_BUG_ON(!(flags & TTU_RMAP_LOCKED));
+				/*
+				 * To call huge_pmd_unshare, i_mmap_rwsem must
+				 * be held in write mode.  Caller needs to
+				 * explicitly do this outside rmap routines.
+				 *
+				 * We also must hold hugetlb vma_lock in write
+				 * mode. Lock order dictates acquiring vma_lock
+				 * BEFORE i_mmap_rwsem.  We can only try lock
+				 * here and fail if unsuccessful.
+				 */
 				if (!hugetlb_vma_trylock_write(vma)) {
 					page_vma_mapped_walk_done(&pvmw);
 					ret = false;
-- 
2.38.0.135.g90850a2211-goog

