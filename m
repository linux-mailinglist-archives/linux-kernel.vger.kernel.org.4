Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A76B9664FBC
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 00:15:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234011AbjAJXPD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 18:15:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233693AbjAJXOw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 18:14:52 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14F0812AC8;
        Tue, 10 Jan 2023 15:14:51 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id c8-20020a17090a4d0800b00225c3614161so18093300pjg.5;
        Tue, 10 Jan 2023 15:14:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1fS03OqrwR9oVGJDnDFSzCp6Jzur92K8MRGJGDZkBWQ=;
        b=U5+5benMPMUHeAqyaz1QfpL9sQnhOmm0oISqrJE1RSzI2wK2oIj4fRNblgnzjErdEh
         yT7zMZXegkJqaA3ILB0rlttiOoS8KBHvP7JNkTSoT2VnM7QgswGmKfylMU9wWWGsHWib
         1AJjhrt0MUfFlw/1lXxKxG1qDofbKBRc770fb0QE1bJykFrvMI1tXZhR03eakIrVtlNe
         m++Z6vfehqtDIpt9eVlwIQkD4y47nFxdJyGR7/DMahwGj+RKuuZ5OYh5FUFiyBMxWnii
         XCfNy3kJWxeuL3BvfYo6G2s1md/EZtPSUyhuDAxHnNpa/hrCm2cnSJjsypdSegO1QprS
         wJ7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1fS03OqrwR9oVGJDnDFSzCp6Jzur92K8MRGJGDZkBWQ=;
        b=hbsw7ntrBy7KYcDmgH+8zOYhs/LiCwv2p7vc7Y8E/UkIfx3JEsjANbHMai8vXhYT7Y
         Mo8tuncQCRoe97cMPlx2A++Kuy2yGy/+c6hQYrslviDJNQERDScS1XvcNsz6bMB6kp2u
         AZImHsORrO0+SQpgyvL7pQvJgI/l2CbDFgzVu1GFK/ysf+KeSO4xs0yfciW6fH+ZZS6K
         m2FqVXJerB7EAwdPaIEJ+gp6RuM0pxlT7sbdlNmj4c5Dh7RiHVi/1rGAqPSmn13P6QuG
         m5SMz6B8DjykOiBWmwUC915IryIfhXFUvlOSPYC4+Yu3yr+HMz+HnpGUAaMdVVhEd1ey
         S+Og==
X-Gm-Message-State: AFqh2krLjPBc0G3YOV8em6guwO0km+PNjrVzMi8TRtiZcaFLUNk7Qo1p
        Mh31D0v371ggOWNkrb0pytE=
X-Google-Smtp-Source: AMrXdXu705LWC3NY+vj9hg2FiCpt0+WPxiTXJZjgJ1tNmCX8U1V6FhAZz+mBiCIMz3bJfQ703Dps5w==
X-Received: by 2002:a17:902:7c17:b0:192:6b28:2b4e with SMTP id x23-20020a1709027c1700b001926b282b4emr57486780pll.69.1673392490481;
        Tue, 10 Jan 2023 15:14:50 -0800 (PST)
Received: from localhost ([2a00:79e1:abd:4a00:2703:3c72:eb1a:cffd])
        by smtp.gmail.com with ESMTPSA id p5-20020a170902bd0500b0019248880f75sm8666776pls.77.2023.01.10.15.14.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jan 2023 15:14:50 -0800 (PST)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Rob Clark <robdclark@chromium.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 2/3] drm/msm/gpu: Bypass PM QoS constraint for idle clamp
Date:   Tue, 10 Jan 2023 15:14:43 -0800
Message-Id: <20230110231447.1939101-3-robdclark@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230110231447.1939101-1-robdclark@gmail.com>
References: <20230110231447.1939101-1-robdclark@gmail.com>
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

