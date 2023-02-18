Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EC5569BC80
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 22:18:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230102AbjBRVSS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Feb 2023 16:18:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbjBRVRd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Feb 2023 16:17:33 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3318193E9;
        Sat, 18 Feb 2023 13:16:19 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id a20so1691798pls.2;
        Sat, 18 Feb 2023 13:16:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LJRWjyogOQnJ+5yTXZeR/CA8uKgjfGlQ9M7/4cay494=;
        b=HlVIEobOB1fK4orz/vfjScfvfTmsM2Ff4tRZMVa4xdM5sCf4zF5X+pa/NEvV0jRFap
         d96y+vkl2FVlKyaS9S7zCK5ePnuhaaEY0SmBx5WF6VNh/A+Ddw4lzPwCsRykF7v5tW+G
         j6OTAh+IKDR2F+7ntwLsA2YAPfoL15U9CCJgJRqqpH77DSuZ6QgB7jeDf4EuDi1zovoz
         WqdVKpv8e/55Xn9GYpUy3oewxQ91CfDFS/Ljoeg0C7AuiGQkPCu8IGY7ptZcCfOFyu0F
         3XanlgorSS20WKL00Ktx8XMMNFwITyfSWzjmfWs+jSzPH1rSFkjSLEdZ6yYHveznktpt
         eclw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LJRWjyogOQnJ+5yTXZeR/CA8uKgjfGlQ9M7/4cay494=;
        b=Dvcu7kZ+FlsBZPkbv7u1oRfTis3sKsfHlMIsvQoxTfI57zbgb2Ek6Xcp6uwftkPXjl
         z8mGCfwXLuxDOqtfnNzFr0gyOhwbu1zOIjBmn8pMOT9h31JLalSQAObSSAdIRr9EK4Ja
         skr3EDqKZUjHbHBxjLwr5Ra450+yNvlRhfi2S0MbJc0338QwDFPy7x1sxFtZ2Jl3/cMl
         Et0rfaXiYGMmfKrd6hhXB67YIc1mwFls5zlvVOo4eHCoo0mR7BrSSxduTU/vp5SnWYUN
         JCjN48DxeVpGzuxyrtHTxdUgsjPOBT/rKmpeZ17Q9NxIs0hCPlMOZcxx2kzfsvj+ai2Z
         nN3g==
X-Gm-Message-State: AO0yUKUtSFed5nCevRdP6Tbx/WfyVMzIn1lLb6DohWtDH3DGbiVD1778
        q5+qKDLNH9yy/cZaL4IIfbE=
X-Google-Smtp-Source: AK7set/0yqp/q3/jslTp6QxBhdRo+Dy4M24xdmTIftytbmsLtB5hmbelVCK/TX7kEgjPGP3InbTQCA==
X-Received: by 2002:a17:903:2447:b0:194:5c63:364c with SMTP id l7-20020a170903244700b001945c63364cmr1849203pls.62.1676754978760;
        Sat, 18 Feb 2023 13:16:18 -0800 (PST)
Received: from localhost (c-73-67-135-195.hsd1.or.comcast.net. [73.67.135.195])
        by smtp.gmail.com with ESMTPSA id ji11-20020a170903324b00b0019afb7a02a1sm4785944plb.218.2023.02.18.13.16.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Feb 2023 13:16:18 -0800 (PST)
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
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        intel-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org (open list),
        linux-media@vger.kernel.org (open list:DMA BUFFER SHARING FRAMEWORK),
        linaro-mm-sig@lists.linaro.org (moderated list:DMA BUFFER SHARING
        FRAMEWORK)
Subject: [PATCH v4 14/14] drm/i915: Add deadline based boost support
Date:   Sat, 18 Feb 2023 13:15:57 -0800
Message-Id: <20230218211608.1630586-15-robdclark@gmail.com>
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

Signed-off-by: Rob Clark <robdclark@chromium.org>
---

This should probably be re-written by someone who knows the i915
request/timeline stuff better, to deal with non-immediate deadlines.
But as-is I think this should be enough to handle the case where
we want syncobj waits to trigger boost.

 drivers/gpu/drm/i915/i915_driver.c  |  2 +-
 drivers/gpu/drm/i915/i915_request.c | 20 ++++++++++++++++++++
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/i915_driver.c b/drivers/gpu/drm/i915/i915_driver.c
index cf1c0970ecb4..bd40b7bcb38a 100644
--- a/drivers/gpu/drm/i915/i915_driver.c
+++ b/drivers/gpu/drm/i915/i915_driver.c
@@ -1781,7 +1781,7 @@ static const struct drm_driver i915_drm_driver = {
 	.driver_features =
 	    DRIVER_GEM |
 	    DRIVER_RENDER | DRIVER_MODESET | DRIVER_ATOMIC | DRIVER_SYNCOBJ |
-	    DRIVER_SYNCOBJ_TIMELINE,
+	    DRIVER_SYNCOBJ_TIMELINE | DRIVER_SYNCOBJ_DEADLINE,
 	.release = i915_driver_release,
 	.open = i915_driver_open,
 	.lastclose = i915_driver_lastclose,
diff --git a/drivers/gpu/drm/i915/i915_request.c b/drivers/gpu/drm/i915/i915_request.c
index 7503dcb9043b..44491e7e214c 100644
--- a/drivers/gpu/drm/i915/i915_request.c
+++ b/drivers/gpu/drm/i915/i915_request.c
@@ -97,6 +97,25 @@ static bool i915_fence_enable_signaling(struct dma_fence *fence)
 	return i915_request_enable_breadcrumb(to_request(fence));
 }
 
+static void i915_fence_set_deadline(struct dma_fence *fence, ktime_t deadline)
+{
+	struct i915_request *rq = to_request(fence);
+
+	if (i915_request_completed(rq))
+		return;
+
+	if (i915_request_started(rq))
+		return;
+
+	/*
+	 * TODO something more clever for deadlines that are in the
+	 * future.  I think probably track the nearest deadline in
+	 * rq->timeline and set timer to trigger boost accordingly?
+	 */
+
+	intel_rps_boost(rq);
+}
+
 static signed long i915_fence_wait(struct dma_fence *fence,
 				   bool interruptible,
 				   signed long timeout)
@@ -182,6 +201,7 @@ const struct dma_fence_ops i915_fence_ops = {
 	.signaled = i915_fence_signaled,
 	.wait = i915_fence_wait,
 	.release = i915_fence_release,
+	.set_deadline = i915_fence_set_deadline,
 };
 
 static void irq_execute_cb(struct irq_work *wrk)
-- 
2.39.1

