Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5684B6A4B37
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 20:37:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230222AbjB0ThN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 14:37:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230182AbjB0ThB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 14:37:01 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77B0626860;
        Mon, 27 Feb 2023 11:36:31 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id cp7-20020a17090afb8700b0023756229427so11270085pjb.1;
        Mon, 27 Feb 2023 11:36:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2hrRR+74wlbtFKJjI1vePCtLY+UXSH6ONksg5TtlCrQ=;
        b=ZgI3xUvsC8eoOc7I4Py64awS2DJ2+wg6ioRtOJmNhnTlQaoPbrRKnsX9V1TIw9UDwu
         Ue3x1CGF6b0DLfDJpaReKLB27UfoUJ58T5b3NyX40icCvf1vTlZldKjJvcgsszIm2ucx
         xgPj++X2E9vko7dsqWj6eGzt2kNrDkmFBgRVb4RpFSGs8G83MYl0z2UAbiGEqvnVSeaQ
         FyiFwohXdg1nClk+Uz62LSDHUZxfB/Nrmoi3hG/hiWlpHkIgKNku6/d0WILMpWZHOGIX
         2r/ZPRGrJurvm3mYl8V/geq4sNb02kYH8aRWUSgKGKzrOg6Zrn+ktO1F9WZf1/vyU8RK
         jFRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2hrRR+74wlbtFKJjI1vePCtLY+UXSH6ONksg5TtlCrQ=;
        b=vRg2xfwdDd9OEVx0BksPAwXgG0TsJ7RM0q8H7jl7uX0i0tpc01WhrtdOgV8i3yVnED
         7iSsmeb824rNgC2OXIbnZTry0P/8ffdT/eQb49TZCM2KNHlrOOEVI8mgfbB73TjiZCKD
         AR/pZJ/4cE73lnut+krW7W9akWCGRNER9bl/oMNJQ4tbTpGfZ9B85i14gC1j6y0aALF6
         AaOL8tv+T/kPpAxu7ViC9PzXjAok/ITVoIaAUmoBB49UKdo5KnyCYLBhyBbtOEbr9HS0
         nx946hL6WNw5T2Kj1KFIRd8E/wPIwIre9Cyu7640kWYz9JA5lduQe++na3SF4+OvHnfR
         UtVQ==
X-Gm-Message-State: AO0yUKVq6G0Bbf2yEhERldqH8aJ46ajRjmuAj0zhqdT2jnnizBYHAFzg
        sg/pyrhgOtzggyZsa+kxg18=
X-Google-Smtp-Source: AK7set/iHm/pa4BOJh52yq5ccDN/6smBG259ieEdaE8ikLcGABkiG2tXYxHILc0sq6Q8GoQkT7wmRA==
X-Received: by 2002:a17:90a:345:b0:236:75d3:fedc with SMTP id 5-20020a17090a034500b0023675d3fedcmr403161pjf.8.1677526587042;
        Mon, 27 Feb 2023 11:36:27 -0800 (PST)
Received: from localhost ([2a00:79e1:abd:4a00:61b:48ed:72ab:435b])
        by smtp.gmail.com with ESMTPSA id o8-20020a17090a3d4800b00233ebab3770sm4815295pjf.23.2023.02.27.11.36.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Feb 2023 11:36:26 -0800 (PST)
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
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Vinod Polimera <quic_vpolimer@quicinc.com>,
        Liu Shixin <liushixin2@huawei.com>,
        linux-arm-msm@vger.kernel.org (open list:DRM DRIVER FOR MSM ADRENO GPU),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v7 14/15] drm/msm/atomic: Switch to vblank_start helper
Date:   Mon, 27 Feb 2023 11:35:20 -0800
Message-Id: <20230227193535.2822389-15-robdclark@gmail.com>
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

Drop our custom thing and switch to drm_crtc_next_vblank_start() for
calculating the time of the start of the next vblank period.

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c | 15 ---------------
 drivers/gpu/drm/msm/msm_atomic.c        |  8 +++++---
 drivers/gpu/drm/msm/msm_kms.h           |  8 --------
 3 files changed, 5 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
