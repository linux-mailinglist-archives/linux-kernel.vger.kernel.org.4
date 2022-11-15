Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01C3D6291D8
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 07:29:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232222AbiKOG27 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 01:28:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232085AbiKOG2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 01:28:42 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FA67CEA
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 22:28:41 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id o13so12400393pgu.7
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 22:28:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jYF/Js/yiLI83Zy9sWN0PENTbwz1/nvxpqAaN81AAww=;
        b=Po3X0rFRnkmXUSuWki6spsmGHe32wlGY0z2bgPRVq1Tc0tzYKF81Dga33krFcwc8yL
         OCWKk6lm+vccRWTPaB55QNVqzfiWma0lZ3lbY3jrh7cucnDby7HfBBf4RIdNWCnWIrX7
         TTh8Ka5JMep8/45EfFJJbpgNaNQlUgtO0eTOw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jYF/Js/yiLI83Zy9sWN0PENTbwz1/nvxpqAaN81AAww=;
        b=gBg5HlPwoLE7QNJsVzliuZlUKO/UaHZSOUSXDWVY1vtPiP/76E8LCdhl/wYVxIJHZu
         7Vy1MdKKWdMGXXuSiDrNGxpdX9W24JqUMHoySyUqqmwbf46eQmpGJQ6l0ueF3o8LcQYp
         SNE/nY0hPDtVZ53WOdyDAV0cEqeaGizyxYSr5yFRpHnPTAbKI2XJOi+2yKAi/6KoMyx3
         EocrDO+f06NzVTkxnkeqo1Daf/ZOCbhRfIH/yCoTKAEE+Ec7vZV209jFc04nQooJWQz2
         wVBpnyE8LuXNo6DHFFyiXmQO+T1gem94geAFXYwk3SG/72xefsuZ4squhl5raUrTnLz2
         2v+g==
X-Gm-Message-State: ANoB5pkGiytYvjFyCw+UQQTlu+jN3/8gBKouxehZy4MBLHA4L8Bnzrjw
        T7ridZgyLPG0EylvCO1Q8ySk6w==
X-Google-Smtp-Source: AA0mqf4IzV4EzwB6ZQ4gSGDn464H2Neoh21HBw+xWWP6tLmPn0yV5GZ2OwSsUT5D0Vuc4ME2acH77w==
X-Received: by 2002:a63:eb4e:0:b0:45f:f8df:108e with SMTP id b14-20020a63eb4e000000b0045ff8df108emr14451107pgk.127.1668493720852;
        Mon, 14 Nov 2022 22:28:40 -0800 (PST)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:17d2:e181:950d:967a])
        by smtp.gmail.com with ESMTPSA id b22-20020a630c16000000b004351358f056sm6956372pgl.85.2022.11.14.22.28.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 22:28:40 -0800 (PST)
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
Subject: [PATCH v5 1/3] drm_bridge: register content protect property
Date:   Tue, 15 Nov 2022 14:28:33 +0800
Message-Id: <20221115062835.3785083-1-hsinyi@chromium.org>
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
Reported-by: kernel test robot <lkp@intel.com>
---
v4->v5: fix compile warning when CONFIG_DRM_DISPLAY_HELPER=m
---
 drivers/gpu/drm/drm_bridge_connector.c | 8 ++++++++
 include/drm/drm_bridge.h               | 4 ++++
 2 files changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/drm_bridge_connector.c b/drivers/gpu/drm/drm_bridge_connector.c
index 1c7d936523df..16d038c2982f 100644
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
 
+	if (support_hdcp && IS_REACHABLE(CONFIG_DRM_DISPLAY_HDCP_HELPER))
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

