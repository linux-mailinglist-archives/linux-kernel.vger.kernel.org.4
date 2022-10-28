Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 477ED611319
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 15:38:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231236AbiJ1NiO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 09:38:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231124AbiJ1Ngy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 09:36:54 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36A151D8F33;
        Fri, 28 Oct 2022 06:36:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E2F04B82A33;
        Fri, 28 Oct 2022 13:36:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C96FC43151;
        Fri, 28 Oct 2022 13:36:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666964209;
        bh=zRz+xGr3qfzBHmqhYcHtUOAO+a77B5PUV9OisEOT424=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NGwjL6BUqzf4qmUkH5RKP2HzYrjJv+TeCLW0MnsOPLlWz8BcrM7/qzpl90OjOoPnr
         3KmQGEfbkHOh4x341ygFqo14frXR4VD/rFF+f3CBqxKWgHLi6lty6eCugeOBEb+vLW
         Zvb3FVE+EcnNWnwvBfVvIWcN7+hLiQhMVvj/bT7XkTw2NOcu6H/Pwvwkl6IjRdr+T1
         BXHPddWl2wPREB1TZi41kLvK47s7oQOA0CpYyxYdRls2adqEM6dhw1N8tGrtleghOf
         Yhi3HNR3Njl5h4G5hqQpCc7xyLCK6cXXrDv4E8DECLnf+oe24SnYa3JcCQW9rNfFib
         qO6cPomTiBsLg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1ooPXH-0004rG-Hw; Fri, 28 Oct 2022 15:36:35 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH v4 09/16] phy: qcom-qmp-pcie: add register init helper
Date:   Fri, 28 Oct 2022 15:35:56 +0200
Message-Id: <20221028133603.18470-10-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221028133603.18470-1-johan+linaro@kernel.org>
References: <20221028133603.18470-1-johan+linaro@kernel.org>
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

Generalise the serdes initialisation helper so that it can be used to
initialise all the PHY registers (e.g. serdes, tx, rx, pcs).

Note that this defers the ungating of the PIPE clock somewhat, which is
fine as it isn't needed until starting the PHY.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp-pcie.c | 37 +++++-------------------
 1 file changed, 8 insertions(+), 29 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
index 791ed7ef0eab..f57d10f20277 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
@@ -1820,27 +1820,22 @@ static void qmp_pcie_configure(void __iomem *base,
 	qmp_pcie_configure_lane(base, tbl, num, 0xff);
 }
 
-static void qmp_pcie_serdes_init(struct qmp_pcie *qmp, const struct qmp_phy_cfg_tables *tbls)
-{
-	void __iomem *serdes = qmp->serdes;
-
-	if (!tbls)
-		return;
-
-	qmp_pcie_configure(serdes, tbls->serdes, tbls->serdes_num);
-}
-
-static void qmp_pcie_lanes_init(struct qmp_pcie *qmp, const struct qmp_phy_cfg_tables *tbls)
+static void qmp_pcie_init_registers(struct qmp_pcie *qmp, const struct qmp_phy_cfg_tables *tbls)
 {
 	const struct qmp_phy_cfg *cfg = qmp->cfg;
+	void __iomem *serdes = qmp->serdes;
 	void __iomem *tx = qmp->tx;
 	void __iomem *rx = qmp->rx;
 	void __iomem *tx2 = qmp->tx2;
 	void __iomem *rx2 = qmp->rx2;
+	void __iomem *pcs = qmp->pcs;
+	void __iomem *pcs_misc = qmp->pcs_misc;
 
 	if (!tbls)
 		return;
 
+	qmp_pcie_configure(serdes, tbls->serdes, tbls->serdes_num);
+
 	qmp_pcie_configure_lane(tx, tbls->tx, tbls->tx_num, 1);
 	qmp_pcie_configure_lane(rx, tbls->rx, tbls->rx_num, 1);
 
@@ -1848,15 +1843,6 @@ static void qmp_pcie_lanes_init(struct qmp_pcie *qmp, const struct qmp_phy_cfg_t
 		qmp_pcie_configure_lane(tx2, tbls->tx, tbls->tx_num, 2);
 		qmp_pcie_configure_lane(rx2, tbls->rx, tbls->rx_num, 2);
 	}
-}
-
-static void qmp_pcie_pcs_init(struct qmp_pcie *qmp, const struct qmp_phy_cfg_tables *tbls)
-{
-	void __iomem *pcs = qmp->pcs;
-	void __iomem *pcs_misc = qmp->pcs_misc;
-
-	if (!tbls)
-		return;
 
 	qmp_pcie_configure(pcs, tbls->pcs, tbls->pcs_num);
 	qmp_pcie_configure(pcs_misc, tbls->pcs_misc, tbls->pcs_misc_num);
@@ -1932,8 +1918,8 @@ static int qmp_pcie_power_on(struct phy *phy)
 	else
 		mode_tables = cfg->tables_ep;
 
-	qmp_pcie_serdes_init(qmp, &cfg->tables);
-	qmp_pcie_serdes_init(qmp, mode_tables);
+	qmp_pcie_init_registers(qmp, &cfg->tables);
+	qmp_pcie_init_registers(qmp, mode_tables);
 
 	ret = clk_prepare_enable(qmp->pipe_clk);
 	if (ret) {
@@ -1941,13 +1927,6 @@ static int qmp_pcie_power_on(struct phy *phy)
 		return ret;
 	}
 
-	/* Tx, Rx, and PCS configurations */
-	qmp_pcie_lanes_init(qmp, &cfg->tables);
-	qmp_pcie_lanes_init(qmp, mode_tables);
-
-	qmp_pcie_pcs_init(qmp, &cfg->tables);
-	qmp_pcie_pcs_init(qmp, mode_tables);
-
 	/* Pull PHY out of reset state */
 	qphy_clrbits(pcs, cfg->regs[QPHY_SW_RESET], SW_RESET);
 
-- 
2.37.3

