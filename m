Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED8686B0DC3
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 16:55:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232285AbjCHPyt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 10:54:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232258AbjCHPyI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 10:54:08 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4BE9B4F43
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 07:53:52 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id p6so18140469plf.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 07:53:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678290831;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9QIRFXSCitL3iYkzZTpxHAB6gd/EN+fonFlEUv102Pg=;
        b=HosAqU4CHLNL9VOPgH3EzAyi783aVn7MePUYwtZnp8B42O3uvSedSD42LasqtJOcvN
         6ljD+/VZH0wkBikCkwVlSbIjihjiOB3vTEQq6VhVsnwSQO/7NQh+3I/KE0whaeBitflR
         iPtRCRH50rCjW8To2Q2AXpukPVruvWPhn3Dd8AyWkNjT55wLUXiro8jnjleC/XVxzeRW
         mYuwmq00QwaYHyeQAJXPh5qi1uSJgi3VBX3lwAqYTNaxX2OJYSX08drJElq6ed9AeVDv
         f7N1K8v1XfD7ocFAH1QlMo+5FVWJy1jv6qAvN5EOdQJey3aynSLn23UtijyDmuh4KmN8
         ZofA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678290831;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9QIRFXSCitL3iYkzZTpxHAB6gd/EN+fonFlEUv102Pg=;
        b=Z35YTT+BwkHQ4Pcx/bVi2Soy4lct4bPR2S3hQyDXOuzBvGD5q7W2fobS/9QCmpdkCx
         ZSgNRSYfthyapTqM5WoDvXadK/F40oIPqXAhYnEf1VYhGKShLl+6ZQ9p87PiHerRuDfa
         2iN6lHHTT5MHmCvoR5slqzkXp7QtO/IiHvDPnAvlIIe/d8ltz6R9Ib817PB53vcSGJDl
         3ythi3XjYa3XyhlQQaUPGzp3vtXp/J8OdCQS9O9CFyQGdttFn3K0+EBGIF9CCXPVKPKX
         QJ1nkW/bOqt861XmQZMINeiGdkealbZwyRuIOQFKZ6Knfo7bOSwSMa4n3pVlvMMyW+RN
         Yamw==
X-Gm-Message-State: AO0yUKWCnX26OY5M1fvdDXzcGRuyWuucpTAk4b5RSRVLZOUSlTeBhUHM
        FpyVkdrgK5zAY+BC9CY443o=
X-Google-Smtp-Source: AK7set8MIBhwU303RCiBfZw9A92NVJsMzpKbjyfLvi/1ZGST318Eyk1lSNOLJxtIDjmlEhJY7kG1VQ==
X-Received: by 2002:a17:903:1251:b0:19e:d60a:e9e with SMTP id u17-20020a170903125100b0019ed60a0e9emr9132560plh.42.1678290831597;
        Wed, 08 Mar 2023 07:53:51 -0800 (PST)
Received: from localhost ([2a00:79e1:abd:4a00:61b:48ed:72ab:435b])
        by smtp.gmail.com with ESMTPSA id kd13-20020a17090313cd00b0019a8e559345sm8518895plb.167.2023.03.08.07.53.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 07:53:51 -0800 (PST)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     freedreno@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        Luben Tuikov <luben.tuikov@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= 
        <ckoenig.leichtzumerken@gmail.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Matt Turner <mattst88@gmail.com>,
        Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>,
        Rob Clark <robdclark@chromium.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v10 11/15] drm/atomic-helper: Set fence deadline for vblank
Date:   Wed,  8 Mar 2023 07:53:02 -0800
Message-Id: <20230308155322.344664-12-robdclark@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230308155322.344664-1-robdclark@gmail.com>
References: <20230308155322.344664-1-robdclark@gmail.com>
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
v3: If there are multiple CRTCs, consider the time of the soonest vblank

Signed-off-by: Rob Clark <robdclark@chromium.org>
Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/drm_atomic_helper.c | 37 +++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
index d579fd8f7cb8..28e3f2c8917e 100644
--- a/drivers/gpu/drm/drm_atomic_helper.c
+++ b/drivers/gpu/drm/drm_atomic_helper.c
@@ -1511,6 +1511,41 @@ void drm_atomic_helper_commit_modeset_enables(struct drm_device *dev,
 }
 EXPORT_SYMBOL(drm_atomic_helper_commit_modeset_enables);
 
+/*
+ * For atomic updates which touch just a single CRTC, calculate the time of the
+ * next vblank, and inform all the fences of the deadline.
+ */
+static void set_fence_deadline(struct drm_device *dev,
+			       struct drm_atomic_state *state)
+{
+	struct drm_crtc *crtc;
+	struct drm_crtc_state *new_crtc_state;
+	struct drm_plane *plane;
+	struct drm_plane_state *new_plane_state;
+	ktime_t vbltime = 0;
+	int i;
+
+	for_each_new_crtc_in_state (state, crtc, new_crtc_state, i) {
+		ktime_t v;
+
+		if (drm_crtc_next_vblank_start(crtc, &v))
+			continue;
+
+		if (!vbltime || ktime_before(v, vbltime))
+			vbltime = v;
+	}
+
+	/* If no CRTCs updated, then nothing to do: */
+	if (!vbltime)
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
@@ -1540,6 +1575,8 @@ int drm_atomic_helper_wait_for_fences(struct drm_device *dev,
 	struct drm_plane_state *new_plane_state;
 	int i, ret;
 
+	set_fence_deadline(dev, state);
+
 	for_each_new_plane_in_state(state, plane, new_plane_state, i) {
 		if (!new_plane_state->fence)
 			continue;
-- 
2.39.2

