Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8866E6C1559
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 15:46:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231932AbjCTOqB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 10:46:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232029AbjCTOpQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 10:45:16 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7180710273;
        Mon, 20 Mar 2023 07:44:55 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id kq3so265939plb.13;
        Mon, 20 Mar 2023 07:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679323493;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ldFupt5wrZbRxkmdbQJ7PqzJnkF6w4MSZ/CZLw9J9jU=;
        b=nLqncyImNrlz2RYRgSTcGk81CIP+FxeIhwn8gsHuejhfPlvxGvZoYbDo0a811aEXK9
         V1LlsnULXd0sVZPzFucY4idd1TfEuzWSGRr8oLl/nGNtw0w61RogcCNsUN5LYoaVQgy8
         A9Zjp7rXg0KtTQarA5j7PNz52fbJgT60Emcaw3O4Td7B/lgNjsxPkom0BwnCRmFdnQOz
         ay5YoqOYuFncYBGa78Ckg/Fc8t6MF4OaZhtzlc9O16bNsgB0fKDDkrlbvblGBXx62ZqL
         kkIj3+KSXWEXR+AMbc3PB0j7Fhhv2yHH3MBrVP4JTcpba0E8hu6lf6FUt8KEpiKFKbzS
         Nr0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679323493;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ldFupt5wrZbRxkmdbQJ7PqzJnkF6w4MSZ/CZLw9J9jU=;
        b=4Ijn8dGLsYTuXuJN1KE8BnX95ftX4uYEwdWyzrbL1iFJatug5Mdr7SSOCqcFx+YGV8
         Aqr09L4EpiXJxnW2JhK+3ZdG5BvRQ/kppHDkZT73XfwXgi8zY5R8Cochq/5u9/KutYLf
         N9lv5c/kpTkIUjcUkEfaC8PZF8BRyphYykkW5UZoPFF8j9eI1p1qFLZGQ8TL5NPK1w/7
         OnaM5474dNWIiDTRiUOUrkYBPIZtbbLlqMn26z0L9pQnA6owu3f7ibpLr0hix5s2MOrT
         yScQZp2L80CQf4WqL5Tg02DqoHRAY9lGbBqWyIBucAKb+csgf8kLpSckSi/jOOgqaCrB
         SZmQ==
X-Gm-Message-State: AO0yUKUBD+mWInhycCZqPa4ZV0Lj3Pj3mu59AuLSBBuqP9bs+cp5NgLS
        dBuS3crU8CWc5vB+qwX4Hxo=
X-Google-Smtp-Source: AK7set8ban8EVPY/GlOSyVWpuGWIu9Ktpe8j0t2q1ieP66G7xMsPkz9aTzAfar0y6DwailYRK/6igQ==
X-Received: by 2002:a05:6a20:bc9e:b0:d9:f086:e756 with SMTP id fx30-20020a056a20bc9e00b000d9f086e756mr1931648pzb.39.1679323493697;
        Mon, 20 Mar 2023 07:44:53 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:61b:48ed:72ab:435b])
        by smtp.gmail.com with ESMTPSA id j8-20020aa78dc8000000b00571f66721aesm6454473pfr.42.2023.03.20.07.44.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 07:44:53 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Daniel Vetter <daniel@ffwll.ch>, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, Rob Clark <robdclark@chromium.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Chia-I Wu <olvaffe@gmail.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Luca Weiss <luca@z3ntu.xyz>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 12/23] drm/msm/gpu: Move fw loading out of hw_init() path
Date:   Mon, 20 Mar 2023 07:43:34 -0700
Message-Id: <20230320144356.803762-13-robdclark@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230320144356.803762-1-robdclark@gmail.com>
References: <20230320144356.803762-1-robdclark@gmail.com>
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

