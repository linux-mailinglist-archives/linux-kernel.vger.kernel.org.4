Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D37036075B1
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 13:10:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbiJULKy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 07:10:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbiJULKq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 07:10:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99B4E172509;
        Fri, 21 Oct 2022 04:10:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 24BA761E63;
        Fri, 21 Oct 2022 11:10:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FC07C433D7;
        Fri, 21 Oct 2022 11:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666350643;
        bh=DWAifErFWoOZm3KXJ7C5WfdvDrTHXU8ehmXjnEMpk9c=;
        h=From:To:Cc:Subject:Date:From;
        b=QgNFhYv8G/Asx+lSdBReO86jSAJEjxgSWMogrbsT6YOtT6jUHTfv5oVl2O/0+Qo+m
         /tNVIUygthIrO1Rdq6ngwc29Lr0kCwuddqQdtTimhDrBNucgtQ1EiW9JZUrdVoma6t
         pSKABao6T6G603SZRiWqeBwVotIv+Wigh938lM3pXqTzqQsWBNLeVokv/jYPy5mXte
         XjvX87LGEOaPDQWzP1+TLnH3ydtU4Rdsd3NNolNaOhR1J813G/UeDNlymg2y/1QoXQ
         ovGuLVSNz1NFOFivgJFsAeM/hwWru1HD/d1XGMgmZzpa7Kc3GXFygRSTa50Ht1sYQw
         MsFdyPhc8Algg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1olpv4-0007KS-9d; Fri, 21 Oct 2022 13:10:30 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH v3 00/15] phy: qcom-qmp-pcie: add support for sc8280xp
Date:   Fri, 21 Oct 2022 13:09:32 +0200
Message-Id: <20221021110947.28103-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

Note that these patches depend on the linux-phy next branch of today and
the following two series:

 1. [PATCH v2 00/14] phy: qcom-qmp: further prep cleanups

    https://lore.kernel.org/lkml/20221012081241.18273-1-johan+linaro@kernel.org

 2. [PATCH 00/20] phy: qcom-qmp: further prep fixes and cleanups (set 3)

    https://lore.kernel.org/lkml/20221012084846.24003-1-johan+linaro@kernel.org

Johan


Changes in v3
 - use bulk clk API for pipe clocks (Dmitry)

Changes in v2
 - rename current DT schema after first SoC added to the original
   bindings (IPQ8074) and add a reference to the new SC8280XP bindings
   instead of marking the current bindings as "legacy" (Krzysztof)

 - add "sc8280xp" infix to the new DT schema filename (Krzysztof)

 - tighten description of the 'qcom,4ln-config-sel' phandle array
   (Krzysztof)


Johan Hovold (15):
  phy: qcom-qmp-pcie: sort device-id table
  phy: qcom-qmp-pcie: move device-id table
  phy: qcom-qmp-pcie: merge driver data
  phy: qcom-qmp-pcie: clean up device-tree parsing
  phy: qcom-qmp-pcie: clean up probe initialisation
  phy: qcom-qmp-pcie: rename PHY ops structure
  phy: qcom-qmp-pcie: clean up PHY lane init
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
 drivers/phy/qualcomm/phy-qcom-qmp-pcie.c      | 824 ++++++++++++------
 .../phy/qualcomm/phy-qcom-qmp-pcs-pcie-v5.h   |   2 +
 5 files changed, 745 insertions(+), 254 deletions(-)
 rename Documentation/devicetree/bindings/phy/{qcom,qmp-pcie-phy.yaml => qcom,ipq8074-qmp-pcie-phy.yaml} (96%)
 create mode 100644 Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml

-- 
2.37.3

