Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E9C2703698
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 19:11:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243689AbjEORLv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 13:11:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243678AbjEORLX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 13:11:23 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 827F3100C8
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 10:09:36 -0700 (PDT)
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34FH71vX003712;
        Mon, 15 May 2023 17:08:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=vqKnBW1jVpjgvLKVZUfkhbQP0EXBChpJr7Ws0PrkfpE=;
 b=ZF5m59j5PzTQyhr/0pZtCLJWXjjE5d2pbrA9fvrp6qqEzkxQjgQrqAOQ3MPthPiwLxnd
 gcGWd8sOK7zrQ52NfMt++5QhH8hFgJ1HNRagClkX+J0hmg0uYI3DrMrjbMHboYyOmpQ1
 0mt7xKDb04Pl/yBcGEPYZdUR877cOrXzaHH0PCK/AeDblUserVsGUAmWDSiiyrqXEPo2
 SwbTOIivDkZS+0VVGGdZIAhBISPO3beSYaxwXHnf4GsLKScY/vw8Rje1f5yxK1tAUNEx
 GfmR5xZDX+savl31fCtkePtkN5+ou8LYQGCiZOjVvIOuL5V7CVQ/eTR8anWhr9FI2rVl BA== 
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qkr70s48h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 May 2023 17:08:29 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 34F4cDVf008930;
        Mon, 15 May 2023 17:08:27 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
        by ppma01fra.de.ibm.com (PPS) with ESMTPS id 3qj264s0by-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 May 2023 17:08:26 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 34FH8NH93211900
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 May 2023 17:08:23 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5345E20043;
        Mon, 15 May 2023 17:08:23 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D805B20040;
        Mon, 15 May 2023 17:08:17 +0000 (GMT)
Received: from tarunpc.ibmuc.com (unknown [9.43.21.157])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 15 May 2023 17:08:17 +0000 (GMT)
From:   Tarun Sahu <tsahu@linux.ibm.com>
To:     linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, muchun.song@linux.dev,
        mike.kravetz@oracle.com, aneesh.kumar@linux.ibm.com,
        willy@infradead.org, sidhartha.kumar@oracle.com,
        gerald.schaefer@linux.ibm.com, linux-kernel@vger.kernel.org,
        jaypatel@linux.ibm.com, tsahu@linux.ibm.com
Subject: [PATCH v2] mm/folio: Avoid special handling for order value 0 in folio_set_order
Date:   Mon, 15 May 2023 22:38:09 +0530
Message-Id: <20230515170809.284680-1-tsahu@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 4-rCbhDpET9mgBonILTZVw_0mH2M3-07
X-Proofpoint-ORIG-GUID: 4-rCbhDpET9mgBonILTZVw_0mH2M3-07
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-15_15,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 mlxlogscore=999 clxscore=1011 mlxscore=0 malwarescore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 spamscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305150143
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

folio_set_order(folio, 0) is used in kernel at two places
__destroy_compound_gigantic_folio and __prep_compound_gigantic_folio.
Currently, It is called to clear out the folio->_folio_nr_pages and
folio->_folio_order.

For __destroy_compound_gigantic_folio:
In past, folio_set_order(folio, 0) was needed because page->mapping used
to overlap with _folio_nr_pages and _folio_order. So if these fields were
left uncleared during freeing gigantic hugepages, they were causing
"BUG: bad page state" due to non-zero page->mapping. Now, After
Commit a01f43901cfb ("hugetlb: be sure to free demoted CMA pages to
CMA") page->mapping has explicitly been cleared out for tail pages. Also,
_folio_order and _folio_nr_pages no longer overlaps with page->mapping.

struct page {
...
   struct address_space * mapping;  /* 24     8 */
...
}

struct folio {
...
    union {
        struct {
        	long unsigned int _flags_1;      /* 64    8 */
        	long unsigned int _head_1;       /* 72    8 */
        	unsigned char _folio_dtor;       /* 80    1 */
        	unsigned char _folio_order;      /* 81    1 */

        	/* XXX 2 bytes hole, try to pack */

        	atomic_t   _entire_mapcount;     /* 84    4 */
        	atomic_t   _nr_pages_mapped;     /* 88    4 */
        	atomic_t   _pincount;            /* 92    4 */
        	unsigned int _folio_nr_pages;    /* 96    4 */
        };                                       /* 64   40 */
        struct page __page_1 __attribute__((__aligned__(8))); /* 64   64 */
    }
...
}

So, folio_set_order(folio, 0) can be removed from freeing gigantic
folio path (__destroy_compound_gigantic_folio).

Another place, folio_set_order(folio, 0) is called inside
__prep_compound_gigantic_folio during error path. Here,
folio_set_order(folio, 0) can also be removed if we move
folio_set_order(folio, order) after for loop.

The patch also moves _folio_set_head call in __prep_compound_gigantic_folio()
such that we avoid clearing them in the error path.

Also, as Mike pointed out:
"It would actually be better to move the calls _folio_set_head and
folio_set_order in __prep_compound_gigantic_folio() as suggested here. Why?
In the current code, the ref count on the 'head page' is still 1 (or more)
while those calls are made. So, someone could take a speculative ref on the
page BEFORE the tail pages are set up."

This way, folio_set_order(folio, 0) is no more needed. And it will also
helps removing the confusion of folio order being set to 0 (as _folio_order
field is part of first tail page).

Testing: I have run LTP tests, which all passes. and also I have written
the test in LTP which tests the bug caused by compound_nr and page->mapping
overlapping.

https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/mem/hugetlb/hugemmap/hugemmap32.c

Running on older kernel ( < 5.10-rc7) with the above bug this fails while
on newer kernel and, also with this patch it passes.

Signed-off-by: Tarun Sahu <tsahu@linux.ibm.com>
---
 mm/hugetlb.c  | 9 +++------
 mm/internal.h | 8 ++------
 2 files changed, 5 insertions(+), 12 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index f154019e6b84..607553445855 100644
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
index 68410c6d97ac..c59fe08c5b39 100644
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

