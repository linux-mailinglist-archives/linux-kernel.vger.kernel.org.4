Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 062EF6A4B0B
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 20:36:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230086AbjB0Tf4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 14:35:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbjB0Tfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 14:35:53 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1270F93F6;
        Mon, 27 Feb 2023 11:35:50 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id v11so4387701plz.8;
        Mon, 27 Feb 2023 11:35:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pnCiHlTZ3XHUfR7rXNQOF8AslwfEMhVF7SVf22K+dwA=;
        b=I6mDs2TufiHGOpRM9erBq02iQ22+V5PWw8V9du6xB+Z0yvBkxQyMt7qnlMSEgeIO0O
         Qs4EWbkmc7NbNwgpoNM36W06HYMEXUolOBzcYA4PsKl9Zj4z/s2nUirhAzhKa1ISdxO6
         XUdR0DPB/dsFQ+OP2wTwLdRQa+zYbOB7fAmgTF7HOFutnypvSToRj0kjQY6TklMT2otY
         7xmabiC02oOcM7YCf8joTl0AyeJOLMYTIxclDdO335JDb655VLZMBfPeBFn7kcAq/7nt
         yFaaY/LNBD5GT6AqGZnJKyLYZFuwPzUQDmao+GOlppq4ntWVmcmNQ656Bm1M66aX7nyI
         qhVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pnCiHlTZ3XHUfR7rXNQOF8AslwfEMhVF7SVf22K+dwA=;
        b=OGeBBQ5mep+yj/PibKre0j4khxAa3nk5yySzGz8HANzi7J5V0RWmpD+tFuxG9elC8h
         ickNeg+RL8+iXGTNrMkWW3R7nR8QJRvqDq2DsvXLJnkBJ+DdOnsxJRgYS4Dcfo4LwId7
         1UNik+625Es9/PlyiVG6AfZ5WR/Z9Qumk2N8DNg0OK1AeopElTQDat2qxvoHj5ZYDMre
         G/Dtl9MyCXBV0bWn1jR/rb5mRp2ZCaBHMR2/MtqnCSfrAtVl0dw0DaVwu6NwmL6ybokv
         tOWaDtFdYvjsvEfAFwA8PrIyVE7aBLpXoroCl5ZaE2SYgjUieyqtnEAb5mCJfRekBP3p
         O/9w==
X-Gm-Message-State: AO0yUKUgjxCqagly1zz+Ta82aZn3sOGl4KAfaj/tTrCt7F4i2CdZc4OL
        Y2BrwiZcXi4hBs2rysGButM=
X-Google-Smtp-Source: AK7set+xjcru5uMJbo51/Coda3pgTL/GPwf8cuOG/WLXI8Ek1zE0cnb0rvcHwjA9q8TU8Dl271GYcA==
X-Received: by 2002:a17:902:db0b:b0:19d:f7e:9864 with SMTP id m11-20020a170902db0b00b0019d0f7e9864mr5610079plx.57.1677526550132;
        Mon, 27 Feb 2023 11:35:50 -0800 (PST)
Received: from localhost ([2a00:79e1:abd:4a00:61b:48ed:72ab:435b])
        by smtp.gmail.com with ESMTPSA id ix1-20020a170902f80100b0019ab58f47a6sm5000335plb.105.2023.02.27.11.35.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Feb 2023 11:35:49 -0800 (PST)
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
        Jonathan Corbet <corbet@lwn.net>,
        Gustavo Padovan <gustavo@padovan.org>,
        linux-media@vger.kernel.org (open list:DMA BUFFER SHARING FRAMEWORK),
        linaro-mm-sig@lists.linaro.org (moderated list:DMA BUFFER SHARING
        FRAMEWORK), linux-doc@vger.kernel.org (open list:DOCUMENTATION),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v7 01/15] dma-buf/dma-fence: Add deadline awareness
Date:   Mon, 27 Feb 2023 11:35:07 -0800
Message-Id: <20230227193535.2822389-2-robdclark@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230227193535.2822389-1-robdclark@gmail.com>
References: <20230227193535.2822389-1-robdclark@gmail.com>
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
v6: More docs

Signed-off-by: Rob Clark <robdclark@chromium.org>
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 Documentation/driver-api/dma-buf.rst |  6 +++
 drivers/dma-buf/dma-fence.c          | 59 ++++++++++++++++++++++++++++
 include/linux/dma-fence.h            | 20 ++++++++++
 3 files changed, 85 insertions(+)

