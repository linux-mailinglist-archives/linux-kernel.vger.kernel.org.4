Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6C3662FFED
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 23:21:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230299AbiKRWU5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 17:20:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230378AbiKRWUc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 17:20:32 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 523599A27F
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 14:20:31 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AILOF8b007813;
        Fri, 18 Nov 2022 22:20:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2022-7-12;
 bh=b3PQObH1nF66pRxTQNIQTkBEH8mytBqt2q8Yl3YFS+0=;
 b=IKGpyc2cxAXtn1dd9EtGfXWLA9prJMPNKnxurgwYmN2APRjN1iRBEvVKczLDRMH8P5jZ
 5gyBNIiCCZd0lIaupdDgyv+M9oVZV/dq6zllW+8783ZJW1eoG8xhGT0zFpCa2uUtnCxQ
 bKRTwcBa/zjbEYsBf7H531uaPSnOgHAGf+q5D6HCbzh0diXEFQA2TtemHNEcvTdW1+Xm
 xMXsWVPPTWdjIydu5rtdSEDh/ux+XMiOdUJHjR1zbrwRYKYjojRfa4x4goeVNeTNa37p
 3uzYTzRz8ry0+QP37VbGf3izxiIu3TvygUdQAXPBZnThdBSPNPwhi2WcUiqvIiEhwqS1 LA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kx9699wat-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Nov 2022 22:20:16 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2AIKZ8Li001657;
        Fri, 18 Nov 2022 22:20:14 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ku3kc1f12-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Nov 2022 22:20:14 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2AIMK7qV040370;
        Fri, 18 Nov 2022 22:20:13 GMT
Received: from sid-dell.us.oracle.com (dhcp-10-159-141-24.vpn.oracle.com [10.159.141.24])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3ku3kc1esc-5;
        Fri, 18 Nov 2022 22:20:13 +0000
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, songmuchun@bytedance.com,
        mike.kravetz@oracle.com, willy@infradead.org,
        almasrymina@google.com, linmiaohe@huawei.com, hughd@google.com,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH mm-unstable v4 04/10] mm/hugetlb: convert remove_hugetlb_page() to folios
