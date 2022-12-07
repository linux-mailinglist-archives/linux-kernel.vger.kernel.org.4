Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 641AB645BB7
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 15:00:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbiLGOAE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 09:00:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbiLGN7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 08:59:38 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 487DEA452
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 05:59:36 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id 65so4850215pfx.9
        for <linux-kernel@vger.kernel.org>; Wed, 07 Dec 2022 05:59:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9qzjJqhRbd7WQ4NJO5tO8jZvOkII4hk1EVHsUTMW3vw=;
        b=LL2DHlQERrB8h3H6WtB4mA+079B71Iz3/+GN4SxQn4vKfgHGxTOJ+lMTsePmtgdGJq
         XAE+aDM+uTO8IpudWEGKSIPnYOCBQdI+KOiks6CLrV+Y1a/XCHqP3HDZWd0k1jlBO/xX
         lVeXXNyUv3yrSkbqyyD0XkbQCOre9Z9m13kHcGLQgxsF4emkgI46vFY0EPqPsZmVCNK/
         qhdodfFhQvW2dzyEf9OyiL8v8n+sAP6QEpit1rySYfFdoJGFDdEWonVYjT75M+yXccbU
         DIZGYa6rZrZFfHj4U7nA0/hJUWIMCLRFYtQ7JgUdzZ34C0+frCkQHP2zwKeB9T2I5jbT
         G2+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9qzjJqhRbd7WQ4NJO5tO8jZvOkII4hk1EVHsUTMW3vw=;
        b=qLH1/O9b+29n+AF7RBQcdQrMERSiM1pFCCnPs9J0Yc12ghm1AdIiLJhmo4qx7af8Ig
         ja810VYbQkTDImgKNQqvTFbCdNqdF+0l59gJJlWNiHYWNix/1yemLsKy9VkD5dHKfK5J
         wiYpTVU46uHVmJ8B2NZVlt1GBDvsZpPt5Vu7k1AdVvovzzaRxHL4QdSYQXMqzcxg/ZQ5
         Qw4ejKpRx3Pc3GY+d2fuV3rpps0ddAZ5ZkGythOISUWQiLahJ4/fi4zCyhVv3vTIE/qW
         mdS89nrJ2ci160kOygxT9q4MJi3QeBbhc9HZGxfDcLoOxGOjLzRS6Hg+ssG7TB1DqEVq
         svdA==
X-Gm-Message-State: ANoB5pkhDS/bqa08rP2eWf/YNILvRpbkCuC3wWOf9iOp+lsSUgE2UBKM
        SM0sabhvk0ZxeWYrPB0HtiTn
X-Google-Smtp-Source: AA0mqf4iqcBg0KpeZAhmXyroQw7K6th1WNGUPDsU78x1/24qN+T2KO0jGWjJvwW2xnRz1J3ulWMPMw==
X-Received: by 2002:a63:2154:0:b0:477:b650:494b with SMTP id s20-20020a632154000000b00477b650494bmr62341263pgm.434.1670421575614;
        Wed, 07 Dec 2022 05:59:35 -0800 (PST)
Received: from localhost.localdomain ([117.216.123.5])
        by smtp.gmail.com with ESMTPSA id c18-20020a170902d49200b00186b69157ecsm14720160plg.202.2022.12.07.05.59.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 05:59:34 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, bp@alien8.de,
        tony.luck@intel.com
Cc:     quic_saipraka@quicinc.com, konrad.dybcio@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        james.morse@arm.com, mchehab@kernel.org, rric@kernel.org,
        linux-edac@vger.kernel.org, quic_ppareek@quicinc.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 00/12] Qcom: LLCC/EDAC: Fix base address used for LLCC banks
Date:   Wed,  7 Dec 2022 19:29:09 +0530
Message-Id: <20221207135922.314827-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
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

The Qualcomm LLCC/EDAC drivers were using a fixed register stride for
accessing the (Control and Status Regsiters) CSRs of each LLCC bank.
This offset only works for some SoCs like SDM845 for which driver support
was initially added.
    
But the later SoCs use different register stride that vary between the
banks with holes in-between. So it is not possible to use a single register
stride for accessing the CSRs of each bank. By doing so could result in a
crash with the current drivers. So far this crash is not reported since
EDAC_QCOM driver is not enabled in ARM64 defconfig and no one tested the
driver extensively by triggering the EDAC IRQ (that's where each bank
CSRs are accessed).
    
For fixing this issue, let's obtain the base address of each LLCC bank from
devicetree and get rid of the fixed stride.

This series affects multiple platforms but I have only tested this on
SM8250 and SM8450. Testing on other platforms is welcomed.

Thanks,
Mani

Manivannan Sadhasivam (12):
  dt-bindings: arm: msm: Update the maintainers for LLCC
  dt-bindings: arm: msm: Fix register regions used for LLCC banks
  arm64: dts: qcom: sdm845: Fix the base addresses of LLCC banks
  arm64: dts: qcom: sc7180: Fix the base addresses of LLCC banks
  arm64: dts: qcom: sc7280: Fix the base addresses of LLCC banks
  arm64: dts: qcom: sc8280xp: Fix the base addresses of LLCC banks
  arm64: dts: qcom: sm8150: Fix the base addresses of LLCC banks
  arm64: dts: qcom: sm8250: Fix the base addresses of LLCC banks
  arm64: dts: qcom: sm8350: Fix the base addresses of LLCC banks
  arm64: dts: qcom: sm8450: Fix the base addresses of LLCC banks
  arm64: dts: qcom: sm6350: Fix the base addresses of LLCC banks
  qcom: llcc/edac: Fix the base address used for accessing LLCC banks

 .../bindings/arm/msm/qcom,llcc.yaml           | 128 ++++++++++++++++--
 arch/arm64/boot/dts/qcom/sc7180.dtsi          |   2 +-
 arch/arm64/boot/dts/qcom/sc7280.dtsi          |   5 +-
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi        |  10 +-
 arch/arm64/boot/dts/qcom/sdm845.dtsi          |   7 +-
 arch/arm64/boot/dts/qcom/sm6350.dtsi          |   2 +-
 arch/arm64/boot/dts/qcom/sm8150.dtsi          |   7 +-
 arch/arm64/boot/dts/qcom/sm8250.dtsi          |   7 +-
 arch/arm64/boot/dts/qcom/sm8350.dtsi          |   7 +-
 arch/arm64/boot/dts/qcom/sm8450.dtsi          |   7 +-
 drivers/edac/qcom_edac.c                      |  14 +-
 drivers/soc/qcom/llcc-qcom.c                  |  64 +++++----
 include/linux/soc/qcom/llcc-qcom.h            |   4 +-
 13 files changed, 197 insertions(+), 67 deletions(-)

-- 
2.25.1

