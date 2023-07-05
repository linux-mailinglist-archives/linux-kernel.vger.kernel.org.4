Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F37AA748E4E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 21:50:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234307AbjGETuU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 15:50:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234131AbjGETuO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 15:50:14 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54F64198A;
        Wed,  5 Jul 2023 12:50:12 -0700 (PDT)
Received: from pps.filterd (m0148663.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 365JW75i014800;
        Wed, 5 Jul 2023 19:49:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : subject :
 date : message-id : in-reply-to : references; s=pps0720;
 bh=/ziEu6YkPCeWxCYYW3QSFeg+yO/ZPOEFfBFG5brYrTg=;
 b=W9szVvRnYBrUz+90Qc5xkEmCizGEOgXwyIVy+0gc/q17OZLNrw4VPYfJLto6MGTglbaF
 h4CxVc1MJxZmo8U+g8jlNq6MTyHvsNeD1kvr5UGQZAefvEwIBXn4tjxslo3wuYVhTmuG
 sqImMJJqCobKx0UEuFe6NN5n1iSfF69WeZ5BKeok+xZdt6kFpTLdeFd2t/IfQQYpIkPk
 Ep6kVoIVfG3+e7qbTmPsaKbEq2UvQ9zSza+9r77nhYF42R1Vg/2mAggOHuBuSyrc1UM6
 bqn9fWW4nVvuT1okYajQXOUZ3nxB7l7/A9jLOkq85JSVw/HXwYCQiqbcokEBgj8hFvY+ JQ== 
Received: from p1lg14878.it.hpe.com (p1lg14878.it.hpe.com [16.230.97.204])
        by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 3rn65h49yc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Jul 2023 19:49:46 +0000
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14878.it.hpe.com (Postfix) with ESMTPS id EE57414798;
        Wed,  5 Jul 2023 19:49:45 +0000 (UTC)
Received: from hpe.com (unknown [16.231.227.36])
        by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTP id 63FB6808EA7;
        Wed,  5 Jul 2023 19:49:45 +0000 (UTC)
From:   nick.hawkins@hpe.com
To:     verdun@hpe.com, nick.hawkins@hpe.com, linus.walleij@linaro.org,
        brgl@bgdev.pl, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, jdelvare@suse.com,
        linux@roeck-us.net, andy.shevchenko@gmail.com,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org
Subject: [PATCH v5 4/5] hwmon: (gxp_fan_ctrl) Provide fan info via gpio
Date:   Wed,  5 Jul 2023 14:45:43 -0500
Message-Id: <20230705194544.100370-5-nick.hawkins@hpe.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230705194544.100370-1-nick.hawkins@hpe.com>
References: <20230705194544.100370-1-nick.hawkins@hpe.com>
X-Proofpoint-GUID: -ZbNcC12XRO622Rd8ACqpn445I1LLAL4
X-Proofpoint-ORIG-GUID: -ZbNcC12XRO622Rd8ACqpn445I1LLAL4
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-05_11,2023-07-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 mlxlogscore=732 malwarescore=0 mlxscore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 suspectscore=0 phishscore=0 clxscore=1015 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2307050180
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

v5:
 *No change
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
 drivers/hwmon/gxp-fan-ctrl.c | 106 +----------------------------------
 2 files changed, 3 insertions(+), 105 deletions(-)

diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index fc640201a2de..599162c36a53 100644
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
index 2e05bc2f627a..cd23ea596415 100644
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
 	void __iomem	*base;
-	void __iomem	*plreg;
-	void __iomem	*fn2;
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
 
 static const struct hwmon_channel_info * const gxp_fan_ctrl_info[] = {
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

