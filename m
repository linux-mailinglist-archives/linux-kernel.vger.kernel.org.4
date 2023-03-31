Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC7FA6D1CBD
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 11:42:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230356AbjCaJmE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 05:42:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232282AbjCaJl7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 05:41:59 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 697FD72BB
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 02:41:51 -0700 (PDT)
Received: from kwepemm600020.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4PnwJQ5znfzrYkH;
        Fri, 31 Mar 2023 17:40:38 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 kwepemm600020.china.huawei.com (7.193.23.147) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 31 Mar 2023 17:41:48 +0800
From:   Peng Zhang <zhangpeng362@huawei.com>
To:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <akpm@linux-foundation.org>, <willy@infradead.org>,
        <mike.kravetz@oracle.com>, <sidhartha.kumar@oracle.com>
CC:     <vishal.moola@gmail.com>, <muchun.song@linux.dev>,
        <wangkefeng.wang@huawei.com>, <sunnanyong@huawei.com>,
        ZhangPeng <zhangpeng362@huawei.com>
Subject: [PATCH v5 1/6] userfaultfd: convert mfill_atomic_pte_copy() to use a folio
Date:   Fri, 31 Mar 2023 17:39:32 +0800
Message-ID: <20230331093937.945725-2-zhangpeng362@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230331093937.945725-1-zhangpeng362@huawei.com>
References: <20230331093937.945725-1-zhangpeng362@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
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

Call vma_alloc_folio() directly instead of alloc_page_vma() and convert
page_kaddr to kaddr in mfill_atomic_pte_copy(). Removes several calls to
compound_head().

Signed-off-by: ZhangPeng <zhangpeng362@huawei.com>
Reviewed-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
 mm/userfaultfd.c | 33 +++++++++++++++++----------------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 7f1b5f8b712c..24d6ed7ff302 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -135,17 +135,18 @@ static int mfill_atomic_pte_copy(pmd_t *dst_pmd,
 				 uffd_flags_t flags,
 				 struct page **pagep)
 {
-	void *page_kaddr;
+	void *kaddr;
 	int ret;
-	struct page *page;
+	struct folio *folio;
 
 	if (!*pagep) {
 		ret = -ENOMEM;
-		page = alloc_page_vma(GFP_HIGHUSER_MOVABLE, dst_vma, dst_addr);
-		if (!page)
+		folio = vma_alloc_folio(GFP_HIGHUSER_MOVABLE, 0, dst_vma,
+					dst_addr, false);
+		if (!folio)
 			goto out;
 
-		page_kaddr = kmap_local_page(page);
+		kaddr = kmap_local_folio(folio, 0);
 		/*
 		 * The read mmap_lock is held here.  Despite the
 		 * mmap_lock being read recursive a deadlock is still
@@ -162,45 +163,45 @@ static int mfill_atomic_pte_copy(pmd_t *dst_pmd,
 		 * and retry the copy outside the mmap_lock.
 		 */
 		pagefault_disable();
-		ret = copy_from_user(page_kaddr,
-				     (const void __user *) src_addr,
+		ret = copy_from_user(kaddr, (const void __user *) src_addr,
 				     PAGE_SIZE);
 		pagefault_enable();
-		kunmap_local(page_kaddr);
+		kunmap_local(kaddr);
 
 		/* fallback to copy_from_user outside mmap_lock */
 		if (unlikely(ret)) {
 			ret = -ENOENT;
-			*pagep = page;
+			*pagep = &folio->page;
 			/* don't free the page */
 			goto out;
 		}
 
-		flush_dcache_page(page);
+		flush_dcache_folio(folio);
 	} else {
-		page = *pagep;
+		folio = page_folio(*pagep);
+		VM_BUG_ON_FOLIO(folio_test_large(folio), folio);
 		*pagep = NULL;
 	}
 
 	/*
-	 * The memory barrier inside __SetPageUptodate makes sure that
+	 * The memory barrier inside __folio_mark_uptodate makes sure that
 	 * preceding stores to the page contents become visible before
 	 * the set_pte_at() write.
 	 */
-	__SetPageUptodate(page);
+	__folio_mark_uptodate(folio);
 
 	ret = -ENOMEM;
-	if (mem_cgroup_charge(page_folio(page), dst_vma->vm_mm, GFP_KERNEL))
+	if (mem_cgroup_charge(folio, dst_vma->vm_mm, GFP_KERNEL))
 		goto out_release;
 
 	ret = mfill_atomic_install_pte(dst_pmd, dst_vma, dst_addr,
-				       page, true, flags);
+				       &folio->page, true, flags);
 	if (ret)
 		goto out_release;
 out:
 	return ret;
 out_release:
-	put_page(page);
+	folio_put(folio);
 	goto out;
 }
 
-- 
2.25.1

