Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2D0762E642
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 22:03:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240269AbiKQVDx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 16:03:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234809AbiKQVDk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 16:03:40 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA6BC22BEA
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 13:03:34 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AHKOOsY002460;
        Thu, 17 Nov 2022 21:03:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2022-7-12;
 bh=cwkUHEJT5bDkOzVSGa3m03Vwd59Go/cano1leZnsjBU=;
 b=f7crwLu4zaBU+jwvzBHOsYEFrBd4NcUw3Xj6RAYVogF3jVfljo5ZOF49cyR2Rs6gokzL
 ce8BkqUGJEKvSg1Zyaw7J1/kBeDGQLJgLcavHmRYc/cQ40zYGwB4wnl/cvfh4hb+rXqs
 BFks4NnwRTL/vlUoHndVl/bpYLUrd2/x4d7jWSDI3HvR0ZYhxibUbQUp4vmFW0oJ/yjC
 bbuneS01PvTsn7kgov1+08G8WT+OzeiqdKG3DMxaIU7LDxX/qH3i2AMXjCQ/gpTWTTTO
 QLeh5FnCY2d+fwdptTy8TZesQYyUzdaX4UZI4JkZ+fQRB6W80AfrZYIIb51ncyjYXjn2 cA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kv8yktgn8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Nov 2022 21:03:22 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2AHKXQTe010907;
        Thu, 17 Nov 2022 21:03:20 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ku3kagyax-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Nov 2022 21:03:20 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2AHL37Fr032582;
        Thu, 17 Nov 2022 21:03:19 GMT
Received: from sid-dell.us.oracle.com (dhcp-10-132-95-73.usdhcp.oraclecorp.com [10.132.95.73])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3ku3kagy08-9;
        Thu, 17 Nov 2022 21:03:19 +0000
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, songmuchun@bytedance.com,
        mike.kravetz@oracle.com, willy@infradead.org,
        almasrymina@google.com, linmiaohe@huawei.com, hughd@google.com,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH mm-unstable v2 08/10] mm/hugetlb: convert free_gigantic_page() to folios
Date:   Thu, 17 Nov 2022 13:02:56 -0800
Message-Id: <20221117210258.12732-9-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221117210258.12732-1-sidhartha.kumar@oracle.com>
References: <20221117210258.12732-1-sidhartha.kumar@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-17_06,2022-11-17_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 adultscore=0
 phishscore=0 malwarescore=0 suspectscore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211170150
X-Proofpoint-GUID: AbH47GrRIcaFuj3YJ6J0Owjvw9P9qaQ9
X-Proofpoint-ORIG-GUID: AbH47GrRIcaFuj3YJ6J0Owjvw9P9qaQ9
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert callers of free_gigantic_page() to use folios, function is then
renamed to free_gigantic_folio().

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
 mm/hugetlb.c | 29 +++++++++++++++++------------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 4eb6f3d6f46e..38c5ca015363 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1361,18 +1361,20 @@ static void destroy_compound_gigantic_folio(struct folio *folio,
 	__destroy_compound_gigantic_folio(folio, order, false);
 }
 
-static void free_gigantic_page(struct page *page, unsigned int order)
+static void free_gigantic_folio(struct folio *folio, unsigned int order)
 {
 	/*
 	 * If the page isn't allocated using the cma allocator,
 	 * cma_release() returns false.
 	 */
 #ifdef CONFIG_CMA
-	if (cma_release(hugetlb_cma[page_to_nid(page)], page, 1 << order))
+	int nid = folio_nid(folio);
+
+	if (cma_release(hugetlb_cma[nid], &folio->page, 1 << order))
 		return;
 #endif
 
-	free_contig_range(page_to_pfn(page), 1 << order);
+	free_contig_range(folio_pfn(folio), 1 << order);
 }
 
 #ifdef CONFIG_CONTIG_ALLOC
