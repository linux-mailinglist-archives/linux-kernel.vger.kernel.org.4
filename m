Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14E3C6ADE78
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 13:14:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230273AbjCGMOd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 07:14:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231328AbjCGMOL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 07:14:11 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D4C95DEDE
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 04:13:26 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id p26so7600032wmc.4
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 04:13:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1678191173;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NKAjQVA6g1l019gbTlYbZiNFJ0kH3vAi7tyg+kj/RfI=;
        b=YgYrEJ48asx6ZbK+m1fuGzRLu4kSx8su6FqPxMVyzClHWoQ/x728pipxhAfbiKW4fx
         IztC52a2jV3cQpqr0nWz0Kg2cYrPeHxnisgQ/Mw/xIQrPQL5dPPkCNKtPWaEqkcvCniW
         Z9lGg+yEFtA4LAm3MZxsLgF6S5R5fp0I4rCk0YqPXNwCituEOJ/BCrg2K+YkmzI3LzJI
         jsgHa0w5v8Motm5OM2vTbzTV2Sx4he4MA7I5YokpH+fUsriO/qEzLW5LMoO9jPF0Qd9c
         nK/dTbh+rrNTdsHPYXhoPW8b/2GFe5+HKG2omi2pw/R7JA4vPo0W1U7cNFF82/SPfA1x
         4YSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678191173;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NKAjQVA6g1l019gbTlYbZiNFJ0kH3vAi7tyg+kj/RfI=;
        b=CQCh5XD3ysiErymCkOsRzAJ4P2Iws0lI7zLeat+W/DPnJ0kJbf5UqNaKmbfYH33lVh
         eGCB4zD4zPArwz4kk4vtXKKBKHosmyiBPdPZTAHwtCvXJxDYY9llh0wu+wN9HiPLOyK4
         VsTP/7lrZikBjpWhUOfLB0VOxZ9rO7Q34Vf+h+ou/dASTntUgKZRndjG/49qXgb+mWIa
         XSkqFrgBCY8AZkbfgpHbXbB/v7xNDml6rmaprX285EaSEvlT7q6hYcUOqS7+cYIy92I/
         6Jx6mqTF6fFqoDpPGvOGY26xWsGMUdPVKQhtjVCMsZ0vs2Ln+hbYQkmmkXe97e8WCFd/
         on8Q==
X-Gm-Message-State: AO0yUKUULo+G7oRAKfl73lAouDoe9fkS/FnxWPyVTyM16wxZbdZjEft+
        CCQaiDOxbfrHTtm6gdShwbtbdQ==
X-Google-Smtp-Source: AK7set+Kt/QuSjZ5ZNjBsiEa/UH4AvxKuh0etTkRX2V6K17UNPhEan604LX/RshQABqEAuqMH5QwlQ==
X-Received: by 2002:a05:600c:19d4:b0:3eb:38a2:2bd2 with SMTP id u20-20020a05600c19d400b003eb38a22bd2mr11890946wmq.11.1678191173019;
        Tue, 07 Mar 2023 04:12:53 -0800 (PST)
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id ip21-20020a05600ca69500b003eb596cbc54sm12954925wmb.0.2023.03.07.04.12.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 04:12:52 -0800 (PST)
From:   Naresh Solanki <naresh.solanki@9elements.com>
X-Google-Original-From: Naresh Solanki <Naresh.Solanki@9elements.com>
To:     Lee Jones <lee@kernel.org>
Cc:     Patrick Rudolph <patrick.rudolph@9elements.com>,
        Marcello Sylvester Bauer <sylv@sylv.io>,
        Naresh Solanki <Naresh.Solanki@9elements.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v12 2/2] mfd: max597x: Add support for MAX5970 and MAX5978
Date:   Tue,  7 Mar 2023 13:12:45 +0100
Message-Id: <20230307121246.127425-2-Naresh.Solanki@9elements.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230307121246.127425-1-Naresh.Solanki@9elements.com>
References: <20230307121246.127425-1-Naresh.Solanki@9elements.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Patrick Rudolph <patrick.rudolph@9elements.com>

Implement a regulator driver with IRQ support for fault management.
Written against documentation [1] and [2] and tested on real hardware.

Every channel has it's own regulator supply nammed 'vss1-supply' and
'vss2-supply'. The regulator supply is used to determine the output
voltage, as the smart switch provides no output regulation.
The driver requires the 'shunt-resistor-micro-ohms' to be present in
the devicetree to properly calculate current related values.

