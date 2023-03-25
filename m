Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B2536C8BEB
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 07:56:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231892AbjCYG4b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 02:56:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231833AbjCYG4V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 02:56:21 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 315D015570
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 23:56:20 -0700 (PDT)
Received: from kwepemm600020.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Pk8x53K6NzKnd5;
        Sat, 25 Mar 2023 14:55:53 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 kwepemm600020.china.huawei.com (7.193.23.147) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Sat, 25 Mar 2023 14:56:17 +0800
From:   Peng Zhang <zhangpeng362@huawei.com>
To:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <willy@infradead.org>, <mike.kravetz@oracle.com>
CC:     <akpm@linux-foundation.org>, <vishal.moola@gmail.com>,
        <muchun.song@linux.dev>, <sidhartha.kumar@oracle.com>,
        <wangkefeng.wang@huawei.com>, <sunnanyong@huawei.com>,
        ZhangPeng <zhangpeng362@huawei.com>
Subject: [PATCH v3 4/6] userfaultfd: convert __mcopy_atomic_hugetlb() to use a folio
Date:   Sat, 25 Mar 2023 14:56:06 +0800
Message-ID: <20230325065608.601391-5-zhangpeng362@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230325065608.601391-1-zhangpeng362@huawei.com>
References: <20230325065608.601391-1-zhangpeng362@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600020.china.huawei.com (7.193.23.147)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ZhangPeng <zhangpeng362@huawei.com>

Convert hugetlb_mcopy_atomic_pte() to take in a folio pointer instead of
a page pointer. Convert __mcopy_atomic_hugetlb() to use a folio.

Signed-off-by: ZhangPeng <zhangpeng362@huawei.com>
---
 include/linux/hugetlb.h |  4 ++--
 mm/hugetlb.c            | 26 +++++++++++++-------------
 mm/userfaultfd.c        | 16 ++++++++--------
 3 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 7c977d234aba..030252ce51bd 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -163,7 +163,7 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm, pte_t *dst_pte,
 				unsigned long dst_addr,
 				unsigned long src_addr,
 				enum mcopy_atomic_mode mode,
-				struct page **pagep,
+				struct folio **foliop,
 				bool wp_copy);
 #endif /* CONFIG_USERFAULTFD */
 bool hugetlb_reserve_pages(struct inode *inode, long from, long to,
@@ -399,7 +399,7 @@ static inline int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
 						unsigned long dst_addr,
 						unsigned long src_addr,
 						enum mcopy_atomic_mode mode,
-						struct page **pagep,
+						struct folio **foliop,
 						bool wp_copy)
 {
 	BUG();
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 29ac064f69d6..1cfd20e5fe8b 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -6163,7 +6163,7 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
 			    unsigned long dst_addr,
 			    unsigned long src_addr,
 			    enum mcopy_atomic_mode mode,
-			    struct page **pagep,
+			    struct folio **foliop,
 			    bool wp_copy)
 {
 	bool is_continue = (mode == MCOPY_ATOMIC_CONTINUE);
@@ -6185,8 +6185,8 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
 		if (!folio)
 			goto out;
 		folio_in_pagecache = true;
-	} else if (!*pagep) {
-		/* If a page already exists, then it's UFFDIO_COPY for
+	} else if (!*foliop) {
+		/* If a folio already exists, then it's UFFDIO_COPY for
 		 * a non-missing case. Return -EEXIST.
 		 */
 		if (vm_shared &&
@@ -6221,33 +6221,33 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
 				ret = -ENOMEM;
 				goto out;
 			}
-			*pagep = &folio->page;
-			/* Set the outparam pagep and return to the caller to
+			*foliop = folio;
+			/* Set the outparam foliop and return to the caller to
 			 * copy the contents outside the lock. Don't free the
-			 * page.
+			 * folio.
 			 */
 			goto out;
 		}
 	} else {
 		if (vm_shared &&
 		    hugetlbfs_pagecache_present(h, dst_vma, dst_addr)) {
-			put_page(*pagep);
+			folio_put(*foliop);
 			ret = -EEXIST;
-			*pagep = NULL;
+			*foliop = NULL;
 			goto out;
 		}
 
 		folio = alloc_hugetlb_folio(dst_vma, dst_addr, 0);
 		if (IS_ERR(folio)) {
-			put_page(*pagep);
+			folio_put(*foliop);
 			ret = -ENOMEM;
-			*pagep = NULL;
+			*foliop = NULL;
 			goto out;
 		}
-		copy_user_huge_page(&folio->page, *pagep, dst_addr, dst_vma,
+		copy_user_huge_page(&folio->page, &(*foliop)->page, dst_addr, dst_vma,
 				    pages_per_huge_page(h));
-		put_page(*pagep);
-		*pagep = NULL;
+		folio_put(*foliop);
+		*foliop = NULL;
 	}
 
 	/*
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 7b660bc07d71..cbcc7eb1d36e 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -324,7 +324,7 @@ static __always_inline ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
 	pte_t *dst_pte;
 	unsigned long src_addr, dst_addr;
 	long copied;
-	struct page *page;
+	struct folio *folio;
 	unsigned long vma_hpagesize;
 	pgoff_t idx;
 	u32 hash;
@@ -344,7 +344,7 @@ static __always_inline ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
 	src_addr = src_start;
 	dst_addr = dst_start;
 	copied = 0;
-	page = NULL;
+	folio = NULL;
 	vma_hpagesize = vma_kernel_pagesize(dst_vma);
 
 	/*
@@ -413,7 +413,7 @@ static __always_inline ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
 		}
 
 		err = hugetlb_mcopy_atomic_pte(dst_mm, dst_pte, dst_vma,
-					       dst_addr, src_addr, mode, &page,
+					       dst_addr, src_addr, mode, &folio,
 					       wp_copy);
 
 		hugetlb_vma_unlock_read(dst_vma);
@@ -423,9 +423,9 @@ static __always_inline ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
 
 		if (unlikely(err == -ENOENT)) {
 			mmap_read_unlock(dst_mm);
-			BUG_ON(!page);
+			BUG_ON(!folio);
 
-			err = copy_folio_from_user(page_folio(page),
+			err = copy_folio_from_user(folio,
 						   (const void __user *)src_addr, true);
 			if (unlikely(err)) {
 				err = -EFAULT;
@@ -436,7 +436,7 @@ static __always_inline ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
 			dst_vma = NULL;
 			goto retry;
 		} else
-			BUG_ON(page);
+			BUG_ON(folio);
 
 		if (!err) {
 			dst_addr += vma_hpagesize;
@@ -453,8 +453,8 @@ static __always_inline ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
 out_unlock:
 	mmap_read_unlock(dst_mm);
 out:
-	if (page)
-		put_page(page);
+	if (folio)
+		folio_put(folio);
 	BUG_ON(copied < 0);
 	BUG_ON(err > 0);
 	BUG_ON(!copied && !err);
-- 
2.25.1

