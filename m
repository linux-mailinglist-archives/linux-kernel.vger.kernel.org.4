Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D13BE62A401
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 22:23:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238772AbiKOVXY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 16:23:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231953AbiKOVWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 16:22:50 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D37626AC9
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 13:22:49 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AFKRoLs008998;
        Tue, 15 Nov 2022 21:22:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2022-7-12;
 bh=0C32TPwYA1sxUQ1BprDeGSkpbbMnBeTp3PiSrVMBGtI=;
 b=SFRBsTfvH1LOKYOxqXdl718oidp1tjJfMSH1LtpfTfvfxmtbDgNiq9vLSe4bcCZD+m56
 IXYnRszYpuvuNtBVqcw3ZXpkukPITqJimDsmKDEBxlw6JhMDSlUhsbUQR+Jx+bS4XLcG
 yTZ+2DsRzNFQeXhF++fqIK9rKtY+uy2HnCyG3wHi3SxuEvCglhyZGYTr3PLtj/42MyP1
 FQ2UnfPmvSQNt1sPg/oOCTxXJDbHAYLSsSfegi65THFR7Tfn7SwKItIvtnNDICRWdWPb
 owdeqypV99huuL2iOf8fDtXMGbBztvlQK8jeZQhaefr0Hxvegk+RXRCE9PYol+Dx3VbG Sw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kv3jsjxa1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Nov 2022 21:22:40 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2AFK0D1P031734;
        Tue, 15 Nov 2022 21:22:38 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kt1xcfvnc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Nov 2022 21:22:38 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2AFLMSRo002082;
        Tue, 15 Nov 2022 21:22:38 GMT
Received: from dhcp-10-132-95-73.usdhcp.oraclecorp.com.com (dhcp-10-132-95-73.usdhcp.oraclecorp.com [10.132.95.73])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3kt1xcfvb0-8;
        Tue, 15 Nov 2022 21:22:38 +0000
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, songmuchun@bytedance.com,
        mike.kravetz@oracle.com, willy@infradead.org,
        almasrymina@google.com, linmiaohe@huawei.com, hughd@google.com,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH mm-unstable 07/10] mm/hugetlb: convert enqueue_huge_page() to folios
Date:   Tue, 15 Nov 2022 13:22:14 -0800
Message-Id: <20221115212217.19539-8-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221115212217.19539-1-sidhartha.kumar@oracle.com>
References: <20221115212217.19539-1-sidhartha.kumar@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-15_08,2022-11-15_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 suspectscore=0 malwarescore=0 mlxscore=0 adultscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211150146
X-Proofpoint-ORIG-GUID: ok8lAA7QoayIlTeg983FneMaP8FuRyUG
X-Proofpoint-GUID: ok8lAA7QoayIlTeg983FneMaP8FuRyUG
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
index 7382c162dbcd..ebb98c1af2fb 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1119,17 +1119,17 @@ static bool vma_has_reserves(struct vm_area_struct *vma, long chg)
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
@@ -1540,7 +1540,7 @@ static void add_hugetlb_folio(struct hstate *h, struct folio *folio,
 		return;
 
 	arch_clear_hugepage_flags(&folio->page);
-	enqueue_huge_page(h, &folio->page);
+	enqueue_hugetlb_folio(h, folio);
 }
 
 static void __update_and_free_page(struct hstate *h, struct page *page)
@@ -1752,7 +1752,7 @@ void free_huge_page(struct page *page)
 		update_and_free_hugetlb_folio(h, folio, true);
 	} else {
 		arch_clear_hugepage_flags(page);
-		enqueue_huge_page(h, page);
+		enqueue_hugetlb_folio(h, folio);
 		spin_unlock_irqrestore(&hugetlb_lock, flags);
 	}
 }
@@ -2427,7 +2427,7 @@ static int gather_surplus_pages(struct hstate *h, long delta)
 		if ((--needed) < 0)
 			break;
 		/* Add the page to the hugetlb allocator */
-		enqueue_huge_page(h, page);
+		enqueue_hugetlb_folio(h, page_folio(page));
 	}
 free:
 	spin_unlock_irq(&hugetlb_lock);
@@ -2793,8 +2793,8 @@ static int alloc_and_dissolve_huge_page(struct hstate *h, struct page *old_page,
 		 * Ok, old_page is still a genuine free hugepage. Remove it from
 		 * the freelist and decrease the counters. These will be
 		 * incremented again when calling __prep_account_new_huge_page()
-		 * and enqueue_huge_page() for new_page. The counters will remain
-		 * stable since this happens under the lock.
+		 * and enqueue_hugetlb_folio() for new_folio. The counters will
+		 * remain stable since this happens under the lock.
 		 */
 		remove_hugetlb_folio(h, old_folio, false);
 
@@ -2803,7 +2803,7 @@ static int alloc_and_dissolve_huge_page(struct hstate *h, struct page *old_page,
 		 * earlier.  It can be directly added to the pool free list.
 		 */
 		__prep_account_new_huge_page(h, nid);
-		enqueue_huge_page(h, new_page);
+		enqueue_hugetlb_folio(h, new_folio);
 
 		/*
 		 * Pages have been replaced, we can safely free the old one.
-- 
2.38.1

