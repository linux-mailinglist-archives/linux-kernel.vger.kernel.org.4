Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF32062B43A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 08:51:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231794AbiKPHvL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 02:51:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232496AbiKPHvD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 02:51:03 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E16B613D24
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 23:51:02 -0800 (PST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AG7EZN6019791;
        Wed, 16 Nov 2022 07:50:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=I72SMcB9Nh5GrbTHhWHuP/ufwCqUK02E800IhbxJcvI=;
 b=JsWjsN2j+gX5kHZaK9XteMv5hujZ65uoBLZBSJGZj+bvAkEGRE4yT1BHAwBRhDD+bGto
 /kRgPW3q2hS5ksX+78V1nolgwq750IQe0JKy149cG6jk4pgNKx4axQrfz9X/9b4mdX1F
 82uwQZsY/pVuk1S/E8qZuolWtIOvpaAOl+4shvcWCUCUFx4Wkj59gbCJFtn4FBk6Uwb4
 61pQzAfeRr7p4pOMd43EhCXTGN0DU9ACY9yTzcnmAycjtrqBBy/jLmEbxpQ58ox2GQ0/
 VMJacw++7sX4ig/1PwyXdMcanMJ8CDaCqvyqwGBfVL20hU4h/s5/MWMxewzx6O27I9i3 nA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3kvu9wrqkh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Nov 2022 07:50:52 +0000
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2AG7FtMq027589;
        Wed, 16 Nov 2022 07:50:52 GMT
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3kvu9wrqjn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Nov 2022 07:50:52 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2AG7oosj016626;
        Wed, 16 Nov 2022 07:50:50 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma03fra.de.ibm.com with ESMTP id 3kt348v3vk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Nov 2022 07:50:50 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2AG7okxf62259648
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Nov 2022 07:50:46 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DB7834C044;
        Wed, 16 Nov 2022 07:50:46 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3ECB14C040;
        Wed, 16 Nov 2022 07:50:41 +0000 (GMT)
Received: from li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com (unknown [9.163.49.19])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 16 Nov 2022 07:50:40 +0000 (GMT)
Date:   Wed, 16 Nov 2022 08:50:37 +0100
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
Subject: mm: mmu_gather: do not define delayed_rmap if not used
Message-ID: <Y3SWTXMotahiqvBO@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
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
X-Proofpoint-ORIG-GUID: cCvXpFGQE3lRE7XncXT-QScuG9jjhokm
X-Proofpoint-GUID: AHiqeIdmIxzMn1bV-H05LR94Marl3dP9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-15_08,2022-11-15_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 spamscore=0 mlxlogscore=789 suspectscore=0 adultscore=0
 impostorscore=0 priorityscore=1501 phishscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211160053
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In cases the delayed rmap removal is not used (which are
currently UP and s390) skip delayed_rmap flag and make
the related code paths no-op.

Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
---
 include/asm-generic/tlb.h | 32 +++++++++++++++++++-------------
 mm/mmu_gather.c           |  8 ++++----
 2 files changed, 23 insertions(+), 17 deletions(-)

diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
index 154c774d6307..317bef9eee3c 100644
--- a/include/asm-generic/tlb.h
+++ b/include/asm-generic/tlb.h
@@ -265,24 +265,14 @@ extern bool __tlb_remove_page_size(struct mmu_gather *tlb,
  * This both sets 'delayed_rmap', and returns true. It would be an inline
  * function, except we define it before the 'struct mmu_gather'.
  */
-#define tlb_delay_rmap(tlb) (((tlb)->delayed_rmap = 1), true)
+#define tlb_delay_rmap(tlb)		(((tlb)->delayed_rmap = 1), true)
+#define tlb_reset_delay_rmap(tlb)	((tlb)->delayed_rmap = 0)
+#define tlb_rmap_delayed(tlb)		((tlb)->delayed_rmap)
 extern void tlb_flush_rmaps(struct mmu_gather *tlb, struct vm_area_struct *vma);
 #endif
 
 #endif
 
-/*
- * We have a no-op version of the rmap removal that doesn't
- * delay anything. That is used on S390, which flushes remote
- * TLBs synchronously, and on UP, which doesn't have any
- * remote TLBs to flush and is not preemptible due to this
- * all happening under the page table lock.
- */
-#ifndef tlb_delay_rmap
-#define tlb_delay_rmap(tlb) (false)
-static inline void tlb_flush_rmaps(struct mmu_gather *tlb, struct vm_area_struct *vma) { }
-#endif
-
 /*
  * struct mmu_gather is an opaque type used by the mm code for passing around
  * any data needed by arch specific code for tlb_remove_page.
@@ -313,10 +303,12 @@ struct mmu_gather {
 	 */
 	unsigned int		freed_tables : 1;
 
+#ifdef tlb_delay_rmap
 	/*
 	 * Do we have pending delayed rmap removals?
 	 */
 	unsigned int		delayed_rmap : 1;
+#endif
 
 	/*
 	 * at which levels have we cleared entries?
@@ -346,6 +338,20 @@ struct mmu_gather {
 #endif
 };
 
+/*
+ * We have a no-op version of the rmap removal that doesn't
+ * delay anything. That is used on S390, which flushes remote
+ * TLBs synchronously, and on UP, which doesn't have any
+ * remote TLBs to flush and is not preemptible due to this
+ * all happening under the page table lock.
+ */
+#ifndef tlb_delay_rmap
+#define tlb_delay_rmap(tlb)		(false)
+#define tlb_reset_delay_rmap(tlb)	do { } while (0)
+#define tlb_rmap_delayed(tlb)		(false)
+static inline void tlb_flush_rmaps(struct mmu_gather *tlb, struct vm_area_struct *vma) { }
+#endif
+
 void tlb_flush_mmu(struct mmu_gather *tlb);
 
 static inline void __tlb_adjust_range(struct mmu_gather *tlb,
diff --git a/mm/mmu_gather.c b/mm/mmu_gather.c
index 9f22309affee..b0f1bd20af2f 100644
--- a/mm/mmu_gather.c
+++ b/mm/mmu_gather.c
@@ -20,7 +20,7 @@ static bool tlb_next_batch(struct mmu_gather *tlb)
 	struct mmu_gather_batch *batch;
 
 	/* No more batching if we have delayed rmaps pending */
-	if (tlb->delayed_rmap)
+	if (tlb_rmap_delayed(tlb))
 		return false;
 
 	batch = tlb->active;
@@ -60,7 +60,7 @@ void tlb_flush_rmaps(struct mmu_gather *tlb, struct vm_area_struct *vma)
 {
 	struct mmu_gather_batch *batch;
 
-	if (!tlb->delayed_rmap)
+	if (!tlb_rmap_delayed(tlb))
 		return;
 
 	batch = tlb->active;
@@ -73,7 +73,7 @@ void tlb_flush_rmaps(struct mmu_gather *tlb, struct vm_area_struct *vma)
 		}
 	}
 
-	tlb->delayed_rmap = 0;
+	tlb_reset_delay_rmap(tlb);
 }
 #endif
 
@@ -311,7 +311,7 @@ static void __tlb_gather_mmu(struct mmu_gather *tlb, struct mm_struct *mm,
 	tlb->active     = &tlb->local;
 	tlb->batch_count = 0;
 #endif
-	tlb->delayed_rmap = 0;
+	tlb_reset_delay_rmap(tlb);
 
 	tlb_table_init(tlb);
 #ifdef CONFIG_MMU_GATHER_PAGE_SIZE
-- 
2.31.1

