Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0038062E6AC
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 22:16:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240618AbiKQVQG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 16:16:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240779AbiKQVP1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 16:15:27 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2078884335
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 13:15:14 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AHLE1C0027418;
        Thu, 17 Nov 2022 21:15:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2022-7-12;
 bh=0qWyxReQlxSizjSVKyD4aM3NoT7R0refv45YW4nsk6s=;
 b=N2QYyLOpbtBsCVAKGcAkRb2UOdDcw8rMtQOScRJnPLB/lMfveZgtrNoMpLYVHHwoGv7k
 NXJHtzAYZyNluJp3hnAq/yy8voikYsGf0BKPTciFLJuabeMyFzG48kL15cL6V/Gs8JfS
 Pw4zCuHb9WBNxhAr8YgJ8ZaXJ/IRPAxeRpe2RFAHMJ6ZM6Rw1iASvnaDPBmo58o60HEd
 vgJx2DmrVrO5a7RPB+l/+OTVgKzk6jywobciKEhHzDU9zHzEvZkKGpVHNNYdkKHdqL4m
 RcSZwOpVOh4rkB9K3VoMYsBJiXQjNWDqeaRQ7c9Mk89zFaIMymlMnMJT/DzftE0iuPpo MQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kv3jstfam-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Nov 2022 21:15:04 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2AHKdRa8010850;
        Thu, 17 Nov 2022 21:15:04 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kt1x9nqqg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Nov 2022 21:15:03 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2AHLEx7c024557;
        Thu, 17 Nov 2022 21:15:03 GMT
Received: from sid-dell.us.oracle.com (dhcp-10-132-95-73.usdhcp.oraclecorp.com [10.132.95.73])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3kt1x9nqku-7;
        Thu, 17 Nov 2022 21:15:03 +0000
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, songmuchun@bytedance.com,
        mike.kravetz@oracle.com, willy@infradead.org,
        almasrymina@google.com, linmiaohe@huawei.com, hughd@google.com,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH mm-unstable v3 06/10] mm/hugetlb: convert add_hugetlb_page() to folios and add hugetlb_cma_folio()
Date:   Thu, 17 Nov 2022 13:14:57 -0800
Message-Id: <20221117211501.17150-7-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221117211501.17150-1-sidhartha.kumar@oracle.com>
References: <20221117211501.17150-1-sidhartha.kumar@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-17_06,2022-11-17_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 phishscore=0
 spamscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211170152
X-Proofpoint-ORIG-GUID: 9Z2UtI9eYvBe4UgxK_xjpndkp5YKbKbz
X-Proofpoint-GUID: 9Z2UtI9eYvBe4UgxK_xjpndkp5YKbKbz
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert add_hugetlb_page() to take in a folio, also convert
hugetlb_cma_page() to take in a folio.

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
 mm/hugetlb.c | 40 ++++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 80301fab56d8..bf36aa8e6072 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -54,13 +54,13 @@ struct hstate hstates[HUGE_MAX_HSTATE];
 #ifdef CONFIG_CMA
 static struct cma *hugetlb_cma[MAX_NUMNODES];
 static unsigned long hugetlb_cma_size_in_node[MAX_NUMNODES] __initdata;
