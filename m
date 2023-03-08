Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BE376B0DEB
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 17:00:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232318AbjCHQAQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 11:00:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232315AbjCHP7g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 10:59:36 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F5C68B33F
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 07:59:08 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id ay29-20020a05600c1e1d00b003e9f4c2b623so1649093wmb.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 07:59:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678291147;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=T5JFu944VlLvwqNSsdE85tDBaxtEQbqvWWGACaI1P34=;
        b=Cs38mQ7Hzy6NxzN0rw7/y88YnnIDhIAuRTXJu6qG97obQbgcYrjupSnC4l7N+mQmF3
         0Zp0FSEG4C5QNIllix0Pq/SC9NT7/CTPoTpFQd/o10bJB7yOCWAJKl6ujghc1QtX5t17
         f59ued4d/wvE0bjnUGbBvSbaXrLOF4xGbS1ouemYCfePszZYi0XPs5XLvtZz1dkM298j
         7g9zMkw6Clxh2Au5OoKnld95SrNuIINJ/KIagvdnmqUvn/Z+Sq2bakqGP5a5R5dirDgt
         SP6tVIl/ktAXf+wy4cFn+dUmv82yeHN5uFPNnhOIoytgYXYNKbjAb/TccB21ER15ZRJ2
         fK4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678291147;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T5JFu944VlLvwqNSsdE85tDBaxtEQbqvWWGACaI1P34=;
        b=OdtZT7vobXUHk5hFPaQTlVAhKpcRJWg2ixgoZGztP/wpdmqevn0Kqj7RfnGRBhZujr
         tjJnLbobNtS2vTBORA9+jQayuQPrkaLcdAoCjYeegN1zNR8Y55/5Ky/ArmAomtR11PzY
         6SAunYMz1Pra+VUZfz0YfUvYy+3/Bf8C5jqBwWS8Sh+xgpzKM3YCzpfKUdJaSLAyoyOi
         xbHV3+aN8Zh3daDU9YgouO4UnXNehwcEEGJcoSeBZnFJeiG1+OWFZwVykEbR2GXhXNUW
         JbwDusoirr0Q8AeaIC7zdzOoeyqoai/BhlaH2iKZvgjrtZtMu8cMUXDzMeL5wldYb5dV
         /lVQ==
X-Gm-Message-State: AO0yUKXio/fx93fUwhxjx19ALmhIrjX0cwZkkP4moPwx5cnoV8Zju97m
        dj4yHCLsqzA1o4pZDSNVKyg1UQ==
X-Google-Smtp-Source: AK7set+2QJoEuHrRia3+vViyHXIXGUf3b+nF68EBSYlz06MF0ge8vYvciclvnuuVP7SQ/htNYqzgrw==
X-Received: by 2002:a05:600c:4511:b0:3ea:e554:7808 with SMTP id t17-20020a05600c451100b003eae5547808mr16689893wmo.19.1678291146902;
        Wed, 08 Mar 2023 07:59:06 -0800 (PST)
Received: from hackbox.lan ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id 16-20020a05600c229000b003eb2e33f327sm2548430wmf.2.2023.03.08.07.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 07:59:06 -0800 (PST)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: [RFC PATCH v2 0/7] Add dedicated Qcom ICE driver
Date:   Wed,  8 Mar 2023 17:58:31 +0200
Message-Id: <20230308155838.1094920-1-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
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

As both SDCC and UFS drivers use the ICE with duplicated implementation,
while none of the currently supported platforms make use concomitantly
of the same ICE IP block instance, the new SM8550 allows both UFS and
SDCC to do so. In order to support such scenario, there is a need for
a unified implementation and a devicetree node to be shared between
both types of storage devices. So lets drop the duplicate implementation
of the ICE from both SDCC and UFS and make it a dedicated (soc) driver.
Also, switch all UFS and SDCC devicetree nodes to use the new ICE
approach.

See each individual patch for changelogs.

The v1 is here:
https://lore.kernel.org/all/20230214120253.1098426-1-abel.vesa@linaro.org/

Abel Vesa (7):
  dt-bindings: soc: qcom: Add schema for Inline Crypto Engine
  dt-bindings: ufs: qcom: Add ICE phandle and drop core clock
  dt-bindings: mmc: sdhci-msm: Add ICE phandle and drop core clock
  soc: qcom: Make the Qualcomm UFS/SDCC ICE a dedicated driver
  scsi: ufs: ufs-qcom: Switch to the new ICE API
  mmc: sdhci-msm: Switch to the new ICE API
  arm64: dts: qcom: Add the Inline Crypto Engine nodes

 .../devicetree/bindings/mmc/sdhci-msm.yaml    |   9 +-
 .../soc/qcom/qcom,inline-crypto-engine.yaml   |  42 +++
 .../devicetree/bindings/ufs/qcom,ufs.yaml     |  14 +-
 arch/arm64/boot/dts/qcom/sdm630.dtsi          |  18 +-
 arch/arm64/boot/dts/qcom/sdm670.dtsi          |  15 +-
 arch/arm64/boot/dts/qcom/sdm845.dtsi          |  21 +-
 arch/arm64/boot/dts/qcom/sm6115.dtsi          |  37 ++-
 arch/arm64/boot/dts/qcom/sm6350.dtsi          |  31 +-
 arch/arm64/boot/dts/qcom/sm8150.dtsi          |  21 +-
 arch/arm64/boot/dts/qcom/sm8450.dtsi          |  22 +-
 drivers/mmc/host/Kconfig                      |   2 +-
 drivers/mmc/host/sdhci-msm.c                  | 257 ++-------------
 drivers/soc/qcom/Kconfig                      |   6 +
 drivers/soc/qcom/Makefile                     |   1 +
 drivers/soc/qcom/ice.c                        | 301 ++++++++++++++++++
 drivers/ufs/host/Kconfig                      |   2 +-
 drivers/ufs/host/Makefile                     |   1 -
 drivers/ufs/host/ufs-qcom-ice.c               | 244 --------------
 drivers/ufs/host/ufs-qcom.c                   |  50 ++-
 drivers/ufs/host/ufs-qcom.h                   |  30 +-
 include/soc/qcom/ice.h                        |  65 ++++
 21 files changed, 608 insertions(+), 581 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,inline-crypto-engine.yaml
 create mode 100644 drivers/soc/qcom/ice.c
 delete mode 100644 drivers/ufs/host/ufs-qcom-ice.c
 create mode 100644 include/soc/qcom/ice.h

-- 
2.34.1

