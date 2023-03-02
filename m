Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D7DE6A8D9F
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 00:55:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbjCBXy7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 18:54:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230203AbjCBXyu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 18:54:50 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B177618A84
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 15:54:21 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id d10so472878pgt.12
        for <linux-kernel@vger.kernel.org>; Thu, 02 Mar 2023 15:54:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677801260;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ip3Zm9fB4YGz5nKO4uRGWvdUBo1kk9r+HbO76l3v604=;
        b=NPnuc36DwWV6jfH6r3yVJ4b59Wf35Duqu6e1nD7BgWf2yneUDE6kVoCoE+xb389eMT
         EZ/ikHqIomQkk+RGfyNR+DzhA8rz5MR99SlyiJPrYYe1dkFP8OF1LpL+bjCISYGfsAnW
         eXzV6jM2sM5KOmtQjt29kK+XX2RXrDudysKCCUDXIvydIFPw7ydGZ+GKydpRuA25pQDy
         fsJa+0QwtfU+3uPb5Di9+IJSFSO01jcMmUW1ignhuMUv9igemtSrGFTwGp8BjbkxblaH
         kICCw+tMtNgLFdrlyzQ/tWg6WEXNm2A6NcVFZvv9qnxSnyb2vrlh5z8g294FUtDwh2lu
         04NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677801260;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ip3Zm9fB4YGz5nKO4uRGWvdUBo1kk9r+HbO76l3v604=;
        b=b167EF+ePZQbL8pc9rV+g6ufUry+6JS7O7duJUCIYoUhmBAAUazxYnmdeq53v5LZKl
         0w6awXnqxzvcD0CEdxIhcFHj9uZSS0gslxcc7n1kEzhSUnPBbDrZFKphpIOWh9dW6arf
         uMQtAcNChpM1dCTTIhfOdvgoD0wGoalhaZ1M43C7akw5h3TqWTxNVmE92ednjOTlx5Z/
         KIMxCxCGyQZlKSBn8wAkfcS5Q8AhpVInztN1F2gvB2h6t1AV7SIszPquqqHoXC28c8R7
         NlyKOqzSvfc8q3pEBB2wZkXiAsLW9If83Mahkv03TNFdEa4PkAhF8lvzNfE1DRnMrcXa
         FTqA==
X-Gm-Message-State: AO0yUKVc+02gjZ7xwDd/qfdCsEPv8rjg13UrTv+MGcCW0I9K3e2xaXqo
        fb0gJcxvRvblaVoaxvYJD8I=
X-Google-Smtp-Source: AK7set9ewq8g2UINVf25gy6LzGcHT8o0VBZ0takvw3RJyEoTXa7FhIG3EiWkXQhyiXUYSioIGvwevg==
X-Received: by 2002:a62:1741:0:b0:5b9:49a5:5ddc with SMTP id 62-20020a621741000000b005b949a55ddcmr262457pfx.3.1677801260254;
        Thu, 02 Mar 2023 15:54:20 -0800 (PST)
Received: from localhost ([2a00:79e1:abd:4a00:61b:48ed:72ab:435b])
        by smtp.gmail.com with ESMTPSA id u4-20020aa78484000000b00575d1ba0ecfsm234624pfn.133.2023.03.02.15.54.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 15:54:19 -0800 (PST)
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
        Mario Kleiner <mario.kleiner.de@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v9 10/15] drm/vblank: Add helper to get next vblank time
Date:   Thu,  2 Mar 2023 15:53:32 -0800
Message-Id: <20230302235356.3148279-11-robdclark@gmail.com>
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

Will be used in the next commit to set a deadline on fences that an
atomic update is waiting on.

v2: Calculate time at *start* of vblank period, not end
v3: Fix kbuild complaints

Signed-off-by: Rob Clark <robdclark@chromium.org>
Reviewed-by: Mario Kleiner <mario.kleiner.de@gmail.com>
---
 drivers/gpu/drm/drm_vblank.c | 53 ++++++++++++++++++++++++++++++------
 include/drm/drm_vblank.h     |  1 +
 2 files changed, 45 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/drm_vblank.c b/drivers/gpu/drm/drm_vblank.c
index 2ff31717a3de..299fa2a19a90 100644
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
@@ -980,6 +985,36 @@ u64 drm_crtc_vblank_count_and_time(struct drm_crtc *crtc,
 }
 EXPORT_SYMBOL(drm_crtc_vblank_count_and_time);
 
+/**
+ * drm_crtc_next_vblank_start - calculate the time of the next vblank
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
+	vblank_start = DIV_ROUND_DOWN_ULL(
+			(u64)vblank->framedur_ns * mode->crtc_vblank_start,
+			mode->crtc_vtotal);
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

