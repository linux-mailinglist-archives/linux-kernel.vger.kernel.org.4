Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E503A62D753
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 10:44:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239454AbiKQJok (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 04:44:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234734AbiKQJoe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 04:44:34 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B916D6DCEB
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 01:44:33 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id d6so1902258lfs.10
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 01:44:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=07jxP8RcYFdE+SSC8KiN//xkr0d7SR0+oxWGO499peQ=;
        b=LSZF9vPxP9SRCCRRlugy9ekXBT9pLaqSLEk4FXkTueoXWwiDMw19beV0kmm08vw7kR
         bwFK8Thq5hj8JJOUhxvARAOmaBPC6M5adxr3RPiQOQi080uZYk36NZ1j/Jl8dfD+DKDz
         qVYcDwazmdvFKb9sJjUuc/krbW8lWq61lMD6YxBmDTs7nO1eOzkJiWBJLgkzeJMfZDt0
         7ll36P26rnm5q86x2O0TU67grttZJ1H1jkd71HOkir4oQq+tdXaNz6mfVIzmv3hVWKtB
         I+Giz3NUME+0SGNGMPx3WM/1Gez/T1gup38sDDvLb2Gt6HWiIOkjlzvAOUiLZMbxPno5
         6JQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=07jxP8RcYFdE+SSC8KiN//xkr0d7SR0+oxWGO499peQ=;
        b=O+hZhN7ZZS4OI2CAOllR7KR5HmOwG9bDXNS0dj6Eq9UKHw6fMc9T+Frv/afw7cIfj6
         LozAkE1LP45S1RKDv/kdUK7Kfjl5nkS0fXSqGjO4m3c6HypTk37sbCcP3HJ5lTrw9V9N
         9YC9najRD2tUOnC7snkvxXvEyjyWvLM3ithFBtJYce4dBDpp3t+dVXlVaW1nvYEzQn+M
         35m8MHbCT/KvkMTtIRF/+JQqYvP0Cs11YIMobhI2Xo5njteBWouoyBjxNZPzzXv+zlIG
         RxnXfYWcXIIgtckmX8D2Ct6B28qxDn+Xfdso5p1zuqfAjpMOUa9dK7xvbWF3VpY4wrhw
         WCJg==
X-Gm-Message-State: ANoB5pkOlLK3phirSCMeBlLEgl3sJfp42zGHpq/Z80rrp7K8B3VKJ3mB
        D7RoYFMtko/gGcqu8VBz8D0wKQ==
X-Google-Smtp-Source: AA0mqf7sxxHmLU3xjf1JZJdrXwApfX2dW3Xq6Qp0TygXefNSEF471QrQQDVzmNSY/KnTae89FV4c5Q==
X-Received: by 2002:a19:e048:0:b0:499:af06:a77b with SMTP id g8-20020a19e048000000b00499af06a77bmr581604lfj.202.1668678273353;
        Thu, 17 Nov 2022 01:44:33 -0800 (PST)
Received: from localhost.localdomain ([194.29.137.22])
        by smtp.gmail.com with ESMTPSA id a23-20020a2eb557000000b002770f0a742bsm105312ljn.41.2022.11.17.01.44.32
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 17 Nov 2022 01:44:32 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     patches@linaro.org, Konrad Dybcio <konrad.dybcio@linaro.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Clark <robdclark@chromium.org>,
        Emma Anholt <emma@anholt.net>, Vinod Koul <vkoul@kernel.org>,
        Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] iommu/arm-smmu-qcom: Add SM6350 SMMUv2
Date:   Thu, 17 Nov 2022 10:44:22 +0100
Message-Id: <20221117094422.11000-3-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
In-Reply-To: <20221117094422.11000-1-konrad.dybcio@linaro.org>
References: <20221117094422.11000-1-konrad.dybcio@linaro.org>
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

SM6350 uses a qcom,smmu-v2-style SMMU just for Adreno and friends.
Add a compatible for it.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
index fd97db178696..fa84a69b9439 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
@@ -513,6 +513,7 @@ static const struct of_device_id __maybe_unused qcom_smmu_impl_of_match[] = {
 	{ .compatible = "qcom,sdm845-smmu-500", .data = &sdm845_smmu_500_data },
 	{ .compatible = "qcom,sm6115-smmu-500", .data = &qcom_smmu_500_impl0_data},
 	{ .compatible = "qcom,sm6125-smmu-500", .data = &qcom_smmu_500_impl0_data },
+	{ .compatible = "qcom,sm6350-smmu-v2", .data = &qcom_smmu_v2_data },
 	{ .compatible = "qcom,sm6350-smmu-500", .data = &qcom_smmu_500_impl0_data },
 	{ .compatible = "qcom,sm6375-smmu-500", .data = &qcom_smmu_500_impl0_data },
 	{ .compatible = "qcom,sm8150-smmu-500", .data = &qcom_smmu_500_impl0_data },
-- 
2.38.1

