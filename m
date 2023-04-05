Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C2D86D83C7
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 18:34:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231967AbjDEQez (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 12:34:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjDEQem (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 12:34:42 -0400
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FB214C05;
        Wed,  5 Apr 2023 09:34:34 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: linasend@asahilina.net)
        by mail.marcansoft.com (Postfix) with ESMTPSA id C249242118;
        Wed,  5 Apr 2023 16:34:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=asahilina.net;
        s=default; t=1680712471;
        bh=6hylb8a77OJ3/6TutdrbcroO5JBsT18Y4Xu7BzXejGw=;
        h=From:Date:Subject:To:Cc;
        b=chhqqtkmWEaznb7IhslQ4k6vCZ9b05y+1BohQOSZdF0KfLWPl9YEYaVZUkD/9RyIc
         i7wRMevcE7TkrcRJVxAGc94mZRg+Yn17e9A8kfsq9ip3U0iCZo9tsbAA2tLhPr+UvA
         aIyr/KgYGpy9ehdywhqG45ZVN5qPcAfH6BN4mqFuZFgPpk/dzozEbk09CfMT0tnQpv
         p3/HkoNnMULgvQC6U5IxN54kV9JqxToq4pJ3aQAAHwOuMkR5Rmbg7QrmoSdb6QyJHk
         dThstomiEaLe2w6c+9tIRPQrM+SuR0JwZDdON1C0+YRqSrhGGAolVxmebjOMMHEXIp
         Jq2vQqhXUhBWw==
From:   Asahi Lina <lina@asahilina.net>
Date:   Thu, 06 Apr 2023 01:34:24 +0900
Subject: [PATCH] drm/scheduler: Fix UAF in
 drm_sched_fence_get_timeline_name
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230406-scheduler-uaf-1-v1-1-8e5662269d25@asahilina.net>
X-B4-Tracking: v=1; b=H4sIAA+jLWQC/x2N0QrCMAxFf2Xk2Ui7lkH9FfEhyzJbkCoJG8LYv
 9v6eM7lcA8w0SIGt+EAlb1YedcG/jIAZ6pPwbI0htGNwUU3oXGWZXuJ4kYrekwpCofIxClAq2Y
 ywVmpcu7dPl0DKnvsvu8flbV8/4/3x3n+ADlzkZqBAAAA
To:     Luben Tuikov <luben.tuikov@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, asahi@lists.linux.dev,
        Asahi Lina <lina@asahilina.net>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1680712468; l=3168;
 i=lina@asahilina.net; s=20230221; h=from:subject:message-id;
 bh=6hylb8a77OJ3/6TutdrbcroO5JBsT18Y4Xu7BzXejGw=;
 b=fzl6uj6vopdSACbk9q9OzJ8heI46PdmDbHAcqBaoh1l1UFL2j12a/YUF57upGiukq6/uONr+R
 hwqMsz+jDU+D5GSwQeO1fkTh3sdTwJhx8RE2wWtch/ifppZ6JFHBOhM
X-Developer-Key: i=lina@asahilina.net; a=ed25519;
 pk=Qn8jZuOtR1m5GaiDfTrAoQ4NE1XoYVZ/wmt5YtXWFC4=
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A signaled scheduler fence can outlive its scheduler, since fences are
independently reference counted. Therefore, we can't reference the
scheduler in the get_timeline_name() implementation.

Fixes oopses on `cat /sys/kernel/debug/dma_buf/bufinfo` when shared
dma-bufs reference fences from GPU schedulers that no longer exist.

Signed-off-by: Asahi Lina <lina@asahilina.net>
---
 drivers/gpu/drm/scheduler/sched_entity.c | 7 ++++++-
 drivers/gpu/drm/scheduler/sched_fence.c  | 4 +++-
 include/drm/gpu_scheduler.h              | 5 +++++
 3 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/scheduler/sched_entity.c
index 15d04a0ec623..8b3b949b2ce8 100644
--- a/drivers/gpu/drm/scheduler/sched_entity.c
+++ b/drivers/gpu/drm/scheduler/sched_entity.c
@@ -368,7 +368,12 @@ static bool drm_sched_entity_add_dependency_cb(struct drm_sched_entity *entity)
 
 		/*
 		 * Fence is from the same scheduler, only need to wait for
-		 * it to be scheduled
+		 * it to be scheduled.
+		 *
+		 * Note: s_fence->sched could have been freed and reallocated
+		 * as another scheduler. This false positive case is okay, as if
+		 * the old scheduler was freed all of its jobs must have
+		 * signaled their completion fences.
 		 */
 		fence = dma_fence_get(&s_fence->scheduled);
 		dma_fence_put(entity->dependency);
diff --git a/drivers/gpu/drm/scheduler/sched_fence.c b/drivers/gpu/drm/scheduler/sched_fence.c
index 7fd869520ef2..33b145dfa38c 100644
--- a/drivers/gpu/drm/scheduler/sched_fence.c
+++ b/drivers/gpu/drm/scheduler/sched_fence.c
@@ -66,7 +66,7 @@ static const char *drm_sched_fence_get_driver_name(struct dma_fence *fence)
 static const char *drm_sched_fence_get_timeline_name(struct dma_fence *f)
 {
 	struct drm_sched_fence *fence = to_drm_sched_fence(f);
-	return (const char *)fence->sched->name;
+	return (const char *)fence->sched_name;
 }
 
 static void drm_sched_fence_free_rcu(struct rcu_head *rcu)
@@ -168,6 +168,8 @@ void drm_sched_fence_init(struct drm_sched_fence *fence,
 	unsigned seq;
 
 	fence->sched = entity->rq->sched;
+	strlcpy(fence->sched_name, entity->rq->sched->name,
+		sizeof(fence->sched_name));
 	seq = atomic_inc_return(&entity->fence_seq);
 	dma_fence_init(&fence->scheduled, &drm_sched_fence_ops_scheduled,
 		       &fence->lock, entity->fence_context, seq);
diff --git a/include/drm/gpu_scheduler.h b/include/drm/gpu_scheduler.h
index 9db9e5e504ee..49f019731891 100644
--- a/include/drm/gpu_scheduler.h
+++ b/include/drm/gpu_scheduler.h
@@ -295,6 +295,11 @@ struct drm_sched_fence {
          * @lock: the lock used by the scheduled and the finished fences.
          */
 	spinlock_t			lock;
+        /**
+         * @sched_name: the name of the scheduler that owns this fence. We
+         * keep a copy here since fences can outlive their scheduler.
+         */
+	char sched_name[16];
         /**
          * @owner: job owner for debugging
          */

---
base-commit: fe15c26ee26efa11741a7b632e9f23b01aca4cc6
change-id: 20230406-scheduler-uaf-1-994ec34cac93

Thank you,
~~ Lina

