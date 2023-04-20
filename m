Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CE226E9F0A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 00:32:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233285AbjDTWch (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 18:32:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233176AbjDTWcM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 18:32:12 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFAC67AA0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 15:31:43 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4ec816c9b62so949340e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 15:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682029902; x=1684621902;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UpOebqvOPbIqBzmR7NG/8rdRhqAcRj4FETPLZVvYR+0=;
        b=V0h1ZJjp6OhY4YDWAT7BDJ5ttf7U6iPjAi9Rcptq5HYQkQvwRLcYlr9TSkPIl+3ixf
         chauhhFx1ZN8Dfx0Xoq+3rCgOozjOiJ5wN+gqH/jJGiEYilnTuF87qQjPnr45ExRdyaT
         MbuNpZ3Or0OgZqfkZdOMgiGnx3OGnrLUVx8RI+O20k5lrzZ9pqeCd0sYU7wGItp31rO5
         UM17D2dm3AmUkxEe6xbXTxQufjSkOI7oNM7mdQtuwOnTWrPhwSEr3MxOskjLi1qhvWVK
         gyL7IK1KLNdkklcmVQsrymJiAE9BCiwyr08xJ8xhRwjQHGbTY68hcw1AJN/Quol7kj2O
         WXsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682029902; x=1684621902;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UpOebqvOPbIqBzmR7NG/8rdRhqAcRj4FETPLZVvYR+0=;
        b=CJbeRSJ/Isg3nLisZk9BIr8Ea7JMnYWlfz72UDi12MDgGtkfmHwzqQ53sPHpyysgkN
         eVXR+KxA4M4PCOaVn0/x69cH5jJ+bhIFeYlZBKGUY285Ga9MUiVeLMjYa5KhKCFn5wu0
         R2e6iLOONHZmq4u+DvDCHXJ9qXRLTlN5eolgqhmD3xnWUkL0ZNHd9y+o5t/ECayd9Qed
         7cklMTCkr7uliCS/X+wXG8mmT2v/CXCZodQg8OhBmkJRR9PwmHB6UXdptB9i8jbcQw5O
         NdJWuJbXFlKzpR9DP2rdgL+NJw9uPL3GqQfUyjADkca/VEVuMHk23LT2Ie7KuBSvH8zl
         HLJg==
X-Gm-Message-State: AAQBX9ebKhswEdRm1aU415wpL/IEbuSJIWp+4VWYRQkCFiz6l41ZTLcJ
        bMys70BGtPOIoG72JhnbrvKkFQ==
X-Google-Smtp-Source: AKy350ax7WiiZ7sdUoOrCa6zqvzc4la3MYIVSoMYrIr6DOVfjS5Y91sf5cpvtfvB3sHU712yldza8Q==
X-Received: by 2002:ac2:5204:0:b0:4dc:807a:d144 with SMTP id a4-20020ac25204000000b004dc807ad144mr905144lfl.39.1682029901820;
        Thu, 20 Apr 2023 15:31:41 -0700 (PDT)
Received: from [192.168.1.101] (abyj144.neoplus.adsl.tpnet.pl. [83.9.29.144])
        by smtp.gmail.com with ESMTPSA id w8-20020ac25d48000000b004eedb66983csm324256lfd.273.2023.04.20.15.31.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 15:31:41 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Fri, 21 Apr 2023 00:31:21 +0200
Subject: [PATCH v2 12/13] iommu/arm-smmu-qcom: Add SM6350 DPU compatible
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230411-topic-straitlagoon_mdss-v2-12-5def73f50980@linaro.org>
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
        iommu@lists.linux.dev, Konrad Dybcio <konrad.dybcio@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1682029879; l=884;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=evqQGLlTFOqHDOuiOF22m7xaO9yZbbtIXtz5YEiBVu0=;
 b=fwJivKHapHtCQymUF6p9dE6yEgcAcMF20Cmrb7Mbb0/7cBIbuYECeiyai+qF+fsnSn/sBz3WaMRJ
 hzP05E9EDpr2STBp7wbUGqCGO5QmuBw56ySUAbFzHTnr6Xh3ffb8
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Konrad Dybcio <konrad.dybcio@somainline.org>

Add the SM6350 DPU compatible to clients compatible list, as it also
needs the workarounds.

Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
index 995ab5172883..2daaa600ac75 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
@@ -255,6 +255,7 @@ static const struct of_device_id qcom_smmu_client_of_match[] __maybe_unused = {
 	{ .compatible = "qcom,sm8250-mdss" },
 	{ .compatible = "qcom,sdm845-mdss" },
 	{ .compatible = "qcom,sdm845-mss-pil" },
+	{ .compatible = "qcom,sm6350-mdss" },
 	{ .compatible = "qcom,sm6375-mdss" },
 	{ }
 };

-- 
2.40.0

