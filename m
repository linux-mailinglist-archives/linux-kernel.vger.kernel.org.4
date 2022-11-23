Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EBAB63597F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 11:18:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237377AbiKWKSR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 05:18:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237835AbiKWKR2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 05:17:28 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DBAB11606D
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 02:05:42 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id p12so16202261plq.4
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 02:05:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jg9Va4FU9dSDHU9ZJEP1jjLMkksxPUQCx/bp3wHT5LQ=;
        b=WfT72T7RroMBI9wlOw/bnHHnoMf0WdGs3XyvUrO4MKlEA6nqF+p/zMfKEtc1lbTHMP
         AUezr1Y3S9zCcAz1rse/vatF4x4DHyqj1sqxRUoc4F8B7S7ADYFtpx2fKEE76qFdjo4D
         I/yxw4O7JjW32pIQFhcmJQc1sgcv9rZRQrtcg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jg9Va4FU9dSDHU9ZJEP1jjLMkksxPUQCx/bp3wHT5LQ=;
        b=4lf64Hg7iAngZwhKlc0G9BlknxYmoPhrjKy7sds5OYU6o7ZfBsClHAPw/+i9pWdxQL
         5vGg5QD+jpisidamJL8qlnxuYi+vvhZYraPfqtiUdaJT6bOY6XVNBGnJFnFXtKhLnUs2
         uC5GaA7IrJd1gDnxe7T9uNDjIEuKhtaIHtDajEUSOCo724oH6Ruealz/zb4gNBnuKRJC
         jfhwVqF2MFRYh5NgljsfcFmZvGwMYYSaLX8AArNwuSOslgAByc9F4uXe62VV3orkxxqB
         cMBn0i64TJEfQoYcsPqWhSetHULB09jdIEEMFRvi1kVNYtaVjIPZ4BhAe81TaoBcaCHu
         sPJg==
X-Gm-Message-State: ANoB5pm7cBh5uE8KLZw/RnlGE+dAXeQabcloJarVGShy35yLyOcOJjgs
        q/lMcSXeCRlFtjTHhQx8uyQ5kQ==
X-Google-Smtp-Source: AA0mqf5fXXQL3ErzztA77WK7yJt0QPQuomMU2DldHrT5bbiS3aoblEd2LM/kN8e/sUrTjWAALPK+vg==
X-Received: by 2002:a17:903:26ce:b0:189:2274:7282 with SMTP id jg14-20020a17090326ce00b0018922747282mr8540890plb.90.1669197941921;
        Wed, 23 Nov 2022 02:05:41 -0800 (PST)
Received: from hsinyi.c.googlers.com.com (46.165.189.35.bc.googleusercontent.com. [35.189.165.46])
        by smtp.gmail.com with ESMTPSA id y129-20020a626487000000b005745a586badsm1020138pfb.218.2022.11.23.02.05.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 02:05:41 -0800 (PST)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     Sean Paul <seanpaul@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Robert Foss <robert.foss@linaro.org>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Allen Chen <allen.chen@ite.com.tw>,
        David Airlie <airlied@gmail.com>
Subject: [PATCH v7 3/3] drm/bridge: it6505: handle HDCP request
Date:   Wed, 23 Nov 2022 10:05:29 +0000
Message-Id: <20221123100529.3943662-3-hsinyi@chromium.org>
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
In-Reply-To: <20221123100529.3943662-1-hsinyi@chromium.org>
References: <20221123100529.3943662-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

it6505 supports HDCP 1.3, but current implementation lacks the update of
HDCP status through drm_hdcp_update_content_protection().

it6505 default enables the HDCP. Remove this and only turn on when user
requests it.

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
Reviewed-by: allen chen <allen.chen@ite.com.tw>
---
v6->v7: remove enable hdcp by default.
---
 drivers/gpu/drm/bridge/ite-it6505.c | 60 +++++++++++++++++++++++++++--
 1 file changed, 57 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ite-it6505.c b/drivers/gpu/drm/bridge/ite-it6505.c
index 21a9b8422bda..93626698c31e 100644
--- a/drivers/gpu/drm/bridge/ite-it6505.c
+++ b/drivers/gpu/drm/bridge/ite-it6505.c
@@ -423,6 +423,7 @@ struct it6505 {
 	struct extcon_dev *extcon;
 	struct work_struct extcon_wq;
 	int extcon_state;
+	struct drm_connector *connector;
 	enum drm_connector_status connector_status;
 	enum link_train_status link_state;
 	struct work_struct link_works;
@@ -2159,9 +2160,6 @@ static void it6505_link_train_ok(struct it6505 *it6505)
 		DRM_DEV_DEBUG_DRIVER(dev, "Enable audio!");
 		it6505_enable_audio(it6505);
 	}
-
-	if (it6505->hdcp_desired)
-		it6505_start_hdcp(it6505);
 }
 
 static void it6505_link_step_train_process(struct it6505 *it6505)
