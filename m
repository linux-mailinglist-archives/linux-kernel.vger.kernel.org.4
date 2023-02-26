Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 207AC6A2FE8
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 15:18:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbjBZOR6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 09:17:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbjBZOR4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 09:17:56 -0500
X-Greylist: delayed 383 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 26 Feb 2023 06:17:55 PST
Received: from forward108j.mail.yandex.net (forward108j.mail.yandex.net [IPv6:2a02:6b8:0:801:2::253])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5813A2D6A
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 06:17:55 -0800 (PST)
Received: from iva2-656890eaceb5.qloud-c.yandex.net (iva2-656890eaceb5.qloud-c.yandex.net [IPv6:2a02:6b8:c0c:6902:0:640:6568:90ea])
        by forward108j.mail.yandex.net (Yandex) with ESMTP id 9464E3F215F8;
        Sun, 26 Feb 2023 17:11:30 +0300 (MSK)
Received: by iva2-656890eaceb5.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id tATvDFdaca61-K1oQtVIF;
        Sun, 26 Feb 2023 17:11:29 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lach.pw; s=mail; t=1677420689;
        bh=4OZH6E6CsjLO+EJW2LJh4x68QtAphhfAjHOaUhriUQw=;
        h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
        b=Bq3mjqWKGG+aRyBMIRQvvUaXlBGNUVmOPd8PZxlOY0f9q6/WR31LtRUUC+RQiItZz
         QtSyWfRrAkIEKLUUazGYZrh33mLGeEDa//HuYKeKJbDJTxqYwMRyEziFQUflQPOcnZ
         AjWKdn8iZ52hvgtxSGykBxWP8KX1W2UicVhgz+0Y=
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
        Yaroslav Bolyukin <iam@lach.pw>, Wayne Lin <Wayne.Lin@amd.com>
Subject: [PATCH v3 2/2] drm/amd: use fixed dsc bits-per-pixel from edid
Date:   Sun, 26 Feb 2023 15:10:51 +0100
Message-Id: <20230226141051.21767-3-iam@lach.pw>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230226141051.21767-1-iam@lach.pw>
References: <20230226141051.21767-1-iam@lach.pw>
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

VESA vendor header from DisplayID spec may contain fixed bit per pixel
rate, it should be respected by drm driver

Signed-off-by: Yaroslav Bolyukin <iam@lach.pw>
Reviewed-by: Wayne Lin <Wayne.Lin@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 2 ++
 drivers/gpu/drm/amd/display/dc/core/dc_stream.c           | 2 ++
 drivers/gpu/drm/amd/display/dc/dc_types.h                 | 3 +++
 3 files changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
index 6fdc2027c2b4..dba720d5df4c 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
@@ -89,6 +89,8 @@ enum dc_edid_status dm_helpers_parse_edid_caps(
 
 	edid_caps->edid_hdmi = connector->display_info.is_hdmi;
 
+	edid_caps->dsc_fixed_bits_per_pixel_x16 = connector->display_info.dp_dsc_bpp;
+
 	sad_count = drm_edid_to_sad((struct edid *) edid->raw_edid, &sads);
 	if (sad_count <= 0)
 		return result;
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
index 72b261ad9587..a82362417379 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
@@ -103,6 +103,8 @@ static bool dc_stream_construct(struct dc_stream_state *stream,
 
 	/* EDID CAP translation for HDMI 2.0 */
 	stream->timing.flags.LTE_340MCSC_SCRAMBLE = dc_sink_data->edid_caps.lte_340mcsc_scramble;
+	stream->timing.dsc_fixed_bits_per_pixel_x16 =
+		dc_sink_data->edid_caps.dsc_fixed_bits_per_pixel_x16;
 
 	memset(&stream->timing.dsc_cfg, 0, sizeof(stream->timing.dsc_cfg));
 	stream->timing.dsc_cfg.num_slices_h = 0;
diff --git a/drivers/gpu/drm/amd/display/dc/dc_types.h b/drivers/gpu/drm/amd/display/dc/dc_types.h
index 27d0242d6cbd..22fedf4c7547 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_types.h
@@ -228,6 +228,9 @@ struct dc_edid_caps {
 	bool edid_hdmi;
 	bool hdr_supported;
 
+	/* DisplayPort caps */
+	uint32_t dsc_fixed_bits_per_pixel_x16;
+
 	struct dc_panel_patch panel_patch;
 };
 
-- 
2.39.1

