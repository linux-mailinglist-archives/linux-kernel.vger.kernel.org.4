Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71DCE5FC269
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 10:52:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbiJLIvw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 04:51:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbiJLIun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 04:50:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F15DA760CF;
        Wed, 12 Oct 2022 01:50:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3479DB819A3;
        Wed, 12 Oct 2022 08:50:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3590C43145;
        Wed, 12 Oct 2022 08:50:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665564638;
        bh=9nyAGS5QAzmJUhzuVdKVAvXKjrOv/M19QeLWUbmPdwI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OtXw83vhPnrgJMAyL+SdHSyFTGvWKsmKw8gKPIfn7csDAafTGrNsj+o+u+iC74MXB
         Umk+vzAJmqCZ9jPX2ewD9YAaMJRVTSyxdmzwSbdu+aKJMcNUfpz1rKNuhWIhLLhICB
         lCFt2X5uMPUbv01OxK8jGuYX4/pgCNv+5+u2UnSNwVPLGDdZk5b+00/qVo14YcYl8Y
         p7olFpsqr2mL3UPa5MsvQv7zUstgaZSPk8uj1+w4pedu09gEexrePIknKOvg+nt8dS
         5fecTzq/4TwLxlS2RsapkhK3oti7qCbzx+nM8AYqV1nP9p1xSiXQRbrTdHkn0aPijI
         AulpAd5g2jKGQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1oiXRe-0006Hj-Ih; Wed, 12 Oct 2022 10:50:30 +0200
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
Subject: [PATCH 06/20] phy: qcom-qmp-pcie-msm8996: clean up ready and status polling
Date:   Wed, 12 Oct 2022 10:49:48 +0200
Message-Id: <20221012085002.24099-6-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221012085002.24099-1-johan+linaro@kernel.org>
References: <20221012084846.24003-1-johan+linaro@kernel.org>
 <20221012085002.24099-1-johan+linaro@kernel.org>
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

Clean up the PHY ready and status polling by dropping the configuration
masks which are no longer needed since the QMP driver split.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 .../phy/qualcomm/phy-qcom-qmp-pcie-msm8996.c  | 19 ++++---------------
 1 file changed, 4 insertions(+), 15 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie-msm8996.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie-msm8996.c
index 899be7bd4d92..b9260c8746bf 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie-msm8996.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie-msm8996.c
@@ -35,7 +35,6 @@
 #define PLL_READY_GATE_EN			BIT(3)
 /* QPHY_PCS_STATUS bit */
 #define PHYSTATUS				BIT(6)
-#define PHYSTATUS_4_20				BIT(7)
 /* QPHY_COM_PCS_READY_STATUS bit */
 #define PCS_READY				BIT(0)
 
@@ -200,9 +199,6 @@ struct qmp_phy_cfg {
 
 	unsigned int start_ctrl;
 	unsigned int pwrdn_ctrl;
-	unsigned int mask_com_pcs_ready;
-	/* bit offset of PHYSTATUS in QPHY_PCS_STATUS register */
-	unsigned int phy_status;
 };
 
 /**
@@ -318,8 +314,6 @@ static const struct qmp_phy_cfg msm8996_pciephy_cfg = {
 
 	.start_ctrl		= PCS_START | PLL_READY_GATE_EN,
 	.pwrdn_ctrl		= SW_PWRDN | REFCLK_DRV_DSBL,
-	.mask_com_pcs_ready	= PCS_READY,
-	.phy_status		= PHYSTATUS,
 };
 
 static void qmp_pcie_msm8996_configure_lane(void __iomem *base,
@@ -356,7 +350,7 @@ static int qmp_pcie_msm8996_serdes_init(struct qmp_phy *qphy)
 	const struct qmp_phy_init_tbl *serdes_tbl = cfg->serdes_tbl;
 	int serdes_tbl_num = cfg->serdes_tbl_num;
 	void __iomem *status;
-	unsigned int mask, val;
+	unsigned int val;
 	int ret;
 
 	qmp_pcie_msm8996_configure(serdes, serdes_tbl, serdes_tbl_num);
@@ -366,9 +360,7 @@ static int qmp_pcie_msm8996_serdes_init(struct qmp_phy *qphy)
 		     SERDES_START | PCS_START);
 
 	status = serdes + cfg->regs[QPHY_COM_PCS_READY_STATUS];
-	mask = cfg->mask_com_pcs_ready;
-
-	ret = readl_poll_timeout(status, val, (val & mask), 10,
+	ret = readl_poll_timeout(status, val, (val & PCS_READY), 10,
 				 PHY_INIT_COMPLETE_TIMEOUT);
 	if (ret) {
 		dev_err(qmp->dev,
@@ -484,7 +476,7 @@ static int qmp_pcie_msm8996_power_on(struct phy *phy)
 	void __iomem *rx = qphy->rx;
 	void __iomem *pcs = qphy->pcs;
 	void __iomem *status;
-	unsigned int mask, val, ready;
+	unsigned int val;
 	int ret;
 
 	qmp_pcie_msm8996_serdes_init(qphy);
@@ -522,10 +514,7 @@ static int qmp_pcie_msm8996_power_on(struct phy *phy)
 	qphy_setbits(pcs, cfg->regs[QPHY_START_CTRL], cfg->start_ctrl);
 
 	status = pcs + cfg->regs[QPHY_PCS_STATUS];
-	mask = cfg->phy_status;
-	ready = 0;
-
-	ret = readl_poll_timeout(status, val, (val & mask) == ready, 10,
+	ret = readl_poll_timeout(status, val, !(val & PHYSTATUS), 10,
 				 PHY_INIT_COMPLETE_TIMEOUT);
 	if (ret) {
 		dev_err(qmp->dev, "phy initialization timed-out\n");
-- 
2.35.1

