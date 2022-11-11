Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC7406256CB
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 10:27:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233704AbiKKJ1H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 04:27:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233697AbiKKJ0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 04:26:21 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66DF1787B7;
        Fri, 11 Nov 2022 01:26:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AFA5BB824B7;
        Fri, 11 Nov 2022 09:26:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56388C4FF14;
        Fri, 11 Nov 2022 09:26:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668158765;
        bh=Zc93zrWLEk/mbwGGbJNQIwKZAm30VFAYxogWwW49F5k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C3AUQa/9n/9j2FNq/dev8SIshUT9Qofnoy1OArKU0vmw4y3SseDP4yvNyggvATHia
         FD+esdOdLm3Q/klGjqDDk5XeB2bTfoTlmllbmBTsH/kqMYzRINLCTq3VX/iyvBp7KV
         7hE5PjeN3u93oz/Fa3cSyGMgBT4iq96pwOz0VCz8ct+/uSK/NLamlAx6fzCy35EIDL
         xWQFUg6kY8oz8udOJbaYHIw3rMuroH855OcfZLYHTFOCKj3qnTIgfx8C2XhtwwxYIw
         zafDEP7IsQ5eshs86pf7NWkY2tGkWG40HOH2ojj/j6am2TQbSMlxROO9j1etjrTmNF
         xFyj9QBdCVtIA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1otQI5-0002lP-LZ; Fri, 11 Nov 2022 10:25:37 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 14/14] phy: qcom-qmp-combo: add support for updated sc8280xp binding
Date:   Fri, 11 Nov 2022 10:24:57 +0100
Message-Id: <20221111092457.10546-15-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.37.4
In-Reply-To: <20221111092457.10546-1-johan+linaro@kernel.org>
References: <20221111092457.10546-1-johan+linaro@kernel.org>
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

Add support for the new SC8280XP binding.

Note that the binding does not try to describe every register subregion
and instead the driver holds the corresponding offsets.

Also note that (possibly) unlike on earlier platforms, the TX registers
are used by both the USB and DP implementation.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp-combo.c | 143 ++++++++++++++++++++--
 1 file changed, 133 insertions(+), 10 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
