Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56AB670C37A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 18:32:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232927AbjEVQbv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 12:31:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230168AbjEVQbp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 12:31:45 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36C6D1A8
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 09:31:20 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-30a8c4afa46so1279871f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 09:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1684773078; x=1687365078;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aeRgb+2IQy9YLMHOmM6dxmEYQ6o/TExWO2LvlYPralc=;
        b=R2eRSweNwYOScNlU7dswEK45UIIszWqs7q0bCnbr3woXVjK/ReorWE3SV/i2p3ZH1z
         XFAsiXifP//oau8aAu8oukC3pLtOOE+WxViVYpJuhHgIJf1HpWQ4Vpo+nAFyqY3gBr64
         jLnnw76COtiPuDZnGFWhUk/3SHGYLet4O/yfzqnD+NAzm9l1x7HXlUwQV5DEGNggCJiS
         vy422Z7jRUF2TtCJxH8eqxst+ngskqg9RajRTqhnbal+KbwaQq/ciU8aNdoMfCMKsjjS
         3Uz/tff47qqqmyRaWwPK/zXZDMoMC3e+C1PhLMYI8ECrb/yVZtCgJMzSLA35VUXISgZZ
         LxyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684773078; x=1687365078;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aeRgb+2IQy9YLMHOmM6dxmEYQ6o/TExWO2LvlYPralc=;
        b=lQLu/Ne6N19aY0NcFlwFTZDZMGRoM1djObPYEW4h/hzwhxQnIiMjvmqTHAN/8qWB/a
         ZBN9v4BqFS4y6sejMdPG6CkBqWOR3ZfmMOlXC2jN+YghFe1AhmP6xBVxR0JAt0LtsFjG
         RkWMU1xv+Ls7761FTfM2akIVN4c3Pjpq6sjULt3HnMHbrJt+QQbBO54y44urm+up7BeQ
         VheMJCLsfCL2gn0kEnXl+Ne7e1y4lbaAAa888vtknKK+tsRVf6NCMWEfxX4onqFhI0G8
         euWKQf/Omh2rVF9SqyN8GigfnUX12NI5gyZew7HM1+WZ0y2EyZtA4uEmaBHVGzb8wPmX
         KUBw==
X-Gm-Message-State: AC+VfDxW/VszOvtDuAXENByOEj02rkTVoyUiSSAv3lRTVzXnlRa/3yeE
        MNlqxPo920TiTk2Dz5/hHdXPhQ==
X-Google-Smtp-Source: ACHHUZ4FqLn8QWNKwqXBi93vrruT9FCt4VR8KVinpAq4kslwjjH7GnGdirsqupXNVea819//36CFrQ==
X-Received: by 2002:adf:dbc7:0:b0:306:3352:5b8c with SMTP id e7-20020adfdbc7000000b0030633525b8cmr8948912wrj.7.1684773077795;
        Mon, 22 May 2023 09:31:17 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:28d:66d0:72d:52cc:8221:fcda])
        by smtp.gmail.com with ESMTPSA id y10-20020adff6ca000000b002f103ca90cdsm8152677wrp.101.2023.05.22.09.31.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 09:31:17 -0700 (PDT)
From:   Esteban Blanc <eblanc@baylibre.com>
To:     linus.walleij@linaro.org, lgirdwood@gmail.com, broonie@kernel.org,
        a.zummo@towertech.it, alexandre.belloni@bootlin.com
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-rtc@vger.kernel.org, jpanis@baylibre.com,
        jneanne@baylibre.com, aseketeli@baylibre.com, eblanc@baylibre.com,
        u-kumar1@ti.com
Subject: [PATCH v5 1/3] rtc: tps6594: Add driver for TPS6594 RTC
Date:   Mon, 22 May 2023 18:31:13 +0200
Message-Id: <20230522163115.2592883-2-eblanc@baylibre.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230522163115.2592883-1-eblanc@baylibre.com>
References: <20230522163115.2592883-1-eblanc@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TPS6594 PMIC is a MFD. This patch adds support for
the RTC found inside TPS6594 family of PMIC.

