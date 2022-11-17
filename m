Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA96B62E646
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 22:04:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240516AbiKQVEN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 16:04:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239809AbiKQVDl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 16:03:41 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAA5D275E5
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 13:03:32 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AHKOQbn002482;
        Thu, 17 Nov 2022 21:03:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2022-7-12;
 bh=k+s6al3wwRtBndCW2ZWmf31NL6al8soF2mssq2Ti0Oc=;
 b=mZlOHPgAIKUokYiEYU/wm818rb3shzppAw9LoNV9rfPRyh2Hmca0AcnVA4RKROurg1dT
 e8bLXLt0LzHkhQm+SPWJPLuCZ6X3x/1GfLiBaB/WWSfJ3RcK2lO4HhBZeXOXqyZ0MShI
 dkQ4sPM37QTzkI63BVK3QWEoBqiCMn2UThfsPJ5GdJ8r/jNegaZcnqx9p3SpbqZ2EKJo
 Zjb1cLsvaIiDlNspDSmWe1BCeHqqRTaDkVGw9aE0xuLC0xV+znIv7RmK0SupkOLAJJok
 imGso4NsuPTtYzZBxCjsEibB85WxF5wRJG5URlzxu9JhQWygStYEE4wseIVT3DuJFrTY yA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kv8yktgkv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Nov 2022 21:03:11 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2AHKgvsI010998;
        Thu, 17 Nov 2022 21:03:09 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ku3kagy2m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Nov 2022 21:03:09 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2AHL37Fd032582;
        Thu, 17 Nov 2022 21:03:09 GMT
Received: from sid-dell.us.oracle.com (dhcp-10-132-95-73.usdhcp.oraclecorp.com [10.132.95.73])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3ku3kagy08-2;
        Thu, 17 Nov 2022 21:03:09 +0000
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, songmuchun@bytedance.com,
        mike.kravetz@oracle.com, willy@infradead.org,
        almasrymina@google.com, linmiaohe@huawei.com, hughd@google.com,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH mm-unstable v2 01/10] mm: add folio dtor and order setter functions
Date:   Thu, 17 Nov 2022 13:02:49 -0800
Message-Id: <20221117210258.12732-2-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221117210258.12732-1-sidhartha.kumar@oracle.com>
References: <20221117210258.12732-1-sidhartha.kumar@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-17_06,2022-11-17_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 adultscore=0
 phishscore=0 malwarescore=0 suspectscore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211170150
X-Proofpoint-GUID: 7-LgzR41kaozz5_oBEAW_85xG-oTzz4V
X-Proofpoint-ORIG-GUID: 7-LgzR41kaozz5_oBEAW_85xG-oTzz4V
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
index a48c5ad16a5e..47ba2b2b22ae 100644
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
+	folio->_folio_nr_pages = 1U << order;
+#endif
+}
+
 /* Returns the number of pages in this potentially compound page. */
 static inline unsigned long compound_nr(struct page *page)
 {
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 002337cc27b5..157f2392c64f 100644
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
@@ -2936,7 +2936,6 @@ struct page *alloc_huge_page(struct vm_area_struct *vma,
 	 * a reservation exists for the allocation.
 	 */
 	page = dequeue_huge_page_vma(h, vma, addr, avoid_reserve, gbl_chg);
-
 	if (!page) {
 		spin_unlock_irq(&hugetlb_lock);
 		page = alloc_buddy_huge_page_with_mpol(h, vma, addr);
@@ -7349,7 +7348,6 @@ void move_hugetlb_state(struct folio *old_folio, struct folio *new_folio, int re
 		int old_nid = folio_nid(old_folio);
 		int new_nid = folio_nid(new_folio);
 
-
 		folio_set_hugetlb_temporary(old_folio);
 		folio_clear_hugetlb_temporary(new_folio);
 
-- 
2.38.1

