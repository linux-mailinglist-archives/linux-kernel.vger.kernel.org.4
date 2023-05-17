Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE65C7068AA
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 14:53:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231816AbjEQMxK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 08:53:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231789AbjEQMxI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 08:53:08 -0400
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A62272D68
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 05:53:07 -0700 (PDT)
Received: from vefanov-Precision-3650-Tower.intra.ispras.ru (unknown [10.10.2.69])
        by mail.ispras.ru (Postfix) with ESMTPSA id E979144C1013;
        Wed, 17 May 2023 12:53:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru E979144C1013
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
        s=default; t=1684327986;
        bh=KFaX/2tqEHJVLG8kfiqijrjpzQ1dulXoIoRl1Nm6ws4=;
        h=From:To:Cc:Subject:Date:From;
        b=ZG1fdJH2oBF1CHR2wwa1NllsEyhlC/jOhH8h9ubTvPRpSNyDlOduUsGvINvz6FN1w
         /l4EkLGy8uUj43MBmgeHPNizD5r053D/05CVV1ry6yX36RdHHsGTrkcWp5TsTzZW3F
         pAQfrN2BdL/5S2rfItpWx9Lpt5lHQW8aGQZ5s7Oc=
From:   Vladislav Efanov <VEfanov@ispras.ru>
To:     Luben Tuikov <luben.tuikov@amd.com>
Cc:     Vladislav Efanov <VEfanov@ispras.ru>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        lvc-project@linuxtesting.org
Subject: [PATCH] drm/sched: Remove redundant check
Date:   Wed, 17 May 2023 15:52:47 +0300
Message-Id: <20230517125247.434103-1-VEfanov@ispras.ru>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The rq pointer points inside the drm_gpu_scheduler structure. Thus
it can't be NULL.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: c61cdbdbffc1 ("drm/scheduler: Fix hang when sched_entity released")
Signed-off-by: Vladislav Efanov <VEfanov@ispras.ru>
---
 drivers/gpu/drm/scheduler/sched_main.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
index 8c183639603e..aea5a90ff98b 100644
--- a/drivers/gpu/drm/scheduler/sched_main.c
+++ b/drivers/gpu/drm/scheduler/sched_main.c
@@ -1141,9 +1141,6 @@ void drm_sched_fini(struct drm_gpu_scheduler *sched)
 	for (i = DRM_SCHED_PRIORITY_COUNT - 1; i >= DRM_SCHED_PRIORITY_MIN; i--) {
 		struct drm_sched_rq *rq = &sched->sched_rq[i];
 
-		if (!rq)
-			continue;
-
 		spin_lock(&rq->lock);
 		list_for_each_entry(s_entity, &rq->entities, list)
 			/*
-- 
2.34.1