Alarm is also supported.

Signed-off-by: Esteban Blanc <eblanc@baylibre.com>
---
 drivers/rtc/Kconfig       |  12 +
 drivers/rtc/Makefile      |   1 +
 drivers/rtc/rtc-tps6594.c | 463 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 476 insertions(+)
 create mode 100644 drivers/rtc/rtc-tps6594.c

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index 753872408615..0fc10710647a 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -578,6 +578,18 @@ config RTC_DRV_TPS6586X
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
+	  This driver can also be built as a module. If so, the module
+	  will be called tps6594-rtc
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
index 000000000000..a91f7b546e07
--- /dev/null
+++ b/drivers/rtc/rtc-tps6594.c
@@ -0,0 +1,463 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * RTC driver for tps6594 PMIC
+ *
+ * Copyright (C) 2023 BayLibre Incorporated - https://www.baylibre.com/
+ */
+
+#include <linux/bcd.h>
+#include <linux/errno.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <linux/math64.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/property.h>
+#include <linux/rtc.h>
+#include <linux/types.h>
+#include <linux/units.h>
+
+#include <linux/mfd/tps6594.h>
+
+#define TPS6594_GET_TIME_ON TPS6594_BIT_GET_TIME
+#define TPS6594_GET_TIME_OFF 0
+#define TPS6594_IT_ALARM_ON TPS6594_BIT_IT_ALARM
+#define TPS6594_IT_ALARM_OFF 0
+#define TPS6594_AUTO_COMP_ON TPS6594_BIT_IT_ALARM
+
+// Total number of RTC registers needed to set time
+#define NUM_TIME_REGS (TPS6594_REG_RTC_WEEKS - TPS6594_REG_RTC_SECONDS + 1)
+
+// Total number of RTC alarm registers
+#define NUM_TIME_ALARM_REGS (NUM_TIME_REGS - 1)
+
+// Total number of RTC registers needed to set compensation registers
+#define NUM_COMP_REGS (TPS6594_REG_RTC_COMP_MSB - TPS6594_REG_RTC_COMP_LSB + 1)
+
+/*
+ * Min and max values supported by 'offset' interface (swapped sign).
+ * After conversion, the values do not exceed the range [-32767, 33767]
+ * which COMP_REG must conform to.
+ */
+#define MIN_OFFSET (-277774)
+#define MAX_OFFSET (277774)
+
+// Number of ticks per hour
+#define TICKS_PER_HOUR (32768 * 3600)
+
+// Multiplier for ppb conversions
+#define PPB_MULT NANO
+
+static int tps6594_rtc_alarm_irq_enable(struct device *dev,
+					unsigned int enabled)
+{
+	struct tps6594 *tps = dev_get_drvdata(dev->parent);
+	u8 val = 0;
+
+	val = enabled ? TPS6594_IT_ALARM_ON : TPS6594_IT_ALARM_OFF;
+
+	return regmap_update_bits(tps->regmap, TPS6594_REG_RTC_INTERRUPTS,
+				  TPS6594_BIT_IT_ALARM, val);
+}
+
+/* Pulse GET_TIME field of RTC_CTRL_1 to store a timestamp in shadow registers. */
+static int tps6594_rtc_shadow_timestamp(struct device *dev, struct tps6594 *tps)
+{
+	int ret;
+
+	/*
+	 * Set GET_TIME to 0. Next time we set GET_TIME to 1 we will be sure to store
+	 * an up-to-date timestamp.
+	 */
+	ret = regmap_clear_bits(tps->regmap, TPS6594_REG_RTC_CTRL_1,
+				TPS6594_BIT_GET_TIME);
+	if (ret < 0)
+		return ret;
+
+	/*
+	 * Copy content of RTC registers to shadow registers or latches to read
+	 * a coherent timestamp.
+	 */
+	return regmap_set_bits(tps->regmap, TPS6594_REG_RTC_CTRL_1,
+			       TPS6594_BIT_GET_TIME);
+}
+
+static int tps6594_rtc_read_time(struct device *dev, struct rtc_time *tm)
+{
+	unsigned char rtc_data[NUM_TIME_REGS];
+	struct tps6594 *tps = dev_get_drvdata(dev->parent);
+	int ret;
+
+	// Check if RTC is running.
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
+	// Read shadowed RTC registers.
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
+	// Stop RTC while updating the RTC time registers.
+	ret = regmap_clear_bits(tps->regmap, TPS6594_REG_RTC_CTRL_1,
+				TPS6594_BIT_STOP_RTC);
+	if (ret < 0)
+		return ret;
+
+	// Update all the time registers in one shot.
+	ret = regmap_bulk_write(tps->regmap, TPS6594_REG_RTC_SECONDS, rtc_data,
+				NUM_TIME_REGS);
+	if (ret < 0)
+		return ret;
+
+	// Start back RTC.
+	return regmap_set_bits(tps->regmap, TPS6594_REG_RTC_CTRL_1,
+			       TPS6594_BIT_STOP_RTC);
+}
+
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
+	alm->enabled = int_val & TPS6594_BIT_IT_ALARM;
+
+	return 0;
+}
+
+static int tps6594_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alm)
+{
+	unsigned char alarm_data[NUM_TIME_ALARM_REGS];
+	struct tps6594 *tps = dev_get_drvdata(dev->parent);
+	int ret;
+
+	// Disable alarm irq before changing the alarm timestamp.
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
+	// Update all the alarm registers in one shot.
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
+	__le16 value;
+	int ret;
+
+	/*
+	 * TPS6594 uses two's complement 16 bit value for compensation of RTC
+	 * crystal inaccuracies. One time every hour when seconds counter
+	 * increments from 0 to 1 compensation value will be added to internal
+	 * RTC counter value.
+	 *
+	 * Valid range for compensation value: [-32767 .. 32767].
+	 */
+	if (calibration < -32767 || calibration > 32767) {
+		dev_err(dev, "RTC calibration value out of range: %d\n",
+			calibration);
+		return -EINVAL;
+	}
+
+	value = (__le16)calibration;
+
+	comp_data[0] = value & 0xFF;
+	comp_data[1] = (value >> 8) & 0xFF;
+
+	// Update all the compensation registers in one shot.
+	ret = regmap_bulk_write(tps->regmap, TPS6594_REG_RTC_COMP_LSB,
+				comp_data, NUM_COMP_REGS);
+	if (ret < 0)
+		return ret;
+
+	// Enable automatic compensation.
+	return regmap_set_bits(tps->regmap, TPS6594_REG_RTC_CTRL_1,
+			       TPS6594_BIT_AUTO_COMP);
+}
+
+static int tps6594_rtc_get_calibration(struct device *dev, int *calibration)
+{
+	unsigned char comp_data[NUM_COMP_REGS];
+	struct tps6594 *tps = dev_get_drvdata(dev->parent);
+	unsigned int ctrl;
+	__le16 value;
+	int ret;
+
+	ret = regmap_read(tps->regmap, TPS6594_REG_RTC_CTRL_1, &ctrl);
+	if (ret < 0)
+		return ret;
+
+	// If automatic compensation is not enabled report back zero.
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
+	value = (__le16)comp_data[0] | ((__le16)comp_data[1] << 8);
+
+	*calibration = value;
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
+	// Convert from RTC calibration register format to ppb format.
+	tmp = calibration * PPB_MULT;
+
+	if (tmp < 0)
+		tmp -= TICKS_PER_HOUR / 2LL;
+	else
+		tmp += TICKS_PER_HOUR / 2LL;
+	tmp = div_s64(tmp, TICKS_PER_HOUR);
+
+	/*
+	 * SAFETY:
+	 * Compution is the reverse operation of the one done in
+	 * `tps6594_rtc_set_offset`. The safety remarks applie here too.
+	 */
+
+	/*
+	 * Offset value operates in negative way, so swap sign.
+	 * See 8.3.10.5, (32768 - COMP_REG).
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
+
+	// Make sure offset value is within supported range.
+	if (offset < MIN_OFFSET || offset > MAX_OFFSET)
+		return -ERANGE;
+
+	// Convert from ppb format to RTC calibration register format.
+
+	tmp = offset * TICKS_PER_HOUR;
+	if (tmp < 0)
+		tmp -= PPB_MULT / 2LL;
+	else
+		tmp += PPB_MULT / 2LL;
+	tmp = div_s64(tmp, PPB_MULT);
+
+	/*
+	 * SAFETY:
+	 * - tmp = offset * TICK_PER_HOUR :
+	 *	`offset` can't be more than 277774, so `tmp` can't exceed 277774000000000
+	 *	which is lower than the maximum value in an `s64` (2^63-1). No overflow here.
+	 *
+	 * - tmp += TICK_PER_HOUR / 2LL :
+	 *	tmp will have a maximum value of 277774117964800 which is still inferior to 2^63-1.
+	 */
+
+	// Offset value operates in negative way, so swap sign.
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
+	// Notify RTC core on event.
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
+	struct tps6594 *tps = dev_get_drvdata(pdev->dev.parent);
+	struct rtc_device *rtc;
+	int irq;
+	int ret;
+
+	rtc = devm_kzalloc(&pdev->dev, sizeof(*rtc), GFP_KERNEL);
+	if (!rtc)
+		return -ENOMEM;
+
+	rtc = devm_rtc_allocate_device(&pdev->dev);
+	if (IS_ERR(rtc))
+		return PTR_ERR(rtc);
+
+	// Enable crystal oscillator.
+	ret = regmap_set_bits(tps->regmap, TPS6594_REG_RTC_CTRL_2,
+			      TPS6594_BIT_XTAL_EN);
+	if (ret < 0)
+		return ret;
+
+	ret = regmap_test_bits(tps->regmap, TPS6594_REG_RTC_STATUS,
+			       TPS6594_BIT_RUN);
+	if (ret < 0)
+		return ret;
+	// RTC not running.
+	if (ret == 0) {
+		ret = regmap_set_bits(tps->regmap, TPS6594_REG_RTC_CTRL_1,
+				      TPS6594_BIT_STOP_RTC);
+		if (ret < 0)
+			return ret;
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
+		// Stop RTC until first call to `tps6594_rtc_set_time`.
+		ret = regmap_clear_bits(tps->regmap, TPS6594_REG_RTC_CTRL_1,
+					TPS6594_BIT_STOP_RTC);
+		if (ret < 0)
+			return ret;
+	}
+
+	platform_set_drvdata(pdev, rtc);
+
+	irq = platform_get_irq_byname(pdev, TPS6594_IRQ_NAME_ALARM);
+	if (irq < 0)
+		return dev_err_probe(&pdev->dev, irq, "Failed to get irq\n");
+
+	ret = devm_request_threaded_irq(&pdev->dev, irq, NULL,
+					tps6594_rtc_interrupt, IRQF_ONESHOT,
+					TPS6594_IRQ_NAME_ALARM, &pdev->dev);
+	if (ret < 0)
+		return dev_err_probe(&pdev->dev, ret,
+				     "Failed to request_threaded_irq\n");
+
+	ret = device_init_wakeup(&pdev->dev, true);
+	if (ret < 0)
+		return dev_err_probe(&pdev->dev, ret,
+				     "Failed to init rtc as wakeup source\n");
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
+MODULE_ALIAS("platform:rtc-tps6594-rtc");
+MODULE_AUTHOR("Esteban Blanc <eblanc@baylibre.com>");
+MODULE_DESCRIPTION("TPS6594 RTC driver");
+MODULE_LICENSE("GPL");
-- 
2.39.2

