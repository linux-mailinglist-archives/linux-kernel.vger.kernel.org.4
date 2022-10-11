Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53EBC5FB04C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 12:19:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbiJKKT2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 06:19:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbiJKKT0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 06:19:26 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6F116FA14
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 03:19:24 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id l1so12746794pld.13
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 03:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Yq/9loxiQhBqkMGuBqVSVER97PU6eqNrwXcwJJSQ4o8=;
        b=YQMKAEJu2Lqp0lr6XC66P8V857rodeAZ2poxsUDkoWg3pWPdvuULNzsOWa02Zg/92T
         lxqyY11dROObYQy7jaqYxhREieGrky1SSz0bgsk/fWFgWgEUq5QP5+M51hpDBdXo5izF
         GnXG6kwB2iRS53lBKhVLXKuhjjLlcNr/EMfqE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yq/9loxiQhBqkMGuBqVSVER97PU6eqNrwXcwJJSQ4o8=;
        b=Lig6pqUh0QoNSmp1V7K6B7AnMCelgH/aqMEJuNW5jTziPVaMg4pAO9yZZ7iqBzR3PH
         Gpmx+DDJPxZMm03RIqnf0xFuA901JkjwHN/pU9hsSvAhsEKbAB8EtkCxxiQBeoJvtThE
         JnSWESjHzK6CwFInjhzc+Q6s1Cy3OPrsykqEDJgjFyTPQ3EHT73yL31TRchUiyl6JXZL
         TzgTqCGl7sTshwTOLUaLhJWjhonopUrBebdh8A62tZL487qXd844JQ+2LpSwIYgB+8VA
         bMH2ZcJf31JSmOudoTQjDHGenu+gmEW8jI7fzGezMeIGKV73e9XuOZlXj2wvLTDG3AgM
         rGSg==
X-Gm-Message-State: ACrzQf06Ajo1F5WzXLu533zM1tu6jm99zK7qFaO1gzbb2lnO49Ny+kv1
        QYKQxtPyRQqgInROb5ELJR+jjQ==
X-Google-Smtp-Source: AMsMyM4LINEjb4g0hFCLAALDCXfaB3pcV4PVIko37wfdn2j6GQwmNRf85N9NgRqisdThg1hBRZsIyA==
X-Received: by 2002:a17:902:6a87:b0:181:c6c6:1d38 with SMTP id n7-20020a1709026a8700b00181c6c61d38mr12889488plk.74.1665483564107;
        Tue, 11 Oct 2022 03:19:24 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:31e6:a0c9:ff22:7e86])
        by smtp.gmail.com with ESMTPSA id y12-20020a17090a1f4c00b0020d75e90d32sm488402pjy.17.2022.10.11.03.19.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 03:19:23 -0700 (PDT)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     Douglas Anderson <dianders@chromium.org>,
        Sean Paul <seanpaul@chromium.org>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm_bridge: register content protect property
Date:   Tue, 11 Oct 2022 18:18:51 +0800
Message-Id: <20221011101850.200455-1-hsinyi@chromium.org>
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

Some bridges are able to update HDCP status from userspace requests if
they support HDCP.

HDCP property is the same as other connector properties that need to be
created after the connecter is initialized and before the connector is
registered.

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
 drivers/gpu/drm/drm_bridge_connector.c | 3 +++
 1 file changed, 3 insertions(+)

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
-- 
2.38.0.rc1.362.ged0d419d3c-goog

