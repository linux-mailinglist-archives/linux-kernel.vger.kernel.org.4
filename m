Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E6CC6C8BEC
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 07:56:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231902AbjCYG4h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 02:56:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231866AbjCYG4X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 02:56:23 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED163168B7
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 23:56:21 -0700 (PDT)
Received: from kwepemm600020.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Pk8sx1B65znY5G;
        Sat, 25 Mar 2023 14:53:09 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 kwepemm600020.china.huawei.com (7.193.23.147) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Sat, 25 Mar 2023 14:56:19 +0800
From:   Peng Zhang <zhangpeng362@huawei.com>
To:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <willy@infradead.org>, <mike.kravetz@oracle.com>
CC:     <akpm@linux-foundation.org>, <vishal.moola@gmail.com>,
        <muchun.song@linux.dev>, <sidhartha.kumar@oracle.com>,
        <wangkefeng.wang@huawei.com>, <sunnanyong@huawei.com>,
        ZhangPeng <zhangpeng362@huawei.com>
Subject: [PATCH v3 6/6] userfaultfd: convert __mcopy_atomic() to use a folio
Date:   Sat, 25 Mar 2023 14:56:08 +0800
Message-ID: <20230325065608.601391-7-zhangpeng362@huawei.com>
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

Convert mcopy_atomic_pte(), shmem_mfill_atomic_pte() and
mfill_atomic_pte() to take in a folio pointer.
Convert __mcopy_atomic() to use a folio.

Signed-off-by: ZhangPeng <zhangpeng362@huawei.com>
---
 include/linux/shmem_fs.h |  2 +-
 mm/shmem.c               | 16 ++++++++--------
 mm/userfaultfd.c         | 34 +++++++++++++++++-----------------
 3 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
index 103d1000a5a2..580af0e3bf02 100644
--- a/include/linux/shmem_fs.h
+++ b/include/linux/shmem_fs.h
@@ -156,7 +156,7 @@ extern int shmem_mfill_atomic_pte(struct mm_struct *dst_mm, pmd_t *dst_pmd,
 				  unsigned long dst_addr,
 				  unsigned long src_addr,
 				  bool zeropage, bool wp_copy,
-				  struct page **pagep);
+				  struct folio **foliop);
 #else /* !CONFIG_SHMEM */
 #define shmem_mfill_atomic_pte(dst_mm, dst_pmd, dst_vma, dst_addr, \
 			       src_addr, zeropage, wp_copy, pagep) ({ BUG(); 0; })
