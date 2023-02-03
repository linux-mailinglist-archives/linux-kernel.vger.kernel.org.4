Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 045B168911D
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 08:42:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232461AbjBCHkr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 02:40:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232463AbjBCHke (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 02:40:34 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C09CE93E07;
        Thu,  2 Feb 2023 23:40:25 -0800 (PST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3137U10W028808;
        Fri, 3 Feb 2023 07:40:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=K0UhmP1F9ZlFA9OSI4ZHU52ngPm9Xi4QvjBfDFsjiWQ=;
 b=TKb2iDg/y8IyP7+aUuA1mTXGdpD7idcWpChbwKMaF3Zlfe/hi47R6yD8GJXfP/OfSaL9
 UdZtYVEiGYH8v39+HTUo/Mxo9GePLhw2Rgo6+cO7jpDPwUMF+sKERp1UiHnyh01y4rIY
 SxUAGDHD1X/G0p27KvBX+VfFY/86tjZvxOKu4es7+a+J3Xcn8bW1XZkAfdJrjv1Ea4ja
 t0Oy79l//9QQMu26dvVCc2dS4Xts2FZimsFcamoVrlAZfwLsus2uJT68ed7QGOYmP1Hr
 B5kFxJJAGU/r2l7lsJ1uS2JtZc2mhJ/ES/5mfokq8BCPBX/MfYNS9QSEiAaSHopHG9HV MQ== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ngwxdg7q1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Feb 2023 07:40:12 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3136xHhp014735;
        Fri, 3 Feb 2023 07:40:10 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3ncvtty3vg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Feb 2023 07:40:09 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3137e7SU16908882
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 3 Feb 2023 07:40:07 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2B87521445;
        Fri,  3 Feb 2023 07:40:07 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5B93021430;
        Fri,  3 Feb 2023 07:40:04 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Fri,  3 Feb 2023 07:40:04 +0000 (GMT)
From:   Alexander Egorenkov <egorenar@linux.ibm.com>
To:     wim@linux-watchdog.org, linux@roeck-us.net
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        hca@linux.ibm.com
Subject: [PATCH 2/5] watchdog: diag288_wdt: remove power management
Date:   Fri,  3 Feb 2023 08:39:55 +0100
Message-Id: <20230203073958.1585738-3-egorenar@linux.ibm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230203073958.1585738-1-egorenar@linux.ibm.com>
References: <20230203073958.1585738-1-egorenar@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: bvLEypXLprd-xXauJl0jXOPhuucVvsbG
X-Proofpoint-ORIG-GUID: bvLEypXLprd-xXauJl0jXOPhuucVvsbG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-03_04,2023-02-02_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 priorityscore=1501
 adultscore=0 spamscore=0 mlxscore=0 clxscore=1015 phishscore=0
 mlxlogscore=999 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2302030069
X-Spam-Status: No, score=-1.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,TVD_SUBJ_WIPE_DEBT
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove power management because s390 no longer supports hibernation since
commit 394216275c7d ("s390: remove broken hibernate / power management
support").

Reviewed-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Alexander Egorenkov <egorenar@linux.ibm.com>
---
 drivers/watchdog/diag288_wdt.c | 65 ++--------------------------------
 1 file changed, 2 insertions(+), 63 deletions(-)

diff --git a/drivers/watchdog/diag288_wdt.c b/drivers/watchdog/diag288_wdt.c
index 07ebbb709af4..c8d516ced6d2 100644
--- a/drivers/watchdog/diag288_wdt.c
+++ b/drivers/watchdog/diag288_wdt.c
@@ -27,7 +27,6 @@
 #include <linux/moduleparam.h>
 #include <linux/slab.h>
 #include <linux/watchdog.h>
-#include <linux/suspend.h>
 #include <asm/ebcdic.h>
 #include <asm/diag.h>
 #include <linux/io.h>
@@ -103,10 +102,6 @@ static int __diag288_lpar(unsigned int func, unsigned int timeout,
 	return __diag288(func, timeout, action, 0);
 }
 
-static unsigned long wdt_status;
-
-#define DIAG_WDOG_BUSY	0
-
 static int wdt_start(struct watchdog_device *dev)
 {
 	char *ebc_cmd;
@@ -114,15 +109,10 @@ static int wdt_start(struct watchdog_device *dev)
 	int ret;
 	unsigned int func;
 
-	if (test_and_set_bit(DIAG_WDOG_BUSY, &wdt_status))
-		return -EBUSY;
-
 	if (MACHINE_IS_VM) {
 		ebc_cmd = kmalloc(MAX_CMDLEN, GFP_KERNEL);
-		if (!ebc_cmd) {
-			clear_bit(DIAG_WDOG_BUSY, &wdt_status);
+		if (!ebc_cmd)
 			return -ENOMEM;
-		}
 		len = strlcpy(ebc_cmd, wdt_cmd, MAX_CMDLEN);
 		ASCEBC(ebc_cmd, MAX_CMDLEN);
 		EBC_TOUPPER(ebc_cmd, MAX_CMDLEN);
@@ -139,7 +129,6 @@ static int wdt_start(struct watchdog_device *dev)
 
 	if (ret) {
 		pr_err("The watchdog cannot be activated\n");
-		clear_bit(DIAG_WDOG_BUSY, &wdt_status);
 		return ret;
 	}
 	return 0;
@@ -152,8 +141,6 @@ static int wdt_stop(struct watchdog_device *dev)
 	diag_stat_inc(DIAG_STAT_X288);
 	ret = __diag288(WDT_FUNC_CANCEL, 0, 0, 0);
 
-	clear_bit(DIAG_WDOG_BUSY, &wdt_status);
-
 	return ret;
 }
 
@@ -222,45 +209,6 @@ static struct watchdog_device wdt_dev = {
 	.max_timeout = MAX_INTERVAL,
 };
 
-/*
- * It makes no sense to go into suspend while the watchdog is running.
- * Depending on the memory size, the watchdog might trigger, while we
- * are still saving the memory.
- */
-static int wdt_suspend(void)
-{
-	if (test_and_set_bit(DIAG_WDOG_BUSY, &wdt_status)) {
-		pr_err("Linux cannot be suspended while the watchdog is in use\n");
-		return notifier_from_errno(-EBUSY);
-	}
-	return NOTIFY_DONE;
-}
-
-static int wdt_resume(void)
-{
-	clear_bit(DIAG_WDOG_BUSY, &wdt_status);
-	return NOTIFY_DONE;
-}
-
-static int wdt_power_event(struct notifier_block *this, unsigned long event,
-			   void *ptr)
-{
-	switch (event) {
-	case PM_POST_HIBERNATION:
-	case PM_POST_SUSPEND:
-		return wdt_resume();
-	case PM_HIBERNATION_PREPARE:
-	case PM_SUSPEND_PREPARE:
-		return wdt_suspend();
-	default:
-		return NOTIFY_DONE;
-	}
-}
-
-static struct notifier_block wdt_power_notifier = {
-	.notifier_call = wdt_power_event,
-};
-
 static int __init diag288_init(void)
 {
 	int ret;
@@ -297,21 +245,12 @@ static int __init diag288_init(void)
 		return -EINVAL;
 	}
 
-	ret = register_pm_notifier(&wdt_power_notifier);
-	if (ret)
-		return ret;
-
-	ret = watchdog_register_device(&wdt_dev);
-	if (ret)
-		unregister_pm_notifier(&wdt_power_notifier);
-
-	return ret;
+	return watchdog_register_device(&wdt_dev);
 }
 
 static void __exit diag288_exit(void)
 {
 	watchdog_unregister_device(&wdt_dev);
-	unregister_pm_notifier(&wdt_power_notifier);
 }
 
 module_init(diag288_init);
-- 
2.37.2

