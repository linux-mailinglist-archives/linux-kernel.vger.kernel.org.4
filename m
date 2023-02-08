Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB7E468F647
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 19:00:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231532AbjBHSAv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 13:00:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231465AbjBHSAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 13:00:49 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1831A1115D
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 10:00:48 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id l37-20020a05600c1d2500b003dfe46a9801so2134023wms.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Feb 2023 10:00:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JM97LRzJuNIDSLoCISaLbKYkgeCT4D6L+oW9RVZ90Yk=;
        b=AhK6w+HaNN9UcUU9RClSrVf/MNf3cBzGVk1j/L/hIllRp/hGqKN2c785P5ZvV2M4HF
         glhT2PFlq/5knVylSOKQZH02xFnxnxj1nGCMgEKP0ld90BWvS/qhKK1V7TsVXGrrpkW4
         LRYIBOdPOeDA7TnL5z2imhnxyQHUiVpP+bb92NHbEbrxZUK1E9KW1lcdLsf6bsNZoyHX
         5Te/MV+LWIpLnGro18mO90JkeZJ6JQxE1KDQnU2iHbjWnAqy1MxSvCBXnkDvaGCIFVB9
         EogvRjNOUJWsobUduJ7b6CUAYll0c6EDP0HyZbLva0R1Sb/bcUbrVdcuoc+iHuOWtz65
         tNBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JM97LRzJuNIDSLoCISaLbKYkgeCT4D6L+oW9RVZ90Yk=;
        b=IbvXOQ2V9QhgxmoTkt4iQ0w7JwdhxMCBmfiFPGvOrweGJx3gDzkFmRr1dXqqt7/t9/
         YdEM8brhUat7rwvzuELwtu4r9wElEGG1TYvxRl1E6mwFVl7IufBBGNeGjqJ4sIuvtX9z
         ofHpk/s+KnpflK2wdO+QKoiFuUciUPGj/jfUOuLOgOEdRKRJc0pipZYhqQO3LPoVF121
         KzyJSZ6SDLw/gHRC25HI4xe6k4zh+JNDACRqKN0n0t+JR91UVIxVo+JbqU8pwFfLA6mI
         qqbQl4nFN6hBQQ/bYSEMaRQq3MP58N1+yN4IwNJQYajpjxLNtS+JKmgdNPt/CC0iJp1m
         FxcQ==
X-Gm-Message-State: AO0yUKUzhLWQjnGC+pXmx3qJbmUBSOa654Twogi4UcQVpvmvJsMho60i
        DXmfv9q3CoT4CrUzJoLVcnzIFH/YEhveKQPU
X-Google-Smtp-Source: AK7set8Y152Z3sTAFY7YTLliHoMt3ktxih4kVHF3bHkaEDdbrPJEuvTVoUiiwlapKRteWSDw4GPGCA==
X-Received: by 2002:a05:600c:713:b0:3df:e4b4:de69 with SMTP id i19-20020a05600c071300b003dfe4b4de69mr7318950wmn.27.1675879246674;
        Wed, 08 Feb 2023 10:00:46 -0800 (PST)
Received: from hackbox.lan ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id k20-20020a05600c169400b003dc54eef495sm2370286wmn.24.2023.02.08.10.00.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 10:00:45 -0800 (PST)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Johan Hovold <johan+linaro@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH v9 00/11] sm8550: Add PCIe HC and PHY support
Date:   Wed,  8 Feb 2023 20:00:09 +0200
Message-Id: <20230208180020.2761766-1-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
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

For changelogs please look at each patch individually.

Abel Vesa (11):
  dt-bindings: phy: Add QMP PCIe PHY comptible for SM8550
  phy: qcom-qmp: pcs: Add v6 register offsets
  phy: qcom-qmp: pcs: Add v6.20 register offsets
  phy: qcom-qmp: pcs-pcie: Add v6 register offsets
  phy: qcom-qmp: pcs-pcie: Add v6.20 register offsets
  phy: qcom-qmp: qserdes-txrx: Add v6.20 register offsets
  phy: qcom-qmp: qserdes-lane-shared: Add v6 register offsets
  phy: qcom-qmp-pcie: Add support for SM8550 g3x2 and g4x2 PCIEs
  dt-bindings: PCI: qcom: Add SM8550 compatible
  PCI: qcom: Add SM8550 PCIe support
  arm64: dts: qcom: sm8550: Fix PCIe PHYs and controllers nodes

 .../devicetree/bindings/pci/qcom,pcie.yaml    |  40 ++
 .../phy/qcom,sc8280xp-qmp-pcie-phy.yaml       |  30 +-
 arch/arm64/boot/dts/qcom/sm8550-mtp.dts       |  10 +
 arch/arm64/boot/dts/qcom/sm8550.dtsi          |  52 +--
 drivers/pci/controller/dwc/pcie-qcom.c        |  25 +-
 drivers/phy/qualcomm/phy-qcom-qmp-pcie.c      | 346 +++++++++++++++++-
 .../phy/qualcomm/phy-qcom-qmp-pcs-pcie-v6.h   |  15 +
 .../qualcomm/phy-qcom-qmp-pcs-pcie-v6_20.h    |  23 ++
 drivers/phy/qualcomm/phy-qcom-qmp-pcs-v6.h    |  16 +
 drivers/phy/qualcomm/phy-qcom-qmp-pcs-v6_20.h |  18 +
 .../phy-qcom-qmp-qserdes-ln-shrd-v6.h         |  32 ++
 .../phy-qcom-qmp-qserdes-txrx-v6_20.h         |  45 +++
 drivers/phy/qualcomm/phy-qcom-qmp.h           |   6 +
 13 files changed, 611 insertions(+), 47 deletions(-)
 create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v6.h
 create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v6_20.h
 create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-pcs-v6.h
 create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-pcs-v6_20.h
 create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-qserdes-ln-shrd-v6.h
 create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-v6_20.h

-- 
2.34.1

