Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58EA86A0839
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 13:07:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234302AbjBWMH4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 07:07:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234148AbjBWMHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 07:07:31 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6474855C1A
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 04:07:11 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id f41so13470391lfv.13
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 04:07:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SZ/xGzExvk13wbA4qbsvWe1ebWJNBnGJT8JbIK1eSfo=;
        b=GtD3uY6KVcOgkOy/CR8IknJL9LBoGlgXIYEaGeOKc0CRIfEwXT4DtWQO9jXwzMwbPF
         L2JeagzDKYh5+FsEjmID5ErNMkfMwwbjsnj73bNf/54dcBQLLEEO7y2Qy0ZsHGIgH9pv
         1n+GSDq2loo5S+XmYEEuqL7X1JtY8rIXGTP1qKgfu7FPfRRpBVsvzieJfDYmNAlyTx7Z
         5+pHzJgt1RbiaabHkywWJ7j0Iy9PKUw60/o8u/wbQK0os3388Ib3aifKtF5ZnIJdrmLc
         6PcqOrecwlT6BBgkFsYLLcbLepAYVzOEWfA654vlQTKYk4ucX9WZYRthAjPF4TEaQgK4
         6G3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SZ/xGzExvk13wbA4qbsvWe1ebWJNBnGJT8JbIK1eSfo=;
        b=RN10vDB/3h+nfWJEYfETJCUeDEkSbrKXO/mGTROisSnfT+Hv39ISbpqGrF0idK4x/G
         re1AUfX2AmxZlKI7JFXOwE6aRaIy+l69PLLVpF/Wf7TZkOEwsYI/IBiPl2vWQCOq0243
         zkTgL35pxBf87Ch6+dK4CMh/qsFQWupPgn0RiTya8fRa4h3xXTqGzK2lzLhNkHqvgk2F
         wWrhslgp80hAFuPcvHIq4RCK+cntJaVdjgqO4w0gHxMHIXQfKAC6Jtr7u+Yy7qBXQPFt
         toYIXp/TO1GCS0EM8cq8tKFvmOhsvcGvOC6brWLdQJ03qDvYBeMr5Cf2DrACz4H1/I+6
         B3zg==
X-Gm-Message-State: AO0yUKXhEdSPilKbWNA5eUKcpfMaRPgxOSyhpsYEK7m4s4Ixsk2vT7TA
        o2KR8+QpKXUOfS9BtaS/LXyi3w==
X-Google-Smtp-Source: AK7set85M6q9Qseas9oAZzSpJrj3R3yandRl8Q//18ZT9N2L1yKHvcS8kTOKNPxbLGdtL+pCZaX0Lw==
X-Received: by 2002:a19:700d:0:b0:4dc:554b:d27e with SMTP id h13-20020a19700d000000b004dc554bd27emr3475770lfc.65.1677154024955;
        Thu, 23 Feb 2023 04:07:04 -0800 (PST)
Received: from [192.168.1.101] (abxi151.neoplus.adsl.tpnet.pl. [83.9.2.151])
        by smtp.gmail.com with ESMTPSA id h23-20020a2ea497000000b0029599744c02sm414838lji.75.2023.02.23.04.07.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Feb 2023 04:07:04 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Thu, 23 Feb 2023 13:06:47 +0100
Subject: [PATCH v3 13/15] drm/msm/a6xx: Use adreno_is_aXYZ macros in
 speedbin matching
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230223-topic-gmuwrapper-v3-13-5be55a336819@linaro.org>
References: <20230223-topic-gmuwrapper-v3-0-5be55a336819@linaro.org>
In-Reply-To: <20230223-topic-gmuwrapper-v3-0-5be55a336819@linaro.org>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Clark <robdclark@chromium.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1677154003; l=4256;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=0V7/WcL1MABzv4zFeEQKs26sXQyT+kVWIiROsyIVolM=;
 b=D9HkDWtlsgD+vquVTDXjCdgIkGfxQXGREpBvyo4fJHN0h6p2nPKn83JtZsrqh0vEaY1HAeDwTV3K
 dCCpYpXNDdj3E2EvvGzpO//FKJ+LItrMDGREeje+rheuWwsQAJ9R
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

Before transitioning to using per-SoC and not per-Adreno speedbin
fuse values (need another patchset to land elsewhere), a good
improvement/stopgap solution is to use adreno_is_aXYZ macros in
place of explicit revision matching. Do so to allow differentiating
between A619 and A619_holi.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c   | 18 +++++++++---------
 drivers/gpu/drm/msm/adreno/adreno_gpu.h | 14 ++++++++++++--
 2 files changed, 21 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index f694acca931c..d49b649ebecf 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -2215,23 +2215,23 @@ static u32 adreno_7c3_get_speed_bin(u32 fuse)
 	return UINT_MAX;
 }
 
