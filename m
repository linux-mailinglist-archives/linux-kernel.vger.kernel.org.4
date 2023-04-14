Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9366F6E2AC1
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 21:49:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbjDNTtH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 15:49:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjDNTtG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 15:49:06 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12EAF4C39
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 12:49:02 -0700 (PDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33EJMZpS023873;
        Fri, 14 Apr 2023 19:48:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=Tz1sdDgTX7NzO5j6Tr87zpN4tbJYB+amGklPjb0YLQw=;
 b=RXSjyrwSSMaMPJ9ojJUieOVk8aFp1I41gpMA5PCxGNbZT+O9aO+BaXJ1DeYiS44VlN8z
 tz1YNhPjN6MgNKVeXkfX/qXOIs3I5wxyq60veYXUtBBxDKh16x1QQCPQ6aShdjOr3dMT
 SzSQuu10om0vOKfsdqNP5uigKl0RsijUtVQbNNAVJPkMdG7KLF8Kay5nZfniF/h7s1gi
 49LRllNfKj5IeMoTTTj/IaYRtXXonSUOnPCiWQmX6+fVnnMjqhzPxvku9LR89onc+4rL
 Hg8SS0rkpIMir7tc+CWAmeglN7fNRYn9Dz35rYdt7Ilm6iuoACSLO0ZrFLUERwATtcxm 1A== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3pycxdrr00-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Apr 2023 19:48:47 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 33E3v1UH002603;
        Fri, 14 Apr 2023 19:48:45 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
        by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3pu0m1bw0p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Apr 2023 19:48:45 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 33EJmfYc13894366
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Apr 2023 19:48:41 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C0F2A2004B;
        Fri, 14 Apr 2023 19:48:41 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6C42520040;
        Fri, 14 Apr 2023 19:48:36 +0000 (GMT)
Received: from tarunpc.ibmuc.com (unknown [9.43.14.252])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 14 Apr 2023 19:48:36 +0000 (GMT)
From:   Tarun Sahu <tsahu@linux.ibm.com>
To:     linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, muchun.song@linux.dev,
        mike.kravetz@oracle.com, aneesh.kumar@linux.ibm.com,
        willy@infradead.org, sidhartha.kumar@oracle.com,
        gerald.schaefer@linux.ibm.com, linux-kernel@vger.kernel.org,
        jaypatel@linux.ibm.com, tsahu@linux.ibm.com
Subject: [PATCH] mm/folio: Avoid special handling for order value 0 in folio_set_order
Date:   Sat, 15 Apr 2023 01:18:32 +0530
Message-Id: <20230414194832.973194-1-tsahu@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 3i7m5OSu9A-wYDstwtiRq8slVmQrLv6q
X-Proofpoint-GUID: 3i7m5OSu9A-wYDstwtiRq8slVmQrLv6q
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-14_12,2023-04-14_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0
 clxscore=1011 mlxlogscore=999 adultscore=0 bulkscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304140174
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

folio_set_order(folio, 0); which is an abuse of folio_set_order as 0-order
folio does not have any tail page to set order. folio->_folio_nr_pages is
set to 0 for order 0 in folio_set_order. It is required because
_folio_nr_pages overlapped with page->mapping and leaving it non zero
caused "bad page" error while freeing gigantic hugepages. This was fixed in
Commit ba9c1201beaa ("mm/hugetlb: clear compound_nr before freeing gigantic
pages"). Also commit a01f43901cfb ("hugetlb: be sure to free demoted CMA
pages to CMA") now explicitly clear page->mapping and hence we won't see
the bad page error even if _folio_nr_pages remains unset. Also the order 0
folios are not supposed to call folio_set_order, So now we can get rid of
folio_set_order(folio, 0) from hugetlb code path to clear the confusion.

The patch also moves _folio_set_head and folio_set_order calls in
__prep_compound_gigantic_folio() such that we avoid clearing them in the
error path.

Testing: I have run LTP tests, which all passes. and also I have written
the test in LTP which tests the bug caused by compound_nr and page->mapping
overlapping.

https://lore.kernel.org/all/20230413090753.883953-1-tsahu@linux.ibm.com/

Running on older kernel ( < 5.10-rc7) with the above bug this fails while
on newer kernel and, also with this patch it passes.

Signed-off-by: Tarun Sahu <tsahu@linux.ibm.com>
---
 mm/hugetlb.c  | 9 +++------
 mm/internal.h | 8 ++------
 2 files changed, 5 insertions(+), 12 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index f16b25b1a6b9..e2540269c1dc 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1489,7 +1489,6 @@ static void __destroy_compound_gigantic_folio(struct folio *folio,
 			set_page_refcounted(p);
 	}
 
-	folio_set_order(folio, 0);
 	__folio_clear_head(folio);
 }
 
@@ -1951,9 +1950,6 @@ static bool __prep_compound_gigantic_folio(struct folio *folio,
 	struct page *p;
 
 	__folio_clear_reserved(folio);
-	__folio_set_head(folio);
-	/* we rely on prep_new_hugetlb_folio to set the destructor */
-	folio_set_order(folio, order);
 	for (i = 0; i < nr_pages; i++) {
 		p = folio_page(folio, i);
 
@@ -1999,6 +1995,9 @@ static bool __prep_compound_gigantic_folio(struct folio *folio,
 		if (i != 0)
 			set_compound_head(p, &folio->page);
 	}
+	__folio_set_head(folio);
+	/* we rely on prep_new_hugetlb_folio to set the destructor */
+	folio_set_order(folio, order);
 	atomic_set(&folio->_entire_mapcount, -1);
 	atomic_set(&folio->_nr_pages_mapped, 0);
 	atomic_set(&folio->_pincount, 0);
@@ -2017,8 +2016,6 @@ static bool __prep_compound_gigantic_folio(struct folio *folio,
 		p = folio_page(folio, j);
 		__ClearPageReserved(p);
 	}
-	folio_set_order(folio, 0);
-	__folio_clear_head(folio);
 	return false;
 }
 
diff --git a/mm/internal.h b/mm/internal.h
index 18cda26b8a92..0d96a3bc1d58 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -425,16 +425,12 @@ int split_free_page(struct page *free_page,
  */
 static inline void folio_set_order(struct folio *folio, unsigned int order)
 {
-	if (WARN_ON_ONCE(!folio_test_large(folio)))
+	if (WARN_ON_ONCE(!order || !folio_test_large(folio)))
 		return;
 
 	folio->_folio_order = order;
 #ifdef CONFIG_64BIT
-	/*
-	 * When hugetlb dissolves a folio, we need to clear the tail
-	 * page, rather than setting nr_pages to 1.
-	 */
-	folio->_folio_nr_pages = order ? 1U << order : 0;
+	folio->_folio_nr_pages = 1U << order;
 #endif
 }
 
-- 
2.31.1

