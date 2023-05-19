Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 437D0709D74
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 19:06:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231888AbjESRF6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 13:05:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231815AbjESRFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 13:05:19 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 418641A7
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 10:04:53 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4f3b314b1d7so421700e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 10:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684515891; x=1687107891;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6Cgx0VgjSWF36kTiyIdxe2LPUi4kT2lQKkyyJC5x69s=;
        b=IsY0da0u/JDDGZ3J9pfUfxvXvYtnLy1D+JtipBNPvBMtbtDtTz7HNBPcotwGkAmlfy
         PORzwnfF1eE1o74F4V53MF8I4B6xYtH+/1Qeh3ai0UEn3Jbg7koeCdcgjxciv4skpxKK
         Dd+OZTmBUhedVkMuG9TyM9xC6Tdma/4p8vFJNPL5zQJAICD7bqgmefISwx9CqL5EPLXd
         D4Nr8+FEO4bgOpv3+Xfx91X+dElds3dF083I77oRfdnjU5BfyOe6J+CN2+/rZxk+h23n
         Naxe+XT5eXF+9OG41/F/kawP49Vretx4AX4CFfC5mqxpFEdDmR9enO1+5bcPInK1F/k4
         j2XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684515891; x=1687107891;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Cgx0VgjSWF36kTiyIdxe2LPUi4kT2lQKkyyJC5x69s=;
        b=FQyqpboXEifoa1MU1ZPSxDP7LSfgdaqWCmxFeo7RxmS30UZ7LLD3ttksHuYKiNYSDQ
         nBarlMRMM5efwjFWzjSy/80i/B/gViPVWyPDgELX0mNX8EtV2M8zXn5I278YH5ENUIVr
         hkmjW1DpMaG3viOv8/ezWTzmxy5p7gcX+X6g2t8jFAxRIfrWgDQzOGeCqY8BAxpKrHwn
         p+U6XRtZtZGvLu9n9aYetVZgmkTN9rG+5IGM0QehvAinFbQbi9rGDkI1GVK3QRMdHDCu
         fM+2zjJEvnDxR7gP6n71aspqkOIeC+bFX+SY3alY8yuhej68S5F7XCjs69Hg3yjMFEuc
         rjXw==
X-Gm-Message-State: AC+VfDz1CcyutsR2p5EcQF4Z0N4de5QT+J1kmfxKJWhr5AB4RLyXIhYb
        09jursX3glTdjJajEo5dnx99XA==
X-Google-Smtp-Source: ACHHUZ7Ds1+/AWoTFgM3T6UfzCXKF2mivsVSYkyWxs5tAN5cNPFGwbnFQ0oWsighigcXlZcHgEYaQA==
X-Received: by 2002:a19:f00a:0:b0:4eb:42b7:8c18 with SMTP id p10-20020a19f00a000000b004eb42b78c18mr963212lfc.53.1684515891515;
        Fri, 19 May 2023 10:04:51 -0700 (PDT)
Received: from [192.168.1.101] (abxi58.neoplus.adsl.tpnet.pl. [83.9.2.58])
        by smtp.gmail.com with ESMTPSA id a6-20020a19f806000000b004f38260f196sm654478lff.218.2023.05.19.10.04.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 10:04:51 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Fri, 19 May 2023 19:04:32 +0200
Subject: [PATCH v4 11/12] iommu/arm-smmu-qcom: Add SM6375 DPU compatible
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230411-topic-straitlagoon_mdss-v4-11-68e7e25d70e1@linaro.org>
References: <20230411-topic-straitlagoon_mdss-v4-0-68e7e25d70e1@linaro.org>
In-Reply-To: <20230411-topic-straitlagoon_mdss-v4-0-68e7e25d70e1@linaro.org>
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
        Joerg Roedel <joro@8bytes.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev, Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1684515870; l=919;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=hMmDD+SgonZLP46KBM866xQojXqpPqEZ25ow2fxLp/E=;
 b=R5FoZY4Lqorac7OGiiU0hCgTpb7/pGRuboSGxvm7lhbIzQY6O4CtC/NrOwAerHytiT6x+EkhV
 M+R6OmHtCA7AQ3JrOawU6BYsdkdEV6mk6MgjQ/tb3RtgeGijwLddrRa
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

Add the SM6375 DPU compatible to clients compatible list, as it also
needs the workarounds.

Acked-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
index f945ae3d9d06..d7d5d1dbee17 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
@@ -253,6 +253,7 @@ static const struct of_device_id qcom_smmu_client_of_match[] __maybe_unused = {
 	{ .compatible = "qcom,sc8280xp-mdss" },
 	{ .compatible = "qcom,sdm845-mdss" },
 	{ .compatible = "qcom,sdm845-mss-pil" },
+	{ .compatible = "qcom,sm6375-mdss" },
 	{ .compatible = "qcom,sm8150-mdss" },
 	{ .compatible = "qcom,sm8250-mdss" },
 	{ }

-- 
2.40.1

