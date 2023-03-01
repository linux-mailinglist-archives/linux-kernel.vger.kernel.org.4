Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 867A36A6997
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 10:13:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbjCAJNk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 04:13:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbjCAJNW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 04:13:22 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 200062706
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 01:12:57 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id v16so9646144wrn.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Mar 2023 01:12:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1677661972;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k8cE2nYyroyY+N05om5Zg3FelpYcKKnaG2Z1LHphPvA=;
        b=fT3yWe9CLuTMf790ZsTEUSqLJ3ajaZBSwvba5PVK1KCNfqWu4RF+YozuHyMltyhZzP
         0hYxYyg2ZW0S3uIxGH2IEY30zmm5w2KgU7iNZwcp58RkPh2ArH7aBE6pnx4C7Rhxj0sL
         wpCptEg+7dO6E3w4n6z6Ufb2Et7W3gQsNbcFBlhq56rsvoQ4ockKFKDeL79K/i6x5eCi
         fQTDd2ZEpt6ubvyVSimu4nsAS51m/uCYtrugH0EEV3w1V7/XzVDfK9WjvV6hLjNKM7d+
         F17IGzAeXmJxRAfSXrtX6XQikz0tDqP1UwgVOE1D2e41svxW2tsaOrsxKdyxXcbrU1GI
         mZFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677661972;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k8cE2nYyroyY+N05om5Zg3FelpYcKKnaG2Z1LHphPvA=;
        b=w3C4dCpDEGzDAyHLqBmx9uyZiYczzw6ed2UCYgVF0oCHSrhqGfdS6E6og4I8L4Tb0o
         kUn0zKaaI89J2ujFZkLIIQOa9W4YtAphigyPoWoI+ru7D+ggwTSFWFFroYCBiNq862Mb
         Pp8xsB8R8eQ015v+N661rcPX97sXvuZfmN/HCrgveKDAnptIiy1p5qcJ9Y6sIGnSM3VO
         xlnheGxXZb9DwuW8mZWYAf+QT6brRt9B4MzVgsUO4ENWofMbLPHVjsV6LaV/GcI+Bc5x
         aYhH3h3bfc4iXiSYDmIOZ4acvpwZL6VvvBVaT9rdkqh8g2NZNJ8XomSlAM+bK4OSe7uc
         kvHw==
X-Gm-Message-State: AO0yUKWpoNHjMPC7LIpX58l+KEOBH8DXeXHXt818ghjFB9NzOOqstFEN
        6g+jFKNT8lQEHXnWiU4Fuc7KBg==
X-Google-Smtp-Source: AK7set+tWhY2Jd6WXRAlvuGhLIIgytsQup4yviilznlURzXNCc4zBdFQHIhJg4qQgJfFOMldqErwBg==
X-Received: by 2002:a05:6000:1287:b0:2ca:338a:defc with SMTP id f7-20020a056000128700b002ca338adefcmr4588042wrx.37.1677661972458;
        Wed, 01 Mar 2023 01:12:52 -0800 (PST)
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id s8-20020a5d4ec8000000b002c704271b05sm12072232wrv.66.2023.03.01.01.12.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Mar 2023 01:12:52 -0800 (PST)
From:   Naresh Solanki <naresh.solanki@9elements.com>
X-Google-Original-From: Naresh Solanki <Naresh.Solanki@9elements.com>
To:     Lee Jones <lee@kernel.org>
Cc:     Patrick Rudolph <patrick.rudolph@9elements.com>,
        Marcello Sylvester Bauer <sylv@sylv.io>,
        Naresh Solanki <Naresh.Solanki@9elements.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] mfd: max597x: Add support for MAX5970 and MAX5978
Date:   Wed,  1 Mar 2023 10:12:34 +0100
Message-Id: <20230301091234.3159953-2-Naresh.Solanki@9elements.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230301091234.3159953-1-Naresh.Solanki@9elements.com>
References: <20230301091234.3159953-1-Naresh.Solanki@9elements.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
---
 drivers/mfd/Kconfig          | 10 ++++
 drivers/mfd/simple-mfd-i2c.c | 13 +++++
 include/linux/mfd/max597x.h  | 97 ++++++++++++++++++++++++++++++++++++
 3 files changed, 120 insertions(+)
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
index 000000000000..8a4da98caf3e
--- /dev/null
+++ b/include/linux/mfd/max597x.h
@@ -0,0 +1,97 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Device driver for regulators in MAX5970 and MAX5978 IC
+ *
+ * Copyright (c) 2022 9elements GmbH
+ *
+ * Author: Patrick Rudolph <patrick.rudolph@9elements.com>
+ */
+
+#ifndef _MAX597X_H
+#define _MAX597X_H
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
+#define  MAX5970_MON(reg, ch) \
+	(((reg) >> ((ch) * 2)) & MAX5970_MON_MASK)
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
+#endif				/* _MAX597X_H */
-- 
2.39.1

