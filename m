Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 404896EBB52
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Apr 2023 22:51:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230062AbjDVUux (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Apr 2023 16:50:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229867AbjDVUud (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Apr 2023 16:50:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85B8126B2;
        Sat, 22 Apr 2023 13:50:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1E13061537;
        Sat, 22 Apr 2023 20:50:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55A6BC433EF;
        Sat, 22 Apr 2023 20:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682196630;
        bh=gS1hH+6UfTG4eAU2Lxy6lXpSl2LKEs6U01Sva2NM8K0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BFSTdmqxktXIhqaVQuxoxZIM99nWNCOVwcoGznR4cprKjkzJO5pg2Q/268AbMmxBu
         irvc/NwAS/hJVW4jFaRR+t/GheZ26xD7a1cKXRGMOqA9SOOW2o3JGCpCP+2HHOTBdN
         zfNT9leHiGN7ynDEGUpS22IvgOJZREPxVKvTESL5wZGibVElapgIfTa61nNvsRaBGD
         kw4OZ4aOZS50isJpiHTuhS7E/pnjYJRX22z0F6IltRv9Kq+Dwbzz/exHrw1dEaTNiX
         FMAA39WWEh0uSIV8vEirYQlIpo43mWxUocvEXg7DiZnEvjPGiwoI593lSqkCu03T5k
         v4NKC3zOgkqTg==
Received: by mercury (Postfix, from userid 1000)
        id 173BA1066CC8; Sat, 22 Apr 2023 22:50:25 +0200 (CEST)
From:   Sebastian Reichel <sre@kernel.org>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Gerald Loacker <gerald.loacker@wolfvision.net>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
Subject: [PATCH v2 07/13] drm/panel: sitronix-st7789v: improve error handling
Date:   Sat, 22 Apr 2023 22:50:06 +0200
Message-Id: <20230422205012.2464933-8-sre@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230422205012.2464933-1-sre@kernel.org>
References: <20230422205012.2464933-1-sre@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Improve error handling in the probe routine, so that probe
defer errors are captured in /sys/kernel/debug/devices_deferred

Signed-off-by: Sebastian Reichel <sre@kernel.org>
---
 .../gpu/drm/panel/panel-sitronix-st7789v.c    | 23 ++++++++++---------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-sitronix-st7789v.c b/drivers/gpu/drm/panel/panel-sitronix-st7789v.c
index 6290bd49d055..a6d6155ef45c 100644
--- a/drivers/gpu/drm/panel/panel-sitronix-st7789v.c
+++ b/drivers/gpu/drm/panel/panel-sitronix-st7789v.c
@@ -348,32 +348,33 @@ static const struct drm_panel_funcs st7789v_drm_funcs = {
 
 static int st7789v_probe(struct spi_device *spi)
 {
+	struct device *dev = &spi->dev;
 	struct st7789v *ctx;
 	int ret;
 
-	ctx = devm_kzalloc(&spi->dev, sizeof(*ctx), GFP_KERNEL);
+	ctx = devm_kzalloc(dev, sizeof(*ctx), GFP_KERNEL);
 	if (!ctx)
 		return -ENOMEM;
 
 	spi_set_drvdata(spi, ctx);
 	ctx->spi = spi;
 
-	drm_panel_init(&ctx->panel, &spi->dev, &st7789v_drm_funcs,
+	drm_panel_init(&ctx->panel, dev, &st7789v_drm_funcs,
 		       DRM_MODE_CONNECTOR_DPI);
 
-	ctx->power = devm_regulator_get(&spi->dev, "power");
-	if (IS_ERR(ctx->power))
-		return PTR_ERR(ctx->power);
+	ctx->power = devm_regulator_get(dev, "power");
+	ret = PTR_ERR_OR_ZERO(ctx->power);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to get regulator\n");
 
-	ctx->reset = devm_gpiod_get_optional(&spi->dev, "reset", GPIOD_OUT_LOW);
-	if (IS_ERR(ctx->reset)) {
-		dev_err(&spi->dev, "Couldn't get our reset line\n");
-		return PTR_ERR(ctx->reset);
-	}
+	ctx->reset = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_LOW);
+	ret = PTR_ERR_OR_ZERO(ctx->reset);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to get reset line\n");
 
 	ret = drm_panel_of_backlight(&ctx->panel);
 	if (ret)
-		return ret;
+		return dev_err_probe(dev, ret, "Failed to get backlight\n");
 
 	drm_panel_add(&ctx->panel);
 
-- 
2.39.2

