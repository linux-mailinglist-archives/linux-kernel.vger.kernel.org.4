Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2A9369BC5F
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 22:17:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbjBRVRJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Feb 2023 16:17:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbjBRVQO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Feb 2023 16:16:14 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08BC416AF6
        for <linux-kernel@vger.kernel.org>; Sat, 18 Feb 2023 13:16:03 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id a5-20020a17090a70c500b00236679bc70cso13890pjm.4
        for <linux-kernel@vger.kernel.org>; Sat, 18 Feb 2023 13:16:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9yF21jz9Wf1+ysDiZnumY8mp3PUToyh/n6nr/hm38/k=;
        b=o3KZu6xCZhOx8yKLO3mCPTkTO6tIsRYmbOCGeJBqVniPc0jFqnNjoHWeefirhtUCQD
         TMs4eZTOs8KhFyvy1g7Y9zc5kpRNWaU+YjrhCI0IjZKJHAefvOW94v4Dvkm0LEbtvHuu
         vzxcd1WXm9wrdxUdbR7dY2ZQ2XClD6c5Gn77V1jB543GNPc7fQn2yq5/fobhwsvghKil
         2LcGEX1LDJhLA9cS8/Eq6f+d05FvrxWhwhn9n4RxA6yLI8lNL9gy4vMuECMYp3adFLxY
         jFsUaLS6DZPqaOrW6zXMPOxhyfe3J7t7Zryk/soeD4VzpBWEKQhlxetBTVeAudYUDL07
         N2HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9yF21jz9Wf1+ysDiZnumY8mp3PUToyh/n6nr/hm38/k=;
        b=ER5O0dccRNFodLe0PK7DA3sALzY2i3XSk+sLnXmc6H0fCTSopIt1zyoeZN24WsG6Bv
         EMrQQ8OrQQhB1X1tWf2KDaxU6bkk0vhDaUI6ySIJMRqdvhW697Vil8RH+xhfkM6bDfkn
         6DbXEBHWjekDBBVfIQxZ6NJLFjRZUU4iQpl3uHOr0CWco1shjLDtCndHhVwrsbTpixQ5
         h8tsOOnLOd5+R9AvmKkFMLdKb4nkaR/yYNFBe1YNyfgLRv8d5wavBDUrzgwvmoLNnLfx
         wdLtJIOLDgLbwaOWCqNTsj77paRTKYcOwnlb5r3B6Jmh2pMsZH9EoLUBxJ5lEMWn2Gck
         6FWg==
X-Gm-Message-State: AO0yUKVedwMJpd9AGFIyXgn8Bvx9VL/MPQCVU2O1YlCxS+1DGOvVNQEw
        9cSFS3DjKDL6dP49gdMTRLaKL2rjYWI=
X-Google-Smtp-Source: AK7set/CikEflsQKGjABB3qCsM3+X57SWJofwv3VcrtlhsrKcTwjJR9A6EG4N9La9GuATGYrx2hX2w==
X-Received: by 2002:a17:902:cf52:b0:19a:7c7d:7180 with SMTP id e18-20020a170902cf5200b0019a7c7d7180mr3479908plg.34.1676754963579;
        Sat, 18 Feb 2023 13:16:03 -0800 (PST)
Received: from localhost (c-73-67-135-195.hsd1.or.comcast.net. [73.67.135.195])
        by smtp.gmail.com with ESMTPSA id i3-20020a170902c28300b0019251e959b1sm5033341pld.262.2023.02.18.13.16.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Feb 2023 13:16:03 -0800 (PST)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     freedreno@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= 
        <ckoenig.leichtzumerken@gmail.com>,
        =?UTF-8?q?Michel=20D=C3=A4nzer?= <michel@daenzer.net>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Pekka Paalanen <ppaalanen@gmail.com>,
        Simon Ser <contact@emersion.fr>,
        Rob Clark <robdclark@chromium.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4 11/14] drm/atomic-helper: Set fence deadline for vblank
Date:   Sat, 18 Feb 2023 13:15:54 -0800
Message-Id: <20230218211608.1630586-12-robdclark@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230218211608.1630586-1-robdclark@gmail.com>
References: <20230218211608.1630586-1-robdclark@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rob Clark <robdclark@chromium.org>

For an atomic commit updating a single CRTC (ie. a pageflip) calculate
the next vblank time, and inform the fence(s) of that deadline.

v2: Comment typo fix (danvet)

Signed-off-by: Rob Clark <robdclark@chromium.org>
Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/drm_atomic_helper.c | 36 +++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
index d579fd8f7cb8..35a4dc714920 100644
--- a/drivers/gpu/drm/drm_atomic_helper.c
+++ b/drivers/gpu/drm/drm_atomic_helper.c
@@ -1511,6 +1511,40 @@ void drm_atomic_helper_commit_modeset_enables(struct drm_device *dev,
 }
 EXPORT_SYMBOL(drm_atomic_helper_commit_modeset_enables);
 
+/*
+ * For atomic updates which touch just a single CRTC, calculate the time of the
+ * next vblank, and inform all the fences of the deadline.
+ */
+static void set_fence_deadline(struct drm_device *dev,
+			       struct drm_atomic_state *state)
+{
+	struct drm_crtc *crtc, *wait_crtc = NULL;
+	struct drm_crtc_state *new_crtc_state;
+	struct drm_plane *plane;
+	struct drm_plane_state *new_plane_state;
+	ktime_t vbltime;
+	int i;
+
+	for_each_new_crtc_in_state (state, crtc, new_crtc_state, i) {
+		if (wait_crtc)
+			return;
+		wait_crtc = crtc;
+	}
+
+	/* If no CRTCs updated, then nothing to do: */
+	if (!wait_crtc)
+		return;
+
+	if (drm_crtc_next_vblank_time(wait_crtc, &vbltime))
+		return;
+
+	for_each_new_plane_in_state (state, plane, new_plane_state, i) {
+		if (!new_plane_state->fence)
+			continue;
+		dma_fence_set_deadline(new_plane_state->fence, vbltime);
+	}
+}
+
 /**
  * drm_atomic_helper_wait_for_fences - wait for fences stashed in plane state
  * @dev: DRM device
@@ -1540,6 +1574,8 @@ int drm_atomic_helper_wait_for_fences(struct drm_device *dev,
 	struct drm_plane_state *new_plane_state;
 	int i, ret;
 
+	set_fence_deadline(dev, state);
+
 	for_each_new_plane_in_state(state, plane, new_plane_state, i) {
 		if (!new_plane_state->fence)
 			continue;
-- 
2.39.1

