Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 110A96FF556
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 16:59:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238519AbjEKO7n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 10:59:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238110AbjEKO7j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 10:59:39 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF592187;
        Thu, 11 May 2023 07:59:14 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-64384274895so6219110b3a.2;
        Thu, 11 May 2023 07:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683817153; x=1686409153;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jxmpm6QJhLjfIu7rdhWCC28olrB5FLthXZJk0Cftfj8=;
        b=EKUXk1wUCFkUgZ4mO/Dxzdegw+zmKOoNYNpA058P6CE1+TGsguw8yR9Wq+esTyeRVl
         JX+/2Og+Kk+6LHAjVUHWV39vnZ4IybuU/wPKCy6YNuqicFZOugXBuLICBVmu4Rka84ru
         d27IjH+XFL2I7Ftfp+etgrKbpZkEwv9kubh+Cln8JQOozf+hOp1G99QaByl0FFmqdSgM
         oIibYbWtBvMVPJ6tn+Pg7SiNDlMbVb+cTKr5qI5BJ4cn0sbRwmDZPR1CemoSwK78ucLs
         GDOAoPTRDaSmkSLz+QcU/ppv0tcWv0y5q83o/xv9NZcngyMpcunQtu48At56mSFnWVOa
         cgyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683817153; x=1686409153;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jxmpm6QJhLjfIu7rdhWCC28olrB5FLthXZJk0Cftfj8=;
        b=RVkBuBcNL7RDi/v/w8IExZuBdv8ggY1aPOzkdETVZrlV4/DUqzpoO4THHLmpBQUJIF
         YvA6vcOd4BQFxjuNvFrNfAKDA2eKzIR5E+d8KRjIr09+Qtt4heTzbPGXLiZQjPXMG/bC
         MYzI14cRQckYTU9QvB22bdEGp1HEzpJroJdAche07G52wkRlft6yAZsUEyKhv83e2YcN
         4maul8xJT34mUD3aM2E77rwPOvu8byTMtMaCgX8PVKFMKEzbQ3Xz1LDhhsGlJ2yWh3n1
         we38yv29AC54cgi5GR0bMF2U4aOU4NDasU9ez6P8CluwatNdwh1pdE50rhmSaepxmSIO
         A/kg==
X-Gm-Message-State: AC+VfDzzTIqbrK6SRf9nbj+H3T7VySU5XCSHPlu0nrKnpxGk2bovognj
        TnSaf7s4pebaBSa2ciieH/Q=
X-Google-Smtp-Source: ACHHUZ4UChDZreBdWe7eD7dyF2UmkYB9pYAOAMp4I4A3/HPsdFfgnvoASPCeFX9RddExMgANHVAwlw==
X-Received: by 2002:a05:6a00:2401:b0:63b:5501:6795 with SMTP id z1-20020a056a00240100b0063b55016795mr27904487pfh.24.1683817152786;
        Thu, 11 May 2023 07:59:12 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:61b:48ed:72ab:435b])
        by smtp.gmail.com with ESMTPSA id i8-20020aa79088000000b006430cb02bd5sm5390140pfa.168.2023.05.11.07.59.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 07:59:12 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org
Cc:     freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Clark <robdclark@chromium.org>,
        Lepton Wu <lepton@chromium.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Elliot Berman <quic_eberman@quicinc.com>,
        Adam Skladowski <a39.skl@gmail.com>,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM SMMU DRIVERS),
        iommu@lists.linux.dev (open list:IOMMU SUBSYSTEM),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 1/2] iommu/arm-smmu-qcom: Fix missing adreno_smmu's
Date:   Thu, 11 May 2023 07:59:05 -0700
Message-Id: <20230511145908.597683-1-robdclark@gmail.com>
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
Suggested-by: Lepton Wu <lepton@chromium.org>
Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
index d1b296b95c86..66e191773099 100644
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
@@ -540,12 +541,18 @@ struct arm_smmu_device *qcom_smmu_impl_init(struct arm_smmu_device *smmu)
 		/* Match platform for ACPI boot */
 		if (acpi_match_platform_list(qcom_acpi_platlist) >= 0)
 			return qcom_smmu_create(smmu, &qcom_smmu_500_impl0_data);
 	}
 #endif
 
 	match = of_match_node(qcom_smmu_impl_of_match, np);
 	if (match)
 		return qcom_smmu_create(smmu, match->data);
 
+	/* If you hit this WARN_ON() you are missing an entry in the
+	 * qcom_smmu_impl_of_match[] table, and GPU per-process page-
+	 * tables will be broken.
+	 */
+	WARN_ON(of_device_is_compatible(np, "qcom,adreno-smmu"));
+
 	return smmu;
 }
-- 
2.40.1

