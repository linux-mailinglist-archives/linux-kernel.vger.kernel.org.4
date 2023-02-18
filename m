Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 160B369BC6D
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 22:17:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbjBRVRc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Feb 2023 16:17:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbjBRVQd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Feb 2023 16:16:33 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD78A15C82;
        Sat, 18 Feb 2023 13:16:05 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id 21so319343plg.8;
        Sat, 18 Feb 2023 13:16:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JsqKhysyjry5mR87QHTfoSePPgw92sCbt0Ck69L5/uk=;
        b=fdqRVzGUTW2Lylj8ptJ8toY2v6E2ELgrc8C8ilcJUZ/kWsyPrOCCgQdLF+kfCIID3d
         1yO9rav+tObLxcCflTXMXXJl/q5dB+0YsloZdSqf45hZF7HC9gHfhGaw+mPtrlO+bt4m
         iEwSaUeDE//+Jw2o8V4PDqoX/9WP7WqY57r4BlulvwXO+2mGolrHFjLYLfG6SE5rsCWd
         FUbiWHBPoS0KTibR65rb2rP9Sqx/RFWW8FBI7AZiXRVMQCVLfUFFHAQF00Gqw6+Oynw0
         uG7o6WGK7t/sfWs8eSza5ClmJ69N2tkQtrfznMed39wwS+8P4C56iZZfSK/TXUUvMIUL
         jrVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JsqKhysyjry5mR87QHTfoSePPgw92sCbt0Ck69L5/uk=;
        b=Lt03KKYxl2LKp3JcmeV5eE2MXqokQfM1FRlC2YNrJKoTsU+g5qf/P1y+smn6YLrm1v
         m2Fspn4GaWCNm1uNAg0i2gM+/3e3T/SR9+rNuv9US7K+SOdPlwQUa0KKEOmK+xRwobBH
         PMGgjBs+ZbqQQxfrbgShkeHoekTFmWGzMsFbgAjc4rzYl40y1c98ugCQznQw+jVoh+oO
         mZjTmw9Pj9JwhEhAwCLg1D9cL3pvv65VrLyRnd6Cz4HwEC1YhN5cIam31NLOQXnIpcKd
         YTn+Ccb3letXJwfmacCae9wvlW+bi/PpPq0ABWgQ7lSSLZAotmQv/kndQ5Bp09AlCgcr
         lPaA==
X-Gm-Message-State: AO0yUKUYZ+/cHtTfJHKd3OcYCTWhA2o+uvErpc/l2HPxHYI+rUwsd4hC
        kfJrzRkSqzovoZASAD+vbBA=
X-Google-Smtp-Source: AK7set+E5bi4hUVjrj1G0GZ5TsGbo0N5rmpLKCrZ3Kk67JhED8tmWFS6Fjjlgd7iA3PZt/W4m6gieA==
X-Received: by 2002:a17:902:ea12:b0:199:4be8:be48 with SMTP id s18-20020a170902ea1200b001994be8be48mr2315956plg.19.1676754965011;
        Sat, 18 Feb 2023 13:16:05 -0800 (PST)
Received: from localhost (c-73-67-135-195.hsd1.or.comcast.net. [73.67.135.195])
        by smtp.gmail.com with ESMTPSA id z13-20020a1709027e8d00b00198fe021f93sm5047709pla.77.2023.02.18.13.16.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Feb 2023 13:16:04 -0800 (PST)
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
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        linux-arm-msm@vger.kernel.org (open list:DRM DRIVER FOR MSM ADRENO GPU),
        linux-kernel@vger.kernel.org (open list),
        linux-media@vger.kernel.org (open list:DMA BUFFER SHARING FRAMEWORK),
        linaro-mm-sig@lists.linaro.org (moderated list:DMA BUFFER SHARING
        FRAMEWORK)
Subject: [PATCH v4 12/14] drm/msm: Add deadline based boost support
Date:   Sat, 18 Feb 2023 13:15:55 -0800
Message-Id: <20230218211608.1630586-13-robdclark@gmail.com>
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

Track the nearest deadline on a fence timeline and set a timer to expire
shortly before to trigger boost if the fence has not yet been signaled.

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/msm/msm_drv.c   |  4 +-
 drivers/gpu/drm/msm/msm_fence.c | 74 +++++++++++++++++++++++++++++++++
 drivers/gpu/drm/msm/msm_fence.h | 20 +++++++++
 3 files changed, 97 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
