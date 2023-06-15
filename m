Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D7D673236D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 01:22:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbjFOXV7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 19:21:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239223AbjFOXVm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 19:21:42 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 024002D42
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 16:21:31 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4f769c37d26so3435966e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 16:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686871289; x=1689463289;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FPRMcWRdPNRhm7m7rFyZkdTr39iafUGR7Em1StRoccs=;
        b=YcfgUYjVM7UOkgkcCmENJ1htERFxfeAzizRgAdyXb8MMoN+m8qs7nT5qIUfhoms1l1
         noWA5RFKINggsK7GFdC/2KHQq/kHkA1hGfNW8Fhvm9YkRxsFHUdZNIW8W2bI/2FNpFf/
         5+2d1i5FVp9BpWUHiPmtnDPjvN/NC87P+mvwDcx88fGMjHJV+k76VnCmPLiKAvChbEWA
         3/4zET4oxImGkAmfIgfiLgg8cXTle8uoafOBIw2a1IFxJFLPBFVT6IpuI/asCpMGJvR5
         P2OJM6fhh8NdRm44jV8WaIRO/EyB7BPhNshd5YZsnJj43chwbs9OrgwzzHs41dfTtjQ9
         fqzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686871289; x=1689463289;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FPRMcWRdPNRhm7m7rFyZkdTr39iafUGR7Em1StRoccs=;
        b=FyiQW+nZ0CFG1wHNGInMDjQTNWc5WPg1CbzHFGH6vVktGnv2vAZq8Lv9GD54GMi23o
         wiwVbRNnXHmwtSZX4PQ7xNWTsmzS+o65JVykcQUzAowv/0PTMZT7dqXn/Q3RK8DyDrZb
         OC+yMhlVvF7Nr/flhZ3kvj9ORI3vXSQ3YD4sEaqcXQnTCAlM+0nTUuHD68HTiUbn9EVQ
         VTOT6YAs0WRulsfdfDEyaR/TTs4LT94ngdhHziktIFkEy0kYQDw3eyX0fFVRxDAt/nf4
         MSMXuSyKBjSnZDK36XWRvCaKtGi5pBlmpzU8NTm/OMiak4/8ORkhUtQJ3/S0HBednOPO
         tGxQ==
X-Gm-Message-State: AC+VfDzZ/t44xyVSsJxk9ko10ahyPsPijAXaYKOwkq7lWorErdM//n2V
        HS7Tb0Raq5bo62rDLzo7LYzskQ==
X-Google-Smtp-Source: ACHHUZ51XQWATY/JYl6yXAjj285muAVX1IeWAWH01KFLBe2yZmnM2C461nEnaI9MIa1ayHfiyf87Vg==
X-Received: by 2002:a19:e01e:0:b0:4f3:ac64:84d9 with SMTP id x30-20020a19e01e000000b004f3ac6484d9mr98518lfg.20.1686871289278;
        Thu, 15 Jun 2023 16:21:29 -0700 (PDT)
Received: from [192.168.1.101] (abyj190.neoplus.adsl.tpnet.pl. [83.9.29.190])
        by smtp.gmail.com with ESMTPSA id u25-20020a056512041900b004f24ee39661sm2744852lfk.137.2023.06.15.16.21.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jun 2023 16:21:28 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Fri, 16 Jun 2023 01:20:48 +0200
Subject: [PATCH v9 07/20] drm/msm/a6xx: Improve
 a6xx_bus_clear_pending_transactions()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230223-topic-gmuwrapper-v9-7-890d8f470c8b@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1686871277; l=1415;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=DRGqhpFzhDNQhxx5j97tqEL/ORDaa2xLNnRcBrvxk+I=;
 b=20lGkYLKlOXNgAl41BoltFryorb2un2mRZZOBZExBSXPDrbKc/bg50HjamGPBK9owpvzNnkYT
 fCj5EZeMjQoC3pscJe3/j8131yDod+0deyTgWkdnBQyvwUsFSfbsd4S
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

Unify the indentation and explain the cryptic 0xF value.

Reviewed-by: Akhil P Oommen <quic_akhilpo@quicinc.com>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index a48f4e3a754a..d5bd008c2947 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -1705,17 +1705,18 @@ static void a6xx_llc_slices_init(struct platform_device *pdev,
 		a6xx_gpu->llc_mmio = ERR_PTR(-EINVAL);
 }
 
-#define GBIF_CLIENT_HALT_MASK             BIT(0)
-#define GBIF_ARB_HALT_MASK                BIT(1)
+#define GBIF_CLIENT_HALT_MASK		BIT(0)
+#define GBIF_ARB_HALT_MASK		BIT(1)
+#define VBIF_XIN_HALT_CTRL0_MASK	GENMASK(3, 0)
 
 void a6xx_bus_clear_pending_transactions(struct adreno_gpu *adreno_gpu, bool gx_off)
 {
 	struct msm_gpu *gpu = &adreno_gpu->base;
 
 	if (!a6xx_has_gbif(adreno_gpu)) {
-		gpu_write(gpu, REG_A6XX_VBIF_XIN_HALT_CTRL0, 0xf);
+		gpu_write(gpu, REG_A6XX_VBIF_XIN_HALT_CTRL0, VBIF_XIN_HALT_CTRL0_MASK);
 		spin_until((gpu_read(gpu, REG_A6XX_VBIF_XIN_HALT_CTRL1) &
-								0xf) == 0xf);
+				(VBIF_XIN_HALT_CTRL0_MASK)) == VBIF_XIN_HALT_CTRL0_MASK);
 		gpu_write(gpu, REG_A6XX_VBIF_XIN_HALT_CTRL0, 0);
 
 		return;

-- 
2.41.0

