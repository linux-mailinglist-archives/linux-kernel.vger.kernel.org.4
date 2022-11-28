Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39A1A63B595
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 00:04:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234420AbiK1XEn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 18:04:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234538AbiK1XE0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 18:04:26 -0500
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E7F72C103;
        Mon, 28 Nov 2022 15:04:25 -0800 (PST)
Received: from pps.filterd (m0134422.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2ASLXlBX023374;
        Mon, 28 Nov 2022 23:03:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : subject :
 date : message-id : in-reply-to : references; s=pps0720;
 bh=I+8ZPqA+Mk7OX+uGOemUMsAF9IijmZ08o+d7ve+/0GU=;
 b=DLwNgOExSocNtcwCbjyv8GGMIXwr5dCmDxABABlpSOHJMAVD6ANhydD1kcezuBXDX3s8
 zCq2od0md3wLABiNvCW3y3rq/WWN3xcJK3RbNUIEK+1h/mrTNczag0DoXrQBFCWbNbft
 VMdybHuAd6n6kWEmWG2AKYsDvZkkrV0WbeWqiUhh3yW7PdyrzjJcNXAmumtUNIo8Vi/g
 kJJg2cNJcnxrbVbLBdw+e0VVzmxxhCGEeyv8yf2MPIo+KwGfHKg5P+m8HevE8KwyaY89
 wEs466ctcwDdVSDAnbqk/14eCJSNy9sp8dNOIF6Ws3QZQKTv0srGHOfzAEYntJ8AY3vs 6g== 
Received: from p1lg14881.it.hpe.com (p1lg14881.it.hpe.com [16.230.97.202])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3m51axt8aq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Nov 2022 23:03:48 +0000
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14881.it.hpe.com (Postfix) with ESMTPS id 4C4E0801ADE;
        Mon, 28 Nov 2022 23:03:48 +0000 (UTC)
Received: from hpe.com (unknown [16.231.227.36])
        by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTP id BC40D8084C7;
        Mon, 28 Nov 2022 23:03:47 +0000 (UTC)
From:   nick.hawkins@hpe.com
To:     jdelvare@suse.com, linux@roeck-us.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, verdun@hpe.com,
        nick.hawkins@hpe.com, corbet@lwn.net, linux@armlinux.org.uk,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 1/6] hwmon: (gxp-fan-ctrl) Add GXP fan controller
Date:   Mon, 28 Nov 2022 17:02:14 -0600
Message-Id: <20221128230219.39537-2-nick.hawkins@hpe.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221128230219.39537-1-nick.hawkins@hpe.com>
References: <20221128230219.39537-1-nick.hawkins@hpe.com>
X-Proofpoint-GUID: MFB_z8x_8qqw3MuOVwI9mQf83Q3CSmHa
X-Proofpoint-ORIG-GUID: MFB_z8x_8qqw3MuOVwI9mQf83Q3CSmHa
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-28_17,2022-11-28_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 impostorscore=0 phishscore=0 adultscore=0 clxscore=1011 suspectscore=0
 mlxscore=0 bulkscore=0 spamscore=0 mlxlogscore=999 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211280166
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nick Hawkins <nick.hawkins@hpe.com>

The GXP SoC can support up to 16 fans through the interface provided by
the CPLD. The current support is limited to 8 fans. The fans speeds are
controlled via 8 different PWMs which can vary in value from  0-255. The
fans are also capable of reporting if they have failed to the CPLD which
in turn reports the status to the GXP SoC.

Signed-off-by: Nick Hawkins <nick.hawkins@hpe.com>

---

v2:
 *Changed number of supported fans from 16 to 8 in code
 *Remove last sentence of commit description
 *Removed support for fan[0-15]_input in code and documentation
 *Changed documentation to limit fan count to 7
 *Changed documentation license
 *Removed PWM defines
 *Added gxp-fan-ctrl to hwmon's index.rst
 *Removed mutex
 *Added fan_enable support to report if the fan is enabled
 *Changed presents to present
 *Removed unnecessary ()
 *Add comment for plreg reads and calculations
 *Add comment for the use of platform power state in code
 *Removed use of variable offsets and went with hardcoding instead
 *Rewrote driver to use devm_hwmon_device_register_with_info()
 *Remove unused header files
 *Fix GPL header
 *Changed module description
 *Add kfree in case of failure to get regmaps or resource
