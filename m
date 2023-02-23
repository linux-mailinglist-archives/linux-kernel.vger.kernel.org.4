Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46AD36A06A8
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 11:52:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233883AbjBWKwW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 05:52:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233850AbjBWKwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 05:52:11 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66D565A3A8
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 02:52:09 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id s22so13180364lfi.9
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 02:52:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kOnarmskAJLopy40U3oKLXvwONPiZjzBhb9uGjfbEpM=;
        b=v6mJXgjMBuGtfrSDWhwelPVQPy3Ud+cSwx2/evKTPdSq2McQWPDRRTSbbBwaf5CVUa
         Pf52PM0d3kILST+/20WP0ERnplsPF6R+swwCslmoH1hrDDvvFtXCBoFy39K8UnN9TMxz
         kXq41D5IOYUlKtzL8yK3m3TtlG61F/dXmnTamm0m2rA+IWz2rpvpwTz+jmK7fcp2xtFU
         qcF54AiBnvXe7Czvj8VBl/LHxTjUeyZRZc25/b8Y+JBMUIpETQUxKzNuJYHI9lY67SPC
         nUXdP22icW4dJvyJ9td1/c5TTGcxNwXq0pyfElh/NPu4nyunz3ER13hHZDxNzNHnvHWz
         +W2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kOnarmskAJLopy40U3oKLXvwONPiZjzBhb9uGjfbEpM=;
        b=Gdeae24SoQfUDBfs1qhwTB5cyeCBQByA0VLUzbs8gOfmpcNXeLRjUoj94RBBuhROll
         0MhqdonuAvOPC9Y6zHgPF1x0FtwUdoTmAPI8mK/UwjghX4O6TyTJ/6RdKaEz7ySLN8bC
         isKKMiwdaMC+aOeLWd7O96dVnjYAkjgFGRyIY45+2KV0NbHPtNs6fyrEEI7SSVEJmRLR
         a+TkJXfjYQ/VOsEp8RLfmFHyp/m4UhZbBOEsaZUKxD+xvwp/LQwDMptqFfcTjtpPuP3j
         /zxvAbysgokwhQID/YGt1RtNJPB2N/zAXai/ZS/FYNAJtC/HdIJ/2tIhk5eDyGJbRMva
         tEeQ==
X-Gm-Message-State: AO0yUKXQ6dwGRIy553xcSiR90WVkgdMudaAzsThUNKNTat9F0Psi0wb0
        e1h7YIfChOjRqMHgWEcBbPRuWQ==
X-Google-Smtp-Source: AK7set+Ll6LguG7fwI+ZW1MKrmT0txqLk0/wruezIlzF3Nb5y2FtSmtqTMkvKl3ULG0p0w7fygQDvQ==
X-Received: by 2002:ac2:5df1:0:b0:4db:1bee:c with SMTP id z17-20020ac25df1000000b004db1bee000cmr3797826lfq.44.1677149527659;
        Thu, 23 Feb 2023 02:52:07 -0800 (PST)
Received: from [192.168.1.101] (abxi151.neoplus.adsl.tpnet.pl. [83.9.2.151])
        by smtp.gmail.com with ESMTPSA id m25-20020ac24ad9000000b004cf07a0051csm262304lfp.228.2023.02.23.02.52.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Feb 2023 02:52:07 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Thu, 23 Feb 2023 11:51:59 +0100
Subject: [PATCH v3 3/7] drm/msm/adreno: Use OPP for every GPU generation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230223-topic-opp-v3-3-5f22163cd1df@linaro.org>
References: <20230223-topic-opp-v3-0-5f22163cd1df@linaro.org>
In-Reply-To: <20230223-topic-opp-v3-0-5f22163cd1df@linaro.org>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1677149522; l=6284;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=glYRGSAYYXQFh91qm5j1elUuZYdypRgrsNPyka/F8vE=;
 b=aNk/6sMX10joDOfNNA+zMQRVgVNP1GQlVvN6+WTjJArXs6Mfezf/axeXVsw/hubjtzdfeQUk1CiW
 5U+fuMvaA3Ke1TyL+vpAeDKopiEgfvO0Rk1oXpIN8/6EVjfjMp2L
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some older GPUs (namely a2xx with no opp tables at all and a320 with
downstream-remnants gpu pwrlevels) used not to have OPP tables. They
both however had just one frequency defined, making it extremely easy
to construct such an OPP table from within the driver if need be.

