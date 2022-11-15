Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21F0B629E2C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 16:55:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230368AbiKOPzM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 10:55:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230088AbiKOPzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 10:55:10 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FD352E689;
        Tue, 15 Nov 2022 07:55:09 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id b185so14459297pfb.9;
        Tue, 15 Nov 2022 07:55:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=C2pdDGcHzEOrC/CxVz6JXzn+8ROQCVIB4tco+V8khKI=;
        b=lmxiKTwU9EufjzjCqWK+4zeLsUn2z1+RhlDqnBGWCUbHSaVqWEsuteZADyBl0p5Jc1
         WS9Z28Ldft+0gHcHHNZo06DlJlxmD/EMdyHuIqgK0sKGn8mjn30raRGlh4kLzc6XvX0O
         WTUpPQfBNSOCuy8NeIZwUmXr8MO0JpTz4RR71M/U8parEak+4kx83OnhITFwli8nDzsL
         dZ0F5lnDFvo2Xw3CG7x8jG0turoh91KDLgHzCtpU3hBYfIA2jOcfyX1LivQl7Wsl38Fi
         gZcrBjAgiuMo+zjVeVbvuUW713bauncKWonnGhRFhD6L825P5jovH2qcszZgfSlMXhNc
         A/+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C2pdDGcHzEOrC/CxVz6JXzn+8ROQCVIB4tco+V8khKI=;
        b=ok2z4WdbxFXm9YOPtBD3jwgESFg2zgJ+toXmLla62aVi91t8TrIGDr076CeFpNjKNN
         hAlkN4O9/WP0NHJcaO5nNPXg+upEtrui+WErPAb1XjqSbEV+1FUuAeFTo37N4vaNvYPd
         wyBxhgvaR/Cf1V+y48wcLcR0iUq41CYbtTliiqsP6zhhuX8qywnOWbX2P+ume4cCov5P
         DhuALhP/cyBR2AxllXDZp2v/2LVOmMNbBGzdYmae2kU3h7XsPqUiaHETVxDd4n4A0NJR
         RLt68zCAr3GyUVqTgpPWGHHX8wVNklJ0mRhwtYHobI+vXoegNBp3VSalkCEzU7dwyZkz
         XFaQ==
X-Gm-Message-State: ANoB5plExT+L3YZjS3tBKDjPzO8P4PTOnAWPsdktF9/u9wN58MNf+7Ol
        XdKp2gJwrReHWnfzFVRbn0A=
X-Google-Smtp-Source: AA0mqf7v++J8wJlYIvd1JnXUJ2bJZVcaeIiHA7I/qToy2tlaCkZ7E0JMANpQu1t9KdE4xkibKJLdaA==
X-Received: by 2002:a63:6742:0:b0:46f:59af:c1f4 with SMTP id b63-20020a636742000000b0046f59afc1f4mr15728710pgc.344.1668527708582;
        Tue, 15 Nov 2022 07:55:08 -0800 (PST)
Received: from localhost ([2a00:79e1:abd:4a00:2703:3c72:eb1a:cffd])
        by smtp.gmail.com with ESMTPSA id h2-20020a170902f7c200b00176ab6a0d5fsm10014905plw.54.2022.11.15.07.55.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 07:55:08 -0800 (PST)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Rob Clark <robdclark@chromium.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Chia-I Wu <olvaffe@gmail.com>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] drm/msm: Enable clamp_to_idle for 7c3
Date:   Tue, 15 Nov 2022 07:55:33 -0800
Message-Id: <20221115155535.1615278-1-robdclark@gmail.com>
X-Mailer: git-send-email 2.38.1
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

This was overlooked.

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index ebe9599a8316..e495d8e192db 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -2029,13 +2029,6 @@ struct msm_gpu *a6xx_gpu_init(struct drm_device *dev)
 			adreno_cmp_rev(ADRENO_REV(6, 3, 5, ANY_ID), info->rev)))
 		adreno_gpu->base.hw_apriv = true;
 
-	/*
-	 * For now only clamp to idle freq for devices where this is known not
-	 * to cause power supply issues:
-	 */
-	if (info && (info->revn == 618))
-		gpu->clamp_to_idle = true;
-
 	a6xx_llc_slices_init(pdev, a6xx_gpu);
 
 	ret = a6xx_set_supported_hw(&pdev->dev, config->rev);
@@ -2050,6 +2043,13 @@ struct msm_gpu *a6xx_gpu_init(struct drm_device *dev)
 		return ERR_PTR(ret);
 	}
 
+	/*
+	 * For now only clamp to idle freq for devices where this is known not
+	 * to cause power supply issues:
+	 */
+	if (adreno_is_a618(adreno_gpu) || adreno_is_7c3(adreno_gpu))
+		gpu->clamp_to_idle = true;
+
 	/* Check if there is a GMU phandle and set it up */
 	node = of_parse_phandle(pdev->dev.of_node, "qcom,gmu", 0);
 
-- 
2.38.1