@@ -2399,6 +2397,14 @@ static void it6505_irq_hdcp_done(struct it6505 *it6505)
 
 	DRM_DEV_DEBUG_DRIVER(dev, "hdcp done interrupt");
 	it6505->hdcp_status = HDCP_AUTH_DONE;
+	if (it6505->connector) {
+		struct drm_device *drm_dev = it6505->connector->dev;
+
+		drm_modeset_lock(&drm_dev->mode_config.connection_mutex, NULL);
+		drm_hdcp_update_content_protection(it6505->connector,
+						   DRM_MODE_CONTENT_PROTECTION_ENABLED);
+		drm_modeset_unlock(&drm_dev->mode_config.connection_mutex);
+	}
 	it6505_show_hdcp_info(it6505);
 }
 
@@ -2931,6 +2937,7 @@ static void it6505_bridge_atomic_enable(struct drm_bridge *bridge,
 	if (WARN_ON(!connector))
 		return;
 
+	it6505->connector = connector;
 	conn_state = drm_atomic_get_new_connector_state(state, connector);
 
 	if (WARN_ON(!conn_state))
@@ -2974,6 +2981,7 @@ static void it6505_bridge_atomic_disable(struct drm_bridge *bridge,
 
 	DRM_DEV_DEBUG_DRIVER(dev, "start");
 
+	it6505->connector = NULL;
 	if (it6505->powered) {
 		it6505_drm_dp_link_set_power(&it6505->aux, &it6505->link,
 					     DP_SET_POWER_D3);
@@ -3028,6 +3036,50 @@ static struct edid *it6505_bridge_get_edid(struct drm_bridge *bridge,
 	return edid;
 }
 
+static int it6505_connector_atomic_check(struct it6505 *it6505,
+					 struct drm_connector_state *state)
+{
+	struct device *dev = &it6505->client->dev;
+	int cp = state->content_protection;
+
+	DRM_DEV_DEBUG_DRIVER(dev, "hdcp connector state:%d, curr hdcp state:%d",
+			     cp, it6505->hdcp_status);
+
+	if (!it6505->hdcp_desired) {
+		DRM_DEV_DEBUG_DRIVER(dev, "sink not support hdcp");
+		return 0;
+	}
+
+	if (it6505->hdcp_status == HDCP_AUTH_GOING)
+		return -EINVAL;
+
+	if (cp == DRM_MODE_CONTENT_PROTECTION_UNDESIRED) {
+		if (it6505->hdcp_status == HDCP_AUTH_DONE)
+			it6505_stop_hdcp(it6505);
+	} else if (cp == DRM_MODE_CONTENT_PROTECTION_DESIRED) {
+		if (it6505->hdcp_status == HDCP_AUTH_IDLE &&
+		    it6505->link_state == LINK_OK)
+			it6505_start_hdcp(it6505);
+	} else {
+		if (it6505->hdcp_status == HDCP_AUTH_IDLE) {
+			DRM_DEV_DEBUG_DRIVER(dev, "invalid to set hdcp enabled");
+			return -EINVAL;
+		}
+	}
+
+	return 0;
+}
+
+static int it6505_bridge_atomic_check(struct drm_bridge *bridge,
+				      struct drm_bridge_state *bridge_state,
+				      struct drm_crtc_state *crtc_state,
+				      struct drm_connector_state *conn_state)
+{
+	struct it6505 *it6505 = bridge_to_it6505(bridge);
+
+	return it6505_connector_atomic_check(it6505, conn_state);
+}
+
 static const struct drm_bridge_funcs it6505_bridge_funcs = {
 	.atomic_duplicate_state = drm_atomic_helper_bridge_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_bridge_destroy_state,
@@ -3035,6 +3087,7 @@ static const struct drm_bridge_funcs it6505_bridge_funcs = {
 	.attach = it6505_bridge_attach,
 	.detach = it6505_bridge_detach,
 	.mode_valid = it6505_bridge_mode_valid,
+	.atomic_check = it6505_bridge_atomic_check,
 	.atomic_enable = it6505_bridge_atomic_enable,
 	.atomic_disable = it6505_bridge_atomic_disable,
 	.atomic_pre_enable = it6505_bridge_atomic_pre_enable,
@@ -3354,6 +3407,7 @@ static int it6505_i2c_probe(struct i2c_client *client,
 	it6505->bridge.type = DRM_MODE_CONNECTOR_DisplayPort;
 	it6505->bridge.ops = DRM_BRIDGE_OP_DETECT | DRM_BRIDGE_OP_EDID |
 			     DRM_BRIDGE_OP_HPD;
+	it6505->bridge.support_hdcp = true;
 	drm_bridge_add(&it6505->bridge);
 
 	return 0;
-- 
2.38.1.584.g0f3c55d4c2-goog

