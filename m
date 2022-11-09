Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8A566230C7
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 17:56:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231535AbiKIQ4Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 11:56:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230243AbiKIQzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 11:55:10 -0500
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FAEB2A26B;
        Wed,  9 Nov 2022 08:54:02 -0800 (PST)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2A9EDNjS027347;
        Wed, 9 Nov 2022 10:53:36 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=dJ5BiHi/4KsxHP0YWvFqK47+1pv9GNU8ZJtgpqFaKJ0=;
 b=LY28Pi0eJhh1jFkyLFRvMj2fERv4wRLRt9FFQ2LKyTpKilaoiDd7zy8A9eL/Yj4+AJ5i
 jlQfkt3C6L0zpDh7meCiJHJZA9lQm9+QwZovc5O+RM+2I8mqEvSdJZNJMywvvIOvmeGN
 JK6U0NkHJWuag0FNPRPFHFeYFvWDHs1S56iixgaqLcQnFekIgJ6T2flU5ghVZG9P7FwQ
 +9iiFleq/uzqN27rY0N1/CHp6priyo52AjlHFVz7w1q7uuqpvfukyEU6GIGVQVoc2UoH
 GeygAPtdU/oWxwVXziXDcT1OjbwBEwKnYlAsldeXqf3gLBvTn3ZRpTRnAuOYZ5xSCL5H Uw== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3knm8pde7v-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Nov 2022 10:53:36 -0600
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.15; Wed, 9 Nov
 2022 10:53:33 -0600
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.15 via Frontend
 Transport; Wed, 9 Nov 2022 10:53:33 -0600
Received: from debianA11184.ad.cirrus.com (AUSNPC0LSNW1.ad.cirrus.com [198.61.65.92])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 461F7478;
        Wed,  9 Nov 2022 16:53:33 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <lee@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <linus.walleij@linaro.org>,
        <broonie@kernel.org>, <tglx@linutronix.de>, <maz@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH 03/12] mfd: cs48l32: Add support for CS48L31/32/33 codecs
Date:   Wed, 9 Nov 2022 16:53:22 +0000
Message-ID: <20221109165331.29332-4-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221109165331.29332-1-rf@opensource.cirrus.com>
References: <20221109165331.29332-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: VuRZUj3DP1_OgkG2GM65W3o5jte__lzz
X-Proofpoint-GUID: VuRZUj3DP1_OgkG2GM65W3o5jte__lzz
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

The CS48L31/32/33 audio codecs are multi-function devices
containing gpios, irq controller and regulators in addition
to the core audio functionality.

Signed-off-by: Piotr Stankiewicz <piotrs@opensource.cirrus.com>
Signed-off-by: Qi Zhou <qi.zhou@cirrus.com>
Signed-off-by: Stuart Henderson <stuarth@opensource.cirrus.com>
Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 MAINTAINERS                      |   5 +-
 drivers/mfd/Kconfig              |  13 +
 drivers/mfd/Makefile             |   2 +
 drivers/mfd/cs48l32-tables.c     | 541 +++++++++++++++++++++++++++++++
 drivers/mfd/cs48l32.c            | 434 +++++++++++++++++++++++++
 drivers/mfd/cs48l32.h            |  28 ++
 include/linux/mfd/cs48l32/core.h |  49 +++
 7 files changed, 1071 insertions(+), 1 deletion(-)
 create mode 100644 drivers/mfd/cs48l32-tables.c
 create mode 100644 drivers/mfd/cs48l32.c
 create mode 100644 drivers/mfd/cs48l32.h
 create mode 100644 include/linux/mfd/cs48l32/core.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 3f94ed38089b..f1d696f29f11 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5001,7 +5001,7 @@ F:	include/dt-bindings/pinctrl/lochnagar.h
 F:	include/linux/mfd/lochnagar*
 F:	sound/soc/codecs/lochnagar-sc.c
 
-CIRRUS LOGIC MADERA CODEC DRIVERS
+CIRRUS LOGIC MADERA/CS48L32 CODEC DRIVERS
 M:	Charles Keepax <ckeepax@opensource.cirrus.com>
 M:	Richard Fitzgerald <rf@opensource.cirrus.com>
 L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
@@ -5009,16 +5009,19 @@ L:	patches@opensource.cirrus.com
 S:	Supported
 W:	https://github.com/CirrusLogic/linux-drivers/wiki
 T:	git https://github.com/CirrusLogic/linux-drivers.git
+F:	Documentation/devicetree/bindings/mfd/cirrus,cs48l32.yaml
 F:	Documentation/devicetree/bindings/mfd/cirrus,madera.yaml
 F:	Documentation/devicetree/bindings/pinctrl/cirrus,madera.yaml
 F:	Documentation/devicetree/bindings/sound/cirrus,madera.yaml
 F:	drivers/gpio/gpio-madera*
 F:	drivers/irqchip/irq-madera*
 F:	drivers/mfd/cs47l*
