Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6B4569D4D7
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 21:20:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231898AbjBTUUm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 15:20:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231319AbjBTUU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 15:20:27 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9B1B21A1C;
        Mon, 20 Feb 2023 12:20:09 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id k29so1596998pgm.3;
        Mon, 20 Feb 2023 12:20:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9VcsUu3unD+maL4g/jB1gMbq//XnoqiDQvEiNIyt7mI=;
        b=eFd6WKVkDjMERL0NUJwdZTkwaDz0OjPOGjnuwSqBIjiEyMvPenvK4sKtmZyxPWgSI5
         WzMJ7uiuRFqsr+eNs7HnTFRMZMbN/YDiqBuD4ndq4yNYXEZLdGcxi3k805YFDaRTM49H
         btsQGnmcp+Jjet2+wIFLHC8jDiihHqY6cv/dPw9x9644Qa2EUek2cYNr9GJNbS8dgyFQ
         P4BpZWBP0fPeYBPaJP/C+GnuHA8Ghph1mcX47CION2s+/ZlxKblgjj9wQSBLyzCt5Nee
         8vZ4iojT33oWnJ5z8yuQWQAsIzfLIZESfCxDG4TaE7N2JPqd9DRSZuJmNBVAKuuF7rDe
         FzFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9VcsUu3unD+maL4g/jB1gMbq//XnoqiDQvEiNIyt7mI=;
        b=pOxZSKZZCNYl93d22osXo+HFb4ekxazPbUtKJWJ9ZBJsEAYGMqIY0pLv4CJsdu2Qxy
         7xdmgYassi/z/Qz9gToGjbxVR1GQPfnvmJJqLYfTqQW6jAh5Aks/jyURMfSmU8JQvuN7
         1VoXxf5wqaEBEMjQ5MlUWdIxsXZuOhzWlMDC/pxp8GAi3BMpkka9I9yeo3yFgzr7IfOd
         1kzi0ezqW8i7zal2LppwmIvYQbwn+TnXA47NAA9BfBgw8VBSMv66DulnjIxTWUZ2rBZd
         vWv2Dx1LriMUZtwwulwrJer2Q3jHx9jHvjr1OqtTqWbsIEPAzl9sGcE9zbXYeX7Uuu1F
         hDvQ==
X-Gm-Message-State: AO0yUKUsQZa2mrQsFQK6Cn+TtTY3EQtlZCAoaM3TjpB8WKcl3qT9zK74
        NQjeYYyZI/a6UlXvofjE7Uo=
X-Google-Smtp-Source: AK7set/lZ+AFzfPQmwQQNW8iN+Fzdh2s6fnv3atcgztBFxVgeLYdWwu6bkkmpStlqHcJMRsJSfDpoA==
X-Received: by 2002:a62:184d:0:b0:5a9:fcb0:e8a2 with SMTP id 74-20020a62184d000000b005a9fcb0e8a2mr1540546pfy.11.1676924402380;
        Mon, 20 Feb 2023 12:20:02 -0800 (PST)
Received: from localhost (c-73-67-135-195.hsd1.or.comcast.net. [73.67.135.195])
        by smtp.gmail.com with ESMTPSA id e22-20020a62ee16000000b005a84e660713sm1934218pfi.195.2023.02.20.12.20.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Feb 2023 12:20:02 -0800 (PST)
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
Subject: [PATCH v5 14/14] drm/i915: Add deadline based boost support
Date:   Mon, 20 Feb 2023 12:19:01 -0800
Message-Id: <20230220201916.1822214-15-robdclark@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230220201916.1822214-1-robdclark@gmail.com>
References: <20230220201916.1822214-1-robdclark@gmail.com>
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

