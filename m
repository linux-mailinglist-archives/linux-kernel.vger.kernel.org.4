Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 743046E5179
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 22:12:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230331AbjDQUMh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 16:12:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbjDQUMb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 16:12:31 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4A3C558D;
        Mon, 17 Apr 2023 13:12:25 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id h24-20020a17090a9c1800b002404be7920aso27709582pjp.5;
        Mon, 17 Apr 2023 13:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681762345; x=1684354345;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uGGeQ34qFmH3qFSmAUdD5AsG5Jqn1gFFjidxM1csPmQ=;
        b=WP1cGmhDXEaM2XoZQjksyWZjyjJ8/dPdSZFCLLz/R19MHv4d8SYoajJ3n7KJGGRP2d
         QfL8ZCHeiRUBptfALCwXRF34t1z07YYlkovBk2/hsT8PJckcxJI+ZsBCXsg2pi9LvC1d
         rggmvYF4ju/BUSXm2VA+2JY6fVH8vgjnf0fz97JefdsnlbPsqu6gE2y7kSOZ9r2ZtnIy
         ygjwVBziEtNITmZ5gllCzuvyKpWojJLQwxnRhV3/072eKrNSg/4TfPqqi8S3Wpt3IGlm
         aGZiitnwhALRhD1nKBOWbwppjuXsprBAvS5mBlN4oYjef76qBN+AMd4pN7SrTzRzxWlF
         oqyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681762345; x=1684354345;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uGGeQ34qFmH3qFSmAUdD5AsG5Jqn1gFFjidxM1csPmQ=;
        b=PLg+Ms/uCM7q/5+HUPoU6AwCmbX/OPEcCbpv4lhLJ2PvM2UvPI9iKVbcEl2P9tACgi
         AqgAa+IYoEtv0eY9EjalwXR7F6VGLsE0Cli/FDhNdjUFebsfa2wTrNQp/x8AUZWuh4OF
         FKK/udILpTHi1Cjb+ID5RocWOl4xkZTlchKYAnGNG7SBdQ10Mf4uOx8Cz+7gdLW0XmIo
         KP2fcIA7eKdFR6mg7CRaWu96BFHXHUjVxx1QzJNkHt76t7t5RXuQWm1x5wgc8yoxWLds
         tKpUiCuThUao+YSxDLT+rOR4GReilOQ8fTAnvRVPD06460dCop4063fWHYAsUAYjZDEs
         NK2w==
X-Gm-Message-State: AAQBX9cYkmI0IZoZNYRfSKNuDrgRrFHoJ+g82QoNkS9DB8beJN7ofKlf
        kfrDAS0TvzVLb1zrYpvVA3g=
X-Google-Smtp-Source: AKy350apR+UW6/r809TtL7zmvsClieP2I6EjDtF1IFJX/9UC+3g2jKbrC6+C4/pk1uCM3wzNBU0ZUQ==
X-Received: by 2002:a17:902:bc4b:b0:1a6:6a7c:9fde with SMTP id t11-20020a170902bc4b00b001a66a7c9fdemr140605plz.14.1681762345291;
        Mon, 17 Apr 2023 13:12:25 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:61b:48ed:72ab:435b])
        by smtp.gmail.com with ESMTPSA id w24-20020a17090aaf9800b0023d0c2f39f2sm9118078pjq.19.2023.04.17.13.12.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 13:12:24 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Rob Clark <robdclark@chromium.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>,
        linux-doc@vger.kernel.org (open list:DOCUMENTATION),
        linux-kernel@vger.kernel.org (open list),
        linux-arm-msm@vger.kernel.org (open list:DRM DRIVER FOR MSM ADRENO GPU),
        freedreno@lists.freedesktop.org (open list:DRM DRIVER FOR MSM ADRENO
        GPU)
Subject: [RFC 3/3] drm/msm: Add comm/cmdline fields
Date:   Mon, 17 Apr 2023 13:12:12 -0700
Message-Id: <20230417201215.448099-4-robdclark@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230417201215.448099-1-robdclark@gmail.com>
References: <20230417201215.448099-1-robdclark@gmail.com>
MIME-Version: 1.0
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

From: Rob Clark <robdclark@chromium.org>

Normally this would be the same information that can be obtained in
other ways.  But in some cases the process opening the drm fd is merely
a sort of proxy for the actual process using the GPU.  This is the case
for guest VM processes using the GPU via virglrenderer, in which case
the msm native-context renderer in virglrenderer overrides the comm/
cmdline to be the guest process's values.

Exposing this via fdinfo allows tools like gputop to show something more
meaningful than just a bunch of "pcivirtio-gpu" users.

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 Documentation/gpu/drm-usage-stats.rst |  8 ++++++++
 drivers/gpu/drm/msm/msm_gpu.c         | 14 ++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/Documentation/gpu/drm-usage-stats.rst b/Documentation/gpu/drm-usage-stats.rst
index 8e00d53231e0..bc90bed455e3 100644
--- a/Documentation/gpu/drm-usage-stats.rst
+++ b/Documentation/gpu/drm-usage-stats.rst
@@ -148,6 +148,14 @@ percentage utilization of the engine, whereas drm-engine-<keystr> only reflects
 time active without considering what frequency the engine is operating as a
 percentage of it's maximum frequency.
 
+- drm-comm: <valstr>
+
+Returns the clients executable path.
+
+- drm-cmdline: <valstr>
+
+Returns the clients cmdline.
+
 Implementation Details
 ======================
 
diff --git a/drivers/gpu/drm/msm/msm_gpu.c b/drivers/gpu/drm/msm/msm_gpu.c
index f0f4f845c32d..1150dcbf28aa 100644
--- a/drivers/gpu/drm/msm/msm_gpu.c
+++ b/drivers/gpu/drm/msm/msm_gpu.c
@@ -148,12 +148,26 @@ int msm_gpu_pm_suspend(struct msm_gpu *gpu)
 	return 0;
 }
 
+static void get_comm_cmdline(struct msm_file_private *ctx, char **comm, char **cmd);
+
 void msm_gpu_show_fdinfo(struct msm_gpu *gpu, struct msm_file_private *ctx,
 			 struct drm_printer *p)
 {
+	char *comm, *cmdline;
+
+	get_comm_cmdline(ctx, &comm, &cmdline);
+
 	drm_printf(p, "drm-engine-gpu:\t%llu ns\n", ctx->elapsed_ns);
 	drm_printf(p, "drm-cycles-gpu:\t%llu\n", ctx->cycles);
 	drm_printf(p, "drm-maxfreq-gpu:\t%u Hz\n", gpu->fast_rate);
+
+	if (comm)
+		drm_printf(p, "drm-comm:\t%s\n", comm);
+	if (cmdline)
+		drm_printf(p, "drm-cmdline:\t%s\n", cmdline);
+
+	kfree(comm);
+	kfree(cmdline);
 }
 
 int msm_gpu_hw_init(struct msm_gpu *gpu)
-- 
2.39.2