---
 Documentation/hwmon/gxp-fan-ctrl.rst |  28 +++
 Documentation/hwmon/index.rst        |   1 +
 drivers/hwmon/Kconfig                |   9 +
 drivers/hwmon/Makefile               |   1 +
 drivers/hwmon/gxp-fan-ctrl.c         | 305 +++++++++++++++++++++++++++
 5 files changed, 344 insertions(+)
 create mode 100644 Documentation/hwmon/gxp-fan-ctrl.rst
 create mode 100644 drivers/hwmon/gxp-fan-ctrl.c

diff --git a/Documentation/hwmon/gxp-fan-ctrl.rst b/Documentation/hwmon/gxp-fan-ctrl.rst
new file mode 100644
index 000000000000..ae3397e81c04
--- /dev/null
+++ b/Documentation/hwmon/gxp-fan-ctrl.rst
@@ -0,0 +1,28 @@
+.. SPDX-License-Identifier: GPL-2.0-only
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
+PWM control.
+
+
+Sysfs attributes
+----------------
+
+======================= ===========================================================
+pwm[0-7]		Fan 0 to 7 respective PWM value (0-255)
+fan[0-7]_fault		Fan 0 to 7 respective fault status: 1 fail, 0 ok
+fan[0-7]_enable         Fan 0 to 7 respective enabled status: 1 enabled, 0 disabled
+======================= ===========================================================
diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.rst
index f7113b0f8b2a..b319ab173d1d 100644
--- a/Documentation/hwmon/index.rst
+++ b/Documentation/hwmon/index.rst
@@ -73,6 +73,7 @@ Hardware Monitoring Kernel Drivers
    g762
    gsc-hwmon
    gl518sm
+   gxp-fan-ctrl
    hih6130
    ibmaem
    ibm-cffps
diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index e70d9614bec2..9e0427f20141 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -705,6 +705,15 @@ config SENSORS_GPIO_FAN
 	  This driver can also be built as a module. If so, the module
 	  will be called gpio-fan.
 