index a683bd9b5a04..43996aecaf8c 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
@@ -411,20 +411,6 @@ static void dpu_kms_disable_commit(struct msm_kms *kms)
 	pm_runtime_put_sync(&dpu_kms->pdev->dev);
 }
 
-static ktime_t dpu_kms_vsync_time(struct msm_kms *kms, struct drm_crtc *crtc)
-{
-	struct drm_encoder *encoder;
-
-	drm_for_each_encoder_mask(encoder, crtc->dev, crtc->state->encoder_mask) {
-		ktime_t vsync_time;
-
-		if (dpu_encoder_vsync_time(encoder, &vsync_time) == 0)
-			return vsync_time;
-	}
-
-	return ktime_get();
-}
-
 static void dpu_kms_prepare_commit(struct msm_kms *kms,
 		struct drm_atomic_state *state)
 {
@@ -953,7 +939,6 @@ static const struct msm_kms_funcs kms_funcs = {
 	.irq             = dpu_core_irq,
 	.enable_commit   = dpu_kms_enable_commit,
 	.disable_commit  = dpu_kms_disable_commit,
-	.vsync_time      = dpu_kms_vsync_time,
 	.prepare_commit  = dpu_kms_prepare_commit,
 	.flush_commit    = dpu_kms_flush_commit,
 	.wait_flush      = dpu_kms_wait_flush,
diff --git a/drivers/gpu/drm/msm/msm_atomic.c b/drivers/gpu/drm/msm/msm_atomic.c
index 1686fbb611fd..de7ce17489cc 100644
--- a/drivers/gpu/drm/msm/msm_atomic.c
+++ b/drivers/gpu/drm/msm/msm_atomic.c
@@ -186,8 +186,7 @@ void msm_atomic_commit_tail(struct drm_atomic_state *state)
 	struct msm_kms *kms = priv->kms;
 	struct drm_crtc *async_crtc = NULL;
 	unsigned crtc_mask = get_crtc_mask(state);
-	bool async = kms->funcs->vsync_time &&
-			can_do_async(state, &async_crtc);
+	bool async = can_do_async(state, &async_crtc);
 
 	trace_msm_atomic_commit_tail_start(async, crtc_mask);
 
@@ -231,7 +230,9 @@ void msm_atomic_commit_tail(struct drm_atomic_state *state)
 
 			kms->pending_crtc_mask |= crtc_mask;
 
-			vsync_time = kms->funcs->vsync_time(kms, async_crtc);
+			if (!drm_crtc_next_vblank_start(async_crtc, &vsync_time))
+				goto fallback;
+
 			wakeup_time = ktime_sub(vsync_time, ms_to_ktime(1));
 
 			msm_hrtimer_queue_work(&timer->work, wakeup_time,
@@ -253,6 +254,7 @@ void msm_atomic_commit_tail(struct drm_atomic_state *state)
 		return;
 	}
 
+fallback:
 	/*
 	 * If there is any async flush pending on updated crtcs, fold
 	 * them into the current flush.
diff --git a/drivers/gpu/drm/msm/msm_kms.h b/drivers/gpu/drm/msm/msm_kms.h
index f8ed7588928c..086a3f1ff956 100644
--- a/drivers/gpu/drm/msm/msm_kms.h
+++ b/drivers/gpu/drm/msm/msm_kms.h
@@ -59,14 +59,6 @@ struct msm_kms_funcs {
 	void (*enable_commit)(struct msm_kms *kms);
 	void (*disable_commit)(struct msm_kms *kms);
 
-	/**
-	 * If the kms backend supports async commit, it should implement
-	 * this method to return the time of the next vsync.  This is
-	 * used to determine a time slightly before vsync, for the async
-	 * commit timer to run and complete an async commit.
-	 */
-	ktime_t (*vsync_time)(struct msm_kms *kms, struct drm_crtc *crtc);
-
 	/**
 	 * Prepare for atomic commit.  This is called after any previous
 	 * (async or otherwise) commit has completed.
-- 
2.39.1

