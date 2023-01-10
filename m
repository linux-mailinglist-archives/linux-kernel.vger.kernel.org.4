Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD069664E05
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 22:29:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232144AbjAJV3U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 16:29:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232833AbjAJV3Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 16:29:16 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E8F65CF86;
        Tue, 10 Jan 2023 13:29:10 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id h7-20020a17090aa88700b00225f3e4c992so17902433pjq.1;
        Tue, 10 Jan 2023 13:29:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ww/wSmvr3k1evMYET/bp6trdFG64eYICnW875bycRj8=;
        b=CCgZWPuWSBttrXnRXZbS8iC4aN+Aau60QJBgZPiWSORv8+dEzapGDIMmiMg0TlBknL
         Al+dyjFFmkvbQ8rgPSsDtx/Vm02bYxdsPlM9Sa9gKrP1EjLefqBa4ulX/2RObwrZW7ay
         a+pYBnM5nAhKXuXGsELpeNXhU/mPabU2iEVAU5HzuT8TSVKmCGBW6q1sXxyCHEIP43GG
         fAYmkmpOvzY0aL+nzYypi5k2AfVLd6vrwSADOaqncv/imIZ/Q5SCPeGkN2xCQahFE7P4
         cq6QJfLTcvs5b/l3nglsLlXwWPDTV+r4VW5nnUqlRr7yVPoPUOQd2hexbhR2FGCAOREz
         IZRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ww/wSmvr3k1evMYET/bp6trdFG64eYICnW875bycRj8=;
        b=UU7b9TgLs6S5ScX0oTtzu/q0UocYtAthIUhF/HkT1DH8dNG5Yvc2s0aclggp9j8zP+
         ClsWU1Nj3H7F3ycLrP58PSN1FXWg+53asBNlJZsR41Whv8Hp0p/dIlEXstCNsMdvrjhA
         /wOKLK/Rc5qo3WWXbjRVGREH4dXqAA8ahz12g3delAygMQJ8ejsvEmrAmKJcR9rfvgGV
         lyOcPslJtTEiI5V1xLi90kfQr9sPPKnJhPX/dXaRhRxxx3guRf9JuwRMjh8pKenM4PZq
         fIp2xbSQZ5SxdqCCYyv//0ih53b4U0rAZS4z7owFpBKbzgOxdL+IS1x9USFH3w8CQq7I
         wwfw==
X-Gm-Message-State: AFqh2krFb+DDqKfLgVNy0/rlO0yONDeuxtTE9JWrfnPQvUegQcxDonuL
        x43eVCq0qaBrIc8/vwaT9uU=
X-Google-Smtp-Source: AMrXdXvkRSXydWegDtiIcTPIVygJ7XqwuvTRfFb3Q/Yts4DuDVkJxsJ0AWg0r/ZcAz2R8ccvVQ0eyQ==
X-Received: by 2002:a17:902:8c89:b0:193:62a:80c8 with SMTP id t9-20020a1709028c8900b00193062a80c8mr17111420plo.45.1673386149390;
        Tue, 10 Jan 2023 13:29:09 -0800 (PST)
Received: from localhost ([2a00:79e1:abd:4a00:2703:3c72:eb1a:cffd])
        by smtp.gmail.com with ESMTPSA id jd6-20020a170903260600b001897de9bae3sm8568294plb.204.2023.01.10.13.29.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jan 2023 13:29:09 -0800 (PST)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Rob Clark <robdclark@chromium.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Chia-I Wu <olvaffe@gmail.com>, Emma Anholt <emma@anholt.net>,
        Dan Carpenter <error27@gmail.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] drm/msm/gpu: Fix potential double-free
Date:   Tue, 10 Jan 2023 13:28:59 -0800
Message-Id: <20230110212903.1925878-1-robdclark@gmail.com>
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

If userspace was calling the MSM_SET_PARAM ioctl on multiple threads to
set the COMM or CMDLINE param, it could trigger a race causing the
previous value to be kfree'd multiple times.  Fix this by serializing on
the gpu lock.

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/msm/adreno/adreno_gpu.c |  4 ++++
 drivers/gpu/drm/msm/msm_gpu.c           |  2 ++
 drivers/gpu/drm/msm/msm_gpu.h           | 12 ++++++++++--
 3 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
index 57586c794b84..3605f095b2de 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
@@ -352,6 +352,8 @@ int adreno_set_param(struct msm_gpu *gpu, struct msm_file_private *ctx,
 		/* Ensure string is null terminated: */
 		str[len] = '\0';
 
+		mutex_lock(&gpu->lock);
+
 		if (param == MSM_PARAM_COMM) {
 			paramp = &ctx->comm;
 		} else {
@@ -361,6 +363,8 @@ int adreno_set_param(struct msm_gpu *gpu, struct msm_file_private *ctx,
 		kfree(*paramp);
 		*paramp = str;
 
+		mutex_unlock(&gpu->lock);
+
 		return 0;
 	}
 	case MSM_PARAM_SYSPROF:
diff --git a/drivers/gpu/drm/msm/msm_gpu.c b/drivers/gpu/drm/msm/msm_gpu.c
index bfef659d3a5c..7537e7b3a452 100644
--- a/drivers/gpu/drm/msm/msm_gpu.c
+++ b/drivers/gpu/drm/msm/msm_gpu.c
@@ -336,6 +336,8 @@ static void get_comm_cmdline(struct msm_gem_submit *submit, char **comm, char **
 	struct msm_file_private *ctx = submit->queue->ctx;
 	struct task_struct *task;
 
+	WARN_ON(!mutex_is_locked(&submit->gpu->lock));
+
 	/* Note that kstrdup will return NULL if argument is NULL: */
 	*comm = kstrdup(ctx->comm, GFP_KERNEL);
 	*cmd  = kstrdup(ctx->cmdline, GFP_KERNEL);
diff --git a/drivers/gpu/drm/msm/msm_gpu.h b/drivers/gpu/drm/msm/msm_gpu.h
index a771f56ed70f..fc1c0d8611a8 100644
--- a/drivers/gpu/drm/msm/msm_gpu.h
+++ b/drivers/gpu/drm/msm/msm_gpu.h
@@ -375,10 +375,18 @@ struct msm_file_private {
 	 */
 	int sysprof;
 
-	/** comm: Overridden task comm, see MSM_PARAM_COMM */
+	/**
+	 * comm: Overridden task comm, see MSM_PARAM_COMM
+	 *
+	 * Accessed under msm_gpu::lock
+	 */
 	char *comm;
 
-	/** cmdline: Overridden task cmdline, see MSM_PARAM_CMDLINE */
+	/**
+	 * cmdline: Overridden task cmdline, see MSM_PARAM_CMDLINE
+	 *
+	 * Accessed under msm_gpu::lock
+	 */
 	char *cmdline;
 
 	/**
-- 
2.38.1

