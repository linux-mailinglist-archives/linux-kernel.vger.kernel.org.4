Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B5F2717963
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 10:01:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235009AbjEaIBP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 04:01:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235453AbjEaIAo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 04:00:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6810EE77;
        Wed, 31 May 2023 01:00:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F00E1637C4;
        Wed, 31 May 2023 08:00:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5705CC433EF;
        Wed, 31 May 2023 08:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685520017;
        bh=c6Duq3c+yZHkdCZ4H7pQzdV4qKMi9g8iw8iuvGIfvk0=;
        h=From:To:Cc:Subject:Date:From;
        b=FiW9J8LHcud0gneuOakQNXig/Xsx+xPjtCWFvOaZcHDQTWYbvnnteZgvxwbvqw+Xz
         QrZc3kTX9J4JiSvhiEvjNF9D077T38NMgxOPLQsZ14OKsHmirvs4CWUu+k6fn67jMp
         /sk8SEhiIIYhLEh7FGhTlulJoJHmdHd3Uznxo7Tvt+cDEQvS3vo/FAiqmjP7GyTCRT
         4dUeUppARvJQl6F67wOoCSnkjZgYYt6M3iVgoGrS3EMdyx9YfF95Q7O3B4mUA55zua
         +DzTZ3EA3mC7GuREpicd28R07bgEuKZUTDF7HmSxntqitc+OygLOsKeA6zfZUaDuYU
         VXpCNH0Pa6aKQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1q4Gkm-0000CD-LB; Wed, 31 May 2023 10:00:20 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Bjorn Andersson <andersson@kernel.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>, stable@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>
Subject: [PATCH] drm/msm/a6xx: fix uninitialised lock in init error path
Date:   Wed, 31 May 2023 09:58:54 +0200
Message-Id: <20230531075854.703-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A recent commit started taking the GMU lock in the GPU destroy path,
which on GPU initialisation failure is called before the GMU and its
lock have been initialised.

Make sure that the GMU has been initialised before taking the lock in
a6xx_destroy() and drop the now redundant check from a6xx_gmu_remove().

Fixes: 4cd15a3e8b36 ("drm/msm/a6xx: Make GPU destroy a bit safer")
Cc: stable@vger.kernel.org      # 6.3
Cc: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c | 3 ---
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 9 ++++++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
index e16b4b3f8535..105ccf17041f 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
@@ -1472,9 +1472,6 @@ void a6xx_gmu_remove(struct a6xx_gpu *a6xx_gpu)
 	struct a6xx_gmu *gmu = &a6xx_gpu->gmu;
 	struct platform_device *pdev = to_platform_device(gmu->dev);
 
-	if (!gmu->initialized)
-		return;
-
 	pm_runtime_force_suspend(gmu->dev);
 
 	/*
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index 9fb214f150dd..ee47b95a0205 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -1684,6 +1684,7 @@ static void a6xx_destroy(struct msm_gpu *gpu)
 {
 	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
 	struct a6xx_gpu *a6xx_gpu = to_a6xx_gpu(adreno_gpu);
+	struct a6xx_gmu *gmu = &a6xx_gpu->gmu;
 
 	if (a6xx_gpu->sqe_bo) {
 		msm_gem_unpin_iova(a6xx_gpu->sqe_bo, gpu->aspace);
@@ -1697,9 +1698,11 @@ static void a6xx_destroy(struct msm_gpu *gpu)
 
 	a6xx_llc_slices_destroy(a6xx_gpu);
 
-	mutex_lock(&a6xx_gpu->gmu.lock);
-	a6xx_gmu_remove(a6xx_gpu);
-	mutex_unlock(&a6xx_gpu->gmu.lock);
+	if (gmu->initialized) {
+		mutex_lock(&gmu->lock);
+		a6xx_gmu_remove(a6xx_gpu);
+		mutex_unlock(&gmu->lock);
+	}
 
 	adreno_gpu_cleanup(adreno_gpu);
 
-- 
2.39.3

