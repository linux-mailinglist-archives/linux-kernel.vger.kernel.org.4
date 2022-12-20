Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23D3F652170
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 14:25:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233595AbiLTNZE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 08:25:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233522AbiLTNYl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 08:24:41 -0500
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 101BA1A063;
        Tue, 20 Dec 2022 05:24:35 -0800 (PST)
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BKBTI6t000448;
        Tue, 20 Dec 2022 08:24:31 -0500
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3mh8gbh9cr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Dec 2022 08:24:31 -0500
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 2BKDOUPo053431
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 20 Dec 2022 08:24:30 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Tue, 20 Dec 2022 08:24:29 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Tue, 20 Dec 2022 08:24:28 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Tue, 20 Dec 2022 08:24:28 -0500
Received: from IST-LT-42339.ad.analog.com (IST-LT-42339.ad.analog.com [10.117.192.221])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 2BKDNoP3010583;
        Tue, 20 Dec 2022 08:24:19 -0500
From:   Zeynep Arslanbenzer <Zeynep.Arslanbenzer@analog.com>
To:     <lee@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <sre@kernel.org>,
        <lgirdwood@gmail.com>, <broonie@kernel.org>
CC:     <Zeynep.Arslanbenzer@analog.com>, <Nurettin.Bolucu@analog.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-pm@vger.kernel.org>
Subject: [PATCH 1/6] drivers: mfd: add MAX77659 PMIC support
Date:   Tue, 20 Dec 2022 16:22:45 +0300
Message-ID: <20221220132250.19383-2-Zeynep.Arslanbenzer@analog.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221220132250.19383-1-Zeynep.Arslanbenzer@analog.com>
References: <20221220132250.19383-1-Zeynep.Arslanbenzer@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: Cc-NM7e9ldMnSsZUvWNPgwnDZAimRUbB
X-Proofpoint-GUID: Cc-NM7e9ldMnSsZUvWNPgwnDZAimRUbB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-20_05,2022-12-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 mlxlogscore=999 clxscore=1015
 impostorscore=0 mlxscore=0 spamscore=0 priorityscore=1501 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2212200110
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds MFD driver for MAX77659 to enable its sub
devices.

The MAX77659 is a multi-function devices. It includes
charger and regulator

Signed-off-by: Nurettin Bolucu <Nurettin.Bolucu@analog.com>
Signed-off-by: Zeynep Arslanbenzer <Zeynep.Arslanbenzer@analog.com>
---
 MAINTAINERS                  |   8 ++
 drivers/mfd/Kconfig          |  14 +++
 drivers/mfd/Makefile         |   1 +
 drivers/mfd/max77659.c       | 188 +++++++++++++++++++++++++++++++++++
 include/linux/mfd/max77659.h |  60 +++++++++++
 5 files changed, 271 insertions(+)
 create mode 100644 drivers/mfd/max77659.c
 create mode 100644 include/linux/mfd/max77659.h

diff --git a/MAINTAINERS b/MAINTAINERS
index a608f19da3a9..45a8a471c7c0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12640,6 +12640,14 @@ F:	drivers/power/supply/max77650-charger.c
 F:	drivers/regulator/max77650-regulator.c
 F:	include/linux/mfd/max77650.h
 
+ANALOG DEVICES MAX77659 PMIC MFD DRIVER
+M:	Nurettin Bolucu <Nurettin.Bolucu@analog.com>
+M:	Zeynep Arslanbenzer <Zeynep.Arslanbenzer@analog.com>
+L:	linux-kernel@vger.kernel.org
+S:	Maintained
+F:	drivers/mfd/max77659.c
+F:	include/linux/mfd/max77659.h
+
 MAXIM MAX77714 PMIC MFD DRIVER
 M:	Luca Ceresoli <luca@lucaceresoli.net>
 S:	Maintained
diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 8b93856de432..4d5e446edfa5 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -821,6 +821,20 @@ config MFD_MAX77650
 	  the following functionalities of the device: GPIO, regulator,
 	  charger, LED, onkey.
 
