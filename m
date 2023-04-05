Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA5D46D83D3
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 18:37:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232952AbjDEQhy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 12:37:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231644AbjDEQhw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 12:37:52 -0400
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 321874C05
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 09:37:51 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: linasend@asahilina.net)
        by mail.marcansoft.com (Postfix) with ESMTPSA id DF52541F7F;
        Wed,  5 Apr 2023 16:37:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=asahilina.net;
        s=default; t=1680712669;
        bh=sTrFnCJhBZN7oYDaKAxjFUzN6p2aBL4GuRgTde2utLA=;
        h=From:Date:Subject:To:Cc;
        b=K9G7MJzLSnQvQdH338vkTkWCLk/wuK+dbCnW6BiykK1txyyK5y49heffh9Jy/ORMy
         ItfAF2UNyA/hadH73iE5JxMzzV63FPIeo+cOvW0TQFYhbMbtdsfeeYHwiwaBx6LoH2
         0MU4CDaO6Wz0wV6EH6bKRrjacw5By/XWK1MuBVS6sXocUdWSzpUi2peUiPC7ly5qd6
         uLcKyxO0+aeAKCaGzlvoTFkn/dfHLMpCfKPrWQ7YfhsO9OeEANVIQsREQg1pqY/TOR
         zN8QDe7quVjG7m7CoBTJ7ofkkW9WBlkZLSCOKpK8MD0KXPP37aM9hBDCaXn5uhgzXZ
         kZuTTeTPISmGA==
From:   Asahi Lina <lina@asahilina.net>
Date:   Thu, 06 Apr 2023 01:37:39 +0900
Subject: [PATCH] drm/scheduler: Fix UAF race in drm_sched_entity_push_job()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230406-scheduler-uaf-2-v1-1-972531cf0a81@asahilina.net>
X-B4-Tracking: v=1; b=H4sIANKjLWQC/x2N0QrCMAxFf2Xk2UjX1SH+iviQtakNSJWEDWHs3
 219POdyuDsYq7DBbdhBeROTd20wngaIheqTUVJj8M5PLrgZLRZO64sVV8roMYSYr5k4+XCBVi1
 kjItSjaV323yeUOOI3ff9o5zl+3+8P47jB294TdCBAAAA
To:     Luben Tuikov <luben.tuikov@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        asahi@lists.linux.dev, Asahi Lina <lina@asahilina.net>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1680712667; l=1875;
 i=lina@asahilina.net; s=20230221; h=from:subject:message-id;
 bh=sTrFnCJhBZN7oYDaKAxjFUzN6p2aBL4GuRgTde2utLA=;
 b=5gNq7s+ZmeJPRhxbAegKKsazjg3FHd+yC9o0mB8mFPifI+IwCjdiBXH8s5F46HIaJ5/Abi83s
 w0mJnLrKf5YBO3ujbqgVFlDaQlZ9eA0oCS9LBP5n5tFbCpZij99Sgfl
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

After a job is pushed into the queue, it is owned by the scheduler core
and may be freed at any time, so we can't write nor read the submit
timestamp after that point.

Fixes oopses observed with the drm/asahi driver, found with kASAN.

Signed-off-by: Asahi Lina <lina@asahilina.net>
---
 drivers/gpu/drm/scheduler/sched_entity.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/scheduler/sched_entity.c
index 15d04a0ec623..e0a8890a62e2 100644
--- a/drivers/gpu/drm/scheduler/sched_entity.c
+++ b/drivers/gpu/drm/scheduler/sched_entity.c
@@ -507,12 +507,19 @@ void drm_sched_entity_push_job(struct drm_sched_job *sched_job)
 {
 	struct drm_sched_entity *entity = sched_job->entity;
 	bool first;
+	ktime_t submit_ts;
 
 	trace_drm_sched_job(sched_job, entity);
 	atomic_inc(entity->rq->sched->score);
 	WRITE_ONCE(entity->last_user, current->group_leader);
+
+	/*
+	 * After the sched_job is pushed into the entity queue, it may be
+	 * completed and freed up at any time. We can no longer access it.
+	 * Make sure to set the submit_ts first, to avoid a race.
+	 */
+	sched_job->submit_ts = submit_ts = ktime_get();
 	first = spsc_queue_push(&entity->job_queue, &sched_job->queue_node);
-	sched_job->submit_ts = ktime_get();
 
 	/* first job wakes up scheduler */
 	if (first) {
@@ -529,7 +536,7 @@ void drm_sched_entity_push_job(struct drm_sched_job *sched_job)
 		spin_unlock(&entity->rq_lock);
 
 		if (drm_sched_policy == DRM_SCHED_POLICY_FIFO)
-			drm_sched_rq_update_fifo(entity, sched_job->submit_ts);
+			drm_sched_rq_update_fifo(entity, submit_ts);
 
 		drm_sched_wakeup(entity->rq->sched);
 	}

---
base-commit: fe15c26ee26efa11741a7b632e9f23b01aca4cc6
change-id: 20230406-scheduler-uaf-2-44cf8faed245

Thank you,
~~ Lina

