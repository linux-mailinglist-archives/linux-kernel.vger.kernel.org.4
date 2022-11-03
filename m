Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C150B6187D8
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 19:45:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230306AbiKCSp2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 14:45:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiKCSpZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 14:45:25 -0400
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 636B665A5
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 11:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
        Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=stQoeni8g1ouTppLMWkElI0A2/tlqOJ/VPPxbiTBNoQ=; b=IPG36VN9SfNk4SE38mDa03um9V
        rdAThTQ2XUKJyeBmjL2aA2zHnI6iGG+ASzg5uDDqgEjfv4mlwantbI00sk338dCNZEdfRDtfvfn9U
        wt1J0R0q6gyFWtWXlWJ/Xg2Z6uUKoDgLnl5EYz+oXx9IE9liAVKXWQavFui7LHaXAmCm8IL3CoJtV
        o4b+zliJWbGF8W0HncqKu4QScfxoFYKLkfzXTc/rETDgUNzKpmfCZvNpO58cz3oogoZE7Mh+5VRAO
        1i4yxj0K0g4kfp78rNYKGi80W57Z5nclWKewb3lqvXmbHQcx3dj70HlcCC/3LCpXcTjqQIbtABALP
        NEfJ2kng==;
Received: from [186.214.188.198] (helo=localhost.localdomain)
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
        id 1oqfDJ-00BsY3-PN; Thu, 03 Nov 2022 19:45:18 +0100
From:   Melissa Wen <mwen@igalia.com>
To:     harry.wentland@amd.com, sunpeng.li@amd.com,
        Rodrigo.Siqueira@amd.com, alexander.deucher@amd.com,
        christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@linux.ie,
        daniel@ffwll.ch
Cc:     Nicholas.Choi@amd.com, Nicholas.Kazlauskas@amd.com,
        kernel-dev@igalia.com, Melissa Wen <mwen@igalia.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amd/display: don't enable DRM CRTC degamma property for DCE
Date:   Thu,  3 Nov 2022 17:45:00 -0100
Message-Id: <20221103184500.14450-1-mwen@igalia.com>
X-Mailer: git-send-email 2.35.1
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

DM maps DRM CRTC degamma to DPP (pre-blending) degamma block, but DCE doesn't
support programmable degamma curve anywhere. Currently, a custom degamma is
accepted by DM but just ignored by DCE driver and degamma correction isn't
actually applied. There is no way to map custom degamma in DCE, therefore, DRM
CRTC degamma property shouldn't be enabled for DCE drivers.

Signed-off-by: Melissa Wen <mwen@igalia.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
index 9ac2805c5d63..b3eadfc61555 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
@@ -415,7 +415,7 @@ int amdgpu_dm_crtc_init(struct amdgpu_display_manager *dm,
 {
 	struct amdgpu_crtc *acrtc = NULL;
 	struct drm_plane *cursor_plane;
-
+	bool is_dcn;
 	int res = -ENOMEM;
 
 	cursor_plane = kzalloc(sizeof(*cursor_plane), GFP_KERNEL);
@@ -453,8 +453,14 @@ int amdgpu_dm_crtc_init(struct amdgpu_display_manager *dm,
 	acrtc->otg_inst = -1;
 
 	dm->adev->mode_info.crtcs[crtc_index] = acrtc;
-	drm_crtc_enable_color_mgmt(&acrtc->base, MAX_COLOR_LUT_ENTRIES,
+
+	/* Don't enable DRM CRTC degamma property for DCE since it doesn't
+	 * support programmable degamma anywhere.
+	 */
+	is_dcn = dm->adev->dm.dc->caps.color.dpp.dcn_arch;
+	drm_crtc_enable_color_mgmt(&acrtc->base, is_dcn ? MAX_COLOR_LUT_ENTRIES : 0,
 				   true, MAX_COLOR_LUT_ENTRIES);
+
 	drm_mode_crtc_set_gamma_size(&acrtc->base, MAX_COLOR_LEGACY_LUT_ENTRIES);
 
 	return 0;
-- 
2.35.1

