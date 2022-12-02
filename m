Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EEF464008E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 07:30:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232272AbiLBGaU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 01:30:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231395AbiLBGaS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 01:30:18 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3D60CB22A
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 22:30:17 -0800 (PST)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B24OXiZ006185;
        Fri, 2 Dec 2022 06:30:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=yB+4a+twZIHEkO39zfADVQ6a+j3braLNJjx+t1//bl8=;
 b=S5lnT29pA7OrJk2zrvW84W0klUVS4OYLLasT9NhAJPRoIXnRkCG52gBsux/jdEsLBKpo
 BRwgPllCJOhKYMOEor3UM0AorYpz/hDCHxBMnz+mfQBZrd7hsZlca0PJBgNU1hADrmLA
 4ueqGyj9aUI4jy4jj+fKnE0pEPL4+UP+weizC5fK2niHxXxX4bQYguARDsLmPgLF+yuK
 nELsbgIrXits/bguhTRHg7gnob84V3kaGZxy+v1ejdwdceE6ILA6uYfab/+74T6C2Xy6
 F9wX+N+drU5/bDGtbY9J2Zq4vVQFKKu98WGQMPk3fpNWMMEVlvU92vI6UwDisOmEIwa+ WA== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3m6k83c0sc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 02 Dec 2022 06:30:09 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2B26U8Px009181
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 2 Dec 2022 06:30:08 GMT
Received: from quicinc.com (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Thu, 1 Dec 2022
 22:30:05 -0800
From:   Pavankumar Kondeti <quic_pkondeti@quicinc.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Mark Hemment <markhemm@googlemail.com>,
        David Hildenbrand <david@redhat.com>,
        "Charan Teja Kalla" <quic_charante@quicinc.com>,
        Prakash Gupta <quic_guptap@quicinc.com>,
        Divyanand Rangu <quic_drangu@quicinc.com>,
        Pavankumar Kondeti <quic_pkondeti@quicinc.com>
Subject: [PATCH v2] mm/madvise: fix madvise_pageout for private file mappings
Date:   Fri, 2 Dec 2022 11:59:57 +0530
Message-ID: <1669962597-27724-1-git-send-email-quic_pkondeti@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Tsa-cX_JTQ7iY5aHzAxDQ9BPAISfDYTy
X-Proofpoint-ORIG-GUID: Tsa-cX_JTQ7iY5aHzAxDQ9BPAISfDYTy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-02_02,2022-12-01_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 malwarescore=0
 priorityscore=1501 suspectscore=0 phishscore=0 lowpriorityscore=0
 mlxscore=0 adultscore=0 impostorscore=0 clxscore=1015 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212020047
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When MADV_PAGEOUT is called on a private file mapping VMA region,
we bail out early if the process is neither owner nor write capable
of the file. However, this VMA may have both private/shared clean
pages and private dirty pages. The opportunity of paging out the
private dirty pages (Anon pages) is missed. Fix this behavior by
allowing private file mappings pageout further and perform the file
access check along with PageAnon() during page walk.

We observe ~10% improvement in zram usage, thus leaving more available
memory on a 4GB RAM system running Android.

Signed-off-by: Pavankumar Kondeti <quic_pkondeti@quicinc.com>
---

V2:

- As per David's suggestion, removed new argument introduced in
  madvise_walk_private struct and directly call can_do_file_pageout()

- As per Mark's suggestions, optimized PageAnon() checks. Also bailed out
early if the file mapping is not private.

 mm/madvise.c | 53 +++++++++++++++++++++++++++++++++++------------------
 1 file changed, 35 insertions(+), 18 deletions(-)

diff --git a/mm/madvise.c b/mm/madvise.c
index c7105ec..02f12f4 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -321,6 +321,21 @@ static long madvise_willneed(struct vm_area_struct *vma,
 	return 0;
 }
 
+static inline bool can_do_file_pageout(struct vm_area_struct *vma)
+{
+	if (!vma->vm_file)
+		return false;
+	/*
+	 * paging out pagecache only for non-anonymous mappings that correspond
+	 * to the files the calling process could (if tried) open for writing;
+	 * otherwise we'd be including shared non-exclusive mappings, which
+	 * opens a side channel.
+	 */
+	return inode_owner_or_capable(&init_user_ns,
+				      file_inode(vma->vm_file)) ||
+	       file_permission(vma->vm_file, MAY_WRITE) == 0;
+}
+
 static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
 				unsigned long addr, unsigned long end,
 				struct mm_walk *walk)
@@ -334,10 +349,14 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
 	spinlock_t *ptl;
 	struct page *page = NULL;
 	LIST_HEAD(page_list);
+	bool pageout_anon_only_filter;
 
 	if (fatal_signal_pending(current))
 		return -EINTR;
 
+	pageout_anon_only_filter = pageout && !vma_is_anonymous(vma) &&
+					!can_do_file_pageout(vma);
+
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 	if (pmd_trans_huge(*pmd)) {
 		pmd_t orig_pmd;
@@ -364,6 +383,9 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
 		if (page_mapcount(page) != 1)
 			goto huge_unlock;
 
+		if (pageout_anon_only_filter && !PageAnon(page))
+			goto huge_unlock;
+
 		if (next - addr != HPAGE_PMD_SIZE) {
 			int err;
 
@@ -432,6 +454,8 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
 		if (PageTransCompound(page)) {
 			if (page_mapcount(page) != 1)
 				break;
+			if (pageout_anon_only_filter && !PageAnon(page))
+				break;
 			get_page(page);
 			if (!trylock_page(page)) {
 				put_page(page);
@@ -459,6 +483,9 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
 		if (!PageLRU(page) || page_mapcount(page) != 1)
 			continue;
 
+		if (pageout_anon_only_filter && !PageAnon(page))
+			continue;
+
 		VM_BUG_ON_PAGE(PageTransCompound(page), page);
 
 		if (pte_young(ptent)) {
@@ -553,23 +580,6 @@ static void madvise_pageout_page_range(struct mmu_gather *tlb,
 	tlb_end_vma(tlb, vma);
 }
 
-static inline bool can_do_pageout(struct vm_area_struct *vma)
-{
-	if (vma_is_anonymous(vma))
-		return true;
-	if (!vma->vm_file)
-		return false;
-	/*
-	 * paging out pagecache only for non-anonymous mappings that correspond
-	 * to the files the calling process could (if tried) open for writing;
-	 * otherwise we'd be including shared non-exclusive mappings, which
-	 * opens a side channel.
-	 */
-	return inode_owner_or_capable(&init_user_ns,
-				      file_inode(vma->vm_file)) ||
-	       file_permission(vma->vm_file, MAY_WRITE) == 0;
-}
-
 static long madvise_pageout(struct vm_area_struct *vma,
 			struct vm_area_struct **prev,
 			unsigned long start_addr, unsigned long end_addr)
@@ -581,7 +591,14 @@ static long madvise_pageout(struct vm_area_struct *vma,
 	if (!can_madv_lru_vma(vma))
 		return -EINVAL;
 
-	if (!can_do_pageout(vma))
+	/*
+	 * If the VMA belongs to a private file mapping, there can be private
+	 * dirty pages which can be paged out if even this process is neither
+	 * owner nor write capable of the file. We allow private file mappings
+	 * further to pageout dirty anon pages.
+	 */
+	if (!vma_is_anonymous(vma) && (!can_do_file_pageout(vma) &&
+				(vma->vm_flags & VM_MAYSHARE)))
 		return 0;
 
 	lru_add_drain();
-- 
2.7.4

