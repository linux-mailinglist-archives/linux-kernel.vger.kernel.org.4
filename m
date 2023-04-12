Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02A1A6DFEF3
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 21:46:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229878AbjDLTqb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 15:46:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjDLTqY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 15:46:24 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D962A6E8F
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 12:46:17 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id t20so16111906lfd.5
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 12:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681328776; x=1683920776;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iRmV3ZbptyRzjNEUKN3cUqrgquOQ4fNh4NEQv3SzN+Q=;
        b=GoQkyT6N0Y6moHhgYdP68L9f+lKcTaod6XOvgbDDI0g9iwqIOBW7GWFmkp8nK1DKe7
         0yW1GGSi9g74x8J7+QkDzghmWIQNzPNNnqJCAVmlZekK2PrLOd3bhq6vDcohjLffhwGC
         5MgK8c2K7qkkO9gNjfjWWgby7xpo+LYJcGSSsZc3HO+1Bf69tfGyyGSLctMNZA/NFDSS
         gDIQFf6oUj4KKricwOXub2SkE2qyN0AfsbI9FvBwh5+lHEZmTu39f5KvPZISoV6D5h3z
         W2t/gicK62AJEXrPwL3xeAKvyUUrtGdCjidq8rGQYUwdZYB8/Q72f05e9FCLsnPceUQS
         /TrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681328776; x=1683920776;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iRmV3ZbptyRzjNEUKN3cUqrgquOQ4fNh4NEQv3SzN+Q=;
        b=Z+HfBb3+LDYoySrtrnC1sJ8FH3JntGLUJuButkRZ6/8XM9fpv/7WCU1q3EmKAgwrmt
         HnnLcbVvKYnpKKZMej/dwFYUZGC8JLq5O1SYOHB3PHUXgGZgGoyzmB9q/5oJj38JlHbp
         w2jJkAme1tHrzvg/eIvQKJdY57iVFA0IqM1H4fUYZcyvpKgrG/ka0z4s6drPNonOQlI+
         VzkGImMn7edcjG6RJmoDsUmAThPXFCcPPIq6rgGn/VHTTmXZkWVJ5TavbWRo/t3qxuub
         xL19TKFa20ou6HP4FWBkCpCL2u8V0xE1kvw6d1ulchEeh4D088mtPpKP+FAJBHxc10Rs
         k3nw==
X-Gm-Message-State: AAQBX9e03l0X3383s6hwOFjfP8XE57BEl8GfaGn5U/+t7vUB6G1MnJWn
        3JZRDUBcxU88yLmjq59Mv1o7FQ==
X-Google-Smtp-Source: AKy350bXHnApee1Viu5dW0j8U/HQ+c7GXyIeVe07SzcYGPzf3DqEBWYbZ7SR3qPrtRgvxAgZjFqHIg==
X-Received: by 2002:ac2:48ba:0:b0:4b5:649a:9105 with SMTP id u26-20020ac248ba000000b004b5649a9105mr7037lfg.65.1681328776198;
        Wed, 12 Apr 2023 12:46:16 -0700 (PDT)
Received: from [192.168.1.101] (abxj23.neoplus.adsl.tpnet.pl. [83.9.3.23])
        by smtp.gmail.com with ESMTPSA id x2-20020ac25dc2000000b004ec8de8ab3fsm1205865lfq.132.2023.04.12.12.46.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 12:46:15 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Wed, 12 Apr 2023 21:46:01 +0200
Subject: [PATCH 4/5] drm/panel: nt36523: Get orientation from OF
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230412-topic-lenovopanel-v1-4-00b25df46824@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1681328765; l=1963;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=03x2QxCFOJ92tJUVDwn0/WKNOzd6yyjZ3Pdc9Flrqao=;
 b=bOzS7MQebAJyIKNBJY3A7fnCKU5niA9Qy5YrlRr2x0jODxMc3uyB2h2x7P0KnBW0UcoLPDYXQUe4
 hhp5Aq77CF6aPHBYweuvlRFzFViGdpbDDMSpEjgLTDAOS8Bxu4bA
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

Some bright vendors mount their display panels upside down. Add the
required pieces to allow for accounting for that.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/gpu/drm/panel/panel-novatek-nt36523.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-novatek-nt36523.c b/drivers/gpu/drm/panel/panel-novatek-nt36523.c
index 3c81ec014eef..db4b4af13ec1 100644
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
@@ -784,6 +793,12 @@ static int nt36523_probe(struct mipi_dsi_device *dsi)
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

