Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 154686DB9F0
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Apr 2023 11:47:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbjDHJrw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Apr 2023 05:47:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbjDHJrt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Apr 2023 05:47:49 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 419BAD323;
        Sat,  8 Apr 2023 02:47:48 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-94a34a0baf9so20558666b.1;
        Sat, 08 Apr 2023 02:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680947267; x=1683539267;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0RkJjvXtF3VU1Cy+t8RIPMHhsvFn55qW4SFCevsbzn4=;
        b=UGvGMJosgQTVH39RakdelZpC0StnZ1PZzBWnxLzZ5og7/LerO1hbzhBlMR2Kf/3lTo
         1201BYL06Kqz6ITIir6mmEddV4v9rL8H5MpchofCos1n5Y4OU1U9Hf0oaqgPgXiLnPx1
         3UuZmTaP2G+57ZWPk1STLyNK4E9bOEQv4bzUz6Q4F4Be+OVUj7ZRV+YMoKNMFOCyvr6l
         QgKzjtaiR8jF/O/hL9lvLuw90i+g4ZtqpQ69hf6Cuu3ty/NMtqPaRBsggastVsrZrBK0
         MdxuRqsLKznfD28KXmgCMVT1WbYMPQ207LyLG2jnmR354/w0cFR283o9/sUge66jQx88
         om2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680947267; x=1683539267;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0RkJjvXtF3VU1Cy+t8RIPMHhsvFn55qW4SFCevsbzn4=;
        b=vi2n4E5pD71ixK3csDzZ9v9N0zNy7Uvuq2nXhCPt+aQ4mKU738c3ABHWmwG36/NwVr
         lhck4LvuwT2R6t1S8My1lgkACWOfNEz/FF7615P5r5iCQZU9ZXS6kZpBGxEnTPLN0bBY
         SEGRp9waIl0nw3QV21IIm4EGPUWwQMna/6bP27NA73tV+Kb+AItGz+veqimRhDWl3Mzb
         457A4P3lQ8YlMUCd4+e+eMuN8B+ibnvge1N3p/k6+axe4nl91bZKmWZGNrBRHvDBYvlD
         7t5XV6MAyhBYhRYarw78O9Tu71uKx/66ydNKEef6l2/PYvotTu9eYHuqY316V6S6v85R
         dm3w==
X-Gm-Message-State: AAQBX9d80Et0ACXWv0vSH926sXFKhxvMlyScfEJ4qXEsFOEcCiFtjqkU
        X5tZ7drk0VKbZZcdU4fvnVg=
X-Google-Smtp-Source: AKy350ZO1WTb+JMGVZ0B8YpfZnnHStqYVCirnT9BonVAubdsbktzssUGadzVx62Bdc94GSIK27wwag==
X-Received: by 2002:a50:ff13:0:b0:504:80f8:f6b2 with SMTP id a19-20020a50ff13000000b0050480f8f6b2mr2697563edu.25.1680947266484;
        Sat, 08 Apr 2023 02:47:46 -0700 (PDT)
Received: from xeon.. ([188.163.112.79])
        by smtp.gmail.com with ESMTPSA id a21-20020a50c315000000b0050481736f0csm982297edb.12.2023.04.08.02.47.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Apr 2023 02:47:46 -0700 (PDT)
From:   Svyatoslav Ryhel <clamor95@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Svyatoslav Ryhel <clamor95@gmail.com>,
        Maxim Schwalm <maxim.schwalm@gmail.com>,
        Dmitry Osipenko <digetx@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: [PATCH v1 1/2] drm/tegra: output: hdmi: Support bridge/connector
Date:   Sat,  8 Apr 2023 12:47:22 +0300
Message-Id: <20230408094723.12733-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230408094723.12733-1-clamor95@gmail.com>
References: <20230408094723.12733-1-clamor95@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Maxim Schwalm <maxim.schwalm@gmail.com>

Some Tegra device-trees may specify a video output graph, which involves
MHL bridge/simple bridge and/or connector framework. This patch adds
support for the bridge/connector attached to the HDMI output, allowing
us to model the hardware properly.

