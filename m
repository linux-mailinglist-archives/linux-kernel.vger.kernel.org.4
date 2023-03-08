Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A7AD6B0DCD
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 16:56:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232276AbjCHP4K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 10:56:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231270AbjCHPzp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 10:55:45 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B220CB669;
        Wed,  8 Mar 2023 07:54:34 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id d6so9901424pgu.2;
        Wed, 08 Mar 2023 07:54:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678290870;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qRQ1dHdIY/cau10a8E821pdOJBm+YYqmFlRisJrtcpU=;
        b=VInRsevL5hoOa24Y230bcVyeMLhH1aYIW9bUbR0nGfdeB6sMlUDfsB/IW5G+fFUrdS
         xq6loIUgrztEsywE69ZAUqsW/L7mtKOytKAxltZ3p9YKFi2P++DogG9K8Wzc4VJz9IkR
         eIWO7Ytce4BgJ/1k5T/PIexTpPW9HU/10m6MSvCYXZGAWm6rKl2YTRWJh9dj9zV/5Xcm
         ECw0NTffFqx4DWlIb59auEPRrYN6tUrv0DAG1fPg6lIXMqGtWwUlR9x0+Muci1Ohe032
         oiCRyrQ7zikzViwwCe93VCwvd/UimZPs2bcwJ5HysU/y6zbQohofGorhDeC9UnlH4d6l
         t5jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678290870;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qRQ1dHdIY/cau10a8E821pdOJBm+YYqmFlRisJrtcpU=;
        b=AL+1/5qAacdiRvUGx3GwRelhGcaYxwcS2k/ohYwmuct3xFvSbD3UlOBWNV6qZCfN0s
         uKyz5w2EXj0oc7SJJ9Y13pp5pC5wEx5YrK+ThE7slCAfHTTAcxSw8VEOaReKCJOqre+w
         2DJv7UwqJzj5Uk2OBa8cjUpWgCjti35TiuBvWZjS2C9af2SrazAaaR/4DCaqBp8QrQmX
         wU18ISQn/FrshlYv7sgd7HNl1bcTo/Yq4n9bhqPncHliwK04dztCnPYs0cK+Z1fCtSu6
         c52KRprwpxrDOYPaEqSpa3w1jjU7wEzhx2jg9A/ccbkkNhgsruzzc4No7NCT4FqPYVBZ
         +XWw==
X-Gm-Message-State: AO0yUKUueO3ha+qaZww+D4FMDvlfQKzq0LQjOyVIm2iPHlOEvZdcB4aT
        PZzs2BLGZ9dDhZJP5RstToo=
X-Google-Smtp-Source: AK7set/qurbajmx0drbw1A0UnfJ3nB9Otb6mpv7CbrkCjVlUVasHmbmab9vdSeIaq9fwrT8DYoD/PA==
X-Received: by 2002:a62:7bc4:0:b0:5e2:62b7:f785 with SMTP id w187-20020a627bc4000000b005e262b7f785mr15546331pfc.29.1678290870363;
        Wed, 08 Mar 2023 07:54:30 -0800 (PST)
Received: from localhost ([2a00:79e1:abd:4a00:61b:48ed:72ab:435b])
        by smtp.gmail.com with ESMTPSA id u5-20020aa78385000000b005a91d570972sm9486660pfm.41.2023.03.08.07.54.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 07:54:29 -0800 (PST)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     freedreno@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        Luben Tuikov <luben.tuikov@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= 
        <ckoenig.leichtzumerken@gmail.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Matt Turner <mattst88@gmail.com>,
        Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>,
        Rob Clark <robdclark@chromium.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        linux-kernel@vger.kernel.org (open list),
        linux-media@vger.kernel.org (open list:DMA BUFFER SHARING FRAMEWORK),
        linaro-mm-sig@lists.linaro.org (moderated list:DMA BUFFER SHARING
        FRAMEWORK)
Subject: [PATCH v10 15/15] drm/i915: Add deadline based boost support
Date:   Wed,  8 Mar 2023 07:53:06 -0800
Message-Id: <20230308155322.344664-16-robdclark@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230308155322.344664-1-robdclark@gmail.com>
References: <20230308155322.344664-1-robdclark@gmail.com>
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

I expect this patch to be replaced by someone who knows i915 better.

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
2.39.2

