Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 504AF6A8D9E
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 00:55:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230105AbjCBXzC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 18:55:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbjCBXyw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 18:54:52 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C426C4ECE6
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 15:54:27 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id b20so528379pfo.6
        for <linux-kernel@vger.kernel.org>; Thu, 02 Mar 2023 15:54:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677801262;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MXVtv6kxe3TDMQ2pw6mJDt0CFb+4GUA2rpUfR00AfQQ=;
        b=Z61bfh00Rec8zY5KmfpfHiKo+C2+EC3BX+zxN86/3V50gTS1EA+yUmnvTqbEF5gU2o
         ue2/h/GeUQXz4CmaZG3BWbKWHplzMfNB8f0i3AXm32c5V25DzEhWkHABjVgEuXuqlrsE
         PfVcfkB8vgPByxFw8lj7KewXv+0Zi+kLga1mF5h5+/FdebTukkwwBgL5MP4NIR3nVhGA
         wBBjWaaPJ1PKzLiKFKuOdCdJOW7DYKuax/FSynCJeRJsfOswB5Plvm7XptszT7I9KXRF
         K446aSXTE3vqRlEXjp/7AlsoHI98maOY4kjkl1+C+0iu95/kZekWobxS+hvob6ScpD3K
         9UnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677801262;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MXVtv6kxe3TDMQ2pw6mJDt0CFb+4GUA2rpUfR00AfQQ=;
        b=cRlzS7NoRVyf9Znqsft/zfVcxr/sUKkcavRCirRtDHFbgypxUE6pSc/vlrXhbf4EV9
         1uDD1e9jLgFR1IZJ1IVgtJWus2e4MZ+X7xxtKRi0k1Rm9UiYinhuexBYPidXq4OTalUZ
         94Sa8V2IrWNfbvpixk0+52LEzRwBXVTF3rW40aOXizgVsuD6Egz+8oNFQVURo9UDi6kv
         0+48seVhhNhXBg2icJnQ4hdNXC7zB/j7ARtp+mtk0H1hZ4mwgfImWCIum1pRgwn+zGIn
         v5CD/ydOgojM4eXzskzfCmNw4rNBs/01ofsvf0B5AxyHujhPIyBB+3SaSLpmtEp5S4Kc
         RFqw==
X-Gm-Message-State: AO0yUKUqgGJ3P5izwy97BDHqcMVzF9bTUmfp5MJEYS/+SzL3ZTC/7NoU
        zuJukbsZY2LVAn+VTEX5ts4=
X-Google-Smtp-Source: AK7set/NIuV3qeeo1RK5MQFd9CggFAdL5hfgAIUNfnCuspzyu6Q6fMwz5vrHANFyeqfgydjNY+lvUg==
X-Received: by 2002:a62:1dd4:0:b0:5aa:6125:dbf4 with SMTP id d203-20020a621dd4000000b005aa6125dbf4mr186424pfd.11.1677801262188;
        Thu, 02 Mar 2023 15:54:22 -0800 (PST)
Received: from localhost ([2a00:79e1:abd:4a00:61b:48ed:72ab:435b])
        by smtp.gmail.com with ESMTPSA id n4-20020a62e504000000b005a8c92f7c27sm216478pff.212.2023.03.02.15.54.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 15:54:21 -0800 (PST)
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
Subject: [PATCH v9 11/15] drm/atomic-helper: Set fence deadline for vblank
Date:   Thu,  2 Mar 2023 15:53:33 -0800
Message-Id: <20230302235356.3148279-12-robdclark@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230302235356.3148279-1-robdclark@gmail.com>
References: <20230302235356.3148279-1-robdclark@gmail.com>
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

