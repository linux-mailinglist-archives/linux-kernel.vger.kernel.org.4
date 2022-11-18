Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1116562FFF2
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 23:21:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231764AbiKRWVR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 17:21:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231490AbiKRWUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 17:20:37 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D62209A5CD
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 14:20:33 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AILNjW6010944;
        Fri, 18 Nov 2022 22:20:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2022-7-12;
 bh=xjFNR0+YHVKKmji0eOTm6FSXkffaZEYjgSGJZ2r6Kok=;
 b=2+HJ31eibUrmdIvm+h9gGAi3ugpM9nSxj7h/yP4kFA3JFzIcVG5W6r5Gb0/GJiIv4HcP
 4qMgRVKx99fzm9ybnlNbsmnBf81F/lpm3WkNBrmy6A5bk6UPnbmcCX9mDXstGji5i6z2
 Owsirr6QVIBJqjNWY0cOwvsSIdZZtDxfQKiH8iD0JfqitgGU6z54+PQ+ae6B+APGe9AW
 fS9Ce6C6uJ117xXnLVe5rncfaqfdLG+tr6i1kjL+U4Ms6tVqpQJsJJzm/B85HWYTVeGK
 vrcE6awXZETIRlO4MI+B3hM5cKdSzgQElf1Uifoo6qEGU7WTmdrFyL/s7fVJcG6GXVlK jQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kxbub995k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Nov 2022 22:20:24 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2AIKgCrS001825;
        Fri, 18 Nov 2022 22:20:24 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ku3kc1f96-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Nov 2022 22:20:24 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2AIMK7qh040370;
        Fri, 18 Nov 2022 22:20:23 GMT
Received: from sid-dell.us.oracle.com (dhcp-10-159-141-24.vpn.oracle.com [10.159.141.24])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3ku3kc1esc-11;
        Fri, 18 Nov 2022 22:20:23 +0000
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, songmuchun@bytedance.com,
        mike.kravetz@oracle.com, willy@infradead.org,
        almasrymina@google.com, linmiaohe@huawei.com, hughd@google.com,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH mm-unstable v4 10/10] mm/hugetlb: change hugetlb allocation functions to return a folio
Date:   Fri, 18 Nov 2022 14:20:02 -0800
Message-Id: <20221118222002.82588-11-sidhartha.kumar@oracle.com>
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
X-Proofpoint-ORIG-GUID: Xu_BTJ8irP3of8i3krNOxSTLg64AGDo2
X-Proofpoint-GUID: Xu_BTJ8irP3of8i3krNOxSTLg64AGDo2
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Many hugetlb allocation helper functions have now been converting to
folios, update their higher level callers to be compatible with folios.

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
 mm/hugetlb.c | 98 ++++++++++++++++++++++++----------------------------
 1 file changed, 46 insertions(+), 52 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index b690ea7aaa00..2de3e5ccbc3f 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1378,7 +1378,7 @@ static void free_gigantic_folio(struct folio *folio, unsigned int order)
 }
 
 #ifdef CONFIG_CONTIG_ALLOC
-static struct page *alloc_gigantic_page(struct hstate *h, gfp_t gfp_mask,
+static struct folio *alloc_gigantic_folio(struct hstate *h, gfp_t gfp_mask,
 		int nid, nodemask_t *nodemask)
 {
 	unsigned long nr_pages = pages_per_huge_page(h);
@@ -1394,7 +1394,7 @@ static struct page *alloc_gigantic_page(struct hstate *h, gfp_t gfp_mask,
 			page = cma_alloc(hugetlb_cma[nid], nr_pages,
 					huge_page_order(h), true);
 			if (page)
-				return page;
+				return page_folio(page);
 		}
 
 		if (!(gfp_mask & __GFP_THISNODE)) {
@@ -1405,17 +1405,16 @@ static struct page *alloc_gigantic_page(struct hstate *h, gfp_t gfp_mask,
 				page = cma_alloc(hugetlb_cma[node], nr_pages,
 						huge_page_order(h), true);
 				if (page)
-					return page;
+					return page_folio(page);
 			}
 		}
 	}
 #endif
-
-	return alloc_contig_pages(nr_pages, gfp_mask, nid, nodemask);
+	return page_folio(alloc_contig_pages(nr_pages, gfp_mask, nid, nodemask));
 }
 
 #else /* !CONFIG_CONTIG_ALLOC */
