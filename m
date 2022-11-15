Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2389C62A400
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 22:23:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238766AbiKOVXU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 16:23:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231921AbiKOVWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 16:22:50 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2772522BE1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 13:22:49 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AFKIZIJ022487;
        Tue, 15 Nov 2022 21:22:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2022-7-12;
 bh=ZXiZrA4HYBBXzWdHv73gcqz8SPH14/W1bs6g/VbOofA=;
 b=UGJlR5+iFPdQb2Z9YRyMvV8jqeCIocEiEEwm6SBPa/GfwkHtchO7z4zg0Cf4DphbDK5c
 huSsi3txtVfg5uteoiZGellrJMvwHDvwBZwTXUc5LS5LQdxv1+2i1LhbeO4DsPHkRqu7
 f9oBrGL+21ziCm0ejApMGw6iiXeX0DqLWKEAORR7UO8N8B9tgPoztaRoQQpSw24zG+Xd
 1P0cSEIQRB9D0Vt4zyJEBVy3DqHg9kxwGSmYtiW8GMSTWpDIbEDiG3eJdlbzioJcMbYg
 ess2zzzGPj9Cjq59YV6wemd6xeBDFzHKS8fzA0wVpI76ugbVwoIbytw2lOhqUqQSULyn Xg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kv3ns2ybr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Nov 2022 21:22:32 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2AFLHbBh031840;
        Tue, 15 Nov 2022 21:22:30 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kt1xcfvde-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Nov 2022 21:22:30 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2AFLMSRc002082;
        Tue, 15 Nov 2022 21:22:29 GMT
Received: from dhcp-10-132-95-73.usdhcp.oraclecorp.com.com (dhcp-10-132-95-73.usdhcp.oraclecorp.com [10.132.95.73])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3kt1xcfvb0-2;
        Tue, 15 Nov 2022 21:22:29 +0000
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, songmuchun@bytedance.com,
        mike.kravetz@oracle.com, willy@infradead.org,
        almasrymina@google.com, linmiaohe@huawei.com, hughd@google.com,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH mm-unstable 01/10] mm: add folio dtor and order setter functions
Date:   Tue, 15 Nov 2022 13:22:08 -0800
Message-Id: <20221115212217.19539-2-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221115212217.19539-1-sidhartha.kumar@oracle.com>
References: <20221115212217.19539-1-sidhartha.kumar@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-15_08,2022-11-15_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=912 phishscore=0
 suspectscore=0 malwarescore=0 mlxscore=0 adultscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211150146
X-Proofpoint-GUID: 13SXim-31TboRW7oy2yL6cFPd65kpzUs
X-Proofpoint-ORIG-GUID: 13SXim-31TboRW7oy2yL6cFPd65kpzUs
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
index 982f2607180b..068686110729 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -895,6 +895,13 @@ static inline void set_compound_page_dtor(struct page *page,
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
@@ -910,6 +917,15 @@ static inline void set_compound_order(struct page *page, unsigned int order)
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
index f786993f92d0..1acde3b8251e 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1771,7 +1771,7 @@ static void __prep_new_hugetlb_folio(struct hstate *h, struct folio *folio)
 {
 	hugetlb_vmemmap_optimize(h, &folio->page);
 	INIT_LIST_HEAD(&folio->lru);
-	folio->_folio_dtor = HUGETLB_PAGE_DTOR;
+	folio_set_compound_dtor(folio, HUGETLB_PAGE_DTOR);
 	hugetlb_set_folio_subpool(folio, NULL);
 	set_hugetlb_cgroup(folio, NULL);
 	set_hugetlb_cgroup_rsvd(folio, NULL);
@@ -2927,7 +2927,6 @@ struct page *alloc_huge_page(struct vm_area_struct *vma,
 	 * a reservation exists for the allocation.
 	 */
 	page = dequeue_huge_page_vma(h, vma, addr, avoid_reserve, gbl_chg);
-
 	if (!page) {
 		spin_unlock_irq(&hugetlb_lock);
 		page = alloc_buddy_huge_page_with_mpol(h, vma, addr);
@@ -7317,7 +7316,6 @@ void move_hugetlb_state(struct folio *old_folio, struct folio *new_folio, int re
 		int old_nid = folio_nid(old_folio);
 		int new_nid = folio_nid(new_folio);
 
-
 		folio_set_hugetlb_temporary(old_folio);
 		folio_clear_hugetlb_temporary(new_folio);
 
-- 
2.38.1

