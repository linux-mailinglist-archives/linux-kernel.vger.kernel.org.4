Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 338357391B0
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 23:36:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230453AbjFUVgH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 17:36:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230386AbjFUVfy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 17:35:54 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13E2919AC;
        Wed, 21 Jun 2023 14:35:51 -0700 (PDT)
Received: from pps.filterd (m0134424.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35LEDeNQ021621;
        Wed, 21 Jun 2023 21:35:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : subject :
 date : message-id : in-reply-to : references; s=pps0720;
 bh=7Qr3ATq8CjKK5O+7nhui+tllgidlImf8ZWEtB9ITk6s=;
 b=GQfLYw+7vnvk6tvsdBJb9evMMi8bvwXwaZZA9a9YwuaeWqsgvlK4LCIofwjOw8sQhNSz
 ZcdlLzbF7BxnM8R5IcLfWR+ygramuWoqevXzrjDEe+iyN6R4lSsu2DzK9ldn+xrzyJ8V
 5kSucfw3DmcOBA90mI4w8d8XaThoJMi1K7fjRX6pY6Zj+8eiUx+it31IV3bPTcTlwRca
 WbqYVhJebRgYUNCIDfCEG6ENHhydVFvSHzr/atG6uRQgB1j//0mP69TbH7XFbW3KaOtu
 VB3EZqdtFMfCa/KZS201W9DwhsnxZPdo0vNWWeVM5FrawepPULdmBbomwogD4zpEzO3s VQ== 
Received: from p1lg14879.it.hpe.com (p1lg14879.it.hpe.com [16.230.97.200])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3rc2smbfxp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Jun 2023 21:35:26 +0000
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14879.it.hpe.com (Postfix) with ESMTPS id 9A16412B48;
        Wed, 21 Jun 2023 21:35:25 +0000 (UTC)
Received: from hpe.com (unknown [16.231.227.36])
        by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTP id 1646580F2AB;
        Wed, 21 Jun 2023 21:35:25 +0000 (UTC)
From:   nick.hawkins@hpe.com
To:     verdun@hpe.com, nick.hawkins@hpe.com, linus.walleij@linaro.org,
        brgl@bgdev.pl, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, jdelvare@suse.com,
        linux@roeck-us.net, andy.shevchenko@gmail.com,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org
Subject: [PATCH v4 4/5] hwmon: (gxp_fan_ctrl) Provide fan info via gpio
Date:   Wed, 21 Jun 2023 16:31:14 -0500
Message-Id: <20230621213115.113266-5-nick.hawkins@hpe.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230621213115.113266-1-nick.hawkins@hpe.com>
References: <20230621213115.113266-1-nick.hawkins@hpe.com>
X-Proofpoint-ORIG-GUID: qppe19gE22yrJ4mUwYZaRK67_JvqI9d3
X-Proofpoint-GUID: qppe19gE22yrJ4mUwYZaRK67_JvqI9d3
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-21_12,2023-06-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1015
 adultscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=761 bulkscore=0 phishscore=0 suspectscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306210181
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

The fan driver now is independent of the fan plreg GPIO information.
Therefore there will no longer be presence or fail information available
from the driver. Part of the changes includes removing a system power check
as the GPIO driver needs it to report power state to host.

Signed-off-by: Nick Hawkins <nick.hawkins@hpe.com>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>

---

v4:
 *No change, Added Reviewed-by:
v3:
 *Removed shared variable
 *Removed GPIO dependency on Kconfig
 *Removed present and failure checks surrounding Fans sysfs
v2:
 *Removed use of shared functions to GPIO in favor of a shared variable
 *Added build dependency on GXP GPIO driver.
---
 drivers/hwmon/Kconfig        |   2 +-
 drivers/hwmon/gxp-fan-ctrl.c | 108 +----------------------------------
 2 files changed, 4 insertions(+), 106 deletions(-)

diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 5b3b76477b0e..196ce88d2db9 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -721,7 +721,7 @@ config SENSORS_GXP_FAN_CTRL
 	  If you say yes here you get support for GXP fan control functionality.
 
 	  The GXP controls fan function via the CPLD through the use of PWM
-	  registers. This driver reports status and pwm setting of the fans.
+	  registers. This driver enables pwm setting of the fans.
 
 config SENSORS_HIH6130
 	tristate "Honeywell Humidicon HIH-6130 humidity/temperature sensor"
diff --git a/drivers/hwmon/gxp-fan-ctrl.c b/drivers/hwmon/gxp-fan-ctrl.c
index 0014b8b0fd41..55a10c7fc9d6 100644
--- a/drivers/hwmon/gxp-fan-ctrl.c
+++ b/drivers/hwmon/gxp-fan-ctrl.c
@@ -1,7 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
-/* Copyright (C) 2022 Hewlett-Packard Enterprise Development Company, L.P. */
+/* Copyright (C) 2023 Hewlett-Packard Enterprise Development Company, L.P. */
 
-#include <linux/bits.h>
 #include <linux/err.h>
 #include <linux/hwmon.h>
 #include <linux/io.h>
@@ -9,52 +8,10 @@
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
 
-#define OFS_FAN_INST	0 /* Is 0 because plreg base will be set at INST */
-#define OFS_FAN_FAIL	2 /* Is 2 bytes after base */
-#define OFS_SEVSTAT	0 /* Is 0 because fn2 base will be set at SEVSTAT */
-#define POWER_BIT	24
-
 struct gxp_fan_ctrl_drvdata {
-	void __iomem	*base;
-	void __iomem	*plreg;
-	void __iomem	*fn2;
+	void __iomem *base;
 };
 
-static bool fan_installed(struct device *dev, int fan)
-{
-	struct gxp_fan_ctrl_drvdata *drvdata = dev_get_drvdata(dev);
-	u8 val;
-
-	val = readb(drvdata->plreg + OFS_FAN_INST);
-
-	return !!(val & BIT(fan));
-}
-
-static long fan_failed(struct device *dev, int fan)
-{
-	struct gxp_fan_ctrl_drvdata *drvdata = dev_get_drvdata(dev);
-	u8 val;
-
-	val = readb(drvdata->plreg + OFS_FAN_FAIL);
-
-	return !!(val & BIT(fan));
-}
-
-static long fan_enabled(struct device *dev, int fan)
-{
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
-}
-
 static int gxp_pwm_write(struct device *dev, u32 attr, int channel, long val)
 {
 	struct gxp_fan_ctrl_drvdata *drvdata = dev_get_drvdata(dev);
@@ -81,37 +38,11 @@ static int gxp_fan_ctrl_write(struct device *dev, enum hwmon_sensor_types type,
 	}
 }
 
-static int gxp_fan_read(struct device *dev, u32 attr, int channel, long *val)
-{
-	switch (attr) {
-	case hwmon_fan_enable:
-		*val = fan_enabled(dev, channel);
-		return 0;
-	case hwmon_fan_fault:
-		*val = fan_failed(dev, channel);
-		return 0;
-	default:
-		return -EOPNOTSUPP;
-	}
-}
-
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
+	*val = readb(drvdata->base + channel);
 
 	return 0;
 }