-static struct page *alloc_gigantic_page(struct hstate *h, gfp_t gfp_mask,
+static struct folio *alloc_gigantic_folio(struct hstate *h, gfp_t gfp_mask,
 					int nid, nodemask_t *nodemask)
 {
 	return NULL;
@@ -1423,7 +1422,7 @@ static struct page *alloc_gigantic_page(struct hstate *h, gfp_t gfp_mask,
 #endif /* CONFIG_CONTIG_ALLOC */
 
 #else /* !CONFIG_ARCH_HAS_GIGANTIC_PAGE */
-static struct page *alloc_gigantic_page(struct hstate *h, gfp_t gfp_mask,
+static struct folio *alloc_gigantic_folio(struct hstate *h, gfp_t gfp_mask,
 					int nid, nodemask_t *nodemask)
 {
 	return NULL;
@@ -1950,7 +1949,7 @@ pgoff_t hugetlb_basepage_index(struct page *page)
 	return (index << compound_order(page_head)) + compound_idx;
 }
 
-static struct page *alloc_buddy_huge_page(struct hstate *h,
+static struct folio *alloc_buddy_hugetlb_folio(struct hstate *h,
 		gfp_t gfp_mask, int nid, nodemask_t *nmask,
 		nodemask_t *node_alloc_noretry)
 {
@@ -2009,7 +2008,7 @@ static struct page *alloc_buddy_huge_page(struct hstate *h,
 	if (node_alloc_noretry && !page && alloc_try_hard)
 		node_set(nid, *node_alloc_noretry);
 
-	return page;
+	return page_folio(page);
 }
 
 /*
@@ -2019,23 +2018,21 @@ static struct page *alloc_buddy_huge_page(struct hstate *h,
  * Note that returned page is 'frozen':  ref count of head page and all tail
  * pages is zero.
  */
-static struct page *alloc_fresh_huge_page(struct hstate *h,
+static struct folio *alloc_fresh_hugetlb_folio(struct hstate *h,
 		gfp_t gfp_mask, int nid, nodemask_t *nmask,
 		nodemask_t *node_alloc_noretry)
 {
-	struct page *page;
 	struct folio *folio;
 	bool retry = false;
 
 retry:
 	if (hstate_is_gigantic(h))
-		page = alloc_gigantic_page(h, gfp_mask, nid, nmask);
+		folio = alloc_gigantic_folio(h, gfp_mask, nid, nmask);
 	else
-		page = alloc_buddy_huge_page(h, gfp_mask,
+		folio = alloc_buddy_hugetlb_folio(h, gfp_mask,
 				nid, nmask, node_alloc_noretry);
-	if (!page)
+	if (!folio)
 		return NULL;
-	folio = page_folio(page);
 	if (hstate_is_gigantic(h)) {
 		if (!prep_compound_gigantic_folio(folio, huge_page_order(h))) {
 			/*
@@ -2052,7 +2049,7 @@ static struct page *alloc_fresh_huge_page(struct hstate *h,
 	}
 	prep_new_hugetlb_folio(h, folio, folio_nid(folio));
 
-	return page;
+	return folio;
 }
 
 /*
@@ -2062,21 +2059,21 @@ static struct page *alloc_fresh_huge_page(struct hstate *h,
 static int alloc_pool_huge_page(struct hstate *h, nodemask_t *nodes_allowed,
 				nodemask_t *node_alloc_noretry)
 {
-	struct page *page;
+	struct folio *folio;
 	int nr_nodes, node;
 	gfp_t gfp_mask = htlb_alloc_mask(h) | __GFP_THISNODE;
 
 	for_each_node_mask_to_alloc(h, nr_nodes, node, nodes_allowed) {
-		page = alloc_fresh_huge_page(h, gfp_mask, node, nodes_allowed,
-						node_alloc_noretry);
-		if (page)
+		folio = alloc_fresh_hugetlb_folio(h, gfp_mask, node,
+					nodes_allowed, node_alloc_noretry);
+		if (folio)
 			break;
 	}
 
-	if (!page)
+	if (!folio)
 		return 0;
 
-	free_huge_page(page); /* free it into the hugepage allocator */
+	free_huge_page(&folio->page); /* free it into the hugepage allocator */
 
 	return 1;
 }
@@ -2237,7 +2234,7 @@ int dissolve_free_huge_pages(unsigned long start_pfn, unsigned long end_pfn)
 static struct page *alloc_surplus_huge_page(struct hstate *h, gfp_t gfp_mask,
 						int nid, nodemask_t *nmask)
 {
-	struct page *page = NULL;
+	struct folio *folio = NULL;
 
 	if (hstate_is_gigantic(h))
 		return NULL;
@@ -2247,8 +2244,8 @@ static struct page *alloc_surplus_huge_page(struct hstate *h, gfp_t gfp_mask,
 		goto out_unlock;
 	spin_unlock_irq(&hugetlb_lock);
 
-	page = alloc_fresh_huge_page(h, gfp_mask, nid, nmask, NULL);
-	if (!page)
+	folio = alloc_fresh_hugetlb_folio(h, gfp_mask, nid, nmask, NULL);
+	if (!folio)
 		return NULL;
 
 	spin_lock_irq(&hugetlb_lock);
@@ -2260,43 +2257,42 @@ static struct page *alloc_surplus_huge_page(struct hstate *h, gfp_t gfp_mask,
 	 * codeflow
 	 */
 	if (h->surplus_huge_pages >= h->nr_overcommit_huge_pages) {
-		SetHPageTemporary(page);
+		folio_set_hugetlb_temporary(folio);
 		spin_unlock_irq(&hugetlb_lock);
-		free_huge_page(page);
+		free_huge_page(&folio->page);
 		return NULL;
 	}
 
 	h->surplus_huge_pages++;
-	h->surplus_huge_pages_node[page_to_nid(page)]++;
+	h->surplus_huge_pages_node[folio_nid(folio)]++;
 
 out_unlock:
 	spin_unlock_irq(&hugetlb_lock);
 
-	return page;
+	return &folio->page;
 }
 
 static struct page *alloc_migrate_huge_page(struct hstate *h, gfp_t gfp_mask,
 				     int nid, nodemask_t *nmask)
 {
-	struct page *page;
+	struct folio *folio;
 
 	if (hstate_is_gigantic(h))
 		return NULL;
 
-	page = alloc_fresh_huge_page(h, gfp_mask, nid, nmask, NULL);
-	if (!page)
+	folio = alloc_fresh_hugetlb_folio(h, gfp_mask, nid, nmask, NULL);
+	if (!folio)
 		return NULL;
 
 	/* fresh huge pages are frozen */
-	set_page_refcounted(page);
-
+	folio_ref_unfreeze(folio, 1);
 	/*
 	 * We do not account these pages as surplus because they are only
 	 * temporary and will be released properly on the last reference
 	 */
-	SetHPageTemporary(page);
+	folio_set_hugetlb_temporary(folio);
 
-	return page;
+	return &folio->page;
 }
 
 /*
@@ -2745,19 +2741,18 @@ void restore_reserve_on_error(struct hstate *h, struct vm_area_struct *vma,
 }
 
 /*
- * alloc_and_dissolve_huge_page - Allocate a new page and dissolve the old one
+ * alloc_and_dissolve_hugetlb_folio - Allocate a new folio and dissolve
+ * the old one
  * @h: struct hstate old page belongs to
  * @old_page: Old page to dissolve
  * @list: List to isolate the page in case we need to
  * Returns 0 on success, otherwise negated error.
  */
-static int alloc_and_dissolve_huge_page(struct hstate *h, struct page *old_page,
-					struct list_head *list)
+static int alloc_and_dissolve_hugetlb_folio(struct hstate *h,
+			struct folio *old_folio, struct list_head *list)
 {
 	gfp_t gfp_mask = htlb_alloc_mask(h) | __GFP_THISNODE;
-	struct folio *old_folio = page_folio(old_page);
 	int nid = folio_nid(old_folio);
-	struct page *new_page;
 	struct folio *new_folio;
 	int ret = 0;
 
@@ -2768,26 +2763,25 @@ static int alloc_and_dissolve_huge_page(struct hstate *h, struct page *old_page,
 	 * the pool.  This simplifies and let us do most of the processing
 	 * under the lock.
 	 */
-	new_page = alloc_buddy_huge_page(h, gfp_mask, nid, NULL, NULL);
-	if (!new_page)
+	new_folio = alloc_buddy_hugetlb_folio(h, gfp_mask, nid, NULL, NULL);
+	if (!new_folio)
 		return -ENOMEM;
-	new_folio = page_folio(new_page);
 	__prep_new_hugetlb_folio(h, new_folio);
 
 retry:
 	spin_lock_irq(&hugetlb_lock);
 	if (!folio_test_hugetlb(old_folio)) {
 		/*
-		 * Freed from under us. Drop new_page too.
+		 * Freed from under us. Drop new_folio too.
 		 */
 		goto free_new;
 	} else if (folio_ref_count(old_folio)) {
 		/*
-		 * Someone has grabbed the page, try to isolate it here.
+		 * Someone has grabbed the folio, try to isolate it here.
 		 * Fail with -EBUSY if not possible.
 		 */
 		spin_unlock_irq(&hugetlb_lock);
-		ret = isolate_hugetlb(old_page, list);
+		ret = isolate_hugetlb(&old_folio->page, list);
 		spin_lock_irq(&hugetlb_lock);
 		goto free_new;
 	} else if (!folio_test_hugetlb_freed(old_folio)) {
@@ -2865,7 +2859,7 @@ int isolate_or_dissolve_huge_page(struct page *page, struct list_head *list)
 	if (folio_ref_count(folio) && !isolate_hugetlb(&folio->page, list))
 		ret = 0;
 	else if (!folio_ref_count(folio))
-		ret = alloc_and_dissolve_huge_page(h, &folio->page, list);
+		ret = alloc_and_dissolve_hugetlb_folio(h, folio, list);
 
 	return ret;
 }
@@ -3083,14 +3077,14 @@ static void __init hugetlb_hstate_alloc_pages_onenode(struct hstate *h, int nid)
 			if (!alloc_bootmem_huge_page(h, nid))
 				break;
 		} else {
-			struct page *page;
+			struct folio *folio;
 			gfp_t gfp_mask = htlb_alloc_mask(h) | __GFP_THISNODE;
 
-			page = alloc_fresh_huge_page(h, gfp_mask, nid,
+			folio = alloc_fresh_hugetlb_folio(h, gfp_mask, nid,
 					&node_states[N_MEMORY], NULL);
-			if (!page)
+			if (!folio)
 				break;
-			free_huge_page(page); /* free it into the hugepage allocator */
+			free_huge_page(&folio->page); /* free it into the hugepage allocator */
 		}
 		cond_resched();
 	}
-- 
2.38.1

