Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D98E732383
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 01:22:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239645AbjFOXWe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 19:22:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239185AbjFOXWF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 19:22:05 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5505830DC
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 16:21:41 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-4f640e48bc3so11252696e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 16:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686871299; x=1689463299;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L+TVhBBKRUS2B/z8pS7wjP7swdoiJrJVs5F8KW7VIYM=;
        b=WV8n5HFl5rBMncwRQgxWFtUGnZvsSUJAk14Qygq5K/fTGLN9SXB3p2pM3AONYV2eRR
         nWPHVuR3fIJk7+DTgIGp31tnAl2qja+52rui9M+JCAxZ8PB+Z01D/zZLK3427nj/Sf7r
         Zm/PsV+3NBN+eYLYFmYZACGDtHO4cevmrrFfDcqIVmHRJ0zWn+RLhufwZFjpH39nZnzA
         pfRylr+GqtkIKmj9nq71JxApn8vHr7nhy4TMlLX7fsxTJncyraEThweMrBzUvq45mTrq
         eK5uN5UDUTOYhrj+Fg1QpXKxJbLn/VvyT8eieWEzFvqiSddoijBWYAN2yrqhogdlpjlc
         hgrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686871299; x=1689463299;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L+TVhBBKRUS2B/z8pS7wjP7swdoiJrJVs5F8KW7VIYM=;
        b=dut47daulvHlkOfr8DDNa86FHT8In8Rf4begChnJGVDljHAD5Sy3c8qDz0pVc6oAWu
         TdpoqUMbkrnb+nSSLvmKahBv1E0bx0gKsNjbvTJbmcTsIS22uAthFL/2s4qGcHhNwUJ6
         7rnNxy7yhGERBFz9tFKN2qaMNbuYNMQk0093vWl1qaeybOYEzWDkKYN9Ka8vVYQY3Xk3
         VZmS7qs7L4DHQXLflfZN3QNGM+QeFCnmln1u2mM9xDy7SJTUDtQ+yxJfgoYQ5mlEk5g8
         8eBND0g/fYJf9y9iYW80rMYb5h9tsTrxkoIjKOWKagpH+0zfhQyIVdLohSPef2Gs7qAk
         qgCg==
X-Gm-Message-State: AC+VfDyohypz4anGaAsG3elxGYjZ8fz3pBH5mkLaOmk9P8wypRE2p+cF
        b4xPQQjYoVpknHF34uRAN2Yhqg==
X-Google-Smtp-Source: ACHHUZ4n36pYAckaRYbqmGsxTzHTFoV5ax5z5iMVD0zHb+446aB8zkIuGFCiXjQAg0ZUIdpQBbM+Ig==
X-Received: by 2002:a19:8c02:0:b0:4f8:4961:6aa9 with SMTP id o2-20020a198c02000000b004f849616aa9mr99387lfd.8.1686871299682;
        Thu, 15 Jun 2023 16:21:39 -0700 (PDT)
Received: from [192.168.1.101] (abyj190.neoplus.adsl.tpnet.pl. [83.9.29.190])
        by smtp.gmail.com with ESMTPSA id u25-20020a056512041900b004f24ee39661sm2744852lfk.137.2023.06.15.16.21.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jun 2023 16:21:39 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Fri, 16 Jun 2023 01:20:55 +0200
Subject: [PATCH v9 14/20] drm/msm/a6xx: Add support for A619_holi
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230223-topic-gmuwrapper-v9-14-890d8f470c8b@linaro.org>
References: <20230223-topic-gmuwrapper-v9-0-890d8f470c8b@linaro.org>
In-Reply-To: <20230223-topic-gmuwrapper-v9-0-890d8f470c8b@linaro.org>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Clark <robdclark@chromium.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1686871277; l=4063;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=ATtA2V/YLegt8/q2Uu20SduFtLhbxHciiWCX+CGAu+4=;
 b=+ygqn6qEEI4gFIhGSWrLrM1KaKJPg06Dr12/WJ1UnxAa0ImLj7nrdziLC4Pk++hsQ2h46rcD1
 uFozTkkHrmlBhpfeAT7V7g3aGQIeZGhKeI9WaoHdKYl8hAYqmIk5rPx
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A619_holi is a GMU-less variant of the already-supported A619 GPU.
It's present on at least SM4350 (holi) and SM6375 (blair). No mesa
changes are required. Add the required kernel-side support for it.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c   | 27 +++++++++++++++++++++++++--
 drivers/gpu/drm/msm/adreno/adreno_gpu.h |  5 +++++
 2 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index b91fc02eb08c..2ca9e0440396 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -911,6 +911,9 @@ static void a6xx_set_ubwc_config(struct msm_gpu *gpu)
 	if (adreno_is_a618(adreno_gpu))
 		return;
 
