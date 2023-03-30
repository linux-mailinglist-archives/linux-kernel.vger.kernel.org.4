Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D27F6D0714
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 15:41:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232125AbjC3Nls (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 09:41:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232050AbjC3Nlh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 09:41:37 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53233AD0C
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 06:41:34 -0700 (PDT)
Received: from kwepemm600020.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4PnPf41JkyzKwBL;
        Thu, 30 Mar 2023 21:39:08 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 kwepemm600020.china.huawei.com (7.193.23.147) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 30 Mar 2023 21:41:31 +0800
From:   Peng Zhang <zhangpeng362@huawei.com>
To:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <akpm@linux-foundation.org>, <willy@infradead.org>,
        <mike.kravetz@oracle.com>
CC:     <vishal.moola@gmail.com>, <muchun.song@linux.dev>,
        <sidhartha.kumar@oracle.com>, <wangkefeng.wang@huawei.com>,
        <sunnanyong@huawei.com>, ZhangPeng <zhangpeng362@huawei.com>
Subject: [PATCH v4 4/6] userfaultfd: convert mfill_atomic_hugetlb() to use a folio
Date:   Thu, 30 Mar 2023 21:40:43 +0800
Message-ID: <20230330134045.375163-5-zhangpeng362@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230330134045.375163-1-zhangpeng362@huawei.com>
References: <20230330134045.375163-1-zhangpeng362@huawei.com>
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

Convert hugetlb_mfill_atomic_pte() to take in a folio pointer instead of
a page pointer. Convert mfill_atomic_hugetlb() to use a folio.

Signed-off-by: ZhangPeng <zhangpeng362@huawei.com>
---
 include/linux/hugetlb.h |  4 ++--
 mm/hugetlb.c            | 26 +++++++++++++-------------
 mm/userfaultfd.c        | 16 ++++++++--------
 3 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 2a758bcd6719..28703fe22386 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -163,7 +163,7 @@ int hugetlb_mfill_atomic_pte(pte_t *dst_pte,
 			     unsigned long dst_addr,
 			     unsigned long src_addr,
 			     uffd_flags_t flags,
-			     struct page **pagep);
+			     struct folio **foliop);
 #endif /* CONFIG_USERFAULTFD */
 bool hugetlb_reserve_pages(struct inode *inode, long from, long to,
 						struct vm_area_struct *vma,
@@ -397,7 +397,7 @@ static inline int hugetlb_mfill_atomic_pte(pte_t *dst_pte,
 					   unsigned long dst_addr,
 					   unsigned long src_addr,
 					   uffd_flags_t flags,
-					   struct page **pagep)
+					   struct folio **foliop)
 {
 	BUG();
 	return 0;
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index aade1b513474..c88f856ec2e2 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -6178,7 +6178,7 @@ int hugetlb_mfill_atomic_pte(pte_t *dst_pte,
 			     unsigned long dst_addr,
 			     unsigned long src_addr,
 			     uffd_flags_t flags,
-			     struct page **pagep)
+			     struct folio **foliop)
 {
 	struct mm_struct *dst_mm = dst_vma->vm_mm;
 	bool is_continue = uffd_flags_mode_is(flags, MFILL_ATOMIC_CONTINUE);
@@ -6201,8 +6201,8 @@ int hugetlb_mfill_atomic_pte(pte_t *dst_pte,
 		if (IS_ERR(folio))
 			goto out;
 		folio_in_pagecache = true;
-	} else if (!*pagep) {
-		/* If a page already exists, then it's UFFDIO_COPY for
+	} else if (!*foliop) {
+		/* If a folio already exists, then it's UFFDIO_COPY for
 		 * a non-missing case. Return -EEXIST.
 		 */
 		if (vm_shared &&
@@ -6237,33 +6237,33 @@ int hugetlb_mfill_atomic_pte(pte_t *dst_pte,
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
index b453a4d2a0d3..9e95af5ce2dd 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -322,7 +322,7 @@ static __always_inline ssize_t mfill_atomic_hugetlb(
 	pte_t *dst_pte;
 	unsigned long src_addr, dst_addr;
 	long copied;
-	struct page *page;
+	struct folio *folio;
 	unsigned long vma_hpagesize;
 	pgoff_t idx;
 	u32 hash;
@@ -342,7 +342,7 @@ static __always_inline ssize_t mfill_atomic_hugetlb(
 	src_addr = src_start;
 	dst_addr = dst_start;
 	copied = 0;
-	page = NULL;
+	folio = NULL;
 	vma_hpagesize = vma_kernel_pagesize(dst_vma);
 
 	/*
@@ -411,7 +411,7 @@ static __always_inline ssize_t mfill_atomic_hugetlb(
 		}
 
 		err = hugetlb_mfill_atomic_pte(dst_pte, dst_vma, dst_addr,
-					       src_addr, flags, &page);
+					       src_addr, flags, &folio);
 
 		hugetlb_vma_unlock_read(dst_vma);
 		mutex_unlock(&hugetlb_fault_mutex_table[hash]);
@@ -420,9 +420,9 @@ static __always_inline ssize_t mfill_atomic_hugetlb(
 
 		if (unlikely(err == -ENOENT)) {
 			mmap_read_unlock(dst_mm);
-			BUG_ON(!page);
+			BUG_ON(!folio);
 
-			err = copy_folio_from_user(page_folio(page),
+			err = copy_folio_from_user(folio,
 						   (const void __user *)src_addr, true);
 			if (unlikely(err)) {
 				err = -EFAULT;
@@ -433,7 +433,7 @@ static __always_inline ssize_t mfill_atomic_hugetlb(
 			dst_vma = NULL;
 			goto retry;
 		} else
-			BUG_ON(page);
+			BUG_ON(folio);
 
 		if (!err) {
 			dst_addr += vma_hpagesize;
@@ -450,8 +450,8 @@ static __always_inline ssize_t mfill_atomic_hugetlb(
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

