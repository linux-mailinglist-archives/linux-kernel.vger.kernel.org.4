Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64AB662E6B2
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 22:16:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240802AbiKQVQZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 16:16:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240787AbiKQVPm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 16:15:42 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF54D65845
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 13:15:16 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AHLEGi5000828;
        Thu, 17 Nov 2022 21:15:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2022-7-12;
 bh=DrYH6pRWKnBgFEybzVkbkIij9mLZr9efXDcEx32Vsb4=;
 b=Leq38lRgCQU5qt7/Ysz+q9zI6Qm3VvJkpXz/Mb5i+JrtVd4ny7qEIcgrC9gOg7ssEp0I
 wr0/0sh0IJp7rYduA8cxFMZCqK/vtfmBuPveWzNVLyhUuRam7gmFjxcAiyEIMNSL4GX5
 ySQrUx/9ldTdx4Zi0wj78sMhe50cJwImpv8kc9w0VpM03BwLhTtHaYPTJI+wODNtMEIN
 uUWmFXEG126tA+OSAC3wmocUq4/+YTLvuwwjciSpY4v3MdSNNABtAfEUCXiCmMBisTQA
 /MdsK6BBCAHeNW8OZJhN0Jf/NNybgjFMBd4WbAtecTIBxDWzWg7mgq3TWsKKIlCjOyxl ew== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kv8ykthg4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Nov 2022 21:15:05 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2AHKjtZu010826;
        Thu, 17 Nov 2022 21:15:04 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kt1x9nqr3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Nov 2022 21:15:04 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2AHLEx7e024557;
        Thu, 17 Nov 2022 21:15:04 GMT
Received: from sid-dell.us.oracle.com (dhcp-10-132-95-73.usdhcp.oraclecorp.com [10.132.95.73])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3kt1x9nqku-8;
        Thu, 17 Nov 2022 21:15:04 +0000
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, songmuchun@bytedance.com,
        mike.kravetz@oracle.com, willy@infradead.org,
        almasrymina@google.com, linmiaohe@huawei.com, hughd@google.com,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH mm-unstable v3 07/10] mm/hugetlb: convert enqueue_huge_page() to folios
Date:   Thu, 17 Nov 2022 13:14:58 -0800
Message-Id: <20221117211501.17150-8-sidhartha.kumar@oracle.com>
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
X-Proofpoint-GUID: E5SbJIJezI92l3ebRPRmBKsVEGxPXbVl
X-Proofpoint-ORIG-GUID: E5SbJIJezI92l3ebRPRmBKsVEGxPXbVl
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert callers of enqueue_huge_page() to pass in a folio, function is
renamed to enqueue_hugetlb_folio().

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
 mm/hugetlb.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index bf36aa8e6072..4eb6f3d6f46e 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1127,17 +1127,17 @@ static bool vma_has_reserves(struct vm_area_struct *vma, long chg)
 	return false;
 }
 
-static void enqueue_huge_page(struct hstate *h, struct page *page)
+static void enqueue_hugetlb_folio(struct hstate *h, struct folio *folio)
 {
-	int nid = page_to_nid(page);
+	int nid = folio_nid(folio);
 
 	lockdep_assert_held(&hugetlb_lock);
-	VM_BUG_ON_PAGE(page_count(page), page);
+	VM_BUG_ON_FOLIO(folio_ref_count(folio), folio);
 
-	list_move(&page->lru, &h->hugepage_freelists[nid]);
+	list_move(&folio->lru, &h->hugepage_freelists[nid]);
 	h->free_huge_pages++;
 	h->free_huge_pages_node[nid]++;
-	SetHPageFreed(page);
+	folio_set_hugetlb_freed(folio);
 }
 
 static struct page *dequeue_huge_page_node_exact(struct hstate *h, int nid)
@@ -1549,7 +1549,7 @@ static void add_hugetlb_folio(struct hstate *h, struct folio *folio,
 		return;
 
 	arch_clear_hugepage_flags(&folio->page);
-	enqueue_huge_page(h, &folio->page);
+	enqueue_hugetlb_folio(h, folio);
 }
 
 static void __update_and_free_page(struct hstate *h, struct page *page)
@@ -1761,7 +1761,7 @@ void free_huge_page(struct page *page)
 		update_and_free_hugetlb_folio(h, folio, true);
 	} else {
 		arch_clear_hugepage_flags(page);
-		enqueue_huge_page(h, page);
+		enqueue_hugetlb_folio(h, folio);
 		spin_unlock_irqrestore(&hugetlb_lock, flags);
 	}
 }
@@ -2436,7 +2436,7 @@ static int gather_surplus_pages(struct hstate *h, long delta)
 		if ((--needed) < 0)
 			break;
 		/* Add the page to the hugetlb allocator */
-		enqueue_huge_page(h, page);
+		enqueue_hugetlb_folio(h, page_folio(page));
 	}
 free:
 	spin_unlock_irq(&hugetlb_lock);
@@ -2802,8 +2802,8 @@ static int alloc_and_dissolve_huge_page(struct hstate *h, struct page *old_page,
 		 * Ok, old_page is still a genuine free hugepage. Remove it from
 		 * the freelist and decrease the counters. These will be
 		 * incremented again when calling __prep_account_new_huge_page()
-		 * and enqueue_huge_page() for new_page. The counters will remain
-		 * stable since this happens under the lock.
+		 * and enqueue_hugetlb_folio() for new_folio. The counters will
+		 * remain stable since this happens under the lock.
 		 */
 		remove_hugetlb_folio(h, old_folio, false);
 
@@ -2812,7 +2812,7 @@ static int alloc_and_dissolve_huge_page(struct hstate *h, struct page *old_page,
 		 * earlier.  It can be directly added to the pool free list.
 		 */
 		__prep_account_new_huge_page(h, nid);
-		enqueue_huge_page(h, new_page);
+		enqueue_hugetlb_folio(h, new_folio);
 
 		/*
 		 * Pages have been replaced, we can safely free the old one.
-- 
2.38.1

