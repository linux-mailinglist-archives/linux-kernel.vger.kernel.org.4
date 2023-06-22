Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E8C073A40E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 16:59:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232306AbjFVO7V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 10:59:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232140AbjFVO6a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 10:58:30 -0400
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 834931FE7;
        Thu, 22 Jun 2023 07:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:References:
        In-Reply-To:Message-Id:Date:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=mEN6CLA9Jrql6zJscJkNfXRebWT5+YN3ONZ25Kkuswc=; b=yC2P3mh10696nzYrcagG+WiWPv
        nW2bQxo2yiops9YT6UqRehtQSaYc4r85eNuyOaGYbAVVBfYCq5tyLxm2KmOtjmWETvFzFwQXCnHsm
        tIJ461qnxKdtPoyvMMPEweEByP4bzST10glPKA/oBHWaNiU+Ct5SPMaizXsWW6aiFWYI=;
Received: from modemcable061.19-161-184.mc.videotron.ca ([184.161.19.61]:55382 helo=localhost.localdomain)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1qCLlN-0002fr-TO; Thu, 22 Jun 2023 10:58:22 -0400
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     a.zummo@towertech.it, alexandre.belloni@bootlin.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org
Cc:     linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, hugo@hugovil.com,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>
Date:   Thu, 22 Jun 2023 10:57:57 -0400
Message-Id: <20230622145800.2442116-15-hugo@hugovil.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230622145800.2442116-1-hugo@hugovil.com>
References: <20230622145800.2442116-1-hugo@hugovil.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 184.161.19.61
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH v4 14/17] rtc: pcf2127: support generic watchdog timing configuration
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Introduce in the configuration structure two new values to hold the
watchdog clock source and the min_hw_heartbeat_ms value.

The minimum and maximum timeout values are automatically computed from
the watchdog clock source value for each variant.

The PCF2131 has no 1Hz watchdog clock source, as is the case for
PCF2127/29.

The next best choice is using a 1/4Hz clock, giving a watchdog timeout
range between 4 and 1016s. By using the same register configuration as
for the PCF2127/29, the 1/4Hz clock source is selected.

Note: the PCF2127 datasheet gives a min/max range between 1 and 255s,
but it should be between 2 and 254s, because the watchdog is triggered
when the timer value reaches 1, not 0.

Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
 drivers/rtc/rtc-pcf2127.c | 64 +++++++++++++++++++++++++++++++++------
 1 file changed, 55 insertions(+), 9 deletions(-)

diff --git a/drivers/rtc/rtc-pcf2127.c b/drivers/rtc/rtc-pcf2127.c
index 3b8718aaadd7..c20eab277385 100644
--- a/drivers/rtc/rtc-pcf2127.c
+++ b/drivers/rtc/rtc-pcf2127.c
@@ -80,9 +80,14 @@
 
 /* Watchdog timer value constants */
 #define PCF2127_WD_VAL_STOP		0
-#define PCF2127_WD_VAL_MIN		2
-#define PCF2127_WD_VAL_MAX		255
-#define PCF2127_WD_VAL_DEFAULT		60
+/* PCF2127/29 watchdog timer value constants */
+#define PCF2127_WD_CLOCK_HZ_X1000	1000 /* 1Hz */
+#define PCF2127_WD_MIN_HW_HEARTBEAT_MS	500
+/* PCF2131 watchdog timer value constants */
+#define PCF2131_WD_CLOCK_HZ_X1000	250  /* 1/4Hz */
+#define PCF2131_WD_MIN_HW_HEARTBEAT_MS	4000
+
+#define PCF2127_WD_DEFAULT_TIMEOUT_S	60
 
 /* Mask for currently enabled interrupts */
 #define PCF2127_CTRL1_IRQ_MASK (PCF2127_BIT_CTRL1_TSF1)
