Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E44C6135E4
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 13:20:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231350AbiJaMU1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 08:20:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231337AbiJaMUB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 08:20:01 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D8A0F6A;
        Mon, 31 Oct 2022 05:20:01 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 29VCJXdi052992;
        Mon, 31 Oct 2022 07:19:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1667218773;
        bh=GiNjoUYPd2sq/j3p9U/hpIawiy/hEqNxOJWdzMjdOcU=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=DM3r2a5S3H98LBwnBHHm0hrnWFWfIqsOkYaGBrO72HjmzMuqw4avO5E+KgSa3SKl4
         MPpsTlhPxIKxxlDo/tLe1JGkgo1V2EHIvkJ3ZRUW3PcQs+yf8HSZ09v5B/8Q5xmi5v
         2w9tH1543fuYsXSZdH0DAYGRPTRKQIRJKwFdfmBY=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 29VCJXGW041830
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 31 Oct 2022 07:19:33 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Mon, 31
 Oct 2022 07:19:32 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Mon, 31 Oct 2022 07:19:32 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 29VCJVZo061317;
        Mon, 31 Oct 2022 07:19:32 -0500
From:   Rahul T R <r-ravikumar@ti.com>
To:     <dri-devel@lists.freedesktop.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <tomi.valkeinen@ideasonboard.com>
CC:     <andrzej.hajda@intel.com>, <narmstrong@baylibre.com>,
        <robert.foss@linaro.org>, <jonas@kwiboo.se>,
        <jernej.skrabec@gmail.com>, <airlied@linux.ie>, <daniel@ffwll.ch>,
        <p.zabel@pengutronix.de>, <laurent.pinchart@ideasonboard.com>,
        <linux-kernel@vger.kernel.org>, <jpawar@cadence.com>,
        <sjakhade@cadence.com>, <mparab@cadence.com>, <a-bhatia1@ti.com>,
        <devicetree@vger.kernel.org>, <vigneshr@ti.com>,
        <lee.jones@linaro.org>, Rahul T R <r-ravikumar@ti.com>
Subject: [PATCH v9 3/5] drm/bridge: cdns-dsi: Move to drm/bridge/cadence
Date:   Mon, 31 Oct 2022 17:49:22 +0530
Message-ID: <20221031121924.29974-4-r-ravikumar@ti.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221031121924.29974-1-r-ravikumar@ti.com>
References: <20221031121924.29974-1-r-ravikumar@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the cadence dsi bridge under drm/bridge/cadence
directory, to prepare for adding j721e wrapper
support

Signed-off-by: Rahul T R <r-ravikumar@ti.com>
Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
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
index 1d06182bea71..8fbb46c66094 100644
--- a/drivers/gpu/drm/bridge/cadence/Kconfig
+++ b/drivers/gpu/drm/bridge/cadence/Kconfig
@@ -25,3 +25,14 @@ config DRM_CDNS_MHDP8546_J721E
 	  initializes the J721E Display Port and sets up the
 	  clock and data muxes.
 endif
+
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
diff --git a/drivers/gpu/drm/bridge/cadence/Makefile b/drivers/gpu/drm/bridge/cadence/Makefile
index 4d2db8df1bc6..e3d8e9a40784 100644
--- a/drivers/gpu/drm/bridge/cadence/Makefile
+++ b/drivers/gpu/drm/bridge/cadence/Makefile
@@ -2,3 +2,5 @@
 obj-$(CONFIG_DRM_CDNS_MHDP8546) += cdns-mhdp8546.o
 cdns-mhdp8546-y := cdns-mhdp8546-core.o cdns-mhdp8546-hdcp.o
 cdns-mhdp8546-$(CONFIG_DRM_CDNS_MHDP8546_J721E) += cdns-mhdp8546-j721e.o
+obj-$(CONFIG_DRM_CDNS_DSI) += cdns-dsi.o
+cdns-dsi-y := cdns-dsi-core.o
diff --git a/drivers/gpu/drm/bridge/cdns-dsi.c b/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
similarity index 100%
rename from drivers/gpu/drm/bridge/cdns-dsi.c
rename to drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
-- 
2.38.0

