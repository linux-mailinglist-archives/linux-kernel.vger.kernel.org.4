Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34B0A6AE538
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 16:45:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbjCGPpn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 10:45:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231234AbjCGPpd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 10:45:33 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94EA8838B8
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 07:45:30 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id bx12so12554544wrb.11
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 07:45:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1678203929;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mDUOEs+XSiOfyiNiOvW3qp6/s0S8NXRmgJF421g68As=;
        b=T2+UqBQ/B0o7lX4P+fFNGS8AxIhdRQnYL4u4eNa7vRwBpDax96IfUm5+btsWfAbHcK
         Sdr3j0hYKmTAbAHYv/qL/mPpQQJJPqyKnKMepnHYk3PdPsyrRt5pQVsB4wYuygFJ7jg5
         H0Ic8Yt+QpJOslls+C9511LK9mHgITHGmgRC6e4n2N8NOVMCiP2ueRTdPubfescwcybS
         61uLpz+0u8U9qoUSjalcknogymte+g8ZLweUlmmH0L/cH0M4DaN7UOYZVZZ7MHUOBmzM
         L97fKVMk6hNpf4IT17R9VddhXt8Rr0OKI/efvPyffo6FYMDI7YjO9u0YsRXDmxX0e8TL
         uXfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678203929;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mDUOEs+XSiOfyiNiOvW3qp6/s0S8NXRmgJF421g68As=;
        b=0JsRYaf+pBc8PPEvlB2AX0zq6TlG6s5sTDpCHPo5a+YyBZddHd8SX04x/Kk+v2Rz3r
         0x501U6SOyS4qGIHHJpPtb81vE4IB/G+QICze3lGAYNFyHzggedMFNDu9mj+ja2Xmlti
         K2gGphz9ISB8rk04rCmo8DkJYoprbNImSQQemahHypUQlsANp90kuSgtRDQEQPiXcfmS
         WWjbhmNaPbgXT8tWIpWmFdUdWxLH4GVkcHXlbqoREMPIQCjhJara+ZWgvHm/Yd0BG2E1
         kH5thKXsEKiGgNTpdqMLMVH3OnCd4qOaQpSGZfqRDhcx6OSRFMQW39j6xGrJ5PzhhGsC
         ZBIg==
X-Gm-Message-State: AO0yUKVID81R+Ibdj2Yyb3gTaSTGqh/7T6VNqpFteg2D67fruSvnlkrr
        2vpJhZuWonhkB+AY1QT5uX6pKg==
X-Google-Smtp-Source: AK7set+D4VvEr8Bpnmjt43C/gu6jiUPUyAHWRjw53NuTFxCehWbsdbW+MiO3KVlZBzRA8OdTuO/NLw==
X-Received: by 2002:a5d:634d:0:b0:2c7:ae57:5acc with SMTP id b13-20020a5d634d000000b002c7ae575accmr9993378wrw.26.1678203929163;
        Tue, 07 Mar 2023 07:45:29 -0800 (PST)
Received: from localhost.localdomain (laubervilliers-657-1-248-155.w90-24.abo.wanadoo.fr. [90.24.137.155])
        by smtp.gmail.com with ESMTPSA id f2-20020a5d50c2000000b002c704271b05sm12697905wrt.66.2023.03.07.07.45.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 07:45:29 -0800 (PST)
From:   bchihi@baylibre.com
To:     daniel.lezcano@linaro.org, angelogioacchino.delregno@collabora.com,
        rafael@kernel.org, amitk@kernel.org, rui.zhang@intel.com,
        matthias.bgg@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, rdunlap@infradead.org,
        ye.xingchen@zte.com.cn, p.zabel@pengutronix.de
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        khilman@baylibre.com, james.lo@mediatek.com,
        rex-bc.chen@mediatek.com