You must specify compatible devictree layout:

regulator@3a {
        reg = <0x3a>;
        vss1-supply = <&p3v3>;
        compatible = "maxim,max5978";

        ...

        regulators {
                sw0_ref: SW0 {
                        regulator-compatible = "SW0";
                        shunt-resistor-micro-ohms = <12000>;
                        ...
                }
        }
}

1: https://datasheets.maximintegrated.com/en/ds/MAX5970.pdf
2: https://datasheets.maximintegrated.com/en/ds/MAX5978.pdf

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
Signed-off-by: Marcello Sylvester Bauer <sylv@sylv.io>
Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
...
Changes in V12:
- Use simple_mfd_i2c driver and remove previous implementation.
- Remove newline
- Use _MFD_MAX597X_H in header file
- Successfull build need following patch from regulator:
https://lore.kernel.org/r/20230216075302.68935-1-Naresh.Solanki@9elements.com
https://lore.kernel.org/r/20230210163225.1208035-1-Naresh.Solanki@9elements.com
---
 drivers/mfd/Kconfig          | 10 ++++
 drivers/mfd/simple-mfd-i2c.c | 13 +++++
 include/linux/mfd/max597x.h  | 96 ++++++++++++++++++++++++++++++++++++
 3 files changed, 119 insertions(+)
 create mode 100644 include/linux/mfd/max597x.h

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index d4fc4ca9fdbd..de899e0d2f1a 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -266,6 +266,16 @@ config MFD_MADERA_SPI
 	  Support for the Cirrus Logic Madera platform audio SoC
 	  core functionality controlled via SPI.
 
+config MFD_MAX597X
+	tristate "Maxim 597x power switch and monitor"
+	depends on (I2C && OF)
+	select MFD_SIMPLE_MFD_I2C
+	help
+	  This driver controls a Maxim 5970/5978 switch via I2C bus.
+	  The MAX5970/5978 is a smart switch with no output regulation, but
+	  fault protection and voltage and current monitoring capabilities.
+	  Also it supports upto 4 indication leds.
+
 config MFD_CS47L15
 	bool "Cirrus Logic CS47L15"
 	select PINCTRL_CS47L15
diff --git a/drivers/mfd/simple-mfd-i2c.c b/drivers/mfd/simple-mfd-i2c.c
index e31f13fd6a79..20782b4dd172 100644
--- a/drivers/mfd/simple-mfd-i2c.c
+++ b/drivers/mfd/simple-mfd-i2c.c
@@ -72,9 +72,22 @@ static const struct simple_mfd_data silergy_sy7636a = {
 	.mfd_cell_size = ARRAY_SIZE(sy7636a_cells),
 };
 
+static const struct mfd_cell max597x_cells[] = {
+	{ .name = "max597x-regulator", },
+	{ .name = "max597x-iio", },
+	{ .name = "max597x-led", },
+};
+
+static const struct simple_mfd_data maxim_max597x = {
+	.mfd_cell = max597x_cells,
+	.mfd_cell_size = ARRAY_SIZE(max597x_cells),
+};
+
 static const struct of_device_id simple_mfd_i2c_of_match[] = {
 	{ .compatible = "kontron,sl28cpld" },
 	{ .compatible = "silergy,sy7636a", .data = &silergy_sy7636a},
+	{ .compatible = "maxim,max5970", .data = &maxim_max597x},
+	{ .compatible = "maxim,max5978", .data = &maxim_max597x},
 	{}
 };
 MODULE_DEVICE_TABLE(of, simple_mfd_i2c_of_match);
