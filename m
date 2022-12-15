Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B78164DDAE
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 16:20:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbiLOPUR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 10:20:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbiLOPT3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 10:19:29 -0500
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6D5F31EDE;
        Thu, 15 Dec 2022 07:18:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:References:
        In-Reply-To:Message-Id:Date:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=3/hHFIu9SnBKamnAdB3ZQ8g9PZ0HEAjP2IbxnYhiE10=; b=lV7ulN+dKm/SBhTFCJMMX8L67j
        ESIkngHePN4zgGZhBpV1Qav5bkBo6WWLyua17OcHCazwP4AMfbYs/0fQOwUCmt7aVajuvEEf9fprJ
        OID55IP1uQIvT1ra8I8Q/OiplV20AuKmgtwyUDNE5zezVeS59BWY9JmV99JM8nlqM5RM=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:48102 helo=pettiford.lan)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1p5pmE-0000EC-1p; Thu, 15 Dec 2022 10:04:04 -0500
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     a.zummo@towertech.it, alexandre.belloni@bootlin.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, hugo@hugovil.com,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>
Date:   Thu, 15 Dec 2022 10:02:07 -0500
Message-Id: <20221215150214.1109074-7-hugo@hugovil.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221215150214.1109074-1-hugo@hugovil.com>
References: <20221215150214.1109074-1-hugo@hugovil.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH v3 06/14] rtc: pcf2127: add support for multiple TS functions
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

This will simplify the implementation of new variants into this driver.

Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
 drivers/rtc/rtc-pcf2127.c | 303 +++++++++++++++++++++++++++-----------
 1 file changed, 215 insertions(+), 88 deletions(-)

diff --git a/drivers/rtc/rtc-pcf2127.c b/drivers/rtc/rtc-pcf2127.c
index 38816ad065eb..3265878edc48 100644
--- a/drivers/rtc/rtc-pcf2127.c
+++ b/drivers/rtc/rtc-pcf2127.c
@@ -75,16 +75,19 @@
 #define PCF2127_BIT_WD_CTL_CD0			BIT(6)
 #define PCF2127_BIT_WD_CTL_CD1			BIT(7)
 #define PCF2127_REG_WD_VAL		0x11
-/* Tamper timestamp registers */
-#define PCF2127_REG_TS_CTRL		0x12
+/* Tamper timestamp1 registers */
+#define PCF2127_REG_TS1_BASE		0x12
+/* Tamper timestamp registers common offsets (starting from base register) */
+#define PCF2127_OFFSET_TS_CTL		0
+#define PCF2127_OFFSET_TS_SC		1
+#define PCF2127_OFFSET_TS_MN		2
+#define PCF2127_OFFSET_TS_HR		3
+#define PCF2127_OFFSET_TS_DM		4
+#define PCF2127_OFFSET_TS_MO		5
+#define PCF2127_OFFSET_TS_YR		6
+/* Tamper timestamp registers common bits */
 #define PCF2127_BIT_TS_CTRL_TSOFF		BIT(6)
 #define PCF2127_BIT_TS_CTRL_TSM			BIT(7)