+config SENSORS_GXP_FAN_CTRL
+	tristate "HPE GXP fan controller"
+	depends on ARCH_HPE_GXP || COMPILE_TEST
+	help
+	  If you say yes here you get support for GXP fan control functionality.
+
+	  The GXP controls fan function via the CPLD through the use of PWM
+	  registers. This driver reports status and pwm setting of the fans.
+
 config SENSORS_HIH6130
 	tristate "Honeywell Humidicon HIH-6130 humidity/temperature sensor"
 	depends on I2C
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
index 000000000000..0b03d33a3a7b
--- /dev/null
+++ b/drivers/hwmon/gxp-fan-ctrl.c
@@ -0,0 +1,305 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (C) 2022 Hewlett-Packard Enterprise Development Company, L.P. */
+
+#include <linux/err.h>
+#include <linux/hwmon.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/slab.h>
+
+#define OFS_FAN_INST 0 /* Is 0 because plreg base will be set at INST */
+#define OFS_FAN_FAIL 2 /* Is 2 bytes after base */
+#define OFS_SEVSTAT 0 /* Is 0 because fn2 base will be set at SEVSTAT */
+#define POWER_BIT 24
+
+struct gxp_fan_ctrl_drvdata {
+	struct device	*dev;
+	struct device	*hwmon_dev;
+	struct regmap	*plreg_map; /* Programmable logic register regmap */
+	struct regmap	*fn2_map; /* Function 2 regmap */
+	void __iomem	*base;
+};
+
+static bool fan_installed(struct device *dev, int fan)
+{
+	struct gxp_fan_ctrl_drvdata *drvdata = dev_get_drvdata(dev);
+	u32 val;
+
+	regmap_read(drvdata->plreg_map, OFS_FAN_INST, &val);
+	if (val & BIT(fan))
+		return 1;
+	else
+		return 0;
+}
+
+static long fan_failed(struct device *dev, int fan)
+{
+	struct gxp_fan_ctrl_drvdata *drvdata = dev_get_drvdata(dev);
+	u32 val;
+
+	/*
+	 * The offset for fan fail is 2 which is not word aligned.
+	 * Read from fan installed which is 0 and shift value.
+	 */
+
+	regmap_read(drvdata->plreg_map, OFS_FAN_INST, &val);
+
+	if ((val >> (8 * OFS_FAN_FAIL)) & BIT(fan))
+		return 1;
+	else
+		return 0;
+}
+
+static long fan_enabled(struct device *dev, int fan)
+{
+	struct gxp_fan_ctrl_drvdata *drvdata = dev_get_drvdata(dev);
+	unsigned int reg;
+
+	/*
+	 * Check the power status as if the platform is off the value
+	 * reported for the PWM will be incorrect. Report fan as
+	 * disabled.
+	 */
+	regmap_read(drvdata->fn2_map, OFS_SEVSTAT, &reg);
+
+	/* If Fan is installed and the system is on it is enabled */
+	if ((reg & BIT(POWER_BIT)) && fan_installed(dev, fan))
+		return  1;
+
+	/* Platform power is off, fan is disabled */
+	return 0;
+}
+
+static int gxp_pwm_write(struct device *dev, u32 attr, int channel, long val)
+{
+	struct gxp_fan_ctrl_drvdata *drvdata = dev_get_drvdata(dev);
+
+	switch (attr) {
+	case hwmon_pwm_input:
+		if (val > 255)
+			return -EINVAL;
+		writeb(val, drvdata->base + channel);
+		return 0;
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static int gxp_fan_ctrl_write(struct device *dev, enum hwmon_sensor_types type,
+			      u32 attr, int channel, long val)
+{
+	switch (type) {
+	case hwmon_pwm:
+		return gxp_pwm_write(dev, attr, channel, val);
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static int gxp_fan_read(struct device *dev, u32 attr, int channel, long *val)
+{
+	switch (attr) {
+	case hwmon_fan_enable:
+		*val = fan_enabled(dev, channel);
+		return 0;
+	case hwmon_fan_fault:
+		*val = fan_failed(dev, channel);
+		return 0;
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static int gxp_pwm_read(struct device *dev, u32 attr, int channel, long *val)
+{
+	struct gxp_fan_ctrl_drvdata *drvdata = dev_get_drvdata(dev);
+	unsigned int reg;
+
+	/*
+	 * Check the power status of the platform. If the platform is off
+	 * the value reported for the PWM will be incorrect. In this case
+	 * report a PWM of zero.
+	 */
+	regmap_read(drvdata->fn2_map, 0, &reg);
+	if (reg & BIT(POWER_BIT)) {
+		/* If Fan present, then read it. */
+		*val = fan_installed(dev, channel) ? readb(drvdata->base + channel) : 0;
+	} else {
+		*val = 0;
+	}
+
+	return 0;
+}
+
+static int gxp_fan_ctrl_read(struct device *dev, enum hwmon_sensor_types type,
+			     u32 attr, int channel, long *val)
+{
+	switch (type) {
+	case hwmon_fan:
+		return gxp_fan_read(dev, attr, channel, val);
+	case hwmon_pwm:
+		return gxp_pwm_read(dev, attr, channel, val);
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static umode_t gxp_fan_ctrl_is_visible(const void *_data,
+				       enum hwmon_sensor_types type,
+				       u32 attr, int channel)
+{
+	umode_t mode = 0;
+
+	switch (type) {
+	case hwmon_fan:
+		switch (attr) {
+		case hwmon_fan_enable:
+		case hwmon_fan_fault:
+			mode = 0444;
+		default:
+			break;
+		}
+	case hwmon_pwm:
+		switch (attr) {
+		case hwmon_pwm_input:
+			mode = 0644;
+		default:
+			break;
+		}
+	default:
+		break;
+	}
+
+	return mode;
+}
+
+static const struct hwmon_ops gxp_fan_ctrl_ops = {
+	.is_visible = gxp_fan_ctrl_is_visible,
+	.read = gxp_fan_ctrl_read,
+	.write = gxp_fan_ctrl_write,
+};
+
+static const struct hwmon_channel_info *gxp_fan_ctrl_info[] = {
+	HWMON_CHANNEL_INFO(fan,
+			   HWMON_F_FAULT | HWMON_F_ENABLE,
+			   HWMON_F_FAULT | HWMON_F_ENABLE,
+			   HWMON_F_FAULT | HWMON_F_ENABLE,
+			   HWMON_F_FAULT | HWMON_F_ENABLE,
+			   HWMON_F_FAULT | HWMON_F_ENABLE,
+			   HWMON_F_FAULT | HWMON_F_ENABLE,
+			   HWMON_F_FAULT | HWMON_F_ENABLE,
+			   HWMON_F_FAULT | HWMON_F_ENABLE),
+	HWMON_CHANNEL_INFO(pwm,
+			   HWMON_PWM_INPUT | HWMON_PWM_ENABLE,
+			   HWMON_PWM_INPUT | HWMON_PWM_ENABLE,
+			   HWMON_PWM_INPUT | HWMON_PWM_ENABLE,
+			   HWMON_PWM_INPUT | HWMON_PWM_ENABLE,
+			   HWMON_PWM_INPUT | HWMON_PWM_ENABLE,
+			   HWMON_PWM_INPUT | HWMON_PWM_ENABLE,
+			   HWMON_PWM_INPUT | HWMON_PWM_ENABLE,
+			   HWMON_PWM_INPUT | HWMON_PWM_ENABLE),
+	NULL
+};
+
+static const struct hwmon_chip_info gxp_fan_ctrl_chip_info = {
+	.ops = &gxp_fan_ctrl_ops,
+	.info = gxp_fan_ctrl_info,
+
+};
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
+	int error;
+
+	drvdata = devm_kzalloc(&pdev->dev, sizeof(struct gxp_fan_ctrl_drvdata),
+			       GFP_KERNEL);
+	if (!drvdata)
+		return -ENOMEM;
+
+	drvdata->dev = &pdev->dev;
+
+	platform_set_drvdata(pdev, drvdata);
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	drvdata->base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(drvdata->base)) {
+		error = dev_err_probe(dev, PTR_ERR(drvdata->base),
+				      "failed to map base\n");
+		goto free_mem;
+	}
+	drvdata->plreg_map = gxp_fan_ctrl_init_regmap(pdev, "pl");
+	if (IS_ERR(drvdata->plreg_map)) {
+		error = dev_err_probe(dev, PTR_ERR(drvdata->plreg_map),
+				      "failed to map plreg_handle\n");
+		goto free_mem;
+	}
+
+	drvdata->fn2_map = gxp_fan_ctrl_init_regmap(pdev, "fn2");
+	if (IS_ERR(drvdata->fn2_map)) {
+		error = dev_err_probe(dev, PTR_ERR(drvdata->fn2_map),
+				      "failed to map fn2_handle\n");
+		goto free_mem;
+	}
+
+	drvdata->hwmon_dev = devm_hwmon_device_register_with_info(&pdev->dev,
+								  "fan_ctrl",
+								  drvdata,
+								  &gxp_fan_ctrl_chip_info,
+								  NULL);
+
+	if (IS_ERR(drvdata->hwmon_dev)) {
+		error = dev_err_probe(dev, PTR_ERR(drvdata->hwmon_dev),
+				      "failed to register fan ctrl\n");
+
+		goto free_mem;
+	}
+
+	return 0;
+
+free_mem:
+	kfree(drvdata);
+	return error;
+}
+
+static const struct of_device_id gxp_fan_ctrl_of_match[] = {
+	{ .compatible = "hpe,gxp-fan-ctrl", },
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
+MODULE_DESCRIPTION("HPE GXP fan controller");
+MODULE_LICENSE("GPL");
-- 
2.17.1

