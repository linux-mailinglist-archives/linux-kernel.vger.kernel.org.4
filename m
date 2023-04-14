Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5455D6E2062
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 12:12:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbjDNKM1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 06:12:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbjDNKMY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 06:12:24 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07236210B
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 03:12:21 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id o6-20020a05600c4fc600b003ef6e6754c5so7780790wmq.5
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 03:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1681467139; x=1684059139;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G1rEYNHDVxQfV6KJfQc7ooInBgmNYg9H7v5b1I7MMz4=;
        b=2QHGs6MK5Ex2B4DiWcHnp8OPftJyrqxB3p1UAAIufGoJCrl/HZX9dfHHpO352WY8pR
         /+t1k2+zDbV4mkBfZcP/M1cdp6ce3GNTxX1rzQH/Hu2Ygm3h3iUdm2rd/bC+CBfjDV2x
         zsbHOgkZ9qEKVqrUMSWvS0EAdxxypXefL9x8h210FLndwLRSAzkwIk8+eSUoDZm4j3qj
         1fDBE7uSjPNxziW632etdiqFRx6F3otPPrfg6ks5iy8BLdQWDf33T/Ll9ppFgfo0yPle
         7rLeyS3yf4oZP7hOAvwGIYE5o5clcn9nNmSHL87E+uWTknzHX9CCE3ki79jlxFC/a+pF
         i00g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681467139; x=1684059139;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G1rEYNHDVxQfV6KJfQc7ooInBgmNYg9H7v5b1I7MMz4=;
        b=YDfIwia58Wre9s+yyPtHSxbTgpmoNvFq67YzfuhJT1mMqokTYsybLNDHeIk09ioOqA
         P8dOE2QNVGKGwM/b7kVdgSrt4k3esalN036EMlDAY5HG3oLRiYGWdiywhfXxLELOhld3
         eSHTtEqmxp1FC8C+LQaxUrE0SE2UY5mUUUNwAvCyYep1eiQmPzb7X/s0OdcsKAuqLru3
         +QmMdbrPMHhWgD+dwwZRLhEbiQfMkePl9VKqoB3fmokqFkbV9j4Hf1ZqtOTqS+vKiie/
         esZrs4ZqRLsoVvu5obZ6Ce4ezWn67PtAL/DKB8to8g48KxiFkuBXy2NIZGqda4/QXZfF
         LHMw==
X-Gm-Message-State: AAQBX9dvU6wkpg9lAQ2L6xHf8qnv/a+8Knvi1OjWlD2cVRGzrNrnCpAa
        BCy41DTi58qi74xPPwWR1o7UJw==
X-Google-Smtp-Source: AKy350bz7AKgvBjYMIGlvZuDkcDUibGt6B33CFhuzdrLHZwAmMNK230EiD4fyVzeooQHN3Uu/0DpnA==
X-Received: by 2002:a05:600c:ce:b0:3f0:9ff5:79fb with SMTP id u14-20020a05600c00ce00b003f09ff579fbmr4019260wmm.39.1681467139345;
        Fri, 14 Apr 2023 03:12:19 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e34:eca6:27f0:42a5:8f07:826a:465d])
        by smtp.gmail.com with ESMTPSA id m10-20020a05600c3b0a00b003ef5e5f93f5sm7612923wms.19.2023.04.14.03.12.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 03:12:18 -0700 (PDT)
From:   Esteban Blanc <eblanc@baylibre.com>
To:     linus.walleij@linaro.org, lgirdwood@gmail.com, broonie@kernel.org,
        a.zummo@towertech.it, alexandre.belloni@bootlin.com
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-rtc@vger.kernel.org, jpanis@baylibre.com,
        jneanne@baylibre.com, aseketeli@baylibre.com, sterzik@ti.com,
        u-kumar1@ti.com
Subject: [PATCH v3 1/3] rtc: tps6594: add driver for TPS6594 PMIC RTC
Date:   Fri, 14 Apr 2023 12:12:15 +0200
Message-Id: <20230414101217.1342891-2-eblanc@baylibre.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230414101217.1342891-1-eblanc@baylibre.com>
References: <20230414101217.1342891-1-eblanc@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TPS6594 PMIC is a MFD driver. This adds support for the RTC found inside
TPS6594 family of PMIC.

Alarm is also supported.

