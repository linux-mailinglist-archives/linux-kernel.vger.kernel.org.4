Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5EB56649DF
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 19:26:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239297AbjAJS0g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 13:26:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239359AbjAJSZb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 13:25:31 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE37890856;
        Tue, 10 Jan 2023 10:22:11 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id a184so9508011pfa.9;
        Tue, 10 Jan 2023 10:22:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xPPp4X1sBM/+EwXKJ1Udyn041rDe4dkPN+gbP+h2Yoc=;
        b=qJBXBpPJHtuENt0GARPRQKp2a2d2bG2sppM+WZAucEidaZyC+7Wdq7LI5CBoTGxNA3
         jTM3LIlOEtS2/aAitqxnZlBmwxljOP+vIOV58uLlCtvqQEQ9Hp5OhT51wWZruY2i1MvY
         6kNX/u3a2zanqEN+w3E8Fi5z7VxFwMtMlmKNz3DvJhEiBlnsPXKcLQGyP4QrZjvdFQov
         NpmA3F4p1EDwLG67Omt8qx9Z7OS9T/RSlw79BOSqJ9MZQA+/GvD7cezqN0I8G58X9fhL
         aKulhMPWw2ZlC2+GEWtLpHyTGBlhi2bX0OSfOQGJWyDhjoNo0z4KMuNgubZ3g4QCFu+8
         RGmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xPPp4X1sBM/+EwXKJ1Udyn041rDe4dkPN+gbP+h2Yoc=;
        b=qaz2DXcYIt5Q6OSc0+xrH2UEGub+ep82IiIjlzku828JcX+j5a4ZJgRSP7OpTetcCh
         /MZ8TFcinWrc9F9gwFQUrbeRDY1js905H/tqfoSaf+5Bidx18He3/tk21E4CFrWSpqoZ
         rPWCim1wKi12EKHnWQOpzIXyrgXDJ/6vZ+vedTl9G7KTfvsFLS1ASzGVraNfjR9Xkgca
         CNbBqJQdyawOjgqDRK74GxkMYP09WWMqMoPgG/scZxODmqMqLk3vsmYokRZ0N3Ln/MBC
         RK0WJr9rT8al9uUOdv0Q1AYjes84BLgCAPxNXr087cmBCxtcfQ7ho7najm1sX1GMUZ5p
         sm2w==
X-Gm-Message-State: AFqh2kqiwZFQKBUayWaMQBltUMZ3E32pz0cOTGlxZ02cLDuVZYdrEL+y
        9oPzVI0atmcCBKVV76uzsuM=
X-Google-Smtp-Source: AMrXdXvvQvGvIzUPW5Fb9EE9F+jKZ5hTovkXNS514pYVo6mWEmFnuLDdCDGGVysVJxNzwsiPHXCUBw==
X-Received: by 2002:a05:6a00:4c0a:b0:589:85ed:4119 with SMTP id ea10-20020a056a004c0a00b0058985ed4119mr6884681pfb.32.1673374931439;
        Tue, 10 Jan 2023 10:22:11 -0800 (PST)
Received: from localhost ([2a00:79e1:abd:4a00:2703:3c72:eb1a:cffd])
        by smtp.gmail.com with ESMTPSA id p128-20020a622986000000b00581172f7456sm8410169pfp.56.2023.01.10.10.22.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jan 2023 10:22:11 -0800 (PST)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Rob Clark <robdclark@chromium.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 3/3] drm/msm/gpu: Add default devfreq thresholds
Date:   Tue, 10 Jan 2023 10:21:47 -0800
Message-Id: <20230110182150.1911031-4-robdclark@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230110182150.1911031-1-robdclark@gmail.com>
References: <20230110182150.1911031-1-robdclark@gmail.com>
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

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/msm/msm_gpu_devfreq.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/msm/msm_gpu_devfreq.c b/drivers/gpu/drm/msm/msm_gpu_devfreq.c
index e578d74d402f..1f31e72ca0cf 100644
--- a/drivers/gpu/drm/msm/msm_gpu_devfreq.c
+++ b/drivers/gpu/drm/msm/msm_gpu_devfreq.c
@@ -145,6 +145,15 @@ void msm_devfreq_init(struct msm_gpu *gpu)
 	if (!gpu->funcs->gpu_busy)
 		return;
 
+	/*
+	 * Setup default values for simple_ondemand governor tuning.  We
+	 * want to throttle up at 50% load for the double-buffer case,
+	 * where due to stalling waiting for vblank we could get stuck
+	 * at (for ex) 30fps at 50% utilization.
+	 */
+	priv->gpu_devfreq_config.upthreshold = 50;
+	priv->gpu_devfreq_config.downdifferential = 10;
+
 	mutex_init(&df->lock);
 
 	dev_pm_qos_add_request(&gpu->pdev->dev, &df->boost_freq,
-- 
2.38.1