-static bool hugetlb_cma_page(struct page *page, unsigned int order)
+static bool hugetlb_cma_folio(struct folio *folio, unsigned int order)
 {
-	return cma_pages_valid(hugetlb_cma[page_to_nid(page)], page,
+	return cma_pages_valid(hugetlb_cma[folio_nid(folio)], &folio->page,
 				1 << order);
 }
 #else
-static bool hugetlb_cma_page(struct page *page, unsigned int order)
+static bool hugetlb_cma_folio(struct folio *folio, unsigned int order)
 {
 	return false;
 }
@@ -1506,17 +1506,17 @@ static void remove_hugetlb_folio_for_demote(struct hstate *h, struct folio *foli
 	__remove_hugetlb_folio(h, folio, adjust_surplus, true);
 }
 
-static void add_hugetlb_page(struct hstate *h, struct page *page,
+static void add_hugetlb_folio(struct hstate *h, struct folio *folio,
 			     bool adjust_surplus)
 {
 	int zeroed;
-	int nid = page_to_nid(page);
+	int nid = folio_nid(folio);
 
-	VM_BUG_ON_PAGE(!HPageVmemmapOptimized(page), page);
+	VM_BUG_ON_FOLIO(!folio_test_hugetlb_vmemmap_optimized(folio), folio);
 
 	lockdep_assert_held(&hugetlb_lock);
 
-	INIT_LIST_HEAD(&page->lru);
+	INIT_LIST_HEAD(&folio->lru);
 	h->nr_huge_pages++;
 	h->nr_huge_pages_node[nid]++;
 
@@ -1525,21 +1525,21 @@ static void add_hugetlb_page(struct hstate *h, struct page *page,
 		h->surplus_huge_pages_node[nid]++;
 	}
 
-	set_compound_page_dtor(page, HUGETLB_PAGE_DTOR);
-	set_page_private(page, 0);
+	folio_set_compound_dtor(folio, HUGETLB_PAGE_DTOR);
+	folio_change_private(folio, 0);
 	/*
 	 * We have to set HPageVmemmapOptimized again as above
-	 * set_page_private(page, 0) cleared it.
+	 * folio_change_private(folio, 0) cleared it.
 	 */
-	SetHPageVmemmapOptimized(page);
+	folio_set_hugetlb_vmemmap_optimized(folio);
 
 	/*
-	 * This page is about to be managed by the hugetlb allocator and
+	 * This folio is about to be managed by the hugetlb allocator and
 	 * should have no users.  Drop our reference, and check for others
 	 * just in case.
 	 */
-	zeroed = put_page_testzero(page);
-	if (!zeroed)
+	zeroed = folio_put_testzero(folio);
+	if (unlikely(!zeroed))
 		/*
 		 * It is VERY unlikely soneone else has taken a ref on
 		 * the page.  In this case, we simply return as the
@@ -1548,8 +1548,8 @@ static void add_hugetlb_page(struct hstate *h, struct page *page,
 		 */
 		return;
 
-	arch_clear_hugepage_flags(page);
-	enqueue_huge_page(h, page);
+	arch_clear_hugepage_flags(&folio->page);
+	enqueue_huge_page(h, &folio->page);
 }
 
 static void __update_and_free_page(struct hstate *h, struct page *page)
@@ -1575,7 +1575,7 @@ static void __update_and_free_page(struct hstate *h, struct page *page)
 		 * page and put the page back on the hugetlb free list and treat
 		 * as a surplus page.
 		 */
-		add_hugetlb_page(h, page, true);
+		add_hugetlb_folio(h, page_folio(page), true);
 		spin_unlock_irq(&hugetlb_lock);
 		return;
 	}
@@ -1600,7 +1600,7 @@ static void __update_and_free_page(struct hstate *h, struct page *page)
 	 * need to be given back to CMA in free_gigantic_page.
 	 */
 	if (hstate_is_gigantic(h) ||
-	    hugetlb_cma_page(page, huge_page_order(h))) {
+	    hugetlb_cma_folio(folio, huge_page_order(h))) {
 		destroy_compound_gigantic_folio(folio, huge_page_order(h));
 		free_gigantic_page(page, huge_page_order(h));
 	} else {
@@ -2184,7 +2184,7 @@ int dissolve_free_huge_page(struct page *page)
 			update_and_free_hugetlb_folio(h, folio, false);
 		} else {
 			spin_lock_irq(&hugetlb_lock);
-			add_hugetlb_page(h, &folio->page, false);
+			add_hugetlb_folio(h, folio, false);
 			h->max_huge_pages++;
 			spin_unlock_irq(&hugetlb_lock);
 		}
@@ -3451,7 +3451,7 @@ static int demote_free_huge_page(struct hstate *h, struct page *page)
 		/* Allocation of vmemmmap failed, we can not demote page */
 		spin_lock_irq(&hugetlb_lock);
 		set_page_refcounted(page);
-		add_hugetlb_page(h, page, false);
+		add_hugetlb_folio(h, page_folio(page), false);
 		return rc;
 	}
 
-- 
2.38.1

