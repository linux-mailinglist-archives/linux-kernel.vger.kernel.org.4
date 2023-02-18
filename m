Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 051AC69BC5D
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 22:17:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbjBRVRG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Feb 2023 16:17:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229897AbjBRVQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Feb 2023 16:16:10 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE7CD13D7E
        for <linux-kernel@vger.kernel.org>; Sat, 18 Feb 2023 13:16:02 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id j10so703975pfn.4
        for <linux-kernel@vger.kernel.org>; Sat, 18 Feb 2023 13:16:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Jl0bAAXIZTjQ7NsDAeqTzIEhvjQzgg5/X7BsK4u81Y=;
        b=Ypm3OEaEuberWEEJkwjckxIjd/fHXeD+UsK2sNxPfOh4VXSeIeHxGyby2GuFmyckgB
         DPDPfvmi2uvJ7m2w9ZXK3H1Ekv2+II/tBc0aGXy3LefRYqgovm0DXtFUG/3/66OJN4iE
         YqOAZ7tRtVL4IMhiN+VmmAehUqGvglfHf9UTRFLCXJlwg8IMcrNqpT87lm7YhFL2srhA
         /yf3cvPBlakDzzA63dLpzDbxyi8W6tpPJBgG/p8y808RF05uk0cx38i6cB7r5fBCuZdJ
         JXI1niL29wo25W9KmsKxhyFpm2IP/w+0LZnJz4MIoDp2aP//Ap8lQlE41lyS6/oyFtPJ
         1IUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5Jl0bAAXIZTjQ7NsDAeqTzIEhvjQzgg5/X7BsK4u81Y=;
        b=UncEU8NVXfzQzhrsxsy+WaZUBEfEEO4c6fwSP/Rc1N8SoFFSdhB3PZbP0L9qymnucA
         Jlifjmn66EA+OjxnGJOQwGIGqs7Jgn/v9J1MRuUQI9BoUr3XjRrXCqIJG6CrbE/KxCNw
         QWvLOLyK4gKFN7H8rDK7ZdL21n6UCRciDhy6HLuLvAFmm6d1WlvL10xLdXwW+XM1iA/Z
         J1iOORyrX2RnVchbE8yny8KUBk3dPmD8qXse2u/sM6v/++S/hKf35NMHgTs4bNE09Dt6
         XfbZWoam/keZFfPG8PY5zMxQJPTgzwitEQfeu9y9vs+iUu1Ir3S36YfDtAHvNpuGOz6u
         gmyA==
X-Gm-Message-State: AO0yUKXkUqVyuoH2FE/VFBH7dO9YIyBJ/sdEA83/471Z8Hj6uYtqPmYn
        9hnxXq/2R7vN0/8G8HwArW4=
X-Google-Smtp-Source: AK7set9pC4wrkPL0tafLapsDNCmKgteFtOwdub9yogT8Dwsv0vCa2ZO4cR/0UWRxya11wooq0NMxTA==
X-Received: by 2002:a05:6a00:4106:b0:5a8:9858:750a with SMTP id bu6-20020a056a00410600b005a89858750amr9007439pfb.13.1676754962150;
        Sat, 18 Feb 2023 13:16:02 -0800 (PST)
Received: from localhost (c-73-67-135-195.hsd1.or.comcast.net. [73.67.135.195])
        by smtp.gmail.com with ESMTPSA id s26-20020aa78d5a000000b0058dbb5c5038sm4957450pfe.182.2023.02.18.13.16.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Feb 2023 13:16:01 -0800 (PST)
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
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4 10/14] drm/vblank: Add helper to get next vblank time
Date:   Sat, 18 Feb 2023 13:15:53 -0800
Message-Id: <20230218211608.1630586-11-robdclark@gmail.com>
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

Will be used in the next commit to set a deadline on fences that an
atomic update is waiting on.

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/drm_vblank.c | 32 ++++++++++++++++++++++++++++++++
 include/drm/drm_vblank.h     |  1 +
 2 files changed, 33 insertions(+)

diff --git a/drivers/gpu/drm/drm_vblank.c b/drivers/gpu/drm/drm_vblank.c
index 2ff31717a3de..caf25ebb34c5 100644
--- a/drivers/gpu/drm/drm_vblank.c
+++ b/drivers/gpu/drm/drm_vblank.c
@@ -980,6 +980,38 @@ u64 drm_crtc_vblank_count_and_time(struct drm_crtc *crtc,
 }
 EXPORT_SYMBOL(drm_crtc_vblank_count_and_time);
 
+/**
+ * drm_crtc_next_vblank_time - calculate the time of the next vblank
+ * @crtc: the crtc for which to calculate next vblank time
+ * @vblanktime: pointer to time to receive the next vblank timestamp.
+ *
+ * Calculate the expected time of the next vblank based on time of previous
+ * vblank and frame duration
+ */
+int drm_crtc_next_vblank_time(struct drm_crtc *crtc, ktime_t *vblanktime)
+{
+	unsigned int pipe = drm_crtc_index(crtc);
+	struct drm_vblank_crtc *vblank = &crtc->dev->vblank[pipe];
+	u64 count;
+
+	if (!vblank->framedur_ns)
+		return -EINVAL;
+
+	count = drm_vblank_count_and_time(crtc->dev, pipe, vblanktime);
+
+	/*
+	 * If we don't get a valid count, then we probably also don't
+	 * have a valid time:
+	 */
+	if (!count)
+		return -EINVAL;
+
+	*vblanktime = ktime_add(*vblanktime, ns_to_ktime(vblank->framedur_ns));
+
+	return 0;
+}
+EXPORT_SYMBOL(drm_crtc_next_vblank_time);
+
 static void send_vblank_event(struct drm_device *dev,
 		struct drm_pending_vblank_event *e,
 		u64 seq, ktime_t now)
diff --git a/include/drm/drm_vblank.h b/include/drm/drm_vblank.h
index 733a3e2d1d10..a63bc2c92f3c 100644
--- a/include/drm/drm_vblank.h
+++ b/include/drm/drm_vblank.h
@@ -230,6 +230,7 @@ bool drm_dev_has_vblank(const struct drm_device *dev);
 u64 drm_crtc_vblank_count(struct drm_crtc *crtc);
 u64 drm_crtc_vblank_count_and_time(struct drm_crtc *crtc,
 				   ktime_t *vblanktime);
+int drm_crtc_next_vblank_time(struct drm_crtc *crtc, ktime_t *vblanktime);
 void drm_crtc_send_vblank_event(struct drm_crtc *crtc,
 			       struct drm_pending_vblank_event *e);
 void drm_crtc_arm_vblank_event(struct drm_crtc *crtc,
-- 
2.39.1