@@ -1426,7 +1428,8 @@ static struct page *alloc_gigantic_page(struct hstate *h, gfp_t gfp_mask,
 {
 	return NULL;
 }
-static inline void free_gigantic_page(struct page *page, unsigned int order) { }
+static inline void free_gigantic_folio(struct folio *folio,
+						unsigned int order) { }
 static inline void destroy_compound_gigantic_folio(struct folio *folio,
 						unsigned int order) { }
 #endif
@@ -1565,7 +1568,7 @@ static void __update_and_free_page(struct hstate *h, struct page *page)
 	 * If we don't know which subpages are hwpoisoned, we can't free
 	 * the hugepage, so it's leaked intentionally.
 	 */
-	if (HPageRawHwpUnreliable(page))
+	if (folio_test_hugetlb_raw_hwp_unreliable(folio))
 		return;
 
 	if (hugetlb_vmemmap_restore(h, page)) {
@@ -1575,7 +1578,7 @@ static void __update_and_free_page(struct hstate *h, struct page *page)
 		 * page and put the page back on the hugetlb free list and treat
 		 * as a surplus page.
 		 */
-		add_hugetlb_folio(h, page_folio(page), true);
+		add_hugetlb_folio(h, folio, true);
 		spin_unlock_irq(&hugetlb_lock);
 		return;
 	}
@@ -1588,7 +1591,7 @@ static void __update_and_free_page(struct hstate *h, struct page *page)
 		hugetlb_clear_page_hwpoison(&folio->page);
 
 	for (i = 0; i < pages_per_huge_page(h); i++) {
-		subpage = nth_page(page, i);
+		subpage = folio_page(folio, i);
 		subpage->flags &= ~(1 << PG_locked | 1 << PG_error |
 				1 << PG_referenced | 1 << PG_dirty |
 				1 << PG_active | 1 << PG_private |
@@ -1597,12 +1600,12 @@ static void __update_and_free_page(struct hstate *h, struct page *page)
 
 	/*
 	 * Non-gigantic pages demoted from CMA allocated gigantic pages
-	 * need to be given back to CMA in free_gigantic_page.
+	 * need to be given back to CMA in free_gigantic_folio.
 	 */
 	if (hstate_is_gigantic(h) ||
 	    hugetlb_cma_folio(folio, huge_page_order(h))) {
 		destroy_compound_gigantic_folio(folio, huge_page_order(h));
-		free_gigantic_page(page, huge_page_order(h));
+		free_gigantic_folio(folio, huge_page_order(h));
 	} else {
 		__free_pages(page, huge_page_order(h));
 	}
@@ -2023,6 +2026,7 @@ static struct page *alloc_fresh_huge_page(struct hstate *h,
 		nodemask_t *node_alloc_noretry)
 {
 	struct page *page;
+	struct folio *folio;
 	bool retry = false;
 
 retry:
@@ -2033,14 +2037,14 @@ static struct page *alloc_fresh_huge_page(struct hstate *h,
 				nid, nmask, node_alloc_noretry);
 	if (!page)
 		return NULL;
-
+	folio = page_folio(page);
 	if (hstate_is_gigantic(h)) {
 		if (!prep_compound_gigantic_page(page, huge_page_order(h))) {
 			/*
 			 * Rare failure to convert pages to compound page.
 			 * Free pages and try again - ONCE!
 			 */
-			free_gigantic_page(page, huge_page_order(h));
+			free_gigantic_folio(folio, huge_page_order(h));
 			if (!retry) {
 				retry = true;
 				goto retry;
@@ -3048,6 +3052,7 @@ static void __init gather_bootmem_prealloc(void)
 
 	list_for_each_entry(m, &huge_boot_pages, list) {
 		struct page *page = virt_to_page(m);
+		struct folio *folio = page_folio(page);
 		struct hstate *h = m->hstate;
 
 		VM_BUG_ON(!hstate_is_gigantic(h));
@@ -3058,7 +3063,7 @@ static void __init gather_bootmem_prealloc(void)
 			free_huge_page(page); /* add to the hugepage allocator */
 		} else {
 			/* VERY unlikely inflated ref count on a tail page */
-			free_gigantic_page(page, huge_page_order(h));
+			free_gigantic_folio(folio, huge_page_order(h));
 		}
 
 		/*
-- 
2.38.1

