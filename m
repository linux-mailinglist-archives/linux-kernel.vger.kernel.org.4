Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FDF66D07E9
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 16:17:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232440AbjC3ORE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 10:17:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232331AbjC3OQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 10:16:45 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22B98B3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 07:16:44 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 378CB660318B;
        Thu, 30 Mar 2023 15:16:39 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1680185799;
        bh=D/9bHIIU8EntiaL/vdcNdgqt9ErEdu+AmuAAOoOoYds=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=B2jMTHtt045a3dSxN00qmjjDtSEqT0xybtlM2APVkIaOO4JR3NWyYXjEMi5e3F+QS
         xRUXvu4N1GHHY27St/IA+bi8R28QBW6FQrTbY69eyiMbplI5qC1neRsaejS30M7Vsk
         7k1rJn3jj4llAkZEOlbphLLKtP26RTuEVa4EccwBSgRQvvxAIsavo55+c+pGAdQYTl
         qMjcHIJeuvzUHo45cHPNDLq9tJphRY/IkpwU/Abhj8CueHBB8gGjpiXtEdfaUHKyit
         sUmgS6tFkmG5W2+936+S8gMYSf4sDlU4t9RA7znNUTcG2Fk1+Js5rbQStuUYAsV9Ln
         vfNUqnHOceQiA==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     chunkuang.hu@kernel.org
Cc:     p.zabel@pengutronix.de, airlied@gmail.com, daniel@ffwll.ch,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel@collabora.com,
        wenst@chromium.org
Subject: [PATCH v1 5/5] drm/mediatek: dp: Add support for embedded DisplayPort aux-bus
Date:   Thu, 30 Mar 2023 16:16:27 +0200
Message-Id: <20230330141631.190528-6-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230330141631.190528-1-angelogioacchino.delregno@collabora.com>
References: <20230330141631.190528-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For the eDP case we can support using aux-bus on MediaTek DP: this
gives us the possibility to declare our panel as generic "panel-edp"
which will automatically configure the timings and available modes
via the EDID that we read from it.

To do this, move the panel parsing at the end of the probe function
so that the hardware is initialized beforehand and also power it on
as, when we populate the aux-bus, the panel driver will trigger an
EDID read as panel detection.

Also, since the DP IP will always trigger a HPD interrupt at this
stage, it was necessary to add a new `bridge_attached` member to
the mtk_dp structure to make sure that `drm_helper_hpd_irq_event()`
will not be called before the bridge gets actually attached, or
otherwise we will get a NULL pointer KP due to mtk_dp->bridge.dev
being uninitialized.

Last but not least, since now the AUX transfers can happen in the
separated aux-bus, it was necessary to add an exclusion for the
cable_plugged_in check in `mtk_dp_aux_transfer()` and the easiest
way to do this is to simply ignore checking that when the bridge
type is eDP.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/gpu/drm/mediatek/mtk_dp.c | 57 +++++++++++++++++++++++++------
 1 file changed, 46 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_dp.c b/drivers/gpu/drm/mediatek/mtk_dp.c
index ac21eca0e20e..1af0b4f9f166 100644
--- a/drivers/gpu/drm/mediatek/mtk_dp.c
+++ b/drivers/gpu/drm/mediatek/mtk_dp.c
@@ -4,6 +4,7 @@
  * Copyright (c) 2022 BayLibre
  */
 
+#include <drm/display/drm_dp_aux_bus.h>
 #include <drm/display/drm_dp.h>
 #include <drm/display/drm_dp_helper.h>
 #include <drm/drm_atomic_helper.h>