+F:	drivers/mfd/cs48l*
 F:	drivers/mfd/madera*
 F:	drivers/pinctrl/cirrus/*
 F:	include/dt-bindings/sound/madera*
 F:	include/linux/irqchip/irq-madera*
+F:	include/linux/mfd/cs48l32/*
 F:	include/linux/mfd/madera/*
 F:	include/sound/madera*
 F:	sound/soc/codecs/cs47l*
diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 6653d03e0fe3..2be52ba23c7a 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -300,6 +300,19 @@ config MFD_CS47L92
 	help
 	  Support for Cirrus Logic CS42L92, CS47L92 and CS47L93 Smart Codecs
 
+config MFD_CS48L32
+	bool "Cirrus Logic CS48L31/32/33"
+	depends on SPI_MASTER
+	select MFD_CORE
+	select REGMAP
+	select REGMAP_SPI
+	select REGMAP_IRQ
+	select CIRRUS_CS48L32_IRQ
+	select PINCTRL
+	select PINCTRL_CS48L32
+	help
+	  Support for Cirrus Logic CS48L31, CS48L32 and CS48L33 Smart Codecs.
+
 config MFD_ASIC3
 	bool "Compaq ASIC3"
 	depends on GPIOLIB
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index 4dd479212b3a..4edbeb9b7a31 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -91,6 +91,8 @@ obj-$(CONFIG_MFD_MADERA)	+= madera.o
 obj-$(CONFIG_MFD_MADERA_I2C)	+= madera-i2c.o
 obj-$(CONFIG_MFD_MADERA_SPI)	+= madera-spi.o
 
+obj-$(CONFIG_MFD_CS48L32)	+= cs48l32.o cs48l32-tables.o
+
 obj-$(CONFIG_TPS6105X)		+= tps6105x.o
 obj-$(CONFIG_TPS65010)		+= tps65010.o
 obj-$(CONFIG_TPS6507X)		+= tps6507x.o
diff --git a/drivers/mfd/cs48l32-tables.c b/drivers/mfd/cs48l32-tables.c
new file mode 100644
index 000000000000..5dab9753deb0
--- /dev/null
+++ b/drivers/mfd/cs48l32-tables.c
@@ -0,0 +1,541 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Regmap tables for Cirrus Logic CS48L32 audio codec.
+ *
+ * Copyright (C) 2018, 2020, 2022 Cirrus Logic, Inc. and
+ *               Cirrus Logic International Semiconductor Ltd.
+ */
+
+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/mfd/cs48l32/core.h>
+#include <linux/mfd/cs48l32/registers.h>
+
+#include "cs48l32.h"
+
+static const struct reg_sequence cs48l32_reva_patch[] = {
+	{ 0x00001044, 0x0005000f },
+	{ 0x00001c34, 0x000037e8 },
+	{ 0x000046d8, 0x00000fe0 },
+};
+
+int cs48l32_patch(struct cs48l32_mfd *cs48l32)
+{
+	int ret;
+
+	ret = regmap_register_patch(cs48l32->regmap, cs48l32_reva_patch,
+				    ARRAY_SIZE(cs48l32_reva_patch));
+	if (ret < 0)
+		dev_err(cs48l32->dev, "Error applying patch: %d\n", ret);
+
+	return ret;
+}
+
+static const struct reg_default cs48l32_reg_default[] = {
+	{ 0x00000c08, 0xe1000001 }, /* GPIO1_CTRL1 */
+	{ 0x00000c0c, 0xe1000001 }, /* GPIO2_CTRL1 */
+	{ 0x00000c10, 0xe1000001 }, /* GPIO3_CTRL1 */
+	{ 0x00000c14, 0xe1000001 }, /* GPIO4_CTRL1 */
+	{ 0x00000c18, 0xe1000001 }, /* GPIO5_CTRL1 */
+	{ 0x00000c1c, 0xe1000001 }, /* GPIO6_CTRL1 */
+	{ 0x00000c20, 0xe1000001 }, /* GPIO7_CTRL1 */
+	{ 0x00000c24, 0xe1000001 }, /* GPIO8_CTRL1 */
+	{ 0x00000c28, 0xe1000001 }, /* GPIO9_CTRL1 */
+	{ 0x00000c2c, 0xe1000001 }, /* GPIO10_CTRL1 */
+	{ 0x00000c30, 0xe1000001 }, /* GPIO11_CTRL1 */
+	{ 0x00000c34, 0xe1000001 }, /* GPIO12_CTRL1 */
+	{ 0x00000c38, 0xe1000001 }, /* GPIO13_CTRL1 */
+	{ 0x00000c3c, 0xe1000001 }, /* GPIO14_CTRL1 */
+	{ 0x00000c40, 0xe1000001 }, /* GPIO15_CTRL1 */
+	{ 0x00000c44, 0xe1000001 }, /* GPIO16_CTRL1 */
+	{ 0x00001020, 0x00000000 }, /* OUTPUT_SYS_CLK */
+	{ 0x00001044, 0x0005000f }, /* AUXPDM_CTRL */
+	{ 0x0000105c, 0x00000000 }, /* AUXPDM_CTRL2 */
+	{ 0x00001400, 0x00000002 }, /* CLOCK32K */
+	{ 0x00001404, 0x00000404 }, /* SYSTEM_CLOCK1 */
+	{ 0x00001420, 0x00000003 }, /* SAMPLE_RATE1 */
+	{ 0x00001424, 0x00000003 }, /* SAMPLE_RATE2 */
+	{ 0x00001428, 0x00000003 }, /* SAMPLE_RATE3 */
+	{ 0x0000142c, 0x00000003 }, /* SAMPLE_RATE4 */
+	{ 0x00001c00, 0x00000002 }, /* FLL1_CONTROL1 */
+	{ 0x00001c04, 0x88203004 }, /* FLL1_CONTROL2 */
+	{ 0x00001c08, 0x00000000 }, /* FLL1_CONTROL3 */
+	{ 0x00001c0c, 0x21f05001 }, /* FLL1_CONTROL4 */
+	{ 0x00001ca0, 0x00000c04 }, /* FLL1_GPIO_CLOCK */
+	{ 0x00002000, 0x00000006 }, /* CHARGE_PUMP1 */
+	{ 0x00002408, 0x000003e4 }, /* LDO2_CTRL1 */
+	{ 0x00002410, 0x000000e6 }, /* MICBIAS_CTRL1 */
+	{ 0x00002418, 0x00000222 }, /* MICBIAS_CTRL5 */
+	{ 0x00002710, 0x00004600 }, /* IRQ1_CTRL_AOD */
+	{ 0x00004000, 0x00000000 }, /* INPUT_CONTROL */
+	{ 0x00004008, 0x00000400 }, /* INPUT_RATE_CONTROL */
+	{ 0x0000400c, 0x00000000 }, /* INPUT_CONTROL2 */
+	{ 0x00004020, 0x00050020 }, /* INPUT1_CONTROL1 */
+	{ 0x00004024, 0x00000000 }, /* IN1L_CONTROL1 */
+	{ 0x00004028, 0x10800080 }, /* IN1L_CONTROL2 */
+	{ 0x00004044, 0x00000000 }, /* IN1R_CONTROL1 */
+	{ 0x00004048, 0x10800080 }, /* IN1R_CONTROL2 */
+	{ 0x00004060, 0x00050020 }, /* INPUT2_CONTROL1 */
+	{ 0x00004064, 0x00000000 }, /* IN2L_CONTROL1 */
+	{ 0x00004068, 0x10800000 }, /* IN2L_CONTROL2 */
+	{ 0x00004084, 0x00000000 }, /* IN2R_CONTROL1 */
+	{ 0x00004088, 0x10800000 }, /* IN2R_CONTROL2 */
+	{ 0x00004244, 0x00000002 }, /* INPUT_HPF_CONTROL */
+	{ 0x00004248, 0x00000022 }, /* INPUT_VOL_CONTROL */
+	{ 0x00004300, 0x00000000 }, /* AUXPDM_CONTROL1 */
+	{ 0x00004304, 0x00000000 }, /* AUXPDM_CONTROL2 */
+	{ 0x00004308, 0x00010008 }, /* AUXPDM1_CONTROL1 */
+	{ 0x00004310, 0x00010008 }, /* AUXPDM2_CONTROL1 */
+	{ 0x00004688, 0x00000000 }, /* ADC1L_ANA_CONTROL1 */
+	{ 0x0000468c, 0x00000000 }, /* ADC1R_ANA_CONTROL1 */
+	{ 0x00006000, 0x00000000 }, /* ASP1_ENABLES1 */
+	{ 0x00006004, 0x00000028 }, /* ASP1_CONTROL1 */
+	{ 0x00006008, 0x18180200 }, /* ASP1_CONTROL2 */
+	{ 0x0000600c, 0x00000002 }, /* ASP1_CONTROL3 */
+	{ 0x00006010, 0x03020100 }, /* ASP1_FRAME_CONTROL1 */
+	{ 0x00006014, 0x07060504 }, /* ASP1_FRAME_CONTROL2 */
+	{ 0x00006020, 0x03020100 }, /* ASP1_FRAME_CONTROL5 */
+	{ 0x00006024, 0x07060504 }, /* ASP1_FRAME_CONTROL6 */
+	{ 0x00006030, 0x00000020 }, /* ASP1_DATA_CONTROL1 */
+	{ 0x00006040, 0x00000020 }, /* ASP1_DATA_CONTROL5 */
+	{ 0x00006080, 0x00000000 }, /* ASP2_ENABLES1 */
+	{ 0x00006084, 0x00000028 }, /* ASP2_CONTROL1 */
+	{ 0x00006088, 0x18180200 }, /* ASP2_CONTROL2 */
+	{ 0x0000608c, 0x00000002 }, /* ASP2_CONTROL3 */
+	{ 0x00006090, 0x03020100 }, /* ASP2_FRAME_CONTROL1 */
+	{ 0x000060a0, 0x03020100 }, /* ASP2_FRAME_CONTROL5 */
+	{ 0x000060b0, 0x00000020 }, /* ASP2_DATA_CONTROL1 */
+	{ 0x000060c0, 0x00000020 }, /* ASP2_DATA_CONTROL5 */
+	{ 0x00008200, 0x00800000 }, /* ASP1TX1_INPUT1 */
+	{ 0x00008204, 0x00800000 }, /* ASP1TX1_INPUT2 */
+	{ 0x00008208, 0x00800000 }, /* ASP1TX1_INPUT3 */
+	{ 0x0000820c, 0x00800000 }, /* ASP1TX1_INPUT4 */
+	{ 0x00008210, 0x00800000 }, /* ASP1TX2_INPUT1 */
+	{ 0x00008214, 0x00800000 }, /* ASP1TX2_INPUT2 */
+	{ 0x00008218, 0x00800000 }, /* ASP1TX2_INPUT3 */
+	{ 0x0000821c, 0x00800000 }, /* ASP1TX2_INPUT4 */
+	{ 0x00008220, 0x00800000 }, /* ASP1TX3_INPUT1 */
+	{ 0x00008224, 0x00800000 }, /* ASP1TX3_INPUT2 */
+	{ 0x00008228, 0x00800000 }, /* ASP1TX3_INPUT3 */
+	{ 0x0000822c, 0x00800000 }, /* ASP1TX3_INPUT4 */
+	{ 0x00008230, 0x00800000 }, /* ASP1TX4_INPUT1 */
+	{ 0x00008234, 0x00800000 }, /* ASP1TX4_INPUT2 */
+	{ 0x00008238, 0x00800000 }, /* ASP1TX4_INPUT3 */
+	{ 0x0000823c, 0x00800000 }, /* ASP1TX4_INPUT4 */
+	{ 0x00008240, 0x00800000 }, /* ASP1TX5_INPUT1 */
+	{ 0x00008244, 0x00800000 }, /* ASP1TX5_INPUT2 */
+	{ 0x00008248, 0x00800000 }, /* ASP1TX5_INPUT3 */
+	{ 0x0000824c, 0x00800000 }, /* ASP1TX5_INPUT4 */
+	{ 0x00008250, 0x00800000 }, /* ASP1TX6_INPUT1 */
+	{ 0x00008254, 0x00800000 }, /* ASP1TX6_INPUT2 */
+	{ 0x00008258, 0x00800000 }, /* ASP1TX6_INPUT3 */
+	{ 0x0000825c, 0x00800000 }, /* ASP1TX6_INPUT4 */
+	{ 0x00008260, 0x00800000 }, /* ASP1TX7_INPUT1 */
+	{ 0x00008264, 0x00800000 }, /* ASP1TX7_INPUT2 */
+	{ 0x00008268, 0x00800000 }, /* ASP1TX7_INPUT3 */
+	{ 0x0000826c, 0x00800000 }, /* ASP1TX7_INPUT4 */
+	{ 0x00008270, 0x00800000 }, /* ASP1TX8_INPUT1 */
+	{ 0x00008274, 0x00800000 }, /* ASP1TX8_INPUT2 */
+	{ 0x00008278, 0x00800000 }, /* ASP1TX8_INPUT3 */
+	{ 0x0000827c, 0x00800000 }, /* ASP1TX8_INPUT4 */
+	{ 0x00008300, 0x00800000 }, /* ASP2TX1_INPUT1 */
+	{ 0x00008304, 0x00800000 }, /* ASP2TX1_INPUT2 */
+	{ 0x00008308, 0x00800000 }, /* ASP2TX1_INPUT3 */
+	{ 0x0000830c, 0x00800000 }, /* ASP2TX1_INPUT4 */
+	{ 0x00008310, 0x00800000 }, /* ASP2TX2_INPUT1 */
+	{ 0x00008314, 0x00800000 }, /* ASP2TX2_INPUT2 */
+	{ 0x00008318, 0x00800000 }, /* ASP2TX2_INPUT3 */
+	{ 0x0000831c, 0x00800000 }, /* ASP2TX2_INPUT4 */
+	{ 0x00008320, 0x00800000 }, /* ASP2TX3_INPUT1 */
+	{ 0x00008324, 0x00800000 }, /* ASP2TX3_INPUT2 */
+	{ 0x00008328, 0x00800000 }, /* ASP2TX3_INPUT3 */
+	{ 0x0000832c, 0x00800000 }, /* ASP2TX3_INPUT4 */
+	{ 0x00008330, 0x00800000 }, /* ASP2TX4_INPUT1 */
+	{ 0x00008334, 0x00800000 }, /* ASP2TX4_INPUT2 */
+	{ 0x00008338, 0x00800000 }, /* ASP2TX4_INPUT3 */
+	{ 0x0000833c, 0x00800000 }, /* ASP2TX4_INPUT4 */
+	{ 0x00008980, 0x00000000 }, /* ISRC1INT1_INPUT1 */
+	{ 0x00008990, 0x00000000 }, /* ISRC1INT2_INPUT1 */
+	{ 0x000089a0, 0x00000000 }, /* ISRC1INT3_INPUT1 */
+	{ 0x000089b0, 0x00000000 }, /* ISRC1INT4_INPUT1 */
+	{ 0x000089c0, 0x00000000 }, /* ISRC1DEC1_INPUT1 */
+	{ 0x000089d0, 0x00000000 }, /* ISRC1DEC2_INPUT1 */
+	{ 0x000089e0, 0x00000000 }, /* ISRC1DEC3_INPUT1 */
+	{ 0x000089f0, 0x00000000 }, /* ISRC1DEC4_INPUT1 */
+	{ 0x00008a00, 0x00000000 }, /* ISRC2INT1_INPUT1 */
+	{ 0x00008a10, 0x00000000 }, /* ISRC2INT2_INPUT1 */
+	{ 0x00008a40, 0x00000000 }, /* ISRC2DEC1_INPUT1 */
+	{ 0x00008a50, 0x00000000 }, /* ISRC2DEC2_INPUT1 */
+	{ 0x00008a80, 0x00000000 }, /* ISRC3INT1_INPUT1 */
+	{ 0x00008a90, 0x00000000 }, /* ISRC3INT2_INPUT1 */
+	{ 0x00008ac0, 0x00000000 }, /* ISRC3DEC1_INPUT1 */
+	{ 0x00008ad0, 0x00000000 }, /* ISRC3DEC2_INPUT1 */
+	{ 0x00008b80, 0x00800000 }, /* EQ1_INPUT1 */
+	{ 0x00008b84, 0x00800000 }, /* EQ1_INPUT2 */
+	{ 0x00008b88, 0x00800000 }, /* EQ1_INPUT3 */
+	{ 0x00008b8c, 0x00800000 }, /* EQ1_INPUT4 */
+	{ 0x00008b90, 0x00800000 }, /* EQ2_INPUT1 */
+	{ 0x00008b94, 0x00800000 }, /* EQ2_INPUT2 */
+	{ 0x00008b98, 0x00800000 }, /* EQ2_INPUT3 */
+	{ 0x00008b9c, 0x00800000 }, /* EQ2_INPUT4 */
+	{ 0x00008ba0, 0x00800000 }, /* EQ3_INPUT1 */
+	{ 0x00008ba4, 0x00800000 }, /* EQ3_INPUT2 */
+	{ 0x00008ba8, 0x00800000 }, /* EQ3_INPUT3 */
+	{ 0x00008bac, 0x00800000 }, /* EQ3_INPUT4 */
+	{ 0x00008bb0, 0x00800000 }, /* EQ4_INPUT1 */
+	{ 0x00008bb4, 0x00800000 }, /* EQ4_INPUT2 */
+	{ 0x00008bb8, 0x00800000 }, /* EQ4_INPUT3 */
+	{ 0x00008bbc, 0x00800000 }, /* EQ4_INPUT4 */
+	{ 0x00008c00, 0x00800000 }, /* DRC1L_INPUT1 */
+	{ 0x00008c04, 0x00800000 }, /* DRC1L_INPUT2 */
+	{ 0x00008c08, 0x00800000 }, /* DRC1L_INPUT3 */
+	{ 0x00008c0c, 0x00800000 }, /* DRC1L_INPUT4 */
+	{ 0x00008c10, 0x00800000 }, /* DRC1R_INPUT1 */
+	{ 0x00008c14, 0x00800000 }, /* DRC1R_INPUT2 */
+	{ 0x00008c18, 0x00800000 }, /* DRC1R_INPUT3 */
+	{ 0x00008c1c, 0x00800000 }, /* DRC1R_INPUT4 */
+	{ 0x00008c20, 0x00800000 }, /* DRC2L_INPUT1 */
+	{ 0x00008c24, 0x00800000 }, /* DRC2L_INPUT2 */
+	{ 0x00008c28, 0x00800000 }, /* DRC2L_INPUT3 */
+	{ 0x00008c2c, 0x00800000 }, /* DRC2L_INPUT4 */
+	{ 0x00008c30, 0x00800000 }, /* DRC2R_INPUT1 */
+	{ 0x00008c34, 0x00800000 }, /* DRC2R_INPUT2 */
+	{ 0x00008c38, 0x00800000 }, /* DRC2R_INPUT3 */
+	{ 0x00008c3c, 0x00800000 }, /* DRC2R_INPUT4 */
+	{ 0x00008c80, 0x00800000 }, /* LHPF1_INPUT1 */
+	{ 0x00008c84, 0x00800000 }, /* LHPF1_INPUT2 */
+	{ 0x00008c88, 0x00800000 }, /* LHPF1_INPUT3 */
+	{ 0x00008c8c, 0x00800000 }, /* LHPF1_INPUT4 */
+	{ 0x00008c90, 0x00800000 }, /* LHPF2_INPUT1 */
+	{ 0x00008c94, 0x00800000 }, /* LHPF2_INPUT2 */
+	{ 0x00008c98, 0x00800000 }, /* LHPF2_INPUT3 */
+	{ 0x00008c9c, 0x00800000 }, /* LHPF2_INPUT4 */
+	{ 0x00008ca0, 0x00800000 }, /* LHPF3_INPUT1 */
+	{ 0x00008ca4, 0x00800000 }, /* LHPF3_INPUT2 */
+	{ 0x00008ca8, 0x00800000 }, /* LHPF3_INPUT3 */
+	{ 0x00008cac, 0x00800000 }, /* LHPF3_INPUT4 */
+	{ 0x00008cb0, 0x00800000 }, /* LHPF4_INPUT1 */
+	{ 0x00008cb4, 0x00800000 }, /* LHPF4_INPUT2 */
+	{ 0x00008cb8, 0x00800000 }, /* LHPF4_INPUT3 */
+	{ 0x00008cbc, 0x00800000 }, /* LHPF4_INPUT4 */
+	{ 0x00009000, 0x00800000 }, /* DSP1RX1_INPUT1 */
+	{ 0x00009004, 0x00800000 }, /* DSP1RX1_INPUT2 */
+	{ 0x00009008, 0x00800000 }, /* DSP1RX1_INPUT3 */
+	{ 0x0000900c, 0x00800000 }, /* DSP1RX1_INPUT4 */
+	{ 0x00009010, 0x00800000 }, /* DSP1RX2_INPUT1 */
+	{ 0x00009014, 0x00800000 }, /* DSP1RX2_INPUT2 */
+	{ 0x00009018, 0x00800000 }, /* DSP1RX2_INPUT3 */
+	{ 0x0000901c, 0x00800000 }, /* DSP1RX2_INPUT4 */
+	{ 0x00009020, 0x00800000 }, /* DSP1RX3_INPUT1 */
+	{ 0x00009024, 0x00800000 }, /* DSP1RX3_INPUT2 */
+	{ 0x00009028, 0x00800000 }, /* DSP1RX3_INPUT3 */
+	{ 0x0000902c, 0x00800000 }, /* DSP1RX3_INPUT4 */
+	{ 0x00009030, 0x00800000 }, /* DSP1RX4_INPUT1 */
+	{ 0x00009034, 0x00800000 }, /* DSP1RX4_INPUT2 */
+	{ 0x00009038, 0x00800000 }, /* DSP1RX4_INPUT3 */
+	{ 0x0000903c, 0x00800000 }, /* DSP1RX4_INPUT4 */
+	{ 0x00009040, 0x00800000 }, /* DSP1RX5_INPUT1 */
+	{ 0x00009044, 0x00800000 }, /* DSP1RX5_INPUT2 */
+	{ 0x00009048, 0x00800000 }, /* DSP1RX5_INPUT3 */
+	{ 0x0000904c, 0x00800000 }, /* DSP1RX5_INPUT4 */
+	{ 0x00009050, 0x00800000 }, /* DSP1RX6_INPUT1 */
+	{ 0x00009054, 0x00800000 }, /* DSP1RX6_INPUT2 */
+	{ 0x00009058, 0x00800000 }, /* DSP1RX6_INPUT3 */
+	{ 0x0000905c, 0x00800000 }, /* DSP1RX6_INPUT4 */
+	{ 0x00009060, 0x00800000 }, /* DSP1RX7_INPUT1 */
+	{ 0x00009064, 0x00800000 }, /* DSP1RX7_INPUT2 */
+	{ 0x00009068, 0x00800000 }, /* DSP1RX7_INPUT3 */
+	{ 0x0000906c, 0x00800000 }, /* DSP1RX7_INPUT4 */
+	{ 0x00009070, 0x00800000 }, /* DSP1RX8_INPUT1 */
+	{ 0x00009074, 0x00800000 }, /* DSP1RX8_INPUT2 */
+	{ 0x00009078, 0x00800000 }, /* DSP1RX8_INPUT3 */
+	{ 0x0000907c, 0x00800000 }, /* DSP1RX8_INPUT4 */
+	{ 0x0000a400, 0x00000000 }, /* ISRC1_CONTROL1 */
+	{ 0x0000a404, 0x00000000 }, /* ISRC1_CONTROL2 */
+	{ 0x0000a510, 0x00000000 }, /* ISRC2_CONTROL1 */
+	{ 0x0000a514, 0x00000000 }, /* ISRC2_CONTROL2 */
+	{ 0x0000a620, 0x00000000 }, /* ISRC3_CONTROL1 */
+	{ 0x0000a624, 0x00000000 }, /* ISRC3_CONTROL2 */
+	{ 0x0000a800, 0x00000000 }, /* FX_SAMPLE_RATE */
+	{ 0x0000a808, 0x00000000 }, /* EQ_CONTROL1 */
+	{ 0x0000a80c, 0x00000000 }, /* EQ_CONTROL2 */
+	{ 0x0000a810, 0x0c0c0c0c }, /* EQ1_GAIN1 */
+	{ 0x0000a814, 0x0000000c }, /* EQ1_GAIN2 */
+	{ 0x0000a818, 0x03fe0fc8 }, /* EQ1_BAND1_COEFF1 */
+	{ 0x0000a81c, 0x00000b75 }, /* EQ1_BAND1_COEFF2 */
+	{ 0x0000a820, 0x000000e0 }, /* EQ1_BAND1_PG */
+	{ 0x0000a824, 0xf1361ec4 }, /* EQ1_BAND2_COEFF1 */
+	{ 0x0000a828, 0x00000409 }, /* EQ1_BAND2_COEFF2 */
+	{ 0x0000a82c, 0x000004cc }, /* EQ1_BAND2_PG */
+	{ 0x0000a830, 0xf3371c9b }, /* EQ1_BAND3_COEFF1 */
+	{ 0x0000a834, 0x0000040b }, /* EQ1_BAND3_COEFF2 */
+	{ 0x0000a838, 0x00000cbb }, /* EQ1_BAND3_PG */
+	{ 0x0000a83c, 0xf7d916f8 }, /* EQ1_BAND4_COEFF1 */
+	{ 0x0000a840, 0x0000040a }, /* EQ1_BAND4_COEFF2 */
+	{ 0x0000a844, 0x00001f14 }, /* EQ1_BAND4_PG */
+	{ 0x0000a848, 0x0563058c }, /* EQ1_BAND5_COEFF1 */
+	{ 0x0000a84c, 0x00000000 }, /* EQ1_BAND5_COEFF1 + 4 */
+	{ 0x0000a850, 0x00004000 }, /* EQ1_BAND5_PG */
+	{ 0x0000a854, 0x0c0c0c0c }, /* EQ2_GAIN1 */
+	{ 0x0000a858, 0x0000000c }, /* EQ2_GAIN2 */
+	{ 0x0000a85c, 0x03fe0fc8 }, /* EQ2_BAND1_COEFF1 */
+	{ 0x0000a860, 0x00000b75 }, /* EQ2_BAND1_COEFF2 */
+	{ 0x0000a864, 0x000000e0 }, /* EQ2_BAND1_PG */
+	{ 0x0000a868, 0xf1361ec4 }, /* EQ2_BAND2_COEFF1 */
+	{ 0x0000a86c, 0x00000409 }, /* EQ2_BAND2_COEFF2 */
+	{ 0x0000a870, 0x000004cc }, /* EQ2_BAND2_PG */
+	{ 0x0000a874, 0xf3371c9b }, /* EQ2_BAND3_COEFF1 */
+	{ 0x0000a878, 0x0000040b }, /* EQ2_BAND3_COEFF2 */
+	{ 0x0000a87c, 0x00000cbb }, /* EQ2_BAND3_PG */
+	{ 0x0000a880, 0xf7d916f8 }, /* EQ2_BAND4_COEFF1 */
+	{ 0x0000a884, 0x0000040a }, /* EQ2_BAND4_COEFF2 */
+	{ 0x0000a888, 0x00001f14 }, /* EQ2_BAND4_PG */
+	{ 0x0000a88c, 0x0563058c }, /* EQ2_BAND5_COEFF1 */
+	{ 0x0000a890, 0x00000000 }, /* EQ2_BAND5_COEFF1 + 4 */
+	{ 0x0000a894, 0x00004000 }, /* EQ2_BAND5_PG */
+	{ 0x0000a898, 0x0c0c0c0c }, /* EQ3_GAIN1 */
+	{ 0x0000a89c, 0x0000000c }, /* EQ3_GAIN2 */
+	{ 0x0000a8a0, 0x03fe0fc8 }, /* EQ3_BAND1_COEFF1 */
+	{ 0x0000a8a4, 0x00000b75 }, /* EQ3_BAND1_COEFF2 */
+	{ 0x0000a8a8, 0x000000e0 }, /* EQ3_BAND1_PG */
+	{ 0x0000a8ac, 0xf1361ec4 }, /* EQ3_BAND2_COEFF1 */
+	{ 0x0000a8b0, 0x00000409 }, /* EQ3_BAND2_COEFF2 */
+	{ 0x0000a8b4, 0x000004cc }, /* EQ3_BAND2_PG */
+	{ 0x0000a8b8, 0xf3371c9b }, /* EQ3_BAND3_COEFF1 */
+	{ 0x0000a8bc, 0x0000040b }, /* EQ3_BAND3_COEFF2 */
+	{ 0x0000a8c0, 0x00000cbb }, /* EQ3_BAND3_PG */
+	{ 0x0000a8c4, 0xf7d916f8 }, /* EQ3_BAND4_COEFF1 */
+	{ 0x0000a8c8, 0x0000040a }, /* EQ3_BAND4_COEFF2 */
+	{ 0x0000a8cc, 0x00001f14 }, /* EQ3_BAND4_PG */
+	{ 0x0000a8d0, 0x0563058c }, /* EQ3_BAND5_COEFF1 */
+	{ 0x0000a8d4, 0x00000000 }, /* EQ3_BAND5_COEFF1 + 4 */
+	{ 0x0000a8d8, 0x00004000 }, /* EQ3_BAND5_PG */
+	{ 0x0000a8dc, 0x0c0c0c0c }, /* EQ4_GAIN1 */
+	{ 0x0000a8e0, 0x0000000c }, /* EQ4_GAIN2 */
+	{ 0x0000a8e4, 0x03fe0fc8 }, /* EQ4_BAND1_COEFF1 */
+	{ 0x0000a8e8, 0x00000b75 }, /* EQ4_BAND1_COEFF2 */
+	{ 0x0000a8ec, 0x000000e0 }, /* EQ4_BAND1_PG */
+	{ 0x0000a8f0, 0xf1361ec4 }, /* EQ4_BAND2_COEFF1 */
+	{ 0x0000a8f4, 0x00000409 }, /* EQ4_BAND2_COEFF2 */
+	{ 0x0000a8f8, 0x000004cc }, /* EQ4_BAND2_PG */
+	{ 0x0000a8fc, 0xf3371c9b }, /* EQ4_BAND3_COEFF1 */
+	{ 0x0000a900, 0x0000040b }, /* EQ4_BAND3_COEFF2 */
+	{ 0x0000a904, 0x00000cbb }, /* EQ4_BAND3_PG */
+	{ 0x0000a908, 0xf7d916f8 }, /* EQ4_BAND4_COEFF1 */
+	{ 0x0000a90c, 0x0000040a }, /* EQ4_BAND4_COEFF2 */
+	{ 0x0000a910, 0x00001f14 }, /* EQ4_BAND4_PG */
+	{ 0x0000a914, 0x0563058c }, /* EQ4_BAND5_COEFF1 */
+	{ 0x0000a918, 0x00000000 }, /* EQ4_BAND5_COEFF1 + 4 */
+	{ 0x0000a91c, 0x00004000 }, /* EQ4_BAND5_PG */
+	{ 0x0000aa30, 0x00000000 }, /* LHPF_CONTROL1 */
+	{ 0x0000aa34, 0x00000000 }, /* LHPF_CONTROL2 */
+	{ 0x0000aa38, 0x00000000 }, /* LHPF1_COEFF */
+	{ 0x0000aa3c, 0x00000000 }, /* LHPF2_COEFF */
+	{ 0x0000aa40, 0x00000000 }, /* LHPF3_COEFF */
+	{ 0x0000aa44, 0x00000000 }, /* LHPF4_COEFF */
+	{ 0x0000ab00, 0x00000000 }, /* DRC1_CONTROL1 */
+	{ 0x0000ab04, 0x49130018 }, /* DRC1_CONTROL2 */
+	{ 0x0000ab08, 0x00000018 }, /* DRC1_CONTROL3 */
+	{ 0x0000ab0c, 0x00000000 }, /* DRC1_CONTROL4 */
+	{ 0x0000ab14, 0x00000000 }, /* DRC2_CONTROL1 */
+	{ 0x0000ab18, 0x49130018 }, /* DRC2_CONTROL2 */
+	{ 0x0000ab1c, 0x00000018 }, /* DRC2_CONTROL3 */
+	{ 0x0000ab20, 0x00000000 }, /* DRC2_CONTROL4 */
+	{ 0x0000b000, 0x00000000 }, /* TONE_GENERATOR1 */
+	{ 0x0000b004, 0x00100000 }, /* TONE_GENERATOR2 */
+	{ 0x0000b400, 0x00000000 }, /* COMFORT_NOISE_GENERATOR */
+	{ 0x0000b800, 0x00000000 }, /* US_CONTROL */
+	{ 0x0000b804, 0x00002020 }, /* US1_CONTROL */
+	{ 0x0000b808, 0x00000000 }, /* US1_DET_CONTROL */
+	{ 0x0000b814, 0x00002020 }, /* US2_CONTROL */
+	{ 0x0000b818, 0x00000000 }, /* US2_DET_CONTROL */
+	{ 0x00018110, 0xffffffff }, /* IRQ1_MASK_1 */
+	{ 0x00018114, 0xfffffff7 }, /* IRQ1_MASK_2 */
+	{ 0x00018118, 0xffffffff }, /* IRQ1_MASK_3 */
+	{ 0x0001811c, 0xffffffff }, /* IRQ1_MASK_4 */
+	{ 0x00018120, 0xffffffff }, /* IRQ1_MASK_5 */
+	{ 0x00018124, 0xffffffff }, /* IRQ1_MASK_6 */
+	{ 0x00018128, 0xffffffff }, /* IRQ1_MASK_7 */
+	{ 0x0001812c, 0xffffffff }, /* IRQ1_MASK_8 */
+	{ 0x00018130, 0xffffffff }, /* IRQ1_MASK_9 */
+	{ 0x00018134, 0xffffffff }, /* IRQ1_MASK_10 */
+	{ 0x00018138, 0xffffffff }, /* IRQ1_MASK_11 */
+};
+
+static bool cs48l32_readable_register(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case CS48L32_DEVID:
+	case CS48L32_REVID:
+	case CS48L32_OTPID:
+	case CS48L32_SFT_RESET:
+	case CS48L32_CTRL_IF_DEBUG3:
+	case CS48L32_MCU_CTRL1:
+	case CS48L32_GPIO1_CTRL1 ... CS48L32_GPIO16_CTRL1:
+	case CS48L32_OUTPUT_SYS_CLK:
+	case CS48L32_AUXPDM_CTRL:
+	case CS48L32_AUXPDM_CTRL2:
+	case CS48L32_CLOCK32K:
+	case CS48L32_SYSTEM_CLOCK1 ... CS48L32_SYSTEM_CLOCK2:
+	case CS48L32_SAMPLE_RATE1 ... CS48L32_SAMPLE_RATE4:
+	case CS48L32_FLL1_CONTROL1 ... CS48L32_FLL1_GPIO_CLOCK:
+	case CS48L32_CHARGE_PUMP1:
+	case CS48L32_LDO2_CTRL1:
+	case CS48L32_MICBIAS_CTRL1:
+	case CS48L32_MICBIAS_CTRL5:
+	case CS48L32_IRQ1_CTRL_AOD:
+	case CS48L32_INPUT_CONTROL:
+	case CS48L32_INPUT_STATUS:
+	case CS48L32_INPUT_RATE_CONTROL:
+	case CS48L32_INPUT_CONTROL2:
+	case CS48L32_INPUT_CONTROL3:
+	case CS48L32_INPUT1_CONTROL1:
+	case CS48L32_IN1L_CONTROL1 ... CS48L32_IN1L_CONTROL2:
+	case CS48L32_IN1R_CONTROL1 ... CS48L32_IN1R_CONTROL2:
+	case CS48L32_INPUT2_CONTROL1:
+	case CS48L32_IN2L_CONTROL1 ... CS48L32_IN2L_CONTROL2:
+	case CS48L32_IN2R_CONTROL1 ... CS48L32_IN2R_CONTROL2:
+	case CS48L32_INPUT_HPF_CONTROL:
+	case CS48L32_INPUT_VOL_CONTROL:
+	case CS48L32_AUXPDM_CONTROL1:
+	case CS48L32_AUXPDM_CONTROL2:
+	case CS48L32_AUXPDM1_CONTROL1:
+	case CS48L32_AUXPDM2_CONTROL1:
+	case CS48L32_ADC1L_ANA_CONTROL1:
+	case CS48L32_ADC1R_ANA_CONTROL1:
+	case CS48L32_ASP1_ENABLES1 ... CS48L32_ASP1_DATA_CONTROL5:
+	case CS48L32_ASP2_ENABLES1 ... CS48L32_ASP2_DATA_CONTROL5:
+	case CS48L32_ASP1TX1_INPUT1 ... CS48L32_ASP1TX8_INPUT4:
+	case CS48L32_ASP2TX1_INPUT1 ... CS48L32_ASP2TX4_INPUT4:
+	case CS48L32_ISRC1INT1_INPUT1 ... CS48L32_ISRC1DEC4_INPUT1:
+	case CS48L32_ISRC2INT1_INPUT1 ... CS48L32_ISRC2DEC2_INPUT1:
+	case CS48L32_ISRC3INT1_INPUT1 ... CS48L32_ISRC3DEC2_INPUT1:
+	case CS48L32_EQ1_INPUT1 ... CS48L32_EQ4_INPUT4:
+	case CS48L32_DRC1L_INPUT1 ... CS48L32_DRC1R_INPUT4:
+	case CS48L32_DRC2L_INPUT1 ... CS48L32_DRC2R_INPUT4:
+	case CS48L32_LHPF1_INPUT1 ... CS48L32_LHPF1_INPUT4:
+	case CS48L32_LHPF2_INPUT1 ... CS48L32_LHPF2_INPUT4:
+	case CS48L32_LHPF3_INPUT1 ... CS48L32_LHPF3_INPUT4:
+	case CS48L32_LHPF4_INPUT1 ... CS48L32_LHPF4_INPUT4:
+	case CS48L32_DSP1RX1_INPUT1 ... CS48L32_DSP1RX8_INPUT4:
+	case CS48L32_ISRC1_CONTROL1 ... CS48L32_ISRC1_CONTROL2:
+	case CS48L32_ISRC2_CONTROL1 ... CS48L32_ISRC2_CONTROL2:
+	case CS48L32_ISRC3_CONTROL1 ... CS48L32_ISRC3_CONTROL2:
+	case CS48L32_FX_SAMPLE_RATE:
+	case CS48L32_EQ_CONTROL1 ... CS48L32_EQ_CONTROL2:
+	case CS48L32_EQ1_GAIN1 ... CS48L32_EQ1_BAND5_PG:
+	case CS48L32_EQ2_GAIN1 ... CS48L32_EQ2_BAND5_PG:
+	case CS48L32_EQ3_GAIN1 ... CS48L32_EQ3_BAND5_PG:
+	case CS48L32_EQ4_GAIN1 ... CS48L32_EQ4_BAND5_PG:
+	case CS48L32_LHPF_CONTROL1 ... CS48L32_LHPF_CONTROL2:
+	case CS48L32_LHPF1_COEFF ... CS48L32_LHPF4_COEFF:
+	case CS48L32_DRC1_CONTROL1 ... CS48L32_DRC1_CONTROL4:
+	case CS48L32_DRC2_CONTROL1 ... CS48L32_DRC2_CONTROL4:
+	case CS48L32_TONE_GENERATOR1 ... CS48L32_TONE_GENERATOR2:
+	case CS48L32_COMFORT_NOISE_GENERATOR:
+	case CS48L32_US_CONTROL:
+	case CS48L32_US1_CONTROL:
+	case CS48L32_US1_DET_CONTROL:
+	case CS48L32_US2_CONTROL:
+	case CS48L32_US2_DET_CONTROL:
+	case CS48L32_DSP1_XM_SRAM_IBUS_SETUP_0 ... CS48L32_DSP1_XM_SRAM_IBUS_SETUP_24:
+	case CS48L32_DSP1_YM_SRAM_IBUS_SETUP_0 ... CS48L32_DSP1_YM_SRAM_IBUS_SETUP_8:
+	case CS48L32_DSP1_PM_SRAM_IBUS_SETUP_0 ... CS48L32_DSP1_PM_SRAM_IBUS_SETUP_7:
+	case CS48L32_IRQ1_STATUS:
+	case CS48L32_IRQ1_EINT_1 ... CS48L32_IRQ1_EINT_11:
+	case CS48L32_IRQ1_STS_1 ... CS48L32_IRQ1_STS_11:
+	case CS48L32_IRQ1_MASK_1 ... CS48L32_IRQ1_MASK_11:
+	case CS48L32_DSP1_XMEM_PACKED_0 ... CS48L32_DSP1_XMEM_PACKED_147455:
+	case CS48L32_DSP1_SYS_INFO_ID ... CS48L32_DSP1_AHBM_WINDOW_DEBUG_1:
+	case CS48L32_DSP1_XMEM_UNPACKED24_0 ... CS48L32_DSP1_XMEM_UNPACKED24_196607:
+	case CS48L32_DSP1_CLOCK_FREQ ... CS48L32_DSP1_SAMPLE_RATE_TX8:
+	case CS48L32_DSP1_SCRATCH1 ... CS48L32_DSP1_SCRATCH4:
+	case CS48L32_DSP1_CCM_CORE_CONTROL ... CS48L32_DSP1_STREAM_ARB_RESYNC_MSK1:
+	case CS48L32_DSP1_YMEM_PACKED_0 ... CS48L32_DSP1_YMEM_PACKED_49151:
+	case CS48L32_DSP1_YMEM_UNPACKED24_0 ... CS48L32_DSP1_YMEM_UNPACKED24_65535:
+	case CS48L32_DSP1_PMEM_0 ... CS48L32_DSP1_PMEM_71679:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static bool cs48l32_volatile_register(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case CS48L32_DEVID:
+	case CS48L32_REVID:
+	case CS48L32_OTPID:
+	case CS48L32_SFT_RESET:
+	case CS48L32_CTRL_IF_DEBUG3:
+	case CS48L32_MCU_CTRL1:
+	case CS48L32_SYSTEM_CLOCK2:
+	case CS48L32_FLL1_CONTROL5:
+	case CS48L32_FLL1_CONTROL6:
+	case CS48L32_INPUT_STATUS:
+	case CS48L32_INPUT_CONTROL3:
+	case CS48L32_DSP1_XM_SRAM_IBUS_SETUP_0 ... CS48L32_DSP1_XM_SRAM_IBUS_SETUP_24:
+	case CS48L32_DSP1_YM_SRAM_IBUS_SETUP_0 ... CS48L32_DSP1_YM_SRAM_IBUS_SETUP_8:
+	case CS48L32_DSP1_PM_SRAM_IBUS_SETUP_0 ... CS48L32_DSP1_PM_SRAM_IBUS_SETUP_7:
+	case CS48L32_IRQ1_STATUS:
+	case CS48L32_IRQ1_EINT_1 ... CS48L32_IRQ1_EINT_11:
+	case CS48L32_IRQ1_STS_1 ... CS48L32_IRQ1_STS_11:
+	case CS48L32_DSP1_XMEM_PACKED_0 ... CS48L32_DSP1_XMEM_PACKED_147455:
+	case CS48L32_DSP1_SYS_INFO_ID ... CS48L32_DSP1_AHBM_WINDOW_DEBUG_1:
+	case CS48L32_DSP1_XMEM_UNPACKED24_0 ... CS48L32_DSP1_XMEM_UNPACKED24_196607:
+	case CS48L32_DSP1_CLOCK_FREQ ... CS48L32_DSP1_SAMPLE_RATE_TX8:
+	case CS48L32_DSP1_SCRATCH1 ... CS48L32_DSP1_SCRATCH4:
+	case CS48L32_DSP1_CCM_CORE_CONTROL ... CS48L32_DSP1_STREAM_ARB_RESYNC_MSK1:
+	case CS48L32_DSP1_YMEM_PACKED_0 ... CS48L32_DSP1_YMEM_PACKED_49151:
+	case CS48L32_DSP1_YMEM_UNPACKED24_0 ... CS48L32_DSP1_YMEM_UNPACKED24_65535:
+	case CS48L32_DSP1_PMEM_0 ... CS48L32_DSP1_PMEM_71679:
+		return true;
+	default:
+		return false;
+	}
+}
+
+/*
+ * The bus bridge requires DSP packed memory registers to be accessed in
+ * aligned block multiples.
+ * Mark precious to prevent regmap debugfs causing an illegal bus transaction.
+ */
+static bool cs48l32_precious_register(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case CS48L32_DSP1_XMEM_PACKED_0 ... CS48L32_DSP1_XMEM_PACKED_147455:
+	case CS48L32_DSP1_YMEM_PACKED_0 ... CS48L32_DSP1_YMEM_PACKED_49151:
+	case CS48L32_DSP1_PMEM_0 ... CS48L32_DSP1_PMEM_71679:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static const struct regmap_config cs48l32_spi_regmap = {
+	.name = "cs48l32",
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.pad_bits = 32,
+	.val_bits = 32,
+	.reg_format_endian = REGMAP_ENDIAN_BIG,
+	.val_format_endian = REGMAP_ENDIAN_BIG,
+
+	.max_register = CS48L32_DSP1_PMEM_71679,
+	.readable_reg = &cs48l32_readable_register,
+	.volatile_reg = &cs48l32_volatile_register,
+	.precious_reg = &cs48l32_precious_register,
+
+	.cache_type = REGCACHE_RBTREE,
+	.reg_defaults = cs48l32_reg_default,
+	.num_reg_defaults = ARRAY_SIZE(cs48l32_reg_default),
+};
+
+int cs48l32_init_regmap(struct spi_device *spi, struct cs48l32_mfd *cs48l32)
+{
+	cs48l32->regmap = devm_regmap_init_spi(spi, &cs48l32_spi_regmap);
+	if (IS_ERR(cs48l32->regmap))
+		return PTR_ERR(cs48l32->regmap);
+
+	return 0;
+}
diff --git a/drivers/mfd/cs48l32.c b/drivers/mfd/cs48l32.c
new file mode 100644
index 000000000000..9506a1e0560b
--- /dev/null
+++ b/drivers/mfd/cs48l32.c
@@ -0,0 +1,434 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * MFD for Cirrus Logic CS48L32 audio codec.
+ *
+ * Copyright (C) 2016-2018, 2020, 2022 Cirrus Logic, Inc. and
+ *               Cirrus Logic International Semiconductor Ltd.
+ */
+
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/gpio/consumer.h>
+#include <linux/mfd/core.h>
+#include <linux/mfd/cs48l32/core.h>
+#include <linux/mfd/cs48l32/registers.h>
+#include <linux/module.h>
+#include <linux/notifier.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/pinctrl/consumer.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/property.h>
+#include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
+#include <linux/regulator/driver.h>
+#include <linux/regulator/machine.h>
+#include <linux/regulator/of_regulator.h>
+#include <linux/spi/spi.h>
+
+#include "cs48l32.h"
+
+static const char * const cs48l32_core_supplies[] = {
+	"VDD_A",
+	"VDD_IO",
+};
+
+static const char * const cs48l32_supplies[] = {
+	"VOUT_MIC",
+	"VDD_CP",
+};
+
+static const struct mfd_cell cs48l32_devs[] = {
+	{ .name = "cs48l32-pinctrl", },
+	{ .name = "cs48l32-irq", },
+	{ .name = "cs48l32-micsupp", },
+	{
+		.name = "cs48l32-codec",
+		.parent_supplies = cs48l32_supplies,
+		.num_parent_supplies = ARRAY_SIZE(cs48l32_supplies),
+	},
+};
+
+static int cs48l32_wait_for_boot(struct cs48l32_mfd *cs48l32)
+{
+	unsigned int val;
+	int i, ret;
+
+	/* regmap_read_poll_timeout would fail on read errors so roll our own */
+	for (i = 0; i < CS48L32_BOOT_TIMEOUT_MS; ++i) {
+		val = 0;
+		regmap_read(cs48l32->regmap, CS48L32_IRQ1_EINT_2, &val);
+		if (val & CS48L32_BOOT_DONE_EINT1_MASK)
+			break;
+
+		usleep_range(1000, 2000);
+	}
+	if (i == CS48L32_BOOT_TIMEOUT_MS) {
+		dev_err(cs48l32->dev, "BOOT_DONE timed out\n");
+		return -ETIMEDOUT;
+	}
+
+	ret = regmap_read(cs48l32->regmap, CS48L32_MCU_CTRL1, &val);
+	if (ret) {
+		dev_err(cs48l32->dev, "Failed to read MCU_CTRL1: %d\n", ret);
+		return ret;
+	}
+
+	if (val & BIT(CS48L32_MCU_STS_SHIFT)) {
+		dev_err(cs48l32->dev, "MCU boot failed\n");
+		return -EIO;
+	}
+
+	ret = regmap_set_bits(cs48l32->regmap, CS48L32_CTRL_IF_DEBUG3, CS48L32_SEEN_BOOT_DONE);
+	if (ret) {
+		dev_err(cs48l32->dev, "Failed to write CTRL_IF_DEBUG3: %d\n", ret);
+		return ret;
+	}
+
+	pm_runtime_mark_last_busy(cs48l32->dev);
+
+	return 0;
+}
+
+static int cs48l32_soft_reset(struct cs48l32_mfd *cs48l32)
+{
+	int ret;
+
+	ret = regmap_write(cs48l32->regmap, CS48L32_SFT_RESET, CS48L32_SFT_RESET_MAGIC);
+	if (ret != 0) {
+		dev_err(cs48l32->dev, "Failed to write soft reset: %d\n", ret);
+		return ret;
+	}
+
+	usleep_range(2000, 3000);
+
+	return 0;
+}
+
+static void cs48l32_enable_hard_reset(struct cs48l32_mfd *cs48l32)
+{
+	if (cs48l32->reset_gpio)
+		gpiod_set_value_cansleep(cs48l32->reset_gpio, 0);
+}
+
+static void cs48l32_disable_hard_reset(struct cs48l32_mfd *cs48l32)
+{
+	if (cs48l32->reset_gpio) {
+		gpiod_set_value_cansleep(cs48l32->reset_gpio, 1);
+		usleep_range(2000, 3000);
+	}
+}
+
+static int __maybe_unused cs48l32_runtime_resume(struct device *dev)
+{
+	struct cs48l32_mfd *cs48l32 = dev_get_drvdata(dev);
+	unsigned int val;
+	int ret;
+
+	dev_dbg(cs48l32->dev, "Leaving sleep mode\n");
+
+	ret = regulator_enable(cs48l32->vdd_d);
+	if (ret) {
+		dev_err(cs48l32->dev, "Failed to enable VDD_D: %d\n", ret);
+		return ret;
+	}
+
+	usleep_range(2000, 3000);
+
+	regcache_cache_only(cs48l32->regmap, false);
+
+	/* Did it power down during suspend? */
+	ret = regmap_read(cs48l32->regmap, CS48L32_CTRL_IF_DEBUG3, &val);
+	if ((ret == 0) && (val & CS48L32_SEEN_BOOT_DONE)) {
+		dev_dbg(cs48l32->dev, "VDD_D didn't power off during suspend\n");
+	} else {
+		ret = cs48l32_wait_for_boot(cs48l32);
+		if (ret)
+			goto err;
+
+		/* Flag that the registers have reset to defaults */
+		regcache_mark_dirty(cs48l32->regmap);
+	}
+
+	ret = regcache_sync(cs48l32->regmap);
+	if (ret) {
+		dev_err(cs48l32->dev, "Failed to restore register cache\n");
+		goto err;
+	}
+
+	return 0;
+
+err:
+	regcache_cache_only(cs48l32->regmap, true);
+	regulator_disable(cs48l32->vdd_d);
+	return ret;
+}
+
+static int __maybe_unused cs48l32_runtime_suspend(struct device *dev)
+{
+	struct cs48l32_mfd *cs48l32 = dev_get_drvdata(dev);
+
+	dev_dbg(cs48l32->dev, "Entering sleep mode\n");
+
+	regcache_cache_only(cs48l32->regmap, true);
+	regulator_disable(cs48l32->vdd_d);
+
+	return 0;
+}
+
+static const struct dev_pm_ops cs48l32_pm_ops = {
+	SET_RUNTIME_PM_OPS(cs48l32_runtime_suspend, cs48l32_runtime_resume, NULL)
+};
+
+static const struct __maybe_unused of_device_id cs48l32_of_match[] = {
+	{ .compatible = "cirrus,cs48l31", },
+	{ .compatible = "cirrus,cs48l32", },
+	{ .compatible = "cirrus,cs48l33", },
+	{},
+};
+
+static int cs48l32_configure_clk32k(struct cs48l32_mfd *cs48l32)
+{
+	int ret = 0;
+
+	ret = clk_prepare_enable(cs48l32->mclk1);
+	if (ret) {
+		dev_err(cs48l32->dev, "Failed to enable 32k clock: %d\n", ret);
+		return ret;
+	}
+
+	ret = regmap_update_bits(cs48l32->regmap, CS48L32_CLOCK32K,
+				 CS48L32_CLK_32K_EN_MASK | CS48L32_CLK_32K_SRC_MASK,
+				 CS48L32_CLK_32K_EN_MASK | CS48L32_32K_MCLK1);
+	if (ret) {
+		dev_err(cs48l32->dev, "Failed to init 32k clock: %d\n", ret);
+		clk_disable_unprepare(cs48l32->mclk1);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int cs48l32_get_clocks(struct cs48l32_mfd *cs48l32)
+{
+	cs48l32->mclk1 = devm_clk_get_optional(cs48l32->dev, "mclk1");
+	if (IS_ERR(cs48l32->mclk1))
+		return dev_err_probe(cs48l32->dev, PTR_ERR(cs48l32->mclk1),
+				     "Failed to get mclk1\n");
+
+	return 0;
+}
+
+static int cs48l32_get_reset_gpio(struct cs48l32_mfd *cs48l32)
+{
+	struct gpio_desc *reset;
+
+	reset = devm_gpiod_get_optional(cs48l32->dev, "reset", GPIOD_OUT_LOW);
+	if (IS_ERR(reset))
+		return dev_err_probe(cs48l32->dev, PTR_ERR(reset), "Failed to request /RESET\n");
+
+	/*
+	 * A hard reset is needed for full reset of the chip. We allow running
+	 * without hard reset only because it can be useful for early
+	 * prototyping and some debugging, but we need to warn it's not ideal.
+	 */
+	if (!reset)
+		dev_warn(cs48l32->dev, "Running without reset GPIO is not recommended\n");
+
+	cs48l32->reset_gpio = reset;
+
+	return 0;
+}
+
+static int cs48l32_spi_probe(struct spi_device *spi)
+{
+	struct device *dev = &spi->dev;
+	struct cs48l32_mfd *cs48l32;
+	unsigned int hwid, rev, otp_rev;
+	int i, ret;
+
+	cs48l32 = devm_kzalloc(&spi->dev, sizeof(*cs48l32), GFP_KERNEL);
+	if (!cs48l32)
+		return -ENOMEM;
+
+	ret = cs48l32_init_regmap(spi, cs48l32);
+	if (ret)
+		return dev_err_probe(&spi->dev, ret, "Failed to allocate regmap\n");
+
+	cs48l32->dev = dev;
+	cs48l32->irq = spi->irq;
+
+	dev_set_drvdata(cs48l32->dev, cs48l32);
+
+	BLOCKING_INIT_NOTIFIER_HEAD(&cs48l32->notifier);
+
+	regcache_cache_only(cs48l32->regmap, true);
+
+	ret = cs48l32_get_reset_gpio(cs48l32);
+	if (ret)
+		return ret;
+
+	ret = cs48l32_get_clocks(cs48l32);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < ARRAY_SIZE(cs48l32_core_supplies); i++)
+		cs48l32->core_supplies[i].supply = cs48l32_core_supplies[i];
+
+	cs48l32->num_core_supplies = ARRAY_SIZE(cs48l32_core_supplies);
+
+	ret = devm_regulator_bulk_get(dev, cs48l32->num_core_supplies, cs48l32->core_supplies);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to request core supplies\n");
+
+	cs48l32->vdd_d = devm_regulator_get(cs48l32->dev, "VDD_D");
+	if (IS_ERR(cs48l32->vdd_d))
+		return dev_err_probe(dev, PTR_ERR(cs48l32->vdd_d), "Failed to request VDD_D\n");
+
+	ret = regulator_set_voltage(cs48l32->vdd_d, 1200000, 1200000);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to request VDD_D=1.2v\n");
+
+	ret = regulator_bulk_enable(cs48l32->num_core_supplies, cs48l32->core_supplies);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to enable core supplies\n");
+
+	ret = regulator_enable(cs48l32->vdd_d);
+	if (ret) {
+		dev_err(dev, "Failed to enable VDD_D: %d\n", ret);
+		goto err_enable;
+	}
+
+	cs48l32_disable_hard_reset(cs48l32);
+
+	regcache_cache_only(cs48l32->regmap, false);
+
+	/* If we don't have a reset GPIO use a soft reset */
+	if (!cs48l32->reset_gpio) {
+		ret = cs48l32_soft_reset(cs48l32);
+		if (ret)
+			goto err_reset;
+	}
+
+	ret = cs48l32_wait_for_boot(cs48l32);
+	if (ret) {
+		dev_err(cs48l32->dev, "Device failed initial boot: %d\n", ret);
+		goto err_reset;
+	}
+
+	ret = regmap_read(cs48l32->regmap, CS48L32_DEVID, &hwid);
+	if (ret) {
+		dev_err(dev, "Failed to read ID register: %d\n", ret);
+		goto err_reset;
+	}
+	hwid &= CS48L32_DEVID_MASK;
+
+	switch (hwid) {
+	case CS48L31_SILICON_ID:
+	case CS48L32_SILICON_ID:
+	case CS48L33_SILICON_ID:
+		break;
+	default:
+		dev_err(cs48l32->dev, "Unknown device ID: %x\n", hwid);
+		ret = -EINVAL;
+		goto err_reset;
+	}
+
+	ret = regmap_read(cs48l32->regmap, CS48L32_REVID, &rev);
+	if (ret) {
+		dev_err(dev, "Failed to read revision register: %d\n", ret);
+		goto err_reset;
+	}
+	rev &= CS48L32_AREVID_MASK | CS48L32_MTLREVID_MASK;
+
+	ret = regmap_read(cs48l32->regmap, CS48L32_OTPID, &otp_rev);
+	if (ret) {
+		dev_err(dev, "Failed to read OTP revision register: %d\n", ret);
+		goto err_reset;
+	}
+	otp_rev &= CS48L32_OTPID_MASK;
+
+	cs48l32->part = hwid & 0xff;
+
+	dev_info(dev, "CS48L%x revision %X%u.%u\n", cs48l32->part,
+		 rev >> CS48L32_AREVID_SHIFT, rev & CS48L32_MTLREVID_MASK, otp_rev);
+
+	/* Apply hardware patch */
+	ret = cs48l32_patch(cs48l32);
+	if (ret) {
+		dev_err(cs48l32->dev, "Failed to apply patch %d\n", ret);
+		goto err_reset;
+	}
+
+	ret = cs48l32_configure_clk32k(cs48l32);
+	if (ret)
+		goto err_reset;
+
+	pm_runtime_set_active(cs48l32->dev);
+	pm_runtime_enable(cs48l32->dev);
+	pm_runtime_set_autosuspend_delay(cs48l32->dev, 100);
+	pm_runtime_use_autosuspend(cs48l32->dev);
+
+	ret = mfd_add_devices(cs48l32->dev, PLATFORM_DEVID_NONE,
+			      cs48l32_devs, ARRAY_SIZE(cs48l32_devs), NULL, 0, NULL);
+	if (ret) {
+		dev_err(cs48l32->dev, "Failed to add subdevices: %d\n", ret);
+		goto err_clk32k;
+	}
+
+	return 0;
+
+err_clk32k:
+	clk_disable_unprepare(cs48l32->mclk1);
+err_reset:
+	cs48l32_enable_hard_reset(cs48l32);
+	regulator_disable(cs48l32->vdd_d);
+err_enable:
+	regulator_bulk_disable(cs48l32->num_core_supplies, cs48l32->core_supplies);
+
+	return ret;
+}
+
+static void cs48l32_spi_remove(struct spi_device *spi)
+{
+	struct cs48l32_mfd *cs48l32 = spi_get_drvdata(spi);
+
+	/* Prevent any IRQs being serviced while we clean up */
+	disable_irq(cs48l32->irq);
+
+	mfd_remove_devices(cs48l32->dev);
+
+	pm_runtime_disable(cs48l32->dev);
+	regulator_disable(cs48l32->vdd_d);
+	clk_disable_unprepare(cs48l32->mclk1);
+	cs48l32_enable_hard_reset(cs48l32);
+	regulator_bulk_disable(cs48l32->num_core_supplies, cs48l32->core_supplies);
+}
+
+static const struct spi_device_id cs48l32_spi_ids[] = {
+	{ "cs48l31", },
+	{ "cs48l32", },
+	{ "cs48l33", },
+	{ },
+};
+MODULE_DEVICE_TABLE(spi, cs48l32_spi_ids);
+
+static struct spi_driver cs48l32_spi_driver = {
+	.driver = {
+		.name	= "cs48l32",
+		.owner	= THIS_MODULE,
+		.pm	= &cs48l32_pm_ops,
+		.of_match_table	= of_match_ptr(cs48l32_of_match),
+	},
+	.probe		= &cs48l32_spi_probe,
+	.remove		= &cs48l32_spi_remove,
+	.id_table	= cs48l32_spi_ids,
+};
+
+module_spi_driver(cs48l32_spi_driver);
+
+MODULE_SOFTDEP("pre: pinctrl-cs48l32 irq-cirrus-cs48l32");
+MODULE_DESCRIPTION("CS48L32 MFD driver");
+MODULE_AUTHOR("Richard Fitzgerald <rf@opensource.cirrus.com>");
+MODULE_LICENSE("GPL");
diff --git a/drivers/mfd/cs48l32.h b/drivers/mfd/cs48l32.h
new file mode 100644
index 000000000000..36020c0cd686
--- /dev/null
+++ b/drivers/mfd/cs48l32.h
@@ -0,0 +1,28 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * MFD for Cirrus Logic CS48L32 audio codec.
+ *
+ * Copyright (C) 2016-2018, 2020, 2022 Cirrus Logic, Inc. and
+ *               Cirrus Logic International Semiconductor Ltd.
+ */
+
+#ifndef CS48L32_MFD_H
+#define CS48L32_MFD_H
+
+#include <linux/bits.h>
+
+#define CS48L31_SILICON_ID	0x48a31
+#define CS48L32_SILICON_ID	0x48a32
+#define CS48L33_SILICON_ID	0x48a33
+
+#define CS48L32_32K_MCLK1	0
+
+#define CS48L32_SFT_RESET_MAGIC	0x5a000000
+#define CS48L32_SEEN_BOOT_DONE	BIT(0)
+
+#define CS48L32_BOOT_TIMEOUT_MS	25
+
+int cs48l32_init_regmap(struct spi_device *spi, struct cs48l32_mfd *cs48l32);
+int cs48l32_patch(struct cs48l32_mfd *cs48l32);
+
+#endif
diff --git a/include/linux/mfd/cs48l32/core.h b/include/linux/mfd/cs48l32/core.h
new file mode 100644
index 000000000000..1c4269d70c8c
--- /dev/null
+++ b/include/linux/mfd/cs48l32/core.h
@@ -0,0 +1,49 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * MFD for Cirrus Logic CS48L32 audio codec.
+ *
+ * Copyright (C) 2016-2020, 2022 Cirrus Logic, Inc. and
+ *               Cirrus Logic International Semiconductor Ltd.
+ */
+
+#ifndef CS48L32_CORE_H
+#define CS48L32_CORE_H
+
+#include <linux/clk.h>
+#include <linux/gpio/consumer.h>
+#include <linux/interrupt.h>
+#include <linux/notifier.h>
+#include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
+
+#define CS48L32_MAX_CORE_SUPPLIES	2
+
+struct snd_soc_dapm_context;
+
+struct cs48l32_mfd {
+	struct regmap *regmap;
+	struct device *dev;
+	struct gpio_desc *reset_gpio;
+	struct clk *mclk1;
+	struct snd_soc_dapm_context *dapm;
+
+	int num_core_supplies;
+	struct regulator_bulk_data core_supplies[CS48L32_MAX_CORE_SUPPLIES];
+	struct regulator *vdd_d;
+
+	struct device *irq_dev;
+	struct regmap_irq_chip_data *irq_data;
+	int irq;
+
+	u8 part;
+
+	struct blocking_notifier_head notifier;
+};
+
+static inline int cs48l32_call_notifiers(struct cs48l32_mfd *mfd,
+					 unsigned long event,
+					 void *data)
+{
+	return blocking_notifier_call_chain(&mfd->notifier, event, data);
+}
+#endif
-- 
2.30.2

