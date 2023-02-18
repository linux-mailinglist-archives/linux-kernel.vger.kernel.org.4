Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B065A69B6B5
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 01:29:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbjBRA30 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 19:29:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbjBRA3Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 19:29:16 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9149A5BDB0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 16:28:54 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id 64-20020a250243000000b007eba3f8e3baso2483973ybc.4
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 16:28:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5Xd63Fapv1zuFib4b0fw8zL6DTisPv2GzpUTcimolMg=;
        b=G9OKNC7MB5QZ1WtbCVd/b4GGEEQxFMkkCyh9YPN/SaI+Iv0UY6xpXV4C/bjLuR5GX/
         xT5jqUIS0kJvgcXBGXG6eGMOl41EQ+9+EPXqDEN8/E+QrPDYAERgHP5tENbu09gPxEEE
         J2plHmBfhFP7cLD9TJAsfNCeQfwyLgPfEiNyKU7bNFt6UToPyOfI/Tv35qpqCPqZOx+3
         BkeCahUvSvDUjoiOquOpSnIGEQ48uVtj2zGVrhp8k95YXggqw2b91kgnZMkucKn+Y1SW
         QrvcwU7NPBdC0gLOUvUCZFlWQklPf0wCQDXXAGua2AKBXeE+nHdPEk2ToJ76Lq1odat1
         0YNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5Xd63Fapv1zuFib4b0fw8zL6DTisPv2GzpUTcimolMg=;
        b=7Y0mktldTTNqhkx9PjBuw4/RXIRzAz0HFpcWlWOETlIMoi+/HPZv9MAiqlXzyoitcX
         LJBiy8pnWi6I4yyKq03SvrwibNymU1jdYjA1zjy82gLlLs2zQs41FMVj+hmZgFQU0laC
         1VoZ/wHL9T99Jg1Qlnyh4/nGW6B7tLWhISLXohsy+097XllhkUIvQ1CefkzO7y5ufWGC
         OpPEEmkYq979LXoKrKgblCDSEdulYqnh8uROkrtPYpo8YTXl+rEKQxUWx9IxY2DSsoDu
         lOFxMsXanWtqzYfe3jNsv2G8ROpnAmHU1FMtwbdU42+I+smlVrv9G/eM9bAzrlfWblPJ
         EKPA==
X-Gm-Message-State: AO0yUKXLbnQJsWPrxZtLUhRSFIY4Bjh2Gu6EGoYvJ4H8kGV653+9FyYe
        ItmULVBeE+0AIQRGgSda5aSyEACxgMMUeZe2
X-Google-Smtp-Source: AK7set8eABNjJa8kuKJfW7WVM4L/kIrgHT4nRE22RZ7aTpjJYSh+BZra+YA1xFFUMi8kyRc4Y+q2EPk2y7TmuTgs
X-Received: from jthoughton.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:2a4f])
 (user=jthoughton job=sendgmr) by 2002:a81:b60f:0:b0:52a:92e9:27c1 with SMTP
 id u15-20020a81b60f000000b0052a92e927c1mr279953ywh.10.1676680133715; Fri, 17
 Feb 2023 16:28:53 -0800 (PST)
Date:   Sat, 18 Feb 2023 00:27:43 +0000
In-Reply-To: <20230218002819.1486479-1-jthoughton@google.com>
Mime-Version: 1.0
References: <20230218002819.1486479-1-jthoughton@google.com>
X-Mailer: git-send-email 2.39.2.637.g21b0678d19-goog
Message-ID: <20230218002819.1486479-11-jthoughton@google.com>
Subject: [PATCH v2 10/46] hugetlb: make huge_pte_lockptr take an explicit
 shift argument
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

This is needed to handle PTL locking with high-granularity mapping. We
won't always be using the PMD-level PTL even if we're using the 2M
hugepage hstate. It's possible that we're dealing with 4K PTEs, in which
case, we need to lock the PTL for the 4K PTE.

Reviewed-by: Mina Almasry <almasrymina@google.com>
Acked-by: Mike Kravetz <mike.kravetz@oracle.com>
Signed-off-by: James Houghton <jthoughton@google.com>

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
index efd2635a87f5..a1ceb9417f01 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -958,12 +958,11 @@ static inline gfp_t htlb_modify_alloc_mask(struct hstate *h, gfp_t gfp_mask)
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
 
@@ -1173,7 +1172,7 @@ static inline gfp_t htlb_modify_alloc_mask(struct hstate *h, gfp_t gfp_mask)
 	return 0;
 }
 
-static inline spinlock_t *huge_pte_lockptr(struct hstate *h,
+static inline spinlock_t *huge_pte_lockptr(unsigned int shift,
 					   struct mm_struct *mm, pte_t *pte)
 {
 	return &mm->page_table_lock;
@@ -1230,7 +1229,7 @@ static inline spinlock_t *huge_pte_lock(struct hstate *h,
 {
 	spinlock_t *ptl;
 
-	ptl = huge_pte_lockptr(h, mm, pte);
+	ptl = huge_pte_lockptr(huge_page_shift(h), mm, pte);
 	spin_lock(ptl);
 	return ptl;
 }
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 0576dcc98044..5ca9eae0ac42 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5017,7 +5017,7 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 		}
 
 		dst_ptl = huge_pte_lock(h, dst, dst_pte);
-		src_ptl = huge_pte_lockptr(h, src, src_pte);
+		src_ptl = huge_pte_lockptr(huge_page_shift(h), src, src_pte);
 		spin_lock_nested(src_ptl, SINGLE_DEPTH_NESTING);
 		entry = huge_ptep_get(src_pte);
 again:
@@ -5098,7 +5098,8 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 
 				/* Install the new hugetlb folio if src pte stable */
 				dst_ptl = huge_pte_lock(h, dst, dst_pte);
-				src_ptl = huge_pte_lockptr(h, src, src_pte);
+				src_ptl = huge_pte_lockptr(huge_page_shift(h),
+							   src, src_pte);
 				spin_lock_nested(src_ptl, SINGLE_DEPTH_NESTING);
 				entry = huge_ptep_get(src_pte);
 				if (!pte_same(src_pte_old, entry)) {
@@ -5152,7 +5153,7 @@ static void move_huge_pte(struct vm_area_struct *vma, unsigned long old_addr,
 	pte_t pte;
 
 	dst_ptl = huge_pte_lock(h, mm, dst_pte);
-	src_ptl = huge_pte_lockptr(h, mm, src_pte);
+	src_ptl = huge_pte_lockptr(huge_page_shift(h), mm, src_pte);
 
 	/*
 	 * We don't have to worry about the ordering of src and dst ptlocks
diff --git a/mm/migrate.c b/mm/migrate.c
index b0f87f19b536..9b4a7e75f6e6 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -363,7 +363,8 @@ void __migration_entry_wait_huge(struct vm_area_struct *vma,
 
 void migration_entry_wait_huge(struct vm_area_struct *vma, pte_t *pte)
 {
-	spinlock_t *ptl = huge_pte_lockptr(hstate_vma(vma), vma->vm_mm, pte);
+	spinlock_t *ptl = huge_pte_lockptr(huge_page_shift(hstate_vma(vma)),
+					   vma->vm_mm, pte);
 
 	__migration_entry_wait_huge(vma, pte, ptl);
 }
-- 
2.39.2.637.g21b0678d19-goog

