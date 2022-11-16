Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32DBD62B431
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 08:50:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232684AbiKPHuB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 02:50:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiKPHt6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 02:49:58 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C906C13D3A
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 23:49:57 -0800 (PST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AG7B3Ae003519;
        Wed, 16 Nov 2022 07:49:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=V7U57MhOQVptPYtVtN1POlRv/jzcS/7ubz1R1SMk9wc=;
 b=dE4O/qeUlM0Mj4ZBbwRPAuXXZizKKtQ02+ntOSQDagzxKqrjrmvUajTsSYwnM/YzCDHK
 sxr9jeZ7wvtHpQbNyCFkAN5pxgrof0FQSa6zFCf3MIMLoyok+9zpTribsDNNFv4pWnUQ
 fKkOlB8AzOHeFrUJnaEwVSC6nPAWIVltXgiMS3F2Vydjx5ZtdA2Pvg6JIqccoDgMRsVF
 5YxrlBlzony9Otp26BCmcsrkJLyeAwhCyV9QCGvVlctiZor/sDXh2WBJUYC8G+YFCNyt
 oFU5P1VSLrFw3aDNWI16uzosoy4/xUM3fiCbHphqXmTt1q6i3yud4DrPS8rhR050cPHQ mQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kvu888pte-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Nov 2022 07:49:46 +0000
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2AG7ZIYS027634;
        Wed, 16 Nov 2022 07:49:46 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kvu888psu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Nov 2022 07:49:45 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2AG7Ya6U007559;
        Wed, 16 Nov 2022 07:49:43 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma03ams.nl.ibm.com with ESMTP id 3kt348whn5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Nov 2022 07:49:43 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2AG7neEQ5046930
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Nov 2022 07:49:40 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1ED12A4054;
        Wed, 16 Nov 2022 07:49:40 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 77F38A405B;
        Wed, 16 Nov 2022 07:49:34 +0000 (GMT)
Received: from li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com (unknown [9.163.49.19])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 16 Nov 2022 07:49:34 +0000 (GMT)
Date:   Wed, 16 Nov 2022 08:49:30 +0100
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
Subject: mm: mmu_gather: do not expose delayed_rmap flag
Message-ID: <Y3SWCu6NRaMQ5dbD@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
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
X-Proofpoint-ORIG-GUID: 8D-4wtabBeM2LG6gv9fqfaZ3Dv8x0tqL
X-Proofpoint-GUID: zQZ6eeo8tYAkN8Iq8NdhOW-wDMbgabpc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-15_08,2022-11-15_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=845
 clxscore=1015 mlxscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 phishscore=0 lowpriorityscore=0 impostorscore=0 priorityscore=1501
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211160053
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Flag delayed_rmap of 'struct mmu_gather' is rather
a private member, but it is still accessed directly.
Instead, let the TLB gather code access the flag.

Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
---
 mm/memory.c     | 3 +--
 mm/mmu_gather.c | 3 +++
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 42f10cc1de58..38b58cd07b52 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1465,8 +1465,7 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 	/* Do the actual TLB flush before dropping ptl */
 	if (force_flush) {
 		tlb_flush_mmu_tlbonly(tlb);
-		if (tlb->delayed_rmap)
-			tlb_flush_rmaps(tlb, vma);
+		tlb_flush_rmaps(tlb, vma);
 	}
 	pte_unmap_unlock(start_pte, ptl);
 
diff --git a/mm/mmu_gather.c b/mm/mmu_gather.c
index 79de59136cd2..9f22309affee 100644
--- a/mm/mmu_gather.c
+++ b/mm/mmu_gather.c
@@ -60,6 +60,9 @@ void tlb_flush_rmaps(struct mmu_gather *tlb, struct vm_area_struct *vma)
 {
 	struct mmu_gather_batch *batch;
 
+	if (!tlb->delayed_rmap)
+		return;
+
 	batch = tlb->active;
 	for (int i = 0; i < batch->nr; i++) {
 		struct encoded_page *enc = batch->encoded_pages[i];
-- 
2.31.1

