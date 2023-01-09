Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48FDF6628D4
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 15:45:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234288AbjAIOog (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 09:44:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233629AbjAIOoK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 09:44:10 -0500
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1A771E3E8
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 06:44:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
        In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=OWwQ8u7sFMDvTmb5fE9F6XuAX0AS2r8sgD2pqpPqgV4=; b=kAFclU16RCUbRS43TnofiwMD4I
        88haYRtghBErhgU7N0Vs3/2oMPK0osGqyXOle7pnwfTdPC8zxA7afgyaxB847zmvzZZS5YR9QJxBt
        SYeGP6aRLiGt3gcVIG27e6YTKlj6fvtgBT57xGhAth6lUdKlbUIgRycghvWcnECWiWPT522+cAICU
        sjm/VokbHlvGZuBpICqX0vG79oWW06ljrIZfkvQutAr6IwuHZU81nfyFC7Wsi814RIYhBvuynavZ8
        MfZ8/y0ypnhMKZCYbV/aRhb7WHLaXhQA3Dz/QpgNM3vgt4RFrrDvZMZD8jNJr8B6C5XNfU4FkPMVX
        tcpMWhsA==;
Received: from [41.74.137.107] (helo=killbill.home)
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
        id 1pEtNV-003TyM-Oo; Mon, 09 Jan 2023 15:43:57 +0100
From:   Melissa Wen <mwen@igalia.com>
To:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch
Cc:     Joshua Ashton <joshua@froggi.es>, alex.hung@amd.com,
        nicholas.kazlauskas@amd.com, sungjoon.kim@amd.com,
        seanpaul@chromium.org, bhawanpreet.lakha@amd.com,
        Shashank Sharma <shashank.sharma@amd.com>,
        ville.syrjala@linux.intel.com, kernel-dev@igalia.com,
        laurent.pinchart+renesas@ideasonboard.com,
        Melissa Wen <mwen@igalia.com>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 04/18] drm/drm_color_mgmt: add function to create 3D LUT modes supported
Date:   Mon,  9 Jan 2023 13:38:32 -0100
Message-Id: <20230109143846.1966301-5-mwen@igalia.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230109143846.1966301-1-mwen@igalia.com>
References: <20230109143846.1966301-1-mwen@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DRM color function to create modes for lut3d mode property from an array
of drm_color_lut3d_mode modes supported by the HW and advertise to
userspace. Userspace can get the description of a specific mode in the
enum list from its blob data.

Signed-off-by: Melissa Wen <mwen@igalia.com>
---
 drivers/gpu/drm/drm_color_mgmt.c | 43 +++++++++++++++++++++++++++++++-
 include/drm/drm_color_mgmt.h     |  4 +++
 2 files changed, 46 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_color_mgmt.c b/drivers/gpu/drm/drm_color_mgmt.c
index f92633b3b67e..6ce48007cdd4 100644
--- a/drivers/gpu/drm/drm_color_mgmt.c
+++ b/drivers/gpu/drm/drm_color_mgmt.c
@@ -104,7 +104,7 @@
  *	LUT3D property. A mode specifies size, stride, bit depth and color
  *	format and depends on the underlying hardware). If drivers support
  *	multiple 3D LUT modes, they should be declared in a array of
- *	drm_color_lut3d_mode and they will be advertised as an enum.
+ *	drm_mode_lut3d_mode and they will be advertised as an enum.
  *
  * “GAMMA_LUT”:
  *	Blob property to set the gamma lookup table (LUT) mapping pixel data
@@ -228,6 +228,47 @@ void drm_crtc_enable_color_mgmt(struct drm_crtc *crtc,
 }
 EXPORT_SYMBOL(drm_crtc_enable_color_mgmt);
 
+int drm_crtc_create_lut3d_mode_property(struct drm_crtc *crtc,
+					const struct drm_mode_lut3d_mode modes[],
+					unsigned int num_modes)
+{
+	struct drm_device *dev = crtc->dev;
+	struct drm_property_blob *blob;
+	struct drm_property *prop;
+	char *name;
+	int ret;
+
+	if (dev->mode_config.lut3d_mode_property)
+		return 0;
+
+	prop = drm_property_create(dev, DRM_MODE_PROP_ENUM, "LUT3D_MODE", num_modes);
+	if (!prop)
+		return -EINVAL;
+
+	for (int i = 0; i < num_modes; i++) {
+		blob = drm_property_create_blob(dev, sizeof(modes[i]), &modes[i]);
+		if (IS_ERR(blob))
+			return PTR_ERR(blob);
+
+		name = kasprintf(GFP_KERNEL, "lut3d_%d_%dbit",
+				 modes[i].lut_size, modes[i].bit_depth);
+		if (!name)
+			return -ENOMEM;
+
+		ret = drm_property_add_enum(prop, blob->base.id, name);
+		if (ret) {
+			drm_property_blob_put(blob);
+			kfree(name);
+			return ret;
+		}
+		kfree(name);
+	}
+	dev->mode_config.lut3d_mode_property = prop;
+
+	return 0;
+}
+EXPORT_SYMBOL(drm_crtc_create_lut3d_mode_property);
+
 /**
  * drm_mode_crtc_set_gamma_size - set the gamma table size
  * @crtc: CRTC to set the gamma table size for
diff --git a/include/drm/drm_color_mgmt.h b/include/drm/drm_color_mgmt.h
index 81c298488b0c..af9305925572 100644
--- a/include/drm/drm_color_mgmt.h
+++ b/include/drm/drm_color_mgmt.h
@@ -59,6 +59,10 @@ void drm_crtc_enable_color_mgmt(struct drm_crtc *crtc,
 				bool has_ctm,
 				uint gamma_lut_size);
 
+int drm_crtc_create_lut3d_mode_property(struct drm_crtc *crtc,
+					const struct drm_mode_lut3d_mode modes[],
+					unsigned int num_modes);
+
 int drm_mode_crtc_set_gamma_size(struct drm_crtc *crtc,
 				 int gamma_size);
 
-- 
2.35.1

