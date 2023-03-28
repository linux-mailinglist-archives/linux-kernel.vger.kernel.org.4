Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CCCC6CBACC
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 11:31:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232521AbjC1J25 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 05:28:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232453AbjC1J2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 05:28:48 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 010A461A2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 02:28:25 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id r7-20020a17090b050700b002404be7920aso10477737pjz.5
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 02:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679995705;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TwOeeM0Gc4tN+QYu8+Z9WuguitIgi90Sd1+U++iusLY=;
        b=s72MT9nY/6jH9o35SvPW523lbHGEmGn7+JEP2R8hz0I6//1W7BiS6BRqO92l0Q7IWJ
         5gsJwuqiIyaOrgyfMdPtrk18Ve1s8dFzTFxK0ejRtADaNYszk57CHuYubHBBe1mQZozX
         ue7SySqUxsxmzKJXxltkkSwmmyWO+qTwpxj9Wji80Ybg6aF+swYc0pzsq7DDazUmKTdG
         lJyZI2bdfpqzauwAuc8KLIWhIZzE52syRlJba6PWpyMwzkrzXGGCVimyNc8ePLXkMzOG
         z+FqQU0FIzC+4SXlyL2gRLtgY+PmuvLu8Y1Q4FfoLrHcczRzlsRnVN/HgJqgsGJu8Dyt
         x1rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679995705;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TwOeeM0Gc4tN+QYu8+Z9WuguitIgi90Sd1+U++iusLY=;
        b=42br3hsXs1T0ZvqApwykSFjtLwNdHWq7mUyi0//WkozQu4xxAASUhnXKWpIRZpGS3j
         +9PXydTQFqyW+AZOIWsmJgBQGqtVSkc5/PG8zsGGpgeb1/khqsr2aL5mqlAgeeFm04Za
         wRQP0yBtl6Hj+OWVTmVajPOLW7t4WG6hrjSnY00T14mP9CbFQB6WF/bjUZjKEMTUB757
         zzNMTmdDZApV6QhtU6mW3w/VJTEt6/YQeraSxHvX6c+wfQnlG+l7CBUdbe+1P/K8yJEJ
         jBY3Cp39wuF72o/2qD1NvAdzoyWlIjTt2rIZrxHe2ldl3OQzx9lCI0C1tNCJYozUTnAQ
         5Kzw==
X-Gm-Message-State: AO0yUKUIy9qtRq2v9fPgzgcLilA+T9alyHLJXSzWFkcntU4B9davPThs
        kmJm08CSH95+vNyD7tGss/+pIQ==
X-Google-Smtp-Source: AK7set/gqVQvlh1dYk1GKB0z0VrICqZ6/xVXx8jSzvzqqoBg9TGalA4//LSCrdA1mFhcFd1qvSSnJA==
X-Received: by 2002:a05:6a20:3a87:b0:da:dc14:33d with SMTP id d7-20020a056a203a8700b000dadc14033dmr11444261pzh.53.1679995704945;
        Tue, 28 Mar 2023 02:28:24 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:1c61:449a:10df:e7c1:9bdd:74f0])
        by smtp.gmail.com with ESMTPSA id a24-20020aa78658000000b005a8bc11d259sm21261518pfo.141.2023.03.28.02.28.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 02:28:24 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
Cc:     agross@kernel.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, andersson@kernel.org,
        bhupesh.sharma@linaro.org, bhupesh.linux@gmail.com,
        krzysztof.kozlowski@linaro.org, robh+dt@kernel.org,
        konrad.dybcio@linaro.org, vladimir.zapolskiy@linaro.org,
        rfoss@kernel.org, neil.armstrong@linaro.org
Subject: [PATCH v3 0/9] arm64: qcom: Enable Crypto Engine for a few Qualcomm SoCs
Date:   Tue, 28 Mar 2023 14:58:06 +0530
Message-Id: <20230328092815.292665-1-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since v2:
-----------------
- v2 can be viewed here: https://lore.kernel.org/linux-arm-msm/20230322114519.3412469-1-bhupesh.sharma@linaro.org/
- No functional change since v2. As the sdm845 patch from v1 was accepted in linux-next,
  dropped it from this version.

Changes since v1:
-----------------
- v1 can be viewed here: https://lore.kernel.org/linux-arm-msm/20230321190118.3327360-1-bhupesh.sharma@linaro.org/
- Folded the BAM DMA dt-binding change.
  (sent earlier as: https://lore.kernel.org/linux-arm-msm/20230321184811.3325725-1-bhupesh.sharma@linaro.org/)
- Folded the QCE dt-binding change.
  (sent earlier as: https://lore.kernel.org/linux-arm-msm/20230320073816.3012198-1-bhupesh.sharma@linaro.org/)
- Folded Neil's SM8450 dts patch in this series.
- Addressed review comments from Rob, Stephan and Konrad.
- Collected Konrad's R-B for [PATCH 5/9].

This patchset enables Crypto Engine support for Qualcomm SoCs like
SM6115, SM8150, SM8250, SM8350 and SM8450.

Note that:
- SM8250 crypto engine patch utilizes the work already done by myself and
  Vladimir.
- SM8350 crypto engine patch utilizes the work already done by Robert.
- SM8450 crypto engine patch utilizes the work already done by Neil.

Also this patchset is rebased on linux-next/master.

Bhupesh Sharma (8):
  dt-bindings: dma: Add support for SM6115 and QCM2290 SoCs
  dt-bindings: dma: Increase iommu maxItems for BAM DMA
  dt-bindings: qcom-qce: Fix compatibles combinations for SM8150 and
    IPQ4019 SoCs
  dt-bindings: qcom-qce: Add compatibles for SM6115 and QCM2290
  arm64: dts: qcom: sm6115: Add Crypto Engine support
  arm64: dts: qcom: sm8150: Add Crypto Engine support
  arm64: dts: qcom: sm8250: Add Crypto Engine support
  arm64: dts: qcom: sm8350: Add Crypto Engine support

Neil Armstrong (1):
  arm64: dts: qcom: sm8450: add crypto nodes

 .../devicetree/bindings/crypto/qcom-qce.yaml  |  8 ++++++
 .../devicetree/bindings/dma/qcom,bam-dma.yaml | 24 ++++++++++------
 arch/arm64/boot/dts/qcom/sm6115.dtsi          | 22 +++++++++++++++
 arch/arm64/boot/dts/qcom/sm8150.dtsi          | 22 +++++++++++++++
 arch/arm64/boot/dts/qcom/sm8250.dtsi          | 22 +++++++++++++++
 arch/arm64/boot/dts/qcom/sm8350.dtsi          | 22 +++++++++++++++
 arch/arm64/boot/dts/qcom/sm8450.dtsi          | 28 +++++++++++++++++++
 7 files changed, 140 insertions(+), 8 deletions(-)

-- 
2.38.1