Subject: [PATCH 2/4] thermal/drivers/mediatek/lvts_thermal: Add AP domain for mt8195
Date:   Tue,  7 Mar 2023 16:45:22 +0100
Message-Id: <20230307154524.118541-3-bchihi@baylibre.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230307154524.118541-1-bchihi@baylibre.com>
References: <20230307154524.118541-1-bchihi@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Balsam CHIHI <bchihi@baylibre.com>

Add MT8195 AP Domain support to LVTS Driver.

Signed-off-by: Balsam CHIHI <bchihi@baylibre.com>
---
 drivers/thermal/mediatek/lvts_thermal.c | 94 +++++++++++++++++++------
 1 file changed, 74 insertions(+), 20 deletions(-)

diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
index 5dbc80ba961b..7565def6b27c 100644
--- a/drivers/thermal/mediatek/lvts_thermal.c
+++ b/drivers/thermal/mediatek/lvts_thermal.c
@@ -528,29 +528,33 @@ static int lvts_sensor_init(struct device *dev, struct lvts_ctrl *lvts_ctrl,
  * The efuse blob values follows the sensor enumeration per thermal
  * controller. The decoding of the stream is as follow:
  *
- *                        <--?-> <----big0 ???---> <-sensor0-> <-0->
- *                        ------------------------------------------
- * index in the stream: : | 0x0 | 0x1 | 0x2 | 0x3 | 0x4 | 0x5 | 0x6 |
- *                        ------------------------------------------
+ * stream index map for MCU Domain :
  *
- *                        <--sensor1--><-0-> <----big1 ???---> <-sen
- *                        ------------------------------------------
- *                        | 0x7 | 0x8 | 0x9 | 0xA | 0xB | OxC | OxD |
- *                        ------------------------------------------
+ * <-----mcu-tc#0-----> <-----sensor#0-----> <-----sensor#1----->
+ *  0x01 | 0x02 | 0x03 | 0x04 | 0x05 | 0x06 | 0x07 | 0x08 | 0x09
  *
- *                        sor0-> <-0-> <-sensor1-> <-0-> ..........
- *                        ------------------------------------------
- *                        | 0x7 | 0x8 | 0x9 | 0xA | 0xB | OxC | OxD |
- *                        ------------------------------------------
+ * <-----mcu-tc#1-----> <-----sensor#2-----> <-----sensor#3----->
+ *  0x0A | 0x0B | 0x0C | 0x0D | 0x0E | 0x0F | 0x10 | 0x11 | 0x12
  *
- * And so on ...
+ * <-----mcu-tc#2-----> <-----sensor#4-----> <-----sensor#5-----> <-----sensor#6-----> <-----sensor#7----->
+ *  0x13 | 0x14 | 0x15 | 0x16 | 0x17 | 0x18 | 0x19 | 0x1A | 0x1B | 0x1C | 0x1D | 0x1E | 0x1F | 0x20 | 0x21
+ *
+ * stream index map for AP Domain :
+ *
+ * <-----ap--tc#0-----> <-----sensor#0-----> <-----sensor#1----->
+ *  0x22 | 0x23 | 0x24 | 0x25 | 0x26 | 0x27 | 0x28 | 0x29 | 0x2A
+ *
+ * <-----ap--tc#1-----> <-----sensor#2-----> <-----sensor#3----->
+ *  0x2B | 0x2C | 0x2D | 0x2E | 0x2F | 0x30 | 0x31 | 0x32 | 0x33
+ *
+ * <-----ap--tc#2-----> <-----sensor#4-----> <-----sensor#5-----> <-----sensor#6----->
+ *  0x34 | 0x35 | 0x36 | 0x37 | 0x38 | 0x39 | 0x3A | 0x3B | 0x3C | 0x3D | 0x3E | 0x3F
+ *
+ * <-----ap--tc#3-----> <-----sensor#7-----> <-----sensor#8----->
+ *  0x40 | 0x41 | 0x42 | 0x43 | 0x44 | 0x45 | 0x46 | 0x47 | 0x48
  *
  * The data description gives the offset of the calibration data in
  * this bytes stream for each sensor.
- *
- * Each thermal controller can handle up to 4 sensors max, we don't
- * care if there are less as the array of calibration is sized to 4
- * anyway. The unused sensor slot will be zeroed.
  */
 static int lvts_calibration_init(struct device *dev, struct lvts_ctrl *lvts_ctrl,
 					const struct lvts_ctrl_data *lvts_ctrl_data,
@@ -1163,7 +1167,7 @@ static int lvts_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static const struct lvts_ctrl_data mt8195_lvts_data_ctrl[] = {
+static const struct lvts_ctrl_data mt8195_lvts_mcu_data_ctrl[] = {
 	{
 		.cal_offset = { 0x04, 0x07 },
 		.lvts_sensor = {
@@ -1198,13 +1202,63 @@ static const struct lvts_ctrl_data mt8195_lvts_data_ctrl[] = {
 	}
 };
 
+static const struct lvts_ctrl_data mt8195_lvts_ap_data_ctrl[] = {
+		{
+		.cal_offset = { 0x25, 0x28 },
+		.lvts_sensor = {
+			{ .dt_id = MT8195_AP_VPU0 },
+			{ .dt_id = MT8195_AP_VPU1 }
+		},
+		.num_lvts_sensor = 2,
+		.offset = 0x0,
+		.hw_tshut_temp = LVTS_HW_SHUTDOWN_MT8195,
+	},
+	{
+		.cal_offset = { 0x2e, 0x31 },
+		.lvts_sensor = {
+			{ .dt_id = MT8195_AP_GPU0 },
+			{ .dt_id = MT8195_AP_GPU1 }
+		},
+		.num_lvts_sensor = 2,
+		.offset = 0x100,
+		.hw_tshut_temp = LVTS_HW_SHUTDOWN_MT8195,
+	},
+	{
+		.cal_offset = { 0x37, 0x3a, 0x3d },
+		.lvts_sensor = {
+			{ .dt_id = MT8195_AP_VDEC },
+			{ .dt_id = MT8195_AP_IMG },
+			{ .dt_id = MT8195_AP_INFRA },
+		},
+		.num_lvts_sensor = 3,
+		.offset = 0x200,
+		.hw_tshut_temp = LVTS_HW_SHUTDOWN_MT8195,
+	},
+	{
+		.cal_offset = { 0x43, 0x46 },
+		.lvts_sensor = {
+			{ .dt_id = MT8195_AP_CAM0 },
+			{ .dt_id = MT8195_AP_CAM1 }
+		},
+		.num_lvts_sensor = 2,
+		.offset = 0x300,
+		.hw_tshut_temp = LVTS_HW_SHUTDOWN_MT8195,
+	}
+};
+
 static const struct lvts_data mt8195_lvts_mcu_data = {
-	.lvts_ctrl	= mt8195_lvts_data_ctrl,
-	.num_lvts_ctrl	= ARRAY_SIZE(mt8195_lvts_data_ctrl),
+	.lvts_ctrl	= mt8195_lvts_mcu_data_ctrl,
+	.num_lvts_ctrl	= ARRAY_SIZE(mt8195_lvts_mcu_data_ctrl),
+};
+
+static const struct lvts_data mt8195_lvts_ap_data = {
+	.lvts_ctrl	= mt8195_lvts_ap_data_ctrl,
+	.num_lvts_ctrl	= ARRAY_SIZE(mt8195_lvts_ap_data_ctrl),
 };
 
 static const struct of_device_id lvts_of_match[] = {
 	{ .compatible = "mediatek,mt8195-lvts-mcu", .data = &mt8195_lvts_mcu_data },
+	{ .compatible = "mediatek,mt8195-lvts-ap", .data = &mt8195_lvts_ap_data },
 	{},
 };
 MODULE_DEVICE_TABLE(of, lvts_of_match);
-- 
2.34.1