Change idle freq clamping back to the direct method, bypassing PM QoS
requests.  The problem with using PM QoS requests is they call
(indirectly) the governors ->get_target_freq() which goes thru a
get_dev_status() cycle.  The problem comes when the GPU becomes active
again and we remove the idle-clamp request, we go through another
get_dev_status() cycle for the period that the GPU has been idle, which
triggers the governor to lower the target freq excessively.

This partially reverts commit 7c0ffcd40b16 ("drm/msm/gpu: Respect PM QoS
constraints"), but preserves the use of boost QoS request, so that it
will continue to play nicely with other QoS requests such as a cooling
device.  This also mostly undoes commit 78f815c1cf8f ("drm/msm: return the
average load over the polling period")

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/msm/msm_gpu.h         |  12 ++-
 drivers/gpu/drm/msm/msm_gpu_devfreq.c | 135 +++++++++++---------------
 2 files changed, 65 insertions(+), 82 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_gpu.h b/drivers/gpu/drm/msm/msm_gpu.h
index ab110c377916..fc1c0d8611a8 100644
--- a/drivers/gpu/drm/msm/msm_gpu.h
+++ b/drivers/gpu/drm/msm/msm_gpu.h
@@ -109,11 +109,15 @@ struct msm_gpu_devfreq {
 	struct mutex lock;
 
 	/**
-	 * idle_constraint:
+	 * idle_freq:
 	 *
-	 * A PM QoS constraint to limit max freq while the GPU is idle.
+	 * Shadow frequency used while the GPU is idle.  From the PoV of
+	 * the devfreq governor, we are continuing to sample busyness and
+	 * adjust frequency while the GPU is idle, but we use this shadow
+	 * value as the GPU is actually clamped to minimum frequency while
+	 * it is inactive.
 	 */
-	struct dev_pm_qos_request idle_freq;
+	unsigned long idle_freq;
 
 	/**
 	 * boost_constraint:
@@ -135,8 +139,6 @@ struct msm_gpu_devfreq {
 	/** idle_time: Time of last transition to idle: */
 	ktime_t idle_time;
 
-	struct devfreq_dev_status average_status;
-
 	/**
 	 * idle_work:
 	 *
diff --git a/drivers/gpu/drm/msm/msm_gpu_devfreq.c b/drivers/gpu/drm/msm/msm_gpu_devfreq.c
index 0d7ff7ddc029..e578d74d402f 100644
--- a/drivers/gpu/drm/msm/msm_gpu_devfreq.c
+++ b/drivers/gpu/drm/msm/msm_gpu_devfreq.c
@@ -33,6 +33,16 @@ static int msm_devfreq_target(struct device *dev, unsigned long *freq,
 
 	trace_msm_gpu_freq_change(dev_pm_opp_get_freq(opp));
 
+	/*
+	 * If the GPU is idle, devfreq is not aware, so just stash
+	 * the new target freq (to use when we return to active)
+	 */
+	if (df->idle_freq) {
+		df->idle_freq = *freq;
+		dev_pm_opp_put(opp);
+		return 0;
+	}
+
 	if (gpu->funcs->gpu_set_freq) {
 		mutex_lock(&df->lock);
 		gpu->funcs->gpu_set_freq(gpu, opp, df->suspended);
@@ -48,15 +58,26 @@ static int msm_devfreq_target(struct device *dev, unsigned long *freq,
 
 static unsigned long get_freq(struct msm_gpu *gpu)
 {
+	struct msm_gpu_devfreq *df = &gpu->devfreq;
+
+	/*
+	 * If the GPU is idle, use the shadow/saved freq to avoid
+	 * confusing devfreq (which is unaware that we are switching
+	 * to lowest freq until the device is active again)
+	 */
+	if (df->idle_freq)
+		return df->idle_freq;
+
 	if (gpu->funcs->gpu_get_freq)
 		return gpu->funcs->gpu_get_freq(gpu);
 
 	return clk_get_rate(gpu->core_clk);
 }
 
-static void get_raw_dev_status(struct msm_gpu *gpu,
+static int msm_devfreq_get_dev_status(struct device *dev,
 		struct devfreq_dev_status *status)
 {
+	struct msm_gpu *gpu = dev_to_gpu(dev);
 	struct msm_gpu_devfreq *df = &gpu->devfreq;
 	u64 busy_cycles, busy_time;
 	unsigned long sample_rate;
@@ -72,7 +93,7 @@ static void get_raw_dev_status(struct msm_gpu *gpu,
 	if (df->suspended) {
 		mutex_unlock(&df->lock);
 		status->busy_time = 0;
-		return;
+		return 0;
 	}
 
 	busy_cycles = gpu->funcs->gpu_busy(gpu, &sample_rate);
@@ -87,71 +108,6 @@ static void get_raw_dev_status(struct msm_gpu *gpu,
 		busy_time = ~0LU;
 
 	status->busy_time = busy_time;
-}
-
-static void update_average_dev_status(struct msm_gpu *gpu,
-		const struct devfreq_dev_status *raw)
-{
-	struct msm_gpu_devfreq *df = &gpu->devfreq;
-	const u32 polling_ms = df->devfreq->profile->polling_ms;
-	const u32 max_history_ms = polling_ms * 11 / 10;
-	struct devfreq_dev_status *avg = &df->average_status;
-	u64 avg_freq;
-
-	/* simple_ondemand governor interacts poorly with gpu->clamp_to_idle.
-	 * When we enforce the constraint on idle, it calls get_dev_status
-	 * which would normally reset the stats.  When we remove the
-	 * constraint on active, it calls get_dev_status again where busy_time
-	 * would be 0.
-	 *
-	 * To remedy this, we always return the average load over the past
-	 * polling_ms.
-	 */
-
-	/* raw is longer than polling_ms or avg has no history */
-	if (div_u64(raw->total_time, USEC_PER_MSEC) >= polling_ms ||
-	    !avg->total_time) {
-		*avg = *raw;
-		return;
-	}
-
-	/* Truncate the oldest history first.
-	 *
-	 * Because we keep the history with a single devfreq_dev_status,
-	 * rather than a list of devfreq_dev_status, we have to assume freq
-	 * and load are the same over avg->total_time.  We can scale down
-	 * avg->busy_time and avg->total_time by the same factor to drop
-	 * history.
-	 */
-	if (div_u64(avg->total_time + raw->total_time, USEC_PER_MSEC) >=
-			max_history_ms) {
-		const u32 new_total_time = polling_ms * USEC_PER_MSEC -
-			raw->total_time;
-		avg->busy_time = div_u64(
-				mul_u32_u32(avg->busy_time, new_total_time),
-				avg->total_time);
-		avg->total_time = new_total_time;
-	}
-
-	/* compute the average freq over avg->total_time + raw->total_time */
-	avg_freq = mul_u32_u32(avg->current_frequency, avg->total_time);
-	avg_freq += mul_u32_u32(raw->current_frequency, raw->total_time);
-	do_div(avg_freq, avg->total_time + raw->total_time);
-
-	avg->current_frequency = avg_freq;
-	avg->busy_time += raw->busy_time;
-	avg->total_time += raw->total_time;
-}
-
-static int msm_devfreq_get_dev_status(struct device *dev,
-		struct devfreq_dev_status *status)
-{
-	struct msm_gpu *gpu = dev_to_gpu(dev);
-	struct devfreq_dev_status raw;
-
-	get_raw_dev_status(gpu, &raw);
-	update_average_dev_status(gpu, &raw);
-	*status = gpu->devfreq.average_status;
 
 	return 0;
 }
@@ -191,9 +147,6 @@ void msm_devfreq_init(struct msm_gpu *gpu)
 
 	mutex_init(&df->lock);
 
-	dev_pm_qos_add_request(&gpu->pdev->dev, &df->idle_freq,
-			       DEV_PM_QOS_MAX_FREQUENCY,
-			       PM_QOS_MAX_FREQUENCY_DEFAULT_VALUE);
 	dev_pm_qos_add_request(&gpu->pdev->dev, &df->boost_freq,
 			       DEV_PM_QOS_MIN_FREQUENCY, 0);
 
@@ -214,7 +167,6 @@ void msm_devfreq_init(struct msm_gpu *gpu)
 
 	if (IS_ERR(df->devfreq)) {
 		DRM_DEV_ERROR(&gpu->pdev->dev, "Couldn't initialize GPU devfreq\n");
-		dev_pm_qos_remove_request(&df->idle_freq);
 		dev_pm_qos_remove_request(&df->boost_freq);
 		df->devfreq = NULL;
 		return;
@@ -256,7 +208,6 @@ void msm_devfreq_cleanup(struct msm_gpu *gpu)
 
 	devfreq_cooling_unregister(gpu->cooling);
 	dev_pm_qos_remove_request(&df->boost_freq);
-	dev_pm_qos_remove_request(&df->idle_freq);
 }
 
 void msm_devfreq_resume(struct msm_gpu *gpu)
@@ -329,6 +280,7 @@ void msm_devfreq_active(struct msm_gpu *gpu)
 {
 	struct msm_gpu_devfreq *df = &gpu->devfreq;
 	unsigned int idle_time;
+	unsigned long target_freq;
 
 	if (!has_devfreq(gpu))
 		return;
@@ -338,8 +290,28 @@ void msm_devfreq_active(struct msm_gpu *gpu)
 	 */
 	cancel_idle_work(df);
 
+	/*
+	 * Hold devfreq lock to synchronize with get_dev_status()/
+	 * target() callbacks
+	 */
+	mutex_lock(&df->devfreq->lock);
+
+	target_freq = df->idle_freq;
+
 	idle_time = ktime_to_ms(ktime_sub(ktime_get(), df->idle_time));
 
+	df->idle_freq = 0;
+
+	/*
+	 * We could have become active again before the idle work had a
+	 * chance to run, in which case the df->idle_freq would have
+	 * still been zero.  In this case, no need to change freq.
+	 */
+	if (target_freq)
+		msm_devfreq_target(&gpu->pdev->dev, &target_freq, 0);
+
+	mutex_unlock(&df->devfreq->lock);
+
 	/*
 	 * If we've been idle for a significant fraction of a polling
 	 * interval, then we won't meet the threshold of busyness for
@@ -348,9 +320,6 @@ void msm_devfreq_active(struct msm_gpu *gpu)
 	if (idle_time > msm_devfreq_profile.polling_ms) {
 		msm_devfreq_boost(gpu, 2);
 	}
-
-	dev_pm_qos_update_request(&df->idle_freq,
-				  PM_QOS_MAX_FREQUENCY_DEFAULT_VALUE);
 }
 
 
@@ -360,11 +329,23 @@ static void msm_devfreq_idle_work(struct kthread_work *work)
 			struct msm_gpu_devfreq, idle_work.work);
 	struct msm_gpu *gpu = container_of(df, struct msm_gpu, devfreq);
 	struct msm_drm_private *priv = gpu->dev->dev_private;
+	unsigned long idle_freq, target_freq = 0;
 
-	df->idle_time = ktime_get();
+	/*
+	 * Hold devfreq lock to synchronize with get_dev_status()/
+	 * target() callbacks
+	 */
+	mutex_lock(&df->devfreq->lock);
+
+	idle_freq = get_freq(gpu);
 
 	if (priv->gpu_clamp_to_idle)
-		dev_pm_qos_update_request(&df->idle_freq, 0);
+		msm_devfreq_target(&gpu->pdev->dev, &target_freq, 0);
+
+	df->idle_time = ktime_get();
+	df->idle_freq = idle_freq;
+
+	mutex_unlock(&df->devfreq->lock);
 }
 
 void msm_devfreq_idle(struct msm_gpu *gpu)
-- 
2.38.1

