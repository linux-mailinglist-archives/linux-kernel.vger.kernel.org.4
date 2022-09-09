Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A8145B3BE4
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 17:30:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbiIIPaJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 11:30:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231609AbiIIP35 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 11:29:57 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01198B24
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 08:29:22 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id k9so3441500wri.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Sep 2022 08:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=x5KrfZMUqk39SoEPHLkAPrMFfPRI1D3FajlqzTwrI2w=;
        b=oSYpl/Gb1s9dRqBo3A5bgCA72v4jIqY5p2bmNk/vF4s4Z3Ej+MlZWJsUyTGVNwZ/yL
         80TFASgEwfo3yvcFMYRdBstqzyu3kpN57pNe+DqjU8T1t5aIe6g+UheTJwf4quTfGohg
         dIECs/DMEDAnA6Z/89eBhe+EPGIjU3BGLmeGSbWEHr/afbL8jo2GOosPz7te/ia1zXqc
         ViZLMeW/bckHzNGye3KqZHyv26ATnWeXHJ9RDz7Ar1pQyEhVa1XXJ98OQvOJ2T5Y8pRs
         005yXvVrRb7ofk+0Y56L42BjxJn4xzM7xbGKTY9PgS/MXHUxNbbPkdkU5aut49H1VH18
         fRgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=x5KrfZMUqk39SoEPHLkAPrMFfPRI1D3FajlqzTwrI2w=;
        b=6GEEDut9MjKf7DDv3IHOBs20bNMpJ9/F3CtAamemjqYLIQsbyfNu+UWC6u9hlTabg7
         /+iFlKTX0MSU02xz8KS1ML5xQvsbiwolymupnu7AFRtzr2XwtxpFZ3mXsgjExKS9fLOs
         WHRfdJWKhkrnf14OEmAS64yUKFvkNYcdq74efC3TWvkVIiXewTw8stXBKhIr+zEGG08d
         pVBQCQ0Ud/MfYO2XR1VzEJnIIjOvta6m1kBoiOUxZyG70JIaCGxukFl1MYj8vnS836cq
         2UEAD7qxftg7GLAfcBUiCUvhxY/9h4Sx1zEbORACsdAJCk2+oEivPeLbKlmi+BRgkHnt
         5EBw==
X-Gm-Message-State: ACgBeo0XC/Wkk78mnCAaBEt0+wSqwifSvmLk1Gfr9n20ikoIBmKXDwWx
        P7ZAxztU7477SwCtC/Rh36wNPA==
X-Google-Smtp-Source: AA6agR6wb87riPAljaE4mS1gw1MnP9z5tVpez/1x2jPhB3Ig+9QVEo4MAY76WVxvchFw/nzKIBqD1w==
X-Received: by 2002:a5d:6481:0:b0:228:dc1f:4f95 with SMTP id o1-20020a5d6481000000b00228dc1f4f95mr8415352wri.298.1662737351151;
        Fri, 09 Sep 2022 08:29:11 -0700 (PDT)
Received: from radium.lan ([88.160.162.107])
        by smtp.gmail.com with ESMTPSA id o12-20020a5d4a8c000000b002285f73f11dsm956931wrq.81.2022.09.09.08.29.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 08:29:10 -0700 (PDT)
From:   Fabien Parent <fabien.parent@linaro.org>
To:     robdclark@gmail.com, quic_abhinavk@quicinc.com,
        dmitry.baryshkov@linaro.org
