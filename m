Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ED986006DC
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 08:50:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbiJQGus (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 02:50:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbiJQGun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 02:50:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF68B543FA;
        Sun, 16 Oct 2022 23:50:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5E08160A48;
        Mon, 17 Oct 2022 06:50:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7160C433D7;
        Mon, 17 Oct 2022 06:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665989440;
        bh=umU0smwpPoIhb97gIHRTbuFSz5PUSAh+Qs2wU0wsLvg=;
        h=From:To:Cc:Subject:Date:From;
        b=IWYHiCEZZKo+5781AsZfUm0qWSjBcNWuv6Z+R2mihZ1GvUGBU7NWDpiNtyDZ7+g7X
         8OIFTiL6EdgoMfbo5LmINyURAeNgd44Gfj0cn3+/BbEFJawpJPamfE4R/bIn/pNm3m
         52CmeNmNkoWn3MCe/3skvzr5L5e3opSNW8xxgQy+wfkiZzGbpAwSbB2Z+D5O54Q2ez
         nsqplWZ0gL0CftpfwE2dCYP5GMRoqQMt3Tj5Rym6/sh8s1nIK+CkmB106QF+rlhmLj
         me78MVKIVZCgEvTMLJ5nd0WQ1M5RlF4yAmfTrIW9bdKq6cFHbuR7LmqX/t30mpeyTp
         erzbdYmO7P0Mg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1okJxG-00057T-35; Mon, 17 Oct 2022 08:50:30 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH v3 00/11] phy: qcom-qmp: more fixes and cleanups (set 1)
Date:   Mon, 17 Oct 2022 08:50:02 +0200
Message-Id: <20221017065013.19647-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here's the next batch of QMP driver fixes and cleanups.

Dmitry suggested that the register layout structs could all be using
per-IP version defines, which in principle sounds like a good idea. It
is a separate change though, and one which would require some more work
as it is not always clear which IP version a specific SoC uses (e.g.
some of the IPQ platforms appear to mix and match currently).

As such a change shouldn't block these clean ups, I've dropped the
merging of the IPQ SDM845 PCIe layout structs in v2.

Note that v3 has been rebased on the PCIe EP/RC-mode series to avoid two
minor conflicts:

	https://lore.kernel.org/linux-phy/20220927092207.161501-1-dmitry.baryshkov@linaro.org/

Johan


Changes in v3
 - rebase on "[PATCH v6 0/5] PCI: qcom: Support using the same PHY for
   both RC and EP" to avoid two minor conflicts

Changes in v2
 - drop the two patches that dropped the IPC and SDM845 PCIe layout
   structs
 - move the bogus register fix last in case this one needs some more
   discussion

Johan Hovold (11):
  phy: qcom-qmp: fix obsolete lane comments
  phy: qcom-qmp-combo: drop unused UFS reset
  phy: qcom-qmp-pcie: drop unused common-block registers
  phy: qcom-qmp-pcie: clean up power-down handling
  phy: qcom-qmp-pcie: move power-down update
  phy: qcom-qmp-pcie-msm8996: clean up power-down handling
  phy: qcom-qmp-combo: clean up power-down handling
  phy: qcom-qmp-ufs: clean up power-down handling
  phy: qcom-qmp-usb: clean up power-down handling
  phy: qcom-qmp-pcie: clean up clock lists
  phy: qcom-qmp-pcie: drop bogus register update

 drivers/phy/qualcomm/phy-qcom-qmp-combo.c     | 30 +++---------
 .../phy/qualcomm/phy-qcom-qmp-pcie-msm8996.c  | 12 ++---
 drivers/phy/qualcomm/phy-qcom-qmp-pcie.c      | 49 +++++--------------
 drivers/phy/qualcomm/phy-qcom-qmp-ufs.c       | 24 ++++-----
 drivers/phy/qualcomm/phy-qcom-qmp-usb.c       | 22 +++------
 5 files changed, 38 insertions(+), 99 deletions(-)

-- 
2.37.3

