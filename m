Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEB20609EB4
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 12:08:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231147AbiJXKIB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 06:08:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230408AbiJXKHM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 06:07:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E8AC1FFAD;
        Mon, 24 Oct 2022 03:07:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A41F9611B8;
        Mon, 24 Oct 2022 10:07:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE9D8C4FF0E;
        Mon, 24 Oct 2022 10:07:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666606023;
        bh=9PqNY1bKjgTkHZrkBU4jCqQFP+7L+LDLurdxgO2o+T8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RwY2i3IMVUE9BjguwXu76VXbqgXkFldCDLIjwXo87ydWd2ysnvDxXWvxseP2WsBWB
         pjrDiKpzZ+4HM6MtYOx41WGMSWbqygTk6X49FSRp35GHu3a21CI3vuyOg5KFPs/s4/
         /fEDOYDLoKgmjIpmH8YBO+F+Dlv54dDfNQjrTRhaD2mOVFYbEtoFLnzl76jrKbfG+d
         oLG9i5xYqWw38ojw51W9P2mmA21inn4mzqAxbX3VX2+cfqLZo3fDHE3NyF/8wRwAf5
         7AQgdMXkAq9KLN273eyR834QdO8bRi1V3nXdmJqHSCuvmJyCCIKNtIQbGZcxojg6qK
         TJ7P85Qvi3L/A==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1omuM3-0005N4-Nj; Mon, 24 Oct 2022 12:06:47 +0200
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
Subject: [PATCH 12/13] phy: qcom-qmp-usb: restructure PHY creation
Date:   Mon, 24 Oct 2022 12:06:31 +0200
Message-Id: <20221024100632.20549-13-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221024100632.20549-1-johan+linaro@kernel.org>
References: <20221024100632.20549-1-johan+linaro@kernel.org>
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

In preparation for supporting devicetree bindings which do not use a
child node, move the PHY creation to probe() proper and parse the serdes
and dp_com resources in what is now the legacy devicetree helper.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp-usb.c | 46 ++++++++++++-------------
 1 file changed, 22 insertions(+), 24 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-usb.c b/drivers/phy/qualcomm/phy-qcom-qmp-usb.c
index d5e62cfd93f8..3f5e22b1d29e 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-usb.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-usb.c
@@ -2386,13 +2386,22 @@ static void __iomem *qmp_usb_iomap(struct device *dev, struct device_node *np,
 	return devm_of_iomap(dev, np, index, NULL);
 }
 
-static int qmp_usb_create(struct qmp_usb *qmp, struct device_node *np)
+static int qmp_usb_parse_dt_legacy(struct qmp_usb *qmp, struct device_node *np)
 {
+	struct platform_device *pdev = to_platform_device(qmp->dev);
 	const struct qmp_phy_cfg *cfg = qmp->cfg;
 	struct device *dev = qmp->dev;
-	struct phy *generic_phy;
 	bool exclusive = true;
-	int ret;
+
+	qmp->serdes = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(qmp->serdes))
+		return PTR_ERR(qmp->serdes);
+
+	if (cfg->has_phy_dp_com_ctrl) {
+		qmp->dp_com = devm_platform_ioremap_resource(pdev, 1);
+		if (IS_ERR(qmp->dp_com))
+			return PTR_ERR(qmp->dp_com);
+	}
 
 	/*
 	 * FIXME: These bindings should be fixed to not rely on overlapping
@@ -2449,16 +2458,6 @@ static int qmp_usb_create(struct qmp_usb *qmp, struct device_node *np)
 				     "failed to get pipe clock\n");
 	}
 
-	generic_phy = devm_phy_create(dev, np, &qmp_usb_phy_ops);
-	if (IS_ERR(generic_phy)) {
-		ret = PTR_ERR(generic_phy);
-		dev_err(dev, "failed to create PHY: %d\n", ret);
-		return ret;
-	}
-
-	qmp->phy = generic_phy;
-	phy_set_drvdata(generic_phy, qmp);
-
 	return 0;
 }
 
@@ -2480,16 +2479,6 @@ static int qmp_usb_probe(struct platform_device *pdev)
 	if (!qmp->cfg)
 		return -EINVAL;
 
-	qmp->serdes = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(qmp->serdes))
-		return PTR_ERR(qmp->serdes);
-
-	if (qmp->cfg->has_phy_dp_com_ctrl) {
-		qmp->dp_com = devm_platform_ioremap_resource(pdev, 1);
-		if (IS_ERR(qmp->dp_com))
-			return PTR_ERR(qmp->dp_com);
-	}
-
 	ret = qmp_usb_clk_init(qmp);
 	if (ret)
 		return ret;
@@ -2516,7 +2505,7 @@ static int qmp_usb_probe(struct platform_device *pdev)
 	 */
 	pm_runtime_forbid(dev);
 
-	ret = qmp_usb_create(qmp, child);
+	ret = qmp_usb_parse_dt_legacy(qmp, child);
 	if (ret)
 		goto err_node_put;
 
@@ -2524,6 +2513,15 @@ static int qmp_usb_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_node_put;
 
+	qmp->phy = devm_phy_create(dev, child, &qmp_usb_phy_ops);
+	if (IS_ERR(qmp->phy)) {
+		ret = PTR_ERR(qmp->phy);
+		dev_err(dev, "failed to create PHY: %d\n", ret);
+		goto err_node_put;
+	}
+
+	phy_set_drvdata(qmp->phy, qmp);
+
 	of_node_put(child);
 
 	phy_provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
-- 
2.37.3

