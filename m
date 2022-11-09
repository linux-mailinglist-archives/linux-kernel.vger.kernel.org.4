Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 693BB6230C5
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 17:56:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231515AbiKIQ4N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 11:56:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbiKIQzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 11:55:08 -0500
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E797929C9B;
        Wed,  9 Nov 2022 08:54:00 -0800 (PST)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2A9EDNjT027347;
        Wed, 9 Nov 2022 10:53:37 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=Q/WbI1em8k4vxyaQ6hKXQak8tzf3uNIASHJiJMLKsQY=;
 b=j39otrAGNXZgf3fAvfFKOx60cGVYOkea4mp4eCncVPZonmSASXT8/7d+wki3dCMm+iEs
 mOXaspeGx2BaKMlKW/Qsn9jTTLqVyaABVBXTl3sOh3szB9TROYZvG00hcezl4TuTBry2
 1m8XyL5m7mZ3/ajvbNsCjW3lKiTui5RA/yeoAWnt3lZFW6bhAwW+WqcIqzCMD1w1oR2d
 DE+eHZKiFhkKkczv0mORYl7wkjWGQS8h4hAvxaiwj1UUiYu9CvzA5EsZCosz6QZqPFn1
 e8MF1+KTczwq/1XdEwZcr0jwWqcjbXj2MR2bnBjcQ6yijdBEC5Dcfhg+/4HhKpNK+p/h SA== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3knm8pde7v-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Nov 2022 10:53:36 -0600
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.15; Wed, 9 Nov
 2022 10:53:34 -0600
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.15 via Frontend Transport; Wed, 9 Nov 2022 10:53:34 -0600
Received: from debianA11184.ad.cirrus.com (AUSNPC0LSNW1.ad.cirrus.com [198.61.65.92])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 6727A478;
        Wed,  9 Nov 2022 16:53:34 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <lee@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <linus.walleij@linaro.org>,
        <broonie@kernel.org>, <tglx@linutronix.de>, <maz@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH 05/12] pinctrl: cirrus: Add support for CS48L31/32/33 codecs
Date:   Wed, 9 Nov 2022 16:53:24 +0000
Message-ID: <20221109165331.29332-6-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221109165331.29332-1-rf@opensource.cirrus.com>
References: <20221109165331.29332-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: n76uAZArC6TEZecmrLGIImjob4a_Zq3C
X-Proofpoint-GUID: n76uAZArC6TEZecmrLGIImjob4a_Zq3C
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Piotr Stankiewicz <piotrs@opensource.cirrus.com>

Codecs in this family have multiple digital I/O functions for audio,
DSP subsystem, GPIO and various special functions. All muxable pins
are selectable as either a GPIO or an alternate function.

Signed-off-by: Piotr Stankiewicz <piotrs@opensource.cirrus.com>
Signed-off-by: Qi Zhou <qi.zhou@cirrus.com>
Signed-off-by: Stuart Henderson <stuarth@opensource.cirrus.com>
Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 MAINTAINERS                              |   1 +
 drivers/pinctrl/cirrus/Kconfig           |   5 +
 drivers/pinctrl/cirrus/Makefile          |   2 +
 drivers/pinctrl/cirrus/pinctrl-cs48l32.c | 932 +++++++++++++++++++++++
 drivers/pinctrl/cirrus/pinctrl-cs48l32.h |  62 ++
 5 files changed, 1002 insertions(+)
 create mode 100644 drivers/pinctrl/cirrus/pinctrl-cs48l32.c
 create mode 100644 drivers/pinctrl/cirrus/pinctrl-cs48l32.h

diff --git a/MAINTAINERS b/MAINTAINERS
index f1d696f29f11..cd1773d39dd8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5011,6 +5011,7 @@ W:	https://github.com/CirrusLogic/linux-drivers/wiki
 T:	git https://github.com/CirrusLogic/linux-drivers.git
 F:	Documentation/devicetree/bindings/mfd/cirrus,cs48l32.yaml
 F:	Documentation/devicetree/bindings/mfd/cirrus,madera.yaml
+F:	Documentation/devicetree/bindings/pinctrl/cirrus,cs48l32.yaml
 F:	Documentation/devicetree/bindings/pinctrl/cirrus,madera.yaml
 F:	Documentation/devicetree/bindings/sound/cirrus,madera.yaml
 F:	drivers/gpio/gpio-madera*
diff --git a/drivers/pinctrl/cirrus/Kconfig b/drivers/pinctrl/cirrus/Kconfig
index 530426a74f75..c51192bde87a 100644
--- a/drivers/pinctrl/cirrus/Kconfig
+++ b/drivers/pinctrl/cirrus/Kconfig
@@ -30,3 +30,8 @@ config PINCTRL_CS47L90
 
 config PINCTRL_CS47L92
 	bool
+
+config PINCTRL_CS48L32
+	tristate
+	select PINMUX
+	select GENERIC_PINCONF
diff --git a/drivers/pinctrl/cirrus/Makefile b/drivers/pinctrl/cirrus/Makefile
index a484518c840e..18290f6be00c 100644
--- a/drivers/pinctrl/cirrus/Makefile
+++ b/drivers/pinctrl/cirrus/Makefile
@@ -19,4 +19,6 @@ ifeq ($(CONFIG_PINCTRL_CS47L92),y)
 pinctrl-madera-objs		+= pinctrl-cs47l92.o
 endif
 
+obj-$(CONFIG_PINCTRL_CS48L32)	+= pinctrl-cs48l32.o
+
 obj-$(CONFIG_PINCTRL_MADERA)	+= pinctrl-madera.o
