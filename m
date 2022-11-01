Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4748A615399
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 21:54:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbiKAUyX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 16:54:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbiKAUyL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 16:54:11 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6544811A10;
        Tue,  1 Nov 2022 13:54:10 -0700 (PDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A1K4aZg010456;
        Tue, 1 Nov 2022 20:53:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=gNr2mrMqakuUIIGz5uvLpubP6jIubqVjxeqe4xL60BY=;
 b=tXD11D0bSmTumuHf3srbUlXgGOxGUob+myzDMG0AJkOoHsZV5S+ZIccuz1WTLOFX6iLh
 3XaDLtf7IGjmfjWNUIsdKkpaJ9AqkVPZW1j4EQQjV8DXR5Kg/9SmnAeMGaRFrpdkz13A
 TeJNhrCEwUOwgQnGFD63QOxTcgy+/UHhnRcqbFALK1uPiI88TgXcmISedQCu79Zr7rhk
 UiofqGT9rglDSWHEfP/Rz5mWcfIP5GHk/gDNTj8xKUHyzoIgEcBe8UKAAkfGKz/Wlksx
 GQAfFFNRrT5BrxCfdsguMa+OT/K3w/rleQQ3i+WkHpsoZnaZa0htrGwXrcZne1b7BlFs xA== 
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3kjv4x6m6u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Nov 2022 20:53:47 +0000
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2A1Ko3wi022920;
        Tue, 1 Nov 2022 20:53:46 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
        by ppma05wdc.us.ibm.com with ESMTP id 3kgut9pdew-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Nov 2022 20:53:46 +0000
Received: from smtpav02.dal12v.mail.ibm.com ([9.208.128.128])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2A1Krg4Z32637192
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 1 Nov 2022 20:53:43 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2F54458051;
        Tue,  1 Nov 2022 20:53:45 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 423325805A;
        Tue,  1 Nov 2022 20:53:44 +0000 (GMT)
Received: from slate16.aus.stglabs.ibm.com (unknown [9.160.92.229])
        by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Tue,  1 Nov 2022 20:53:44 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-watchdog@vger.kernel.org
Cc:     wim@linux-watchdog.org, linux@roeck-us.net, joel@jms.id.au,
        andrew@aj.id.au, linux-aspeed@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, Eddie James <eajames@linux.ibm.com>
Subject: [PATCH v2 1/2] watchdog: aspeed: Enable pre-timeout interrupt
Date:   Tue,  1 Nov 2022 15:53:37 -0500
Message-Id: <20221101205338.577427-2-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221101205338.577427-1-eajames@linux.ibm.com>
References: <20221101205338.577427-1-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: JIinSzOHHvw6UltKJCmy61hYP48g3HWt
X-Proofpoint-ORIG-GUID: JIinSzOHHvw6UltKJCmy61hYP48g3HWt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-01_10,2022-11-01_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 phishscore=0 mlxscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 suspectscore=0 mlxlogscore=999 bulkscore=0 adultscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211010145
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the core pre-timeout interrupt on AST2500 and AST2600.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 drivers/watchdog/aspeed_wdt.c | 104 ++++++++++++++++++++++++++++------
 1 file changed, 88 insertions(+), 16 deletions(-)

diff --git a/drivers/watchdog/aspeed_wdt.c b/drivers/watchdog/aspeed_wdt.c
index 0cff2adfbfc9..86b5331bc491 100644
--- a/drivers/watchdog/aspeed_wdt.c
+++ b/drivers/watchdog/aspeed_wdt.c
@@ -5,11 +5,14 @@
  * Joel Stanley <joel@jms.id.au>
  */
 
+#include <linux/bits.h>
 #include <linux/delay.h>
+#include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/of_irq.h>
 #include <linux/platform_device.h>
 #include <linux/watchdog.h>
 
@@ -18,28 +21,41 @@ module_param(nowayout, bool, 0);
 MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default="
 				__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
 
+struct aspeed_wdt_config {
+	u32 ext_pulse_width_mask;
+	u32 irq_shift;
+	u32 irq_mask;
+};
+
 struct aspeed_wdt {
 	struct watchdog_device	wdd;
 	void __iomem		*base;
 	u32			ctrl;
-};
-
-struct aspeed_wdt_config {
-	u32 ext_pulse_width_mask;
+	const struct aspeed_wdt_config *cfg;
 };
 
 static const struct aspeed_wdt_config ast2400_config = {
 	.ext_pulse_width_mask = 0xff,
+	.irq_shift = 0,
+	.irq_mask = 0,
 };
 
 static const struct aspeed_wdt_config ast2500_config = {
 	.ext_pulse_width_mask = 0xfffff,
+	.irq_shift = 12,
+	.irq_mask = GENMASK(31, 12),
+};
+
+static const struct aspeed_wdt_config ast2600_config = {
+	.ext_pulse_width_mask = 0xfffff,
+	.irq_shift = 0,
+	.irq_mask = GENMASK(31, 10),
 };
 
 static const struct of_device_id aspeed_wdt_of_table[] = {
 	{ .compatible = "aspeed,ast2400-wdt", .data = &ast2400_config },
 	{ .compatible = "aspeed,ast2500-wdt", .data = &ast2500_config },
-	{ .compatible = "aspeed,ast2600-wdt", .data = &ast2500_config },
+	{ .compatible = "aspeed,ast2600-wdt", .data = &ast2600_config },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, aspeed_wdt_of_table);
@@ -58,6 +74,7 @@ MODULE_DEVICE_TABLE(of, aspeed_wdt_of_table);
 #define   WDT_CTRL_RESET_SYSTEM		BIT(1)
 #define   WDT_CTRL_ENABLE		BIT(0)
 #define WDT_TIMEOUT_STATUS	0x10
+#define   WDT_TIMEOUT_STATUS_IRQ		BIT(2)
 #define   WDT_TIMEOUT_STATUS_BOOT_SECONDARY	BIT(1)
 #define WDT_CLEAR_TIMEOUT_STATUS	0x14
 #define   WDT_CLEAR_TIMEOUT_AND_BOOT_CODE_SELECTION	BIT(0)
@@ -160,6 +177,26 @@ static int aspeed_wdt_set_timeout(struct watchdog_device *wdd,
 	return 0;
 }
 
+static int aspeed_wdt_set_pretimeout(struct watchdog_device *wdd,
+				     unsigned int pretimeout)
+{
+	struct aspeed_wdt *wdt = to_aspeed_wdt(wdd);
+	u32 actual = pretimeout * WDT_RATE_1MHZ;
+	u32 s = wdt->cfg->irq_shift;
+	u32 m = wdt->cfg->irq_mask;
+
+	wdd->pretimeout = pretimeout;
+	wdt->ctrl &= ~m;
+	if (pretimeout)
+		wdt->ctrl |= ((actual << s) & m) | WDT_CTRL_WDT_INTR;
+	else
+		wdt->ctrl &= ~WDT_CTRL_WDT_INTR;
+
+	writel(wdt->ctrl, wdt->base + WDT_CTRL);
+
+	return 0;
+}
+
 static int aspeed_wdt_restart(struct watchdog_device *wdd,
 			      unsigned long action, void *data)
 {
@@ -232,6 +269,7 @@ static const struct watchdog_ops aspeed_wdt_ops = {
 	.stop		= aspeed_wdt_stop,
 	.ping		= aspeed_wdt_ping,
 	.set_timeout	= aspeed_wdt_set_timeout,
+	.set_pretimeout = aspeed_wdt_set_pretimeout,
 	.restart	= aspeed_wdt_restart,
 	.owner		= THIS_MODULE,
 };
@@ -243,10 +281,29 @@ static const struct watchdog_info aspeed_wdt_info = {
 	.identity	= KBUILD_MODNAME,
 };
 
+static const struct watchdog_info aspeed_wdt_pretimeout_info = {
+	.options	= WDIOF_KEEPALIVEPING
+			| WDIOF_PRETIMEOUT
+			| WDIOF_MAGICCLOSE
+			| WDIOF_SETTIMEOUT,
+	.identity	= KBUILD_MODNAME,
+};
+
+static irqreturn_t aspeed_wdt_irq(int irq, void *arg)
+{
+	struct watchdog_device *wdd = arg;
+	struct aspeed_wdt *wdt = to_aspeed_wdt(wdd);
+	u32 status = readl(wdt->base + WDT_TIMEOUT_STATUS);
+
+	if (status & WDT_TIMEOUT_STATUS_IRQ)
+		watchdog_notify_pretimeout(wdd);
+
+	return IRQ_HANDLED;
+}
+
 static int aspeed_wdt_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-	const struct aspeed_wdt_config *config;
 	const struct of_device_id *ofdid;
 	struct aspeed_wdt *wdt;
 	struct device_node *np;
@@ -259,11 +316,33 @@ static int aspeed_wdt_probe(struct platform_device *pdev)
 	if (!wdt)
 		return -ENOMEM;
 
+	np = dev->of_node;
+
+	ofdid = of_match_node(aspeed_wdt_of_table, np);
+	if (!ofdid)
+		return -EINVAL;
+	wdt->cfg = ofdid->data;
+
 	wdt->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(wdt->base))
 		return PTR_ERR(wdt->base);
 
 	wdt->wdd.info = &aspeed_wdt_info;
+
+	if (wdt->cfg->irq_mask) {
+		int irq = platform_get_irq_optional(pdev, 0);
+
+		if (irq > 0) {
+			ret = devm_request_irq(dev, irq, aspeed_wdt_irq,
+					       IRQF_SHARED, dev_name(dev),
+					       wdt);
+			if (ret)
+				return ret;
+
+			wdt->wdd.info = &aspeed_wdt_pretimeout_info;
+		}
+	}
+
 	wdt->wdd.ops = &aspeed_wdt_ops;
 	wdt->wdd.max_hw_heartbeat_ms = WDT_MAX_TIMEOUT_MS;
 	wdt->wdd.parent = dev;
@@ -273,13 +352,6 @@ static int aspeed_wdt_probe(struct platform_device *pdev)
 
 	watchdog_set_nowayout(&wdt->wdd, nowayout);
 
-	np = dev->of_node;
-
-	ofdid = of_match_node(aspeed_wdt_of_table, np);
-	if (!ofdid)
-		return -EINVAL;
-	config = ofdid->data;
-
 	/*
 	 * On clock rates:
 	 *  - ast2400 wdt can run at PCLK, or 1MHz
@@ -331,7 +403,7 @@ static int aspeed_wdt_probe(struct platform_device *pdev)
 		(of_device_is_compatible(np, "aspeed,ast2600-wdt"))) {
 		u32 reg = readl(wdt->base + WDT_RESET_WIDTH);
 
-		reg &= config->ext_pulse_width_mask;
+		reg &= wdt->cfg->ext_pulse_width_mask;
 		if (of_property_read_bool(np, "aspeed,ext-active-high"))
 			reg |= WDT_ACTIVE_HIGH_MAGIC;
 		else
@@ -339,7 +411,7 @@ static int aspeed_wdt_probe(struct platform_device *pdev)
 
 		writel(reg, wdt->base + WDT_RESET_WIDTH);
 
-		reg &= config->ext_pulse_width_mask;
+		reg &= wdt->cfg->ext_pulse_width_mask;
 		if (of_property_read_bool(np, "aspeed,ext-push-pull"))
 			reg |= WDT_PUSH_PULL_MAGIC;
 		else
@@ -349,7 +421,7 @@ static int aspeed_wdt_probe(struct platform_device *pdev)
 	}
 
 	if (!of_property_read_u32(np, "aspeed,ext-pulse-duration", &duration)) {
-		u32 max_duration = config->ext_pulse_width_mask + 1;
+		u32 max_duration = wdt->cfg->ext_pulse_width_mask + 1;
 
 		if (duration == 0 || duration > max_duration) {
 			dev_err(dev, "Invalid pulse duration: %uus\n",
-- 
2.31.1

