Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78557689112
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 08:42:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232409AbjBCHkm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 02:40:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232448AbjBCHke (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 02:40:34 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 490B693AFB;
        Thu,  2 Feb 2023 23:40:25 -0800 (PST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3136lQTI030471;
        Fri, 3 Feb 2023 07:40:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=BLULaKn6GLPcrMBfU9548ZtcKlLiJ/Gqk2e69uSWn0o=;
 b=QmV90DHDUcUiwmSaS6UCoRWWBok1OgshuwFJtzLETCUp1PZHFXC/twAHp/ehMUk0zvr2
 5sSlzRqnw9ZJZiyKKX4FylnEObD+yaQh3ZxWyIhke2gQUikoMTRExW5ADurukG2ANsNy
 dJye06MMzb43fvwjA2bfV6y+eOcwKpVdMN4kJc3kNVsS5d5+9Ow3RAWbCicSryb3tnrl
 AGWOaixBvjX1FcmfbQtvWYwkc2GRKLyoh00c+sK08ANKztHUUBwPekQeO0Rj1BtK9jzC
 4omDLGu7jtYcFRF/sYiFuJYiQVfKC4JxPLrckhK+qlMpbni9vDx8UpMx3KAlhFO8cVGk kg== 
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3ngvkyj33n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Feb 2023 07:40:11 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 312DUkrD013066;
        Fri, 3 Feb 2023 07:40:10 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma06fra.de.ibm.com (PPS) with ESMTPS id 3ncvugn3cy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Feb 2023 07:40:09 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3137e7w419596018
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 3 Feb 2023 07:40:07 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 441D121423;
        Fri,  3 Feb 2023 07:40:07 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7A5D221431;
        Fri,  3 Feb 2023 07:40:04 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Fri,  3 Feb 2023 07:40:04 +0000 (GMT)
From:   Alexander Egorenkov <egorenar@linux.ibm.com>
To:     wim@linux-watchdog.org, linux@roeck-us.net
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        hca@linux.ibm.com
Subject: [PATCH 3/5] watchdog: diag288_wdt: unify command buffer handling for diag288 zvm
Date:   Fri,  3 Feb 2023 08:39:56 +0100
Message-Id: <20230203073958.1585738-4-egorenar@linux.ibm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230203073958.1585738-1-egorenar@linux.ibm.com>
References: <20230203073958.1585738-1-egorenar@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: WWNRe_oUxcoYQIf0tgAXJ9SDaU_v6Dnc
X-Proofpoint-ORIG-GUID: WWNRe_oUxcoYQIf0tgAXJ9SDaU_v6Dnc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-03_04,2023-02-02_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 mlxscore=0 adultscore=0
 impostorscore=0 priorityscore=1501 clxscore=1015 spamscore=0 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302030069
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simplify and de-duplicate code by introducing a common single command
buffer allocated once at initialization. Moreover, simplify the interface
of __diag288_vm() by accepting ASCII strings as the command parameter
and converting it to the EBCDIC format within the function itself.

Reviewed-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Alexander Egorenkov <egorenar@linux.ibm.com>
---
 drivers/watchdog/diag288_wdt.c | 55 +++++++++++++---------------------
 1 file changed, 20 insertions(+), 35 deletions(-)

diff --git a/drivers/watchdog/diag288_wdt.c b/drivers/watchdog/diag288_wdt.c
index c8d516ced6d2..c717f47dd4c3 100644
--- a/drivers/watchdog/diag288_wdt.c
+++ b/drivers/watchdog/diag288_wdt.c
@@ -69,6 +69,8 @@ MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default = C
 
 MODULE_ALIAS("vmwatchdog");
 
+static char *cmd_buf;
+
 static int __diag288(unsigned int func, unsigned int timeout,
 		     unsigned long action, unsigned int len)
 {
@@ -88,11 +90,18 @@ static int __diag288(unsigned int func, unsigned int timeout,
 	return err;
 }
 
-static int __diag288_vm(unsigned int  func, unsigned int timeout,
-			char *cmd, size_t len)
+static int __diag288_vm(unsigned int  func, unsigned int timeout, char *cmd)
 {
+	ssize_t len;
+
+	len = strscpy(cmd_buf, cmd, MAX_CMDLEN);
+	if (len < 0)
+		return len;
+	ASCEBC(cmd_buf, MAX_CMDLEN);
+	EBC_TOUPPER(cmd_buf, MAX_CMDLEN);
+
 	diag_stat_inc(DIAG_STAT_X288);
-	return __diag288(func, timeout, virt_to_phys(cmd), len);
+	return __diag288(func, timeout, virt_to_phys(cmd_buf), len);
 }
 
 static int __diag288_lpar(unsigned int func, unsigned int timeout,
@@ -104,24 +113,14 @@ static int __diag288_lpar(unsigned int func, unsigned int timeout,
 
 static int wdt_start(struct watchdog_device *dev)
 {
-	char *ebc_cmd;
-	size_t len;
 	int ret;
 	unsigned int func;
 
 	if (MACHINE_IS_VM) {
-		ebc_cmd = kmalloc(MAX_CMDLEN, GFP_KERNEL);
-		if (!ebc_cmd)
-			return -ENOMEM;
-		len = strlcpy(ebc_cmd, wdt_cmd, MAX_CMDLEN);
-		ASCEBC(ebc_cmd, MAX_CMDLEN);
-		EBC_TOUPPER(ebc_cmd, MAX_CMDLEN);
-
 		func = conceal_on ? (WDT_FUNC_INIT | WDT_FUNC_CONCEAL)
 			: WDT_FUNC_INIT;
-		ret = __diag288_vm(func, dev->timeout, ebc_cmd, len);
+		ret = __diag288_vm(func, dev->timeout, wdt_cmd);
 		WARN_ON(ret != 0);
-		kfree(ebc_cmd);
 	} else {
 		ret = __diag288_lpar(WDT_FUNC_INIT,
 				     dev->timeout, LPARWDT_RESTART);
@@ -146,19 +145,10 @@ static int wdt_stop(struct watchdog_device *dev)
 
 static int wdt_ping(struct watchdog_device *dev)
 {
-	char *ebc_cmd;
-	size_t len;
 	int ret;
 	unsigned int func;
 
 	if (MACHINE_IS_VM) {
-		ebc_cmd = kmalloc(MAX_CMDLEN, GFP_KERNEL);
-		if (!ebc_cmd)
-			return -ENOMEM;
-		len = strlcpy(ebc_cmd, wdt_cmd, MAX_CMDLEN);
-		ASCEBC(ebc_cmd, MAX_CMDLEN);
-		EBC_TOUPPER(ebc_cmd, MAX_CMDLEN);
-
 		/*
 		 * It seems to be ok to z/VM to use the init function to
 		 * retrigger the watchdog. On LPAR WDT_FUNC_CHANGE must
@@ -167,9 +157,8 @@ static int wdt_ping(struct watchdog_device *dev)
 		func = conceal_on ? (WDT_FUNC_INIT | WDT_FUNC_CONCEAL)
 			: WDT_FUNC_INIT;
 
-		ret = __diag288_vm(func, dev->timeout, ebc_cmd, len);
+		ret = __diag288_vm(func, dev->timeout, wdt_cmd);
 		WARN_ON(ret != 0);
-		kfree(ebc_cmd);
 	} else {
 		ret = __diag288_lpar(WDT_FUNC_CHANGE, dev->timeout, 0);
 	}
@@ -212,25 +201,20 @@ static struct watchdog_device wdt_dev = {
 static int __init diag288_init(void)
 {
 	int ret;
-	char ebc_begin[] = {
-		194, 197, 199, 201, 213
-	};
-	char *ebc_cmd;
 
 	watchdog_set_nowayout(&wdt_dev, nowayout_info);
 
 	if (MACHINE_IS_VM) {
-		ebc_cmd = kmalloc(sizeof(ebc_begin), GFP_KERNEL);
-		if (!ebc_cmd) {
+		cmd_buf = kmalloc(MAX_CMDLEN, GFP_KERNEL);
+		if (!cmd_buf) {
 			pr_err("The watchdog cannot be initialized\n");
 			return -ENOMEM;
 		}
-		memcpy(ebc_cmd, ebc_begin, sizeof(ebc_begin));
-		ret = __diag288_vm(WDT_FUNC_INIT, 15,
-				   ebc_cmd, sizeof(ebc_begin));
-		kfree(ebc_cmd);
+
+		ret = __diag288_vm(WDT_FUNC_INIT, MIN_INTERVAL, "BEGIN");
 		if (ret != 0) {
 			pr_err("The watchdog cannot be initialized\n");
+			kfree(cmd_buf);
 			return -EINVAL;
 		}
 	} else {
@@ -251,6 +235,7 @@ static int __init diag288_init(void)
 static void __exit diag288_exit(void)
 {
 	watchdog_unregister_device(&wdt_dev);
+	kfree(cmd_buf);
 }
 
 module_init(diag288_init);
-- 
2.37.2

