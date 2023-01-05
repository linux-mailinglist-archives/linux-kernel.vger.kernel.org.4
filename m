Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4797F65E8CF
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 11:20:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231496AbjAEKUU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 05:20:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232678AbjAEKTg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 05:19:36 -0500
Received: from mail-ua1-x949.google.com (mail-ua1-x949.google.com [IPv6:2607:f8b0:4864:20::949])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA39650E66
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 02:19:08 -0800 (PST)
Received: by mail-ua1-x949.google.com with SMTP id 88-20020a9f2161000000b00576fb176177so3553637uab.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 02:19:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YeLoaIulUhCWWXAMbuNF9M+t6oo8aI+KwJNM9mGseGc=;
        b=kKVOVndAgw/m6ANRlyIyxTS08GniA9U67oeruSczuNHOB6SYI/n6pFU+HOjz+szql2
         PWk4++j2ti0R10lgALWNsE1fhYxnWxM7JukY7mIAe7pCJ5g5YXsry19Ma9iPvK6znPtU
         jMYy+OpdWtqzX+Nek/p3045z5ujRR/oRPI7EUBPhqyf1BWSaZmKdKoPtQI+kGu8Ti537
         3J1Z6ngNzsR80E2A85x/f+xTfzkF6gI9uOpsAHaLaSIpG6B2w5XFihWl8tN3nkAnSfct
         1xZKvd3M+YUP+kgur9AeYOYhuRYRgatI3fPPdF/dj+Kh+YLKqpI/TnSWPjyTPhxjRiqI
         rjMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YeLoaIulUhCWWXAMbuNF9M+t6oo8aI+KwJNM9mGseGc=;
        b=tK8Ladb9W+G05hfikjI/8fj6SPmrLp9043aibW0lxUSUGokIA/EbsuJF4EXXO4XW2c
         NPm5tdvinivWb6t4mvgmgXI3rY2JK1bkLLTk33HW11elk3PYHOE8/udnri2YQJs/bQ4P
         a4zzBkAJVJOHg3+sHVieFKQTK3YctCbT2iRdCR1r0AmdxTPQetjTDgFzD+D7wMUrMxtl
         Z9xy3bLsU2SnMKhKahqkj07j3LD5aEQ1GPgg1sZca3jfHqNLPQEXUZeHzaqN6vIgkHsN
         GF0mVV67COGs28ZDzJxcecwBNf5f0eUmDrx3kiKxDFVQcD2o9DorflLuqy+RkaRoJ4Ug
         DoLQ==
X-Gm-Message-State: AFqh2kp8heZmAcmZwSVHF5BiJ8zhAb0SZxEbzm8iYJz2pYGUgi09pxLN
        7gn2pTXskTiGp1kzrhmn+IFJoiHxIdGOvlkV
X-Google-Smtp-Source: AMrXdXtkUHqLKKc7LXMFTV+aWMn8L7Sl+RR7fShIQHxbdJZ0UldDgF+0b7JMDk/710jpas3HLfAgCwlTWk0Lhcfi
X-Received: from jthoughton.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:2a4f])
 (user=jthoughton job=sendgmr) by 2002:ab0:2e84:0:b0:419:2056:34b8 with SMTP
 id f4-20020ab02e84000000b00419205634b8mr5177046uaa.85.1672913948093; Thu, 05
 Jan 2023 02:19:08 -0800 (PST)
Date:   Thu,  5 Jan 2023 10:18:08 +0000
In-Reply-To: <20230105101844.1893104-1-jthoughton@google.com>
Mime-Version: 1.0
References: <20230105101844.1893104-1-jthoughton@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20230105101844.1893104-11-jthoughton@google.com>
Subject: [PATCH 10/46] hugetlb: make huge_pte_lockptr take an explicit shift argument
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

This is needed to handle PTL locking with high-granularity mapping. We
won't always be using the PMD-level PTL even if we're using the 2M
hugepage hstate. It's possible that we're dealing with 4K PTEs, in which
case, we need to lock the PTL for the 4K PTE.

Reviewed-by: Mina Almasry <almasrymina@google.com>
Acked-by: Mike Kravetz <mike.kravetz@oracle.com>
Signed-off-by: James Houghton <jthoughton@google.com>
---
 arch/powerpc/mm/pgtable.c | 3 ++-
 include/linux/hugetlb.h   | 9 ++++-----
 mm/hugetlb.c              | 7 ++++---
 mm/migrate.c              | 3 ++-
 4 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/mm/pgtable.c b/arch/powerpc/mm/pgtable.c
