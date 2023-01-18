Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B953F671428
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 07:31:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbjARG34 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 01:29:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjARGW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 01:22:29 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65E5E4E503;
        Tue, 17 Jan 2023 22:11:28 -0800 (PST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30I53Z1M015897;
        Wed, 18 Jan 2023 06:11:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=NbAGOkJyKTdzGBUpPMnKfY++xIugD/a7G/Z7957aSpQ=;
 b=kF0uXYNPWlFkxgF6my4vekuw5ZTt+xnwFLJW3MzsQPn1hoDYaPu9+zJ+tI5c/OHGY0fV
 AjawqG9JgBu1CQepciyLg+a4f5lsN2FdymCznyxAPpaXqGpyaf8S5a0BwpMdNGCTDh7m
 Q8tmxV4e1MNhKoRFX84GYq7YhjO3qTY1t+7vp8Ssfee3Wj9xDks/4frpFu3+fabm2n0e
 sxthGsE0ZWy9Ew+jA4yRjbw7suV2p0PuMfiTcuQAomGbU9ByKPcFU2yArwrbFwJEA4/V
 ahNe9U4ZpgHjDZS0SYuljf1ERmBNOSzzelwWQ0UGN1Q0mTAGGLWyXrY1c/aDz3WPV9lH vg== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3n6a9ph6x5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Jan 2023 06:11:19 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30HNFFDG007008;
        Wed, 18 Jan 2023 06:11:18 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
        by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3n3knfmtkm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Jan 2023 06:11:18 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30I6BFUL50790782
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Jan 2023 06:11:15 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A43BB20040;
        Wed, 18 Jan 2023 06:11:15 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2884820043;
        Wed, 18 Jan 2023 06:11:15 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 18 Jan 2023 06:11:15 +0000 (GMT)
Received: from jarvis-ozlabs-ibm-com.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 8EDF56097C;
        Wed, 18 Jan 2023 17:11:08 +1100 (AEDT)
From:   Andrew Donnellan <ajd@linux.ibm.com>
To:     linuxppc-dev@lists.ozlabs.org, linux-integrity@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, gcwilson@linux.ibm.com,
        linux-kernel@vger.kernel.org, nayna@linux.ibm.com,
        ruscur@russell.cc, zohar@linux.ibm.com, mpe@ellerman.id.au,
        gjoyce@linux.ibm.com, sudhakar@linux.ibm.com, bgray@linux.ibm.com,
        erichte@linux.ibm.com
Subject: [PATCH v3 20/24] powerpc/pseries: Add helpers to get PLPKS password
Date:   Wed, 18 Jan 2023 17:10:45 +1100
Message-Id: <20230118061049.1006141-21-ajd@linux.ibm.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230118061049.1006141-1-ajd@linux.ibm.com>
References: <20230118061049.1006141-1-ajd@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: BOXolXkxoR4OCsa-PnXtg5y54IYkBD2d
X-Proofpoint-ORIG-GUID: BOXolXkxoR4OCsa-PnXtg5y54IYkBD2d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-18_01,2023-01-17_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 mlxscore=0 phishscore=0 malwarescore=0 adultscore=0
 clxscore=1015 priorityscore=1501 impostorscore=0 spamscore=0
 mlxlogscore=748 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2301180051
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Russell Currey <ruscur@russell.cc>

Add helper functions to get the PLPKS password. This will be used in a
later patch to support passing the password between kernels over kexec.

Signed-off-by: Russell Currey <ruscur@russell.cc>
Signed-off-by: Andrew Donnellan <ajd@linux.ibm.com>

---

v3: New patch
---
 arch/powerpc/include/asm/plpks.h       | 11 +++++++++++
 arch/powerpc/platforms/pseries/plpks.c | 10 ++++++++++
 2 files changed, 21 insertions(+)

diff --git a/arch/powerpc/include/asm/plpks.h b/arch/powerpc/include/asm/plpks.h
index 0c49969b0864..08355c89f5fd 100644
--- a/arch/powerpc/include/asm/plpks.h
+++ b/arch/powerpc/include/asm/plpks.h
@@ -171,6 +171,17 @@ u32 plpks_get_maxlargeobjectsize(void);
  */
 u64 plpks_get_signedupdatealgorithms(void);
 
+/**
+ * Returns the PLPKS password generated by the hypervisor.
+ * Should only be used to prepare a different OS to use the PLPKS, i.e. kexec.
+ */
+u8 *plpks_get_password(void);
+
+/**
+ * Returns the length of the PLPKS password in bytes.
+ */
+u16 plpks_get_passwordlen(void);
+
 #endif // CONFIG_PSERIES_PLPKS
 
 #endif // _ASM_POWERPC_PLPKS_H
diff --git a/arch/powerpc/platforms/pseries/plpks.c b/arch/powerpc/platforms/pseries/plpks.c
index 5d9c6a3b2014..b3c7410a4f13 100644
--- a/arch/powerpc/platforms/pseries/plpks.c
+++ b/arch/powerpc/platforms/pseries/plpks.c
@@ -359,6 +359,16 @@ u64 plpks_get_signedupdatealgorithms(void)
 	return signedupdatealgorithms;
 }
 
+u8 *plpks_get_password(void)
+{
+	return ospassword;
+}
+
+u16 plpks_get_passwordlen(void)
+{
+	return ospasswordlength;
+}
+
 bool plpks_is_available(void)
 {
 	int rc;
-- 
2.39.0

