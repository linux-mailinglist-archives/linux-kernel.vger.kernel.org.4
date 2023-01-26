Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7950667D1C6
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 17:36:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231682AbjAZQgd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 11:36:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231523AbjAZQgb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 11:36:31 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3E8B6B9A2
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 08:36:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 39A91618D3
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 16:36:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DACFAC433D2;
        Thu, 26 Jan 2023 16:36:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674750971;
        bh=NHe7c07kpgMGuREH7WhzPdLzzHD/XoCu9aMEENUsRB8=;
        h=From:To:Cc:Subject:Date:From;
        b=Jq6Mu7X3Hczk8L8xJev1HNltLPLpnttt8192JQyVScT0Kl5l9lHE7IKY5InhnkXip
         orDbczFBsTVbdfrrtDFaZVac4GQjK4YPhbX/2xPHcTMHcBG+2vbSu8JaT7xsW/8CmC
         jLNwog3vS7+Cw2iZ/rMcobUqrowChSuEttq6XlnJeVTIrXgrfSYGPUciQqyqs4rh1C
         JRxhmCinFJy5V9r78IpLrGkshwkajTNXpKef9gbyfM5cEwyZZGhziVUeVNFinQAsnO
         nQPO4RIOoc8vKMIStOO994qTh8heSri8qd8H1ZmJwar+k+iRJHZajuZizdFKZEUvli
         SVWtx9/qme7pQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Roman Li <roman.li@amd.com>,
        Wayne Lin <Wayne.Lin@amd.com>,
        Aurabindo Pillai <aurabindo.pillai@amd.com>,
        Stylon Wang <stylon.wang@amd.com>,
        hersen wu <hersenxs.wu@amd.com>, Lyude Paul <lyude@redhat.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amdgpu/display/mst: fix an unused-variable warning
Date:   Thu, 26 Jan 2023 17:35:54 +0100
Message-Id: <20230126163605.3524630-1-arnd@kernel.org>
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

The newly added code is in an #ifdef, so the variables that
are only used in there cause a warning if CONFIG_DRM_AMD_DC_DCN
is disabled:

drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c: In function 'amdgpu_dm_atomic_check':
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:9698:43: error: unused variable 'mst_state' [-Werror=unused-variable]
 9698 |         struct drm_dp_mst_topology_state *mst_state;
      |                                           ^~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:9697:41: error: unused variable 'mgr' [-Werror=unused-variable]
 9697 |         struct drm_dp_mst_topology_mgr *mgr;
      |                                         ^~~

Fixes: c689e1e362ea ("drm/amdgpu/display/mst: Fix mst_state->pbn_div and slot count assignments")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index be1232356f9e..c966bb05f6c7 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -9694,8 +9694,10 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
 	struct drm_connector_state *old_con_state, *new_con_state;
 	struct drm_crtc *crtc;
 	struct drm_crtc_state *old_crtc_state, *new_crtc_state;
+#if defined(CONFIG_DRM_AMD_DC_DCN)
 	struct drm_dp_mst_topology_mgr *mgr;
 	struct drm_dp_mst_topology_state *mst_state;
+#endif
 	struct drm_plane *plane;
 	struct drm_plane_state *old_plane_state, *new_plane_state;
 	enum dc_status status;
-- 
2.39.0

