Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E214F631C00
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 09:52:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230208AbiKUIwW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 03:52:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230212AbiKUIwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 03:52:04 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81319809AE;
        Mon, 21 Nov 2022 00:52:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2691760F4D;
        Mon, 21 Nov 2022 08:51:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F30BBC4FF13;
        Mon, 21 Nov 2022 08:51:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669020715;
        bh=S5xseugGMZk5s5FcsKTKBF2KLbZ80lWoZS12gqBQ1d4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gV77FZj3HmD3muBAP2D3gn4WplONtukbm/wFPKcKAoCZjx+5mQ6Ku2s49W17rsJMS
         dY1yhcum1TAZD9YX9VYWldMz14noh0kNSwjOrIwDD/JptgPKkeVfELHuJEf3xOHWSL
         h6apXcfivOGUGNLQx3pUl/eMfywTmSw/obX3RkvUg1Iv1DYoeShmgvhU/6XmEXT/YL
         0omqchMQFLyBIwoCnyz7+SgDqVQ5HDdp7V7/rAsefkEiluVKsKhz5YULiiEjR0PKd3
         8Lg7/x5kvbY60IIxiP633QQ4bfGIiP1eTyLkuztj5eS5MYp1u17O7zObU2mjdT2g90
         EVoDTmEJiGdLA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1ox2WT-00088U-3D; Mon, 21 Nov 2022 09:51:25 +0100
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
Subject: [PATCH v3 08/15] phy: qcom-qmp-combo: add clock registration helper
Date:   Mon, 21 Nov 2022 09:50:51 +0100
Message-Id: <20221121085058.31213-9-johan+linaro@kernel.org>
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
nodes, add a clock registration helper to handle the registration of
both the USB and DP clocks.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp-combo.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
index 9b945a72ae9b..1079a16b45f6 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
@@ -2447,6 +2447,22 @@ static int phy_dp_clks_register(struct qmp_combo *qmp, struct device_node *np)
 	return devm_add_action_or_reset(qmp->dev, phy_clk_release_provider, np);
 }
 
+static int qmp_combo_register_clocks(struct qmp_combo *qmp, struct device_node *usb_np,
+					struct device_node *dp_np)
+{
+	int ret;
+
+	ret = phy_pipe_clk_register(qmp, usb_np);
+	if (ret)
+		return ret;
+
+	ret = phy_dp_clks_register(qmp, dp_np);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
 static int qmp_combo_parse_dt_lecacy_dp(struct qmp_combo *qmp, struct device_node *np)
 {
 	struct device *dev = qmp->dev;
@@ -2606,11 +2622,7 @@ static int qmp_combo_probe(struct platform_device *pdev)
 	 */
 	pm_runtime_forbid(dev);
 
-	ret = phy_pipe_clk_register(qmp, usb_np);
-	if (ret)
-		goto err_node_put;
-
-	ret = phy_dp_clks_register(qmp, dp_np);
+	ret = qmp_combo_register_clocks(qmp, usb_np, dp_np);
 	if (ret)
 		goto err_node_put;
 
-- 
2.37.4

