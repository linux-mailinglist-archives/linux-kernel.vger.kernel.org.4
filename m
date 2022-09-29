Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FDD65EF1FB
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 11:29:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235356AbiI2J3b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 05:29:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234801AbiI2J3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 05:29:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E77E145964;
        Thu, 29 Sep 2022 02:29:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BEFA860EA4;
        Thu, 29 Sep 2022 09:29:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2259FC433D7;
        Thu, 29 Sep 2022 09:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664443763;
        bh=h3xjpWqHRExakkM4pHqF24mphBmdaIf2Jyk2LwyRhaY=;
        h=From:To:Cc:Subject:Date:From;
        b=lPnL5nMkEt2mxtK7jxqvzAuGW2bwlCZVoswtCsu+tekWV5kaOF3csLdF4ylij+BQ/
         zFNs06l/zwZG0QRl4niuE+gNM3x2WeTQkAwB9tkKCmujSAKTBn1/pkaov/o6Jw/SUP
         aDt5H33VjpDC3Cy5SdYyceUX1oH82pIopvwdSQUiw8N4B90zaqhgRtT6FX4bdGcc7r
         Mx21Pqog6P9/FNko4dl4/Et9oIxt/hWqyz4wjRc4AyCUH3dq2ZHzb8mMZkyf4qXKeH
         v1XDXe8vhOCEh1T4gxJ5Y0hX2ripy2GzUOwmF/IufZOQQsXbLeF7K5z0V3t0wNReeM
         j+6barLBkgtdw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1odprE-00061D-No; Thu, 29 Sep 2022 11:29:29 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH v2 00/11] phy: qcom-qmp: more fixes and cleanups
Date:   Thu, 29 Sep 2022 11:29:05 +0200
Message-Id: <20220929092916.23068-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

I've also moved the bogus register update last in case it turns out that
that one needs more discussion.

Johan


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
2.35.1

