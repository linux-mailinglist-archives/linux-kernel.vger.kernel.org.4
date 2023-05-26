Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A59C711AFE
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 02:05:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241995AbjEZAFJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 20:05:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241879AbjEZAEv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 20:04:51 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD1BF9C;
        Thu, 25 May 2023 17:04:46 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34PIqFOY026779;
        Thu, 25 May 2023 19:04:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=PODMain02222019;
 bh=jD9qWk0Kv3wwEJcLo11fHHHLR/b2atTvZtjA2dyDzto=;
 b=mqEpKchMOfQFmGtpOI2mIqJO9TnoRLLxn8AxFiegZ8nrwR0W0Gv+BLP8th7uMTeSFuYD
 XM3grFch9pv2Gccyn6TSTll9ZbK+4ZB9l4A1YstY2YFKdExT7AeruJBGBfUcFUewATaB
 byfth7Nf2GInjV/lKmSb6BtAIUCil4Dk4+kEGPmramDM1t9n2aQ5dtNO7VcSe+OW+vny
 xEsC80n79VQH0ezTCpIm+vjCZOKjtJ0NBp1gNxOEoqn4NnmGCRvAKxrX2ZwCEqaxEx4X
 zGVuo/FbVAAQrY83A7s2pmnXHqNdJ0hYEaPkDBLUo5KRlMGMqCyttmisIr05p2Iu23BF Fg== 
Received: from ausex02.ad.cirrus.com ([141.131.3.21])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3qsde8jhx4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 May 2023 19:04:37 -0500
Received: from ausex02.ad.cirrus.com (141.131.37.96) by ausex02.ad.cirrus.com
 (141.131.37.96) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.26; Thu, 25 May
 2023 19:04:36 -0500
Received: from ftrev.crystal.cirrus.com (141.131.38.212) by
 anon-ausex02.ad.cirrus.com (141.131.37.96) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 25 May 2023 19:04:36 -0500
From:   Fred Treven <fred.treven@cirrus.com>
To:     Fred Treven <fred.treven@cirrus.com>,
        Ben Bright <ben.bright@cirrus.com>,
        James Ogletree <james.ogletree@cirrus.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Simon Trimmer <simont@opensource.cirrus.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        <patches@opensource.cirrus.com>, <linux-input@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <lee@kernel.org>
Subject: [PATCH v2 2/5] Input: cs40l26 - Support for CS40L26 Haptic Device
Date:   Thu, 25 May 2023 19:04:28 -0500
Message-ID: <1685059471-9598-2-git-send-email-fred.treven@cirrus.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1685059471-9598-1-git-send-email-fred.treven@cirrus.com>
References: <1685059471-9598-1-git-send-email-fred.treven@cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: Km_lnUM2Z36dgvqeivw1gZKUFXLOY7F6
X-Proofpoint-GUID: Km_lnUM2Z36dgvqeivw1gZKUFXLOY7F6
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce support for Cirrus Logic device CS40L26:
a boosted haptics driver with integrated DSP and
waveform memory with advanced closed loop algorithms
and LRA protection.

Signed-off-by: Fred Treven <fred.treven@cirrus.com>
---
 MAINTAINERS                      |    2 +
 drivers/input/misc/Kconfig       |   30 +
 drivers/input/misc/Makefile      |    3 +
 drivers/input/misc/cs40l26-i2c.c |   76 ++
 drivers/input/misc/cs40l26-spi.c |   77 ++
 drivers/input/misc/cs40l26.c     | 2385 ++++++++++++++++++++++++++++++++++++++
 include/linux/input/cs40l26.h    |  486 ++++++++
 7 files changed, 3059 insertions(+)
 create mode 100644 drivers/input/misc/cs40l26-i2c.c
 create mode 100644 drivers/input/misc/cs40l26-spi.c
 create mode 100644 drivers/input/misc/cs40l26.c
 create mode 100644 include/linux/input/cs40l26.h

diff --git a/MAINTAINERS b/MAINTAINERS
index d72ed4957b0b..d4e51e6634c9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4935,6 +4935,8 @@ S:	Supported
 W:	https://github.com/CirrusLogic/linux-drivers/wiki
 T:	git https://github.com/CirrusLogic/linux-drivers.git
 F:	Documentation/devicetree/bindings/input/cirrus,cs40l26.yaml
+F:	drivers/input/misc/cs40l*
+F:	include/linux/input/cs40l*
 
 CIRRUS LOGIC LOCHNAGAR DRIVER
 M:	Charles Keepax <ckeepax@opensource.cirrus.com>
diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
index 81a54a59e13c..88e585897ad7 100644
--- a/drivers/input/misc/Kconfig
+++ b/drivers/input/misc/Kconfig
@@ -140,6 +140,36 @@ config INPUT_BMA150
 	  To compile this driver as a module, choose M here: the
 	  module will be called bma150.
 
+config INPUT_CS40L26
+	tristate "Cirrus Logic CS40L26 Haptic Amplifier support"
+	select CS_DSP
+	help
+	  Say Y here to enable support for CS40L26 boosted haptic
+	  amplifier.
+
+	  To compile the driver as a module choose M here: the module
+	  will be called cs40l26_core.
+
+config INPUT_CS40L26_I2C
+	tristate "Support I2C bus connection"
+	depends on INPUT_CS40L26 && I2C
+	select REGMAP_I2C
+	help
+	  Say Y if you have CS40L26 connected to an I2C bus.
+
+	  To compile the driver as a module choose M here: the
+	  module will be called cs40l26_i2c.
+
+config INPUT_CS40L26_SPI
+	tristate "Support SPI bus connection"
+	depends on INPUT_CS40L26 && SPI
+	select REGMAP_SPI
+	help
+	  Say Y if you have CS40L26 connected to a SPI bus.
+
+	  To compile the driver as a module choose M here: the
+	  module will be called cs40l26_spi.
+
 config INPUT_E3X0_BUTTON
 	tristate "NI Ettus Research USRP E3xx Button support."
 	default n
diff --git a/drivers/input/misc/Makefile b/drivers/input/misc/Makefile
index 04296a4abe8e..97d2245fdd6a 100644
--- a/drivers/input/misc/Makefile
+++ b/drivers/input/misc/Makefile
@@ -28,6 +28,9 @@ obj-$(CONFIG_INPUT_CMA3000)		+= cma3000_d0x.o
 obj-$(CONFIG_INPUT_CMA3000_I2C)		+= cma3000_d0x_i2c.o
 obj-$(CONFIG_INPUT_COBALT_BTNS)		+= cobalt_btns.o
 obj-$(CONFIG_INPUT_CPCAP_PWRBUTTON)	+= cpcap-pwrbutton.o
+obj-$(CONFIG_INPUT_CS40L26)		+= cs40l26.o
+obj-$(CONFIG_INPUT_CS40L26_I2C)		+= cs40l26-i2c.o
+obj-$(CONFIG_INPUT_CS40L26_SPI)		+= cs40l26-spi.o
 obj-$(CONFIG_INPUT_DA7280_HAPTICS)	+= da7280.o
 obj-$(CONFIG_INPUT_DA9052_ONKEY)	+= da9052_onkey.o
 obj-$(CONFIG_INPUT_DA9055_ONKEY)	+= da9055_onkey.o
