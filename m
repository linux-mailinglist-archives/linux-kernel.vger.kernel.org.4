Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 487F564C964
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 13:59:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238387AbiLNM7M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 07:59:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238283AbiLNM7G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 07:59:06 -0500
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B794AD2C8;
        Wed, 14 Dec 2022 04:59:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1671022717; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OWoSCk2ituhKYm0/ufJukih+FFvTeAkXh/icLalhjMU=;
        b=WQHYKNy6OB/jkbFThVhdeMU3KkWHydgSHaXQn9FzLTm135synLNrG8eIYt3yiHQs+o/WVU
        weO98VRMojZx8O68xVYEdEwFwyDlZZr3vjG7siwPXmRq4/Ln2nonqiebfWJINUChxklDOk
        x6fvTEIu05htYE0Zmf50eYtPowY3pbg=
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
Subject: [PATCH 04/10] drm: bridge: it66121: Write AVI infoframe with regmap_bulk_write()
Date:   Wed, 14 Dec 2022 13:58:15 +0100
Message-Id: <20221214125821.12489-5-paul@crapouillou.net>
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

Since all AVI infoframe registers are contiguous in the address space,
the AVI infoframe can be written in one go with regmap_bulk_write().

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/gpu/drm/bridge/ite-it66121.c | 27 +++++++--------------------
 1 file changed, 7 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ite-it66121.c b/drivers/gpu/drm/bridge/ite-it66121.c
index 12222840df30..0a4fdfd7af44 100644
--- a/drivers/gpu/drm/bridge/ite-it66121.c
+++ b/drivers/gpu/drm/bridge/ite-it66121.c
@@ -773,24 +773,9 @@ void it66121_bridge_mode_set(struct drm_bridge *bridge,
 			     const struct drm_display_mode *mode,
 			     const struct drm_display_mode *adjusted_mode)
 {
-	int ret, i;
 	u8 buf[HDMI_INFOFRAME_SIZE(AVI)];
 	struct it66121_ctx *ctx = container_of(bridge, struct it66121_ctx, bridge);
-	const u16 aviinfo_reg[HDMI_AVI_INFOFRAME_SIZE] = {
-		IT66121_AVIINFO_DB1_REG,
-		IT66121_AVIINFO_DB2_REG,
-		IT66121_AVIINFO_DB3_REG,
-		IT66121_AVIINFO_DB4_REG,
-		IT66121_AVIINFO_DB5_REG,
-		IT66121_AVIINFO_DB6_REG,
-		IT66121_AVIINFO_DB7_REG,
-		IT66121_AVIINFO_DB8_REG,
-		IT66121_AVIINFO_DB9_REG,
-		IT66121_AVIINFO_DB10_REG,
-		IT66121_AVIINFO_DB11_REG,
-		IT66121_AVIINFO_DB12_REG,
-		IT66121_AVIINFO_DB13_REG
-	};
+	int ret;
 
 	mutex_lock(&ctx->lock);
 
@@ -810,10 +795,12 @@ void it66121_bridge_mode_set(struct drm_bridge *bridge,
 	}
 
 	/* Write new AVI infoframe packet */
-	for (i = 0; i < HDMI_AVI_INFOFRAME_SIZE; i++) {
-		if (regmap_write(ctx->regmap, aviinfo_reg[i], buf[i + HDMI_INFOFRAME_HEADER_SIZE]))
-			goto unlock;
-	}
+	ret = regmap_bulk_write(ctx->regmap, IT66121_AVIINFO_DB1_REG,
+				&buf[HDMI_INFOFRAME_HEADER_SIZE],
+				HDMI_AVI_INFOFRAME_SIZE);
+	if (ret)
+		goto unlock;
+
 	if (regmap_write(ctx->regmap, IT66121_AVIINFO_CSUM_REG, buf[3]))
 		goto unlock;
 
-- 
2.35.1

