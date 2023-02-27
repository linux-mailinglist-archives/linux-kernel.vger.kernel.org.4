Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E463A6A4B31
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 20:37:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbjB0ThF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 14:37:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbjB0Tgx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 14:36:53 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7260A28227
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 11:36:19 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id c23so7320450pjo.4
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 11:36:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MXVtv6kxe3TDMQ2pw6mJDt0CFb+4GUA2rpUfR00AfQQ=;
        b=Q0NqEufkMDZIkDjHCzybwLnsn4J9qQK3EtCROjv4c4CAc99HZTKvvfzkYXKjWYYoB6
         l7OazioTiiSTWaLSffa8Ed39GCqqqN5Ige+TFR5Qm1FAqyhCon6mIipzuo+RC3hAXo/Q
         v4plfWaeiZxbioPm6ZzrBzdQ7fw5LaMHtBq+zpK6oWiQVXnJZRL9vnoIc3iFLuS6V/q9
         we/iLpwdWXMFwHxzyBlAhJSfZg1BMPKoVLQW6Uo/lARIkblp310Zd/0O+V9vzK0kzP8E
         2v/koAkAULQHw0d9nwd7xNNu1DltzF+b72F7b7/cRA4fFOkdQ3U3AWWrkFnmew+T1tG9
         +cRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MXVtv6kxe3TDMQ2pw6mJDt0CFb+4GUA2rpUfR00AfQQ=;
        b=c+UFkzP7VEfQMO+IhZN/mq6yKs/aTidmKe4xD0BnZyEEPdhod8q0rpSXLY0F3CP+Qe
         O8zVwzBVRPurdecIww6g7ernF1ApaezVdvyN04J7tEEi6w8w2L8pMUyRuKG8XLtf6jBE
         3ooohL/MSRQeWjwHRY0DPcKL8zHR4X2MJfl0JBPKDR/6nPhq72QzbUPB6Dbt83xICvl3
         X7caBVHsb/G+6Qg0hA0w+tLGvfxbe3qrzzWaMxrkkOxHa0/4x+3cJHkR/VKb2JjfvnbK
         0mrLh685XFsS567NUgcyahfat7YohraEW+5H1uILNbFMqy20w/eQB0HjMOnUlJaXmVHo
         +j+w==
X-Gm-Message-State: AO0yUKWfh468nq+gCbiNklBVWCPcLeIqxMdwTFExnja71ujJz1LjcBEu
        2P1tErMtYzel5CXzvqJEaOg=
X-Google-Smtp-Source: AK7set88rQrrQrTTzWZUmg1ax7k5vgVzy2wFfdqhlnrfnAMYKgTWuBnItaDxtjqFcBrNhbLZ/dv5Xg==
X-Received: by 2002:a05:6a20:5499:b0:cd:52a:faf0 with SMTP id i25-20020a056a20549900b000cd052afaf0mr573957pzk.59.1677526575436;
        Mon, 27 Feb 2023 11:36:15 -0800 (PST)
Received: from localhost ([2a00:79e1:abd:4a00:61b:48ed:72ab:435b])
        by smtp.gmail.com with ESMTPSA id j8-20020aa78008000000b00575d1ba0ecfsm4592396pfi.133.2023.02.27.11.36.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Feb 2023 11:36:15 -0800 (PST)
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
Subject: [PATCH v7 11/15] drm/atomic-helper: Set fence deadline for vblank
Date:   Mon, 27 Feb 2023 11:35:17 -0800
Message-Id: <20230227193535.2822389-12-robdclark@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230227193535.2822389-1-robdclark@gmail.com>
References: <20230227193535.2822389-1-robdclark@gmail.com>
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