+config MFD_MAX77659
+	tristate "Analog Devices MAX77659 PMIC Support"
+	depends on I2C
+	depends on OF
+	select MFD_CORE
+	select REGMAP_I2C
+	select REGMAP_IRQ
+	help
+	  Say Y here to add support for Analog Devices MAX77659 Power
+	  Management IC. This is the core multifunction
+	  driver for interacting with the device. Additional drivers can be
+	  enabled in order to use the following functionalities of the device:
+	  regulator, charger.
+
 config MFD_MAX77686
 	tristate "Maxim Semiconductor MAX77686/802 PMIC Support"
 	depends on I2C
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index 7ed3ef4a698c..f7b39bf4aacb 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -163,6 +163,7 @@ obj-$(CONFIG_MFD_DA9150)	+= da9150-core.o
 obj-$(CONFIG_MFD_MAX14577)	+= max14577.o
 obj-$(CONFIG_MFD_MAX77620)	+= max77620.o
 obj-$(CONFIG_MFD_MAX77650)	+= max77650.o
+obj-$(CONFIG_MFD_MAX77659)	+= max77659.o
 obj-$(CONFIG_MFD_MAX77686)	+= max77686.o
 obj-$(CONFIG_MFD_MAX77693)	+= max77693.o
 obj-$(CONFIG_MFD_MAX77714)	+= max77714.o
