Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C282649BA9
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 11:06:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231771AbiLLKGZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 05:06:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbiLLKGX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 05:06:23 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59C0829E
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 02:06:22 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id cf42so17723249lfb.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 02:06:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AxHwpzdAgeysBPjazrb8MZAklpvcch7q79EoiQSklm4=;
        b=a/cqR3OmFlwQ2CdWLT4/9k8uaKshPkOmZbfG58+OuOX46knLAG7cQEu2GCEwRyPqEs
         y/hD4vUys0tprqY3OHNqDXo7pdF4W9IOwifvY+6SIB9TvrQWqas14voG4g4kXszGsOvA
         NXtqYPzKGddJg0cs9et+X09UEkCyx+/dWT4W2GNM0wrmvOoP28wTJMLQNVnDyxgT076S
         I6L9kDhnyEsTfpFw6PLHrFYzHEXpNx+Mf9F3PFJFgKtz7I60mQqetqkr8qkQaRX/wj2w
         PI/avCbXLGjhbVdybY4qsfoAh38TItwsuK7GO61nal47ZsRU0eOnsY1bDwBvpL9ym8hy
         2tRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AxHwpzdAgeysBPjazrb8MZAklpvcch7q79EoiQSklm4=;
        b=xU6aqm+D5Zn9LTHdZ2xgZdLci8RldAM5NrjlJ7vyn4VFcnw2wrXu3+YzdA78eb9VAn
         vS3SpXeGV13mGgJnD606jGmCh08iNOMT8CitkKJunCMil7XtRPjyqv6oP6CYwxHWzLK8
         dp6ZFDI4MuIf0WGeHiCwf4XOA4XlvRHLuQMKJeROmXZQmheVgikxXgBPTaab+UVzlRnL
         96U+JwFnSJCUhmOXmrVB+1yb88Lx1xfk6zle7SbAfxqVbiCc+Hwos5kV0fYgK5rPGwyy
         FZ2K54hNt5+0UX2nkD5hI7ezna9ie8Zpp0o3PPati7cG0tJC0L5qXl4CaTECQEQq4FSK
         e0xQ==
X-Gm-Message-State: ANoB5pkZoY/fgIsB0UkxCxL4otX3/jGOzOYm8XvIuElAUOmr5NSLqd5n
        81afbxLmnO0tcNNJ9VOMPji/FA==
X-Google-Smtp-Source: AA0mqf5CzScTMQIXPiYPV2YD594XKdZ5k3C8WvM0e52jzUu7K/7Aeq2ynaYjH+BhVeHCMGpOTa6GRA==
X-Received: by 2002:a05:6512:358d:b0:4b5:6c00:429b with SMTP id m13-20020a056512358d00b004b56c00429bmr3733559lfr.26.1670839580725;
        Mon, 12 Dec 2022 02:06:20 -0800 (PST)
Received: from localhost.localdomain (abxh44.neoplus.adsl.tpnet.pl. [83.9.1.44])
        by smtp.gmail.com with ESMTPSA id o27-20020ac25e3b000000b00498fc3d4cfdsm1586330lfg.189.2022.12.12.02.06.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 02:06:20 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
        Rob Clark <robdclark@chromium.org>,
        Adam Skladowski <a39.skl@gmail.com>,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH] iommu/arm-smmu-qcom: Add SM8150 DPU compatible
Date:   Mon, 12 Dec 2022 11:06:16 +0100
Message-Id: <20221212100617.18190-1-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.38.1
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

From: Marijn Suijten <marijn.suijten@somainline.org>

Add the SM8150 DPU compatible to clients compatible list, as it also
needs the workarounds.

Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
Depends on the binding here:

[1] https://lore.kernel.org/linux-arm-msm/20221212093315.11390-1-konrad.dybcio@linaro.org/T/#t

 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
index 6610f5d2877d..cd74c1efcfde 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
@@ -255,6 +255,7 @@ static const struct of_device_id qcom_smmu_client_of_match[] __maybe_unused = {
 	{ .compatible = "qcom,sdm845-mss-pil" },
 	{ .compatible = "qcom,sm6350-mdss" },
 	{ .compatible = "qcom,sm6375-mdss" },
+	{ .compatible = "qcom,sm8150-mdss" },
 	{ .compatible = "qcom,sm8250-mdss" },
 	{ }
 };
-- 
2.38.1

