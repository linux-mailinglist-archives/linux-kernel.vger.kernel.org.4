Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76C5A65F35A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 19:04:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235391AbjAESEH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 13:04:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234822AbjAESDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 13:03:49 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43159564D0;
        Thu,  5 Jan 2023 10:03:47 -0800 (PST)
Received: from jupiter.universe (dyndsl-085-016-198-020.ewe-ip-backbone.de [85.16.198.20])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 685C06602D31;
        Thu,  5 Jan 2023 18:03:45 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1672941825;
        bh=mHh80L5ElPr39w1k3P2HJAsFvlLLjnNTUVP+BBbonS4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jPiRG+FK7BIKmHxxliBSQ5KVTX8SlArJTKNKalscLlSNPZlsJN6Z+YQbLweNhq8+t
         lKH5F/XEKa4SWXIczxf8UL85t4zUAxvdpx9/lQGkaT/scS/NOpOYRgszbW2MTi4Nbd
         op16fXQ74lzl60QaMUMsXFyyw40jziXUYnzDRSC9HdPSIWnQHXdUykAUfNhPFJ+Dhu
         sEkIEY3bfVB5FJxWFdD2jxMCjVRbnVJg4zl7Y7dZ01gHmbdNsBOLZr85jBu53pjT8V
         qqbv4sxy+7HeyO+mSaCY6KGmbV631Mw8R6DU5u4oFoTcxWhieLaW/oRRJGnBmtCl1h
         KpmdxJXpDKdTQ==
Received: by jupiter.universe (Postfix, from userid 1000)
        id A9EAC48011B; Thu,  5 Jan 2023 19:03:42 +0100 (CET)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Heiko Stuebner <heiko@sntech.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-pm@vger.kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        kernel@collabora.com
Subject: [PATCHv3 4/7] thermal: rockchip: Simplify channel id logic
Date:   Thu,  5 Jan 2023 19:03:37 +0100
Message-Id: <20230105180340.29140-5-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230105180340.29140-1-sebastian.reichel@collabora.com>
References: <20230105180340.29140-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the channel ID lookup table by a simple offset, since
the channel IDs are consecutive.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/thermal/rockchip_thermal.c | 48 +++++++++++++-----------------
 1 file changed, 21 insertions(+), 27 deletions(-)

diff --git a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/rockchip_thermal.c
index 0670584533a5..2c8a8b365c80 100644
--- a/drivers/thermal/rockchip_thermal.c
+++ b/drivers/thermal/rockchip_thermal.c
@@ -39,15 +39,6 @@ enum tshut_polarity {
 	TSHUT_HIGH_ACTIVE,
 };
 