diff --git a/drivers/pinctrl/cirrus/pinctrl-cs48l32.c b/drivers/pinctrl/cirrus/pinctrl-cs48l32.c
new file mode 100644
index 000000000000..cb5031d6d0ce
--- /dev/null
+++ b/drivers/pinctrl/cirrus/pinctrl-cs48l32.c
@@ -0,0 +1,932 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Pinctrl for Cirrus Logic CS48L32
+ *
+ * Copyright (C) 2017-2018, 2020, 2022 Cirrus Logic, Inc. and
+ *               Cirrus Logic International Semiconductor Ltd.
+ */
+#include <linux/err.h>
+#include <linux/mfd/cs48l32/core.h>
+#include <linux/mfd/cs48l32/registers.h>
+#include <linux/module.h>
+#include <linux/pinctrl/pinctrl.h>
+#include <linux/pinctrl/pinmux.h>
+#include <linux/pinctrl/pinconf.h>
+#include <linux/pinctrl/pinconf-generic.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/slab.h>
+
+#include "../pinctrl-utils.h"
+#include "pinctrl-cs48l32.h"
+
+/*
+ * Pins are named after their GPIO number
+ * NOTE: IDs are zero-indexed for coding convenience
+ */
+static const struct pinctrl_pin_desc cs48l32_pins[] = {
+	PINCTRL_PIN(0, "gpio1"),
+	PINCTRL_PIN(1, "gpio2"),
+	PINCTRL_PIN(2, "gpio3"),
+	PINCTRL_PIN(3, "gpio4"),
+	PINCTRL_PIN(4, "gpio5"),
+	PINCTRL_PIN(5, "gpio6"),
+	PINCTRL_PIN(6, "gpio7"),
+	PINCTRL_PIN(7, "gpio8"),
+	PINCTRL_PIN(8, "gpio9"),
+	PINCTRL_PIN(9, "gpio10"),
+	PINCTRL_PIN(10, "gpio11"),
+	PINCTRL_PIN(11, "gpio12"),
+	PINCTRL_PIN(12, "gpio13"),
+	PINCTRL_PIN(13, "gpio14"),
+	PINCTRL_PIN(14, "gpio15"),
+	PINCTRL_PIN(15, "gpio16"),
+};
+
+/*
+ * All single-pin functions can be mapped to any GPIO, however pinmux applies
+ * functions to pin groups and only those groups declared as supporting that
+ * function. To make this work we must put each pin in its own dummy group so
+ * that the functions can be described as applying to all pins.
+ * Since these do not correspond to anything in the actual hardware - they are
+ * merely an adaptation to pinctrl's view of the world - we use the same name
+ * as the pin to avoid confusion when comparing with datasheet instructions
+ */
+static const char * const cs48l32_pin_single_group_names[] = {
+	"gpio1",  "gpio2",  "gpio3",  "gpio4",  "gpio5",  "gpio6",  "gpio7",
+	"gpio8",  "gpio9",  "gpio10", "gpio11", "gpio12", "gpio13", "gpio14",
+	"gpio15", "gpio16",
+};
+
+/* set of pin numbers for single-pin groups */
+static const unsigned int cs48l32_pin_single_group_pins[] = {
+	0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15,
+};
+
+static const char * const cs48l32_asp1_group_names[] = { "asp1" };
+static const char * const cs48l32_asp2_group_names[] = { "asp2" };
+static const char * const cs48l32_in1pdm_group_names[] = { "in1-pdm" };
+static const char * const cs48l32_in2pdm_group_names[] = { "in2-pdm" };
+static const char * const cs48l32_spi2_group_names[] = { "spi2" };
+
+/*
+ * alt-functions always apply to only one group, other functions always
+ * apply to all pins
+ */
+static const struct {
+	const char *name;
+	const char * const *group_names;
+	u32 func;
+} cs48l32_mux_funcs[] = {
+	{
+		.name = "asp1",
+		.group_names = cs48l32_asp1_group_names,
+		.func = 0x000
+	},
+	{
+		.name = "asp2",
+		.group_names = cs48l32_asp2_group_names,
+		.func = 0x000
+	},
+	{
+		.name = "in1-pdm",
+		.group_names = cs48l32_in1pdm_group_names,
+		.func = 0x000
+	},
+	{
+		.name = "in2-pdm",
+		.group_names = cs48l32_in2pdm_group_names,
+		.func = 0x000,
+	},
+	{
+		.name = "spi2",
+		.group_names = cs48l32_spi2_group_names,
+		.func = 0x000
+	},
+	{
+		.name = "io",
+		.group_names = cs48l32_pin_single_group_names,
+		.func = 0x001
+	},
+	{
+		.name = "dsp-gpio",
+		.group_names = cs48l32_pin_single_group_names,
+		.func = 0x002
+	},
+	{
+		.name = "irq1",
+		.group_names = cs48l32_pin_single_group_names,
+		.func = 0x003
+	},
+	{
+		.name = "fll1-clk",
+		.group_names = cs48l32_pin_single_group_names,
+		.func = 0x010
+	},
+	{
+		.name = "fll1-lock",
+		.group_names = cs48l32_pin_single_group_names,
+		.func = 0x018
+	},
+	{
+		.name = "opclk",
+		.group_names = cs48l32_pin_single_group_names,
+		.func = 0x048
+	},
+	{
+		.name = "opclk-dsp",
+		.group_names = cs48l32_pin_single_group_names,
+		.func = 0x04a
+	},
+	{
+		.name = "uart",
+		.group_names = cs48l32_pin_single_group_names,
+		.func = 0x04c
+	},
+	{
+		.name = "input-path-signal-detect",
+		.group_names = cs48l32_pin_single_group_names,
+		.func = 0x08c
+	},
+	{
+		.name = "ultrasonic-in1-activity-detect",
+		.group_names = cs48l32_pin_single_group_names,
+		.func = 0x090
+	},
+	{
+		.name = "ultrasonic-in2-activity-detect",
+		.group_names = cs48l32_pin_single_group_names,
+		.func = 0x092
+	},
+	{
+		.name = "dma-ch0-programmable-transfer-complete",
+		.group_names = cs48l32_pin_single_group_names,
+		.func = 0x190
+	},
+	{
+		.name = "dma-ch1-programmable-transfer-complete",
+		.group_names = cs48l32_pin_single_group_names,
+		.func = 0x191
+	},
+	{
+		.name = "dma-ch2-programmable-transfer-complete",
+		.group_names = cs48l32_pin_single_group_names,
+		.func = 0x192
+	},
+	{
+		.name = "dma-ch3-programmable-transfer-complete",
+		.group_names = cs48l32_pin_single_group_names,
+		.func = 0x193
+	},
+	{
+		.name = "dma-ch4-programmable-transfer-complete",
+		.group_names = cs48l32_pin_single_group_names,
+		.func = 0x194
+	},
+	{
+		.name = "dma-ch5-programmable-transfer-complete",
+		.group_names = cs48l32_pin_single_group_names,
+		.func = 0x195
+	},
+	{
+		.name = "dma-ch6-programmable-transfer-complete",
+		.group_names = cs48l32_pin_single_group_names,
+		.func = 0x196
+	},
+	{
+		.name = "dma-ch7-programmable-transfer-complete",
+		.group_names = cs48l32_pin_single_group_names,
+		.func = 0x197
+	},
+	{
+		.name = "sample-rate-change-trigger-a",
+		.group_names = cs48l32_pin_single_group_names,
+		.func = 0x214
+	},
+	{
+		.name = "sample-rate-change-trigger-b",
+		.group_names = cs48l32_pin_single_group_names,
+		.func = 0x215
+	},
+	{
+		.name = "sample-rate-change-trigger-c",
+		.group_names = cs48l32_pin_single_group_names,
+		.func = 0x216
+	},
+	{
+		.name = "sample-rate-change-trigger-d",
+		.group_names = cs48l32_pin_single_group_names,
+		.func = 0x217
+	},
+	{
+		.name = "timer1-irq-ch1",
+		.group_names = cs48l32_pin_single_group_names,
+		.func = 0x230
+	},
+	{
+		.name = "timer1-irq-ch2",
+		.group_names = cs48l32_pin_single_group_names,
+		.func = 0x231
+	},
+	{
+		.name = "timer1-irq-ch3",
+		.group_names = cs48l32_pin_single_group_names,
+		.func = 0x232
+	},
+	{
+		.name = "timer1-irq-ch4",
+		.group_names = cs48l32_pin_single_group_names,
+		.func = 0x233
+	},
+	{
+		.name = "timer2-irq-ch1",
+		.group_names = cs48l32_pin_single_group_names,
+		.func = 0x234
+	},
+	{
+		.name = "timer2-irq-ch2",
+		.group_names = cs48l32_pin_single_group_names,
+		.func = 0x235
+	},
+	{
+		.name = "timer2-irq-ch3",
+		.group_names = cs48l32_pin_single_group_names,
+		.func = 0x236
+	},
+	{
+		.name = "timer2-irq-ch4",
+		.group_names = cs48l32_pin_single_group_names,
+		.func = 0x237
+	},
+	{
+		.name = "timer3-irq-ch1",
+		.group_names = cs48l32_pin_single_group_names,
+		.func = 0x238
+	},
+	{
+		.name = "timer3-irq-ch2",
+		.group_names = cs48l32_pin_single_group_names,
+		.func = 0x239
+	},
+	{
+		.name = "timer3-irq-ch3",
+		.group_names = cs48l32_pin_single_group_names,
+		.func = 0x23a
+	},
+	{
+		.name = "timer3-irq-ch4",
+		.group_names = cs48l32_pin_single_group_names,
+		.func = 0x23b
+	},
+	{
+		.name = "timer4-irq-ch1",
+		.group_names = cs48l32_pin_single_group_names,
+		.func = 0x23c
+	},
+	{
+		.name = "timer4-irq-ch2",
+		.group_names = cs48l32_pin_single_group_names,
+		.func = 0x23d
+	},
+	{
+		.name = "timer4-irq-ch3",
+		.group_names = cs48l32_pin_single_group_names,
+		.func = 0x23e
+	},
+	{
+		.name = "timer4-irq-ch4",
+		.group_names = cs48l32_pin_single_group_names,
+		.func = 0x23f
+	},
+	{
+		.name = "timer5-irq-ch1",
+		.group_names = cs48l32_pin_single_group_names,
+		.func = 0x240
+	},
+	{
+		.name = "timer5-irq-ch2",
+		.group_names = cs48l32_pin_single_group_names,
+		.func = 0x241
+	},
+	{
+		.name = "timer5-irq-ch3",
+		.group_names = cs48l32_pin_single_group_names,
+		.func = 0x242
+	},
+	{
+		.name = "timer5-irq-ch4",
+		.group_names = cs48l32_pin_single_group_names,
+		.func = 0x243
+	},
+	{
+		.name = "timer-1",
+		.group_names = cs48l32_pin_single_group_names,
+		.func = 0x250
+	},
+	{
+		.name = "timer-2",
+		.group_names = cs48l32_pin_single_group_names,
+		.func = 0x251
+	},
+	{
+		.name = "timer-3",
+		.group_names = cs48l32_pin_single_group_names,
+		.func = 0x252
+	},
+	{
+		.name = "timer-4",
+		.group_names = cs48l32_pin_single_group_names,
+		.func = 0x253
+	},
+	{
+		.name = "timer-5",
+		.group_names = cs48l32_pin_single_group_names,
+		.func = 0x254
+	},
+};
+
+/* Note - all 1 less than in datasheet because these are zero-indexed */
+static const unsigned int cs48l32_asp1_pins[] = { 2, 3, 4, 5 };
+static const unsigned int cs48l32_asp2_pins[] = { 6, 7, 8, 9 };
+static const unsigned int cs48l32_spi2_pins[] = { 10, 11, 12, 13, 14, 15 };
+
+static const struct cs48l32_pin_groups cs48l32_pin_groups[] = {
+	{ "asp1", cs48l32_asp1_pins, ARRAY_SIZE(cs48l32_asp1_pins) },
+	{ "asp2", cs48l32_asp2_pins, ARRAY_SIZE(cs48l32_asp2_pins) },
+	{ "spi2", cs48l32_spi2_pins, ARRAY_SIZE(cs48l32_spi2_pins) },
+};
+
+static const struct cs48l32_pin_chip cs48l32_pin_chip = {
+	.n_pins = CS48L32_NUM_GPIOS,
+	.pin_groups = cs48l32_pin_groups,
+	.n_pin_groups = ARRAY_SIZE(cs48l32_pin_groups),
+};
+
+static unsigned int cs48l32_pin_make_drv_str(struct cs48l32_pin_private *priv,
+					     unsigned int milliamps)
+{
+	switch (milliamps) {
+	case 4:
+		return 0;
+	case 8:
+		return 1 << CS48L32_GP_DRV_STR_SHIFT;
+	default:
+		break;
+	}
+
+	dev_warn(priv->dev, "%u mA is not a valid drive strength\n", milliamps);
+
+	return 0;
+}
+
+static unsigned int cs48l32_pin_unmake_drv_str(struct cs48l32_pin_private *priv,
+					       unsigned int regval)
+{
+	regval = (regval & CS48L32_GP_DRV_STR_MASK) >> CS48L32_GP_DRV_STR_SHIFT;
+
+	switch (regval) {
+	case 0:
+		return 4;
+	case 1:
+		return 8;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
+static int cs48l32_get_groups_count(struct pinctrl_dev *pctldev)
+{
+	struct cs48l32_pin_private *priv = pinctrl_dev_get_drvdata(pctldev);
+
+	/* Number of alt function groups plus number of single-pin groups */
+	return priv->chip->n_pin_groups + priv->chip->n_pins;
+}
+
+static const char *cs48l32_get_group_name(struct pinctrl_dev *pctldev,
+					  unsigned int selector)
+{
+	struct cs48l32_pin_private *priv = pinctrl_dev_get_drvdata(pctldev);
+
+	if (selector < priv->chip->n_pin_groups)
+		return priv->chip->pin_groups[selector].name;
+
+	selector -= priv->chip->n_pin_groups;
+
+	return cs48l32_pin_single_group_names[selector];
+}
+
+static int cs48l32_get_group_pins(struct pinctrl_dev *pctldev,
+				  unsigned int selector,
+				  const unsigned int **pins,
+				  unsigned int *num_pins)
+{
+	struct cs48l32_pin_private *priv = pinctrl_dev_get_drvdata(pctldev);
+
+	if (selector < priv->chip->n_pin_groups) {
+		*pins = priv->chip->pin_groups[selector].pins;
+		*num_pins = priv->chip->pin_groups[selector].n_pins;
+	} else {
+		/* return the dummy group for a single pin */
+		selector -= priv->chip->n_pin_groups;
+		*pins = &cs48l32_pin_single_group_pins[selector];
+		*num_pins = 1;
+	}
+
+	return 0;
+}
+
+static void cs48l32_pin_dbg_show_fn(struct cs48l32_pin_private *priv,
+				    struct seq_file *s,
+				    unsigned int pin, unsigned int fn)
+{
+	const struct cs48l32_pin_chip *chip = priv->chip;
+	int i, g_pin;
+
+	if (fn != 0) {
+		for (i = 0; i < ARRAY_SIZE(cs48l32_mux_funcs); ++i) {
+			if (cs48l32_mux_funcs[i].func == fn) {
+				seq_printf(s, " FN=%s", cs48l32_mux_funcs[i].name);
+				return;
+			}
+		}
+		return;	/* ignore unknown function values */
+	}
+
+	/* alt function */
+	for (i = 0; i < chip->n_pin_groups; ++i) {
+		for (g_pin = 0; g_pin < chip->pin_groups[i].n_pins; ++g_pin) {
+			if (chip->pin_groups[i].pins[g_pin] == pin) {
+				seq_printf(s, " FN=%s", chip->pin_groups[i].name);
+				return;
+			}
+		}
+	}
+}
+
+static void cs48l32_pin_dbg_show(struct pinctrl_dev *pctldev,
+				 struct seq_file *s, unsigned int pin)
+{
+	struct cs48l32_pin_private *priv = pinctrl_dev_get_drvdata(pctldev);
+	unsigned int reg = CS48L32_GPIO1_CTRL1 + (4 * pin);
+	unsigned int conf, fn;
+	int ret;
+
+	ret = regmap_read(priv->mfd->regmap, reg, &conf);
+	if (ret)
+		return;
+
+	seq_printf(s, "%08x", conf);
+
+	fn = (conf & CS48L32_GP_FN_MASK) >> CS48L32_GP_FN_SHIFT;
+	cs48l32_pin_dbg_show_fn(priv, s, pin, fn);
+
+	/* State of direction bit is only relevant if function==1 */
+	if (fn == 1) {
+		if (conf & CS48L32_GP_DIR_MASK)
+			seq_puts(s, " IN");
+		else
+			seq_puts(s, " OUT");
+	}
+
+	if (conf & CS48L32_GP_PU_MASK)
+		seq_puts(s, " PU");
+
+	if (conf & CS48L32_GP_PD_MASK)
+		seq_puts(s, " PD");
+
+	if (conf & CS48L32_GP_DB_MASK)
+		seq_puts(s, " DB");
+
+	if (conf & CS48L32_GP_OP_CFG_MASK)
+		seq_puts(s, " OD");
+	else
+		seq_puts(s, " CMOS");
+
+	seq_printf(s, " DRV=%umA", cs48l32_pin_unmake_drv_str(priv, conf));
+}
+
+
+static const struct pinctrl_ops cs48l32_pin_group_ops = {
+	.get_groups_count = &cs48l32_get_groups_count,
+	.get_group_name = &cs48l32_get_group_name,
+	.get_group_pins = &cs48l32_get_group_pins,
+	.pin_dbg_show = &cs48l32_pin_dbg_show,
+	.dt_node_to_map = &pinconf_generic_dt_node_to_map_all,
+	.dt_free_map = &pinctrl_utils_free_map,
+};
+
+static int cs48l32_mux_get_funcs_count(struct pinctrl_dev *pctldev)
+{
+	return ARRAY_SIZE(cs48l32_mux_funcs);
+}
+
+static const char *cs48l32_mux_get_func_name(struct pinctrl_dev *pctldev,
+					     unsigned int selector)
+{
+	return cs48l32_mux_funcs[selector].name;
+}
+
+static int cs48l32_mux_get_groups(struct pinctrl_dev *pctldev,
+				  unsigned int selector,
+				  const char * const **groups,
+				  unsigned int * const num_groups)
+{
+	struct cs48l32_pin_private *priv = pinctrl_dev_get_drvdata(pctldev);
+
+	*groups = cs48l32_mux_funcs[selector].group_names;
+
+	if (cs48l32_mux_funcs[selector].func == 0) {
+		/* alt func always maps to a single group */
+		*num_groups = 1;
+	} else {
+		/* other funcs map to all available gpio pins */
+		*num_groups = priv->chip->n_pins;
+	}
+
+	return 0;
+}
+
+static int cs48l32_mux_set_mux(struct pinctrl_dev *pctldev, unsigned int selector,
+			       unsigned int group)
+{
+	struct cs48l32_pin_private *priv = pinctrl_dev_get_drvdata(pctldev);
+	struct cs48l32_mfd *mfd = priv->mfd;
+	const struct cs48l32_pin_groups *pin_group = priv->chip->pin_groups;
+	unsigned int n_chip_groups = priv->chip->n_pin_groups;
+	const char *func_name = cs48l32_mux_funcs[selector].name;
+	unsigned int reg;
+	int i, ret;
+
+	dev_dbg(priv->dev, "%s selecting %u (%s) for group %u (%s)\n",
+		__func__, selector, func_name, group,
+		cs48l32_get_group_name(pctldev, group));
+
+	if (cs48l32_mux_funcs[selector].func == 0) {
+		/* alt func pin assignments are codec-specific */
+		for (i = 0; i < n_chip_groups; ++i) {
+			if (strcmp(func_name, pin_group->name) == 0)
+				break;
+
+			++pin_group;
+		}
+
+		if (i == n_chip_groups)
+			return -EINVAL;
+
+		for (i = 0; i < pin_group->n_pins; ++i) {
+			reg = CS48L32_GPIO1_CTRL1 + (4 * pin_group->pins[i]);
+
+			dev_dbg(priv->dev, "%s setting 0x%x func bits to 0\n", __func__, reg);
+
+			ret = regmap_update_bits(mfd->regmap, reg, CS48L32_GP_FN_MASK, 0);
+			if (ret)
+				break;
+
+		}
+	} else {
+		/*
+		 * for other funcs the group will be the gpio number and will
+		 * be offset by the number of chip-specific functions at the
+		 * start of the group list
+		 */
+		group -= n_chip_groups;
+		reg = CS48L32_GPIO1_CTRL1 + (4 * group);
+
+		dev_dbg(priv->dev, "%s setting 0x%x func bits to 0x%x\n",
+			__func__, reg, cs48l32_mux_funcs[selector].func);
+
+		ret = regmap_update_bits(mfd->regmap,
+					 reg,
+					 CS48L32_GP_FN_MASK,
+					 cs48l32_mux_funcs[selector].func);
+	}
+
+	if (ret)
+		dev_err(priv->dev, "Failed to write to 0x%x (%d)\n", reg, ret);
+
+	return ret;
+}
+
+static int cs48l32_gpio_set_direction(struct pinctrl_dev *pctldev,
+				      struct pinctrl_gpio_range *range,
+				      unsigned int pin,
+				      bool input)
+{
+	struct cs48l32_pin_private *priv = pinctrl_dev_get_drvdata(pctldev);
+	struct cs48l32_mfd *mfd = priv->mfd;
+	unsigned int reg = CS48L32_GPIO1_CTRL1 + (4 * pin);
+	unsigned int val;
+	int ret;
+
+	if (input)
+		val = CS48L32_GP_DIR_MASK;
+	else
+		val = 0;
+
+	ret = regmap_update_bits(mfd->regmap, reg, CS48L32_GP_DIR_MASK, val);
+	if (ret)
+		dev_err(priv->dev, "Failed to write to 0x%x (%d)\n", reg, ret);
+
+	return ret;
+}
+
+static int cs48l32_gpio_request_enable(struct pinctrl_dev *pctldev,
+				       struct pinctrl_gpio_range *range,
+				       unsigned int pin)
+{
+	struct cs48l32_pin_private *priv = pinctrl_dev_get_drvdata(pctldev);
+	struct cs48l32_mfd *mfd = priv->mfd;
+	unsigned int reg = CS48L32_GPIO1_CTRL1 + (4 * pin);
+	int ret;
+
+	/* put the pin into GPIO mode */
+	ret = regmap_update_bits(mfd->regmap, reg, CS48L32_GP_FN_MASK, 1);
+	if (ret)
+		dev_err(priv->dev, "Failed to write to 0x%x (%d)\n", reg, ret);
+
+	return ret;
+}
+
+static void cs48l32_gpio_disable_free(struct pinctrl_dev *pctldev,
+				      struct pinctrl_gpio_range *range,
+				      unsigned int pin)
+{
+	struct cs48l32_pin_private *priv = pinctrl_dev_get_drvdata(pctldev);
+	struct cs48l32_mfd *mfd = priv->mfd;
+	unsigned int reg = CS48L32_GPIO1_CTRL1 + (4 * pin);
+	int ret;
+
+	/* disable GPIO by setting to GPIO IN */
+	cs48l32_gpio_set_direction(pctldev, range, pin, true);
+
+	ret = regmap_update_bits(mfd->regmap, reg, CS48L32_GP_FN_MASK, 1);
+	if (ret)
+		dev_err(priv->dev, "Failed to write to 0x%x (%d)\n", reg, ret);
+}
+static const struct pinmux_ops cs48l32_pin_mux_ops = {
+	.get_functions_count = &cs48l32_mux_get_funcs_count,
+	.get_function_name = &cs48l32_mux_get_func_name,
+	.get_function_groups = &cs48l32_mux_get_groups,
+	.set_mux = &cs48l32_mux_set_mux,
+	.gpio_request_enable = &cs48l32_gpio_request_enable,
+	.gpio_disable_free = &cs48l32_gpio_disable_free,
+	.gpio_set_direction = &cs48l32_gpio_set_direction,
+	.strict = true, /* GPIO and other functions are exclusive */
+};
+
+static int cs48l32_pin_conf_get(struct pinctrl_dev *pctldev, unsigned int pin,
+				unsigned long *config)
+{
+	struct cs48l32_pin_private *priv = pinctrl_dev_get_drvdata(pctldev);
+	unsigned int param = pinconf_to_config_param(*config);
+	unsigned int result = 0;
+	unsigned int conf;
+	int ret;
+
+	ret = regmap_read(priv->mfd->regmap, CS48L32_GPIO1_CTRL1 + (4 * pin), &conf);
+	if (ret) {
+		dev_err(priv->dev, "Failed to read GP%d conf (%d)\n", pin + 1, ret);
+		return ret;
+	}
+
+	switch (param) {
+	case PIN_CONFIG_BIAS_BUS_HOLD:
+		conf &= CS48L32_GP_PU_MASK | CS48L32_GP_PD_MASK;
+		if (conf == (CS48L32_GP_PU_MASK | CS48L32_GP_PD_MASK))
+			result = 1;
+		break;
+	case PIN_CONFIG_BIAS_DISABLE:
+		conf &= CS48L32_GP_PU_MASK | CS48L32_GP_PD_MASK;
+		if (!conf)
+			result = 1;
+		break;
+	case PIN_CONFIG_BIAS_PULL_DOWN:
+		conf &= CS48L32_GP_PU_MASK | CS48L32_GP_PD_MASK;
+		if (conf == CS48L32_GP_PD_MASK)
+			result = 1;
+		break;
+	case PIN_CONFIG_BIAS_PULL_UP:
+		conf &= CS48L32_GP_PU_MASK | CS48L32_GP_PD_MASK;
+		if (conf == CS48L32_GP_PU_MASK)
+			result = 1;
+		break;
+	case PIN_CONFIG_DRIVE_OPEN_DRAIN:
+		if (conf & CS48L32_GP_OP_CFG_MASK)
+			result = 1;
+		break;
+	case PIN_CONFIG_DRIVE_PUSH_PULL:
+		if (!(conf & CS48L32_GP_OP_CFG_MASK))
+			result = 1;
+		break;
+	case PIN_CONFIG_DRIVE_STRENGTH:
+		result = cs48l32_pin_unmake_drv_str(priv, conf);
+		break;
+	case PIN_CONFIG_INPUT_DEBOUNCE:
+		dev_dbg(priv->dev, "Input debounce time not supported.");
+		break;
+	case PIN_CONFIG_INPUT_ENABLE:
+		if (conf & CS48L32_GP_DIR_MASK)
+			result = 1;
+		break;
+	case PIN_CONFIG_OUTPUT:
+		if ((conf & CS48L32_GP_DIR_MASK) && (conf & CS48L32_GP_LVL_MASK))
+			result = 1;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	*config = pinconf_to_config_packed(param, result);
+
+	return 0;
+}
+
+static int cs48l32_pin_conf_set(struct pinctrl_dev *pctldev, unsigned int pin,
+				unsigned long *configs, unsigned int num_configs)
+{
+	struct cs48l32_pin_private *priv = pinctrl_dev_get_drvdata(pctldev);
+	unsigned int conf = 0;
+	unsigned int mask = 0;
+	unsigned int reg = CS48L32_GPIO1_CTRL1 + (4 * pin);
+	unsigned int val;
+	int ret;
+
+	while (num_configs) {
+		dev_dbg(priv->dev, "%s config 0x%lx\n", __func__, *configs);
+
+		switch (pinconf_to_config_param(*configs)) {
+		case PIN_CONFIG_BIAS_BUS_HOLD:
+			mask |= CS48L32_GP_PU_MASK | CS48L32_GP_PD_MASK;
+			conf |= CS48L32_GP_PU_MASK | CS48L32_GP_PD_MASK;
+			break;
+		case PIN_CONFIG_BIAS_DISABLE:
+			mask |= CS48L32_GP_PU_MASK | CS48L32_GP_PD_MASK;
+			conf &= ~(CS48L32_GP_PU_MASK | CS48L32_GP_PD_MASK);
+			break;
+		case PIN_CONFIG_BIAS_PULL_DOWN:
+			mask |= CS48L32_GP_PU_MASK | CS48L32_GP_PD_MASK;
+			conf |= CS48L32_GP_PD_MASK;
+			conf &= ~CS48L32_GP_PU_MASK;
+			break;
+		case PIN_CONFIG_BIAS_PULL_UP:
+			mask |= CS48L32_GP_PU_MASK | CS48L32_GP_PD_MASK;
+			conf |= CS48L32_GP_PU_MASK;
+			conf &= ~CS48L32_GP_PD_MASK;
+			break;
+		case PIN_CONFIG_DRIVE_OPEN_DRAIN:
+			mask |= CS48L32_GP_OP_CFG_MASK;
+			conf |= CS48L32_GP_OP_CFG_MASK;
+			break;
+		case PIN_CONFIG_DRIVE_PUSH_PULL:
+			mask |= CS48L32_GP_OP_CFG_MASK;
+			conf &= ~CS48L32_GP_OP_CFG_MASK;
+			break;
+		case PIN_CONFIG_DRIVE_STRENGTH:
+			val = pinconf_to_config_argument(*configs);
+			mask |= CS48L32_GP_DRV_STR_MASK;
+			conf &= ~CS48L32_GP_DRV_STR_MASK;
+			conf |= cs48l32_pin_make_drv_str(priv, val);
+			break;
+		case PIN_CONFIG_INPUT_DEBOUNCE:
+			dev_dbg(priv->dev, "Input debounce time not supported.");
+			break;
+		case PIN_CONFIG_INPUT_ENABLE:
+			val = pinconf_to_config_argument(*configs);
+			mask |= CS48L32_GP_DIR_MASK;
+			if (val)
+				conf |= CS48L32_GP_DIR_MASK;
+			else
+				conf &= ~CS48L32_GP_DIR_MASK;
+			break;
+		case PIN_CONFIG_OUTPUT:
+			val = pinconf_to_config_argument(*configs);
+			mask |= CS48L32_GP_LVL_MASK;
+			if (val)
+				conf |= CS48L32_GP_LVL_MASK;
+			else
+				conf &= ~CS48L32_GP_LVL_MASK;
+
+			mask |= CS48L32_GP_DIR_MASK;
+			conf &= ~CS48L32_GP_DIR_MASK;
+			break;
+		default:
+			return -EINVAL;
+		}
+
+		++configs;
+		--num_configs;
+	}
+
+	dev_dbg(priv->dev, "%s gpio%d 0x%x:0x%x\n", __func__, pin + 1, reg, conf);
+
+	ret = regmap_update_bits(priv->mfd->regmap, reg, mask, conf);
+	if (ret)
+		dev_err(priv->dev, "Failed to write GPIO%d conf (%d) reg 0x%x\n",
+			pin + 1, ret, reg);
+
+	return ret;
+}
+
+static int cs48l32_pin_conf_group_set(struct pinctrl_dev *pctldev,
+				      unsigned int selector,
+				      unsigned long *configs,
+				      unsigned int num_configs)
+{
+	struct cs48l32_pin_private *priv = pinctrl_dev_get_drvdata(pctldev);
+	const struct cs48l32_pin_groups *pin_group;
+	unsigned int n_groups = priv->chip->n_pin_groups;
+	int i, ret;
+
+	dev_dbg(priv->dev, "%s setting group %s\n", __func__,
+		cs48l32_get_group_name(pctldev, selector));
+
+	if (selector >= n_groups) {
+		/* group is a single pin, convert to pin number and set */
+		return cs48l32_pin_conf_set(pctldev,
+					  selector - n_groups,
+					  configs,
+					  num_configs);
+	} else {
+		pin_group = &priv->chip->pin_groups[selector];
+
+		for (i = 0; i < pin_group->n_pins; ++i) {
+			ret = cs48l32_pin_conf_set(pctldev,
+						 pin_group->pins[i],
+						 configs,
+						 num_configs);
+			if (ret)
+				return ret;
+		}
+	}
+
+	return 0;
+}
+
+static const struct pinconf_ops cs48l32_pin_conf_ops = {
+	.is_generic = true,
+	.pin_config_get = &cs48l32_pin_conf_get,
+	.pin_config_set = &cs48l32_pin_conf_set,
+	.pin_config_group_set = &cs48l32_pin_conf_group_set,
+
+};
+
+static struct pinctrl_desc cs48l32_pin_desc = {
+	.name = "cs48l32-pinctrl",
+	.pins = cs48l32_pins,
+	.pctlops = &cs48l32_pin_group_ops,
+	.pmxops = &cs48l32_pin_mux_ops,
+	.confops = &cs48l32_pin_conf_ops,
+	.owner = THIS_MODULE,
+};
+
+static int cs48l32_pin_probe(struct platform_device *pdev)
+{
+	struct cs48l32_mfd *mfd = dev_get_drvdata(pdev->dev.parent);
+	struct cs48l32_pin_private *priv;
+	int ret;
+
+	BUILD_BUG_ON(ARRAY_SIZE(cs48l32_pin_single_group_names) !=
+		     ARRAY_SIZE(cs48l32_pin_single_group_pins));
+
+	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->dev = &pdev->dev;
+	priv->mfd = mfd;
+	/* Composite MFD device so shares the parent OF node. */
+	pdev->dev.of_node = mfd->dev->of_node;
+
+	priv->chip = &cs48l32_pin_chip;
+	cs48l32_pin_desc.npins = priv->chip->n_pins;
+
+	ret = devm_pinctrl_register_and_init(&pdev->dev, &cs48l32_pin_desc, priv, &priv->pctl);
+	if (ret)
+		return dev_err_probe(priv->dev, ret, "Failed pinctrl register\n");
+
+	ret = pinctrl_enable(priv->pctl);
+	if (ret)
+		return dev_err_probe(priv->dev, ret, "Failed to enable pinctrl\n");
+
+	platform_set_drvdata(pdev, priv);
+
+	dev_dbg(priv->dev, "pinctrl registered\n");
+
+	return 0;
+}
+
+static struct platform_driver cs48l32_pin_driver = {
+	.probe = &cs48l32_pin_probe,
+	.driver = {
+		.name = "cs48l32-pinctrl",
+	},
+};
+
+module_platform_driver(cs48l32_pin_driver);
+
+MODULE_DESCRIPTION("CS48L32 pinctrl driver");
+MODULE_AUTHOR("Richard Fitzgerald <rf@opensource.cirrus.com>");
+MODULE_AUTHOR("Piotr Stankiewicz <piotrs@opensource.cirrus.com>");
+MODULE_LICENSE("GPL");
diff --git a/drivers/pinctrl/cirrus/pinctrl-cs48l32.h b/drivers/pinctrl/cirrus/pinctrl-cs48l32.h
new file mode 100644
index 000000000000..2193c7558dd3
--- /dev/null
+++ b/drivers/pinctrl/cirrus/pinctrl-cs48l32.h
@@ -0,0 +1,62 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Pinctrl for Cirrus Logic CS48L32
+ *
+ * Copyright (C) 2020, 2022 Cirrus Logic, Inc. and
+ *               Cirrus Logic International Semiconductor Ltd.
+ */
+
+#ifndef PINCTRL_CS48L32_H
+#define PINCTRL_CS48L32_H
+
+#include <linux/device.h>
+#include <linux/mfd/cs48l32/core.h>
+
+struct pinctrl_dev;
+
+#define CS48L32_GP_DIR_MASK		0x80000000
+#define CS48L32_GP_DIR_SHIFT			31
+#define CS48L32_GP_PU_MASK		0x40000000
+#define CS48L32_GP_PU_SHIFT			30
+#define CS48L32_GP_PD_MASK		0x20000000
+#define CS48L32_GP_PD_SHIFT			29
+#define CS48L32_GP_DRV_STR_MASK		0x03000000
+#define CS48L32_GP_DRV_STR_SHIFT		24
+#define CS48L32_GP_DBTIME_MASK		0x000f0000
+#define CS48L32_GP_DBTIME_SHIFT			16
+#define CS48L32_GP_LVL_MASK		0x00008000
+#define CS48L32_GP_LVL_SHIFT			15
+#define CS48L32_GP_OP_CFG_MASK		0x00004000
+#define CS48L32_GP_OP_CFG_SHIFT			14
+#define CS48L32_GP_DB_MASK		0x00002000
+#define CS48L32_GP_DB_SHIFT			13
+#define CS48L32_GP_POL_MASK		0x00001000
+#define CS48L32_GP_POL_SHIFT			12
+#define CS48L32_GP_FN_MASK		0x000007ff
+#define CS48L32_GP_FN_SHIFT			 0
+
+#define CS48L32_NUM_GPIOS			16
+
+struct cs48l32_pin_groups {
+	const char *name;
+	const unsigned int *pins;
+	unsigned int n_pins;
+};
+
+struct cs48l32_pin_chip {
+	unsigned int n_pins;
+
+	const struct cs48l32_pin_groups *pin_groups;
+	unsigned int n_pin_groups;
+};
+
+struct cs48l32_pin_private {
+	struct cs48l32_mfd *mfd;
+
+	const struct cs48l32_pin_chip *chip; /* chip-specific groups */
+
+	struct device *dev;
+	struct pinctrl_dev *pctl;
+};
+
+#endif
-- 
2.30.2

