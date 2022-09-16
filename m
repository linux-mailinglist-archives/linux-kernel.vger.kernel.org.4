Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A57695BAB76
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 12:43:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229455AbiIPKnU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 06:43:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230463AbiIPKmn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 06:42:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 426D91CFEC;
        Fri, 16 Sep 2022 03:24:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BC45462A74;
        Fri, 16 Sep 2022 10:23:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B59AC433B5;
        Fri, 16 Sep 2022 10:23:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663323825;
        bh=ir7H0gZFvFgZNHyj7dRRRxwrCHWMLr07c5X1mE03c7s=;
        h=From:To:Cc:Subject:Date:From;
        b=IZzcj5R12OziQR5GgV4ebTz73/lF+Z55vsEIp8ULDxt5DMv7uDGMOGYKsQgZ2Gh3+
         ZTQOCzuW6k/uSMmlUDiicWmXQ43xsxvPSu7xlmME6xMSNlZexJ+/CJGxZjAqwpqqST
         yZna0gdrctLO2T4z0mVfcMrmDc5b+eSSlbgU+lSkGFcTo7wO+vZLC8LcWSs4oAeiu0
         W8gSFoB8cLeNKdm/dsuNbMEILcLG03Xf3GmxSAt9TlDTSWGzSxO83MsNAohG9H6yo+
         vRJC8rzIn49F5gGY4838MH6y37BdXUO20MSQ5Eu7wZzTXHLnx42ghMuEK86VFUyKpD
         WqvDVWm16NBYQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1oZ8Vh-00030L-EZ; Fri, 16 Sep 2022 12:23:50 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH v2 00/11] phy: qcom-qmp: more fixes and cleanups
Date:   Fri, 16 Sep 2022 12:23:29 +0200
Message-Id: <20220916102340.11520-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.35.1
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

Here's the next set of QMP PHY cleanups including some non-critical
fixes of tiny memory leaks on probe deferral (I didn't add a stable tag
for any of them on purpose).

Note that the UFS PHY driver does not use the pcs_misc region either
currently, but I decided to leave the register mapping code in as,
unlike for msm8996, the bindings do include this region.

These apply on top of the previous clean up series, which has been
reviewed by Dmitry and is ready to be merged (apart from possibly a tiny
fixup of the last patch):

	https://lore.kernel.org/all/20220907110728.19092-1-johan+linaro@kernel.org/

As mentioned in the individual commit messages, the memleak fixes
switches to using exclusive mappings for the device registers. When
reviewing the mainline devicetree I found four instances of incorrect
serdes region sizes which I've now fixed up. I don't think we need to
add workarounds for booting older malformed dtbs in this case, at least
not until someone complains.

As I also reported in a reply to v1:

	https://lore.kernel.org/lkml/YyRJuCnuUE+bF7RP@hovoldconsulting.com/

we do however have two USB PHY bindings that currently rely on
overlapping regions which would require some more work to be fixed up.

Specifically, the USB PHY driver uses two separate PCS regions but the
binding treats them as one and the driver ends up mapping everything in
between. This sort of works on all platforms but two where the TX and RX
regions lie in between.

The binding and driver should probably be fixed up to define this
PCS_USB region explicitly, but that work is left for another day.

Meanwhile, I've implemented a workaround that fall back to using
non-exclusive mappings for these platforms.

Johan


Changes in v2
 - fallback to non-exclusive mappings for the two USB bindings that
   currently rely on it (patch 6/11)


Johan Hovold (11):
  phy: qcom-qmp-pcie: add pcs_misc sanity check
  phy: qcom-qmp-pcie: fix memleak on probe deferral
  phy: qcom-qmp-pcie-msm8996: fix memleak on probe deferral
  phy: qcom-qmp-combo: fix memleak on probe deferral
  phy: qcom-qmp-ufs: fix memleak on probe deferral
  phy: qcom-qmp-usb: fix memleak on probe deferral
  phy: qcom-qmp-pcie-msm8996: drop unused pcs_misc handling
  phy: qcom-qmp-pcie: drop unused legacy DT workaround
  phy: qcom-qmp-combo: drop unused legacy DT workaround
  phy: qcom-qmp-ufs: drop legacy DT workaround
  phy: qcom-qmp-usb: drop legacy DT workaround

 drivers/phy/qualcomm/phy-qcom-qmp-combo.c     | 53 +++++-------
 .../phy/qualcomm/phy-qcom-qmp-pcie-msm8996.c  | 33 +++-----
 drivers/phy/qualcomm/phy-qcom-qmp-pcie.c      | 59 ++++++--------
 drivers/phy/qualcomm/phy-qcom-qmp-ufs.c       | 53 +++++-------
 drivers/phy/qualcomm/phy-qcom-qmp-usb.c       | 80 +++++++++++--------
 5 files changed, 117 insertions(+), 161 deletions(-)

-- 
2.35.1

