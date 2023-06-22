Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70DBD73A3F8
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 16:58:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231713AbjFVO6t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 10:58:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232102AbjFVO6W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 10:58:22 -0400
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF70A1BD7;
        Thu, 22 Jun 2023 07:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:References:
        In-Reply-To:Message-Id:Date:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=xt+CVSzgAOOtwJcOdP+TdLyOaww1PHVabdxnOxpwf6M=; b=aV4JAPZnSVqMp7gpgMyQyNHBjf
        zPeCCHOy660V8+6uR+4cq3j0waT8yh/sAGCuCfO97uMDv0ecK0dOLvJyRAPxTGfr0b+amwyi76wO7
        /AQ5orjKlNv5slQ/odAOA3EO1Vxl2A3R1uEj4EzOCE0SezCV2lrAwYLm4kdpfPQAWNzw=;
Received: from modemcable061.19-161-184.mc.videotron.ca ([184.161.19.61]:55382 helo=localhost.localdomain)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1qCLlH-0002fr-Cs; Thu, 22 Jun 2023 10:58:16 -0400
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     a.zummo@towertech.it, alexandre.belloni@bootlin.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org
Cc:     linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, hugo@hugovil.com,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>
Date:   Thu, 22 Jun 2023 10:57:53 -0400
Message-Id: <20230622145800.2442116-11-hugo@hugovil.com>
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
Subject: [PATCH v4 10/17] rtc: pcf2127: add support for multiple TS functions
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

This will simplify the implementation of new variants into this driver.

Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
 drivers/rtc/rtc-pcf2127.c | 268 ++++++++++++++++++++++++++++----------
 1 file changed, 201 insertions(+), 67 deletions(-)

diff --git a/drivers/rtc/rtc-pcf2127.c b/drivers/rtc/rtc-pcf2127.c
index 21fa42870dd4..c6bbeb1916a4 100644
--- a/drivers/rtc/rtc-pcf2127.c
+++ b/drivers/rtc/rtc-pcf2127.c
@@ -59,8 +59,8 @@
 #define PCF2127_BIT_WD_CTL_CD0			BIT(6)
 #define PCF2127_BIT_WD_CTL_CD1			BIT(7)
 #define PCF2127_REG_WD_VAL		0x11
