Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C67D62E6AE
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 22:16:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240863AbiKQVQO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 16:16:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240785AbiKQVP2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 16:15:28 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 402B8725D7
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 13:15:15 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AHLEGdV000786;
        Thu, 17 Nov 2022 21:15:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2022-7-12;
 bh=cqECmlw3uurUHKox1I6ZdisuXQoCt6s1cy/6t7wynMs=;
 b=qL30yY0jr6ljOLZCv8DWjFmNovpZ9cosgqnYBZK/BLygReSyOM7YNkJlVC9YScfaPZz7
 2KcowcjTaereDgpfgTLlt8EmNh7okZh6igBMftOOVkszADxTTSCpzduB4CrCxwyh8jZ4
 6gwXI9qvX/6zmKn3AbZ22z11txssGfrVudvVweFGGWuUePpc3Z30tf9t11VQly916CwR
 ul/sifON/HulEnUpJmitg4PiJR32sJHpGSVgVKL4xIG5LLW5mmc9olCteuYzTlm0B1X5
 NbDAuVs7PmqydgoiLtwokE38K21vSqyOsnHC/OXjEVDNNdj3dAT8aSNkQygNz1fwhaeK qQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kv8ykthg3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Nov 2022 21:15:05 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2AHKrqUS010778;
        Thu, 17 Nov 2022 21:15:03 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kt1x9nqpx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Nov 2022 21:15:03 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2AHLEx7a024557;
        Thu, 17 Nov 2022 21:15:02 GMT
Received: from sid-dell.us.oracle.com (dhcp-10-132-95-73.usdhcp.oraclecorp.com [10.132.95.73])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3kt1x9nqku-6;
        Thu, 17 Nov 2022 21:15:02 +0000
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, songmuchun@bytedance.com,
        mike.kravetz@oracle.com, willy@infradead.org,
        almasrymina@google.com, linmiaohe@huawei.com, hughd@google.com,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH mm-unstable v3 05/10] mm/hugetlb: convert update_and_free_page() to folios
Date:   Thu, 17 Nov 2022 13:14:56 -0800
Message-Id: <20221117211501.17150-6-sidhartha.kumar@oracle.com>
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
X-Proofpoint-GUID: c7lu4abh0h8pd6OSNEfIR-TS5DzbqwA6
X-Proofpoint-ORIG-GUID: c7lu4abh0h8pd6OSNEfIR-TS5DzbqwA6
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make more progress on converting the free_huge_page() destructor to
operate on folios by converting update_and_free_page() to folios.

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
 mm/hugetlb.c | 30 ++++++++++++++++--------------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index d9604c0dac54..80301fab56d8 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1478,7 +1478,7 @@ static void __remove_hugetlb_folio(struct hstate *h, struct folio *folio,
 	 * apply.
 	 *
 	 * This handles the case where more than one ref is held when and
-	 * after update_and_free_page is called.
+	 * after update_and_free_hugetlb_folio is called.
 	 *
 	 * In the case of demote we do not ref count the page as it will soon
 	 * be turned into a page of smaller size.
@@ -1609,7 +1609,7 @@ static void __update_and_free_page(struct hstate *h, struct page *page)
 }
 
 /*
- * As update_and_free_page() can be called under any context, so we cannot
+ * As update_and_free_hugetlb_folio() can be called under any context, so we cannot
  * use GFP_KERNEL to allocate vmemmap pages. However, we can defer the
  * actual freeing in a workqueue to prevent from using GFP_ATOMIC to allocate
  * the vmemmap pages.
@@ -1657,11 +1657,11 @@ static inline void flush_free_hpage_work(struct hstate *h)
 		flush_work(&free_hpage_work);
 }
 
-static void update_and_free_page(struct hstate *h, struct page *page,
+static void update_and_free_hugetlb_folio(struct hstate *h, struct folio *folio,
 				 bool atomic)
 {
-	if (!HPageVmemmapOptimized(page) || !atomic) {
-		__update_and_free_page(h, page);
+	if (!folio_test_hugetlb_vmemmap_optimized(folio) || !atomic) {
+		__update_and_free_page(h, &folio->page);
 		return;
 	}
 
@@ -1672,16 +1672,18 @@ static void update_and_free_page(struct hstate *h, struct page *page,
 	 * empty. Otherwise, schedule_work() had been called but the workfn
 	 * hasn't retrieved the list yet.
 	 */
