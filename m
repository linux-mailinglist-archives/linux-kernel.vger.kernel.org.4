Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C347629C4C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 15:41:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232856AbiKOOlA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 09:41:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230112AbiKOOky (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 09:40:54 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C2B01FCCF;
        Tue, 15 Nov 2022 06:40:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E488A617D2;
        Tue, 15 Nov 2022 14:40:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 498EEC433D6;
        Tue, 15 Nov 2022 14:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668523252;
        bh=tdOVhDzSZ5XpNzRfzXTMWRYvcJkVvDoiknCPxpwBlwI=;
        h=From:To:Cc:Subject:Date:From;
        b=hTNobZL8u/a5/wx3FwlAD+koJZ+rozFrtBXSZ1niM4JNhb0YpuH8sv8RbLJpwABf1
         N67nTEK0wuc0EgfJuCNswZBfNZZ7WJULePeWk8mqBKhm68JwiKSZ7cwmdp9+CjZuwB
         X4uCAcWwmebqJyo6CCQ4cBCkv2BGOru+LeKP11aNWpZkq9Db+Duno+Vz5WspYLRa2e
         I/JAlvwbH5GXkKRu1hmyw3h4EALGO7ASxu6wMuRrQ0XopnY3bwiaiU0XXIwAZhB0PO
         q/dmaU39q7A432vE6qbe6/itgq8s28VbkYC7y/eDYShd+HVjRPF3iIMcBahAhqCu3/
         LOFbb4c2WOvdA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1oux6r-0000fE-QI; Tue, 15 Nov 2022 15:40:22 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH v2 00/15] phy: qcom-qmp-combo: fix sc8280xp binding (set 3/3)
Date:   Tue, 15 Nov 2022 15:39:50 +0100
Message-Id: <20221115144005.2478-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.37.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series fixes the USB-DP PHY devicetree binding for SC8280XP and
adds support for the new updated binding to the driver.

As the full series including the preparatory parts is over forty patches
and I've been posting this in three parts of which this is the last one.
In an effort to get all of these into 6.2, I've also submitted all three
series before waiting for the previous ones to be applied. Parts one and
two can be found here:

  https://lore.kernel.org/lkml/20221114081346.5116-1-johan+linaro@kernel.org/
  https://lore.kernel.org/lkml/20221114110621.4639-1-johan+linaro@kernel.org/

This last series adds a new binding for SC8280XP that drops the legacy
child node and the (incomplete) description of register subregions.

As the current bindings are both incomplete and incorrect it may be
a good idea to update also the other platforms currently supported by
this driver to the new binding scheme. The driver can support both
schemes during a transition period before removing the corresponding
code (dt parsing and clock-provider registration).

Johan


Changes in v2:
 - drop quotes from old DT schema $id and $schema (Krzysztof)
 - drop clock-output-names from new binding (Krzysztof)
 - add QMP clock and PHY index constants in a new header
 - drop patch moving clock registration before runtime PM enable (Dmitry)
 - include also the corresponding dts changes


Johan Hovold (15):
  dt-bindings: phy: qcom,qmp-usb3-dp: rename current bindings
  dt-bindings: phy: qcom,qmp-usb3-dp: fix sc8280xp binding
  phy: qcom-qmp-combo: drop v4 reference-clock source
  phy: qcom-qmp-combo: restructure PHY creation
  phy: qcom-qmp-combo: generate pipe clock name
  phy: qcom-qmp-combo: drop redundant clock structure
  phy: qcom-qmp-combo: drop redundant clock allocation
  phy: qcom-qmp-combo: add clock registration helper
  phy: qcom-qmp-combo: separate clock and provider registration
  phy: qcom-qmp-combo: clean up DP clock callbacks
  phy: qcom-qmp-combo: rename common-register pointers
  phy: qcom-qmp-combo: rename DP_PHY register pointer
  phy: qcom-qmp-combo: add support for updated sc8280xp binding
  arm64: dts: qcom: sc8280xp: fix primary USB-DP PHY reset
  arm64: dts: qcom: sc8280xp: fix USB-DP PHY nodes

 ....yaml => qcom,sc7180-qmp-usb3-dp-phy.yaml} |  25 +-
 .../phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml    |  99 ++++
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi        |  79 +--
 drivers/phy/qualcomm/phy-qcom-qmp-combo.c     | 530 +++++++++++-------
 include/dt-bindings/phy/phy-qcom-qmp.h        |  20 +
 5 files changed, 473 insertions(+), 280 deletions(-)
 rename Documentation/devicetree/bindings/phy/{qcom,qmp-usb3-dp-phy.yaml => qcom,sc7180-qmp-usb3-dp-phy.yaml} (91%)
 create mode 100644 Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml
 create mode 100644 include/dt-bindings/phy/phy-qcom-qmp.h

-- 
2.37.4

