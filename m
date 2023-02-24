Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F83C6A1D04
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 14:31:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230007AbjBXNbk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 08:31:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbjBXNbh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 08:31:37 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64DB74A1D9
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 05:31:33 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id az36so1827584wmb.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 05:31:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1677245492;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yoniXrMAMCP1ygXvpYDpat9bf0ssCt2SLlyt+NFABPo=;
        b=N2LRUjZLdttLYVWwSQ+Qb+uQjRaJVVOuaSb+azySZDFZGlWMoqKxP3cvUIQPgCiycJ
         LcQihuiuIQCoJKT+YpEVQ9Clu+mAmQlBUsueXVDz+/KDUSopoW0Gn582H49I0ckj93fk
         AjwVx4lFVBFCHK4Mufce6jHIfoTjs1uPO6ewzyBFplaUICMb0Dd29hySPEkYpTgo5jeT
         0mplG4gxz1ZUea6VGbINjdeF22NxAxqx/JKiFzUer3peJyTNOBiuqXGNy/KP+8IgxCw9
         rECdYtZRxk1nqkSjlyqUbLJwh3MOiSJVHm0S/sUVCdWAGA2rUIchQpnXybVjO1wGdbpW
         MUqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677245492;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yoniXrMAMCP1ygXvpYDpat9bf0ssCt2SLlyt+NFABPo=;
        b=Si8RJd8YZAFaURKNaHbAoKrXH8MH7AXh+vcfK7JMPDnnqVepOJMt1RveRAgeVPOIWG
         zymDRki6rsYH8kkZSTMg+9a88c0u3zlhH5P0seqPk+kvt1pptEkmBddmT1hqNFyPaT2W
         tRN49yLv3js9M98cGMoklPAyzThiGc7q2VKIlaQdq6k7Yseo2X3dv3M9dpazdba0Mxgh
         NRnbK3SauxGnn8YEENBMffPddwMsNYssl5y50ydDRlhAw/uu8SWasB9k0wppDIeAHTq1
         jv+dh1zEY3Ibf200HgxXW9RIrks/sgzeQTFV7FDhrhsMBhuXzaA4AYk75kF3auiCaqWZ
         NnPw==
X-Gm-Message-State: AO0yUKVI3aztOc04vZx7tFbW6NovseDrlO14dMtsmQJOisfgDCJRAKIC
        uYEFWy3N+hipaOt7TQTCVO7rvw==
X-Google-Smtp-Source: AK7set8KhmdSLDLrap5U721LvZMJFmsNPMFod4er9hFMe0xX2IiOZU+nnSlAJjMKwe1pC00LGGghgQ==
X-Received: by 2002:a05:600c:198e:b0:3df:9858:c037 with SMTP id t14-20020a05600c198e00b003df9858c037mr13460121wmq.12.1677245491846;
        Fri, 24 Feb 2023 05:31:31 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:28d:66d0:5e4:476:5145:2ad1])
        by smtp.gmail.com with ESMTPSA id o25-20020a05600c511900b003dfe549da4fsm3308735wms.18.2023.02.24.05.31.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 05:31:31 -0800 (PST)
From:   Esteban Blanc <eblanc@baylibre.com>
To:     linus.walleij@linaro.org, lgirdwood@gmail.com, broonie@kernel.org,
        a.zummo@towertech.it, alexandre.belloni@bootlin.com
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-rtc@vger.kernel.org, jpanis@baylibre.com,
        jneanne@baylibre.com
Subject: [PATCH INTERNAL v1 1/3] rtc: tps6594: add driver for TPS6594 PMIC RTC
Date:   Fri, 24 Feb 2023 14:31:27 +0100
Message-Id: <20230224133129.887203-2-eblanc@baylibre.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230224133129.887203-1-eblanc@baylibre.com>
References: <20230224133129.887203-1-eblanc@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TPS6594 PMIC is a MFD driver. This add support for the RTC found inside
TPS6594 family of PMIC.

Alarm is also supported.

Signed-off-by: Esteban Blanc <eblanc@baylibre.com>
---
 drivers/rtc/Kconfig       |   8 +
 drivers/rtc/Makefile      |   1 +
 drivers/rtc/rtc-tps6594.c | 516 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 525 insertions(+)
 create mode 100644 drivers/rtc/rtc-tps6594.c

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index 677d2601d305..34c63555669d 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -578,6 +578,14 @@ config RTC_DRV_TPS6586X
 	  along with alarm. This driver supports the RTC driver for
 	  the TPS6586X RTC module.
 
