Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 944E161DB7A
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 16:03:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbiKEPDb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Nov 2022 11:03:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbiKEPCy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Nov 2022 11:02:54 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7BAA10B51;
        Sat,  5 Nov 2022 08:02:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5BCC2B802C3;
        Sat,  5 Nov 2022 15:02:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE1BDC433D6;
        Sat,  5 Nov 2022 15:02:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667660570;
        bh=kYdOKAF/5Q7m4Ezd0uHPs5wxaKbTgNgIwKugdR1H+Zw=;
        h=From:To:Cc:Subject:Date:From;
        b=X6uYkmMHY1vbRtUx4gvaoBpQJMuKGX8C1lhn9BkVMv2LUg0+ufaZk/7ul195HYBXf
         AUcAb0gL34S9DHE9gIvsF3M4Yg3/wRYZnbda68hpSyYlI+wqLG3TfcGtSuEXVp8A2+
         0ELOZL7kOwIqOsMiSJCKKjV/ASiddyRM86J26IDwK2ww1kAbec74f17nXuR1+WlV/U
         8G6yuENjAonBF3NDItsWlNd1Y0ERWU5OwF+dliuMshvvyWZNcBrFPFiXLFM8S2qGKp
         uWcpG+2fr4v2Rvvxg2A4saQ+Tfpk1wLH5ymBXgDWQ5o5VtzjRyThVOOVJiZFMcNewU
         GvXiq12yw4Bmw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1orKgo-0005KF-Ih; Sat, 05 Nov 2022 16:02:30 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH v5 00/16] phy: qcom-qmp-pcie: add support for sc8280xp
Date:   Sat,  5 Nov 2022 15:59:23 +0100
Message-Id: <20221105145939.20318-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.37.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support for the PCIe PHYs on SC8280XP including its
four-lane PHYs.

The first half of the series clean up the driver in preparation for
supporting SC8280XP and its new devicetree bindings that drops the
legacy child node and the (incomplete) description of register
subregions.

The other QMP bindings suffer from similar problems and follow-on series
will do corresponding changes to the UFS, USB and combo QMP bindings and
drivers.

Johan


Changes in v5
 - use the shorter tables identifier throughout the driver (Vinod)

Changes in v4
 - break out switch to shorter tables identifier in a preparatory patch
   (Vinod)

Changes in v3
 - use bulk clk API for pipe clocks (Dmitry)

Changes in v2
 - rename current DT schema after first SoC added to the original
   bindings (IPQ8074) and add a reference to the new SC8280XP bindings
   instead of marking the current bindings as "legacy" (Krzysztof)

 - add "sc8280xp" infix to the new DT schema filename (Krzysztof)

 - tighten description of the 'qcom,4ln-config-sel' phandle array
   (Krzysztof)


Johan Hovold (16):
  phy: qcom-qmp-pcie: sort device-id table
  phy: qcom-qmp-pcie: move device-id table
  phy: qcom-qmp-pcie: merge driver data
  phy: qcom-qmp-pcie: clean up device-tree parsing
  phy: qcom-qmp-pcie: clean up probe initialisation
  phy: qcom-qmp-pcie: rename PHY ops structure
  phy: qcom-qmp-pcie: clean up PHY lane init
  phy: qcom-qmp-pcie: use shorter tables identifiers
  phy: qcom-qmp-pcie: add register init helper
  dt-bindings: phy: qcom,qmp-pcie: rename current bindings
  dt-bindings: phy: qcom,qmp-pcie: add sc8280xp bindings
  phy: qcom-qmp-pcie: restructure PHY creation
  phy: qcom-qmp-pcie: fix initialisation reset
  phy: qcom-qmp-pcie: add support for pipediv2 clock
  phy: qcom-qmp-pcie: add support for sc8280xp
  phy: qcom-qmp-pcie: add support for sc8280xp 4-lane PHYs

 ...hy.yaml => qcom,ipq8074-qmp-pcie-phy.yaml} |   7 +-
 .../phy/qcom,sc8280xp-qmp-pcie-phy.yaml       | 165 ++++
 drivers/phy/qualcomm/Kconfig                  |   1 +
 drivers/phy/qualcomm/phy-qcom-qmp-pcie.c      | 874 ++++++++++++------
 .../phy/qualcomm/phy-qcom-qmp-pcs-pcie-v5.h   |   2 +
 5 files changed, 770 insertions(+), 279 deletions(-)
 rename Documentation/devicetree/bindings/phy/{qcom,qmp-pcie-phy.yaml => qcom,ipq8074-qmp-pcie-phy.yaml} (96%)
 create mode 100644 Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml

-- 
2.37.4

