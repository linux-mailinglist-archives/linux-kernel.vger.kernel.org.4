Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA89271F837
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 03:54:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233325AbjFBByb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 21:54:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231628AbjFBBy1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 21:54:27 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDE9CD3
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 18:54:26 -0700 (PDT)
Received: from kwepemm600020.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4QXQsz316BzqTcc;
        Fri,  2 Jun 2023 09:49:43 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 kwepemm600020.china.huawei.com (7.193.23.147) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 2 Jun 2023 09:54:23 +0800
From:   Peng Zhang <zhangpeng362@huawei.com>
To:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <akpm@linux-foundation.org>, <willy@infradead.org>,
        <mike.kravetz@oracle.com>
CC:     <muchun.song@linux.dev>, <sidhartha.kumar@oracle.com>,
        <vishal.moola@gmail.com>, <wangkefeng.wang@huawei.com>,
        <sunnanyong@huawei.com>, ZhangPeng <zhangpeng362@huawei.com>
Subject: [PATCH 1/2] mm/hugetlb: Use a folio in copy_hugetlb_page_range()
Date:   Fri, 2 Jun 2023 09:54:07 +0800
Message-ID: <20230602015408.376149-2-zhangpeng362@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230602015408.376149-1-zhangpeng362@huawei.com>
References: <20230602015408.376149-1-zhangpeng362@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600020.china.huawei.com (7.193.23.147)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ZhangPeng <zhangpeng362@huawei.com>

We can replace five implict calls to compound_head() with one by using
pte_folio. However, we still need to keep ptepage because we need to know
which page in the folio we are copying.

Suggested-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: ZhangPeng <zhangpeng362@huawei.com>
---
 mm/hugetlb.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index ea24718db4af..0b774dd3d57b 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5017,6 +5017,7 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 {
 	pte_t *src_pte, *dst_pte, entry;
 	struct page *ptepage;
+	struct folio *pte_folio;
 	unsigned long addr;
 	bool cow = is_cow_mapping(src_vma->vm_flags);
 	struct hstate *h = hstate_vma(src_vma);
@@ -5116,7 +5117,8 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 		} else {
 			entry = huge_ptep_get(src_pte);
 			ptepage = pte_page(entry);
-			get_page(ptepage);
+			pte_folio = page_folio(ptepage);
+			folio_get(pte_folio);
 
 			/*
 			 * Failing to duplicate the anon rmap is a rare case
@@ -5128,7 +5130,7 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 			 * need to be without the pgtable locks since we could
 			 * sleep during the process.
 			 */
-			if (!PageAnon(ptepage)) {
+			if (!folio_test_anon(pte_folio)) {
 				page_dup_file_rmap(ptepage, true);
 			} else if (page_try_dup_anon_rmap(ptepage, true,
 							  src_vma)) {
@@ -5140,14 +5142,14 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 				/* Do not use reserve as it's private owned */
 				new_folio = alloc_hugetlb_folio(dst_vma, addr, 1);
 				if (IS_ERR(new_folio)) {
-					put_page(ptepage);
+					folio_put(pte_folio);
 					ret = PTR_ERR(new_folio);
 					break;
 				}
 				ret = copy_user_large_folio(new_folio,
-						      page_folio(ptepage),
-						      addr, dst_vma);
-				put_page(ptepage);
+							    pte_folio,
+							    addr, dst_vma);
+				folio_put(pte_folio);
 				if (ret) {
 					folio_put(new_folio);
 					break;
-- 
2.25.1

