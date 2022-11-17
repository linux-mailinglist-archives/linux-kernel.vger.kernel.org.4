Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B5EB62E643
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 22:03:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240350AbiKQVD4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 16:03:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234747AbiKQVDk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 16:03:40 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA5B322BE3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 13:03:34 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AHKOKut004819;
        Thu, 17 Nov 2022 21:03:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2022-7-12;
 bh=MCK/rXGUTZNQyhTZ+P51qmllsIFD0ccOv0nuQ2VWPKM=;
 b=MfRqQmhDx6K5xV8shmyIJBd7uIX0lygdVT7WzN3v1ea1XOIxeXlnPBzwtByaUk73rfZv
 dcuu9WvbCG603vi0uF8G3v6h8Cl7bUZpZUqOe3GdOYi3W0IMpxuHR9QupKzKWbTj419C
 sZGiW33H9HNqkzJETyoSi9LaeGcOjbp22YRbXktCUsl9gzMk9HWh8DdZj9Ge005pqkXK
 zlc6D4+Q14y2U6lywcTJXVYb8pmJsSXviuywNfezJzC7J43YykM5f5ur/HJnGeB1BUa5
 5ytmiPQS1GTPwaaWjCUq3QDaQDOcNGI091bMv/8QdqwbB6xB88aBDDEJuaC4e05KyJzQ mw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kv3jste28-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Nov 2022 21:03:24 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2AHKZSqx010894;
        Thu, 17 Nov 2022 21:03:22 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ku3kagycb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Nov 2022 21:03:21 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2AHL37Ft032582;
        Thu, 17 Nov 2022 21:03:21 GMT
Received: from sid-dell.us.oracle.com (dhcp-10-132-95-73.usdhcp.oraclecorp.com [10.132.95.73])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3ku3kagy08-10;
        Thu, 17 Nov 2022 21:03:21 +0000
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, songmuchun@bytedance.com,
        mike.kravetz@oracle.com, willy@infradead.org,
        almasrymina@google.com, linmiaohe@huawei.com, hughd@google.com,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH mm-unstable v2 09/10] mm/hugetlb: convert hugetlb prep functions to folios
Date:   Thu, 17 Nov 2022 13:02:57 -0800
Message-Id: <20221117210258.12732-10-sidhartha.kumar@oracle.com>
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
X-Proofpoint-ORIG-GUID: lMDZlMUHC4wS5IWV71oJIP6jr0QEoaU7
X-Proofpoint-GUID: lMDZlMUHC4wS5IWV71oJIP6jr0QEoaU7
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
 mm/hugetlb.c | 61 +++++++++++++++++++++++++---------------------------
 1 file changed, 29 insertions(+), 32 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 38c5ca015363..6ecf9874c521 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1789,28 +1789,26 @@ static void __prep_new_hugetlb_folio(struct hstate *h, struct folio *folio)
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
-	__SetPageHead(page);
+	/* we rely on prep_new_hugetlb_folio to set the destructor */
+	folio_set_compound_order(folio, order);
+	__SetPageHead(&folio->page);
 	for (i = 0; i < nr_pages; i++) {
-		p = nth_page(page, i);
+		p = folio_page(folio, i);
 
 		/*
 		 * For gigantic hugepages allocated through bootmem at
@@ -1851,43 +1849,41 @@ static bool __prep_compound_gigantic_page(struct page *page, unsigned int order,
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
+	folio_clear_head(folio);
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
@@ -2039,7 +2035,7 @@ static struct page *alloc_fresh_huge_page(struct hstate *h,
 		return NULL;
 	folio = page_folio(page);
 	if (hstate_is_gigantic(h)) {
-		if (!prep_compound_gigantic_page(page, huge_page_order(h))) {
+		if (!prep_compound_gigantic_folio(folio, huge_page_order(h))) {
 			/*
 			 * Rare failure to convert pages to compound page.
 			 * Free pages and try again - ONCE!
@@ -2052,7 +2048,7 @@ static struct page *alloc_fresh_huge_page(struct hstate *h,
 			return NULL;
 		}
 	}
-	prep_new_huge_page(h, page, page_to_nid(page));
+	prep_new_hugetlb_folio(h, folio, folio_nid(folio));
 
 	return page;
 }
@@ -3056,10 +3052,10 @@ static void __init gather_bootmem_prealloc(void)
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
@@ -3478,13 +3474,14 @@ static int demote_free_huge_page(struct hstate *h, struct page *page)
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

