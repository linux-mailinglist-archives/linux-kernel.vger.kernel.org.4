Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7BA45FBFDC
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 06:21:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbiJLEVE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 00:21:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbiJLEVA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 00:21:00 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 285766AEA5
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 21:20:59 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id n18-20020a17090ade9200b0020b0012097cso2892528pjv.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 21:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=99TdLCDiLCw1CKOLf2kqVlfCC+0M09AdfWZjON605rQ=;
        b=eztaR/oo+aVk7T4AjXlFgAUpkTdV8XUnPmBWH+GoE8TXoFcNI+OmgXPSMCm2ybcDXR
         nGpi0qlIsI+mSCfo7KdWfC0YB87LaAUaEIF/LTYpnZ7E7gxvcxFTynmlbSRzFPuepaUD
         kCJk0ovkpadyJkkW3u3JO/EfzpKXYDaRGr9sY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=99TdLCDiLCw1CKOLf2kqVlfCC+0M09AdfWZjON605rQ=;
        b=a6HgSJ1cp5Pp+zVuJrXeykn+3VFTP2rBPXq1qzKnAW8hVSjPZ74mioqRzYcVR20zrY
         YIqxsuW9LCd7GUja0NxBF8daxfgfMPla/g986IgqaO2N64dB+HbJA2yTZ+g9zIo2fPqb
         08Lp9wGapPYTFQnLz5TPxDGYliEbowEW/wscJsGv6Ps5mizQTVyEJbDvCR1fTKjIZkWY
         Oodj76YNTSLciOY1wg+WTpgbnrD4GHNLSMI5QZkLEqDxPY9xGfZJiuyw0rhNlzT/IegD
         EoYSW7KOpJM06PVR221qpRamjBcWHCw2VlivzT6THBJOIIocGuo4ID+AqON4Ddqh8RTn
         q1/w==
X-Gm-Message-State: ACrzQf2lnRCI+qCejtGXBtbtT5zFTF0NzJNxkffnmWqj5fo9jMqqaWUo
        ew0W5t8iORSKgQ8Oo2DqvaflriIDOaKIYQ==
X-Google-Smtp-Source: AMsMyM47l4acst/sR04DCSeFadKyk5MwSU4caq5gnpulOX6YhUk2+D/6OnMS067g5lBoK+dyJezIeg==
X-Received: by 2002:a17:90a:db54:b0:209:e4e4:9344 with SMTP id u20-20020a17090adb5400b00209e4e49344mr2859123pjx.62.1665548458546;
        Tue, 11 Oct 2022 21:20:58 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:31e6:a0c9:ff22:7e86])
        by smtp.gmail.com with ESMTPSA id 131-20020a621989000000b00561969ea721sm10121806pfz.147.2022.10.11.21.20.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 21:20:58 -0700 (PDT)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     Douglas Anderson <dianders@chromium.org>,
        Sean Paul <seanpaul@chromium.org>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] drm_bridge: register content protect property
Date:   Wed, 12 Oct 2022 12:20:31 +0800
Message-Id: <20221012042030.573466-1-hsinyi@chromium.org>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
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

HDCP property is the same as other connector properties that need to be
created after the connecter is initialized and before the connector is
registered.

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
Reported-by: kernel test robot <lkp@intel.com>
---
v2: Fix compile error when config is not set.
---
 drivers/gpu/drm/drm_bridge_connector.c | 3 +++
 include/drm/display/drm_hdcp_helper.h  | 8 ++++++++
 2 files changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/drm_bridge_connector.c b/drivers/gpu/drm/drm_bridge_connector.c
index 1c7d936523df5..a3b9ef8dc3f0b 100644
--- a/drivers/gpu/drm/drm_bridge_connector.c
+++ b/drivers/gpu/drm/drm_bridge_connector.c
@@ -7,6 +7,7 @@
 #include <linux/module.h>
 #include <linux/slab.h>
 
+#include <drm/display/drm_hdcp_helper.h>
 #include <drm/drm_atomic_state_helper.h>
 #include <drm/drm_bridge.h>
 #include <drm/drm_bridge_connector.h>
@@ -398,6 +399,8 @@ struct drm_connector *drm_bridge_connector_init(struct drm_device *drm,
 	if (panel_bridge)
 		drm_panel_bridge_set_orientation(connector, panel_bridge);
 
+	drm_connector_attach_content_protection_property(connector, true);
+
 	return connector;
 }
 EXPORT_SYMBOL_GPL(drm_bridge_connector_init);
diff --git a/include/drm/display/drm_hdcp_helper.h b/include/drm/display/drm_hdcp_helper.h
index 8aaf87bf27351..c65d9f06a2532 100644
--- a/include/drm/display/drm_hdcp_helper.h
+++ b/include/drm/display/drm_hdcp_helper.h
@@ -15,8 +15,16 @@ struct drm_device;
 struct drm_connector;
 
 int drm_hdcp_check_ksvs_revoked(struct drm_device *dev, u8 *ksvs, u32 ksv_count);
+#if defined(CONFIG_DRM_DISPLAY_HDCP_HELPER)
 int drm_connector_attach_content_protection_property(struct drm_connector *connector,
 						     bool hdcp_content_type);
+#else
+static inline int drm_connector_attach_content_protection_property(struct drm_connector *connector,
+								   bool hdcp_content_type)
+{
+	return 0;
+}
+#endif
 void drm_hdcp_update_content_protection(struct drm_connector *connector, u64 val);
 
 #endif
-- 
2.38.0.rc1.362.ged0d419d3c-goog

