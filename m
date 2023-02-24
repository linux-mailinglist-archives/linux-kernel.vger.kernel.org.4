Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED83E6A22D8
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 21:02:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbjBXUCO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 15:02:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbjBXUCF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 15:02:05 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80E4014EA6;
        Fri, 24 Feb 2023 12:02:02 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id qi12-20020a17090b274c00b002341621377cso3997188pjb.2;
        Fri, 24 Feb 2023 12:02:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BjpvB6oPPHx1azLHzg6QZzAF+790oeDvTeHTT2aGPnU=;
        b=KVIenKwh8Ra0IYJKT+/nF0y9Cr8kAZkAkoXqA+8kOBiUEf5CM+tN0trf1WKWR/Dik/
         t816aUVYIS+dwzDCsrw2h+mge9bndhFtiG2TKKPUU0etFn0CNu/SaoeTjk2Y9QUGvAX4
         oOaBnzt9jVjPnWLWrca7kkC4UaGhGkB2AJbTpooRjMjPdZZHL6b27k4fX2mTmHO5VoRl
         XM0lGp1zQxd5GIDQOWrkk9lZxYH6PVpatjCY6SX1qCoy+QgpwkORwYZhqFDVWTl0H+Tf
         cfxy0zN1uiEtYST0pPGpqbxtnzl6xljbKT9fPvX8UncCfqbA4Te8EskFDsIUjrMi/Tbt
         DjLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BjpvB6oPPHx1azLHzg6QZzAF+790oeDvTeHTT2aGPnU=;
        b=oWjXoX+V1xHpDSD6HO+m/1FgQgkgl59KHAf8Iubtu3qxZrVDjNn5091f8m1X7+8rr2
         0kMAD71Ias6NuNqLu0zwyKdZFKJzQrIl5HJWZH07z6Jm+1U4Mf/ioLnlOZqN8WOcx7uC
         Ji6E2J04dCz1Vfv3pyX6IG9B3ZatxtYQzm6GQSwY554iDvfJOjwM2350BDzgLIRtUZ+i
         gCi3xXv4RK5/wWTgmwpTEIKWIvLP24Im4GhNAqixLygvF6pdta+ztWvIR6Hdah21v6gf
         W5J3JvRWoKgxL2wP9nrABDZZ3HLZ2A65jtMMO4AyeTDvdNqb2fRwmERgPEFOrEM6yFo2
         BN3w==
X-Gm-Message-State: AO0yUKVMGnoCM4pmYREh1aR8FBsbfv8AuPyNeHbPOHFiwDX6hJxKekps
        kbGZiwBgw+D8zJ+sQ1Qo5co=
X-Google-Smtp-Source: AK7set+9rmp1d+NriLvJCoJx2WT3H6tb4kY4AkvBvGlmYmXHcQpGTZTSxGiQ9ZUCe0/7HOWhXegI/w==
X-Received: by 2002:a17:902:c946:b0:19a:f556:e389 with SMTP id i6-20020a170902c94600b0019af556e389mr19042785pla.65.1677268921892;
        Fri, 24 Feb 2023 12:02:01 -0800 (PST)
Received: from localhost ([2a00:79e1:abd:4a00:61b:48ed:72ab:435b])
        by smtp.gmail.com with ESMTPSA id e8-20020a170902744800b0019a8468cbe7sm9762719plt.224.2023.02.24.12.02.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 12:02:01 -0800 (PST)
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
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Gustavo Padovan <gustavo@padovan.org>,
        linux-media@vger.kernel.org (open list:SYNC FILE FRAMEWORK),
        linaro-mm-sig@lists.linaro.org (moderated list:DMA BUFFER SHARING
        FRAMEWORK), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v6 01/15] dma-buf/dma-fence: Add deadline awareness
Date:   Fri, 24 Feb 2023 12:01:29 -0800
Message-Id: <20230224200155.2510320-2-robdclark@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230224200155.2510320-1-robdclark@gmail.com>
References: <20230224200155.2510320-1-robdclark@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Add a way to hint to the fence signaler of an upcoming deadline, such as
vblank, which the fence waiter would prefer not to miss.  This is to aid
the fence signaler in making power management decisions, like boosting
frequency as the deadline approaches and awareness of missing deadlines
so that can be factored in to the frequency scaling.

