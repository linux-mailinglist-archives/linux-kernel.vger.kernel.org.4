Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCDB3609D59
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 11:02:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230208AbiJXJCH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 05:02:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbiJXJBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 05:01:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6371C4DB55;
        Mon, 24 Oct 2022 02:01:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F2F2B6108A;
        Mon, 24 Oct 2022 09:01:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC32CC4315C;
        Mon, 24 Oct 2022 09:01:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666602097;
        bh=eORV9LmEcdHb6Kr3GUyjApeVuli873Sn/SlzBLhCixE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q7XBzBVRtDWnivgHChKd8A/o1R1cb2VYbr4gnTcDGLrR86JS7bQQhNT8mGyivYcul
         vwFBYJZEUjz8rd8qEKMSxVhcC8TydFAciESdoYPXWZlE9sgcQWCJRScjhdYdJze1bJ
         0Wez0oSziuZ9ZyhcFBxJnXdu3+qutXqO9DqEXld84PSf7vBBJqMdFx88/Lg5Lqrtl5
         i3mzW+nMXW/sabTHP2g4V9uUbM5YMg4NeU0ujNAiZTzZom2GGh0LwqCOh7inOder4H
         CBUCAb3/+U16HOaeADXyirs+xfNlH1uACipBUseyVCQ7M5E5HOQRvLLw6eqyO9ZdTC
         Qlk0WYccbCjHw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1omtKj-00056j-Px; Mon, 24 Oct 2022 11:01:21 +0200
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
Subject: [PATCH 09/10] phy: qcom-qmp-ufs: restructure PHY creation
Date:   Mon, 24 Oct 2022 11:00:40 +0200
Message-Id: <20221024090041.19574-10-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221024090041.19574-1-johan+linaro@kernel.org>
References: <20221024090041.19574-1-johan+linaro@kernel.org>
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
resource in what is now the legacy devicetree helper.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp-ufs.c | 34 ++++++++++++-------------
 1 file changed, 16 insertions(+), 18 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
index fa703e856eb7..bf5c1a6b9ca4 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
@@ -983,12 +983,15 @@ static int qmp_ufs_clk_init(struct qmp_ufs *qmp)
 	return devm_clk_bulk_get(dev, num, qmp->clks);
 }
 
-static int qmp_ufs_create(struct qmp_ufs *qmp, struct device_node *np)
+static int qmp_ufs_parse_dt_legacy(struct qmp_ufs *qmp, struct device_node *np)
 {
+	struct platform_device *pdev = to_platform_device(qmp->dev);
 	const struct qmp_phy_cfg *cfg = qmp->cfg;
 	struct device *dev = qmp->dev;
-	struct phy *generic_phy;
-	int ret;
+
+	qmp->serdes = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(qmp->serdes))
+		return PTR_ERR(qmp->serdes);
 
 	/*
 	 * Get memory resources for the PHY:
@@ -1025,16 +1028,6 @@ static int qmp_ufs_create(struct qmp_ufs *qmp, struct device_node *np)
 	if (IS_ERR(qmp->pcs_misc))
 		dev_vdbg(dev, "PHY pcs_misc-reg not used\n");
 
-	generic_phy = devm_phy_create(dev, np, &qcom_qmp_ufs_phy_ops);
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
 
@@ -1056,10 +1049,6 @@ static int qmp_ufs_probe(struct platform_device *pdev)
 	if (!qmp->cfg)
 		return -EINVAL;
 
-	qmp->serdes = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(qmp->serdes))
-		return PTR_ERR(qmp->serdes);
-
 	ret = qmp_ufs_clk_init(qmp);
 	if (ret)
 		return ret;
@@ -1072,10 +1061,19 @@ static int qmp_ufs_probe(struct platform_device *pdev)
 	if (!child)
 		return -EINVAL;
 
-	ret = qmp_ufs_create(qmp, child);
+	ret = qmp_ufs_parse_dt_legacy(qmp, child);
 	if (ret)
 		goto err_node_put;
 
+	qmp->phy = devm_phy_create(dev, child, &qcom_qmp_ufs_phy_ops);
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

