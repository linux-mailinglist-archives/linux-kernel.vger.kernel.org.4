Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4008E6F8B7D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 23:43:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233656AbjEEVme (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 17:42:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233673AbjEEVlu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 17:41:50 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8E685BBF
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 14:41:03 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2ac8d9399d5so7756441fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 May 2023 14:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683322862; x=1685914862;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6Cgx0VgjSWF36kTiyIdxe2LPUi4kT2lQKkyyJC5x69s=;
        b=Gccfie7GMOugjyiUVru/AmbzWeTgn3lIDnsiRORE1BLhhAhDo2q5OeGjUTPqdrkPBV
         42ByFze8DoBI5q1FCMCT3Iqs+bmFU9i+JGnGLiFcDLLR+U6BR/AlJJoHqfO5asrH7mPH
         tUCk2VtfCESPRGvyE+inqnMfl0UcEkoyWEGYVTdWp4vxAJonCDVB+us6Iw92/tmXMKch
         lHBlg/1zA/bh25rGZ61FMJcGz6CSwAPlGrSppo1mdMsb5EsYAZ3p1Ep7bEJedfnQfzJW
         ihCWZ0yivoUcwJphIuwej6UOCSM9grvNt6HRpYB4LNcg3PISN324cVw3HYfU0OzB2t6h
         AIzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683322862; x=1685914862;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Cgx0VgjSWF36kTiyIdxe2LPUi4kT2lQKkyyJC5x69s=;
        b=DLb52MUk2GnMqzbC1ri+y7d8QkA0CcAQZiOaHX7Rm0cdL1bUAVZlLda2cQnhH3LML4
         y/pFaWIyrNmUhxSsFTRv3oX8TNiZNaOTX57CVmG0ttLgC7ow7QLstlrEvAYjJ8w+s79+
         rNGr/i7kkGMmvQGs01iclR8/pvwYua8xFR78e6Y0i2QDhD2TaJ9DNijEH1o43BJ7wCf6
         lKxVHQK3s3Wke3EWGDltbE/hvqiBrMBKfW6X3nCVDZLq7L2E2x6WCvsgHAYBW6fTwVjK
         V8tsNTwcdKyteiw7MopJOidFJVByEIgD2Pau+sUAIJjzZexnYHMDVZC2S2+u0DZerUGL
         4bmQ==
X-Gm-Message-State: AC+VfDxg1ORsN35jymvsPf5n+cWZS6ePLib1PT/hhjgaMnpDau1beVFH
        g3PVzQOVIroA69t7G7nhA+r1hQ==
X-Google-Smtp-Source: ACHHUZ4+K+GhXhvLSXj3jdIBiVBVY1fOjuTIzZpxArJ+LOicJ5uIxrApQrg8YtPi+bMU1mnhxFICzg==
X-Received: by 2002:a2e:9056:0:b0:2a7:9a7a:f864 with SMTP id n22-20020a2e9056000000b002a79a7af864mr953234ljg.5.1683322861925;
        Fri, 05 May 2023 14:41:01 -0700 (PDT)
Received: from [192.168.1.101] (abyl248.neoplus.adsl.tpnet.pl. [83.9.31.248])
        by smtp.gmail.com with ESMTPSA id n12-20020a2e720c000000b002a776dbc277sm126453ljc.124.2023.05.05.14.41.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 May 2023 14:41:01 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Fri, 05 May 2023 23:40:37 +0200
Subject: [PATCH v3 11/12] iommu/arm-smmu-qcom: Add SM6375 DPU compatible
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230411-topic-straitlagoon_mdss-v3-11-9837d6b3516d@linaro.org>
References: <20230411-topic-straitlagoon_mdss-v3-0-9837d6b3516d@linaro.org>
In-Reply-To: <20230411-topic-straitlagoon_mdss-v3-0-9837d6b3516d@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1683322839; l=919;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=hMmDD+SgonZLP46KBM866xQojXqpPqEZ25ow2fxLp/E=;
 b=zckkfPprq0LAaufGJdyd08HwqQ+DvDuj3pjCVufSbw/R95EDd1/WxZUQAiuD3r3x7v5RBq0Ea
 rvoL+U9hlerCFPzxbe1MTtGhJLaUTYkcG44IEB3EaL4dsVNizhDuuO+
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

