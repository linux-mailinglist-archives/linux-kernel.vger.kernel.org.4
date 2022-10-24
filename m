Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45CE2609EB0
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 12:07:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230478AbiJXKHj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 06:07:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230307AbiJXKHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 06:07:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41CAB419B7;
        Mon, 24 Oct 2022 03:07:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id ABFC4B810B2;
        Mon, 24 Oct 2022 10:07:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47F56C433D7;
        Mon, 24 Oct 2022 10:07:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666606023;
        bh=tayFJ0zIpPNVGZUS4cmjEbiTrP4owsq5Yv1fDhHyyaw=;
        h=From:To:Cc:Subject:Date:From;
        b=P27ZWaZc7pD/HNh+mXLuYd+iczelBbxiLYrr5IUhsIficy7b9a872+jD9L/bpvs/9
         piRKbdlTvxXII2s5JRjJIdWMrZV6rQ/x5ijtAkgZjK2lXplPGnkqhhCyFWW6t8lsqQ
         vSpnx79dTcJTebFCzWkdavI2oCK4HrPDKrqGRK+I2isw6GP9Yq/0UPeV9IShCB0b7y
         r826F5thtFSdAGG/k3j6fcS1KnKUoQQaouGmB+oi1lTUUYGvujbO3UaT33KQaHc/dM
         MeliJ9GXdfbN2UYM7icHdxs5XN9rl9Chlx/5Et1nEyitqPFEdyD1FGMKke50KHJRLX
         KsyIrGtc4N/0g==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1omuM2-0005M4-KK; Mon, 24 Oct 2022 12:06:46 +0200
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
Subject: [PATCH 00/13] phy: qcom-qmp-usb: fix sc8280xp binding
Date:   Mon, 24 Oct 2022 12:06:19 +0200
Message-Id: <20221024100632.20549-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series fixes the USB PHY devicetree binding for SC8280XP and adds
support for the new updated binding to the driver.

The first half of the series clean up the driver in preparation for
supporting SC8280XP and its new binding that drops the legacy child node
and the (incomplete) description of register subregions.

The other QMP bindings suffer from similar problems and the PCIe and UFS
drivers are being fixed here:

        https://lore.kernel.org/lkml/20221021110947.28103-1-johan+linaro@kernel.org/
	https://lore.kernel.org/lkml/20221024090041.19574-1-johan+linaro@kernel.org/

and a follow-on series will do corresponding changes to the combo QMP
bindings and driver.

Note that these patches depend on the linux-phy next branch of today and
the following two series:

 1. [PATCH v2 00/14] phy: qcom-qmp: further prep cleanups

    https://lore.kernel.org/lkml/20221012081241.18273-1-johan+linaro@kernel.org

 2. [PATCH 00/20] phy: qcom-qmp: further prep fixes and cleanups (set 3)

    https://lore.kernel.org/lkml/20221012084846.24003-1-johan+linaro@kernel.org

Johan


Johan Hovold (13):
  phy: qcom-qmp-usb: fix sc8280xp PCS_USB offset
  phy: qcom-qmp-usb: sort device-id table
  phy: qcom-qmp-usb: move device-id table
  phy: qcom-qmp-usb: move pm ops
  phy: qcom-qmp-usb: merge driver data
  phy: qcom-qmp-usb: clean up device-tree parsing
  phy: qcom-qmp-usb: clean up probe initialisation
  phy: qcom-qmp-usb: rename PHY ops structure
  phy: qcom-qmp-usb: clean up PHY init
  dt-bindings: phy: qcom,qmp-usb: rename current bindings
  dt-bindings: phy: qcom,qmp-usb: fix sc8280xp binding
  phy: qcom-qmp-usb: restructure PHY creation
  phy: qcom-qmp-usb: add support for updated sc8280xp binding

 ...phy.yaml => qcom,msm8996-qmp-usb-phy.yaml} |  20 +-
 .../phy/qcom,sc8280xp-qmp-usb-phy.yaml        | 105 ++++
 drivers/phy/qualcomm/phy-qcom-qmp-usb.c       | 532 +++++++++---------
 3 files changed, 368 insertions(+), 289 deletions(-)
 rename Documentation/devicetree/bindings/phy/{qcom,qmp-usb-phy.yaml => qcom,msm8996-qmp-usb-phy.yaml} (95%)
 create mode 100644 Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb-phy.yaml

-- 
2.37.3

