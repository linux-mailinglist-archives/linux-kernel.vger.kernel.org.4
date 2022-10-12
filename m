Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEFD45FC1BA
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 10:16:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbiJLIQG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 04:16:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbiJLIP5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 04:15:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 166255D0CE;
        Wed, 12 Oct 2022 01:15:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A30C66144F;
        Wed, 12 Oct 2022 08:15:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13322C433D6;
        Wed, 12 Oct 2022 08:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665562555;
        bh=Wvipar655653CcKkXzaYMDKLi1DlZcbfAXHSTb3rkMA=;
        h=From:To:Cc:Subject:Date:From;
        b=R9CKHVfAdz8ESb0YVEYS9BdppS+lexLZBMsFRc4ZdJ0mimPxL2FGs2zKP1ncOhKij
         4NsjRnylW+CA413LJwyzGsmYyuNmTG2Zkpnu5/N2lgVroAQO55+9bWCyynnKfOPW/1
         zHf6g/fCw6fdh1CiLVUvt+0Crw2X/ED9oeII/r7BvrEskNkUtFEU48rejkmiG6ZpcG
         oGFF8AglS74WYelsOAkK8BxjohqscflsikxWVH+fC6SR9h416dyIscdqU4UYfM5RO5
         tGq25csFvXfxwNCKAqVtJHKTZ4pCWXf53abfD2Sdm5K5CAV3nc9315S5Bty+CBJRMw
         bCA/pt4I/WtVQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1oiWu2-0004oK-4h; Wed, 12 Oct 2022 10:15:46 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH v2 00/14] phy: qcom-qmp: further prep cleanups
Date:   Wed, 12 Oct 2022 10:12:27 +0200
Message-Id: <20221012081241.18273-1-johan+linaro@kernel.org>
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

Here's the next batch of QMP cleanups in preparation for adding support
for SC8280XP and its four-lane PCIe PHYs.

Note that these apply on top of the following two series that have been
reviewed and should be ready to be merged when the PHY tree opens:

	https://lore.kernel.org/linux-arm-msm/20220929092916.23068-1-johan+linaro@kernel.org/
	https://lore.kernel.org/all/20220927092207.161501-1-dmitry.baryshkov@linaro.org/

After this I have one more series of related cleanups before posting the
SC8280XP support.

Johan


Changes in v2
 - move the 1 ms PCIe "power-down" delay to after starting the PHY which
   was probably the intention all along. This is done in a separate new
   patch 9/14. (Dmitry)


Johan Hovold (14):
  phy: qcom-qmp: drop regulator error message
  phy: qcom-qmp: drop superfluous comments
  phy: qcom-qmp-combo: drop unused in-layout configuration
  phy: qcom-qmp-pcie: drop redundant ipq8074 power on
  phy: qcom-qmp-pcie-msm8996: drop unused in-layout configuration
  phy: qcom-qmp-ufs: drop unused in-layout configuration
  phy: qcom-qmp-usb: drop unused in-layout configuration
  phy: qcom-qmp-pcie: drop power-down delay config
  phy: qcom-qmp-pcie: replace power-down delay
  phy: qcom-qmp-pcie-msm8996: drop power-down delay config
  phy: qcom-qmp-combo: drop sc8280xp power-down delay
  phy: qcom-qmp-combo: drop power-down delay config
  phy: qcom-qmp-usb: drop sc8280xp power-down delay
  phy: qcom-qmp-usb: drop power-down delay config

 drivers/phy/qualcomm/phy-qcom-qmp-combo.c     |  81 +++----------
 .../phy/qualcomm/phy-qcom-qmp-pcie-msm8996.c  |  55 ++-------
 drivers/phy/qualcomm/phy-qcom-qmp-pcie.c      | 106 +++---------------
 drivers/phy/qualcomm/phy-qcom-qmp-ufs.c       |  48 ++------
 drivers/phy/qualcomm/phy-qcom-qmp-usb.c       |  89 ++-------------
 5 files changed, 64 insertions(+), 315 deletions(-)

-- 
2.35.1

