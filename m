Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EBA56628D6
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 15:45:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbjAIOon (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 09:44:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233660AbjAIOoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 09:44:12 -0500
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA35B1E3C0
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 06:44:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=0r/YKTFRwpqtasaSu+TXALDbDG9nOKnJqiwlyrK/4as=; b=IUDT/m33kXvkNtSdS/4qsMQINo
        dq0n9SoMUor3bd/Rw5LOOIuDpC9ngY9awRLDxP3azAfNHsZ6/s2xQJo8xaWiRTBqAiOUJcVzif2/F
        iLHuQPa74RA90u1PoRZlzhZgcHUO/EdvvjyI3tlvowW2B5gRy+Nitf8r0vIxCYWibFKz7/jk1J+8o
        qp9mPE/c6nozubFOIaq0dh0mJMBP01vBrn/OJ/fWempQWUBiawc58yWeV6nnHeY3bK/6wKfkdl38H
        j+DiNdjAapYxucLFEUWUdk1gIwsBvzQbvqpzybRB2IJyF3GuuaSdCoX7koVe8dYnwHkrvJWDVlT2R
        l6abuV2A==;
Received: from [41.74.137.107] (helo=killbill.home)
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
        id 1pEtNY-003TyM-8V; Mon, 09 Jan 2023 15:44:00 +0100
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
Subject: [RFC PATCH v2 05/18] drm/drm_color_mgmt: add function to attach 3D LUT props
Date:   Mon,  9 Jan 2023 13:38:33 -0100
Message-Id: <20230109143846.1966301-6-mwen@igalia.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230109143846.1966301-1-mwen@igalia.com>
References: <20230109143846.1966301-1-mwen@igalia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the driver supports user 3D LUT then it calls a drm function to
attach 3D LUT related properties according to HW caps.

Signed-off-by: Melissa Wen <mwen@igalia.com>
---
 drivers/gpu/drm/drm_color_mgmt.c | 35 ++++++++++++++++++++++++++++++++
 include/drm/drm_color_mgmt.h     |  3 +++
 2 files changed, 38 insertions(+)

diff --git a/drivers/gpu/drm/drm_color_mgmt.c b/drivers/gpu/drm/drm_color_mgmt.c
index 6ce48007cdd4..06503f693ecd 100644
--- a/drivers/gpu/drm/drm_color_mgmt.c
+++ b/drivers/gpu/drm/drm_color_mgmt.c
@@ -269,6 +269,41 @@ int drm_crtc_create_lut3d_mode_property(struct drm_crtc *crtc,
 }
 EXPORT_SYMBOL(drm_crtc_create_lut3d_mode_property);
 
+/**
+ * drm_crtc_enable_lut3d - enable 3D LUT properties
+ * @crtc: DRM CRTC
+ * @shaper_lut_size: the size of shaper lut
+ *
+ * This function lets the driver enable the 3D LUT color correction property
+ * on a CRTC. This includes 3D LUT and also a shaper LUT, if set. The shaper
+ * LUT property is only attached if its size is not 0 and 3D LUT is set, being
+ * therefore optional.
+ */
+void drm_crtc_enable_lut3d(struct drm_crtc *crtc,
+			   uint shaper_lut_size)
+{
+	struct drm_device *dev = crtc->dev;
+	struct drm_mode_config *config = &dev->mode_config;
+
+	if (!config->lut3d_mode_property)
+		return;
+
+	drm_object_attach_property(&crtc->base,
+				   config->lut3d_property, 0);
+	drm_object_attach_property(&crtc->base,
+				   config->lut3d_mode_property, 0);
+
+	if (!shaper_lut_size)
+		return;
+
+	drm_object_attach_property(&crtc->base,
+				   config->shaper_lut_property, 0);
+	drm_object_attach_property(&crtc->base,
+				   config->shaper_lut_size_property,
+				   shaper_lut_size);
+}
+EXPORT_SYMBOL(drm_crtc_enable_lut3d);
+
 /**
  * drm_mode_crtc_set_gamma_size - set the gamma table size
  * @crtc: CRTC to set the gamma table size for
diff --git a/include/drm/drm_color_mgmt.h b/include/drm/drm_color_mgmt.h
index af9305925572..db2026dc825e 100644
--- a/include/drm/drm_color_mgmt.h
+++ b/include/drm/drm_color_mgmt.h
@@ -63,6 +63,9 @@ int drm_crtc_create_lut3d_mode_property(struct drm_crtc *crtc,
 					const struct drm_mode_lut3d_mode modes[],
 					unsigned int num_modes);
 
+void drm_crtc_enable_lut3d(struct drm_crtc *crtc,
+			   uint shaper_lut_size);
+
 int drm_mode_crtc_set_gamma_size(struct drm_crtc *crtc,
 				 int gamma_size);
 
-- 
2.35.1

