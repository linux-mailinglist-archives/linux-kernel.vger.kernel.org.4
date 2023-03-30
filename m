Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 032616D12E3
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 01:15:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230360AbjC3XPd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 19:15:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbjC3XPc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 19:15:32 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28085D50E
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 16:15:31 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id q16so26618291lfe.10
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 16:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680218129;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gKYBmK1IVa52dJ8Yd581Rv9QR37AAvuQ9cm7SbojhKg=;
        b=gYLVf8N1n65KjQ18ewInau6qSRnWQtAGfYEsyBEMZHwlZqL7OzVU4lR6alx2YWyOkm
         1vXDdWn1ZF65Vap+R7nQF3cWDGRHC/OynalikGuRncZftTBOQaTLW2B8p1vDv7/5abd8
         f2mpuvfvPZbZqyKZ8CBfp9qQwa3GVxla4yOzG9jj0j4+by7KzJ2xTAat0Wmi/BwJXJat
         ANM0MuSwGKyHd6VBQyPwbVFXvc+WgPSlEqy/04bOVgpABpd7EGwN18y8WPHl1VO6KSCA
         9V4bKs4JKP5uiudSog/2XOLt7GJXZQgFRzzYTJ51wSyGRO8cWESXH5oefnQp9cAxHEXX
         T+KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680218129;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gKYBmK1IVa52dJ8Yd581Rv9QR37AAvuQ9cm7SbojhKg=;
        b=3VZSGXSWKmc9P8ORGSmm/6O87XbIMxmxTgffFWtKmLJNoQzhue10G5cfK1q8Yry2i1
         lE3U/2z2H41zOOVSSDh60jqE2knmr9QmwOZSkiVslKdhCaRr6k8YXPcQMpE7L7xgGMQ8
         abccEB05Tjs1Ntkc2c5Lo4NsoF4sEfuCnCY5ZHoXaVMZcIp68FSChJLGjflVHXzoMsmI
         lau+rx3BdC1a7VxXQQyYFQX8uLgqMzYW0WG2d1mximcnQokUCTNDYXkrfX5e81o+3aMF
         wRD95hbbZeLI6ETSr7RTb+6KjhSHIbMjn/wY+mCuAaWsAouNGUcx1Hlmr0zpYKidXMeH
         iJIg==
X-Gm-Message-State: AAQBX9fVyvzML9S6L2+8C53Z9l3eUyqyFHZ9iqnOqVFezt60sB4mtpkD
        Vua2QWrF//lTsRaq2+dmvG29jw==
X-Google-Smtp-Source: AKy350ZkSoTtv36RT8IMcVEcnIufQ5seRglWcEDl6o88SB8mFQgltcw5w6ByxFf9OwNvXOSEDn4udA==
X-Received: by 2002:a05:6512:11c3:b0:4d8:6f37:2611 with SMTP id h3-20020a05651211c300b004d86f372611mr6779352lfr.20.1680218129285;
        Thu, 30 Mar 2023 16:15:29 -0700 (PDT)
Received: from localhost.localdomain (abxj225.neoplus.adsl.tpnet.pl. [83.9.3.225])
        by smtp.gmail.com with ESMTPSA id g8-20020a19ac08000000b004dc4bb914c7sm123387lfc.201.2023.03.30.16.15.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 16:15:28 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org
Cc:     marijn.suijten@somainline.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Johan Hovold <johan+linaro@kernel.org>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Nathan Chancellor <nathan@kernel.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] drm/msm/adreno: adreno_gpu: Use suspend() instead of idle() on load error
Date:   Fri, 31 Mar 2023 01:15:16 +0200
Message-Id: <20230330231517.2747024-1-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The adreno_load_gpu() path is guarded by an error check on
adreno_load_fw(). This function is responsible for loading
Qualcomm-only-signed binaries (e.g. SQE and GMU FW for A6XX), but it
does not take the vendor-signed ZAP blob into account.

By embedding the SQE (and GMU, if necessary) firmware into the
initrd/kernel, we can trigger and unfortunate path that would not bail
out early and proceed with gpu->hw_init(). That will fail, as the ZAP
loader path will not find the firmware and return back to
adreno_load_gpu().

This error path involves pm_runtime_put_sync() which then calls idle()
instead of suspend(). This is suboptimal, as it means that we're not
going through the clean shutdown sequence. With at least A619_holi, this
makes the GPU not wake up until it goes through at least one more
start-fail-stop cycle. The pm_runtime_put_sync that appears in the error
path actually does not guarantee that because of the earlier enabling of
runtime autosuspend.

Fix that by using pm_runtime_put_sync_suspend to force a clean shutdown.

Test cases:
1. All firmware baked into kernel
2. error loading ZAP fw in initrd -> load from rootfs at DE start

Both succeed on A619_holi (SM6375) and A630 (SDM845).

Fixes: 0d997f95b70f ("drm/msm/adreno: fix runtime PM imbalance at gpu load")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
v1 -> v2:
- Improve the commit message and the reasoning within

 drivers/gpu/drm/msm/adreno/adreno_device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/adreno/adreno_device.c b/drivers/gpu/drm/msm/adreno/adreno_device.c
index f61896629be6..59f3302e8167 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_device.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_device.c
@@ -477,7 +477,7 @@ struct msm_gpu *adreno_load_gpu(struct drm_device *dev)
 	return gpu;
 
 err_put_rpm:
-	pm_runtime_put_sync(&pdev->dev);
+	pm_runtime_put_sync_suspend(&pdev->dev);
 err_disable_rpm:
 	pm_runtime_disable(&pdev->dev);
 
-- 
2.40.0

