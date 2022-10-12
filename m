Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A6145FC25E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 10:51:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbiJLIvW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 04:51:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbiJLIum (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 04:50:42 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E2CB75FF7;
        Wed, 12 Oct 2022 01:50:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 04AD5B819DC;
        Wed, 12 Oct 2022 08:50:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B86FCC433D6;
        Wed, 12 Oct 2022 08:50:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665564638;
        bh=7PZIvZJARdmCtef9Yrh3b79tw5ZWMrA9yRcUuFC5Uvg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EdV7Iw05dE5rDpyNdEr3NB0qjNnJLE3htrlqLGOeVpNnfvUtCPlvWwqOVFddbQ+YW
         iajx+O3zkB3UwgdRy3lkoVaE5QBJPRU1FPHTRDmSjiQ+yo+ii+RrxtaOaXzWLzvRXw
         6+NzNWa5RhewcBhAr/3QTKjDIHy4NgArV1OlTzZ+vFzUu1NojxmVMEwgx1cX4pdBer
         SI1AnKBMy9No2ZTVPKTNx1BgIEys6mXjDC9DXaK9mVdTNYm78XDxcyeiRa6xvZjeUK
         q3CSnWCGCGYww/CGiQ+d8jFkrLWHhOA6Xz4nbjap452A1o7nnsf/sLQk7zWiOwC60a
         wTFfbuL9kvgYA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1oiXRe-0006HX-2X; Wed, 12 Oct 2022 10:50:30 +0200
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
Subject: [PATCH 01/20] phy: qcom-qmp-pcie: fix sc8180x initialisation
Date:   Wed, 12 Oct 2022 10:49:43 +0200
Message-Id: <20221012085002.24099-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221012084846.24003-1-johan+linaro@kernel.org>
References: <20221012084846.24003-1-johan+linaro@kernel.org>
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

The phy_status mask was never set for SC8180X which meant that the
driver would not wait for the PHY to be initialised during power-on and
would never detect PHY initialisation timeouts.

Fixes: f839f14e24f2 ("phy: qcom-qmp: Add sc8180x PCIe support")
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp-pcie.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
index 151baa63e8e8..a7677b61f96e 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
@@ -1733,6 +1733,7 @@ static const struct qmp_phy_cfg sc8180x_pciephy_cfg = {
 
 	.start_ctrl		= PCS_START | SERDES_START,
 	.pwrdn_ctrl		= SW_PWRDN | REFCLK_DRV_DSBL,
+	.phy_status		= PHYSTATUS,
 };
 
 static const struct qmp_phy_cfg sdx55_qmp_pciephy_cfg = {
-- 
2.35.1

