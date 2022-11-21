Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 207B3631C11
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 09:52:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230314AbiKUIww (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 03:52:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbiKUIwF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 03:52:05 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 160527FC1B;
        Mon, 21 Nov 2022 00:52:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 057DEB80D66;
        Mon, 21 Nov 2022 08:51:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9DA5C4FF12;
        Mon, 21 Nov 2022 08:51:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669020715;
        bh=bmsUPacS9Rzat24dJ5K0aImxD9SNax5aw2TjIGoYLjk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YyFoSCeGHZL6flaDiHGab6T5gW7sxlluRjcCBsvujWHqFKQw0pszU55Low7NBABPz
         IYS1w9dClqpEh7MMFULeayksK5Mdb1o2+F4C9deZTvdLSVE3CrTSPL5RvQEUXtEXpL
         qKSF40QqTGkGuOIJNTq/xbg5VsM8H6+nZTUOdUftbW8yL+wR/b4TDWrOV95K6x8PXZ
         u5DWZv+98XX/0uxA4ZZ6cdD43s0/qp1YwuNPKBZzLFslzpBnri6ofhc2d0qr9WRZPQ
         jatkAWTdidY9LKDgnB05J9nbYUV2oqfBiFzwNoOrcNG17TjPAK2Yrpbdk/F2itz7s1
         7jXCYSYPiVmcQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1ox2WT-00088Y-67; Mon, 21 Nov 2022 09:51:25 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Kishon Vijay Abraham I <kishon@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH v3 09/15] phy: qcom-qmp-combo: separate clock and provider registration
Date:   Mon, 21 Nov 2022 09:50:52 +0100
Message-Id: <20221121085058.31213-10-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.37.4
In-Reply-To: <20221121085058.31213-1-johan+linaro@kernel.org>
References: <20221121085058.31213-1-johan+linaro@kernel.org>
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

