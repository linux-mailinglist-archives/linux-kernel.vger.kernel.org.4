Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBEAA6FB14C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 15:19:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234213AbjEHNTA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 09:19:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232161AbjEHNSo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 09:18:44 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 521B030AF0;
        Mon,  8 May 2023 06:18:16 -0700 (PDT)
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 348C9S7W004289;
        Mon, 8 May 2023 09:18:08 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3qf0u68anq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 May 2023 09:18:07 -0400
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 348DI6dM020971
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 8 May 2023 09:18:06 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Mon, 8 May 2023
 09:18:05 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Mon, 8 May 2023 09:18:05 -0400
Received: from IST-LT-42339.ad.analog.com ([10.158.19.231])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 348DBdTQ009014;
        Mon, 8 May 2023 09:17:55 -0400
From:   Zeynep Arslanbenzer <Zeynep.Arslanbenzer@analog.com>
To:     <lee@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <sre@kernel.org>,
        <lgirdwood@gmail.com>, <broonie@kernel.org>
CC:     <Zeynep.Arslanbenzer@analog.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        Nurettin Bolucu <Nurettin.Bolucu@analog.com>
Subject: [PATCH v3 7/7] mfd: max77658: Add ADI MAX77643/54/58/59 MFD Support
Date:   Mon, 8 May 2023 16:10:45 +0300
Message-ID: <20230508131045.9399-8-Zeynep.Arslanbenzer@analog.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230508131045.9399-1-Zeynep.Arslanbenzer@analog.com>
References: <20230508131045.9399-1-Zeynep.Arslanbenzer@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: TWN6JE6mWSojmHNnWgAOARUCMfJ_6n_8
X-Proofpoint-ORIG-GUID: TWN6JE6mWSojmHNnWgAOARUCMfJ_6n_8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-08_09,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 impostorscore=0
 suspectscore=0 malwarescore=0 phishscore=0 mlxlogscore=999
 priorityscore=1501 adultscore=0 bulkscore=0 lowpriorityscore=0
 clxscore=1015 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2305080089
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MFD driver for MAX77643/54/58/59 to enable its sub
devices.

The MAX77643 is a multi-function devices. It includes
regulator.

The MAX77654 is a multi-function devices. It includes
regulator and charger.

The MAX77658 is a multi-function devices. It includes
regulator, charger and battery.

The MAX77659 is a multi-function devices. It includes
regulator and charger.

Signed-off-by: Nurettin Bolucu <Nurettin.Bolucu@analog.com>
Signed-off-by: Zeynep Arslanbenzer <Zeynep.Arslanbenzer@analog.com>
---
 drivers/mfd/Kconfig          |  13 ++
 drivers/mfd/Makefile         |   1 +
 drivers/mfd/max77658.c       | 426 +++++++++++++++++++++++++++++++++++
 include/linux/mfd/max77658.h |  80 +++++++
 4 files changed, 520 insertions(+)
 create mode 100644 drivers/mfd/max77658.c
 create mode 100644 include/linux/mfd/max77658.h

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 8b93856de432..aa1630a6d33a 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -821,6 +821,19 @@ config MFD_MAX77650
 	  the following functionalities of the device: GPIO, regulator,
 	  charger, LED, onkey.
 
+config MFD_MAX77658
+	tristate "Analog Devices MAX77643/54/58/59 PMIC Support"
+	depends on I2C
+	depends on OF
+	select MFD_CORE
+	select REGMAP_I2C
+	select REGMAP_IRQ
+	help
+	  Say Y here to add support for Analog Devices MAX77643/54/58/59
+	  Power Management ICs. This is the core driver for interacting
+	  with the device. Additional drivers must be enabled in order to use the
+	  regulator, charger, and battery functionalities of the device.
+
 config MFD_MAX77686
 	tristate "Maxim Semiconductor MAX77686/802 PMIC Support"
 	depends on I2C
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index 7ed3ef4a698c..f52aff45878f 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -163,6 +163,7 @@ obj-$(CONFIG_MFD_DA9150)	+= da9150-core.o
 obj-$(CONFIG_MFD_MAX14577)	+= max14577.o
 obj-$(CONFIG_MFD_MAX77620)	+= max77620.o
 obj-$(CONFIG_MFD_MAX77650)	+= max77650.o
