Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44F986E0B1D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 12:10:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230384AbjDMKKU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 06:10:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbjDMKKC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 06:10:02 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A36679755
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 03:09:52 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id bx15so12904956ljb.7
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 03:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681380591; x=1683972591;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8VxPnjG7Ga3tmIOUhMs54Sv+8hbNOJAgCnpbXzAxobQ=;
        b=gkNHMjZtMFbejwqHO8md1YUCsEy0fYS+RJS3bjUxHlw0snRh4wvU8AUxIGsEsMLnKa
         10et6J2RG6qAOAU1ZLvwzNAADG1ZVdTRZ8LuFsMrwPPvRhVqJ+A16dHEQwnOliK8l2jS
         QNF+uoFhI+XWvwmi4Dme6LksLIZ1uRlnXMqIxmjTQ8ucJMdJqmJRf+EonV7c1izxks0d
         8uzCwK+i2pGFbSngVB/Pu0oelXFgd5MyuGt8hk+MM22/okasA9WDelKwqvFbOWbfk8yl
         nex5srBTm3qTyHgNJiqlIFbJQ4SXUhW508wun5OiUN7TyZs16fx6YiC87mRDUmiCfiMj
         XzVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681380591; x=1683972591;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8VxPnjG7Ga3tmIOUhMs54Sv+8hbNOJAgCnpbXzAxobQ=;
        b=gJgWlvyXO0KOb6/CKVSZF61UBmLZViP8oRxoNgp11tkN0Yj2mkYu9A3HFDIYpN+dxG
         /q1+EhCdtDzjWFgOgHWoP2e8MXQRsTGhTU0fbsfydDXihYUNGnGou0a6xxb+z2M543a/
         wo/P0nmFv1mplzqaYlTn+K71OF3yaWVoWiIyx8UKAP18HIPA/afPamLclECNvNF6QEOO
         T+vV02azpzDTkKTtnpppsXj8cEyAS0WGD3BjZiEAgOw5E7RZnkH97ywg/i6B3IgHfgVd
         UBlgs7qOzRm/uUJUFMJ+xBxBDdfGUPuAhS6vXm8EMG3jjdrwhJQsPxkVkOX/Rmxywjqr
         DRUA==
X-Gm-Message-State: AAQBX9eP4snxlgWgwdqsA4X+5eQeqxm6bt5HdfKa5HOMZDn6jYLQkB1t
        g51p2CoRTtSL/B1pkRjoZvmsiQ==
X-Google-Smtp-Source: AKy350az83SRGEXISdkGaf4esD2bKF7/wkQ6o6zZO+wzeNhiP2LfMNi57V3An2zNWdJRkLqJSjz4xQ==
X-Received: by 2002:a2e:7303:0:b0:2a3:3b80:509b with SMTP id o3-20020a2e7303000000b002a33b80509bmr786082ljc.19.1681380590987;
        Thu, 13 Apr 2023 03:09:50 -0700 (PDT)
Received: from [192.168.1.101] (abyl123.neoplus.adsl.tpnet.pl. [83.9.31.123])
        by smtp.gmail.com with ESMTPSA id t20-20020a2e9d14000000b002a2e931fc48sm200482lji.140.2023.04.13.03.09.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Apr 2023 03:09:50 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Thu, 13 Apr 2023 12:09:37 +0200
Subject: [PATCH v2 3/5] drm/panel: nt36523: Add DCS backlight support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230412-topic-lenovopanel-v2-3-055c3649788e@linaro.org>
References: <20230412-topic-lenovopanel-v2-0-055c3649788e@linaro.org>
In-Reply-To: <20230412-topic-lenovopanel-v2-0-055c3649788e@linaro.org>
To:     Jianhua Lu <lujianhua000@gmail.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1681380585; l=3553;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=dc/Dvzhn8dlfyxlg6IxeHxMIzNiaOkMG9FE6LJmww9g=;
 b=/V/o7X0Ghnkvl0ZAqJzTcC2sDHw0LtDECLQxC6YaVBgZ1QbjHDaQryqxaoyjqtl7NFzPGPAzzXSJ
 BXCzY5/qBRM/zoLHtArYov4YGep8+aN5xLG+Q+CtClnBrSautTux
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This chip supports controlling the backlight via DCS commands, on at
least some panels. Add support for doing so.

