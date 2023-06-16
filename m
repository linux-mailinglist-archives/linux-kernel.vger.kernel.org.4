Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28188733D11
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 01:55:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233349AbjFPXzw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 19:55:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230132AbjFPXzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 19:55:49 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E1D52D4C
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 16:55:47 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id 3f1490d57ef6-be49e41a3d6so1068567276.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 16:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1686959747; x=1689551747;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=L7c6vdsDMgEhg/4Dt7iJwihFwCqLkr9cdfGj229y85U=;
        b=SgxHfeWXtovRTx0Zp13Coj9JDCk2062f1OJ8xF7q3AXQSRe4L48Vnr2kYXYL88GzzJ
         EHbp0NSmUUt65eWWhCFBVxjBxZh/nNwIwnbwkf/h6P+niL4BRi5NmUQG/JA0gDlMAYGL
         U4xXsBgIktX5oZbPUFB7fA/GZE2qdhlHzCJnA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686959747; x=1689551747;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L7c6vdsDMgEhg/4Dt7iJwihFwCqLkr9cdfGj229y85U=;
        b=IuJfFLUiNnnNuvHXwzmxvEO+O8Lr29uiPkBuddceHQKSpZ7tBDAfQ8psRDITuweb1d
         MYEPQHblYQlHaX94LbkEaab2ka+iYWoc9sTEqucWnObY1+/8ogfWuM6ILb7/aezHTB/M
         5c1gY44G7Nil3thrpuBfsI2N1rtcvHdJbSAJHNnDs/VNcxmEaposl0PHsv19pDu1IO+f
         cm3R5Yr9Ngnp5/dqyGZiPyEwOTC2gV0usO88oOOAv0goS40xUyI8X1rIJ9mQ9Znw1+gU
         FEdTz0td7nq3V68SqGNDKCcg5MBhEYaTzkGyWufvc6yneWUvW+WoYo2PAWpByUQt2GEU
         9JJg==
X-Gm-Message-State: AC+VfDyBTz8okluDEjJa/Qxud14Tnut7K7tW4dOOqMh0C/tBBWAK01Ym
        eCkl/Ivw0Kastj9OjxrgsgWLiw==
X-Google-Smtp-Source: ACHHUZ494+LF9dHu8iWrChEGlIR80hEFdqBTzDAXJuZrJmvMeRhfSCPkiPjjmsQi6UZaol5OL5s7Sw==
X-Received: by 2002:a25:583:0:b0:bc8:5eff:9767 with SMTP id 125-20020a250583000000b00bc85eff9767mr491558ybf.33.1686959746682;
        Fri, 16 Jun 2023 16:55:46 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:27ce:4d20:94c5:fde0])
        by smtp.gmail.com with ESMTPSA id w5-20020a17090aea0500b002562cfb81dfsm1862496pjy.28.2023.06.16.16.55.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jun 2023 16:55:45 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     dri-devel@lists.freedesktop.org
Cc:     Pin-yen Lin <treapking@chromium.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-mediatek@lists.infradead.org,
        Sam Ravnborg <sam@ravnborg.org>,
        Maxime Ripard <mripard@kernel.org>,
        Icenowy Zheng <uwu@icenowy.me>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Douglas Anderson <dianders@chromium.org>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] drm/bridge: ps8640: Drop the ability of ps8640 to fetch the EDID
Date:   Fri, 16 Jun 2023 16:55:17 -0700
Message-ID: <20230616165517.v2.1.I7b8f60b3fbfda068f9bf452d584dc934494bfbfa@changeid>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to read the EDID from an eDP panel, you not only need to
power on the bridge chip itself but also the panel. In the ps8640
driver, this was made to work by having the bridge chip manually power
the panel on by calling pre_enable() on everything connectorward on
the bridge chain. This worked OK, but...

...when trying to do the same thing on ti-sn65dsi86, feedback was that
this wasn't a great idea. As a result, we designed the "DP AUX"
bus. With the design we ended up with the panel driver itself was in
charge of reading the EDID. The panel driver could power itself on and
the bridge chip was able to power itself on because it implemented the
DP AUX bus.