Do so and switch all clk_set_rate calls on core_clk to their OPP
counterparts.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/gpu/drm/msm/adreno/adreno_gpu.c | 99 +++++++++++++++------------------
 drivers/gpu/drm/msm/msm_gpu.c           |  4 +-
 drivers/gpu/drm/msm/msm_gpu_devfreq.c   |  2 +-
 3 files changed, 47 insertions(+), 58 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
index ce6b76c45b6f..d12f2f314022 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
@@ -922,73 +922,46 @@ void adreno_wait_ring(struct msm_ringbuffer *ring, uint32_t ndwords)
 			ring->id);
 }
 
-/* Get legacy powerlevels from qcom,gpu-pwrlevels and populate the opp table */
-static int adreno_get_legacy_pwrlevels(struct device *dev)
-{
-	struct device_node *child, *node;
-	int ret;
-
-	node = of_get_compatible_child(dev->of_node, "qcom,gpu-pwrlevels");
-	if (!node) {
-		DRM_DEV_DEBUG(dev, "Could not find the GPU powerlevels\n");
-		return -ENXIO;
-	}
-
-	for_each_child_of_node(node, child) {
-		unsigned int val;
-
-		ret = of_property_read_u32(child, "qcom,gpu-freq", &val);
-		if (ret)
-			continue;
-
-		/*
-		 * Skip the intentionally bogus clock value found at the bottom
-		 * of most legacy frequency tables
-		 */
-		if (val != 27000000)
-			dev_pm_opp_add(dev, val, 0);
-	}
-
-	of_node_put(node);
-
-	return 0;
-}
-
-static void adreno_get_pwrlevels(struct device *dev,
+static int adreno_get_pwrlevels(struct device *dev,
 		struct msm_gpu *gpu)
 {
+	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
 	unsigned long freq = ULONG_MAX;
 	struct dev_pm_opp *opp;
 	int ret;
 
 	gpu->fast_rate = 0;
 
-	/* You down with OPP? */
-	if (!of_find_property(dev->of_node, "operating-points-v2", NULL))
-		ret = adreno_get_legacy_pwrlevels(dev);
-	else {
-		ret = devm_pm_opp_of_add_table(dev);
-		if (ret)
-			DRM_DEV_ERROR(dev, "Unable to set the OPP table\n");
-	}
-
-	if (!ret) {
-		/* Find the fastest defined rate */
-		opp = dev_pm_opp_find_freq_floor(dev, &freq);
-		if (!IS_ERR(opp)) {
-			gpu->fast_rate = freq;
-			dev_pm_opp_put(opp);
+	/* devm_pm_opp_of_add_table may error out but will still create an OPP table */
+	ret = devm_pm_opp_of_add_table(dev);
+	if (ret == -ENODEV) {
+		/* Special cases for ancient hw with ancient DT bindings */
+		if (adreno_is_a2xx(adreno_gpu)) {
+			dev_warn(dev, "Unable to find the OPP table. Falling back to 200 MHz.\n");
+			dev_pm_opp_add(dev, 200000000, 0);
+		} else if (adreno_is_a320(adreno_gpu)) {
+			dev_warn(dev, "Unable to find the OPP table. Falling back to 450 MHz.\n");
+			dev_pm_opp_add(dev, 450000000, 0);
+		} else {
+			DRM_DEV_ERROR(dev, "Unable to find the OPP table\n");
+			return -ENODEV;
 		}
+	} else if (ret) {
+		DRM_DEV_ERROR(dev, "Unable to set the OPP table\n");
+		return ret;
 	}
 
-	if (!gpu->fast_rate) {
-		dev_warn(dev,
-			"Could not find a clock rate. Using a reasonable default\n");
-		/* Pick a suitably safe clock speed for any target */
-		gpu->fast_rate = 200000000;
-	}
+	/* Find the fastest defined rate */
+	opp = dev_pm_opp_find_freq_floor(dev, &freq);
+	if (IS_ERR(opp))
+		return PTR_ERR(opp);
+
+	gpu->fast_rate = freq;
+	dev_pm_opp_put(opp);
 
 	DBG("fast_rate=%u, slow_rate=27000000", gpu->fast_rate);
+
+	return 0;
 }
 
 int adreno_gpu_ocmem_init(struct device *dev, struct adreno_gpu *adreno_gpu,
@@ -1046,6 +1019,20 @@ int adreno_gpu_init(struct drm_device *drm, struct platform_device *pdev,
 	struct adreno_rev *rev = &config->rev;
 	const char *gpu_name;
 	u32 speedbin;
+	int ret;
+
+	/*
+	 * This can only be done before devm_pm_opp_of_add_table(), or
+	 * dev_pm_opp_set_config() will WARN_ON()
+	 */
+	if (IS_ERR(devm_clk_get(dev, "core"))) {
+		/*
+		 * If "core" is absent, go for the legacy clock name.
+		 * If we got this far in probing, it's a given one of them exists.
+		 */
+		devm_pm_opp_set_clkname(dev, "core_clk");
+	} else
+		devm_pm_opp_set_clkname(dev, "core");
 
 	adreno_gpu->funcs = funcs;
 	adreno_gpu->info = adreno_info(config->rev);
@@ -1070,7 +1057,9 @@ int adreno_gpu_init(struct drm_device *drm, struct platform_device *pdev,
 
 	adreno_gpu_config.nr_rings = nr_rings;
 
-	adreno_get_pwrlevels(dev, gpu);
+	ret = adreno_get_pwrlevels(dev, gpu);
+	if (ret)
+		return ret;
 
 	pm_runtime_set_autosuspend_delay(dev,
 		adreno_gpu->info->inactive_period);
diff --git a/drivers/gpu/drm/msm/msm_gpu.c b/drivers/gpu/drm/msm/msm_gpu.c
index 380249500325..cdcb00df3f25 100644
--- a/drivers/gpu/drm/msm/msm_gpu.c
+++ b/drivers/gpu/drm/msm/msm_gpu.c
@@ -59,7 +59,7 @@ static int disable_pwrrail(struct msm_gpu *gpu)
 static int enable_clk(struct msm_gpu *gpu)
 {
 	if (gpu->core_clk && gpu->fast_rate)
-		clk_set_rate(gpu->core_clk, gpu->fast_rate);
+		dev_pm_opp_set_rate(&gpu->pdev->dev, gpu->fast_rate);
 
 	/* Set the RBBM timer rate to 19.2Mhz */
 	if (gpu->rbbmtimer_clk)
@@ -78,7 +78,7 @@ static int disable_clk(struct msm_gpu *gpu)
 	 * will be rounded down to zero anyway so it all works out.
 	 */
 	if (gpu->core_clk)
-		clk_set_rate(gpu->core_clk, 27000000);
+		dev_pm_opp_set_rate(&gpu->pdev->dev, 27000000);
 
 	if (gpu->rbbmtimer_clk)
 		clk_set_rate(gpu->rbbmtimer_clk, 0);
diff --git a/drivers/gpu/drm/msm/msm_gpu_devfreq.c b/drivers/gpu/drm/msm/msm_gpu_devfreq.c
index e27dbf12b5e8..ea70c1c32d94 100644
--- a/drivers/gpu/drm/msm/msm_gpu_devfreq.c
+++ b/drivers/gpu/drm/msm/msm_gpu_devfreq.c
@@ -48,7 +48,7 @@ static int msm_devfreq_target(struct device *dev, unsigned long *freq,
 		gpu->funcs->gpu_set_freq(gpu, opp, df->suspended);
 		mutex_unlock(&df->lock);
 	} else {
-		clk_set_rate(gpu->core_clk, *freq);
+		dev_pm_opp_set_rate(dev, *freq);
 	}
 
 	dev_pm_opp_put(opp);

-- 
2.39.2

