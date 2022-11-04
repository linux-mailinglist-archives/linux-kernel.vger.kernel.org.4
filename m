Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3727161A126
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 20:38:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbiKDTin (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 15:38:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbiKDTij (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 15:38:39 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 520A3C77;
        Fri,  4 Nov 2022 12:38:34 -0700 (PDT)
Received: from pps.filterd (m0150242.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A4FZYPu004981;
        Fri, 4 Nov 2022 19:38:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : subject :
 date : message-id : in-reply-to : references; s=pps0720;
 bh=zFea3ha9HFtfiXKf+MvGPFFv9hcHTnWxgx1wDMflA3E=;
 b=goNbsv4lKx4493mLm07iJJfNYb3mf1lWHgxBzNcBIM449lWmluHL3NvB8CxEdoEiTrug
 /a0jYlxkB2RsINEYlNZQgj+qsL8JGbh+r4M7Rw8yPEz5+WL9/AI4JII7GhCoIbD1Rlk0
 oVefF8aoG38omOFDP6ULU+6WwFx+c/m3Ov0Yuva7elW9TlCC4P/EAKiWc41TglRhMOv3
 3vEd2in/y/9sEfo07UNe5pw9HMqh6Ncbb2eqqEuXcNPfz2Q4nNHLBKKyciY03+9O3OQ3
 tliYgMlY9gK0aWCLO1GWNlheP7DOCKMwLgCg/V+W1JrSdnDhndhvJnR7DkLR/gxrbgfh 0Q== 
Received: from p1lg14881.it.hpe.com (p1lg14881.it.hpe.com [16.230.97.202])
        by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 3kn4nv2amj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Nov 2022 19:38:10 +0000
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14881.it.hpe.com (Postfix) with ESMTPS id CD10380471E;
        Fri,  4 Nov 2022 19:38:09 +0000 (UTC)
Received: from hpe.com (unknown [16.231.227.36])
        by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTP id 3073D808166;
        Fri,  4 Nov 2022 19:38:09 +0000 (UTC)
From:   nick.hawkins@hpe.com
To:     jdelvare@suse.com, linux@roeck-us.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, verdun@hpe.com,
        nick.hawkins@hpe.com, corbet@lwn.net, linux@armlinux.org.uk,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v1 1/6] hwmon: (gxp-fan-ctrl) Add GXP fan controller
Date:   Fri,  4 Nov 2022 14:36:52 -0500
Message-Id: <20221104193657.105130-2-nick.hawkins@hpe.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221104193657.105130-1-nick.hawkins@hpe.com>
References: <20221104193657.105130-1-nick.hawkins@hpe.com>
X-Proofpoint-ORIG-GUID: R9awUIoSaoPR1jRpJnbwWRElZnlCDaCq
X-Proofpoint-GUID: R9awUIoSaoPR1jRpJnbwWRElZnlCDaCq
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-04_11,2022-11-03_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 phishscore=0 spamscore=0
 malwarescore=0 mlxlogscore=999 suspectscore=0 mlxscore=0 clxscore=1015
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211040122
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nick Hawkins <nick.hawkins@hpe.com>

The GXP SoC can support up to 16 fans through the interface provided by
the CPLD. The fans speeds are controlled via a pwm value 0-255. The fans
are also capable of reporting if they have failed to the CPLD which in
turn reports the status to the GXP SoC. There are no tachometers so fan
speeds are reported as a percent of the pwm value.

Signed-off-by: Nick Hawkins <nick.hawkins@hpe.com>
---
 Documentation/hwmon/gxp-fan-ctrl.rst |  36 +++
 drivers/hwmon/Kconfig                |   8 +
 drivers/hwmon/Makefile               |   1 +
 drivers/hwmon/gxp-fan-ctrl.c         | 362 +++++++++++++++++++++++++++
 4 files changed, 407 insertions(+)
 create mode 100644 Documentation/hwmon/gxp-fan-ctrl.rst
 create mode 100644 drivers/hwmon/gxp-fan-ctrl.c

diff --git a/Documentation/hwmon/gxp-fan-ctrl.rst b/Documentation/hwmon/gxp-fan-ctrl.rst
new file mode 100644
index 000000000000..fc1709fb113b
--- /dev/null
+++ b/Documentation/hwmon/gxp-fan-ctrl.rst
@@ -0,0 +1,36 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+Kernel driver gxp-fan-ctrl
+==========================
+
+Supported chips:
+
+  * HPE GXP SOC
+
+Author: Nick Hawkins <nick.hawkins@hpe.com>
+
+
+Description
+-----------
+
+gxp-fan-ctrl is a driver which provides fan control for the hpe gxp soc.
+The driver allows the gathering of fan status and the use of fan
+pwm control.
+
+
+Usage Notes
+-----------
+
+Traditionally fanY_input returns an RPM value, on HPE GXP systems it is
+the pwm value [0-255] due to the fan speeds being reported as
+percentages.
+
+
+Sysfs attributes
+----------------
+
+======================= =================================================
+pwm[0-15]		Fan 0 to 15 respective pwm value
+fan[0-15]_input		Fan 0 to 15 respective input value: pwm value
+fan[0-15]_fault		Fan 0 to 15 respective fault status: 1 fail, 0 ok
+======================= =================================================
diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index e70d9614bec2..3d32cd77424c 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -2303,6 +2303,14 @@ config SENSORS_INTEL_M10_BMC_HWMON
 	  sensors monitor various telemetry data of different components on the
 	  card, e.g. board temperature, FPGA core temperature/voltage/current.
 
+config SENSORS_GXP_FAN_CTRL
+	tristate "GXP Fan Control driver"
+	depends on ARCH_HPE_GXP || COMPILE_TEST
+	help
+	  If you say yes here you get support for GXP fan control functionality.
+	  The GXP controls fan function via the CPLD through the use of PWM
+	  registers. This driver reports status and pwm setting of the fans.
+
 if ACPI
 
 comment "ACPI drivers"
diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
index 007e829d1d0d..b474dcc708c4 100644
--- a/drivers/hwmon/Makefile
+++ b/drivers/hwmon/Makefile
@@ -83,6 +83,7 @@ obj-$(CONFIG_SENSORS_GL518SM)	+= gl518sm.o
 obj-$(CONFIG_SENSORS_GL520SM)	+= gl520sm.o
 obj-$(CONFIG_SENSORS_GSC)	+= gsc-hwmon.o
 obj-$(CONFIG_SENSORS_GPIO_FAN)	+= gpio-fan.o
+obj-$(CONFIG_SENSORS_GXP_FAN_CTRL) += gxp-fan-ctrl.o
 obj-$(CONFIG_SENSORS_HIH6130)	+= hih6130.o
 obj-$(CONFIG_SENSORS_ULTRA45)	+= ultra45_env.o
 obj-$(CONFIG_SENSORS_I5500)	+= i5500_temp.o
diff --git a/drivers/hwmon/gxp-fan-ctrl.c b/drivers/hwmon/gxp-fan-ctrl.c
new file mode 100644
index 000000000000..a01530951d58
--- /dev/null
+++ b/drivers/hwmon/gxp-fan-ctrl.c
@@ -0,0 +1,362 @@
+// SPDX-License-Identifier: GPL-2.0=or-later
+/* Copyright (C) 2022 Hewlett-Packard Enterprise Development Company, L.P. */
+
+#include <linux/err.h>
+#include <linux/hwmon.h>
+#include <linux/hwmon-sysfs.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/mfd/syscon.h>
+
+#define OFFSET_PWM0DUTY	0x10
+#define OFFSET_PWM1DUTY	0x11
+#define OFFSET_PWM2DUTY	0x12
+#define OFFSET_PWM3DUTY	0x13
+#define OFFSET_PWM4DUTY	0x14
+#define OFFSET_PWM5DUTY	0x15
+#define OFFSET_PWM6DUTY	0x16
+#define OFFSET_PWM7DUTY	0x17
+
+struct fan_data {
+	u32 inst;
+	u32 fail;
+	u32 id;
+	u32 bit;
+};
+
+struct fan_ctrl_data {
+	struct fan_data fan[16];
+	u32 power_bit;
+};
+
+struct gxp_fan_ctrl_drvdata {
+	struct device	*dev;
+	struct device	*hwmon_dev;
+	struct regmap	*plreg_map; /* Programmable logic register regmap */
+	struct regmap	*fn2_map; /* Function 2 regmap */
+	void __iomem	*base;
+	const struct fan_ctrl_data *data;
+	struct mutex update_lock; /* To protect the setting of the fan PWM value */
+};
+
+static void address_translation(u32 desired_offset, u32 *offset, u32 *bit_shift)
+{
+	*offset = (desired_offset & 0xffc);
+	*bit_shift = (desired_offset - *offset) * 8;
+}
+
+static bool fan_installed(struct device *dev, int fan)
+{
+	struct gxp_fan_ctrl_drvdata *drvdata = dev_get_drvdata(dev);
+	u32 trans_offset;
+	u32 trans_shift;
+	u32 val;
+
+	address_translation(drvdata->data->fan[fan].inst,
+			    &trans_offset,
+			    &trans_shift);
+
+	regmap_read(drvdata->plreg_map, trans_offset, &val);
+	val = (val >> trans_shift) & drvdata->data->fan[fan].bit;
+	if (val == drvdata->data->fan[fan].bit)
+		return 1;
+	else
+		return 0;
+}
+
+static bool fan_failed(struct device *dev, int fan)
+{
+	struct gxp_fan_ctrl_drvdata *drvdata = dev_get_drvdata(dev);
+	u32 trans_offset;
+	u32 trans_shift;
+	u32 val;
+
+	address_translation(drvdata->data->fan[fan].fail,
+			    &trans_offset,
+			    &trans_shift);
+
+	regmap_read(drvdata->plreg_map, trans_offset, &val);
+	val = (val >> trans_shift) & drvdata->data->fan[fan].fail;
+	if (val == drvdata->data->fan[fan].fail)
+		return 1;
+	else
+		return 0;
+}
+
+static ssize_t show_fault(struct device *dev, struct device_attribute *attr,
+			  char *buf)
+{
+	int nr = (to_sensor_dev_attr(attr))->index;
+	unsigned char val;
+
+	val = (fan_failed(dev, nr)) ? 1 : 0;
+
+	return sprintf(buf, "%d\n", val);
+}
+
+static ssize_t show_in(struct device *dev, struct device_attribute *attr,
+		       char *buf)
+{
+	int nr = (to_sensor_dev_attr(attr))->index;
+	struct gxp_fan_ctrl_drvdata *drvdata = dev_get_drvdata(dev);
+	unsigned char val;
+	unsigned int reg;
+
+	/* Check Power Status */
+	regmap_read(drvdata->fn2_map, 0, &reg);
+	if (reg & BIT(drvdata->data->power_bit)) {
+		/* If Fan presents, then read it. */
+		val = (fan_installed(dev, nr)) ? readb(drvdata->base +
+						       OFFSET_PWM0DUTY +
+						       nr) : 0;
+	} else {
+		/* Power Off */
+		val = 0;
+	}
+
+	return sprintf(buf, "%d\n", val);
+}
+
+static ssize_t show_pwm(struct device *dev, struct device_attribute *attr,
+			char *buf)
+{
+	int nr = (to_sensor_dev_attr(attr))->index;
+	struct gxp_fan_ctrl_drvdata *drvdata = dev_get_drvdata(dev);
+	unsigned char val;
+
+	val = readb(drvdata->base + OFFSET_PWM0DUTY + nr);
+
+	return sprintf(buf, "%d\n", val);
+}
+
+static ssize_t store_pwm(struct device *dev, struct device_attribute *attr,
+			 const char *buf, size_t count)
+{
+	int nr = (to_sensor_dev_attr(attr))->index;
+	struct gxp_fan_ctrl_drvdata *drvdata = dev_get_drvdata(dev);
+	unsigned long val;
+	int err;
+
+	err = kstrtoul(buf, 10, &val);
+	if (err)
+		return err;
+
+	if (val > 255)
+		return -1; /* out of range */
+
+	mutex_lock(&drvdata->update_lock);
+
+	writeb(val, drvdata->base + OFFSET_PWM0DUTY + nr);
+
+	mutex_unlock(&drvdata->update_lock);
+	return count;
+}
+
+static SENSOR_DEVICE_ATTR(pwm0, 0200 | 0444, show_pwm, store_pwm, 0);
+static SENSOR_DEVICE_ATTR(pwm1, 0200 | 0444, show_pwm, store_pwm, 1);
+static SENSOR_DEVICE_ATTR(pwm2, 0200 | 0444, show_pwm, store_pwm, 2);
+static SENSOR_DEVICE_ATTR(pwm3, 0200 | 0444, show_pwm, store_pwm, 3);
+static SENSOR_DEVICE_ATTR(pwm4, 0200 | 0444, show_pwm, store_pwm, 4);
+static SENSOR_DEVICE_ATTR(pwm5, 0200 | 0444, show_pwm, store_pwm, 5);
+static SENSOR_DEVICE_ATTR(pwm6, 0200 | 0444, show_pwm, store_pwm, 6);
+static SENSOR_DEVICE_ATTR(pwm7, 0200 | 0444, show_pwm, store_pwm, 7);
+static SENSOR_DEVICE_ATTR(pwm8, 0200 | 0444, show_pwm, store_pwm, 8);
+static SENSOR_DEVICE_ATTR(pwm9, 0200 | 0444, show_pwm, store_pwm, 9);
+static SENSOR_DEVICE_ATTR(pwm10, 0200 | 0444, show_pwm, store_pwm, 10);
+static SENSOR_DEVICE_ATTR(pwm11, 0200 | 0444, show_pwm, store_pwm, 11);
+static SENSOR_DEVICE_ATTR(pwm12, 0200 | 0444, show_pwm, store_pwm, 12);
+static SENSOR_DEVICE_ATTR(pwm13, 0200 | 0444, show_pwm, store_pwm, 13);
+static SENSOR_DEVICE_ATTR(pwm14, 0200 | 0444, show_pwm, store_pwm, 14);
+static SENSOR_DEVICE_ATTR(pwm15, 0200 | 0444, show_pwm, store_pwm, 15);
+
+static struct sensor_device_attribute sda_in_input[] = {
+	SENSOR_ATTR(fan0_input, 0444, show_in, NULL, 0),
+	SENSOR_ATTR(fan1_input, 0444, show_in, NULL, 1),
+	SENSOR_ATTR(fan2_input, 0444, show_in, NULL, 2),
+	SENSOR_ATTR(fan3_input, 0444, show_in, NULL, 3),
+	SENSOR_ATTR(fan4_input, 0444, show_in, NULL, 4),
+	SENSOR_ATTR(fan5_input, 0444, show_in, NULL, 5),
+	SENSOR_ATTR(fan6_input, 0444, show_in, NULL, 6),
+	SENSOR_ATTR(fan7_input, 0444, show_in, NULL, 7),
+	SENSOR_ATTR(fan8_input, 0444, show_in, NULL, 8),
+	SENSOR_ATTR(fan9_input, 0444, show_in, NULL, 9),
+	SENSOR_ATTR(fan10_input, 0444, show_in, NULL, 10),
+	SENSOR_ATTR(fan11_input, 0444, show_in, NULL, 11),
+	SENSOR_ATTR(fan12_input, 0444, show_in, NULL, 12),
+	SENSOR_ATTR(fan13_input, 0444, show_in, NULL, 13),
+	SENSOR_ATTR(fan14_input, 0444, show_in, NULL, 14),
+	SENSOR_ATTR(fan15_input, 0444, show_in, NULL, 15),
+};
+
+static SENSOR_DEVICE_ATTR(fan0_fault, 0444, show_fault, NULL, 0);
+static SENSOR_DEVICE_ATTR(fan1_fault, 0444, show_fault, NULL, 1);
+static SENSOR_DEVICE_ATTR(fan2_fault, 0444, show_fault, NULL, 2);
+static SENSOR_DEVICE_ATTR(fan3_fault, 0444, show_fault, NULL, 3);
+static SENSOR_DEVICE_ATTR(fan4_fault, 0444, show_fault, NULL, 4);
+static SENSOR_DEVICE_ATTR(fan5_fault, 0444, show_fault, NULL, 5);
+static SENSOR_DEVICE_ATTR(fan6_fault, 0444, show_fault, NULL, 6);
+static SENSOR_DEVICE_ATTR(fan7_fault, 0444, show_fault, NULL, 7);
+static SENSOR_DEVICE_ATTR(fan8_fault, 0444, show_fault, NULL, 8);
+static SENSOR_DEVICE_ATTR(fan9_fault, 0444, show_fault, NULL, 9);
+static SENSOR_DEVICE_ATTR(fan10_fault, 0444, show_fault, NULL, 10);
+static SENSOR_DEVICE_ATTR(fan11_fault, 0444, show_fault, NULL, 11);
+static SENSOR_DEVICE_ATTR(fan12_fault, 0444, show_fault, NULL, 12);
+static SENSOR_DEVICE_ATTR(fan13_fault, 0444, show_fault, NULL, 13);
+static SENSOR_DEVICE_ATTR(fan14_fault, 0444, show_fault, NULL, 14);
+static SENSOR_DEVICE_ATTR(fan15_fault, 0444, show_fault, NULL, 15);
+
+static struct attribute *gxp_fan_ctrl_attrs[] = {
+	&sensor_dev_attr_fan0_fault.dev_attr.attr,
+	&sensor_dev_attr_fan1_fault.dev_attr.attr,
+	&sensor_dev_attr_fan2_fault.dev_attr.attr,
+	&sensor_dev_attr_fan3_fault.dev_attr.attr,
+	&sensor_dev_attr_fan4_fault.dev_attr.attr,
+	&sensor_dev_attr_fan5_fault.dev_attr.attr,
+	&sensor_dev_attr_fan6_fault.dev_attr.attr,
+	&sensor_dev_attr_fan7_fault.dev_attr.attr,
+	&sensor_dev_attr_fan8_fault.dev_attr.attr,
+	&sensor_dev_attr_fan9_fault.dev_attr.attr,
+	&sensor_dev_attr_fan10_fault.dev_attr.attr,
+	&sensor_dev_attr_fan11_fault.dev_attr.attr,
+	&sensor_dev_attr_fan12_fault.dev_attr.attr,
+	&sensor_dev_attr_fan13_fault.dev_attr.attr,
+	&sensor_dev_attr_fan14_fault.dev_attr.attr,
+	&sensor_dev_attr_fan15_fault.dev_attr.attr,
+	&sda_in_input[0].dev_attr.attr,
+	&sda_in_input[1].dev_attr.attr,
+	&sda_in_input[2].dev_attr.attr,
+	&sda_in_input[3].dev_attr.attr,
+	&sda_in_input[4].dev_attr.attr,
+	&sda_in_input[5].dev_attr.attr,
+	&sda_in_input[6].dev_attr.attr,
+	&sda_in_input[7].dev_attr.attr,
+	&sda_in_input[8].dev_attr.attr,
+	&sda_in_input[9].dev_attr.attr,
+	&sda_in_input[10].dev_attr.attr,
+	&sda_in_input[11].dev_attr.attr,
+	&sda_in_input[12].dev_attr.attr,
+	&sda_in_input[13].dev_attr.attr,
+	&sda_in_input[14].dev_attr.attr,
+	&sda_in_input[15].dev_attr.attr,
+	&sensor_dev_attr_pwm0.dev_attr.attr,
+	&sensor_dev_attr_pwm1.dev_attr.attr,
+	&sensor_dev_attr_pwm2.dev_attr.attr,
+	&sensor_dev_attr_pwm3.dev_attr.attr,
+	&sensor_dev_attr_pwm4.dev_attr.attr,
+	&sensor_dev_attr_pwm5.dev_attr.attr,
+	&sensor_dev_attr_pwm6.dev_attr.attr,
+	&sensor_dev_attr_pwm7.dev_attr.attr,
+	&sensor_dev_attr_pwm8.dev_attr.attr,
+	&sensor_dev_attr_pwm9.dev_attr.attr,
+	&sensor_dev_attr_pwm10.dev_attr.attr,
+	&sensor_dev_attr_pwm11.dev_attr.attr,
+	&sensor_dev_attr_pwm12.dev_attr.attr,
+	&sensor_dev_attr_pwm13.dev_attr.attr,
+	&sensor_dev_attr_pwm14.dev_attr.attr,
+	&sensor_dev_attr_pwm15.dev_attr.attr,
+	NULL,
+};
+
+ATTRIBUTE_GROUPS(gxp_fan_ctrl);
+
+static struct regmap *gxp_fan_ctrl_init_regmap(struct platform_device *pdev, char *reg_name)
+{
+	struct regmap_config regmap_config = {
+		.reg_bits = 32,
+		.reg_stride = 4,
+		.val_bits = 32,
+	};
+	void __iomem *base;
+
+	base = devm_platform_ioremap_resource_byname(pdev, reg_name);
+	if (IS_ERR(base))
+		return ERR_CAST(base);
+
+	regmap_config.name = reg_name;
+
+	return devm_regmap_init_mmio(&pdev->dev, base, &regmap_config);
+}
+
+static int gxp_fan_ctrl_probe(struct platform_device *pdev)
+{
+	struct gxp_fan_ctrl_drvdata *drvdata;
+	struct resource *res;
+	struct device *dev = &pdev->dev;
+
+	drvdata = devm_kzalloc(&pdev->dev, sizeof(struct gxp_fan_ctrl_drvdata),
+			       GFP_KERNEL);
+	if (!drvdata)
+		return -ENOMEM;
+
+	drvdata->dev = &pdev->dev;
+
+	drvdata->data = of_device_get_match_data(&pdev->dev);
+
+	platform_set_drvdata(pdev, drvdata);
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	drvdata->base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(drvdata->base))
+		return dev_err_probe(dev, PTR_ERR(drvdata->base),
+				     "failed to map base\n");
+	drvdata->plreg_map = gxp_fan_ctrl_init_regmap(pdev, "plreg");
+	if (IS_ERR(drvdata->plreg_map))
+		return dev_err_probe(dev, PTR_ERR(drvdata->plreg_map),
+				     "failed to map plreg_handle\n");
+
+	drvdata->fn2_map = gxp_fan_ctrl_init_regmap(pdev, "fn2reg");
+	if (IS_ERR(drvdata->fn2_map))
+		return dev_err_probe(dev, PTR_ERR(drvdata->fn2_map),
+				     "failed to map fn2_handle\n");
+
+	mutex_init(&drvdata->update_lock);
+
+	drvdata->hwmon_dev = devm_hwmon_device_register_with_groups(&pdev->dev,
+								    "fan_ctrl",
+								    drvdata,
+								    gxp_fan_ctrl_groups);
+
+	return PTR_ERR_OR_ZERO(drvdata->hwmon_dev);
+}
+
+static const struct fan_ctrl_data g10_data = {
+	.fan[0] = { .inst = 0x00, .fail = 0x02, .id = 0x04, .bit = 0x01 },
+	.fan[1] = { .inst = 0x00, .fail = 0x02, .id = 0x04, .bit = 0x02 },
+	.fan[2] = { .inst = 0x00, .fail = 0x02, .id = 0x04, .bit = 0x04 },
+	.fan[3] = { .inst = 0x00, .fail = 0x02, .id = 0x04, .bit = 0x08 },
+	.fan[4] = { .inst = 0x00, .fail = 0x02, .id = 0x04, .bit = 0x10 },
+	.fan[5] = { .inst = 0x00, .fail = 0x02, .id = 0x04, .bit = 0x20 },
+	.fan[6] = { .inst = 0x00, .fail = 0x02, .id = 0x04, .bit = 0x40 },
+	.fan[7] = { .inst = 0x00, .fail = 0x02, .id = 0x04, .bit = 0x80 },
+	.fan[8] = { .inst = 0x01, .fail = 0x03, .id = 0x05, .bit = 0x01 },
+	.fan[9] = { .inst = 0x01, .fail = 0x03, .id = 0x05, .bit = 0x02 },
+	.fan[10] = { .inst = 0x01, .fail = 0x03, .id = 0x05, .bit = 0x04 },
+	.fan[11] = { .inst = 0x01, .fail = 0x03, .id = 0x05, .bit = 0x08 },
+	.fan[12] = { .inst = 0x01, .fail = 0x03, .id = 0x05, .bit = 0x10 },
+	.fan[13] = { .inst = 0x01, .fail = 0x03, .id = 0x05, .bit = 0x20 },
+	.fan[14] = { .inst = 0x01, .fail = 0x03, .id = 0x05, .bit = 0x40 },
+	.fan[15] = { .inst = 0x01, .fail = 0x03, .id = 0x05, .bit = 0x80 },
+	.power_bit = 24,
+};
+
+static const struct of_device_id gxp_fan_ctrl_of_match[] = {
+	{ .compatible = "hpe,gxp-fan-ctrl", .data = &g10_data },
+	{},
+};
+MODULE_DEVICE_TABLE(of, gxp_fan_ctrl_of_match);
+
+static struct platform_driver gxp_fan_ctrl_driver = {
+	.probe		= gxp_fan_ctrl_probe,
+	.driver = {
+		.name	= "gxp-fan-ctrl",
+		.of_match_table = gxp_fan_ctrl_of_match,
+	},
+};
+module_platform_driver(gxp_fan_ctrl_driver);
+
+MODULE_AUTHOR("Nick Hawkins <nick.hawkins@hpe.com>");
+MODULE_DESCRIPTION("HPE GXP Fan Ctrl driver");
+MODULE_LICENSE("GPL");
-- 
2.17.1

