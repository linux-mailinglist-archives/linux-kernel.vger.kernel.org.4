Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F133264C9A3
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 14:02:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238486AbiLNNCx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 08:02:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238471AbiLNNCO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 08:02:14 -0500
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AA471022;
        Wed, 14 Dec 2022 05:01:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1671022896; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=54+4ueu5T1/xC0rmHnqvYZ6EX75p2F2DCkDDVJurBq8=;
        b=AYA5uFXVtLsqM5Mwh7qvJwRdGdJy/7tQE13iGDpRyM0xYx4nuqgL9deriatRy/FJkwV3us
        mbAG9Hnemi5O71+4CPskroO2XMdfvQ2z9IKj2nS0QE3BcZusLf5oy8tKoq5wpadmU33dCO
        VVJg9q9xPJZJ+4hdsQ9bPpFTufZh9OY=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Phong LE <ple@baylibre.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     list@opendingux.net, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 10/10] drm: bridge: it66121: Add support for the IT6610
Date:   Wed, 14 Dec 2022 14:01:31 +0100
Message-Id: <20221214130131.12962-1-paul@crapouillou.net>
In-Reply-To: <20221214125821.12489-1-paul@crapouillou.net>
References: <20221214125821.12489-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the IT6610 HDMI encoder.

The hardware is very similar, and therefore the driver did not require
too many changes. Some bits are only available on the IT66121, and
vice-versa. Also, the IT6610 requires specific polarities on the DE and
pixel lines.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/gpu/drm/bridge/ite-it66121.c | 108 +++++++++++++++++++++------
 1 file changed, 86 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ite-it66121.c b/drivers/gpu/drm/bridge/ite-it66121.c
index 43b027b85b8e..b34860871627 100644
--- a/drivers/gpu/drm/bridge/ite-it66121.c
+++ b/drivers/gpu/drm/bridge/ite-it66121.c
@@ -68,6 +68,7 @@
 #define IT66121_AFE_XP_ENO			BIT(4)
 #define IT66121_AFE_XP_RESETB			BIT(3)
 #define IT66121_AFE_XP_PWDI			BIT(2)
+#define IT6610_AFE_XP_BYPASS			BIT(0)
 
 #define IT66121_AFE_IP_REG			0x64
 #define IT66121_AFE_IP_GAINBIT			BIT(7)
@@ -284,7 +285,13 @@
 
 #define IT66121_AFE_CLK_HIGH			80000 /* Khz */
 
+enum chip_id {
+	ID_IT6610,
+	ID_IT66121,
+};
+
 struct it66121_chip_info {
+	enum chip_id id;
 	u16 vid, pid;
 };
 
