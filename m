Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 998A36A6335
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 00:00:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbjB1W76 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 17:59:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229962AbjB1W7h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 17:59:37 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E046A37B6D
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 14:59:10 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id d6so6664474pgu.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 14:59:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677625144;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MXVtv6kxe3TDMQ2pw6mJDt0CFb+4GUA2rpUfR00AfQQ=;
        b=lDDwHWxzgKFhwd0FwReE0TTiiAb83G7jUQSBS/f/M/ntGYCYCd8W6ZE1LPU5UZFIvK
         dW9jk0CmhshvdSDV6ebPMrDie4K87JKDCYBx6yAdkn7YIDdYTNidnEypcjr6kUnHp7l6
         q7yEgWMJXTJ0okyiRpLxtDAiffSkCml69duEm+eHv6ML2SsYKC7nGugK6nD+U+hC0HYP
         QYe71BsjeCe+fxKCpqTh1LVoBHOROffRb82GSZ1+MCYPxncKipP74Xn90MpcXWep8YuL
         gyBpt2hhU9FqLm1Yv8L0iT8j+JmvCoDKxRxD/1yQka/7P9+KDkbyuXLg8RjRA2tVedoW
         26hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677625144;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MXVtv6kxe3TDMQ2pw6mJDt0CFb+4GUA2rpUfR00AfQQ=;
        b=TH0Ylz/BCCqacuGVrb5ocWaC9PMTZsYKRUeY/h+3crLAx0geXvz3NVgxOY1nVZTM1o
         GAeB1/ae8+wGAMhZhi9PA1BcLNPWzuuyYcUc2V7qkDyYX6q5sVvyGL0kPhZEouBjZWfd
         CHCWMu/TcLyHqRfLwUkYql2n+f1erKVsUx4VRPygMCboVi8c5mdo+uMC9DrH34xDBAs+
         SHV+4LfgwpLeG6NGTryKakzd48l6HwAGtbipJJZ0pwXHNyzBebEdmPZYhtUG2Ebg07/I
         jo+8fPGqrmMJJUbQi8+iS60UQ3D7y1/qVkaTxbvDfLJa0qwSj4XWBpeJjmJiNUZtabHg
         kOWg==
X-Gm-Message-State: AO0yUKXhkmGfP2M20GeXZQB0B2htU/+Sb/+md5jLTCKjgmQFmIt2x5qa
        6W4bpCgkkVkeeqKOEb7KgSs=
X-Google-Smtp-Source: AK7set/xiKOJMAsF8k79uT9+nXk0mQyBjzZTeb3SMFY0LqIjGj3yT0L/GjWCUIdSsqXfkTJLMrtaZQ==
X-Received: by 2002:aa7:8ec5:0:b0:5de:7ef1:d03a with SMTP id b5-20020aa78ec5000000b005de7ef1d03amr3394472pfr.19.1677625143747;
        Tue, 28 Feb 2023 14:59:03 -0800 (PST)
Received: from localhost ([2a00:79e1:abd:4a00:61b:48ed:72ab:435b])
        by smtp.gmail.com with ESMTPSA id w18-20020aa78592000000b005afda149679sm6703267pfn.179.2023.02.28.14.59.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 14:59:03 -0800 (PST)
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
Subject: [PATCH v8 12/16] drm/atomic-helper: Set fence deadline for vblank
Date:   Tue, 28 Feb 2023 14:58:16 -0800
Message-Id: <20230228225833.2920879-13-robdclark@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230228225833.2920879-1-robdclark@gmail.com>
References: <20230228225833.2920879-1-robdclark@gmail.com>
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

