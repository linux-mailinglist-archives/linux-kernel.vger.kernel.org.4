Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC0596A2FEC
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 15:19:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbjBZOTV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 09:19:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbjBZOTR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 09:19:17 -0500
X-Greylist: delayed 461 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 26 Feb 2023 06:19:15 PST
Received: from forward105j.mail.yandex.net (forward105j.mail.yandex.net [5.45.198.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE98D975D
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 06:19:15 -0800 (PST)
Received: from iva2-656890eaceb5.qloud-c.yandex.net (iva2-656890eaceb5.qloud-c.yandex.net [IPv6:2a02:6b8:c0c:6902:0:640:6568:90ea])
        by forward105j.mail.yandex.net (Yandex) with ESMTP id AD4604EC894E;
        Sun, 26 Feb 2023 17:11:26 +0300 (MSK)
Received: by iva2-656890eaceb5.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id tATvDFdaca61-3BIj2fmR;
        Sun, 26 Feb 2023 17:11:25 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lach.pw; s=mail; t=1677420686;
        bh=WCeZwLUOEBKexfa/7u2+rQMXS0gvx0CaGysSJoeK89Q=;
        h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
        b=XB+45PhK8q59oOnfG2pxmN0+6rYNEUdPO4jgO5jZKH8wbkpiNICukBKb01jjQOb7r
         wnoKOvNmZFrZusvgfuKJMonK5nQF6q7Q7658XWAdPKJOsp2YdaO07CT+nEfhX0FjVV
         1ybZR9if96vPutvx8UI9fCwa/QvfPrQ9dLEK8LiM=
Authentication-Results: iva2-656890eaceb5.qloud-c.yandex.net; dkim=pass header.i=@lach.pw
From:   Yaroslav Bolyukin <iam@lach.pw>
To:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Jani Nikula <jani.nikula@intel.com>,
        Yaroslav Bolyukin <iam@lach.pw>
Subject: [PATCH v3 1/2] drm/edid: parse DRM VESA dsc bpp target
Date:   Sun, 26 Feb 2023 15:10:50 +0100
Message-Id: <20230226141051.21767-2-iam@lach.pw>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230226141051.21767-1-iam@lach.pw>
References: <20230226141051.21767-1-iam@lach.pw>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As per DisplayID v2.0 Errata E9 spec "DSC pass-through timing support"
VESA vendor-specific data block may contain target DSC bits per pixel
fields

Signed-off-by: Yaroslav Bolyukin <iam@lach.pw>
---
 drivers/gpu/drm/drm_edid.c  | 38 +++++++++++++++++++++++++------------
 include/drm/drm_connector.h |  6 ++++++
 include/drm/drm_displayid.h |  4 ++++
 3 files changed, 36 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
index 3d0a4da661bc..aa88ac82cbe0 100644
--- a/drivers/gpu/drm/drm_edid.c
+++ b/drivers/gpu/drm/drm_edid.c
@@ -6338,7 +6338,7 @@ static void drm_parse_vesa_mso_data(struct drm_connector *connector,
 	if (oui(vesa->oui[0], vesa->oui[1], vesa->oui[2]) != VESA_IEEE_OUI)
 		return;
 
-	if (sizeof(*vesa) != sizeof(*block) + block->num_bytes) {
+	if (block->num_bytes < 5) {
 		drm_dbg_kms(connector->dev,
 			    "[CONNECTOR:%d:%s] Unexpected VESA vendor block size\n",
 			    connector->base.id, connector->name);
@@ -6361,24 +6361,37 @@ static void drm_parse_vesa_mso_data(struct drm_connector *connector,
 		break;
 	}
 
-	if (!info->mso_stream_count) {
-		info->mso_pixel_overlap = 0;
-		return;
-	}
+	info->mso_pixel_overlap = 0;
+
+	if (info->mso_stream_count) {
+		info->mso_pixel_overlap = FIELD_GET(DISPLAYID_VESA_MSO_OVERLAP, vesa->mso);
+
+		if (info->mso_pixel_overlap > 8) {
+			drm_dbg_kms(connector->dev,
+				    "[CONNECTOR:%d:%s] Reserved MSO pixel overlap value %u\n",
+				    connector->base.id, connector->name,
+				    info->mso_pixel_overlap);
+			info->mso_pixel_overlap = 8;
+		}
 
-	info->mso_pixel_overlap = FIELD_GET(DISPLAYID_VESA_MSO_OVERLAP, vesa->mso);
-	if (info->mso_pixel_overlap > 8) {
 		drm_dbg_kms(connector->dev,
-			    "[CONNECTOR:%d:%s] Reserved MSO pixel overlap value %u\n",
+			    "[CONNECTOR:%d:%s] MSO stream count %u, pixel overlap %u\n",
 			    connector->base.id, connector->name,
-			    info->mso_pixel_overlap);
-		info->mso_pixel_overlap = 8;
+			    info->mso_stream_count, info->mso_pixel_overlap);
+	}
+
+	if (block->num_bytes < 7) {
+		/* DSC bpp is optional */
+		return;
 	}
 
+	info->dp_dsc_bpp = FIELD_GET(DISPLAYID_VESA_DSC_BPP_INT, vesa->dsc_bpp_int) * 16
+		+ FIELD_GET(DISPLAYID_VESA_DSC_BPP_FRACT, vesa->dsc_bpp_fract);
+
 	drm_dbg_kms(connector->dev,
-		    "[CONNECTOR:%d:%s] MSO stream count %u, pixel overlap %u\n",
+		    "[CONNECTOR:%d:%s] DSC bits per pixel %u\n",
 		    connector->base.id, connector->name,
-		    info->mso_stream_count, info->mso_pixel_overlap);
+		    info->dp_dsc_bpp);
 }
 
 static void drm_update_mso(struct drm_connector *connector,
@@ -6425,6 +6438,7 @@ static void drm_reset_display_info(struct drm_connector *connector)
 	info->mso_stream_count = 0;
 	info->mso_pixel_overlap = 0;
 	info->max_dsc_bpp = 0;
+	info->dp_dsc_bpp = 0;
 
 	kfree(info->vics);
 	info->vics = NULL;
diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
index 7b5048516185..1d01e0146a7f 100644
--- a/include/drm/drm_connector.h
+++ b/include/drm/drm_connector.h
@@ -719,6 +719,12 @@ struct drm_display_info {
 	 */
 	u32 max_dsc_bpp;
 
+	/**
+	 * @dp_dsc_bpp: DP Display-Stream-Compression (DSC) timing's target
+	 * DST bits per pixel in 6.4 fixed point format. 0 means undefined
+	 */
+	u16 dp_dsc_bpp;
+
 	/**
 	 * @vics: Array of vics_len VICs. Internal to EDID parsing.
 	 */
diff --git a/include/drm/drm_displayid.h b/include/drm/drm_displayid.h
index 49649eb8447e..0fc3afbd1675 100644
--- a/include/drm/drm_displayid.h
+++ b/include/drm/drm_displayid.h
@@ -131,12 +131,16 @@ struct displayid_detailed_timing_block {
 
 #define DISPLAYID_VESA_MSO_OVERLAP	GENMASK(3, 0)
 #define DISPLAYID_VESA_MSO_MODE		GENMASK(6, 5)
+#define DISPLAYID_VESA_DSC_BPP_INT	GENMASK(5, 0)
+#define DISPLAYID_VESA_DSC_BPP_FRACT	GENMASK(3, 0)
 
 struct displayid_vesa_vendor_specific_block {
 	struct displayid_block base;
 	u8 oui[3];
 	u8 data_structure_type;
 	u8 mso;
+	u8 dsc_bpp_int;
+	u8 dsc_bpp_fract;
 } __packed;
 
 /* DisplayID iteration */
-- 
2.39.1

