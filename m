Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67A1C69BC15
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 22:15:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbjBRVPx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Feb 2023 16:15:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbjBRVPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Feb 2023 16:15:51 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 446CE12070;
        Sat, 18 Feb 2023 13:15:50 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id o9so1553648plk.12;
        Sat, 18 Feb 2023 13:15:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+1OrC8Qn2ZJKlzQr5VPD0V+OBV4kyv6Pm4LEmbHRWBY=;
        b=ZkdbOU+WUTXbXuy+edMoJBjcaH2pmGSWOPbAWIOHb+1uil8B7cZRAXaxpt2UzBVglS
         K9D42mFhZUJcG+CpOfomRVhFsdfvtao4eWTFV3/+UwBd/316jEIHmEWPTlOa0RssKCj1
         q6+JqVhrNYTe37sHAGTzgDmWHe7IAo585bi5HTzHmLnbqpizohUqvGrmEN6//nmpjn+I
         tFz7J4QCJ2M+hzuOgu5IwJPfJ6OAxIQDVrn5ObNQd/YyMKOG3wF0TXHse6PkE5PFTOo/
         UCKE9AF4BrQl4QisNCpjzkr8PAcEaMAj8rLMQPzDN2Hyci+wm2KiAB2Nef7AnBgp3v2u
         IzjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+1OrC8Qn2ZJKlzQr5VPD0V+OBV4kyv6Pm4LEmbHRWBY=;
        b=v5OOFhvC1QsgleSCdN2DzsZ+HsCbE47C65DnedPT47rKZNk/rSmi/R2+g5r4t8JvFz
         QmtYAWtdGuNSJifXtKjPxAeYAGZ8IGnUvWbwgDhncOexoYRficVvvis+VbT6qsMK8zoX
         4tQRApVXTxv9pdFAfHCUwHDfMcA9W6YiK2pPouZtuUSF1p35QQPUcE7pMZYvCWN11pxG
         T29P9FZrQJB9wQ27Vt9V9LGVUuErVhYSL0wu+Ryr5Qb8Lo4GK74dOSN5/oPbzaOuhevJ
         gLlsPbYiUNu01PiZXd+moLXspJ5quNZS2gfBfwdA5FRmAfjUI53oEBITtcvkKslVNM33
         4hOQ==
X-Gm-Message-State: AO0yUKW08EcbHZx104u2K2nAoSu15qoL8tqCgOHK8MLou1jjRBjcrBn7
        ERWFuMho1xuJptUQ+tCoaYE=
X-Google-Smtp-Source: AK7set/oYuhKvXuo3/h/Qa5avadZ9tVCfGZN140IDlH5L063jOweVl04kKTFFu939dYcCEm0rB2r/Q==
X-Received: by 2002:a17:902:ec81:b0:199:26b1:17b3 with SMTP id x1-20020a170902ec8100b0019926b117b3mr610623plg.28.1676754949710;
        Sat, 18 Feb 2023 13:15:49 -0800 (PST)
Received: from localhost (c-73-67-135-195.hsd1.or.comcast.net. [73.67.135.195])
        by smtp.gmail.com with ESMTPSA id x1-20020a1709029a4100b0019a97a4324dsm5059856plv.5.2023.02.18.13.15.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Feb 2023 13:15:49 -0800 (PST)
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
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Gustavo Padovan <gustavo@padovan.org>,
        linux-media@vger.kernel.org (open list:SYNC FILE FRAMEWORK),
        linaro-mm-sig@lists.linaro.org (moderated list:DMA BUFFER SHARING
        FRAMEWORK), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4 01/14] dma-buf/dma-fence: Add deadline awareness
Date:   Sat, 18 Feb 2023 13:15:44 -0800
Message-Id: <20230218211608.1630586-2-robdclark@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230218211608.1630586-1-robdclark@gmail.com>
References: <20230218211608.1630586-1-robdclark@gmail.com>
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

Signed-off-by: Rob Clark <robdclark@chromium.org>
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 drivers/dma-buf/dma-fence.c | 20 ++++++++++++++++++++
 include/linux/dma-fence.h   | 20 ++++++++++++++++++++
 2 files changed, 40 insertions(+)

diff --git a/drivers/dma-buf/dma-fence.c b/drivers/dma-buf/dma-fence.c
index 0de0482cd36e..763b32627684 100644
--- a/drivers/dma-buf/dma-fence.c
+++ b/drivers/dma-buf/dma-fence.c
@@ -912,6 +912,26 @@ dma_fence_wait_any_timeout(struct dma_fence **fences, uint32_t count,
 }
 EXPORT_SYMBOL(dma_fence_wait_any_timeout);
 
+
+/**
+ * dma_fence_set_deadline - set desired fence-wait deadline
+ * @fence:    the fence that is to be waited on
+ * @deadline: the time by which the waiter hopes for the fence to be
+ *            signaled
+ *
+ * Inform the fence signaler of an upcoming deadline, such as vblank, by
+ * which point the waiter would prefer the fence to be signaled by.  This
+ * is intended to give feedback to the fence signaler to aid in power
+ * management decisions, such as boosting GPU frequency if a periodic
+ * vblank deadline is approaching.
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
index 775cdc0b4f24..d77f6591c453 100644
--- a/include/linux/dma-fence.h
+++ b/include/linux/dma-fence.h
@@ -99,6 +99,7 @@ enum dma_fence_flag_bits {
 	DMA_FENCE_FLAG_SIGNALED_BIT,
 	DMA_FENCE_FLAG_TIMESTAMP_BIT,
 	DMA_FENCE_FLAG_ENABLE_SIGNAL_BIT,
+	DMA_FENCE_FLAG_HAS_DEADLINE_BIT,
 	DMA_FENCE_FLAG_USER_BITS, /* must always be last member */
 };
 
@@ -257,6 +258,23 @@ struct dma_fence_ops {
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

