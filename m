Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A40726B969E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 14:43:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231503AbjCNNna (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 09:43:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231556AbjCNNnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 09:43:01 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0895494A52
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 06:40:17 -0700 (PDT)
Received: from kwepemm600020.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4PbYsv3jx7zKmjN;
        Tue, 14 Mar 2023 21:15:15 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 kwepemm600020.china.huawei.com (7.193.23.147) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 14 Mar 2023 21:15:28 +0800
From:   Peng Zhang <zhangpeng362@huawei.com>
To:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <willy@infradead.org>
CC:     <akpm@linux-foundation.org>, <mike.kravetz@oracle.com>,
        <vishal.moola@gmail.com>, <sidhartha.kumar@oracle.com>,
        <wangkefeng.wang@huawei.com>, <sunnanyong@huawei.com>,
        ZhangPeng <zhangpeng362@huawei.com>
Subject: [PATCH v2 1/3] userfaultfd: convert mcopy_atomic_pte() to use a folio
Date:   Tue, 14 Mar 2023 13:13:48 +0000
Message-ID: <20230314131350.924377-2-zhangpeng362@huawei.com>
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

Call vma_alloc_folio() directly instead of alloc_page_vma(). Add an
assertion that this is a single-page folio and removes several calls to
compound_head().

Signed-off-by: ZhangPeng <zhangpeng362@huawei.com>
---
 mm/userfaultfd.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 53c3d916ff66..263191c37fb5 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -137,15 +137,15 @@ static int mcopy_atomic_pte(struct mm_struct *dst_mm,
 {
 	void *page_kaddr;
 	int ret;
-	struct page *page;
+	struct folio *folio;
 
 	if (!*pagep) {
 		ret = -ENOMEM;
-		page = alloc_page_vma(GFP_HIGHUSER_MOVABLE, dst_vma, dst_addr);
-		if (!page)
+		folio = vma_alloc_folio(GFP_HIGHUSER_MOVABLE, 0, dst_vma, dst_addr, false);
+		if (!folio)
 			goto out;
 
-		page_kaddr = kmap_local_page(page);
+		page_kaddr = kmap_local_folio(folio, 0);
 		/*
 		 * The read mmap_lock is held here.  Despite the
 		 * mmap_lock being read recursive a deadlock is still
@@ -171,36 +171,37 @@ static int mcopy_atomic_pte(struct mm_struct *dst_mm,
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
-	if (mem_cgroup_charge(page_folio(page), dst_mm, GFP_KERNEL))
+	if (mem_cgroup_charge(folio, dst_mm, GFP_KERNEL))
 		goto out_release;
 
 	ret = mfill_atomic_install_pte(dst_mm, dst_pmd, dst_vma, dst_addr,
-				       page, true, wp_copy);
+				       &folio->page, true, wp_copy);
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

