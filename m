Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC81C62FFEC
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 23:20:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbiKRWUx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 17:20:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230299AbiKRWUb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 17:20:31 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E95B39A269
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 14:20:30 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AILU16w007898;
        Fri, 18 Nov 2022 22:20:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2022-7-12;
 bh=RHKiiVc28hJsMCo6RKUzQfHyZDcgMk6bAgu3H8/3i84=;
 b=OPKUKIperTgeSLKAXCH+TLcK59t+CkPU971CcGTZMmahY03KRTCmy8JhKRWtWMWmkziG
 FM4B8K4ieOZujNZA0HGPpnRyNSjM3gCTVWcI9JWuK0J66iQ4UUeBkj9A5kNNGC0YLwZr
 qTSCZGRDeJ6tkz1binh1f7GVSBcRHLYPyfiFvAueRAoduw2iPOm15Lbfa0EGW9kZ4HS6
 tNYC747rPNLgCbdLgIbgWVX4IIaq8NzOViywYaVuy8NWpkRxzDBB1AVqrIVgFQa7MlBa
 ydjxjJR64j6DJBAlobfMMJfe3dQie/7g/agesKDPSKCs5HtD2p8YZla/eAPzgoj7iUIU bQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kxg1gredv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Nov 2022 22:20:13 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2AIKNcpJ002620;
        Fri, 18 Nov 2022 22:20:11 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ku3kc1ex3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Nov 2022 22:20:11 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2AIMK7qR040370;
        Fri, 18 Nov 2022 22:20:10 GMT
Received: from sid-dell.us.oracle.com (dhcp-10-159-141-24.vpn.oracle.com [10.159.141.24])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3ku3kc1esc-3;
        Fri, 18 Nov 2022 22:20:10 +0000
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, songmuchun@bytedance.com,
        mike.kravetz@oracle.com, willy@infradead.org,
        almasrymina@google.com, linmiaohe@huawei.com, hughd@google.com,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH mm-unstable v4 02/10] mm/hugetlb: convert destroy_compound_gigantic_page() to folios
Date:   Fri, 18 Nov 2022 14:19:54 -0800
Message-Id: <20221118222002.82588-3-sidhartha.kumar@oracle.com>
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
X-Proofpoint-GUID: L6W28uzzG4lp2HvGtvnLRibKpFBP5Z0P
X-Proofpoint-ORIG-GUID: L6W28uzzG4lp2HvGtvnLRibKpFBP5Z0P
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
 mm/hugetlb.c | 43 +++++++++++++++++++++----------------------
 1 file changed, 21 insertions(+), 22 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 6390de8975c5..f6f791675c38 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1325,43 +1325,40 @@ static int hstate_next_node_to_free(struct hstate *h, nodemask_t *nodes_allowed)
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
-	atomic_set(subpages_mapcount_ptr(page), 0);
-	atomic_set(compound_pincount_ptr(page), 0);
+	atomic_set(folio_mapcount_ptr(folio), 0);
+	atomic_set(folio_subpages_mapcount_ptr(folio), 0);
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
+	__folio_clear_head(folio);
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
@@ -1430,7 +1427,7 @@ static struct page *alloc_gigantic_page(struct hstate *h, gfp_t gfp_mask,
 	return NULL;
 }
 static inline void free_gigantic_page(struct page *page, unsigned int order) { }
-static inline void destroy_compound_gigantic_page(struct page *page,
+static inline void destroy_compound_gigantic_folio(struct folio *folio,
 						unsigned int order) { }
 #endif
 
@@ -1477,8 +1474,8 @@ static void __remove_hugetlb_page(struct hstate *h, struct page *page,
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
@@ -1559,6 +1556,7 @@ static void add_hugetlb_page(struct hstate *h, struct page *page,
 static void __update_and_free_page(struct hstate *h, struct page *page)
 {
 	int i;
+	struct folio *folio = page_folio(page);
 	struct page *subpage;
 
 	if (hstate_is_gigantic(h) && !gigantic_page_runtime_supported())
@@ -1587,8 +1585,8 @@ static void __update_and_free_page(struct hstate *h, struct page *page)
 	 * Move PageHWPoison flag from head page to the raw error pages,
 	 * which makes any healthy subpages reusable.
 	 */
-	if (unlikely(PageHWPoison(page)))
-		hugetlb_clear_page_hwpoison(page);
+	if (unlikely(folio_test_hwpoison(folio)))
+		hugetlb_clear_page_hwpoison(&folio->page);
 
 	for (i = 0; i < pages_per_huge_page(h); i++) {
 		subpage = nth_page(page, i);
@@ -1604,7 +1602,7 @@ static void __update_and_free_page(struct hstate *h, struct page *page)
 	 */
 	if (hstate_is_gigantic(h) ||
 	    hugetlb_cma_page(page, huge_page_order(h))) {
-		destroy_compound_gigantic_page(page, huge_page_order(h));
+		destroy_compound_gigantic_folio(folio, huge_page_order(h));
 		free_gigantic_page(page, huge_page_order(h));
 	} else {
 		__free_pages(page, huge_page_order(h));
@@ -3437,6 +3435,7 @@ static int demote_free_huge_page(struct hstate *h, struct page *page)
 {
 	int i, nid = page_to_nid(page);
 	struct hstate *target_hstate;
+	struct folio *folio = page_folio(page);
 	struct page *subpage;
 	int rc = 0;
 
@@ -3455,10 +3454,10 @@ static int demote_free_huge_page(struct hstate *h, struct page *page)
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

