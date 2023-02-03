Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B318689114
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 08:42:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232542AbjBCHkz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 02:40:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232392AbjBCHke (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 02:40:34 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 291AF93E08;
        Thu,  2 Feb 2023 23:40:25 -0800 (PST)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31370nHu015928;
        Fri, 3 Feb 2023 07:40:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=tIvJlJrYU4Flf0lu2LlXiqfJqpjr0G6K3AKhGGPmAVs=;
 b=n92bHkMC6MzB/nXIOfHWT1pcrEjXAwJyQ8KJiD9DbNUCKSnd4z9gkQ9zQJHWB99Wmjcp
 F350SJJ1FTq7WZyPuzPhoucgZtpVY+kjG60Xd9tIzky/93bBewLWlGVjQVnJYPhPJh6z
 PNNCh0xqgmuDq34TtJKJYq35VhzgjAXi0vMGOslaHqU3IwdHCMMk7u6yYp/YUNMy9ok5
 Z7uOBLUwSSm3duDySAyq0NFNMMiSoefttNB5iWeHDXJVP+fzb9PdXz4X3TwQiMEBQmS/
 yPsA5hZ4aS8m3UyJ1566DfXSckxCOq2p1R5+46zoozb8t73CaWtxsUyk4GLlFXHjPLhF 8Q== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ngwgeguh5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Feb 2023 07:40:12 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3136xHho014735;
        Fri, 3 Feb 2023 07:40:10 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3ncvtty3vf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Feb 2023 07:40:09 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3137e7Qj22282850
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 3 Feb 2023 07:40:07 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2136821426;
        Fri,  3 Feb 2023 07:40:07 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B75F621435;
        Fri,  3 Feb 2023 07:40:04 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Fri,  3 Feb 2023 07:40:04 +0000 (GMT)
From:   Alexander Egorenkov <egorenar@linux.ibm.com>
To:     wim@linux-watchdog.org, linux@roeck-us.net
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        hca@linux.ibm.com
Subject: [PATCH 5/5] watchdog: diag288_wdt: unify lpar and zvm diag288 helpers
Date:   Fri,  3 Feb 2023 08:39:58 +0100
Message-Id: <20230203073958.1585738-6-egorenar@linux.ibm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230203073958.1585738-1-egorenar@linux.ibm.com>
References: <20230203073958.1585738-1-egorenar@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Lff_S4qLoP8GXhEN0LtVG907S7o0xdIU
X-Proofpoint-GUID: Lff_S4qLoP8GXhEN0LtVG907S7o0xdIU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-03_04,2023-02-02_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=990 phishscore=0
 spamscore=0 lowpriorityscore=0 impostorscore=0 mlxscore=0 malwarescore=0
 priorityscore=1501 adultscore=0 bulkscore=0 clxscore=1015 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302030069
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change naming of the internal diag288 helper functions
to improve overall readability and reduce confusion:
* Rename __diag288() to diag288().
* Get rid of the misnamed helper __diag288_lpar() that was used not only
  on LPARs but also zVM and KVM systems.
* Rename __diag288_vm() to diag288_str().

Reviewed-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Alexander Egorenkov <egorenar@linux.ibm.com>
---
 drivers/watchdog/diag288_wdt.c | 32 +++++++++++++-------------------
 1 file changed, 13 insertions(+), 19 deletions(-)

diff --git a/drivers/watchdog/diag288_wdt.c b/drivers/watchdog/diag288_wdt.c
index a29ad164b27a..4631d0a3866a 100644
--- a/drivers/watchdog/diag288_wdt.c
+++ b/drivers/watchdog/diag288_wdt.c
@@ -71,8 +71,8 @@ MODULE_ALIAS("vmwatchdog");
 
 static char *cmd_buf;
 
-static int __diag288(unsigned int func, unsigned int timeout,
-		     unsigned long action, unsigned int len)
+static int diag288(unsigned int func, unsigned int timeout,
+		   unsigned long action, unsigned int len)
 {
 	union register_pair r1 = { .even = func, .odd = timeout, };
 	union register_pair r3 = { .even = action, .odd = len, };
@@ -92,7 +92,7 @@ static int __diag288(unsigned int func, unsigned int timeout,
 	return err;
 }
 
-static int __diag288_vm(unsigned int  func, unsigned int timeout, char *cmd)
+static int diag288_str(unsigned int func, unsigned int timeout, char *cmd)
 {
 	ssize_t len;
 
@@ -102,13 +102,7 @@ static int __diag288_vm(unsigned int  func, unsigned int timeout, char *cmd)
 	ASCEBC(cmd_buf, MAX_CMDLEN);
 	EBC_TOUPPER(cmd_buf, MAX_CMDLEN);
 
-	return __diag288(func, timeout, virt_to_phys(cmd_buf), len);
-}
-
-static int __diag288_lpar(unsigned int func, unsigned int timeout,
-			  unsigned long action)
-{
-	return __diag288(func, timeout, action, 0);
+	return diag288(func, timeout, virt_to_phys(cmd_buf), len);
 }
 
 static int wdt_start(struct watchdog_device *dev)
@@ -119,11 +113,10 @@ static int wdt_start(struct watchdog_device *dev)
 	if (MACHINE_IS_VM) {
 		func = conceal_on ? (WDT_FUNC_INIT | WDT_FUNC_CONCEAL)
 			: WDT_FUNC_INIT;
-		ret = __diag288_vm(func, dev->timeout, wdt_cmd);
+		ret = diag288_str(func, dev->timeout, wdt_cmd);
 		WARN_ON(ret != 0);
 	} else {
-		ret = __diag288_lpar(WDT_FUNC_INIT,
-				     dev->timeout, LPARWDT_RESTART);
+		ret = diag288(WDT_FUNC_INIT, dev->timeout, LPARWDT_RESTART, 0);
 	}
 
 	if (ret) {
@@ -135,7 +128,7 @@ static int wdt_start(struct watchdog_device *dev)
 
 static int wdt_stop(struct watchdog_device *dev)
 {
-	return __diag288(WDT_FUNC_CANCEL, 0, 0, 0);
+	return diag288(WDT_FUNC_CANCEL, 0, 0, 0);
 }
 
 static int wdt_ping(struct watchdog_device *dev)
@@ -152,10 +145,10 @@ static int wdt_ping(struct watchdog_device *dev)
 		func = conceal_on ? (WDT_FUNC_INIT | WDT_FUNC_CONCEAL)
 			: WDT_FUNC_INIT;
 
-		ret = __diag288_vm(func, dev->timeout, wdt_cmd);
+		ret = diag288_str(func, dev->timeout, wdt_cmd);
 		WARN_ON(ret != 0);
 	} else {
-		ret = __diag288_lpar(WDT_FUNC_CHANGE, dev->timeout, 0);
+		ret = diag288(WDT_FUNC_CHANGE, dev->timeout, 0, 0);
 	}
 
 	if (ret)
@@ -206,20 +199,21 @@ static int __init diag288_init(void)
 			return -ENOMEM;
 		}
 
-		ret = __diag288_vm(WDT_FUNC_INIT, MIN_INTERVAL, "BEGIN");
+		ret = diag288_str(WDT_FUNC_INIT, MIN_INTERVAL, "BEGIN");
 		if (ret != 0) {
 			pr_err("The watchdog cannot be initialized\n");
 			kfree(cmd_buf);
 			return -EINVAL;
 		}
 	} else {
-		if (__diag288_lpar(WDT_FUNC_INIT, 30, LPARWDT_RESTART)) {
+		if (diag288(WDT_FUNC_INIT, WDT_DEFAULT_TIMEOUT,
+			    LPARWDT_RESTART, 0)) {
 			pr_err("The watchdog cannot be initialized\n");
 			return -EINVAL;
 		}
 	}
 
-	if (__diag288_lpar(WDT_FUNC_CANCEL, 0, 0)) {
+	if (diag288(WDT_FUNC_CANCEL, 0, 0, 0)) {
 		pr_err("The watchdog cannot be deactivated\n");
 		return -EINVAL;
 	}
-- 
2.37.2

