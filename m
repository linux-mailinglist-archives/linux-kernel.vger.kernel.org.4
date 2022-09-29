Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 730AC5EF20B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 11:30:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235700AbiI2JaV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 05:30:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234907AbiI2J31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 05:29:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8214914597A;
        Thu, 29 Sep 2022 02:29:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1D732B823E4;
        Thu, 29 Sep 2022 09:29:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51153C43151;
        Thu, 29 Sep 2022 09:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664443763;
        bh=RCDMsqIFvGXQJyg4OyLTudRn8PZLhfXKmmKAniUA9x0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=e0itfTuGMYmuiVFXNUGerLKOSIVpupFDHlT988AY5P0O+aLVwDbnar88/o9vDD1wK
         c/dejAnfVMQ99m2H4INqKmq3yz2X8+iAo4XpqHpHP5EdeSMNwApCKUAos5uH1fUUEQ
         PJYWpxUuNLMue7eghJyLJ/zG6j55w3S0i+hXp0MEYYkMlHXBQn2uZRM7uLJL4duT1k
         x5SgTVeI9ZCBGiqlWgWIkBT0kqaxfnUpVwa2iBTHoaIhr5W25atvJo47Qr0/QfueRs
         DXd+QYImGu8ASCPujwLsL4/8q+2uWAUJwFkFwRKbVUN3qZwme2WSbdYfuCZRtHoMfv
         OFSS2AY7CzTMg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1odprF-00061T-Uc; Thu, 29 Sep 2022 11:29:29 +0200
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
Subject: [PATCH v2 06/11] phy: qcom-qmp-pcie-msm8996: clean up power-down handling
Date:   Thu, 29 Sep 2022 11:29:11 +0200
Message-Id: <20220929092916.23068-7-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220929092916.23068-1-johan+linaro@kernel.org>
References: <20220929092916.23068-1-johan+linaro@kernel.org>
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

This driver uses v2 registers only so drop the unnecessary
POWER_DOWN_CONTROL override.

Note that this register is already hard-coded when powering on the PHY.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp-pcie-msm8996.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie-msm8996.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie-msm8996.c
index d9646bf5dc91..1960bd0513e9 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie-msm8996.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie-msm8996.c
@@ -91,7 +91,6 @@ enum qphy_reg_layout {
 	QPHY_SW_RESET,
 	QPHY_START_CTRL,
 	QPHY_PCS_STATUS,
-	QPHY_PCS_POWER_DOWN_CONTROL,
 	/* Keep last to ensure regs_layout arrays are properly initialized */
 	QPHY_LAYOUT_SIZE
 };
@@ -591,13 +590,8 @@ static int qmp_pcie_msm8996_power_off(struct phy *phy)
 	qphy_clrbits(qphy->pcs, cfg->regs[QPHY_START_CTRL], cfg->start_ctrl);
 
 	/* Put PHY into POWER DOWN state: active low */
-	if (cfg->regs[QPHY_PCS_POWER_DOWN_CONTROL]) {
-		qphy_clrbits(qphy->pcs, cfg->regs[QPHY_PCS_POWER_DOWN_CONTROL],
-			     cfg->pwrdn_ctrl);
-	} else {
-		qphy_clrbits(qphy->pcs, QPHY_V2_PCS_POWER_DOWN_CONTROL,
-				cfg->pwrdn_ctrl);
-	}
+	qphy_clrbits(qphy->pcs, QPHY_V2_PCS_POWER_DOWN_CONTROL,
+			cfg->pwrdn_ctrl);
 
 	return 0;
 }
-- 
2.35.1

