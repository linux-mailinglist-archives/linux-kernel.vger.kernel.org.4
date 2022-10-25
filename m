Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B94B60C3B6
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 08:19:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231165AbiJYGTH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 02:19:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230057AbiJYGTD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 02:19:03 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC7BCE09C1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 23:19:00 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id m14-20020a17090a3f8e00b00212dab39bcdso8686866pjc.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 23:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=12QBAJ7DmLqyQWnHrdks60L8hd98m3eMBCj+hNYftI0=;
        b=InODbJj4Fj/eiKetwOgrodIX0PxWjCUlX16/H+OhnS89EDFUjGlPs3yDws2Ax4LbYo
         svkJpAR/ZX/jWAra79lJBxfYLaem0Gg+Hq/hA80MiFvfwiOe9U5wtzcfOfCCj1ANX9Z3
         sh0sVLZY8qSADqafobTn+a6dGnsPvR04iCnTr+HBy/491Y2DB6z4ySJovE/Pjge1cMCJ
         N7RtJdXexVoxTIQJY/la4v7RKPLiOa+upOi6j2xhTwwBJdtT20ed9EAkAvJa4GlZhlPU
         LaeAjvEytdwfV8C8+FAUWfU1YjSVd51s2Bl5+ijeXSQtaVNJlklC+bcazDNN+ciN36Y9
         COvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=12QBAJ7DmLqyQWnHrdks60L8hd98m3eMBCj+hNYftI0=;
        b=xM71TMUfq3J9RHfR2ux5Ppguh9ZDiZzaHT2SXadyiYen4FcmgGKtrxswiuGKfWGNDR
         i+uZiY1TfSpZk8N1EdKAQIvWCXuWqfrfvFghcGrwwXvnzhozx0vY4gl0Cll60z+ZrzmP
         pUHq3Z1l06xt4TVNlapRWJKvNNSTgeNGxzTmvFtzNHnFLixKYzbuThsWaL6eS8I2g7ae
         c0Z2Q21tZa0zlFpBIbKjjOhSc4gHfP+SuwuNjpTg4jnrRnKD+BxdzFWsHj0rrmnPmwX3
         Nm9bklAgOfWjMQcRnl/rigGOq7a7YIasbgbKrTx+78Z4yKpeDVwnqc8WKE0RU7vS4Eoh
         2sLQ==
X-Gm-Message-State: ACrzQf1iYE3pC2sDHcbJ8dqxyaHNZz7mtJTPaxLaMySExl4hXJoVg7fZ
        CzsmPHV1jJog03OqWmTshv/vPvQuYjYgTYmk
X-Google-Smtp-Source: AMsMyM5p5tpQvnFbyquz5tYj/STP6Kb+hIKXV83kT0DLWXB4Z1ZgRcWqs/UnY7b7yl/qYSSewOG02Q==
X-Received: by 2002:a17:902:f34b:b0:186:abd0:93ff with SMTP id q11-20020a170902f34b00b00186abd093ffmr8063636ple.56.1666678740372;
        Mon, 24 Oct 2022 23:19:00 -0700 (PDT)
Received: from b-7000.. ([103.7.29.103])
        by smtp.gmail.com with ESMTPSA id me2-20020a17090b17c200b0020d9df9610bsm4830047pjb.19.2022.10.24.23.18.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 23:19:00 -0700 (PDT)
From:   brolerliew <brolerliew@gmail.com>
Cc:     brolerliew@gmail.com,
        Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/scheduler: set current_entity to next when remove from rq
Date:   Tue, 25 Oct 2022 14:18:46 +0800
Message-Id: <20221025061846.447975-1-brolerliew@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When entity move from one rq to another, current_entity will be set to NULL
if it is the moving entity. This make entities close to rq head got
selected more frequently, especially when doing load balance between
multiple drm_gpu_scheduler.

Make current_entity to next when removing from rq.

Signed-off-by: brolerliew <brolerliew@gmail.com>
---
 drivers/gpu/drm/scheduler/sched_main.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
index 2fab218d7082..00b22cc50f08 100644
--- a/drivers/gpu/drm/scheduler/sched_main.c
+++ b/drivers/gpu/drm/scheduler/sched_main.c
@@ -168,10 +168,11 @@ void drm_sched_rq_remove_entity(struct drm_sched_rq *rq,
 	spin_lock(&rq->lock);
 
 	atomic_dec(rq->sched->score);
-	list_del_init(&entity->list);
 
 	if (rq->current_entity == entity)
-		rq->current_entity = NULL;
+		rq->current_entity = list_next_entry(entity, list);
+
+	list_del_init(&entity->list);
 
 	if (drm_sched_policy == DRM_SCHED_POLICY_FIFO)
 		drm_sched_rq_remove_fifo_locked(entity);
-- 
2.34.1

