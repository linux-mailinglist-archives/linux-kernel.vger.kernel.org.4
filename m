Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 334E0706EA8
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 18:51:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbjEQQuk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 12:50:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229827AbjEQQuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 12:50:24 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2079C4ED4
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 09:50:23 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2ac80ed7f26so10591111fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 09:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684342221; x=1686934221;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jKJzh3VBdMQOrvlfJ6ldWhmoYbX6WSR7/WgTonW/aWQ=;
        b=YmiF+k1DCo7sJT82Nk4sHD2XysqRnE+/gQkavGhTVbv/wfUHjEY8DCZp2ALGlIVFxK
         vFJI4qnhA+rQycQEkYdzapsq5QVvy9SXn5xlTDOoXdH3J1z58P59pbM7e5MxV4tA0hp3
         rbiaEhfSmmAB1rsLKvlYg6c7wOpxONwYICuOrUPT+3L/+in9V33CHGd/qHhzTf6wO3yG
         +Jvh6u1Zv7vUkNa2k4FikK39n3WwVam404AZmfXKxvskCzetQqAQjfBdSlJA3260QPCp
         37em6Erd7VhUrUSU/c10E737Ddrm8tAWCQ8bpq2ENKPG9oV1u1LR+ePlOFOzGeCaiwlF
         ZPbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684342221; x=1686934221;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jKJzh3VBdMQOrvlfJ6ldWhmoYbX6WSR7/WgTonW/aWQ=;
        b=HonRqfHyM6g3JkLOc8PqIr1qBLNZo518xrdnpCBz/+aPVDSe9ukpNm+gNOEk504DGp
         h0mhRtYvjSzx8/EDUrDl+3TfPAWVLEJsIfvZZDo2IhqIyGI2b542q1li3oOIQIF9oB4h
         HTA7HNACHXLpcQhpS7Lzd2RpGjJfx+JcqFzv+l4ZDT+OOCj1DjQSSgDV9R53OzV8xw95
         /tnUQkiqE8vxxkAhWu32Ir6YAjnuCKYLCvBA7FAcG4G+PEm82zX7wun20dW1CvuTREZN
         yxF3lGV9B+TbHavc8BsScXMKjtc7vMTkGAIZp8bxYTDvSPj41EJl2wlLR1dwkzcnQ/E8
         WkFw==
X-Gm-Message-State: AC+VfDzXqFeOCFYbdq9ey+T7DIFG9JNv2779BJjBsZCiteZ01ox0vcfN
        M+lAXbP+A+slLcO2rhFWDBH2SQ==
X-Google-Smtp-Source: ACHHUZ4scB0qXASKtXLDjxdCzSc8nOLwoqbw3Tshdmgqbc6XZcRpopUJoPcc0s3OQF9oqf10FQSm+g==
X-Received: by 2002:a2e:9d03:0:b0:2a7:a616:c39 with SMTP id t3-20020a2e9d03000000b002a7a6160c39mr9789440lji.48.1684342221526;
        Wed, 17 May 2023 09:50:21 -0700 (PDT)
Received: from [192.168.1.101] (abxi58.neoplus.adsl.tpnet.pl. [83.9.2.58])
        by smtp.gmail.com with ESMTPSA id g6-20020a2e9cc6000000b002af0e9abaf6sm159224ljj.131.2023.05.17.09.50.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 09:50:21 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Wed, 17 May 2023 18:50:12 +0200
Subject: [PATCH 5/6] drm/msm/a6xx: Use GMU_ALWAYS_ON_COUNTER for
 GMU-equipped GPUs in timestamp
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230517-topic-a7xx_prep-v1-5-7a964f2e99c2@linaro.org>
References: <20230517-topic-a7xx_prep-v1-0-7a964f2e99c2@linaro.org>
In-Reply-To: <20230517-topic-a7xx_prep-v1-0-7a964f2e99c2@linaro.org>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1684342212; l=1052;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=yXq/EvspiDM4WLys1dNWbAg7dVVScVQhvkOnD1ANMBI=;
 b=r6jwsVtQ4nvBF0AJY4c2o98RWESzy2qTp1iwGXmihRYAaw/Lb3C3Gds/eT2qIOq5DsqpEtp6u
 156ORD/lpIhDMiWaQkypMLl/VUZdMdWCtf9EjO5p0/D/H2C4QjxlzCj
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the always-on counter provided by the GMU to skip having to
keep the GPU online.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index 8707e8b6ac7e..d2a999b90589 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -1664,12 +1664,9 @@ static int a6xx_get_timestamp(struct msm_gpu *gpu, uint64_t *value)
 
 	mutex_lock(&a6xx_gpu->gmu.lock);
 
-	/* Force the GPU power on so we can read this register */
-	a6xx_gmu_set_oob(&a6xx_gpu->gmu, GMU_OOB_PERFCOUNTER_SET);
-
-	*value = gpu_read64(gpu, REG_A6XX_CP_ALWAYS_ON_COUNTER);
-
-	a6xx_gmu_clear_oob(&a6xx_gpu->gmu, GMU_OOB_PERFCOUNTER_SET);
+	*value = gmu_read64(&a6xx_gpu->gmu,
+			    REG_A6XX_GMU_ALWAYS_ON_COUNTER_L,
+			    REG_A6XX_GMU_ALWAYS_ON_COUNTER_H);
 
 	mutex_unlock(&a6xx_gpu->gmu.lock);
 

-- 
2.40.1

