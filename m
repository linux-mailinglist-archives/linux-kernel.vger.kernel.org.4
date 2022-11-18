Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E03C462FFEF
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 23:21:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbiKRWVG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 17:21:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230398AbiKRWUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 17:20:34 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 005F49A5C9
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 14:20:31 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AILNqQI028279;
        Fri, 18 Nov 2022 22:20:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2022-7-12;
 bh=AsgMZ2LJqnopBhIKo6BhJx8thhSJpl8MTE3CrL6uzHY=;
 b=FY21OGcSxwsSiMUvablV/wK+6LPXJdaFuVBubQdLf8qHe8JUbh/xDG0VHH9uXxdoCDJL
 CgXiBxQLoV37W6TMt548DZyiox0xd5msxdaOggKahtMY+1QRWWKRDLQ3m5MbLa5dcAEP
 DnswYClXb6cKf6+MFX50G/MTYCECGoowCPVJ/xOeGrCqkjCAQ9hp1iubpDHCuP65saLF
 DIYddoO9C7czJbG5VZSKe73e0eQ8LR5b3kfSEEMI8Y4MZgQFzyI7+UdrHBdtqjvQtW1J
 waCJb7NJrUSJxZrLl614DuHIMqUXiRDQ6dvlaxvPrNDGRQyseosANBlwk7W+U/9BsKLE tg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kxh458859-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Nov 2022 22:20:21 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2AIKooLE001656;
        Fri, 18 Nov 2022 22:20:20 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ku3kc1f6f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Nov 2022 22:20:20 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2AIMK7qd040370;
        Fri, 18 Nov 2022 22:20:20 GMT
Received: from sid-dell.us.oracle.com (dhcp-10-159-141-24.vpn.oracle.com [10.159.141.24])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3ku3kc1esc-9;
        Fri, 18 Nov 2022 22:20:20 +0000
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, songmuchun@bytedance.com,
        mike.kravetz@oracle.com, willy@infradead.org,
        almasrymina@google.com, linmiaohe@huawei.com, hughd@google.com,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH mm-unstable v4 08/10] mm/hugetlb: convert free_gigantic_page() to folios
Date:   Fri, 18 Nov 2022 14:20:00 -0800
Message-Id: <20221118222002.82588-9-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221118222002.82588-1-sidhartha.kumar@oracle.com>
References: <20221118222002.82588-1-sidhartha.kumar@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-18_08,2022-11-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 adultscore=0
 phishscore=0 malwarescore=0 suspectscore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211180133
X-Proofpoint-ORIG-GUID: gLCHJ9oRVphfWHUDuwHHQjHXKYnFPcdQ
X-Proofpoint-GUID: gLCHJ9oRVphfWHUDuwHHQjHXKYnFPcdQ
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
index 36ae789009dc..c28d3c67bc0b 100644
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
@@ -2025,6 +2028,7 @@ static struct page *alloc_fresh_huge_page(struct hstate *h,
 		nodemask_t *node_alloc_noretry)
 {
 	struct page *page;
+	struct folio *folio;
 	bool retry = false;
 
 retry:
@@ -2035,14 +2039,14 @@ static struct page *alloc_fresh_huge_page(struct hstate *h,
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
@@ -3050,6 +3054,7 @@ static void __init gather_bootmem_prealloc(void)
 
 	list_for_each_entry(m, &huge_boot_pages, list) {
 		struct page *page = virt_to_page(m);
+		struct folio *folio = page_folio(page);
 		struct hstate *h = m->hstate;
 
 		VM_BUG_ON(!hstate_is_gigantic(h));
@@ -3060,7 +3065,7 @@ static void __init gather_bootmem_prealloc(void)
 			free_huge_page(page); /* add to the hugepage allocator */
 		} else {
 			/* VERY unlikely inflated ref count on a tail page */
-			free_gigantic_page(page, huge_page_order(h));
+			free_gigantic_folio(folio, huge_page_order(h));
 		}
 
 		/*
-- 
2.38.1

