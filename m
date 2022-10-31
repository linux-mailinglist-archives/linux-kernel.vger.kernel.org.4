Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B0FD613C86
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 18:51:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231945AbiJaRvP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 13:51:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231583AbiJaRvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 13:51:09 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 666B363F0;
        Mon, 31 Oct 2022 10:51:03 -0700 (PDT)
Received: from jupiter.universe (dyndsl-095-033-157-181.ewe-ip-backbone.de [95.33.157.181])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 96FDE6602929;
        Mon, 31 Oct 2022 17:51:01 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1667238661;
        bh=BWy4dn0pQBQiXfifi3Jr34SCNThA0tYAu6kcv4narXw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U7W9ExE22CVaA23lXf8rDegKzDERbeF9XfSP+/WFdDiKfEkiax8mNx2FbJX2zOtiW
         8UgoSIElsQ6RXJQdgpl6Lc6CB8WjAvjs7kcavGbL9XGs5FjjoP3mGQIi8s8SCrPO0F
         J7Rd7g6xeNbJ8N6dm3dBTzIzsTOGtPSXn0kYrubkh5eeaXNxWPZOkwLYD+5agFgYOx
         p+cFb2+mvBOJ639AhL9c2zjfnCH/etmpM+B41VubvApy7DhUzFqIuaQGApV3+v111A
         zueSmF8CRdfX+gVb7Sqm0CoEILxRYfIJfwbhiFp67Bj/JEsTz7SHDxtZ/E8aigFT4d
         tGStbHERgizjQ==
Received: by jupiter.universe (Postfix, from userid 1000)
        id 5341A4801C9; Mon, 31 Oct 2022 18:50:59 +0100 (CET)
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
Subject: [PATCH 4/7] thermal: rockchip: Simplify channel id logic
Date:   Mon, 31 Oct 2022 18:50:55 +0100
Message-Id: <20221031175058.175698-5-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221031175058.175698-1-sebastian.reichel@collabora.com>
References: <20221031175058.175698-1-sebastian.reichel@collabora.com>
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
index 3dab31f163b3..a547e44e2b64 100644
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
2.35.1

