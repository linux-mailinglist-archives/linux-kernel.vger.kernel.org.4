Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27F16714EA4
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 18:46:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbjE2Qq0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 12:46:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbjE2QqS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 12:46:18 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9BF5D2
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 09:46:15 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-5147f7d045bso4700355a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 09:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1685378774; x=1687970774;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=okJUfe+J2lktOzbTBoR7fCmJ4uPpfts4ISVsUrRsL8s=;
        b=1Ct2HKvKxppmAt3WslN5ekIsk3Ti5wkXJOaYEQq4Aqt1ERIO+MObGuoSun48zPGh/6
         1+m/UleVx1iF3cYfEcRmNIgR066/IowWPZtaQS73P2R8nzqD3wLZ1a7zsWmMR1nwOEsb
         NAjC+KmybjL1aIg1F7Z71bk9K/dYnaMKn7/anAKmtrlzLDCLvtRoXhcG0c40sUHLsxao
         dniqD+yL17nHxVLMVG2nFyEA1NRsIn1pTVDDZ1cKhlJ4T4f1MiYP2M6qkD9g3YSU/mn9
         kvPm/6f/iZj18nLqnLV3C0sHVfTg5xj1kuK21BxiRmSqblaqObGIXqYEoiw/iatpwrDE
         59Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685378774; x=1687970774;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=okJUfe+J2lktOzbTBoR7fCmJ4uPpfts4ISVsUrRsL8s=;
        b=ZJHYYq/l7288qDNMPSxhRmzUuq1bFeNwtk+d5g2fV/RQql6SseEJ58RVk3GKJ8vxgp
         pRtc+ftop7qm0gZcaDYZ/4kqi3Qlq94zNSoPIqL1a4c5p/544CCXPYCLZXL6wC4vL0vA
         c7EejsPEzR9KMKtWna5RAZu9kYWirUp3uPD7fyCmRMlKUTEZ7ONm04iMZwBAcI5oYOXT
         hNPOtzwsYFIGX3TulflsYeT3B/0n+gwQPb+vt4PgJKxyaXhsD35n2ZJTCZKCxmLwWLW4
         CbDGsUBnItkRghLnYPJos3s/D62WZsaxTmqS8El3zjRWyu1hKVOxLNqauKFffCtrb9kP
         Sidw==
X-Gm-Message-State: AC+VfDzuufdrQ5VqgcoRkysu4ql/CETaXRD3Nj4TJQMI0vroFguTXSGo
        egAi/5yLFDB0QVcRIE/iTNL6zw==
X-Google-Smtp-Source: ACHHUZ4MOIYTHTGclDNGhT7EA/gcBVTkBZq3YDK2pAqHCZjwGgo+m2IybXiQCUxUe0jTf8EK3KJtfQ==
X-Received: by 2002:a50:fc0a:0:b0:510:f3a6:d50 with SMTP id i10-20020a50fc0a000000b00510f3a60d50mr195454edr.36.1685378774115;
        Mon, 29 May 2023 09:46:14 -0700 (PDT)
Received: from ph18.baylibre (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id f4-20020aa7d844000000b0050d89daaa70sm3248578eds.2.2023.05.29.09.46.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 May 2023 09:46:13 -0700 (PDT)
From:   =?UTF-8?q?Bernhard=20Rosenkr=C3=A4nzer?= <bero@baylibre.com>
To:     daniel.lezcano@linaro.org, angelogioacchino.delregno@collabora.com,
        rafael@kernel.org, amitk@kernel.org, rui.zhang@intel.com,
        matthias.bgg@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, rdunlap@infradead.org,
        ye.xingchen@zte.com.cn, p.zabel@pengutronix.de
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        wenst@chromium.org, james.lo@mediatek.com,
        rex-bc.chen@mediatek.com, nfraprado@collabora.com,
        abailon@baylibre.com, amergnat@baylibre.com, khilman@baylibre.com
Subject: [PATCH v3 3/5] thermal/drivers/mediatek/lvts_thermal: Add mt8192 support
Date:   Mon, 29 May 2023 18:46:03 +0200
Message-ID: <20230529164605.3552619-4-bero@baylibre.com>
X-Mailer: git-send-email 2.41.0.rc2
In-Reply-To: <20230529164605.3552619-1-bero@baylibre.com>
References: <20230529164605.3552619-1-bero@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
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

