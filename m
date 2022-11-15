Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A058B62A3FE
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 22:23:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238718AbiKOVXK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 16:23:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230480AbiKOVWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 16:22:50 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F87021E27
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 13:22:48 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AFKBwUw022508;
        Tue, 15 Nov 2022 21:22:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2022-7-12;
 bh=l6pQ/QCJuSbmIlwypPHGacUcrC4q4nIGq/FftDEzLUE=;
 b=bMfqqNaiuAfZCh0AjmiUxL2cTySomJy85PP1PRggcBP8bh6HnIJnv8G2jUhaJBbEZa/Q
 LLH6jYllysUwJWEGfSVWlrMyYndJDbwNVuSl9ooQOEHkqHZZTiF5EMnscavuylzFaxbr
 Vu7ENFOcb78fmWUshJ8gM5MZ8tit4UmQet+ltyAqOMrzlIXeZJOKOBYbZcUz1neKUeyE
 FuNFJfgt5sIMZF8GSG0PlHf6hV92qjKcvc2W0luEOEJE2oH8//Qglvp4MoIph/e7CAB1
 4JQlewj+iwYNIvAJwPkXmH2rvpEv/2gDw0/LEz5iKVVUlPLjHSw4BQZhPtk3zTrYeNrp 6w== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kv3ns2ybu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Nov 2022 21:22:34 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2AFJhvLf032077;
        Tue, 15 Nov 2022 21:22:31 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kt1xcfveu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Nov 2022 21:22:31 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2AFLMSRe002082;
        Tue, 15 Nov 2022 21:22:31 GMT
Received: from dhcp-10-132-95-73.usdhcp.oraclecorp.com.com (dhcp-10-132-95-73.usdhcp.oraclecorp.com [10.132.95.73])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3kt1xcfvb0-3;
        Tue, 15 Nov 2022 21:22:30 +0000
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, songmuchun@bytedance.com,
        mike.kravetz@oracle.com, willy@infradead.org,
        almasrymina@google.com, linmiaohe@huawei.com, hughd@google.com,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH mm-unstable 02/10] mm/hugetlb: convert destroy_compound_gigantic_page() to folios
Date:   Tue, 15 Nov 2022 13:22:09 -0800
Message-Id: <20221115212217.19539-3-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221115212217.19539-1-sidhartha.kumar@oracle.com>
References: <20221115212217.19539-1-sidhartha.kumar@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-15_08,2022-11-15_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=930 phishscore=0
 suspectscore=0 malwarescore=0 mlxscore=0 adultscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211150146
X-Proofpoint-GUID: qRqmsSvymaaVj34QTAbtu48juYVKn4H6
X-Proofpoint-ORIG-GUID: qRqmsSvymaaVj34QTAbtu48juYVKn4H6
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert page operations within __destroy_compound_gigantic_page() to the
corresponding folio operations.

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
 mm/hugetlb.c | 41 ++++++++++++++++++++---------------------
 1 file changed, 20 insertions(+), 21 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 1acde3b8251e..cf52cd0d571e 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1317,42 +1317,39 @@ static int hstate_next_node_to_free(struct hstate *h, nodemask_t *nodes_allowed)
 		nr_nodes--)
 
 /* used to demote non-gigantic_huge pages as well */
