Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E1806DFEF1
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 21:46:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbjDLTq1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 15:46:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbjDLTqR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 15:46:17 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 785D065BA
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 12:46:16 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id m4so15954538lfj.13
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 12:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681328774; x=1683920774;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V2syyztnoLcpIUNviLs7GJ0HFV5Q0EtJR2piodIqSJw=;
        b=RfudjppL9G0xxKBlGgs2DSoQTslqgi59iqMfEWCBk8iN+Dg6zk7BOuKfvO0F1utOJM
         ZYzqDjUu7wxeXrBJ2+2dejIwb/1G9bHt0x0cRvyn8zXrpGSOYp4/otzdpnATTQiLqXwY
         4AE6lalKMQtRAoYa1aN8R8cdwu5lKCvOSCGKLsBblI6t41lp4tzvWtGMeimGAGrwDhfC
         Qzx7qc1ngIAoaHMIaSOf6vA0fzpMz+gAOqb5me3vCZMOskQYOBRMisf1FHAWiQodVTbu
         o9IHYRb4uw94Rse0aEMerz2ulP3wrSf3/iMuRdtHyv1iMjouAjAcNm/ZSVuCFdWFF9Xn
         4EuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681328774; x=1683920774;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V2syyztnoLcpIUNviLs7GJ0HFV5Q0EtJR2piodIqSJw=;
        b=PzIkUbffaQaIzuwa5ld+yqHL6pc4cE1nQ6CAWeMR1D36K652QxfYxjeUSYhMKGkUQo
         Yugd0dMdKvvN6+pLpcGSp3sb7wMGTAF1qVQ57iutiexQ2MTjMrDJfCwZJEQEnr/4ftSu
         EGXfsm49MsXOnzyelRnNQ8fo958WJeq9qAi4CRQp7MJguqVSJq9KNtNmoFbzL9WI4noe
         FciZU4pMBr5KrNnlh9DQGVwmzghGzjg4KpH0t2+RX3atInfREVWQehnl4fP88CI6c1yD
         hQRpKeHLz9jb5ZsOrfVKUWlIbfv8lJqdGBpFfldWEZzcnFNlRcLIrF26J3HjA6/xxl6e
         cg5g==
X-Gm-Message-State: AAQBX9cDIZsnXpZ6tVng/7qa54j1lo9Tgi20WG2igCPAObovT0sc4RZG
        Bdh699Rf69+vIgymwkI6zDUK7A==
X-Google-Smtp-Source: AKy350bIn1HpqV+HLVwmlEhLY+jtsM/Pb73dRYtaanipb2FLYFUFk/ryHNgkBySXye0vjf1vyofOXw==
X-Received: by 2002:ac2:569a:0:b0:4ea:f4f4:dccd with SMTP id 26-20020ac2569a000000b004eaf4f4dccdmr10465lfr.68.1681328774663;
        Wed, 12 Apr 2023 12:46:14 -0700 (PDT)
Received: from [192.168.1.101] (abxj23.neoplus.adsl.tpnet.pl. [83.9.3.23])
        by smtp.gmail.com with ESMTPSA id x2-20020ac25dc2000000b004ec8de8ab3fsm1205865lfq.132.2023.04.12.12.46.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 12:46:14 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Wed, 12 Apr 2023 21:46:00 +0200
Subject: [PATCH 3/5] drm/panel: nt36523: Add DCS backlight support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230412-topic-lenovopanel-v1-3-00b25df46824@linaro.org>
References: <20230412-topic-lenovopanel-v1-0-00b25df46824@linaro.org>
In-Reply-To: <20230412-topic-lenovopanel-v1-0-00b25df46824@linaro.org>
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
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1681328765; l=3407;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=9qqhcFpj6mF/L7AASWe+iOrvvqzkHzB2/YH6M7xRsIE=;
 b=aaw8d1wQUM5xrKtH4IBrznSRGGUZaSyx3AjopF5+cWdlTv3kuJUW1nQTTUmCN592VUP7cB4PIeZx
 xt2oLM0aAVhODQeuFYxIxrlaZfJNRPx6hs7y2M9Swnwxv/7IYP1u
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This chip supports controlling the backlight via DCS commands, on at
least some panels. Add support for doing so.

Note this may only concern the NT36523*W* variant. Nobody knows, really,
there's no docs.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/gpu/drm/panel/panel-novatek-nt36523.c | 67 +++++++++++++++++++++++++--
 1 file changed, 64 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-novatek-nt36523.c b/drivers/gpu/drm/panel/panel-novatek-nt36523.c
index d30dbbfb67b1..3c81ec014eef 100644
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
@@ -679,6 +681,58 @@ static const struct drm_panel_funcs nt36523_panel_funcs = {
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
+	};
+
+	return devm_backlight_device_register(dev, dev_name(dev), dev, dsi,
+					      &nt36523_bl_ops, &props);
+}
+
 static int nt36523_probe(struct mipi_dsi_device *dsi)
 {
 	struct device *dev = &dsi->dev;
@@ -730,9 +784,16 @@ static int nt36523_probe(struct mipi_dsi_device *dsi)
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