index aca48c868c14..be2a68f8e78d 100644
--- a/drivers/gpu/drm/msm/msm_drv.c
+++ b/drivers/gpu/drm/msm/msm_drv.c
@@ -1065,7 +1065,9 @@ static const struct drm_driver msm_driver = {
 				DRIVER_RENDER |
 				DRIVER_ATOMIC |
 				DRIVER_MODESET |
-				DRIVER_SYNCOBJ,
+				DRIVER_SYNCOBJ |
+				DRIVER_SYNCOBJ_DEADLINE |
+				0,
 	.open               = msm_open,
 	.postclose           = msm_postclose,
 	.lastclose          = drm_fb_helper_lastclose,
diff --git a/drivers/gpu/drm/msm/msm_fence.c b/drivers/gpu/drm/msm/msm_fence.c
index 56641408ea74..51b461f32103 100644
--- a/drivers/gpu/drm/msm/msm_fence.c
+++ b/drivers/gpu/drm/msm/msm_fence.c
@@ -8,6 +8,35 @@
 
 #include "msm_drv.h"
 #include "msm_fence.h"
+#include "msm_gpu.h"
+
+static struct msm_gpu *fctx2gpu(struct msm_fence_context *fctx)
+{
+	struct msm_drm_private *priv = fctx->dev->dev_private;
+	return priv->gpu;
+}
+
+static enum hrtimer_restart deadline_timer(struct hrtimer *t)
+{
+	struct msm_fence_context *fctx = container_of(t,
+			struct msm_fence_context, deadline_timer);
+
+	kthread_queue_work(fctx2gpu(fctx)->worker, &fctx->deadline_work);
+
+	return HRTIMER_NORESTART;
+}
+
+static void deadline_work(struct kthread_work *work)
+{
+	struct msm_fence_context *fctx = container_of(work,
+			struct msm_fence_context, deadline_work);
+
+	/* If deadline fence has already passed, nothing to do: */
+	if (msm_fence_completed(fctx, fctx->next_deadline_fence))
+		return;
+
+	msm_devfreq_boost(fctx2gpu(fctx), 2);
+}
 
 
 struct msm_fence_context *
@@ -36,6 +65,13 @@ msm_fence_context_alloc(struct drm_device *dev, volatile uint32_t *fenceptr,
 	fctx->completed_fence = fctx->last_fence;
 	*fctx->fenceptr = fctx->last_fence;
 
+	hrtimer_init(&fctx->deadline_timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS);
+	fctx->deadline_timer.function = deadline_timer;
+
+	kthread_init_work(&fctx->deadline_work, deadline_work);
+
+	fctx->next_deadline = ktime_get();
+
 	return fctx;
 }
 
@@ -62,6 +98,8 @@ void msm_update_fence(struct msm_fence_context *fctx, uint32_t fence)
 	spin_lock_irqsave(&fctx->spinlock, flags);
 	if (fence_after(fence, fctx->completed_fence))
 		fctx->completed_fence = fence;
+	if (msm_fence_completed(fctx, fctx->next_deadline_fence))
+		hrtimer_cancel(&fctx->deadline_timer);
 	spin_unlock_irqrestore(&fctx->spinlock, flags);
 }
 
@@ -92,10 +130,46 @@ static bool msm_fence_signaled(struct dma_fence *fence)
 	return msm_fence_completed(f->fctx, f->base.seqno);
 }
 
+static void msm_fence_set_deadline(struct dma_fence *fence, ktime_t deadline)
+{
+	struct msm_fence *f = to_msm_fence(fence);
+	struct msm_fence_context *fctx = f->fctx;
+	unsigned long flags;
+	ktime_t now;
+
+	spin_lock_irqsave(&fctx->spinlock, flags);
+	now = ktime_get();
+
+	if (ktime_after(now, fctx->next_deadline) ||
+			ktime_before(deadline, fctx->next_deadline)) {
+		fctx->next_deadline = deadline;
+		fctx->next_deadline_fence =
+			max(fctx->next_deadline_fence, (uint32_t)fence->seqno);
+
+		/*
+		 * Set timer to trigger boost 3ms before deadline, or
+		 * if we are already less than 3ms before the deadline
+		 * schedule boost work immediately.
+		 */
+		deadline = ktime_sub(deadline, ms_to_ktime(3));
+
+		if (ktime_after(now, deadline)) {
+			kthread_queue_work(fctx2gpu(fctx)->worker,
+					&fctx->deadline_work);
+		} else {
+			hrtimer_start(&fctx->deadline_timer, deadline,
+					HRTIMER_MODE_ABS);
+		}
+	}
+
+	spin_unlock_irqrestore(&fctx->spinlock, flags);
+}
+
 static const struct dma_fence_ops msm_fence_ops = {
 	.get_driver_name = msm_fence_get_driver_name,
 	.get_timeline_name = msm_fence_get_timeline_name,
 	.signaled = msm_fence_signaled,
+	.set_deadline = msm_fence_set_deadline,
 };
 
 struct dma_fence *
diff --git a/drivers/gpu/drm/msm/msm_fence.h b/drivers/gpu/drm/msm/msm_fence.h
index 7f1798c54cd1..cdaebfb94f5c 100644
--- a/drivers/gpu/drm/msm/msm_fence.h
+++ b/drivers/gpu/drm/msm/msm_fence.h
@@ -52,6 +52,26 @@ struct msm_fence_context {
 	volatile uint32_t *fenceptr;
 
 	spinlock_t spinlock;
+
+	/*
+	 * TODO this doesn't really deal with multiple deadlines, like
+	 * if userspace got multiple frames ahead.. OTOH atomic updates
+	 * don't queue, so maybe that is ok
+	 */
+
+	/** next_deadline: Time of next deadline */
+	ktime_t next_deadline;
+
+	/**
+	 * next_deadline_fence:
+	 *
+	 * Fence value for next pending deadline.  The deadline timer is
+	 * canceled when this fence is signaled.
+	 */
+	uint32_t next_deadline_fence;
+
+	struct hrtimer deadline_timer;
+	struct kthread_work deadline_work;
 };
 
 struct msm_fence_context * msm_fence_context_alloc(struct drm_device *dev,
-- 
2.39.1

