Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB4556A8D68
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 00:54:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbjCBXyF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 18:54:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbjCBXyC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 18:54:02 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72CDFEFB0;
        Thu,  2 Mar 2023 15:54:01 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id x34so855922pjj.0;
        Thu, 02 Mar 2023 15:54:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677801241;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MNK4EAXE449Ce2l3n69cjKEqV9oops58mW8yuHdnCzs=;
        b=aY/t7j93xxdOs7JmfvKvArQyIm33WCAYc9L+FBv/Rd7ysY8N1rZ4CqWMXGq1UDhlp0
         5oMd893ch1N87bbsjm2NNRviy/GBwCXG9iDVnw+mdgvjB5ZzJV9GV6gKi+Stesyyw2ZM
         4hpTQEcQqoPeb9dwFhg93/IZWzQgAECSPpLRZIo/DO166N6Fu6j1HnMaN7v2rX1yqGXZ
         UvCy8ykM2T1+WkJ9Y9uVr/dePQcyOlIHgsWw2z+DyrekmjjMjDdXb9ynepJ3bO3oE3TB
         ZW7sMPO4fmKKzIM/C+9wbXqvhroBsfQfckZq1FbkchaU2nvKVkuyEy+a+inJVb7Umw1V
         hxqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677801241;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MNK4EAXE449Ce2l3n69cjKEqV9oops58mW8yuHdnCzs=;
        b=TwGMdzUDU/WUgueQLjPZpP3KGxduRXmWhs+cnx8Z0ZczRPvISA1KnQ//abiONkPsAx
         5HolLY9OxZgPn99Dr8ztWn1TSLjFmdPzrlsla1zX/v/mIp86zDsody/b1/A/YQ2IKbD1
         1VcsmCJIPlzDnOYHGQCHP+wP7H6lD2BBmV9RZFf7jJoFecYh3UTuykQNvvqMTvL/9J0u
         1fg8TqbtnKDBSf+Jg5lLdSSrYOO3r3uB+Ls7VKM+EyPhom7Y2G1vZN7U+K8Y7TKX+JjW
         QBKdcPaWueTsVmvZC/Q+eW6xju4HvxbEiRRpSKbnt5OCTq11CzsqHFucBjBqHaYqftPf
         SEGA==
X-Gm-Message-State: AO0yUKVKMC8OrbQ0hreS47MCJXpHAdTecMrb4XtcVpqDgNrbWJiJXdgI
        IlnLDPl6KXBVoaw8J5oDcpI=
X-Google-Smtp-Source: AK7set/F6PBmFSHbT23NnNbCBzYLCIvIAQzxnHQvkvk9MfRxtNHvyFRXboh+FUIUlLOu7i03hSI/cw==
X-Received: by 2002:a17:902:f801:b0:19a:aaac:f4d1 with SMTP id ix1-20020a170902f80100b0019aaaacf4d1mr3023868plb.13.1677801240810;
        Thu, 02 Mar 2023 15:54:00 -0800 (PST)
Received: from localhost ([2a00:79e1:abd:4a00:61b:48ed:72ab:435b])
        by smtp.gmail.com with ESMTPSA id t4-20020a170902a5c400b0019602274208sm211584plq.186.2023.03.02.15.54.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 15:54:00 -0800 (PST)
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
        Pekka Paalanen <pekka.paalanen@collabora.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Gustavo Padovan <gustavo@padovan.org>,
        linux-media@vger.kernel.org (open list:DMA BUFFER SHARING FRAMEWORK),
        linaro-mm-sig@lists.linaro.org (moderated list:DMA BUFFER SHARING
        FRAMEWORK), linux-doc@vger.kernel.org (open list:DOCUMENTATION),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v9 01/15] dma-buf/dma-fence: Add deadline awareness
Date:   Thu,  2 Mar 2023 15:53:23 -0800
Message-Id: <20230302235356.3148279-2-robdclark@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230302235356.3148279-1-robdclark@gmail.com>
References: <20230302235356.3148279-1-robdclark@gmail.com>
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
v7: Fix typo, clarify past deadlines

Signed-off-by: Rob Clark <robdclark@chromium.org>
Reviewed-by: Christian König <christian.koenig@amd.com>
Acked-by: Pekka Paalanen <pekka.paalanen@collabora.com>
Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/driver-api/dma-buf.rst |  6 +++
 drivers/dma-buf/dma-fence.c          | 59 ++++++++++++++++++++++++++++
 include/linux/dma-fence.h            | 22 +++++++++++
 3 files changed, 87 insertions(+)

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
index 0de0482cd36e..f177c56269bb 100644
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
+ *   (since it has to wait an additional vblank period), sending a signal to
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
index 775cdc0b4f24..d54b595a0fe0 100644
--- a/include/linux/dma-fence.h
+++ b/include/linux/dma-fence.h
@@ -257,6 +257,26 @@ struct dma_fence_ops {
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
+	 * the expectation is to track the soonest one.  If the deadline is
+	 * before the current time, it should be interpreted as an immediate
+	 * deadline.
+	 *
+	 * This callback is optional.
+	 */
+	void (*set_deadline)(struct dma_fence *fence, ktime_t deadline);
 };
 
 void dma_fence_init(struct dma_fence *fence, const struct dma_fence_ops *ops,
@@ -583,6 +603,8 @@ static inline signed long dma_fence_wait(struct dma_fence *fence, bool intr)
 	return ret < 0 ? ret : 0;
 }
 
+void dma_fence_set_deadline(struct dma_fence *fence, ktime_t deadline);
+
 struct dma_fence *dma_fence_get_stub(void);
 struct dma_fence *dma_fence_allocate_private_stub(void);
 u64 dma_fence_context_alloc(unsigned num);
-- 
2.39.1

