Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 645B469F0E0
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 10:04:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231430AbjBVJEJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 04:04:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230454AbjBVJEI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 04:04:08 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DA542A15B
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 01:04:06 -0800 (PST)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31M7C5ZR040585;
        Wed, 22 Feb 2023 09:03:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=cxrO0BbDUH2tKiBBxpepRQ4gxOgG7/PBThZqAEqGpYE=;
 b=CgOf7IN29BzgdNz0ntpQ+BYARIaJMWYCPwNI5UYqWUok0+xlQ2CfvV2hxXDVa3Y9v7jH
 dCd+awsEIxeTeqDHchootYVV99wxhjoSlGSPvYSOQyv8Xwmgo30y1SKkzt/Y4VaOmGr0
 lHXCcW1pRZl5xPqLjwLb7Aq/B2pyQWwfm8aM1caCLn6+0pilcerZuz1/m/s+VjObXPi8
 ayGFsqarED3S5BOAouEQs28sL25tYj56uNcKyUJkjVaxuUBGRLRUN4BVChzCsWqDgrU3
 pKR7EPqL8anURG+plfYFt9fCrpieVwTOPFWGtEhQv/aC56qBcdDJVBzBiWNuiXAAa+Up VA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nweesap5r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Feb 2023 09:03:59 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 31M8uvaj024487;
        Wed, 22 Feb 2023 09:03:58 GMT
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nweesap4r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Feb 2023 09:03:58 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 31LClhdQ031888;
        Wed, 22 Feb 2023 09:03:56 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma05fra.de.ibm.com (PPS) with ESMTPS id 3ntpa6busf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Feb 2023 09:03:55 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 31M93rIx50266414
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Feb 2023 09:03:53 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7ACD82004B;
        Wed, 22 Feb 2023 09:03:53 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 67E0920043;
        Wed, 22 Feb 2023 09:03:50 +0000 (GMT)
Received: from li-a450e7cc-27df-11b2-a85c-b5a9ac31e8ef.ibm.com (unknown [9.43.123.148])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 22 Feb 2023 09:03:50 +0000 (GMT)
From:   Kautuk Consul <kconsul@linux.vnet.ibm.com>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Rohan McLure <rmclure@linux.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Kautuk Consul <kconsul@linux.vnet.ibm.com>
Subject: [PATCH v2] arch/powerpc/include/asm/barrier.h: redefine rmb and wmb to  lwsync
Date:   Wed, 22 Feb 2023 14:33:44 +0530
Message-Id: <20230222090344.189270-1-kconsul@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: NaYc2lZZu0jJ8X5W3gtlCbMrNFeQnFkQ
X-Proofpoint-GUID: H6girN4eq9gcI0GUR15wgtr31GAK9Iij
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-22_04,2023-02-20_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 suspectscore=0 priorityscore=1501 bulkscore=0 adultscore=0 mlxlogscore=837
 mlxscore=0 malwarescore=0 clxscore=1015 phishscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302220078
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

Signed-off-by: Kautuk Consul <kconsul@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/barrier.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/powerpc/include/asm/barrier.h b/arch/powerpc/include/asm/barrier.h
index b95b666f0374..e088dacc0ee8 100644
--- a/arch/powerpc/include/asm/barrier.h
+++ b/arch/powerpc/include/asm/barrier.h
@@ -36,8 +36,15 @@
  * heavy-weight sync, so smp_wmb() can be a lighter-weight eieio.
  */
 #define __mb()   __asm__ __volatile__ ("sync" : : : "memory")
+
+/* The sub-arch has lwsync. */
+#if defined(CONFIG_PPC64) || defined(CONFIG_PPC_E500MC)
+#define __rmb() __asm__ __volatile__ ("lwsync" : : : "memory")
+#define __wmb() __asm__ __volatile__ ("lwsync" : : : "memory")
+#else
 #define __rmb()  __asm__ __volatile__ ("sync" : : : "memory")
 #define __wmb()  __asm__ __volatile__ ("sync" : : : "memory")
+#endif
 
 /* The sub-arch has lwsync */
 #if defined(CONFIG_PPC64) || defined(CONFIG_PPC_E500MC)
-- 
2.31.1

