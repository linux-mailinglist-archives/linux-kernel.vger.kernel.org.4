Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CF9E6A22EE
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 21:03:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbjBXUDC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 15:03:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229922AbjBXUCi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 15:02:38 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE7076F034
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 12:02:21 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id n5so109747pfv.11
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 12:02:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MXVtv6kxe3TDMQ2pw6mJDt0CFb+4GUA2rpUfR00AfQQ=;
        b=aPE3MZ7QQuZoD5+LGINDsHbNmjt8oh652eQP/MXvfbKHVNHLGY2jMwu+RXp/nZ1aUh
         g14nAqn6FmzLtuvzwD7Xgtmw4UNDm6/qkBIofrbKtJPGvcy1djnYWaSlvUXeW7QTWBWY
         JMoU8IwGO0Si3emDqozuVcZC9GHt+mVLZLE2No2WRIwDcGPd3ps6XCvr9ufX7cY9+qoj
         adAZY/y9dZK40ujexAfEZIZgkdUVJ9kAtedOfS50mbfjBQ1KP4Nykc/5pNbCWpbkaMdi
         wFRLzDExT6pMeHikZU1jt0g9sRjXXBl5U1/Nn3hrTHfduKrXexv2tFOtqp70nSACZYXk
         nCVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MXVtv6kxe3TDMQ2pw6mJDt0CFb+4GUA2rpUfR00AfQQ=;
        b=xCfj6vze0mBnSnoHi/vb0eoPJcu4ZBayduxCj7UVYmwFETqzA9yIvV8n0xAUWAkgzB
         yqb3YFt7BioQWzaNNnSHeQM9+sC6XK0wxok0cJfxKaQt5igsDJyKYZeClL8wRCX8SeT7
         ew7neuhfGn508vVRZCFbtgho4/3VlluDWZSdeAk6U6DYrFLfCsKoGSXRYriUcwburTLR
         UD9fRNjpYlGG1ktwA14GR4fHJ1ZDC4RjNIKdXJLgmZImGqVKzsDdDn1ljwDV+6/1DyGf
         4bvK4tU2czdVgAMu1QOYu3fklt79ETgHbHTHDCl+TbhetNLJHKnhvGztBhwxyZwZFR7t
         K5ZA==
X-Gm-Message-State: AO0yUKXEHQoZpJOkUJ8PCXQD1Se+RqfEuZkS2UOabgtbCL0ZgJlp4dVx
        jaTMiREZzyzXvcS7+Lwto0w=
X-Google-Smtp-Source: AK7set8iCcnhfJ0pgKgYusRmBK5mKzDmKBZZZyguSD6rXOPY07ODicabelyFMwmH27l/yS1spJfo3Q==
X-Received: by 2002:a62:1dd0:0:b0:5aa:6125:dbf4 with SMTP id d199-20020a621dd0000000b005aa6125dbf4mr13512105pfd.11.1677268940762;
        Fri, 24 Feb 2023 12:02:20 -0800 (PST)
Received: from localhost ([2a00:79e1:abd:4a00:61b:48ed:72ab:435b])
        by smtp.gmail.com with ESMTPSA id h5-20020a62b405000000b005d6dff9bbecsm5223958pfn.62.2023.02.24.12.02.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 12:02:20 -0800 (PST)
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
        Luben Tuikov <luben.tuikov@amd.com>,
        Rob Clark <robdclark@chromium.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v6 11/15] drm/atomic-helper: Set fence deadline for vblank
Date:   Fri, 24 Feb 2023 12:01:39 -0800
Message-Id: <20230224200155.2510320-12-robdclark@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230224200155.2510320-1-robdclark@gmail.com>
References: <20230224200155.2510320-1-robdclark@gmail.com>
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
index d579fd8f7cb8..d8ee98ce2fc5 100644
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
+	if (drm_crtc_next_vblank_start(wait_crtc, &vbltime))
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