-/*
- * The system has two Temperature Sensors.
- * sensor0 is for CPU, and sensor1 is for GPU.
- */
-enum sensor_id {
-	SENSOR_CPU = 0,
-	SENSOR_GPU,
-};
-
 /*
  * The conversion table has the adc value and temperature.
  * ADC_DECREMENT: the adc value is of diminishing.(e.g. rk3288_code_table)
@@ -82,7 +73,7 @@ struct chip_tsadc_table {
 
 /**
  * struct rockchip_tsadc_chip - hold the private data of tsadc chip
- * @chn_id: array of sensor ids of chip corresponding to the channel
+ * @chn_offset: the channel offset of the first channel
  * @chn_num: the channel number of tsadc chip
  * @tshut_temp: the hardware-controlled shutdown temperature value
  * @tshut_mode: the hardware-controlled shutdown mode (0:CRU 1:GPIO)
@@ -98,7 +89,7 @@ struct chip_tsadc_table {
  */
 struct rockchip_tsadc_chip {
 	/* The sensor id of chip correspond to the ADC channel */
-	int chn_id[SOC_MAX_SENSORS];
+	int chn_offset;
 	int chn_num;
 
 	/* The hardware-controlled tshut property */
@@ -925,8 +916,8 @@ static void rk_tsadcv2_tshut_mode(int chn, void __iomem *regs,
 }
 
 static const struct rockchip_tsadc_chip px30_tsadc_data = {
-	.chn_id[SENSOR_CPU] = 0, /* cpu sensor is channel 0 */
-	.chn_id[SENSOR_GPU] = 1, /* gpu sensor is channel 1 */
+	/* cpu, gpu */
+	.chn_offset = 0,
 	.chn_num = 2, /* 2 channels for tsadc */
 
 	.tshut_mode = TSHUT_MODE_CRU, /* default TSHUT via CRU */
@@ -949,7 +940,8 @@ static const struct rockchip_tsadc_chip px30_tsadc_data = {
 };
 
 static const struct rockchip_tsadc_chip rv1108_tsadc_data = {
-	.chn_id[SENSOR_CPU] = 0, /* cpu sensor is channel 0 */
+	/* cpu */
+	.chn_offset = 0,
 	.chn_num = 1, /* one channel for tsadc */
 
 	.tshut_mode = TSHUT_MODE_GPIO, /* default TSHUT via GPIO give PMIC */
@@ -973,7 +965,8 @@ static const struct rockchip_tsadc_chip rv1108_tsadc_data = {
 };
 
 static const struct rockchip_tsadc_chip rk3228_tsadc_data = {
-	.chn_id[SENSOR_CPU] = 0, /* cpu sensor is channel 0 */
+	/* cpu */
+	.chn_offset = 0,
 	.chn_num = 1, /* one channel for tsadc */
 
 	.tshut_mode = TSHUT_MODE_GPIO, /* default TSHUT via GPIO give PMIC */
@@ -997,8 +990,8 @@ static const struct rockchip_tsadc_chip rk3228_tsadc_data = {
 };
 
 static const struct rockchip_tsadc_chip rk3288_tsadc_data = {
-	.chn_id[SENSOR_CPU] = 1, /* cpu sensor is channel 1 */
-	.chn_id[SENSOR_GPU] = 2, /* gpu sensor is channel 2 */
+	/* cpu, gpu */
+	.chn_offset = 1,
 	.chn_num = 2, /* two channels for tsadc */
 
 	.tshut_mode = TSHUT_MODE_GPIO, /* default TSHUT via GPIO give PMIC */
@@ -1022,7 +1015,8 @@ static const struct rockchip_tsadc_chip rk3288_tsadc_data = {
 };
 
 static const struct rockchip_tsadc_chip rk3328_tsadc_data = {
-	.chn_id[SENSOR_CPU] = 0, /* cpu sensor is channel 0 */
+	/* cpu */
+	.chn_offset = 0,
 	.chn_num = 1, /* one channels for tsadc */
 
 	.tshut_mode = TSHUT_MODE_CRU, /* default TSHUT via CRU */
@@ -1045,8 +1039,8 @@ static const struct rockchip_tsadc_chip rk3328_tsadc_data = {
 };
 
 static const struct rockchip_tsadc_chip rk3366_tsadc_data = {
-	.chn_id[SENSOR_CPU] = 0, /* cpu sensor is channel 0 */
-	.chn_id[SENSOR_GPU] = 1, /* gpu sensor is channel 1 */
+	/* cpu, gpu */
+	.chn_offset = 0,
 	.chn_num = 2, /* two channels for tsadc */
 
 	.tshut_mode = TSHUT_MODE_GPIO, /* default TSHUT via GPIO give PMIC */
@@ -1070,8 +1064,8 @@ static const struct rockchip_tsadc_chip rk3366_tsadc_data = {
 };
 
 static const struct rockchip_tsadc_chip rk3368_tsadc_data = {
-	.chn_id[SENSOR_CPU] = 0, /* cpu sensor is channel 0 */
-	.chn_id[SENSOR_GPU] = 1, /* gpu sensor is channel 1 */
+	/* cpu, gpu */
+	.chn_offset = 0,
 	.chn_num = 2, /* two channels for tsadc */
 
 	.tshut_mode = TSHUT_MODE_GPIO, /* default TSHUT via GPIO give PMIC */
@@ -1095,8 +1089,8 @@ static const struct rockchip_tsadc_chip rk3368_tsadc_data = {
 };
 
 static const struct rockchip_tsadc_chip rk3399_tsadc_data = {
-	.chn_id[SENSOR_CPU] = 0, /* cpu sensor is channel 0 */
-	.chn_id[SENSOR_GPU] = 1, /* gpu sensor is channel 1 */
+	/* cpu, gpu */
+	.chn_offset = 0,
 	.chn_num = 2, /* two channels for tsadc */
 
 	.tshut_mode = TSHUT_MODE_GPIO, /* default TSHUT via GPIO give PMIC */
@@ -1120,8 +1114,8 @@ static const struct rockchip_tsadc_chip rk3399_tsadc_data = {
 };
 
 static const struct rockchip_tsadc_chip rk3568_tsadc_data = {
-	.chn_id[SENSOR_CPU] = 0, /* cpu sensor is channel 0 */
-	.chn_id[SENSOR_GPU] = 1, /* gpu sensor is channel 1 */
+	/* cpu, gpu */
+	.chn_offset = 0,
 	.chn_num = 2, /* two channels for tsadc */
 
 	.tshut_mode = TSHUT_MODE_GPIO, /* default TSHUT via GPIO give PMIC */
@@ -1406,7 +1400,7 @@ static int rockchip_thermal_probe(struct platform_device *pdev)
 	for (i = 0; i < thermal->chip->chn_num; i++) {
 		error = rockchip_thermal_register_sensor(pdev, thermal,
 						&thermal->sensors[i],
-						thermal->chip->chn_id[i]);
+						thermal->chip->chn_offset + i);
 		if (error)
 			return dev_err_probe(&pdev->dev, error,
 				"failed to register sensor[%d].\n", i);
-- 
2.39.0