Date:   Fri, 18 Nov 2022 14:19:56 -0800
Message-Id: <20221118222002.82588-5-sidhartha.kumar@oracle.com>
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
X-Proofpoint-GUID: CSbvYnpvcy-AvvMsIkQJBRL21N68WzEJ
X-Proofpoint-ORIG-GUID: CSbvYnpvcy-AvvMsIkQJBRL21N68WzEJ
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Removes page_folio() call by converting callers to directly pass a folio
into __remove_hugetlb_page().

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
 mm/hugetlb.c | 48 +++++++++++++++++++++++++-----------------------
 1 file changed, 25 insertions(+), 23 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index d0acabbf3025..90ba01a76f87 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1432,19 +1432,18 @@ static inline void destroy_compound_gigantic_folio(struct folio *folio,
 #endif
 
 /*
- * Remove hugetlb page from lists, and update dtor so that page appears
+ * Remove hugetlb folio from lists, and update dtor so that the folio appears
  * as just a compound page.
  *
- * A reference is held on the page, except in the case of demote.
+ * A reference is held on the folio, except in the case of demote.
  *
  * Must be called with hugetlb lock held.
  */
-static void __remove_hugetlb_page(struct hstate *h, struct page *page,
+static void __remove_hugetlb_folio(struct hstate *h, struct folio *folio,
 							bool adjust_surplus,
 							bool demote)
 {
-	int nid = page_to_nid(page);
-	struct folio *folio = page_folio(page);
+	int nid = folio_nid(folio);
 
 	VM_BUG_ON_FOLIO(hugetlb_cgroup_from_folio(folio), folio);
 	VM_BUG_ON_FOLIO(hugetlb_cgroup_from_folio_rsvd(folio), folio);
@@ -1453,9 +1452,9 @@ static void __remove_hugetlb_page(struct hstate *h, struct page *page,
 	if (hstate_is_gigantic(h) && !gigantic_page_runtime_supported())
 		return;
 
-	list_del(&page->lru);
+	list_del(&folio->lru);
 
-	if (HPageFreed(page)) {
+	if (folio_test_hugetlb_freed(folio)) {
 		h->free_huge_pages--;
 		h->free_huge_pages_node[nid]--;
 	}
@@ -1485,26 +1484,26 @@ static void __remove_hugetlb_page(struct hstate *h, struct page *page,
 	 * be turned into a page of smaller size.
 	 */
 	if (!demote)
-		set_page_refcounted(page);
+		folio_ref_unfreeze(folio, 1);
 	if (hstate_is_gigantic(h))
-		set_compound_page_dtor(page, NULL_COMPOUND_DTOR);
+		folio_set_compound_dtor(folio, NULL_COMPOUND_DTOR);
 	else
-		set_compound_page_dtor(page, COMPOUND_PAGE_DTOR);
+		folio_set_compound_dtor(folio, COMPOUND_PAGE_DTOR);
 
 	h->nr_huge_pages--;
 	h->nr_huge_pages_node[nid]--;
 }
 
-static void remove_hugetlb_page(struct hstate *h, struct page *page,
+static void remove_hugetlb_folio(struct hstate *h, struct folio *folio,
 							bool adjust_surplus)
 {
-	__remove_hugetlb_page(h, page, adjust_surplus, false);
+	__remove_hugetlb_folio(h, folio, adjust_surplus, false);
 }
 
-static void remove_hugetlb_page_for_demote(struct hstate *h, struct page *page,
+static void remove_hugetlb_folio_for_demote(struct hstate *h, struct folio *folio,
 							bool adjust_surplus)
 {
-	__remove_hugetlb_page(h, page, adjust_surplus, true);
+	__remove_hugetlb_folio(h, folio, adjust_surplus, true);
 }
 
 static void add_hugetlb_page(struct hstate *h, struct page *page,
@@ -1639,8 +1638,9 @@ static void free_hpage_workfn(struct work_struct *work)
 		/*
 		 * The VM_BUG_ON_PAGE(!PageHuge(page), page) in page_hstate()
 		 * is going to trigger because a previous call to
-		 * remove_hugetlb_page() will set_compound_page_dtor(page,
-		 * NULL_COMPOUND_DTOR), so do not use page_hstate() directly.
+		 * remove_hugetlb_folio() will call folio_set_compound_dtor
+		 * (folio, NULL_COMPOUND_DTOR), so do not use page_hstate()
+		 * directly.
 		 */
 		h = size_to_hstate(page_size(page));
 
@@ -1749,12 +1749,12 @@ void free_huge_page(struct page *page)
 		h->resv_huge_pages++;
 
 	if (folio_test_hugetlb_temporary(folio)) {
-		remove_hugetlb_page(h, page, false);
+		remove_hugetlb_folio(h, folio, false);
 		spin_unlock_irqrestore(&hugetlb_lock, flags);
 		update_and_free_page(h, page, true);
 	} else if (h->surplus_huge_pages_node[nid]) {
 		/* remove the page from active list */
-		remove_hugetlb_page(h, page, true);
+		remove_hugetlb_folio(h, folio, true);
 		spin_unlock_irqrestore(&hugetlb_lock, flags);
 		update_and_free_page(h, page, true);
 	} else {
@@ -2092,6 +2092,7 @@ static struct page *remove_pool_huge_page(struct hstate *h,
 {
 	int nr_nodes, node;
 	struct page *page = NULL;
+	struct folio *folio;
 
 	lockdep_assert_held(&hugetlb_lock);
 	for_each_node_mask_to_free(h, nr_nodes, node, nodes_allowed) {
@@ -2103,7 +2104,8 @@ static struct page *remove_pool_huge_page(struct hstate *h,
 		    !list_empty(&h->hugepage_freelists[node])) {
 			page = list_entry(h->hugepage_freelists[node].next,
 					  struct page, lru);
-			remove_hugetlb_page(h, page, acct_surplus);
+			folio = page_folio(page);
+			remove_hugetlb_folio(h, folio, acct_surplus);
 			break;
 		}
 	}
@@ -2165,7 +2167,7 @@ int dissolve_free_huge_page(struct page *page)
 			goto retry;
 		}
 
-		remove_hugetlb_page(h, &folio->page, false);
+		remove_hugetlb_folio(h, folio, false);
 		h->max_huge_pages--;
 		spin_unlock_irq(&hugetlb_lock);
 
@@ -2803,7 +2805,7 @@ static int alloc_and_dissolve_huge_page(struct hstate *h, struct page *old_page,
 		 * and enqueue_huge_page() for new_page. The counters will remain
 		 * stable since this happens under the lock.
 		 */
-		remove_hugetlb_page(h, old_page, false);
+		remove_hugetlb_folio(h, old_folio, false);
 
 		/*
 		 * Ref count on new page is already zero as it was dropped
@@ -3230,7 +3232,7 @@ static void try_to_free_low(struct hstate *h, unsigned long count,
 				goto out;
 			if (PageHighMem(page))
 				continue;
-			remove_hugetlb_page(h, page, false);
+			remove_hugetlb_folio(h, page_folio(page), false);
 			list_add(&page->lru, &page_list);
 		}
 	}
@@ -3441,7 +3443,7 @@ static int demote_free_huge_page(struct hstate *h, struct page *page)
 
 	target_hstate = size_to_hstate(PAGE_SIZE << h->demote_order);
 
-	remove_hugetlb_page_for_demote(h, page, false);
+	remove_hugetlb_folio_for_demote(h, folio, false);
 	spin_unlock_irq(&hugetlb_lock);
 
 	rc = hugetlb_vmemmap_restore(h, page);
-- 
2.38.1

