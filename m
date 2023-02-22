Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 766D869F7E4
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 16:33:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231297AbjBVPdO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 10:33:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232506AbjBVPdJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 10:33:09 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A0812E0FC
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 07:33:06 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id c23so4469354pjo.4
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 07:33:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rMyy7zeolGJx13EdVfIC3dMjyuc5oDyD182TrCmkF94=;
        b=wETPq4VhxDAwhLSfECSszph1RsgRzfh4oibhGIpn9iT5NJpHbusmsb0OpMZbure3dP
         Co050tyAU4CZ+2K9MM2SYdx/JBr3QzaaYmd6LyQf4y61HQNUCf+gDJe9lgHj+eQL0pAR
         GF/+wHqCJqb6s2pfVAjS4kHSFePjhdJs2rBc0SMsiZZmQozNp575eg9f0B9JiJyiPEuX
         qQZIpqyO+ii13hTPIbOJ2jxtftbfM/e7GTnnyImmfPC5SMOzMyneTNHABE5NxU6YiW+y
         91PbTg+/i7Ht5CNZt6nH69TVz0x3knXefTv88Vq59yYKz0eqgliSF1R9Qu2dlpzynvqn
         Ob4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rMyy7zeolGJx13EdVfIC3dMjyuc5oDyD182TrCmkF94=;
        b=55Mc5yVTkdc1oOZYvhtz6djc0jv5UfzE3OHlyGSMJJ9MZjxIqtdAVdvrEouFSk3ue6
         D6P8JcZ3q1b59m/c4CYtbOuWnGSm3oRir48v3EL6T5WfYOogAGfrQlAqjihUzmeo5uSS
         r/sExgjIFzJKnU9mNnoY75RYsmUidhoYmptSpNzFT67fPgq/4AeTB8bicf34B+su61gx
         7w+IkPA1sQGBPBaP3Ac+tCvEIG4hN2K04ERKbJX2Yn9hWTOridK4VedM4dguGoWgiMce
         2hIoYOPs09VIP3HdQPW/BJyYKv4//MA/frFi3wmNx7BpO2Ucx+bAeSAZ2zJCZK+EItmp
         YBUg==
X-Gm-Message-State: AO0yUKWNv7mgWm4wFh3cUnfotQ+mosvPWZhalzJ09+rEBVLmt0b1tpwl
        RDhpvyYmjBXpGOiteh7sYygb
X-Google-Smtp-Source: AK7set/n/8dgaH07ptoAOleRUMSTtz2iry2jJrEygcUsEgQBJo45ikFu/zvY7ufBlzLlACL+ZmlTww==
X-Received: by 2002:a05:6a20:12d2:b0:c1:2027:f4a2 with SMTP id v18-20020a056a2012d200b000c12027f4a2mr540878pzg.49.1677079985963;
        Wed, 22 Feb 2023 07:33:05 -0800 (PST)
Received: from localhost.localdomain ([117.216.123.15])
        by smtp.gmail.com with ESMTPSA id f15-20020aa78b0f000000b005ac419804d3sm5222482pfd.186.2023.02.22.07.33.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Feb 2023 07:33:05 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org, lpieralisi@kernel.org, robh@kernel.org,
        kw@linux.com, krzysztof.kozlowski+dt@linaro.org, vkoul@kernel.org
Cc:     konrad.dybcio@linaro.org, bhelgaas@google.com, kishon@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 00/11] Add PCIe RC support to Qcom SDX55 SoC
Date:   Wed, 22 Feb 2023 21:02:40 +0530
Message-Id: <20230222153251.254492-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This series adds PCIe RC support to the Qcom SDX55 SoC. The PCIe controller
in SDX55 can act as both Root Complex and Endpoint but only one mode at a
time i.e., the mode cannot be switched during runtime.

This series has been tested on Thundercomm T55 board having QCA6390 WLAN
chipset connected to the PCIe controller. For powering up the WLAN chipset,
an out-of-tree patch has been used since we do not have a proper driver in
mainline to handle the power supplies.

NOTE: Even with this series, I couldn't get network connectivity using
QCA6390. But that's due to ath11k regression for which I've filed a bug
report: https://bugzilla.kernel.org/show_bug.cgi?id=206923

Merging strategy
----------------

PCI and binding patches through PCI tree
PHY patches through PHY tree
Devicetree patches through Qcom tree

Thanks,
Mani

Manivannan Sadhasivam (11):
  dt-bindings: PCI: qcom: Update maintainers entry
  dt-bindings: PCI: qcom: Add iommu properties
  dt-bindings: PCI: qcom: Add SDX55 SoC
  dt-bindings: PCI: qcom-ep: Fix the unit address used in example
  ARM: dts: qcom: sdx55: Fix the unit address of PCIe EP node
  ARM: dts: qcom: sdx55: Rename pcie0_{phy/lane} to pcie_{phy/lane}
  ARM: dts: qcom: sdx55: Add support for PCIe RC controller
  ARM: dts: qcom: sdx55-t55: Enable PCIe RC support
  phy: qcom-qmp-pcie: Split out EP related init sequence for SDX55
  phy: qcom-qmp-pcie: Add RC init sequence for SDX55
  PCI: qcom: Add support for SDX55 SoC

 .../devicetree/bindings/pci/qcom,pcie-ep.yaml |   2 +-
 .../devicetree/bindings/pci/qcom,pcie.yaml    |  35 +++-
 arch/arm/boot/dts/qcom-sdx55-t55.dts          |  42 +++++
 .../boot/dts/qcom-sdx55-telit-fn980-tlb.dts   |   2 +-
 arch/arm/boot/dts/qcom-sdx55.dtsi             | 154 +++++++++++++-----
 drivers/pci/controller/dwc/pcie-qcom.c        |   4 +-
 drivers/phy/qualcomm/phy-qcom-qmp-pcie.c      |  91 +++++++++--
 .../qualcomm/phy-qcom-qmp-pcs-pcie-v4_20.h    |   2 +
 8 files changed, 272 insertions(+), 60 deletions(-)

-- 
2.25.1

