Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF93061618E
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 12:14:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230435AbiKBLNQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 07:13:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiKBLNG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 07:13:06 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39E7F27177
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 04:12:53 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id y203so1967843pfb.4
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 04:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=m6/hZVhtIbefUcknBjEFg5/f3s1Nad05i+KmCMBOS8c=;
        b=hLqMyKDmts+cb/C7xAVLTNi71pVTv0NmTjToGpyRqd3vLx6TVav4fQClcyMCmXKQ+M
         V0QchhfeV47Z7tL2eUrc/PnSv1h5PRFm0jfFOGKDt7ZV307lBwFKobmmgCXtmyh7wdiY
         ZlH0wfU8MoQKyZG6ENvTSh9ZDEX09jvMX9ZbA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m6/hZVhtIbefUcknBjEFg5/f3s1Nad05i+KmCMBOS8c=;
        b=6o1dWL/D6gmdv/y9YY++A7SGPfBiUEubmvcm4qRA4mblhq8+b+FmiQ8C2TV2X0wsdd
         KN5dKPDIZhBf8+yz7bFjMonM224ZiLsLuB6NnTacBem7f+BwOeOUD2LTYRSnvS115+Je
         OsvcfVX+RAgP7lDAmf+OCYBoJHKvSaPnQu68P+thfjYmyIJONmq5nTLof0sGMqnH2IXl
         kiJODYQl2v3P4GfMmlLh3ms9MHzWnzs1932z2Sab5uoTsSsKvwAVcFvWsdw14RX27unt
         oVMrzUz/vT1LefdxftVtA5ratq3RoN9l7UyaD6RHjhQ4lW4LktSlL6Wd1mfsMg3CWEuS
         kK2w==
X-Gm-Message-State: ACrzQf0fa13+G5SldXiab+pHcFzgJ/790qlWOZ3d4LdEIEpEUiYA5yWJ
        DY66B53uJ1g2RbnffR+ygBtfgg==
X-Google-Smtp-Source: AMsMyM6Crxni0oCe3e5f5hJnN9Mt/qV0mM6bqwpX26il1/YGroybGY392gEGIreOiMD6whQbfwU8FQ==
X-Received: by 2002:a05:6a00:230f:b0:53e:2c2c:5c03 with SMTP id h15-20020a056a00230f00b0053e2c2c5c03mr24447199pfh.11.1667387512828;
        Wed, 02 Nov 2022 04:11:52 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:c30f:38e9:6ba:158b])
        by smtp.gmail.com with ESMTPSA id z20-20020aa79f94000000b0056246403534sm8251048pfr.88.2022.11.02.04.11.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 04:11:52 -0700 (PDT)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     Douglas Anderson <dianders@chromium.org>,
        Sean Paul <seanpaul@chromium.org>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] drm_bridge: register content protect property
Date:   Wed,  2 Nov 2022 19:11:46 +0800
Message-Id: <20221102111148.1810314-1-hsinyi@chromium.org>
X-Mailer: git-send-email 2.38.0.135.g90850a2211-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
---
v2->v3:
Only register the property when there exists any bridge that supports
hdcp.
---
 drivers/gpu/drm/drm_bridge_connector.c | 8 ++++++++
 include/drm/drm_bridge.h               | 4 ++++
 2 files changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/drm_bridge_connector.c b/drivers/gpu/drm/drm_bridge_connector.c
index 1c7d936523df5..b4fb5da0b963f 100644
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
index 6b65b0dfb4fb4..1d2ab70f3436a 100644
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
2.38.0.135.g90850a2211-goog