Despite the fact that we came up with a new scheme, implemented in on
ti-sn65dsi86, and even implemented it on parade-ps8640, we still kept
the old code around. This was because the new scheme required a DT
change. Previously the panel was a simple "platform_device" and in DT
at the top level. With the new design the panel needs to be listed in
DT under the DP controller node. The old code allowed us to properly
fetch EDIDs with ps8640 with the old DTs.

Unfortunately, the old code stopped working as of commit 102e80d1fa2c
("drm/bridge: ps8640: Use atomic variants of drm_bridge_funcs"). There
are cases at bootup where connector->state->state is NULL and the
kernel crashed at:
* drm_atomic_bridge_chain_pre_enable
* drm_atomic_get_old_bridge_state
* drm_atomic_get_old_private_obj_state

The crash went away at commit 4fb912e5e190 ("drm/bridge: Introduce
pre_enable_prev_first to alter bridge init order") which added a NULL
check. However, even though we were no longer crashing the end result
was that we weren't actually powering the panel on when we thought we
were. Things could end up working (despite warning splats) if
userspace was persistent and tried to get the mode again, but it
wasn't great.

A bit of digging was done to see if there was an easy fix but there
was nothing obvious. Instead, the only device using ps8640 the "old"
way had its DT updated so that the panel was no longer a simple
"platform_deice". See commit c2d94f72140a ("arm64: dts: mediatek:
mt8173-elm: Move display to ps8640 auxiliary bus") and commit
113b5cc06f44 ("arm64: dts: mediatek: mt8173-elm: remove panel model
number in DT").

Let's delete the old broken code so nobody gets tempted to copy it or
figure out how it works (since it doesn't).

NOTE: from a device tree "purist" point of view, we're supposed to
keep old device trees working and this patch is technically "against
policy". Reasons I'm still proposing it anyway:
1. Officially, old mt8173-elm device trees worked via the "little
   white lie" approach. The DT would list an arbitrary/representative
   panel that would be used for power sequencing. The mode information
   in the panel driver would then be ignored / overridden by the EDID
   reading code in ps8640. I don't feel too terrible breaking DTs that
   contained the wrong "compatible" string to begin with. NOTE that
   any old device trees that _didn't_ lie about their compatible will
   still work because the mode information will come from the
   hardcoded panels in panel-edp.
2. The only users of the old code were Chromebooks and Chromebooks
   don't bake their DTs into the BIOS (they are bundled with the
   kernel). Thus we don't need to worry about breaking someone using
   an old DT with a new kernel.
3. The old code was broken anyway. If someone wants to fix the old
   code instead of deleting it then they have my blessing, but without
   a proper fix the old code isn't useful.

Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v2:
- Removed "Fixes" tag as per discussion on v1.
- Adjusted commit message since commit 4fb912e5e190 made things not crash.

 drivers/gpu/drm/bridge/parade-ps8640.c | 79 --------------------------
 1 file changed, 79 deletions(-)

diff --git a/drivers/gpu/drm/bridge/parade-ps8640.c b/drivers/gpu/drm/bridge/parade-ps8640.c
index 8801cdd033b5..8161b1a1a4b1 100644
--- a/drivers/gpu/drm/bridge/parade-ps8640.c
+++ b/drivers/gpu/drm/bridge/parade-ps8640.c
@@ -105,7 +105,6 @@ struct ps8640 {
 	struct gpio_desc *gpio_reset;
 	struct gpio_desc *gpio_powerdown;
 	struct device_link *link;
-	struct edid *edid;
 	bool pre_enabled;
 	bool need_post_hpd_delay;
 };
@@ -155,23 +154,6 @@ static inline struct ps8640 *aux_to_ps8640(struct drm_dp_aux *aux)
 	return container_of(aux, struct ps8640, aux);
 }
 
-static bool ps8640_of_panel_on_aux_bus(struct device *dev)
-{
-	struct device_node *bus, *panel;
-
-	bus = of_get_child_by_name(dev->of_node, "aux-bus");
-	if (!bus)
-		return false;
-
-	panel = of_get_child_by_name(bus, "panel");
-	of_node_put(bus);
-	if (!panel)
-		return false;
-	of_node_put(panel);
-
-	return true;
-}
-
 static int _ps8640_wait_hpd_asserted(struct ps8640 *ps_bridge, unsigned long wait_us)
 {
 	struct regmap *map = ps_bridge->regmap[PAGE2_TOP_CNTL];
@@ -539,50 +521,6 @@ static void ps8640_bridge_detach(struct drm_bridge *bridge)
 		device_link_del(ps_bridge->link);
 }
 
-static struct edid *ps8640_bridge_get_edid(struct drm_bridge *bridge,
-					   struct drm_connector *connector)
-{
-	struct ps8640 *ps_bridge = bridge_to_ps8640(bridge);
-	struct device *dev = &ps_bridge->page[PAGE0_DP_CNTL]->dev;
-	bool poweroff = !ps_bridge->pre_enabled;
-
-	if (!ps_bridge->edid) {
-		/*
-		 * When we end calling get_edid() triggered by an ioctl, i.e
-		 *
-		 *   drm_mode_getconnector (ioctl)
-		 *     -> drm_helper_probe_single_connector_modes
-		 *        -> drm_bridge_connector_get_modes
-		 *           -> ps8640_bridge_get_edid
-		 *
-		 * We need to make sure that what we need is enabled before
-		 * reading EDID, for this chip, we need to do a full poweron,
-		 * otherwise it will fail.
-		 */
-		if (poweroff)
-			drm_atomic_bridge_chain_pre_enable(bridge,
-							   connector->state->state);
-
-		ps_bridge->edid = drm_get_edid(connector,
-					       ps_bridge->page[PAGE0_DP_CNTL]->adapter);
-
-		/*
-		 * If we call the get_edid() function without having enabled the
-		 * chip before, return the chip to its original power state.
-		 */
-		if (poweroff)
-			drm_atomic_bridge_chain_post_disable(bridge,
-							     connector->state->state);
-	}
-
-	if (!ps_bridge->edid) {
-		dev_err(dev, "Failed to get EDID\n");
-		return NULL;
-	}
-
-	return drm_edid_duplicate(ps_bridge->edid);
-}
-
 static void ps8640_runtime_disable(void *data)
 {
 	pm_runtime_dont_use_autosuspend(data);
@@ -592,7 +530,6 @@ static void ps8640_runtime_disable(void *data)
 static const struct drm_bridge_funcs ps8640_bridge_funcs = {
 	.attach = ps8640_bridge_attach,
 	.detach = ps8640_bridge_detach,
-	.get_edid = ps8640_bridge_get_edid,
 	.atomic_post_disable = ps8640_atomic_post_disable,
 	.atomic_pre_enable = ps8640_atomic_pre_enable,
 	.atomic_duplicate_state = drm_atomic_helper_bridge_duplicate_state,
@@ -705,14 +642,6 @@ static int ps8640_probe(struct i2c_client *client)
 	ps_bridge->bridge.of_node = dev->of_node;
 	ps_bridge->bridge.type = DRM_MODE_CONNECTOR_eDP;
 
-	/*
-	 * In the device tree, if panel is listed under aux-bus of the bridge
-	 * node, panel driver should be able to retrieve EDID by itself using
-	 * aux-bus. So let's not set DRM_BRIDGE_OP_EDID here.
-	 */
-	if (!ps8640_of_panel_on_aux_bus(&client->dev))
-		ps_bridge->bridge.ops = DRM_BRIDGE_OP_EDID;
-
 	/*
 	 * Get MIPI DSI resources early. These can return -EPROBE_DEFER so
 	 * we want to get them out of the way sooner.
@@ -777,13 +706,6 @@ static int ps8640_probe(struct i2c_client *client)
 	return ret;
 }
 
-static void ps8640_remove(struct i2c_client *client)
-{
-	struct ps8640 *ps_bridge = i2c_get_clientdata(client);
-
-	kfree(ps_bridge->edid);
-}
-
 static const struct of_device_id ps8640_match[] = {
 	{ .compatible = "parade,ps8640" },
 	{ }
@@ -792,7 +714,6 @@ MODULE_DEVICE_TABLE(of, ps8640_match);
 
 static struct i2c_driver ps8640_driver = {
 	.probe = ps8640_probe,
-	.remove = ps8640_remove,
 	.driver = {
 		.name = "ps8640",
 		.of_match_table = ps8640_match,
-- 
2.41.0.162.gfafddb0af9-goog