@@ -100,6 +101,7 @@ struct mtk_dp_efuse_fmt {
 struct mtk_dp {
 	bool enabled;
 	bool need_debounce;
+	bool bridge_attached;
 	u8 max_lanes;
 	u8 max_linkrate;
 	u8 rx_cap[DP_RECEIVER_CAP_SIZE];
@@ -1847,7 +1849,8 @@ static irqreturn_t mtk_dp_hpd_event_thread(int hpd, void *dev)
 	spin_unlock_irqrestore(&mtk_dp->irq_thread_lock, flags);
 
 	if (status & MTK_DP_THREAD_CABLE_STATE_CHG) {
-		drm_helper_hpd_irq_event(mtk_dp->bridge.dev);
+		if (mtk_dp->bridge_attached)
+			drm_helper_hpd_irq_event(mtk_dp->bridge.dev);
 
 		if (!mtk_dp->train_info.cable_plugged_in) {
 			mtk_dp_disable_sdp_aui(mtk_dp);
@@ -2040,7 +2043,8 @@ static ssize_t mtk_dp_aux_transfer(struct drm_dp_aux *mtk_aux,
 
 	mtk_dp = container_of(mtk_aux, struct mtk_dp, aux);
 
-	if (!mtk_dp->train_info.cable_plugged_in) {
+	if (mtk_dp->data->bridge_type != DRM_MODE_CONNECTOR_eDP &&
+	    !mtk_dp->train_info.cable_plugged_in) {
 		ret = -EAGAIN;
 		goto err;
 	}
@@ -2149,6 +2153,7 @@ static int mtk_dp_bridge_attach(struct drm_bridge *bridge,
 	mtk_dp->drm_dev = bridge->dev;
 
 	mtk_dp_hwirq_enable(mtk_dp, true);
+	mtk_dp->bridge_attached = true;
 
 	return 0;
 
@@ -2163,6 +2168,7 @@ static void mtk_dp_bridge_detach(struct drm_bridge *bridge)
 {
 	struct mtk_dp *mtk_dp = mtk_dp_from_bridge(bridge);
 
+	mtk_dp->bridge_attached = false;
 	mtk_dp_hwirq_enable(mtk_dp, false);
 	mtk_dp->drm_dev = NULL;
 	mtk_dp_poweroff(mtk_dp);
@@ -2478,6 +2484,20 @@ static int mtk_dp_register_audio_driver(struct device *dev)
 	return PTR_ERR_OR_ZERO(mtk_dp->audio_pdev);
 }
 
+static int mtk_dp_edp_link_panel(struct drm_dp_aux *mtk_aux)
+{
+	struct mtk_dp *mtk_dp = container_of(mtk_aux, struct mtk_dp, aux);
+	struct device *dev = mtk_aux->dev;
+	struct drm_bridge *panel_aux_bridge;
+
+	panel_aux_bridge = devm_drm_of_get_bridge(dev, dev->of_node, 1, 0);
+	if (IS_ERR(panel_aux_bridge))
+		return PTR_ERR(panel_aux_bridge);
+
+	mtk_dp->next_bridge = panel_aux_bridge;
+	return 0;
+}
+
 static int mtk_dp_probe(struct platform_device *pdev)
 {
 	struct mtk_dp *mtk_dp;
@@ -2496,21 +2516,14 @@ static int mtk_dp_probe(struct platform_device *pdev)
 		return dev_err_probe(dev, irq_num,
 				     "failed to request dp irq resource\n");
 
-	mtk_dp->next_bridge = devm_drm_of_get_bridge(dev, dev->of_node, 1, 0);
-	if (IS_ERR(mtk_dp->next_bridge) &&
-	    PTR_ERR(mtk_dp->next_bridge) == -ENODEV)
-		mtk_dp->next_bridge = NULL;
-	else if (IS_ERR(mtk_dp->next_bridge))
-		return dev_err_probe(dev, PTR_ERR(mtk_dp->next_bridge),
-				     "Failed to get bridge\n");
-
 	ret = mtk_dp_dt_parse(mtk_dp, pdev);
 	if (ret)
 		return dev_err_probe(dev, ret, "Failed to parse dt\n");
 
-	drm_dp_aux_init(&mtk_dp->aux);
 	mtk_dp->aux.name = "aux_mtk_dp";
+	mtk_dp->aux.dev = dev;
 	mtk_dp->aux.transfer = mtk_dp_aux_transfer;
+	drm_dp_aux_init(&mtk_dp->aux);
 
 	spin_lock_init(&mtk_dp->irq_thread_lock);
 
@@ -2565,6 +2578,28 @@ static int mtk_dp_probe(struct platform_device *pdev)
 	mtk_dp->need_debounce = true;
 	timer_setup(&mtk_dp->debounce_timer, mtk_dp_debounce_timer, 0);
 
+	if (mtk_dp->bridge.type == DRM_MODE_CONNECTOR_eDP) {
+		/* Need to power on HW because aux-bus will read EDID */
+		mtk_dp_aux_panel_poweron(mtk_dp, true);
+
+		/* We ignore -ENODEV error, as the panel may not be on aux-bus */
+		ret = devm_of_dp_aux_populate_bus(&mtk_dp->aux, NULL);
+		if (ret && ret != -ENODEV) {
+			mtk_dp_aux_panel_poweron(mtk_dp, false);
+			return ret;
+		}
+
+		/*
+		 * Here we don't ignore any error, as if there's no panel to
+		 * link, eDP is not configured correctly and will be unusable.
+		 */
+		ret = mtk_dp_edp_link_panel(&mtk_dp->aux);
+		if (ret) {
+			mtk_dp_aux_panel_poweron(mtk_dp, false);
+			return ret;
+		}
+	}
+
 	pm_runtime_enable(dev);
 	pm_runtime_get_sync(dev);
 
-- 
2.40.0

