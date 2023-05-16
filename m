Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43ABE705A7F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 00:20:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbjEPWUr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 18:20:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjEPWUp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 18:20:45 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6A6B59E0;
        Tue, 16 May 2023 15:20:44 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1ae408f4d1aso1593895ad.0;
        Tue, 16 May 2023 15:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684275644; x=1686867644;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IeZwhtVSqAG6iHIQ8IUXqbVYn2+osulTFj6IZpAkURA=;
        b=Hgdp6nAntZmrpqBDhdk7E0rc6dat30noUIDD+YKei7fPL4Wo6aL9d0ZJpZbplRH5N6
         Pd7nyDkiAo9c4HmdojDLo6C+h3ssKd+H97R4Shk70DuWn6qCC/JqGqERqIsIhZgG23YQ
         guqdrq5wh2D6b+wK3N+eL9YA33on0DesQXmZ1LEnnlSJBp0CrkHvw1Y4TYEZzAXxcU7h
         ETVFJz0nm9KmvFzWpWutpUJGvgZHYvhqKbaYzQZCTWo00i8Of7FqL7mBHftk8Eto6BxW
         OjomwIOY4wf1RqIORCghEwEbOBe/DOcw+fZPfFVg2kiAh/WbjNNeYB1RHy62EqfQiACx
         6HsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684275644; x=1686867644;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IeZwhtVSqAG6iHIQ8IUXqbVYn2+osulTFj6IZpAkURA=;
        b=lUDDTBntQJmp4REt2H8QByoDaD7YSJuISplVFU+8gZH27e4dnas9Pe9PPhzC1FIt/E
         MewOMcsSWMZcSy2NGc40YFby+wlhCLhMUwNQcArbjCKqxiwkRIVEpHX4m66/hHeH6j+N
         dN5Zj9+LrQIynNygb4NBpyW1Au2FoBlp+wAKLMirAxFQw6h8eFVPTn7JdcQBZUkQNYMo
         BBhPZjrsOj3iMDaYvpj6tPq4Y4iW1Se8ozy0z5qJKmaNETXhBtxEt+0KQ+D93MgUBRL7
         0gPAS8VpbAeEzMWkQei3VqAITDU0wpIIyaeZR6XRTERxhgv6VdUp5w2ELTLkAbeBGYS7
         2u3Q==
X-Gm-Message-State: AC+VfDzAwR7KczJXE0rJSLWJbeXFiMlWx9SlQ6TuygxBE2SY76Fao0Ck
        lnTd3tHuJ/fM6wmnYqErE4o=
X-Google-Smtp-Source: ACHHUZ4nzvdM64wv1Iwhf7a6uwcd+WXdrvGPTYoGMcH7eUawy/TgM0s5yLdILJA8XRWrw1sQeBpvfg==
X-Received: by 2002:a17:902:9005:b0:1ad:eb16:35e2 with SMTP id a5-20020a170902900500b001adeb1635e2mr12415779plp.66.1684275643949;
        Tue, 16 May 2023 15:20:43 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:61b:48ed:72ab:435b])
        by smtp.gmail.com with ESMTPSA id bf12-20020a170902b90c00b001ac95be5081sm15963062plb.307.2023.05.16.15.20.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 15:20:43 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org
Cc:     freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Will Deacon <will@kernel.org>,
        Rob Clark <robdclark@chromium.org>, stable@vger.kernel.org,
        Lepton Wu <lepton@chromium.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Elliot Berman <quic_eberman@quicinc.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Melody Olvera <quic_molvera@quicinc.com>,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM SMMU DRIVERS),
        iommu@lists.linux.dev (open list:IOMMU SUBSYSTEM),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4 1/2] iommu/arm-smmu-qcom: Fix missing adreno_smmu's
Date:   Tue, 16 May 2023 15:20:36 -0700
Message-Id: <20230516222039.907690-1-robdclark@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rob Clark <robdclark@chromium.org>

