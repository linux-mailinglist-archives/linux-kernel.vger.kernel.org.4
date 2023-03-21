Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2AC46C2E7A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 11:15:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbjCUKPf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 06:15:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjCUKPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 06:15:33 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2382B3BC56
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 03:15:28 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id kq3so3077529plb.13
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 03:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679393727;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XYIEmKf52NYEWrNdpaXJ3v1W0hKF3ftprNKh3Wud+Dw=;
        b=BmyyTr+3j2Vvujb32yH2EM+vbvlpatom5s2GPyNol5mKx1hZWtWwfJ5YxZPRtlO+wR
         X3eajkA02HKDYXJiMVg0FxsQeS0JVBKMypwGmrRP53GjctYSxKVUCRkkQKsWf0vCPG6i
         5ZekszoXrCkfj95X/4IZVYRng/YD2FvBmc7CD2F24kIE4dP4cS1cDOkki9jLBHLr86vH
         bUE9oIDX+yCpW/gECTMAXV2gAwgpvPAffHoLQwqNvvCR0R2RTzPrkfK4snkEWAwgc0qm
         5GRPy+3RxJ0qWe7U1W6V+H6Kcy2iRJc9XBL+XsqFqDRXsjOD7L/6trcCKyyugWbrYXEC
         Pl2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679393727;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XYIEmKf52NYEWrNdpaXJ3v1W0hKF3ftprNKh3Wud+Dw=;
        b=mhPXUhP4B9Bs2q4NCHd4A+5RqUJniN79A7o1jMcFoS2vbFema/c+2pdlAtPlMcFfyz
         EMG1QNBzkorFYqQNtJ227lTlXp9QS//hVCkOHxAlflD+FRIIjh1pG/P5NzzV3Qlkm1n8
         PI9QfKxTx6HBl07yvmnNbmJ/x0ItDUAIUdcf85xYht/Hp1CTNVd4XRmOo7XwmRyaZ2KH
         jy2Sd4To02unZxmUuTEXZmnS9czlEQIdYOvreS3MXKRBKNPPIEv+cYrp4idYctaeMAwc
         wflsURgfmpfoV0v9kOJ1fbTrPsrCF6yOeTr2Zpoalug1QDM6pb0/QIZgPWpBI/cgGW+E
         r8Gg==
X-Gm-Message-State: AO0yUKViOEa/wdZENMGbuD926YvGugBYtzm5+B2nB5AnSo6Xl93TZRYZ
        UUIsKJeFKQrt7iUdISoKcDdL
X-Google-Smtp-Source: AK7set8wT5e21KPeq70SJ2RVHMDL8pXfqoa+nAuyHbWCb/g80CXj+qROT4H42dOBTddU2G4mhbI32Q==
X-Received: by 2002:a17:90b:4a43:b0:23f:e4b7:afb3 with SMTP id lb3-20020a17090b4a4300b0023fe4b7afb3mr2102902pjb.9.1679393727395;
        Tue, 21 Mar 2023 03:15:27 -0700 (PDT)
Received: from localhost.localdomain ([117.217.184.244])
        by smtp.gmail.com with ESMTPSA id n20-20020a170902d0d400b0019eae717885sm8371936pln.107.2023.03.21.03.15.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 03:15:27 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     will@kernel.org, joro@8bytes.org
Cc:     robin.murphy@arm.com, andersson@kernel.org,
        johan+linaro@kernel.org, steev@kali.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v4] iommu/arm-smmu-qcom: Limit the SMR groups to 128
Date:   Tue, 21 Mar 2023 14:43:32 +0530
Message-Id: <20230321091332.18334-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On some Qualcomm platforms, the hypervisor emulates more than 128 SMR
(Stream Matching Register) groups. This doesn't conform to the ARM SMMU
architecture specification which defines the range of 0-127. Moreover, the
emulated groups don't exhibit the same behavior as the architecture
supported ones.

For instance, emulated groups will not detect the quirky behavior of some
firmware versions intercepting writes to S2CR register, thus skipping the
quirk implemented in the driver and causing boot crash.

So let's limit the groups to 128 and issue a notice to users in that case.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---

Changes in v4:

* Spun off the SMR limiting part into a separate patch
* Dropped the quirk rework part as it is not really needed for now

Changes in v3:

* Limited num_mapping_groups to 128 as per ARM SMMU spec and removed the
  check for 128 groups in qcom_smmu_bypass_quirk()
* Reworded the commit message accordingly

Changes in v2:

* Limited the check to 128 groups as per ARM SMMU spec's NUMSMRG range
* Moved the quirk handling to its own function
* Collected review tag from Bjorn

 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
index d1b296b95c86..54f62d409619 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
@@ -268,12 +268,26 @@ static int qcom_smmu_init_context(struct arm_smmu_domain *smmu_domain,
 
 static int qcom_smmu_cfg_probe(struct arm_smmu_device *smmu)
 {
-	unsigned int last_s2cr = ARM_SMMU_GR0_S2CR(smmu->num_mapping_groups - 1);
 	struct qcom_smmu *qsmmu = to_qcom_smmu(smmu);
+	unsigned int last_s2cr;
 	u32 reg;
 	u32 smr;
 	int i;
 
+	/*
+	 * Limit the number of stream matching groups to 128 as the ARM SMMU
+	 * architecture specification defines NUMSMRG (Number of Stream Mapping
+	 * Register Groups) in the range of 0-127, but some Qcom platforms
+	 * emulate more stream mapping groups. And those groups don't exhibit
+	 * the same behavior as the architecture supported ones.
+	 */
+	if (smmu->num_mapping_groups > 128) {
+		dev_notice(smmu->dev, "\tLimiting the stream matching groups to 128\n");
+		smmu->num_mapping_groups = 128;
+	}
+
+	last_s2cr = ARM_SMMU_GR0_S2CR(smmu->num_mapping_groups - 1);
+
 	/*
 	 * With some firmware versions writes to S2CR of type FAULT are
 	 * ignored, and writing BYPASS will end up written as FAULT in the
-- 
2.25.1

