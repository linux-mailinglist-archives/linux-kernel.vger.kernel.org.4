Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9F7B6D1317
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 01:25:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231281AbjC3XZu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 19:25:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231134AbjC3XZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 19:25:36 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEEFA6582
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 16:25:24 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id bx10so2963386ljb.8
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 16:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680218723;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Nm/XTs8kUm7gm8q4P4cfKXmAlTclT7Zyu7DRpRk628Y=;
        b=BYtErKq2dxteRSgjjQL+mwZRyd9zpYOFbIkDF581CEse36BLDXFkH8njSk4IQuXWEl
         FiAzc9MEUl7bvHvZmnaEDyrZt1JDqnU3EMaeFm8qUnduETAyJbIAcixqy3df5pbsxgQu
         nslyToLngtR6nQnONdAPedi5+UWJgRNM7cRhMqFPZIqeeu5zMGa9KeH8aaLCBAqp6O7Q
         fczu6rgdZwaZ91EQFPyjbIV+OS8lQFWbR6Pm4qVJ/thRNQY1KqRzfkcPNzzsBK//aL7h
         oLNiyjA5grF+jUbmJmx2EgrWrIWs/uEfhy++vHFw8j1ZVaTbjJZPT2C7zVXHyf3BNoYB
         D6Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680218723;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nm/XTs8kUm7gm8q4P4cfKXmAlTclT7Zyu7DRpRk628Y=;
        b=Rd9Y2SUHmfNNi6/TpzrrqJ57rLoRrSO+K1/Ukr6LIuiFRtfaXvnPALbBZCP7vR/9LX
         rKA2PlXZhoTZruOMg+tnARhlpY6ax3KRzChvo0XNjmCyodYAYepRyztdQux5ZYAmJpSZ
         ZdIAseJdwNFTPZchfE/fKRuzxnnKWJtzR3h50DsbibZASgQpKHpMx1viVWIJOvxmCILs
         lup26/43ip1Skp1ao37ctUyMWNUIpqdY7pOnfj8J0IUEkYNBAAq+n1lzuNZDeukC8eW+
         afXfUR4+5LxEuoJugSvHZXqxdLLqaqSVMcNk2RqlS/9Sv+myqN0GJJQl2hcgm0cwFk94
         OH9g==
X-Gm-Message-State: AAQBX9eiT8DAlldZqc6LV5c8vNgKt+MnJwuDRjtl/kYKwo1tmxBhaqiz
        I54UiRKTN9InTL4WlTQ8a+X2bJ17IaoHJgwxbgQ=
X-Google-Smtp-Source: AKy350ZLBWU7rjccfv3QlowitPG5Y1L7h3hSSdHiDykxNVTkNatVJLjZltMvqKbD2UA3ZgEb3/MOgQ==
X-Received: by 2002:a2e:240b:0:b0:293:2c65:20c8 with SMTP id k11-20020a2e240b000000b002932c6520c8mr6554156ljk.1.1680218723191;
        Thu, 30 Mar 2023 16:25:23 -0700 (PDT)
Received: from [192.168.1.101] (abxj225.neoplus.adsl.tpnet.pl. [83.9.3.225])
        by smtp.gmail.com with ESMTPSA id g26-20020ac2539a000000b004dda80cabf0sm127241lfh.172.2023.03.30.16.25.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 16:25:22 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Fri, 31 Mar 2023 01:25:15 +0200
Subject: [PATCH v5 01/15] drm/msm/adreno: adreno_gpu: Don't set OPP scaling
 clock w/ GMU
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230223-topic-gmuwrapper-v5-1-bf774b9a902a@linaro.org>
References: <20230223-topic-gmuwrapper-v5-0-bf774b9a902a@linaro.org>
In-Reply-To: <20230223-topic-gmuwrapper-v5-0-bf774b9a902a@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1680218720; l=2082;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=J+NC5YC/ebMbVp5SWCJ3W7rySZtZPgfNfKIxNjYvw8s=;
 b=nnT3Xo8An9NkjO3ejLZCh5888RRNMto9J5UyzdIwiIHICQUr3SIDVK8O3ukDZ7+cZtZU4IrWrsF0
 73sPX4KQBNED78yvgQLw9aOdxIvKNTl7MlvKQnrTqJz3HCX/fQBO
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Recently I contributed the switch to OPP API for all Adreno generations.
I did however also skip over the fact that GPUs with a GMU don't specify
a core clock of any kind in the GPU node. While that didn't break
anything, it did introduce unwanted spam in the dmesg:

adreno 5000000.gpu: error -ENOENT: _opp_set_clknames: Couldn't find clock with name: core_clk

Guard the entire logic so that it's not used with GMU-equipped GPUs.

Fixes: 9f251f934012 ("drm/msm/adreno: Use OPP for every GPU generation")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/gpu/drm/msm/adreno/adreno_gpu.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
index d12f2f314022..84f25122afba 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
@@ -1021,18 +1021,22 @@ int adreno_gpu_init(struct drm_device *drm, struct platform_device *pdev,
 	u32 speedbin;
 	int ret;
 
-	/*
-	 * This can only be done before devm_pm_opp_of_add_table(), or
-	 * dev_pm_opp_set_config() will WARN_ON()
-	 */
-	if (IS_ERR(devm_clk_get(dev, "core"))) {
+	/* Only handle the core clock when GMU is not in use */
+	if (config->rev.core < 6) {
 		/*
-		 * If "core" is absent, go for the legacy clock name.
-		 * If we got this far in probing, it's a given one of them exists.
+		 * This can only be done before devm_pm_opp_of_add_table(), or
+		 * dev_pm_opp_set_config() will WARN_ON()
 		 */
-		devm_pm_opp_set_clkname(dev, "core_clk");
-	} else
-		devm_pm_opp_set_clkname(dev, "core");
+		if (IS_ERR(devm_clk_get(dev, "core"))) {
+			/*
+			 * If "core" is absent, go for the legacy clock name.
+			 * If we got this far in probing, it's a given one of
+			 * them exists.
+			 */
+			devm_pm_opp_set_clkname(dev, "core_clk");
+		} else
+			devm_pm_opp_set_clkname(dev, "core");
+	}
 
 	adreno_gpu->funcs = funcs;
 	adreno_gpu->info = adreno_info(config->rev);

-- 
2.40.0

