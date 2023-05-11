Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A5576FFA4A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 21:38:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239241AbjEKTii (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 15:38:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239235AbjEKTib (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 15:38:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB7F07EC9;
        Thu, 11 May 2023 12:38:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 337AA63AEE;
        Thu, 11 May 2023 19:38:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A0DFC4339B;
        Thu, 11 May 2023 19:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683833906;
        bh=32Dyk/hnYKXbkSTD+0XGzrBbDpEETte5HuuCckT159c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MLF0C6ve2dKFFNSaPLfTmfBJtVBXGmpenB1RXnh3m40KcwxVkXScb1bTjZ5RhI9A/
         0B0yEQ97KtOuAKRORcD5v3d8NJgOdW6nuty6iiTsFokQukx6/U+dZIg0QWanMirv8n
         so3xrmVIm98RZQ5bjY61g4+Vrd+dpddt18Jt/XQ34r54lDlaPJ+/Zhy0troFACR30x
         rS032EukqsV3R5t0IVXHF0WeISZXZAGFhnh+Z84Fr2yQ33t7Czv8Isxm++/ETKDH8f
         qqlo8Fw1W0aHzRJymvJ9lAeaK4xprZINPD+TVFXSAo+XUpOR/o+kFFy59p+hm2xfsK
         LdWgWsq8oP1iw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Hersen Wu <hersenxs.wu@amd.com>,
        Qingqing Zhuo <Qingqing.Zhuo@amd.com>,
        Qingqing Zhuo <qingqing.zhuo@amd.com>,
        Daniel Wheeler <daniel.wheeler@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, harry.wentland@amd.com,
        sunpeng.li@amd.com, Rodrigo.Siqueira@amd.com,
        christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com,
        daniel@ffwll.ch, aurabindo.pillai@amd.com, hdegoede@redhat.com,
        stylon.wang@amd.com, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.3 05/11] drm/amd/display: fix memleak in aconnector->timing_requested
Date:   Thu, 11 May 2023 15:37:48 -0400
Message-Id: <20230511193757.623114-5-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230511193757.623114-1-sashal@kernel.org>
References: <20230511193757.623114-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hersen Wu <hersenxs.wu@amd.com>

[ Upstream commit 025ce392b5f213696ca0af3e07735d0fae020694 ]

[Why]
when amdgpu_dm_update_connector_after_detect is called
two times successively with valid sink, memory allocated of
aconnector->timing_requested for the first call is not free.
this causes memeleak.

[How]
allocate memory only when aconnector->timing_requested
is null.

Reviewed-by: Qingqing Zhuo <Qingqing.Zhuo@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Hersen Wu <hersenxs.wu@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index a01fd41643fc2..5dced13f4ae8d 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -3094,9 +3094,12 @@ void amdgpu_dm_update_connector_after_detect(
 						    aconnector->edid);
 		}
 
-		aconnector->timing_requested = kzalloc(sizeof(struct dc_crtc_timing), GFP_KERNEL);
-		if (!aconnector->timing_requested)
-			dm_error("%s: failed to create aconnector->requested_timing\n", __func__);
+		if (!aconnector->timing_requested) {
+			aconnector->timing_requested =
+				kzalloc(sizeof(struct dc_crtc_timing), GFP_KERNEL);
+			if (!aconnector->timing_requested)
+				dm_error("failed to create aconnector->requested_timing\n");
+		}
 
 		drm_connector_update_edid_property(connector, aconnector->edid);
 		amdgpu_dm_update_freesync_caps(connector, aconnector->edid);
-- 
2.39.2

