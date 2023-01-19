Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16CD7673B11
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 15:05:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231370AbjASOFM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 09:05:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231372AbjASOFJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 09:05:09 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C22856ECE
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 06:05:07 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id c4-20020a1c3504000000b003d9e2f72093so3655344wma.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 06:05:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9dXl5MSAf6THUl/3TA+I7jX3wEzwzpDXufOnVHww1WE=;
        b=uA2hhR0cBXUfloKo6JvvK7dyc314WNntf+GxNQLjpCdE5UB14EXGT8mjXjOLG84kTL
         zM7QyUYCAKrEqvpaVZy9KFXWuZXC1kewLqywsUGhwhMJlKGBTv1ZNmduXnlqXoz7nptY
         8lAiVPZIWDt7Pm/224Fh7/Hc74Ebf35Umh5V5YG9PWYuGV1zqW6fhTPKqjyCyi7qfgCv
         LfXnw8JrH3gVi49TaA9XLgvk5cjESP1fm7XgD2DR6pUm5OmhAZ7gZyDryiFaiZ73SuhM
         jMI8wD8IzW8bBlDn2LyA0v/9c4vKhiMLPt+aPAlel5Z9SZKwKs1setpw8m97FRq+wnHQ
         NfJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9dXl5MSAf6THUl/3TA+I7jX3wEzwzpDXufOnVHww1WE=;
        b=TOFbVGYiFy2VPGBErQy+54zBY0i6UPPctscyFYvynY/R8uyyNx0BfG0xDvSimUHUXH
         ptayqGmW1TC2tP99bWPWqixlLCbsM62eweWwuSTkSfqtY1YQMXRG2lCGqKAC2YZhn+nP
         svUtn3tYQNwFmM7iRcIK3TYTl1KsmQ74VOM5E1CA4DmGdDbQjgf1VUjgapMytMN7CmWr
         yzL21LMCXLcAFgsExuGjO/e4XKG/LOVGvBh/VPuO7/Q3Jb1euX+gmdteHEycxYQx4hTy
         hQbbqUItVMBn9R0ZTS4AinXCamiv7OiSzr1D1qnhMHg5/N7R+N0XDLEFQdQkPWQTVR0p
         gqJQ==
X-Gm-Message-State: AFqh2kpVqSmRqyCojwZjLXYyzc2pNE5wNg05YjHwjHsW14kmUFct/Oen
        k2gdwSDUHKJfsWokxGfNJDzguQ==
X-Google-Smtp-Source: AMrXdXuFCeG5Oi9K6Cs7CIYf3ikTo6UoLal3U73PVjlaOwcshPkD6BKNJtNiRr5vPMOxClhadO/IBA==
X-Received: by 2002:a05:600c:1d29:b0:3d9:69fd:7707 with SMTP id l41-20020a05600c1d2900b003d969fd7707mr19004751wms.2.1674137106143;
        Thu, 19 Jan 2023 06:05:06 -0800 (PST)
Received: from hackbox.lan ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id m10-20020a05600c4f4a00b003d96efd09b7sm5263883wmq.19.2023.01.19.06.05.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 06:05:05 -0800 (PST)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 00/12] sm8550: Add PCIe HC and PHY support
Date:   Thu, 19 Jan 2023 16:04:41 +0200
Message-Id: <20230119140453.3942340-1-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
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

In order to make sure the bindings are properly updated, I decided
to send the whole PCIe support for SM8550 in a single patchset.

Sorry in advance for the inconvenience.

For changelogs please look at each patch individually.

Abel Vesa (12):
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
  arm64: dts: qcom: sm8550: Add PCIe PHYs and controllers nodes
  arm64: dts: qcom: sm8550-mtp: Add PCIe PHYs and controllers nodes

 .../devicetree/bindings/pci/qcom,pcie.yaml    |  44 +++
 .../phy/qcom,sc8280xp-qmp-pcie-phy.yaml       |  11 +-
 arch/arm64/boot/dts/qcom/sm8550-mtp.dts       |  29 ++
 arch/arm64/boot/dts/qcom/sm8550.dtsi          | 207 +++++++++-
 drivers/pci/controller/dwc/pcie-qcom.c        |   4 +-
 drivers/phy/qualcomm/phy-qcom-qmp-pcie.c      | 367 ++++++++++++++++++
 .../phy/qualcomm/phy-qcom-qmp-pcs-pcie-v6.h   |  15 +
 .../qualcomm/phy-qcom-qmp-pcs-pcie-v6_20.h    |  23 ++
 drivers/phy/qualcomm/phy-qcom-qmp-pcs-v6.h    |  16 +
 drivers/phy/qualcomm/phy-qcom-qmp-pcs-v6_20.h |  18 +
 .../phy-qcom-qmp-qserdes-ln-shrd-v6.h         |  32 ++
 .../phy-qcom-qmp-qserdes-txrx-v6_20.h         |  45 +++
 drivers/phy/qualcomm/phy-qcom-qmp.h           |   6 +
 13 files changed, 812 insertions(+), 5 deletions(-)
 create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v6.h
 create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v6_20.h
 create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-pcs-v6.h
 create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-pcs-v6_20.h
 create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-qserdes-ln-shrd-v6.h
 create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-v6_20.h

-- 
2.34.1