index cb2dcdb18f8e..035a0df47af0 100644
--- a/arch/powerpc/mm/pgtable.c
+++ b/arch/powerpc/mm/pgtable.c
@@ -261,7 +261,8 @@ int huge_ptep_set_access_flags(struct vm_area_struct *vma,
 
 		psize = hstate_get_psize(h);
 #ifdef CONFIG_DEBUG_VM
-		assert_spin_locked(huge_pte_lockptr(h, vma->vm_mm, ptep));
+		assert_spin_locked(huge_pte_lockptr(huge_page_shift(h),
+						    vma->vm_mm, ptep));
 #endif
 
 #else
diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 16fc3e381801..3f098363cd6e 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -956,12 +956,11 @@ static inline gfp_t htlb_modify_alloc_mask(struct hstate *h, gfp_t gfp_mask)
 	return modified_mask;
 }
 
-static inline spinlock_t *huge_pte_lockptr(struct hstate *h,
+static inline spinlock_t *huge_pte_lockptr(unsigned int shift,
 					   struct mm_struct *mm, pte_t *pte)
 {
-	if (huge_page_size(h) == PMD_SIZE)
+	if (shift == PMD_SHIFT)
 		return pmd_lockptr(mm, (pmd_t *) pte);
-	VM_BUG_ON(huge_page_size(h) == PAGE_SIZE);
 	return &mm->page_table_lock;
 }
 
@@ -1171,7 +1170,7 @@ static inline gfp_t htlb_modify_alloc_mask(struct hstate *h, gfp_t gfp_mask)
 	return 0;
 }
 
-static inline spinlock_t *huge_pte_lockptr(struct hstate *h,
+static inline spinlock_t *huge_pte_lockptr(unsigned int shift,
 					   struct mm_struct *mm, pte_t *pte)
 {
 	return &mm->page_table_lock;
@@ -1228,7 +1227,7 @@ static inline spinlock_t *huge_pte_lock(struct hstate *h,
 {
 	spinlock_t *ptl;
 
-	ptl = huge_pte_lockptr(h, mm, pte);
+	ptl = huge_pte_lockptr(huge_page_shift(h), mm, pte);
 	spin_lock(ptl);
 	return ptl;
 }
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 5bd53ae8ca4b..4db38dc79d0e 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -4987,7 +4987,7 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 		}
 
 		dst_ptl = huge_pte_lock(h, dst, dst_pte);
-		src_ptl = huge_pte_lockptr(h, src, src_pte);
+		src_ptl = huge_pte_lockptr(huge_page_shift(h), src, src_pte);
 		spin_lock_nested(src_ptl, SINGLE_DEPTH_NESTING);
 		entry = huge_ptep_get(src_pte);
 again:
@@ -5068,7 +5068,8 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 
 				/* Install the new huge page if src pte stable */
 				dst_ptl = huge_pte_lock(h, dst, dst_pte);
-				src_ptl = huge_pte_lockptr(h, src, src_pte);
+				src_ptl = huge_pte_lockptr(huge_page_shift(h),
+							   src, src_pte);
 				spin_lock_nested(src_ptl, SINGLE_DEPTH_NESTING);
 				entry = huge_ptep_get(src_pte);
 				if (!pte_same(src_pte_old, entry)) {
@@ -5122,7 +5123,7 @@ static void move_huge_pte(struct vm_area_struct *vma, unsigned long old_addr,
 	pte_t pte;
 
 	dst_ptl = huge_pte_lock(h, mm, dst_pte);
-	src_ptl = huge_pte_lockptr(h, mm, src_pte);
+	src_ptl = huge_pte_lockptr(huge_page_shift(h), mm, src_pte);
 
 	/*
 	 * We don't have to worry about the ordering of src and dst ptlocks
diff --git a/mm/migrate.c b/mm/migrate.c
index b5032c3e940a..832f639fc49a 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -360,7 +360,8 @@ void __migration_entry_wait_huge(struct vm_area_struct *vma,
 
 void migration_entry_wait_huge(struct vm_area_struct *vma, pte_t *pte)
 {
-	spinlock_t *ptl = huge_pte_lockptr(hstate_vma(vma), vma->vm_mm, pte);
+	spinlock_t *ptl = huge_pte_lockptr(huge_page_shift(hstate_vma(vma)),
+					   vma->vm_mm, pte);
 
 	__migration_entry_wait_huge(vma, pte, ptl);
 }
-- 
2.39.0.314.g84b9a713c41-goog

