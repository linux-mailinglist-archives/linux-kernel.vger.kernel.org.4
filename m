Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5213B5B3389
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 11:21:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbiIIJUt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 05:20:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229983AbiIIJUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 05:20:44 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1408B287B
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 02:20:42 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id y29so1089454ljq.7
        for <linux-kernel@vger.kernel.org>; Fri, 09 Sep 2022 02:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=XnkhLW1ejx8tTO+Y2Pwl+ZHC58noV7Cx6HucpRux/vI=;
        b=QQojFVc2k9PcGOvKHHr5y1k4LCqtHDtgix461+LEA/MpWC9FdGdDFNqg+lJ3TH2guI
         6qIc/txqs0RA8Um0J4kMYH8vFwQ+knr9QJ2ynb2Zh+n+7eRdEIj/rNAEgcC2lnofGeGo
         FI+7DjM4wQc6RcRWGiKaVrt85uQD7zygPWc0hcJ5rb/saMZPSvx2oK0IhPUIfTdMw1ju
         Bk5I96ljFe99+T06ENoi6nLiYtbcn3TyBdVCBcBGYlOE6tXgSSHQ+2S8LdRhNNvIWHY9
         M6+tug9yOui5mUn0EzbHBQAR3+trhCV+TR0ri886ivgMC55AXBDa6XeQrEbrK8yUL0pu
         8UAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=XnkhLW1ejx8tTO+Y2Pwl+ZHC58noV7Cx6HucpRux/vI=;
        b=Awuon3oxnyV+CHADVEb14dPISIvido5xsrz1bEBYLoDRte4iGFtoXZw5ipbnnxPl6n
         FEeV6se9GBJZEHeBS0gVOezB/pSdfXQSGwttSszPfN6PqHD8gOmpocuJEcNagpn3ckww
         QaH2gcpmk2olAXFf3/JgWVotFx6Wpie3UF2ECNorBFefKOo+ilB6S0dP5SoB7SieSbtL
         vDNydHucopTz9JBoLDVUc2/Yrs90Ea4qv/qACHjhj6156EMW9cJX4TeCSsIzbxq3Crbi
         VFt/j/0vNCXrZgQIuAAmoIY+xV4VwH5Kb4aBSdtgpwHXazH79dWEAMX4P5sg+Ea02HAn
         fPtw==
X-Gm-Message-State: ACgBeo1d6jETmBz53iSbLN1hlior7J1TR9LP0pAyqWdChXW6QN6aX3w4
        IcGnICcOS+gve9o58QPun13IPg==
X-Google-Smtp-Source: AA6agR4/MECLtPUrG3w1cE3tpTg0G0bj6Q2BTrm9q5W4QM1J3Sxu7sA6FekYdA5+1DR+QEB22UhYBw==
X-Received: by 2002:a2e:8518:0:b0:26a:cfb4:5d47 with SMTP id j24-20020a2e8518000000b0026acfb45d47mr3163880lji.22.1662715240709;
        Fri, 09 Sep 2022 02:20:40 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id s6-20020a056512214600b00498fe38ea0fsm2170lfr.174.2022.09.09.02.20.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 02:20:40 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 00/15] ARM/hwlock: qcom: switch TCSR mutex to MMIO
Date:   Fri,  9 Sep 2022 11:20:20 +0200
Message-Id: <20220909092035.223915-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Switch older Qualcomm SoCs to use MMIO-based method instead of syscon.

Not tested on hardware. Please kindly provide tests.

Changes since v2
================
1. Rebase on current MFD changes.
2. Add Rb tag.
3. Split MFD patch to separate patchset:
https://lore.kernel.org/linux-devicetree/20220909091056.128949-1-krzysztof.kozlowski@linaro.org/T/#u

Changes since v1
================
1. Use existing qcom,tcsr-msm8974 compatible.
2. Fix few other TCSR syscon compatibles (new patches: ipq6018, msm8953,
   qcs404, msm8996).
3. New patch: dt-bindings: mfd: qcom,tcsr: drop simple-mfd from IPQ6018
4. New patch: dt-bindings: mfd: qcom,tcsr: add QCS404

Dependencies
============
1. DT bindings and driver patches can go via hwlock. DTS via Bjorn/Qualcomm.

2. The last five DTS commits (ARM and arm64) named "switch TCSR mutex to MMIO"
   depend on driver support. The changes are not bisectable, just like
   previously such changes were not bisectable:
   https://lore.kernel.org/all/20200622075956.171058-5-bjorn.andersson@linaro.org/
   Therefore these changes could wait for next release.

Best regards,
Krzysztof

Krzysztof Kozlowski (15):
  dt-bindings: hwlock: qcom-hwspinlock: add support for MMIO on older
    SoCs
  dt-bindings: hwlock: qcom-hwspinlock: correct example indentation
  hwspinlock: qcom: correct MMIO max register for newer SoCs
  hwspinlock: qcom: add support for MMIO on older SoCs
  arm64: dts: qcom: ipq6018: add missing TCSR syscon compatible
  arm64: dts: qcom: msm8953: add missing TCSR syscon compatible
  arm64: dts: qcom: qcs404: add missing TCSR syscon compatible
  arm64: dts: qcom: msm8996: add missing TCSR syscon compatible
  ARM: dts: qcom: msm8974: add missing TCSR syscon compatible
  ARM: dts: qcom: msm8974: split TCSR halt regs out of mutex
  arm64: dts: qcom: ipq6018: switch TCSR mutex to MMIO
  arm64: dts: qcom: msm8994: switch TCSR mutex to MMIO
  ARM: dts: qcom: msm8974: switch TCSR mutex to MMIO
  ARM: dts: qcom: apq8084: switch TCSR mutex to MMIO
  ARM: dts: qcom: msm8226: switch TCSR mutex to MMIO

 .../bindings/hwlock/qcom-hwspinlock.yaml      | 25 +++++++----
 .../arm/boot/dts/qcom-apq8074-dragonboard.dts |  2 +-
 arch/arm/boot/dts/qcom-apq8084.dtsi           | 11 ++---
 arch/arm/boot/dts/qcom-msm8226.dtsi           | 14 ++-----
 .../qcom-msm8974-lge-nexus5-hammerhead.dts    |  2 +-
 .../dts/qcom-msm8974-sony-xperia-rhine.dtsi   |  2 +-
 arch/arm/boot/dts/qcom-msm8974.dtsi           | 25 ++++++-----
 .../dts/qcom-msm8974pro-fairphone-fp2.dts     |  2 +-
 .../boot/dts/qcom-msm8974pro-samsung-klte.dts |  2 +-
 ...-msm8974pro-sony-xperia-shinano-castor.dts |  2 +-
 arch/arm64/boot/dts/qcom/ipq6018.dtsi         | 15 +++----
 arch/arm64/boot/dts/qcom/msm8953.dtsi         |  2 +-
 arch/arm64/boot/dts/qcom/msm8994.dtsi         | 13 ++----
 arch/arm64/boot/dts/qcom/msm8996.dtsi         |  2 +-
 arch/arm64/boot/dts/qcom/qcs404.dtsi          |  2 +-
 drivers/hwspinlock/qcom_hwspinlock.c          | 42 ++++++++++++++-----
 16 files changed, 86 insertions(+), 77 deletions(-)

-- 
2.34.1

