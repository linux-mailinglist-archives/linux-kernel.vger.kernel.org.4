Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B758862D908
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 12:09:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239782AbiKQLJC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 06:09:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239721AbiKQLIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 06:08:15 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90D1213E12
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 03:08:09 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id j12so1300204plj.5
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 03:08:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0tqK0qcu4ZbXIz1FounyREg16LfpvMx9JNd0Tfa961A=;
        b=AFoBfEAD1nJWlMgLMnXn0vdIL+CPo94VWnV12a+S1YWYICb26F1Np8B8kTDn2QXh8v
         3MDzOYrdbhabqzws4QPDv8RY9mRvzvrHQTlp+AE1wWRhkwPQ4zHAz5NAx5NSPfZW3mQE
         TIKnnBeFktEgCF3rHIxA2KZt5ybmy93+PksJ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0tqK0qcu4ZbXIz1FounyREg16LfpvMx9JNd0Tfa961A=;
        b=GQQ5aG4/HB0TqYI3sJxwZKckIboJ3oV2k0rDWMglXdJevZSNBoSn86Hs8yA6Oag/EZ
         IgSjnQOt+8xRbmcmbv0ckw2Tu/oLX73XVdBCm2M8p72xEuJmNlDqdVd/MIDhrhbxOTwt
         TFVD9FbUtTEb/B0pCCgO0GAuZrIpX2N2n0C7FLi9NvscPt+IunOGKrP49t6WsrYdYS1r
         ai60lDyBoNhuWeZodNThpdgWe/rRXZBLGx2VPfgfmCr7Pc04gtfCzueGkSFmNrmD2lhR
         UMrTmHrT4ebjJ0G+BR3BBeOPzrJ5Gfre9mSQHZQyIWIHNObGYva+yT5tlPREhlIYqh3l
         3nPA==
X-Gm-Message-State: ANoB5pln5cfSbD4Oclv6qsCavBZuP6Xnbw/LYXXrr4oehkvtme+FcKRQ
        GxgnrXcgNcaScihj5IQbUNGRYg==
X-Google-Smtp-Source: AA0mqf4+GevadWvaves7De04ntMu+JYejX2ZKDF7Jns6C/cQy0CVatDlK3RNSm4xGN01xw2wzCaSaQ==
X-Received: by 2002:a17:90b:3544:b0:213:2173:f46a with SMTP id lt4-20020a17090b354400b002132173f46amr8259914pjb.103.1668683288952;
        Thu, 17 Nov 2022 03:08:08 -0800 (PST)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:e678:c7f5:9cb3:1a06])
        by smtp.gmail.com with ESMTPSA id z18-20020a170902ccd200b0017a032d7ae4sm1025540ple.104.2022.11.17.03.08.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 03:08:08 -0800 (PST)
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
Subject: [PATCH v6 1/3] drm_bridge: register content protect property
Date:   Thu, 17 Nov 2022 19:08:02 +0800
Message-Id: <20221117110804.1431024-1-hsinyi@chromium.org>
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
v5->v6: fix compile warning when CONFIG_DRM_DISPLAY_HELPER=m
---
 drivers/gpu/drm/drm_bridge_connector.c | 9 +++++++++
 include/drm/drm_bridge.h               | 4 ++++
 2 files changed, 13 insertions(+)

diff --git a/drivers/gpu/drm/drm_bridge_connector.c b/drivers/gpu/drm/drm_bridge_connector.c
index 1c7d936523df..4147c6240110 100644
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
@@ -398,6 +403,10 @@ struct drm_connector *drm_bridge_connector_init(struct drm_device *drm,
 	if (panel_bridge)
 		drm_panel_bridge_set_orientation(connector, panel_bridge);
 
+	if (support_hdcp && IS_REACHABLE(CONFIG_DRM_DISPLAY_HELPER) &&
+	    IS_ENABLED(CONFIG_DRM_DISPLAY_HDCP_HELPER))
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

