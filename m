Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 627C06EFDAE
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 00:55:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240430AbjDZWzM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 18:55:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233392AbjDZWzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 18:55:10 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A9D81FCA
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 15:55:09 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-63d32d21f95so1653495b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 15:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682549708; x=1685141708;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=URe5IK8BqyGlY33B01lIkRKYglbFP/keYXZpRkkqgQk=;
        b=J0Q49yLEutapdBdj8hf5PCpH516ZfIpIr5OozmqwhsEE+HfSh2BWbTNAp/fCkT2W8v
         wVe2wp15oh4yzAAsdiZy2veVZHJxOQ4yfC/rISW65XTMhPtl9YzQJW8t8rnaS5mNNEU1
         8EcrP+vrKmHQ2ex9zVoZe5BPPpxHGttp7V+v8VxBFTK57ShSGV3CZpOkO8RK6SSJxIqs
         sPq+LmqDJx5lGlYjMCOa/DrG7iLIdDX5nQYDN1nrcTnjQkcIXuHQo6Fy5DDZdyz80jju
         RkxlJQIH6KYK0GB9KA8OZ/U80D/TjHkZS4AOiLEMazrjdC/jMgGTMxuFzC4KNHRJm1u9
         +Qbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682549708; x=1685141708;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=URe5IK8BqyGlY33B01lIkRKYglbFP/keYXZpRkkqgQk=;
        b=TWu1wJ95LLRmzDWQ2xRLHc7y8EKZFwmU940gyqPrRtNqQUwPv36ZWYIg+P4BLvpMkZ
         AEJm8VqocXAV80u1bol4J6wZtS6o21eNo92U3kQckUqjeBIP+c7QS3KTVoIVGOUphg7l
         wX5cAzjBXIZqPCSp6qgDAOpKcDuNIKRE9SS6I+OZYg1VSf5Nft3ATMKZ2v7TfwtBBfzh
         A8xab8WWtnrbtQGgDaXUuahTaprXxF01SOG2uVL0cDqg8FgHbB5jBbx5KIMgkWq4CoLT
         X3FoNnW1xh6DZJDY12PcL8U64AdcF0P53uM3oVgzB7cEbHXli3AOYMYsUrhf/xGeEZyE
         KfOw==
X-Gm-Message-State: AC+VfDwgSn4SPfJb9ny7FrYRsKaFUe6BzKd1qlqTO/thkoVTTx62HBma
        5W4Sowa/fu9nJA7ZWecekh6di3GzQ8c=
X-Google-Smtp-Source: ACHHUZ7N+TgomRffe1hCJV7ix6lm3dalClXxZYcIk7/1RguQPQWpXFX+HZaXNm+srdNv0IDb03c3FA==
X-Received: by 2002:a05:6a00:1812:b0:63f:21e:cad8 with SMTP id y18-20020a056a00181200b0063f021ecad8mr290784pfa.3.1682549708511;
        Wed, 26 Apr 2023 15:55:08 -0700 (PDT)
Received: from olv-ct-22.c.googlers.com.com (217.108.125.34.bc.googleusercontent.com. [34.125.108.217])
        by smtp.gmail.com with ESMTPSA id c4-20020aa78804000000b0062e00158bf4sm11735343pfo.208.2023.04.26.15.55.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Apr 2023 15:55:08 -0700 (PDT)
From:   Chia-I Wu <olvaffe@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Andres Rodriguez <andresx7@gmail.com>,
        amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] drm/amdgpu: add a missing lock for AMDGPU_SCHED
Date:   Wed, 26 Apr 2023 15:54:55 -0700
Message-ID: <20230426225458.877481-1-olvaffe@gmail.com>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mgr->ctx_handles should be protected by mgr->lock.

v2: improve commit message
v3: add a Fixes tag

Signed-off-by: Chia-I Wu <olvaffe@gmail.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Fixes: 52c6a62c64fac ("drm/amdgpu: add interface for editing a foreign process's priority v3")
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c
index e9b45089a28a6..863b2a34b2d64 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c
@@ -38,6 +38,7 @@ static int amdgpu_sched_process_priority_override(struct amdgpu_device *adev,
 {
 	struct fd f = fdget(fd);
 	struct amdgpu_fpriv *fpriv;
+	struct amdgpu_ctx_mgr *mgr;
 	struct amdgpu_ctx *ctx;
 	uint32_t id;
 	int r;
@@ -51,8 +52,11 @@ static int amdgpu_sched_process_priority_override(struct amdgpu_device *adev,
 		return r;
 	}
 
-	idr_for_each_entry(&fpriv->ctx_mgr.ctx_handles, ctx, id)
+	mgr = &fpriv->ctx_mgr;
+	mutex_lock(&mgr->lock);
+	idr_for_each_entry(&mgr->ctx_handles, ctx, id)
 		amdgpu_ctx_priority_override(ctx, priority);
+	mutex_unlock(&mgr->lock);
 
 	fdput(f);
 	return 0;
-- 
2.40.1.495.gc816e09b53d-goog