-/* Tamper timestamp registers */
-#define PCF2127_REG_TS_CTRL		0x12
+/* Tamper timestamp1 registers */
+#define PCF2127_REG_TS1_BASE		0x12
 #define PCF2127_BIT_TS_CTRL_TSOFF		BIT(6)
 #define PCF2127_BIT_TS_CTRL_TSM			BIT(7)
 /*
@@ -86,12 +86,36 @@
 		PCF2127_BIT_CTRL2_WDTF | \
 		PCF2127_BIT_CTRL2_TSF2)
 
+#define PCF2127_MAX_TS_SUPPORTED	1
+
 enum pcf21xx_type {
 	PCF2127,
 	PCF2129,
 	PCF21XX_LAST_ID
 };
 
+struct pcf21xx_ts_config {
+	u8 reg_base; /* Base register to read timestamp values. */
+
+	/*
+	 * If the TS input pin is driven to GND, an interrupt can be generated
+	 * (supported by all variants).
+	 */
+	u8 gnd_detect_reg; /* Interrupt control register address. */
+	u8 gnd_detect_bit; /* Interrupt bit. */
+
+	/*
+	 * If the TS input pin is driven to an intermediate level between GND
+	 * and supply, an interrupt can be generated (optional feature depending
+	 * on variant).
+	 */
+	u8 inter_detect_reg; /* Interrupt control register address. */
+	u8 inter_detect_bit; /* Interrupt bit. */
+
+	u8 ie_reg; /* Interrupt enable control register. */
+	u8 ie_bit; /* Interrupt enable bit. */
+};
+
 struct pcf21xx_config {
 	int type; /* IC variant */
 	int max_register;
@@ -102,6 +126,9 @@ struct pcf21xx_config {
 	u8 reg_wd_ctl; /* Watchdog control register. */
 	u8 reg_wd_val; /* Watchdog value register. */
 	u8 reg_clkout; /* Clkout register. */
+	unsigned int ts_count;
+	struct pcf21xx_ts_config ts[PCF2127_MAX_TS_SUPPORTED];
+	struct attribute_group attribute_group;
 };
 
 struct pcf2127 {
@@ -109,9 +136,9 @@ struct pcf2127 {
 	struct watchdog_device wdd;
 	struct regmap *regmap;
 	const struct pcf21xx_config *cfg;
-	time64_t ts;
-	bool ts_valid;
 	bool irq_enabled;
+	time64_t ts[PCF2127_MAX_TS_SUPPORTED]; /* Timestamp values. */
+	bool ts_valid[PCF2127_MAX_TS_SUPPORTED];  /* Timestamp valid indication. */
 };
 
 /*
@@ -441,18 +468,19 @@ static int pcf2127_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 }
 
 /*
- * This function reads ctrl2 register, caller is responsible for calling
- * pcf2127_wdt_active_ping()
+ * This function reads one timestamp function data, caller is responsible for
+ * calling pcf2127_wdt_active_ping()
  */
-static int pcf2127_rtc_ts_read(struct device *dev, time64_t *ts)
+static int pcf2127_rtc_ts_read(struct device *dev, time64_t *ts,
+			       int ts_id)
 {
 	struct pcf2127 *pcf2127 = dev_get_drvdata(dev);
 	struct rtc_time tm;
 	int ret;
 	unsigned char data[7];
 
-	ret = regmap_bulk_read(pcf2127->regmap, PCF2127_REG_TS_CTRL, data,
-			       sizeof(data));
+	ret = regmap_bulk_read(pcf2127->regmap, pcf2127->cfg->ts[ts_id].reg_base,
+			       data, sizeof(data));
 	if (ret) {
 		dev_err(dev, "%s: read error ret=%d\n", __func__, ret);
 		return ret;
@@ -482,18 +510,21 @@ static int pcf2127_rtc_ts_read(struct device *dev, time64_t *ts)
 	return 0;
 };
 
-static void pcf2127_rtc_ts_snapshot(struct device *dev)
+static void pcf2127_rtc_ts_snapshot(struct device *dev, int ts_id)
 {
 	struct pcf2127 *pcf2127 = dev_get_drvdata(dev);
 	int ret;
 
+	if (ts_id >= pcf2127->cfg->ts_count)
+		return;
+
 	/* Let userspace read the first timestamp */
-	if (pcf2127->ts_valid)
+	if (pcf2127->ts_valid[ts_id])
 		return;
 
-	ret = pcf2127_rtc_ts_read(dev, &pcf2127->ts);
+	ret = pcf2127_rtc_ts_read(dev, &pcf2127->ts[ts_id], ts_id);
 	if (!ret)
-		pcf2127->ts_valid = true;
+		pcf2127->ts_valid[ts_id] = true;
 }
 
 static irqreturn_t pcf2127_rtc_irq(int irq, void *dev)
@@ -514,7 +545,7 @@ static irqreturn_t pcf2127_rtc_irq(int irq, void *dev)
 		return IRQ_NONE;
 
 	if (ctrl1 & PCF2127_BIT_CTRL1_TSF1 || ctrl2 & PCF2127_BIT_CTRL2_TSF2)
-		pcf2127_rtc_ts_snapshot(dev);
+		pcf2127_rtc_ts_snapshot(dev, 0);
 
 	if (ctrl1 & PCF2127_CTRL1_IRQ_MASK)
 		regmap_write(pcf2127->regmap, PCF2127_REG_CTRL1,
@@ -543,28 +574,41 @@ static const struct rtc_class_ops pcf2127_rtc_ops = {
 
 /* sysfs interface */
 
-static ssize_t timestamp0_store(struct device *dev,
-				struct device_attribute *attr,
-				const char *buf, size_t count)
+static ssize_t timestamp_store(struct device *dev,
+			       struct device_attribute *attr,
+			       const char *buf, size_t count, int ts_id)
 {
 	struct pcf2127 *pcf2127 = dev_get_drvdata(dev->parent);
 	int ret;
 
+	if (ts_id >= pcf2127->cfg->ts_count)
+		return 0;
+
 	if (pcf2127->irq_enabled) {
-		pcf2127->ts_valid = false;
+		pcf2127->ts_valid[ts_id] = false;
 	} else {
-		ret = regmap_update_bits(pcf2127->regmap, PCF2127_REG_CTRL1,
-			PCF2127_BIT_CTRL1_TSF1, 0);
+		/* Always clear GND interrupt bit. */
+		ret = regmap_update_bits(pcf2127->regmap,
+					 pcf2127->cfg->ts[ts_id].gnd_detect_reg,
+					 pcf2127->cfg->ts[ts_id].gnd_detect_bit,
+					 0);
+
 		if (ret) {
-			dev_err(dev, "%s: update ctrl1 ret=%d\n", __func__, ret);
+			dev_err(dev, "%s: update TS gnd detect ret=%d\n", __func__, ret);
 			return ret;
 		}
 
-		ret = regmap_update_bits(pcf2127->regmap, PCF2127_REG_CTRL2,
-			PCF2127_BIT_CTRL2_TSF2, 0);
-		if (ret) {
-			dev_err(dev, "%s: update ctrl2 ret=%d\n", __func__, ret);
-			return ret;
+		if (pcf2127->cfg->ts[ts_id].inter_detect_bit) {
+			/* Clear intermediate level interrupt bit if supported. */
+			ret = regmap_update_bits(pcf2127->regmap,
+						 pcf2127->cfg->ts[ts_id].inter_detect_reg,
+						 pcf2127->cfg->ts[ts_id].inter_detect_bit,
+						 0);
+			if (ret) {
+				dev_err(dev, "%s: update TS intermediate level detect ret=%d\n",
+					__func__, ret);
+				return ret;
+			}
 		}
 
 		ret = pcf2127_wdt_active_ping(&pcf2127->wdd);
@@ -573,34 +617,63 @@ static ssize_t timestamp0_store(struct device *dev,
 	}
 
 	return count;
+}
+
+static ssize_t timestamp0_store(struct device *dev,
+				struct device_attribute *attr,
+				const char *buf, size_t count)
+{
+	return timestamp_store(dev, attr, buf, count, 0);
 };
 
-static ssize_t timestamp0_show(struct device *dev,
-			       struct device_attribute *attr, char *buf)
+static ssize_t timestamp_show(struct device *dev,
+			      struct device_attribute *attr, char *buf,
+			      int ts_id)
 {
 	struct pcf2127 *pcf2127 = dev_get_drvdata(dev->parent);
-	unsigned int ctrl1, ctrl2;
 	int ret;
 	time64_t ts;
 
+	if (ts_id >= pcf2127->cfg->ts_count)
+		return 0;
+
 	if (pcf2127->irq_enabled) {
-		if (!pcf2127->ts_valid)
+		if (!pcf2127->ts_valid[ts_id])
 			return 0;
-		ts = pcf2127->ts;
+		ts = pcf2127->ts[ts_id];
 	} else {
-		ret = regmap_read(pcf2127->regmap, PCF2127_REG_CTRL1, &ctrl1);
-		if (ret)
-			return 0;
+		u8 valid_low = 0;
+		u8 valid_inter = 0;
+		unsigned int ctrl;
 
-		ret = regmap_read(pcf2127->regmap, PCF2127_REG_CTRL2, &ctrl2);
+		/* Check if TS input pin is driven to GND, supported by all
+		 * variants.
+		 */
+		ret = regmap_read(pcf2127->regmap,
+				  pcf2127->cfg->ts[ts_id].gnd_detect_reg,
+				  &ctrl);
 		if (ret)
 			return 0;
 
-		if (!(ctrl1 & PCF2127_BIT_CTRL1_TSF1) &&
-		    !(ctrl2 & PCF2127_BIT_CTRL2_TSF2))
+		valid_low = ctrl & pcf2127->cfg->ts[ts_id].gnd_detect_bit;
+
+		if (pcf2127->cfg->ts[ts_id].inter_detect_bit) {
+			/* Check if TS input pin is driven to intermediate level
+			 * between GND and supply, if supported by variant.
+			 */
+			ret = regmap_read(pcf2127->regmap,
+					  pcf2127->cfg->ts[ts_id].inter_detect_reg,
+					  &ctrl);
+			if (ret)
+				return 0;
+
+			valid_inter = ctrl & pcf2127->cfg->ts[ts_id].inter_detect_bit;
+		}
+
+		if (!valid_low && !valid_inter)
 			return 0;
 
-		ret = pcf2127_rtc_ts_read(dev->parent, &ts);
+		ret = pcf2127_rtc_ts_read(dev->parent, &ts, ts_id);
 		if (ret)
 			return 0;
 
@@ -609,6 +682,12 @@ static ssize_t timestamp0_show(struct device *dev,
 			return ret;
 	}
 	return sprintf(buf, "%llu\n", (unsigned long long)ts);
+}
+
+static ssize_t timestamp0_show(struct device *dev,
+			       struct device_attribute *attr, char *buf)
+{
+	return timestamp_show(dev, attr, buf, 0);
 };
 
 static DEVICE_ATTR_RW(timestamp0);
@@ -618,10 +697,6 @@ static struct attribute *pcf2127_attrs[] = {
 	NULL
 };
 
-static const struct attribute_group pcf2127_attr_group = {
-	.attrs	= pcf2127_attrs,
-};
-
 static struct pcf21xx_config pcf21xx_cfg[] = {
 	[PCF2127] = {
 		.type = PCF2127,
@@ -633,6 +708,19 @@ static struct pcf21xx_config pcf21xx_cfg[] = {
 		.reg_wd_ctl = PCF2127_REG_WD_CTL,
 		.reg_wd_val = PCF2127_REG_WD_VAL,
 		.reg_clkout = PCF2127_REG_CLKOUT,
+		.ts_count = 1,
+		.ts[0] = {
+			.reg_base  = PCF2127_REG_TS1_BASE,
+			.gnd_detect_reg = PCF2127_REG_CTRL1,
+			.gnd_detect_bit = PCF2127_BIT_CTRL1_TSF1,
+			.inter_detect_reg = PCF2127_REG_CTRL2,
+			.inter_detect_bit = PCF2127_BIT_CTRL2_TSF2,
+			.ie_reg    = PCF2127_REG_CTRL2,
+			.ie_bit    = PCF2127_BIT_CTRL2_TSIE,
+		},
+		.attribute_group = {
+			.attrs	= pcf2127_attrs,
+		},
 	},
 	[PCF2129] = {
 		.type = PCF2129,
@@ -644,9 +732,74 @@ static struct pcf21xx_config pcf21xx_cfg[] = {
 		.reg_wd_ctl = PCF2127_REG_WD_CTL,
 		.reg_wd_val = PCF2127_REG_WD_VAL,
 		.reg_clkout = PCF2127_REG_CLKOUT,
+		.ts_count = 1,
+		.ts[0] = {
+			.reg_base  = PCF2127_REG_TS1_BASE,
+			.gnd_detect_reg = PCF2127_REG_CTRL1,
+			.gnd_detect_bit = PCF2127_BIT_CTRL1_TSF1,
+			.inter_detect_reg = PCF2127_REG_CTRL2,
+			.inter_detect_bit = PCF2127_BIT_CTRL2_TSF2,
+			.ie_reg    = PCF2127_REG_CTRL2,
+			.ie_bit    = PCF2127_BIT_CTRL2_TSIE,
+		},
+		.attribute_group = {
+			.attrs	= pcf2127_attrs,
+		},
 	},
 };
 
+/*
+ * Enable timestamp function and corresponding interrupt(s).
+ */
+static int pcf2127_enable_ts(struct device *dev, int ts_id)
+{
+	struct pcf2127 *pcf2127 = dev_get_drvdata(dev);
+	int ret;
+
+	if (ts_id >= pcf2127->cfg->ts_count) {
+		dev_err(dev, "%s: invalid tamper detection ID (%d)\n",
+			__func__, ts_id);
+		return -EINVAL;
+	}
+
+	/* Enable timestamp function. */
+	ret = regmap_update_bits(pcf2127->regmap,
+				 pcf2127->cfg->ts[ts_id].reg_base,
+				 PCF2127_BIT_TS_CTRL_TSOFF |
+				 PCF2127_BIT_TS_CTRL_TSM,
+				 PCF2127_BIT_TS_CTRL_TSM);
+	if (ret) {
+		dev_err(dev, "%s: tamper detection config (ts%d_ctrl) failed\n",
+			__func__, ts_id);
+		return ret;
+	}
+
+	/* TS input pin driven to GND detection is supported by all variants.
+	 * Make sure that interrupt bit is defined.
+	 */
+	if (pcf2127->cfg->ts[ts_id].gnd_detect_bit == 0) {
+		dev_err(dev, "%s: tamper detection to GND configuration invalid\n",
+			__func__);
+		return ret;
+	}
+
+	/*
+	 * Enable interrupt generation when TSF timestamp flag is set.
+	 * Interrupt signals are open-drain outputs and can be left floating if
+	 * unused.
+	 */
+	ret = regmap_update_bits(pcf2127->regmap, pcf2127->cfg->ts[ts_id].ie_reg,
+				 pcf2127->cfg->ts[ts_id].ie_bit,
+				 pcf2127->cfg->ts[ts_id].ie_bit);
+	if (ret) {
+		dev_err(dev, "%s: tamper detection TSIE%d config failed\n",
+			__func__, ts_id);
+		return ret;
+	}
+
+	return ret;
+}
+
 static int pcf2127_probe(struct device *dev, struct regmap *regmap,
 			 int alarm_irq, const char *name, const struct pcf21xx_config *config)
 {
@@ -777,34 +930,15 @@ static int pcf2127_probe(struct device *dev, struct regmap *regmap,
 	}
 
 	/*
-	 * Enable timestamp function and store timestamp of first trigger
-	 * event until TSF1 and TSF2 interrupt flags are cleared.
+	 * Enable timestamp functions 1 to 4.
 	 */
-	ret = regmap_update_bits(pcf2127->regmap, PCF2127_REG_TS_CTRL,
-				 PCF2127_BIT_TS_CTRL_TSOFF |
-				 PCF2127_BIT_TS_CTRL_TSM,
-				 PCF2127_BIT_TS_CTRL_TSM);
-	if (ret) {
-		dev_err(dev, "%s: tamper detection config (ts_ctrl) failed\n",
-			__func__);
-		return ret;
-	}
-
-	/*
-	 * Enable interrupt generation when TSF1 or TSF2 timestamp flags
-	 * are set. Interrupt signal is an open-drain output and can be
-	 * left floating if unused.
-	 */
-	ret = regmap_update_bits(pcf2127->regmap, PCF2127_REG_CTRL2,
-				 PCF2127_BIT_CTRL2_TSIE,
-				 PCF2127_BIT_CTRL2_TSIE);
-	if (ret) {
-		dev_err(dev, "%s: tamper detection config (ctrl2) failed\n",
-			__func__);
-		return ret;
+	for (int i = 0; i < pcf2127->cfg->ts_count; i++) {
+		ret = pcf2127_enable_ts(dev, i);
+		if (ret)
+			return ret;
 	}
 
-	ret = rtc_add_group(pcf2127->rtc, &pcf2127_attr_group);
+	ret = rtc_add_group(pcf2127->rtc, &pcf2127->cfg->attribute_group);
 	if (ret) {
 		dev_err(dev, "%s: tamper sysfs registering failed\n",
 			__func__);
-- 
2.30.2

