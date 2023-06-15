Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B0B7732370
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 01:22:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239223AbjFOXWF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 19:22:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239068AbjFOXVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 19:21:41 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 887F12972
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 16:21:29 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4f762b3227dso256518e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 16:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686871288; x=1689463288;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VdelOgpuK3XacSGUaivE1M7Dtjzj0Im9GIbVnmMBHAI=;
        b=fwMjNHV8C5nXO8bPmPoAb20mcUZa+AOFrkxPgzS0kC57dPb3d5cMn0aehR9t0ZLmbK
         JTiyTBpqZEXXhdNbOoAzE1CMuWrau9s2wN/EOeHmtFSq2aO7H/CCkB+brJKZAeN29Afr
         4uJs/mt+NvoCBHGayJX5Xn3S7LZzUvVO2h4Y+8EiqG7aRyN7Z8tJuqGIVzXzQnHMrhyI
         cqZTIne0j09rd8mzdkMqwDpptedKMXJBtefHPoHY3kvCWpXpcgI3jpIMIYj6B7pFUD/e
         uoGPO0H0yljadwsqzaQ93YdomBGnrJwbU5Pph9HNSPwjo5ITYhTvm6xL8+G82eYajin8
         hGEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686871288; x=1689463288;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VdelOgpuK3XacSGUaivE1M7Dtjzj0Im9GIbVnmMBHAI=;
        b=L8Qhju587tRBPs5y1HbkC4uuYlK/IsDQ6vSrJXsj2394a6jEGLxhWJwVgJiRrAOlA4
         PW/tsJJ2AKyhrE0lOR0JMwuxSBn+GBrXNa7IotWWFLyk2ElD4NOFA+ozoPayKKkxOJ4L
         IXdB468j2tKcXIaurnV5F7sjSGwf4qN8KVyiGnTxWb3wlkVdbvTfsH4VcXhrF0m2AKBT
         kCI5GfFezkWwlZRqf6K+M3M8PjWtdenvCLUZq7wcBUAWBOyNpYYLJ3Ix9mVDz1nhAgfi
         Lhg6UR8nOmEXaywCmGtMnuCqaofSjhxBmbyn9VCNc+VXYB14hpWj6LJyTavmwVMETBQw
         a2Kg==
X-Gm-Message-State: AC+VfDwsTPZyc0IZ2AyKc9ErjBNwbFdEnuoUBTIeNvHiBzGnXLDHt4w4
        /VSSjescacEsODo7VtqIlSfhfA==
X-Google-Smtp-Source: ACHHUZ4gYgm8y3d78Ar5R5M9B+KlPNlCGKZowaamYleHcxabm31ozYxTOc2Zudlx2F7TIsoZc7rjQQ==
X-Received: by 2002:a19:e341:0:b0:4f1:2ebf:536f with SMTP id c1-20020a19e341000000b004f12ebf536fmr63508lfk.16.1686871287800;
        Thu, 15 Jun 2023 16:21:27 -0700 (PDT)
Received: from [192.168.1.101] (abyj190.neoplus.adsl.tpnet.pl. [83.9.29.190])
        by smtp.gmail.com with ESMTPSA id u25-20020a056512041900b004f24ee39661sm2744852lfk.137.2023.06.15.16.21.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jun 2023 16:21:27 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Fri, 16 Jun 2023 01:20:47 +0200
Subject: [PATCH v9 06/20] drm/msm/a6xx: Move
 a6xx_bus_clear_pending_transactions to a6xx_gpu
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230223-topic-gmuwrapper-v9-6-890d8f470c8b@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1686871277; l=4596;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=Du7BRzmQsw5lwzfigmccIbHnHbypFGrfE8cKEgMRcLA=;
 b=5mb8ok8pQk2TM4oNRuuBYYgw0XKe4Y1lGERaQ7pd0r1T6fekl5TW7pD1CgliPFmqxe2aeAbJJ
 P6dnhKmYTeOC0HTvH0XtRIBN37rzwY3fKPL0isfg3m3L5u0cFj6GNSW
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This function is responsible for telling the GPU to halt transactions
on all of its relevant buses, drain them and leave them in a predictable
state, so that the GPU can be e.g. reset cleanly.

Move the function to a6xx_gpu.c, remove the static keyword and add a
prototype in a6xx_gpu.h to accomodate for the move.

Reviewed-by: Akhil P Oommen <quic_akhilpo@quicinc.com>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c | 37 -----------------------------------
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 36 ++++++++++++++++++++++++++++++++++
 drivers/gpu/drm/msm/adreno/a6xx_gpu.h |  2 ++
 3 files changed, 38 insertions(+), 37 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
index 32852c161aab..6402544f6849 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
@@ -868,43 +868,6 @@ static void a6xx_gmu_rpmh_off(struct a6xx_gmu *gmu)
 		(val & 1), 100, 1000);
 }
 
