Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2A0E6D59C6
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 09:37:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233701AbjDDHhd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 03:37:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233928AbjDDHha (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 03:37:30 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E85111BC
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 00:37:27 -0700 (PDT)
Received: from booty.fritz.box (unknown [77.244.183.192])
        (Authenticated sender: luca.ceresoli@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPA id E8061FF806;
        Tue,  4 Apr 2023 07:37:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1680593846;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=dYxgRiKBiyC9aBkvrnxyDE3aBRygWQf6CKuf5len1Ks=;
        b=fTrVC7oiQFon1yRW4lDxVOkJPJ6zVmR4++6L3cF5Cy+lHiaimfr9mKysHIqcuOmnKc+XHb
        X8mEoNpBsTgLvpMcdqWrhdiodv9kyKfUyC2IeHyyLfNv/+kHuYS/FgmcMTuK2JzEaN7h48
        5BZn/onnmGu2jScMQeBk/hAs/UE76ripctN96fK94wUqzF1LG+0v1mxDMEPnlA5IoT3KJ5
        Fxag6WwA2jsLAidrRzbv4AnUzbGHjzwaP08sp0ux5aeagYXKPo8zsxCbEQ68Zmk9XKj/QS
        g0MOKpvY9xjJXi9r7H+neKvzdpHbPGcJ4uibTUXA1kSMzbN/II46YDpRFiTNsA==
From:   Luca Ceresoli <luca.ceresoli@bootlin.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Luca Ceresoli <luca.ceresoli@bootlin.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Marek Vasut <marex@denx.de>,
        linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Subject: [PATCH] drm: bridge: ldb: add support for using channel 1 only
Date:   Tue,  4 Apr 2023 09:37:20 +0200
Message-Id: <20230404073720.1465552-1-luca.ceresoli@bootlin.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The LDB driver currently checks whether dual mode is used, otherwise it
assumes only channel 0 is in use. Add support for using only channel 1. In
device tree terms, this means linking port 2 only.

Doing this cleanly requires changing the logic of the probe functions from
this:

 1. use of_graph_get_remote_node() on port 1 to find the panel
 2. use drm_of_lvds_get_dual_link_pixel_order() to detect dual mode

to this:

 1. use of_graph_get_remote_node() twice to find remote ports
 2. reuse the result of the above to know whether each channel is enabled
    and to find the panel
 3. if (both channels as enabled)
        use drm_of_lvds_get_dual_link_pixel_order() to detect dual mode

Also add a dev_dbg() to log the detected mode and log an error in case no
panel was found (no channel enabled).

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
 drivers/gpu/drm/bridge/fsl-ldb.c | 112 ++++++++++++++++++-------------
 1 file changed, 67 insertions(+), 45 deletions(-)

diff --git a/drivers/gpu/drm/bridge/fsl-ldb.c b/drivers/gpu/drm/bridge/fsl-ldb.c
index 6bac160b395b..d844fb946981 100644
--- a/drivers/gpu/drm/bridge/fsl-ldb.c
+++ b/drivers/gpu/drm/bridge/fsl-ldb.c
@@ -84,10 +84,16 @@ struct fsl_ldb {
 	struct drm_bridge *panel_bridge;
 	struct clk *clk;
 	struct regmap *regmap;
-	bool lvds_dual_link;
 	const struct fsl_ldb_devdata *devdata;
+	bool ch0_enabled;
+	bool ch1_enabled;
 };
 
+static bool fsl_ldb_is_dual(const struct fsl_ldb *fsl_ldb)
+{
+	return (fsl_ldb->ch0_enabled && fsl_ldb->ch1_enabled);
+}
+
 static inline struct fsl_ldb *to_fsl_ldb(struct drm_bridge *bridge)
 {
 	return container_of(bridge, struct fsl_ldb, bridge);
@@ -95,7 +101,7 @@ static inline struct fsl_ldb *to_fsl_ldb(struct drm_bridge *bridge)
 
 static unsigned long fsl_ldb_link_frequency(struct fsl_ldb *fsl_ldb, int clock)
 {
-	if (fsl_ldb->lvds_dual_link)
+	if (fsl_ldb_is_dual(fsl_ldb))
 		return clock * 3500;
 	else
 		return clock * 7000;
@@ -177,28 +183,25 @@ static void fsl_ldb_atomic_enable(struct drm_bridge *bridge,
 	clk_prepare_enable(fsl_ldb->clk);
 
 	/* Program LDB_CTRL */
-	reg = LDB_CTRL_CH0_ENABLE;
-
-	if (fsl_ldb->lvds_dual_link)
-		reg |= LDB_CTRL_CH1_ENABLE | LDB_CTRL_SPLIT_MODE;
-
-	if (lvds_format_24bpp) {
-		reg |= LDB_CTRL_CH0_DATA_WIDTH;
-		if (fsl_ldb->lvds_dual_link)
-			reg |= LDB_CTRL_CH1_DATA_WIDTH;
-	}
-
-	if (lvds_format_jeida) {
-		reg |= LDB_CTRL_CH0_BIT_MAPPING;
-		if (fsl_ldb->lvds_dual_link)
-			reg |= LDB_CTRL_CH1_BIT_MAPPING;
-	}
-
-	if (mode->flags & DRM_MODE_FLAG_PVSYNC) {
-		reg |= LDB_CTRL_DI0_VSYNC_POLARITY;
-		if (fsl_ldb->lvds_dual_link)
-			reg |= LDB_CTRL_DI1_VSYNC_POLARITY;
-	}
+	reg =
+		(fsl_ldb->ch0_enabled ? LDB_CTRL_CH0_ENABLE : 0) |
+		(fsl_ldb->ch1_enabled ? LDB_CTRL_CH1_ENABLE : 0) |
+		(fsl_ldb_is_dual(fsl_ldb) ? LDB_CTRL_SPLIT_MODE : 0);
+
+	if (lvds_format_24bpp)
+		reg |=
+			(fsl_ldb->ch0_enabled ? LDB_CTRL_CH0_DATA_WIDTH : 0) |
+			(fsl_ldb->ch1_enabled ? LDB_CTRL_CH1_DATA_WIDTH : 0);
+
+	if (lvds_format_jeida)
+		reg |=
+			(fsl_ldb->ch0_enabled ? LDB_CTRL_CH0_BIT_MAPPING : 0) |
+			(fsl_ldb->ch1_enabled ? LDB_CTRL_CH1_BIT_MAPPING : 0);
+
+	if (mode->flags & DRM_MODE_FLAG_PVSYNC)
+		reg |=
+			(fsl_ldb->ch0_enabled ? LDB_CTRL_DI0_VSYNC_POLARITY : 0) |
+			(fsl_ldb->ch1_enabled ? LDB_CTRL_DI1_VSYNC_POLARITY : 0);
 
 	regmap_write(fsl_ldb->regmap, fsl_ldb->devdata->ldb_ctrl, reg);
 
@@ -210,9 +213,9 @@ static void fsl_ldb_atomic_enable(struct drm_bridge *bridge,
 	/* Wait for VBG to stabilize. */
 	usleep_range(15, 20);
 
-	reg |= LVDS_CTRL_CH0_EN;
-	if (fsl_ldb->lvds_dual_link)
-		reg |= LVDS_CTRL_CH1_EN;
+	reg |=
+		(fsl_ldb->ch0_enabled ? LVDS_CTRL_CH0_EN : 0) |
+		(fsl_ldb->ch1_enabled ? LVDS_CTRL_CH1_EN : 0);
 
 	regmap_write(fsl_ldb->regmap, fsl_ldb->devdata->lvds_ctrl, reg);
 }
@@ -265,7 +268,7 @@ fsl_ldb_mode_valid(struct drm_bridge *bridge,
 {
 	struct fsl_ldb *fsl_ldb = to_fsl_ldb(bridge);
 
-	if (mode->clock > (fsl_ldb->lvds_dual_link ? 160000 : 80000))
+	if (mode->clock > (fsl_ldb_is_dual(fsl_ldb) ? 160000 : 80000))
 		return MODE_CLOCK_HIGH;
 
 	return MODE_OK;
@@ -286,7 +289,7 @@ static int fsl_ldb_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct device_node *panel_node;
-	struct device_node *port1, *port2;
+	struct device_node *remote1, *remote2;
 	struct drm_panel *panel;
 	struct fsl_ldb *fsl_ldb;
 	int dual_link;
@@ -311,10 +314,23 @@ static int fsl_ldb_probe(struct platform_device *pdev)
 	if (IS_ERR(fsl_ldb->regmap))
 		return PTR_ERR(fsl_ldb->regmap);
 
-	/* Locate the panel DT node. */
-	panel_node = of_graph_get_remote_node(dev->of_node, 1, 0);
-	if (!panel_node)
-		return -ENXIO;
+	/* Locate the remote ports and the panel node */
+	remote1 = of_graph_get_remote_node(dev->of_node, 1, 0);
+	remote2 = of_graph_get_remote_node(dev->of_node, 2, 0);
+	fsl_ldb->ch0_enabled = (remote1 != NULL);
+	fsl_ldb->ch1_enabled = (remote2 != NULL);
+	panel_node = of_node_get(remote1 ? remote1 : remote2);
+	of_node_put(remote1);
+	of_node_put(remote2);
+
+	if (!fsl_ldb->ch0_enabled && !fsl_ldb->ch1_enabled) {
+		of_node_put(panel_node);
+		return dev_err_probe(dev, -ENXIO, "No panel node found");
+	}
+
+	dev_dbg(dev, "Using %s\n",
+		fsl_ldb_is_dual(fsl_ldb) ? "dual mode" :
+		fsl_ldb->ch0_enabled ? "channel 0" : "channel 1");
 
 	panel = of_drm_find_panel(panel_node);
 	of_node_put(panel_node);
@@ -325,20 +341,26 @@ static int fsl_ldb_probe(struct platform_device *pdev)
 	if (IS_ERR(fsl_ldb->panel_bridge))
 		return PTR_ERR(fsl_ldb->panel_bridge);
 
-	/* Determine whether this is dual-link configuration */
-	port1 = of_graph_get_port_by_id(dev->of_node, 1);
-	port2 = of_graph_get_port_by_id(dev->of_node, 2);
-	dual_link = drm_of_lvds_get_dual_link_pixel_order(port1, port2);
-	of_node_put(port1);
-	of_node_put(port2);
 
-	if (dual_link == DRM_LVDS_DUAL_LINK_EVEN_ODD_PIXELS) {
-		dev_err(dev, "LVDS channel pixel swap not supported.\n");
-		return -EINVAL;
-	}
+	if (fsl_ldb_is_dual(fsl_ldb)) {
+		struct device_node *port1, *port2;
+
+		port1 = of_graph_get_port_by_id(dev->of_node, 1);
+		port2 = of_graph_get_port_by_id(dev->of_node, 2);
+		dual_link = drm_of_lvds_get_dual_link_pixel_order(port1, port2);
+		of_node_put(port1);
+		of_node_put(port2);
 
-	if (dual_link == DRM_LVDS_DUAL_LINK_ODD_EVEN_PIXELS)
-		fsl_ldb->lvds_dual_link = true;
+		if (dual_link < 0)
+			return dev_err_probe(dev, dual_link,
+					     "Error getting dual link configuration");
+
+		/* Only DRM_LVDS_DUAL_LINK_ODD_EVEN_PIXELS is supported */
+		if (dual_link == DRM_LVDS_DUAL_LINK_EVEN_ODD_PIXELS) {
+			dev_err(dev, "LVDS channel pixel swap not supported.\n");
+			return -EINVAL;
+		}
+	}
 
 	platform_set_drvdata(pdev, fsl_ldb);
 
-- 
2.34.1

