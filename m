Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 157DE6B3072
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 23:22:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231210AbjCIWWX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 17:22:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjCIWWU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 17:22:20 -0500
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E69F1009F6;
        Thu,  9 Mar 2023 14:21:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1678400517; x=1709936517;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=yVuCSofNXc4xFq2MIhmOj+IftFzTz6jbp1BPLOvSYTc=;
  b=bSj1u7ulRJ3rgD3z35BHM9dYZuW5gYvPHxFMDBWyE5fmsJEof2360M7L
   lPj2fMlLes5VqvO7Ap8VvUsykvhXWnXDoIHJCtI4iBNFgfOnDpOhjby8q
   pEE5G7WetMGmVRKF1ZJbObUoEHOnbAoo4aHnJuJHq1GIc40+0HEYoS/bd
   I=;
X-IronPort-AV: E=Sophos;i="5.98,247,1673913600"; 
   d="scan'208";a="191702044"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-iad-1a-m6i4x-47cc8a4c.us-east-1.amazon.com) ([10.25.36.214])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2023 22:21:11 +0000
Received: from EX13MTAUWB002.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
        by email-inbound-relay-iad-1a-m6i4x-47cc8a4c.us-east-1.amazon.com (Postfix) with ESMTPS id 01C01160DA9;
        Thu,  9 Mar 2023 22:21:06 +0000 (UTC)
Received: from EX19D047UWB002.ant.amazon.com (10.13.138.34) by
 EX13MTAUWB002.ant.amazon.com (10.43.161.202) with Microsoft SMTP Server (TLS)
 id 15.0.1497.45; Thu, 9 Mar 2023 22:21:05 +0000
Received: from u0d599d08243c5b.ant.amazon.com (10.187.171.27) by
 EX19D047UWB002.ant.amazon.com (10.13.138.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.24; Thu, 9 Mar 2023 22:21:04 +0000
From:   Jordan Crouse <jorcrous@amazon.com>
To:     <freedreno@lists.freedesktop.org>
CC:     Jordan Crouse <jorcrous@amazon.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        "Dmitry Baryshkov" <dmitry.baryshkov@linaro.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Ricardo Ribalda <ribalda@chromium.org>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        <dri-devel@lists.freedesktop.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] drm/msm: Check for the GPU IOMMU during bind
Date:   Thu, 9 Mar 2023 15:20:49 -0700
Message-ID: <20230309222049.4180579-1-jorcrous@amazon.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.187.171.27]
X-ClientProxiedBy: EX19D046UWB003.ant.amazon.com (10.13.139.174) To
 EX19D047UWB002.ant.amazon.com (10.13.138.34)
X-Spam-Status: No, score=-11.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While booting with amd,imageon on a headless target the GPU probe was
failing with -ENOSPC in get_pages() from msm_gem.c.

Investigation showed that the driver was using the default 16MB VRAM
carveout because msm_use_mmu() was returning false since headless devices
use a dummy parent device. Avoid this by extending the existing is_a2xx
priv member to check the GPU IOMMU state on all platforms and use that
check in msm_use_mmu().

This works for memory allocations but it doesn't prevent the VRAM carveout
from being created because that happens before we have a chance to check
the GPU IOMMU state in adreno_bind.

There are a number of possible options to resolve this but none of them are
very clean. The easiest way is to likely specify vram=0 as module parameter
on headless devices so that the memory doesn't get wasted.

Signed-off-by: Jordan Crouse <jorcrous@amazon.com>
---

 drivers/gpu/drm/msm/adreno/adreno_device.c | 6 +++++-
 drivers/gpu/drm/msm/msm_drv.c              | 7 +++----
 drivers/gpu/drm/msm/msm_drv.h              | 2 +-
 3 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/adreno_device.c b/drivers/gpu/drm/msm/adreno/adreno_device.c
index 36f062c7582f..4f19da28f80f 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_device.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_device.c
@@ -539,7 +539,11 @@ static int adreno_bind(struct device *dev, struct device *master, void *data)
 	DBG("Found GPU: %u.%u.%u.%u", config.rev.core, config.rev.major,
 		config.rev.minor, config.rev.patchid);
 
-	priv->is_a2xx = config.rev.core == 2;
+	/*
+	 * A2xx has a built in IOMMU and all other IOMMU enabled targets will
+	 * have an ARM IOMMU attached
+	 */
+	priv->has_gpu_iommu = config.rev.core == 2 || device_iommu_mapped(dev);
 	priv->has_cached_coherent = config.rev.core >= 6;
 
 	gpu = info->init(drm);
diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
index aca48c868c14..a125a351ec90 100644
--- a/drivers/gpu/drm/msm/msm_drv.c
+++ b/drivers/gpu/drm/msm/msm_drv.c
@@ -318,11 +318,10 @@ bool msm_use_mmu(struct drm_device *dev)
 	struct msm_drm_private *priv = dev->dev_private;
 
 	/*
-	 * a2xx comes with its own MMU
-	 * On other platforms IOMMU can be declared specified either for the
-	 * MDP/DPU device or for its parent, MDSS device.
+	 * Return true if the GPU or the MDP/DPU or parent MDSS device has an
+	 * IOMMU
 	 */
-	return priv->is_a2xx ||
+	return priv->has_gpu_iommu ||
 		device_iommu_mapped(dev->dev) ||
 		device_iommu_mapped(dev->dev->parent);
 }
diff --git a/drivers/gpu/drm/msm/msm_drv.h b/drivers/gpu/drm/msm/msm_drv.h
index 9f0c184b02a0..f33f94acd1b9 100644
--- a/drivers/gpu/drm/msm/msm_drv.h
+++ b/drivers/gpu/drm/msm/msm_drv.h
@@ -126,7 +126,7 @@ struct msm_drm_private {
 	struct msm_gpu *gpu;
 
 	/* gpu is only set on open(), but we need this info earlier */
-	bool is_a2xx;
+	bool has_gpu_iommu;
 	bool has_cached_coherent;
 
 	struct drm_fb_helper *fbdev;
-- 
2.34.1

