Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B401622368
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 06:19:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbiKIFT4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 00:19:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiKIFTy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 00:19:54 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64A081C41A
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 21:19:53 -0800 (PST)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2A94qva0032682;
        Wed, 9 Nov 2022 05:18:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=LrH8BIfpsTP39wyNKDVaHcP/glgryo0dSy/eDu+MvKs=;
 b=RApXaZ6teB0dvqYsxowDc8bz7IjN/RgKaUxQ9TmCi9jzkjl9m+jjULWYNkz1qiBLN8My
 /t+u+uIoZ1JHPyFTV9h/RS5m+A6fKtnY3tb5udUYQtuWkXJh+kO8Y7nIiLElVQPIhy4I
 FWF7OO4WQL4C34XLHHlrxET9McsvhDtLKMSP0jZQV0/QSswH40T9OzSwRQyIoShTo0Lx
 s1auoE9CLKbBuYuzE1X5UaXdlzXILFoKKsWD6lU2kbWTGEiOqrkkG2YqTZlEhw0NpQKa
 TCHh0RpaIjTdL4cM537kddrz0wuvt11049mQHYNCpdsmkByBSbO3ys3RRG3S8eyw+FGc LA== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kr4g3850w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Nov 2022 05:18:46 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2A95IjsP025092
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 9 Nov 2022 05:18:45 GMT
Received: from quicinc.com (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 8 Nov 2022
 21:18:42 -0800
From:   Pavankumar Kondeti <quic_pkondeti@quicinc.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Charan Teja Kalla <quic_charante@quicinc.com>,
        Prakash Gupta <quic_guptap@quicinc.com>,
        Divyanand Rangu <quic_drangu@quicinc.com>,
        Pavankumar Kondeti <quic_pkondeti@quicinc.com>
Subject: [PATCH] mm/madvise: fix madvise_pageout for private file mappings
Date:   Wed, 9 Nov 2022 10:48:36 +0530
Message-ID: <1667971116-12900-1-git-send-email-quic_pkondeti@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: SoP7s-0PyKxUV5nM38lMExrsnsyCdA1J
X-Proofpoint-ORIG-GUID: SoP7s-0PyKxUV5nM38lMExrsnsyCdA1J
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-09_01,2022-11-08_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 adultscore=0
 bulkscore=0 spamscore=0 malwarescore=0 impostorscore=0 mlxscore=0
 mlxlogscore=953 clxscore=1011 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2210170000 definitions=main-2211090040
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When MADV_PAGEOUT is called on a private file mapping VMA region,
we bail out early if the process is neither owner nor write capable
of the file. However, this VMA may have both private/shared clean
pages and private dirty pages. The opportunity of paging out the
private dirty pages (Anon pages) is missed. Fix this by caching
the file access check and use it later along with PageAnon() during
page walk.

We observe ~10% improvement in zram usage, thus leaving more available
memory on a 4GB RAM system running Android.

Signed-off-by: Pavankumar Kondeti <quic_pkondeti@quicinc.com>
---
 mm/madvise.c | 30 +++++++++++++++++++++++-------
 1 file changed, 23 insertions(+), 7 deletions(-)

diff --git a/mm/madvise.c b/mm/madvise.c
index c7105ec..b6b88e2 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -40,6 +40,7 @@
 struct madvise_walk_private {
 	struct mmu_gather *tlb;
 	bool pageout;
+	bool can_pageout_file;
 };
 
 /*
@@ -328,6 +329,7 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
 	struct madvise_walk_private *private = walk->private;
 	struct mmu_gather *tlb = private->tlb;
 	bool pageout = private->pageout;
+	bool pageout_anon_only = pageout && !private->can_pageout_file;
 	struct mm_struct *mm = tlb->mm;
 	struct vm_area_struct *vma = walk->vma;
 	pte_t *orig_pte, *pte, ptent;
@@ -364,6 +366,9 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
 		if (page_mapcount(page) != 1)
 			goto huge_unlock;
 
+		if (pageout_anon_only && !PageAnon(page))
+			goto huge_unlock;
+
 		if (next - addr != HPAGE_PMD_SIZE) {
 			int err;
 
@@ -432,6 +437,8 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
 		if (PageTransCompound(page)) {
 			if (page_mapcount(page) != 1)
 				break;
+			if (pageout_anon_only && !PageAnon(page))
+				break;
 			get_page(page);
 			if (!trylock_page(page)) {
 				put_page(page);
@@ -459,6 +466,9 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
 		if (!PageLRU(page) || page_mapcount(page) != 1)
 			continue;
 
+		if (pageout_anon_only && !PageAnon(page))
+			continue;
+
 		VM_BUG_ON_PAGE(PageTransCompound(page), page);
 
 		if (pte_young(ptent)) {
@@ -541,11 +551,13 @@ static long madvise_cold(struct vm_area_struct *vma,
 
 static void madvise_pageout_page_range(struct mmu_gather *tlb,
 			     struct vm_area_struct *vma,
-			     unsigned long addr, unsigned long end)
+			     unsigned long addr, unsigned long end,
+			     bool can_pageout_file)
 {
 	struct madvise_walk_private walk_private = {
 		.pageout = true,
 		.tlb = tlb,
+		.can_pageout_file = can_pageout_file,
 	};
 
 	tlb_start_vma(tlb, vma);
@@ -553,10 +565,8 @@ static void madvise_pageout_page_range(struct mmu_gather *tlb,
 	tlb_end_vma(tlb, vma);
 }
 
-static inline bool can_do_pageout(struct vm_area_struct *vma)
+static inline bool can_do_file_pageout(struct vm_area_struct *vma)
 {
-	if (vma_is_anonymous(vma))
-		return true;
 	if (!vma->vm_file)
 		return false;
 	/*
@@ -576,17 +586,23 @@ static long madvise_pageout(struct vm_area_struct *vma,
 {
 	struct mm_struct *mm = vma->vm_mm;
 	struct mmu_gather tlb;
+	bool can_pageout_file;
 
 	*prev = vma;
 	if (!can_madv_lru_vma(vma))
 		return -EINVAL;
 
-	if (!can_do_pageout(vma))
-		return 0;
+	/*
+	 * If the VMA belongs to a private file mapping, there can be private
+	 * dirty pages which can be paged out if even this process is neither
+	 * owner nor write capable of the file. Cache the file access check
+	 * here and use it later during page walk.
+	 */
+	can_pageout_file = can_do_file_pageout(vma);
 
 	lru_add_drain();
 	tlb_gather_mmu(&tlb, mm);
-	madvise_pageout_page_range(&tlb, vma, start_addr, end_addr);
+	madvise_pageout_page_range(&tlb, vma, start_addr, end_addr, can_pageout_file);
 	tlb_finish_mmu(&tlb);
 
 	return 0;
-- 
2.7.4

