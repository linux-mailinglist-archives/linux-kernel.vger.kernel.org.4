Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0E286E6843
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 17:32:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232431AbjDRPcg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 11:32:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232346AbjDRPc2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 11:32:28 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A9C813FBE;
        Tue, 18 Apr 2023 08:32:16 -0700 (PDT)
Received: from pps.filterd (m0150242.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33I9lVw7007157;
        Tue, 18 Apr 2023 15:31:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : subject :
 date : message-id : in-reply-to : references; s=pps0720;
 bh=oObhR1AgXUg5CibVcUv6pkBoGTuDIv3heB6+ATUoSok=;
 b=j5+Ofor6tF3/RSrW/I7K7BkrWrzpAa7EPfxd1Fjw7Mloyp+eM0IBa9ISS+ZnXCS9YASA
 M8Y0hlMAn/AeMD39Vj7H00vKhUC03cgelTuyXlVrHq26ZvWkxBI4UTq7nyZVufFIBd0Y
 7bPisyU4idRWii8DrdE3CpGeLRUT7BkMHN3eC79oAgDzGfsCuQ80k2xtRqXl+BAYttY5
 X+QdItKpaoYshd559pZYrfpVzWpfFv1xhef2bibwUswEN/aLvnPfeC73oGA2CuUfcxRX
 OCu3TleOr6N0OgipN0blYzJfz+WtO8GjH8eYcr1RYtojAMITBUVV2J/mHyrFBqlPM9gN 5A== 
Received: from p1lg14880.it.hpe.com (p1lg14880.it.hpe.com [16.230.97.201])
        by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 3q1ca1045j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Apr 2023 15:31:37 +0000
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14880.it.hpe.com (Postfix) with ESMTPS id 7B6DC800217;
        Tue, 18 Apr 2023 15:31:36 +0000 (UTC)
Received: from hpe.com (unknown [16.231.227.36])
        by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTP id CAE0B816D3A;
        Tue, 18 Apr 2023 15:31:35 +0000 (UTC)
From:   nick.hawkins@hpe.com
To:     verdun@hpe.com, nick.hawkins@hpe.com, linus.walleij@linaro.org,
        brgl@bgdev.pl, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, jdelvare@suse.com,
        linux@roeck-us.net, linux@armlinux.org.uk,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v1 2/9] hwmon: (gxp_fan_ctrl) Give GPIO access to fan data
Date:   Tue, 18 Apr 2023 10:28:17 -0500
Message-Id: <20230418152824.110823-3-nick.hawkins@hpe.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230418152824.110823-1-nick.hawkins@hpe.com>
References: <20230418152824.110823-1-nick.hawkins@hpe.com>
X-Proofpoint-GUID: IymkpW-Evmgrn-rdu4CClDYAe9CzoyTs
X-Proofpoint-ORIG-GUID: IymkpW-Evmgrn-rdu4CClDYAe9CzoyTs
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-18_11,2023-04-18_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=0
 impostorscore=0 mlxscore=0 malwarescore=0 lowpriorityscore=0
 mlxlogscore=999 phishscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304180132
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nick Hawkins <nick.hawkins@hpe.com>

The fan driver has access to the IO that reports fan presence.
Add the ability for other drivers such as GPIO to call in
to get fan information. Also remove the system power check as
the GPIO driver needs it to report power state.

Signed-off-by: Nick Hawkins <nick.hawkins@hpe.com>
---
 drivers/hwmon/gxp-fan-ctrl.c | 58 +++++++++++++++---------------------
 1 file changed, 24 insertions(+), 34 deletions(-)

diff --git a/drivers/hwmon/gxp-fan-ctrl.c b/drivers/hwmon/gxp-fan-ctrl.c
index 0014b8b0fd41..a8fcea98cc55 100644
--- a/drivers/hwmon/gxp-fan-ctrl.c
+++ b/drivers/hwmon/gxp-fan-ctrl.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-only
-/* Copyright (C) 2022 Hewlett-Packard Enterprise Development Company, L.P. */
+/* Copyright (C) 2023 Hewlett-Packard Enterprise Development Company, L.P. */
 
 #include <linux/bits.h>
 #include <linux/err.h>
