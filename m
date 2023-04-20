Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCAF06E9F07
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 00:32:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233168AbjDTWcd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 18:32:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233058AbjDTWcL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 18:32:11 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87C1D5FE0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 15:31:41 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4ec88c67b2eso939653e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 15:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682029900; x=1684621900;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z7U+MQQRn266X/fu48wXlntxvnDdxvseAqEyvV5bnYU=;
        b=tMlxGgaR6TjY9h0TBPC//jlkuKqvmqB/3gCELO4fQHzbhqM1pN8tWw5LvbFYIMEFAx
         2W7OizUDJ7IuE4yeBSwaonNURn0iha2+UHhiZRq+ZPzmsZ6oJJ6udJxD2ptavJ5iWxgb
         LhBoIarkiSGbTzPKLaNsjYWrh1W2ySxsIHaSfTwYeuQt2axkX9zm5bsuf+tAuvXDAGPF
         RybMNWmjB7IpiOJFEvXvk/QJsAbSrcIpGKZR20E/1ICfsQdRqG6X1+v0r/Qv8t49I0s0
         y0JlgurZs8Nmwa9ZuqONoww3D7GdNClHsi2aGUU5viYJviBhqcpwXnerXS58bixKFHIQ
         yWjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682029900; x=1684621900;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z7U+MQQRn266X/fu48wXlntxvnDdxvseAqEyvV5bnYU=;
        b=iFP93HAPpdYAprQjbf+53Q47MpP162pI9kToNHlqi6bGkdkqYQgkV5e6oYok26CJCZ
         LvvapRIZPSebfSWZu42rm8znTuSdBJXjHknzuZuz0CnjZL3Zjy5Z9PAqysIKVe67y2QZ
         kR2RV1+WrICWU3OJZ9GyaOTszznGoreUUyLjMHSsymYoHug97vzAWy5mfmb5kkFYUsBt
         tfKb2a6Go8GMhy4lz8wUwOv61jR98cQ9Hrd1To9dXNSvdeLC2DVFwlOFxk/IrrOGw4ya
         RAA10eGZTbHBUzO4dloVzu3zwANdP+QgoPRUxTapxPAkp+HsCpb1qaCZ3vezn7biIPe2
         g4qQ==
X-Gm-Message-State: AAQBX9cQQ36g1Gm5dFhP3mgLgWbQywSJhQWjohSOhks+Wof3sCLWR/Mc
        J/Yidjv2ysFmKOBMKx8Ak5cNgg==
X-Google-Smtp-Source: AKy350ZHaiUf6dhHxtQIv5/1RWQP/D8HT6ayzW/hPzmDLaYG8EmD3Kj8tDGo9DQ1XAOeCfV2w5oZjQ==
X-Received: by 2002:a19:c503:0:b0:4db:513b:6ef4 with SMTP id w3-20020a19c503000000b004db513b6ef4mr861359lfe.11.1682029900156;
        Thu, 20 Apr 2023 15:31:40 -0700 (PDT)
Received: from [192.168.1.101] (abyj144.neoplus.adsl.tpnet.pl. [83.9.29.144])
        by smtp.gmail.com with ESMTPSA id w8-20020ac25d48000000b004eedb66983csm324256lfd.273.2023.04.20.15.31.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 15:31:39 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Fri, 21 Apr 2023 00:31:20 +0200
Subject: [PATCH v2 11/13] iommu/arm-smmu-qcom: Add SM6375 DPU compatible
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230411-topic-straitlagoon_mdss-v2-11-5def73f50980@linaro.org>
References: <20230411-topic-straitlagoon_mdss-v2-0-5def73f50980@linaro.org>
In-Reply-To: <20230411-topic-straitlagoon_mdss-v2-0-5def73f50980@linaro.org>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev, Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1682029879; l=785;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=/9HUTFzDlWhvA+x0Ieoh1uk/GJ56evseSi3zEZVI4y0=;
 b=ROJxpQig3kurlmL1S3QtRtECNCPVtfMcinbv+K27HQnjedkIX8uJX5aG6iQpvL9I7p/oUOGv9hbW
 FCr4DwNFAO+ezsbjZfziED0S7dhYav6nqfEfdzaeIBUDDYNQX+Nk
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

Add the SM6375 DPU compatible to clients compatible list, as it also
needs the workarounds.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
index ae09c627bc84..995ab5172883 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
@@ -255,6 +255,7 @@ static const struct of_device_id qcom_smmu_client_of_match[] __maybe_unused = {
 	{ .compatible = "qcom,sm8250-mdss" },
 	{ .compatible = "qcom,sdm845-mdss" },
 	{ .compatible = "qcom,sdm845-mss-pil" },
+	{ .compatible = "qcom,sm6375-mdss" },
 	{ }
 };
 

-- 
2.40.0

