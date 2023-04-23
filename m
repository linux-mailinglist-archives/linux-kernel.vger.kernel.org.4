Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCFED6EC08A
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Apr 2023 16:50:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230471AbjDWOuW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Apr 2023 10:50:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230459AbjDWOuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Apr 2023 10:50:15 -0400
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA67010FB
        for <linux-kernel@vger.kernel.org>; Sun, 23 Apr 2023 07:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=uJMJ+NQtZ0XpbgcU5B6V/mq7bccUXUSsHINPFl3Guj4=; b=IhYMosca0wZ+B+VisCfWEo1sGl
        2lQqN8jG09ZDejv+mI53UicwpH5fMnjrZ7Qb1/2dEKmd1yy8nzkvK5Smrs5Qs5WkHkJBoDmHf7AXh
        dlFAcJyDtpRMTgve+Hn1N7bZgZFmywRF/8ixSlzrFpgc403gIrKQBwen7HpIZWEDuAvrIEIUTJGgj
        /YmI1sY85xnZ+R1ppu+GGQV3wFqCyEREfiAwopG5AiSOs2UJIObEJ4Pf9H1xEaGDXDfC7X2yToqGc
        Lk4A819xB5lK1Pt7F++wJ6WUqOg6Z3Z+XzMdwPWZEv/pK6DyL5Fda3ja7GU4gse57Nis3N+nvF2yr
        QZA5shMQ==;
Received: from nat-wifi.fi.muni.cz ([147.251.43.9] helo=killbill.fi.muni.cz)
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
        id 1pqaTA-00ANVs-Ad; Sun, 23 Apr 2023 16:13:36 +0200
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
Subject: [RFC PATCH 30/40] drm/amd/display: mark plane as needing reset if plane color mgmt changes
Date:   Sun, 23 Apr 2023 13:10:42 -0100
Message-Id: <20230423141051.702990-31-mwen@igalia.com>
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

We took a similar path for CRTC color mgmt changes, since we remap CRTC
degamma to plane/DPP block. Here we can use the status of
`plane->color_mgmt_changed` to detect when a plane color property
changed and recreate the plane accordingly.

Co-developed-by: Joshua Ashton <joshua@froggi.es>
Signed-off-by: Joshua Ashton <joshua@froggi.es>
Signed-off-by: Melissa Wen <mwen@igalia.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 760080e4a4da..1dac311cab67 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -9441,6 +9441,9 @@ static bool should_reset_plane(struct drm_atomic_state *state,
 	if (drm_atomic_crtc_needs_modeset(new_crtc_state))
 		return true;
 
+	if (new_plane_state->color_mgmt_changed)
+		return true;
+
 	/*
 	 * If there are any new primary or overlay planes being added or
 	 * removed then the z-order can potentially change. To ensure
-- 
2.39.2

