Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D1FF6C496E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 12:45:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbjCVLpg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 07:45:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjCVLpe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 07:45:34 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 236035506F
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 04:45:33 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id l7so1185282pjg.5
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 04:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679485532;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2+O6o3cqfiLbQr24/TOjdxuLgf/QkAWU7WZZoxZO1GE=;
        b=N5DBCtMuiln0Fr8UEeBZ7U8aydGp0J1wPY0WQO6c6sJDybTclrkWadCu+zzuA6vIPA
         jFMQytEyf6QyGtDz1q32hz27dSCeijbGp/GhTb7MUY7W5rLJGEEY4nTvCJImTqZ2dCRH
         LHwYpnkLWl8nTF3FQC/IsDzHL3QW3gRxIdndHZX2wsllOFSeezp2sySBXnGzOXbcsz5H
         C/7hFrYaLR5BTHiiflMEjS9lJFfpziafbbyy0/bu1b9NR0DSGyHVrl0ccsFwHwCAy4xv
         YY8VgFlLGhCTtW9/4jKdj1uMuCX+YqysMkfc6GVjcQDBQSyMsWco6nwY7EXjQ+uW05RK
         rAag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679485532;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2+O6o3cqfiLbQr24/TOjdxuLgf/QkAWU7WZZoxZO1GE=;
        b=XJICyBsC3f91XarM02mLDA4Oo7+gNzb3okSzcKv+rZBT9iwD+dlCY1UwlXieGehJb/
         iHjBo1pZb4R1kx1imgwp5KL1Gqi50BH/stTFOoeSQetZSEF2vBiSu9mDWEU7Y0eHkfxg
         FWWK9NtcYIyww5DRWr0XZvaWOTOi9mm+ZngrrXEDU7aHysXHE22L7Ue2PwjhtJUahtOF
         3ZDQWPdcPq6apeaRNmqEXyfxhLAUNbYJtEnRkV8iZ5sJcRaJihfDp3GPFlpEtkxsFSvF
         bVvr8w3EmAGq24kyWP9604FLhiKjNIN45++laoX3C4JGtjbdVxygjQkBsr80Sv8z15BI
         U8ZA==
X-Gm-Message-State: AO0yUKX5BMhlGALw9x1UwikIOJPCotP43EImCe7wPPb4KUywWoBPhpNb
        9+5Hqoyihbayuv+K+3PVADWd0g==
X-Google-Smtp-Source: AK7set/56AdP+NeGE5QIvnOZbcumy4vlC3E3UGgDx27hBp+V7kcdvEg2cqM6gn7nUr5wAFKU6tMZjQ==
X-Received: by 2002:a17:902:f98b:b0:19f:30be:ea0d with SMTP id ky11-20020a170902f98b00b0019f30beea0dmr2175646plb.62.1679485532598;
        Wed, 22 Mar 2023 04:45:32 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:1c60:d4c3:8671:83c0:33ae:5a96])
        by smtp.gmail.com with ESMTPSA id jd1-20020a170903260100b0019b0afc24e8sm10386649plb.250.2023.03.22.04.45.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 04:45:32 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
Cc:     agross@kernel.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, andersson@kernel.org,
        bhupesh.sharma@linaro.org, bhupesh.linux@gmail.com,
        krzysztof.kozlowski@linaro.org, robh+dt@kernel.org,
        konrad.dybcio@linaro.org, vladimir.zapolskiy@linaro.org,
        rfoss@kernel.org, neil.armstrong@linaro.org
Subject: [PATCH v2 00/10] arm64: qcom: Enable Crypto Engine for a few Qualcomm SoCs
Date:   Wed, 22 Mar 2023 17:15:09 +0530
Message-Id: <20230322114519.3412469-1-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

While at it, also fix the compatible string for BAM DMA engine
used in sdm845.dtsi

Note that:
- SM8250 crypto engine patch utilizes the work already done by myself and
  Vladimir.
- SM8350 crypto engine patch utilizes the work already done by Robert.
- SM8450 crypto engine patch utilizes the work already done by Neil.

Also this patchset is rebased on linux-next/master.

Bhupesh Sharma (9):
  dt-bindings: dma: Add support for SM6115 and QCM2290 SoCs
  dt-bindings: dma: Increase iommu maxItems for BAM DMA
  dt-bindings: qcom-qce: Fix compatibles combinations for SM8150 and
    IPQ4019 SoCs
  dt-bindings: qcom-qce: Add compatibles for SM6115 and QCM2290
  arm64: dts: qcom: sdm845: Fix the BAM DMA engine compatible string
  arm64: dts: qcom: sm6115: Add Crypto Engine support
  arm64: dts: qcom: sm8150: Add Crypto Engine support
  arm64: dts: qcom: sm8250: Add Crypto Engine support
  arm64: dts: qcom: sm8350: Add Crypto Engine support

Neil Armstrong (1):
  arm64: dts: qcom: sm8450: add crypto nodes

 .../devicetree/bindings/crypto/qcom-qce.yaml  |  8 ++++++
 .../devicetree/bindings/dma/qcom,bam-dma.yaml | 24 ++++++++++------
 arch/arm64/boot/dts/qcom/sdm845.dtsi          |  2 +-
 arch/arm64/boot/dts/qcom/sm6115.dtsi          | 22 +++++++++++++++
 arch/arm64/boot/dts/qcom/sm8150.dtsi          | 22 +++++++++++++++
 arch/arm64/boot/dts/qcom/sm8250.dtsi          | 22 +++++++++++++++
 arch/arm64/boot/dts/qcom/sm8350.dtsi          | 22 +++++++++++++++
 arch/arm64/boot/dts/qcom/sm8450.dtsi          | 28 +++++++++++++++++++
 8 files changed, 141 insertions(+), 9 deletions(-)

-- 
2.38.1