@@ -186,6 +191,8 @@ struct pcf21xx_config {
 	u8 reg_wd_ctl; /* Watchdog control register. */
 	u8 reg_wd_val; /* Watchdog value register. */
 	u8 reg_clkout; /* Clkout register. */
+	int wdd_clock_hz_x1000; /* Watchdog clock in Hz multiplicated by 1000 */
+	int wdd_min_hw_heartbeat_ms;
 	unsigned int ts_count;
 	struct pcf21xx_ts_config ts[PCF2127_MAX_TS_SUPPORTED];
 	struct attribute_group attribute_group;
@@ -389,9 +396,16 @@ static int pcf2127_nvmem_write(void *priv, unsigned int offset,
 
 static int pcf2127_wdt_ping(struct watchdog_device *wdd)
 {
+	int wd_val;
 	struct pcf2127 *pcf2127 = watchdog_get_drvdata(wdd);
 
-	return regmap_write(pcf2127->regmap, pcf2127->cfg->reg_wd_val, wdd->timeout);
+	/*
+	 * Compute counter value of WATCHDG_TIM_VAL to obtain desired period
+	 * in seconds, depending on the source clock frequency.
+	 */
+	wd_val = ((wdd->timeout * pcf2127->cfg->wdd_clock_hz_x1000) / 1000) + 1;
+
+	return regmap_write(pcf2127->regmap, pcf2127->cfg->reg_wd_val, wd_val);
 }
 
 /*
@@ -453,6 +467,23 @@ static const struct watchdog_ops pcf2127_watchdog_ops = {
 	.set_timeout = pcf2127_wdt_set_timeout,
 };
 
+/*
+ * Compute watchdog period, t, in seconds, from the WATCHDG_TIM_VAL register
+ * value, n, and the clock frequency, f1000, in Hz x 1000.
+ *
+ * The PCF2127/29 datasheet gives t as:
+ *   t = n / f
+ * The PCF2131 datasheet gives t as:
+ *   t = (n - 1) / f
+ * For both variants, the watchdog is triggered when the WATCHDG_TIM_VAL reaches
+ * the value 1, and not zero. Consequently, the equation from the PCF2131
+ * datasheet seems to be the correct one for both variants.
+ */
+static int pcf2127_watchdog_get_period(int n, int f1000)
+{
+	return (1000 * (n - 1)) / f1000;
+}
+
 static int pcf2127_watchdog_init(struct device *dev, struct pcf2127 *pcf2127)
 {
 	u32 wdd_timeout;
@@ -465,10 +496,19 @@ static int pcf2127_watchdog_init(struct device *dev, struct pcf2127 *pcf2127)
 	pcf2127->wdd.parent = dev;
 	pcf2127->wdd.info = &pcf2127_wdt_info;
 	pcf2127->wdd.ops = &pcf2127_watchdog_ops;
-	pcf2127->wdd.min_timeout = PCF2127_WD_VAL_MIN;
-	pcf2127->wdd.max_timeout = PCF2127_WD_VAL_MAX;
-	pcf2127->wdd.timeout = PCF2127_WD_VAL_DEFAULT;
-	pcf2127->wdd.min_hw_heartbeat_ms = 500;
+
+	pcf2127->wdd.min_timeout =
+		pcf2127_watchdog_get_period(
+			2, pcf2127->cfg->wdd_clock_hz_x1000);
+	pcf2127->wdd.max_timeout =
+		pcf2127_watchdog_get_period(
+			255, pcf2127->cfg->wdd_clock_hz_x1000);
+	pcf2127->wdd.timeout = PCF2127_WD_DEFAULT_TIMEOUT_S;
+
+	dev_dbg(dev, "%s clock = %d Hz / 1000\n", __func__,
+		pcf2127->cfg->wdd_clock_hz_x1000);
+
+	pcf2127->wdd.min_hw_heartbeat_ms = pcf2127->cfg->wdd_min_hw_heartbeat_ms;
 	pcf2127->wdd.status = WATCHDOG_NOWAYOUT_INIT_STATUS;
 
 	watchdog_set_drvdata(&pcf2127->wdd, pcf2127);
@@ -885,6 +925,8 @@ static struct pcf21xx_config pcf21xx_cfg[] = {
 		.reg_wd_ctl = PCF2127_REG_WD_CTL,
 		.reg_wd_val = PCF2127_REG_WD_VAL,
 		.reg_clkout = PCF2127_REG_CLKOUT,
+		.wdd_clock_hz_x1000 = PCF2127_WD_CLOCK_HZ_X1000,
+		.wdd_min_hw_heartbeat_ms = PCF2127_WD_MIN_HW_HEARTBEAT_MS,
 		.ts_count = 1,
 		.ts[0] = {
 			.reg_base  = PCF2127_REG_TS1_BASE,
@@ -910,6 +952,8 @@ static struct pcf21xx_config pcf21xx_cfg[] = {
 		.reg_wd_ctl = PCF2127_REG_WD_CTL,
 		.reg_wd_val = PCF2127_REG_WD_VAL,
 		.reg_clkout = PCF2127_REG_CLKOUT,
+		.wdd_clock_hz_x1000 = PCF2127_WD_CLOCK_HZ_X1000,
+		.wdd_min_hw_heartbeat_ms = PCF2127_WD_MIN_HW_HEARTBEAT_MS,
 		.ts_count = 1,
 		.ts[0] = {
 			.reg_base  = PCF2127_REG_TS1_BASE,
@@ -935,6 +979,8 @@ static struct pcf21xx_config pcf21xx_cfg[] = {
 		.reg_wd_ctl = PCF2131_REG_WD_CTL,
 		.reg_wd_val = PCF2131_REG_WD_VAL,
 		.reg_clkout = PCF2131_REG_CLKOUT,
+		.wdd_clock_hz_x1000 = PCF2131_WD_CLOCK_HZ_X1000,
+		.wdd_min_hw_heartbeat_ms = PCF2131_WD_MIN_HW_HEARTBEAT_MS,
 		.ts_count = 4,
 		.ts[0] = {
 			.reg_base  = PCF2131_REG_TS1_BASE,
@@ -1148,7 +1194,7 @@ static int pcf2127_probe(struct device *dev, struct regmap *regmap,
 
 	/*
 	 * Watchdog timer enabled and reset pin /RST activated when timed out.
-	 * Select 1Hz clock source for watchdog timer.
+	 * Select 1Hz clock source for watchdog timer (1/4Hz for PCF2131).
 	 * Note: Countdown timer disabled and not available.
 	 * For pca2129, pcf2129 and pcf2131, only bit[7] is for Symbol WD_CD
 	 * of register watchdg_tim_ctl. The bit[6] is labeled
-- 
2.30.2

