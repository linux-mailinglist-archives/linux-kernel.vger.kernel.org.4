Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 682A9626266
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 20:50:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234112AbiKKTuU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 14:50:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233048AbiKKTuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 14:50:17 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7C9A8339B
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 11:50:15 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id s4so3254197qtx.6
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 11:50:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YU/dVE0ERRRiwLc0HKRhu2fVlyQiYjgDvyxIAHOZXz8=;
        b=UTwWvPMR4j2f2p7up8Le/KvMZlwgGMWDnXQ8RcwwGzzkoHuyjeJwmie5C9GVXHQOeM
         4nOE7CQbS2Rp5oNTgauj01OBG+ZZjUdaZ0z0IfnaKX4HNjv6IZ2fHaOWlPCl9B5mridB
         2dt9pYevIUdALZ+hmKfj0ybst/f34okv6UyGw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YU/dVE0ERRRiwLc0HKRhu2fVlyQiYjgDvyxIAHOZXz8=;
        b=nI3X8AAbmHppsTf/J6XATwoLqu3fkaecBIWE+OSA+kSqRcJmKPpnl2ZJrYZjZl7Iam
         4uMycATVkPxqH4cQ1+LwKt/WTBJyPRYxeSjNfTeXZHRXKZmqgfe7L4yOSdSUxJVZP7xR
         dw9zo3JHFqIlYdBkDAh1Nw4Mz4HFGK+bv9lqQbGuvmsqVbP7xsIaNbLqZ1/b0/2lEBzB
         S/3DbSRMdyaIVzqq1ZoQkbkOm+IFmA9cooFb0mUSvttNo8sCVkGlsQ+KaNnzapPrEcEr
         3ctkgqpuciu7mGYvdbSKcS1icTMpxwoTYPsU1tVhN07cpmJ+MtDO9n8xhLg3Tzl/jJiy
         YY0A==
X-Gm-Message-State: ANoB5pkJyRPnMtN5K4E8h0QL85KRIBqN95fsv0M+CT4STTlr6ug5RIWE
        qEX4nvUZ2JX5QxC/tt8BpGBbFbeWfsQXAw==
X-Google-Smtp-Source: AA0mqf4f379m8qQ4NDG8WIoePs17+iR7zz+GPC8xaMp8RokfgQW72ZP6ejmf+n05qXiKrn00RS9fgw==
X-Received: by 2002:a05:622a:5083:b0:3a5:404:4c36 with SMTP id fp3-20020a05622a508300b003a504044c36mr2767678qtb.653.1668196214671;
        Fri, 11 Nov 2022 11:50:14 -0800 (PST)
Received: from joelboxx.c.googlers.com.com (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id y11-20020a05620a25cb00b006ef1a8f1b81sm1985277qko.5.2022.11.11.11.50.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 11:50:13 -0800 (PST)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Rob Clark <robdclark@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ricardo Ribalda <ribalda@chromium.org>,
        Ross Zwisler <zwisler@kernel.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        dri-devel@lists.freedesktop.org, Emma Anholt <emma@anholt.net>,
        freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Vladimir Lypak <vladimir.lypak@gmail.com>
Subject: [PATCH 1/2] adreno: Shutdown the GPU properly
Date:   Fri, 11 Nov 2022 19:49:56 +0000
Message-Id: <20221111194957.4046771-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.38.1.493.g58b659f92b-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During kexec on ARM device, we notice that device_shutdown() only calls
pm_runtime_force_suspend() while shutting down the GPU. This means the GPU
kthread is still running and further, there maybe active submits.

This causes all kinds of issues during a kexec reboot:

Warning from shutdown path:

[  292.509662] WARNING: CPU: 0 PID: 6304 at [...] adreno_runtime_suspend+0x3c/0x44
[  292.509863] Hardware name: Google Lazor (rev3 - 8) with LTE (DT)
[  292.509872] pstate: 80400009 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[  292.509881] pc : adreno_runtime_suspend+0x3c/0x44
[  292.509891] lr : pm_generic_runtime_suspend+0x30/0x44
[  292.509905] sp : ffffffc014473bf0
[...]
[  292.510043] Call trace:
[  292.510051]  adreno_runtime_suspend+0x3c/0x44
[  292.510061]  pm_generic_runtime_suspend+0x30/0x44
[  292.510071]  pm_runtime_force_suspend+0x54/0xc8
[  292.510081]  adreno_shutdown+0x1c/0x28
[  292.510090]  platform_shutdown+0x2c/0x38
[  292.510104]  device_shutdown+0x158/0x210
[  292.510119]  kernel_restart_prepare+0x40/0x4c

And here from GPU kthread, an SError OOPs:

[  192.648789]  el1h_64_error+0x7c/0x80
[  192.648812]  el1_interrupt+0x20/0x58
[  192.648833]  el1h_64_irq_handler+0x18/0x24
[  192.648854]  el1h_64_irq+0x7c/0x80
[  192.648873]  local_daif_inherit+0x10/0x18
[  192.648900]  el1h_64_sync_handler+0x48/0xb4
[  192.648921]  el1h_64_sync+0x7c/0x80
[  192.648941]  a6xx_gmu_set_oob+0xbc/0x1fc
[  192.648968]  a6xx_hw_init+0x44/0xe38
[  192.648991]  msm_gpu_hw_init+0x48/0x80
[  192.649013]  msm_gpu_submit+0x5c/0x1a8
[  192.649034]  msm_job_run+0xb0/0x11c
[  192.649058]  drm_sched_main+0x170/0x434
[  192.649086]  kthread+0x134/0x300
[  192.649114]  ret_from_fork+0x10/0x20

Fix by calling adreno_system_suspend() in the device_shutdown() path.

Cc: Rob Clark <robdclark@chromium.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ricardo Ribalda <ribalda@chromium.org>
Cc: Ross Zwisler <zwisler@kernel.org>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 drivers/gpu/drm/msm/adreno/adreno_device.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/adreno/adreno_device.c b/drivers/gpu/drm/msm/adreno/adreno_device.c
index 24b489b6129a..f0cff62812c3 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_device.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_device.c
@@ -607,9 +607,12 @@ static int adreno_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static int adreno_system_suspend(struct device *dev);
 static void adreno_shutdown(struct platform_device *pdev)
 {
-	pm_runtime_force_suspend(&pdev->dev);
+	struct msm_gpu *gpu = dev_to_gpu(&pdev->dev);
+
+	WARN_ON_ONCE(adreno_system_suspend(&pdev->dev));
 }
 
 static const struct of_device_id dt_match[] = {
-- 
2.38.1.493.g58b659f92b-goog

