Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 972F369D4CA
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 21:20:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232108AbjBTUUB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 15:20:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231534AbjBTUTl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 15:19:41 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCF97212B4
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 12:19:34 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id p5so1191110pgh.11
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 12:19:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9yF21jz9Wf1+ysDiZnumY8mp3PUToyh/n6nr/hm38/k=;
        b=lvipANIQsaWNUdRbi8p53cd5scp9HEL/FMz/zPxLfgMuJrmChNXU1njroAo0j8QUNN
         +hlen5sr+/XlUz7mobPetUYmDMzXSNLJrUPKnh29D1Oe1gt7UA/iMSbTqVMY8WPKXQnl
         iTP3MCe3Oqph3l6oWVrJgwsziBvVvw2yEPlsRrwp+2Edme83jB88NYVxOFJ/PSU1QtR4
         l01R8SxajC7MaZCCwKkDzkW1IdX/heJI4xKNG4ossix0v+4yU2OzbAp3wExHMxl+tb9N
         aQLW40Rb6GqF0QAcRrPdzGncMPL1PvgmzemEC4C2f/c2lIVyqUUlR9mRKjblXmakm623
         bcyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9yF21jz9Wf1+ysDiZnumY8mp3PUToyh/n6nr/hm38/k=;
        b=TJvd69wtBj/p6sizTrww/69zzEjpUGRyQ9ukz5Kf1JdxAGrkOAF/My+kc7i+JklpLO
         gjX47MpBray6AXj30uJGQXOPIAn475W/Q21E0038Ov3gakPgOphVTDDMy2YGqFrZDQZp
         IEQIOa6qYZZFydOfS7sBoH+sgSCwBgKh3IEhQjYnFnoSf7UAGJMAW+blsFiHihY0jfYV
         UKUB05EUxh0qM3agqKjRcG48SxDd1Gq+VsOhiYy7gY57x73TzHLcp7SQNqWF9TUgYn37
         p8ei6gCR61XiLGb+XdH9wFRfBSZfU63CM6SVgY8bp3CxroQQWkENIEyZSXumRL451O7r
         UBQA==
X-Gm-Message-State: AO0yUKU5bFbrQfPrYF+n+GbRF0v4pxbC0IRUU6TA8SoIoJQpjDzirs5s
        ku0t/4dBsf82JpCDGr9h3tg=
X-Google-Smtp-Source: AK7set+/m0Mqndnwo3/kdSSWJI3dteVdKvTtFzD7FJZbcVYsVjIK/CX8AqRRPuz2ghIlApBRtj94IQ==
X-Received: by 2002:a05:6a00:409a:b0:5ad:8c9:2c9a with SMTP id bw26-20020a056a00409a00b005ad08c92c9amr1811318pfb.11.1676924373807;
        Mon, 20 Feb 2023 12:19:33 -0800 (PST)
Received: from localhost (c-73-67-135-195.hsd1.or.comcast.net. [73.67.135.195])
        by smtp.gmail.com with ESMTPSA id z8-20020aa791c8000000b005a8a4665d3bsm2070875pfa.116.2023.02.20.12.19.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Feb 2023 12:19:33 -0800 (PST)
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
Subject: [PATCH v5 11/14] drm/atomic-helper: Set fence deadline for vblank
Date:   Mon, 20 Feb 2023 12:18:58 -0800
Message-Id: <20230220201916.1822214-12-robdclark@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230220201916.1822214-1-robdclark@gmail.com>
References: <20230220201916.1822214-1-robdclark@gmail.com>
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

