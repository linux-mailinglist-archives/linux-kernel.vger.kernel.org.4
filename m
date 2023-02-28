Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B97986A6398
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 00:03:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229867AbjB1XDe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 18:03:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbjB1XD3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 18:03:29 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DDF165A6;
        Tue, 28 Feb 2023 15:03:11 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id c23so11443116pjo.4;
        Tue, 28 Feb 2023 15:03:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677625390;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9VcsUu3unD+maL4g/jB1gMbq//XnoqiDQvEiNIyt7mI=;
        b=j/ogsyjdQRA5zYnsXBpsNkXEvSmQoeBfNg6XeRt0KkElPbyzUKxGr8RwmSl86o4DMN
         ztLh7LsVCV+uaNjSNr7UOPriKIqPZgohUBS1K9WRnqz6MiLI0M6xfpzkxFrbp3D/lDur
         inZxwhFCKjIR5uryIkhxHHCHK0472BvmeDRdGKeRo068Tu+fwjEGlfJPRakzpVDuX2eA
         RSdRj47f3t31B0tjaZjiMGBpJGQz4jmEwFNCJc0pQ2DkaOY9EJXSzRMjshuEtbL/Rfrk
         buQHwrWLMfVQCmOW7uWpYyHwV+//irPDNH2euzWduAGbAbpYtkZS5Jau2HfkMZBBv44d
         AXKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677625390;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9VcsUu3unD+maL4g/jB1gMbq//XnoqiDQvEiNIyt7mI=;
        b=lz7m3SvpUW9a4/ZlD6z2hGhB9mkJs8sZ395fc+Cn2Ex53lMfSZoT4RuCTfOxFDhg0C
         7JiQSYaxmAZEKzgzGhqjqisrmN63fIh+Y7Q8ZS3sFhGw3/HpUAccNCCmfZO1ONkylgW5
         u3NY1h/Kb+3xotac32GYiVV50JteANPBlpv1hOm9L34+X8CgcxyXrQ+KZLwrQHzcXDSC
         JjMrqfe4FLPqNCZoXTGaxztqkUAfQV3b62FBF82ecjmuHi0WfWKvwX12WHFmz1FPNpES
         bbtrIJbU9tBJ33rC2QmeuJcTRcT+OpU/bJKna28aXverxl6OetU7TN33o2P2ekge04kl
         3Jjw==
X-Gm-Message-State: AO0yUKX4zqkPf2ANH0BPJ3TMG8x8wd5LcSt8eVTEO/yZYeeSATC23DFg
        8xQTRgKZIRdHMZQjubh5ibFrbi76UKhvZg==
X-Google-Smtp-Source: AK7set+uhL3oAEBWRGfMU0kz/dsgPtKf8mVqXm9u6mnBtkUHEgwo3uBk0J4jg6vnUxxbgGVMP/FFbg==
X-Received: by 2002:a17:903:41c1:b0:19c:d550:8cd4 with SMTP id u1-20020a17090341c100b0019cd5508cd4mr5350380ple.7.1677625390440;
        Tue, 28 Feb 2023 15:03:10 -0800 (PST)
Received: from localhost ([2a00:79e1:abd:4a00:61b:48ed:72ab:435b])
        by smtp.gmail.com with ESMTPSA id e9-20020a170902d38900b0019251e959b1sm7004856pld.262.2023.02.28.15.03.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 15:03:10 -0800 (PST)
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
Subject: [PATCH v8 16/16] drm/i915: Add deadline based boost support
Date:   Tue, 28 Feb 2023 14:58:20 -0800
Message-Id: <20230228225833.2920879-17-robdclark@gmail.com>
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

v2: rebase

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/i915/i915_request.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

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