-static u32 fuse_to_supp_hw(struct device *dev, struct adreno_rev rev, u32 fuse)
+static u32 fuse_to_supp_hw(struct device *dev, struct adreno_gpu *adreno_gpu, u32 fuse)
 {
 	u32 val = UINT_MAX;
 
-	if (adreno_cmp_rev(ADRENO_REV(6, 1, 8, ANY_ID), rev))
+	if (adreno_is_a618(adreno_gpu))
 		val = a618_get_speed_bin(fuse);
 
-	else if (adreno_cmp_rev(ADRENO_REV(6, 1, 9, ANY_ID), rev))
+	else if (adreno_is_a619(adreno_gpu))
 		val = a619_get_speed_bin(fuse);
 
-	else if (adreno_cmp_rev(ADRENO_REV(6, 3, 5, ANY_ID), rev))
+	else if (adreno_is_7c3(adreno_gpu))
 		val = adreno_7c3_get_speed_bin(fuse);
 
-	else if (adreno_cmp_rev(ADRENO_REV(6, 4, 0, ANY_ID), rev))
+	else if (adreno_is_a640(adreno_gpu))
 		val = a640_get_speed_bin(fuse);
 
-	else if (adreno_cmp_rev(ADRENO_REV(6, 5, 0, ANY_ID), rev))
+	else if (adreno_is_a650(adreno_gpu))
 		val = a650_get_speed_bin(fuse);
 
 	if (val == UINT_MAX) {
@@ -2244,7 +2244,7 @@ static u32 fuse_to_supp_hw(struct device *dev, struct adreno_rev rev, u32 fuse)
 	return (1 << val);
 }
 
-static int a6xx_set_supported_hw(struct device *dev, struct adreno_rev rev)
+static int a6xx_set_supported_hw(struct device *dev, struct adreno_gpu *adreno_gpu)
 {
 	u32 supp_hw;
 	u32 speedbin;
@@ -2263,7 +2263,7 @@ static int a6xx_set_supported_hw(struct device *dev, struct adreno_rev rev)
 		return ret;
 	}
 
-	supp_hw = fuse_to_supp_hw(dev, rev, speedbin);
+	supp_hw = fuse_to_supp_hw(dev, adreno_gpu, speedbin);
 
 	ret = devm_pm_opp_set_supported_hw(dev, &supp_hw, 1);
 	if (ret)
@@ -2382,7 +2382,7 @@ struct msm_gpu *a6xx_gpu_init(struct drm_device *dev)
 	if (!adreno_has_gmu_wrapper(adreno_gpu))
 		a6xx_llc_slices_init(pdev, a6xx_gpu);
 
-	ret = a6xx_set_supported_hw(&pdev->dev, config->rev);
+	ret = a6xx_set_supported_hw(&pdev->dev, adreno_gpu);
 	if (ret) {
 		a6xx_destroy(&(a6xx_gpu->base.base));
 		return ERR_PTR(ret);
diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.h b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
index 27c30a7694f4..da9f45a13b5d 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.h
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
@@ -268,9 +268,9 @@ static inline int adreno_is_a630(struct adreno_gpu *gpu)
 	return gpu->revn == 630;
 }
 
-static inline int adreno_is_a640_family(struct adreno_gpu *gpu)
+static inline int adreno_is_a640(struct adreno_gpu *gpu)
 {
-	return (gpu->revn == 640) || (gpu->revn == 680);
+	return gpu->revn == 640;
 }
 
 static inline int adreno_is_a650(struct adreno_gpu *gpu)
@@ -289,6 +289,11 @@ static inline int adreno_is_a660(struct adreno_gpu *gpu)
 	return gpu->revn == 660;
 }
 
+static inline int adreno_is_a680(struct adreno_gpu *gpu)
+{
+	return gpu->revn == 680;
+}
+
 /* check for a615, a616, a618, a619 or any derivatives */
 static inline int adreno_is_a615_family(struct adreno_gpu *gpu)
 {
@@ -306,6 +311,11 @@ static inline int adreno_is_a650_family(struct adreno_gpu *gpu)
 	return gpu->revn == 650 || gpu->revn == 620 || adreno_is_a660_family(gpu);
 }
 
+static inline int adreno_is_a640_family(struct adreno_gpu *gpu)
+{
+	return adreno_is_a640(gpu) || adreno_is_a680(gpu);
+}
+
 u64 adreno_private_address_space_size(struct msm_gpu *gpu);
 int adreno_get_param(struct msm_gpu *gpu, struct msm_file_private *ctx,
 		     uint32_t param, uint64_t *value, uint32_t *len);

-- 
2.39.2

