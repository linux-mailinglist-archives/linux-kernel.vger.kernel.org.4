Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BAE06B95F3
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 14:20:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbjCNNU3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 09:20:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232569AbjCNNUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 09:20:03 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D758C10273
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 06:16:44 -0700 (PDT)
Received: from kwepemm600020.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4PbYqh1thZzHwdP;
        Tue, 14 Mar 2023 21:13:20 +0800 (CST)
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
Subject: [PATCH v2 3/3] userfaultfd: convert __mcopy_atomic() to use a folio
Date:   Tue, 14 Mar 2023 13:13:50 +0000
Message-ID: <20230314131350.924377-4-zhangpeng362@huawei.com>
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

Convert mcopy_atomic_pte(), shmem_mfill_atomic_pte() and
mfill_atomic_pte() to pass in a folio pointer.
Convert __mcopy_atomic() to use a folio.

Signed-off-by: ZhangPeng <zhangpeng362@huawei.com>
---
 include/linux/shmem_fs.h |  2 +-
 mm/shmem.c               | 17 ++++++++---------
 mm/userfaultfd.c         | 35 +++++++++++++++++------------------
 3 files changed, 26 insertions(+), 28 deletions(-)

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
index 448f393d8ab2..986267bf34ef 100644
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
@@ -2489,9 +2489,8 @@ int shmem_mfill_atomic_pte(struct mm_struct *dst_mm,
 			clear_user_highpage(&folio->page, dst_addr);
 		}
 	} else {
-		folio = page_folio(*pagep);
-		VM_BUG_ON_FOLIO(folio_test_large(folio), folio);
-		*pagep = NULL;
+		VM_BUG_ON_FOLIO(folio_test_large(*foliop), folio);
+		*foliop = NULL;
 	}
 
 	VM_BUG_ON(folio_test_locked(folio));
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index a7da26cdb731..cfe2d527f1c0 100644
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
@@ -171,16 +171,15 @@ static int mcopy_atomic_pte(struct mm_struct *dst_mm,
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
-		VM_BUG_ON_FOLIO(folio_test_large(folio), folio);
-		*pagep = NULL;
+		VM_BUG_ON_FOLIO(folio_test_large(*foliop), folio);
+		*foliop = NULL;
 	}
 
 	/*
@@ -476,7 +475,7 @@ static __always_inline ssize_t mfill_atomic_pte(struct mm_struct *dst_mm,
 						struct vm_area_struct *dst_vma,
 						unsigned long dst_addr,
 						unsigned long src_addr,
-						struct page **page,
+						struct folio **foliop,
 						enum mcopy_atomic_mode mode,
 						bool wp_copy)
 {
@@ -500,7 +499,7 @@ static __always_inline ssize_t mfill_atomic_pte(struct mm_struct *dst_mm,
 	if (!(dst_vma->vm_flags & VM_SHARED)) {
 		if (mode == MCOPY_ATOMIC_NORMAL)
 			err = mcopy_atomic_pte(dst_mm, dst_pmd, dst_vma,
-					       dst_addr, src_addr, page,
+					       dst_addr, src_addr, foliop,
 					       wp_copy);
 		else
 			err = mfill_zeropage_pte(dst_mm, dst_pmd,
@@ -509,7 +508,7 @@ static __always_inline ssize_t mfill_atomic_pte(struct mm_struct *dst_mm,
 		err = shmem_mfill_atomic_pte(dst_mm, dst_pmd, dst_vma,
 					     dst_addr, src_addr,
 					     mode != MCOPY_ATOMIC_NORMAL,
-					     wp_copy, page);
+					     wp_copy, foliop);
 	}
 
 	return err;
@@ -528,7 +527,7 @@ static __always_inline ssize_t __mcopy_atomic(struct mm_struct *dst_mm,
 	pmd_t *dst_pmd;
 	unsigned long src_addr, dst_addr;
 	long copied;
-	struct page *page;
+	struct folio *folio;
 	bool wp_copy;
 
 	/*
@@ -544,7 +543,7 @@ static __always_inline ssize_t __mcopy_atomic(struct mm_struct *dst_mm,
 	src_addr = src_start;
 	dst_addr = dst_start;
 	copied = 0;
-	page = NULL;
+	folio = NULL;
 retry:
 	mmap_read_lock(dst_mm);
 
@@ -641,16 +640,16 @@ static __always_inline ssize_t __mcopy_atomic(struct mm_struct *dst_mm,
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
@@ -659,10 +658,10 @@ static __always_inline ssize_t __mcopy_atomic(struct mm_struct *dst_mm,
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
@@ -679,8 +678,8 @@ static __always_inline ssize_t __mcopy_atomic(struct mm_struct *dst_mm,
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

