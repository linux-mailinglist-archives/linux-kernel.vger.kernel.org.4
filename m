Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE031729D17
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 16:39:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241551AbjFIOj1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 10:39:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241079AbjFIOjU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 10:39:20 -0400
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99EAC269A;
        Fri,  9 Jun 2023 07:39:18 -0700 (PDT)
X-GND-Sasl: miquel.raynal@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1686321557;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=O/Gbxig3KHx3alSZjtr0kx9eZgIqHD/LRBPLbP6Mt5Y=;
        b=BibnEOww0QBNScennSR5DSp34xDnk2kE/9mj92EqUnNRVtVhgZ0wNtltmPLBjVh9VzQKvS
        C7fQ94nAoXDPc68JADBWh4uSPJnzTe6UVeYV6XNx2/NPOKCHiwthna5sDYgg4IaEUlmTK9
        rnPIgMEkgUi8uv38t662BswGdGk9DlX6y36e9BzGVAFbOgBlLLm+EOSc4Jzqt4nLjEc8Rq
        GOUt7LOEplO804qtYUWiVW1Btf2DrYlvw9sU5WrVf1do8jFS8tXOt+NWlfHHM/hmThhZBx
        BjJ25cjuTT1BCrHU/8kDKbZrBeqNuwBY+AW/Gg/EFzCdIkEojRegwJCSqk+hYw==
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3139A60009;
        Fri,  9 Jun 2023 14:39:16 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, linux-pm@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Kamel Bouhara <kamel.bouhara@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 2/2] power: reset: at91-reset: add sysfs interface to the power on reason
Date:   Fri,  9 Jun 2023 16:39:12 +0200
Message-Id: <20230609143912.849995-3-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230609143912.849995-1-miquel.raynal@bootlin.com>
References: <20230609143912.849995-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kamel Bouhara <kamel.bouhara@bootlin.com>

Introduce a list of generic reset sources and use them to export the
power on reason through sysfs. Update the ABI documentation to describe
this new interface.