-	if (llist_add((struct llist_node *)&page->mapping, &hpage_freelist))
+	if (llist_add((struct llist_node *)&folio->mapping, &hpage_freelist))
 		schedule_work(&free_hpage_work);
 }
 
 static void update_and_free_pages_bulk(struct hstate *h, struct list_head *list)
 {
 	struct page *page, *t_page;
+	struct folio *folio;
 
 	list_for_each_entry_safe(page, t_page, list, lru) {
-		update_and_free_page(h, page, false);
+		folio = page_folio(page);
+		update_and_free_hugetlb_folio(h, folio, false);
 		cond_resched();
 	}
 }
@@ -1751,12 +1753,12 @@ void free_huge_page(struct page *page)
 	if (folio_test_hugetlb_temporary(folio)) {
 		remove_hugetlb_folio(h, folio, false);
 		spin_unlock_irqrestore(&hugetlb_lock, flags);
-		update_and_free_page(h, page, true);
+		update_and_free_hugetlb_folio(h, folio, true);
 	} else if (h->surplus_huge_pages_node[nid]) {
 		/* remove the page from active list */
 		remove_hugetlb_folio(h, folio, true);
 		spin_unlock_irqrestore(&hugetlb_lock, flags);
-		update_and_free_page(h, page, true);
+		update_and_free_hugetlb_folio(h, folio, true);
 	} else {
 		arch_clear_hugepage_flags(page);
 		enqueue_huge_page(h, page);
@@ -2170,8 +2172,8 @@ int dissolve_free_huge_page(struct page *page)
 		spin_unlock_irq(&hugetlb_lock);
 
 		/*
-		 * Normally update_and_free_page will allocate required vmemmmap
-		 * before freeing the page.  update_and_free_page will fail to
+		 * Normally update_and_free_hugtlb_folio will allocate required vmemmmap
+		 * before freeing the page.  update_and_free_hugtlb_folio will fail to
 		 * free the page if it can not allocate required vmemmap.  We
 		 * need to adjust max_huge_pages if the page is not freed.
 		 * Attempt to allocate vmemmmap here so that we can take
@@ -2179,7 +2181,7 @@ int dissolve_free_huge_page(struct page *page)
 		 */
 		rc = hugetlb_vmemmap_restore(h, &folio->page);
 		if (!rc) {
-			update_and_free_page(h, &folio->page, false);
+			update_and_free_hugetlb_folio(h, folio, false);
 		} else {
 			spin_lock_irq(&hugetlb_lock);
 			add_hugetlb_page(h, &folio->page, false);
@@ -2816,7 +2818,7 @@ static int alloc_and_dissolve_huge_page(struct hstate *h, struct page *old_page,
 		 * Pages have been replaced, we can safely free the old one.
 		 */
 		spin_unlock_irq(&hugetlb_lock);
-		update_and_free_page(h, old_page, false);
+		update_and_free_hugetlb_folio(h, old_folio, false);
 	}
 
 	return ret;
@@ -2825,7 +2827,7 @@ static int alloc_and_dissolve_huge_page(struct hstate *h, struct page *old_page,
 	spin_unlock_irq(&hugetlb_lock);
 	/* Page has a zero ref count, but needs a ref to be freed */
 	folio_ref_unfreeze(new_folio, 1);
-	update_and_free_page(h, new_page, false);
+	update_and_free_hugetlb_folio(h, new_folio, false);
 
 	return ret;
 }
-- 
2.38.1

