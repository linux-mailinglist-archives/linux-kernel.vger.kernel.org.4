Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC6BD6116F1
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 18:07:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229473AbiJ1QHC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 12:07:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230287AbiJ1QFz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 12:05:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E069B659D3;
        Fri, 28 Oct 2022 09:05:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7B18762950;
        Fri, 28 Oct 2022 16:05:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 975E1C4347C;
        Fri, 28 Oct 2022 16:05:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666973109;
        bh=zMsqR4NCaF15rnmf8tGTZpGv/GOwk0U5elPPfgDilzc=;
        h=From:To:Cc:Subject:Date:From;
        b=RA510jvmZ8L122s0NFLJGM8/PHg6Vnxygzvi59838JAxosslWRpcpLX0dr/0A21oR
         Ih5qsaUR5TBTSXglSgeTw0CFZjarBRkxP4AByZEsouyaepzqamqbcFgoUlRDbIJZK3
         l18qB7+tQcY9nwUu/Id+UXlx/RiSYrPlkFKgiEdEMkh5P1mCQusIY23Yj/EzHsfhEN
         6x22dJOpDlEzAESmlvxaVaTOXCyepRJ82L6qYGKvOMVzxneTJOwM7U0+AWJp1TOgDJ
         nqp1My8ZVgkNF7TfUD4qNlzkQDPz6IZJRStj+m7OF9WQ70SW6uKih2vpFaHtm+D8ls
         76qNnUDzgoS0A==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1ooRqp-00071S-Kp; Fri, 28 Oct 2022 18:04:55 +0200
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
Subject: [PATCH RESEND v2 00/13] phy: qcom-qmp-usb: fix sc8280xp binding
Date:   Fri, 28 Oct 2022 18:04:22 +0200
Message-Id: <20221028160435.26948-1-johan+linaro@kernel.org>
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

[ Resending with devicetree list on CC ]

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

Note that these patches depend on the linux-phy next branch of today.

Johan


Changes in v2
 - add missing "3" to current bindings file name
   "qcom,msm8996-qmp-usb3-phy.yaml" to match compatible
 - add missing "-uni" infix to new bindings file name
   "qcom,sc8280xp-qmp-usb3-uni-phy.yaml" to match compatible (Krzysztof)


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

 ...hy.yaml => qcom,msm8996-qmp-usb3-phy.yaml} |  20 +-
 .../phy/qcom,sc8280xp-qmp-usb3-uni-phy.yaml   | 105 ++++
 drivers/phy/qualcomm/phy-qcom-qmp-usb.c       | 532 +++++++++---------
 3 files changed, 368 insertions(+), 289 deletions(-)
 rename Documentation/devicetree/bindings/phy/{qcom,qmp-usb-phy.yaml => qcom,msm8996-qmp-usb3-phy.yaml} (95%)
 create mode 100644 Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb3-uni-phy.yaml

-- 
2.37.3

