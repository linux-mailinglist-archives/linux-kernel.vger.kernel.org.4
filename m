Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2185B6E4BA8
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 16:39:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230280AbjDQOjX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 10:39:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbjDQOjQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 10:39:16 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 040BA1720
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 07:39:14 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id z38so10571852ljq.12
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 07:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681742353; x=1684334353;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vfZDVg8acR2SKXDmnGE2uGGT4RT4YcuN/C99IcV99uQ=;
        b=wiuTpFK+nWG3951r1qdKkM3efc1mIO0xc7L3tK1Rs7ECSqy5Wt3rrpaotfOfz5CJDK
         D41+M3aHs+cUv1SIa4rt/ubzWSAjrOjvIcyk9BT0kOiNmapG9P48KAGxl9av9mwWZQwG
         /MOMRiqPhsf6EnnkABW1UdHlaOceRhuiti+y7IvtJjruZKUzGA92drD+gUiEAEWUYI41
         DV844hjjFtBamUAMbd+JusbFvq4IWI0BfLntwCbxKsuAR0u7LgcxlS6lWUoM/tOZlzgz
         Jq5lyiu3iUCjpVHOgm+iRDM47+12IxDtAEyARnW06F4PRHz9vZMy5FQQ972O/LbLLm2h
         WUFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681742353; x=1684334353;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vfZDVg8acR2SKXDmnGE2uGGT4RT4YcuN/C99IcV99uQ=;
        b=Z6oXLJCqD8f/dKNfZbPFrlj14X6Vu0m0GF5BXpgIb96Pq7AJ1IMGm9BdRvIImQYv3V
         FFCv0r1AD3nYsL5+gKEY++1nbO+aI1tgG91Qu9Ld5m0Pj1JDLo5Tw97OEXlrsq9S5uu6
         S9UJwTD/fmaLNQ71bUqCQw2PHbpFOfW+NvxN2vjw9KlSND/iOmjLE6iIa+vO/GuZdd1X
         y/IFpkWEzr8Jd0VDBNGpY57j42tQbVo5HEeq/LcM+fXhcX8gvkkwOlwv13FmErwmmfuA
         Ji63zD9zdlEuGXprf5t1SWBZUYzVC8IkRo5btylss59dqCbuYMaedQzjL7ylvFtxzfg/
         bwUA==
X-Gm-Message-State: AAQBX9fSzo6NUnNz1VJ2TVtwyusxKond0mZ0VQx1Nvjin+Cpa/QHr5uf
        8BAV0rW6zKTAVEu8zyiUTHAH4Q==
X-Google-Smtp-Source: AKy350ZwJrsG8n19CsEttEydK+XkaaRhRbNiFoxesa/6Fz8OsxOddCHQZw63KQJPJlg9+X0bQL+7Jg==
X-Received: by 2002:a2e:b16e:0:b0:2a7:a59c:8ad0 with SMTP id a14-20020a2eb16e000000b002a7a59c8ad0mr4192846ljm.2.1681742353572;
        Mon, 17 Apr 2023 07:39:13 -0700 (PDT)
Received: from [192.168.1.101] (abyk99.neoplus.adsl.tpnet.pl. [83.9.30.99])
        by smtp.gmail.com with ESMTPSA id 2-20020a2eb282000000b002a76b9e4058sm2235785ljx.43.2023.04.17.07.39.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 07:39:13 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Mon, 17 Apr 2023 16:39:05 +0200
Subject: [PATCH v3 3/4] drm/panel: nt36523: Get orientation from OF
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230412-topic-lenovopanel-v3-3-bcf9ba4de46f@linaro.org>
References: <20230412-topic-lenovopanel-v3-0-bcf9ba4de46f@linaro.org>
In-Reply-To: <20230412-topic-lenovopanel-v3-0-bcf9ba4de46f@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1681742347; l=2068;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=pdWLeHccDvo0CLmZJATdV9aHqMgeBmhMVIeYiCuYKCc=;
 b=LUrTUaEn8X0twowhoCQRfIeIIMED6UchNvHwT4QrNhD6Vj+l42sWFzkIdE1jAYJGhdjTiiovJuiA
 fxUs8DR1CFaJIdN88iO7ynlRGQvMKmRLweI9zyKkaTC4X63lPAm7
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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