+	if (adreno_is_a619_holi(adreno_gpu))
+		hbb_lo = 0;
+
 	if (adreno_is_a640_family(adreno_gpu))
 		amsbc = 1;
 
@@ -1135,7 +1138,12 @@ static int hw_init(struct msm_gpu *gpu)
 	}
 
 	/* Clear GBIF halt in case GX domain was not collapsed */
-	if (a6xx_has_gbif(adreno_gpu)) {
+	if (adreno_is_a619_holi(adreno_gpu)) {
+		gpu_write(gpu, REG_A6XX_GBIF_HALT, 0);
+		gpu_write(gpu, REG_A6XX_RBBM_GPR0_CNTL, 0);
+		/* Let's make extra sure that the GPU can access the memory.. */
+		mb();
+	} else if (a6xx_has_gbif(adreno_gpu)) {
 		gpu_write(gpu, REG_A6XX_GBIF_HALT, 0);
 		gpu_write(gpu, REG_A6XX_RBBM_GBIF_HALT, 0);
 		/* Let's make extra sure that the GPU can access the memory.. */
@@ -1144,6 +1152,9 @@ static int hw_init(struct msm_gpu *gpu)
 
 	gpu_write(gpu, REG_A6XX_RBBM_SECVID_TSB_CNTL, 0);
 
+	if (adreno_is_a619_holi(adreno_gpu))
+		a6xx_sptprac_enable(gmu);
+
 	/*
 	 * Disable the trusted memory range - we don't actually supported secure
 	 * memory rendering at this point in time and we don't want to block off
@@ -1760,12 +1771,18 @@ static void a6xx_llc_slices_init(struct platform_device *pdev,
 #define GBIF_CLIENT_HALT_MASK		BIT(0)
 #define GBIF_ARB_HALT_MASK		BIT(1)
 #define VBIF_XIN_HALT_CTRL0_MASK	GENMASK(3, 0)
+#define VBIF_RESET_ACK_MASK		0xF0
+#define GPR0_GBIF_HALT_REQUEST		0x1E0
 
 void a6xx_bus_clear_pending_transactions(struct adreno_gpu *adreno_gpu, bool gx_off)
 {
 	struct msm_gpu *gpu = &adreno_gpu->base;
 
-	if (!a6xx_has_gbif(adreno_gpu)) {
+	if (adreno_is_a619_holi(adreno_gpu)) {
+		gpu_write(gpu, REG_A6XX_RBBM_GPR0_CNTL, GPR0_GBIF_HALT_REQUEST);
+		spin_until((gpu_read(gpu, REG_A6XX_RBBM_VBIF_GX_RESET_STATUS) &
+				(VBIF_RESET_ACK_MASK)) == VBIF_RESET_ACK_MASK);
+	} else if (!a6xx_has_gbif(adreno_gpu)) {
 		gpu_write(gpu, REG_A6XX_VBIF_XIN_HALT_CTRL0, VBIF_XIN_HALT_CTRL0_MASK);
 		spin_until((gpu_read(gpu, REG_A6XX_VBIF_XIN_HALT_CTRL1) &
 				(VBIF_XIN_HALT_CTRL0_MASK)) == VBIF_XIN_HALT_CTRL0_MASK);
@@ -1861,6 +1878,9 @@ static int a6xx_pm_resume(struct msm_gpu *gpu)
 	if (ret)
 		goto err_bulk_clk;
 
+	if (adreno_is_a619_holi(adreno_gpu))
+		a6xx_sptprac_enable(gmu);
+
 	/* If anything goes south, tear the GPU down piece by piece.. */
 	if (ret) {
 err_bulk_clk:
@@ -1920,6 +1940,9 @@ static int a6xx_pm_suspend(struct msm_gpu *gpu)
 	/* Drain the outstanding traffic on memory buses */
 	a6xx_bus_clear_pending_transactions(adreno_gpu, true);
 
+	if (adreno_is_a619_holi(adreno_gpu))
+		a6xx_sptprac_disable(gmu);
+
 	clk_bulk_disable_unprepare(gpu->nr_clocks, gpu->grp_clks);
 
 	pm_runtime_put_sync(gmu->gxpd);
diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.h b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
index de0b03a4b594..efd35b7bc4cf 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.h
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
@@ -263,6 +263,11 @@ static inline int adreno_is_a619(const struct adreno_gpu *gpu)
 	return adreno_is_revn(gpu, 619);
 }
 
+static inline int adreno_is_a619_holi(const struct adreno_gpu *gpu)
+{
+	return adreno_is_a619(gpu) && adreno_has_gmu_wrapper(gpu);
+}
+
 static inline int adreno_is_a630(const struct adreno_gpu *gpu)
 {
 	return adreno_is_revn(gpu, 630);

-- 
2.41.0

