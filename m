Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B60D3714D2C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 17:36:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbjE2Pgu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 11:36:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbjE2Pfl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 11:35:41 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CDAAD2
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 08:35:40 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-30a8fa6e6fcso2098492f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 08:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1685374539; x=1687966539;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=okJUfe+J2lktOzbTBoR7fCmJ4uPpfts4ISVsUrRsL8s=;
        b=NS0pX9COgJWbr5d79P8/3iY6bZnrVbpsLAZI49cLvjkr8spD9tqOztdfBCY3Gn6Lds
         /1uov4ZItcSTVxZKrPEQ6VSVFkYUHApadQdxAF9J6FPGSY6/tDxD/61t65Fje98Pffib
         VbpuICwrNoSBngs4Nf4rbyQJQRRt9p534nbEbqb1dsltYfnZCGm8yINHiTJOJRD2KghD
         Rz+Z0nRZZqTiaMLZn86FC0gzrB/Sp15ifze5nX4/fl6pppipyFHmBuz0MwSIX3/6thPR
         cRVodjoK6FB4nD5CX5Ea5r+32ROAX26J7NIbWwT5oK2RFwHJ8KDq7Y+H+phMbQri8eGY
         9u6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685374539; x=1687966539;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=okJUfe+J2lktOzbTBoR7fCmJ4uPpfts4ISVsUrRsL8s=;
        b=d2G8+DGJsO8OTnkKdC26TwPalXpJfq3xi7KhcsMZbTT1SnJgu6QLlNXWbr0vHDqT39
         TXix7QOGByV07m+pLyTA8QHyEJjP4mH+NyhDV8QF+RF8SnXyxigPL6IgTwPYdoPKreoo
         NzqbwdxC8exP8eyRY9VDOejtBNIcE5eMW2tWiTx+G3jPqTR2biZhFQadbIa6MdaFUryf
         9/5sJsNAfJ7PDdM2rTjeDgp6ZLDEH5GFdb6YNyKeUvQ33u5hNjE8m/8iRBs3DSM5+V3t
         dOnUMvkgp8wrCXyAF8l/Viuy0WHltbBZyzIKN5zLzglPGeSvch+Rftm0nSgbrzFWCrrr
         +U9g==
X-Gm-Message-State: AC+VfDzPwbLIvxrju8blc1YxhGjA3d5hR7qc6lOzxmQ5UbxTu37Ldj5f
        vo/f487dAyYQvf1bcLhfW9Hl2Q==
X-Google-Smtp-Source: ACHHUZ5u2XpZ9IFBwAwLoRHz0ujidyfO2mfgl+1ahV/sz3Y7KccSdj1EbKTzlJTfC21W95MVkMiv2A==
X-Received: by 2002:adf:dd4b:0:b0:2f0:e287:1fbc with SMTP id u11-20020adfdd4b000000b002f0e2871fbcmr9100259wrm.11.1685374538821;
        Mon, 29 May 2023 08:35:38 -0700 (PDT)
Received: from ph18.baylibre (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id j27-20020a5d453b000000b003095a329e90sm269781wra.97.2023.05.29.08.35.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 May 2023 08:35:38 -0700 (PDT)
From:   =?UTF-8?q?Bernhard=20Rosenkr=C3=A4nzer?= <bero@baylibre.com>
To:     daniel.lezcano@linaro.org, angelogioacchino.delregno@collabora.com,
        rafael@kernel.org, amitk@kernel.org, rui.zhang@intel.com,
        matthias.bgg@gmail.com, robh+dt@kernel.org,
        krzystof.kozlowski+dt@linaro.org, rdunlap@infradead.org,
        ye.xingchen@zte.com.cn, p.zabel@pangutronix.de
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        wenst@chromium.org, james.lo@mediatek.com,
        rex-bc.chen@mediatek.com, nfraprado@collabora.com,
        abailon@baylibre.com, amergnat@baylibre.com, khilman@baylibre.com
Subject: [PATCH v3 3/5] thermal/drivers/mediatek/lvts_thermal: Add mt8192 support
Date:   Mon, 29 May 2023 17:35:30 +0200
Message-ID: <20230529153532.3541327-4-bero@baylibre.com>
X-Mailer: git-send-email 2.41.0.rc2
In-Reply-To: <20230529153532.3541327-1-bero@baylibre.com>
References: <20230529153532.3541327-1-bero@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Balsam CHIHI <bchihi@baylibre.com>

Add LVTS Driver support for MT8192.

Co-developed-by : Nícolas F. R. A. Prado <nfraprado@collabora.com>
Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
Signed-off-by: Balsam CHIHI <bchihi@baylibre.com>
Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
Signed-off-by: Bernhard Rosenkränzer <bero@baylibre.com>
---
 drivers/thermal/mediatek/lvts_thermal.c | 95 +++++++++++++++++++++++++
 1 file changed, 95 insertions(+)

diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
index 5ea8a9d569ea6..d5e5214784ece 100644
--- a/drivers/thermal/mediatek/lvts_thermal.c
+++ b/drivers/thermal/mediatek/lvts_thermal.c
@@ -80,6 +80,7 @@
 #define LVTS_MSR_FILTERED_MODE		1
 
 #define LVTS_HW_SHUTDOWN_MT8195		105000
+#define LVTS_HW_SHUTDOWN_MT8192		105000
 
 static int golden_temp = LVTS_GOLDEN_TEMP_DEFAULT;
 static int coeff_b = LVTS_COEFF_B;
@@ -1280,6 +1281,88 @@ static const struct lvts_ctrl_data mt8195_lvts_ap_data_ctrl[] = {
 	}
 };
 
