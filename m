Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCC19634B8D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 01:14:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235166AbiKWAOS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 19:14:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234681AbiKWAOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 19:14:16 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C291AD328D
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 16:14:15 -0800 (PST)
Received: from dimapc.. (109-252-117-140.nat.spd-mgts.ru [109.252.117.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 1F6476602A9F;
        Wed, 23 Nov 2022 00:14:13 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1669162453;
        bh=CjfoupBANitx/AKoGxyh1s9D/gZeN1CU4qbRETlE+4k=;
        h=From:To:Cc:Subject:Date:From;
        b=bhGlGP4QmVJocJpVlT6d0e2EYlzQqO/gsofScbdgqWtPDF2iNG4Uixj2pqveUT30I
         JzwkZS6f/BDgfPUpCTh7G/MuMvUwjkZOyjmBgCl3sn1vlM3xc7MkvHB1SgPB4AFXNU
         4h4Zl3+2BsaLdnxuG3UGBiFcm0Czjd2DIyeSqLCQz1BrQYQ3+IwxtSz4fT3WD2Jqi5
         VdaEhEEZz16wMZkkuiNySwo9KmSByjNzSg8DyJJZpLBXwY1UEO+UDDMAPcLKydSqxa
         vjGNj9lkh5YdzNydlQloq5Ti3ho3Kh5uqh3hU/vEauyhDm5wGYEAIxgKnoVe6HSyv5
         VEGTqZnRH7Kkg==
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
To:     Luben Tuikov <luben.tuikov@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1] drm/scheduler: Fix lockup in drm_sched_entity_kill()
Date:   Wed, 23 Nov 2022 03:13:03 +0300
Message-Id: <20221123001303.533968-1-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The drm_sched_entity_kill() is invoked twice by drm_sched_entity_destroy()
while userspace process is exiting or being killed. First time it's invoked
when sched entity is flushed and second time when entity is released. This
causes a lockup within wait_for_completion(entity_idle) due to how completion
API works.

Calling wait_for_completion() more times than complete() was invoked is a
error condition that causes lockup because completion internally uses
counter for complete/wait calls. The complete_all() must be used instead
in such cases.

This patch fixes lockup of Panfrost driver that is reproducible by killing
any application in a middle of 3d drawing operation.

Fixes: 2fdb8a8f07c2 ("drm/scheduler: rework entity flush, kill and fini")
Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---
 drivers/gpu/drm/scheduler/sched_entity.c | 2 +-
 drivers/gpu/drm/scheduler/sched_main.c   | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/scheduler/sched_entity.c
index fe09e5be79bd..15d04a0ec623 100644
--- a/drivers/gpu/drm/scheduler/sched_entity.c
+++ b/drivers/gpu/drm/scheduler/sched_entity.c
@@ -81,7 +81,7 @@ int drm_sched_entity_init(struct drm_sched_entity *entity,
 	init_completion(&entity->entity_idle);
 
 	/* We start in an idle state. */
-	complete(&entity->entity_idle);
+	complete_all(&entity->entity_idle);
 
 	spin_lock_init(&entity->rq_lock);
 	spsc_queue_init(&entity->job_queue);
diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
index 6ce04c2e90c0..857ec20be9e8 100644
--- a/drivers/gpu/drm/scheduler/sched_main.c
+++ b/drivers/gpu/drm/scheduler/sched_main.c
@@ -1026,7 +1026,7 @@ static int drm_sched_main(void *param)
 		sched_job = drm_sched_entity_pop_job(entity);
 
 		if (!sched_job) {
-			complete(&entity->entity_idle);
+			complete_all(&entity->entity_idle);
 			continue;
 		}
 
@@ -1037,7 +1037,7 @@ static int drm_sched_main(void *param)
 
 		trace_drm_run_job(sched_job, entity);
 		fence = sched->ops->run_job(sched_job);
-		complete(&entity->entity_idle);
+		complete_all(&entity->entity_idle);
 		drm_sched_fence_scheduled(s_fence);
 
 		if (!IS_ERR_OR_NULL(fence)) {
-- 
2.38.1