diff --git a/drivers/input/misc/cs40l26-i2c.c b/drivers/input/misc/cs40l26-i2c.c
new file mode 100644
index 000000000000..7be2d7731895
--- /dev/null
+++ b/drivers/input/misc/cs40l26-i2c.c
@@ -0,0 +1,76 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * CS40L26 Boosted Haptic Driver with Integrated DSP and
+ * Waveform Memory with Advanced Closed Loop Algorithms and LRA protection
+ *
+ * Copyright 2023 Cirrus Logic, Inc.
+ *
+ * Author: Fred Treven <fred.treven@cirrus.com>
+ */
+
+#include <linux/i2c.h>
+#include <linux/input/cs40l26.h>
+
+static const struct i2c_device_id cs40l26_id_i2c[] = {
+	{ "cs40l26a", 0 },
+	{ "cs40l26b", 1 },
+	{ "cs40l27a", 2 },
+	{ "cs40l27b", 3 },
+	{}
+};
+MODULE_DEVICE_TABLE(i2c, cs40l26_id_i2c);
+
+static const struct of_device_id cs40l26_of_match[CS40L26_NUM_DEVS + 1] = {
+	{ .compatible = "cirrus,cs40l26a" },
+	{ .compatible = "cirrus,cs40l26b" },
+	{ .compatible = "cirrus,cs40l27a" },
+	{ .compatible = "cirrus,cs40l27b" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, cs40l26_of_match);
+
+static int cs40l26_i2c_probe_new(struct i2c_client *client)
+{
+	struct device *dev = &client->dev;
+	struct cs40l26_private *cs40l26;
+
+	cs40l26 = devm_kzalloc(dev, sizeof(struct cs40l26_private), GFP_KERNEL);
+	if (!cs40l26)
+		return -ENOMEM;
+
+	i2c_set_clientdata(client, cs40l26);
+
+	cs40l26->regmap = devm_regmap_init_i2c(client, &cs40l26_regmap);
+	if (IS_ERR(cs40l26->regmap))
+		return dev_err_probe(dev, PTR_ERR(cs40l26->regmap),
+					"Failed to allocate register map\n");
+
+	cs40l26->dev = dev;
+	cs40l26->irq = client->irq;
+
+	return cs40l26_probe(cs40l26);
+}
+
+static void cs40l26_i2c_remove(struct i2c_client *client)
+{
+	struct cs40l26_private *cs40l26 = i2c_get_clientdata(client);
+
+	cs40l26_remove(cs40l26);
+}
+
+static struct i2c_driver cs40l26_i2c_driver = {
+	.driver = {
+		.name = "cs40l26",
+		.of_match_table = cs40l26_of_match,
+		.pm = pm_sleep_ptr(&cs40l26_pm_ops),
+	},
+	.id_table = cs40l26_id_i2c,
+	.probe_new = cs40l26_i2c_probe_new,
+	.remove = cs40l26_i2c_remove,
+};
+
+module_i2c_driver(cs40l26_i2c_driver);
+
+MODULE_DESCRIPTION("CS40L26 I2C Driver");
+MODULE_AUTHOR("Fred Treven, Cirrus Logic Inc. <fred.treven@cirrus.com>");
+MODULE_LICENSE("GPL");
diff --git a/drivers/input/misc/cs40l26-spi.c b/drivers/input/misc/cs40l26-spi.c
new file mode 100644
index 000000000000..c43f4b3a5ea2
--- /dev/null
+++ b/drivers/input/misc/cs40l26-spi.c
@@ -0,0 +1,77 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * CS40L26 Boosted Haptic Driver with Integrated DSP and
+ * Waveform Memory with Advanced Closed Loop Algorithms and LRA protection
+ *
+ * Copyright 2023 Cirrus Logic, Inc.
+ *
+ * Author: Fred Treven <fred.treven@cirrus.com>
+ */
+
+#include <linux/spi/spi.h>
+#include <linux/input/cs40l26.h>
+
+static const struct spi_device_id cs40l26_id_spi[] = {
+	{ "cs40l26a", 0 },
+	{ "cs40l26b", 1 },
+	{ "cs40l27a", 2 },
+	{ "cs40l27b", 3 },
+	{}
+};
+MODULE_DEVICE_TABLE(spi, cs40l26_id_spi);
+
+static const struct of_device_id cs40l26_of_match[CS40L26_NUM_DEVS + 1] = {
+	{ .compatible = "cirrus,cs40l26a" },
+	{ .compatible = "cirrus,cs40l26b" },
+	{ .compatible = "cirrus,cs40l27a" },
+	{ .compatible = "cirrus,cs40l27b" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, cs40l26_of_match);
+
+static int cs40l26_spi_probe(struct spi_device *spi)
+{
+	struct device *dev = &spi->dev;
+	struct cs40l26_private *cs40l26;
+
+	cs40l26 = devm_kzalloc(dev, sizeof(struct cs40l26_private), GFP_KERNEL);
+	if (!cs40l26)
+		return -ENOMEM;
+
+	spi_set_drvdata(spi, cs40l26);
+
+	cs40l26->regmap = devm_regmap_init_spi(spi, &cs40l26_regmap);
+	if (IS_ERR(cs40l26->regmap))
+		return dev_err_probe(dev, PTR_ERR(cs40l26->regmap),
+					"Failed to allocate register map\n");
+
+	cs40l26->dev = dev;
+	cs40l26->irq = spi->irq;
+
+	return cs40l26_probe(cs40l26);
+}
+
+static void cs40l26_spi_remove(struct spi_device *spi)
+{
+	struct cs40l26_private *cs40l26 = spi_get_drvdata(spi);
+
+	cs40l26_remove(cs40l26);
+}
+
+static struct spi_driver cs40l26_spi_driver = {
+	.driver = {
+		.name = "cs40l26",
+		.of_match_table = cs40l26_of_match,
+		.pm = pm_sleep_ptr(&cs40l26_pm_ops),
+	},
+
+	.id_table = cs40l26_id_spi,
+	.probe = cs40l26_spi_probe,
+	.remove = cs40l26_spi_remove,
+};
+
+module_spi_driver(cs40l26_spi_driver);
+
+MODULE_DESCRIPTION("CS40L26 SPI Driver");
+MODULE_AUTHOR("Fred Treven, Cirrus Logic Inc. <fred.treven@cirrus.com>");
+MODULE_LICENSE("GPL");
diff --git a/drivers/input/misc/cs40l26.c b/drivers/input/misc/cs40l26.c
new file mode 100644
index 000000000000..1959438dfe31
--- /dev/null
+++ b/drivers/input/misc/cs40l26.c
@@ -0,0 +1,2385 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * CS40L26 Boosted Haptic Driver with Integrated DSP and
+ * Waveform Memory with Advanced Closed Loop Algorithms and LRA protection
+ *
+ * Copyright 2023 Cirrus Logic, Inc.
+ *
+ * Author: Fred Treven <fred.treven@cirrus.com>
+ */
+
+#include <linux/firmware.h>
+#include <linux/gpio.h>
+#include <linux/i2c.h>
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <linux/pm_runtime.h>
+#include <linux/string.h>
+#include <linux/firmware/cirrus/wmfw.h>
+#include <linux/input/cs40l26.h>
+
+static bool cs40l26_readable_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case CS40L26_DEVID ... CS40L26_REVID:
+	case CS40L26_TEST_KEY_CTRL:
+	case CS40L26_GLOBAL_ENABLES:
+	case CS40L26_ERROR_RELEASE:
+	case CS40L26_PWRMGT_CTL ... CS40L26_PWRMGT_STS:
+	case CS40L26_REFCLK_INPUT:
+	case CS40L26_PLL_REFCLK_DETECT_0:
+	case CS40L26_VBST_CTL_1 ... CS40L26_BST_IPK_CTL:
+	case CS40L26_TEST_LBST:
+	case CS40L26_NGATE1_INPUT:
+	case CS40L26_DAC_MSM_CONFIG ... CS40L26_TST_DAC_MSM_CONFIG:
+	case CS40L26_IRQ1_STATUS:
+	case CS40L26_IRQ1_EINT_1 ... CS40L26_IRQ1_EINT_5:
+	case CS40L26_IRQ1_STS_1 ... CS40L26_IRQ1_STS_5:
+	case CS40L26_IRQ1_MASK_1 ... CS40L26_IRQ1_MASK_5:
+	case CS40L26_MIXER_NGATE_CH1_CFG:
+	case CS40L26_DSP_MBOX_1 ... CS40L26_DSP_VIRTUAL2_MBOX_8:
+	case CS40L26_OTP_MEM0 ... CS40L26_OTP_MEM31:
+	case CS40L26_DSP1_XMEM_PACKED_0 ... CS40L26_DSP1_XMEM_PACKED_6143:
+	case CS40L26_DSP1_XROM_PACKED_0 ... CS40L26_DSP1_XROM_PACKED_4604:
+	case CS40L26_DSP1_XMEM_UNPACKED32_0 ... CS40L26_DSP1_XROM_UNPACKED32_3070:
+	case CS40L26_DSP1_SYS_INFO_ID:
+	case CS40L26_DSP1_XMEM_UNPACKED24_0 ... CS40L26_DSP1_XMEM_UNPACKED24_8191:
+	case CS40L26_DSP1_XROM_UNPACKED24_0 ... CS40L26_DSP1_XROM_UNPACKED24_6141:
+	case CS40L26_DSP1_SCRATCH1:
+	case CS40L26_DSP1_SCRATCH2:
+	case CS40L26_DSP1_SCRATCH3:
+	case CS40L26_DSP1_SCRATCH4:
+	case CS40L26_DSP1_CCM_CORE_CONTROL:
+	case CS40L26_DSP1_YMEM_PACKED_0 ... CS40L26_DSP1_YMEM_PACKED_1532:
+	case CS40L26_DSP1_YMEM_UNPACKED32_0 ... CS40L26_DSP1_YMEM_UNPACKED32_1022:
+	case CS40L26_DSP1_YMEM_UNPACKED24_0 ... CS40L26_DSP1_YMEM_UNPACKED24_2045:
+	case CS40L26_DSP1_PMEM_0 ... CS40L26_DSP1_PMEM_5114:
+	case CS40L26_DSP1_PROM_0 ... CS40L26_DSP1_PROM_30714:
+		return true;
+	default:
+		return false;
+	}
+}
+
+const struct regmap_config cs40l26_regmap = {
+	.reg_bits = 32,
+	.val_bits = 32,
+	.reg_stride = 4,
+	.reg_format_endian = REGMAP_ENDIAN_BIG,
+	.val_format_endian = REGMAP_ENDIAN_BIG,
+	.max_register = CS40L26_LASTREG,
+	.num_reg_defaults = 0,
+	.readable_reg = cs40l26_readable_reg,
+	.cache_type = REGCACHE_NONE,
+};
+EXPORT_SYMBOL_GPL(cs40l26_regmap);
+
+static const struct cs_dsp_region cs40l26_dsp_regions[] = {
+	{
+		.type = WMFW_HALO_PM_PACKED,
+		.base = CS40L26_DSP1_PMEM_0,
+	},
+	{
+		.type = WMFW_HALO_XM_PACKED,
+		.base = CS40L26_DSP1_XMEM_PACKED_0,
+	},
+	{
+		.type = WMFW_HALO_YM_PACKED,
+		.base = CS40L26_DSP1_YMEM_PACKED_0,
+	},
+	{
+		.type = WMFW_ADSP2_XM,
+		.base = CS40L26_DSP1_XMEM_UNPACKED24_0,
+	},
+	{
+		.type = WMFW_ADSP2_YM,
+		.base = CS40L26_DSP1_YMEM_UNPACKED24_0,
+	},
+};
+
+static int cs40l26_mailbox_write(struct cs40l26_private *cs40l26, u32 write_val)
+{
+	unsigned int ack;
+	int i, error;
+
+	for (i = 0; i < CS40L26_DSP_TIMEOUT_COUNT; i++) {
+		regmap_write(cs40l26->regmap, CS40L26_DSP_VIRTUAL1_MBOX_1, write_val);
+
+		error = regmap_read(cs40l26->regmap, CS40L26_DSP_VIRTUAL1_MBOX_1, &ack);
+		if (!error && !ack)
+			break;
+
+		usleep_range(CS40L26_DSP_TIMEOUT_US, CS40L26_DSP_TIMEOUT_US + 100);
+	}
+	if (i == CS40L26_DSP_TIMEOUT_COUNT) {
+		if (!error)
+			error = -ETIMEDOUT;
+
+		dev_err(cs40l26->dev, "Mailbox ack. failed with value 0x%X: %d", ack, error);
+	}
+
+	return error;
+}
+
+static int cs40l26_fw_ctl_write_raw(struct cs_dsp *dsp, const char * const name,
+					unsigned int algo_id, unsigned int off_words,
+					size_t len_bytes, u32 *buf)
+{
+	size_t len_words = len_bytes / sizeof(__be32);
+	struct cs_dsp_coeff_ctl *ctl;
+	int i, error;
+	__be32 *val;
+
+	ctl = cs_dsp_get_ctl(dsp, name, WMFW_ADSP2_XM, algo_id);
+	if (IS_ERR_OR_NULL(ctl)) {
+		dev_err(dsp->dev, "Failed to find fw ctl %s\n", name);
+		return -ENOENT;
+	}
+
+	val = kzalloc(len_bytes, GFP_KERNEL);
+	if (!val)
+		return -ENOMEM;
+
+	for (i = 0; i < len_words; i++)
+		val[i] = cpu_to_be32(buf[i]);
+
+	error = cs_dsp_coeff_write_ctrl(ctl, off_words, val, len_bytes);
+	if (error)
+		dev_err(dsp->dev, "Failed to write fw ctl %s: %d\n", name, error);
+
+	kfree(val);
+
+	return error;
+}
+
+static inline int cs40l26_fw_ctl_write(struct cs_dsp *dsp, const char * const name,
+					unsigned int algo_id, u32 val)
+{
+	return cs40l26_fw_ctl_write_raw(dsp, name, algo_id, 0, sizeof(u32), &val);
+}
+
+static int cs40l26_fw_ctl_read_raw(struct cs_dsp *dsp, const char * const name,
+					unsigned int algo_id, unsigned int off_words,
+					size_t len_bytes, u32 *buf)
+{
+	size_t len_words = len_bytes / sizeof(u32);
+	struct cs_dsp_coeff_ctl *ctl;
+	int i, error;
+
+	ctl = cs_dsp_get_ctl(dsp, name, WMFW_ADSP2_XM, algo_id);
+	if (IS_ERR_OR_NULL(ctl)) {
+		dev_err(dsp->dev, "Failed to find fw ctl %s\n", name);
+		return -ENOENT;
+	}
+
+	error = cs_dsp_coeff_read_ctrl(ctl, off_words, buf, len_bytes);
+	if (error) {
+		dev_err(dsp->dev, "Failed to read fw ctl %s: %d\n", name, error);
+		return error;
+	}
+
+	for (i = 0; i < len_words; i++)
+		buf[i] = be32_to_cpu(buf[i]);
+
+	return 0;
+}
+
+static inline int cs40l26_fw_ctl_read(struct cs_dsp *dsp, const char * const name,
+					unsigned int algo_id, u32 *buf)
+{
+	return cs40l26_fw_ctl_read_raw(dsp, name, algo_id, 0, sizeof(u32), buf);
+}
+
+static const struct cs40l26_pseq_params cs40l26_pseq_params_write_full = {
+	.num_op_words		= CS40L26_PSEQ_OP_WRITE_FULL_WORDS,
+	.op_mask		= CS40L26_PSEQ_WRITE_FULL_OP_MASK,
+	.low_addr_shift		= CS40L26_PSEQ_WRITE_FULL_LOWER_ADDR_SHIFT,
+	.low_addr_mask		= CS40L26_PSEQ_WRITE_FULL_LOWER_ADDR_MASK,
+	.low_data_mask		= CS40L26_PSEQ_WRITE_FULL_LOWER_DATA_MASK,
+	.up_addr_shift		= CS40L26_PSEQ_WRITE_FULL_UPPER_ADDR_SHIFT,
+	.up_addr_mask		= CS40L26_PSEQ_WRITE_FULL_UPPER_ADDR_MASK,
+	.up_data_mask		= CS40L26_PSEQ_WRITE_FULL_UPPER_DATA_MASK,
+	.up_data_shift		= CS40L26_PSEQ_WRITE_FULL_UPPER_DATA_SHIFT,
+};
+
+static const struct cs40l26_pseq_params cs40l26_pseq_params_write_x16 = {
+	.num_op_words		= CS40L26_PSEQ_OP_WRITE_X16_WORDS,
+	.op_mask		= CS40L26_PSEQ_WRITE_X16_OP_MASK,
+	.low_addr_shift		= CS40L26_PSEQ_WRITE_X16_LOWER_ADDR_SHIFT,
+	.low_addr_mask		= CS40L26_PSEQ_WRITE_X16_LOWER_ADDR_MASK,
+	.low_data_mask		= 0,
+	.up_addr_shift		= CS40L26_PSEQ_WRITE_X16_UPPER_ADDR_SHIFT,
+	.up_addr_mask		= CS40L26_PSEQ_WRITE_X16_UPPER_ADDR_MASK,
+	.up_data_mask		= CS40L26_PSEQ_WRITE_X16_UPPER_DATA_MASK,
+	.up_data_shift		= CS40L26_PSEQ_WRITE_X16_UPPER_DATA_SHIFT,
+};
+
+static int cs40l26_pseq_find_end(struct cs40l26_private *cs40l26, struct cs40l26_pseq_op **op_end)
+{
+	struct cs40l26_pseq_op *op;
+
+	list_for_each_entry(op, &cs40l26->pseq_op_head, list) {
+		if (op->operation == CS40L26_PSEQ_OP_END)
+			break;
+	}
+
+	if (op->operation != CS40L26_PSEQ_OP_END) {
+		dev_err(cs40l26->dev, "Failed to find PSEQ list terminator\n");
+		return -ENOENT;
+	}
+
+	*op_end = op;
+
+	return 0;
+}
+
+static int cs40l26_pseq_write(struct cs40l26_private *cs40l26, u32 addr,
+				u32 data, bool update, u8 op_code)
+{
+	struct device *dev = cs40l26->dev;
+	bool is_new = true;
+	struct cs40l26_pseq_op *op, *op_new, *op_end;
+	const struct cs40l26_pseq_params *params;
+	int error;
+
+	switch (op_code) {
+	case CS40L26_PSEQ_OP_WRITE_FULL:
+		params = &cs40l26_pseq_params_write_full;
+		break;
+	case CS40L26_PSEQ_OP_WRITE_L16:
+	case CS40L26_PSEQ_OP_WRITE_H16:
+		if (addr & CS40L26_PSEQ_INVALID_ADDR) {
+			dev_err(dev, "Invalid PSEQ address: 0x%08X\n", addr);
+			return -EINVAL;
+		}
+
+		params = &cs40l26_pseq_params_write_x16;
+		break;
+	default:
+		dev_err(dev, "Invalid PSEQ OP code: 0x%02X\n", op_code);
+		return -EINVAL;
+	}
+
+	op_new = devm_kzalloc(dev, sizeof(struct cs40l26_pseq_op), GFP_KERNEL);
+	if (!op_new)
+		return -ENOMEM;
+
+	op_new->size = params->num_op_words;
+	op_new->operation = op_code;
+	op_new->words[0] = (op_code << CS40L26_PSEQ_OP_SHIFT);
+	op_new->words[0] |= (addr & params->up_addr_mask) >> params->up_addr_shift;
+	op_new->words[1] = (addr & params->low_addr_mask) << params->low_addr_shift;
+	op_new->words[1] |= (data & params->up_data_mask) >> params->up_data_shift;
+	if (op_code == CS40L26_PSEQ_OP_WRITE_FULL)
+		op_new->words[2] = data & params->low_data_mask;
+
+	list_for_each_entry(op, &cs40l26->pseq_op_head, list) {
+		if (op->words[0] == op_new->words[0] &&
+				(op->words[1] & params->op_mask) ==
+				(op_new->words[1] & params->op_mask) && update) {
+			if (op->size != params->num_op_words) {
+				dev_err(dev, "Failed to replace PSEQ op.\n");
+				error = -EINVAL;
+				goto op_new_free;
+			}
+			is_new = false;
+			break;
+		}
+	}
+
+	error = cs40l26_pseq_find_end(cs40l26, &op_end);
+	if (error)
+		goto op_new_free;
+
+	if (((CS40L26_PSEQ_MAX_WORDS * sizeof(u32)) - op_end->offset) <
+			(op_new->size * sizeof(u32))) {
+		dev_err(dev, "Not enough space in pseq to add op\n");
+		error = -ENOMEM;
+		goto op_new_free;
+	}
+
+	if (is_new) {
+		op_new->offset = op_end->offset;
+		op_end->offset += (op_new->size * sizeof(u32));
+	} else {
+		op_new->offset = op->offset;
+	}
+
+	error = cs40l26_fw_ctl_write_raw(&cs40l26->dsp, "POWER_ON_SEQUENCE", CS40L26_PM_ALGO_ID,
+					op_new->offset / sizeof(u32), op_new->size * sizeof(u32),
+					op_new->words);
+	if (error)
+		goto op_new_free;
+
+	if (is_new) {
+		error = cs40l26_fw_ctl_write_raw(&cs40l26->dsp, "POWER_ON_SEQUENCE",
+						CS40L26_PM_ALGO_ID, op_end->offset / sizeof(u32),
+						op_end->size * sizeof(u32), op_end->words);
+		if (error)
+			goto op_new_free;
+
+		list_add(&op_new->list, &cs40l26->pseq_op_head);
+	} else {
+		list_replace(&op->list, &op_new->list);
+	}
+
+	return 0;
+
+op_new_free:
+	devm_kfree(dev, op_new);
+
+	return error;
+}
+
+static int cs40l26_pseq_multi_write(struct cs40l26_private *cs40l26,
+		const struct reg_sequence *reg_seq, int num_regs, bool update, u8 op_code)
+{
+	int error, i;
+
+	for (i = 0; i < num_regs; i++) {
+		error = cs40l26_pseq_write(cs40l26, reg_seq[i].reg,
+						reg_seq[i].def, update, op_code);
+		if (error)
+			return error;
+	}
+
+	return 0;
+}
+
+static int cs40l26_update_reg_defaults_via_pseq(struct cs40l26_private *cs40l26)
+{
+	int error;
+
+	error = cs40l26_pseq_write(cs40l26, CS40L26_NGATE1_INPUT,
+					CS40L26_DATA_SRC_DSP1TX4, true,
+					CS40L26_PSEQ_OP_WRITE_L16);
+	if (error)
+		return error;
+
+	error = cs40l26_pseq_write(cs40l26, CS40L26_MIXER_NGATE_CH1_CFG,
+					CS40L26_MIXER_NGATE_CH1_CFG_DEFAULT,
+					true, CS40L26_PSEQ_OP_WRITE_FULL);
+	if (error)
+		return error;
+
+	return cs40l26_pseq_write(cs40l26, CS40L26_TST_DAC_MSM_CONFIG,
+					CS40L26_TST_DAC_MSM_CFG_DFLT_CHG_VAL_H16,
+					true, CS40L26_PSEQ_OP_WRITE_H16);
+}
+
+static int cs40l26_pseq_init(struct cs40l26_private *cs40l26)
+{
+	struct cs40l26_pseq_op *pseq_op;
+	int error, i, num_words;
+	u8 operation;
+	u32 *words;
+
+	INIT_LIST_HEAD(&cs40l26->pseq_op_head);
+
+	words = kcalloc(CS40L26_PSEQ_MAX_WORDS, sizeof(u32), GFP_KERNEL);
+	if (IS_ERR_OR_NULL(words))
+		return -ENOMEM;
+
+	error = cs40l26_fw_ctl_read_raw(&cs40l26->dsp, "POWER_ON_SEQUENCE",
+					CS40L26_PM_ALGO_ID, 0,
+					CS40L26_PSEQ_MAX_WORDS * sizeof(u32), words);
+	if (error)
+		goto err_free;
+
+	for (i = 0; i < CS40L26_PSEQ_MAX_WORDS; i += num_words) {
+		operation = (words[i] & CS40L26_PSEQ_OP_MASK) >> CS40L26_PSEQ_OP_SHIFT;
+
+		switch (operation) {
+		case CS40L26_PSEQ_OP_END:
+			num_words = CS40L26_PSEQ_OP_END_WORDS;
+			break;
+		case CS40L26_PSEQ_OP_WRITE_ADDR8:
+		case CS40L26_PSEQ_OP_WRITE_H16:
+		case CS40L26_PSEQ_OP_WRITE_L16:
+			num_words = CS40L26_PSEQ_OP_WRITE_X16_WORDS;
+			break;
+		case CS40L26_PSEQ_OP_WRITE_FULL:
+			num_words = CS40L26_PSEQ_OP_WRITE_FULL_WORDS;
+			break;
+		default:
+			dev_err(cs40l26->dev, "Invalid OP code 0x%02X\n", operation);
+			error = -EINVAL;
+			goto err_free;
+		}
+
+		pseq_op = devm_kzalloc(cs40l26->dev, sizeof(struct cs40l26_pseq_op), GFP_KERNEL);
+		if (!pseq_op) {
+			error = -ENOMEM;
+			goto err_free;
+		}
+
+		memcpy(pseq_op->words, &words[i], num_words * sizeof(u32));
+		pseq_op->size = num_words;
+		pseq_op->offset = i * sizeof(u32);
+		pseq_op->operation = operation;
+		list_add(&pseq_op->list, &cs40l26->pseq_op_head);
+
+		if (operation == CS40L26_PSEQ_OP_END)
+			break;
+	}
+
+	if (operation != CS40L26_PSEQ_OP_END) {
+		dev_err(cs40l26->dev, "PSEQ_END_OF_SCRIPT not found\n");
+		error = -ENOENT;
+		goto err_free;
+	}
+
+	error = cs40l26_update_reg_defaults_via_pseq(cs40l26);
+
+err_free:
+	kfree(words);
+
+	return error;
+}
+
+static inline void cs40l26_pm_exit(struct device *dev)
+{
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_put_autosuspend(dev);
+}
+
+static inline int cs40l26_pm_enter(struct device *dev)
+{
+	return pm_runtime_resume_and_get(dev);
+}
+
+static inline int cs40l26_pm_timeout_ms_set(struct cs40l26_private *cs40l26,
+		unsigned int dsp_state, u32 timeout_ms)
+{
+	return regmap_write(cs40l26->regmap,
+				(dsp_state == CS40L26_DSP_STATE_STANDBY) ?
+				CS40L26_A1_PM_STDBY_TICKS_STATIC_REG :
+				CS40L26_A1_PM_ACTIVE_TICKS_STATIC_REG,
+				timeout_ms * CS40L26_PM_TICKS_PER_MS);
+}
+
+static inline int cs40l26_pm_timeout_ms_get(struct cs40l26_private *cs40l26,
+		unsigned int dsp_state, unsigned int *timeout_ms)
+{
+	unsigned int timeout_ticks;
+	int error;
+
+	error = regmap_read(cs40l26->regmap, (dsp_state == CS40L26_DSP_STATE_STANDBY) ?
+			CS40L26_A1_PM_STDBY_TICKS_STATIC_REG :
+			CS40L26_A1_PM_ACTIVE_TICKS_STATIC_REG, &timeout_ticks);
+	if (error)
+		return error;
+
+	*timeout_ms = timeout_ticks / CS40L26_PM_TICKS_PER_MS;
+
+	return 0;
+}
+
+static inline void cs40l26_pm_runtime_setup(struct cs40l26_private *cs40l26)
+{
+	pm_runtime_mark_last_busy(cs40l26->dev);
+	pm_runtime_use_autosuspend(cs40l26->dev);
+	pm_runtime_set_autosuspend_delay(cs40l26->dev, CS40L26_AUTOSUSPEND_DELAY_MS);
+	pm_runtime_enable(cs40l26->dev);
+}
+
+static inline void cs40l26_pm_runtime_teardown(struct cs40l26_private *cs40l26)
+{
+	pm_runtime_disable(cs40l26->dev);
+	pm_runtime_dont_use_autosuspend(cs40l26->dev);
+}
+
+static int cs40l26_irq_update_mask(struct cs40l26_private *cs40l26, u32 reg, u32 val, u32 bit_mask)
+{
+	unsigned int eint_reg, cur_mask, new_mask;
+	int error;
+
+	if (reg == CS40L26_IRQ1_MASK_1) {
+		eint_reg = CS40L26_IRQ1_EINT_1;
+	} else if (reg == CS40L26_IRQ1_MASK_2) {
+		eint_reg = CS40L26_IRQ1_EINT_2;
+	} else {
+		dev_err(cs40l26->dev, "Invalid IRQ mask reg: 0x%08X\n", reg);
+		return -EINVAL;
+	}
+
+	error = regmap_read(cs40l26->regmap, reg, &cur_mask);
+	if (error)
+		return error;
+
+	new_mask = (cur_mask & ~bit_mask) | val;
+
+	error = regmap_write(cs40l26->regmap, eint_reg, bit_mask);
+	if (error)
+		return error;
+
+	error = regmap_write(cs40l26->regmap, reg, new_mask);
+	if (error)
+		return error;
+
+	if (bit_mask & GENMASK(31, 16)) {
+		error = cs40l26_pseq_write(cs40l26, reg, (new_mask & GENMASK(31, 16)) >> 16,
+						true, CS40L26_PSEQ_OP_WRITE_H16);
+		if (error) {
+			dev_err(cs40l26->dev, "Failed to update IRQ mask H16");
+			return error;
+		}
+	}
+
+	if (bit_mask & GENMASK(15, 0)) {
+		error = cs40l26_pseq_write(cs40l26, reg, (new_mask & GENMASK(15, 0)), true,
+						CS40L26_PSEQ_OP_WRITE_L16);
+		if (error) {
+			dev_err(cs40l26->dev, "Failed to update IRQ mask L16");
+			return error;
+		}
+	}
+
+	return 0;
+}
+
+static inline int cs40l26_gpio_timeout_ms_set(struct cs40l26_private *cs40l26,
+						unsigned int timeout_ms)
+{
+	return cs40l26_fw_ctl_write(&cs40l26->dsp, "TIMEOUT_GPI_MS",
+					CS40L26_VIBEGEN_ALGO_ID, timeout_ms);
+}
+
+static int cs40l26_erase_gpio_mapping(struct cs40l26_private *cs40l26,
+					enum cs40l26_gpio_map mapping)
+{
+	unsigned int disable = CS40L26_EVENT_MAP_GPI_DISABLE;
+	int error;
+
+	if (cs40l26->dsp.running) {
+		mutex_lock(&cs40l26->dsp.pwr_lock);
+
+		error = cs40l26_fw_ctl_write_raw(&cs40l26->dsp, "ENT_MAP_TABLE_EVENT_DATA_PACKED",
+						CS40L26_EVENT_HANDLER_ALGO_ID, mapping,
+						sizeof(u32), &disable);
+		if (error) {
+			mutex_unlock(&cs40l26->dsp.pwr_lock);
+			return error;
+		}
+
+		error = cs40l26_gpio_timeout_ms_set(cs40l26, 0);
+
+		mutex_unlock(&cs40l26->dsp.pwr_lock);
+	} else {
+		error = regmap_write(cs40l26->regmap, CS40L26_A1_EVENT_MAP_1, disable);
+	}
+
+	return error;
+}
+
+static int cs40l26_gpio_config(struct cs40l26_private *cs40l26)
+{
+	unsigned int defaults[2], mask, val;
+	int error;
+
+	defaults[0] = cs40l26->gpio_release_default;
+	defaults[1] = cs40l26->gpio_press_default;
+
+	error = cs40l26_fw_ctl_write_raw(&cs40l26->dsp, "ENT_MAP_TABLE_EVENT_DATA_PACKED",
+						CS40L26_EVENT_HANDLER_ALGO_ID, 0,
+						2 * sizeof(u32), defaults);
+	if (error)
+		return error;
+
+	switch (cs40l26->devid) {
+	case CS40L26_DEVID_A:
+	case CS40L26_DEVID_L27_A:
+		val = (unsigned int)GENMASK(CS40L26_IRQ1_GPIO4_FALL, CS40L26_IRQ1_GPIO2_RISE);
+		break;
+	default:
+		val = 0;
+	}
+
+	mask = (unsigned int)GENMASK(CS40L26_IRQ1_GPIO4_FALL, CS40L26_IRQ1_GPIO1_RISE);
+
+	return cs40l26_irq_update_mask(cs40l26, CS40L26_IRQ1_MASK_1, val, mask);
+}
+
+static int cs40l26_map_effect_to_gpio(struct cs40l26_private *cs40l26, struct ff_effect *effect,
+		struct cs40l26_uploaded_effect *ueffect)
+{
+	u16 button = effect->trigger.button;
+	u8 edge, ev_handler_bank_ram, gpio;
+	unsigned int offset, write_val;
+	int error;
+
+	gpio = (button & CS40L26_BTN_NUM_MASK) >> CS40L26_BTN_NUM_SHIFT;
+	edge = (button & CS40L26_BTN_EDGE_MASK) >> CS40L26_BTN_EDGE_SHIFT;
+
+	if (gpio != 1) {
+		dev_err(cs40l26->dev, "GPIO%u not supported on 0x%02X\n", gpio, cs40l26->revid);
+		return -EINVAL;
+	}
+
+	ev_handler_bank_ram = (ueffect->wvfrm_bank == CS40L26_WVFRM_BANK_RAM ||
+				ueffect->wvfrm_bank == CS40L26_WVFRM_BANK_BUZ) ? 1 : 0;
+
+	offset = edge ? 0 : 1;
+
+	write_val = (ueffect->trigger_index & CS40L26_BTN_INDEX_MASK) |
+			(ev_handler_bank_ram << CS40L26_BTN_BANK_SHIFT);
+
+	mutex_lock(&cs40l26->dsp.pwr_lock);
+
+	error = cs40l26_fw_ctl_write_raw(&cs40l26->dsp, "ENT_MAP_TABLE_EVENT_DATA_PACKED",
+					CS40L26_EVENT_HANDLER_ALGO_ID, offset, sizeof(u32),
+					&write_val);
+	if (error)
+		goto err_pwr_lock;
+
+	error = cs40l26_gpio_timeout_ms_set(cs40l26, effect->replay.length);
+
+err_pwr_lock:
+	mutex_unlock(&cs40l26->dsp.pwr_lock);
+	if (error)
+		return error;
+
+	ueffect->mapping = edge ? CS40L26_GPIO_MAP_A_PRESS : CS40L26_GPIO_MAP_A_RELEASE;
+
+	return 0;
+}
+
+static inline int cs40l26_num_waves_get(struct cs40l26_private *cs40l26,
+					u32 *num_waves)
+{
+	return cs40l26_fw_ctl_read(&cs40l26->dsp, "NUM_OF_WAVES",
+					CS40L26_VIBEGEN_ALGO_ID, num_waves);
+}
+
+static struct cs40l26_uploaded_effect *cs40l26_uploaded_effect_find(struct cs40l26_private *cs40l26,
+									int id)
+{
+	struct cs40l26_uploaded_effect *ueffect;
+
+	if (list_empty(&cs40l26->effect_head)) {
+		dev_dbg(cs40l26->dev, "Effect list is empty\n");
+		return ERR_PTR(-ENODATA);
+	}
+
+	list_for_each_entry(ueffect, &cs40l26->effect_head, list) {
+		if (ueffect->id == id)
+			return ueffect;
+	}
+
+	return NULL;
+}
+
+static struct cs40l26_buzzgen_config cs40l26_buzzgen_configs[] = {
+	{
+		.duration_name = "BUZZ_EFFECTS2_BUZZ_DURATION",
+		.freq_name = "BUZZ_EFFECTS2_BUZZ_FREQ",
+		.level_name = "BUZZ_EFFECTS2_BUZZ_LEVEL",
+		.effect_id = -1
+	},
+	{
+		.duration_name = "BUZZ_EFFECTS3_BUZZ_DURATION",
+		.freq_name = "BUZZ_EFFECTS3_BUZZ_FREQ",
+		.level_name = "BUZZ_EFFECTS3_BUZZ_LEVEL",
+		.effect_id = -1
+	},
+	{
+		.duration_name = "BUZZ_EFFECTS4_BUZZ_DURATION",
+		.freq_name = "BUZZ_EFFECTS4_BUZZ_FREQ",
+		.level_name = "BUZZ_EFFECTS4_BUZZ_LEVEL",
+		.effect_id = -1
+	},
+	{
+		.duration_name = "BUZZ_EFFECTS5_BUZZ_DURATION",
+		.freq_name = "BUZZ_EFFECTS5_BUZZ_FREQ",
+		.level_name = "BUZZ_EFFECTS5_BUZZ_LEVEL",
+		.effect_id = -1
+	},
+	{
+		.duration_name = "BUZZ_EFFECTS6_BUZZ_DURATION",
+		.freq_name = "BUZZ_EFFECTS6_BUZZ_FREQ",
+		.level_name = "BUZZ_EFFECTS6_BUZZ_LEVEL",
+		.effect_id = -1
+	},
+};
+
+static int cs40l26_buzzgen_find_slot(struct cs40l26_private *cs40l26, int id)
+{
+	int i, slot = -1;
+
+	for (i = CS40L26_BUZZGEN_NUM_CONFIGS - 1; i >= 0; i--) {
+		if (cs40l26_buzzgen_configs[i].effect_id == id) {
+			slot = i;
+			break;
+		} else if (cs40l26_buzzgen_configs[i].effect_id == -1) {
+			slot = i;
+		}
+	}
+
+	return slot;
+}
+
+static int cs40l26_erase_buzzgen(struct cs40l26_private *cs40l26, int id)
+{
+	int slot = cs40l26_buzzgen_find_slot(cs40l26, id);
+
+	if (slot == -1) {
+		dev_err(cs40l26->dev, "Failed to erase BUZZGEN config for id %d\n", id);
+		return -EINVAL;
+	}
+
+	cs40l26_buzzgen_configs[slot].effect_id = -1;
+
+	return 0;
+}
+
+static int cs40l26_sine_upload(struct cs40l26_private *cs40l26, struct ff_effect *effect,
+		struct cs40l26_uploaded_effect *ueffect)
+{
+	unsigned int freq, level, duration;
+	int error, slot;
+
+	slot = cs40l26_buzzgen_find_slot(cs40l26, effect->id);
+	if (slot == -1) {
+		dev_err(cs40l26->dev, "No free BUZZGEN slot available\n");
+		return -ENOSPC;
+	}
+
+	cs40l26_buzzgen_configs[slot].effect_id = effect->id;
+
+	/* Divide by 4 to match firmware's formatting expectation */
+	duration = (u32)(effect->replay.length / 4);
+
+	if (effect->u.periodic.period < CS40L26_BUZZGEN_PERIOD_MS_MIN)
+		freq = 1000 / CS40L26_BUZZGEN_PERIOD_MS_MIN;
+	else if (effect->u.periodic.period > CS40L26_BUZZGEN_PERIOD_MS_MAX)
+		freq = 1000 / CS40L26_BUZZGEN_PERIOD_MS_MAX;
+	else
+		freq = 1000 / effect->u.periodic.period;
+
+	if (effect->u.periodic.magnitude < CS40L26_BUZZGEN_LEVEL_MIN)
+		level = CS40L26_BUZZGEN_LEVEL_MIN;
+	else if (effect->u.periodic.magnitude > CS40L26_BUZZGEN_LEVEL_MAX)
+		level = CS40L26_BUZZGEN_LEVEL_MAX;
+	else
+		level = effect->u.periodic.magnitude;
+
+	mutex_lock(&cs40l26->dsp.pwr_lock);
+
+	error = cs40l26_fw_ctl_write(&cs40l26->dsp, cs40l26_buzzgen_configs[slot].duration_name,
+					CS40L26_BUZZGEN_ALGO_ID, duration);
+	if (error)
+		goto err_pwr_lock;
+
+	error = cs40l26_fw_ctl_write(&cs40l26->dsp, cs40l26_buzzgen_configs[slot].freq_name,
+					CS40L26_BUZZGEN_ALGO_ID, freq);
+	if (error)
+		goto err_pwr_lock;
+
+	error = cs40l26_fw_ctl_write(&cs40l26->dsp, cs40l26_buzzgen_configs[slot].level_name,
+					CS40L26_BUZZGEN_ALGO_ID, level);
+err_pwr_lock:
+	mutex_unlock(&cs40l26->dsp.pwr_lock);
+	if (error)
+		return error;
+
+	ueffect->id = effect->id;
+	ueffect->wvfrm_bank = CS40L26_WVFRM_BANK_BUZ;
+	/*
+	 * BUZZGEN 1 is reserved for OTP buzz; BUZZGEN 2 - BUZZGEN 6 are valid.
+	 * Add an offset of 1 for this reason.
+	 */
+	ueffect->trigger_index = CS40L26_BUZZGEN_INDEX_START + slot + 1;
+
+	return 0;
+}
+
+static int cs40l26_custom_upload(struct cs40l26_private *cs40l26, struct ff_effect *effect,
+					struct cs40l26_uploaded_effect *ueffect)
+{
+	struct device *dev = cs40l26->dev;
+	unsigned int nwaves, min_index, max_index, trigger_index;
+	u16 bank, index;
+	int error;
+
+	mutex_lock(&cs40l26->dsp.pwr_lock);
+	error = cs40l26_num_waves_get(cs40l26, &nwaves);
+	mutex_unlock(&cs40l26->dsp.pwr_lock);
+	if (error)
+		return error;
+
+	bank = (u16)(cs40l26->raw_custom_data[0] & 0xffffu);
+	index = (u16)(cs40l26->raw_custom_data[1] & 0xffffu);
+
+	if (bank == CS40L26_WVFRM_BANK_RAM) {
+		if (nwaves == 0) {
+			dev_err(dev, "No waveforms in RAM\n");
+			return -ENODATA;
+		}
+
+		min_index = CS40L26_RAM_INDEX_START;
+		max_index = min_index + nwaves - 1;
+	} else if (bank == CS40L26_WVFRM_BANK_ROM) {
+		min_index = CS40L26_ROM_INDEX_START;
+		max_index = CS40L26_ROM_INDEX_END;
+	} else {
+		dev_err(dev, "Invalid custom waveform bank: %u\n", bank);
+		return -EINVAL;
+	}
+
+	trigger_index = index + min_index;
+	if (trigger_index > max_index) {
+		dev_err(dev, "RAM index 0x%X out of bounds\n", trigger_index);
+		return -EINVAL;
+	}
+	dev_dbg(dev, "%s: Trigger Index = 0x%08X\n", __func__, trigger_index);
+
+	ueffect->id = effect->id;
+	ueffect->wvfrm_bank = bank;
+	ueffect->trigger_index = trigger_index;
+
+	return 0;
+}
+
+static int cs40l26_uploaded_effect_add(struct cs40l26_private *cs40l26)
+{
+	struct ff_effect *effect = &cs40l26->upload_effect;
+	bool is_new = false;
+	struct cs40l26_uploaded_effect *ueffect;
+	int error;
+
+	ueffect = cs40l26_uploaded_effect_find(cs40l26, cs40l26->upload_effect.id);
+	if (IS_ERR_OR_NULL(ueffect)) {
+		is_new = true;
+		ueffect = devm_kzalloc(cs40l26->dev, sizeof(struct cs40l26_uploaded_effect),
+						GFP_KERNEL);
+		if (IS_ERR_OR_NULL(ueffect))
+			return -ENOMEM;
+	}
+
+	if (effect->u.periodic.waveform == FF_CUSTOM) {
+		error = cs40l26_custom_upload(cs40l26, effect, ueffect);
+	} else if (effect->u.periodic.waveform == FF_SINE) {
+		error = cs40l26_sine_upload(cs40l26, effect, ueffect);
+	} else {
+		dev_err(cs40l26->dev, "Invalid periodic waveform type: 0x%X\n",
+				effect->u.periodic.waveform);
+		error = -EINVAL;
+	}
+	if (error)
+		goto err_free;
+
+	if (effect->trigger.button) {
+		error = cs40l26_map_effect_to_gpio(cs40l26, effect, ueffect);
+		if (error)
+			goto err_free;
+	} else {
+		ueffect->mapping = CS40L26_GPIO_MAP_INVALID;
+	}
+
+	if (is_new)
+		list_add(&ueffect->list, &cs40l26->effect_head);
+
+	return 0;
+
+err_free:
+	if (is_new)
+		kfree(ueffect);
+
+	return error;
+}
+
+static void cs40l26_upload_worker(struct work_struct *work)
+{
+	struct cs40l26_private *cs40l26 = container_of(work, struct cs40l26_private, upload_work);
+	struct device *dev = cs40l26->dev;
+
+	cs40l26->upload_error = cs40l26_pm_enter(dev);
+	if (cs40l26->upload_error)
+		return;
+
+	mutex_lock(&cs40l26->lock);
+
+	cs40l26->upload_error =  cs40l26_uploaded_effect_add(cs40l26);
+
+	mutex_unlock(&cs40l26->lock);
+
+	cs40l26_pm_exit(dev);
+}
+
+static void cs40l26_vibe_start_worker(struct work_struct *work)
+{
+	struct cs40l26_uploaded_effect *ueffect;
+	struct cs40l26_private *cs40l26;
+	struct ff_effect *effect;
+	unsigned int invert;
+	struct device *dev;
+	int error;
+
+	cs40l26 = container_of(work, struct cs40l26_private, vibe_start_work);
+	dev = cs40l26->dev;
+
+	error = cs40l26_pm_enter(dev);
+	if (error)
+		return;
+
+	mutex_lock(&cs40l26->lock);
+
+	effect = cs40l26->trigger_effect;
+
+	ueffect = cs40l26_uploaded_effect_find(cs40l26, effect->id);
+	if (IS_ERR_OR_NULL(ueffect)) {
+		dev_err(dev, "No such effect (ID = %d)\n", effect->id);
+		goto err_mutex;
+	}
+
+	mutex_lock(&cs40l26->dsp.pwr_lock);
+
+	error = cs40l26_fw_ctl_write(&cs40l26->dsp, "TIMEOUT_MS", CS40L26_VIBEGEN_ALGO_ID,
+					effect->replay.length);
+	if (error)
+		goto err_pwr_lock;
+
+	switch (effect->direction) {
+	case 0x0000:
+		invert = 0;
+		break;
+	case 0x8000:
+		invert = 1;
+		break;
+	default:
+		dev_err(dev, "Invalid direction 0x%X\n", effect->direction);
+		goto err_pwr_lock;
+	}
+
+	error = cs40l26_fw_ctl_write(&cs40l26->dsp, "SOURCE_INVERT", CS40L26_EXT_ALGO_ID, invert);
+	if (error)
+		goto err_pwr_lock;
+
+	error = cs40l26_mailbox_write(cs40l26, ueffect->trigger_index);
+	if (error)
+		goto err_pwr_lock;
+
+	reinit_completion(&cs40l26->erase);
+
+err_pwr_lock:
+	mutex_unlock(&cs40l26->dsp.pwr_lock);
+err_mutex:
+	mutex_unlock(&cs40l26->lock);
+
+	cs40l26_pm_exit(dev);
+}
+
+static void cs40l26_vibe_stop_worker(struct work_struct *work)
+{
+	struct cs40l26_private *cs40l26;
+	int error;
+
+	cs40l26 = container_of(work, struct cs40l26_private, vibe_stop_work);
+
+	error = cs40l26_pm_enter(cs40l26->dev);
+	if (error)
+		return;
+
+	mutex_lock(&cs40l26->lock);
+
+	error = cs40l26_mailbox_write(cs40l26, CS40L26_DSP_MBOX_CMD_STOP_PLAYBACK);
+	if (error)
+		dev_err(cs40l26->dev, "Failed to stop playback\n");
+
+	mutex_unlock(&cs40l26->lock);
+	cs40l26_pm_exit(cs40l26->dev);
+}
+
+static void cs40l26_erase_worker(struct work_struct *work)
+{
+	struct cs40l26_uploaded_effect *ueffect;
+	struct cs40l26_private *cs40l26;
+	u16 duration, replay_len;
+	int id;
+
+	cs40l26 = container_of(work, struct cs40l26_private, erase_work);
+
+	cs40l26->erase_error = cs40l26_pm_enter(cs40l26->dev);
+	if (cs40l26->erase_error)
+		return;
+
+	mutex_lock(&cs40l26->lock);
+
+	id = cs40l26->erase_effect->id;
+	ueffect = cs40l26_uploaded_effect_find(cs40l26, id);
+	if (IS_ERR_OR_NULL(ueffect)) {
+		dev_err(cs40l26->dev, "Failed to erase nonexistent effect (%d)\n", id);
+		cs40l26->erase_error = PTR_ERR(ueffect);
+		goto err_mutex;
+	}
+
+	/* Wait for any ongoing playback to stop */
+	replay_len = cs40l26->erase_effect->replay.length;
+	duration = replay_len ? replay_len + 500 : CS40L26_VIBEGEN_MAX_TIME_MS;
+
+	mutex_unlock(&cs40l26->lock);
+
+	if (!wait_for_completion_timeout(&cs40l26->erase, msecs_to_jiffies(duration))) {
+		cs40l26->erase_error = -ETIME;
+		dev_err(cs40l26->dev, "Timed out waiting for playback stop\n");
+		goto err_pm;
+	}
+	mutex_lock(&cs40l26->lock);
+
+	if (ueffect->wvfrm_bank == CS40L26_WVFRM_BANK_BUZ) {
+		cs40l26->erase_error = cs40l26_erase_buzzgen(cs40l26, ueffect->id);
+		if (cs40l26->erase_error)
+			goto err_mutex;
+	}
+
+	if (ueffect->mapping != CS40L26_GPIO_MAP_INVALID) {
+		cs40l26->erase_error = cs40l26_erase_gpio_mapping(cs40l26, ueffect->mapping);
+		if (cs40l26->erase_error)
+			goto err_mutex;
+	}
+
+	list_del(&ueffect->list);
+	kfree(ueffect);
+
+err_mutex:
+	mutex_unlock(&cs40l26->lock);
+err_pm:
+	cs40l26_pm_exit(cs40l26->dev);
+}
+
+/* LUT for converting gain percentage to attenuation in dB */
+const u32 cs40l26_atten_lut_q21_2[CS40L26_NUM_ATTEN_LUT_VALUES] = {
+	400, /* MUTE */ 160, /* 1% */ 136, 122, 112, 104, 98, 92,
+	88, 84, 80, 77, 74, 71, 68, 66, 64, 62, 60, 58, 56, 54, 53,
+	51, 50, 48, /* 25% */ 47, 45, 44, 43, 42, 41, 40, 39, 37, 36,
+	35, 35, 34, 33, 32, 31, 30, 29, 29, 28, 27, 26, 26, 25, 24, /* 50 % */
+	23, 23, 22, 21, 21, 20, 20, 19, 18, 18, 17, 17, 16, 16, 15, 14,
+	14, 13, 13, 12, 12, 11, 11, 10, 10, /* 75% */ 10, 9, 9, 8, 8, 7,
+	7, 6, 6, 6, 5, 5, 4, 4, 4, 3, 3, 3, 2, 2, 1, 1, 1, 0, 0, /* 100% */
+};
+
+static void cs40l26_set_gain_worker(struct work_struct *work)
+{
+	struct cs40l26_private *cs40l26 = container_of(work, struct cs40l26_private, set_gain_work);
+
+	if (cs40l26_pm_enter(cs40l26->dev))
+		return;
+
+	mutex_lock(&cs40l26->lock);
+	mutex_lock(&cs40l26->dsp.pwr_lock);
+
+	cs40l26_fw_ctl_write(&cs40l26->dsp, "SOURCE_ATTENUATION", CS40L26_EXT_ALGO_ID,
+				cs40l26_atten_lut_q21_2[cs40l26->gain_pct]);
+
+	mutex_unlock(&cs40l26->dsp.pwr_lock);
+	mutex_unlock(&cs40l26->lock);
+	cs40l26_pm_exit(cs40l26->dev);
+}
+
+static int cs40l26_upload_effect(struct input_dev *dev, struct ff_effect *effect,
+					struct ff_effect *old)
+{
+	struct cs40l26_private *cs40l26 = input_get_drvdata(dev);
+	u32 len = effect->u.periodic.custom_len;
+	int error;
+
+	if (effect->type != FF_PERIODIC) {
+		dev_err(cs40l26->dev, "Effect type 0x%X not supported\n", effect->type);
+		return -EINVAL;
+	}
+
+	memcpy(&cs40l26->upload_effect, effect, sizeof(struct ff_effect));
+
+	if (effect->u.periodic.waveform == FF_CUSTOM) {
+		cs40l26->raw_custom_data = kcalloc(len, sizeof(s16), GFP_KERNEL);
+		if (IS_ERR_OR_NULL(cs40l26->raw_custom_data))
+			return -ENOMEM;
+
+		if (copy_from_user(cs40l26->raw_custom_data, effect->u.periodic.custom_data,
+					sizeof(s16) * len)) {
+			dev_err(cs40l26->dev, "Failed to get user data\n");
+			error = -EFAULT;
+			goto out_free;
+		}
+	}
+
+	/*
+	 * The no-sleep nature of Input FF callbacks requires usage of
+	 * worker functions in order to properly utilize the PM runtime
+	 * framework.
+	 */
+	queue_work(cs40l26->vibe_workqueue, &cs40l26->upload_work);
+	flush_work(&cs40l26->upload_work);
+	error = cs40l26->upload_error;
+
+out_free:
+	if (effect->u.periodic.waveform == FF_CUSTOM)
+		kfree(cs40l26->raw_custom_data);
+	cs40l26->raw_custom_data = NULL;
+	memset(&cs40l26->upload_effect, 0, sizeof(struct ff_effect));
+
+	return error;
+}
+
+static int cs40l26_playback_effect(struct input_dev *dev, int effect_id, int val)
+{
+	struct cs40l26_private *cs40l26 = input_get_drvdata(dev);
+
+	cs40l26->trigger_effect = &dev->ff->effects[effect_id];
+	if (IS_ERR_OR_NULL(cs40l26->trigger_effect)) {
+		dev_err(cs40l26->dev, "No such effect (ID = %d)\n", effect_id);
+		return -ENOENT;
+	}
+
+	if (val > 0)
+		queue_work(cs40l26->vibe_workqueue, &cs40l26->vibe_start_work);
+	else
+		queue_work(cs40l26->vibe_workqueue, &cs40l26->vibe_stop_work);
+
+	return 0;
+}
+
+static int cs40l26_erase_effect(struct input_dev *dev, int effect_id)
+{
+	struct cs40l26_private *cs40l26 = input_get_drvdata(dev);
+	struct ff_effect *effect;
+
+	effect = &dev->ff->effects[effect_id];
+	if (IS_ERR_OR_NULL(effect)) {
+		dev_err(cs40l26->dev, "Could not erase nonexistent effect\n");
+		return -ENOENT;
+	}
+
+	cs40l26->erase_effect = effect;
+
+	queue_work(cs40l26->vibe_workqueue, &cs40l26->erase_work);
+	flush_work(&cs40l26->erase_work);
+
+	return cs40l26->erase_error;
+}
+
+static void cs40l26_set_gain(struct input_dev *dev, u16 gain)
+{
+	struct cs40l26_private *cs40l26 = input_get_drvdata(dev);
+
+	if (gain >= CS40L26_NUM_ATTEN_LUT_VALUES) {
+		dev_err(cs40l26->dev, "Gain %u%% out of bounds\n", gain);
+		return;
+	}
+
+	cs40l26->gain_pct = gain;
+	queue_work(cs40l26->vibe_workqueue, &cs40l26->set_gain_work);
+}
+
+static int cs40l26_input_init(struct cs40l26_private *cs40l26)
+{
+	struct device *dev = cs40l26->dev;
+	int error;
+
+	cs40l26->input = devm_input_allocate_device(dev);
+	if (!cs40l26->input)
+		return -ENOMEM;
+
+	cs40l26->input->name = "cs40l26_input";
+	cs40l26->input->id.product = cs40l26->devid;
+	cs40l26->input->id.version = cs40l26->revid;
+
+	input_set_drvdata(cs40l26->input, cs40l26);
+	input_set_capability(cs40l26->input, EV_FF, FF_PERIODIC);
+	input_set_capability(cs40l26->input, EV_FF, FF_CUSTOM);
+	input_set_capability(cs40l26->input, EV_FF, FF_SINE);
+	input_set_capability(cs40l26->input, EV_FF, FF_GAIN);
+
+	error = input_ff_create(cs40l26->input, FF_MAX_EFFECTS);
+	if (error) {
+		dev_err(dev, "Failed to create FF device: %d\n", error);
+		return error;
+	}
+
+	/*
+	 * input_ff_create() automatically sets FF_RUMBLE capabilities;
+	 * we want to restrtict this to only FF_PERIODIC
+	 */
+	__clear_bit(FF_RUMBLE, cs40l26->input->ffbit);
+
+	cs40l26->input->ff->upload = cs40l26_upload_effect;
+	cs40l26->input->ff->playback = cs40l26_playback_effect;
+	cs40l26->input->ff->erase = cs40l26_erase_effect;
+	cs40l26->input->ff->set_gain = cs40l26_set_gain;
+
+	error = input_register_device(cs40l26->input);
+	if (error) {
+		dev_err(dev, "Cannot register input device: %d\n", error);
+		return error;
+	}
+
+	INIT_LIST_HEAD(&cs40l26->effect_head);
+
+	return error;
+}
+
+static int cs40l26_bst_ipk_config(struct cs40l26_private *cs40l26)
+{
+	unsigned int bst_ipk;
+	int error;
+
+	if (cs40l26->bst_ipk_ua < CS40L26_BST_IPK_UA_MIN ||
+			cs40l26->bst_ipk_ua > CS40L26_BST_IPK_UA_MAX)
+		bst_ipk = CS40L26_BST_IPK_DEFAULT;
+	else
+		bst_ipk = (cs40l26->bst_ipk_ua / CS40L26_BST_IPK_UA_STEP) - 16;
+
+	error = regmap_write(cs40l26->regmap, CS40L26_BST_IPK_CTL, bst_ipk);
+	if (error)
+		return error;
+
+	error = cs40l26_pseq_write(cs40l26, CS40L26_BST_IPK_CTL, bst_ipk,
+				   true, CS40L26_PSEQ_OP_WRITE_L16);
+	if (error)
+		return error;
+
+	return cs40l26_irq_update_mask(cs40l26, CS40L26_IRQ1_MASK_1, 0,
+				       BIT(CS40L26_IRQ1_BST_IPK_FLAG));
+}
+
+static int cs40l26_bst_ctl_config(struct cs40l26_private *cs40l26)
+{
+	unsigned int bst_ctl;
+	int error;
+
+	if (cs40l26->vbst_uv < CS40L26_BST_UV_MIN ||
+			cs40l26->vbst_uv > CS40L26_BST_UV_MAX)
+		bst_ctl = CS40L26_BST_DEFAULT;
+	else
+		bst_ctl = (cs40l26->vbst_uv - CS40L26_BST_UV_MIN) / CS40L26_BST_UV_STEP;
+
+	error = regmap_write(cs40l26->regmap, CS40L26_VBST_CTL_1, bst_ctl);
+	if (error)
+		return error;
+
+	return cs40l26_pseq_write(cs40l26, CS40L26_VBST_CTL_1, bst_ctl,
+					true, CS40L26_PSEQ_OP_WRITE_L16);
+}
+
+static int cs40l26_wksrc_config(struct cs40l26_private *cs40l26)
+{
+	unsigned int mask, val;
+
+	val = BIT(CS40L26_IRQ1_WKSRC_STS_GPIO2) |
+					BIT(CS40L26_IRQ1_WKSRC_STS_GPIO3) |
+					BIT(CS40L26_IRQ1_WKSRC_STS_GPIO4);
+
+	mask = BIT(CS40L26_IRQ1_WKSRC_STS_ANY) |
+					BIT(CS40L26_IRQ1_WKSRC_STS_GPIO1) |
+					BIT(CS40L26_IRQ1_WKSRC_STS_I2C) |
+					BIT(CS40L26_IRQ1_WKSRC_STS_SPI) |
+					BIT(CS40L26_IRQ1_WKSRC_STS_GPIO2) |
+					BIT(CS40L26_IRQ1_WKSRC_STS_GPIO3) |
+					BIT(CS40L26_IRQ1_WKSRC_STS_GPIO4);
+
+	return cs40l26_irq_update_mask(cs40l26, CS40L26_IRQ1_MASK_1, val, mask);
+}
+
+static int cs40l26_hw_init(struct cs40l26_private *cs40l26)
+{
+	int error;
+
+	error = cs40l26_irq_update_mask(cs40l26, CS40L26_IRQ1_MASK_1, 0,
+					GENMASK(CS40L26_IRQ1_AMP_ERR,
+					CS40L26_IRQ1_BST_OVP_FLAG_RISE) |
+					BIT(CS40L26_IRQ1_VIRTUAL2_MBOX_WR));
+	if (error)
+		return error;
+
+	error = cs40l26_irq_update_mask(cs40l26, CS40L26_IRQ1_MASK_2, 0,
+					BIT(CS40L26_IRQ2_PLL_LOCK) |
+					BIT(CS40L26_IRQ2_PLL_READY));
+	if (error)
+		return error;
+
+	error = cs40l26_wksrc_config(cs40l26);
+	if (error)
+		return error;
+
+	error = cs40l26_gpio_config(cs40l26);
+	if (error)
+		return error;
+
+	error = cs40l26_bst_ipk_config(cs40l26);
+	if (error)
+		return error;
+
+	return cs40l26_bst_ctl_config(cs40l26);
+}
+
+static int cs40l26_lbst_short_test(struct cs40l26_private *cs40l26)
+{
+	struct regmap *regmap = cs40l26->regmap;
+	struct device *dev = cs40l26->dev;
+	unsigned int err, vbst_ctl_1, vbst_ctl_2;
+	int error;
+
+	error = regmap_read(regmap, CS40L26_VBST_CTL_2, &vbst_ctl_2);
+	if (error)
+		return error;
+
+	error = regmap_update_bits(regmap, CS40L26_VBST_CTL_2, CS40L26_BST_CTL_SEL_MASK,
+					CS40L26_BST_CTL_SEL_FIXED);
+	if (error)
+		return error;
+
+	error = regmap_read(regmap, CS40L26_VBST_CTL_1, &vbst_ctl_1);
+	if (error)
+		return error;
+
+	error = regmap_update_bits(regmap, CS40L26_VBST_CTL_1, CS40L26_BST_CTL_MASK,
+					CS40L26_BST_CTL_VP);
+	if (error)
+		return error;
+
+	error = regmap_update_bits(regmap, CS40L26_GLOBAL_ENABLES, CS40L26_GLOBAL_EN_MASK, 1);
+	if (error)
+		return error;
+
+	/* Wait until boost converter is guranteed to be powered up */
+	usleep_range(CS40L26_BST_TIME_US_MIN, CS40L26_BST_TIME_US_MAX);
+
+	error = regmap_read(regmap, CS40L26_ERROR_RELEASE, &err);
+	if (error)
+		return error;
+
+	if (err & BIT(CS40L26_BST_SHORT_ERR_RLS)) {
+		dev_err(dev, "FATAL: Boost shorted at startup\n");
+		return error;
+	}
+
+	error = regmap_update_bits(regmap, CS40L26_GLOBAL_ENABLES, CS40L26_GLOBAL_EN_MASK, 0);
+	if (error)
+		return error;
+
+	error = regmap_write(regmap, CS40L26_VBST_CTL_2, vbst_ctl_2);
+	if (error)
+		return error;
+
+	return regmap_write(regmap, CS40L26_VBST_CTL_1, vbst_ctl_1);
+}
+
+static int cs40l26_part_num_resolve(struct cs40l26_private *cs40l26)
+{
+	unsigned int devid, revid;
+	int error;
+
+	error = regmap_read(cs40l26->regmap, CS40L26_DEVID, &devid);
+	if (error)
+		return error;
+	devid &= CS40L26_DEVID_MASK;
+
+	switch (devid) {
+	case CS40L26_DEVID_A:
+	case CS40L26_DEVID_B:
+	case CS40L26_DEVID_L27_A:
+	case CS40L26_DEVID_L27_B:
+		cs40l26->devid = devid;
+		break;
+	default:
+		dev_err(cs40l26->dev, "Invalid device ID: 0x%06X\n", devid);
+		return -EINVAL;
+	}
+
+	error = regmap_read(cs40l26->regmap, CS40L26_REVID, &revid);
+	if (error)
+		return error;
+	revid &= CS40L26_REVID_MASK;
+
+	if (revid == CS40L26_REVID_A1 || revid == CS40L26_REVID_B0) {
+		cs40l26->revid = revid;
+	} else {
+		dev_err(cs40l26->dev, "Invalid device revision: 0x%02X\n", revid);
+		return -EINVAL;
+	}
+
+	dev_info(cs40l26->dev, "Cirrus Logic CS40L26 ID: 0x%06X, Revision: 0x%02X\n",
+			cs40l26->devid, cs40l26->revid);
+
+	return 0;
+}
+
+static int cs40l26_parse_properties(struct cs40l26_private *cs40l26)
+{
+	int error;
+
+	error = device_property_read_u32(cs40l26->dev, "cirrus,bst-ctl-microvolt",
+						&cs40l26->vbst_uv);
+	if (error && error != -EINVAL)
+		return error;
+
+	error = device_property_read_u32(cs40l26->dev, "cirrus,bst-ipk-microamp",
+						&cs40l26->bst_ipk_ua);
+	if (error && error != -EINVAL)
+		return error;
+
+	cs40l26->exploratory_mode_enabled = !device_property_present(cs40l26->dev,
+					"cirrus,bst-exploratory-mode-disable");
+
+	return 0;
+}
+
+static int cs40l26_dsp_state_get(struct cs40l26_private *cs40l26, unsigned int *state)
+{
+	unsigned int dsp_state = CS40L26_DSP_STATE_NONE;
+	int i, error = 0;
+
+	if (cs40l26->dsp.running) {
+		for (i = 0; i < CS40L26_DSP_TIMEOUT_COUNT; i++) {
+			error = cs40l26_fw_ctl_read(&cs40l26->dsp, "PM_CUR_STATE",
+							CS40L26_PM_ALGO_ID, &dsp_state);
+
+			if (error)
+				return error;
+
+			if (dsp_state != CS40L26_DSP_STATE_NONE)
+				break;
+
+			usleep_range(CS40L26_DSP_TIMEOUT_US, CS40L26_DSP_TIMEOUT_US + 100);
+		}
+		if (i == CS40L26_DSP_TIMEOUT_COUNT) {
+			dev_err(cs40l26->dev, "Timed out reading PM_CUR_STATE\n");
+			return -ETIMEDOUT;
+		}
+	} else {
+		error = regmap_read_poll_timeout(cs40l26->regmap,
+						CS40L26_A1_PM_CUR_STATE_STATIC_REG,
+						dsp_state, dsp_state != CS40L26_DSP_STATE_NONE,
+						CS40L26_DSP_TIMEOUT_US,
+						CS40L26_DSP_TIMEOUT_US * CS40L26_DSP_TIMEOUT_COUNT);
+		if (error)
+			return error;
+	}
+
+	switch (dsp_state) {
+	case CS40L26_DSP_STATE_HIBERNATE:
+	case CS40L26_DSP_STATE_SHUTDOWN:
+	case CS40L26_DSP_STATE_STANDBY:
+	case CS40L26_DSP_STATE_ACTIVE:
+		*state = CS40L26_DSP_STATE_MASK & dsp_state;
+		break;
+	default:
+		dev_err(cs40l26->dev, "DSP state %u is invalid\n", dsp_state);
+		error = -EINVAL;
+	}
+
+	return error;
+}
+
+static bool cs40l26_dsp_can_run(struct cs40l26_private *cs40l26)
+{
+	unsigned int pm_state_locks, state;
+	int error;
+
+	error = cs40l26_dsp_state_get(cs40l26, &state);
+	if (error)
+		return false;
+
+	if (state == CS40L26_DSP_STATE_ACTIVE)
+		return true;
+
+	if (state != CS40L26_DSP_STATE_STANDBY) {
+		dev_err(cs40l26->dev, "DSP in bad state: %u\n", state);
+		return false;
+	}
+
+	if (cs40l26->dsp.running) {
+		error = cs40l26_fw_ctl_read_raw(&cs40l26->dsp, "PM_STATE_LOCKS",
+						CS40L26_PM_ALGO_ID, CS40L26_DSP_LOCK3_OFFSET /
+						sizeof(u32), sizeof(u32), &pm_state_locks);
+		if (error)
+			return false;
+	} else {
+		error = regmap_read(cs40l26->regmap, CS40L26_A1_PM_STATE_LOCKS3_STATIC_REG,
+					&pm_state_locks);
+		if (error)
+			return false;
+	}
+
+	return (pm_state_locks & CS40L26_DSP_LOCK3_MASK) == CS40L26_DSP_LOCK3_MASK;
+}
+
+static int cs40l26_mbox_buffer_read(struct cs40l26_private *cs40l26, u32 *val)
+{
+	unsigned int q_rd, q_wt, status;
+	int error;
+
+	mutex_lock(&cs40l26->dsp.pwr_lock);
+	error = cs40l26_fw_ctl_read(&cs40l26->dsp, "QUEUE_WT", CS40L26_MAILBOX_ALGO_ID, &q_wt);
+	if (error)
+		goto exit_pwr_lock;
+
+	error = cs40l26_fw_ctl_read(&cs40l26->dsp, "QUEUE_RD", CS40L26_MAILBOX_ALGO_ID, &q_rd);
+	if (error)
+		goto exit_pwr_lock;
+
+	if (q_rd - sizeof(u32) == q_wt) {
+		error = cs40l26_fw_ctl_read(&cs40l26->dsp, "MAILBOX_STATUS",
+						CS40L26_MAILBOX_ALGO_ID, &status);
+		if (error)
+			goto exit_pwr_lock;
+
+		if (status) {
+			dev_err(cs40l26->dev, "Mailbox buffer is full, info missing\n");
+			error = -ENOSPC;
+			goto exit_pwr_lock;
+		}
+	}
+
+	if (q_rd == q_wt) {
+		dev_dbg(cs40l26->dev, "Reached end of queue\n");
+		mutex_unlock(&cs40l26->dsp.pwr_lock);
+		return 1;
+	}
+
+	error = regmap_read(cs40l26->regmap, q_rd, val);
+	if (error)
+		goto exit_pwr_lock;
+
+	q_rd = (q_rd == cs40l26->mbox_q_last) ? cs40l26->mbox_q_base : q_rd + sizeof(u32);
+
+	error = cs40l26_fw_ctl_write(&cs40l26->dsp, "QUEUE_RD", CS40L26_MAILBOX_ALGO_ID, q_rd);
+
+exit_pwr_lock:
+	mutex_unlock(&cs40l26->dsp.pwr_lock);
+
+	return error;
+}
+
+static int cs40l26_handle_mbox_buffer(struct cs40l26_private *cs40l26)
+{
+	struct device *dev = cs40l26->dev;
+	unsigned int val;
+
+	while (!cs40l26_mbox_buffer_read(cs40l26, &val)) {
+		if ((val & CS40L26_DSP_MBOX_CMD_INDEX_MASK) == CS40L26_DSP_MBOX_PANIC) {
+			dev_err(dev, "DSP PANIC! Error condition: 0x%06X\n",
+					(u32)(val & CS40L26_DSP_MBOX_CMD_PAYLOAD_MASK));
+			return -ENOTRECOVERABLE;
+		}
+
+		switch (val) {
+		case CS40L26_DSP_MBOX_COMPLETE_MBOX:
+			dev_dbg(dev, "Mailbox: COMPLETE_MBOX\n");
+			complete_all(&cs40l26->erase);
+			break;
+		case CS40L26_DSP_MBOX_COMPLETE_GPIO:
+			dev_dbg(dev, "Mailbox: COMPLETE_GPIO\n");
+			break;
+		case CS40L26_DSP_MBOX_TRIGGER_CP:
+			dev_dbg(dev, "Mailbox: TRIGGER_CP\n");
+			break;
+		case CS40L26_DSP_MBOX_TRIGGER_GPIO:
+			dev_dbg(dev, "Mailbox: TRIGGER_GPIO\n");
+			break;
+		case CS40L26_DSP_MBOX_PM_AWAKE:
+			cs40l26->wksrc_sts |= CS40L26_WKSRC_STS_EN;
+			dev_dbg(dev, "Mailbox: AWAKE\n");
+			break;
+		case CS40L26_DSP_MBOX_SYS_ACK:
+			dev_err(dev, "Mailbox: ACK\n");
+			return -EPERM;
+		default:
+			dev_err(dev, "MBOX buffer value (0x%X) is invalid\n", val);
+			return -EINVAL;
+		}
+	}
+
+	return 0;
+}
+
+static int cs40l26_error_release(struct cs40l26_private *cs40l26, unsigned int err_rls)
+{
+	unsigned int err_sts, err_cfg;
+	int error;
+
+	error = regmap_read(cs40l26->regmap, CS40L26_ERROR_RELEASE, &err_sts);
+	if (error)
+		return error;
+
+	err_cfg = err_sts & ~BIT(err_rls);
+
+	error = regmap_write(cs40l26->regmap, CS40L26_ERROR_RELEASE, err_cfg);
+	if (error)
+		return error;
+
+	err_cfg |= BIT(err_rls);
+
+	error = regmap_write(cs40l26->regmap, CS40L26_ERROR_RELEASE, err_cfg);
+	if (error)
+		return error;
+
+	err_cfg &= ~BIT(err_rls);
+
+	return regmap_write(cs40l26->regmap, CS40L26_ERROR_RELEASE, err_cfg);
+}
+
+static int cs40l26_handle_irq1(struct cs40l26_private *cs40l26, unsigned int irq1)
+{
+	unsigned int err_rls = 0, last_wksrc, pwrmgt_sts;
+	struct device *dev = cs40l26->dev;
+	int error = 0;
+
+	switch (irq1) {
+	case CS40L26_IRQ1_GPIO1_RISE:
+	case CS40L26_IRQ1_GPIO1_FALL:
+		if (cs40l26->wksrc_sts & CS40L26_WKSRC_STS_EN)
+			dev_dbg(dev, "GPIO1 %s edge detected\n",
+					(irq1 != 0) ? "falling" : "rising");
+
+		cs40l26->wksrc_sts |= CS40L26_WKSRC_STS_EN;
+		break;
+	case CS40L26_IRQ1_WKSRC_STS_ANY:
+		dev_dbg(dev, "Wakesource detected (ANY)\n");
+
+		error = regmap_read(cs40l26->regmap, CS40L26_PWRMGT_STS, &pwrmgt_sts);
+		if (error)
+			goto err;
+
+		cs40l26->wksrc_sts = (u8)((pwrmgt_sts & CS40L26_WKSRC_STS_MASK) >>
+						CS40L26_WKSRC_STS_SHIFT);
+
+		mutex_lock(&cs40l26->dsp.pwr_lock);
+		error = cs40l26_fw_ctl_read(&cs40l26->dsp, "LAST_WAKESRC_CTL",
+						cs40l26->dsp.fw_id, &last_wksrc);
+		mutex_unlock(&cs40l26->dsp.pwr_lock);
+		if (error)
+			goto err;
+
+		cs40l26->last_wksrc_pol = (u8)(last_wksrc & CS40L26_WKSRC_GPIO_POL_MASK);
+		break;
+	case CS40L26_IRQ1_WKSRC_STS_GPIO1:
+		dev_dbg(dev, "GPIO1 event woke device from hibernate\n");
+
+		if (cs40l26->wksrc_sts & cs40l26->last_wksrc_pol) {
+			dev_dbg(dev, "GPIO1 falling edge detected\n");
+			cs40l26->wksrc_sts |= CS40L26_WKSRC_STS_EN;
+		} else {
+			dev_dbg(dev, "GPIO1 rising edge detected\n");
+		}
+		break;
+	case CS40L26_IRQ1_WKSRC_STS_SPI:
+		dev_dbg(dev, "SPI event woke device from hibernate\n");
+		break;
+	case CS40L26_IRQ1_WKSRC_STS_I2C:
+		dev_dbg(dev, "I2C event woke device from hibernate\n");
+		break;
+	case CS40L26_IRQ1_BST_OVP_FLAG_RISE:
+		dev_warn(dev, "BST overvoltage warning\n");
+		break;
+	case CS40L26_IRQ1_BST_OVP_FLAG_FALL:
+		dev_warn(dev, "BST voltage returned below warning threshold\n");
+		break;
+	case CS40L26_IRQ1_BST_OVP_ERR:
+		dev_err(dev, "BST overvolt. error\n");
+		err_rls = CS40L26_BST_OVP_ERR_RLS;
+		break;
+	case CS40L26_IRQ1_BST_DCM_UVP_ERR:
+		dev_err(dev, "BST undervolt. error\n");
+		err_rls = CS40L26_BST_UVP_ERR_RLS;
+		break;
+	case CS40L26_IRQ1_BST_SHORT_ERR:
+		dev_err(dev, "LBST short detected\n");
+		err_rls = CS40L26_BST_SHORT_ERR_RLS;
+		break;
+	case CS40L26_IRQ1_BST_IPK_FLAG:
+		dev_dbg(dev, "Current is being limited by LBST inductor\n");
+		break;
+	case CS40L26_IRQ1_TEMP_WARN_RISE:
+		dev_err(dev, "Die overtemperature warning\n");
+		err_rls = CS40L26_TEMP_WARN_ERR_RLS;
+		break;
+	case CS40L26_IRQ1_TEMP_WARN_FALL:
+		dev_warn(dev, "Die temperature returned below threshold\n");
+		break;
+	case CS40L26_IRQ1_TEMP_ERR:
+		dev_err(dev, "Die overtemperature error\n");
+		err_rls = CS40L26_TEMP_ERR_RLS;
+		break;
+	case CS40L26_IRQ1_AMP_ERR:
+		dev_err(dev, "AMP short detected\n");
+		err_rls = CS40L26_AMP_SHORT_ERR_RLS;
+		break;
+	case CS40L26_IRQ1_VIRTUAL2_MBOX_WR:
+		error = regmap_write(cs40l26->regmap, CS40L26_IRQ1_EINT_1, BIT(irq1));
+		if (error)
+			return error;
+
+		return cs40l26_handle_mbox_buffer(cs40l26);
+	default:
+		return 0;
+	}
+
+	if (err_rls)
+		error = cs40l26_error_release(cs40l26, err_rls);
+
+err:
+	regmap_write(cs40l26->regmap, CS40L26_IRQ1_EINT_1, BIT(irq1));
+
+	return error;
+}
+
+static int cs40l26_handle_irq2(struct cs40l26_private *cs40l26, unsigned int irq2)
+{
+	struct device *dev = cs40l26->dev;
+
+	switch (irq2) {
+	case CS40L26_IRQ2_PLL_LOCK:
+		dev_dbg(dev, "PLL achieved lock\n");
+		break;
+	case CS40L26_IRQ2_PLL_READY:
+		dev_dbg(dev, "PLL ready\n");
+		break;
+	default:
+		return 0;
+	}
+
+	return regmap_write(cs40l26->regmap, CS40L26_IRQ1_EINT_2, BIT(irq2));
+}
+
+static irqreturn_t cs40l26_irq(int irq, void *data)
+{
+	struct cs40l26_private *cs40l26 = (struct cs40l26_private *)data;
+	struct regmap *regmap = cs40l26->regmap;
+	struct device *dev = cs40l26->dev;
+	unsigned int eint, sts;
+	unsigned long eint_l;
+	int i, error;
+
+	if (cs40l26_pm_enter(dev)) {
+		dev_err(dev, "Interrupts missed\n");
+		return IRQ_NONE;
+	}
+
+	mutex_lock(&cs40l26->lock);
+
+	if (regmap_read(regmap, CS40L26_IRQ1_STATUS, &sts)) {
+		dev_err(dev, "Failed to read IRQ1 Status\n");
+		error = IRQ_NONE;
+		goto err;
+	}
+
+	if (sts != CS40L26_IRQ_STATUS_ASSERT) {
+		dev_err(dev, "IRQ1 asserted with no pending interrupts\n");
+		error = IRQ_NONE;
+		goto err;
+	}
+
+	error = regmap_read(regmap, CS40L26_IRQ1_EINT_1, &eint);
+	if (error)
+		goto err;
+	eint_l = (unsigned long)eint;
+
+	for_each_set_bit(i, &eint_l, CS40L26_IRQ1_NUM_IRQS) {
+		error = cs40l26_handle_irq1(cs40l26, i);
+		if (error)
+			goto err;
+	}
+
+	error = regmap_read(regmap, CS40L26_IRQ1_EINT_2, &eint);
+	if (error)
+		goto err;
+	eint_l = (unsigned long)eint;
+
+	for_each_set_bit(i, &eint_l, CS40L26_IRQ2_NUM_IRQS) {
+		error = cs40l26_handle_irq2(cs40l26, i);
+		if (error)
+			goto err;
+	}
+
+err:
+	mutex_unlock(&cs40l26->lock);
+
+	cs40l26_pm_exit(dev);
+
+	if (error)
+		dev_err(dev, "Failed to process IRQ (%d): %d\n", irq, error);
+
+	return IRQ_HANDLED;
+}
+
+static int __cs40l26_prevent_hiber(struct cs40l26_private *cs40l26)
+{
+
+	int i, error;
+
+	for (i = 0; i < CS40L26_DSP_TIMEOUT_COUNT; i++) {
+		error = cs40l26_mailbox_write(cs40l26, CS40L26_DSP_MBOX_CMD_PREVENT_HIBER);
+		if (error)
+			return error;
+
+		usleep_range(CS40L26_DSP_TIMEOUT_US, CS40L26_DSP_TIMEOUT_US + 100);
+
+		if (cs40l26_dsp_can_run(cs40l26))
+			break;
+	}
+
+	if (i == CS40L26_DSP_TIMEOUT_COUNT) {
+		dev_err(cs40l26->dev, "Failed to prevent hibernation\n");
+		return -ETIMEDOUT;
+	}
+
+	return 0;
+}
+
+static int cs40l26_prevent_hiber(struct cs40l26_private *cs40l26)
+{
+	int error;
+
+	mutex_lock(&cs40l26->dsp.pwr_lock);
+
+	error = __cs40l26_prevent_hiber(cs40l26);
+
+	mutex_unlock(&cs40l26->dsp.pwr_lock);
+
+	return error;
+}
+
+static int cs40l26_allow_hiber(struct cs40l26_private *cs40l26)
+{
+	cs40l26->wksrc_sts = 0x00;
+
+	/* Don't perform mailbox write since reading for acknowledgment will wake the device */
+	return regmap_write(cs40l26->regmap, CS40L26_DSP_VIRTUAL1_MBOX_1,
+				   CS40L26_DSP_MBOX_CMD_ALLOW_HIBER);
+}
+
+static int cs40l26_dsp_pre_config(struct cs40l26_private *cs40l26)
+{
+	unsigned int dsp_state, halo_state, timeout_ms;
+	int error, i;
+
+	error = regmap_read(cs40l26->regmap, CS40L26_A1_DSP_HALO_STATE_REG, &halo_state);
+	if (error)
+		return error;
+
+	if (halo_state != CS40L26_DSP_HALO_STATE_RUN) {
+		dev_err(cs40l26->dev, "DSP not Ready: HALO_STATE: %u\n", halo_state);
+		return -EINVAL;
+	}
+
+	error = cs40l26_pm_timeout_ms_get(cs40l26, CS40L26_DSP_STATE_ACTIVE, &timeout_ms);
+	if (error) {
+		dev_err(cs40l26->dev, "Failed to get active->standby timeout: %d\n", error);
+		return error;
+	}
+
+	for (i = 0; i < CS40L26_DSP_STATE_TIMEOUT_COUNT; i++) {
+		error = cs40l26_dsp_state_get(cs40l26, &dsp_state);
+		if (error)
+			return error;
+
+		if (dsp_state != CS40L26_DSP_STATE_SHUTDOWN &&
+				dsp_state != CS40L26_DSP_STATE_STANDBY)
+			dev_warn(cs40l26->dev, "DSP core not safe to kill\n");
+		else
+			break;
+
+		usleep_range(timeout_ms * 1000, (timeout_ms * 1000) + 100);
+	}
+	if (i == CS40L26_DSP_STATE_TIMEOUT_COUNT) {
+		dev_err(cs40l26->dev, "DSP Core could not be shut down\n");
+		return -ETIMEDOUT;
+	}
+
+	return regmap_write(cs40l26->regmap, CS40L26_DSP1_CCM_CORE_CONTROL,
+				CS40L26_DSP_CCM_CORE_KILL);
+}
+
+static const struct reg_sequence cs40l26_a1_errata[] = {
+	{ CS40L26_PLL_REFCLK_DETECT_0, 0x00000000 },
+	{ CS40L26_TEST_KEY_CTRL, 0x00000055 },
+	{ CS40L26_TEST_KEY_CTRL, 0x000000AA },
+	{ CS40L26_TEST_LBST, CS40L26_DISABLE_EXPLORATORY_MODE },
+};
+
+static int cs40l26_handle_errata(struct cs40l26_private *cs40l26)
+{
+	int num_writes = 1, error;
+
+	if (!cs40l26->exploratory_mode_enabled) {
+		error = cs40l26_lbst_short_test(cs40l26);
+		if (error)
+			return error;
+
+		num_writes = ARRAY_SIZE(cs40l26_a1_errata);
+	}
+
+	return cs40l26_pseq_multi_write(cs40l26, cs40l26_a1_errata, num_writes,
+					false, CS40L26_PSEQ_OP_WRITE_FULL);
+}
+
+static int cs40l26_cs_dsp_pre_run(struct cs_dsp *dsp)
+{
+	struct cs40l26_private *cs40l26 = container_of(dsp, struct cs40l26_private, dsp);
+	int error;
+
+	error = cs40l26_pm_timeout_ms_set(cs40l26, CS40L26_DSP_STATE_STANDBY,
+						CS40L26_PM_STDBY_TIMEOUT_MS_DEFAULT);
+	if (error) {
+		dev_err(cs40l26->dev, "Failed to set standby->hibernate timeout: %d\n", error);
+		return error;
+	}
+
+	error = cs40l26_pm_timeout_ms_set(cs40l26, CS40L26_DSP_STATE_ACTIVE,
+						CS40L26_PM_ACTIVE_TIMEOUT_MS_DEFAULT);
+	if (error) {
+		dev_err(cs40l26->dev, "Failed to set active->standby timeout: %d\n", error);
+		return error;
+	}
+
+	error = regmap_update_bits(cs40l26->regmap, CS40L26_PWRMGT_CTL, CS40L26_MEM_RDY_MASK,
+					1 << CS40L26_MEM_RDY_SHIFT);
+	if (error)
+		return error;
+
+	error = cs40l26_fw_ctl_read(dsp, "QUEUE_BASE", CS40L26_MAILBOX_ALGO_ID,
+					&cs40l26->mbox_q_base);
+	if (error)
+		return error;
+
+	error = cs40l26_fw_ctl_read(dsp, "QUEUE_LEN", CS40L26_MAILBOX_ALGO_ID,
+					&cs40l26->mbox_q_len);
+	if (error)
+		return error;
+
+	cs40l26->mbox_q_last = cs40l26->mbox_q_base + ((cs40l26->mbox_q_len - 1) * sizeof(u32));
+
+	error = cs40l26_fw_ctl_write(dsp, "CALL_RAM_INIT", dsp->fw_id, 1);
+	if (error)
+		return error;
+
+	error = cs40l26_pseq_init(cs40l26);
+	if (error)
+		return error;
+
+	return cs40l26_handle_errata(cs40l26);
+}
+
+static int cs40l26_cs_dsp_post_run(struct cs_dsp *dsp)
+{
+	struct cs40l26_private *cs40l26 = container_of(dsp, struct cs40l26_private, dsp);
+	unsigned int halo_state, nwaves;
+	int error;
+
+	/*
+	 * cs_dsp_halo_start_core() resets the DSP core.
+	 * Therefore, hibernation must be prevented again
+	 */
+	error = __cs40l26_prevent_hiber(cs40l26);
+	if (error)
+		return error;
+
+	error = cs40l26_fw_ctl_read(&cs40l26->dsp, "HALO_STATE", dsp->fw_id, &halo_state);
+	if (error)
+		return error;
+
+	if (halo_state != CS40L26_DSP_HALO_STATE_RUN) {
+		dev_err(dsp->dev, "Firmware in unexpected state: %u\n", halo_state);
+		return -EINVAL;
+	}
+
+	error = cs40l26_hw_init(cs40l26);
+	if (error)
+		return error;
+
+	error = cs40l26_fw_ctl_write(&cs40l26->dsp, "TIMEOUT_MS", CS40L26_VIBEGEN_ALGO_ID, 0);
+	if (error)
+		return error;
+
+	error = cs40l26_num_waves_get(cs40l26, &nwaves);
+	if (error)
+		return error;
+
+	dev_info(dsp->dev, "%s loaded with %u RAM waveforms\n", "CS40L26", nwaves);
+
+	return 0;
+}
+
+static const struct cs_dsp_client_ops cs40l26_cs_dsp_client_ops = {
+	.pre_run		= cs40l26_cs_dsp_pre_run,
+	.post_run		= cs40l26_cs_dsp_post_run,
+};
+
+static int cs40l26_cs_dsp_init(struct cs40l26_private *cs40l26)
+{
+	int error;
+
+	cs40l26->dsp.num = 1;
+	cs40l26->dsp.type = WMFW_HALO;
+	cs40l26->dsp.dev = cs40l26->dev;
+	cs40l26->dsp.regmap = cs40l26->regmap;
+	cs40l26->dsp.base = CS40L26_DSP_CTRL_BASE;
+	cs40l26->dsp.base_sysinfo = CS40L26_DSP1_SYS_INFO_ID;
+	cs40l26->dsp.mem = cs40l26_dsp_regions;
+	cs40l26->dsp.num_mems = CS40L26_DSP_NUM_REGIONS;
+	cs40l26->dsp.lock_regions = 0xFFFFFFFF;
+	cs40l26->dsp.client_ops = &cs40l26_cs_dsp_client_ops;
+
+	error = cs_dsp_halo_init(&cs40l26->dsp);
+	if (error) {
+		dev_err(cs40l26->dev, "Failed to initialize HALO core\n");
+		return error;
+	}
+
+	cs40l26->dsp_initialized = true;
+
+	return 0;
+}
+
+static void cs40l26_dsp_start(struct cs40l26_private *cs40l26)
+{
+	struct device *dev = cs40l26->dev;
+
+	if (cs40l26_dsp_pre_config(cs40l26))
+		goto err_rls_fw;
+
+	mutex_lock(&cs40l26->lock);
+
+	if (cs_dsp_power_up(&cs40l26->dsp, cs40l26->wmfw, "cs40l26.wmfw",
+				cs40l26->bin, "cs40l26.bin", "cs40l26"))
+		goto err_mutex;
+
+	if (cs40l26->dsp.fw_id != CS40L26_FW_ID) {
+		dev_err(dev, "Invalid firmware ID: 0x%X\n", cs40l26->dsp.fw_id);
+		goto err_mutex;
+	}
+
+	if (cs40l26->dsp.fw_id_version < CS40L26_FW_ID_VERSION_MIN) {
+		dev_err(dev, "Invalid firmware version: 0x%X\n", cs40l26->dsp.fw_id_version);
+		goto err_mutex;
+	}
+
+	if (cs_dsp_run(&cs40l26->dsp))
+		dev_err(dev, "Failed to run DSP\n");
+
+err_mutex:
+	mutex_unlock(&cs40l26->lock);
+
+err_rls_fw:
+	release_firmware(cs40l26->bin);
+	release_firmware(cs40l26->wmfw);
+
+	cs40l26_pm_runtime_setup(cs40l26);
+}
+
+static void cs40l26_coeff_upload(const struct firmware *bin, void *context)
+{
+	struct cs40l26_private *cs40l26 = (struct cs40l26_private *)context;
+
+	if (!bin) {
+		dev_err(cs40l26->dev, "Failed to request coefficient file\n");
+		return;
+	}
+
+	cs40l26->bin = bin;
+
+	cs40l26_dsp_start(cs40l26);
+}
+
+static void cs40l26_fw_upload(const struct firmware *wmfw, void *context)
+{
+	struct cs40l26_private *cs40l26 = (struct cs40l26_private *)context;
+
+	if (!wmfw) {
+		dev_err(cs40l26->dev, "Failed to request firmware file\n");
+		return;
+	}
+
+	if (cs40l26_cs_dsp_init(cs40l26)) {
+		release_firmware(wmfw);
+		return;
+	}
+
+	cs40l26->wmfw = wmfw;
+
+	request_firmware_nowait(THIS_MODULE, FW_ACTION_UEVENT,
+				"cs40l26.bin", cs40l26->dev, GFP_KERNEL,
+				cs40l26, cs40l26_coeff_upload);
+}
+
+static inline int cs40l26_worker_init(struct cs40l26_private *cs40l26)
+{
+	cs40l26->vibe_workqueue =
+		alloc_ordered_workqueue("cs40l26_workqueue", WQ_HIGHPRI);
+	if (IS_ERR_OR_NULL(cs40l26->vibe_workqueue)) {
+		dev_err(cs40l26->dev, "Failed to allocate workqueue\n");
+		return -ENOMEM;
+	}
+
+	INIT_WORK(&cs40l26->erase_work, cs40l26_erase_worker);
+	INIT_WORK(&cs40l26->set_gain_work, cs40l26_set_gain_worker);
+	INIT_WORK(&cs40l26->upload_work, cs40l26_upload_worker);
+	INIT_WORK(&cs40l26->vibe_start_work, cs40l26_vibe_start_worker);
+	INIT_WORK(&cs40l26->vibe_stop_work, cs40l26_vibe_stop_worker);
+
+	return 0;
+}
+
+static struct regulator_bulk_data cs40l26_supplies[] = {
+	{ .supply = "VP" },
+	{ .supply = "VA" },
+};
+
+static int cs40l26_device_init(struct cs40l26_private *cs40l26)
+{
+	struct device *dev = cs40l26->dev;
+	int error;
+
+	error = devm_regulator_bulk_get(dev, CS40L26_NUM_SUPPLIES,
+					cs40l26_supplies);
+	if (error) {
+		dev_err(dev, "Failed to request core supplies: %d\n", error);
+		return error;
+	}
+
+	error = cs40l26_parse_properties(cs40l26);
+	if (error)
+		return error;
+
+	error = regulator_bulk_enable(CS40L26_NUM_SUPPLIES, cs40l26_supplies);
+	if (error) {
+		dev_err(dev, "Failed to enable core supplies: %d\n", error);
+		return error;
+	}
+
+	cs40l26->reset_gpio =
+			devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
+	if (IS_ERR_OR_NULL(cs40l26->reset_gpio)) {
+		dev_err(dev, "Failed to get reset GPIO: %d\n",
+			(int)PTR_ERR(cs40l26->reset_gpio));
+		error = -ENOENT;
+		return error;
+	}
+
+	usleep_range(CS40L26_MIN_RESET_PULSE_WIDTH_US,
+		     CS40L26_MIN_RESET_PULSE_WIDTH_US + 100);
+
+	gpiod_set_value_cansleep(cs40l26->reset_gpio, 0);
+
+	usleep_range(CS40L26_CP_READY_DELAY_US,
+		     CS40L26_CP_READY_DELAY_US + 100);
+
+	mutex_init(&cs40l26->lock);
+
+	error = cs40l26_worker_init(cs40l26);
+	if (error) {
+		dev_err(dev, "Failed to initialize worker threads\n");
+		return error;
+	}
+
+	/*
+	 * Initialize completion but immediately complete since no effects are
+	 * active at this point. This avoids having to determine if
+	 * init_completion() or reinit_completion() is needed at the time of
+	 * an incoming trigger.
+	 */
+	init_completion(&cs40l26->erase);
+	complete_all(&cs40l26->erase);
+
+	error = cs40l26_part_num_resolve(cs40l26);
+	if (error)
+		return error;
+
+	/*
+	 * The DSP may lock up if a haptic effect is triggered via GPI
+	 * event or control port and the PLL is set to closed-loop.
+	 *
+	 * Set the PLL to open-loop and remove default GPI mappings
+	 * to prevent this while the driver is loading and configuring
+	 * RAM firmware.
+	 *
+	 * The firmware will set the PLL back to closed-loop when it is loaded
+	 * and the DSP has been started.
+	 */
+	error = regmap_update_bits(cs40l26->regmap, CS40L26_REFCLK_INPUT,
+				   CS40L26_PLL_REFCLK_LOOP_MASK,
+				   1 << CS40L26_PLL_REFCLK_LOOP_SHIFT);
+	if (error)
+		return error;
+
+	error = regmap_read(cs40l26->regmap, CS40L26_A1_EVENT_MAP_1,
+			    &cs40l26->gpio_press_default);
+	if (error)
+		return error;
+
+	error = regmap_read(cs40l26->regmap, CS40L26_A1_EVENT_MAP_2,
+			    &cs40l26->gpio_release_default);
+	if (error)
+		return error;
+
+	error = cs40l26_erase_gpio_mapping(cs40l26, CS40L26_GPIO_MAP_A_PRESS);
+	if (error)
+		return error;
+
+	error = cs40l26_erase_gpio_mapping(cs40l26, CS40L26_GPIO_MAP_A_RELEASE);
+	if (error)
+		return error;
+
+	/* Set LRA to HI-Z in order to avoid fault conditions */
+	return regmap_update_bits(cs40l26->regmap, CS40L26_TST_DAC_MSM_CONFIG,
+				   CS40L26_SPK_DEFAULT_HIZ_MASK,
+				   1 << CS40L26_SPK_DEFAULT_HIZ_SHIFT);
+}
+
+int cs40l26_probe(struct cs40l26_private *cs40l26)
+{
+	struct device *dev = cs40l26->dev;
+	int error;
+
+	error = cs40l26_device_init(cs40l26);
+		if (error)
+			goto err;
+
+	error = __cs40l26_prevent_hiber(cs40l26);
+	if (error)
+		goto err;
+
+	error = request_firmware_nowait(THIS_MODULE, FW_ACTION_UEVENT,
+					"cs40l26.wmfw", dev, GFP_KERNEL,
+					cs40l26, cs40l26_fw_upload);
+	if (error) {
+		dev_err(dev, "Failed to load firmware: %d\n", error);
+		goto err;
+	}
+
+	error = devm_request_threaded_irq(dev, cs40l26->irq, NULL, cs40l26_irq,
+					IRQF_ONESHOT | IRQF_SHARED, "cs40l26",
+					cs40l26);
+	if (error) {
+		dev_err(dev, "Failed to request threaded IRQ\n");
+		goto err;
+	}
+
+	error = cs40l26_input_init(cs40l26);
+	if (error)
+		goto err;
+
+	return 0;
+err:
+	cs40l26_remove(cs40l26);
+
+	return error;
+}
+EXPORT_SYMBOL_GPL(cs40l26_probe);
+
+int cs40l26_remove(struct cs40l26_private *cs40l26)
+{
+	struct regulator *vp_consumer = cs40l26_supplies[CS40L26_VP_SUPPLY].consumer;
+	struct regulator *va_consumer = cs40l26_supplies[CS40L26_VA_SUPPLY].consumer;
+
+	disable_irq(cs40l26->irq);
+
+	cs40l26_pm_runtime_teardown(cs40l26);
+
+	if (cs40l26->dsp_initialized) {
+		if (cs40l26->dsp.running)
+			cs_dsp_stop(&cs40l26->dsp);
+		if (cs40l26->dsp.booted)
+			cs_dsp_power_down(&cs40l26->dsp);
+		if (&cs40l26->dsp)
+			cs_dsp_remove(&cs40l26->dsp);
+	}
+
+	if (cs40l26->vibe_workqueue) {
+		cancel_work_sync(&cs40l26->erase_work);
+		cancel_work_sync(&cs40l26->set_gain_work);
+		cancel_work_sync(&cs40l26->upload_work);
+		cancel_work_sync(&cs40l26->vibe_start_work);
+		cancel_work_sync(&cs40l26->vibe_stop_work);
+		destroy_workqueue(cs40l26->vibe_workqueue);
+	}
+
+	if (!IS_ERR_OR_NULL(cs40l26->reset_gpio))
+		gpiod_set_value_cansleep(cs40l26->reset_gpio, 1);
+
+	if (va_consumer)
+		regulator_disable(va_consumer);
+
+	if (vp_consumer)
+		regulator_disable(vp_consumer);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(cs40l26_remove);
+
+static int __maybe_unused cs40l26_suspend(struct device *dev)
+{
+	struct cs40l26_private *cs40l26 = dev_get_drvdata(dev);
+	int error;
+
+	mutex_lock(&cs40l26->lock);
+	dev_dbg(dev, "%s: Enabling hibernation\n", __func__);
+
+	error = cs40l26_allow_hiber(cs40l26);
+
+	mutex_unlock(&cs40l26->lock);
+
+	return error;
+}
+
+static int __maybe_unused cs40l26_sys_suspend(struct device *dev)
+{
+	struct i2c_client *i2c_client = to_i2c_client(dev);
+
+	dev_dbg(dev, "System suspend, disabling IRQ\n");
+
+	disable_irq(i2c_client->irq);
+
+	return 0;
+}
+
+static int __maybe_unused cs40l26_sys_suspend_noirq(struct device *dev)
+{
+	struct i2c_client *i2c_client = to_i2c_client(dev);
+
+	dev_dbg(dev, "Late system suspend, re-enabling IRQ\n");
+	enable_irq(i2c_client->irq);
+
+	return 0;
+}
+
+static int __maybe_unused cs40l26_resume(struct device *dev)
+{
+	dev_dbg(dev, "%s: Disabling hibernation\n", __func__);
+
+	return cs40l26_prevent_hiber(dev_get_drvdata(dev));
+}
+
+static int __maybe_unused cs40l26_sys_resume(struct device *dev)
+{
+	struct i2c_client *i2c_client = to_i2c_client(dev);
+
+	dev_dbg(dev, "System resume, re-enabling IRQ\n");
+
+	enable_irq(i2c_client->irq);
+
+	return 0;
+}
+
+static int __maybe_unused cs40l26_sys_resume_noirq(struct device *dev)
+{
+	struct i2c_client *i2c_client = to_i2c_client(dev);
+
+	dev_dbg(dev, "Early system resume, disabling IRQ\n");
+
+	disable_irq(i2c_client->irq);
+
+	return 0;
+}
+
+const struct dev_pm_ops cs40l26_pm_ops = {
+	SET_RUNTIME_PM_OPS(cs40l26_suspend, cs40l26_resume, NULL)
+	SET_SYSTEM_SLEEP_PM_OPS(cs40l26_sys_suspend, cs40l26_sys_resume)
+	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(cs40l26_sys_suspend_noirq, cs40l26_sys_resume_noirq)
+};
+EXPORT_SYMBOL_GPL(cs40l26_pm_ops);
+
+MODULE_DESCRIPTION("CS40L26 Boosted Class D Amplifier for Haptics");
+MODULE_AUTHOR("Fred Treven, Cirrus Logic Inc. <fred.treven@cirrus.com>");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/input/cs40l26.h b/include/linux/input/cs40l26.h
new file mode 100644
index 000000000000..bc0acec9cf23
--- /dev/null
+++ b/include/linux/input/cs40l26.h
@@ -0,0 +1,486 @@
+/* SPDX-License-Identifier: GPL-2.0
+ *
+ * CS40L26 Boosted Haptic Driver with Integrated DSP and
+ * Waveform Memory with Advanced Closed Loop Algorithms and LRA protection
+ *
+ * Copyright 2023 Cirrus Logic, Inc.
+ *
+ * Author: Fred Treven <fred.treven@cirrus.com>
+ */
+
+#ifndef __CS40L26_H__
+#define __CS40L26_H__
+
+#include <linux/bitops.h>
+#include <linux/completion.h>
+#include <linux/gpio/consumer.h>
+#include <linux/input.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/firmware/cirrus/cs_dsp.h>
+#include <linux/firmware/cirrus/wmfw.h>
+
+#define CS40L26_FIRSTREG				0x0
+#define CS40L26_LASTREG					0x3C7DFE8
+
+#define CS40L26_DEVID					0x0
+#define CS40L26_REVID					0x4
+#define CS40L26_TEST_KEY_CTRL				0x40
+#define CS40L26_GLOBAL_ENABLES				0x2014
+#define CS40L26_ERROR_RELEASE				0x2034
+#define CS40L26_PWRMGT_CTL				0x2900
+#define CS40L26_PWRMGT_STS				0x290C
+#define CS40L26_REFCLK_INPUT				0x2C04
+#define CS40L26_PLL_REFCLK_DETECT_0			0x2C28
+#define CS40L26_VBST_CTL_1				0x3800
+#define CS40L26_VBST_CTL_2				0x3804
+#define CS40L26_BST_IPK_CTL				0x3808
+#define CS40L26_TEST_LBST				0x391C
+#define CS40L26_NGATE1_INPUT				0x4C60
+#define CS40L26_DAC_MSM_CONFIG				0x7400
+#define CS40L26_TST_DAC_MSM_CONFIG			0x7404
+#define CS40L26_IRQ1_STATUS				0x10004
+#define CS40L26_IRQ1_EINT_1				0x10010
+#define CS40L26_IRQ1_EINT_2				0x10014
+#define CS40L26_IRQ1_EINT_3				0x10018
+#define CS40L26_IRQ1_EINT_4				0x1001C
+#define CS40L26_IRQ1_EINT_5				0x10020
+#define CS40L26_IRQ1_STS_1				0x10090
+#define CS40L26_IRQ1_STS_2				0x10094
+#define CS40L26_IRQ1_STS_3				0x10098
+#define CS40L26_IRQ1_STS_4				0x1009C
+#define CS40L26_IRQ1_STS_5				0x100A0
+#define CS40L26_IRQ1_MASK_1				0x10110
+#define CS40L26_IRQ1_MASK_2				0x10114
+#define CS40L26_IRQ1_MASK_3				0x10118
+#define CS40L26_IRQ1_MASK_4				0x1011C
+#define CS40L26_IRQ1_MASK_5				0x10120
+#define CS40L26_MIXER_NGATE_CH1_CFG			0x12004
+#define CS40L26_DSP_MBOX_1				0x13000
+#define CS40L26_DSP_MBOX_2				0x13004
+#define CS40L26_DSP_MBOX_3				0x13008
+#define CS40L26_DSP_MBOX_4				0x1300C
+#define CS40L26_DSP_MBOX_5				0x13010
+#define CS40L26_DSP_MBOX_6				0x13014
+#define CS40L26_DSP_MBOX_7				0x13018
+#define CS40L26_DSP_MBOX_8				0x1301C
+#define CS40L26_DSP_VIRTUAL1_MBOX_1			0x13020
+#define CS40L26_DSP_VIRTUAL1_MBOX_2			0x13024
+#define CS40L26_DSP_VIRTUAL1_MBOX_3			0x13028
+#define CS40L26_DSP_VIRTUAL1_MBOX_4			0x1302C
+#define CS40L26_DSP_VIRTUAL1_MBOX_5			0x13030
+#define CS40L26_DSP_VIRTUAL1_MBOX_6			0x13034
+#define CS40L26_DSP_VIRTUAL1_MBOX_7			0x13038
+#define CS40L26_DSP_VIRTUAL1_MBOX_8			0x1303C
+#define CS40L26_DSP_VIRTUAL2_MBOX_1			0x13040
+#define CS40L26_DSP_VIRTUAL2_MBOX_2			0x13044
+#define CS40L26_DSP_VIRTUAL2_MBOX_3			0x13048
+#define CS40L26_DSP_VIRTUAL2_MBOX_4			0x1304C
+#define CS40L26_DSP_VIRTUAL2_MBOX_5			0x13050
+#define CS40L26_DSP_VIRTUAL2_MBOX_6			0x13054
+#define CS40L26_DSP_VIRTUAL2_MBOX_7			0x13058
+#define CS40L26_DSP_VIRTUAL2_MBOX_8			0x1305C
+#define CS40L26_OTP_MEM0				0x30000
+#define CS40L26_OTP_MEM31				0x3007C
+#define CS40L26_DSP1_XMEM_PACKED_0			0x2000000
+#define CS40L26_DSP1_XMEM_PACKED_6143			0x2005FFC
+#define CS40L26_DSP1_XROM_PACKED_0			0x2006000
+#define CS40L26_DSP1_XROM_PACKED_4604			0x200A7F0
+#define CS40L26_DSP1_XMEM_UNPACKED32_0			0x2400000
+#define CS40L26_DSP1_XMEM_UNPACKED32_4095		0x2403FFC
+#define CS40L26_DSP1_XROM_UNPACKED32_0			0x2404000
+#define CS40L26_DSP1_XROM_UNPACKED32_3070		0x2406FF8
+#define CS40L26_DSP1_SYS_INFO_ID			0x25E0000
+#define CS40L26_DSP1_XMEM_UNPACKED24_0			0x2800000
+#define CS40L26_DSP1_XMEM_UNPACKED24_8191		0x2807FFC
+#define CS40L26_DSP1_XROM_UNPACKED24_0			0x2808000
+#define CS40L26_DSP1_XROM_UNPACKED24_6141		0x280DFF4
+#define CS40L26_DSP1_SCRATCH1				0x2B805C0
+#define CS40L26_DSP1_SCRATCH2				0x2B805C8
+#define CS40L26_DSP1_SCRATCH3				0x2B805D0
+#define CS40L26_DSP1_SCRATCH4				0x2B805D8
+#define CS40L26_DSP1_CCM_CORE_CONTROL			0x2BC1000
+#define CS40L26_DSP1_YMEM_PACKED_0			0x2C00000
+#define CS40L26_DSP1_YMEM_PACKED_1532			0x2C017F0
+#define CS40L26_DSP1_YMEM_UNPACKED32_0			0x3000000
+#define CS40L26_DSP1_YMEM_UNPACKED32_1022		0x3000FF8
+#define CS40L26_DSP1_YMEM_UNPACKED24_0			0x3400000
+#define CS40L26_DSP1_YMEM_UNPACKED24_2045		0x3401FF4
+#define CS40L26_DSP1_PMEM_0				0x3800000
+#define CS40L26_DSP1_PMEM_5114				0x3804FE8
+#define CS40L26_DSP1_PROM_0				0x3C60000
+#define CS40L26_DSP1_PROM_30714				0x3C7DFE8
+
+/* Device */
+#define CS40L26_DEVID_A				0x40A260
+#define CS40L26_DEVID_B				0x40A26B
+#define CS40L26_DEVID_L27_A			0x40A270
+#define CS40L26_DEVID_L27_B			0x40A27B
+#define CS40L26_NUM_DEVS			4
+#define CS40L26_DEVID_MASK			GENMASK(23, 0)
+#define CS40L26_REVID_A1			0xA1
+#define CS40L26_REVID_B0			0xB0
+#define CS40L26_REVID_MASK			GENMASK(7, 0)
+
+#define CS40L26_MIN_RESET_PULSE_WIDTH_US	1500
+#define CS40L26_CP_READY_DELAY_US		6000
+
+#define CS40L26_DATA_SRC_DSP1TX4		0x35
+#define CS40L26_MIXER_NGATE_CH1_CFG_DEFAULT	0x00010003
+#define CS40L26_TST_DAC_MSM_CFG_DFLT_CHG_VAL_H16 0x1133
+
+#define CS40L26_SPK_DEFAULT_HIZ_MASK		BIT(28)
+#define CS40L26_SPK_DEFAULT_HIZ_SHIFT		28
+
+#define CS40L26_DSP_CCM_CORE_KILL		0x00000080
+#define CS40L26_DSP_CCM_CORE_RESET		0x00000281
+
+#define CS40L26_MEM_RDY_MASK			BIT(1)
+#define CS40L26_MEM_RDY_SHIFT			1
+
+/* Errata */
+#define CS40L26_DISABLE_EXPLORATORY_MODE	0x0100C080
+
+/* Boost Converter Control */
+#define CS40L26_GLOBAL_EN_MASK			BIT(0)
+
+#define CS40L26_BST_IPK_UA_MAX			4800000
+#define CS40L26_BST_IPK_UA_MIN			1600000
+#define CS40L26_BST_IPK_UA_STEP			50000
+#define CS40L26_BST_IPK_DEFAULT			0x4A
+
+#define CS40L26_BST_UV_MIN			2500000
+#define CS40L26_BST_UV_MAX			11000000
+#define CS40L26_BST_UV_STEP			50000
+#define CS40L26_BST_DEFAULT			0xAA
+
+#define CS40L26_BST_CTL_VP			0x00
+#define CS40L26_BST_CTL_MASK			GENMASK(7, 0)
+#define CS40L26_BST_CTL_SEL_MASK		GENMASK(1, 0)
+#define CS40L26_BST_CTL_SEL_FIXED		0x0
+#define CS40L26_BST_CTL_LIM_EN_MASK		BIT(2)
+#define CS40L26_BST_CTL_LIM_EN_SHIFT		2
+
+#define CS40L26_BST_TIME_US_MIN			10000
+#define CS40L26_BST_TIME_US_MAX			10100
+
+/* Phase Locked Loop */
+#define CS40L26_PLL_OL				1
+#define CS40L26_PLL_CL				0
+
+#define CS40L26_PLL_REFCLK_LOOP_MASK		BIT(11)
+#define CS40L26_PLL_REFCLK_LOOP_SHIFT		11
+
+/* Haptic Triggering */
+#define CS40L26_RAM_INDEX_START			0x01000000
+#define CS40L26_RAM_INDEX_END			0x0100007F
+
+#define CS40L26_ROM_INDEX_START			0x01800000
+#define CS40L26_ROM_INDEX_END			0x01800026
+
+#define CS40L26_BUZZGEN_INDEX_START		0x01800080
+#define CS40L26_BUZZGEN_INDEX_END		0x01800085
+
+#define CS40L26_BUZZGEN_NUM_CONFIGS		5
+
+#define CS40L26_BUZZGEN_PERIOD_MS_MAX		10
+#define CS40L26_BUZZGEN_PERIOD_MS_MIN		4
+
+#define CS40L26_BUZZGEN_DURATION_OFFSET		8
+#define CS40L26_BUZZGEN_DURATION_DIV_STEP	4
+
+#define CS40L26_BUZZGEN_LEVEL_MIN		0x00
+#define CS40L26_BUZZGEN_LEVEL_MAX		0xFF
+
+#define CS40L26_VIBEGEN_MAX_TIME_MS		10000
+
+#define CS40L26_NUM_ATTEN_LUT_VALUES		101
+
+/* GPIO */
+#define CS40L26_EVENT_MAP_GPI_DISABLE		0x1FF
+
+#define CS40L26_BTN_INDEX_MASK			GENMASK(7, 0)
+#define CS40L26_BTN_BUZZ_MASK			BIT(7)
+#define CS40L26_BTN_BUZZ_SHIFT			7
+#define CS40L26_BTN_BANK_MASK			BIT(8)
+#define CS40L26_BTN_BANK_SHIFT			8
+#define CS40L26_BTN_NUM_MASK			GENMASK(14, 12)
+#define CS40L26_BTN_NUM_SHIFT			12
+#define CS40L26_BTN_EDGE_MASK			BIT(15)
+#define CS40L26_BTN_EDGE_SHIFT			15
+
+/* A1 ROM Controls */
+#define CS40L26_A1_PM_CUR_STATE_STATIC_REG	0x02800370
+#define CS40L26_A1_PM_STATE_LOCKS_STATIC_REG	0x02800378
+#define CS40L26_A1_PM_STATE_LOCKS3_STATIC_REG	(CS40L26_A1_PM_STATE_LOCKS_STATIC_REG + \
+								CS40L26_DSP_LOCK3_OFFSET)
+#define	CS40L26_A1_PM_TIMEOUT_TICKS_STATIC_REG	0x02800350
+#define CS40L26_A1_PM_STDBY_TICKS_STATIC_REG	0x02800360
+#define CS40L26_A1_PM_ACTIVE_TICKS_STATIC_REG	0x02800368
+#define CS40L26_A1_DSP_HALO_STATE_REG		0x02800fa8
+#define CS40L26_A1_DSP_REQ_ACTIVE_REG		0x02800c08
+#define CS40L26_A1_EVENT_MAP_1			0x02806FC4
+#define CS40L26_A1_EVENT_MAP_2			0x02806FC8
+
+/* Interrupts */
+#define CS40L26_IRQ_STATUS_ASSERT		0x1
+
+#define CS40L26_IRQ_EINT1_ALL_MASK		0xFFDC7FFF
+#define CS40L26_IRQ_EINT2_ALL_MASK		0x07DE0400
+
+/* Firmware Handling */
+#define CS40L26_FW_ID				0x1800D4
+#define CS40L26_FW_ID_VERSION_MIN		0x070237
+
+/* Algorithms */
+#define CS40L26_BUZZGEN_ALGO_ID			0x0004F202
+#define CS40L26_EVENT_HANDLER_ALGO_ID		0x0004F200
+#define CS40L26_GPIO_ALGO_ID			0x0004F201
+#define CS40L26_MAILBOX_ALGO_ID			0x0004F203
+#define CS40L26_PM_ALGO_ID			0x0004F206
+#define CS40L26_VIBEGEN_ALGO_ID			0x000400BD
+#define CS40L26_EXT_ALGO_ID			0x0004013C
+
+/* DSP */
+#define CS40L26_DSP_STATE_HIBERNATE		0
+#define CS40L26_DSP_STATE_SHUTDOWN		1
+#define CS40L26_DSP_STATE_STANDBY		2
+#define CS40L26_DSP_STATE_ACTIVE		3
+#define CS40L26_DSP_STATE_NONE			4
+#define CS40L26_DSP_STATE_MASK			GENMASK(7, 0)
+
+#define CS40L26_DSP_LOCK3_OFFSET		8
+#define CS40L26_DSP_LOCK3_MASK			BIT(1)
+#define CS40L26_DSP_PM_ACTIVE			BIT(0)
+
+#define CS40L26_DSP_HALO_STATE_RUN		2
+
+#define CS40L26_DSP_CTRL_BASE			0x2B80000
+#define CS40L26_DSP_NUM_REGIONS			5
+
+#define CS40L26_DSP_TIMEOUT_US			1000
+#define CS40L26_DSP_TIMEOUT_COUNT		100
+#define CS40L26_PM_LOCKS_TIMEOUT_COUNT		10
+#define CS40L26_DSP_STATE_TIMEOUT_COUNT		10
+
+/* Mailbox Controls */
+#define CS40L26_DSP_MBOX_RESET			0x0
+
+#define CS40L26_DSP_MBOX_CMD_HIBER		0x02000001
+#define CS40L26_DSP_MBOX_CMD_WAKEUP		0x02000002
+#define CS40L26_DSP_MBOX_CMD_PREVENT_HIBER	0x02000003
+#define CS40L26_DSP_MBOX_CMD_ALLOW_HIBER	0x02000004
+#define CS40L26_DSP_MBOX_CMD_SHUTDOWN		0x02000005
+#define CS40L26_DSP_MBOX_PM_CMD_BASE		CS40L26_DSP_MBOX_CMD_HIBER
+
+#define CS40L26_DSP_MBOX_CMD_INDEX_MASK		GENMASK(28, 24)
+#define CS40L26_DSP_MBOX_CMD_INDEX_SHIFT	24
+#define CS40L26_DSP_MBOX_CMD_PAYLOAD_MASK	GENMASK(23, 0)
+
+#define CS40L26_DSP_MBOX_CMD_STOP_PLAYBACK	0x05000000
+
+#define CS40L26_DSP_MBOX_COMPLETE_MBOX		0x01000000
+#define CS40L26_DSP_MBOX_COMPLETE_GPIO		0x01000001
+#define CS40L26_DSP_MBOX_TRIGGER_CP		0x01000010
+#define CS40L26_DSP_MBOX_TRIGGER_GPIO		0x01000011
+#define CS40L26_DSP_MBOX_PM_AWAKE		0x02000002
+#define CS40L26_DSP_MBOX_SYS_ACK		0x0A000000
+#define CS40L26_DSP_MBOX_PANIC			0x0C000000
+
+#define CS40L26_DSP_MBOX_QUEUE_SIZE_BYTES	16
+
+/* Power Management */
+#define CS40L26_PM_STDBY_TIMEOUT_LOWER_OFFSET	16
+#define CS40L26_PM_STDBY_TIMEOUT_UPPER_OFFSET	20
+#define CS40L26_PM_STDBY_TIMEOUT_MS_DEFAULT	100
+#define CS40L26_PM_ACTIVE_TIMEOUT_LOWER_OFFSET	24
+#define CS40L26_PM_ACTIVE_TIMEOUT_UPPER_OFFSET	28
+#define CS40L26_PM_ACTIVE_TIMEOUT_MS_DEFAULT	250
+#define CS40L26_PM_TIMEOUT_TICKS_LOWER_MASK	GENMASK(23, 0)
+#define CS40L26_PM_TIMEOUT_TICKS_UPPER_MASK	GENMASK(7, 0)
+#define CS40L26_PM_TIMEOUT_TICKS_UPPER_SHIFT	24
+#define CS40L26_PM_TICKS_PER_MS			32
+
+#define CS40L26_AUTOSUSPEND_DELAY_MS		2000
+
+#define CS40L26_PSEQ_MAX_WORDS			129
+#define CS40L26_PSEQ_OP_MASK			GENMASK(23, 16)
+#define CS40L26_PSEQ_OP_SHIFT			16
+#define CS40L26_PSEQ_OP_WRITE_FULL		0x00
+#define CS40L26_PSEQ_OP_WRITE_FULL_WORDS	3
+#define CS40L26_PSEQ_OP_WRITE_ADDR8		0x02
+#define CS40L26_PSEQ_OP_WRITE_L16		0x04
+#define CS40L26_PSEQ_OP_WRITE_H16		0x05
+#define CS40L26_PSEQ_OP_WRITE_X16_WORDS		2
+#define CS40L26_PSEQ_OP_END			0xFF
+#define CS40L26_PSEQ_OP_END_WORDS		1
+#define CS40L26_PSEQ_INVALID_ADDR		0xFF000000
+#define CS40L26_PSEQ_WRITE_FULL_LOWER_ADDR_SHIFT	8
+#define CS40L26_PSEQ_WRITE_FULL_UPPER_ADDR_SHIFT	16
+#define CS40L26_PSEQ_WRITE_FULL_LOWER_ADDR_MASK	GENMASK(15, 0)
+#define CS40L26_PSEQ_WRITE_FULL_UPPER_ADDR_MASK	GENMASK(31, 0)
+#define CS40L26_PSEQ_WRITE_FULL_UPPER_DATA_SHIFT	24
+#define CS40L26_PSEQ_WRITE_FULL_LOWER_DATA_MASK	GENMASK(23, 0)
+#define CS40L26_PSEQ_WRITE_FULL_UPPER_DATA_MASK	GENMASK(31, 24)
+#define CS40L26_PSEQ_WRITE_FULL_OP_MASK		GENMASK(31, 8)
+#define CS40L26_PSEQ_WRITE_X16_LOWER_ADDR_SHIFT	16
+#define CS40L26_PSEQ_WRITE_X16_LOWER_ADDR_MASK	GENMASK(7, 0)
+#define CS40L26_PSEQ_WRITE_X16_UPPER_ADDR_SHIFT	8
+#define CS40L26_PSEQ_WRITE_X16_UPPER_ADDR_MASK	GENMASK(23, 8)
+#define CS40L26_PSEQ_WRITE_X16_UPPER_DATA_SHIFT	0
+#define CS40L26_PSEQ_WRITE_X16_UPPER_DATA_MASK	GENMASK(31, 0)
+#define CS40L26_PSEQ_WRITE_X16_OP_MASK		GENMASK(23, 16)
+
+/* Wake Sources */
+#define CS40L26_WKSRC_STS_MASK			GENMASK(9, 4)
+#define CS40L26_WKSRC_STS_SHIFT			4
+#define CS40L26_WKSRC_STS_EN			BIT(7)
+#define CS40L26_WKSRC_GPIO_POL_MASK		GENMASK(3, 0)
+
+#define CS40L26_IRQ1_WKSRC_MASK			GENMASK(14, 9)
+#define CS40L26_IRQ1_WKSRC_SHIFT		9
+#define CS40L26_IRQ1_WKSRC_GPIO_MASK		GENMASK(3, 0)
+
+/* Interrupts */
+#define CS40L26_IRQ1_GPIO1_RISE		0
+#define CS40L26_IRQ1_GPIO1_FALL		1
+#define CS40L26_IRQ1_GPIO2_RISE		2
+#define CS40L26_IRQ1_GPIO4_FALL		7
+#define CS40L26_IRQ1_WKSRC_STS_ANY	8
+#define CS40L26_IRQ1_WKSRC_STS_GPIO1	9
+#define CS40L26_IRQ1_WKSRC_STS_GPIO2	10
+#define CS40L26_IRQ1_WKSRC_STS_GPIO3	11
+#define CS40L26_IRQ1_WKSRC_STS_GPIO4	12
+#define CS40L26_IRQ1_WKSRC_STS_SPI	13
+#define CS40L26_IRQ1_WKSRC_STS_I2C	14
+#define CS40L26_IRQ1_BST_OVP_FLAG_RISE	18
+#define CS40L26_IRQ1_BST_OVP_FLAG_FALL	19
+#define CS40L26_IRQ1_BST_OVP_ERR	20
+#define CS40L26_IRQ1_BST_DCM_UVP_ERR	21
+#define CS40L26_IRQ1_BST_SHORT_ERR	22
+#define CS40L26_IRQ1_BST_IPK_FLAG	23
+#define CS40L26_IRQ1_TEMP_WARN_RISE	24
+#define CS40L26_IRQ1_TEMP_WARN_FALL	25
+#define CS40L26_IRQ1_TEMP_ERR		26
+#define CS40L26_IRQ1_AMP_ERR		27
+#define CS40L26_IRQ1_VIRTUAL2_MBOX_WR	31
+#define CS40L26_IRQ1_NUM_IRQS		32
+
+#define CS40L26_IRQ2_PLL_LOCK		0
+#define CS40L26_IRQ2_PLL_READY		5
+#define CS40L26_IRQ2_NUM_IRQS		27
+
+enum cs40l26_power_supply {
+	CS40L26_VP_SUPPLY,
+	CS40L26_VA_SUPPLY,
+	CS40L26_NUM_SUPPLIES,
+};
+
+enum cs40l26_wvfrm_bank {
+	CS40L26_WVFRM_BANK_RAM,
+	CS40L26_WVFRM_BANK_ROM,
+	CS40L26_WVFRM_BANK_OWT,
+	CS40L26_WVFRM_BANK_BUZ,
+	CS40L26_WVFRM_BANK_NUM,
+};
+
+enum cs40l26_gpio_map {
+	CS40L26_GPIO_MAP_A_PRESS,
+	CS40L26_GPIO_MAP_A_RELEASE,
+	CS40L26_GPIO_MAP_NUM_AVAILABLE,
+	CS40L26_GPIO_MAP_INVALID,
+};
+
+enum cs40l26_err_rls {
+	CS40L26_RSRVD_ERR_RLS, /* 0 */
+	CS40L26_AMP_SHORT_ERR_RLS, /* 1 */
+	CS40L26_BST_SHORT_ERR_RLS, /* 2 */
+	CS40L26_BST_OVP_ERR_RLS, /* 3 */
+	CS40L26_BST_UVP_ERR_RLS, /* 4 */
+	CS40L26_TEMP_WARN_ERR_RLS, /* 5 */
+	CS40L26_TEMP_ERR_RLS, /* 6 */
+};
+
+struct cs40l26_pseq_op {
+	u8 size;
+	u16 offset; /* offset in bytes from pseq_base */
+	u8 operation;
+	u32 words[3];
+	struct list_head list;
+};
+
+struct cs40l26_pseq_params {
+	int num_op_words;
+	unsigned int op_mask;
+	unsigned int low_addr_shift;
+	unsigned int low_addr_mask;
+	unsigned int low_data_mask;
+	unsigned int up_addr_shift;
+	unsigned int up_addr_mask;
+	unsigned int up_data_mask;
+	unsigned int up_data_shift;
+};
+
+struct cs40l26_buzzgen_config {
+	char *duration_name;
+	char *freq_name;
+	char *level_name;
+	int effect_id;
+};
+
+struct cs40l26_uploaded_effect {
+	int id;
+	u32 trigger_index;
+	u16 wvfrm_bank;
+	enum cs40l26_gpio_map mapping;
+	struct list_head list;
+};
+
+struct cs40l26_private {
+	struct device *dev;
+	struct regmap *regmap;
+	struct cs_dsp dsp;
+	int irq;
+	struct mutex lock;
+	struct gpio_desc *reset_gpio;
+	unsigned int devid;
+	u8 revid;
+	struct input_dev *input;
+	struct ff_effect *erase_effect;
+	struct ff_effect *trigger_effect;
+	struct ff_effect upload_effect;
+	s16 *raw_custom_data;
+	struct list_head effect_head;
+	struct work_struct erase_work;
+	struct work_struct set_gain_work;
+	struct work_struct upload_work;
+	struct work_struct vibe_start_work;
+	struct work_struct vibe_stop_work;
+	struct workqueue_struct *vibe_workqueue;
+	struct completion erase;
+	int erase_error;
+	int upload_error;
+	u16 gain_pct;
+	u8 wksrc_sts;
+	u8 last_wksrc_pol;
+	struct list_head pseq_op_head;
+	unsigned int gpio_press_default;
+	unsigned int gpio_release_default;
+	u32 mbox_q_base;
+	u32 mbox_q_len;
+	u32 mbox_q_last;
+	unsigned int bst_ipk_ua;
+	unsigned int vbst_uv;
+	bool exploratory_mode_enabled;
+	const struct firmware *wmfw;
+	const struct firmware *bin;
+	bool dsp_initialized;
+};
+
+int cs40l26_probe(struct cs40l26_private *cs40l26);
+int cs40l26_remove(struct cs40l26_private *cs40l26);
+
+extern const struct regmap_config cs40l26_regmap;
+extern const struct dev_pm_ops cs40l26_pm_ops;
+
+#endif /* __CS40L26_H__ */
-- 
2.7.4