+static const struct lvts_ctrl_data mt8192_lvts_mcu_data_ctrl[] = {
+	{
+		.cal_offset = { 0x04, 0x08 },
+		.lvts_sensor = {
+			{ .dt_id = MT8192_MCU_BIG_CPU0 },
+			{ .dt_id = MT8192_MCU_BIG_CPU1 }
+		},
+		.num_lvts_sensor = 2,
+		.offset = 0x0,
+		.hw_tshut_temp = LVTS_HW_SHUTDOWN_MT8192,
+		.mode = LVTS_MSR_FILTERED_MODE,
+	},
+	{
+		.cal_offset = { 0x0c, 0x10 },
+		.lvts_sensor = {
+			{ .dt_id = MT8192_MCU_BIG_CPU2 },
+			{ .dt_id = MT8192_MCU_BIG_CPU3 }
+		},
+		.num_lvts_sensor = 2,
+		.offset = 0x100,
+		.hw_tshut_temp = LVTS_HW_SHUTDOWN_MT8192,
+		.mode = LVTS_MSR_FILTERED_MODE,
+	},
+	{
+		.cal_offset = { 0x14, 0x18, 0x1c, 0x20 },
+		.lvts_sensor = {
+			{ .dt_id = MT8192_MCU_LITTLE_CPU0 },
+			{ .dt_id = MT8192_MCU_LITTLE_CPU1 },
+			{ .dt_id = MT8192_MCU_LITTLE_CPU2 },
+			{ .dt_id = MT8192_MCU_LITTLE_CPU3 }
+		},
+		.num_lvts_sensor = 4,
+		.offset = 0x200,
+		.hw_tshut_temp = LVTS_HW_SHUTDOWN_MT8192,
+		.mode = LVTS_MSR_FILTERED_MODE,
+	}
+};
+
+static const struct lvts_ctrl_data mt8192_lvts_ap_data_ctrl[] = {
+		{
+		.cal_offset = { 0x24, 0x28 },
+		.lvts_sensor = {
+			{ .dt_id = MT8192_AP_VPU0 },
+			{ .dt_id = MT8192_AP_VPU1 }
+		},
+		.num_lvts_sensor = 2,
+		.offset = 0x0,
+		.hw_tshut_temp = LVTS_HW_SHUTDOWN_MT8192,
+	},
+	{
+		.cal_offset = { 0x2c, 0x30 },
+		.lvts_sensor = {
+			{ .dt_id = MT8192_AP_GPU0 },
+			{ .dt_id = MT8192_AP_GPU1 }
+		},
+		.num_lvts_sensor = 2,
+		.offset = 0x100,
+		.hw_tshut_temp = LVTS_HW_SHUTDOWN_MT8192,
+	},
+	{
+		.cal_offset = { 0x34, 0x38 },
+		.lvts_sensor = {
+			{ .dt_id = MT8192_AP_INFRA },
+			{ .dt_id = MT8192_AP_CAM },
+		},
+		.num_lvts_sensor = 2,
+		.offset = 0x200,
+		.hw_tshut_temp = LVTS_HW_SHUTDOWN_MT8192,
+	},
+	{
+		.cal_offset = { 0x3c, 0x40, 0x44 },
+		.lvts_sensor = {
+			{ .dt_id = MT8192_AP_MD0 },
+			{ .dt_id = MT8192_AP_MD1 },
+			{ .dt_id = MT8192_AP_MD2 }
+		},
+		.num_lvts_sensor = 3,
+		.offset = 0x300,
+		.hw_tshut_temp = LVTS_HW_SHUTDOWN_MT8192,
+	}
+};
+
 static const struct lvts_data mt8195_lvts_mcu_data = {
 	.lvts_ctrl	= mt8195_lvts_mcu_data_ctrl,
 	.num_lvts_ctrl	= ARRAY_SIZE(mt8195_lvts_mcu_data_ctrl),
@@ -1290,9 +1373,21 @@ static const struct lvts_data mt8195_lvts_ap_data = {
 	.num_lvts_ctrl	= ARRAY_SIZE(mt8195_lvts_ap_data_ctrl),
 };
 
+static const struct lvts_data mt8192_lvts_mcu_data = {
+	.lvts_ctrl	= mt8192_lvts_mcu_data_ctrl,
+	.num_lvts_ctrl	= ARRAY_SIZE(mt8192_lvts_mcu_data_ctrl),
+};
+
+static const struct lvts_data mt8192_lvts_ap_data = {
+	.lvts_ctrl	= mt8192_lvts_ap_data_ctrl,
+	.num_lvts_ctrl	= ARRAY_SIZE(mt8192_lvts_ap_data_ctrl),
+};
+
 static const struct of_device_id lvts_of_match[] = {
 	{ .compatible = "mediatek,mt8195-lvts-mcu", .data = &mt8195_lvts_mcu_data },
 	{ .compatible = "mediatek,mt8195-lvts-ap", .data = &mt8195_lvts_ap_data },
+	{ .compatible = "mediatek,mt8192-lvts-mcu", .data = &mt8192_lvts_mcu_data },
+	{ .compatible = "mediatek,mt8192-lvts-ap", .data = &mt8192_lvts_ap_data },
 	{},
 };
 MODULE_DEVICE_TABLE(of, lvts_of_match);
-- 
2.41.0.rc2

