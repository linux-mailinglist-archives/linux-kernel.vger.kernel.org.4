Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E852969B9AB
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 12:17:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbjBRLRt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Feb 2023 06:17:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjBRLRr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Feb 2023 06:17:47 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C64E71E9C2
        for <linux-kernel@vger.kernel.org>; Sat, 18 Feb 2023 03:17:34 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id w1so623721plq.10
        for <linux-kernel@vger.kernel.org>; Sat, 18 Feb 2023 03:17:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s6dHGa2Xgzvsmpkv1OMI3GGLXSZg9rQflTYWwQPQ1MY=;
        b=JY77n9tlE/HK4ICl9GMTuT3xOecSN1t2rBwKN2r6bw9DpB3ugVZniqFJmEP/ZS6pdn
         FZrSdrEN79gLPWOMUK+L66wCzzs3r3Q8uln5PXzclN7b87DKiNVjqYU3DiNx/XLz0qPb
         Of7YZ4EvDZl+ErstHa8fMnpIbvTchMOkO2RII=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s6dHGa2Xgzvsmpkv1OMI3GGLXSZg9rQflTYWwQPQ1MY=;
        b=d+N0DN4XS8E4EOzpn3kOF0vwwG58DP3q4zknQ+mOo4HU0z3x/jzctrh6Qz+B2+G/TO
         GhCQK5cGellc0P5bqhTAMf9T+RaOb5NhcxImZzM528QprECEiW7T96v8rSnJWzicIxW7
         mgbztEoQCwJj2YXEOgz4TROCFv9ysMxcOlas69VG/bSD58/+6OvjKqpoQgmy6b4Jexv/
         3oariZ4Tr7h+oGWC5RblAwu0zRtbiob6JMMa1RMyps1mjuYHNSX4DGQnOhwY8cppS+NS
         x1zrmaLMctYecXMWxmB8xF2NfVtIr61UpPgqyIPb5kNxptwiiLmW8PvlCoEjFVmI1d2o
         sptQ==
X-Gm-Message-State: AO0yUKVKCWClOLlCmfOH+tBsoS7LYxuf+57qZvjtxWlR7eWxWShCfLde
        Cer8NpDFNcevxdsy9Mhog/Wsog==
X-Google-Smtp-Source: AK7set/hFbuR6/pwEBTsgMDjBxXuhNwX/DV7X+3lXNMmHiMnzFAlbjwwtNwH3GYu9AIwOZM3LSHFcw==
X-Received: by 2002:a05:6a20:4e27:b0:c6:858d:81b7 with SMTP id gk39-20020a056a204e2700b000c6858d81b7mr3115816pzb.25.1676719054085;
        Sat, 18 Feb 2023 03:17:34 -0800 (PST)
Received: from treapking.tpe.corp.google.com ([2401:fa00:1:10:88dd:be84:8f65:fec2])
        by smtp.gmail.com with ESMTPSA id 23-20020aa79157000000b005a8686b72fcsm4457829pfi.75.2023.02.18.03.17.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Feb 2023 03:17:33 -0800 (PST)
From:   Pin-yen Lin <treapking@chromium.org>
To:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Benson Leung <bleung@chromium.org>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        devicetree@vger.kernel.org,
        Nicolas Boichat <drinkcat@chromium.org>,
        chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
        Guenter Roeck <groeck@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        Pin-yen Lin <treapking@chromium.org>
Subject: [PATCH v3 2/5] drm/bridge: Add .get_edid callback for anx7688 driver
Date:   Sat, 18 Feb 2023 19:17:09 +0800
Message-Id: <20230218111712.2380225-3-treapking@chromium.org>
X-Mailer: git-send-email 2.39.2.637.g21b0678d19-goog
In-Reply-To: <20230218111712.2380225-1-treapking@chromium.org>
References: <20230218111712.2380225-1-treapking@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow the driver to read EDID when ddc-i2c-bus phandle is present in
the device node.

Signed-off-by: Pin-yen Lin <treapking@chromium.org>
---

Changes in v3:
- New in v3

 drivers/gpu/drm/bridge/cros-ec-anx7688.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/gpu/drm/bridge/cros-ec-anx7688.c b/drivers/gpu/drm/bridge/cros-ec-anx7688.c
index fa91bdeddef0..a16294c87940 100644
--- a/drivers/gpu/drm/bridge/cros-ec-anx7688.c
+++ b/drivers/gpu/drm/bridge/cros-ec-anx7688.c
@@ -6,6 +6,7 @@
  */
 
 #include <drm/drm_bridge.h>
+#include <drm/drm_edid.h>
 #include <drm/drm_print.h>
 #include <linux/i2c.h>
 #include <linux/module.h>
@@ -91,14 +92,24 @@ static bool cros_ec_anx7688_bridge_mode_fixup(struct drm_bridge *bridge,
 	return totalbw >= requiredbw;
 }
 
+static struct edid *cros_ec_anx7688_get_edid(struct drm_bridge *bridge,
+					     struct drm_connector *connector)
+{
+	struct cros_ec_anx7688 *anx7688 = bridge_to_cros_ec_anx7688(bridge);
+
+	return drm_get_edid(connector, anx7688->bridge.ddc);
+}
+
 static const struct drm_bridge_funcs cros_ec_anx7688_bridge_funcs = {
 	.mode_fixup = cros_ec_anx7688_bridge_mode_fixup,
+	.get_edid = cros_ec_anx7688_get_edid,
 };
 
 static int cros_ec_anx7688_bridge_probe(struct i2c_client *client)
 {
 	struct device *dev = &client->dev;
 	struct cros_ec_anx7688 *anx7688;
+	struct device_node *phandle;
 	u16 vendor, device, fw_version;
 	u8 buffer[4];
 	int ret;
@@ -153,6 +164,19 @@ static int cros_ec_anx7688_bridge_probe(struct i2c_client *client)
 		DRM_WARN("Old ANX7688 FW version (0x%04x), not filtering\n",
 			 fw_version);
 
+
+	phandle = of_parse_phandle(dev->of_node, "ddc-i2c-bus", 0);
+	if (phandle) {
+		anx7688->bridge.ddc = of_get_i2c_adapter_by_node(phandle);
+		of_node_put(phandle);
+		if (!anx7688->bridge.ddc)
+			return -EPROBE_DEFER;
+	} else {
+		dev_dbg(dev, "No I2C bus specified, disabling EDID readout\n");
+	}
+	if (anx7688->bridge.ddc)
+		anx7688->bridge.ops |= DRM_BRIDGE_OP_EDID;
+
 	anx7688->bridge.funcs = &cros_ec_anx7688_bridge_funcs;
 	drm_bridge_add(&anx7688->bridge);
 
-- 
2.39.2.637.g21b0678d19-goog

