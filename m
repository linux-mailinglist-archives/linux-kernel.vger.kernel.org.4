Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 546DB6F5C17
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 18:33:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbjECQdo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 12:33:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjECQdm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 12:33:42 -0400
Received: from mail.fris.de (mail.fris.de [116.203.77.234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 673B94EF9
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 09:33:38 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6AFF5BFBA7;
        Wed,  3 May 2023 18:33:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=dkim;
        t=1683131616; h=from:subject:date:message-id:to:cc:mime-version:
         content-transfer-encoding:in-reply-to:references;
        bh=XpB9Qsa5ysbMqR5vQpemAUlG5S8C8bacv3P8I3Dbn2Q=;
        b=CgseNmfWzz5i1BKVwb2ndpUP21VlGSBMvwIHZ0pXLuLpGSUnuwT7dFHPpdiYHqYAE3ll43
        b6QriMM6PFrKmemHLibj4YeGxf1wy7jRak9nxGAwR7JovCzdwsSwr5YgsfmI5j09wF5wj6
        R3Epht6IA6FwRj2reSNkCPc3lTn2cAL2cb9BlQ+wLNbbNJBeYu2Fb/kZ+33Sqw3fHXlUmP
        pdAsqqxp96Yqu5LYpk1mNRYarLq9J595VY6RZyTzK9sgtf8UTXwPLo4VqDmb4RW3NbG9JO
        ICxvQIsmTsocEcvsnd3doTslg6p7SXolxWDoMemNzV3aZH43zbt49ktPNnQsaw==
From:   Frieder Schrempf <frieder@fris.de>
To:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        dri-devel@lists.freedesktop.org, Inki Dae <inki.dae@samsung.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        linux-kernel@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>
Cc:     Frieder Schrempf <frieder.schrempf@kontron.de>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Marek Vasut <marex@denx.de>
Subject: [PATCH v2 1/2] drm: bridge: samsung-dsim: Fix i.MX8M enable flow to meet spec
Date:   Wed,  3 May 2023 18:33:06 +0200
Message-Id: <20230503163313.2640898-2-frieder@fris.de>
In-Reply-To: <20230503163313.2640898-1-frieder@fris.de>
References: <20230503163313.2640898-1-frieder@fris.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frieder Schrempf <frieder.schrempf@kontron.de>

According to the documentation [1] the proper enable flow is:

1. Enable DSI link and keep data lanes in LP-11 (stop state)
2. Disable stop state to bring data lanes into HS mode

Currently we do this all at once within enable(), which doesn't
allow to meet the requirements of some downstream bridges.

To fix this we now enable the DSI in pre_enable() and force it
into stop state using the FORCE_STOP_STATE bit in the ESCMODE
register until enable() is called where we reset the bit.

We currently do this only for i.MX8M as Exynos uses a different
init flow where samsung_dsim_init() is called from
samsung_dsim_host_transfer().

[1] https://docs.kernel.org/gpu/drm-kms-helpers.html#mipi-dsi-bridge-operation

Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
Changes for v2:
* Drop RFC
---
 drivers/gpu/drm/bridge/samsung-dsim.c | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/samsung-dsim.c b/drivers/gpu/drm/bridge/samsung-dsim.c
index e0a402a85787..9775779721d9 100644
--- a/drivers/gpu/drm/bridge/samsung-dsim.c
+++ b/drivers/gpu/drm/bridge/samsung-dsim.c
@@ -859,6 +859,10 @@ static int samsung_dsim_init_link(struct samsung_dsim *dsi)
 	reg = samsung_dsim_read(dsi, DSIM_ESCMODE_REG);
 	reg &= ~DSIM_STOP_STATE_CNT_MASK;
 	reg |= DSIM_STOP_STATE_CNT(driver_data->reg_values[STOP_STATE_CNT]);
+
+	if (!samsung_dsim_hw_is_exynos(dsi->plat_data->hw_type))
+		reg |= DSIM_FORCE_STOP_STATE;
+
 	samsung_dsim_write(dsi, DSIM_ESCMODE_REG, reg);
 
 	reg = DSIM_BTA_TIMEOUT(0xff) | DSIM_LPDR_TIMEOUT(0xffff);
@@ -1340,6 +1344,9 @@ static void samsung_dsim_atomic_pre_enable(struct drm_bridge *bridge,
 		ret = samsung_dsim_init(dsi);
 		if (ret)
 			return;
+
+		samsung_dsim_set_display_mode(dsi);
+		samsung_dsim_set_display_enable(dsi, true);
 	}
 }
 
@@ -1347,9 +1354,16 @@ static void samsung_dsim_atomic_enable(struct drm_bridge *bridge,
 				       struct drm_bridge_state *old_bridge_state)
 {
 	struct samsung_dsim *dsi = bridge_to_dsi(bridge);
+	u32 reg;
 
-	samsung_dsim_set_display_mode(dsi);
-	samsung_dsim_set_display_enable(dsi, true);
+	if (samsung_dsim_hw_is_exynos(dsi->plat_data->hw_type)) {
+		samsung_dsim_set_display_mode(dsi);
+		samsung_dsim_set_display_enable(dsi, true);
+	} else {
+		reg = samsung_dsim_read(dsi, DSIM_ESCMODE_REG);
+		reg &= ~DSIM_FORCE_STOP_STATE;
+		samsung_dsim_write(dsi, DSIM_ESCMODE_REG, reg);
+	}
 
 	dsi->state |= DSIM_STATE_VIDOUT_AVAILABLE;
 }
@@ -1358,10 +1372,17 @@ static void samsung_dsim_atomic_disable(struct drm_bridge *bridge,
 					struct drm_bridge_state *old_bridge_state)
 {
 	struct samsung_dsim *dsi = bridge_to_dsi(bridge);
+	u32 reg;
 
 	if (!(dsi->state & DSIM_STATE_ENABLED))
 		return;
 
+	if (!samsung_dsim_hw_is_exynos(dsi->plat_data->hw_type)) {
+		reg = samsung_dsim_read(dsi, DSIM_ESCMODE_REG);
+		reg |= DSIM_FORCE_STOP_STATE;
+		samsung_dsim_write(dsi, DSIM_ESCMODE_REG, reg);
+	}
+
 	dsi->state &= ~DSIM_STATE_VIDOUT_AVAILABLE;
 }
 
-- 
2.40.0

