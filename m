Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E82D0611372
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 15:46:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231236AbiJ1Np7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 09:45:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231376AbiJ1Noz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 09:44:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D60F2BE30;
        Fri, 28 Oct 2022 06:44:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2D9F06288F;
        Fri, 28 Oct 2022 13:44:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D3CDC4FEBA;
        Fri, 28 Oct 2022 13:44:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666964681;
        bh=e+hcsmYgZR7tNCuV97Vtva50JcgAeAf+EYANRp5kN7E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T+MXjridsg/gEA6y8eQsmBCbZR95j6xEwpAKNAzZ/E6cUfz5DNWJQ3k3SXi79wfrt
         zNeyT7xqjV8vH82FHEtvbIaFgbJn5/Fj4SlFY4znEbSESbFIuZfvvDwpCIbcHsaoL9
         glNOkqhfKNgPyeokrg0bu/Vv82MTMOl9zDRQcgn3f+g+/7vYwbsLTjz3nO5PrGzpbe
         Ax1GUojYGt2WHLzIKUDrO6YPYqUVAmjON0EU8Bf/yviv9XXIF9o2stMUB+3VmWvcFI
         OZweShJhAuKmYr6pmMP31Qb3PHt0v5P7MVPns86t00yUltaVH/6TdZx5ER8fz5sgij
         AWPy51U1GAQEA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1ooPet-00052Y-Rb; Fri, 28 Oct 2022 15:44:27 +0200
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
Subject: [PATCH v2 12/13] phy: qcom-qmp-usb: restructure PHY creation
Date:   Fri, 28 Oct 2022 15:44:06 +0200
Message-Id: <20221028134407.19300-13-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221028134407.19300-1-johan+linaro@kernel.org>
References: <20221028134407.19300-1-johan+linaro@kernel.org>
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

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
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