index 0a4d53e6c586..544a7e55bf14 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
@@ -798,9 +798,25 @@ static const u8 qmp_dp_v5_voltage_swing_hbr_rbr[4][4] = {
 
 struct qmp_combo;
 
+struct qmp_combo_offsets {
+	u16 com;
+	u16 txa;
+	u16 rxa;
+	u16 txb;
+	u16 rxb;
+	u16 usb3_serdes;
+	u16 usb3_pcs_misc;
+	u16 usb3_pcs;
+	u16 usb3_pcs_usb;
+	u16 dp_serdes;
+	u16 dp_dp_phy;
+};
+
 struct qmp_phy_cfg {
 	int lanes;
 
+	const struct qmp_combo_offsets *offsets;
+
 	/* Init sequence for PHY blocks - serdes, tx, rx, pcs */
 	const struct qmp_phy_init_tbl *serdes_tbl;
 	int serdes_tbl_num;
@@ -961,6 +977,20 @@ static const char * const sc7180_usb3phy_reset_l[] = {
 	"phy",
 };
 
+static const struct qmp_combo_offsets qmp_combo_offsets_v5 = {
+	.com		= 0x0000,
+	.txa		= 0x0400,
+	.rxa		= 0x0600,
+	.txb		= 0x0a00,
+	.rxb		= 0x0c00,
+	.usb3_serdes	= 0x1000,
+	.usb3_pcs_misc	= 0x1200,
+	.usb3_pcs	= 0x1400,
+	.usb3_pcs_usb	= 0x1700,
+	.dp_serdes	= 0x2000,
+	.dp_dp_phy	= 0x2200,
+};
+
 static const struct qmp_phy_cfg sc7180_usb3dpphy_cfg = {
 	.lanes			= 2,
 
@@ -1107,6 +1137,8 @@ static const struct qmp_phy_cfg sc8180x_usb3dpphy_cfg = {
 static const struct qmp_phy_cfg sc8280xp_usb43dpphy_cfg = {
 	.lanes			= 2,
 
+	.offsets		= &qmp_combo_offsets_v5,
+
 	.serdes_tbl		= sc8280xp_usb43dp_serdes_tbl,
 	.serdes_tbl_num		= ARRAY_SIZE(sc8280xp_usb43dp_serdes_tbl),
 	.tx_tbl			= sc8280xp_usb43dp_tx_tbl,
@@ -1147,7 +1179,6 @@ static const struct qmp_phy_cfg sc8280xp_usb43dpphy_cfg = {
 	.vreg_list		= qmp_phy_vreg_l,
 	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
 	.regs			= qmp_v4_usb3phy_regs_layout,
-	.pcs_usb_offset		= 0x300,
 };
 
 static const struct qmp_phy_cfg sm8250_usb3dpphy_cfg = {
@@ -2433,6 +2464,22 @@ static int phy_dp_clks_register(struct qmp_combo *qmp, struct device_node *np)
 	return 0;
 }
 
+static struct clk_hw *qmp_combo_clk_hw_get(struct of_phandle_args *clkspec, void *data)
+{
+	struct qmp_combo *qmp = data;
+
+	switch (clkspec->args[0]) {
+	case 0:
+		return &qmp->pipe_clk_fixed.hw;
+	case 1:
+		return &qmp->dp_link_hw;
+	case 2:
+		return &qmp->dp_pixel_hw;
+	}
+
+	return ERR_PTR(-EINVAL);
+}
+
 static int qmp_combo_register_clocks(struct qmp_combo *qmp, struct device_node *usb_np,
 					struct device_node *dp_np)
 {
@@ -2446,6 +2493,15 @@ static int qmp_combo_register_clocks(struct qmp_combo *qmp, struct device_node *
 	if (ret)
 		return ret;
 
+	/*
+	 * Register a single provider for bindings without child nodes.
+	 */
+	if (usb_np == qmp->dev->of_node)
+		return devm_of_clk_add_hw_provider(qmp->dev, qmp_combo_clk_hw_get, qmp);
+
+	/*
+	 * Register multiple providers for legacy bindings with child nodes.
+	 */
 	ret = of_clk_add_hw_provider(usb_np, of_clk_hw_simple_get,
 					&qmp->pipe_clk_fixed.hw);
 	if (ret)
@@ -2580,6 +2636,63 @@ static int qmp_combo_parse_dt_legacy(struct qmp_combo *qmp, struct device_node *
 	return 0;
 }
 
+static int qmp_combo_parse_dt(struct qmp_combo *qmp)
+{
+	struct platform_device *pdev = to_platform_device(qmp->dev);
+	const struct qmp_phy_cfg *cfg = qmp->cfg;
+	const struct qmp_combo_offsets *offs = cfg->offsets;
+	struct device *dev = qmp->dev;
+	void __iomem *base;
+
+	if (!offs)
+		return -EINVAL;
+
+	base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	qmp->com = base + offs->com;
+	qmp->tx = base + offs->txa;
+	qmp->rx = base + offs->rxa;
+	qmp->tx2 = base + offs->txb;
+	qmp->rx2 = base + offs->rxb;
+
+	qmp->serdes = base + offs->usb3_serdes;
+	qmp->pcs_misc = base + offs->usb3_pcs_misc;
+	qmp->pcs = base + offs->usb3_pcs;
+	qmp->pcs_usb = base + offs->usb3_pcs_usb;
+
+	qmp->dp_serdes = base + offs->dp_serdes;
+	qmp->dp_tx = base + offs->txa;
+	qmp->dp_tx2 = base + offs->txb;
+	qmp->dp_dp_phy = base + offs->dp_dp_phy;
+
+	qmp->pipe_clk = devm_clk_get(dev, "usb3_pipe");
+	if (IS_ERR(qmp->pipe_clk)) {
+		return dev_err_probe(dev, PTR_ERR(qmp->pipe_clk),
+				"failed to get usb3_pipe clock\n");
+	}
+
+	return 0;
+}
+
+static struct phy *qmp_combo_phy_xlate(struct device *dev, struct of_phandle_args *args)
+{
+	struct qmp_combo *qmp = dev_get_drvdata(dev);
+
+	if (args->args_count == 0)
+		return ERR_PTR(-EINVAL);
+
+	switch (args->args[0]) {
+	case PHY_TYPE_USB3:
+		return qmp->usb_phy;
+	case PHY_TYPE_DP:
+		return qmp->dp_phy;
+	}
+
+	return ERR_PTR(-EINVAL);
+}
+
 static int qmp_combo_probe(struct platform_device *pdev)
 {
 	struct qmp_combo *qmp;
@@ -2612,17 +2725,22 @@ static int qmp_combo_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	/* Check for legacy binding with child nodes. */
 	usb_np = of_get_child_by_name(dev->of_node, "usb3-phy");
-	if (!usb_np)
-		return -EINVAL;
+	if (usb_np) {
+		dp_np = of_get_child_by_name(dev->of_node, "dp-phy");
+		if (!dp_np) {
+			of_node_put(usb_np);
+			return -EINVAL;
+		}
 
-	dp_np = of_get_child_by_name(dev->of_node, "dp-phy");
-	if (!dp_np) {
-		of_node_put(usb_np);
-		return -EINVAL;
-	}
+		ret = qmp_combo_parse_dt_legacy(qmp, usb_np, dp_np);
+	} else {
+		usb_np = of_node_get(dev->of_node);
+		dp_np = of_node_get(dev->of_node);
 
-	ret = qmp_combo_parse_dt_legacy(qmp, usb_np, dp_np);
+		ret = qmp_combo_parse_dt(qmp);
+	}
 	if (ret)
 		goto err_node_put;
 
@@ -2658,7 +2776,12 @@ static int qmp_combo_probe(struct platform_device *pdev)
 
 	phy_set_drvdata(qmp->dp_phy, qmp);
 
-	phy_provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
+	dev_set_drvdata(dev, qmp);
+
+	if (usb_np == dev->of_node)
+		phy_provider = devm_of_phy_provider_register(dev, qmp_combo_phy_xlate);
+	else
+		phy_provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
 
 	of_node_put(usb_np);
 	of_node_put(dp_np);
-- 
2.37.4