-static void __destroy_compound_gigantic_page(struct page *page,
+static void __destroy_compound_gigantic_folio(struct folio *folio,
 					unsigned int order, bool demote)
 {
 	int i;
 	int nr_pages = 1 << order;
 	struct page *p;
 
-	atomic_set(compound_mapcount_ptr(page), 0);
-	atomic_set(compound_pincount_ptr(page), 0);
+	atomic_set(folio_mapcount_ptr(folio), 0);
+	atomic_set(folio_pincount_ptr(folio), 0);
 
 	for (i = 1; i < nr_pages; i++) {
-		p = nth_page(page, i);
+		p = folio_page(folio, i);
 		p->mapping = NULL;
 		clear_compound_head(p);
 		if (!demote)
 			set_page_refcounted(p);
 	}
 
-	set_compound_order(page, 0);
-#ifdef CONFIG_64BIT
-	page[1].compound_nr = 0;
-#endif
-	__ClearPageHead(page);
+	folio_set_compound_order(folio, 0);
+	folio_clear_head(folio);
 }
 
-static void destroy_compound_hugetlb_page_for_demote(struct page *page,
+static void destroy_compound_hugetlb_folio_for_demote(struct folio *folio,
 					unsigned int order)
 {
-	__destroy_compound_gigantic_page(page, order, true);
+	__destroy_compound_gigantic_folio(folio, order, true);
 }
 
 #ifdef CONFIG_ARCH_HAS_GIGANTIC_PAGE
-static void destroy_compound_gigantic_page(struct page *page,
+static void destroy_compound_gigantic_folio(struct folio *folio,
 					unsigned int order)
 {
-	__destroy_compound_gigantic_page(page, order, false);
+	__destroy_compound_gigantic_folio(folio, order, false);
 }
 
 static void free_gigantic_page(struct page *page, unsigned int order)
@@ -1421,7 +1418,7 @@ static struct page *alloc_gigantic_page(struct hstate *h, gfp_t gfp_mask,
 	return NULL;
 }
 static inline void free_gigantic_page(struct page *page, unsigned int order) { }
-static inline void destroy_compound_gigantic_page(struct page *page,
+static inline void destroy_compound_gigantic_folio(struct folio *folio,
 						unsigned int order) { }
 #endif
 
@@ -1468,8 +1465,8 @@ static void __remove_hugetlb_page(struct hstate *h, struct page *page,
 	 *
 	 * For gigantic pages set the destructor to the null dtor.  This
 	 * destructor will never be called.  Before freeing the gigantic
-	 * page destroy_compound_gigantic_page will turn the compound page
-	 * into a simple group of pages.  After this the destructor does not
+	 * page destroy_compound_gigantic_folio will turn the folio into a
+	 * simple group of pages.  After this the destructor does not
 	 * apply.
 	 *
 	 * This handles the case where more than one ref is held when and
@@ -1550,6 +1547,7 @@ static void add_hugetlb_page(struct hstate *h, struct page *page,
 static void __update_and_free_page(struct hstate *h, struct page *page)
 {
 	int i;
+	struct folio *folio = page_folio(page);
 	struct page *subpage;
 
 	if (hstate_is_gigantic(h) && !gigantic_page_runtime_supported())
@@ -1578,8 +1576,8 @@ static void __update_and_free_page(struct hstate *h, struct page *page)
 	 * Move PageHWPoison flag from head page to the raw error pages,
 	 * which makes any healthy subpages reusable.
 	 */
-	if (unlikely(PageHWPoison(page)))
-		hugetlb_clear_page_hwpoison(page);
+	if (unlikely(folio_test_hwpoison(folio)))
+		hugetlb_clear_page_hwpoison(&folio->page);
 
 	for (i = 0; i < pages_per_huge_page(h); i++) {
 		subpage = nth_page(page, i);
@@ -1595,7 +1593,7 @@ static void __update_and_free_page(struct hstate *h, struct page *page)
 	 */
 	if (hstate_is_gigantic(h) ||
 	    hugetlb_cma_page(page, huge_page_order(h))) {
-		destroy_compound_gigantic_page(page, huge_page_order(h));
+		destroy_compound_gigantic_folio(folio, huge_page_order(h));
 		free_gigantic_page(page, huge_page_order(h));
 	} else {
 		__free_pages(page, huge_page_order(h));
@@ -3426,6 +3424,7 @@ static int demote_free_huge_page(struct hstate *h, struct page *page)
 {
 	int i, nid = page_to_nid(page);
 	struct hstate *target_hstate;
+	struct folio *folio = page_folio(page);
 	struct page *subpage;
 	int rc = 0;
 
@@ -3444,10 +3443,10 @@ static int demote_free_huge_page(struct hstate *h, struct page *page)
 	}
 
 	/*
-	 * Use destroy_compound_hugetlb_page_for_demote for all huge page
+	 * Use destroy_compound_hugetlb_folio_for_demote for all huge page
 	 * sizes as it will not ref count pages.
 	 */
-	destroy_compound_hugetlb_page_for_demote(page, huge_page_order(h));
+	destroy_compound_hugetlb_folio_for_demote(folio, huge_page_order(h));
 
 	/*
 	 * Taking target hstate mutex synchronizes with set_max_huge_pages.
-- 
2.38.1

