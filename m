Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A0E26930ED
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 13:27:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbjBKM1y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 07:27:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbjBKM1u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 07:27:50 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A059A23C66
        for <linux-kernel@vger.kernel.org>; Sat, 11 Feb 2023 04:27:25 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id rp23so21849813ejb.7
        for <linux-kernel@vger.kernel.org>; Sat, 11 Feb 2023 04:27:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dxv3eKTtA5e9aZgQHY+jlwZt6H2vd/82rQZm7n3Xcpk=;
        b=NQIH6K9SlVrupUFRfjmSUqrEmHxFxsMW2+wyo0+MRR2O4BS/ozIvVLHbmTA6FFYSSQ
         rrY+UtU4pDfccwJ1NvuGV3zBM+ya0k+vbB7DturJaLcFp5wj76xTG8gsuNsxR0Oxi8jc
         Q1Ne7eQKCst883bTFnkZ30xbZMDhCUgId1g2p1qyjcxSMMIJsxCeIBwA4FvXSTbNi8hk
         6fCcCuJ0Lhd3TS4d6bk5nRbiokwY4VoFpt6b4peOX6DIB+rZhPlSVIuBEE441cbGzUUz
         uaaQm6FbrYaq29Tn69T6Qyqpued72pxn6owdUSM9b5Nh3TNOCKON1+FzWAvefvZAjIjl
         avaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dxv3eKTtA5e9aZgQHY+jlwZt6H2vd/82rQZm7n3Xcpk=;
        b=5+XCQqWWGN6VqOhCQanbjht50LcXd6+SOaRtobykGSCndeE9JUlGfh+p5pAHzJIA8c
         kVwmrxbXDf/CCHGl/8a5+GiKAVGQ4R9+ctUukXdHldrm58TsPV4NX2mSATUx8UbcSK3O
         ifqGjJzXpuxsuk782Z326aflPwSGGZvv7rS6VbQmx3cko9ViTDdC6dkXY0oWzF3r1ngR
         Y226X5FwSRMrRc6dJ7fbgMyqRLcKjNsiDNAnZoADzI3pME2TBwIABRVregSw/Zj/rkwP
         njswRkWgH8cWwLRMhkonwut087MYejFKedbgtfM9G9n507G5J6pMWqZsVVoZbaU3i1IB
         E2Sw==
X-Gm-Message-State: AO0yUKXMiPTl4pabJaTU4BUxwN7+lkxhuxvkjiv73C6em3Urx52pMS9n
        OI+oyX0MJtRkntAdkKDb3mBBjg==
X-Google-Smtp-Source: AK7set9T/kjhLcsuN3ieSGb5mjaV3UzHEzK0GKmB8WFftBur+QhwrE4VGV1Hc1Yw1Cv+PX+Y4G/wSQ==
X-Received: by 2002:a17:906:ad4:b0:88d:ba89:1838 with SMTP id z20-20020a1709060ad400b0088dba891838mr12444413ejf.9.1676118445267;
        Sat, 11 Feb 2023 04:27:25 -0800 (PST)
Received: from localhost.localdomain (abxh117.neoplus.adsl.tpnet.pl. [83.9.1.117])
        by smtp.gmail.com with ESMTPSA id mv9-20020a170907838900b0087bd2ebe474sm3767941ejc.208.2023.02.11.04.27.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Feb 2023 04:27:25 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Melody Olvera <quic_molvera@quicinc.com>,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH 09/10] iommu/arm-smmu-qcom: Add SM6350 DPU compatible
Date:   Sat, 11 Feb 2023 13:26:55 +0100
Message-Id: <20230211122656.1479141-10-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230211122656.1479141-1-konrad.dybcio@linaro.org>
References: <20230211122656.1479141-1-konrad.dybcio@linaro.org>
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

From: Konrad Dybcio <konrad.dybcio@somainline.org>

Add the SM6350 DPU compatible to clients compatible list, as it also
needs the workarounds.

Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
index 7425424da974..959516bbfe65 100644
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
2.39.1

