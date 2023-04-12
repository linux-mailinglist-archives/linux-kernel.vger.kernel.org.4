Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2706C6E00E1
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 23:30:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbjDLVaw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 17:30:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjDLVat (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 17:30:49 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EBA393DE;
        Wed, 12 Apr 2023 14:30:23 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33CJTWAB007793;
        Wed, 12 Apr 2023 21:29:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : mime-version : content-transfer-encoding;
 s=corp-2023-03-30; bh=bXdrSJqSpeC4V4Q0x3boHlrCc8/cule5AASS6t5grGE=;
 b=CpO6OHCajrI0WUVal1n9Ba/30Oyk+t6xOfwfMan1V+X/22fSPQOCFvQNtQQCMaTrqopF
 +4bf/DmxgpFMr1Gvs6vpw1X+VS5CBVTk3KV6yS9JKvzmRe9pG/qg+UP/CG2KMOx+ZfTv
 oFDlOcj5j3GOCnWanc+GWiQgcLIB5DRAudkPVjrIGhaBCHdF3DtyDlyLHPFfA7FL5Eg0
 qKW6pTNj615zz3xSnPwFPTGbCYrWthTmoi8/HuatpGbKf19gWIc4UKv49PBTV34NQy7r
 kQngQGEG2CaPW6MVBlZ0n6OMF0/WTVOtY1Q/yDTHvu3W7Pl76DCtI6XASxvaf2+cFpPh 2w== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pu0etscn0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Apr 2023 21:29:56 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33CKatV3012630;
        Wed, 12 Apr 2023 21:29:54 GMT
Received: from brm-x62-22.us.oracle.com (brm-x62-22.us.oracle.com [10.80.150.48])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3puwe9rak4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 12 Apr 2023 21:29:54 +0000
From:   Henry Willard <henry.willard@oracle.com>
To:     tsbogend@alpha.franken.de, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] MIPS: Don't clear _PAGE_SPECIAL in _PAGE_CHG_MASK
Date:   Wed, 12 Apr 2023 15:29:53 -0600
Message-Id: <20230412212953.388185-1-henry.willard@oracle.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-12_12,2023-04-12_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 adultscore=0 spamscore=0 suspectscore=0 bulkscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304120183
X-Proofpoint-GUID: 2_Y7AlEXgNk-dEm2slUp1j_nW3Jx5VIL
X-Proofpoint-ORIG-GUID: 2_Y7AlEXgNk-dEm2slUp1j_nW3Jx5VIL
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the special case where

	p = mmap(NULL, ALLOC_SIZE, PROT_READ,
                MAP_PRIVATE | MAP_ANONYMOUS | MAP_POPULATE, -1, 0);

is followed by

	rc = mprotect(p, ALLOC_SIZE, PROT_NONE);

the _PAGE_SPECIAL bit in the page tables will be cleared by
mistake and the later unmapped operations will incorrectly
modify the struct page for the the zero page. This sequence
occurs in the madvise05 test of the Linux Test Project
suite of tests.

This was discovered while testing an older version of the kernel
(5.4.17) on a MIPS device. Unfortunately, support for this device
is not available in newer kernels, so I can't test this with the
latest Linux kernel code. It looks like the problem exists in
newer kernels, but I can't verify it. Except for the LTP test,
this sequence of calls is probably not common.

Passing it along in the hope it will be useful to someone.

Signed-off-by: Henry Willard <henry.willard@oracle.com>
---
 arch/mips/include/asm/pgtable-bits.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/pgtable-bits.h b/arch/mips/include/asm/pgtable-bits.h
index 2362842ee2b5..1c576679aa87 100644
--- a/arch/mips/include/asm/pgtable-bits.h
+++ b/arch/mips/include/asm/pgtable-bits.h
@@ -280,6 +280,7 @@ static inline uint64_t pte_to_entrylo(unsigned long pte_val)
 #define __WRITEABLE	(_PAGE_SILENT_WRITE | _PAGE_WRITE | _PAGE_MODIFIED)
 
 #define _PAGE_CHG_MASK	(_PAGE_ACCESSED | _PAGE_MODIFIED |	\
-			 _PAGE_SOFT_DIRTY | _PFN_MASK | _CACHE_MASK)
+			 _PAGE_SOFT_DIRTY | _PFN_MASK |   \
+			 _CACHE_MASK | _PAGE_SPECIAL)
 
 #endif /* _ASM_PGTABLE_BITS_H */
-- 
2.31.1

