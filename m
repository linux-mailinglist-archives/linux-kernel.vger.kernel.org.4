Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8223E627706
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 09:04:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236184AbiKNIEh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 03:04:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235782AbiKNIEf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 03:04:35 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80821A44D
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 00:04:34 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id b11so9654530pjp.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 00:04:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xoG+PJ9Nv0PDD+u17FuY5+9Du9VLILbNauZXpkpEyQQ=;
        b=CIZEgZfUnCWJeURsVp/Xm+odE+LazMMPO6T0YWFu4rOJWHW0dOOIryWk6KVIImAAIj
         dnRQXgEEDyvvG10/lE+19pymhklk3X1ZIMT5Ml3unTgam0Atkjjo5k6BXk5KC5muXRdZ
         SKJnnogqqy0wD5olJGDVRJpf46SyYN6BB38L4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xoG+PJ9Nv0PDD+u17FuY5+9Du9VLILbNauZXpkpEyQQ=;
        b=Fxf4EWFEdyh3nUwZFgrtz6+3OQOwnH0ohI9cc5F/79+DUUMxSTH04idnH3n5rTMuza
         qb9yWjqG+MaH+VfPs2i3PLQcBBVMt2QZiaBba1Y6A/L3q+jGTS+k8aIK+vot4eUCwmj5
         pnp18ciHc1sJoQRCA+mhX4X2S13YKAqhXB953Si0BH1+f6QXwNuw2hn8R46ws+hq0QfP
         vhhVmu7JcwutgRkNF6iYBMr/F4Xfpy7JEgYV5pa/mcxi4JG2G6ksqJMiMVJZyQ9qSIeY
         Pg+Lk67Ng4+mIKl1MUCeNcrBgNbGQeQCfotdohpyWgNsB+53ww+1hFNC+eRVrhwuzZj1
         NJyw==
X-Gm-Message-State: ANoB5pnpIPRFu+81i50cPvcDLojAz+vweAEJBw+ZG5+QE+cYmTghPbVx
        Tv59X0GwxF1vklQm7Nm1S2sCvQ==
X-Google-Smtp-Source: AA0mqf5mkTTvERz38Hq6KQcT7IGye7ORIveDefH6gBS7UHEPLjTy8OplWLFFOhShRaVLBM82XyJhqA==
X-Received: by 2002:a17:90a:28e5:b0:213:566c:376e with SMTP id f92-20020a17090a28e500b00213566c376emr13043378pjd.96.1668413073771;
        Mon, 14 Nov 2022 00:04:33 -0800 (PST)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:40f1:682:170b:f25a])
        by smtp.gmail.com with ESMTPSA id u16-20020a170902e5d000b00186fb8f931asm6696799plf.206.2022.11.14.00.04.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 00:04:33 -0800 (PST)
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
Subject: [PATCH v4 1/3] drm_bridge: register content protect property
Date:   Mon, 14 Nov 2022 16:04:05 +0800
Message-Id: <20221114080405.2426999-1-hsinyi@chromium.org>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
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

Some bridges are able to update HDCP status from userspace request if
they support HDCP.

HDCP property is the same as other connector properties that needs to be
created after the connecter is initialized and before the connector is
registered.

If there exists a bridge that supports HDCP, add the property to the
bridge connector.

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
Reviewed-by: Sean Paul <seanpaul@chromium.org>
---
v3->v4: no change.
---
 drivers/gpu/drm/drm_bridge_connector.c | 8 ++++++++
 include/drm/drm_bridge.h               | 4 ++++
 2 files changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/drm_bridge_connector.c b/drivers/gpu/drm/drm_bridge_connector.c
index 1c7d936523df..b4fb5da0b963 100644
--- a/drivers/gpu/drm/drm_bridge_connector.c
+++ b/drivers/gpu/drm/drm_bridge_connector.c
@@ -7,6 +7,7 @@
 #include <linux/module.h>
 #include <linux/slab.h>
 
+#include <drm/display/drm_hdcp_helper.h>
 #include <drm/drm_atomic_state_helper.h>
 #include <drm/drm_bridge.h>
 #include <drm/drm_bridge_connector.h>
@@ -333,6 +334,7 @@ struct drm_connector *drm_bridge_connector_init(struct drm_device *drm,
 	struct i2c_adapter *ddc = NULL;
 	struct drm_bridge *bridge, *panel_bridge = NULL;
 	int connector_type;
+	bool support_hdcp = false;
 
 	bridge_connector = kzalloc(sizeof(*bridge_connector), GFP_KERNEL);
 	if (!bridge_connector)
@@ -376,6 +378,9 @@ struct drm_connector *drm_bridge_connector_init(struct drm_device *drm,
 
 		if (drm_bridge_is_panel(bridge))
 			panel_bridge = bridge;
+
+		if (bridge->support_hdcp)
+			support_hdcp = true;
 	}
 
 	if (connector_type == DRM_MODE_CONNECTOR_Unknown) {
@@ -398,6 +403,9 @@ struct drm_connector *drm_bridge_connector_init(struct drm_device *drm,
 	if (panel_bridge)
 		drm_panel_bridge_set_orientation(connector, panel_bridge);
 
+	if (support_hdcp && IS_ENABLED(CONFIG_DRM_DISPLAY_HDCP_HELPER))
+		drm_connector_attach_content_protection_property(connector, true);
+
 	return connector;
 }
 EXPORT_SYMBOL_GPL(drm_bridge_connector_init);
diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
index 6b65b0dfb4fb..1d2ab70f3436 100644
--- a/include/drm/drm_bridge.h
+++ b/include/drm/drm_bridge.h
@@ -768,6 +768,10 @@ struct drm_bridge {
 	 * modes.
 	 */
 	bool interlace_allowed;
+	/**
+	 * @support_hdcp: Indicate that the bridge supports HDCP.
+	 */
+	bool support_hdcp;
 	/**
 	 * @ddc: Associated I2C adapter for DDC access, if any.
 	 */
-- 
2.38.1.431.g37b22c650d-goog

