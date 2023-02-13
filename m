Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 292A669456F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 13:11:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231461AbjBMMLL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 07:11:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbjBMMKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 07:10:47 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 217BA199EA
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 04:10:32 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id qw12so31327109ejc.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 04:10:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vNtO6TjtSJEcp8uPwtQuefcLvw6u6ONtxjs37g8Gm+4=;
        b=toYQaFXONrXRhcBi2/hw4dFUyhYBRB7y87GTU4Y3klK3WIh2/uojlLE5PuGh5xcMTo
         i4tnKd/9xLb6WIiHTyIVSfDnRmJp6YE/wtXaunfK2/hlmGOlKcJ2+D7LG4ZvuV8ilmk9
         3Bue5mpoKtVVoa8G0pnbWlKaxmTQZVMxOPJJTc4UxtNn27hpuHtphGJMZI8N1YQjCGC0
         EIMfxN3ypFRJMClIQ2Zfb9sckLN/A9nDfpSB4tFeiFAsfZUZF+chkCbH3N7rB7Ib6itM
         DAK8Uh31Rrf/AAEuPq/JAtje50o8BBtM8UA7qsrFLsl6AEBUpE1OyFB5HjQT6Eiv+OIv
         B18w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vNtO6TjtSJEcp8uPwtQuefcLvw6u6ONtxjs37g8Gm+4=;
        b=GHOVbdNX6pOQTez2NVjHIoe2K6kM5LoUmq58DrcdF8WlLdvKqx46ifiupmSvew8FWT
         pcAG4FyG8MIIDfaEmPLXrqu9U/VpujNnO9M3wMgAEFe0hyIVPdAa/zAkYMgAsZ309H3/
         1c2EXbp4C6yCLmWwewobkcjCdDn8QvoMwUbrR4Ty3/ipI3FfwyX5SRajIfnyY3TrEQOE
         7PcZWithBHbSKPNNLYVEC3xU8Rbsz2P1nFSU6529bB2vUxTgCEjDcLXinCdYZ7NB6i7S
         DwPbwfZXI123Wrjv+5wM5yeZw84hmFshXFo0koXRvvZCmTB1n6A/HjDHz7uM0d/zgJNs
         +uLA==
X-Gm-Message-State: AO0yUKVkvu9ta6F0gLOG7t20vMyJfpfjLJ/kuPQWFw4nQpXvewo8DFaa
        y6jMPf9+tMqzAAxioYqaGFKxvA==
X-Google-Smtp-Source: AK7set+2HZz0BOon+XsyYOSj4boCldns/BHsuJJeXI+oH2c45FDwpraOuwUwCHEGTa8c1INQ+1A1mg==
X-Received: by 2002:a17:907:6090:b0:8ae:3380:ff56 with SMTP id ht16-20020a170907609000b008ae3380ff56mr22903380ejc.63.1676290228220;
        Mon, 13 Feb 2023 04:10:28 -0800 (PST)
Received: from localhost.localdomain (abxh117.neoplus.adsl.tpnet.pl. [83.9.1.117])
        by smtp.gmail.com with ESMTPSA id dt19-20020a170906b79300b0088ed7de4821sm6651586ejb.158.2023.02.13.04.10.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Feb 2023 04:10:27 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Douglas Anderson <dianders@chromium.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/9] drm/msm/dsi: dsi_cfg: Deduplicate identical structs
Date:   Mon, 13 Feb 2023 13:10:07 +0100
Message-Id: <20230213121012.1768296-5-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230213121012.1768296-1-konrad.dybcio@linaro.org>
References: <20230213121012.1768296-1-konrad.dybcio@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some structs were defined multiple times for no apparent reason.
Deduplicate them.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/gpu/drm/msm/dsi/dsi_cfg.c | 77 +++++++++++--------------------
 1 file changed, 26 insertions(+), 51 deletions(-)

diff --git a/drivers/gpu/drm/msm/dsi/dsi_cfg.c b/drivers/gpu/drm/msm/dsi/dsi_cfg.c
index 6c192963c100..d39521850018 100644
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
 		{ 0x1a98000 },
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
 		{ 0x1a94000, 0x1a96000 },
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
 		{ 0x994000, 0x996000 },
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
 		{ 0xae94000, 0xae96000 },
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
 		{ 0xae94000, 0xae96000 },
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
 		{ 0xae94000 },
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
 		{ 0xae94000, 0xae96000 },
 	},
-- 
2.39.1