+obj-$(CONFIG_MFD_MAX77658)	+= max77658.o
 obj-$(CONFIG_MFD_MAX77686)	+= max77686.o
 obj-$(CONFIG_MFD_MAX77693)	+= max77693.o
 obj-$(CONFIG_MFD_MAX77714)	+= max77714.o
diff --git a/drivers/mfd/max77658.c b/drivers/mfd/max77658.c
new file mode 100644
index 000000000000..2eab1133cdc8
--- /dev/null
+++ b/drivers/mfd/max77658.c
@@ -0,0 +1,426 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2023 Analog Devices, Inc.
+ * ADI driver for the MAX77643/54/58/59
+ */
+
+#include <linux/i2c.h>
+#include <linux/mfd/core.h>
+#include <linux/mfd/max77658.h>
+#include <linux/mod_devicetable.h>
+#include <linux/of_device.h>
+#include <linux/regmap.h>
+
+#define I2C_ADDR_FUEL_GAUGE (0x6C >> 1)
+
+static const struct regmap_config max77658_regmap_config = {
+	.reg_bits   = 8,
+	.val_bits   = 8,
+};
+
+static const struct regmap_config max77658_regmap_config_fg = {
+	.reg_bits   = 8,
+	.val_bits   = 16,
+	.cache_type = REGCACHE_NONE,
+	.val_format_endian = REGMAP_ENDIAN_LITTLE,
+};
+
+static const struct regmap_irq max77643_glbl0_irqs[] = {
+	{ .mask = MAX77658_BIT_INT_GLBL0_GPIO0_F, },
+	{ .mask = MAX77658_BIT_INT_GLBL0_GPIO0_R, },
+	{ .mask = MAX77658_BIT_INT_GLBL0_EN_F, },
+	{ .mask = MAX77658_BIT_INT_GLBL0_EN_R, },
+	{ .mask = MAX77658_BIT_INT_GLBL0_TJAL1_R, },
+	{ .mask = MAX77658_BIT_INT_GLBL0_TJAL2_R, },
+	{ .mask = MAX77643_BIT_INT_GLBL0_DOD0_R, },
+};
+
+static const struct regmap_irq_chip max77643_glbl0_irq_chip = {
+	.name           = "max77643_glbl0",
+	.status_base    = MAX77658_REG_INT_GLBL0,
+	.mask_base      = MAX77643_REG_INTM_GLBL0,
+	.num_regs       = 1,
+	.irqs           = max77643_glbl0_irqs,
+	.num_irqs       = ARRAY_SIZE(max77643_glbl0_irqs),
+};
+
+static const struct regmap_irq max77658_glbl0_irqs[] = {
+	{ .mask = MAX77658_BIT_INT_GLBL0_GPIO0_F, },
+	{ .mask = MAX77658_BIT_INT_GLBL0_GPIO0_R, },
+	{ .mask = MAX77658_BIT_INT_GLBL0_EN_F, },
+	{ .mask = MAX77658_BIT_INT_GLBL0_EN_R, },
+	{ .mask = MAX77658_BIT_INT_GLBL0_TJAL1_R, },
+	{ .mask = MAX77658_BIT_INT_GLBL0_TJAL2_R, },
+	{ .mask = MAX77658_BIT_INT_GLBL0_DOD1_R, },
+	{ .mask = MAX77658_BIT_INT_GLBL0_DOD0_R, },
+};
+
+static const struct regmap_irq_chip max77654_glbl0_irq_chip = {
+	.name           = "max77654_glbl0",
+	.status_base    = MAX77658_REG_INT_GLBL0,
+	.mask_base      = MAX77654_REG_INTM_GLBL0,
+	.num_regs       = 1,
+	.irqs           = max77658_glbl0_irqs,
+	.num_irqs       = ARRAY_SIZE(max77658_glbl0_irqs),
+};
+
+static const struct regmap_irq_chip max77658_glbl0_irq_chip = {
+	.name           = "max77658_glbl0",
+	.status_base    = MAX77658_REG_INT_GLBL0,
+	.mask_base      = MAX77658_REG_INTM_GLBL0,
+	.num_regs       = 1,
+	.irqs           = max77658_glbl0_irqs,
+	.num_irqs       = ARRAY_SIZE(max77658_glbl0_irqs),
+};
+
+static const struct regmap_irq max77659_glbl0_irqs[] = {
+	{ .mask = MAX77658_BIT_INT_GLBL0_GPIO0_F, },
+	{ .mask = MAX77658_BIT_INT_GLBL0_GPIO0_R, },
+	{ .mask = MAX77658_BIT_INT_GLBL0_EN_F, },
+	{ .mask = MAX77658_BIT_INT_GLBL0_EN_R, },
+	{ .mask = MAX77658_BIT_INT_GLBL0_TJAL1_R, },
+	{ .mask = MAX77658_BIT_INT_GLBL0_TJAL2_R, },
+	{ .mask = MAX77658_BIT_INT_GLBL0_DOD0_R, },
+};
+
+static const struct regmap_irq_chip max77659_glbl0_irq_chip = {
+	.name           = "max77659_glbl0",
+	.status_base    = MAX77658_REG_INT_GLBL0,
+	.mask_base      = MAX77654_REG_INTM_GLBL0,
+	.num_regs       = 1,
+	.irqs           = max77659_glbl0_irqs,
+	.num_irqs       = ARRAY_SIZE(max77659_glbl0_irqs),
+};
+
+static const struct regmap_irq max77643_glbl1_irqs[] = {
+	{ .mask = MAX77658_BIT_INT_GLBL1_GPI1_F, },
+	{ .mask = MAX77658_BIT_INT_GLBL1_GPI1_R, },
+	{ .mask = MAX77658_BIT_INT_GLBL1_SBB0_F, },
+	{ .mask = MAX77658_BIT_INT_GLBL1_SBB1_F, },
+	{ .mask = MAX77658_BIT_INT_GLBL1_SBB2_F, },
+	{ .mask = MAX77658_BIT_INT_GLBL1_LDO0_F, },
+};
+
+static const struct regmap_irq_chip max77643_glbl1_irq_chip = {
+	.name           = "max77643_glbl1",
+	.status_base    = MAX77658_REG_INT_GLBL1,
+	.mask_base      = MAX77643_REG_INTM_GLBL1,
+	.num_regs       = 1,
+	.irqs           = max77643_glbl1_irqs,
+	.num_irqs       = ARRAY_SIZE(max77643_glbl1_irqs),
+};
+
+static const struct regmap_irq max77654_glbl1_irqs[] = {
+	{ .mask = MAX77658_BIT_INT_GLBL1_GPI1_F, },
+	{ .mask = MAX77658_BIT_INT_GLBL1_GPI1_R, },
+	{ .mask = MAX77654_BIT_INT_GLBL1_GPI2_F, },
+	{ .mask = MAX77654_BIT_INT_GLBL1_GPI2_R, },
+	{ .mask = MAX77654_BIT_INT_GLBL1_SBB_TO, },
+	{ .mask = MAX77658_BIT_INT_GLBL1_LDO0_F, },
+	{ .mask = MAX77658_BIT_INT_GLBL1_LDO1_F, },
+};
+
+static const struct regmap_irq_chip max77654_glbl1_irq_chip = {
+	.name           = "max77654_glbl1",
+	.status_base    = MAX77658_REG_INT_GLBL1,
+	.mask_base      = MAX77654_REG_INTM_GLBL1,
+	.num_regs       = 1,
+	.irqs           = max77654_glbl1_irqs,
+	.num_irqs       = ARRAY_SIZE(max77654_glbl1_irqs),
+};
+
+static const struct regmap_irq max77658_glbl1_irqs[] = {
+	{ .mask = MAX77658_BIT_INT_GLBL1_GPI1_F, },
+	{ .mask = MAX77658_BIT_INT_GLBL1_GPI1_R, },
+	{ .mask = MAX77658_BIT_INT_GLBL1_SBB0_F, },
+	{ .mask = MAX77658_BIT_INT_GLBL1_SBB1_F, },
+	{ .mask = MAX77658_BIT_INT_GLBL1_SBB2_F, },
+	{ .mask = MAX77658_BIT_INT_GLBL1_LDO0_F, },
+	{ .mask = MAX77658_BIT_INT_GLBL1_LDO1_F, },
+};
+
+static const struct regmap_irq_chip max77658_glbl1_irq_chip = {
+	.name           = "max77658_glbl1",
+	.status_base    = MAX77658_REG_INT_GLBL1,
+	.mask_base      = MAX77658_REG_INTM_GLBL1,
+	.num_regs       = 1,
+	.irqs           = max77658_glbl1_irqs,
+	.num_irqs       = ARRAY_SIZE(max77658_glbl1_irqs),
+};
+
+static const struct regmap_irq max77659_glbl1_irqs[] = {
+	{ .mask = MAX77658_BIT_INT_GLBL1_GPI1_F, },
+	{ .mask = MAX77658_BIT_INT_GLBL1_GPI1_R, },
+	{ .mask = MAX77659_BIT_INT_GLBL1_SBB_TO, },
+	{ .mask = MAX77658_BIT_INT_GLBL1_LDO0_F, },
+};
+
+static const struct regmap_irq_chip max77659_glbl1_irq_chip = {
+	.name           = "max77659_glbl1",
+	.status_base    = MAX77658_REG_INT_GLBL1,
+	.mask_base      = MAX77658_REG_INTM_GLBL1,
+	.num_regs       = 1,
+	.irqs           = max77659_glbl1_irqs,
+	.num_irqs       = ARRAY_SIZE(max77659_glbl1_irqs),
+};
+
+static const struct regmap_irq max77658_chg_irqs[] = {
+	{ .mask = MAX77658_BIT_INT_THM, },
+	{ .mask = MAX77658_BIT_INT_CHG, },
+	{ .mask = MAX77658_BIT_INT_CHGIN, },
+	{ .mask = MAX77658_BIT_INT_TJ_REG, },
+	{ .mask = MAX77658_BIT_INT_CHGIN_CTRL, },
+	{ .mask = MAX77658_BIT_INT_SYS_CTRL, },
+	{ .mask = MAX77658_BIT_INT_SYS_CNFG, },
+};
+
+static const struct regmap_irq_chip max77654_chg_irq_chip = {
+	.name           = "max77654_chg",
+	.status_base    = MAX77658_REG_INT_CHG,
+	.mask_base      = MAX77658_REG_INTM_CHG,
+	.num_regs       = 1,
+	.irqs           = max77658_chg_irqs,
+	.num_irqs       = ARRAY_SIZE(max77658_chg_irqs),
+};
+
+static const struct regmap_irq_chip max77658_chg_irq_chip = {
+	.name           = "max77658_chg",
+	.status_base    = MAX77658_REG_INT_CHG,
+	.mask_base      = MAX77658_REG_INTM_CHG,
+	.num_regs       = 1,
+	.irqs           = max77658_chg_irqs,
+	.num_irqs       = ARRAY_SIZE(max77658_chg_irqs),
+};
+
+static const struct regmap_irq max77659_chg_irqs[] = {
+	{ .mask = MAX77658_BIT_INT_THM, },
+	{ .mask = MAX77658_BIT_INT_CHG, },
+	{ .mask = MAX77658_BIT_INT_CHGIN, },
+	{ .mask = MAX77658_BIT_INT_TJ_REG, },
+	{ .mask = MAX77659_BIT_INT_SYS_CTRL, },
+};
+
+static const struct regmap_irq_chip max77659_chg_irq_chip = {
+	.name           = "max77659_chg",
+	.status_base    = MAX77658_REG_INT_CHG,
+	.mask_base      = MAX77658_REG_INTM_CHG,
+	.num_regs       = 1,
+	.irqs           = max77659_chg_irqs,
+	.num_irqs       = ARRAY_SIZE(max77659_chg_irqs),
+};
+
+static const struct mfd_cell max77643_devs[] = {
+	MFD_CELL_NAME("max77658-regulator"),
+};
+
+static const struct mfd_cell max77654_devs[] = {
+	MFD_CELL_NAME("max77658-regulator"),
+	MFD_CELL_OF("max77654-charger", NULL, NULL, 0, 0,
+		    "adi,max77654-charger"),
+};
+
+static const struct mfd_cell max77658_devs[] = {
+	MFD_CELL_NAME("max77658-regulator"),
+	MFD_CELL_OF("max77658-charger", NULL, NULL, 0, 0,
+		    "adi,max77658-charger"),
+	MFD_CELL_OF("max77658-battery", NULL, NULL, 0, 0,
+		    "adi,max77658-battery"),
+};
+
+static const struct mfd_cell max77659_devs[] = {
+	MFD_CELL_NAME("max77658-regulator"),
+	MFD_CELL_OF("max77659-charger", NULL, NULL, 0, 0,
+		    "adi,max77659-charger"),
+};
+
+static int max77658_pmic_irq_init(struct device *dev)
+{
+	const struct regmap_irq_chip *glbl0_chip, *glbl1_chip, *chg_chip;
+	struct max77658_dev *max77658 = dev_get_drvdata(dev);
+	int ret, i;
+
+	switch (max77658->id) {
+	case ID_MAX77643:
+		glbl0_chip = &max77643_glbl0_irq_chip;
+		glbl1_chip = &max77643_glbl1_irq_chip;
+		break;
+	case ID_MAX77654:
+		glbl0_chip = &max77654_glbl0_irq_chip;
+		glbl1_chip = &max77654_glbl1_irq_chip;
+		chg_chip = &max77654_chg_irq_chip;
+		break;
+	case ID_MAX77658:
+		glbl0_chip = &max77658_glbl0_irq_chip;
+		glbl1_chip = &max77658_glbl1_irq_chip;
+		chg_chip = &max77658_chg_irq_chip;
+		break;
+	case ID_MAX77659:
+		glbl0_chip = &max77659_glbl0_irq_chip;
+		glbl1_chip = &max77659_glbl1_irq_chip;
+		chg_chip = &max77659_chg_irq_chip;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	for (i = 0; i < glbl0_chip->num_regs; i++) {
+		ret = regmap_update_bits(max77658->regmap,
+					 glbl0_chip->mask_base,
+					 (1 << glbl0_chip->irqs[i].reg_offset),
+					 1);
+		if (ret)
+			return dev_err_probe(dev, ret,
+					     "Unable to write Global0 Interrupt Masking register\n");
+	}
+
+	for (i = 0; i < glbl1_chip->num_regs; i++) {
+		ret = regmap_update_bits(max77658->regmap,
+					 glbl1_chip->mask_base,
+					 (1 << glbl1_chip->irqs[i].reg_offset),
+					 1);
+		if (ret)
+			return dev_err_probe(dev, ret,
+					     "Unable to write Global1 Interrupt Masking register\n");
+	}
+
+	if (max77658->id != ID_MAX77643) {
+		for (i = 0; i < chg_chip->num_regs; i++) {
+			ret = regmap_update_bits(max77658->regmap,
+						 chg_chip->mask_base,
+						 (1 <<
+						 chg_chip->irqs[i].reg_offset),
+						 1);
+			if (ret)
+				return dev_err_probe(dev, ret,
+						     "Unable to write Charger Interrupt Masking register\n");
+		}
+
+		ret = devm_regmap_add_irq_chip(dev, max77658->regmap,
+					       max77658->irq,
+					       IRQF_ONESHOT | IRQF_SHARED, 0,
+					       chg_chip, &max77658->irqc_chg);
+		if (ret)
+			return dev_err_probe(dev, ret,
+					     "Failed to add charger IRQ chip\n");
+	}
+
+	ret = devm_regmap_add_irq_chip(dev, max77658->regmap, max77658->irq,
+				       IRQF_ONESHOT | IRQF_SHARED, 0,
+				       glbl0_chip, &max77658->irqc_glbl0);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "Failed to add global0 IRQ chip\n");
+
+	return devm_regmap_add_irq_chip(dev, max77658->regmap, max77658->irq,
+					IRQF_ONESHOT | IRQF_SHARED, 0,
+					glbl1_chip, &max77658->irqc_glbl1);
+}
+
+static int max77658_i2c_probe(struct i2c_client *client,
+			      const struct i2c_device_id *id)
+{
+	struct device *dev = &client->dev;
+	struct max77658_dev *max77658;
+	const struct mfd_cell *cells;
+	struct i2c_client *fuel;
+	int ret, n_devs;
+
+	max77658 = devm_kzalloc(dev, sizeof(*max77658), GFP_KERNEL);
+	if (!max77658)
+		return -ENOMEM;
+
+	i2c_set_clientdata(client, max77658);
+	max77658->irq = client->irq;
+
+	max77658->id  = (enum max77658_ids)device_get_match_data(dev);
+	if (!max77658->id)
+		max77658->id  = (enum max77658_ids)id->driver_data;
+
+	if (!max77658->id)
+		return -EINVAL;
+
+	max77658->regmap = devm_regmap_init_i2c(client,
+						&max77658_regmap_config);
+	if (IS_ERR(max77658->regmap))
+		return dev_err_probe(dev, PTR_ERR(max77658->regmap),
+				     "Failed to initialize regmap\n");
+
+	fuel = i2c_new_dummy_device(client->adapter, I2C_ADDR_FUEL_GAUGE);
+	if (IS_ERR(fuel))
+		return dev_err_probe(dev, PTR_ERR(fuel),
+				     "Failed to create I2C device[0x%Xh]\n",
+				      I2C_ADDR_FUEL_GAUGE);
+
+	i2c_set_clientdata(fuel, max77658);
+
+	max77658->regmap_fg = devm_regmap_init_i2c(fuel,
+						   &max77658_regmap_config_fg);
+	if (IS_ERR(max77658->regmap_fg))
+		return dev_err_probe(dev,
+				     PTR_ERR(max77658->regmap_fg),
+				     "Failed to initialize I2C device[0x%Xh]\n",
+				     I2C_ADDR_FUEL_GAUGE);
+
+	ret = max77658_pmic_irq_init(dev);
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "Failed to initialize IRQ\n");
+
+	switch (max77658->id) {
+	case ID_MAX77643:
+		cells = max77643_devs;
+		n_devs = ARRAY_SIZE(max77643_devs);
+		break;
+	case ID_MAX77654:
+		cells = max77654_devs;
+		n_devs = ARRAY_SIZE(max77654_devs);
+		break;
+	case ID_MAX77658:
+		cells = max77658_devs;
+		n_devs = ARRAY_SIZE(max77658_devs);
+		break;
+	case ID_MAX77659:
+		cells = max77659_devs;
+		n_devs = ARRAY_SIZE(max77659_devs);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	ret = devm_mfd_add_devices(dev, -1, cells, n_devs,  NULL, 0, NULL);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to add sub-devices\n");
+
+	return device_init_wakeup(dev, true);
+}
+
+static const struct of_device_id max77658_of_id[] = {
+	{ .compatible = "adi,max77643", .data = (void *)ID_MAX77643 },
+	{ .compatible = "adi,max77654", .data = (void *)ID_MAX77654 },
+	{ .compatible = "adi,max77658", .data = (void *)ID_MAX77658 },
+	{ .compatible = "adi,max77659", .data = (void *)ID_MAX77659 },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, max77658_of_id);
+
+static const struct i2c_device_id max77658_i2c_id[] = {
+	{ "max77643", ID_MAX77643 },
+	{ "max77654", ID_MAX77654 },
+	{ "max77658", ID_MAX77658 },
+	{ "max77659", ID_MAX77659 },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(i2c, max77658_i2c_id);
+
+static struct i2c_driver max77658_driver = {
+	.driver = {
+		.name = "max77658",
+		.of_match_table = max77658_of_id,
+	},
+	.probe = max77658_i2c_probe,
+	.id_table = max77658_i2c_id,
+};
+module_i2c_driver(max77658_driver);
+
+MODULE_DESCRIPTION("MAX77658 MFD Driver");
+MODULE_AUTHOR("Nurettin.Bolucu@analog.com, Zeynep.Arslanbenzer@analog.com");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/mfd/max77658.h b/include/linux/mfd/max77658.h
new file mode 100644
index 000000000000..a7860f76c61f
--- /dev/null
+++ b/include/linux/mfd/max77658.h
@@ -0,0 +1,80 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#ifndef __MFD_MAX77658_H__
+#define __MFD_MAX77658_H__
+
+#include <linux/bits.h>
+
+#define MAX77658_REG_INT_GLBL0		0x00
+#define MAX77658_REG_INT_CHG		0x01
+#define MAX77658_REG_INT_GLBL1		0x04
+#define MAX77658_REG_INTM_CHG		0x07
+#define MAX77658_REG_INTM_GLBL0		0x08
+#define MAX77658_REG_INTM_GLBL1		0x09
+
+#define MAX77654_REG_INTM_GLBL1		0x08
+#define MAX77654_REG_INTM_GLBL0		0x09
+
+#define MAX77643_REG_INT_GLBL1		0x01
+#define MAX77643_REG_INTM_GLBL0		0x04
+#define MAX77643_REG_INTM_GLBL1		0x05
+
+#define MAX77658_BIT_INT_GLBL0_GPIO0_F	BIT(0)
+#define MAX77658_BIT_INT_GLBL0_GPIO0_R	BIT(1)
+#define MAX77658_BIT_INT_GLBL0_EN_F	BIT(2)
+#define MAX77658_BIT_INT_GLBL0_EN_R	BIT(3)
+#define MAX77658_BIT_INT_GLBL0_TJAL1_R	BIT(4)
+#define MAX77658_BIT_INT_GLBL0_TJAL2_R	BIT(5)
+#define MAX77658_BIT_INT_GLBL0_DOD1_R	BIT(6)
+#define MAX77658_BIT_INT_GLBL0_DOD0_R	BIT(7)
+
+#define MAX77643_BIT_INT_GLBL0_DOD0_R	BIT(6)
+
+#define MAX77658_BIT_INT_GLBL1_GPI1_F	BIT(0)
+#define MAX77658_BIT_INT_GLBL1_GPI1_R	BIT(1)
+#define MAX77658_BIT_INT_GLBL1_SBB0_F	BIT(2)
+#define MAX77658_BIT_INT_GLBL1_SBB1_F	BIT(3)
+#define MAX77658_BIT_INT_GLBL1_SBB2_F	BIT(4)
+#define MAX77658_BIT_INT_GLBL1_LDO0_F	BIT(5)
+#define MAX77658_BIT_INT_GLBL1_LDO1_F	BIT(6)
+
+#define MAX77659_BIT_INT_GLBL1_SBB_TO	BIT(4)
+
+#define MAX77654_BIT_INT_GLBL1_GPI2_F	BIT(2)
+#define MAX77654_BIT_INT_GLBL1_GPI2_R	BIT(3)
+#define MAX77654_BIT_INT_GLBL1_SBB_TO	BIT(4)
+
+#define MAX77658_BIT_INT_THM		BIT(0)
+#define MAX77658_BIT_INT_CHG		BIT(1)
+#define MAX77658_BIT_INT_CHGIN		BIT(2)
+#define MAX77658_BIT_INT_TJ_REG		BIT(3)
+#define MAX77658_BIT_INT_CHGIN_CTRL	BIT(4)
+#define MAX77658_BIT_INT_SYS_CTRL	BIT(5)
+#define MAX77658_BIT_INT_SYS_CNFG	BIT(6)
+
+#define MAX77659_BIT_INT_SYS_CTRL	BIT(4)
+
+enum max77658_ids {
+	ID_MAX77643 = 1,
+	ID_MAX77654,
+	ID_MAX77658,
+	ID_MAX77659
+};
+
+struct device;
+struct regmap;
+struct regmap_irq_chip_data;
+
+struct max77658_dev {
+	enum max77658_ids id;
+
+	int irq;
+	struct regmap_irq_chip_data *irqc_glbl0;
+	struct regmap_irq_chip_data *irqc_glbl1;
+	struct regmap_irq_chip_data *irqc_chg;
+
+	struct regmap *regmap;
+	struct regmap *regmap_fg;
+};
+
+#endif /* __MFD_MAX77658_H__ */
-- 
2.25.1