v2: Drop dma_fence::deadline and related logic to filter duplicate
    deadlines, to avoid increasing dma_fence size.  The fence-context
    implementation will need similar logic to track deadlines of all
    the fences on the same timeline.  [ckoenig]
v3: Clarify locking wrt. set_deadline callback
v4: Clarify in docs comment that this is a hint
v5: Drop DMA_FENCE_FLAG_HAS_DEADLINE_BIT.

Signed-off-by: Rob Clark <robdclark@chromium.org>
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 drivers/dma-buf/dma-fence.c | 20 ++++++++++++++++++++
 include/linux/dma-fence.h   | 19 +++++++++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/drivers/dma-buf/dma-fence.c b/drivers/dma-buf/dma-fence.c
index 0de0482cd36e..71b2e883f304 100644
--- a/drivers/dma-buf/dma-fence.c
+++ b/drivers/dma-buf/dma-fence.c
@@ -912,6 +912,26 @@ dma_fence_wait_any_timeout(struct dma_fence **fences, uint32_t count,
 }
 EXPORT_SYMBOL(dma_fence_wait_any_timeout);
 
+/**
+ * dma_fence_set_deadline - set desired fence-wait deadline hint
+ * @fence:    the fence that is to be waited on
+ * @deadline: the time by which the waiter hopes for the fence to be
+ *            signaled
+ *
+ * Give the fence signaler a hint about an upcoming deadline, such as
+ * vblank, by which point the waiter would prefer the fence to be
+ * signaled by.  This is intended to give feedback to the fence signaler
+ * to aid in power management decisions, such as boosting GPU frequency
+ * if a periodic vblank deadline is approaching but the fence is not
+ * yet signaled..
+ */
+void dma_fence_set_deadline(struct dma_fence *fence, ktime_t deadline)
+{
+	if (fence->ops->set_deadline && !dma_fence_is_signaled(fence))
+		fence->ops->set_deadline(fence, deadline);
+}
+EXPORT_SYMBOL(dma_fence_set_deadline);
+
 /**
  * dma_fence_describe - Dump fence describtion into seq_file
  * @fence: the 6fence to describe
diff --git a/include/linux/dma-fence.h b/include/linux/dma-fence.h
index 775cdc0b4f24..f334e37e52bc 100644
--- a/include/linux/dma-fence.h
+++ b/include/linux/dma-fence.h
@@ -257,6 +257,23 @@ struct dma_fence_ops {
 	 */
 	void (*timeline_value_str)(struct dma_fence *fence,
 				   char *str, int size);
+
+	/**
+	 * @set_deadline:
+	 *
+	 * Callback to allow a fence waiter to inform the fence signaler of
+	 * an upcoming deadline, such as vblank, by which point the waiter
+	 * would prefer the fence to be signaled by.  This is intended to
+	 * give feedback to the fence signaler to aid in power management
+	 * decisions, such as boosting GPU frequency.
+	 *
+	 * This is called without &dma_fence.lock held, it can be called
+	 * multiple times and from any context.  Locking is up to the callee
+	 * if it has some state to manage.
+	 *
+	 * This callback is optional.
+	 */
+	void (*set_deadline)(struct dma_fence *fence, ktime_t deadline);
 };
 
 void dma_fence_init(struct dma_fence *fence, const struct dma_fence_ops *ops,
@@ -583,6 +600,8 @@ static inline signed long dma_fence_wait(struct dma_fence *fence, bool intr)
 	return ret < 0 ? ret : 0;
 }
 
+void dma_fence_set_deadline(struct dma_fence *fence, ktime_t deadline);
+
 struct dma_fence *dma_fence_get_stub(void);
 struct dma_fence *dma_fence_allocate_private_stub(void);
 u64 dma_fence_context_alloc(unsigned num);
-- 
2.39.1

