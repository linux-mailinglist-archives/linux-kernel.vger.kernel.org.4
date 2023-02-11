Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FBA26930A6
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 12:52:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbjBKLwX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 06:52:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230210AbjBKLwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 06:52:10 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE1C311E8F
        for <linux-kernel@vger.kernel.org>; Sat, 11 Feb 2023 03:52:00 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id u21so7341440edv.3
        for <linux-kernel@vger.kernel.org>; Sat, 11 Feb 2023 03:52:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vjuw/WKHUzl4CS0skPJYkF1VfQoY8YcicD8uoD7GMqo=;
        b=MMlGoG1QFkDFz6fzoQUmVxZRb5Qrt5eSRBTekI+BGXfrpFp8ss7RqovWc9M/65m4e2
         lBxVsa52ZYn+vLJG4F9UncIF4P1HSbtEsyfHhBN189oHiHimX4c8q9JyKn8Iv6KdVKA8
         dvGZNd22XRq7Dp/QuFIM7l2givieqLuIAqZFjly0sRBisMHsampGLW5m8uhhHsOpt6pi
         ozvXoS1JCgzRmOGkSs+AfYDbmzeAn3zUzo90Lymndvred2gLK7p580lnoUojah/YozWu
         RETxhQslzqxxU4xK/Ich0474I2UNT65viWeEQ2Hw36GoCk4dAfkkxbBKv+VUDdZIszlP
         bvaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vjuw/WKHUzl4CS0skPJYkF1VfQoY8YcicD8uoD7GMqo=;
        b=Nn6dIEj0+JUZdDTBvzxjBd+4kmprNMNO4UhBSfz4jLxrJOGGgZR6M4Gu63Osqbeikc
         nJcBlQl/pFWREjA8BtamxCIz5QbOfMCS6dYoIWYsvloZydk+PX+1jWkwRM+PPW/rQHXq
         60zMYJzfwzFdg/bg5rWfgODIQrqfOy0eGt1D94T8CwbEHrLOf2Oewejj6Gv4B5VeXYgW
         m/mmRS26EXKNg84p91eZ0fgcQ1HGXfRyNTVC3djveE2ZNLGay9Ij+fQoPbjomcaAFCvH
         QGm7AhUpQu8asbs4fohCIRJnCi7tWAyZglagtvLPZ7/c0GLT/0UgONIJaYvoUfgC4RR5
         2utw==
X-Gm-Message-State: AO0yUKWJVhOfLTrvMJfTejLLpPJCu0pj53Pi/FFcv1sHV1steCFeFuOj
        evPwejg0mPlt6EG67hHB3BjvQw==
X-Google-Smtp-Source: AK7set9Z67CdTMkJyRDgYcair70owljearLWjv3M69xJNXvSz5MtdMyaiuQatBSdjmETEaPzOBN25Q==
X-Received: by 2002:a50:cd5a:0:b0:4ac:b9c0:77a6 with SMTP id d26-20020a50cd5a000000b004acb9c077a6mr912991edj.15.1676116320218;
        Sat, 11 Feb 2023 03:52:00 -0800 (PST)
Received: from localhost.localdomain (abxh117.neoplus.adsl.tpnet.pl. [83.9.1.117])
        by smtp.gmail.com with ESMTPSA id r10-20020a50d68a000000b004aabb714230sm3636070edi.35.2023.02.11.03.51.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Feb 2023 03:51:59 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Douglas Anderson <dianders@chromium.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        AngeloGioacchino Del Regno <kholk11@gmail.com>,
        Archit Taneja <architt@codeaurora.org>,
        Harigovindan P <harigovi@codeaurora.org>,
        Rajeev Nandan <quic_rajeevny@quicinc.com>,
        Stephen Boyd <swboyd@chromium.org>,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 05/10] drm/msm/dsi: dsi_cfg: Deduplicate identical structs
Date:   Sat, 11 Feb 2023 12:51:05 +0100
Message-Id: <20230211115110.1462920-6-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230211115110.1462920-1-konrad.dybcio@linaro.org>
References: <20230211115110.1462920-1-konrad.dybcio@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some structs were defined multiple times for no apparent reason.
Deduplicate them.

Fixes: 3f3c8aff1f8f ("drm/msm/dsi: Add configuration for 8x76")
Fixes: 3a3ff88a0fc1 ("drm/msm/dsi: Add 8x96 info in dsi_cfg")
Fixes: 6125bd327e16 ("drm/msm: add DSI support for sc7180")
Fixes: 65c391b31994 ("drm/msm/dsi: Add DSI support for SC7280")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/gpu/drm/msm/dsi/dsi_cfg.c | 77 +++++++++++--------------------
 1 file changed, 26 insertions(+), 51 deletions(-)

