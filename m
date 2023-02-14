Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D63E696BAA
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 18:32:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232227AbjBNRc2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 12:32:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231359AbjBNRcW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 12:32:22 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA64E2E806
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 09:32:12 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id dz21so6457157edb.13
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 09:32:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aCCbSlMjNx5L3JbI+yxmCqJTM703drqGHbbH/KoYNcE=;
        b=UB/rfIQ8kQgMmMUAWxOZPzuSgFHFDqpMLIMDpHWl7HIegwaxvdZaqGa30kHwfTbeQp
         7ZsMd8W+dKrdk+I9p10m1aTphQTC3KM2K7Qavphr4HBOUAusWmL4W3h+HluIsFtPNWeZ
         Ul6OWFxJxszjGTuWkyjNFyUMuWvFvt8BZx1e8WneRxUXp8XzxW8ynqh7fkiM0H8EulSZ
         dPS0fxPF4towZpOtmdyNIUFwirKsNqNkiiaJSwj4Gi9BCCPoOnAv14K04jpy3jGav+pK
         jwbn6j/p095LA+2apeELdP6lbcXngMgtm0gNyHDEILSEQxHBNegYylL2cwYbB6bCSpVl
         rLeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aCCbSlMjNx5L3JbI+yxmCqJTM703drqGHbbH/KoYNcE=;
        b=aOafw/MmOHbV0QvZAi3dI/+kkgI/oa2BBkiWVQCJaEuAjWGwyJkKuFxvJoH9Zel3J+
         5pGq8zLPKSq8j9412mcGFMsrkYIo6ohbYGa11SN1OklvRpgeoQa8qVSAK4/oQcB8Ku2C
         NCDUOe4MdplkcHy7p9XmlTwX8yS58VzaQhY1Ne6yRIaCkYGFSLqlLyfG8FnjayVWh8cv
         IDRFLh5sTuzoFH6W6UW4bk9LApv/4Rbr+v7AhjDB/wngU31SfHFVGTEEvgmtKRkYfXvr
         2qmRl9onRIaTyzDu36RFHuAvvoq1H9+XswxTdut1mk+zf+4wSsINqnlwWW19bMd3oPXO
         Budg==
X-Gm-Message-State: AO0yUKVJppd+7Md4r55RnJEBddvKuYFCeLDBWL2gVidmqB7tKkKfhyxX
        xFyHn97ICf2ZhX+/LmJeDzu5nA==
X-Google-Smtp-Source: AK7set8Qu1sZENJSKRws0s9U+f/9W6outwfMSSC/5d4Kj6gfPjPKyISNG9v6fJ8GsR8Y4KxoC+/koQ==
X-Received: by 2002:a50:d5de:0:b0:4aa:aaf6:e6be with SMTP id g30-20020a50d5de000000b004aaaaf6e6bemr3648055edj.7.1676395931356;
        Tue, 14 Feb 2023 09:32:11 -0800 (PST)
Received: from localhost.localdomain (abxh117.neoplus.adsl.tpnet.pl. [83.9.1.117])
        by smtp.gmail.com with ESMTPSA id w8-20020a50c448000000b0049668426aa6sm8325787edf.24.2023.02.14.09.32.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 09:32:10 -0800 (PST)
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
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Emma Anholt <emma@anholt.net>, Chia-I Wu <olvaffe@gmail.com>,
        Dan Carpenter <error27@gmail.com>,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 06/14] drm/msm/gpu: Use dev_pm_opp_set_rate for non-GMU GPUs
Date:   Tue, 14 Feb 2023 18:31:37 +0100
Message-Id: <20230214173145.2482651-7-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230214173145.2482651-1-konrad.dybcio@linaro.org>
References: <20230214173145.2482651-1-konrad.dybcio@linaro.org>
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

Currently we only utilize the OPP table connected to the GPU for
getting (available) frequencies. We do however need to scale the
voltage rail(s) accordingly to ensure that we aren't trying to
run the GPU at 1GHz with a VDD_LOW vote, as that would result in
an otherwise inexplainable hang.

Tell the OPP framework that we want to scale the "core" clock
and swap out the clk_set_rate to a dev_pm_opp_set_rate in
msm_devfreq_target() to enable usage of required-opps and by
extension proper voltage level/corner scaling.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/gpu/drm/msm/adreno/adreno_gpu.c | 4 ++++
 drivers/gpu/drm/msm/msm_gpu_devfreq.c   | 2 +-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
index ce6b76c45b6f..15e405e4f977 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
@@ -1047,6 +1047,10 @@ int adreno_gpu_init(struct drm_device *drm, struct platform_device *pdev,
 	const char *gpu_name;
 	u32 speedbin;
 
+	/* This can only be done here, or devm_pm_opp_set_supported_hw will WARN_ON() */
+	if (!IS_ERR(devm_clk_get(dev, "core")))
+		devm_pm_opp_set_clkname(dev, "core");
+
 	adreno_gpu->funcs = funcs;
 	adreno_gpu->info = adreno_info(config->rev);
 	adreno_gpu->gmem = adreno_gpu->info->gmem;
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
2.39.1