@@ -391,16 +398,22 @@ static int it66121_configure_afe(struct it66121_ctx *ctx,
 
 		ret = regmap_write_bits(ctx->regmap, IT66121_AFE_IP_REG,
 					IT66121_AFE_IP_GAINBIT |
-					IT66121_AFE_IP_ER0 |
-					IT66121_AFE_IP_EC1,
+					IT66121_AFE_IP_ER0,
 					IT66121_AFE_IP_GAINBIT);
 		if (ret)
 			return ret;
 
-		ret = regmap_write_bits(ctx->regmap, IT66121_AFE_XP_EC1_REG,
-					IT66121_AFE_XP_EC1_LOWCLK, 0x80);
-		if (ret)
-			return ret;
+		if (ctx->info->id == ID_IT66121) {
+			ret = regmap_write_bits(ctx->regmap, IT66121_AFE_IP_REG,
+						IT66121_AFE_IP_EC1, 0);
+			if (ret)
+				return ret;
+
+			ret = regmap_write_bits(ctx->regmap, IT66121_AFE_XP_EC1_REG,
+						IT66121_AFE_XP_EC1_LOWCLK, 0x80);
+			if (ret)
+				return ret;
+		}
 	} else {
 		ret = regmap_write_bits(ctx->regmap, IT66121_AFE_XP_REG,
 					IT66121_AFE_XP_GAINBIT |
@@ -411,17 +424,24 @@ static int it66121_configure_afe(struct it66121_ctx *ctx,
 
 		ret = regmap_write_bits(ctx->regmap, IT66121_AFE_IP_REG,
 					IT66121_AFE_IP_GAINBIT |
-					IT66121_AFE_IP_ER0 |
-					IT66121_AFE_IP_EC1, IT66121_AFE_IP_ER0 |
-					IT66121_AFE_IP_EC1);
+					IT66121_AFE_IP_ER0,
+					IT66121_AFE_IP_ER0);
 		if (ret)
 			return ret;
 
-		ret = regmap_write_bits(ctx->regmap, IT66121_AFE_XP_EC1_REG,
-					IT66121_AFE_XP_EC1_LOWCLK,
-					IT66121_AFE_XP_EC1_LOWCLK);
-		if (ret)
-			return ret;
+		if (ctx->info->id == ID_IT66121) {
+			ret = regmap_write_bits(ctx->regmap, IT66121_AFE_IP_REG,
+						IT66121_AFE_IP_EC1,
+						IT66121_AFE_IP_EC1);
+			if (ret)
+				return ret;
+
+			ret = regmap_write_bits(ctx->regmap, IT66121_AFE_XP_EC1_REG,
+						IT66121_AFE_XP_EC1_LOWCLK,
+						IT66121_AFE_XP_EC1_LOWCLK);
+			if (ret)
+				return ret;
+		}
 	}
 
 	/* Clear reset flags */
@@ -430,6 +450,14 @@ static int it66121_configure_afe(struct it66121_ctx *ctx,
 	if (ret)
 		return ret;
 
+	if (ctx->info->id == ID_IT6610) {
+		ret = regmap_write_bits(ctx->regmap, IT66121_AFE_XP_REG,
+					IT6610_AFE_XP_BYPASS,
+					IT6610_AFE_XP_BYPASS);
+		if (ret)
+			return ret;
+	}
+
 	return it66121_fire_afe(ctx);
 }
 
@@ -491,7 +519,6 @@ static int it66121_get_edid_block(void *context, u8 *buf,
 				  unsigned int block, size_t len)
 {
 	struct it66121_ctx *ctx = context;
-	unsigned int val;
 	int remain = len;
 	int offset = 0;
 	int ret, cnt;
@@ -572,10 +599,12 @@ static int it66121_bridge_attach(struct drm_bridge *bridge,
 	if (ret)
 		return ret;
 
-	ret = regmap_write_bits(ctx->regmap, IT66121_CLK_BANK_REG,
-				IT66121_CLK_BANK_PWROFF_RCLK, 0);
-	if (ret)
-		return ret;
+	if (ctx->info->id == ID_IT66121) {
+		ret = regmap_write_bits(ctx->regmap, IT66121_CLK_BANK_REG,
+					IT66121_CLK_BANK_PWROFF_RCLK, 0);
+		if (ret)
+			return ret;
+	}
 
 	ret = regmap_write_bits(ctx->regmap, IT66121_INT_REG,
 				IT66121_INT_TX_CLK_OFF, 0);
@@ -713,6 +742,24 @@ static void it66121_bridge_disable(struct drm_bridge *bridge,
 	ctx->connector = NULL;
 }
 
+static int it66121_bridge_check(struct drm_bridge *bridge,
+				struct drm_bridge_state *bridge_state,
+				struct drm_crtc_state *crtc_state,
+				struct drm_connector_state *conn_state)
+{
+	struct it66121_ctx *ctx = container_of(bridge, struct it66121_ctx, bridge);
+
+	if (ctx->info->id == ID_IT6610) {
+		/* The IT6610 only supports these settings */
+		bridge_state->input_bus_cfg.flags |= DRM_BUS_FLAG_DE_HIGH |
+			DRM_BUS_FLAG_PIXDATA_DRIVE_NEGEDGE;
+		bridge_state->input_bus_cfg.flags &=
+			~DRM_BUS_FLAG_PIXDATA_DRIVE_POSEDGE;
+	}
+
+	return 0;
+}
+
 static
 void it66121_bridge_mode_set(struct drm_bridge *bridge,
 			     const struct drm_display_mode *mode,
@@ -758,9 +805,12 @@ void it66121_bridge_mode_set(struct drm_bridge *bridge,
 	if (regmap_write(ctx->regmap, IT66121_HDMI_MODE_REG, IT66121_HDMI_MODE_HDMI))
 		goto unlock;
 
-	if (regmap_write_bits(ctx->regmap, IT66121_CLK_BANK_REG,
-			      IT66121_CLK_BANK_PWROFF_TXCLK, IT66121_CLK_BANK_PWROFF_TXCLK))
+	if (ctx->info->id == ID_IT66121 &&
+	    regmap_write_bits(ctx->regmap, IT66121_CLK_BANK_REG,
+			      IT66121_CLK_BANK_PWROFF_TXCLK,
+			      IT66121_CLK_BANK_PWROFF_TXCLK)) {
 		goto unlock;
+	}
 
 	if (it66121_configure_input(ctx))
 		goto unlock;
@@ -768,7 +818,11 @@ void it66121_bridge_mode_set(struct drm_bridge *bridge,
 	if (it66121_configure_afe(ctx, adjusted_mode))
 		goto unlock;
 
-	regmap_write_bits(ctx->regmap, IT66121_CLK_BANK_REG, IT66121_CLK_BANK_PWROFF_TXCLK, 0);
+	if (ctx->info->id == ID_IT66121 &&
+	    regmap_write_bits(ctx->regmap, IT66121_CLK_BANK_REG,
+			      IT66121_CLK_BANK_PWROFF_TXCLK, 0)) {
+		goto unlock;
+	}
 
 unlock:
 	mutex_unlock(&ctx->lock);
@@ -859,6 +913,7 @@ static const struct drm_bridge_funcs it66121_bridge_funcs = {
 	.atomic_get_input_bus_fmts = it66121_bridge_atomic_get_input_bus_fmts,
 	.atomic_enable = it66121_bridge_enable,
 	.atomic_disable = it66121_bridge_disable,
+	.atomic_check = it66121_bridge_check,
 	.mode_set = it66121_bridge_mode_set,
 	.mode_valid = it66121_bridge_mode_valid,
 	.detect = it66121_bridge_detect,
@@ -1557,17 +1612,26 @@ static void it66121_remove(struct i2c_client *client)
 
 static const struct of_device_id it66121_dt_match[] = {
 	{ .compatible = "ite,it66121" },
+	{ .compatible = "ite,it6610" },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, it66121_dt_match);
 
 static const struct it66121_chip_info it66121_chip_info = {
+	.id = ID_IT66121,
 	.vid = 0x4954,
 	.pid = 0x0612,
 };
 
+static const struct it66121_chip_info it6610_chip_info = {
+	.id = ID_IT6610,
+	.vid = 0xca00,
+	.pid = 0x0611,
+};
+
 static const struct i2c_device_id it66121_id[] = {
 	{ "it66121", (kernel_ulong_t) &it66121_chip_info },
+	{ "it6610", (kernel_ulong_t) &it6610_chip_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, it66121_id);
-- 
2.35.1