Signed-off-by: Esteban Blanc <eblanc@baylibre.com>
---
 drivers/rtc/Kconfig       |   9 +
 drivers/rtc/Makefile      |   1 +
 drivers/rtc/rtc-tps6594.c | 473 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 483 insertions(+)
 create mode 100644 drivers/rtc/rtc-tps6594.c

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index 5a71579af0a1..e5614a570d7e 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -578,6 +578,15 @@ config RTC_DRV_TPS6586X
 	  along with alarm. This driver supports the RTC driver for
 	  the TPS6586X RTC module.
 
+config RTC_DRV_TPS6594
+	tristate "TI TPS6594 RTC driver"
+	depends on MFD_TPS6594
+	default MFD_TPS6594
+	help
+	  TI Power Management IC TPS6594 supports RTC functionality
+	  along with alarm. This driver supports the RTC driver for
+	  the TPS6594 RTC module.
+
 config RTC_DRV_TPS65910
 	tristate "TI TPS65910 RTC driver"
 	depends on MFD_TPS65910
diff --git a/drivers/rtc/Makefile b/drivers/rtc/Makefile
index ea445d1ebb17..3d3f8c9d0697 100644
--- a/drivers/rtc/Makefile
+++ b/drivers/rtc/Makefile
@@ -175,6 +175,7 @@ obj-$(CONFIG_RTC_DRV_TEGRA)	+= rtc-tegra.o
 obj-$(CONFIG_RTC_DRV_TEST)	+= rtc-test.o
 obj-$(CONFIG_RTC_DRV_TI_K3)	+= rtc-ti-k3.o
 obj-$(CONFIG_RTC_DRV_TPS6586X)	+= rtc-tps6586x.o
+obj-$(CONFIG_RTC_DRV_TPS6594)	+= rtc-tps6594.o
 obj-$(CONFIG_RTC_DRV_TPS65910)	+= rtc-tps65910.o
 obj-$(CONFIG_RTC_DRV_TWL4030)	+= rtc-twl.o
 obj-$(CONFIG_RTC_DRV_VT8500)	+= rtc-vt8500.o
