Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DF5A6E2819
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 18:11:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbjDNQLe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 12:11:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbjDNQLb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 12:11:31 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A404B8A53
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 09:11:30 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <jzi@pengutronix.de>)
        id 1pnM1A-00049P-QL; Fri, 14 Apr 2023 18:11:21 +0200
Received: from [2a0a:edc0:0:1101:1d::39] (helo=dude03.red.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <jzi@pengutronix.de>)
        id 1pnM19-00BEra-Ci; Fri, 14 Apr 2023 18:11:19 +0200
Received: from jzi by dude03.red.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <jzi@pengutronix.de>)
        id 1pnM18-00FQvp-Id; Fri, 14 Apr 2023 18:11:18 +0200
From:   Johannes Zink <j.zink@pengutronix.de>
To:     thierry.reding@gmail.com, sam@ravnborg.org, airlied@gmail.com,
        daniel@ffwll.ch, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
Cc:     Johannes Zink <j.zink@pengutronix.de>
Subject: [PATCH 2/2] drm/panel-simple: allow LVDS format override
Date:   Fri, 14 Apr 2023 18:11:16 +0200
Message-Id: <20230414161116.3673911-3-j.zink@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230414161116.3673911-1-j.zink@pengutronix.de>
References: <20230414161116.3673911-1-j.zink@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: jzi@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some panels support multiple LVDS data mapping formats, which can be
used e.g. run displays on jeida-18 format when only 3 LVDS lanes are
available.

Add parsing of an optional data-mapping devicetree property, which also
touches up the bits per color to match the bus format.

Signed-off-by: Johannes Zink <j.zink@pengutronix.de>
---
 drivers/gpu/drm/panel/panel-simple.c | 37 +++++++++++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index 065f378bba9d..7366ad13b3f1 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -40,6 +40,7 @@
 #include <drm/drm_edid.h>
 #include <drm/drm_mipi_dsi.h>
 #include <drm/drm_panel.h>
+#include <drm/drm_of.h>
 
 /**
  * struct panel_desc - Describes a simple panel.
@@ -559,7 +560,7 @@ static int panel_simple_probe(struct device *dev, const struct panel_desc *desc)
 	struct device_node *ddc;
 	int connector_type;
 	u32 bus_flags;
-	int err;
+	int err, ret;
 
 	panel = devm_kzalloc(dev, sizeof(*panel), GFP_KERNEL);
 	if (!panel)
@@ -605,6 +606,40 @@ static int panel_simple_probe(struct device *dev, const struct panel_desc *desc)
 			panel_simple_parse_panel_timing_node(dev, panel, &dt);
 	}
 
+
+	/* optional data-mapping property for overriding bus format */
+	ret = drm_of_lvds_get_data_mapping(dev->of_node);
+	if (ret == -EINVAL) {
+		dev_warn(dev, "Ignore invalid data-mapping property");
+	} else if (ret != -ENODEV) {
+		int bpc;
+
+		switch (ret) {
+		default:
+			WARN_ON(1);
+			fallthrough;
+		case MEDIA_BUS_FMT_RGB888_1X7X4_SPWG:
+			fallthrough;
+		case MEDIA_BUS_FMT_RGB888_1X7X4_JEIDA:
+			bpc = 8;
+			break;
+		case MEDIA_BUS_FMT_RGB666_1X7X3_SPWG:
+			bpc = 6;
+		}
+
+		if (desc->bpc != bpc || desc->bus_format != ret) {
+			struct panel_desc *override_desc;
+
+			override_desc = devm_kmemdup(dev, desc, sizeof(*desc), GFP_KERNEL);
+			if (!override_desc)
+				return -ENOMEM;
+
+			override_desc->bus_format = ret;
+			override_desc->bpc = bpc;
+			panel->desc = override_desc;
+		}
+	}
+
 	connector_type = desc->connector_type;
 	/* Catch common mistakes for panels. */
 	switch (connector_type) {
-- 
2.39.2

