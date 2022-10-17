Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61E8C60124D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 17:01:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230133AbiJQPB1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 11:01:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231620AbiJQPAo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 11:00:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3D30419B3;
        Mon, 17 Oct 2022 07:57:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2A9D3611C1;
        Mon, 17 Oct 2022 14:54:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42A89C43142;
        Mon, 17 Oct 2022 14:54:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666018479;
        bh=5U2mLRcMewZ/OXbcaeXyQCALagcvHGf09jg9Pu1Jzck=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KSHL9PrRPjAqbjDjMFzJzqq+fxGXFq9dz+otGMV65LYtpvqxceXazsyzITOX/rviN
         WaYu6q9TScpcEmMA6E9/fuoqw6gpnaVnK5XuoRKlLajAmdAqpt6+DBIcizuMZ4tHPK
         UydCTFCbvaEm18+mUzZ5enbwEPTYxXVdPeVBwLxyivfEZHDfNBKPUd3q7poHfBFSgz
         /myluj2wWcO0yNVgLsgw/QXbt6BN15azMGcPq4wXTdHBGcBilD9iqCop3+/dFn2ayR
         IdYTSxK7LwdQLAWKCO86grM6lkN1jyTWF7G4jl2WuF2SoY1R95gUw1HM8fNuOnZeSD
         n5uf9WznNwX7g==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1okRVd-0005mW-J3; Mon, 17 Oct 2022 16:54:29 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 13/15] phy: qcom-qmp-pcie: add support for pipediv2 clock
Date:   Mon, 17 Oct 2022 16:53:26 +0200
Message-Id: <20221017145328.22090-14-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221017145328.22090-1-johan+linaro@kernel.org>
References: <20221017145328.22090-1-johan+linaro@kernel.org>
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

Some QMP PHYs have a second fixed-divider pipe clock that needs to be
enabled along with the pipe clock.

Add support for an optional "pipediv2" clock.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp-pcie.c | 42 ++++++++++++++++++++----
 1 file changed, 36 insertions(+), 6 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
index 9c8e009033f1..c1d74c06fad1 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
@@ -1379,7 +1379,9 @@ struct qmp_pcie {
 	void __iomem *rx2;
 
 	struct clk *pipe_clk;
+	struct clk *pipediv2_clk;
 	struct clk_bulk_data *clks;
+
 	struct reset_control_bulk_data *resets;
 	struct regulator_bulk_data *vregs;
 
@@ -1902,6 +1904,36 @@ static int qmp_pcie_exit(struct phy *phy)
 	return 0;
 }
 
+static int pipe_clk_enable(struct qmp_pcie *qmp)
+{
+	int ret;
+
+	ret = clk_prepare_enable(qmp->pipe_clk);
+	if (ret) {
+		dev_err(qmp->dev, "failed to enable pipe clock: %d\n", ret);
+		return ret;
+	}
+
+	ret = clk_prepare_enable(qmp->pipediv2_clk);
+	if (ret) {
+		dev_err(qmp->dev, "failed to enable pipediv2 clock: %d\n", ret);
+		goto err_disable_pipe_clk;
+	}
+
+	return 0;
+
+err_disable_pipe_clk:
+	clk_disable_unprepare(qmp->pipe_clk);
+
+	return ret;
+}
+
+static void pipe_clk_disable(struct qmp_pcie *qmp)
+{
+	clk_disable_unprepare(qmp->pipediv2_clk);
+	clk_disable_unprepare(qmp->pipe_clk);
+}
+
 static int qmp_pcie_power_on(struct phy *phy)
 {
 	struct qmp_pcie *qmp = phy_get_drvdata(phy);
@@ -1923,11 +1955,9 @@ static int qmp_pcie_power_on(struct phy *phy)
 	qmp_pcie_init_registers(qmp, &cfg->tables);
 	qmp_pcie_init_registers(qmp, mode_tables);
 
-	ret = clk_prepare_enable(qmp->pipe_clk);
-	if (ret) {
-		dev_err(qmp->dev, "pipe_clk enable failed err=%d\n", ret);
+	ret = pipe_clk_enable(qmp);
+	if (ret)
 		return ret;
-	}
 
 	/* Pull PHY out of reset state */
 	qphy_clrbits(pcs, cfg->regs[QPHY_SW_RESET], SW_RESET);
@@ -1950,7 +1980,7 @@ static int qmp_pcie_power_on(struct phy *phy)
 	return 0;
 
 err_disable_pipe_clk:
-	clk_disable_unprepare(qmp->pipe_clk);
+	pipe_clk_disable(qmp);
 
 	return ret;
 }
@@ -1960,7 +1990,7 @@ static int qmp_pcie_power_off(struct phy *phy)
 	struct qmp_pcie *qmp = phy_get_drvdata(phy);
 	const struct qmp_phy_cfg *cfg = qmp->cfg;
 
-	clk_disable_unprepare(qmp->pipe_clk);
+	pipe_clk_disable(qmp);
 
 	/* PHY reset */
 	qphy_setbits(qmp->pcs, cfg->regs[QPHY_SW_RESET], SW_RESET);
-- 
2.37.3

