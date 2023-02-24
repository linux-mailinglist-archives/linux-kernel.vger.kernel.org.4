Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4ABC6A22E5
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 21:02:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbjBXUCy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 15:02:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbjBXUCg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 15:02:36 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D83A86A799
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 12:02:19 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id ko13so594771plb.13
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 12:02:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tP53Gyn1BqvvyHDZxZgbpzYxVq0KGIuaeYcLElpQeo4=;
        b=LsUyN3pcLbpBQMwjeBISBDSfO/Ldh83Cf9X4Rn5TTdCP1nUUiULbIACR87hhvnQ7Qx
         S/BfCbIIV8dmVP6UE248OG17EMFOznbRCIRCCeHLBywQBYvgCJ0QesDVPNJo/wnNAwd2
         ltEnqgPXt7/IW2eT3HOFgP6PuTAoJJy9E0gESbSK9mQmNlX+7/wyNbKM4Dwr2qgDLxOt
         175fX/3Wv3xL7dBJuw47zG3AZrJ4KDfHuOwlWfOQgkzfmGkOdAOCm8k9VhqCCKT+yPu8
         XdZH3wnXlPtcwutntMBrVr5VAYSstntrI7JELRpmdmhORYynnlGjbTqnrGvENtvlBjav
         X/hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tP53Gyn1BqvvyHDZxZgbpzYxVq0KGIuaeYcLElpQeo4=;
        b=8RqFCFncjCgVfBLAHlxmplB4tLNHeoRuxlkX5Y2RWwlX9gD6whY8HXblQ06DmoSrvB
         MORWwi5Nvb6CRPHjfgBzq6N2kTgnoDzUNSatRSEGwypRsnKDLFnvhCXzT1xaNNLIQeQW
         3P/S6UbWTy9k0HkBw7Dv426Vz6xQ/LYs7zkAJTp3TFJ5knhxYEAiU/pItmWkCEoRP43N
         MbRKBljmtCtGSYTGCIfn+Ew5u2jiXB+whriortjjllklYtWDp+KMb+2Tjy9pBLb5jf6/
         D1YFvIPdOTaca1X1X1RHWF9kA26wH3wX8QozR/rqF5w3o2yjTxaMI35IoJ/8K89Wi0Tw
         fGHA==
X-Gm-Message-State: AO0yUKXJ3L+HvhXNqWYrH1nQdhINhvaOMeVQR1hyec6oFEj+ESQZ4j7h
        xFq2PjlhIciL0d/jvImzoY8=
X-Google-Smtp-Source: AK7set/IKmJxzVBTzX7dMZ3LGzjWCOBg+cG5XHYE1Otx7SzOyn/sO9COyW0Uldi87E/qRO3wZTuxPA==
X-Received: by 2002:a17:902:f549:b0:19c:90d2:c909 with SMTP id h9-20020a170902f54900b0019c90d2c909mr16992848plf.42.1677268938998;
        Fri, 24 Feb 2023 12:02:18 -0800 (PST)
Received: from localhost ([2a00:79e1:abd:4a00:61b:48ed:72ab:435b])
        by smtp.gmail.com with ESMTPSA id p22-20020a170902a41600b0019a723a831dsm5951840plq.158.2023.02.24.12.02.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 12:02:18 -0800 (PST)
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
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v6 10/15] drm/vblank: Add helper to get next vblank time
Date:   Fri, 24 Feb 2023 12:01:38 -0800
Message-Id: <20230224200155.2510320-11-robdclark@gmail.com>
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

Will be used in the next commit to set a deadline on fences that an
atomic update is waiting on.

v2: Calculate time at *start* of vblank period, not end

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/drm_vblank.c | 52 +++++++++++++++++++++++++++++-------
 include/drm/drm_vblank.h     |  1 +
 2 files changed, 44 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/drm_vblank.c b/drivers/gpu/drm/drm_vblank.c
