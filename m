Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6BC462FFEE
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 23:21:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbiKRWVB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 17:21:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230403AbiKRWUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 17:20:34 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D789B9A5C7
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 14:20:31 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AILNqP0028284;
        Fri, 18 Nov 2022 22:20:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2022-7-12;
 bh=tGmuZTBNbre96NHUK8JjH0uovdu0VRYw1Si/RwfIyuI=;
 b=hW2vbpKavv0zc0LzqJcKmPU8NQeFFiR3rjXzqrDYjJiv9wgZpZuWHbSfCleXTwiqHMbI
 2TTS+hH6WxEzt1nHBUpLG1bkfagw4q4PV27OffY8rkZ5z6KyvTX56asyyrMTMVhUvxvY
 ZnkvwrCJO1WSdnFYkU2G64BAlwDasDAkQQ/2pNhKADynGU7eFT3ER2zNCvPHWLkzh34h
 jSkVdOPG6lJ6OVCROx1S6/SSpKdUcIRQ09kOLukNi+2zaQd13Vam8cqcjHmQm+xgN3yt
 TWmhZgINBSTFEms3naZ+ftycPQMrn5HC6/nTS71C0buex79bpdZAU7xI4lHcxeXu+xrB /A== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kxh458853-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Nov 2022 22:20:09 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2AIKcWxX001852;
        Fri, 18 Nov 2022 22:20:09 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ku3kc1eve-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Nov 2022 22:20:09 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2AIMK7qP040370;
        Fri, 18 Nov 2022 22:20:08 GMT
Received: from sid-dell.us.oracle.com (dhcp-10-159-141-24.vpn.oracle.com [10.159.141.24])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3ku3kc1esc-2;
        Fri, 18 Nov 2022 22:20:08 +0000
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, songmuchun@bytedance.com,
        mike.kravetz@oracle.com, willy@infradead.org,
        almasrymina@google.com, linmiaohe@huawei.com, hughd@google.com,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH mm-unstable v4 01/10] mm: add folio dtor and order setter functions
Date:   Fri, 18 Nov 2022 14:19:53 -0800
Message-Id: <20221118222002.82588-2-sidhartha.kumar@oracle.com>
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
X-Proofpoint-ORIG-GUID: RhIRZtB6Dzm0KkkTFIQbHxb16u5h1bTp
X-Proofpoint-GUID: RhIRZtB6Dzm0KkkTFIQbHxb16u5h1bTp
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add folio equivalents for set_compound_order() and set_compound_page_dtor().

Also remove extra new-lines introduced by mm/hugetlb: convert
move_hugetlb_state() to folios and mm/hugetlb_cgroup: convert
hugetlb_cgroup_uncharge_page() to folios.

Suggested-by: Mike Kravetz <mike.kravetz@oracle.com>
Suggested-by: Muchun Song <songmuchun@bytedance.com>
Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
 include/linux/mm.h | 16 ++++++++++++++++
 mm/hugetlb.c       |  4 +---
 2 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index a48c5ad16a5e..2bdef8a5298a 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -972,6 +972,13 @@ static inline void set_compound_page_dtor(struct page *page,
 	page[1].compound_dtor = compound_dtor;
 }
 
+static inline void folio_set_compound_dtor(struct folio *folio,
+		enum compound_dtor_id compound_dtor)
+{
+	VM_BUG_ON_FOLIO(compound_dtor >= NR_COMPOUND_DTORS, folio);
+	folio->_folio_dtor = compound_dtor;
+}
+
 void destroy_large_folio(struct folio *folio);
 
 static inline int head_compound_pincount(struct page *head)
@@ -987,6 +994,15 @@ static inline void set_compound_order(struct page *page, unsigned int order)
 #endif
 }
 
+static inline void folio_set_compound_order(struct folio *folio,
+		unsigned int order)
+{
+	folio->_folio_order = order;
+#ifdef CONFIG_64BIT
+	folio->_folio_nr_pages = order ? 1U << order : 0;
+#endif
+}
+
 /* Returns the number of pages in this potentially compound page. */
 static inline unsigned long compound_nr(struct page *page)
 {
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 4c2fe7fec475..6390de8975c5 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1780,7 +1780,7 @@ static void __prep_new_hugetlb_folio(struct hstate *h, struct folio *folio)
 {
 	hugetlb_vmemmap_optimize(h, &folio->page);
 	INIT_LIST_HEAD(&folio->lru);
-	folio->_folio_dtor = HUGETLB_PAGE_DTOR;
+	folio_set_compound_dtor(folio, HUGETLB_PAGE_DTOR);
 	hugetlb_set_folio_subpool(folio, NULL);
 	set_hugetlb_cgroup(folio, NULL);
 	set_hugetlb_cgroup_rsvd(folio, NULL);
@@ -2938,7 +2938,6 @@ struct page *alloc_huge_page(struct vm_area_struct *vma,
 	 * a reservation exists for the allocation.
 	 */
 	page = dequeue_huge_page_vma(h, vma, addr, avoid_reserve, gbl_chg);
-
 	if (!page) {
 		spin_unlock_irq(&hugetlb_lock);
 		page = alloc_buddy_huge_page_with_mpol(h, vma, addr);
@@ -7351,7 +7350,6 @@ void move_hugetlb_state(struct folio *old_folio, struct folio *new_folio, int re
 		int old_nid = folio_nid(old_folio);
 		int new_nid = folio_nid(new_folio);
 
-
 		folio_set_hugetlb_temporary(old_folio);
 		folio_clear_hugetlb_temporary(new_folio);
 
-- 
2.38.1

