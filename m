Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 982BC734465
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Jun 2023 00:49:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233587AbjFQWti (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 18:49:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233235AbjFQWte (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 18:49:34 -0400
Received: from vps.xff.cz (vps.xff.cz [195.181.215.36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B52E1982
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jun 2023 15:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xff.cz; s=mail;
        t=1687042166; bh=eyC5JI8V8DNnn2DGE7rCYRCn5Al5AnVBD9PbxGzqK2g=;
        h=From:To:Cc:Subject:Date:From;
        b=oKUwMM8cgEjhyZLWJWVJisv9Ze3H3GBrDTrEP/0OLHL9U0g8IcZNRG1MRdNl3aAKH
         z/EGNYpVQFTVKGNW59SfocIxaEoKq8EIWbpGcFFN7XEi7p/SeQXOVgj4tqUPave0Tb
         wUP3AWpKQZrMz/jz0MqT/ScvrpWQzoJXcI2sxArA=
From:   =?UTF-8?q?Ond=C5=99ej=20Jirman?= <megi@xff.cz>
To:     linux-rockchip@lists.infradead.org
Cc:     Ondrej Jirman <megi@xff.cz>, Sam Ravnborg <sam@ravnborg.org>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Archit Taneja <architt@codeaurora.org>,
        Philippe CORNU <philippe.cornu@st.com>,
        dri-devel@lists.freedesktop.org (open list:DRM DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2] drm: bridge: dw-mipi-dsi: Fix enable/disable of DSI controller
Date:   Sun, 18 Jun 2023 00:48:25 +0200
Message-ID: <20230617224915.1923630-1-megi@xff.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ondrej Jirman <megi@xff.cz>

Before this patch, booting to Linux VT and doing a simple:

  echo 2 > /sys/class/graphics/fb0/blank
  echo 0 > /sys/class/graphics/fb0/blank

would result in failures to re-enable the panel. Mode set callback is
called only once during boot in this scenario, while calls to
enable/disable callbacks are balanced afterwards. The driver doesn't
work unless userspace calls modeset before enabling the CRTC/connector.

This patch moves enabling of the DSI host from mode_set into pre_enable
callback, and removes some old hacks where this bridge driver is
directly calling into other bridge driver's callbacks.

pre_enable_prev_first flag is set on the panel's bridge so that panel
drivers will get their prepare function called between DSI host's
pre_enable and enable callbacks, so that they get a chance to
perform panel setup while DSI host is already enabled in command
mode. Otherwise panel's prepare would be called before DSI host
is enabled, and any DSI communication used in prepare callback
would fail.

With all these changes, the enable/disable sequence is now well
balanced, and host's and panel's callbacks are called in proper order
documented in the drm_panel API documentation without needing the old
hacks. (Mainly that panel->prepare is called when DSI host is ready to
allow the panel driver to send DSI commands and vice versa during
disable.)

Tested on Pinephone Pro. Trace of the callbacks follows.

Before:

[    1.253882] dw-mipi-dsi-rockchip ff960000.dsi: mode_set
[    1.290732] panel-himax-hx8394 ff960000.dsi.0: prepare
[    1.475576] dw-mipi-dsi-rockchip ff960000.dsi: enable
[    1.475593] panel-himax-hx8394 ff960000.dsi.0: enable

echo 2 > /sys/class/graphics/fb0/blank

[   13.722799] panel-himax-hx8394 ff960000.dsi.0: disable
[   13.774502] dw-mipi-dsi-rockchip ff960000.dsi: post_disable
[   13.774526] panel-himax-hx8394 ff960000.dsi.0: unprepare

echo 0 > /sys/class/graphics/fb0/blank

[   17.735796] panel-himax-hx8394 ff960000.dsi.0: prepare
[   17.923522] dw-mipi-dsi-rockchip ff960000.dsi: enable
[   17.923540] panel-himax-hx8394 ff960000.dsi.0: enable
[   17.944330] dw-mipi-dsi-rockchip ff960000.dsi: failed to write command FIFO
[   17.944335] panel-himax-hx8394 ff960000.dsi.0: sending command 0xb9 failed: -110
[   17.944340] panel-himax-hx8394 ff960000.dsi.0: Panel init sequence failed: -110

echo 2 > /sys/class/graphics/fb0/blank

[  431.148583] panel-himax-hx8394 ff960000.dsi.0: disable
[  431.169259] dw-mipi-dsi-rockchip ff960000.dsi: failed to write command FIFO
[  431.169268] panel-himax-hx8394 ff960000.dsi.0: Failed to enter sleep mode: -110
[  431.169282] dw-mipi-dsi-rockchip ff960000.dsi: post_disable
[  431.169316] panel-himax-hx8394 ff960000.dsi.0: unprepare
[  431.169357] pclk_mipi_dsi0 already disabled

echo 0 > /sys/class/graphics/fb0/blank

[  432.796851] panel-himax-hx8394 ff960000.dsi.0: prepare
[  432.981537] dw-mipi-dsi-rockchip ff960000.dsi: enable
[  432.981568] panel-himax-hx8394 ff960000.dsi.0: enable
[  433.002290] dw-mipi-dsi-rockchip ff960000.dsi: failed to write command FIFO
[  433.002299] panel-himax-hx8394 ff960000.dsi.0: sending command 0xb9 failed: -110
[  433.002312] panel-himax-hx8394 ff960000.dsi.0: Panel init sequence failed: -110

-----------------------------------------------------------------------

After:

[    1.248372] dw-mipi-dsi-rockchip ff960000.dsi: mode_set
[    1.248704] dw-mipi-dsi-rockchip ff960000.dsi: pre_enable
[    1.285377] panel-himax-hx8394 ff960000.dsi.0: prepare
[    1.468392] dw-mipi-dsi-rockchip ff960000.dsi: enable
[    1.468421] panel-himax-hx8394 ff960000.dsi.0: enable

echo 2 > /sys/class/graphics/fb0/blank

[   16.210357] panel-himax-hx8394 ff960000.dsi.0: disable
[   16.261315] dw-mipi-dsi-rockchip ff960000.dsi: post_disable
[   16.261339] panel-himax-hx8394 ff960000.dsi.0: unprepare

echo 0 > /sys/class/graphics/fb0/blank

[   19.161453] dw-mipi-dsi-rockchip ff960000.dsi: pre_enable
[   19.197869] panel-himax-hx8394 ff960000.dsi.0: prepare
[   19.382141] dw-mipi-dsi-rockchip ff960000.dsi: enable
[   19.382158] panel-himax-hx8394 ff960000.dsi.0: enable

Fixes: 46fc51546d44 ("drm/bridge/synopsys: Add MIPI DSI host controller bridge")
       (But depends on functionality intorduced in Linux 6.3, so this patch will
        not build on older kernels when applied to older stable branches.)
Signed-off-by: Ondrej Jirman <megi@xff.cz>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
---
Changed in v2:
- use proper function for copying drm mode
- add fixes + note about dependencies

 drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c | 28 +++++++++++--------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
index b2efecf7d160..4291798bd70f 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
@@ -265,6 +265,7 @@ struct dw_mipi_dsi {
 	struct dw_mipi_dsi *master; /* dual-dsi master ptr */
 	struct dw_mipi_dsi *slave; /* dual-dsi slave ptr */
 
+	struct drm_display_mode mode;
 	const struct dw_mipi_dsi_plat_data *plat_data;
 };
 
@@ -332,6 +333,7 @@ static int dw_mipi_dsi_host_attach(struct mipi_dsi_host *host,
 	if (IS_ERR(bridge))
 		return PTR_ERR(bridge);
 
+	bridge->pre_enable_prev_first = true;
 	dsi->panel_bridge = bridge;
 
 	drm_bridge_add(&dsi->bridge);
@@ -859,15 +861,6 @@ static void dw_mipi_dsi_bridge_post_atomic_disable(struct drm_bridge *bridge,
 	 */
 	dw_mipi_dsi_set_mode(dsi, 0);
 
-	/*
-	 * TODO Only way found to call panel-bridge post_disable &
-	 * panel unprepare before the dsi "final" disable...
-	 * This needs to be fixed in the drm_bridge framework and the API
-	 * needs to be updated to manage our own call chains...
-	 */
-	if (dsi->panel_bridge->funcs->post_disable)
-		dsi->panel_bridge->funcs->post_disable(dsi->panel_bridge);
-
 	if (phy_ops->power_off)
 		phy_ops->power_off(dsi->plat_data->priv_data);
 
@@ -942,15 +935,25 @@ static void dw_mipi_dsi_mode_set(struct dw_mipi_dsi *dsi,
 		phy_ops->power_on(dsi->plat_data->priv_data);
 }
 
+static void dw_mipi_dsi_bridge_atomic_pre_enable(struct drm_bridge *bridge,
+						 struct drm_bridge_state *old_bridge_state)
+{
+	struct dw_mipi_dsi *dsi = bridge_to_dsi(bridge);
+
+	/* Power up the dsi ctl into a command mode */
+	dw_mipi_dsi_mode_set(dsi, &dsi->mode);
+	if (dsi->slave)
+		dw_mipi_dsi_mode_set(dsi->slave, &dsi->mode);
+}
+
 static void dw_mipi_dsi_bridge_mode_set(struct drm_bridge *bridge,
 					const struct drm_display_mode *mode,
 					const struct drm_display_mode *adjusted_mode)
 {
 	struct dw_mipi_dsi *dsi = bridge_to_dsi(bridge);
 
-	dw_mipi_dsi_mode_set(dsi, adjusted_mode);
-	if (dsi->slave)
-		dw_mipi_dsi_mode_set(dsi->slave, adjusted_mode);
+	/* Store the display mode for later use in pre_enable callback */
+	drm_mode_copy(&dsi->mode, adjusted_mode);
 }
 
 static void dw_mipi_dsi_bridge_atomic_enable(struct drm_bridge *bridge,
@@ -1004,6 +1007,7 @@ static const struct drm_bridge_funcs dw_mipi_dsi_bridge_funcs = {
 	.atomic_duplicate_state	= drm_atomic_helper_bridge_duplicate_state,
 	.atomic_destroy_state	= drm_atomic_helper_bridge_destroy_state,
 	.atomic_reset		= drm_atomic_helper_bridge_reset,
+	.atomic_pre_enable	= dw_mipi_dsi_bridge_atomic_pre_enable,
 	.atomic_enable		= dw_mipi_dsi_bridge_atomic_enable,
 	.atomic_post_disable	= dw_mipi_dsi_bridge_post_atomic_disable,
 	.mode_set		= dw_mipi_dsi_bridge_mode_set,
-- 
2.41.0

