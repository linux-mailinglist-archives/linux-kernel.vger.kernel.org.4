Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B052C61DB6D
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 16:03:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbiKEPDK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Nov 2022 11:03:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229828AbiKEPCx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Nov 2022 11:02:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D283F10574;
        Sat,  5 Nov 2022 08:02:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6EFBB60AF0;
        Sat,  5 Nov 2022 15:02:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CDFDC4315F;
        Sat,  5 Nov 2022 15:02:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667660570;
        bh=oVZOTzq45reHyMUZv3CzKzfVdLviOUal1dPut+RcE50=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dpzR3cQojso4N00J1Jx18hOHXzZGo4acBogaoMKYI5uvDVmeSLUWm3uR9BuZ/3LJc
         j3wzbR9AVrIZH+yNhahBHwDUbrs9YOaO2lM2J2zIw8jQoPI5Udq3mOPqo63R2AA04o
         7hPIwu5quonuQqp5LIh6JNg95HypYb+gGBbDbLp1wMWaQtddUyyrLW+2SNFzQSeNN8
         +LS9a3xiwnFC1qriAtr5SBmnz8l3knXllzafLOQzQ4g6fxB9wutDFNsxmkeATsyUVr
         te5laE5Cw0gD4emE+cDIo9YmvUoskHcqjKQw0QSGxjqFiavoF01m/vBgQWvRFZcdCZ
         DAf6QEojcrzlA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1orKgp-0005Kd-FS; Sat, 05 Nov 2022 16:02:31 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [PATCH v5 09/16] phy: qcom-qmp-pcie: add register init helper
Date:   Sat,  5 Nov 2022 15:59:32 +0100
Message-Id: <20221105145939.20318-10-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.37.4
In-Reply-To: <20221105145939.20318-1-johan+linaro@kernel.org>
References: <20221105145939.20318-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp-pcie.c | 37 +++++-------------------
 1 file changed, 8 insertions(+), 29 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
index a977f2bbd831..09999d5b5268 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
@@ -1820,27 +1820,22 @@ static void qmp_pcie_configure(void __iomem *base,
 	qmp_pcie_configure_lane(base, tbl, num, 0xff);
 }
 
-static void qmp_pcie_serdes_init(struct qmp_pcie *qmp, const struct qmp_phy_cfg_tbls *tbls)
-{
-	void __iomem *serdes = qmp->serdes;
-
-	if (!tbls)
-		return;
-
-	qmp_pcie_configure(serdes, tbls->serdes, tbls->serdes_num);
-}
-
-static void qmp_pcie_lanes_init(struct qmp_pcie *qmp, const struct qmp_phy_cfg_tbls *tbls)
+static void qmp_pcie_init_registers(struct qmp_pcie *qmp, const struct qmp_phy_cfg_tbls *tbls)
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
-static void qmp_pcie_pcs_init(struct qmp_pcie *qmp, const struct qmp_phy_cfg_tbls *tbls)
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
 		mode_tbls = cfg->tbls_ep;
 
-	qmp_pcie_serdes_init(qmp, &cfg->tbls);
-	qmp_pcie_serdes_init(qmp, mode_tbls);
+	qmp_pcie_init_registers(qmp, &cfg->tbls);
+	qmp_pcie_init_registers(qmp, mode_tbls);
 
 	ret = clk_prepare_enable(qmp->pipe_clk);
 	if (ret) {
@@ -1941,13 +1927,6 @@ static int qmp_pcie_power_on(struct phy *phy)
 		return ret;
 	}
 
-	/* Tx, Rx, and PCS configurations */
-	qmp_pcie_lanes_init(qmp, &cfg->tbls);
-	qmp_pcie_lanes_init(qmp, mode_tbls);
-
-	qmp_pcie_pcs_init(qmp, &cfg->tbls);
-	qmp_pcie_pcs_init(qmp, mode_tbls);
-
 	/* Pull PHY out of reset state */
 	qphy_clrbits(pcs, cfg->regs[QPHY_SW_RESET], SW_RESET);
 
-- 
2.37.4

