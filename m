Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79575674E7C
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 08:44:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230504AbjATHof (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 02:44:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230216AbjATHnv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 02:43:51 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59F68829B2;
        Thu, 19 Jan 2023 23:43:49 -0800 (PST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30K6biob022206;
        Fri, 20 Jan 2023 07:43:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=6OGClhRQ684WONO53FSabRo00ZX26Q62iyN9ttQk2xE=;
 b=E+0paSCDPJv/cvKdu2hZZQCOYHMqJ57xRagNFgJ2C2AbWeU84OoWCAdJ3NDY0P8H2si5
 riYMyxSys2thcPBgCYTZqTacdVWHDyGQC96QmlgEkzCQW5OscLbrmnD4ckdTR0Iz07iG
 u1rOYvWK9G8PpaN3xIos6Bw6YK6qj1PhfBRwgH8WRAmGSW6Wo5+xDeMcPyIo42eRL8uk
 1I1Q9wUKF13YbcXgAl8MfamF0m81OIFTGOY00WcWJqPuRXQRVPKrJ+b/vP+yqzpS3rdz
 k1nQX8mJ+0y86uznqzrtP+nH8G48NVQYiGiaoV09hnR1O9ad/usxWKxotPNxYKnx29fR CA== 
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3n7n6cswfk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Jan 2023 07:43:40 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30JN7s6v006911;
        Fri, 20 Jan 2023 07:43:37 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
        by ppma03fra.de.ibm.com (PPS) with ESMTPS id 3n3m16njxd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Jan 2023 07:43:37 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
        by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30K7hZb843057556
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Jan 2023 07:43:35 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3A6BE20063;
        Fri, 20 Jan 2023 07:43:35 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AEA502004D;
        Fri, 20 Jan 2023 07:43:34 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
        by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 20 Jan 2023 07:43:34 +0000 (GMT)
Received: from jarvis-ozlabs-ibm-com.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 12318606DB;
        Fri, 20 Jan 2023 18:43:30 +1100 (AEDT)
From:   Andrew Donnellan <ajd@linux.ibm.com>
To:     linuxppc-dev@lists.ozlabs.org, linux-integrity@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, gcwilson@linux.ibm.com,
        linux-kernel@vger.kernel.org, nayna@linux.ibm.com,
        ruscur@russell.cc, zohar@linux.ibm.com, mpe@ellerman.id.au,
        gjoyce@linux.ibm.com, sudhakar@linux.ibm.com, bgray@linux.ibm.com,
        erichte@linux.ibm.com, joel@jms.id.au
Subject: [PATCH v4 13/24] powerpc/pseries: Move plpks.h to include directory
Date:   Fri, 20 Jan 2023 18:42:55 +1100
Message-Id: <20230120074306.1326298-14-ajd@linux.ibm.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230120074306.1326298-1-ajd@linux.ibm.com>
References: <20230120074306.1326298-1-ajd@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: BAxAJu5nTwDvSNIooTnDNNuJvF3WbYY-
X-Proofpoint-ORIG-GUID: BAxAJu5nTwDvSNIooTnDNNuJvF3WbYY-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-20_04,2023-01-19_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 priorityscore=1501 mlxscore=0 phishscore=0 mlxlogscore=999 suspectscore=0
 spamscore=0 impostorscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301200070
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Russell Currey <ruscur@russell.cc>

Move plpks.h from platforms/pseries/ to include/asm/. This is necessary
for later patches to make use of the PLPKS from code in other subsystems.

Signed-off-by: Russell Currey <ruscur@russell.cc>
Signed-off-by: Andrew Donnellan <ajd@linux.ibm.com>

---

v3: New patch
---
 .../powerpc/{platforms/pseries => include/asm}/plpks.h | 10 +++++++---
 arch/powerpc/platforms/pseries/plpks.c                 |  3 +--
 2 files changed, 8 insertions(+), 5 deletions(-)
 rename arch/powerpc/{platforms/pseries => include/asm}/plpks.h (89%)

diff --git a/arch/powerpc/platforms/pseries/plpks.h b/arch/powerpc/include/asm/plpks.h
similarity index 89%
rename from arch/powerpc/platforms/pseries/plpks.h
rename to arch/powerpc/include/asm/plpks.h
index 275ccd86bfb5..8295502ee93b 100644
--- a/arch/powerpc/platforms/pseries/plpks.h
+++ b/arch/powerpc/include/asm/plpks.h
@@ -6,8 +6,10 @@
  * Platform keystore for pseries LPAR(PLPKS).
  */
 
-#ifndef _PSERIES_PLPKS_H
-#define _PSERIES_PLPKS_H
+#ifndef _ASM_POWERPC_PLPKS_H
+#define _ASM_POWERPC_PLPKS_H
+
+#ifdef CONFIG_PSERIES_PLPKS
 
 #include <linux/types.h>
 #include <linux/list.h>
@@ -68,4 +70,6 @@ int plpks_read_fw_var(struct plpks_var *var);
  */
 int plpks_read_bootloader_var(struct plpks_var *var);
 
-#endif
+#endif // CONFIG_PSERIES_PLPKS
+
+#endif // _ASM_POWERPC_PLPKS_H
diff --git a/arch/powerpc/platforms/pseries/plpks.c b/arch/powerpc/platforms/pseries/plpks.c
index a01cf2ff140a..13e6daadb179 100644
--- a/arch/powerpc/platforms/pseries/plpks.c
+++ b/arch/powerpc/platforms/pseries/plpks.c
@@ -18,8 +18,7 @@
 #include <linux/types.h>
 #include <asm/hvcall.h>
 #include <asm/machdep.h>
-
-#include "plpks.h"
+#include <asm/plpks.h>
 
 #define PKS_FW_OWNER	     0x1
 #define PKS_BOOTLOADER_OWNER 0x2
-- 
2.39.0

