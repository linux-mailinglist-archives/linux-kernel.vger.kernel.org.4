Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC10A67413D
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 19:49:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230391AbjASStr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 13:49:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230360AbjASStf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 13:49:35 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCFA294C91;
        Thu, 19 Jan 2023 10:49:25 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id j17so4584612lfr.3;
        Thu, 19 Jan 2023 10:49:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KjYSoLcwf7EqtitvVcOTllqc2UQ4a0rkK6OglvdaZqI=;
        b=XakzkJo1d7N4N7DkKi9mHmh1lucNCw3Ur4cZb3/FtRcHSG6kK0fg0VmQOrJjpSHFbv
         gDAhsVrSB2wFhL/Cj3BWGcCRfK14n75kTvu9o0WuA1p27Oy/w3S6l9tL0T43D7CJhT6i
         lmclIQ9IsbKkFAN2ITAdZzY0PPUfj2rlMGatAY4F6ZCgiSgnvEuwOUwVcI9zhTp0rJvt
         QBVqK+Inm1tiZiPBixukk1vATXLjsC+OBU4UHo5XcNQf3OC7VGNkTHAghBYjjIrDWQxx
         /jGLUhDmQ21wZDDTuA02kDGvpzPBhoSVcttWo9j9OvA+VQ6JAoIn91fADMZTvgJ9c/wd
         ta+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KjYSoLcwf7EqtitvVcOTllqc2UQ4a0rkK6OglvdaZqI=;
        b=jjnKyfCTtz7oUpGDy1ylMo/OfoEmm9NMNzrrclv1uB5Jbm2sK48u5DKfet4dQtSkU0
         2+7WCdaGAzAu+oDsiFpzmbD6JzyQUdMdY4B9LLLUbMoWNUPfQMKNGMSTLoVf8mUa4e2U
         1wyF12OveHbsO3IPr7Dj0gzvdYqhuLQx+Qm8QfH2aVKJ5E4ns2zzUEn42RcxmlChV98U
         YiiE2BbrHl66+uDygqp5auEAfQMs6DLmYze27/thHaAGpT4XasgIvG68Pz/48VAiQ/bH
         8VJeVU/1Vvu2RTbr3rAyd+uws8pPwXqtZ1MrKsLZAJDd7Q7FZT39weCRziJRLKfcLXW+
         ub8w==
X-Gm-Message-State: AFqh2kqAjmXBnz19cuiyhJwUWAvojbytLjqAqvVN4TlYy2osFs4Fts94
        eBMqMM2fNv+RtSGz/gvU8gc=
X-Google-Smtp-Source: AMrXdXv1pJP5S8AZ+yVAIwUdPkFLt0kCm3GHTmVeWhx46YujL7HwAwoo4UkMmOKA8DqpaG1bcv0ZzQ==
X-Received: by 2002:a05:6512:12d1:b0:4ca:5013:b0e7 with SMTP id p17-20020a05651212d100b004ca5013b0e7mr4114837lfg.59.1674154163242;
        Thu, 19 Jan 2023 10:49:23 -0800 (PST)
Received: from U19.ag.local (static.187.76.181.135.clients.your-server.de. [135.181.76.187])
        by smtp.gmail.com with ESMTPSA id b31-20020a0565120b9f00b004d30752a561sm2112737lfv.298.2023.01.19.10.49.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 10:49:22 -0800 (PST)
From:   Alibek Omarov <a1ba.omarov@gmail.com>
Cc:     a1ba.omarov@gmail.com, alexander.sverdlin@siemens.com,
        macromorgan@hotmail.com, Sandy Huang <hjc@rock-chips.com>,
        =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Peter Geis <pgwipeout@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Frank Wunderlich <frank-w@public-files.de>,
        Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] drm/rockchip: lvds: add rk3568 support
Date:   Thu, 19 Jan 2023 21:48:03 +0300
Message-Id: <20230119184807.171132-2-a1ba.omarov@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230119184807.171132-1-a1ba.omarov@gmail.com>
References: <20230119184807.171132-1-a1ba.omarov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

One of the ports of RK3568 can be configured as LVDS, re-using the DSI DPHY

Signed-off-by: Alibek Omarov <a1ba.omarov@gmail.com>
---
 drivers/gpu/drm/rockchip/rockchip_lvds.c | 144 +++++++++++++++++++++--
 drivers/gpu/drm/rockchip/rockchip_lvds.h |  10 ++
 2 files changed, 147 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_lvds.c b/drivers/gpu/drm/rockchip/rockchip_lvds.c
index 68f6ebb33460..83c60240af85 100644
--- a/drivers/gpu/drm/rockchip/rockchip_lvds.c
+++ b/drivers/gpu/drm/rockchip/rockchip_lvds.c
@@ -433,6 +433,90 @@ static void px30_lvds_encoder_disable(struct drm_encoder *encoder)
 	drm_panel_unprepare(lvds->panel);
 }
 
