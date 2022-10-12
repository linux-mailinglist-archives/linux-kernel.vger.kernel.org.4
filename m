Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A84DB5FC23B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 10:49:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbiJLItV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 04:49:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbiJLItT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 04:49:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BF6BB6025;
        Wed, 12 Oct 2022 01:49:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F3EF1B819D8;
        Wed, 12 Oct 2022 08:49:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B15CC433D7;
        Wed, 12 Oct 2022 08:49:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665564555;
        bh=xX5IVlc2R/KkmJrk54vJKvxJp0nawmXPvcm/+1PLy84=;
        h=From:To:Cc:Subject:Date:From;
        b=A7UpJexEM00HtjWf9H3Kub1GaCfU/eEw7juC8cPpgInLbEU4LRIkSmq0clCDZIwGV
         hQKGUElMySmxhwWHdtyQklvrxymE7TIOkzVPbkOdUZxeOliJZAqs8iRQqfdgyzbtCG
         9R4A7Q7hkh12O88YodyQuGztmmF1efs4AtH01hrmLQ4jA4NS0kkZVLuYYOl1U0J4AW
         KmRd8wc7837BN2zUisfPZMKzU7jtQKQBCjEkmbTIPGCK8K23c+2jCBogwIhq5mSdtL
         0A181nyJSzuX3cKRGQefuD9IW0hHF4f9JUzQNGPeTICU14mwtBAa9WNptLcLUEYse1
         BuSD4flefK/HA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1oiXQH-0006Fe-4S; Wed, 12 Oct 2022 10:49:05 +0200
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
Subject: [PATCH 00/20] phy: qcom-qmp: further prep fixes and cleanups (set 3)
Date:   Wed, 12 Oct 2022 10:48:46 +0200
Message-Id: <20221012084846.24003-1-johan+linaro@kernel.org>
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

Here's the next batch of QMP fixes and cleanups in preparation for
adding support for SC8280XP and its four-lane PCIe PHYs.

Note that these apply on top of the following three series that have
been reviewed and should be ready to be merged when the PHY tree opens:

	https://lore.kernel.org/lkml/20220929092916.23068-1-johan+linaro@kernel.org/
	https://lore.kernel.org/linux-phy/20220927092207.161501-1-dmitry.baryshkov@linaro.org/
	https://lore.kernel.org/lkml/20221012081241.18273-1-johan+linaro@kernel.org/

Note that I did not add stable tags to the initialisation fixes as these
drivers obviously work to some degree also without waiting for the PHY
to become ready during power on. After they have been tested on the
corresponding platforms, any interested party can ask the stable team to
backport them.

Johan


Johan Hovold (20):
  phy: qcom-qmp-pcie: fix sc8180x initialisation
  phy: qcom-qmp-pcie: fix ipq8074-gen3 initialisation
  phy: qcom-qmp-pcie: fix ipq6018 initialisation
  phy: qcom-qmp-pcie: clean up status polling
  phy: qcom-qmp-pcie: increase status polling period
  phy: qcom-qmp-pcie-msm8996: clean up ready and status polling
  phy: qcom-qmp-pcie-msm8996: increase status polling period
  phy: qcom-qmp-combo: clean up status polling
  phy: qcom-qmp-combo: increase status polling period
  phy: qcom-qmp-ufs: drop unused phy-status config
  phy: qcom-qmp-ufs: clean up ready polling
  phy: qcom-qmp-ufs: increase ready polling period
  phy: qcom-qmp-usb: clean up status polling
  phy: qcom-qmp-usb: increase status polling period
  phy: qcom-qmp-combo: drop start and pwrdn-ctrl abstraction
  phy: qcom-qmp-pcie: drop start-ctrl abstraction
  phy: qcom-qmp-pcie: add config sanity checks
  phy: qcom-qmp-pcie-msm8996: drop start and pwrdn-ctrl abstraction
  phy: qcom-qmp-ufs: drop start and pwrdn-ctrl abstraction
  phy: qcom-qmp-usb: drop start and pwrdn-ctrl abstraction

 drivers/phy/qualcomm/phy-qcom-qmp-combo.c     | 43 ++--------
 .../phy/qualcomm/phy-qcom-qmp-pcie-msm8996.c  | 36 +++-----
 drivers/phy/qualcomm/phy-qcom-qmp-pcie.c      | 30 +++----
 drivers/phy/qualcomm/phy-qcom-qmp-ufs.c       | 51 ++---------
 drivers/phy/qualcomm/phy-qcom-qmp-usb.c       | 86 ++-----------------
 5 files changed, 46 insertions(+), 200 deletions(-)

-- 
2.35.1