+config RTC_DRV_TPS6594
+	tristate "TI TPS6594 RTC driver"
+	depends on MFD_TPS6594
+	help
+	  TI Power Management IC TPS6594 supports RTC functionality
+	  along with alarm. This driver supports the RTC driver for
+	  the TPS6594 RTC module.
+
 config RTC_DRV_TPS65910
 	tristate "TI TPS65910 RTC driver"
 	depends on MFD_TPS65910
diff --git a/drivers/rtc/Makefile b/drivers/rtc/Makefile
index d3c042dcbc73..7dbeec711ad5 100644
--- a/drivers/rtc/Makefile
+++ b/drivers/rtc/Makefile
@@ -174,6 +174,7 @@ obj-$(CONFIG_RTC_DRV_TEGRA)	+= rtc-tegra.o
 obj-$(CONFIG_RTC_DRV_TEST)	+= rtc-test.o
 obj-$(CONFIG_RTC_DRV_TI_K3)	+= rtc-ti-k3.o
 obj-$(CONFIG_RTC_DRV_TPS6586X)	+= rtc-tps6586x.o
+obj-$(CONFIG_RTC_DRV_TPS6594)	+= rtc-tps6594.o
 obj-$(CONFIG_RTC_DRV_TPS65910)	+= rtc-tps65910.o
 obj-$(CONFIG_RTC_DRV_TWL4030)	+= rtc-twl.o
 obj-$(CONFIG_RTC_DRV_V3020)	+= rtc-v3020.o
