Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEC3D718637
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 17:24:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234457AbjEaPYD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 11:24:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232075AbjEaPXr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 11:23:47 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCA35121;
        Wed, 31 May 2023 08:23:38 -0700 (PDT)
Received: from pps.filterd (m0148663.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34VE7EYL016921;
        Wed, 31 May 2023 15:23:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : subject :
 date : message-id : in-reply-to : references; s=pps0720;
 bh=65CUvzbH90KUZ6KAklqHR/S7Q/djK4GczcJKvWNV2lg=;
 b=OYirYXu/K1nAWrgBLJqzlDnse2ADnwEkTFn3zK/+OsbzEuHTFDMiY2ulpUvGblMfAl6f
 twqKx3GyHCNjo661bVaM0NDMTa308M563YH350I1fygZuQVrIuR/rWhYfugMimZnWTFc
 rsUC4KN8fl0ViVWaR8YcBg/Zr2FoAarVEGxK9374j+fgkV0+JOhBUyT8sFLr4ifA2kYZ
 lRLdq3bGl9pc4WZdSxgnWEEXNdJL/nxL5G72S5WkQcA46adUM1bxvqg59pVtFjU4smtH
 iI1BiE76z+UJQCUIKzHxz/Q9hBUDvqUNlNgJAri/gmuJSy1WhHuPLXuL42u/5grdt231 Sw== 
Received: from p1lg14880.it.hpe.com (p1lg14880.it.hpe.com [16.230.97.201])
        by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 3qx7qdrngy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 31 May 2023 15:23:15 +0000
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14880.it.hpe.com (Postfix) with ESMTPS id 67CEB800220;
        Wed, 31 May 2023 15:23:14 +0000 (UTC)
Received: from hpe.com (unknown [16.231.227.36])
        by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTP id D5B2980B983;
        Wed, 31 May 2023 15:23:13 +0000 (UTC)
From:   nick.hawkins@hpe.com
To:     verdun@hpe.com, nick.hawkins@hpe.com, linus.walleij@linaro.org,
        brgl@bgdev.pl, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, jdelvare@suse.com,
        linux@roeck-us.net, andy.shevchenko@gmail.com,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org
Subject: [PATCH v2 4/5] hwmon: (gxp_fan_ctrl) Provide fan info via gpio
Date:   Wed, 31 May 2023 10:19:17 -0500
Message-Id: <20230531151918.105223-5-nick.hawkins@hpe.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230531151918.105223-1-nick.hawkins@hpe.com>
References: <20230531151918.105223-1-nick.hawkins@hpe.com>
X-Proofpoint-ORIG-GUID: XQHoRmjfMi10zvqCfkxzJCL_Lqlvk2ls
X-Proofpoint-GUID: XQHoRmjfMi10zvqCfkxzJCL_Lqlvk2ls
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-31_10,2023-05-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 bulkscore=0 mlxlogscore=589 clxscore=1015 adultscore=0 malwarescore=0
 suspectscore=0 lowpriorityscore=0 spamscore=0 phishscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305310131
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nick Hawkins <nick.hawkins@hpe.com>

The fan driver now receives fan data from GPIO via a shared variable.
This is a necessity as the Host and the driver need access to the same
information. Part of the changes includes removing a system power check
as the GPIO driver needs it to report power state to host.

Signed-off-by: Nick Hawkins <nick.hawkins@hpe.com>

---

v2:
 *Removed use of shared functions to GPIO in favor of a shared variable
 *Added build dependency on GXP GPIO driver.
---
 drivers/hwmon/Kconfig        |  2 +-
 drivers/hwmon/gxp-fan-ctrl.c | 61 +++++-------------------------------
 drivers/hwmon/gxp-gpio.h     | 13 ++++++++
 3 files changed, 21 insertions(+), 55 deletions(-)
 create mode 100644 drivers/hwmon/gxp-gpio.h

diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 5b3b76477b0e..5c606bea31f9 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -716,7 +716,7 @@ config SENSORS_GPIO_FAN
 
 config SENSORS_GXP_FAN_CTRL
 	tristate "HPE GXP fan controller"
-	depends on ARCH_HPE_GXP || COMPILE_TEST
+	depends on (ARCH_HPE_GXP  && GPIO_GXP_PL) || COMPILE_TEST
 	help
 	  If you say yes here you get support for GXP fan control functionality.
 
diff --git a/drivers/hwmon/gxp-fan-ctrl.c b/drivers/hwmon/gxp-fan-ctrl.c
index 0014b8b0fd41..8555231328d7 100644
--- a/drivers/hwmon/gxp-fan-ctrl.c
+++ b/drivers/hwmon/gxp-fan-ctrl.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-only
-/* Copyright (C) 2022 Hewlett-Packard Enterprise Development Company, L.P. */
+/* Copyright (C) 2023 Hewlett-Packard Enterprise Development Company, L.P. */
 
 #include <linux/bits.h>
 #include <linux/err.h>
@@ -8,51 +8,28 @@
 #include <linux/module.h>
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
+#include "gxp-gpio.h"
 
 #define OFS_FAN_INST	0 /* Is 0 because plreg base will be set at INST */
 #define OFS_FAN_FAIL	2 /* Is 2 bytes after base */
-#define OFS_SEVSTAT	0 /* Is 0 because fn2 base will be set at SEVSTAT */
-#define POWER_BIT	24
 
 struct gxp_fan_ctrl_drvdata {
-	void __iomem	*base;
-	void __iomem	*plreg;
-	void __iomem	*fn2;
+	void __iomem *base;
 };
 
 static bool fan_installed(struct device *dev, int fan)
 {
-	struct gxp_fan_ctrl_drvdata *drvdata = dev_get_drvdata(dev);
-	u8 val;
-
-	val = readb(drvdata->plreg + OFS_FAN_INST);
-
-	return !!(val & BIT(fan));
+	return !!(fan_presence & BIT(fan));
 }
 
 static long fan_failed(struct device *dev, int fan)
 {
-	struct gxp_fan_ctrl_drvdata *drvdata = dev_get_drvdata(dev);
-	u8 val;
-
-	val = readb(drvdata->plreg + OFS_FAN_FAIL);
-
-	return !!(val & BIT(fan));
+	return !!(fan_fail & BIT(fan));
 }
 
 static long fan_enabled(struct device *dev, int fan)
 {
-	struct gxp_fan_ctrl_drvdata *drvdata = dev_get_drvdata(dev);
-	u32 val;
-
-	/*
-	 * Check the power status as if the platform is off the value
-	 * reported for the PWM will be incorrect. Report fan as
-	 * disabled.
-	 */
-	val = readl(drvdata->fn2 + OFS_SEVSTAT);
-
-	return !!((val & BIT(POWER_BIT)) && fan_installed(dev, fan));
+	return !!(fan_installed(dev, fan));
 }
 
 static int gxp_pwm_write(struct device *dev, u32 attr, int channel, long val)
@@ -98,20 +75,8 @@ static int gxp_fan_read(struct device *dev, u32 attr, int channel, long *val)
 static int gxp_pwm_read(struct device *dev, u32 attr, int channel, long *val)
 {
 	struct gxp_fan_ctrl_drvdata *drvdata = dev_get_drvdata(dev);
-	u32 reg;
 
-	/*
-	 * Check the power status of the platform. If the platform is off
-	 * the value reported for the PWM will be incorrect. In this case
-	 * report a PWM of zero.
-	 */
-
-	reg = readl(drvdata->fn2 + OFS_SEVSTAT);
-
-	if (reg & BIT(POWER_BIT))
-		*val = fan_installed(dev, channel) ? readb(drvdata->base + channel) : 0;
-	else
-		*val = 0;
+	*val = fan_installed(dev, channel) ? readb(drvdata->base + channel) : 0;
 
 	return 0;
 }
@@ -212,18 +177,6 @@ static int gxp_fan_ctrl_probe(struct platform_device *pdev)
 		return dev_err_probe(dev, PTR_ERR(drvdata->base),
 				     "failed to map base\n");
 
-	drvdata->plreg = devm_platform_ioremap_resource_byname(pdev,
-							       "pl");
-	if (IS_ERR(drvdata->plreg))
-		return dev_err_probe(dev, PTR_ERR(drvdata->plreg),
-				     "failed to map plreg\n");
-
-	drvdata->fn2 = devm_platform_ioremap_resource_byname(pdev,
-							     "fn2");
-	if (IS_ERR(drvdata->fn2))
-		return dev_err_probe(dev, PTR_ERR(drvdata->fn2),
-				     "failed to map fn2\n");
-
 	hwmon_dev = devm_hwmon_device_register_with_info(&pdev->dev,
 							 "hpe_gxp_fan_ctrl",
 							 drvdata,
diff --git a/drivers/hwmon/gxp-gpio.h b/drivers/hwmon/gxp-gpio.h
new file mode 100644
index 000000000000..88abe60bbe83
--- /dev/null
+++ b/drivers/hwmon/gxp-gpio.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright (C) 2023 Hewlett-Packard Enterprise Development Company, L.P. */
+
+#ifndef __GPIO_GXP_H__
+#define __GPIO_GXP_H__
+
+#include <linux/err.h>
+
+/* Data provided by GPIO */
+extern u8 fan_presence;
+extern u8 fan_fail;
+
+#endif /* __GPIO_GXP_H__ */
-- 
2.17.1

