Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A4506E0B1F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 12:10:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbjDMKKX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 06:10:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230306AbjDMKKD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 06:10:03 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E8C5975D
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 03:09:54 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id z26so14363726ljq.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 03:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681380592; x=1683972592;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vfZDVg8acR2SKXDmnGE2uGGT4RT4YcuN/C99IcV99uQ=;
        b=yoIZyZsf2D48M0on5TQwKa4YD+zSyd27GfpCqwZLEslsnC5xR1+CAWvy4JxDSt3+Rr
         nMhmrRR3yV/xYyaaHllXKEP0RixpqM5Rz0d2xDlMV/CT3uXpFuQcfio6uQV6STeOb32n
         g2Ddfbmv+ssGXCaTM7plOi6U4hkLm/EeWbZAT8JqE3Cy7x4UTZB7MC0dmbup5+gqhpOK
         cC7j3GZC8CVl40Lj/uCdtEwKWA0bo8N9x4C/Ex7yczjy3RR4hxUtbXXMs+KkOjR+Nooy
         nJxog04TpTbI5oERIgGSjFZO4TiQuF7f7K3vjlmSRTublVe6J9gMumQm54NzF/TJkLKX
         X6mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681380592; x=1683972592;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vfZDVg8acR2SKXDmnGE2uGGT4RT4YcuN/C99IcV99uQ=;
        b=ikijrIavf/ttIfMCyMhGykMlFJn1RoMUI5Yc4/Yl7hIwlw1bAMWuvRR5PQEwLC78co
         aG9mtZAuW6HQozzLi0c4GyrcyckxWRaP/wwXmWx/RNNcg7zXdeoCzEPWmWuZyatYUkN3
         BG8SfrskWituXRew6QmnJX80huTFvZJTLJAPkALJ+e4iFqdXqk/ojeEyrTNS1xmBrFyU
         76xXklThH9KGRvjFYOAZAegS67MSbVEt+pi4ERMmTAEorEhfY1jkNjUXGZ5D08H1qOtA
         9E0uwJ70z3HrQVuRyfW2DGlmJ5uYd2CtFsqHh7bghKOI3judTZx5qp0kL5Peb01nCllN
         wLkQ==
X-Gm-Message-State: AAQBX9f2/AQHRsUsdGmh2BYqGUs8wJviEzKc5oX+zJJZdHQMRS5Fwi1E
        EqGEJp/VhNO5em6+v8bahrq+nA==
X-Google-Smtp-Source: AKy350Z4phXW2MjbdziUGEXYYMVHQ5u8gvGegNDKhCzPZj1+Z/99Tg9rAJsY4QTp9es8I+bm3+zzwA==
X-Received: by 2002:a2e:81cb:0:b0:2a7:7493:9966 with SMTP id s11-20020a2e81cb000000b002a774939966mr495603ljg.24.1681380592573;
        Thu, 13 Apr 2023 03:09:52 -0700 (PDT)
Received: from [192.168.1.101] (abyl123.neoplus.adsl.tpnet.pl. [83.9.31.123])
        by smtp.gmail.com with ESMTPSA id t20-20020a2e9d14000000b002a2e931fc48sm200482lji.140.2023.04.13.03.09.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Apr 2023 03:09:52 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Thu, 13 Apr 2023 12:09:38 +0200
Subject: [PATCH v2 4/5] drm/panel: nt36523: Get orientation from OF
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230412-topic-lenovopanel-v2-4-055c3649788e@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1681380585; l=2068;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=pdWLeHccDvo0CLmZJATdV9aHqMgeBmhMVIeYiCuYKCc=;
 b=J9jLVmM5Fmo3NkhY+AmFIW8debKry7SOp7UC2XycgFy9HPrtm6VIgt5CvlaTp8ztLNMed3i/i53X
 /XFPdc++Aqs2x94p5vy+Ed6jqzlhe0OrlR3YG8C9+uheXp6Oa1Ul
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

Some bright vendors mount their display panels upside down. Add the
required pieces to allow for accounting for that.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Jianhua Lu <lujianhua000@gmail.com>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/gpu/drm/panel/panel-novatek-nt36523.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-novatek-nt36523.c b/drivers/gpu/drm/panel/panel-novatek-nt36523.c
index b0466abae812..2c5712ac3037 100644
--- a/drivers/gpu/drm/panel/panel-novatek-nt36523.c
+++ b/drivers/gpu/drm/panel/panel-novatek-nt36523.c
@@ -31,6 +31,7 @@ struct panel_info {
 	struct drm_panel panel;
 	struct mipi_dsi_device *dsi[2];
 	const struct panel_desc *desc;
+	enum drm_panel_orientation orientation;
 
 	struct gpio_desc *reset_gpio;
 	struct backlight_device *backlight;
@@ -674,11 +675,19 @@ static int nt36523_get_modes(struct drm_panel *panel,
 	return pinfo->desc->num_modes;
 }
 
+static enum drm_panel_orientation nt36523_get_orientation(struct drm_panel *panel)
+{
+	struct panel_info *pinfo = to_panel_info(panel);
+
+	return pinfo->orientation;
+}
+
 static const struct drm_panel_funcs nt36523_panel_funcs = {
 	.disable = nt36523_disable,
 	.prepare = nt36523_prepare,
 	.unprepare = nt36523_unprepare,
 	.get_modes = nt36523_get_modes,
+	.get_orientation = nt36523_get_orientation,
 };
 
 static int nt36523_bl_update_status(struct backlight_device *bl)
@@ -785,6 +794,12 @@ static int nt36523_probe(struct mipi_dsi_device *dsi)
 	mipi_dsi_set_drvdata(dsi, pinfo);
 	drm_panel_init(&pinfo->panel, dev, &nt36523_panel_funcs, DRM_MODE_CONNECTOR_DSI);
 
+	ret = of_drm_get_panel_orientation(dev->of_node, &pinfo->orientation);
+	if (ret < 0) {
+		dev_err(dev, "%pOF: failed to get orientation %d\n", dev->of_node, ret);
+		return ret;
+	}
+
 	if (pinfo->desc->has_dcs_backlight) {
 		pinfo->panel.backlight = nt36523_create_backlight(dsi);
 		if (IS_ERR(pinfo->panel.backlight))

-- 
2.40.0

