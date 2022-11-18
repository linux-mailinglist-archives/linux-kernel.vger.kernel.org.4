Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A22962F336
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 12:05:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241601AbiKRLFE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 06:05:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241533AbiKRLFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 06:05:00 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 910BC99E8E
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 03:04:47 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id o30so3393113wms.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 03:04:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JEWwvjO7xGoxwjM+6BZt85KGa3T/LYZTSrJmbqTF3bU=;
        b=MxkqzHNX4dIvac2ctpL2Ov1Eo2y0TQHlWsuaTRaoxGgbYR1Z6m+TzdZx/z4HZPmjXj
         tLg/9oYG0dP42sVOAEAmssspPG+2m/LYs4qfTXBbIpYJx5tcWabbVrbUxL09WUWde4bn
         jjbVLKSN4qsP249G7cHrD1pXLAR5sBsLSKJLU22ZiJq5gwr1ksAn+qhxexKa7G3Hf3/q
         vSTy6AH147vJqyeNURuF7erDKCy6skaRMZTC3kbzBSs23B3mM/L2dCO84G2Z62hozgC9
         CHnmQszORwhnpNEbF/TY7IiGqSyPWE65PJFe0gBpRvFQYDv7XWMCi6enoAKajHAtSaDv
         ZKCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JEWwvjO7xGoxwjM+6BZt85KGa3T/LYZTSrJmbqTF3bU=;
        b=8OtArecd2hp1wnYb7G3nZML+5WzFDB6KiCARe44GzVsJRl0HUzyGt+Bb1TWq/2gqLo
         TnbOGx7Y5dgspkL7UdORTEdxSKvSLQRHE5u1lSGNqGVeCh2/7DbTMdKEbr3J0+RA1Ug8
         2c+HIQEF4ifYWq+M3P8WDcjG1pLZCRwklmNL8/XI+58YT6HDchlkUypXec13IFkNPZXd
         GfhkEy7QDKNI47K/pSI8gzsbEZxdiF0dsr+VWLrA62rhq8M0Gm/whwpS6KfHmErjRyEm
         IpTtHGaklXlMmSV4zt16bj0xY49jfNUe8/phePCiGSmIVy3cMPOpGOdsYgUv1yQ7pK+P
         BhPg==
X-Gm-Message-State: ANoB5ploYDqR68LLzai4DxEEiumCG9cQNe3XHu4XylbGlbVSTfeljLPo
        nt/WHTY/MXgnCmw+tM/EWCRlkQ==
X-Google-Smtp-Source: AA0mqf6eZVLMpSrrv1w/0V981VmPrLB6d0Ec/FK4KH0meTVDBLRRQRGw5YlVckTx9UAvO3XAX7mzcQ==
X-Received: by 2002:a05:600c:511c:b0:3cf:6c05:809e with SMTP id o28-20020a05600c511c00b003cf6c05809emr4589679wms.74.1668769486008;
        Fri, 18 Nov 2022 03:04:46 -0800 (PST)
Received: from [127.0.1.1] (210.145.15.109.rev.sfr.net. [109.15.145.210])
        by smtp.googlemail.com with ESMTPSA id i14-20020adff30e000000b002368a6deaf8sm3316948wro.57.2022.11.18.03.04.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 03:04:45 -0800 (PST)
From:   Amjad Ouled-Ameur <aouledameur@baylibre.com>
Date:   Fri, 18 Nov 2022 12:04:29 +0100
Subject: [PATCH v7 3/4] thermal: mediatek: add support for MT8365 SoC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20221018-up-i350-thermal-bringup-v7-3-ebf08ff2eddb@baylibre.com>
References: <20221018-up-i350-thermal-bringup-v7-0-ebf08ff2eddb@baylibre.com>
In-Reply-To: <20221018-up-i350-thermal-bringup-v7-0-ebf08ff2eddb@baylibre.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Fabien Parent <fparent@baylibre.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Markus Schneider-Pargmann <msp@baylibre.com>,
        linux-pm@vger.kernel.org, Rob Herring <robh@kernel.org>,
        Michael Kao <michael.kao@mediatek.com>,
        linux-kernel@vger.kernel.org, Hsin-Yi Wang <hsinyi@chromium.org>,
        Amjad Ouled-Ameur <aouledameur@baylibre.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org
X-Mailer: b4 0.10.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1668769481; l=4121;
 i=aouledameur@baylibre.com; s=20220920; h=from:subject:message-id;
 bh=HsISGoJEL6++3d6wc/n5aLyLD13GWmaS4gC5p+H31oE=;
 b=qIXNFOnmEaHDRp+6JyJy65AdFiqJFAcK2ZdjoYntRPxQ7dWrOTTzB89mSHuqLWQ5c7SSUpqaXv8H
 e+EUMsKuAZwqt0yWVTZMi2He74hQr4qhfsD18P72k1kKjuYiphtj
X-Developer-Key: i=aouledameur@baylibre.com; a=ed25519;
 pk=HgYWawSL4qLGPx+RzJ+Cuu+V8Pi/KQnDDm1wjWPMOFE=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fabien Parent <fparent@baylibre.com>

