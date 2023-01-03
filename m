Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A508B65BDEA
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 11:21:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237352AbjACKUq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 05:20:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237337AbjACKU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 05:20:29 -0500
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51933F5A2;
        Tue,  3 Jan 2023 02:20:25 -0800 (PST)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 303AK4a3130179;
        Tue, 3 Jan 2023 04:20:04 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1672741204;
        bh=xCuASpEX//sSkPIviFrMBHGE8YdXB6rgi4nbVCJxXBI=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=nR+OYqRUv32oppIGnQkRmw+afuNAvQetp6aAJrRL0RXBUhc93MiWQMLZ8mMW6Q+QT
         EGhr7H+iQwnh88gjAfbDXc7B9nDeFmfmyVFWJMMTSYaNi0Z10wLGqaGQrlEKbpspsP
         ahl2Df7yH87TDFd9I+ZBSGU5P5o6WLUzhXB9Tnjo=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 303AK3b9028426
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 3 Jan 2023 04:20:04 -0600
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Tue, 3
 Jan 2023 04:20:03 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Tue, 3 Jan 2023 04:20:03 -0600
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 303AK1rY125602;
        Tue, 3 Jan 2023 04:20:02 -0600
From:   Rahul T R <r-ravikumar@ti.com>
To:     <dri-devel@lists.freedesktop.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <andrzej.hajda@intel.com>, <narmstrong@baylibre.com>,
        <robert.foss@linaro.org>, <jonas@kwiboo.se>,
        <jernej.skrabec@gmail.com>, <airlied@linux.ie>, <daniel@ffwll.ch>,
        <p.zabel@pengutronix.de>, <tomi.valkeinen@ideasonboard.com>,
        <laurent.pinchart@ideasonboard.com>,
        <linux-kernel@vger.kernel.org>, <jpawar@cadence.com>,
        <sjakhade@cadence.com>, <mparab@cadence.com>, <a-bhatia1@ti.com>,
        <devicetree@vger.kernel.org>, <vigneshr@ti.com>,
        <lee.jones@linaro.org>, Rahul T R <r-ravikumar@ti.com>
Subject: [PATCH v11 3/5] drm/bridge: cdns-dsi: Move to drm/bridge/cadence
Date:   Tue, 3 Jan 2023 15:49:49 +0530
Message-ID: <20230103101951.10963-4-r-ravikumar@ti.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230103101951.10963-1-r-ravikumar@ti.com>
References: <20230103101951.10963-1-r-ravikumar@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the cadence dsi bridge under drm/bridge/cadence directory, to
prepare for adding j721e wrapper support

Signed-off-by: Rahul T R <r-ravikumar@ti.com>
Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/gpu/drm/bridge/Kconfig                        | 11 -----------
 drivers/gpu/drm/bridge/Makefile                       |  1 -
 drivers/gpu/drm/bridge/cadence/Kconfig                | 11 +++++++++++
 drivers/gpu/drm/bridge/cadence/Makefile               |  2 ++
 .../bridge/{cdns-dsi.c => cadence/cdns-dsi-core.c}    |  0
 5 files changed, 13 insertions(+), 12 deletions(-)
 rename drivers/gpu/drm/bridge/{cdns-dsi.c => cadence/cdns-dsi-core.c} (100%)

diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
index 57946d80b02d..8b2226f72b24 100644
--- a/drivers/gpu/drm/bridge/Kconfig
+++ b/drivers/gpu/drm/bridge/Kconfig
@@ -15,17 +15,6 @@ config DRM_PANEL_BRIDGE
 menu "Display Interface Bridges"
 	depends on DRM && DRM_BRIDGE
 
-config DRM_CDNS_DSI
-	tristate "Cadence DPI/DSI bridge"
-	select DRM_KMS_HELPER
-	select DRM_MIPI_DSI
-	select DRM_PANEL_BRIDGE
-	select GENERIC_PHY_MIPI_DPHY
-	depends on OF
-	help
-	  Support Cadence DPI to DSI bridge. This is an internal
-	  bridge and is meant to be directly embedded in a SoC.
-
 config DRM_CHIPONE_ICN6211
 	tristate "Chipone ICN6211 MIPI-DSI/RGB Converter bridge"
 	depends on OF
diff --git a/drivers/gpu/drm/bridge/Makefile b/drivers/gpu/drm/bridge/Makefile
index 1884803c6860..52f6e8b4a821 100644
--- a/drivers/gpu/drm/bridge/Makefile
+++ b/drivers/gpu/drm/bridge/Makefile
@@ -1,5 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
-obj-$(CONFIG_DRM_CDNS_DSI) += cdns-dsi.o
 obj-$(CONFIG_DRM_CHIPONE_ICN6211) += chipone-icn6211.o
 obj-$(CONFIG_DRM_CHRONTEL_CH7033) += chrontel-ch7033.o
 obj-$(CONFIG_DRM_CROS_EC_ANX7688) += cros-ec-anx7688.o
diff --git a/drivers/gpu/drm/bridge/cadence/Kconfig b/drivers/gpu/drm/bridge/cadence/Kconfig
index 1d06182bea71..5f39859dcfdd 100644
--- a/drivers/gpu/drm/bridge/cadence/Kconfig
+++ b/drivers/gpu/drm/bridge/cadence/Kconfig
@@ -1,4 +1,15 @@
 # SPDX-License-Identifier: GPL-2.0-only
+config DRM_CDNS_DSI
+	tristate "Cadence DPI/DSI bridge"
+	select DRM_KMS_HELPER
+	select DRM_MIPI_DSI
+	select DRM_PANEL_BRIDGE
+	select GENERIC_PHY_MIPI_DPHY
+	depends on OF
+	help
+	  Support Cadence DPI to DSI bridge. This is an internal
+	  bridge and is meant to be directly embedded in a SoC.
+
 config DRM_CDNS_MHDP8546
 	tristate "Cadence DPI/DP bridge"
 	select DRM_DISPLAY_DP_HELPER
diff --git a/drivers/gpu/drm/bridge/cadence/Makefile b/drivers/gpu/drm/bridge/cadence/Makefile
index 4d2db8df1bc6..9e2f34c84480 100644
--- a/drivers/gpu/drm/bridge/cadence/Makefile
+++ b/drivers/gpu/drm/bridge/cadence/Makefile
@@ -1,4 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-only
+obj-$(CONFIG_DRM_CDNS_DSI) += cdns-dsi.o
+cdns-dsi-y := cdns-dsi-core.o
 obj-$(CONFIG_DRM_CDNS_MHDP8546) += cdns-mhdp8546.o
 cdns-mhdp8546-y := cdns-mhdp8546-core.o cdns-mhdp8546-hdcp.o
 cdns-mhdp8546-$(CONFIG_DRM_CDNS_MHDP8546_J721E) += cdns-mhdp8546-j721e.o
diff --git a/drivers/gpu/drm/bridge/cdns-dsi.c b/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
similarity index 100%
rename from drivers/gpu/drm/bridge/cdns-dsi.c
rename to drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
-- 
2.39.0