-#define PCF2127_REG_TS_SC		0x13
-#define PCF2127_REG_TS_MN		0x14
-#define PCF2127_REG_TS_HR		0x15
-#define PCF2127_REG_TS_DM		0x16
-#define PCF2127_REG_TS_MO		0x17
-#define PCF2127_REG_TS_YR		0x18
 /*
  * RAM registers
  * PCF2127 has 512 bytes general-purpose static RAM (SRAM) that is
@@ -108,6 +111,20 @@
 		PCF2127_BIT_CTRL2_WDTF | \
 		PCF2127_BIT_CTRL2_TSF2)
 
+struct pcf21xx_ts_config {
+	u8 regs_base; /* Base register to read timestamp values. */
+	/* TS input pin driven to GND detection (supported by all variants): */
+	u8 low_reg; /* Interrupt control register. */
+	u8 low_bit; /* Interrupt flag in low_reg control register. */
+	/* TS input pin driven to intermediate level between GND and supply
+	 * detection (optional feature depending on variant):
+	 */
+	u8 inter_reg; /* Interrupt control register. */
+	u8 inter_bit; /* Interrupt flag in inter_reg control register. */
+	u8 ie_reg; /* Interrupt enable control register. */
+	u8 ie_bit; /* Interrupt enable bit. */
+};
+
 struct pcf21xx_config {
 	int max_register;
 	unsigned int has_nvmem:1;
@@ -117,6 +134,9 @@ struct pcf21xx_config {
 	u8 reg_wd_ctl; /* Watchdog control register. */
 	u8 reg_wd_val; /* Watchdog value register. */
 	u8 reg_clkout; /* Clkout register. */
+	unsigned int ts_count;
+	struct pcf21xx_ts_config ts[4];
+	struct attribute_group attribute_group;
 };
 
 struct pcf2127 {
@@ -124,9 +144,9 @@ struct pcf2127 {
 	struct watchdog_device wdd;
 	struct regmap *regmap;
 	const struct pcf21xx_config *cfg;
-	time64_t ts;
-	bool ts_valid;
 	bool irq_enabled;
+	time64_t ts[4]; /* Timestamp values. */
+	bool ts_valid[4];  /* Timestamp valid indication. */
 };
 
 /*
@@ -469,38 +489,39 @@ static int pcf2127_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
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
-	unsigned char data[25];
+	unsigned char data[7]; /* To store result of reading 7 consecutive
+				* timestamp registers.
+				*/
 
-	ret = regmap_bulk_read(pcf2127->regmap, PCF2127_REG_CTRL1, data,
-			       sizeof(data));
+	ret = regmap_bulk_read(pcf2127->regmap, pcf2127->cfg->ts[ts_id].regs_base,
+			       data, sizeof(data));
 	if (ret) {
-		dev_err(dev, "%s: read error ret=%d\n", __func__, ret);
+		dev_err(dev, "%s: bulk read error ret=%d\n", __func__, ret);
 		return ret;
 	}
 
 	dev_dbg(dev,
-		"%s: raw data is cr1=%02x, cr2=%02x, cr3=%02x, ts_sc=%02x, ts_mn=%02x, ts_hr=%02x, ts_dm=%02x, ts_mo=%02x, ts_yr=%02x\n",
-		__func__, data[PCF2127_REG_CTRL1], data[PCF2127_REG_CTRL2],
-		data[PCF2127_REG_CTRL3], data[PCF2127_REG_TS_SC],
-		data[PCF2127_REG_TS_MN], data[PCF2127_REG_TS_HR],
-		data[PCF2127_REG_TS_DM], data[PCF2127_REG_TS_MO],
-		data[PCF2127_REG_TS_YR]);
-
-	tm.tm_sec = bcd2bin(data[PCF2127_REG_TS_SC] & 0x7F);
-	tm.tm_min = bcd2bin(data[PCF2127_REG_TS_MN] & 0x7F);
-	tm.tm_hour = bcd2bin(data[PCF2127_REG_TS_HR] & 0x3F);
-	tm.tm_mday = bcd2bin(data[PCF2127_REG_TS_DM] & 0x3F);
+		"%s: raw data is ts_sc=%02x, ts_mn=%02x, ts_hr=%02x, ts_dm=%02x, ts_mo=%02x, ts_yr=%02x\n",
+		__func__, data[PCF2127_OFFSET_TS_SC], data[PCF2127_OFFSET_TS_MN],
+		data[PCF2127_OFFSET_TS_HR], data[PCF2127_OFFSET_TS_DM],
+		data[PCF2127_OFFSET_TS_MO], data[PCF2127_OFFSET_TS_YR]);
+
+	tm.tm_sec = bcd2bin(data[PCF2127_OFFSET_TS_SC] & 0x7F);
+	tm.tm_min = bcd2bin(data[PCF2127_OFFSET_TS_MN] & 0x7F);
+	tm.tm_hour = bcd2bin(data[PCF2127_OFFSET_TS_HR] & 0x3F);
+	tm.tm_mday = bcd2bin(data[PCF2127_OFFSET_TS_DM] & 0x3F);
 	/* TS_MO register (month) value range: 1-12 */
-	tm.tm_mon = bcd2bin(data[PCF2127_REG_TS_MO] & 0x1F) - 1;
-	tm.tm_year = bcd2bin(data[PCF2127_REG_TS_YR]);
+	tm.tm_mon = bcd2bin(data[PCF2127_OFFSET_TS_MO] & 0x1F) - 1;
+	tm.tm_year = bcd2bin(data[PCF2127_OFFSET_TS_YR]);
 	if (tm.tm_year < 70)
 		tm.tm_year += 100; /* assume we are in 1970...2069 */
 
@@ -514,18 +535,21 @@ static int pcf2127_rtc_ts_read(struct device *dev, time64_t *ts)
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
@@ -546,7 +570,7 @@ static irqreturn_t pcf2127_rtc_irq(int irq, void *dev)
 		return IRQ_NONE;
 
 	if (ctrl1 & PCF2127_BIT_CTRL1_TSF1 || ctrl2 & PCF2127_BIT_CTRL2_TSF2)
-		pcf2127_rtc_ts_snapshot(dev);
+		pcf2127_rtc_ts_snapshot(dev, 0);
 
 	if (ctrl1 & PCF2127_CTRL1_IRQ_MASK)
 		regmap_write(pcf2127->regmap, PCF2127_REG_CTRL1,
@@ -575,28 +599,40 @@ static const struct rtc_class_ops pcf2127_rtc_ops = {
 
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
+		/* Always clear LOW interrupt bit. */
+		ret = regmap_update_bits(pcf2127->regmap,
+					 pcf2127->cfg->ts[ts_id].low_reg,
+					 pcf2127->cfg->ts[ts_id].low_bit,
+					 0);
+
 		if (ret) {
-			dev_err(dev, "%s: update ctrl1 ret=%d\n", __func__, ret);
+			dev_err(dev, "%s: update TS low ret=%d\n", __func__, ret);
 			return ret;
 		}
 
-		ret = regmap_update_bits(pcf2127->regmap, PCF2127_REG_CTRL2,
-			PCF2127_BIT_CTRL2_TSF2, 0);
-		if (ret) {
-			dev_err(dev, "%s: update ctrl2 ret=%d\n", __func__, ret);
-			return ret;
+		if (pcf2127->cfg->ts[ts_id].inter_bit) {
+			/* Clear INTERMEDIATE interrupt bit if supported. */
+			ret = regmap_update_bits(pcf2127->regmap,
+						 pcf2127->cfg->ts[ts_id].inter_reg,
+						 pcf2127->cfg->ts[ts_id].inter_bit,
+						 0);
+			if (ret) {
+				dev_err(dev, "%s: update TS intermediate ret=%d\n", __func__, ret);
+				return ret;
+			}
 		}
 
 		ret = pcf2127_wdt_active_ping(&pcf2127->wdd);
@@ -605,34 +641,63 @@ static ssize_t timestamp0_store(struct device *dev,
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
+				  pcf2127->cfg->ts[ts_id].low_reg,
+				  &ctrl);
 		if (ret)
 			return 0;
 
-		if (!(ctrl1 & PCF2127_BIT_CTRL1_TSF1) &&
-		    !(ctrl2 & PCF2127_BIT_CTRL2_TSF2))
+		valid_low = ctrl & pcf2127->cfg->ts[ts_id].low_bit;
+
+		if (pcf2127->cfg->ts[ts_id].inter_bit) {
+			/* Check if TS input pin is driven to intermediate level
+			 * between GND and supply, if supported by variant.
+			 */
+			ret = regmap_read(pcf2127->regmap,
+					  pcf2127->cfg->ts[ts_id].inter_reg,
+					  &ctrl);
+			if (ret)
+				return 0;
+
+			valid_inter = ctrl & pcf2127->cfg->ts[ts_id].inter_bit;
+		}
+
+		if (!valid_low && !valid_inter)
 			return 0;
 
-		ret = pcf2127_rtc_ts_read(dev->parent, &ts);
+		ret = pcf2127_rtc_ts_read(dev->parent, &ts, ts_id);
 		if (ret)
 			return 0;
 
@@ -641,6 +706,12 @@ static ssize_t timestamp0_show(struct device *dev,
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
@@ -650,10 +721,6 @@ static struct attribute *pcf2127_attrs[] = {
 	NULL
 };
 
-static const struct attribute_group pcf2127_attr_group = {
-	.attrs	= pcf2127_attrs,
-};
-
 enum pcf21xx_type {
 	PCF2127,
 	PCF2129,
@@ -670,6 +737,19 @@ static struct pcf21xx_config pcf21xx_cfg[] = {
 		.reg_wd_ctl = PCF2127_REG_WD_CTL,
 		.reg_wd_val = PCF2127_REG_WD_VAL,
 		.reg_clkout = PCF2127_REG_CLKOUT,
+		.ts_count = 1,
+		.ts[0] = {
+			.regs_base = PCF2127_REG_TS1_BASE,
+			.low_reg   = PCF2127_REG_CTRL1,
+			.low_bit   = PCF2127_BIT_CTRL1_TSF1,
+			.inter_reg = PCF2127_REG_CTRL2,
+			.inter_bit = PCF2127_BIT_CTRL2_TSF2,
+			.ie_reg    = PCF2127_REG_CTRL2,
+			.ie_bit    = PCF2127_BIT_CTRL2_TSIE,
+		},
+		.attribute_group = {
+			.attrs	= pcf2127_attrs,
+		},
 	},
 	[PCF2129] = {
 		.max_register = 0x19,
@@ -680,15 +760,81 @@ static struct pcf21xx_config pcf21xx_cfg[] = {
 		.reg_wd_ctl = PCF2127_REG_WD_CTL,
 		.reg_wd_val = PCF2127_REG_WD_VAL,
 		.reg_clkout = PCF2127_REG_CLKOUT,
+		.ts_count = 1,
+		.ts[0] = {
+			.regs_base = PCF2127_REG_TS1_BASE,
+			.low_reg   = PCF2127_REG_CTRL1,
+			.low_bit   = PCF2127_BIT_CTRL1_TSF1,
+			.inter_reg = PCF2127_REG_CTRL2,
+			.inter_bit = PCF2127_BIT_CTRL2_TSF2,
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
+				 pcf2127->cfg->ts[ts_id].regs_base,
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
+	 * Make sure that low_bit is defined.
+	 */
+	if (pcf2127->cfg->ts[ts_id].low_bit == 0) {
+		dev_err(dev, "%s: tamper detection LOW configuration invalid\n",
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
 	struct pcf2127 *pcf2127;
 	int ret = 0;
 	unsigned int val;
+	int i;
 
 	dev_dbg(dev, "%s\n", __func__);
 
@@ -813,34 +959,15 @@ static int pcf2127_probe(struct device *dev, struct regmap *regmap,
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
+	for (i = 0; i < pcf2127->cfg->ts_count; i++) {
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

