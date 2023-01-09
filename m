Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5100E6628E9
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 15:45:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230493AbjAIOpD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 09:45:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232776AbjAIOoV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 09:44:21 -0500
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9CFB1E3F9
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 06:44:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=yZ+XADzHjwvGta78ZXBVQh4OGwv1Wat6G9lgsepYSyM=; b=A/BXeZXWL4HuH8i/jEvBcxdnAv
        ZDsm7EoqvVho9tRzSvxMx5l4aPf22MNse6N3kGsUoap3ZhaioKJwEu3AabOZ0SCuQyzQGjymoJIxn
        dFdeJ+/UaZT78/RRF8hzAL1vgoSkiPYc5W4WBtxJoxrYZiRDqvs5IYjuvy9m3P20Om7NgHGfBXYoj
        onOeJwyXdUwGEwix+YsVHbjprxp2c85esOC/K8ZvQLYJfkACHj/FfyRZRJaFyZxT5djIDBXBWjRqu
        V5K9X5grXuwBaSqY27q01RexqFEuzv9eQLEUnWCmEAvOZgoZ3vLyR5UG1fFFg247+d0p1ghdRQOQg
        djDdGOsA==;
Received: from [41.74.137.107] (helo=killbill.home)
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
        id 1pEtNh-003TyM-5k; Mon, 09 Jan 2023 15:44:09 +0100
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
Subject: [RFC PATCH v2 08/18] drm/amd/display: add comments to describe DM crtc color mgmt behavior
Date:   Mon,  9 Jan 2023 13:38:36 -0100
Message-Id: <20230109143846.1966301-9-mwen@igalia.com>
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

Describe some expected behavior of the AMD DM color mgmt programming.

Signed-off-by: Melissa Wen <mwen@igalia.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
index 10a29d131424..b54ef1392895 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
@@ -428,12 +428,23 @@ int amdgpu_dm_update_crtc_color_mgmt(struct dm_crtc_state *crtc)
 		stream->out_transfer_func->type = TF_TYPE_DISTRIBUTED_POINTS;
 		stream->out_transfer_func->tf = TRANSFER_FUNCTION_SRGB;
 
+		/* Note: even if we pass has_rom as parameter here, we never
+		 * actually use ROM because the color module only takes the ROM
+		 * path if transfer_func->type == PREDEFINED.
+		 *
+		 * See more in mod_color_calculate_regamma_params()
+		 */
 		r = __set_legacy_tf(stream->out_transfer_func, regamma_lut,
 				    regamma_size, has_rom);
 		if (r)
 			return r;
 	} else if (has_regamma) {
-		/* If atomic regamma, CRTC RGM goes into RGM LUT. */
+		/* CRTC RGM goes into RGM LUT.
+		 *
+		 * Note: here there is no implicit sRGB regamma. We are using
+		 * degamma calculation from color module to calculate the curve
+		 * from a linear base.
+		 */
 		stream->out_transfer_func->type = TF_TYPE_DISTRIBUTED_POINTS;
 		stream->out_transfer_func->tf = TRANSFER_FUNCTION_LINEAR;
 
-- 
2.35.1

