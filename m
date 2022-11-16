Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0521A62B451
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 08:55:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232626AbiKPHzp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 02:55:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiKPHzn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 02:55:43 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EA0211451
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 23:55:41 -0800 (PST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AG7I8Ro024283;
        Wed, 16 Nov 2022 07:55:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=zxqPjpCi3JcyOanxgzeAkaLI2bCjiEEcYtFfqwuvnrU=;
 b=n4Vo0aDH3U1ntnxD7IUZ4WPQ1sNHUfKKRpIazXNRLaybUrNe9aqHGQQu3Z/oKWFXOEyI
 AwwwGkjysmdAzIm4wrH9vv+JFoQtxgXkaQ9WSDMk4/ZC1hvdALgw8l0yZ7Oa1m88YaHr
 R5ew9wRN9n22V+hcRcTLGK+cFiVRbrI2JX5KxsG4BC8LaYb6/zhNR2xbX23XyymsAxEA
 LfOVhjgy61K/b8plgdHs3OENn9UmbF2kufCjDWARHIySGQVU+7TcIhcyVN0GzCeDOZWx
 eBQd7HMamqdwFBqihwBaiP5xAAYZGYTaE2Lynjnjflt+qY4rXxxUzQZJiV1gmR2Plugr rw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kvubk8rb6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Nov 2022 07:55:33 +0000
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2AG7JUZa028413;
        Wed, 16 Nov 2022 07:55:32 GMT
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kvubk8rau-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Nov 2022 07:55:32 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2AG7p1Xg016669;
        Wed, 16 Nov 2022 07:55:30 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma03fra.de.ibm.com with ESMTP id 3kt348v421-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Nov 2022 07:55:30 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2AG7tRo439912076
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Nov 2022 07:55:27 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6D52F4C040;
        Wed, 16 Nov 2022 07:55:27 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E4D7E4C044;
        Wed, 16 Nov 2022 07:55:21 +0000 (GMT)
Received: from li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com (unknown [9.163.49.19])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 16 Nov 2022 07:55:21 +0000 (GMT)
Date:   Wed, 16 Nov 2022 08:55:17 +0100
From:   Alexander Gordeev <agordeev@linux.ibm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Hugh Dickins <hughd@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Nadav Amit <nadav.amit@gmail.com>,
        Will Deacon <will@kernel.org>,
        Aneesh Kumar <aneesh.kumar@linux.ibm.com>,
        Nick Piggin <npiggin@gmail.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Subject: [PATCH 4/4] mm: mmu_gather: rename tlb_delay_rmap() function
Message-ID: <Y3SXZcYeVbzGXR88@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
References: <20221109203051.1835763-1-torvalds@linux-foundation.org>
 <20221109203051.1835763-4-torvalds@linux-foundation.org>
 <CAHk-=wjf+gN25grUT3o3XK8-B-b2jhBuN8YMLQvq-=AXTcuFXg@mail.gmail.com>
 <CAHk-=wiFmm+X92Ghkz_LDG53djReK=idAj0uvSdES+yeG1X=Dw@mail.gmail.com>
 <Y3SVqePHGXRUagyF@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3SVqePHGXRUagyF@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: u61HFfB8v8CpGA_LHireVp_uCMsQZ7Fu
X-Proofpoint-ORIG-GUID: 2bT4bnP3VomTt9cMFUa1muWeD4iWKzHS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-15_08,2022-11-15_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 lowpriorityscore=0 mlxlogscore=814 malwarescore=0 suspectscore=0
 mlxscore=0 priorityscore=1501 spamscore=0 clxscore=1015 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211160053
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tlb_delay_rmap() function indicates to the TLB gather
infrastructure that a particular page should be removed
from rmap until after the TLB flush. Yet, the function
name and prototype indicate the whole TLB gather state.

Rename tlb_delay_rmap() to tlb_delay_page_rmap() along
with delay_rmap local variable and avoid the described
ambiguity.

Although unlikely ever used, add 'struc page' argument
to the renamed function to emphasize the notion of the
page being delayed.

Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
---
 include/asm-generic/tlb.h | 14 +++++++-------
 mm/memory.c               | 12 ++++++------
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
index 33943a4de5a7..2c425acdd2be 100644
--- a/include/asm-generic/tlb.h
+++ b/include/asm-generic/tlb.h
@@ -261,8 +261,8 @@ extern bool __tlb_remove_page_size(struct mmu_gather *tlb,
 				   int page_size);
 
 #ifdef CONFIG_SMP
-#define tlb_delay_rmap tlb_delay_rmap
-static inline bool tlb_delay_rmap(struct mmu_gather *tlb);
+#define tlb_delay_page_rmap tlb_delay_page_rmap
+static inline bool tlb_delay_page_rmap(struct mmu_gather *tlb, struct page *page);
 static inline void tlb_reset_delay_rmap(struct mmu_gather *tlb);
 static inline bool tlb_rmap_delayed(struct mmu_gather *tlb);
 extern void tlb_flush_rmaps(struct mmu_gather *tlb, struct vm_area_struct *vma);
@@ -300,7 +300,7 @@ struct mmu_gather {
 	 */
 	unsigned int		freed_tables : 1;
 
-#ifdef tlb_delay_rmap
+#ifdef tlb_delay_page_rmap
 	/*
 	 * Do we have pending delayed rmap removals?
 	 */
@@ -335,9 +335,9 @@ struct mmu_gather {
 #endif
 };
 
-#ifdef tlb_delay_rmap
+#ifdef tlb_delay_page_rmap
 
-static inline bool tlb_delay_rmap(struct mmu_gather *tlb)
+static inline bool tlb_delay_page_rmap(struct mmu_gather *tlb, struct page *page)
 {
 	tlb->delayed_rmap = 1;
 
@@ -363,8 +363,8 @@ static inline bool tlb_rmap_delayed(struct mmu_gather *tlb)
  * remote TLBs to flush and is not preemptible due to this
  * all happening under the page table lock.
  */
-#define tlb_delay_rmap tlb_delay_rmap
-static inline bool tlb_delay_rmap(struct mmu_gather *tlb)
+#define tlb_delay_page_rmap tlb_delay_page_rmap
+static inline bool tlb_delay_page_rmap(struct mmu_gather *tlb, struct page *page)
 {
 	return false;
 }
diff --git a/mm/memory.c b/mm/memory.c
index 38b58cd07b52..5ba4a1f94688 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1374,7 +1374,7 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 			break;
 
 		if (pte_present(ptent)) {
-			unsigned int delay_rmap;
+			unsigned int delay_page_rmap;
 
 			page = vm_normal_page(vma, addr, ptent);
 			if (unlikely(!should_zap_page(details, page)))
@@ -1387,12 +1387,12 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 			if (unlikely(!page))
 				continue;
 
-			delay_rmap = 0;
+			delay_page_rmap = 0;
 			if (!PageAnon(page)) {
 				if (pte_dirty(ptent)) {
 					set_page_dirty(page);
-					if (tlb_delay_rmap(tlb)) {
-						delay_rmap = 1;
+					if (tlb_delay_page_rmap(tlb, page)) {
+						delay_page_rmap = 1;
 						force_flush = 1;
 					}
 				}
@@ -1401,12 +1401,12 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 					mark_page_accessed(page);
 			}
 			rss[mm_counter(page)]--;
-			if (!delay_rmap) {
+			if (!delay_page_rmap) {
 				page_remove_rmap(page, vma, false);
 				if (unlikely(page_mapcount(page) < 0))
 					print_bad_pte(vma, addr, ptent, page);
 			}
-			if (unlikely(__tlb_remove_page(tlb, page, delay_rmap))) {
+			if (unlikely(__tlb_remove_page(tlb, page, delay_page_rmap))) {
 				force_flush = 1;
 				addr += PAGE_SIZE;
 				break;
-- 
2.31.1