diff --git a/drivers/rtc/rtc-tps6594.c b/drivers/rtc/rtc-tps6594.c
new file mode 100644
index 000000000000..f150ef33f65f
--- /dev/null
+++ b/drivers/rtc/rtc-tps6594.c
@@ -0,0 +1,516 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * RTC driver for tps6594 PMIC
+ *
+ * Copyright (C) 2022 BayLibre Incorporated - https://www.baylibre.com/
+ */
+
+#include <linux/bcd.h>
+#include <linux/errno.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <linux/math64.h>
+#include <linux/module.h>
+#include <linux/rtc.h>
+#include <linux/types.h>
+#include <linux/platform_device.h>
+#include <linux/property.h>
+
+#include <linux/mfd/tps6594.h>
+
+struct tps6594_rtc {
+	struct rtc_device *rtc;
+};
+
+#define TPS6594_GET_TIME_ON TPS6594_BIT_GET_TIME
+#define TPS6594_GET_TIME_OFF 0
+#define TPS6594_IT_ALARM_ON TPS6594_BIT_IT_ALARM
+#define TPS6594_IT_ALARM_OFF 0
+#define TPS6594_AUTO_COMP_ON TPS6594_BIT_IT_ALARM
+
+/* Total number of RTC registers needed to set time*/
+#define NUM_TIME_REGS (TPS6594_REG_RTC_WEEKS - TPS6594_REG_RTC_SECONDS + 1)
+
+/* Total number of RTC alarm register */
+#define NUM_TIME_ALARM_REGS (NUM_TIME_REGS - 1)
+
+/* Total number of RTC registers needed to set compensation registers */
+#define NUM_COMP_REGS (TPS6594_REG_RTC_COMP_MSB - TPS6594_REG_RTC_COMP_LSB + 1)
+
+/* Min and max values supported with 'offset' interface (swapped sign)
+ * After conversion, the values does not exceed the range [-32767, 33767] which COMP_REG must
+ * conform to
+ */
+#define MIN_OFFSET (-277774)
+#define MAX_OFFSET (277774)
+
+/* Number of ticks per hour */
+#define TICKS_PER_HOUR (32768 * 3600)
+
+/* Multiplier for ppb conversions */
+#define PPB_MULT (1000000000LL)
+
+static int tps6594_rtc_alarm_irq_enable(struct device *dev,
+					unsigned int enabled)
+{
+	struct tps6594 *tps = dev_get_drvdata(dev->parent);
+	u8 val = 0;
+	int ret;
+
+	val = enabled ? TPS6594_IT_ALARM_ON : TPS6594_IT_ALARM_OFF;
+
+	ret = regmap_update_bits(tps->regmap, TPS6594_REG_RTC_INTERRUPTS,
+				 TPS6594_BIT_IT_ALARM, val);
+
+	return ret;
+}
+
+/* Pulse GET_TIME field of RTC_CTRL_1 to store a timestamp in shadow registers */
+static int tps6594_rtc_shadow_timestamp(struct device *dev, struct tps6594 *tps)
+{
+	int ret;
+
+	/* Set GET_TIME to 0. This way, next time we set GET_TIME to 1 we are sure to store an
+	 * up-to-date timestamp
+	 */
+	ret = regmap_clear_bits(tps->regmap, TPS6594_REG_RTC_CTRL_1,
+				TPS6594_BIT_GET_TIME);
+	if (ret < 0) {
+		dev_err(dev, "RTC CTRL1 reg update failed with err:%d\n", ret);
+		return ret;
+	}
+
+	/* Copy content of RTC registers to shadow registers or latches to read a coherent
+	 *  timestamp
+	 */
+	ret = regmap_set_bits(tps->regmap, TPS6594_REG_RTC_CTRL_1,
+			      TPS6594_BIT_GET_TIME);
+	if (ret < 0) {
+		dev_err(dev, "RTC CTRL1 reg update failed with err:%d\n", ret);
+		return ret;
+	}
+
+	return ret;
+}
+
+/*
+ * Gets current tps6594 RTC time and date parameters.
+ *
+ * The RTC's time/alarm representation is not what gmtime(3) requires
+ * Linux to use:
+ *
+ *  - Months are 1..12 vs Linux 0-11
+ *  - Years are 0..99 vs Linux 1900..N (we assume 21st century)
+ */
+static int tps6594_rtc_read_time(struct device *dev, struct rtc_time *tm)
+{
+	unsigned char rtc_data[NUM_TIME_REGS];
+	struct tps6594 *tps = dev_get_drvdata(dev->parent);
+	int ret;
+
+	ret = tps6594_rtc_shadow_timestamp(dev, tps);
+	if (ret < 0) {
+		dev_err(dev,
+			"failed to store a timestamp in shadow registers:%d\n",
+			ret);
+		return ret;
+	}
+
+	/* Read shadowed RTC registers */
+	ret = regmap_bulk_read(tps->regmap, TPS6594_REG_RTC_SECONDS, rtc_data,
+			       NUM_TIME_REGS);
+	if (ret < 0) {
+		dev_err(dev, "rtc_read_time failed with error :%d\n", ret);
+		return ret;
+	}
+
+	tm->tm_sec = bcd2bin(rtc_data[0]);
+	tm->tm_min = bcd2bin(rtc_data[1]);
+	tm->tm_hour = bcd2bin(rtc_data[2]);
+	tm->tm_mday = bcd2bin(rtc_data[3]);
+	tm->tm_mon = bcd2bin(rtc_data[4]) - 1;
+	tm->tm_year = bcd2bin(rtc_data[5]) + 100;
+	tm->tm_wday = bcd2bin(rtc_data[6]);
+
+	return ret;
+}
+
+/*
+ * Sets current tps6594 RTC time and date parameters.
+ *
+ * The RTC's time/alarm representation is not what gmtime(3) requires
+ * Linux to use:
+ *
+ *  - Months are 1..12 vs Linux 0-11
+ *  - Years are 0..99 vs Linux 1900..N (we assume 21st century)
+ */
+static int tps6594_rtc_set_time(struct device *dev, struct rtc_time *tm)
+{
+	unsigned char rtc_data[NUM_TIME_REGS];
+	struct tps6594 *tps = dev_get_drvdata(dev->parent);
+	int ret;
+
+	rtc_data[0] = bin2bcd(tm->tm_sec);
+	rtc_data[1] = bin2bcd(tm->tm_min);
+	rtc_data[2] = bin2bcd(tm->tm_hour);
+	rtc_data[3] = bin2bcd(tm->tm_mday);
+	rtc_data[4] = bin2bcd(tm->tm_mon + 1);
+	rtc_data[5] = bin2bcd(tm->tm_year - 100);
+	rtc_data[6] = bin2bcd(tm->tm_wday);
+
+	/* Stop RTC while updating the RTC time registers */
+	ret = regmap_clear_bits(tps->regmap, TPS6594_REG_RTC_CTRL_1,
+				TPS6594_BIT_STOP_RTC);
+	if (ret < 0) {
+		dev_err(dev, "RTC stop failed: %d\n", ret);
+		return ret;
+	}
+
+	/* Update all the time registers in one shot */
+	ret = regmap_bulk_write(tps->regmap, TPS6594_REG_RTC_SECONDS, rtc_data,
+				NUM_TIME_REGS);
+	if (ret < 0) {
+		dev_err(dev, "rtc_set_time failed: %d\n", ret);
+		return ret;
+	}
+
+	/* Start back RTC */
+	ret = regmap_set_bits(tps->regmap, TPS6594_REG_RTC_CTRL_1,
+			      TPS6594_BIT_STOP_RTC);
+	if (ret < 0)
+		dev_err(dev, "RTC start failed: %d\n", ret);
+
+	return ret;
+}
+
+/*
+ * Gets current tps6594 RTC alarm time.
+ */
+static int tps6594_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alm)
+{
+	unsigned char alarm_data[NUM_TIME_ALARM_REGS];
+	u32 int_val;
+	struct tps6594 *tps = dev_get_drvdata(dev->parent);
+	int ret;
+
+	ret = regmap_bulk_read(tps->regmap, TPS6594_REG_ALARM_SECONDS,
+			       alarm_data, NUM_TIME_ALARM_REGS);
+	if (ret < 0) {
+		dev_err(dev, "rtc_read_alarm failed read alarm registers: %d\n",
+			ret);
+		return ret;
+	}
+
+	alm->time.tm_sec = bcd2bin(alarm_data[0]);
+	alm->time.tm_min = bcd2bin(alarm_data[1]);
+	alm->time.tm_hour = bcd2bin(alarm_data[2]);
+	alm->time.tm_mday = bcd2bin(alarm_data[3]);
+	alm->time.tm_mon = bcd2bin(alarm_data[4]) - 1;
+	alm->time.tm_year = bcd2bin(alarm_data[5]) + 100;
+
+	ret = regmap_read(tps->regmap, TPS6594_REG_RTC_INTERRUPTS, &int_val);
+	if (ret < 0) {
+		dev_err(dev, "rtc_read_alarm failed to read alarm status: %d\n",
+			ret);
+		return ret;
+	}
+
+	alm->enabled = int_val & TPS6594_BIT_IT_ALARM ? 1 : 0;
+
+	return ret;
+}
+
+static int tps6594_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alm)
+{
+	unsigned char alarm_data[NUM_TIME_ALARM_REGS];
+	struct tps6594 *tps = dev_get_drvdata(dev->parent);
+	int ret;
+
+	/* Disable alarm irq before changing the alarm timestamp */
+	ret = tps6594_rtc_alarm_irq_enable(dev, 0);
+	if (ret) {
+		dev_err(dev, "rtc_set_alarm failed to disable alarm: %d\n",
+			ret);
+		return ret;
+	}
+
+	alarm_data[0] = bin2bcd(alm->time.tm_sec);
+	alarm_data[1] = bin2bcd(alm->time.tm_min);
+	alarm_data[2] = bin2bcd(alm->time.tm_hour);
+	alarm_data[3] = bin2bcd(alm->time.tm_mday);
+	alarm_data[4] = bin2bcd(alm->time.tm_mon + 1);
+	alarm_data[5] = bin2bcd(alm->time.tm_year - 100);
+
+	/* Update all the alarm registers in one shot */
+	ret = regmap_bulk_write(tps->regmap, TPS6594_REG_ALARM_SECONDS,
+				alarm_data, NUM_TIME_ALARM_REGS);
+	if (ret) {
+		dev_err(dev,
+			"rtc_set_alarm failed to write alarm registers: %d\n",
+			ret);
+		return ret;
+	}
+
+	if (alm->enabled) {
+		ret = tps6594_rtc_alarm_irq_enable(dev, 1);
+		if (ret < 0) {
+			dev_err(dev,
+				"rtc_set_alarm failed to re-enable the alarm: %d\n",
+				ret);
+			return ret;
+		}
+	}
+
+	return ret;
+}
+
+static int tps6594_rtc_set_calibration(struct device *dev, int calibration)
+{
+	unsigned char comp_data[NUM_COMP_REGS];
+	struct tps6594 *tps = dev_get_drvdata(dev->parent);
+	s16 value;
+	int ret;
+
+	/*
+	 * TPS6594 uses two's complement 16 bit value for compensation for RTC
+	 * crystal inaccuracies. One time every hour when seconds counter
+	 * increments from 0 to 1 compensation value will be added to internal
+	 * RTC counter value.
+	 *
+	 *
+	 * Valid range for compensation value: [-32767 .. 32767]
+	 */
+	if (calibration < -32767 || calibration > 32767) {
+		dev_err(dev, "RTC calibration value out of range: %d\n",
+			calibration);
+		return -EINVAL;
+	}
+
+	value = (s16)calibration;
+
+	comp_data[0] = (u16)value & 0xFF;
+	comp_data[1] = ((u16)value >> 8) & 0xFF;
+
+	/* Update all the compensation registers in one shot */
+	ret = regmap_bulk_write(tps->regmap, TPS6594_REG_RTC_COMP_LSB,
+				comp_data, NUM_COMP_REGS);
+	if (ret < 0) {
+		dev_err(dev,
+			"rtc_set_calibration failed to write compensation value: %d\n",
+			ret);
+		return ret;
+	}
+
+	/* Enable automatic compensation */
+	ret = regmap_set_bits(tps->regmap, TPS6594_REG_RTC_CTRL_1,
+			      TPS6594_BIT_AUTO_COMP);
+	if (ret < 0)
+		dev_err(dev,
+			"rtc_set_calibration failed to enable auto_comp: %d\n",
+			ret);
+
+	return ret;
+}
+
+static int tps6594_rtc_get_calibration(struct device *dev, int *calibration)
+{
+	unsigned char comp_data[NUM_COMP_REGS];
+	struct tps6594 *tps = dev_get_drvdata(dev->parent);
+	unsigned int ctrl;
+	u16 value;
+	int ret;
+
+	ret = regmap_read(tps->regmap, TPS6594_REG_RTC_CTRL_1, &ctrl);
+	if (ret < 0) {
+		dev_err(dev,
+			"rtc_get_calibration failed to read control register 1: %d\n",
+			ret);
+		return ret;
+	}
+
+	/* If automatic compensation is not enabled report back zero */
+	if (!(ctrl & TPS6594_BIT_AUTO_COMP)) {
+		*calibration = 0;
+		return 0;
+	}
+
+	ret = regmap_bulk_read(tps->regmap, TPS6594_REG_RTC_COMP_LSB, comp_data,
+			       NUM_COMP_REGS);
+	if (ret < 0) {
+		dev_err(dev,
+			"rtc_get_calibration failed to read compensation registers: %d\n",
+			ret);
+		return ret;
+	}
+
+	value = (u16)comp_data[0] | ((u16)comp_data[1] << 8);
+
+	*calibration = (s16)value;
+
+	return 0;
+}
+
+static int tps6594_rtc_read_offset(struct device *dev, long *offset)
+{
+	int calibration;
+	s64 tmp;
+	int ret;
+
+	ret = tps6594_rtc_get_calibration(dev, &calibration);
+	if (ret < 0)
+		return ret;
+
+	/* Convert from RTC calibration register format to ppb format */
+	tmp = calibration * (s64)PPB_MULT;
+	if (tmp < 0)
+		tmp -= TICKS_PER_HOUR / 2LL;
+	else
+		tmp += TICKS_PER_HOUR / 2LL;
+	tmp = div_s64(tmp, TICKS_PER_HOUR);
+
+	/* Offset value operates in negative way, so swap sign.
+	 * See 8.3.10.5, (32768 - COMP_REG)
+	 */
+	*offset = (long)-tmp;
+
+	return 0;
+}
+
+static int tps6594_rtc_set_offset(struct device *dev, long offset)
+{
+	int calibration;
+	s64 tmp;
+	int ret;
+
+	/* Make sure offset value is within supported range */
+	if (offset < MIN_OFFSET || offset > MAX_OFFSET)
+		return -ERANGE;
+
+	/* Convert from ppb format to RTC calibration register format */
+	tmp = offset * (s64)TICKS_PER_HOUR;
+	if (tmp < 0)
+		tmp -= PPB_MULT / 2LL;
+	else
+		tmp += PPB_MULT / 2LL;
+	tmp = div_s64(tmp, PPB_MULT);
+
+	/* Offset value operates in negative way, so swap sign */
+	calibration = (int)-tmp;
+
+	ret = tps6594_rtc_set_calibration(dev, calibration);
+
+	return ret;
+}
+
+static irqreturn_t tps6594_rtc_interrupt(int irq, void *rtc)
+{
+	struct device *dev = rtc;
+	unsigned long events = 0;
+	struct tps6594 *tps = dev_get_drvdata(dev->parent);
+	struct tps6594_rtc *tps_rtc = dev_get_drvdata(dev);
+	int ret;
+	u32 rtc_reg;
+
+	ret = regmap_read(tps->regmap, TPS6594_REG_RTC_STATUS, &rtc_reg);
+	if (ret)
+		return IRQ_NONE;
+
+	if (rtc_reg & TPS6594_BIT_ALARM)
+		events = RTC_IRQF | RTC_AF;
+
+	/* Notify RTC core on event */
+	rtc_update_irq(tps_rtc->rtc, 1, events);
+
+	return IRQ_HANDLED;
+}
+
+static const struct rtc_class_ops tps6594_rtc_ops = {
+	.read_time = tps6594_rtc_read_time,
+	.set_time = tps6594_rtc_set_time,
+	.read_alarm = tps6594_rtc_read_alarm,
+	.set_alarm = tps6594_rtc_set_alarm,
+	.alarm_irq_enable = tps6594_rtc_alarm_irq_enable,
+	.read_offset = tps6594_rtc_read_offset,
+	.set_offset = tps6594_rtc_set_offset,
+};
+
+static int tps6594_rtc_probe(struct platform_device *pdev)
+{
+	struct tps6594 *tps6594;
+	struct tps6594_rtc *tps_rtc;
+	int irq;
+	int ret;
+
+	tps6594 = dev_get_drvdata(pdev->dev.parent);
+
+	tps_rtc = devm_kzalloc(&pdev->dev, sizeof(struct tps6594_rtc),
+			       GFP_KERNEL);
+	if (!tps_rtc)
+		return -ENOMEM;
+
+	tps_rtc->rtc = devm_rtc_allocate_device(&pdev->dev);
+	if (IS_ERR(tps_rtc->rtc))
+		return PTR_ERR(tps_rtc->rtc);
+
+	/* Enable crystal oscillator */
+	ret = regmap_set_bits(tps6594->regmap, TPS6594_REG_RTC_CTRL_2,
+			      TPS6594_BIT_XTAL_EN);
+	if (ret < 0)
+		return ret;
+
+	/* Start rtc */
+	ret = regmap_set_bits(tps6594->regmap, TPS6594_REG_RTC_CTRL_1,
+			      TPS6594_BIT_STOP_RTC);
+	if (ret < 0)
+		return ret;
+
+	mdelay(100);
+
+	/*
+	 * RTC should be running now. Check if this is the case.
+	 * If not it might be a missing oscillator.
+	 */
+	ret = regmap_test_bits(tps6594->regmap, TPS6594_REG_RTC_STATUS,
+			       TPS6594_BIT_RUN);
+	if (ret < 0)
+		return ret;
+	if (ret == 0)
+		return -ENODEV;
+
+	platform_set_drvdata(pdev, tps_rtc);
+
+	irq = platform_get_irq_byname(pdev, TPS6594_IRQ_NAME_ALARM);
+	if (irq < 0) {
+		dev_err(&pdev->dev, "Failed to get irq\n");
+		return irq;
+	}
+
+	ret = devm_request_threaded_irq(&pdev->dev, irq, NULL,
+					tps6594_rtc_interrupt, IRQF_ONESHOT,
+					TPS6594_IRQ_NAME_ALARM, &pdev->dev);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "Failed to request_threaded_irq\n");
+		return ret;
+	}
+
+	tps_rtc->rtc->ops = &tps6594_rtc_ops;
+	tps_rtc->rtc->range_min = RTC_TIMESTAMP_BEGIN_2000;
+	tps_rtc->rtc->range_max = RTC_TIMESTAMP_END_2099;
+
+	return devm_rtc_register_device(tps_rtc->rtc);
+}
+
+static struct platform_driver tps6594_rtc_driver = {
+	.probe		= tps6594_rtc_probe,
+	.driver		= {
+		.name	= "tps6594-rtc",
+	},
+};
+
+module_platform_driver(tps6594_rtc_driver);
+
+MODULE_ALIAS("platform:tps6594-rtc");
+MODULE_AUTHOR("Esteban Blanc <eblanc@baylibre.com>");
+MODULE_DESCRIPTION("TPS6594 RTC driver");
+MODULE_LICENSE("GPL");
-- 
2.38.1

