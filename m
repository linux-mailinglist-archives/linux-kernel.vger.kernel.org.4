Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CF2A6EC089
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Apr 2023 16:50:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230082AbjDWOuL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Apr 2023 10:50:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230403AbjDWOuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Apr 2023 10:50:06 -0400
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C092110FD
        for <linux-kernel@vger.kernel.org>; Sun, 23 Apr 2023 07:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=T0QU+rn3vH/vhCGh2w+pB+FknzjEXDis7z0wQd69Ucg=; b=KsvdnIDgtkN+mFU1/LngtyfA5d
        lPyshycpBtzRBocFDJHhbU6OKz0Nx9xNY/ss/256mIatnlh/+QjyHXA9VflaBhksFTaB2+LLTNqim
        nY/ibVox19zMD8loxRtvUGRZJ9OmAHZB6PpRd14AlUdYZnCthOWrN0HzO/DI563ikaSL5km9038kP
        bTpMqgm8XDDlxswpF2w5R38RZmWCbU0z4qhDSPA5IA19gP2siJ375VQ+1wex5YCQejDPDOOSxHJgf
        6Er7CXzS621K2NtHFnotO0C0hgoJ62h2XqZsQH1BPurnaIyuhT93Yc9EJq/YbCDGaCyB8S46zZYh/
        oqFL8WPg==;
Received: from nat-wifi.fi.muni.cz ([147.251.43.9] helo=killbill.fi.muni.cz)
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
        id 1pqaSv-00ANVs-J8; Sun, 23 Apr 2023 16:13:21 +0200
From:   Melissa Wen <mwen@igalia.com>
To:     amd-gfx@lists.freedesktop.org,
        Harry Wentland <harry.wentland@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        sunpeng.li@amd.com, Alex Deucher <alexander.deucher@amd.com>,
        dri-devel@lists.freedesktop.org, christian.koenig@amd.com,
        Xinhui.Pan@amd.com, airlied@gmail.com, daniel@ffwll.ch
Cc:     Joshua Ashton <joshua@froggi.es>,
        Sebastian Wick <sebastian.wick@redhat.com>,
        Xaver Hugl <xaver.hugl@gmail.com>,
        Shashank Sharma <Shashank.Sharma@amd.com>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        sungjoon.kim@amd.com, Alex Hung <alex.hung@amd.com>,
        Melissa Wen <mwen@igalia.com>, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 25/40] drm/amd/display: decouple steps to reuse in CRTC shaper LUT support
Date:   Sun, 23 Apr 2023 13:10:37 -0100
Message-Id: <20230423141051.702990-26-mwen@igalia.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230423141051.702990-1-mwen@igalia.com>
References: <20230423141051.702990-1-mwen@igalia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Decouple steps of post-blending shaper LUT setup and LUT size validation
according to HW caps as a preparation for DRM CRTC shaper LUT support.

Signed-off-by: Melissa Wen <mwen@igalia.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_color.c   | 67 ++++++++++++++++---
 1 file changed, 58 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
index 25010fa19bc8..672ca5e9e59c 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
@@ -443,6 +443,48 @@ static void amdgpu_dm_atomic_lut3d(const struct drm_color_lut *drm_lut,
 	}
 }
 
+/**
+ * __set_input_tf - calculates the input transfer function based on expected
+ * input space.
+ * @func: transfer function
+ * @lut: lookup table that defines the color space
+ * @lut_size: size of respective lut.
+ *
+ * Returns:
+ * 0 in case of success. -ENOMEM if fails.
+ */
+static int __set_input_tf(struct dc_transfer_func *func,
+			  const struct drm_color_lut *lut, uint32_t lut_size)
+{
+	struct dc_gamma *gamma = NULL;
+	bool res;
+
+	gamma = dc_create_gamma();
+	if (!gamma)
+		return -ENOMEM;
+
+	gamma->type = GAMMA_CUSTOM;
+	gamma->num_entries = lut_size;
+
+	__drm_lut_to_dc_gamma(lut, gamma, false);
+
+	res = mod_color_calculate_degamma_params(NULL, func, gamma, true);
+	dc_gamma_release(&gamma);
+
+	return res ? 0 : -ENOMEM;
+}
+
+static int amdgpu_dm_atomic_shaper_lut(struct dc_transfer_func *func_shaper)
+{
+	/* We don't get DRM shaper LUT yet. We assume the input color space is already
+	 * delinearized, so we don't need a shaper LUT and we can just BYPASS
+	 */
+	func_shaper->type = TF_TYPE_BYPASS;
+	func_shaper->tf = TRANSFER_FUNCTION_LINEAR;
+
+	return 0;
+}
+
 /* amdgpu_dm_atomic_shaper_lut3d - set DRM CRTC shaper LUT and 3D LUT to DC
  * interface
  * @dc: Display Core control structure
@@ -486,15 +528,23 @@ static int amdgpu_dm_atomic_shaper_lut3d(struct dc *dc,
 	if (!acquire)
 		return 0;
 
-	/* We don't get DRM shaper LUT yet. We assume the input color
-	 * space is already delinearized, so we don't need a shaper LUT
-	 * and we can just BYPASS.
-	 */
-	func_shaper->type = TF_TYPE_BYPASS;
-	func_shaper->tf = TRANSFER_FUNCTION_LINEAR;
 	amdgpu_dm_atomic_lut3d(drm_lut3d, drm_lut3d_size, lut3d_func);
 
-	return 0;
+	return amdgpu_dm_atomic_shaper_lut(func_shaper);
+}
+
+/**
+ * amdgpu_dm_lut3d_size - get expected size according to hw color caps
+ * @adev: amdgpu device
+ * @lut_size: default size
+ *
+ * Return:
+ * lut_size if DC 3D LUT is supported, zero otherwise.
+ */
+static uint32_t amdgpu_dm_get_lut3d_size(struct amdgpu_device *adev,
+					 uint32_t lut_size)
+{
+	return adev->dm.dc->caps.color.mpc.num_3dluts ? lut_size : 0;
 }
 
 /**
@@ -516,8 +566,7 @@ int amdgpu_dm_verify_lut3d_size(struct amdgpu_device *adev,
 	struct dm_crtc_state *acrtc_state = to_dm_crtc_state(crtc_state);
 	uint32_t exp_size, size;
 
-	exp_size = adev->dm.dc->caps.color.mpc.num_3dluts ?
-		   MAX_COLOR_3DLUT_ENTRIES : 0;
+	exp_size = amdgpu_dm_get_lut3d_size(adev, MAX_COLOR_3DLUT_ENTRIES);
 
 	lut3d = __extract_blob_lut(acrtc_state->lut3d, &size);
 
-- 
2.39.2

