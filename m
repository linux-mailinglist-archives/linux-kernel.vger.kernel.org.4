Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 628546D0716
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 15:41:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232124AbjC3Nlz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 09:41:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232091AbjC3Nli (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 09:41:38 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA8DFAD06
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 06:41:35 -0700 (PDT)
Received: from kwepemm600020.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4PnPd413YbzgZhs;
        Thu, 30 Mar 2023 21:38:16 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 kwepemm600020.china.huawei.com (7.193.23.147) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 30 Mar 2023 21:41:33 +0800
From:   Peng Zhang <zhangpeng362@huawei.com>
To:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <akpm@linux-foundation.org>, <willy@infradead.org>,
        <mike.kravetz@oracle.com>
CC:     <vishal.moola@gmail.com>, <muchun.song@linux.dev>,
        <sidhartha.kumar@oracle.com>, <wangkefeng.wang@huawei.com>,
        <sunnanyong@huawei.com>, ZhangPeng <zhangpeng362@huawei.com>
Subject: [PATCH v4 6/6] userfaultfd: convert mfill_atomic() to use a folio
Date:   Thu, 30 Mar 2023 21:40:45 +0800
Message-ID: <20230330134045.375163-7-zhangpeng362@huawei.com>
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

Convert mfill_atomic_pte_copy(), shmem_mfill_atomic_pte() and
mfill_atomic_pte() to take in a folio pointer.
Convert mfill_atomic() to use a folio.

Signed-off-by: ZhangPeng <zhangpeng362@huawei.com>
---
 include/linux/shmem_fs.h |  4 ++--
 mm/shmem.c               | 16 ++++++++--------
 mm/userfaultfd.c         | 34 +++++++++++++++++-----------------
 3 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
index 3bb8d21edbb3..9e151ba45068 100644
--- a/include/linux/shmem_fs.h
+++ b/include/linux/shmem_fs.h
@@ -158,10 +158,10 @@ extern int shmem_mfill_atomic_pte(pmd_t *dst_pmd,
 				  unsigned long dst_addr,
 				  unsigned long src_addr,
 				  uffd_flags_t flags,
-				  struct page **pagep);
+				  struct folio **foliop);
 #else /* !CONFIG_SHMEM */
 #define shmem_mfill_atomic_pte(dst_pmd, dst_vma, dst_addr, \
-			       src_addr, flags, pagep) ({ BUG(); 0; })
+			       src_addr, flags, foliop) ({ BUG(); 0; })
 #endif /* CONFIG_SHMEM */
 #endif /* CONFIG_USERFAULTFD */
 
diff --git a/mm/shmem.c b/mm/shmem.c
index 6c08f5a75d3a..9218c955f482 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2548,7 +2548,7 @@ int shmem_mfill_atomic_pte(pmd_t *dst_pmd,
 			   unsigned long dst_addr,
 			   unsigned long src_addr,
 			   uffd_flags_t flags,
-			   struct page **pagep)
+			   struct folio **foliop)
 {
 	struct inode *inode = file_inode(dst_vma->vm_file);
 	struct shmem_inode_info *info = SHMEM_I(inode);
@@ -2566,14 +2566,14 @@ int shmem_mfill_atomic_pte(pmd_t *dst_pmd,
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
@@ -2605,7 +2605,7 @@ int shmem_mfill_atomic_pte(pmd_t *dst_pmd,
 
 			/* fallback to copy_from_user outside mmap_lock */
 			if (unlikely(ret)) {
-				*pagep = &folio->page;
+				*foliop = folio;
 				ret = -ENOENT;
 				/* don't free the page */
 				goto out_unacct_blocks;
@@ -2616,9 +2616,9 @@ int shmem_mfill_atomic_pte(pmd_t *dst_pmd,
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
index 9e95af5ce2dd..74b122887901 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -133,13 +133,13 @@ static int mfill_atomic_pte_copy(pmd_t *dst_pmd,
 				 unsigned long dst_addr,
 				 unsigned long src_addr,
 				 uffd_flags_t flags,
-				 struct page **pagep)
+				 struct folio **foliop)
 {
 	void *page_kaddr;
 	int ret;
 	struct folio *folio;
 
-	if (!*pagep) {
+	if (!*foliop) {
 		ret = -ENOMEM;
 		folio = vma_alloc_folio(GFP_HIGHUSER_MOVABLE, 0, dst_vma, dst_addr, false);
 		if (!folio)
@@ -171,16 +171,16 @@ static int mfill_atomic_pte_copy(pmd_t *dst_pmd,
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
@@ -471,7 +471,7 @@ static __always_inline ssize_t mfill_atomic_pte(pmd_t *dst_pmd,
 						unsigned long dst_addr,
 						unsigned long src_addr,
 						uffd_flags_t flags,
-						struct page **pagep)
+						struct folio **foliop)
 {
 	ssize_t err;
 
@@ -494,14 +494,14 @@ static __always_inline ssize_t mfill_atomic_pte(pmd_t *dst_pmd,
 		if (uffd_flags_mode_is(flags, MFILL_ATOMIC_COPY))
 			err = mfill_atomic_pte_copy(dst_pmd, dst_vma,
 						    dst_addr, src_addr,
-						    flags, pagep);
+						    flags, foliop);
 		else
 			err = mfill_atomic_pte_zeropage(dst_pmd,
 						 dst_vma, dst_addr);
 	} else {
 		err = shmem_mfill_atomic_pte(dst_pmd, dst_vma,
 					     dst_addr, src_addr,
-					     flags, pagep);
+					     flags, foliop);
 	}
 
 	return err;
@@ -519,7 +519,7 @@ static __always_inline ssize_t mfill_atomic(struct mm_struct *dst_mm,
 	pmd_t *dst_pmd;
 	unsigned long src_addr, dst_addr;
 	long copied;
-	struct page *page;
+	struct folio *folio;
 
 	/*
 	 * Sanitize the command parameters:
@@ -534,7 +534,7 @@ static __always_inline ssize_t mfill_atomic(struct mm_struct *dst_mm,
 	src_addr = src_start;
 	dst_addr = dst_start;
 	copied = 0;
-	page = NULL;
+	folio = NULL;
 retry:
 	mmap_read_lock(dst_mm);
 
@@ -630,16 +630,16 @@ static __always_inline ssize_t mfill_atomic(struct mm_struct *dst_mm,
 		BUG_ON(pmd_trans_huge(*dst_pmd));
 
 		err = mfill_atomic_pte(dst_pmd, dst_vma, dst_addr,
-				       src_addr, flags, &page);
+				       src_addr, flags, &folio);
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
@@ -648,10 +648,10 @@ static __always_inline ssize_t mfill_atomic(struct mm_struct *dst_mm,
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
@@ -668,8 +668,8 @@ static __always_inline ssize_t mfill_atomic(struct mm_struct *dst_mm,
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