Inspired by: 29efdc2 ("drm/tegra: output: rgb: Support LVDS encoder bridge")

Tested-by: Andreas Westman Dorcsak <hedmoo@yahoo.com> # ASUS TF T30
Tested-by: Maxim Schwalm <maxim.schwalm@gmail.com> # ASUS P1801-T T30
Tested-by: Robert Eckelmann <longnoserob@gmail.com> # ASUS TF101 T20
Tested-by: Svyatoslav Ryhel <clamor95@gmail.com> # ASUS TF201 T30
Signed-off-by: Maxim Schwalm <maxim.schwalm@gmail.com>
Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/gpu/drm/tegra/hdmi.c | 44 +++++++++++++++++++++++++++---------
 1 file changed, 33 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/tegra/hdmi.c b/drivers/gpu/drm/tegra/hdmi.c
index 40ec3e6cf204..45b37b103785 100644
--- a/drivers/gpu/drm/tegra/hdmi.c
+++ b/drivers/gpu/drm/tegra/hdmi.c
@@ -19,6 +19,7 @@
 #include <soc/tegra/common.h>
 #include <sound/hdmi-codec.h>
 
+#include <drm/drm_bridge_connector.h>
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_crtc.h>
 #include <drm/drm_debugfs.h>
@@ -1544,26 +1545,47 @@ static int tegra_hdmi_init(struct host1x_client *client)
 {
 	struct tegra_hdmi *hdmi = host1x_client_to_hdmi(client);
 	struct drm_device *drm = dev_get_drvdata(client->host);
+	struct drm_connector *connector;
 	int err;
 
 	hdmi->output.dev = client->dev;
 
-	drm_connector_init_with_ddc(drm, &hdmi->output.connector,
-				    &tegra_hdmi_connector_funcs,
-				    DRM_MODE_CONNECTOR_HDMIA,
-				    hdmi->output.ddc);
-	drm_connector_helper_add(&hdmi->output.connector,
-				 &tegra_hdmi_connector_helper_funcs);
-	hdmi->output.connector.dpms = DRM_MODE_DPMS_OFF;
-
 	drm_simple_encoder_init(drm, &hdmi->output.encoder,
 				DRM_MODE_ENCODER_TMDS);
 	drm_encoder_helper_add(&hdmi->output.encoder,
 			       &tegra_hdmi_encoder_helper_funcs);
 
-	drm_connector_attach_encoder(&hdmi->output.connector,
-					  &hdmi->output.encoder);
-	drm_connector_register(&hdmi->output.connector);
+	if (hdmi->output.bridge) {
+		err = drm_bridge_attach(&hdmi->output.encoder, hdmi->output.bridge,
+					NULL, DRM_BRIDGE_ATTACH_NO_CONNECTOR);
+		if (err) {
+			dev_err(client->dev, "failed to attach bridge: %d\n",
+				err);
+			return err;
+		}
+
+		connector = drm_bridge_connector_init(drm, &hdmi->output.encoder);
+		if (IS_ERR(connector)) {
+			dev_err(client->dev,
+				"failed to initialize bridge connector: %pe\n",
+				connector);
+			return PTR_ERR(connector);
+		}
+
+		drm_connector_attach_encoder(connector, &hdmi->output.encoder);
+	} else {
+		drm_connector_init_with_ddc(drm, &hdmi->output.connector,
+					    &tegra_hdmi_connector_funcs,
+					    DRM_MODE_CONNECTOR_HDMIA,
+					    hdmi->output.ddc);
+		drm_connector_helper_add(&hdmi->output.connector,
+					 &tegra_hdmi_connector_helper_funcs);
+		hdmi->output.connector.dpms = DRM_MODE_DPMS_OFF;
+
+		drm_connector_attach_encoder(&hdmi->output.connector,
+					     &hdmi->output.encoder);
+		drm_connector_register(&hdmi->output.connector);
+	}
 
 	err = tegra_output_init(drm, &hdmi->output);
 	if (err < 0) {
-- 
2.37.2

