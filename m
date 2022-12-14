Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C025B64C969
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 13:59:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237741AbiLNM70 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 07:59:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238283AbiLNM7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 07:59:20 -0500
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C16029FC8;
        Wed, 14 Dec 2022 04:59:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1671022719; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2Ws6li5dO3CpsHCt9CPPSqXKDyNgVlYNQcMTzRYtTc0=;
        b=Yx3CR7S3q+zwFupKXU6o/dNqmCYY3D4AMyXhhL28ejrgEsIzv3C6TPiVBDzDgwJZghnKgG
        JZoBP+8kMeS2Cx2uZaW9f1duXF5NOiwlV8P6ilIqiMeJoffvvJUUwmCpi383rLQuXCWwto
        NRTlkEGFNsFbqpMJ/Q4Gwl8GMDeX+g8=
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
Subject: [PATCH 06/10] drm: bridge: it66121: Don't use DDC error IRQs
Date:   Wed, 14 Dec 2022 13:58:17 +0100
Message-Id: <20221214125821.12489-7-paul@crapouillou.net>
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

The DDC error IRQs will fire on the IT6610 every time the FIFO is empty,
which is not very helpful. To resolve this, we can simply disable them,
and handle DDC errors in it66121_wait_ddc_ready().

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/gpu/drm/bridge/ite-it66121.c | 49 ++++++----------------------
 1 file changed, 10 insertions(+), 39 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ite-it66121.c b/drivers/gpu/drm/bridge/ite-it66121.c
index bfb9c87a7019..06fa59ae5ffc 100644
--- a/drivers/gpu/drm/bridge/ite-it66121.c
+++ b/drivers/gpu/drm/bridge/ite-it66121.c
@@ -515,16 +515,6 @@ static int it66121_get_edid_block(void *context, u8 *buf,
 	offset = (block % 2) * len;
 	block = block / 2;
 
-	ret = regmap_read(ctx->regmap, IT66121_INT_STATUS1_REG, &val);
-	if (ret)
-		return ret;
-
-	if (val & IT66121_INT_STATUS1_DDC_BUSHANG) {
-		ret = it66121_abort_ddc_ops(ctx);
-		if (ret)
-			return ret;
-	}
-
 	ret = it66121_clear_ddc_fifo(ctx);
 	if (ret)
 		return ret;
@@ -545,16 +535,6 @@ static int it66121_get_edid_block(void *context, u8 *buf,
 		if (ret)
 			return ret;
 
-		ret = regmap_read(ctx->regmap, IT66121_INT_STATUS1_REG, &val);
-		if (ret)
-			return ret;
-
-		if (val & IT66121_INT_STATUS1_DDC_BUSHANG) {
-			ret = it66121_abort_ddc_ops(ctx);
-			if (ret)
-				return ret;
-		}
-
 		ret = it66121_preamble_ddc(ctx);
 		if (ret)
 			return ret;
@@ -585,8 +565,10 @@ static int it66121_get_edid_block(void *context, u8 *buf,
 		remain -= cnt;
 
 		ret = it66121_wait_ddc_ready(ctx);
-		if (ret)
+		if (ret) {
+			it66121_abort_ddc_ops(ctx);
 			return ret;
+		}
 
 		ret = regmap_noinc_read(ctx->regmap, IT66121_DDC_RD_FIFO_REG,
 					buf, cnt);
@@ -671,11 +653,7 @@ static int it66121_bridge_attach(struct drm_bridge *bridge,
 	/* Per programming manual, sleep here for bridge to settle */
 	msleep(50);
 
-	/* Start interrupts */
-	return regmap_write_bits(ctx->regmap, IT66121_INT_MASK1_REG,
-				 IT66121_INT_MASK1_DDC_NOACK |
-				 IT66121_INT_MASK1_DDC_FIFOERR |
-				 IT66121_INT_MASK1_DDC_BUSHANG, 0);
+	return 0;
 }
 
 static int it66121_set_mute(struct it66121_ctx *ctx, bool mute)
@@ -926,21 +904,14 @@ static irqreturn_t it66121_irq_threaded_handler(int irq, void *dev_id)
 	ret = regmap_read(ctx->regmap, IT66121_INT_STATUS1_REG, &val);
 	if (ret) {
 		dev_err(dev, "Cannot read STATUS1_REG %d\n", ret);
-	} else {
-		if (val & IT66121_INT_STATUS1_DDC_FIFOERR)
-			it66121_clear_ddc_fifo(ctx);
-		if (val & (IT66121_INT_STATUS1_DDC_BUSHANG |
-			   IT66121_INT_STATUS1_DDC_NOACK))
-			it66121_abort_ddc_ops(ctx);
-		if (val & IT66121_INT_STATUS1_HPD_STATUS) {
-			regmap_write_bits(ctx->regmap, IT66121_INT_CLR1_REG,
-					  IT66121_INT_CLR1_HPD, IT66121_INT_CLR1_HPD);
+	} else if (val & IT66121_INT_STATUS1_HPD_STATUS) {
+		regmap_write_bits(ctx->regmap, IT66121_INT_CLR1_REG,
+				  IT66121_INT_CLR1_HPD, IT66121_INT_CLR1_HPD);
 
-			status = it66121_is_hpd_detect(ctx) ? connector_status_connected
-							    : connector_status_disconnected;
+		status = it66121_is_hpd_detect(ctx) ? connector_status_connected
+			: connector_status_disconnected;
 
-			event = true;
-		}
+		event = true;
 	}
 
 	regmap_write_bits(ctx->regmap, IT66121_SYS_STATUS_REG,
-- 
2.35.1