diff --git a/drivers/mfd/max77659.c b/drivers/mfd/max77659.c
new file mode 100644
index 000000000000..8401aea20e8c
--- /dev/null
+++ b/drivers/mfd/max77659.c
@@ -0,0 +1,188 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#include <linux/i2c.h>
+#include <linux/mfd/core.h>
+#include <linux/mfd/max77659.h>
+#include <linux/mod_devicetable.h>
+#include <linux/regmap.h>
+
+static const struct regmap_config max77659_regmap_config = {
+	.reg_bits   = 8,
+	.val_bits   = 8,
+};
+
+static const struct regmap_irq max77659_glbl0_irqs[] = {
+	{ .mask = MAX77659_BIT_INT_GLBL0_GPIO0_F, },
+	{ .mask = MAX77659_BIT_INT_GLBL0_GPIO0_R, },
+	{ .mask = MAX77659_BIT_INT_GLBL0_EN_F, },
+	{ .mask = MAX77659_BIT_INT_GLBL0_EN_R, },
+	{ .mask = MAX77659_BIT_INT_GLBL0_TJAL1_R, },
+	{ .mask = MAX77659_BIT_INT_GLBL0_TJAL2_R, },
+	{ .mask = MAX77659_BIT_INT_GLBL0_DOD0_R, },
+};
+
+static const struct regmap_irq_chip max77659_glbl0_irq_chip = {
+	.name           = "max77659_glbl0",
+	.status_base    = MAX77659_REG_INT_GLBL0,
+	.mask_base      = MAX77659_REG_INTM_GLBL0,
+	.num_regs       = 1,
+	.irqs           = max77659_glbl0_irqs,
+	.num_irqs       = ARRAY_SIZE(max77659_glbl0_irqs),
+};
+
+static const struct regmap_irq max77659_glbl1_irqs[] = {
+	{ .mask = MAX77659_BIT_INT_GLBL1_GPI1_F, },
+	{ .mask = MAX77659_BIT_INT_GLBL1_GPI1_R, },
+	{ .mask = MAX77659_BIT_INT_GLBL1_SBB_TO, },
+	{ .mask = MAX77659_BIT_INT_GLBL1_LDO0_F, },
+};
+
+static const struct regmap_irq_chip max77659_glbl1_irq_chip = {
+	.name           = "max77659_glbl1",
+	.status_base    = MAX77659_REG_INT_GLBL1,
+	.mask_base      = MAX77659_REG_INTM_GLBL1,
+	.num_regs       = 1,
+	.irqs           = max77659_glbl1_irqs,
+	.num_irqs       = ARRAY_SIZE(max77659_glbl1_irqs),
+};
+
+static const struct regmap_irq max77659_chg_irqs[] = {
+	{ .mask = MAX77659_BIT_INT_THM, },
+	{ .mask = MAX77659_BIT_INT_CHG, },
+	{ .mask = MAX77659_BIT_INT_CHGIN, },
+	{ .mask = MAX77659_BIT_INT_TJ_REG, },
+	{ .mask = MAX77659_BIT_INT_SYS_CTRL, },
+};
+
+static const struct regmap_irq_chip max77659_chg_irq_chip = {
+	.name = "max77659_chg",
+	.status_base = MAX77659_REG_INT_CHG,
+	.mask_base = MAX77659_REG_INT_M_CHG,
+	.num_regs = 1,
+	.irqs = max77659_chg_irqs,
+	.num_irqs = ARRAY_SIZE(max77659_chg_irqs),
+};
+
+static const struct mfd_cell max77659_devs[] = {
+	MFD_CELL_OF(MAX77659_REGULATOR_NAME, NULL, NULL, 0, 0, "adi,max77659-regulator"),
+	MFD_CELL_OF(MAX77659_CHARGER_NAME, NULL, NULL, 0, 0, "adi,max77659-charger"),
+};
+
+static int max77659_pmic_irq_init(struct max77659_dev *me)
+{
+	struct device *dev = me->dev;
+	int ret;
+
+	ret = regmap_write(me->regmap, MAX77659_REG_INTM_GLBL0, MAX77659_INT_GLBL0_MASK);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "Unable to write Global0 Interrupt Masking register\n");
+
+	ret = regmap_write(me->regmap, MAX77659_REG_INTM_GLBL1, MAX77659_INT_GLBL1_MASK);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "Unable to write Global1 Interrupt Masking register\n");
+
+	ret = devm_regmap_add_irq_chip(dev, me->regmap, me->irq,
+				       IRQF_ONESHOT | IRQF_SHARED, 0,
+				       &max77659_glbl0_irq_chip, &me->irqc_glbl0);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to add global0 IRQ chip\n");
+
+	ret = devm_regmap_add_irq_chip(dev, me->regmap, me->irq,
+				       IRQF_ONESHOT | IRQF_SHARED, 0,
+				       &max77659_glbl1_irq_chip, &me->irqc_glbl1);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to add global1 IRQ chip\n");
+
+	return devm_regmap_add_irq_chip(dev, me->regmap, me->irq,
+					IRQF_ONESHOT | IRQF_SHARED, 0,
+					&max77659_chg_irq_chip, &me->irqc_chg);
+}
+
+static int max77659_pmic_setup(struct max77659_dev *me)
+{
+	struct device *dev = me->dev;
+	unsigned int val;
+	int ret;
+
+	ret = max77659_pmic_irq_init(me);
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "Failed to initialize IRQ\n");
+
+	ret = regmap_read(me->regmap, MAX77659_REG_INT_GLBL0, &val);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "Unable to read Global0 Interrupt Status register\n");
+
+	ret = regmap_read(me->regmap, MAX77659_REG_INT_GLBL1, &val);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "Unable to read Global1 Interrupt Status register\n");
+
+	ret = regmap_read(me->regmap, MAX77659_REG_INT_CHG, &val);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "Unable to read Charger Interrupt Status register\n");
+	ret = device_init_wakeup(dev, true);
+	if (ret)
+		return dev_err_probe(dev, ret, "Unable to init wakeup\n");
+
+	ret = devm_mfd_add_devices(dev, -1, max77659_devs, ARRAY_SIZE(max77659_devs),
+				   NULL, 0, NULL);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to add sub-devices\n");
+
+	enable_irq_wake(me->irq);
+
+	return 0;
+}
+
+static int max77659_i2c_probe(struct i2c_client *client)
+{
+	struct max77659_dev *me;
+
+	me = devm_kzalloc(&client->dev, sizeof(*me), GFP_KERNEL);
+	if (!me)
+		return -ENOMEM;
+
+	i2c_set_clientdata(client, me);
+	me->dev = &client->dev;
+	me->irq = client->irq;
+
+	me->regmap = devm_regmap_init_i2c(client, &max77659_regmap_config);
+
+	if (IS_ERR(me->regmap))
+		return dev_err_probe(&client->dev, PTR_ERR(me->regmap),
+				     "Failed to allocate register map\n");
+
+	return max77659_pmic_setup(me);
+}
+
+static const struct of_device_id max77659_of_id[] = {
+	{ .compatible = "adi,max77659" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, max77659_of_id);
+
+static const struct i2c_device_id max77659_i2c_id[] = {
+	{ MAX77659_NAME, 0 },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(i2c, max77659_i2c_id);
+
+static struct i2c_driver max77659_i2c_driver = {
+	.driver = {
+		.name = MAX77659_NAME,
+		.of_match_table = of_match_ptr(max77659_of_id),
+	},
+	.probe_new = max77659_i2c_probe,
+	.id_table = max77659_i2c_id,
+};
+
+module_i2c_driver(max77659_i2c_driver);
+
+MODULE_DESCRIPTION("max77659 MFD Driver");
+MODULE_AUTHOR("Nurettin.Bolucu@analog.com, Zeynep.Arslanbenzer@analog.com");
+MODULE_LICENSE("GPL");
+MODULE_VERSION("1.0");
diff --git a/include/linux/mfd/max77659.h b/include/linux/mfd/max77659.h
new file mode 100644
index 000000000000..ef781e6e54c2
--- /dev/null
+++ b/include/linux/mfd/max77659.h
@@ -0,0 +1,60 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#ifndef __MAX77659_MFD_H__
+#define __MAX77659_MFD_H__
+
+#include <linux/bits.h>
+
+#define MAX77659_NAME "max77659"
+
+#define MAX77659_REGULATOR_NAME MAX77659_NAME "-regulator"
+#define MAX77659_CHARGER_NAME MAX77659_NAME "-charger"
+
+#define MAX77659_REG_INT_GLBL0 0x00
+#define MAX77659_REG_INT_CHG 0x01
+#define MAX77659_REG_INT_GLBL1 0x04
+#define MAX77659_REG_INT_M_CHG 0x07
+#define MAX77659_REG_INTM_GLBL1 0x08
+#define MAX77659_REG_INTM_GLBL0 0x09
+
+#define MAX77659_INT_GLBL0_MASK 0xFF
+#define MAX77659_INT_GLBL1_MASK 0x33
+
+#define MAX77659_BIT_INT_GLBL0_GPIO0_F BIT(0)
+#define MAX77659_BIT_INT_GLBL0_GPIO0_R BIT(1)
+#define MAX77659_BIT_INT_GLBL0_EN_F BIT(2)
+#define MAX77659_BIT_INT_GLBL0_EN_R BIT(3)
+#define MAX77659_BIT_INT_GLBL0_TJAL1_R BIT(4)
+#define MAX77659_BIT_INT_GLBL0_TJAL2_R BIT(5)
+#define MAX77659_BIT_INT_GLBL0_DOD0_R BIT(7)
+
+#define MAX77659_BIT_INT_GLBL1_GPI1_F BIT(0)
+#define MAX77659_BIT_INT_GLBL1_GPI1_R BIT(1)
+#define MAX77659_BIT_INT_GLBL1_SBB_TO BIT(4)
+#define MAX77659_BIT_INT_GLBL1_LDO0_F BIT(5)
+
+#define MAX77659_BIT_INT_THM BIT(0)
+#define MAX77659_BIT_INT_CHG BIT(1)
+#define MAX77659_BIT_INT_CHGIN BIT(2)
+#define MAX77659_BIT_INT_TJ_REG BIT(3)
+#define MAX77659_BIT_INT_SYS_CTRL BIT(4)
+
+enum {
+	MAX77659_DEV_PMIC,
+	MAX77659_DEV_CHARGER,
+	MAX77659_DEV_REGULATOR,
+	MAX77659_NUM_DEVS,
+};
+
+struct max77659_dev {
+	struct device *dev;
+
+	int irq;
+	struct regmap_irq_chip_data *irqc_glbl0;
+	struct regmap_irq_chip_data *irqc_glbl1;
+	struct regmap_irq_chip_data	*irqc_chg;
+
+	struct regmap *regmap;
+};
+
+#endif /* __MAX77659_MFD_H__ */
-- 
2.25.1