diff --git a/drivers/gpu/drm/msm/dsi/dsi_cfg.c b/drivers/gpu/drm/msm/dsi/dsi_cfg.c
index 5f62c563bd1c..860681bfc084 100644
--- a/drivers/gpu/drm/msm/dsi/dsi_cfg.c
+++ b/drivers/gpu/drm/msm/dsi/dsi_cfg.c
@@ -47,41 +47,32 @@ static const struct msm_dsi_config msm8974_apq8084_dsi_cfg = {
 	},
 };
 
-static const char * const dsi_8916_bus_clk_names[] = {
+static const char * const dsi_v1_3_1_clk_names[] = {
 	"mdp_core", "iface", "bus",
 };
 
-static const struct regulator_bulk_data msm8916_dsi_regulators[] = {
+static const struct regulator_bulk_data dsi_v1_3_1_regulators[] = {
 	{ .supply = "vdda", .init_load_uA = 100000 },	/* 1.2 V */
 	{ .supply = "vddio", .init_load_uA = 100000 },	/* 1.8 V */
 };
 
 static const struct msm_dsi_config msm8916_dsi_cfg = {
 	.io_offset = DSI_6G_REG_SHIFT,
-	.regulator_data = msm8916_dsi_regulators,
-	.num_regulators = ARRAY_SIZE(msm8916_dsi_regulators),
-	.bus_clk_names = dsi_8916_bus_clk_names,
-	.num_bus_clks = ARRAY_SIZE(dsi_8916_bus_clk_names),
+	.regulator_data = dsi_v1_3_1_regulators,
+	.num_regulators = ARRAY_SIZE(dsi_v1_3_1_regulators),
+	.bus_clk_names = dsi_v1_3_1_clk_names,
+	.num_bus_clks = ARRAY_SIZE(dsi_v1_3_1_clk_names),
 	.io_start = {
 		{ 0x1a98000, 0 },
 	},
 };
 
-static const char * const dsi_8976_bus_clk_names[] = {
-	"mdp_core", "iface", "bus",
-};
-
-static const struct regulator_bulk_data msm8976_dsi_regulators[] = {
-	{ .supply = "vdda", .init_load_uA = 100000 },	/* 1.2 V */
-	{ .supply = "vddio", .init_load_uA = 100000 },	/* 1.8 V */
-};
-
 static const struct msm_dsi_config msm8976_dsi_cfg = {
 	.io_offset = DSI_6G_REG_SHIFT,
-	.regulator_data = msm8976_dsi_regulators,
-	.num_regulators = ARRAY_SIZE(msm8976_dsi_regulators),
-	.bus_clk_names = dsi_8976_bus_clk_names,
-	.num_bus_clks = ARRAY_SIZE(dsi_8976_bus_clk_names),
+	.regulator_data = dsi_v1_3_1_regulators,
+	.num_regulators = ARRAY_SIZE(dsi_v1_3_1_regulators),
+	.bus_clk_names = dsi_v1_3_1_clk_names,
+	.num_bus_clks = ARRAY_SIZE(dsi_v1_3_1_clk_names),
 	.io_start = {
 		{ 0x1a94000, 0x1a96000, 0 },
 	},
@@ -107,10 +98,6 @@ static const struct msm_dsi_config msm8994_dsi_cfg = {
 	},
 };
 
-static const char * const dsi_8996_bus_clk_names[] = {
-	"mdp_core", "iface", "bus", "core_mmss",
-};
-
 static const struct regulator_bulk_data msm8996_dsi_regulators[] = {
 	{ .supply = "vdda", .init_load_uA = 18160 },	/* 1.25 V */
 	{ .supply = "vcca", .init_load_uA = 17000 },	/* 0.925 V */
@@ -121,8 +108,8 @@ static const struct msm_dsi_config msm8996_dsi_cfg = {
 	.io_offset = DSI_6G_REG_SHIFT,
 	.regulator_data = msm8996_dsi_regulators,
 	.num_regulators = ARRAY_SIZE(msm8996_dsi_regulators),
-	.bus_clk_names = dsi_8996_bus_clk_names,
-	.num_bus_clks = ARRAY_SIZE(dsi_8996_bus_clk_names),
+	.bus_clk_names = dsi_6g_bus_clk_names,
+	.num_bus_clks = ARRAY_SIZE(dsi_6g_bus_clk_names),
 	.io_start = {
 		{ 0x994000, 0x996000, 0 },
 	},
@@ -167,24 +154,20 @@ static const struct msm_dsi_config sdm660_dsi_cfg = {
 	},
 };
 
-static const char * const dsi_sdm845_bus_clk_names[] = {
+static const char * const dsi_v2_4_clk_names[] = {
 	"iface", "bus",
 };
 
-static const char * const dsi_sc7180_bus_clk_names[] = {
-	"iface", "bus",
-};
-
-static const struct regulator_bulk_data sdm845_dsi_regulators[] = {
+static const struct regulator_bulk_data dsi_v2_4_regulators[] = {
 	{ .supply = "vdda", .init_load_uA = 21800 },	/* 1.2 V */
 };
 
 static const struct msm_dsi_config sdm845_dsi_cfg = {
 	.io_offset = DSI_6G_REG_SHIFT,
-	.regulator_data = sdm845_dsi_regulators,
-	.num_regulators = ARRAY_SIZE(sdm845_dsi_regulators),
-	.bus_clk_names = dsi_sdm845_bus_clk_names,
-	.num_bus_clks = ARRAY_SIZE(dsi_sdm845_bus_clk_names),
+	.regulator_data = dsi_v2_4_regulators,
+	.num_regulators = ARRAY_SIZE(dsi_v2_4_regulators),
+	.bus_clk_names = dsi_v2_4_clk_names,
+	.num_bus_clks = ARRAY_SIZE(dsi_v2_4_clk_names),
 	.io_start = {
 		{ 0xae94000, 0xae96000, 0 },
 	},
@@ -198,32 +181,24 @@ static const struct msm_dsi_config sm8550_dsi_cfg = {
 	.io_offset = DSI_6G_REG_SHIFT,
 	.regulator_data = sm8550_dsi_regulators,
 	.num_regulators = ARRAY_SIZE(sm8550_dsi_regulators),
-	.bus_clk_names = dsi_sdm845_bus_clk_names,
-	.num_bus_clks = ARRAY_SIZE(dsi_sdm845_bus_clk_names),
+	.bus_clk_names = dsi_v2_4_clk_names,
+	.num_bus_clks = ARRAY_SIZE(dsi_v2_4_clk_names),
 	.io_start = {
 		{ 0xae94000, 0xae96000, 0 },
 	},
 };
 
-static const struct regulator_bulk_data sc7180_dsi_regulators[] = {
-	{ .supply = "vdda", .init_load_uA = 21800 },	/* 1.2 V */
-};
-
 static const struct msm_dsi_config sc7180_dsi_cfg = {
 	.io_offset = DSI_6G_REG_SHIFT,
-	.regulator_data = sc7180_dsi_regulators,
-	.num_regulators = ARRAY_SIZE(sc7180_dsi_regulators),
-	.bus_clk_names = dsi_sc7180_bus_clk_names,
-	.num_bus_clks = ARRAY_SIZE(dsi_sc7180_bus_clk_names),
+	.regulator_data = dsi_v2_4_regulators,
+	.num_regulators = ARRAY_SIZE(dsi_v2_4_regulators),
+	.bus_clk_names = dsi_v2_4_clk_names,
+	.num_bus_clks = ARRAY_SIZE(dsi_v2_4_clk_names),
 	.io_start = {
 		{ 0xae94000, 0 },
 	},
 };
 
-static const char * const dsi_sc7280_bus_clk_names[] = {
-	"iface", "bus",
-};
-
 static const struct regulator_bulk_data sc7280_dsi_regulators[] = {
 	{ .supply = "vdda", .init_load_uA = 8350 },	/* 1.2 V */
 };
@@ -232,8 +207,8 @@ static const struct msm_dsi_config sc7280_dsi_cfg = {
 	.io_offset = DSI_6G_REG_SHIFT,
 	.regulator_data = sc7280_dsi_regulators,
 	.num_regulators = ARRAY_SIZE(sc7280_dsi_regulators),
-	.bus_clk_names = dsi_sc7280_bus_clk_names,
-	.num_bus_clks = ARRAY_SIZE(dsi_sc7280_bus_clk_names),
+	.bus_clk_names = dsi_v2_4_clk_names,
+	.num_bus_clks = ARRAY_SIZE(dsi_v2_4_clk_names),
 	.io_start = {
 		{ 0xae94000, 0xae96000, 0 },
 	},
-- 
2.39.1