-#define GBIF_CLIENT_HALT_MASK             BIT(0)
-#define GBIF_ARB_HALT_MASK                BIT(1)
-
-static void a6xx_bus_clear_pending_transactions(struct adreno_gpu *adreno_gpu,
-		bool gx_off)
-{
-	struct msm_gpu *gpu = &adreno_gpu->base;
-
-	if (!a6xx_has_gbif(adreno_gpu)) {
-		gpu_write(gpu, REG_A6XX_VBIF_XIN_HALT_CTRL0, 0xf);
-		spin_until((gpu_read(gpu, REG_A6XX_VBIF_XIN_HALT_CTRL1) &
-								0xf) == 0xf);
-		gpu_write(gpu, REG_A6XX_VBIF_XIN_HALT_CTRL0, 0);
-
-		return;
-	}
-
-	if (gx_off) {
-		/* Halt the gx side of GBIF */
-		gpu_write(gpu, REG_A6XX_RBBM_GBIF_HALT, 1);
-		spin_until(gpu_read(gpu, REG_A6XX_RBBM_GBIF_HALT_ACK) & 1);
-	}
-
-	/* Halt new client requests on GBIF */
-	gpu_write(gpu, REG_A6XX_GBIF_HALT, GBIF_CLIENT_HALT_MASK);
-	spin_until((gpu_read(gpu, REG_A6XX_GBIF_HALT_ACK) &
-			(GBIF_CLIENT_HALT_MASK)) == GBIF_CLIENT_HALT_MASK);
-
-	/* Halt all AXI requests on GBIF */
-	gpu_write(gpu, REG_A6XX_GBIF_HALT, GBIF_ARB_HALT_MASK);
-	spin_until((gpu_read(gpu,  REG_A6XX_GBIF_HALT_ACK) &
-			(GBIF_ARB_HALT_MASK)) == GBIF_ARB_HALT_MASK);
-
-	/* The GBIF halt needs to be explicitly cleared */
-	gpu_write(gpu, REG_A6XX_GBIF_HALT, 0x0);
-}
-
 /* Force the GMU off in case it isn't responsive */
 static void a6xx_gmu_force_off(struct a6xx_gmu *gmu)
 {
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index eebb4bc7c0f9..a48f4e3a754a 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -1705,6 +1705,42 @@ static void a6xx_llc_slices_init(struct platform_device *pdev,
 		a6xx_gpu->llc_mmio = ERR_PTR(-EINVAL);
 }
 
+#define GBIF_CLIENT_HALT_MASK             BIT(0)
+#define GBIF_ARB_HALT_MASK                BIT(1)
+
+void a6xx_bus_clear_pending_transactions(struct adreno_gpu *adreno_gpu, bool gx_off)
+{
+	struct msm_gpu *gpu = &adreno_gpu->base;
+
+	if (!a6xx_has_gbif(adreno_gpu)) {
+		gpu_write(gpu, REG_A6XX_VBIF_XIN_HALT_CTRL0, 0xf);
+		spin_until((gpu_read(gpu, REG_A6XX_VBIF_XIN_HALT_CTRL1) &
+								0xf) == 0xf);
+		gpu_write(gpu, REG_A6XX_VBIF_XIN_HALT_CTRL0, 0);
+
+		return;
+	}
+
+	if (gx_off) {
+		/* Halt the gx side of GBIF */
+		gpu_write(gpu, REG_A6XX_RBBM_GBIF_HALT, 1);
+		spin_until(gpu_read(gpu, REG_A6XX_RBBM_GBIF_HALT_ACK) & 1);
+	}
+
+	/* Halt new client requests on GBIF */
+	gpu_write(gpu, REG_A6XX_GBIF_HALT, GBIF_CLIENT_HALT_MASK);
+	spin_until((gpu_read(gpu, REG_A6XX_GBIF_HALT_ACK) &
+			(GBIF_CLIENT_HALT_MASK)) == GBIF_CLIENT_HALT_MASK);
+
+	/* Halt all AXI requests on GBIF */
+	gpu_write(gpu, REG_A6XX_GBIF_HALT, GBIF_ARB_HALT_MASK);
+	spin_until((gpu_read(gpu,  REG_A6XX_GBIF_HALT_ACK) &
+			(GBIF_ARB_HALT_MASK)) == GBIF_ARB_HALT_MASK);
+
+	/* The GBIF halt needs to be explicitly cleared */
+	gpu_write(gpu, REG_A6XX_GBIF_HALT, 0x0);
+}
+
 static int a6xx_pm_resume(struct msm_gpu *gpu)
 {
 	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
index eea2e60ce3b7..9580def06d45 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
@@ -88,4 +88,6 @@ void a6xx_show(struct msm_gpu *gpu, struct msm_gpu_state *state,
 struct msm_gpu_state *a6xx_gpu_state_get(struct msm_gpu *gpu);
 int a6xx_gpu_state_put(struct msm_gpu_state *state);
 
+void a6xx_bus_clear_pending_transactions(struct adreno_gpu *adreno_gpu, bool gx_off);
+
 #endif /* __A6XX_GPU_H__ */

-- 
2.41.0

