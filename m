Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39C73739D52
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 11:33:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231663AbjFVJbi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 05:31:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232369AbjFVJ3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 05:29:55 -0400
Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [IPv6:2a02:1800:110:4::f00:19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 549D24ECF
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 02:22:47 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed20:991a:a831:ea4b:6058])
        by laurent.telenet-ops.be with bizsmtp
        id C9Nj2A00b1yfRTD019Njlh; Thu, 22 Jun 2023 11:22:43 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qCGWX-000Bwe-TC;
        Thu, 22 Jun 2023 11:22:43 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qCGWZ-003VxJ-GO;
        Thu, 22 Jun 2023 11:22:43 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Magnus Damm <magnus.damm@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 22/39] drm: renesas: shmobile: Use media bus formats in platform data
Date:   Thu, 22 Jun 2023 11:21:34 +0200
Message-Id: <3599b9ee249afea0e5b5ced45ab3523e17503d31.1687423204.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1687423204.git.geert+renesas@glider.be>
References: <cover.1687423204.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the custom shmob_drm_interface enumeration values with standard
media bus formats.  This simplifies driver handling of bus formats and
prepares for DT support.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 .../gpu/drm/renesas/shmobile/shmob_drm_drv.c  | 52 +++++++++++++------
 include/linux/platform_data/shmob_drm.h       | 13 +----
 2 files changed, 38 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/renesas/shmobile/shmob_drm_drv.c b/drivers/gpu/drm/renesas/shmobile/shmob_drm_drv.c
index 1a1d66c6e817e227..e5be0ae99bd970be 100644
--- a/drivers/gpu/drm/renesas/shmobile/shmob_drm_drv.c
+++ b/drivers/gpu/drm/renesas/shmobile/shmob_drm_drv.c
@@ -9,6 +9,7 @@
 
 #include <linux/clk.h>
 #include <linux/io.h>
+#include <linux/media-bus-format.h>
 #include <linux/mm.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
@@ -34,24 +35,45 @@
 
 static int shmob_drm_init_interface(struct shmob_drm_device *sdev)
 {
-	static const u32 ldmt1r[] = {
-		[SHMOB_DRM_IFACE_RGB8] = LDMT1R_MIFTYP_RGB8,
-		[SHMOB_DRM_IFACE_RGB9] = LDMT1R_MIFTYP_RGB9,
-		[SHMOB_DRM_IFACE_RGB12A] = LDMT1R_MIFTYP_RGB12A,
-		[SHMOB_DRM_IFACE_RGB12B] = LDMT1R_MIFTYP_RGB12B,
-		[SHMOB_DRM_IFACE_RGB16] = LDMT1R_MIFTYP_RGB16,
-		[SHMOB_DRM_IFACE_RGB18] = LDMT1R_MIFTYP_RGB18,
-		[SHMOB_DRM_IFACE_RGB24] = LDMT1R_MIFTYP_RGB24,
-		[SHMOB_DRM_IFACE_YUV422] = LDMT1R_MIFTYP_YCBCR,
-	};
-
-	if (sdev->pdata->iface.interface >= ARRAY_SIZE(ldmt1r)) {
-		dev_err(sdev->dev, "invalid interface type %u\n",
-			sdev->pdata->iface.interface);
+	switch (sdev->pdata->iface.bus_fmt) {
+	case MEDIA_BUS_FMT_RGB888_3X8:
+		sdev->ldmt1r = LDMT1R_MIFTYP_RGB8;
+		break;
+
+	case MEDIA_BUS_FMT_RGB666_2X9_BE:
+		sdev->ldmt1r = LDMT1R_MIFTYP_RGB9;
+		break;
+
+	case MEDIA_BUS_FMT_RGB888_2X12_BE:
+		sdev->ldmt1r = LDMT1R_MIFTYP_RGB12A;
+		break;
+
+	case MEDIA_BUS_FMT_RGB444_1X12:
+		sdev->ldmt1r = LDMT1R_MIFTYP_RGB12B;
+		break;
+
+	case MEDIA_BUS_FMT_RGB565_1X16:
+		sdev->ldmt1r = LDMT1R_MIFTYP_RGB16;
+		break;
+
+	case MEDIA_BUS_FMT_RGB666_1X18:
+		sdev->ldmt1r = LDMT1R_MIFTYP_RGB18;
+		break;
+
+	case MEDIA_BUS_FMT_RGB888_1X24:
+		sdev->ldmt1r = LDMT1R_MIFTYP_RGB24;
+		break;
+
+	case MEDIA_BUS_FMT_UYVY8_1X16:
+		sdev->ldmt1r = LDMT1R_MIFTYP_YCBCR;
+		break;
+
+	default:
+		dev_err(sdev->dev, "invalid bus format 0x%x\n",
+			sdev->pdata->iface.bus_fmt);
 		return -EINVAL;
 	}
 
-	sdev->ldmt1r = ldmt1r[sdev->pdata->iface.interface];
 	return 0;
 }
 
diff --git a/include/linux/platform_data/shmob_drm.h b/include/linux/platform_data/shmob_drm.h
index f3cb19ff9f818aca..5047e66f0a6823ba 100644
--- a/include/linux/platform_data/shmob_drm.h
+++ b/include/linux/platform_data/shmob_drm.h
@@ -18,17 +18,6 @@ enum shmob_drm_clk_source {
 	SHMOB_DRM_CLK_EXTERNAL,
 };
 
-enum shmob_drm_interface {
-	SHMOB_DRM_IFACE_RGB8,		/* 24bpp, 8:8:8 */
-	SHMOB_DRM_IFACE_RGB9,		/* 18bpp, 9:9 */
-	SHMOB_DRM_IFACE_RGB12A,		/* 24bpp, 12:12 */
-	SHMOB_DRM_IFACE_RGB12B,		/* 12bpp */
-	SHMOB_DRM_IFACE_RGB16,		/* 16bpp */
-	SHMOB_DRM_IFACE_RGB18,		/* 18bpp */
-	SHMOB_DRM_IFACE_RGB24,		/* 24bpp */
-	SHMOB_DRM_IFACE_YUV422,		/* 16bpp */
-};
-
 struct shmob_drm_panel_data {
 	unsigned int width_mm;		/* Panel width in mm */
 	unsigned int height_mm;		/* Panel height in mm */
@@ -36,7 +25,7 @@ struct shmob_drm_panel_data {
 };
 
 struct shmob_drm_interface_data {
-	enum shmob_drm_interface interface;
+	unsigned int bus_fmt;		/* MEDIA_BUS_FMT_RGB888_* */
 	unsigned int clk_div;
 };
 
-- 
2.34.1