@@ -120,8 +51,6 @@ static int gxp_fan_ctrl_read(struct device *dev, enum hwmon_sensor_types type,
 			     u32 attr, int channel, long *val)
 {
 	switch (type) {
-	case hwmon_fan:
-		return gxp_fan_read(dev, attr, channel, val);
 	case hwmon_pwm:
 		return gxp_pwm_read(dev, attr, channel, val);
 	default:
@@ -136,16 +65,6 @@ static umode_t gxp_fan_ctrl_is_visible(const void *_data,
 	umode_t mode = 0;
 
 	switch (type) {
-	case hwmon_fan:
-		switch (attr) {
-		case hwmon_fan_enable:
-		case hwmon_fan_fault:
-			mode = 0444;
-			break;
-		default:
-			break;
-		}
-		break;
 	case hwmon_pwm:
 		switch (attr) {
 		case hwmon_pwm_input:
@@ -169,15 +88,6 @@ static const struct hwmon_ops gxp_fan_ctrl_ops = {
 };
 
 static const struct hwmon_channel_info *gxp_fan_ctrl_info[] = {
-	HWMON_CHANNEL_INFO(fan,
-			   HWMON_F_FAULT | HWMON_F_ENABLE,
-			   HWMON_F_FAULT | HWMON_F_ENABLE,
-			   HWMON_F_FAULT | HWMON_F_ENABLE,
-			   HWMON_F_FAULT | HWMON_F_ENABLE,
-			   HWMON_F_FAULT | HWMON_F_ENABLE,
-			   HWMON_F_FAULT | HWMON_F_ENABLE,
-			   HWMON_F_FAULT | HWMON_F_ENABLE,
-			   HWMON_F_FAULT | HWMON_F_ENABLE),
 	HWMON_CHANNEL_INFO(pwm,
 			   HWMON_PWM_INPUT,
 			   HWMON_PWM_INPUT,
@@ -212,18 +122,6 @@ static int gxp_fan_ctrl_probe(struct platform_device *pdev)
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
-- 
2.17.1

