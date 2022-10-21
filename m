Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0866B607C67
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 18:38:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231124AbiJUQiB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 12:38:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230428AbiJUQh3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 12:37:29 -0400
Received: from mail-ua1-x94a.google.com (mail-ua1-x94a.google.com [IPv6:2607:f8b0:4864:20::94a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2DA627B56D
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 09:37:26 -0700 (PDT)
Received: by mail-ua1-x94a.google.com with SMTP id 95-20020a9f23e8000000b0038caa7cd5c1so2349724uao.8
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 09:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=uDuCPiOW4B8iVzI/6AmJPz8Wx+abw4sbfMgiEm8c4Xc=;
        b=qq0EliFW2HK5B98D2udo/aAD/3vjrh0KvnobMtG+PZI475PQxdoifbXuauS2SCXR7s
         NBAGHfMDTBh2R7M3djga9zPIyUlhx0bNxKeL4L+V01PzyGv4mm0erA2L0Y1ny5S6vxJy
         4gip8m0AqQsH7lfmx5uVfNaKn30YrEf2kISS2JxneX57zOtYW6lbymXlNNHiSfHhJ/y1
         yUdl8fYNmg7ptYMobwK3mFqxuJ7Y4BDoNlS3denm9rDalcC6tLL8UL3VoKuOEfO+zFSR
         UdMrIX+D3fSXo2nL8Ka8LYE/7mxAdhiJ2pdIhLJL9bKOH/gF6yAWL/qKQ3jBuanK9jCL
         6s5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uDuCPiOW4B8iVzI/6AmJPz8Wx+abw4sbfMgiEm8c4Xc=;
        b=H1x/qASiCRbYpy6Qe+KoKeSqLQfpRHR5yLUd9o6vhgplzcBeMNq50sGfMNqWu/9bbr
         Cl0u1ugcv/9G2fBMCg6hTQi5YbvEJkYMuJAssjW6lTtko2Y2+oU5NyvFbpmexchUfXV3
         m0+tZppSgv5FWP0s+YShAB07WvcSAPX2W7evrBYyPU9WnCK9dhTKGAzpEaELAcSsnFtP
         /mhH5T2r4kxzKBy3FRchhpyLv1ru3SlxGY1VO5fRYIQgApYr78mZfb5GQGD8V+WEWFqp
         rgaKAu3rKjaARLDPCGEoJ7RDia7HtIjSwrrEDLTiInbmjtqYrkhvRNUu8LzDjI9s3gcU
         BSgA==
X-Gm-Message-State: ACrzQf0YWUIElb8qWUuGwdS5QcATKEIGwVqCD/me4XGxY3BGU1PNJ3jW
        Aa10/DJbOJY3KnGtcMr7Vev+0y3qSX83DF+Z
X-Google-Smtp-Source: AMsMyM5MOfTzLEOJgE3E6XYRUQL+J9vN27S5Ka8UI3ikwk+Wd0rafhqiIzJtQHdX6T/3LZGa8ANB+n7hmfewb2Cy
X-Received: from jthoughton.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:2a4f])
 (user=jthoughton job=sendgmr) by 2002:a05:6102:3172:b0:3a7:319c:ffef with
 SMTP id l18-20020a056102317200b003a7319cffefmr15180512vsm.80.1666370244975;
 Fri, 21 Oct 2022 09:37:24 -0700 (PDT)
Date:   Fri, 21 Oct 2022 16:36:25 +0000
In-Reply-To: <20221021163703.3218176-1-jthoughton@google.com>
Mime-Version: 1.0
References: <20221021163703.3218176-1-jthoughton@google.com>
X-Mailer: git-send-email 2.38.0.135.g90850a2211-goog
Message-ID: <20221021163703.3218176-10-jthoughton@google.com>
Subject: [RFC PATCH v2 09/47] hugetlb: make huge_pte_lockptr take an explicit
 shift argument.
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
index 6e0c36b08a0c..db3ed6095b1c 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -934,12 +934,11 @@ static inline gfp_t htlb_modify_alloc_mask(struct hstate *h, gfp_t gfp_mask)
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
 
@@ -1144,7 +1143,7 @@ static inline gfp_t htlb_modify_alloc_mask(struct hstate *h, gfp_t gfp_mask)
 	return 0;
 }
 
-static inline spinlock_t *huge_pte_lockptr(struct hstate *h,
+static inline spinlock_t *huge_pte_lockptr(unsigned int shift,
 					   struct mm_struct *mm, pte_t *pte)
 {
 	return &mm->page_table_lock;
@@ -1206,7 +1205,7 @@ static inline spinlock_t *huge_pte_lock(struct hstate *h,
 {
 	spinlock_t *ptl;
 
-	ptl = huge_pte_lockptr(h, mm, pte);
+	ptl = huge_pte_lockptr(huge_page_shift(h), mm, pte);
 	spin_lock(ptl);
 	return ptl;
 }
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index a18143add956..ef7662bd0068 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -4847,7 +4847,7 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 		}
 
 		dst_ptl = huge_pte_lock(h, dst, dst_pte);
-		src_ptl = huge_pte_lockptr(h, src, src_pte);
+		src_ptl = huge_pte_lockptr(huge_page_shift(h), src, src_pte);
 		spin_lock_nested(src_ptl, SINGLE_DEPTH_NESTING);
 		entry = huge_ptep_get(src_pte);
 again:
@@ -4925,7 +4925,8 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 
 				/* Install the new huge page if src pte stable */
 				dst_ptl = huge_pte_lock(h, dst, dst_pte);
-				src_ptl = huge_pte_lockptr(h, src, src_pte);
+				src_ptl = huge_pte_lockptr(huge_page_shift(h),
+							   src, src_pte);
 				spin_lock_nested(src_ptl, SINGLE_DEPTH_NESTING);
 				entry = huge_ptep_get(src_pte);
 				if (!pte_same(src_pte_old, entry)) {
@@ -4979,7 +4980,7 @@ static void move_huge_pte(struct vm_area_struct *vma, unsigned long old_addr,
 	pte_t pte;
 
 	dst_ptl = huge_pte_lock(h, mm, dst_pte);
-	src_ptl = huge_pte_lockptr(h, mm, src_pte);
+	src_ptl = huge_pte_lockptr(huge_page_shift(h), mm, src_pte);
 
 	/*
 	 * We don't have to worry about the ordering of src and dst ptlocks
diff --git a/mm/migrate.c b/mm/migrate.c
index 1457cdbb7828..a0105fa6e3b2 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -334,7 +334,8 @@ void __migration_entry_wait_huge(pte_t *ptep, spinlock_t *ptl)
 
 void migration_entry_wait_huge(struct vm_area_struct *vma, pte_t *pte)
 {
-	spinlock_t *ptl = huge_pte_lockptr(hstate_vma(vma), vma->vm_mm, pte);
+	spinlock_t *ptl = huge_pte_lockptr(huge_page_shift(hstate_vma(vma)),
+					   vma->vm_mm, pte);
 
 	__migration_entry_wait_huge(pte, ptl);
 }
-- 
2.38.0.135.g90850a2211-goog