index 2ff31717a3de..47e578128a9a 100644
--- a/drivers/gpu/drm/drm_vblank.c
+++ b/drivers/gpu/drm/drm_vblank.c
@@ -844,10 +844,9 @@ bool drm_crtc_vblank_helper_get_vblank_timestamp(struct drm_crtc *crtc,
 EXPORT_SYMBOL(drm_crtc_vblank_helper_get_vblank_timestamp);
 
 /**
- * drm_get_last_vbltimestamp - retrieve raw timestamp for the most recent
- *                             vblank interval
- * @dev: DRM device
- * @pipe: index of CRTC whose vblank timestamp to retrieve
+ * drm_crtc_get_last_vbltimestamp - retrieve raw timestamp for the most
+ *                                  recent vblank interval
+ * @crtc: CRTC whose vblank timestamp to retrieve
  * @tvblank: Pointer to target time which should receive the timestamp
  * @in_vblank_irq:
  *     True when called from drm_crtc_handle_vblank().  Some drivers
@@ -865,10 +864,9 @@ EXPORT_SYMBOL(drm_crtc_vblank_helper_get_vblank_timestamp);
  * True if timestamp is considered to be very precise, false otherwise.
  */
 static bool
-drm_get_last_vbltimestamp(struct drm_device *dev, unsigned int pipe,
-			  ktime_t *tvblank, bool in_vblank_irq)
+drm_crtc_get_last_vbltimestamp(struct drm_crtc *crtc, ktime_t *tvblank,
+			       bool in_vblank_irq)
 {
-	struct drm_crtc *crtc = drm_crtc_from_index(dev, pipe);
 	bool ret = false;
 
 	/* Define requested maximum error on timestamps (nanoseconds). */
@@ -876,8 +874,6 @@ drm_get_last_vbltimestamp(struct drm_device *dev, unsigned int pipe,
 
 	/* Query driver if possible and precision timestamping enabled. */
 	if (crtc && crtc->funcs->get_vblank_timestamp && max_error > 0) {
-		struct drm_crtc *crtc = drm_crtc_from_index(dev, pipe);
-
 		ret = crtc->funcs->get_vblank_timestamp(crtc, &max_error,
 							tvblank, in_vblank_irq);
 	}
@@ -891,6 +887,15 @@ drm_get_last_vbltimestamp(struct drm_device *dev, unsigned int pipe,
 	return ret;
 }
 
+static bool
+drm_get_last_vbltimestamp(struct drm_device *dev, unsigned int pipe,
+			  ktime_t *tvblank, bool in_vblank_irq)
+{
+	struct drm_crtc *crtc = drm_crtc_from_index(dev, pipe);
+
+	return drm_crtc_get_last_vbltimestamp(crtc, tvblank, in_vblank_irq);
+}
+
 /**
  * drm_crtc_vblank_count - retrieve "cooked" vblank counter value
  * @crtc: which counter to retrieve
@@ -980,6 +985,35 @@ u64 drm_crtc_vblank_count_and_time(struct drm_crtc *crtc,
 }
 EXPORT_SYMBOL(drm_crtc_vblank_count_and_time);
 
+/**
+ * drm_crtc_next_vblank_time - calculate the time of the next vblank
+ * @crtc: the crtc for which to calculate next vblank time
+ * @vblanktime: pointer to time to receive the next vblank timestamp.
+ *
+ * Calculate the expected time of the start of the next vblank period,
+ * based on time of previous vblank and frame duration
+ */
+int drm_crtc_next_vblank_start(struct drm_crtc *crtc, ktime_t *vblanktime)
+{
+	unsigned int pipe = drm_crtc_index(crtc);
+	struct drm_vblank_crtc *vblank = &crtc->dev->vblank[pipe];
+	struct drm_display_mode *mode = &vblank->hwmode;
+	u64 vblank_start;
+
+	if (!vblank->framedur_ns || !vblank->linedur_ns)
+		return -EINVAL;
+
+	if (!drm_crtc_get_last_vbltimestamp(crtc, vblanktime, false))
+		return -EINVAL;
+
+	vblank_start = (u64)vblank->framedur_ns * mode->crtc_vblank_start /
+			mode->crtc_vtotal;
+	*vblanktime  = ktime_add(*vblanktime, ns_to_ktime(vblank_start));
+
+	return 0;
+}
+EXPORT_SYMBOL(drm_crtc_next_vblank_start);
+
 static void send_vblank_event(struct drm_device *dev,
 		struct drm_pending_vblank_event *e,
 		u64 seq, ktime_t now)
diff --git a/include/drm/drm_vblank.h b/include/drm/drm_vblank.h
index 733a3e2d1d10..7f3957943dd1 100644
--- a/include/drm/drm_vblank.h
+++ b/include/drm/drm_vblank.h
@@ -230,6 +230,7 @@ bool drm_dev_has_vblank(const struct drm_device *dev);
 u64 drm_crtc_vblank_count(struct drm_crtc *crtc);
 u64 drm_crtc_vblank_count_and_time(struct drm_crtc *crtc,
 				   ktime_t *vblanktime);
+int drm_crtc_next_vblank_start(struct drm_crtc *crtc, ktime_t *vblanktime);
 void drm_crtc_send_vblank_event(struct drm_crtc *crtc,
 			       struct drm_pending_vblank_event *e);
 void drm_crtc_arm_vblank_event(struct drm_crtc *crtc,
-- 
2.39.1

