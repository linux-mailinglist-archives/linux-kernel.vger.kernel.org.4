Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4318D664FBD
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 00:15:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234114AbjAJXPH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 18:15:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233940AbjAJXOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 18:14:53 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF28C44344;
        Tue, 10 Jan 2023 15:14:52 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id w3so14862988ply.3;
        Tue, 10 Jan 2023 15:14:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xPPp4X1sBM/+EwXKJ1Udyn041rDe4dkPN+gbP+h2Yoc=;
        b=q63uw3mNNlQVh6Is3bP4jmBTtBzK7jO+hnToC3uKeWKGgwDm8mExfNScSDJARhkjr7
         FrGgbnqN4GOZPhYvVpKjig9VDS4kS/JL09ZRrq+1Y7/DeaLEx3LD3j1zMODLrpmFDyDX
         K/qSExlx+Pn3kbupCI8BEzmL7S6fkRpmiLOSPqZLB2SIC5BUsZTbchcpgBQ/6a7IacoE
         82Y4Y92sV3kTEjAKCt2hjgjuEASCkZ+7vq/ALtjcBxhFgvK3Lg+8m0cKvpEBZ+hsZyui
         z3M14v21V+ZYKkfkLpUjB/ZMhJlBcNPWpySuxouahKrcemeGfpgWmGrXT5EVmlb69XOX
         tX1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xPPp4X1sBM/+EwXKJ1Udyn041rDe4dkPN+gbP+h2Yoc=;
        b=ZtdiIMhYGKy2O2UCtK7OuXR8lcUDNr4g56DrRyQiNN6GX6HztAsMf/wTRmLEV09gbt
         UCSujWVbbwjqHwdITSKhlgJS4PvyJarqsPChfV7g5HLlgIrl0+9anjAe2HDQVjzFBLhB
         aw2T8Qe6m99iGGUAL6TlrWmXCeBkMEzdH9LbGvhsyTZoS8cBp3KcdHR1rn7317ZeEifY
         Y3ChY17LrjXOeZPsQxS3ZGfMDxhtf1ZOHCcvYPqK8Vn2vClBWSqPJ+E4fMcUdbbOkujC
         zJXx4KtGias62Wfwqx/fm0gy3ONSAP4230Dw+mma0M/TvvUxCDjhC2MDe7wwJHi1toUL
         lvuA==
X-Gm-Message-State: AFqh2kp3JjukMO68c/a+um0tiLuW3QKtkUTmKDm9UZIEMm3Gkw6728Rv
        irJO6U0QcVmVzQNfhhrUV7E=
X-Google-Smtp-Source: AMrXdXvCCByLHgBm0haGn8RFxyFWg/VpAsCup8jfefaHXVKuqOBYbiffTI0ZlkvCrwLLmKdjiXEAzg==
X-Received: by 2002:a17:902:aa82:b0:193:2f1a:65b1 with SMTP id d2-20020a170902aa8200b001932f1a65b1mr457696plr.59.1673392492186;
        Tue, 10 Jan 2023 15:14:52 -0800 (PST)
Received: from localhost ([2a00:79e1:abd:4a00:2703:3c72:eb1a:cffd])
        by smtp.gmail.com with ESMTPSA id u18-20020a170903125200b00189adf6770fsm8654086plh.233.2023.01.10.15.14.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jan 2023 15:14:51 -0800 (PST)
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
Subject: [PATCH v2 3/3] drm/msm/gpu: Add default devfreq thresholds
Date:   Tue, 10 Jan 2023 15:14:44 -0800
Message-Id: <20230110231447.1939101-4-robdclark@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230110231447.1939101-1-robdclark@gmail.com>
References: <20230110231447.1939101-1-robdclark@gmail.com>
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