Signed-off-by: Kamel Bouhara <kamel.bouhara@bootlin.com>
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
[Miquel Raynal: Follow-up on Kamel's work, 4 years later]
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 .../testing/sysfs-platform-power-on-reason    | 10 +++++
 drivers/power/reset/at91-reset.c              | 42 +++++++++++++------
 include/linux/power/power_on_reason.h         | 19 +++++++++
 3 files changed, 59 insertions(+), 12 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-platform-power-on-reason
 create mode 100644 include/linux/power/power_on_reason.h

diff --git a/Documentation/ABI/testing/sysfs-platform-power-on-reason b/Documentation/ABI/testing/sysfs-platform-power-on-reason
new file mode 100644
index 000000000000..12020d017543
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-platform-power-on-reason
@@ -0,0 +1,10 @@
+What:		/sys/devices/platform/.../power_on_reason
+Date:		October 2019
+KernelVersion:	5.4
+Contact:	Kamel Bouhara <kamel.bouhara@bootlin.com>
+Description:	This file shows system power on reason. Possible sources are:
+		General system power-on, RTC wakeup, watchdog timeout, software
+		reset, user pressed reset button, CPU clock failure, oscillator
+		failure, low power mode exit, unknown.
+
+		The file is read only.
diff --git a/drivers/power/reset/at91-reset.c b/drivers/power/reset/at91-reset.c
index a8a6f3997768..73cc6839a1c1 100644
--- a/drivers/power/reset/at91-reset.c
+++ b/drivers/power/reset/at91-reset.c
@@ -18,6 +18,7 @@
 #include <linux/platform_device.h>
 #include <linux/reboot.h>
 #include <linux/reset-controller.h>
+#include <linux/power/power_on_reason.h>
 
 #include <soc/at91/at91sam9_ddrsdr.h>
 #include <soc/at91/at91sam9_sdramc.h>
@@ -149,44 +150,54 @@ static int at91_reset(struct notifier_block *this, unsigned long mode,
 	return NOTIFY_DONE;
 }
 
-static void __init at91_reset_status(struct at91_reset *reset)
+static const char *at91_reset_reason(struct at91_reset *reset)
 {
 	u32 reg = readl(reset->rstc_base + AT91_RSTC_SR);
 	const char *reason;
 
 	switch ((reg & AT91_RSTC_RSTTYP) >> 8) {
 	case RESET_TYPE_GENERAL:
-		reason = "general reset";
+		reason = POWER_ON_REASON_GENERAL;
 		break;
 	case RESET_TYPE_WAKEUP:
-		reason = "wakeup";
+		reason = POWER_ON_REASON_RTC;
 		break;
 	case RESET_TYPE_WATCHDOG:
-		reason = "watchdog reset";
+		reason = POWER_ON_REASON_WATCHDOG;
 		break;
 	case RESET_TYPE_SOFTWARE:
-		reason = "software reset";
+		reason = POWER_ON_REASON_SOFTWARE;
 		break;
 	case RESET_TYPE_USER:
-		reason = "user reset";
+		reason = POWER_ON_REASON_USER;
 		break;
 	case RESET_TYPE_CPU_FAIL:
-		reason = "CPU clock failure detection";
+		reason = POWER_ON_REASON_CPU_FAIL;
 		break;
 	case RESET_TYPE_XTAL_FAIL:
-		reason = "32.768 kHz crystal failure detection";
+		reason = POWER_ON_REASON_XTAL_FAIL;
 		break;
 	case RESET_TYPE_ULP2:
-		reason = "ULP2 reset";
+		reason = POWER_ON_REASON_LOW_POWER;
 		break;
 	default:
-		reason = "unknown reset";
+		reason = POWER_ON_REASON_UNKNOWN;
 		break;
 	}
 
-	dev_info(&pdev->dev, "Starting after %s\n", reason);
+	return reason;
 }
 
+static ssize_t power_on_reason_show(struct device *dev,
+				    struct device_attribute *attr, char *buf)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct at91_reset *reset = platform_get_drvdata(pdev);
+
+	return sprintf(buf, "%s\n", at91_reset_reason(reset));
+}
+static DEVICE_ATTR_RO(power_on_reason);
+
 static const struct of_device_id at91_ramc_of_match[] = {
 	{
 		.compatible = "atmel,at91sam9260-sdramc",
@@ -391,7 +402,14 @@ static int __init at91_reset_probe(struct platform_device *pdev)
 	if (ret)
 		goto disable_clk;
 
-	at91_reset_status(pdev, reset->rstc_base);
+	ret = device_create_file(&pdev->dev, &dev_attr_power_on_reason);
+	if (ret) {
+		dev_err(&pdev->dev, "Could not create sysfs entry\n");
+		return ret;
+	}
+
+	dev_info(&pdev->dev, "Starting after %s reset\n",
+		 at91_reset_reason(reset));
 
 	return 0;
 
diff --git a/include/linux/power/power_on_reason.h b/include/linux/power/power_on_reason.h
new file mode 100644
index 000000000000..4b92eb0519c4
--- /dev/null
+++ b/include/linux/power/power_on_reason.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Author: Kamel Bouhra <kamel.bouhara@bootlin.com>
+ */
+
+#ifndef POWER_ON_REASON_H
+#define POWER_ON_REASON_H
+
+#define POWER_ON_REASON_GENERAL "general"
+#define POWER_ON_REASON_RTC "RTC wakeup"
+#define POWER_ON_REASON_WATCHDOG "watchdog timeout"
+#define POWER_ON_REASON_SOFTWARE "software"
+#define POWER_ON_REASON_USER "user"
+#define POWER_ON_REASON_CPU_FAIL "CPU clock failure"
+#define POWER_ON_REASON_XTAL_FAIL "crystal oscillator failure"
+#define POWER_ON_REASON_LOW_POWER "low power exit"
+#define POWER_ON_REASON_UNKNOWN "unknown"
+
+#endif /* POWER_ON_REASON_H */
-- 
2.34.1

