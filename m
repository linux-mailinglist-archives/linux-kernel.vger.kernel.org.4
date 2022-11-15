Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC6DA629C71
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 15:42:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238008AbiKOOmA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 09:42:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232475AbiKOOk4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 09:40:56 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B58D2A70C;
        Tue, 15 Nov 2022 06:40:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C6863617E7;
        Tue, 15 Nov 2022 14:40:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6D11C43166;
        Tue, 15 Nov 2022 14:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668523252;
        bh=bmsUPacS9Rzat24dJ5K0aImxD9SNax5aw2TjIGoYLjk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h3rmnPyFAcnaKKQDndZeXdcleW0Zk6D636grxpPshKNJhP1WEQtpWrTfIP5IfzIF6
         b8qcO5MHW2/znHwA0A2ndWGt2Uom/W22NyvAIbdME0vJN5kjM7OfQi8zvWgwkr3c5/
         hpvFasG052x6p6jbyTuLR6MSuO47LPheSA5yMAZA3RiT+HgY0M1VTBP1oY2Lq7N07s
         XWsQOQfMXJcT5xOAQFrCnF8BGpsqv7ZHAq7tM+U5Ch64UMxN0GlNpqmxwoVJzX4tvx
         cChDpoWPIXi+ncpi5DSgN0RBlk0m+CKf1cCXwk6h3g1NibV7dhACxU3To66KbF+taT
         kEtkp5PFfseqA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1oux6t-0000fj-7r; Tue, 15 Nov 2022 15:40:23 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH v2 09/15] phy: qcom-qmp-combo: separate clock and provider registration
Date:   Tue, 15 Nov 2022 15:39:59 +0100
Message-Id: <20221115144005.2478-10-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.37.4
In-Reply-To: <20221115144005.2478-1-johan+linaro@kernel.org>
References: <20221115144005.2478-1-johan+linaro@kernel.org>
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

In preparation for supporting devicetree bindings which do not use child
nodes, separate clock registration from clock-provider registration.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp-combo.c | 44 +++++++++++------------
 1 file changed, 20 insertions(+), 24 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
index 1079a16b45f6..89a5b51c770d 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
@@ -2243,7 +2243,6 @@ static int phy_pipe_clk_register(struct qmp_combo *qmp, struct device_node *np)
 	struct clk_fixed_rate *fixed = &qmp->pipe_clk_fixed;
 	struct clk_init_data init = { };
 	char name[64];
-	int ret;
 
 	snprintf(name, sizeof(name), "%s::pipe_clk", dev_name(qmp->dev));
 	init.name = name;
@@ -2253,19 +2252,7 @@ static int phy_pipe_clk_register(struct qmp_combo *qmp, struct device_node *np)
 	fixed->fixed_rate = 125000000;
 	fixed->hw.init = &init;
 
-	ret = devm_clk_hw_register(qmp->dev, &fixed->hw);
-	if (ret)
-		return ret;
-
-	ret = of_clk_add_hw_provider(np, of_clk_hw_simple_get, &fixed->hw);
-	if (ret)
-		return ret;
-
-	/*
-	 * Roll a devm action because the clock provider is the child node, but
-	 * the child node is not actually a device.
-	 */
-	return devm_add_action_or_reset(qmp->dev, phy_clk_release_provider, np);
+	return devm_clk_hw_register(qmp->dev, &fixed->hw);
 }
 
 /*
@@ -2436,15 +2423,7 @@ static int phy_dp_clks_register(struct qmp_combo *qmp, struct device_node *np)
 	if (ret)
 		return ret;
 
-	ret = of_clk_add_hw_provider(np, qcom_qmp_dp_clks_hw_get, qmp);
-	if (ret)
-		return ret;
-
-	/*
-	 * Roll a devm action because the clock provider is the child node, but
-	 * the child node is not actually a device.
-	 */
-	return devm_add_action_or_reset(qmp->dev, phy_clk_release_provider, np);
+	return 0;
 }
 
 static int qmp_combo_register_clocks(struct qmp_combo *qmp, struct device_node *usb_np,
@@ -2460,7 +2439,24 @@ static int qmp_combo_register_clocks(struct qmp_combo *qmp, struct device_node *
 	if (ret)
 		return ret;
 
-	return 0;
+	ret = of_clk_add_hw_provider(usb_np, of_clk_hw_simple_get,
+					&qmp->pipe_clk_fixed.hw);
+	if (ret)
+		return ret;
+
+	/*
+	 * Roll a devm action because the clock provider is the child node, but
+	 * the child node is not actually a device.
+	 */
+	ret = devm_add_action_or_reset(qmp->dev, phy_clk_release_provider, usb_np);
+	if (ret)
+		return ret;
+
+	ret = of_clk_add_hw_provider(dp_np, qcom_qmp_dp_clks_hw_get, qmp);
+	if (ret)
+		return ret;
+
+	return devm_add_action_or_reset(qmp->dev, phy_clk_release_provider, dp_np);
 }
 
 static int qmp_combo_parse_dt_lecacy_dp(struct qmp_combo *qmp, struct device_node *np)
-- 
2.37.4

