Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D31CA67CFE6
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 16:18:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232440AbjAZPSg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 10:18:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232412AbjAZPS2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 10:18:28 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FBA26A45
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 07:17:53 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id s3so2163467edd.4
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 07:17:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HBljgGteQAY47rX7zWj3dPQzLacj5RUR5JpIAimyYnM=;
        b=SbrDbQSVGa/pHzpDolRvqqoipOFVH13a6CeMoNa/pHMYxXvbOgOUH4su+pM6Kt+RbP
         Bo5dfMGQKXsKbZvF2sG/tiDu7U40GsMQETx4agRp/7djuufEwlrMvDy8r2e4/S0FUjwa
         hbjLiz3blf6NMyvhWJP0UvBJ+tv3Vq5faJ2XYTa4sTivzh1v2WMrG5MqPPYYnEhHJK5f
         ZwJqmlUBjLqf7NtocSYrfTXayoxb0HedNRM1fr3VjFIQGMRkfqJ4Lo6RDpf89O7Pu8p3
         F73a7ycSleBr15Kv5iGa9kYVyfTESeyqKD7lrpn0F6M87XhlK8v3/W2ISc/SfYBPDolG
         fmlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HBljgGteQAY47rX7zWj3dPQzLacj5RUR5JpIAimyYnM=;
        b=RjoUPhXaMap4vBTNKQD43eZqE7izAHRzFQyh8VkCc0e+ZIMgC0AEt4LKxCxYZQ+xKd
         S+D52MS1X9S0vnrm8whGOcQwfVuzlIV2t7TDNnYtQ8ryR4+qhZlhTCSsx/TbVz/lE5Cj
         +9UKS3/WcN/CKTn7uhaFjuxhIV/DNdCMQpDLvdUeSVQLFaLPoKVLM6034FKlQEL6UL3X
         N5PjktM4/2U1MfTO/CIyGk12vRnjszdi8R6v+0Ctd9zjaoudN/2otcDhvU+Ab1xf4539
         2hIEoAg4zaK6402eBef90HgQz9OJ2fhIMgH9hx+pWH+sNKQXkp4EwYcTLmhuIejGdv0Z
         Wkyw==
X-Gm-Message-State: AFqh2kpJ4lJvwzqBE5phu/5s6P24cO4N2RooQlcfKUZUWdmdeDtYURdR
        mMxBxJusP2A6i2VyyQOaS/ZKlA==
X-Google-Smtp-Source: AMrXdXublsYoSfnqbgR5kg8baz2VjlQvEHCNy1LPZOA9GvVA5G5tqBrXObNDl315s1WMoBg2tndWzg==
X-Received: by 2002:a05:6402:f20:b0:468:58d4:a0f2 with SMTP id i32-20020a0564020f2000b0046858d4a0f2mr45314500eda.23.1674746252805;
        Thu, 26 Jan 2023 07:17:32 -0800 (PST)
Received: from localhost.localdomain (abyk108.neoplus.adsl.tpnet.pl. [83.9.30.108])
        by smtp.gmail.com with ESMTPSA id a16-20020aa7d910000000b00463bc1ddc76sm842808edr.28.2023.01.26.07.17.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 07:17:32 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
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
Subject: [PATCH 06/14] drm/msm/gpu: Use dev_pm_opp_set_rate for non-GMU GPUs
Date:   Thu, 26 Jan 2023 16:16:10 +0100
Message-Id: <20230126151618.225127-7-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230126151618.225127-1-konrad.dybcio@linaro.org>
References: <20230126151618.225127-1-konrad.dybcio@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/gpu/drm/msm/adreno/adreno_gpu.c | 3 +++
 drivers/gpu/drm/msm/msm_gpu_devfreq.c   | 2 +-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
index 817599766329..c85ae3845a4e 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
@@ -1047,6 +1047,9 @@ int adreno_gpu_init(struct drm_device *drm, struct platform_device *pdev,
 	const char *gpu_name;
 	u32 speedbin;
 
+	/* This can only be done here, or devm_pm_opp_set_supported_hw will WARN_ON() */
+	devm_pm_opp_set_clkname(dev, "core");
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