diff --git a/mm/shmem.c b/mm/shmem.c
index 448f393d8ab2..e07e11a5812b 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2421,7 +2421,7 @@ int shmem_mfill_atomic_pte(struct mm_struct *dst_mm,
 			   unsigned long dst_addr,
 			   unsigned long src_addr,
 			   bool zeropage, bool wp_copy,
-			   struct page **pagep)
+			   struct folio **foliop)
 {
 	struct inode *inode = file_inode(dst_vma->vm_file);
 	struct shmem_inode_info *info = SHMEM_I(inode);
@@ -2439,14 +2439,14 @@ int shmem_mfill_atomic_pte(struct mm_struct *dst_mm,
 		 * and now we find ourselves with -ENOMEM. Release the page, to
 		 * avoid a BUG_ON in our caller.
 		 */
-		if (unlikely(*pagep)) {
-			put_page(*pagep);
-			*pagep = NULL;
+		if (unlikely(*foliop)) {
+			folio_put(*foliop);
+			*foliop = NULL;
 		}
 		return -ENOMEM;
 	}
 
-	if (!*pagep) {
+	if (!*foliop) {
 		ret = -ENOMEM;
 		folio = shmem_alloc_folio(gfp, info, pgoff);
 		if (!folio)
@@ -2478,7 +2478,7 @@ int shmem_mfill_atomic_pte(struct mm_struct *dst_mm,
 
 			/* fallback to copy_from_user outside mmap_lock */
 			if (unlikely(ret)) {
-				*pagep = &folio->page;
+				*foliop = folio;
 				ret = -ENOENT;
 				/* don't free the page */
 				goto out_unacct_blocks;
@@ -2489,9 +2489,9 @@ int shmem_mfill_atomic_pte(struct mm_struct *dst_mm,
 			clear_user_highpage(&folio->page, dst_addr);
 		}
 	} else {
-		folio = page_folio(*pagep);
+		folio = *foliop;
 		VM_BUG_ON_FOLIO(folio_test_large(folio), folio);
-		*pagep = NULL;
+		*foliop = NULL;
 	}
 
 	VM_BUG_ON(folio_test_locked(folio));
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index cbcc7eb1d36e..2cecaf507b3f 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -132,14 +132,14 @@ static int mcopy_atomic_pte(struct mm_struct *dst_mm,
 			    struct vm_area_struct *dst_vma,
 			    unsigned long dst_addr,
 			    unsigned long src_addr,
-			    struct page **pagep,
+			    struct folio **foliop,
 			    bool wp_copy)
 {
 	void *page_kaddr;
 	int ret;
 	struct folio *folio;
 
-	if (!*pagep) {
+	if (!*foliop) {
 		ret = -ENOMEM;
 		folio = vma_alloc_folio(GFP_HIGHUSER_MOVABLE, 0, dst_vma, dst_addr, false);
 		if (!folio)
@@ -171,16 +171,16 @@ static int mcopy_atomic_pte(struct mm_struct *dst_mm,
 		/* fallback to copy_from_user outside mmap_lock */
 		if (unlikely(ret)) {
 			ret = -ENOENT;
-			*pagep = &folio->page;
+			*foliop = folio;
 			/* don't free the page */
 			goto out;
 		}
 
 		flush_dcache_folio(folio);
 	} else {
-		folio = page_folio(*pagep);
+		folio = *foliop;
 		VM_BUG_ON_FOLIO(folio_test_large(folio), folio);
-		*pagep = NULL;
+		*foliop = NULL;
 	}
 
 	/*
@@ -476,7 +476,7 @@ static __always_inline ssize_t mfill_atomic_pte(struct mm_struct *dst_mm,
 						struct vm_area_struct *dst_vma,
 						unsigned long dst_addr,
 						unsigned long src_addr,
-						struct page **page,
+						struct folio **foliop,
 						enum mcopy_atomic_mode mode,
 						bool wp_copy)
 {
@@ -500,7 +500,7 @@ static __always_inline ssize_t mfill_atomic_pte(struct mm_struct *dst_mm,
 	if (!(dst_vma->vm_flags & VM_SHARED)) {
 		if (mode == MCOPY_ATOMIC_NORMAL)
 			err = mcopy_atomic_pte(dst_mm, dst_pmd, dst_vma,
-					       dst_addr, src_addr, page,
+					       dst_addr, src_addr, foliop,
 					       wp_copy);
 		else
 			err = mfill_zeropage_pte(dst_mm, dst_pmd,
@@ -509,7 +509,7 @@ static __always_inline ssize_t mfill_atomic_pte(struct mm_struct *dst_mm,
 		err = shmem_mfill_atomic_pte(dst_mm, dst_pmd, dst_vma,
 					     dst_addr, src_addr,
 					     mode != MCOPY_ATOMIC_NORMAL,
-					     wp_copy, page);
+					     wp_copy, foliop);
 	}
 
 	return err;
@@ -528,7 +528,7 @@ static __always_inline ssize_t __mcopy_atomic(struct mm_struct *dst_mm,
 	pmd_t *dst_pmd;
 	unsigned long src_addr, dst_addr;
 	long copied;
-	struct page *page;
+	struct folio *folio;
 	bool wp_copy;
 
 	/*
@@ -544,7 +544,7 @@ static __always_inline ssize_t __mcopy_atomic(struct mm_struct *dst_mm,
 	src_addr = src_start;
 	dst_addr = dst_start;
 	copied = 0;
-	page = NULL;
+	folio = NULL;
 retry:
 	mmap_read_lock(dst_mm);
 
@@ -641,16 +641,16 @@ static __always_inline ssize_t __mcopy_atomic(struct mm_struct *dst_mm,
 		BUG_ON(pmd_trans_huge(*dst_pmd));
 
 		err = mfill_atomic_pte(dst_mm, dst_pmd, dst_vma, dst_addr,
-				       src_addr, &page, mcopy_mode, wp_copy);
+				       src_addr, &folio, mcopy_mode, wp_copy);
 		cond_resched();
 
 		if (unlikely(err == -ENOENT)) {
 			void *page_kaddr;
 
 			mmap_read_unlock(dst_mm);
-			BUG_ON(!page);
+			BUG_ON(!folio);
 
-			page_kaddr = kmap_local_page(page);
+			page_kaddr = kmap_local_folio(folio, 0);
 			err = copy_from_user(page_kaddr,
 					     (const void __user *) src_addr,
 					     PAGE_SIZE);
@@ -659,10 +659,10 @@ static __always_inline ssize_t __mcopy_atomic(struct mm_struct *dst_mm,
 				err = -EFAULT;
 				goto out;
 			}
-			flush_dcache_page(page);
+			flush_dcache_folio(folio);
 			goto retry;
 		} else
-			BUG_ON(page);
+			BUG_ON(folio);
 
 		if (!err) {
 			dst_addr += PAGE_SIZE;
@@ -679,8 +679,8 @@ static __always_inline ssize_t __mcopy_atomic(struct mm_struct *dst_mm,
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

