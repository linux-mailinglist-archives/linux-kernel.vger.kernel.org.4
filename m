Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3818162FFF0
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 23:21:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbiKRWVI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 17:21:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230490AbiKRWUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 17:20:35 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 002229A5CB
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 14:20:32 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AILNiEn010938;
        Fri, 18 Nov 2022 22:20:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2022-7-12;
 bh=zGX+Paz/jOxcPkmu5FIpP7u2F4f1Aw/VOFV5GSkM3Xw=;
 b=ujCfcGxoq6w02oR9p4QckAZ74SGShWnCVoDscaUMWv0RKnbW1DhM1D18iM8CFDZ0U6+l
 X8VAIB6GkhtFshXlPIIrYVvB48ftvrWWljZW70oOS/aAImc6P+ljGwELTG6Z5g+PNSHr
 Y6D6ZjNIZprXMThkkk/Ti5x+H/5RkNwCdlhZvhEDLzamwFfttVhEWqvxvRl3DoWFLzca
 C/VJkQrC/0gucPV0mE3PNgKb9lbCrYYqGcS3PlkQRip5SS6g3NJM3Q52c17rTJO1vak2
 JJQTrPMYjpJ8O8BW705kvDNzoXMQoNDlf4w1PgXghp1m+j9sflI5zpdRTc53Aau42usT bA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kxbub995f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Nov 2022 22:20:24 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2AIKWW5r001830;
        Fri, 18 Nov 2022 22:20:22 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ku3kc1f80-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Nov 2022 22:20:22 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2AIMK7qf040370;
        Fri, 18 Nov 2022 22:20:22 GMT
Received: from sid-dell.us.oracle.com (dhcp-10-159-141-24.vpn.oracle.com [10.159.141.24])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3ku3kc1esc-10;
        Fri, 18 Nov 2022 22:20:22 +0000
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, songmuchun@bytedance.com,
        mike.kravetz@oracle.com, willy@infradead.org,
        almasrymina@google.com, linmiaohe@huawei.com, hughd@google.com,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH mm-unstable v4 09/10] mm/hugetlb: convert hugetlb prep functions to folios
Date:   Fri, 18 Nov 2022 14:20:01 -0800
Message-Id: <20221118222002.82588-10-sidhartha.kumar@oracle.com>
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
X-Proofpoint-ORIG-GUID: FLqtD_HLNaeGxmDRqt3G973sQyU_Etud
X-Proofpoint-GUID: FLqtD_HLNaeGxmDRqt3G973sQyU_Etud
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert prep_new_huge_page() and __prep_compound_gigantic_page() to
folios.

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
 mm/hugetlb.c | 63 +++++++++++++++++++++++++---------------------------
 1 file changed, 30 insertions(+), 33 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index c28d3c67bc0b..b690ea7aaa00 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1789,29 +1789,27 @@ static void __prep_new_hugetlb_folio(struct hstate *h, struct folio *folio)
 	set_hugetlb_cgroup_rsvd(folio, NULL);
 }
 
-static void prep_new_huge_page(struct hstate *h, struct page *page, int nid)
+static void prep_new_hugetlb_folio(struct hstate *h, struct folio *folio, int nid)
 {
-	struct folio *folio = page_folio(page);
-
 	__prep_new_hugetlb_folio(h, folio);
 	spin_lock_irq(&hugetlb_lock);
 	__prep_account_new_huge_page(h, nid);
 	spin_unlock_irq(&hugetlb_lock);
 }
 
