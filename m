Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49EAF6628DB
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 15:45:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234546AbjAIOoy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 09:44:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230493AbjAIOoT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 09:44:19 -0500
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 054BF1DF3C
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 06:44:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=eUiu9Wjf4cO16yZY2bNhlA8qvES7ZdJnbNszqoBABJk=; b=AcFBRRJPlEyliGEC7GMXryCRso
        +PtpcH1KZao7XWkZvq6yU2ttxiXjMGPocxbxuXhqDxmaxPG3sfm7u++kHlqBEUImCa9aC+YLWBV3/
        teSel5vTH7vn2CxnEMOlwUnSObf9iE4N816Uh47bQ5EKZOr3ku9imykLH7QVSHw4tzjjwbUp6p8hQ
        A36echmG6vsG3XeED97XdS+E0Q7+jiCQUo6cDjSvKVUuZ+z5uGMZuwpgcBNZFKJLNfaUufrboCLsL
        y2pOJejCbEO9j4jqz8qlKZImBUWJket+kd96gNEEEAAf8DSV0rUD/U7oo4uxvfaHdlVoTDbHZoZ3G
        QX8/If7A==;
Received: from [41.74.137.107] (helo=killbill.home)
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
        id 1pEtNe-003TyM-7Z; Mon, 09 Jan 2023 15:44:06 +0100
From:   Melissa Wen <mwen@igalia.com>
To:     harry.wentland@amd.com, sunpeng.li@amd.com,
        Rodrigo.Siqueira@amd.com, alexander.deucher@amd.com,
        christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com,
        daniel@ffwll.ch
Cc:     Joshua Ashton <joshua@froggi.es>, alex.hung@amd.com,
        nicholas.kazlauskas@amd.com, sungjoon.kim@amd.com,
        seanpaul@chromium.org, bhawanpreet.lakha@amd.com,
        Shashank Sharma <shashank.sharma@amd.com>,
        ville.syrjala@linux.intel.com, maarten.lankhorst@linux.intel.com,
        mripard@kernel.org, tzimmermann@suse.de, kernel-dev@igalia.com,
        laurent.pinchart+renesas@ideasonboard.com,
        Melissa Wen <mwen@igalia.com>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 07/18] drm/amd/display: remove unused regamma condition
Date:   Mon,  9 Jan 2023 13:38:35 -0100
Message-Id: <20230109143846.1966301-8-mwen@igalia.com>
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

The function __set_output_tf is only called by
amdgpu_dm_update_crtc_color_mgmt() when using atomic regamma. In this
situation, func->tf == TRANSFER_FUNCTION_LINEAR (the original if
condition) and it never falls into tf != LINEAR (the else condition).
Therefore, remove unused condition to avoid misunderstandings here.

Signed-off-by: Melissa Wen <mwen@igalia.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_color.c   | 32 ++++++-------------
 1 file changed, 10 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
index a4cb23d059bd..10a29d131424 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
@@ -255,14 +255,13 @@ static int __set_legacy_tf(struct dc_transfer_func *func,
  * @func: transfer function
  * @lut: lookup table that defines the color space
  * @lut_size: size of respective lut
- * @has_rom: if ROM can be used for hardcoded curve
  *
  * Returns:
  * 0 in case of success. -ENOMEM if fails.
  */
 static int __set_output_tf(struct dc_transfer_func *func,
-			   const struct drm_color_lut *lut, uint32_t lut_size,
-			   bool has_rom)
+			   const struct drm_color_lut *lut,
+			   uint32_t lut_size)
 {
 	struct dc_gamma *gamma = NULL;
 	struct calculate_buffer cal_buffer = {0};
@@ -279,24 +278,13 @@ static int __set_output_tf(struct dc_transfer_func *func,
 	gamma->num_entries = lut_size;
 	__drm_lut_to_dc_gamma(lut, gamma, false);
 
-	if (func->tf == TRANSFER_FUNCTION_LINEAR) {
-		/*
-		 * Color module doesn't like calculating regamma params
-		 * on top of a linear input. But degamma params can be used
-		 * instead to simulate this.
-		 */
-		gamma->type = GAMMA_CUSTOM;
-		res = mod_color_calculate_degamma_params(NULL, func,
-							gamma, true);
-	} else {
-		/*
-		 * Assume sRGB. The actual mapping will depend on whether the
-		 * input was legacy or not.
-		 */
-		gamma->type = GAMMA_CS_TFM_1D;
-		res = mod_color_calculate_regamma_params(func, gamma, false,
-							 has_rom, NULL, &cal_buffer);
-	}
+	/*
+	 * Color module doesn't like calculating regamma params
+	 * on top of a linear input. But degamma params can be used
+	 * instead to simulate this.
+	 */
+	gamma->type = GAMMA_CUSTOM;
+	res = mod_color_calculate_degamma_params(NULL, func, gamma, true);
 
 	dc_gamma_release(&gamma);
 
@@ -450,7 +438,7 @@ int amdgpu_dm_update_crtc_color_mgmt(struct dm_crtc_state *crtc)
 		stream->out_transfer_func->tf = TRANSFER_FUNCTION_LINEAR;
 
 		r = __set_output_tf(stream->out_transfer_func, regamma_lut,
-				    regamma_size, has_rom);
+				    regamma_size);
 		if (r)
 			return r;
 	} else {
-- 
2.35.1

