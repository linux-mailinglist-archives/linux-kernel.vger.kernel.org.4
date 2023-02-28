Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8422C6A6349
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 00:00:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230123AbjB1XAI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 18:00:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbjB1W7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 17:59:40 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAD5637F11;
        Tue, 28 Feb 2023 14:59:14 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id h8so8807818plf.10;
        Tue, 28 Feb 2023 14:59:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677625151;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e0nD4m6G0f9CfPGzBReP4EZd5C0mCrWqHJ9ftGkbyJg=;
        b=gUA/NmJlbxgtGNRvdFcfO9PfFQFNVypjuJ9W3yppmy0ZggF+18qkZZWR4aQ63qwdr/
         Yj1TGSyn3eZbef73fCCtBwSrc1CkS4P5ALb0XNpNNlSyIrh25NkdEq7hqgzRLMlvnO4I
         TqfzA5ERQbMw9kC+Xb+00pmLu/XYsF34v9jd1CZZJ+NcvHNzVKTpAFs072Dhnlm0Hy1q
         ftmU+RHuggF2s94pTyGySQLEQOqg9tcnNwfaJCVMKQC/mhSUcSseLxhBuvNSH4MgSG5J
         EQIYVae5DT25QnQP/zWnqLuUrCX3l3c4dQ3zX7Cg2jIr6ny4hF2lfTH6S6LgHjolrW6g
         VUuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677625151;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e0nD4m6G0f9CfPGzBReP4EZd5C0mCrWqHJ9ftGkbyJg=;
        b=chzJVIbDq2jksLMKX1gkPzYFXknMrThX6T/3Wn6lPyiHBsmMjIRJzIZpPqmiueeH4Z
         VsebZ4eU+bT95DJ7zhNRYEO6RvDH8+tb/dW3weekG92VOfcZ5jRFxmB99yC4M348oQyl
         Ua5BojhaJRDvVitfWvcJi/jLkLpMpYY7cdZbKZJWjSvk0VEgUYqv8dG9XMWC7oKH585i
         FCUDc5ld0JeiaC4b8J7fK8vveLyyyS6N1f6UPjvs0w+avX/MFdqQtFNjzWJvH7GOkY2m
         MOt025RK2JtCUa+pzYDTVJvIGsW/Pq6LCjulINKdpubaJdDFd2R7jAa75mPtuWbWMiTr
         2QcA==
X-Gm-Message-State: AO0yUKXttXyLKimL8QZp1LSld3FYomOu6Xm4lcnh41guoPasgK5r1JEA
        ty92Kqozvbf20x8xqVcvQ8g=
X-Google-Smtp-Source: AK7set/jLbFEjK+nfqFYTgyaKwy4NH2PI3B02lebHRLtpVzfVAHrM3iXehckhrlAUofwzr4gGEqDLg==
X-Received: by 2002:a17:903:27cd:b0:19c:a6ba:69f6 with SMTP id km13-20020a17090327cd00b0019ca6ba69f6mr3780498plb.31.1677625150956;
        Tue, 28 Feb 2023 14:59:10 -0800 (PST)
Received: from localhost ([2a00:79e1:abd:4a00:61b:48ed:72ab:435b])
        by smtp.gmail.com with ESMTPSA id u9-20020a17090282c900b0019472226769sm6992784plz.251.2023.02.28.14.59.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 14:59:10 -0800 (PST)
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
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vinod Polimera <quic_vpolimer@quicinc.com>,
        Douglas Anderson <dianders@chromium.org>,
        Liu Shixin <liushixin2@huawei.com>,
        linux-arm-msm@vger.kernel.org (open list:DRM DRIVER FOR MSM ADRENO GPU),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v8 15/16] drm/msm/atomic: Switch to vblank_start helper
Date:   Tue, 28 Feb 2023 14:58:19 -0800
Message-Id: <20230228225833.2920879-16-robdclark@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230228225833.2920879-1-robdclark@gmail.com>
References: <20230228225833.2920879-1-robdclark@gmail.com>
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
index 1686fbb611fd..c5e71c05f038 100644
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
+			if (drm_crtc_next_vblank_start(async_crtc, &vsync_time))
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