Cc:     airlied@linux.ie, daniel@ffwll.ch, dianders@chromium.org,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Fabien Parent <fabien.parent@linaro.org>
Subject: [PATCH] drm/msm/mdp5: fix kernel panic during shutdown
Date:   Fri,  9 Sep 2022 17:28:56 +0200
Message-Id: <20220909152856.149291-1-fabien.parent@linaro.org>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel is panicking when rebooting on MSM8939:

	# reboot -f
	[   87.280853] Unable to handle kernel write to read-only memory at virtual address ffff800008ed5810
	...
	snip
	...
	[   87.445142] Call trace:
	[   87.452253]  mutex_lock+0x1c/0x50
	[   87.454511]  msm_drv_shutdown+0x28/0x40
	[   87.457984]  platform_shutdown+0x28/0x40
	[   87.461629]  device_shutdown+0x14c/0x240
	[   87.465796]  __do_sys_reboot+0x180/0x274
	[   87.469703]  __arm64_sys_reboot+0x28/0x3c
	[   87.473608]  invoke_syscall+0x54/0x124
	[   87.477515]  el0_svc_common.constprop.0+0x44/0xec
	[   87.481163]  do_el0_svc+0x90/0xe0
	[   87.485934]  el0_svc+0x50/0xa4
	[   87.489232]  el0t_64_sync_handler+0x11c/0x150
	[   87.492185]  el0t_64_sync+0x190/0x194
	[   87.496618] Code: f9800011 c85ffc03 ca010064 b5000064 (c8047c02)
	[   87.500264] ---[ end trace 0000000000000000 ]---
	Segmentation fault

The issue comes from the fact that mdp5_init() is calling
platform_set_drvdata() and consequently overwriting the driver data
previously set by msm_drv_probe.
msm_drv_shutdown was casting the driver data as "struct msm_drm_private"
while it was actually a "struct mdp5_kms".

This commit fixes the issue by having mdp5_init() not override the
platform driver data, and instead use a series of
to_mdp5_kms(to_mdp_kms(priv->kms)) to retrieve the mdp5_kms from the
pdata.

Fixes: 54199009958f ("drm/msm: Fix shutdown")
Signed-off-by: Fabien Parent <fabien.parent@linaro.org>
---
 drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c b/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c
index d2a48caf9d27..17aeabeedfeb 100644
--- a/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c
+++ b/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c
@@ -634,7 +634,8 @@ static int mdp5_kms_init(struct drm_device *dev)
 
 static void mdp5_destroy(struct platform_device *pdev)
 {
-	struct mdp5_kms *mdp5_kms = platform_get_drvdata(pdev);
+	struct msm_drm_private *priv = platform_get_drvdata(pdev);
+	struct mdp5_kms *mdp5_kms = to_mdp5_kms(to_mdp_kms(priv->kms));
 	int i;
 
 	if (mdp5_kms->ctlm)
@@ -797,7 +798,8 @@ static int mdp5_init(struct platform_device *pdev, struct drm_device *dev)
 		goto fail;
 	}
 
-	platform_set_drvdata(pdev, mdp5_kms);
+	/* set uninit-ed kms */
+	priv->kms = &mdp5_kms->base.base;
 
 	spin_lock_init(&mdp5_kms->resource_lock);
 
@@ -890,13 +892,13 @@ static int mdp5_init(struct platform_device *pdev, struct drm_device *dev)
 	if (ret)
 		goto fail;
 
-	/* set uninit-ed kms */
-	priv->kms = &mdp5_kms->base.base;
-
 	return 0;
 fail:
 	if (mdp5_kms)
 		mdp5_destroy(pdev);
+
+	priv->kms = NULL;
+
 	return ret;
 }
 
@@ -956,7 +958,8 @@ static int mdp5_dev_remove(struct platform_device *pdev)
 static __maybe_unused int mdp5_runtime_suspend(struct device *dev)
 {
 	struct platform_device *pdev = to_platform_device(dev);
-	struct mdp5_kms *mdp5_kms = platform_get_drvdata(pdev);
+	struct msm_drm_private *priv = platform_get_drvdata(pdev);
+	struct mdp5_kms *mdp5_kms = to_mdp5_kms(to_mdp_kms(priv->kms));
 
 	DBG("");
 
@@ -966,7 +969,8 @@ static __maybe_unused int mdp5_runtime_suspend(struct device *dev)
 static __maybe_unused int mdp5_runtime_resume(struct device *dev)
 {
 	struct platform_device *pdev = to_platform_device(dev);
-	struct mdp5_kms *mdp5_kms = platform_get_drvdata(pdev);
+	struct msm_drm_private *priv = platform_get_drvdata(pdev);
+	struct mdp5_kms *mdp5_kms = to_mdp5_kms(to_mdp_kms(priv->kms));
 
 	DBG("");
 
-- 
2.37.2

