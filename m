Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0597965CF39
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 10:09:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238980AbjADJJV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 04:09:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238937AbjADJIz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 04:08:55 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0408DF88
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 01:08:54 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id g25-20020a7bc4d9000000b003d97c8d4941so20302475wmk.4
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jan 2023 01:08:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RW8zq/j/mruXN6/WTKeap/h29XYUPaSNwCYMmo6FJKQ=;
        b=nMMd/v3HFY4szFYLEaKcpk0c7SiE4v2hmay0BJN0rm4EPyuTnUt7yH9fmMkpWpYQ1x
         kv1GxehAQfBLQpUThWtUZkXRmS3BCK/RKPUVkkP7ieceowGRkjGW1Vx7Rn2ZAzofiIgT
         Lmk7XGz1HaB0HEYWNZFP1lA9hopNgFGdtdj5seBbURcaFn31wgaXvIqSkeO4Ja7CQluD
         VFIwcMtpzoXmHvJLfiJI0WPTjY6w6Za/SRQ9BWV39o800kr+LlYJfZ6hWYtmOXvYHoht
         qa2FcB1Oncjo1An90deepimnrlPzGUBh1gIk4SvwDZ8Bbpe5tdEeEy0dC/xF1Ecr0Gzo
         v2EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RW8zq/j/mruXN6/WTKeap/h29XYUPaSNwCYMmo6FJKQ=;
        b=ZJaIFAj3DM/124dL9xGPmNGDEGnq/we1s2ZS8yX99nQQhf3P8wV2N3SUS70/OzQkGi
         pA1nFlwVdjqOb6lZziPsM6AkEhFdTa45u1FoOKr71OypaiKUYXM3DJWMrdCl8EDj6sAj
         Fz3h/PNyfh3x7T0Mc9HPYOoi/z2cDUzfd4aL6H181oxMG3yWsskUfBgjZPGaVfeRH7Ln
         osegZv7COnlhfVaN9aXjzU5zPBe+6R47D2+1i/E73Jpty+1cA4Zj79t8GxnuhKI8Y3lA
         ivpXflVnTMO2YewKKEC5InqxlW3YYIVUIgQiGdJ9ffeGovFWMD2i3f4Od3fROQQi1Zas
         Jxtw==
X-Gm-Message-State: AFqh2kr4Lw80CcOf6ddDSljOPZISbwpOke48n/k1SaqOKKS5a3et9rNe
        DhRjWC/Feravk9QMJrZAKTaq/w==
X-Google-Smtp-Source: AMrXdXtTn0L2mtxXUP6CMnmtcwC9FWRBQC4xzA90BRPGajQqe4oSN3qZ4i7MrOggned3SnNYib/zUw==
X-Received: by 2002:a05:600c:c8a:b0:3d9:7062:e0b7 with SMTP id fj10-20020a05600c0c8a00b003d97062e0b7mr27355377wmb.33.1672823333305;
        Wed, 04 Jan 2023 01:08:53 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id j34-20020a05600c1c2200b003d98438a43asm36124622wms.34.2023.01.04.01.08.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 01:08:52 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Wed, 04 Jan 2023 10:08:48 +0100
Subject: [PATCH 6/6] drm/msm/dsi: add support for DSI 2.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230103-topic-sm8550-upstream-mdss-dsi-v1-6-9ccd7e652fcd@linaro.org>
References: <20230103-topic-sm8550-upstream-mdss-dsi-v1-0-9ccd7e652fcd@linaro.org>
In-Reply-To: <20230103-topic-sm8550-upstream-mdss-dsi-v1-0-9ccd7e652fcd@linaro.org>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Marek <jonathan@marek.ca>
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.11.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for DSI 2.7.0 (block used on sm8550).

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/gpu/drm/msm/dsi/dsi_cfg.c | 16 ++++++++++++++++
 drivers/gpu/drm/msm/dsi/dsi_cfg.h |  1 +
 2 files changed, 17 insertions(+)

diff --git a/drivers/gpu/drm/msm/dsi/dsi_cfg.c b/drivers/gpu/drm/msm/dsi/dsi_cfg.c
index 59a4cc95a251..33884ebd2f86 100644
--- a/drivers/gpu/drm/msm/dsi/dsi_cfg.c
+++ b/drivers/gpu/drm/msm/dsi/dsi_cfg.c
@@ -181,6 +181,20 @@ static const struct msm_dsi_config sdm845_dsi_cfg = {
 	.num_dsi = 2,
 };
 
+static const struct regulator_bulk_data sm8550_dsi_regulators[] = {
+	{ .supply = "vdda", .init_load_uA = 16800 },	/* 1.2 V */
+};
+
+static const struct msm_dsi_config sm8550_dsi_cfg = {
+	.io_offset = DSI_6G_REG_SHIFT,
+	.regulator_data = sm8550_dsi_regulators,
+	.num_regulators = ARRAY_SIZE(sm8550_dsi_regulators),
+	.bus_clk_names = dsi_sdm845_bus_clk_names,
+	.num_bus_clks = ARRAY_SIZE(dsi_sdm845_bus_clk_names),
+	.io_start = { 0xae94000, 0xae96000 },
+	.num_dsi = 2,
+};
+
 static const struct regulator_bulk_data sc7180_dsi_regulators[] = {
 	{ .supply = "vdda", .init_load_uA = 21800 },	/* 1.2 V */
 };
@@ -302,6 +316,8 @@ static const struct msm_dsi_cfg_handler dsi_cfg_handlers[] = {
 		&sc7280_dsi_cfg, &msm_dsi_6g_v2_host_ops},
 	{MSM_DSI_VER_MAJOR_6G, MSM_DSI_6G_VER_MINOR_V2_6_0,
 		&sdm845_dsi_cfg, &msm_dsi_6g_v2_host_ops},
+	{MSM_DSI_VER_MAJOR_6G, MSM_DSI_6G_VER_MINOR_V2_7_0,
+		&sm8550_dsi_cfg, &msm_dsi_6g_v2_host_ops},
 };
 
 const struct msm_dsi_cfg_handler *msm_dsi_cfg_get(u32 major, u32 minor)
diff --git a/drivers/gpu/drm/msm/dsi/dsi_cfg.h b/drivers/gpu/drm/msm/dsi/dsi_cfg.h
index 95957fab499d..44be4a88aa83 100644
--- a/drivers/gpu/drm/msm/dsi/dsi_cfg.h
+++ b/drivers/gpu/drm/msm/dsi/dsi_cfg.h
@@ -26,6 +26,7 @@
 #define MSM_DSI_6G_VER_MINOR_V2_4_1	0x20040001
 #define MSM_DSI_6G_VER_MINOR_V2_5_0	0x20050000
 #define MSM_DSI_6G_VER_MINOR_V2_6_0	0x20060000
+#define MSM_DSI_6G_VER_MINOR_V2_7_0	0x20070000
 
 #define MSM_DSI_V2_VER_MINOR_8064	0x0
 

-- 
2.34.1