-static bool __prep_compound_gigantic_page(struct page *page, unsigned int order,
-								bool demote)
+static bool __prep_compound_gigantic_folio(struct folio *folio,
+					unsigned int order, bool demote)
 {
 	int i, j;
 	int nr_pages = 1 << order;
 	struct page *p;
 
-	/* we rely on prep_new_huge_page to set the destructor */
-	set_compound_order(page, order);
-	__ClearPageReserved(page);
-	__SetPageHead(page);
+	/* we rely on prep_new_hugetlb_folio to set the destructor */
+	folio_set_compound_order(folio, order);
+	__folio_clear_reserved(folio);
+	__folio_set_head(folio);
 	for (i = 0; i < nr_pages; i++) {
-		p = nth_page(page, i);
+		p = folio_page(folio, i);
 
 		/*
 		 * For gigantic hugepages allocated through bootmem at
@@ -1853,43 +1851,41 @@ static bool __prep_compound_gigantic_page(struct page *page, unsigned int order,
 			VM_BUG_ON_PAGE(page_count(p), p);
 		}
 		if (i != 0)
-			set_compound_head(p, page);
+			set_compound_head(p, &folio->page);
 	}
-	atomic_set(compound_mapcount_ptr(page), -1);
-	atomic_set(subpages_mapcount_ptr(page), 0);
-	atomic_set(compound_pincount_ptr(page), 0);
+	atomic_set(folio_mapcount_ptr(folio), -1);
+	atomic_set(folio_subpages_mapcount_ptr(folio), 0);
+	atomic_set(folio_pincount_ptr(folio), 0);
 	return true;
 
 out_error:
 	/* undo page modifications made above */
 	for (j = 0; j < i; j++) {
-		p = nth_page(page, j);
+		p = folio_page(folio, j);
 		if (j != 0)
 			clear_compound_head(p);
 		set_page_refcounted(p);
 	}
 	/* need to clear PG_reserved on remaining tail pages  */
 	for (; j < nr_pages; j++) {
-		p = nth_page(page, j);
+		p = folio_page(folio, j);
 		__ClearPageReserved(p);
 	}
-	set_compound_order(page, 0);
-#ifdef CONFIG_64BIT
-	page[1].compound_nr = 0;
-#endif
-	__ClearPageHead(page);
+	folio_set_compound_order(folio, 0);
+	__folio_clear_head(folio);
 	return false;
 }
 
-static bool prep_compound_gigantic_page(struct page *page, unsigned int order)
+static bool prep_compound_gigantic_folio(struct folio *folio,
+							unsigned int order)
 {
-	return __prep_compound_gigantic_page(page, order, false);
+	return __prep_compound_gigantic_folio(folio, order, false);
 }
 
-static bool prep_compound_gigantic_page_for_demote(struct page *page,
+static bool prep_compound_gigantic_folio_for_demote(struct folio *folio,
 							unsigned int order)
 {
-	return __prep_compound_gigantic_page(page, order, true);
+	return __prep_compound_gigantic_folio(folio, order, true);
 }
 
 /*
@@ -2041,7 +2037,7 @@ static struct page *alloc_fresh_huge_page(struct hstate *h,
 		return NULL;
 	folio = page_folio(page);
 	if (hstate_is_gigantic(h)) {
-		if (!prep_compound_gigantic_page(page, huge_page_order(h))) {
+		if (!prep_compound_gigantic_folio(folio, huge_page_order(h))) {
 			/*
 			 * Rare failure to convert pages to compound page.
 			 * Free pages and try again - ONCE!
@@ -2054,7 +2050,7 @@ static struct page *alloc_fresh_huge_page(struct hstate *h,
 			return NULL;
 		}
 	}
-	prep_new_huge_page(h, page, page_to_nid(page));
+	prep_new_hugetlb_folio(h, folio, folio_nid(folio));
 
 	return page;
 }
@@ -3058,10 +3054,10 @@ static void __init gather_bootmem_prealloc(void)
 		struct hstate *h = m->hstate;
 
 		VM_BUG_ON(!hstate_is_gigantic(h));
-		WARN_ON(page_count(page) != 1);
-		if (prep_compound_gigantic_page(page, huge_page_order(h))) {
-			WARN_ON(PageReserved(page));
-			prep_new_huge_page(h, page, page_to_nid(page));
+		WARN_ON(folio_ref_count(folio) != 1);
+		if (prep_compound_gigantic_folio(folio, huge_page_order(h))) {
+			WARN_ON(folio_test_reserved(folio));
+			prep_new_hugetlb_folio(h, folio, folio_nid(folio));
 			free_huge_page(page); /* add to the hugepage allocator */
 		} else {
 			/* VERY unlikely inflated ref count on a tail page */
@@ -3480,13 +3476,14 @@ static int demote_free_huge_page(struct hstate *h, struct page *page)
 	for (i = 0; i < pages_per_huge_page(h);
 				i += pages_per_huge_page(target_hstate)) {
 		subpage = nth_page(page, i);
+		folio = page_folio(subpage);
 		if (hstate_is_gigantic(target_hstate))
-			prep_compound_gigantic_page_for_demote(subpage,
+			prep_compound_gigantic_folio_for_demote(folio,
 							target_hstate->order);
 		else
 			prep_compound_page(subpage, target_hstate->order);
 		set_page_private(subpage, 0);
-		prep_new_huge_page(target_hstate, subpage, nid);
+		prep_new_hugetlb_folio(target_hstate, folio, nid);
 		free_huge_page(subpage);
 	}
 	mutex_unlock(&target_hstate->resize_lock);
-- 
2.38.1