Note this may only concern the NT36523*W* variant. Nobody knows, really,
there's no docs.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Jianhua Lu <lujianhua000@gmail.com>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/gpu/drm/panel/panel-novatek-nt36523.c | 68 +++++++++++++++++++++++++--
 1 file changed, 65 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-novatek-nt36523.c b/drivers/gpu/drm/panel/panel-novatek-nt36523.c
index d30dbbfb67b1..b0466abae812 100644
--- a/drivers/gpu/drm/panel/panel-novatek-nt36523.c
+++ b/drivers/gpu/drm/panel/panel-novatek-nt36523.c
@@ -5,6 +5,7 @@
  * Copyright (c) 2022, 2023 Jianhua Lu <lujianhua000@gmail.com>
  */
 
+#include <linux/backlight.h>
 #include <linux/delay.h>
 #include <linux/gpio/consumer.h>
 #include <linux/module.h>
@@ -53,6 +54,7 @@ struct panel_desc {
 	int (*init_sequence)(struct panel_info *pinfo);
 
 	bool is_dual_dsi;
+	bool has_dcs_backlight;
 };
 
 static inline struct panel_info *to_panel_info(struct drm_panel *panel)
@@ -679,6 +681,59 @@ static const struct drm_panel_funcs nt36523_panel_funcs = {
 	.get_modes = nt36523_get_modes,
 };
 
+static int nt36523_bl_update_status(struct backlight_device *bl)
+{
+	struct mipi_dsi_device *dsi = bl_get_data(bl);
+	u16 brightness = backlight_get_brightness(bl);
+	int ret;
+
+	dsi->mode_flags &= ~MIPI_DSI_MODE_LPM;
+
+	ret = mipi_dsi_dcs_set_display_brightness_large(dsi, brightness);
+	if (ret < 0)
+		return ret;
+
+	dsi->mode_flags |= MIPI_DSI_MODE_LPM;
+
+	return 0;
+}
+
+static int nt36523_bl_get_brightness(struct backlight_device *bl)
+{
+	struct mipi_dsi_device *dsi = bl_get_data(bl);
+	u16 brightness;
+	int ret;
+
+	dsi->mode_flags &= ~MIPI_DSI_MODE_LPM;
+
+	ret = mipi_dsi_dcs_get_display_brightness_large(dsi, &brightness);
+	if (ret < 0)
+		return ret;
+
+	dsi->mode_flags |= MIPI_DSI_MODE_LPM;
+
+	return brightness;
+}
+
+static const struct backlight_ops nt36523_bl_ops = {
+	.update_status = nt36523_bl_update_status,
+	.get_brightness = nt36523_bl_get_brightness,
+};
+
+static struct backlight_device *nt36523_create_backlight(struct mipi_dsi_device *dsi)
+{
+	struct device *dev = &dsi->dev;
+	const struct backlight_properties props = {
+		.type = BACKLIGHT_RAW,
+		.brightness = 512,
+		.max_brightness = 4095,
+		.scale = BACKLIGHT_SCALE_NON_LINEAR,
+	};
+
+	return devm_backlight_device_register(dev, dev_name(dev), dev, dsi,
+					      &nt36523_bl_ops, &props);
+}
+
 static int nt36523_probe(struct mipi_dsi_device *dsi)
 {
 	struct device *dev = &dsi->dev;
@@ -730,9 +785,16 @@ static int nt36523_probe(struct mipi_dsi_device *dsi)
 	mipi_dsi_set_drvdata(dsi, pinfo);
 	drm_panel_init(&pinfo->panel, dev, &nt36523_panel_funcs, DRM_MODE_CONNECTOR_DSI);
 
-	ret = drm_panel_of_backlight(&pinfo->panel);
-	if (ret)
-		return dev_err_probe(dev, ret, "failed to get backlight\n");
+	if (pinfo->desc->has_dcs_backlight) {
+		pinfo->panel.backlight = nt36523_create_backlight(dsi);
+		if (IS_ERR(pinfo->panel.backlight))
+			return dev_err_probe(dev, PTR_ERR(pinfo->panel.backlight),
+					     "Failed to create backlight\n");
+	} else {
+		ret = drm_panel_of_backlight(&pinfo->panel);
+		if (ret)
+			return dev_err_probe(dev, ret, "Failed to get backlight\n");
+	}
 
 	drm_panel_add(&pinfo->panel);
 

-- 
2.40.0