diff --git a/Documentation/driver-api/dma-buf.rst b/Documentation/driver-api/dma-buf.rst
index 622b8156d212..183e480d8cea 100644
--- a/Documentation/driver-api/dma-buf.rst
+++ b/Documentation/driver-api/dma-buf.rst
@@ -164,6 +164,12 @@ DMA Fence Signalling Annotations
 .. kernel-doc:: drivers/dma-buf/dma-fence.c
    :doc: fence signalling annotation
 
+DMA Fence Deadline Hints
+~~~~~~~~~~~~~~~~~~~~~~~~
+
+.. kernel-doc:: drivers/dma-buf/dma-fence.c
+   :doc: deadline hints
+
 DMA Fences Functions Reference
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
diff --git a/drivers/dma-buf/dma-fence.c b/drivers/dma-buf/dma-fence.c
index 0de0482cd36e..e103e821d993 100644
--- a/drivers/dma-buf/dma-fence.c
+++ b/drivers/dma-buf/dma-fence.c
@@ -912,6 +912,65 @@ dma_fence_wait_any_timeout(struct dma_fence **fences, uint32_t count,
 }
 EXPORT_SYMBOL(dma_fence_wait_any_timeout);
 
+/**
+ * DOC: deadline hints
+ *
+ * In an ideal world, it would be possible to pipeline a workload sufficiently
+ * that a utilization based device frequency governor could arrive at a minimum
+ * frequency that meets the requirements of the use-case, in order to minimize
+ * power consumption.  But in the real world there are many workloads which
+ * defy this ideal.  For example, but not limited to:
+ *
+ * * Workloads that ping-pong between device and CPU, with alternating periods
+ *   of CPU waiting for device, and device waiting on CPU.  This can result in
+ *   devfreq and cpufreq seeing idle time in their respective domains and in
+ *   result reduce frequency.
+ *
+ * * Workloads that interact with a periodic time based deadline, such as double
+ *   buffered GPU rendering vs vblank sync'd page flipping.  In this scenario,
+ *   missing a vblank deadline results in an *increase* in idle time on the GPU
+ *   (since it has to wait an additional vblank period), sending a single to
+ *   the GPU's devfreq to reduce frequency, when in fact the opposite is what is
+ *   needed.
+ *
+ * To this end, deadline hint(s) can be set on a &dma_fence via &dma_fence_set_deadline.
+ * The deadline hint provides a way for the waiting driver, or userspace, to
+ * convey an appropriate sense of urgency to the signaling driver.
+ *
+ * A deadline hint is given in absolute ktime (CLOCK_MONOTONIC for userspace
+ * facing APIs).  The time could either be some point in the future (such as
+ * the vblank based deadline for page-flipping, or the start of a compositor's
+ * composition cycle), or the current time to indicate an immediate deadline
+ * hint (Ie. forward progress cannot be made until this fence is signaled).
+ *
+ * Multiple deadlines may be set on a given fence, even in parallel.  See the
+ * documentation for &dma_fence_ops.set_deadline.
+ *
+ * The deadline hint is just that, a hint.  The driver that created the fence
+ * may react by increasing frequency, making different scheduling choices, etc.
+ * Or doing nothing at all.
+ */
+
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
index 775cdc0b4f24..87c0d846dbb4 100644
--- a/include/linux/dma-fence.h
+++ b/include/linux/dma-fence.h
@@ -257,6 +257,24 @@ struct dma_fence_ops {
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
+	 * if it has some state to manage.  If multiple deadlines are set,
+	 * the expectation is to track the soonest one.
+	 *
+	 * This callback is optional.
+	 */
+	void (*set_deadline)(struct dma_fence *fence, ktime_t deadline);
 };
 
 void dma_fence_init(struct dma_fence *fence, const struct dma_fence_ops *ops,
@@ -583,6 +601,8 @@ static inline signed long dma_fence_wait(struct dma_fence *fence, bool intr)
 	return ret < 0 ? ret : 0;
 }
 
+void dma_fence_set_deadline(struct dma_fence *fence, ktime_t deadline);
+
 struct dma_fence *dma_fence_get_stub(void);
 struct dma_fence *dma_fence_allocate_private_stub(void);
 u64 dma_fence_context_alloc(unsigned num);
-- 
2.39.1

