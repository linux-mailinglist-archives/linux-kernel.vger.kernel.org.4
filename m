Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 677BD5EF205
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 11:30:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235494AbiI2J3v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 05:29:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234919AbiI2J30 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 05:29:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0153E145C97;
        Thu, 29 Sep 2022 02:29:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5FF2F60EC4;
        Thu, 29 Sep 2022 09:29:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56F53C43153;
        Thu, 29 Sep 2022 09:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664443763;
        bh=LaAaPBlm6yRSR9iwlubpTa3EtE2ekh7akXEXvlkB+UE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AS+L1l26/t587fC0ejCa59UXyeNiar3TCgzSWscgRcn335Ajqc3aQtjcEKlhXplfy
         CmUEWr6vcd04BTWbDF/rBrmwrLQOJFjlIQSPInhYrIAH1yfJ8Ne9x8VRmak/Lb0D4n
         I6hCVkajdWinxhSdPBeGiLB1REBhEPXIHr0C6C3CJYgsk+bl8tYORgVMTIPEQsECqb
         +VfepB6YdLgep08HiIQf7XU4yDrFReNF5hL4+5sUgcZmtSxGFb00dZglXKnysnuNfy
         KlN9NdScoyndc/7qEh+qBwwRtncYTLOKvga58RRnOQqOR6sBILGGHirshxq9Z9RET7
         7VWi595KhdoRg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1odprF-00061M-PD; Thu, 29 Sep 2022 11:29:29 +0200
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
Subject: [PATCH v2 04/11] phy: qcom-qmp-pcie: clean up power-down handling
Date:   Thu, 29 Sep 2022 11:29:09 +0200
Message-Id: <20220929092916.23068-5-johan+linaro@kernel.org>
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

Always define the POWER_DOWN_CONTROL register instead of falling back to
the v2 offset during power on and power off.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp-pcie.c | 21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
index c9330b0f0fcf..efffb77e8f45 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
@@ -97,18 +97,21 @@ static const unsigned int pciephy_regs_layout[QPHY_LAYOUT_SIZE] = {
 	[QPHY_SW_RESET]			= 0x00,
 	[QPHY_START_CTRL]		= 0x08,
 	[QPHY_PCS_STATUS]		= 0x174,
+	[QPHY_PCS_POWER_DOWN_CONTROL]	= 0x04,
 };
 
 static const unsigned int sdm845_qmp_pciephy_regs_layout[QPHY_LAYOUT_SIZE] = {
 	[QPHY_SW_RESET]			= 0x00,
 	[QPHY_START_CTRL]		= 0x08,
 	[QPHY_PCS_STATUS]		= 0x174,
+	[QPHY_PCS_POWER_DOWN_CONTROL]	= 0x04,
 };
 
 static const unsigned int sdm845_qhp_pciephy_regs_layout[QPHY_LAYOUT_SIZE] = {
 	[QPHY_SW_RESET]			= 0x00,
 	[QPHY_START_CTRL]		= 0x08,
 	[QPHY_PCS_STATUS]		= 0x2ac,
+	[QPHY_PCS_POWER_DOWN_CONTROL]	= 0x04,
 };
 
 static const unsigned int sm8250_pcie_regs_layout[QPHY_LAYOUT_SIZE] = {
@@ -1885,13 +1888,8 @@ static int qmp_pcie_init(struct phy *phy)
 	if (ret)
 		goto err_assert_reset;
 
-	if (cfg->regs[QPHY_PCS_POWER_DOWN_CONTROL])
-		qphy_setbits(pcs,
-				cfg->regs[QPHY_PCS_POWER_DOWN_CONTROL],
-				cfg->pwrdn_ctrl);
-	else
-		qphy_setbits(pcs, QPHY_V2_PCS_POWER_DOWN_CONTROL,
-				cfg->pwrdn_ctrl);
+	qphy_setbits(pcs, cfg->regs[QPHY_PCS_POWER_DOWN_CONTROL],
+			cfg->pwrdn_ctrl);
 
 	return 0;
 
@@ -2014,13 +2012,8 @@ static int qmp_pcie_power_off(struct phy *phy)
 	qphy_clrbits(qphy->pcs, cfg->regs[QPHY_START_CTRL], cfg->start_ctrl);
 
 	/* Put PHY into POWER DOWN state: active low */
-	if (cfg->regs[QPHY_PCS_POWER_DOWN_CONTROL]) {
-		qphy_clrbits(qphy->pcs, cfg->regs[QPHY_PCS_POWER_DOWN_CONTROL],
-			     cfg->pwrdn_ctrl);
-	} else {
-		qphy_clrbits(qphy->pcs, QPHY_V2_PCS_POWER_DOWN_CONTROL,
-				cfg->pwrdn_ctrl);
-	}
+	qphy_clrbits(qphy->pcs, cfg->regs[QPHY_PCS_POWER_DOWN_CONTROL],
+			cfg->pwrdn_ctrl);
 
 	return 0;
 }
-- 
2.35.1

