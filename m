Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F24FF623917
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 02:44:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231611AbiKJBof (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 20:44:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231925AbiKJBo0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 20:44:26 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AA4DA275E2;
        Wed,  9 Nov 2022 17:44:25 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9A0CFD6E;
        Wed,  9 Nov 2022 17:44:31 -0800 (PST)
Received: from slackpad.fritz.box (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E2A0D3F703;
        Wed,  9 Nov 2022 17:44:23 -0800 (PST)
From:   Andre Przywara <andre.przywara@arm.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>
Cc:     Icenowy Zheng <uwu@icenowy.me>, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev
Subject: [RFC PATCH 2/2] pinctrl: sunxi: Add support for the Allwinner V5 pin controller
Date:   Thu, 10 Nov 2022 01:42:55 +0000
Message-Id: <20221110014255.20711-3-andre.przywara@arm.com>
X-Mailer: git-send-email 2.35.5
In-Reply-To: <20221110014255.20711-1-andre.przywara@arm.com>
References: <20221110014255.20711-1-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Allwinner V5 contains pins in all 10 possible pin banks.
Use the newly introduced DT based pinctrl driver to describe just the
generic pinctrl properties, so advertise the number of pins per bank
and the interrupt capabilities. The actual function/mux assignment is
taken from the devicetree.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 drivers/pinctrl/sunxi/Kconfig            |  5 +++
 drivers/pinctrl/sunxi/Makefile           |  1 +
 drivers/pinctrl/sunxi/pinctrl-sun8i-v5.c | 52 ++++++++++++++++++++++++
 3 files changed, 58 insertions(+)
 create mode 100644 drivers/pinctrl/sunxi/pinctrl-sun8i-v5.c

diff --git a/drivers/pinctrl/sunxi/Kconfig b/drivers/pinctrl/sunxi/Kconfig
index a78fdbbdfc0c..6b8ea56c08fd 100644
--- a/drivers/pinctrl/sunxi/Kconfig
+++ b/drivers/pinctrl/sunxi/Kconfig
@@ -131,4 +131,9 @@ config PINCTRL_SUN50I_H616_R
 	default ARM64 && ARCH_SUNXI
 	select PINCTRL_SUNXI
 
+config PINCTRL_SUN8I_V5
+	bool "Support for the Allwinner V5 PIO"
+	default MACH_SUN8I
+	select PINCTRL_SUNXI
+
 endif
diff --git a/drivers/pinctrl/sunxi/Makefile b/drivers/pinctrl/sunxi/Makefile
index f5bad7a52951..5b289e18bd5a 100644
--- a/drivers/pinctrl/sunxi/Makefile
+++ b/drivers/pinctrl/sunxi/Makefile
@@ -21,6 +21,7 @@ obj-$(CONFIG_PINCTRL_SUN8I_A83T_R)	+= pinctrl-sun8i-a83t-r.o
 obj-$(CONFIG_PINCTRL_SUN8I_H3)		+= pinctrl-sun8i-h3.o
 obj-$(CONFIG_PINCTRL_SUN8I_H3_R)	+= pinctrl-sun8i-h3-r.o
 obj-$(CONFIG_PINCTRL_SUN8I_V3S)		+= pinctrl-sun8i-v3s.o
+obj-$(CONFIG_PINCTRL_SUN8I_V5)		+= pinctrl-sun8i-v5.o
 obj-$(CONFIG_PINCTRL_SUN20I_D1)		+= pinctrl-sun20i-d1.o
 obj-$(CONFIG_PINCTRL_SUN50I_H5)		+= pinctrl-sun50i-h5.o
 obj-$(CONFIG_PINCTRL_SUN50I_H6)		+= pinctrl-sun50i-h6.o
diff --git a/drivers/pinctrl/sunxi/pinctrl-sun8i-v5.c b/drivers/pinctrl/sunxi/pinctrl-sun8i-v5.c
new file mode 100644
index 000000000000..402b1c915e04
--- /dev/null
+++ b/drivers/pinctrl/sunxi/pinctrl-sun8i-v5.c
@@ -0,0 +1,52 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Allwinner V5 SoC pinctrl driver.
+ *
+ * Copyright (C) 2022 Arm Ltd.
+ */
+
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/pinctrl/pinctrl.h>
+
+#include "pinctrl-sunxi.h"
+
+static const unsigned int v5_irq_bank_map[] = { 0, 1, 5, 6, 7 };
+
+static const u8 v5_irq_bank_muxes[SUNXI_PINCTRL_MAX_BANKS] =
+/*       PA PB PC PD PE PF PG PH */
+        { 6, 6, 0, 0, 0, 6, 6, 6 };
+
+static const u8 v5_nr_bank_pins[SUNXI_PINCTRL_MAX_BANKS] =
+/*        PA  PB  PC  PD  PE  PF  PG  PH  PI  PJ */
+        { 16, 11, 17, 23, 18,  7, 14, 16, 17, 18 };
+
+static struct sunxi_pinctrl_desc v5_pinctrl_data = {
+	.irq_banks = ARRAY_SIZE(v5_irq_bank_map),
+	.irq_bank_map = v5_irq_bank_map,
+	.irq_read_needs_mux = true,
+	.io_bias_cfg_variant = BIAS_VOLTAGE_PIO_POW_MODE_SEL,
+};
+
+static int v5_pinctrl_probe(struct platform_device *pdev)
+{
+	return sunxi_pinctrl_dt_table_init(pdev, v5_nr_bank_pins,
+					   v5_irq_bank_muxes,
+					   &v5_pinctrl_data);
+}
+
+static const struct of_device_id v5_pinctrl_match[] = {
+	{ .compatible = "allwinner,sun8i-v5-pinctrl", },
+	{}
+};
+
+static struct platform_driver v5_pinctrl_driver = {
+	.probe	= v5_pinctrl_probe,
+	.driver	= {
+		.name		= "sun8i-v5-pinctrl",
+		.of_match_table	= v5_pinctrl_match,
+	},
+};
+builtin_platform_driver(v5_pinctrl_driver);
-- 
2.35.5