diff --git a/include/linux/mfd/max597x.h b/include/linux/mfd/max597x.h
new file mode 100644
index 000000000000..a850b2e02e6a
--- /dev/null
+++ b/include/linux/mfd/max597x.h
@@ -0,0 +1,96 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Device driver for regulators in MAX5970 and MAX5978 IC
+ *
+ * Copyright (c) 2022 9elements GmbH
+ *
+ * Author: Patrick Rudolph <patrick.rudolph@9elements.com>
+ */
+
+#ifndef _MFD_MAX597X_H
+#define _MFD_MAX597X_H
+
+#include <linux/regmap.h>
+
+#define MAX5970_NUM_SWITCHES 2
+#define MAX5978_NUM_SWITCHES 1
+#define MAX597X_NUM_LEDS     4
+
+struct max597x_data {
+	int num_switches;
+	u32 irng[MAX5970_NUM_SWITCHES];
+	u32 mon_rng[MAX5970_NUM_SWITCHES];
+	u32 shunt_micro_ohms[MAX5970_NUM_SWITCHES];
+};
+
+enum max597x_chip_type {
+	MAX597x_TYPE_MAX5978 = 1,
+	MAX597x_TYPE_MAX5970,
+};
+
+#define MAX5970_REG_CURRENT_L(ch)		(0x01 + (ch) * 4)
+#define MAX5970_REG_CURRENT_H(ch)		(0x00 + (ch) * 4)
+#define MAX5970_REG_VOLTAGE_L(ch)		(0x03 + (ch) * 4)
+#define MAX5970_REG_VOLTAGE_H(ch)		(0x02 + (ch) * 4)
+#define MAX5970_REG_MON_RANGE			0x18
+#define  MAX5970_MON_MASK			0x3
+#define  MAX5970_MON(reg, ch)			(((reg) >> ((ch) * 2)) & MAX5970_MON_MASK)
+#define  MAX5970_MON_MAX_RANGE_UV		16000000
+
+#define MAX5970_REG_CH_UV_WARN_H(ch)		(0x1A + (ch) * 10)
+#define MAX5970_REG_CH_UV_WARN_L(ch)		(0x1B + (ch) * 10)
+#define MAX5970_REG_CH_UV_CRIT_H(ch)		(0x1C + (ch) * 10)
+#define MAX5970_REG_CH_UV_CRIT_L(ch)		(0x1D + (ch) * 10)
+#define MAX5970_REG_CH_OV_WARN_H(ch)		(0x1E + (ch) * 10)
+#define MAX5970_REG_CH_OV_WARN_L(ch)		(0x1F + (ch) * 10)
+#define MAX5970_REG_CH_OV_CRIT_H(ch)		(0x20 + (ch) * 10)
+#define MAX5970_REG_CH_OV_CRIT_L(ch)		(0x21 + (ch) * 10)
+
+#define  MAX5970_VAL2REG_H(x)		(((x) >> 2) & 0xFF)
+#define  MAX5970_VAL2REG_L(x)		((x) & 0x3)
+
+#define MAX5970_REG_DAC_FAST(ch)	(0x2E + (ch))
+
+#define MAX5970_FAST2SLOW_RATIO		200
+
+#define MAX5970_REG_STATUS0		0x31
+#define  MAX5970_CB_IFAULTF(ch)		(1 << (ch))
+#define  MAX5970_CB_IFAULTS(ch)		(1 << ((ch) + 4))
+
+#define MAX5970_REG_STATUS1		0x32
+#define  STATUS1_PROT_MASK		0x3
+#define  STATUS1_PROT(reg) \
+	(((reg) >> 6) & STATUS1_PROT_MASK)
+#define  STATUS1_PROT_SHUTDOWN		0
+#define  STATUS1_PROT_CLEAR_PG		1
+#define  STATUS1_PROT_ALERT_ONLY	2
+
+#define MAX5970_REG_STATUS2		0x33
+#define  MAX5970_IRNG_MASK		0x3
+#define  MAX5970_IRNG(reg, ch) \
+	(((reg) >> ((ch) * 2)) & MAX5970_IRNG_MASK)
+
+#define MAX5970_REG_STATUS3		0x34
+#define  MAX5970_STATUS3_ALERT		BIT(4)
+#define  MAX5970_STATUS3_PG(ch)		BIT(ch)
+
+#define MAX5970_REG_FAULT0		0x35
+#define  UV_STATUS_WARN(ch)		(1 << (ch))
+#define  UV_STATUS_CRIT(ch)		(1 << ((ch) + 4))
+
+#define MAX5970_REG_FAULT1		0x36
+#define  OV_STATUS_WARN(ch)		(1 << (ch))
+#define  OV_STATUS_CRIT(ch)		(1 << ((ch) + 4))
+
+#define MAX5970_REG_FAULT2		0x37
+#define  OC_STATUS_WARN(ch)		(1 << (ch))
+
+#define MAX5970_REG_CHXEN		0x3b
+#define  CHXEN(ch)			(3 << ((ch) * 2))
+
+#define MAX5970_REG_LED_FLASH		0x43
+
+#define MAX_REGISTERS			0x49
+#define ADC_MASK			0x3FF
+
+#endif				/* _MFD_MAX597X_H */
-- 
2.39.1

