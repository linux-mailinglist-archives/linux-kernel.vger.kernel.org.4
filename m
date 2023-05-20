Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 481A670A7FF
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 14:21:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231736AbjETMU5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 May 2023 08:20:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231784AbjETMUg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 May 2023 08:20:36 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 658C7E6D
        for <linux-kernel@vger.kernel.org>; Sat, 20 May 2023 05:20:02 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4f3b9c88af8so163126e87.2
        for <linux-kernel@vger.kernel.org>; Sat, 20 May 2023 05:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684585200; x=1687177200;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jEG7D8dDSqo05e8UhKgqNHGqbXe0pvKNUFpleUKYXVg=;
        b=I+Q3ewZykqObWHuKmqMPuJPGa3NjNoeRSIFQSrxfdGMyJ8QZus7o1u2rIwOciol6ij
         7lO60fSX2PeeqP+aSOVKvs0jToT8xNMFRS1Q233kBQGg+VCxzdBLRr6lCuDl8g4BNLZ2
         oiMIH+/WEQYkpTA5dog0TVx2LnYQCHCLprTjwZjY9gbieHYUzkui909KCXd+FlfDGSX0
         Av0XYR0qJZhBAIZjBXR9foRILwwsqAwWRHZ4BbevSgVyob/kTKLAwfwd/zfjoPWhYPf7
         6sPgR8TtZ58hq2+mit63Q8Jzu54ObT3rbMCw6XPnA9NruJSRxIAhteVSG67+B+sQ4hTS
         aGUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684585200; x=1687177200;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jEG7D8dDSqo05e8UhKgqNHGqbXe0pvKNUFpleUKYXVg=;
        b=WTeGoJYpCpigS0lm7BMQqj0UozV9pA/fwQpBOwG1++q23ucYQ8j8ym+XhfmnN8WAUQ
         G9VwCCwgVaOzv7qghaPbCJGmyD5a4BD9uVeM3S0GHZtGot1cYzBZ7sfRLxA+EWXt0Xto
         JscPnTWQWmzCzmRTEmqpFsv+Ge5tUOsCZ5B+dA99VdQblzMFLcg6167O1NHIBV3Yy7yj
         9JR4C6FCzHtG51MM7nH+UzTE9c2DCdGrocwombQwEUF4X+oePyKR3sVBD0S5LpIb0V3b
         R6Q8O/QWxAR1wWzB8ZYB8zAV3qpCk5ITvxnJqceYGRRjJDaGTxL0/n7WYf12Bf3IoBZj
         rkOw==
X-Gm-Message-State: AC+VfDyvXeuSf6frs1rNVka4UZhnUZCn2Eqg0oG7pqkKLJVN+cXf4jgk
        QIFYl0rOfWRSdM8FPFHjv0TJ9g==
X-Google-Smtp-Source: ACHHUZ4Gs+fVbgITqcw+rliR2PEwd5WYSfQWfpcD1Pe4CNQyANny3sRLpUXp92PtuAZoJk3qkE7rvg==
X-Received: by 2002:ac2:4430:0:b0:4f3:a99c:fbbe with SMTP id w16-20020ac24430000000b004f3a99cfbbemr1824929lfl.14.1684585200406;
        Sat, 20 May 2023 05:20:00 -0700 (PDT)
Received: from [192.168.1.101] (abxi58.neoplus.adsl.tpnet.pl. [83.9.2.58])
        by smtp.gmail.com with ESMTPSA id y6-20020ac24466000000b004f37bd02a89sm244766lfl.287.2023.05.20.05.19.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 May 2023 05:20:00 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Sat, 20 May 2023 14:19:48 +0200
Subject: [PATCH v7 08/18] drm/msm/a6xx: Remove both GBIF and RBBM GBIF halt
 on hw init
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230223-topic-gmuwrapper-v7-8-ecc7aab83556@linaro.org>
References: <20230223-topic-gmuwrapper-v7-0-ecc7aab83556@linaro.org>
In-Reply-To: <20230223-topic-gmuwrapper-v7-0-ecc7aab83556@linaro.org>
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
        Marijn Suijten <marijn.suijten@somainline.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1684585186; l=1283;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=JTiDWY7uw1D1PMKchNdprqbjJGR71Zsm7TruEBGJMeY=;
 b=4fROckR5rLH3nc9STYL54zMi3UHMYli5trCboT4r1jFi+HW8CMYFLBcgvzFiaAFA1KSk3V9o3
 dc8cPUDGdU4DS+0RsJGbbtpgR27R2+TdgG433dly6u3cehfgmM1p2Yh
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently we're only deasserting REG_A6XX_RBBM_GBIF_HALT, but we also
need REG_A6XX_GBIF_HALT to be set to 0.

This is typically done automatically on successful GX collapse, but in
case that fails, we should take care of it.

Also, add a memory barrier to ensure it's gone through before jumping
to further initialization.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index 083ccb5bcb4e..dfde5fb65eed 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -1003,8 +1003,12 @@ static int hw_init(struct msm_gpu *gpu)
 	a6xx_gmu_set_oob(&a6xx_gpu->gmu, GMU_OOB_GPU_SET);
 
 	/* Clear GBIF halt in case GX domain was not collapsed */
-	if (a6xx_has_gbif(adreno_gpu))
+	if (a6xx_has_gbif(adreno_gpu)) {
+		gpu_write(gpu, REG_A6XX_GBIF_HALT, 0);
 		gpu_write(gpu, REG_A6XX_RBBM_GBIF_HALT, 0);
+		/* Let's make extra sure that the GPU can access the memory.. */
+		mb();
+	}
 
 	gpu_write(gpu, REG_A6XX_RBBM_SECVID_TSB_CNTL, 0);
 

-- 
2.40.1

