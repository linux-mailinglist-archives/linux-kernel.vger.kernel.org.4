Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E440761DB7C
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 16:03:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230055AbiKEPDg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Nov 2022 11:03:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbiKEPCy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Nov 2022 11:02:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A96910B56;
        Sat,  5 Nov 2022 08:02:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1F36360B73;
        Sat,  5 Nov 2022 15:02:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E67D8C4FF43;
        Sat,  5 Nov 2022 15:02:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667660571;
        bh=yipoO2tRs+ZTCtxVSGW0WVa+FPfnz9Yo8Wlo2plnIvQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=t3Dst5swe5rygx2akfhU2SxFRAkZtpK1XR36kZpXFfO78qrLsbSez98pnlbRF2fm9
         LmWSK9BsPnXd0/9N99RC7D2LNzSn8ZX6ewoOx7kfjVhOF6HVttkdsWcywJObVj0KM7
         yxcHAyRjMr4KsNn1OozRRoJB5hF8UED1VzHDRpndVBU49zKB1+As1JLywIi9lmMCjn
         UGfprqbjGCE/BZsZUrYc0CFwWTR86dnupLUDlyR96Eyt37b59AqJwrF8r3emOxr0kw
         DtyyDstvk6x8nYjvAi6FQ3sXxkZUJkhyHUDjUTDekHCm6h0fifZRNaRvrMH7OqMMb+
         JP0CBydyKMh6w==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1orKgp-0005Ks-Tu; Sat, 05 Nov 2022 16:02:31 +0100
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
Subject: [PATCH v5 14/16] phy: qcom-qmp-pcie: add support for pipediv2 clock
Date:   Sat,  5 Nov 2022 15:59:37 +0100
Message-Id: <20221105145939.20318-15-johan+linaro@kernel.org>
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

Some QMP PHYs have a second fixed-divider pipe clock that needs to be
enabled along with the pipe clock.

Add support for an optional "pipediv2" clock.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp-pcie.c | 25 ++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
index 06844552922e..d671b05c73dd 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
@@ -1378,8 +1378,10 @@ struct qmp_pcie {
 	void __iomem *tx2;
 	void __iomem *rx2;
 
-	struct clk *pipe_clk;
 	struct clk_bulk_data *clks;
+	struct clk_bulk_data pipe_clks[2];
+	int num_pipe_clks;
+
 	struct reset_control_bulk_data *resets;
 	struct regulator_bulk_data *vregs;
 
@@ -1923,11 +1925,9 @@ static int qmp_pcie_power_on(struct phy *phy)
 	qmp_pcie_init_registers(qmp, &cfg->tbls);
 	qmp_pcie_init_registers(qmp, mode_tbls);
 
-	ret = clk_prepare_enable(qmp->pipe_clk);
-	if (ret) {
-		dev_err(qmp->dev, "pipe_clk enable failed err=%d\n", ret);
+	ret = clk_bulk_prepare_enable(qmp->num_pipe_clks, qmp->pipe_clks);
+	if (ret)
 		return ret;
-	}
 
 	/* Pull PHY out of reset state */
 	qphy_clrbits(pcs, cfg->regs[QPHY_SW_RESET], SW_RESET);
@@ -1950,7 +1950,7 @@ static int qmp_pcie_power_on(struct phy *phy)
 	return 0;
 
 err_disable_pipe_clk:
-	clk_disable_unprepare(qmp->pipe_clk);
+	clk_bulk_disable_unprepare(qmp->num_pipe_clks, qmp->pipe_clks);
 
 	return ret;
 }
@@ -1960,7 +1960,7 @@ static int qmp_pcie_power_off(struct phy *phy)
 	struct qmp_pcie *qmp = phy_get_drvdata(phy);
 	const struct qmp_phy_cfg *cfg = qmp->cfg;
 
-	clk_disable_unprepare(qmp->pipe_clk);
+	clk_bulk_disable_unprepare(qmp->num_pipe_clks, qmp->pipe_clks);
 
 	/* PHY reset */
 	qphy_setbits(qmp->pcs, cfg->regs[QPHY_SW_RESET], SW_RESET);
@@ -2154,6 +2154,7 @@ static int qmp_pcie_parse_dt_legacy(struct qmp_pcie *qmp, struct device_node *np
 	struct platform_device *pdev = to_platform_device(qmp->dev);
 	const struct qmp_phy_cfg *cfg = qmp->cfg;
 	struct device *dev = qmp->dev;
+	struct clk *clk;
 
 	qmp->serdes = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(qmp->serdes))
@@ -2206,12 +2207,16 @@ static int qmp_pcie_parse_dt_legacy(struct qmp_pcie *qmp, struct device_node *np
 		}
 	}
 
-	qmp->pipe_clk = devm_get_clk_from_child(dev, np, NULL);
-	if (IS_ERR(qmp->pipe_clk)) {
-		return dev_err_probe(dev, PTR_ERR(qmp->pipe_clk),
+	clk = devm_get_clk_from_child(dev, np, NULL);
+	if (IS_ERR(clk)) {
+		return dev_err_probe(dev, PTR_ERR(clk),
 				     "failed to get pipe clock\n");
 	}
 
+	qmp->num_pipe_clks = 1;
+	qmp->pipe_clks[0].id = "pipe";
+	qmp->pipe_clks[0].clk = clk;
+
 	return 0;
 }
 
-- 
2.37.4