MT8365 is similar to the other SoCs supported by the driver. It has only
one bank and 3 actual sensors that can be multiplexed. There is another
one sensor that does not have usable data.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
Signed-off-by: Amjad Ouled-Ameur <aouledameur@baylibre.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/thermal/mtk_thermal.c | 68 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/drivers/thermal/mtk_thermal.c b/drivers/thermal/mtk_thermal.c
index d8ddceb75372..3a5df1440822 100644
--- a/drivers/thermal/mtk_thermal.c
+++ b/drivers/thermal/mtk_thermal.c
@@ -31,6 +31,7 @@
 #define AUXADC_CON2_V		0x010
 #define AUXADC_DATA(channel)	(0x14 + (channel) * 4)
 
+#define APMIXED_SYS_TS_CON0	0x600
 #define APMIXED_SYS_TS_CON1	0x604
 
 /* Thermal Controller Registers */
@@ -245,6 +246,17 @@ enum mtk_thermal_version {
 /* The calibration coefficient of sensor  */
 #define MT8183_CALIBRATION	153
 
+/* MT8365 */
+#define MT8365_TEMP_AUXADC_CHANNEL 11
+#define MT8365_CALIBRATION 164
+#define MT8365_NUM_CONTROLLER 1
+#define MT8365_NUM_BANKS 1
+#define MT8365_NUM_SENSORS 3
+#define MT8365_NUM_SENSORS_PER_ZONE 3
+#define MT8365_TS1 0
+#define MT8365_TS2 1
+#define MT8365_TS3 2
+
 struct mtk_thermal;
 
 struct thermal_bank_cfg {
@@ -389,6 +401,24 @@ static const int mt7622_mux_values[MT7622_NUM_SENSORS] = { 0, };
 static const int mt7622_vts_index[MT7622_NUM_SENSORS] = { VTS1 };
 static const int mt7622_tc_offset[MT7622_NUM_CONTROLLER] = { 0x0, };
 
+/* MT8365 thermal sensor data */
+static const int mt8365_bank_data[MT8365_NUM_SENSORS] = {
+	MT8365_TS1, MT8365_TS2, MT8365_TS3
+};
+
+static const int mt8365_msr[MT8365_NUM_SENSORS_PER_ZONE] = {
+	TEMP_MSR0, TEMP_MSR1, TEMP_MSR2
+};
+
+static const int mt8365_adcpnp[MT8365_NUM_SENSORS_PER_ZONE] = {
+	TEMP_ADCPNP0, TEMP_ADCPNP1, TEMP_ADCPNP2
+};
+
+static const int mt8365_mux_values[MT8365_NUM_SENSORS] = { 0, 1, 2 };
+static const int mt8365_tc_offset[MT8365_NUM_CONTROLLER] = { 0 };
+
+static const int mt8365_vts_index[MT8365_NUM_SENSORS] = { VTS1, VTS2, VTS3 };
+
 /*
  * The MT8173 thermal controller has four banks. Each bank can read up to
  * four temperature sensors simultaneously. The MT8173 has a total of 5
@@ -463,6 +493,40 @@ static const struct mtk_thermal_data mt2701_thermal_data = {
 	.version = MTK_THERMAL_V1,
 };
 
+/*
+ * The MT8365 thermal controller has one bank, which can read up to
+ * four temperature sensors simultaneously. The MT8365 has a total of 3
+ * temperature sensors.
+ *
+ * The thermal core only gets the maximum temperature of this one bank,
+ * so the bank concept wouldn't be necessary here. However, the SVS (Smart
+ * Voltage Scaling) unit makes its decisions based on the same bank
+ * data.
+ */
+static const struct mtk_thermal_data mt8365_thermal_data = {
+	.auxadc_channel = MT8365_TEMP_AUXADC_CHANNEL,
+	.num_banks = MT8365_NUM_BANKS,
+	.num_sensors = MT8365_NUM_SENSORS,
+	.vts_index = mt8365_vts_index,
+	.cali_val = MT8365_CALIBRATION,
+	.num_controller = MT8365_NUM_CONTROLLER,
+	.controller_offset = mt8365_tc_offset,
+	.need_switch_bank = false,
+	.bank_data = {
+		{
+			.num_sensors = MT8365_NUM_SENSORS,
+			.sensors = mt8365_bank_data
+		},
+	},
+	.msr = mt8365_msr,
+	.adcpnp = mt8365_adcpnp,
+	.sensor_mux_values = mt8365_mux_values,
+	.version = MTK_THERMAL_V1,
+	.apmixed_buffer_ctl_reg = APMIXED_SYS_TS_CON0,
+	.apmixed_buffer_ctl_mask = (u32) ~GENMASK(29, 28),
+	.apmixed_buffer_ctl_set = 0,
+};
+
 /*
  * The MT2712 thermal controller has one bank, which can read up to
  * four temperature sensors simultaneously. The MT2712 has a total of 4
@@ -964,6 +1028,10 @@ static const struct of_device_id mtk_thermal_of_match[] = {
 	{
 		.compatible = "mediatek,mt8183-thermal",
 		.data = (void *)&mt8183_thermal_data,
+	},
+	{
+		.compatible = "mediatek,mt8365-thermal",
+		.data = (void *)&mt8365_thermal_data,
 	}, {
 	},
 };

-- 
b4 0.10.1