When the special handling of qcom,adreno-smmu was moved into
qcom_smmu_create(), it was overlooked that we didn't have all the
required entries in qcom_smmu_impl_of_match.  So we stopped getting
adreno_smmu_priv on sc7180, breaking per-process pgtables.

Fixes: 30b912a03d91 ("iommu/arm-smmu-qcom: Move the qcom,adreno-smmu check into qcom_smmu_create")
Cc: <stable@vger.kernel.org>
Suggested-by: Lepton Wu <lepton@chromium.org>
Signed-off-by: Rob Clark <robdclark@chromium.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
index d1b296b95c86..ec743a9ec67a 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
@@ -496,20 +496,21 @@ static const struct qcom_smmu_match_data qcom_smmu_500_impl0_data = {
 /*
  * Do not add any more qcom,SOC-smmu-500 entries to this list, unless they need
  * special handling and can not be covered by the qcom,smmu-500 entry.
  */
 static const struct of_device_id __maybe_unused qcom_smmu_impl_of_match[] = {
 	{ .compatible = "qcom,msm8996-smmu-v2", .data = &msm8996_smmu_data },
 	{ .compatible = "qcom,msm8998-smmu-v2", .data = &qcom_smmu_v2_data },
 	{ .compatible = "qcom,qcm2290-smmu-500", .data = &qcom_smmu_500_impl0_data },
 	{ .compatible = "qcom,qdu1000-smmu-500", .data = &qcom_smmu_500_impl0_data  },
 	{ .compatible = "qcom,sc7180-smmu-500", .data = &qcom_smmu_500_impl0_data },
+	{ .compatible = "qcom,sc7180-smmu-v2", .data = &qcom_smmu_v2_data },
 	{ .compatible = "qcom,sc7280-smmu-500", .data = &qcom_smmu_500_impl0_data },
 	{ .compatible = "qcom,sc8180x-smmu-500", .data = &qcom_smmu_500_impl0_data },
 	{ .compatible = "qcom,sc8280xp-smmu-500", .data = &qcom_smmu_500_impl0_data },
 	{ .compatible = "qcom,sdm630-smmu-v2", .data = &qcom_smmu_v2_data },
 	{ .compatible = "qcom,sdm845-smmu-v2", .data = &qcom_smmu_v2_data },
 	{ .compatible = "qcom,sdm845-smmu-500", .data = &sdm845_smmu_500_data },
 	{ .compatible = "qcom,sm6115-smmu-500", .data = &qcom_smmu_500_impl0_data},
 	{ .compatible = "qcom,sm6125-smmu-500", .data = &qcom_smmu_500_impl0_data },
 	{ .compatible = "qcom,sm6350-smmu-v2", .data = &qcom_smmu_v2_data },
 	{ .compatible = "qcom,sm6350-smmu-500", .data = &qcom_smmu_500_impl0_data },
@@ -540,12 +541,21 @@ struct arm_smmu_device *qcom_smmu_impl_init(struct arm_smmu_device *smmu)
 		/* Match platform for ACPI boot */
 		if (acpi_match_platform_list(qcom_acpi_platlist) >= 0)
 			return qcom_smmu_create(smmu, &qcom_smmu_500_impl0_data);
 	}
 #endif
 
 	match = of_match_node(qcom_smmu_impl_of_match, np);
 	if (match)
 		return qcom_smmu_create(smmu, match->data);
 
+	/*
+	 * If you hit this WARN_ON() you are missing an entry in the
+	 * qcom_smmu_impl_of_match[] table, and GPU per-process page-
+	 * tables will be broken.
+	 */
+	WARN(of_device_is_compatible(np, "qcom,adreno-smmu"),
+	     "Missing qcom_smmu_impl_of_match entry for: %s",
+	     dev_name(smmu->dev));
+
 	return smmu;
 }
-- 
2.40.1