+static int rk3568_lvds_poweron(struct rockchip_lvds *lvds)
+{
+	int ret;
+
+	ret = clk_enable(lvds->pclk);
+	if (ret < 0) {
+		DRM_DEV_ERROR(lvds->dev, "failed to enable lvds pclk %d\n", ret);
+		return ret;
+	}
+
+	ret = pm_runtime_get_sync(lvds->dev);
+	if (ret < 0) {
+		DRM_DEV_ERROR(lvds->dev, "failed to get pm runtime: %d\n", ret);
+		clk_disable(lvds->pclk);
+		return ret;
+	}
+
+	/* Enable LVDS mode */
+	return regmap_update_bits(lvds->grf, RK3568_GRF_VO_CON2,
+				  RK3568_LVDS0_MODE_EN(1),
+				  RK3568_LVDS0_MODE_EN(1));
+}
+
+static void rk3568_lvds_poweroff(struct rockchip_lvds *lvds)
+{
+	regmap_update_bits(lvds->grf, RK3568_GRF_VO_CON2,
+			   RK3568_LVDS0_MODE_EN(1) | RK3568_LVDS0_P2S_EN(1),
+			   RK3568_LVDS0_MODE_EN(0) | RK3568_LVDS0_P2S_EN(0));
+
+	pm_runtime_put(lvds->dev);
+	clk_disable(lvds->pclk);
+}
+
+static int rk3568_lvds_grf_config(struct drm_encoder *encoder,
+				struct drm_display_mode *mode)
+{
+	struct rockchip_lvds *lvds = encoder_to_lvds(encoder);
+
+	if (lvds->output != DISPLAY_OUTPUT_LVDS) {
+		DRM_DEV_ERROR(lvds->dev, "Unsupported display output %d\n",
+			      lvds->output);
+		return -EINVAL;
+	}
+
+	/* Set format */
+	return regmap_update_bits(lvds->grf, RK3568_GRF_VO_CON0,
+				  RK3568_LVDS0_SELECT(3),
+				  RK3568_LVDS0_SELECT(lvds->format));
+}
+
+static void rk3568_lvds_encoder_enable(struct drm_encoder *encoder)
+{
+	struct rockchip_lvds *lvds = encoder_to_lvds(encoder);
+	struct drm_display_mode *mode = &encoder->crtc->state->adjusted_mode;
+	int ret;
+
+	drm_panel_prepare(lvds->panel);
+
+	ret = rk3568_lvds_poweron(lvds);
+	if (ret) {
+		DRM_DEV_ERROR(lvds->dev, "failed to power on LVDS: %d\n", ret);
+		drm_panel_unprepare(lvds->panel);
+		return;
+	}
+
+	ret = rk3568_lvds_grf_config(encoder, mode);
+	if (ret) {
+		DRM_DEV_ERROR(lvds->dev, "failed to configure LVDS: %d\n", ret);
+		drm_panel_unprepare(lvds->panel);
+		return;
+	}
+
+	drm_panel_enable(lvds->panel);
+}
+
+static void rk3568_lvds_encoder_disable(struct drm_encoder *encoder)
+{
+	struct rockchip_lvds *lvds = encoder_to_lvds(encoder);
+
+	drm_panel_disable(lvds->panel);
+	rk3568_lvds_poweroff(lvds);
+	drm_panel_unprepare(lvds->panel);
+}
+
 static const
 struct drm_encoder_helper_funcs rk3288_lvds_encoder_helper_funcs = {
 	.enable = rk3288_lvds_encoder_enable,
@@ -447,6 +531,13 @@ struct drm_encoder_helper_funcs px30_lvds_encoder_helper_funcs = {
 	.atomic_check = rockchip_lvds_encoder_atomic_check,
 };
 
+static const
+struct drm_encoder_helper_funcs rk3568_lvds_encoder_helper_funcs = {
+	.enable = rk3568_lvds_encoder_enable,
+	.disable = rk3568_lvds_encoder_disable,
+	.atomic_check = rockchip_lvds_encoder_atomic_check,
+};
+
 static int rk3288_lvds_probe(struct platform_device *pdev,
 			     struct rockchip_lvds *lvds)
 {
@@ -491,6 +582,26 @@ static int rk3288_lvds_probe(struct platform_device *pdev,
 	return 0;
 }
 
+static int rockchip_lvds_phy_probe(struct platform_device *pdev,
+				   struct rockchip_lvds *lvds)
+{
+	int ret;
+
+	lvds->dphy = devm_phy_get(&pdev->dev, "dphy");
+	if (IS_ERR(lvds->dphy))
+		return PTR_ERR(lvds->dphy);
+
+	ret = phy_init(lvds->dphy);
+	if (ret)
+		return ret;
+
+	ret = phy_set_mode(lvds->dphy, PHY_MODE_LVDS);
+	if (ret)
+		return ret;
+
+	return phy_power_on(lvds->dphy);
+}
+
 static int px30_lvds_probe(struct platform_device *pdev,
 			   struct rockchip_lvds *lvds)
 {
@@ -503,20 +614,28 @@ static int px30_lvds_probe(struct platform_device *pdev,
 	if (ret)
 		return ret;
 
-	/* PHY */
-	lvds->dphy = devm_phy_get(&pdev->dev, "dphy");
-	if (IS_ERR(lvds->dphy))
-		return PTR_ERR(lvds->dphy);
+	return rockchip_lvds_phy_probe(pdev, lvds);
+}
 
-	ret = phy_init(lvds->dphy);
+static int rk3568_lvds_probe(struct platform_device *pdev,
+			     struct rockchip_lvds *lvds)
+{
+	int ret;
+
+	ret = regmap_update_bits(lvds->grf, RK3568_GRF_VO_CON0,
+				  RK3568_LVDS0_MSBSEL(1),
+				  RK3568_LVDS0_MSBSEL(1));
 	if (ret)
 		return ret;
 
-	ret = phy_set_mode(lvds->dphy, PHY_MODE_LVDS);
+	ret = regmap_update_bits(lvds->grf, RK3568_GRF_VO_CON2,
+				 RK3568_LVDS0_P2S_EN(1),
+				 RK3568_LVDS0_P2S_EN(1));
+
 	if (ret)
 		return ret;
 
-	return phy_power_on(lvds->dphy);
+	return rockchip_lvds_phy_probe(pdev, lvds);
 }
 
 static const struct rockchip_lvds_soc_data rk3288_lvds_data = {
@@ -529,6 +648,11 @@ static const struct rockchip_lvds_soc_data px30_lvds_data = {
 	.helper_funcs = &px30_lvds_encoder_helper_funcs,
 };
 
+static const struct rockchip_lvds_soc_data rk3568_lvds_data = {
+	.probe = rk3568_lvds_probe,
+	.helper_funcs = &rk3568_lvds_encoder_helper_funcs,
+};
+
 static const struct of_device_id rockchip_lvds_dt_ids[] = {
 	{
 		.compatible = "rockchip,rk3288-lvds",
@@ -538,6 +662,10 @@ static const struct of_device_id rockchip_lvds_dt_ids[] = {
 		.compatible = "rockchip,px30-lvds",
 		.data = &px30_lvds_data
 	},
+	{
+		.compatible = "rockchip,rk3568-lvds",
+		.data = &rk3568_lvds_data
+	},
 	{}
 };
 MODULE_DEVICE_TABLE(of, rockchip_lvds_dt_ids);
@@ -612,6 +740,8 @@ static int rockchip_lvds_bind(struct device *dev, struct device *master,
 	encoder = &lvds->encoder.encoder;
 	encoder->possible_crtcs = drm_of_find_possible_crtcs(drm_dev,
 							     dev->of_node);
+	rockchip_drm_encoder_set_crtc_endpoint_id(&lvds->encoder,
+						  dev->of_node, 0, 0);
 
 	ret = drm_simple_encoder_init(drm_dev, encoder, DRM_MODE_ENCODER_LVDS);
 	if (ret < 0) {
diff --git a/drivers/gpu/drm/rockchip/rockchip_lvds.h b/drivers/gpu/drm/rockchip/rockchip_lvds.h
index 4ce967d23813..57decb33f779 100644
--- a/drivers/gpu/drm/rockchip/rockchip_lvds.h
+++ b/drivers/gpu/drm/rockchip/rockchip_lvds.h
@@ -120,4 +120,14 @@
 #define   PX30_LVDS_P2S_EN(val)			HIWORD_UPDATE(val,  6,  6)
 #define   PX30_LVDS_VOP_SEL(val)		HIWORD_UPDATE(val,  1,  1)
 
+#define RK3568_GRF_VO_CON0			0x0360
+#define   RK3568_LVDS0_SELECT(val)		HIWORD_UPDATE(val,  5,  4)
+#define   RK3568_LVDS0_MSBSEL(val)		HIWORD_UPDATE(val,  3,  3)
+
+#define RK3568_GRF_VO_CON2			0x0368
+#define   RK3568_LVDS0_DCLK_INV_SEL(val)	HIWORD_UPDATE(val,  9,  9)
+#define   RK3568_LVDS0_DCLK_DIV2_SEL(val)	HIWORD_UPDATE(val,  8,  8)
+#define   RK3568_LVDS0_MODE_EN(val)		HIWORD_UPDATE(val,  1,  1)
+#define   RK3568_LVDS0_P2S_EN(val)		HIWORD_UPDATE(val,  0,  0)
+
 #endif /* _ROCKCHIP_LVDS_ */
-- 
2.34.1

