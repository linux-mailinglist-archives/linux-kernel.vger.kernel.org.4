Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CAFE611707
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 18:07:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbiJ1QHg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 12:07:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230211AbiJ1QF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 12:05:59 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 418146B8F2;
        Fri, 28 Oct 2022 09:05:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A1D76B82AED;
        Fri, 28 Oct 2022 16:05:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1D5DC4314A;
        Fri, 28 Oct 2022 16:05:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666973109;
        bh=iS1BRJEqhMqO48dkbYjLoV1lWUWlCJ2Wfx2yF2KrGTs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HvnDLGzLnbyUSUT6Gb8vbd5LAj1Zyntg7Ryxty0D2gTH+0JJtftIJM1kKQ7buUn6Y
         iNfQblFGe+OdVSyboOiUHnWZy+C2/mH88ZH8u5AZ0iGiY/FkhXuGHjBk10Zq6PgHqs
         2/2QUTwWFAeDfygIwHm3YaGn/NiTgShFfadPCto+CGAd8QITk6DtE0Mrl3JwRTHNGv
         6f9oGe0tEezQrWcGo/jCet3W7Snr6buYnGpAythTdCIN9XYmIvkgosyGtQaZu7edFd
         wlbWE1SdPXjbnp/igPKR1DpYc2BVAA8o5jfrZMbmjlMeCjBm18Pf8GzGh8xccG0oJ0
         zbzpnivozjlog==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1ooRqq-00071k-A6; Fri, 28 Oct 2022 18:04:56 +0200
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
Subject: [PATCH RESEND v2 07/13] phy: qcom-qmp-usb: clean up probe initialisation
Date:   Fri, 28 Oct 2022 18:04:29 +0200
Message-Id: <20221028160435.26948-8-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221028160435.26948-1-johan+linaro@kernel.org>
References: <20221028160435.26948-1-johan+linaro@kernel.org>
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

Stop abusing the driver data pointer and instead pass the driver state
structure directly to the initialisation helpers during probe.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp-usb.c | 46 ++++++++++++-------------
 1 file changed, 22 insertions(+), 24 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-usb.c b/drivers/phy/qualcomm/phy-qcom-qmp-usb.c
index ccb834a08d5b..2e603831e45e 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-usb.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-usb.c
@@ -2250,9 +2250,10 @@ static const struct dev_pm_ops qmp_usb_pm_ops = {
 			   qmp_usb_runtime_resume, NULL)
 };
 
-static int qmp_usb_vreg_init(struct device *dev, const struct qmp_phy_cfg *cfg)
+static int qmp_usb_vreg_init(struct qmp_usb *qmp)
 {
-	struct qmp_usb *qmp = dev_get_drvdata(dev);
+	const struct qmp_phy_cfg *cfg = qmp->cfg;
+	struct device *dev = qmp->dev;
 	int num = cfg->num_vregs;
 	int i;
 
@@ -2266,9 +2267,10 @@ static int qmp_usb_vreg_init(struct device *dev, const struct qmp_phy_cfg *cfg)
 	return devm_regulator_bulk_get(dev, num, qmp->vregs);
 }
 
-static int qmp_usb_reset_init(struct device *dev, const struct qmp_phy_cfg *cfg)
+static int qmp_usb_reset_init(struct qmp_usb *qmp)
 {
-	struct qmp_usb *qmp = dev_get_drvdata(dev);
+	const struct qmp_phy_cfg *cfg = qmp->cfg;
+	struct device *dev = qmp->dev;
 	int i;
 	int ret;
 
@@ -2287,9 +2289,10 @@ static int qmp_usb_reset_init(struct device *dev, const struct qmp_phy_cfg *cfg)
 	return 0;
 }
 
-static int qmp_usb_clk_init(struct device *dev, const struct qmp_phy_cfg *cfg)
+static int qmp_usb_clk_init(struct qmp_usb *qmp)
 {
-	struct qmp_usb *qmp = dev_get_drvdata(dev);
+	const struct qmp_phy_cfg *cfg = qmp->cfg;
+	struct device *dev = qmp->dev;
 	int num = cfg->num_clks;
 	int i;
 
@@ -2385,10 +2388,10 @@ static void __iomem *qmp_usb_iomap(struct device *dev, struct device_node *np,
 	return devm_of_iomap(dev, np, index, NULL);
 }
 
-static int qmp_usb_create(struct device *dev, struct device_node *np,
-			void __iomem *serdes, const struct qmp_phy_cfg *cfg)
+static int qmp_usb_create(struct qmp_usb *qmp, struct device_node *np)
 {
-	struct qmp_usb *qmp = dev_get_drvdata(dev);
+	const struct qmp_phy_cfg *cfg = qmp->cfg;
+	struct device *dev = qmp->dev;
 	struct phy *generic_phy;
 	bool exclusive = true;
 	int ret;
@@ -2402,8 +2405,6 @@ static int qmp_usb_create(struct device *dev, struct device_node *np,
 	if (of_device_is_compatible(dev->of_node, "qcom,sm8350-qmp-usb3-uni-phy"))
 		exclusive = false;
 
-	qmp->cfg = cfg;
-	qmp->serdes = serdes;
 	/*
 	 * Get memory resources for the PHY:
 	 * Resources are indexed as: tx -> 0; rx -> 1; pcs -> 2.
@@ -2468,8 +2469,6 @@ static int qmp_usb_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct device_node *child;
 	struct phy_provider *phy_provider;
-	void __iomem *serdes;
-	const struct qmp_phy_cfg *cfg = NULL;
 	struct qmp_usb *qmp;
 	int ret;
 
@@ -2478,31 +2477,30 @@ static int qmp_usb_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	qmp->dev = dev;
-	dev_set_drvdata(dev, qmp);
 
-	cfg = of_device_get_match_data(dev);
-	if (!cfg)
+	qmp->cfg = of_device_get_match_data(dev);
+	if (!qmp->cfg)
 		return -EINVAL;
 
-	serdes = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(serdes))
-		return PTR_ERR(serdes);
+	qmp->serdes = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(qmp->serdes))
+		return PTR_ERR(qmp->serdes);
 
-	if (cfg->has_phy_dp_com_ctrl) {
+	if (qmp->cfg->has_phy_dp_com_ctrl) {
 		qmp->dp_com = devm_platform_ioremap_resource(pdev, 1);
 		if (IS_ERR(qmp->dp_com))
 			return PTR_ERR(qmp->dp_com);
 	}
 
-	ret = qmp_usb_clk_init(dev, cfg);
+	ret = qmp_usb_clk_init(qmp);
 	if (ret)
 		return ret;
 
-	ret = qmp_usb_reset_init(dev, cfg);
+	ret = qmp_usb_reset_init(qmp);
 	if (ret)
 		return ret;
 
-	ret = qmp_usb_vreg_init(dev, cfg);
+	ret = qmp_usb_vreg_init(qmp);
 	if (ret)
 		return ret;
 
@@ -2520,7 +2518,7 @@ static int qmp_usb_probe(struct platform_device *pdev)
 	 */
 	pm_runtime_forbid(dev);
 
-	ret = qmp_usb_create(dev, child, serdes, cfg);
+	ret = qmp_usb_create(qmp, child);
 	if (ret)
 		goto err_node_put;
 
-- 
2.37.3