@@ -11,15 +11,14 @@
 
 #define OFS_FAN_INST	0 /* Is 0 because plreg base will be set at INST */
 #define OFS_FAN_FAIL	2 /* Is 2 bytes after base */
-#define OFS_SEVSTAT	0 /* Is 0 because fn2 base will be set at SEVSTAT */
-#define POWER_BIT	24
 
 struct gxp_fan_ctrl_drvdata {
 	void __iomem	*base;
 	void __iomem	*plreg;
-	void __iomem	*fn2;
 };
 
+struct gxp_fan_ctrl_drvdata *drvdata;
+
 static bool fan_installed(struct device *dev, int fan)
 {
 	struct gxp_fan_ctrl_drvdata *drvdata = dev_get_drvdata(dev);
@@ -30,6 +29,16 @@ static bool fan_installed(struct device *dev, int fan)
 	return !!(val & BIT(fan));
 }
 
+u8 get_fans_installed(void)
+{
+	static u8 val;
+
+	val = readb(drvdata->plreg + OFS_FAN_INST);
+
+	return val;
+}
+EXPORT_SYMBOL(get_fans_installed);
+
 static long fan_failed(struct device *dev, int fan)
 {
 	struct gxp_fan_ctrl_drvdata *drvdata = dev_get_drvdata(dev);
@@ -40,19 +49,19 @@ static long fan_failed(struct device *dev, int fan)
 	return !!(val & BIT(fan));
 }
 
-static long fan_enabled(struct device *dev, int fan)
+u8 get_fans_failed(void)
 {
-	struct gxp_fan_ctrl_drvdata *drvdata = dev_get_drvdata(dev);
-	u32 val;
+	static u8 val;
 
-	/*
-	 * Check the power status as if the platform is off the value
-	 * reported for the PWM will be incorrect. Report fan as
-	 * disabled.
-	 */
-	val = readl(drvdata->fn2 + OFS_SEVSTAT);
+	val = readb(drvdata->plreg + OFS_FAN_FAIL);
+
+	return val;
+}
+EXPORT_SYMBOL(get_fans_failed);
 
-	return !!((val & BIT(POWER_BIT)) && fan_installed(dev, fan));
+static long fan_enabled(struct device *dev, int fan)
+{
+	return !!(fan_installed(dev, fan));
 }
 
 static int gxp_pwm_write(struct device *dev, u32 attr, int channel, long val)
@@ -98,20 +107,8 @@ static int gxp_fan_read(struct device *dev, u32 attr, int channel, long *val)
 static int gxp_pwm_read(struct device *dev, u32 attr, int channel, long *val)
 {
 	struct gxp_fan_ctrl_drvdata *drvdata = dev_get_drvdata(dev);
-	u32 reg;
-
-	/*
-	 * Check the power status of the platform. If the platform is off
-	 * the value reported for the PWM will be incorrect. In this case
-	 * report a PWM of zero.
-	 */
 
-	reg = readl(drvdata->fn2 + OFS_SEVSTAT);
-
-	if (reg & BIT(POWER_BIT))
-		*val = fan_installed(dev, channel) ? readb(drvdata->base + channel) : 0;
-	else
-		*val = 0;
+	*val = fan_installed(dev, channel) ? readb(drvdata->base + channel) : 0;
 
 	return 0;
 }
@@ -198,7 +195,6 @@ static const struct hwmon_chip_info gxp_fan_ctrl_chip_info = {
 
 static int gxp_fan_ctrl_probe(struct platform_device *pdev)
 {
-	struct gxp_fan_ctrl_drvdata *drvdata;
 	struct device *dev = &pdev->dev;
 	struct device *hwmon_dev;
 
@@ -218,12 +214,6 @@ static int gxp_fan_ctrl_probe(struct platform_device *pdev)
 		return dev_err_probe(dev, PTR_ERR(drvdata->plreg),
 				     "failed to map plreg\n");
 
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

