Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC02E72BD17
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 11:51:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233235AbjFLJvp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 05:51:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232833AbjFLJvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 05:51:08 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 153798F7E
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 02:35:57 -0700 (PDT)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35C9J1go017905;
        Mon, 12 Jun 2023 09:35:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=eAd/ZbrDRWWwhMVabTIuXiM/RkSvKKwFTmIb0+8WaHQ=;
 b=ET/lHAm+VdQl/AbvkIKN3V/eY0fT2XVttoZIyFHB8m0c84mdzZ3J61r/QgimBlIxJ+zU
 Vd+71IBRKFDPe6xkfWacXEDyx8eeKU88Ht1aysNGyDIcXEM8h7PD1eY/11pZHUcD46eM
 D9FXBQygpQg3JyArH6M9mmxdBLPZvGqy2erR3iDS7CYS4+Gt1J3UCtANDQ+CVP49fXAv
 qq6Gia83Vu9hcqkR+UComjHWsvf1ryWT9n0c+sotxhSFE70Ek5S4pTMryo36tDIVBtK8
 gF05Ue1CnUICiSUzAW8KdnCQQsuWnWvAgxskJZGVvMoD6/QcyEQeCRURmgUWFaqpyPjr nA== 
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3r60m80bv8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Jun 2023 09:35:25 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 35C4pESU007408;
        Mon, 12 Jun 2023 09:35:23 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma05fra.de.ibm.com (PPS) with ESMTPS id 3r4gt4s0gk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Jun 2023 09:35:23 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 35C9ZJah43450946
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Jun 2023 09:35:19 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 809C32004E;
        Mon, 12 Jun 2023 09:35:19 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EAA1A20040;
        Mon, 12 Jun 2023 09:35:16 +0000 (GMT)
Received: from tarunpc.in.ibm.com (unknown [9.199.157.25])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 12 Jun 2023 09:35:16 +0000 (GMT)
From:   Tarun Sahu <tsahu@linux.ibm.com>
To:     linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, muchun.song@linux.dev,
        mike.kravetz@oracle.com, aneesh.kumar@linux.ibm.com,
        willy@infradead.org, sidhartha.kumar@oracle.com,
        gerald.schaefer@linux.ibm.com, linux-kernel@vger.kernel.org,
        jaypatel@linux.ibm.com, tsahu@linux.ibm.com
Subject: [PATCH] [mm-unstable] mm/folio: Replace set_compound_order with folio_set_order
Date:   Mon, 12 Jun 2023 15:05:14 +0530
Message-Id: <20230612093514.689846-1-tsahu@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: xO9wizThQfX7V6ZNG_HgVPesIQ6ZLK_J
X-Proofpoint-GUID: xO9wizThQfX7V6ZNG_HgVPesIQ6ZLK_J
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-12_06,2023-06-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 impostorscore=0 priorityscore=1501 malwarescore=0 spamscore=0
 lowpriorityscore=0 mlxscore=0 clxscore=1015 mlxlogscore=565 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306120082
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch [1] removed the need for special handling of order = 0
in folio_set_order. Now, folio_set_order and set_compound_order becomes
similar function. This patch removes the set_compound_order and uses
folio_set_order instead.

[1] https://lore.kernel.org/all/20230609183032.13E08C433D2@smtp.kernel.org/

Signed-off-by: Tarun Sahu <tsahu@linux.ibm.com>
---
Moved folio_set_order to the top instead of moving prep_compound_head below
to it so that git blame can show the proper change in prep_compound_head
which is replacement of set_compound_order with folio_set_order.

 include/linux/mm.h | 10 ----------
 mm/internal.h      | 32 ++++++++++++++++----------------
 2 files changed, 16 insertions(+), 26 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 27ce77080c79..61d75e0e5b40 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1229,16 +1229,6 @@ static inline void folio_set_compound_dtor(struct folio *folio,
 
 void destroy_large_folio(struct folio *folio);
 
-static inline void set_compound_order(struct page *page, unsigned int order)
-{
-	struct folio *folio = (struct folio *)page;
-
-	folio->_folio_order = order;
-#ifdef CONFIG_64BIT
-	folio->_folio_nr_pages = 1U << order;
-#endif
-}
-
 /* Returns the number of bytes in this potentially compound page. */
 static inline unsigned long page_size(struct page *page)
 {
diff --git a/mm/internal.h b/mm/internal.h
index c59fe08c5b39..c460b2fde977 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -378,12 +378,27 @@ extern void memblock_free_pages(struct page *page, unsigned long pfn,
 					unsigned int order);
 extern void __free_pages_core(struct page *page, unsigned int order);
 
+/*
+ * This will have no effect, other than possibly generating a warning, if the
+ * caller passes in a non-large folio.
+ */
+static inline void folio_set_order(struct folio *folio, unsigned int order)
+{
+	if (WARN_ON_ONCE(!order || !folio_test_large(folio)))
+		return;
+
+	folio->_folio_order = order;
+#ifdef CONFIG_64BIT
+	folio->_folio_nr_pages = 1U << order;
+#endif
+}
+
 static inline void prep_compound_head(struct page *page, unsigned int order)
 {
 	struct folio *folio = (struct folio *)page;
 
 	set_compound_page_dtor(page, COMPOUND_PAGE_DTOR);
-	set_compound_order(page, order);
+	folio_set_order(folio, order);
 	atomic_set(&folio->_entire_mapcount, -1);
 	atomic_set(&folio->_nr_pages_mapped, 0);
 	atomic_set(&folio->_pincount, 0);
@@ -419,21 +434,6 @@ extern void *memmap_alloc(phys_addr_t size, phys_addr_t align,
 int split_free_page(struct page *free_page,
 			unsigned int order, unsigned long split_pfn_offset);
 
-/*
- * This will have no effect, other than possibly generating a warning, if the
- * caller passes in a non-large folio.
- */
-static inline void folio_set_order(struct folio *folio, unsigned int order)
-{
-	if (WARN_ON_ONCE(!order || !folio_test_large(folio)))
-		return;
-
-	folio->_folio_order = order;
-#ifdef CONFIG_64BIT
-	folio->_folio_nr_pages = 1U << order;
-#endif
-}
-
 #if defined CONFIG_COMPACTION || defined CONFIG_CMA
 
 /*
-- 
2.31.1

