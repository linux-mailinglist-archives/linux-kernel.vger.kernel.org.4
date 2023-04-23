Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 107EE6EC03E
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Apr 2023 16:14:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbjDWOOa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Apr 2023 10:14:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230231AbjDWOO1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Apr 2023 10:14:27 -0400
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BBDC30DB
        for <linux-kernel@vger.kernel.org>; Sun, 23 Apr 2023 07:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=K+6HAiokAFpNjOZfe6WgA9HAsgScvAWCci4ACm8KQN8=; b=hx19W7o99rbwOcYM34nXNbSSO2
        wNL6y1AqnOcuv62B7tlO7cHm2Mamz7TFvnDOpoVdX4iSCqBDLy14RJJhCiu5e9fAAzMxhYCxxlaXl
        hySJDSRTL/Cv8+a33gH5aQIROjh5lQr06r9/8oQLXkcUXZ59HIWqAwXQnSLB9RRaKYYFb+Gs/qQyM
        PgNCnsEa34yModOd4L5BkD2Noo5QY4wFU+UvANqowu7JU7BehKBJnr4hxXkt4yPQWMWT4FZFDK1t6
        UfbeEMnf8VkLNQVqDokT5RCPODHQYd5XKsjPOziSs/PvQev4t0yHiP0N/qayIdHHz940+zkg1PH0C
        JVIariXg==;
Received: from nat-wifi.fi.muni.cz ([147.251.43.9] helo=killbill.fi.muni.cz)
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
        id 1pqaST-00ANVs-FW; Sun, 23 Apr 2023 16:12:53 +0200
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
Subject: [RFC PATCH 17/40] drm/amd/display: add comments to describe DM crtc color mgmt behavior
Date:   Sun, 23 Apr 2023 13:10:29 -0100
Message-Id: <20230423141051.702990-18-mwen@igalia.com>
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

Describe some expected behavior of the AMD DM color mgmt programming.

Signed-off-by: Melissa Wen <mwen@igalia.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
index a4cb23d059bd..fe779d10834e 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
@@ -440,12 +440,23 @@ int amdgpu_dm_update_crtc_color_mgmt(struct dm_crtc_state *crtc)
 		stream->out_transfer_func->type = TF_TYPE_DISTRIBUTED_POINTS;
 		stream->out_transfer_func->tf = TRANSFER_FUNCTION_SRGB;
 
+		/* Note: although we pass has_rom as parameter here, we never
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
+		 * Note: there is no implicit sRGB regamma here. We are using
+		 * degamma calculation from color module to calculate the curve
+		 * from a linear base.
+		 */
 		stream->out_transfer_func->type = TF_TYPE_DISTRIBUTED_POINTS;
 		stream->out_transfer_func->tf = TRANSFER_FUNCTION_LINEAR;
 
-- 
2.39.2

