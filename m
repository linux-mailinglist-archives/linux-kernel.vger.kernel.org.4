Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1FEA6287A9
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 19:00:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237933AbiKNR7x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 12:59:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237991AbiKNR7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 12:59:24 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC616275DB
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 09:59:22 -0800 (PST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.5) with ESMTP id 2AEHnud6000569;
        Mon, 14 Nov 2022 17:59:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=cfLDcdRa5huIH2E9S4lJSh5VrC9J1DCFVcQkJHec+xc=;
 b=B7SYTPB6B/TVg3oUxW3oV84VmZ8vReA8ANuwcpooG4UdqvCTFLRjyOegh6MnJ7YbFMDL
 vagiciBnlXspcNLI6HiUab11Ph5s4pKSMuQA7bpVLVNQoV8Iz0xkH96rBl5Gg1j+YOoQ
 iwFcLEES3jCoJQrScLka5nD8UtcZHJRTanIK4kXMVm0yif5iueG1HQJAyPcf7yGEoOKO
 6TrJ+GTrMorUaA3asu6eeaBVEiIGd7K2F77Z42C5UgFfmWptOcal0fhzfjU10uIcewVf
 MOt7IVXuz5Uzx08GCiqKVZagM/wV0HK5KXwazvy1OMhDinEmiUfyA8n2Icwbbtm93V/2 rQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kutdx061e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Nov 2022 17:59:04 +0000
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2AEHtJGN025850;
        Mon, 14 Nov 2022 17:59:03 GMT
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kutdx0601-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Nov 2022 17:59:03 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2AEHpnYQ012395;
        Mon, 14 Nov 2022 17:59:01 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma02fra.de.ibm.com with ESMTP id 3kt34925kh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Nov 2022 17:59:01 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2AEHwxNs6881806
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Nov 2022 17:58:59 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F045C11C04A;
        Mon, 14 Nov 2022 17:58:58 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9B0C911C050;
        Mon, 14 Nov 2022 17:58:53 +0000 (GMT)
Received: from li-c3569c4c-1ef8-11b2-a85c-ee139cda3133.ibm.com.com (unknown [9.43.116.246])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 14 Nov 2022 17:58:53 +0000 (GMT)
From:   Sathvika Vasireddy <sv@linux.ibm.com>
To:     linuxppc-dev@lists.ozlabs.org
Cc:     jpoimboe@redhat.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org, aik@ozlabs.ru, mpe@ellerman.id.au,
        mingo@redhat.com, christophe.leroy@csgroup.eu, rostedt@goodmis.org,
        mbenes@suse.cz, npiggin@gmail.com, chenzhongjin@huawei.com,
        naveen.n.rao@linux.vnet.ibm.com, sv@linux.ibm.com
Subject: [PATCH v6 04/16] powerpc: Curb objtool unannotated intra-function call warnings
Date:   Mon, 14 Nov 2022 23:27:42 +0530
Message-Id: <20221114175754.1131267-5-sv@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221114175754.1131267-1-sv@linux.ibm.com>
References: <20221114175754.1131267-1-sv@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: pI1s5BejsjcvYy6918G0qOdqntjP3gy0
X-Proofpoint-GUID: 7Q4jXcXCAvWiku5ujkc_R4PstgJDw5-9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-14_13,2022-11-11_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 mlxscore=0 mlxlogscore=999 priorityscore=1501 lowpriorityscore=0
 impostorscore=0 spamscore=0 bulkscore=0 adultscore=0 suspectscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211140125
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

objtool throws the following unannotated intra-function call warnings:
arch/powerpc/kernel/entry_64.o: warning: objtool: .text+0x4: unannotated intra-function call
arch/powerpc/kvm/book3s_hv_rmhandlers.o: warning: objtool: .text+0xe64: unannotated intra-function call
arch/powerpc/kvm/book3s_hv_rmhandlers.o: warning: objtool: .text+0xee4: unannotated intra-function call

Fix these warnings by annotating intra-function calls, using
ANNOTATE_INTRA_FUNCTION_CALL macro, to indicate that the branch targets
are valid.

Tested-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
Reviewed-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Sathvika Vasireddy <sv@linux.ibm.com>
---
 arch/powerpc/kernel/entry_64.S          | 2 ++
 arch/powerpc/kvm/book3s_hv_rmhandlers.S | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index 3e2e37e6ecab..1bf1121e17f1 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -14,6 +14,7 @@
  *  code, and exception/interrupt return code for PowerPC.
  */
 
+#include <linux/objtool.h>
 #include <linux/errno.h>
 #include <linux/err.h>
 #include <asm/cache.h>
@@ -73,6 +74,7 @@ flush_branch_caches:
 
 	// Flush the link stack
 	.rept 64
+	ANNOTATE_INTRA_FUNCTION_CALL
 	bl	.+4
 	.endr
 	b	1f
diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
index a69d36cbf43b..96b65b530156 100644
--- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
+++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
@@ -11,6 +11,7 @@
  */
 
 #include <linux/linkage.h>
+#include <linux/objtool.h>
 #include <asm/ppc_asm.h>
 #include <asm/code-patching-asm.h>
 #include <asm/kvm_asm.h>
@@ -1523,12 +1524,14 @@ kvm_flush_link_stack:
 
 	/* Flush the link stack. On Power8 it's up to 32 entries in size. */
 	.rept 32
+	ANNOTATE_INTRA_FUNCTION_CALL
 	bl	.+4
 	.endr
 
 	/* And on Power9 it's up to 64. */
 BEGIN_FTR_SECTION
 	.rept 32
+	ANNOTATE_INTRA_FUNCTION_CALL
 	bl	.+4
 	.endr
 END_FTR_SECTION_IFSET(CPU_FTR_ARCH_300)
-- 
2.31.1