diff --git a/drivers/rtc/rtc-tps6594.c b/drivers/rtc/rtc-tps6594.c
new file mode 100644
index 000000000000..f430592312e6
--- /dev/null
+++ b/drivers/rtc/rtc-tps6594.c
@@ -0,0 +1,473 @@
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
+/*
+ * Min and max values supported with 'offset' interface (swapped sign)
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
+	/*
+	 * Set GET_TIME to 0. This way, next time we set GET_TIME to 1 we are sure to store an
+	 * up-to-date timestamp
+	 */
+	ret = regmap_clear_bits(tps->regmap, TPS6594_REG_RTC_CTRL_1,
+				TPS6594_BIT_GET_TIME);
+	if (ret < 0)
+		return ret;
+
+	/*
+	 * Copy content of RTC registers to shadow registers or latches to read a coherent
+	 * timestamp
+	 */
+	return regmap_set_bits(tps->regmap, TPS6594_REG_RTC_CTRL_1,
+			       TPS6594_BIT_GET_TIME);
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
+	/* Check if RTC is running. */
+	ret = regmap_test_bits(tps->regmap, TPS6594_REG_RTC_STATUS,
+			       TPS6594_BIT_RUN);
+	if (ret < 0)
+		return ret;
+	if (ret == 0)
+		return -EINVAL;
+
+	ret = tps6594_rtc_shadow_timestamp(dev, tps);
+	if (ret < 0)
+		return ret;
+
+	/* Read shadowed RTC registers */
+	ret = regmap_bulk_read(tps->regmap, TPS6594_REG_RTC_SECONDS, rtc_data,
+			       NUM_TIME_REGS);
+	if (ret < 0)
+		return ret;
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
+	if (ret < 0)
+		return ret;
+
+	/* Update all the time registers in one shot */
+	ret = regmap_bulk_write(tps->regmap, TPS6594_REG_RTC_SECONDS, rtc_data,
+				NUM_TIME_REGS);
+	if (ret < 0)
+		return ret;
+
+	/* Start back RTC */
+	return regmap_set_bits(tps->regmap, TPS6594_REG_RTC_CTRL_1,
+			       TPS6594_BIT_STOP_RTC);
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
+	if (ret < 0)
+		return ret;
+
+	alm->time.tm_sec = bcd2bin(alarm_data[0]);
+	alm->time.tm_min = bcd2bin(alarm_data[1]);
+	alm->time.tm_hour = bcd2bin(alarm_data[2]);
+	alm->time.tm_mday = bcd2bin(alarm_data[3]);
+	alm->time.tm_mon = bcd2bin(alarm_data[4]) - 1;
+	alm->time.tm_year = bcd2bin(alarm_data[5]) + 100;
+
+	ret = regmap_read(tps->regmap, TPS6594_REG_RTC_INTERRUPTS, &int_val);
+	if (ret < 0)
+		return ret;
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
+	if (ret)
+		return ret;
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
+	if (ret < 0)
+		return ret;
+
+	if (alm->enabled)
+		ret = tps6594_rtc_alarm_irq_enable(dev, 1);
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
+	if (ret < 0)
+		return ret;
+
+	/* Enable automatic compensation */
+	return regmap_set_bits(tps->regmap, TPS6594_REG_RTC_CTRL_1,
+			       TPS6594_BIT_AUTO_COMP);
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
+	if (ret < 0)
+		return ret;
+
+	/* If automatic compensation is not enabled report back zero */
+	if (!(ctrl & TPS6594_BIT_AUTO_COMP)) {
+		*calibration = 0;
+		return 0;
+	}
+
+	ret = regmap_bulk_read(tps->regmap, TPS6594_REG_RTC_COMP_LSB, comp_data,
+			       NUM_COMP_REGS);
+	if (ret < 0)
+		return ret;
+
+	value = (u16)comp_data[0] | ((u16)comp_data[1] << 8);
+
+	*calibration = (s16)value;
+
+	return ret;
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
+	/*
+	 * Offset value operates in negative way, so swap sign.
+	 * See 8.3.10.5, (32768 - COMP_REG)
+	 */
+	*offset = (long)-tmp;
+
+	return ret;
+}
+
+static int tps6594_rtc_set_offset(struct device *dev, long offset)
+{
+	int calibration;
+	s64 tmp;
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
+	return tps6594_rtc_set_calibration(dev, calibration);
+}
+
+static irqreturn_t tps6594_rtc_interrupt(int irq, void *rtc)
+{
+	struct device *dev = rtc;
+	unsigned long events = 0;
+	struct tps6594 *tps = dev_get_drvdata(dev->parent);
+	struct rtc_device *rtc_dev = dev_get_drvdata(dev);
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
+	rtc_update_irq(rtc_dev, 1, events);
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
+	struct tps6594 *tps;
+	struct rtc_device *rtc;
+	int irq;
+	int ret;
+
+	tps = dev_get_drvdata(pdev->dev.parent);
+
+	rtc = devm_kzalloc(&pdev->dev, sizeof(*rtc), GFP_KERNEL);
+	if (!rtc)
+		return -ENOMEM;
+
+	rtc = devm_rtc_allocate_device(&pdev->dev);
+	if (IS_ERR(rtc))
+		return PTR_ERR(rtc);
+
+	/* Enable crystal oscillator */
+	ret = regmap_set_bits(tps->regmap, TPS6594_REG_RTC_CTRL_2,
+			      TPS6594_BIT_XTAL_EN);
+	if (ret < 0)
+		return ret;
+
+	ret = regmap_test_bits(tps->regmap, TPS6594_REG_RTC_STATUS,
+			       TPS6594_BIT_RUN);
+	if (ret < 0)
+		return ret;
+	/* RTC not running */
+	if (ret == 0) {
+		/* Start rtc */
+		ret = regmap_set_bits(tps->regmap, TPS6594_REG_RTC_CTRL_1,
+				      TPS6594_BIT_STOP_RTC);
+		if (ret < 0)
+			return ret;
+
+		mdelay(100);
+
+		/*
+		 * RTC should be running now. Check if this is the case.
+		 * If not it might be a missing oscillator.
+		 */
+		ret = regmap_test_bits(tps->regmap, TPS6594_REG_RTC_STATUS,
+				       TPS6594_BIT_RUN);
+		if (ret < 0)
+			return ret;
+		if (ret == 0)
+			return -ENODEV;
+
+		/* Stop RTC until first call to `tps6594_rtc_set_time */
+		ret = regmap_clear_bits(tps->regmap, TPS6594_REG_RTC_CTRL_1,
+					TPS6594_BIT_STOP_RTC);
+		if (ret < 0)
+			return ret;
+	}
+
+	platform_set_drvdata(pdev, rtc);
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
+	rtc->ops = &tps6594_rtc_ops;
+	rtc->range_min = RTC_TIMESTAMP_BEGIN_2000;
+	rtc->range_max = RTC_TIMESTAMP_END_2099;
+
+	return devm_rtc_register_device(rtc);
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
2.39.2

