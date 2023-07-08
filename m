Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3BEC74BCDC
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jul 2023 10:41:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbjGHIk7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jul 2023 04:40:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbjGHIk5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jul 2023 04:40:57 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEEB61FE0;
        Sat,  8 Jul 2023 01:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1688805640;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6+AqvnlESMt4eGXysB+WU7X0HzVbXxlbD86pN2OtT+U=;
        b=JsxMJzckQmaOdeCcP31JQuVyvWP+HhcsEyUShqxfnLig35BdIwL/wTBtZWhB5LtEy097js
        cuLkcV+mVyOazDjsDHTHtJv527lJtX/3ObpoQWYoPtp1nPQA4c1bUb0ilS2cF1Ii5kXdxK
        japyWh109wRYEGhkst2nKHWeYYSnnc8=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v2 2/3] drm/panel: ld9040: Register a backlight device
Date:   Sat,  8 Jul 2023 10:40:26 +0200
Message-Id: <20230708084027.18352-3-paul@crapouillou.net>
In-Reply-To: <20230708084027.18352-1-paul@crapouillou.net>
References: <20230708084027.18352-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam: Yes
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Register a backlight device to be able to switch between all the gamma
levels.

v2: Remove .get_brightness() callback, use bl_get_data() and
    backlight_get_brightness()

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/gpu/drm/panel/panel-samsung-ld9040.c | 32 +++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panel/panel-samsung-ld9040.c b/drivers/gpu/drm/panel/panel-samsung-ld9040.c
index f39f999c21af..ad5ed635f592 100644
--- a/drivers/gpu/drm/panel/panel-samsung-ld9040.c
+++ b/drivers/gpu/drm/panel/panel-samsung-ld9040.c
@@ -8,6 +8,7 @@
  * Andrzej Hajda <a.hajda@samsung.com>
 */
 
+#include <linux/backlight.h>
 #include <linux/delay.h>
 #include <linux/gpio/consumer.h>
 #include <linux/module.h>
@@ -310,8 +311,30 @@ static int ld9040_parse_dt(struct ld9040 *ctx)
 	return 0;
 }
 
+static int ld9040_bl_update_status(struct backlight_device *dev)
+{
+	struct ld9040 *ctx = bl_get_data(dev);
+
+	ctx->brightness = backlight_get_brightness(dev);
+	ld9040_brightness_set(ctx);
+
+	return 0;
+}
+
+static const struct backlight_ops ld9040_bl_ops = {
+	.update_status  = ld9040_bl_update_status,
+};
+
+static const struct backlight_properties ld9040_bl_props = {
+	.type = BACKLIGHT_RAW,
+	.scale = BACKLIGHT_SCALE_NON_LINEAR,
+	.max_brightness = ARRAY_SIZE(ld9040_gammas) - 1,
+	.brightness = ARRAY_SIZE(ld9040_gammas) - 1,
+};
+
 static int ld9040_probe(struct spi_device *spi)
 {
+	struct backlight_device *bldev;
 	struct device *dev = &spi->dev;
 	struct ld9040 *ctx;
 	int ret;
@@ -323,7 +346,7 @@ static int ld9040_probe(struct spi_device *spi)
 	spi_set_drvdata(spi, ctx);
 
 	ctx->dev = dev;
-	ctx->brightness = ARRAY_SIZE(ld9040_gammas) - 1;
+	ctx->brightness = ld9040_bl_props.brightness;
 
 	ret = ld9040_parse_dt(ctx);
 	if (ret < 0)
@@ -353,6 +376,13 @@ static int ld9040_probe(struct spi_device *spi)
 	drm_panel_init(&ctx->panel, dev, &ld9040_drm_funcs,
 		       DRM_MODE_CONNECTOR_DPI);
 
+
+	bldev = devm_backlight_device_register(dev, dev_name(dev), dev,
+					       ctx, &ld9040_bl_ops,
+					       &ld9040_bl_props);
+	if (IS_ERR(bldev))
+		return PTR_ERR(bldev);
+
 	drm_panel_add(&ctx->panel);
 
 	return 0;
-- 
2.40.1

