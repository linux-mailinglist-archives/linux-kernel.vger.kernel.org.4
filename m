Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A02396EC03D
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Apr 2023 16:14:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbjDWOO2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Apr 2023 10:14:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbjDWOOZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Apr 2023 10:14:25 -0400
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7452F30CA
        for <linux-kernel@vger.kernel.org>; Sun, 23 Apr 2023 07:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=fshOS/phNnywqSBclNdRCFpkoMQdWZs7fr2IAut5ZT0=; b=BtJ4pyaxdSoPnTZ+6hrLdkGn3J
        ThaZJtL9jgfH3W46t0EickvaTV1RcRBbRBtFLcIqmLXEO4cH/9wHo0uF/7TRv7xq02rBwYs38JVRI
        cRKqfACjAfjuzlRMHgFE6eJ4clTF0oU9e9wGD7U51lS6ePdh+ml8cARhCzFbMiu2pAFK8E1e2JTA0
        6vH7lFIcUzwkeebvagpq38nIzFanGIUMwHbezSCvXbvcQ+djPBX+CR78NQ43bdGLb6P4kcV/tqcem
        fsJd568OQ7gjqkc+45X47JkDUimkGeK1dBnwBoOp/tXIuIIMhM8m9t7moV0apFxk95KjWNou7/qze
        qddg1PuQ==;
Received: from nat-wifi.fi.muni.cz ([147.251.43.9] helo=killbill.fi.muni.cz)
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
        id 1pqaSW-00ANVs-Bb; Sun, 23 Apr 2023 16:12:56 +0200
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
Subject: [RFC PATCH 18/40] drm/amd/display: encapsulate atomic regamma operation
Date:   Sun, 23 Apr 2023 13:10:30 -0100
Message-Id: <20230423141051.702990-19-mwen@igalia.com>
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

We are introducing DRM 3D LUT property to DM color pipeline in the next
patch, but so far, only for atomic interface. By checking
set_output_transfer_func in DC drivers with MPC 3D LUT support, we can
verify that regamma is only programmed when 3D LUT programming fails. As
a groundwork to introduce 3D LUT programming and better understand each
step, detach atomic regamma programming from the crtc colocr updating
code.

Signed-off-by: Melissa Wen <mwen@igalia.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_color.c   | 52 ++++++++++++-------
 1 file changed, 33 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
index fe779d10834e..f1885e9c614d 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
@@ -303,6 +303,35 @@ static int __set_output_tf(struct dc_transfer_func *func,
 	return res ? 0 : -ENOMEM;
 }
 
+static int amdgpu_dm_set_atomic_regamma(struct dc_stream_state *stream,
+					const struct drm_color_lut *regamma_lut,
+					uint32_t regamma_size, bool has_rom)
+{
+	int ret = 0;
+	if (regamma_size) {
+		/* CRTC RGM goes into RGM LUT.
+		 *
+		 * Note: there is no implicit sRGB regamma here. We are using
+		 * degamma calculation from color module to calculate the curve
+		 * from a linear base.
+		 */
+		stream->out_transfer_func->type = TF_TYPE_DISTRIBUTED_POINTS;
+		stream->out_transfer_func->tf = TRANSFER_FUNCTION_LINEAR;
+
+		ret = __set_output_tf(stream->out_transfer_func,
+				      regamma_lut, regamma_size, has_rom);
+	} else {
+		/*
+		 * No CRTC RGM means we can just put the block into bypass
+		 * since we don't have any plane level adjustments using it.
+		 */
+		stream->out_transfer_func->type = TF_TYPE_BYPASS;
+		stream->out_transfer_func->tf = TRANSFER_FUNCTION_LINEAR;
+	}
+
+	return ret;
+}
+
 /**
  * __set_input_tf - calculates the input transfer function based on expected
  * input space.
@@ -450,27 +479,12 @@ int amdgpu_dm_update_crtc_color_mgmt(struct dm_crtc_state *crtc)
 				    regamma_size, has_rom);
 		if (r)
 			return r;
-	} else if (has_regamma) {
-		/* CRTC RGM goes into RGM LUT.
-		 *
-		 * Note: there is no implicit sRGB regamma here. We are using
-		 * degamma calculation from color module to calculate the curve
-		 * from a linear base.
-		 */
-		stream->out_transfer_func->type = TF_TYPE_DISTRIBUTED_POINTS;
-		stream->out_transfer_func->tf = TRANSFER_FUNCTION_LINEAR;
-
-		r = __set_output_tf(stream->out_transfer_func, regamma_lut,
-				    regamma_size, has_rom);
+	} else {
+		regamma_size = has_regamma ? regamma_size : 0;
+		r = amdgpu_dm_set_atomic_regamma(stream, regamma_lut,
+						 regamma_size, has_rom);
 		if (r)
 			return r;
-	} else {
-		/*
-		 * No CRTC RGM means we can just put the block into bypass
-		 * since we don't have any plane level adjustments using it.
-		 */
-		stream->out_transfer_func->type = TF_TYPE_BYPASS;
-		stream->out_transfer_func->tf = TRANSFER_FUNCTION_LINEAR;
 	}
 
 	/*
-- 
2.39.2

