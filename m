Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56BF16722B5
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 17:13:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbjARQNL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 11:13:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbjARQMp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 11:12:45 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52FC554112
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 08:07:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9ACFA618A8
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 16:07:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27895C433EF;
        Wed, 18 Jan 2023 16:07:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674058049;
        bh=erza5wFZzZpKsQRpijn12Ne9oD+6s0EUVrxM9VxD0K8=;
        h=From:To:Cc:Subject:Date:From;
        b=sU3sjFUfD9qPsYWoFVqac92lNyW7s5zIZLNULDMetjK6srOOinZ/Whv3xtYKSEGbG
         P66TD0OK/sWifzth9E5i7XqmapF+84ckRZlVDw6piDgLfi0rs7CGqVmRU1qJkV19Bs
         mRbyO0OXexSnHcMsyUBr42YV2jYhy77KXvs7JrSdccbFZx/9TivXOXp4E+clBwjU00
         Xi5tH73RcZNQhJjyve4H7PyA9jeWEmgu39meb6wMuyTbpYRaBIVEWYINn2S5CqvmtV
         8SFUaQwKSQsqrMhFfKw0IjkulweS4tKfmfJgh1dVNTqgOm7nYe4jmiJvzBmw/xd/6t
         r2qeo9C0iNY+w==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Wenjing Liu <wenjing.liu@amd.com>,
        "Shen, George" <George.Shen@amd.com>,
        Solomon Chiu <solomon.chiu@amd.com>,
        Ian Chen <ian.chen@amd.com>, Po Ting Chen <robin.chen@amd.com>,
        Michael Strauss <michael.strauss@amd.com>,
        Wesley Chalmers <Wesley.Chalmers@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amd/display: fix hdmi_encoded_link_bw definition
Date:   Wed, 18 Jan 2023 17:06:27 +0100
Message-Id: <20230118160722.289840-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Some of the data structures are hidden when CONFIG_DRM_AMD_DC_DCN is
disabled, which leads to a link failure:

drivers/gpu/drm/amd/amdgpu/../display/dc/link/link_dp_capability.c:234:21: error: 'union hdmi_encoded_link_bw' declared inside parameter list will not be visible outside of this definition or declaration [-Werror]
  234 |         const union hdmi_encoded_link_bw hdmi_encoded_link_bw)
      |                     ^~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/link/link_dp_capability.c:234:42: error: parameter 2 ('hdmi_encoded_link_bw') has incomplete type
  234 |         const union hdmi_encoded_link_bw hdmi_encoded_link_bw)
      |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/link/link_dp_capability.c:232:17: error: function declaration isn't a prototype [-Werror=strict-prototypes]
  232 | static uint32_t intersect_frl_link_bw_support(
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/link/link_dp_capability.c: In function 'get_active_converter_info':
drivers/gpu/drm/amd/amdgpu/../display/dc/link/link_dp_capability.c:1126:76: error: storage size of 'hdmi_encoded_link_bw' isn't known
 1126 |                                                 union hdmi_encoded_link_bw hdmi_encoded_link_bw;
      |                                                                            ^~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/link/link_dp_capability.c:1130:101: error: 'struct <anonymous>' has no member named 'MAX_ENCODED_LINK_BW_SUPPORT'
 1130 |                                                                                 hdmi_color_caps.bits.MAX_ENCODED_LINK_BW_SUPPORT);

There is probably no need to hide the data structure, and removing
the #ifdef makes it build cleanly.

Fixes: d5a43956b73b ("drm/amd/display: move dp capability related logic to link_dp_capability")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/amd/display/dc/dc_dp_types.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_dp_types.h b/drivers/gpu/drm/amd/display/dc/dc_dp_types.h
index b7e53b7dc4ed..84da54358922 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dp_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_dp_types.h
@@ -361,14 +361,10 @@ enum dpcd_downstream_port_detailed_type {
 union dwnstream_port_caps_byte2 {
 	struct {
 		uint8_t MAX_BITS_PER_COLOR_COMPONENT:2;
-#if defined(CONFIG_DRM_AMD_DC_DCN)
 		uint8_t MAX_ENCODED_LINK_BW_SUPPORT:3;
 		uint8_t SOURCE_CONTROL_MODE_SUPPORT:1;
 		uint8_t CONCURRENT_LINK_BRING_UP_SEQ_SUPPORT:1;
 		uint8_t RESERVED:1;
-#else
-		uint8_t RESERVED:6;
-#endif
 	} bits;
 	uint8_t raw;
 };
@@ -406,7 +402,6 @@ union dwnstream_port_caps_byte3_hdmi {
 	uint8_t raw;
 };
 
-#if defined(CONFIG_DRM_AMD_DC_DCN)
 union hdmi_sink_encoded_link_bw_support {
 	struct {
 		uint8_t HDMI_SINK_ENCODED_LINK_BW_SUPPORT:3;
@@ -428,7 +423,6 @@ union hdmi_encoded_link_bw {
 	} bits;
 	uint8_t raw;
 };
-#endif
 
 /*4-byte structure for detailed capabilities of a down-stream port
 (DP-to-TMDS converter).*/
-- 
2.39.0

