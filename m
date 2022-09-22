Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 935115E7031
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 01:22:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231164AbiIVXVP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 19:21:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbiIVXVN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 19:21:13 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECCD9D69E6
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 16:21:11 -0700 (PDT)
Received: from notapiano.myfiosgateway.com (unknown [71.190.76.4])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 535A2660221E;
        Fri, 23 Sep 2022 00:21:07 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1663888869;
        bh=6nP/9Zwgxo3QoKKRtWQ1NzQUJknZbxNLs8qAepYQ8Is=;
        h=From:To:Cc:Subject:Date:From;
        b=UkE+IPdZWxVIdnWhxNsSLoepa2mBtct2d8MQJCnMGxOxjAWPaHvBzUAotcsKhwu/B
         JaBL6bnpBF0H18XUhe3IVgNq/UiFn+Gz3Gwue9/4unRstYptP0JZDB+OibCg4sKmVz
         sRUxH8tExtkUkgAxwPpVbPP7FRQ8S5W85QgKd/NvpypE42kWOficRu9npH6yRjCcZ3
         ZA4yjMnwjDsvtxhV6edVENMH8DeIznbXIye2EYS5dFJN1gaktpSkZu5v2C7ZVfqk8L
         KG7i0CFRKDrDuov2sQqYlQl4HUEUmufs0PxfJZSVJKJyUCw8MrdJhZ3yksNjmFFiD8
         ZTJqmwdj5LcDg==
From:   =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>
To:     Robert Foss <robert.foss@linaro.org>
Cc:     kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>, Andrzej Hajda <andrzej.hajda@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Xin Ji <xji@analogixsemi.com>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/bridge: anx7625: Notify audio framework of connector status changes
Date:   Thu, 22 Sep 2022 19:21:03 -0400
Message-Id: <20220922232103.246955-1-nfraprado@collabora.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We already have anx7625_audio_update_connector_status() to notify the
audio framework when HDMI is (dis)connected, but up until now this
function was only called during the callback setup. Add a call for it
to the HPD change handling logic.

A couple functions needed to be hoisted as part of this.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

---

 drivers/gpu/drm/bridge/analogix/anx7625.c | 48 ++++++++++++-----------
 1 file changed, 25 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.c b/drivers/gpu/drm/bridge/analogix/anx7625.c
index b0ff1ecb80a5..da54d6a61e07 100644
--- a/drivers/gpu/drm/bridge/analogix/anx7625.c
+++ b/drivers/gpu/drm/bridge/analogix/anx7625.c
@@ -1588,6 +1588,29 @@ static int anx7625_hpd_change_detect(struct anx7625_data *ctx)
 	return 0;
 }
 
+static void
+anx7625_audio_update_connector_status(struct anx7625_data *ctx,
+				      enum drm_connector_status status)
+{
+	if (ctx->plugged_cb && ctx->codec_dev) {
+		ctx->plugged_cb(ctx->codec_dev,
+				status == connector_status_connected);
+	}
+}
+
+static enum drm_connector_status anx7625_sink_detect(struct anx7625_data *ctx)
+{
+	struct device *dev = &ctx->client->dev;
+
+	DRM_DEV_DEBUG_DRIVER(dev, "sink detect\n");
+
+	if (ctx->pdata.panel_bridge)
+		return connector_status_connected;
+
+	return ctx->hpd_status ? connector_status_connected :
+				     connector_status_disconnected;
+}
+
 static void anx7625_work_func(struct work_struct *work)
 {
 	int event;
@@ -1603,6 +1626,8 @@ static void anx7625_work_func(struct work_struct *work)
 	if (event < 0)
 		goto unlock;
 
+	anx7625_audio_update_connector_status(ctx, anx7625_sink_detect(ctx));
+
 	if (ctx->bridge_attached)
 		drm_helper_hpd_irq_event(ctx->bridge.dev);
 
@@ -1790,19 +1815,6 @@ static struct edid *anx7625_get_edid(struct anx7625_data *ctx)
 	return (struct edid *)edid;
 }
 
-static enum drm_connector_status anx7625_sink_detect(struct anx7625_data *ctx)
-{
-	struct device *dev = &ctx->client->dev;
-
-	DRM_DEV_DEBUG_DRIVER(dev, "sink detect\n");
-
-	if (ctx->pdata.panel_bridge)
-		return connector_status_connected;
-
-	return ctx->hpd_status ? connector_status_connected :
-				     connector_status_disconnected;
-}
-
 static int anx7625_audio_hw_params(struct device *dev, void *data,
 				   struct hdmi_codec_daifmt *fmt,
 				   struct hdmi_codec_params *params)
@@ -1951,16 +1963,6 @@ static int anx7625_hdmi_i2s_get_dai_id(struct snd_soc_component *component,
 	return 0;
 }
 
-static void
-anx7625_audio_update_connector_status(struct anx7625_data *ctx,
-				      enum drm_connector_status status)
-{
-	if (ctx->plugged_cb && ctx->codec_dev) {
-		ctx->plugged_cb(ctx->codec_dev,
-				status == connector_status_connected);
-	}
-}
-
 static int anx7625_audio_hook_plugged_cb(struct device *dev, void *data,
 					 hdmi_codec_plugged_cb fn,
 					 struct device *codec_dev)
-- 
2.37.3

