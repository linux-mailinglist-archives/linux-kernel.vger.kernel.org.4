Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BED7869F0D8
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 10:02:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231508AbjBVJCk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 04:02:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230457AbjBVJCi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 04:02:38 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F83334F49
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 01:02:33 -0800 (PST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31M8QXUq027042;
        Wed, 22 Feb 2023 09:02:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=Wcw5U9usVW0jSpUTwgc+fcPdSplu62KQeKvS/wONcM8=;
 b=pbHHtrECsXb9y2BUnOMKh1X9REHJK02Zx8DjXES8efOlWFlTllOLHtBVtBik/Qn9R0Cl
 Itawjj7+onswD5JPLBr+B8bVyoBjQmHavk1y94M/tmfhhg7vaAc84p2AGtbCn+5j3SqO
 HBw7467JMun2EAzm3SLP8uR+EKN5deZYx+WYQkdDKoBluI5Ad61VL4Fw2YXdqC/Zcygw
 tE/gzJArsiFji4/QHh8Q+LAvS1VDQMMWMbTIxm1Y5RuR53ZfasqxLF2kwLPNbFdKwpiM
 Hsa6RJfmSILefiTmvd2XqNbXd6/jJ+QU8QqNHPnW182TXCvWIR/Zz5aK/1Eq3SrhH9IL 7g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nwfhvgsns-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Feb 2023 09:02:23 +0000
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 31M8bVc9001222;
        Wed, 22 Feb 2023 09:02:22 GMT
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nwfhvgs6s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Feb 2023 09:02:22 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 31LDHs8u020937;
        Wed, 22 Feb 2023 09:01:27 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma01fra.de.ibm.com (PPS) with ESMTPS id 3ntpa6buq6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Feb 2023 09:01:26 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 31M91O6226280682
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Feb 2023 09:01:24 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5CDA12004B;
        Wed, 22 Feb 2023 09:01:23 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5C24F20040;
        Wed, 22 Feb 2023 09:01:20 +0000 (GMT)
Received: from li-a450e7cc-27df-11b2-a85c-b5a9ac31e8ef.ibm.com (unknown [9.43.123.148])
        by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 22 Feb 2023 09:01:19 +0000 (GMT)
From:   Kautuk Consul <kconsul@linux.vnet.ibm.com>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Rohan McLure <rmclure@linux.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Kautuk Consul <kconsul@linux.vnet.ibm.com>
Subject: [PATCH] arch/powerpc/include/asm/barrier.h: redefine rmb and wmb to lwsync
Date:   Wed, 22 Feb 2023 14:31:12 +0530
Message-Id: <20230222090112.187583-1-kconsul@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: QSyD09S1KL2OukIdwsFLPU76kYkEd2ei
X-Proofpoint-ORIG-GUID: zGfMT4bp9Ocw1RK_BS4iUcheaR5QJK7k
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-22_04,2023-02-20_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0
 mlxlogscore=774 impostorscore=0 mlxscore=0 bulkscore=0 priorityscore=1501
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302220078
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A link from ibm.com states:
"Ensures that all instructions preceding the call to __lwsync
 complete before any subsequent store instructions can be executed
 on the processor that executed the function. Also, it ensures that
 all load instructions preceding the call to __lwsync complete before
 any subsequent load instructions can be executed on the processor
 that executed the function. This allows you to synchronize between
 multiple processors with minimal performance impact, as __lwsync
 does not wait for confirmation from each processor."

Thats why smp_rmb() and smp_wmb() are defined to lwsync.
But this same understanding applies to parallel pipeline
execution on each PowerPC processor.
So, use the lwsync instruction for rmb() and wmb() on the PPC
architectures that support it.

Also removed some useless spaces.

Signed-off-by: Kautuk Consul <kconsul@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/barrier.h | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/barrier.h b/arch/powerpc/include/asm/barrier.h
index e80b2c0e9315..553f5a5d20bd 100644
--- a/arch/powerpc/include/asm/barrier.h
+++ b/arch/powerpc/include/asm/barrier.h
@@ -41,11 +41,17 @@
 
 /* The sub-arch has lwsync */
 #if defined(CONFIG_PPC64) || defined(CONFIG_PPC_E500MC)
-#    define SMPWMB      LWSYNC
+#undef rmb
+#undef wmb
+/* Redefine rmb() to lwsync. */
+#define rmb()	({__asm__ __volatile__ ("lwsync" : : : "memory"); })
+/* Redefine wmb() to lwsync. */
+#define wmb()	({__asm__ __volatile__ ("lwsync" : : : "memory"); })
+#define SMPWMB      LWSYNC
 #elif defined(CONFIG_BOOKE)
-#    define SMPWMB      mbar
+#define SMPWMB      mbar
 #else
-#    define SMPWMB      eieio
+#define SMPWMB      eieio
 #endif
 
 /* clang defines this macro for a builtin, which will not work with runtime patching */
-- 
2.31.1

