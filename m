Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2AB36B967C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 14:40:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbjCNNkH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 09:40:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230012AbjCNNjY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 09:39:24 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AC29B04AF
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 06:36:00 -0700 (PDT)
Received: from kwepemm600020.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4PbYs90fb7zrT4F;
        Tue, 14 Mar 2023 21:14:37 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 kwepemm600020.china.huawei.com (7.193.23.147) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 14 Mar 2023 21:15:29 +0800
From:   Peng Zhang <zhangpeng362@huawei.com>
To:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <willy@infradead.org>
CC:     <akpm@linux-foundation.org>, <mike.kravetz@oracle.com>,
        <vishal.moola@gmail.com>, <sidhartha.kumar@oracle.com>,
        <wangkefeng.wang@huawei.com>, <sunnanyong@huawei.com>,
        ZhangPeng <zhangpeng362@huawei.com>
Subject: [PATCH v2 2/3] userfaultfd: convert __mcopy_atomic_hugetlb() to use a folio
Date:   Tue, 14 Mar 2023 13:13:49 +0000
Message-ID: <20230314131350.924377-3-zhangpeng362@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230314131350.924377-1-zhangpeng362@huawei.com>
References: <20230314131350.924377-1-zhangpeng362@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600020.china.huawei.com (7.193.23.147)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ZhangPeng <zhangpeng362@huawei.com>

Change copy_huge_page_from_user() to copy_folio_from_user().
Convert hugetlb_mcopy_atomic_pte() and __mcopy_atomic_hugetlb() to use a
folio.

Signed-off-by: ZhangPeng <zhangpeng362@huawei.com>
---
 include/linux/hugetlb.h |  4 ++--
 include/linux/mm.h      |  3 +--
 mm/hugetlb.c            | 25 ++++++++++++-------------
 mm/memory.c             | 27 ++++++++++++---------------
 mm/userfaultfd.c        | 20 +++++++++-----------
 5 files changed, 36 insertions(+), 43 deletions(-)

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
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 1f79667824eb..428cff424d26 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3546,9 +3546,8 @@ extern void copy_user_huge_page(struct page *dst, struct page *src,
 				unsigned long addr_hint,
 				struct vm_area_struct *vma,
 				unsigned int pages_per_huge_page);
-extern long copy_huge_page_from_user(struct page *dst_page,
+long copy_folio_from_user(struct folio *dst_folio,
 				const void __user *usr_src,
-				unsigned int pages_per_huge_page,
 				bool allow_pagefault);
 
 /**
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 07abcb6eb203..ea1f3b448b7a 100644
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
@@ -6185,7 +6185,7 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
 		if (!folio)
 			goto out;
 		folio_in_pagecache = true;
-	} else if (!*pagep) {
+	} else if (!*foliop) {
 		/* If a page already exists, then it's UFFDIO_COPY for
 		 * a non-missing case. Return -EEXIST.
 		 */
@@ -6201,9 +6201,8 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
 			goto out;
 		}
 
-		ret = copy_huge_page_from_user(&folio->page,
-						(const void __user *) src_addr,
-						pages_per_huge_page(h), false);
+		ret = copy_folio_from_user(folio,
+						(const void __user *) src_addr, false);
 
 		/* fallback to copy_from_user outside mmap_lock */
 		if (unlikely(ret)) {
@@ -6222,7 +6221,7 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
 				ret = -ENOMEM;
 				goto out;
 			}
-			*pagep = &folio->page;
+			*foliop = folio;
 			/* Set the outparam pagep and return to the caller to
 			 * copy the contents outside the lock. Don't free the
 			 * page.
@@ -6232,23 +6231,23 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
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
+		copy_user_huge_page(&folio->page, &((*foliop)->page), dst_addr, dst_vma,
 				    pages_per_huge_page(h));
-		put_page(*pagep);
-		*pagep = NULL;
+		folio_put(*foliop);
+		*foliop = NULL;
 	}
 
 	/*
diff --git a/mm/memory.c b/mm/memory.c
index f456f3b5049c..78fe9ef0c058 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5769,37 +5769,34 @@ void copy_user_huge_page(struct page *dst, struct page *src,
 	process_huge_page(addr_hint, pages_per_huge_page, copy_subpage, &arg);
 }
 
-long copy_huge_page_from_user(struct page *dst_page,
+long copy_folio_from_user(struct folio *dst_folio,
 				const void __user *usr_src,
-				unsigned int pages_per_huge_page,
 				bool allow_pagefault)
 {
 	void *page_kaddr;
 	unsigned long i, rc = 0;
-	unsigned long ret_val = pages_per_huge_page * PAGE_SIZE;
+	unsigned int nr_pages = folio_nr_pages(dst_folio);
+	unsigned long ret_val = nr_pages * PAGE_SIZE;
 	struct page *subpage;
 
-	for (i = 0; i < pages_per_huge_page; i++) {
-		subpage = nth_page(dst_page, i);
-		if (allow_pagefault)
-			page_kaddr = kmap(subpage);
-		else
-			page_kaddr = kmap_atomic(subpage);
+	for (i = 0; i < nr_pages; i++) {
+		subpage = folio_page(dst_folio, i);
+		page_kaddr = kmap_local_page(subpage);
+		if (!allow_pagefault)
+			pagefault_disable();
 		rc = copy_from_user(page_kaddr,
 				usr_src + i * PAGE_SIZE, PAGE_SIZE);
-		if (allow_pagefault)
-			kunmap(subpage);
-		else
-			kunmap_atomic(page_kaddr);
+		if (!allow_pagefault)
+			pagefault_enable();
+		kunmap_local(page_kaddr);
 
 		ret_val -= (PAGE_SIZE - rc);
 		if (rc)
 			break;
 
-		flush_dcache_page(subpage);
-
 		cond_resched();
 	}
+	flush_dcache_folio(dst_folio);
 	return ret_val;
 }
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE || CONFIG_HUGETLBFS */
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 263191c37fb5..a7da26cdb731 100644
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
@@ -423,12 +423,10 @@ static __always_inline ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
 
 		if (unlikely(err == -ENOENT)) {
 			mmap_read_unlock(dst_mm);
-			BUG_ON(!page);
+			BUG_ON(!folio);
 
-			err = copy_huge_page_from_user(page,
-						(const void __user *)src_addr,
-						vma_hpagesize / PAGE_SIZE,
-						true);
+			err = copy_folio_from_user(folio,
+						(const void __user *) src_addr, true);
 			if (unlikely(err)) {
 				err = -EFAULT;
 				goto out;
@@ -438,7 +436,7 @@ static __always_inline ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
 			dst_vma = NULL;
 			goto retry;
 		} else
-			BUG_ON(page);
+			BUG_ON(folio);
 
 		if (!err) {
 			dst_addr += vma_hpagesize;
@@ -455,8 +453,8 @@ static __always_inline ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
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

