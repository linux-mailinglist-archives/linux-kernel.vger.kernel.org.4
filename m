Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9E256B6B45
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 21:42:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231422AbjCLUmz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 16:42:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231361AbjCLUmk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 16:42:40 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE9CC36444;
        Sun, 12 Mar 2023 13:42:29 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id y2so10027413pjg.3;
        Sun, 12 Mar 2023 13:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678653749;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ldFupt5wrZbRxkmdbQJ7PqzJnkF6w4MSZ/CZLw9J9jU=;
        b=P84pUSjCzIkoIgYt6UU3SmvPeySB6ogMNrsJYWlXc0yv0avhsPHyrha1RV5D6jPn+t
         fm16v1cSybQ37reDja2ftceIuj0n/NtUyjdfmKc4FkbI2hdI/v64GTOXXFtNbTTEhMy5
         Q985CWQSQECgz84X+f9QcqdWs8NyQMS9AFjoStBniiatTpnMvkcBwTqiCkrC42Mj28IV
         wxBKqDvaqhb13LSXfgvBVsQpPSM9AbK25LXHmXVPtGKnw6PRo4+FnzT0dKijzME3LuJ+
         V2yCLUuXZ8nRTgsn43U38HZJMCAGRhyaPrLZdPUpX9f579n//KAgRAGsIaKOSwh4arsN
         MrsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678653749;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ldFupt5wrZbRxkmdbQJ7PqzJnkF6w4MSZ/CZLw9J9jU=;
        b=uIHatKbCTDmA4xlR6UpcRRUn0USAFspQsSOgCU5wDrWHq4+QgggeR+k8HaVSqzps4E
         98XO/jaHBBd+Wh9ttTiSCcMJImO5v0jn+WXA4+wUz+cF2VWHu2AeKm+eFzC4NZnkcZiB
         dE/n8uuBhxOK6kTYoE/zFRPDG5ohyD0xl6M6beqerM/b1RxyyNUd/3B15hhLQIBbwe/Z
         6ALOQWZ/7kKAtcFs7pMGfmY3DEdIPQARqfzNm0+lmrJuYd9j2qfcQuUI4XIaitaXk0fW
         zqCXLlCD6VI7y7FPkOaTFP7gnPCMkUPRm1QGyGbNmHkWLLtM2vF7/dwGhihPRqYDvuuN
         I9Cw==
X-Gm-Message-State: AO0yUKXG5NxRyFTTWRA298iY315WXQEz3Fl9CQ+fdd3gfR/XD+MZ9OFL
        4KbPhORfpx4+CRMjiGevqFk=
X-Google-Smtp-Source: AK7set9/7KEDfLzBe8WkK2HrHKScy9T+IM0KGWqvIFfBBs3XnCWMJP6sQw+8lQsHMGjDnBzY8pgELQ==
X-Received: by 2002:a05:6a20:4422:b0:cd:bd86:318e with SMTP id ce34-20020a056a20442200b000cdbd86318emr41689013pzb.26.1678653749407;
        Sun, 12 Mar 2023 13:42:29 -0700 (PDT)
Received: from localhost ([2601:1c0:5080:d9fa:9b45:95de:f47d:f85e])
        by smtp.gmail.com with ESMTPSA id 131-20020a630289000000b004f1cb6ffe81sm3089968pgc.64.2023.03.12.13.42.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Mar 2023 13:42:28 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     linux-arm-msm@vger.kernel.org, Rob Clark <robdclark@chromium.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Chia-I Wu <olvaffe@gmail.com>, Luca Weiss <luca@z3ntu.xyz>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        freedreno@lists.freedesktop.org (open list:DRM DRIVER FOR MSM ADRENO
        GPU), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 03/13] drm/msm/gpu: Move fw loading out of hw_init() path
Date:   Sun, 12 Mar 2023 13:41:31 -0700
Message-Id: <20230312204150.1353517-4-robdclark@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230312204150.1353517-1-robdclark@gmail.com>
References: <20230312204150.1353517-1-robdclark@gmail.com>
MIME-Version: 1.0
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

It is already a no-op, since we've already loaded the fw from
adreno_load_gpu(), so drop the redundant call.

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/msm/adreno/adreno_gpu.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
index 817599766329..28cc5685ba96 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
@@ -503,16 +503,9 @@ struct drm_gem_object *adreno_fw_create_bo(struct msm_gpu *gpu,
 
 int adreno_hw_init(struct msm_gpu *gpu)
 {
-	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
-	int ret, i;
-
 	VERB("%s", gpu->name);
 
-	ret = adreno_load_fw(adreno_gpu);
-	if (ret)
-		return ret;
-
-	for (i = 0; i < gpu->nr_rings; i++) {
+	for (int i = 0; i < gpu->nr_rings; i++) {
 		struct msm_ringbuffer *ring = gpu->rb[i];
 
 		if (!ring)
-- 
2.39.2

