Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CFA36E5F1A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 12:43:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230336AbjDRKnI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 06:43:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231336AbjDRKnG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 06:43:06 -0400
Received: from mail.fris.de (mail.fris.de [116.203.77.234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 439F17AAE
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 03:43:02 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 17E35BFAFF;
        Tue, 18 Apr 2023 12:42:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=dkim;
        t=1681814579; h=from:subject:date:message-id:to:cc:mime-version:
         content-transfer-encoding; bh=BXhi8YyumEodLsDXRdhu1OgBuW6ZXGeQiJDpibPmXDU=;
        b=dMUU+FUnWU/hM5OFAJgGDXTUlJNbbYiardwzNkcNqgAYX3JDOd10wFYRoBjTpVxkeGaOW2
        3QIhGM+0m3mCl9RYkBrQuWB8jAoXhVFN+Q1S9PjpjFT49r7pm/Q4ZDwF5JorZYNY52bJzq
        1BRUkffzw1pIJkel+rIlzfl9bP3nZn20TBsl0JJSMoFoeq4wR0/v8ea3BcIHcRXdX03FbK
        RzJWyXbr0vLnAjkgRGeP5KMs4/5XZwLSJmq5JMAsNyUm0s3RbF405SL8q3FZ+l3OsSBZzg
        IEFT1z+KESmwT/rjyiFa8+fdZx+kS8TziWPlpd0tLgdhSVBoeWdeBxxQFFOPlw==
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
Subject: [RFC PATCH 3/3] drm: bridge: samsung-dsim: Remove init quirk for Exynos
Date:   Tue, 18 Apr 2023 12:42:53 +0200
Message-Id: <20230418104256.878017-1-frieder@fris.de>
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

Assuming that with the init flow fixed to meet the documentation at
[1] and the pre_enable_prev_first flag set in downstream bridge/panel
drivers which require it, we can use the default flow for Exynos as
already done for i.MX8M.

[1] https://docs.kernel.org/gpu/drm-kms-helpers.html#mipi-dsi-bridge-operation

Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
I have no idea if my assumptions are correct and if this works at all.
There's a very good chance it doesn't...
---
 drivers/gpu/drm/bridge/samsung-dsim.c | 39 ++++++++-------------------
 1 file changed, 11 insertions(+), 28 deletions(-)

diff --git a/drivers/gpu/drm/bridge/samsung-dsim.c b/drivers/gpu/drm/bridge/samsung-dsim.c
index 9775779721d9..8c68b767ae50 100644
--- a/drivers/gpu/drm/bridge/samsung-dsim.c
+++ b/drivers/gpu/drm/bridge/samsung-dsim.c
@@ -1336,18 +1336,12 @@ static void samsung_dsim_atomic_pre_enable(struct drm_bridge *bridge,
 
 	dsi->state |= DSIM_STATE_ENABLED;
 
-	/*
-	 * For Exynos-DSIM the downstream bridge, or panel are expecting
-	 * the host initialization during DSI transfer.
-	 */
-	if (!samsung_dsim_hw_is_exynos(dsi->plat_data->hw_type)) {
-		ret = samsung_dsim_init(dsi);
-		if (ret)
-			return;
+	ret = samsung_dsim_init(dsi);
+	if (ret)
+		return;
 
-		samsung_dsim_set_display_mode(dsi);
-		samsung_dsim_set_display_enable(dsi, true);
-	}
+	samsung_dsim_set_display_mode(dsi);
+	samsung_dsim_set_display_enable(dsi, true);
 }
 
 static void samsung_dsim_atomic_enable(struct drm_bridge *bridge,
@@ -1356,14 +1350,9 @@ static void samsung_dsim_atomic_enable(struct drm_bridge *bridge,
 	struct samsung_dsim *dsi = bridge_to_dsi(bridge);
 	u32 reg;
 
-	if (samsung_dsim_hw_is_exynos(dsi->plat_data->hw_type)) {
-		samsung_dsim_set_display_mode(dsi);
-		samsung_dsim_set_display_enable(dsi, true);
-	} else {
-		reg = samsung_dsim_read(dsi, DSIM_ESCMODE_REG);
-		reg &= ~DSIM_FORCE_STOP_STATE;
-		samsung_dsim_write(dsi, DSIM_ESCMODE_REG, reg);
-	}
+	reg = samsung_dsim_read(dsi, DSIM_ESCMODE_REG);
+	reg &= ~DSIM_FORCE_STOP_STATE;
+	samsung_dsim_write(dsi, DSIM_ESCMODE_REG, reg);
 
 	dsi->state |= DSIM_STATE_VIDOUT_AVAILABLE;
 }
@@ -1377,11 +1366,9 @@ static void samsung_dsim_atomic_disable(struct drm_bridge *bridge,
 	if (!(dsi->state & DSIM_STATE_ENABLED))
 		return;
 
-	if (!samsung_dsim_hw_is_exynos(dsi->plat_data->hw_type)) {
-		reg = samsung_dsim_read(dsi, DSIM_ESCMODE_REG);
-		reg |= DSIM_FORCE_STOP_STATE;
-		samsung_dsim_write(dsi, DSIM_ESCMODE_REG, reg);
-	}
+	reg = samsung_dsim_read(dsi, DSIM_ESCMODE_REG);
+	reg |= DSIM_FORCE_STOP_STATE;
+	samsung_dsim_write(dsi, DSIM_ESCMODE_REG, reg);
 
 	dsi->state &= ~DSIM_STATE_VIDOUT_AVAILABLE;
 }
@@ -1680,10 +1667,6 @@ static ssize_t samsung_dsim_host_transfer(struct mipi_dsi_host *host,
 	if (!(dsi->state & DSIM_STATE_ENABLED))
 		return -EINVAL;
 
-	ret = samsung_dsim_init(dsi);
-	if (ret)
-		return ret;
-
 	ret = mipi_dsi_create_packet(&xfer.packet, msg);
 	if (ret < 0)
 		return ret;
-- 
2.40.0

