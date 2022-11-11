Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 812506255FF
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 09:58:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233578AbiKKI6U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 03:58:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233449AbiKKI51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 03:57:27 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2B697E992;
        Fri, 11 Nov 2022 00:57:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0E84961F08;
        Fri, 11 Nov 2022 08:57:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B1A8C4FF41;
        Fri, 11 Nov 2022 08:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668157044;
        bh=9QCvgaPFthb6sQCOGE29pX488mZSMXQmDL1/DQjfEp8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qv4nf/KV+mhHf+Otksy3+RznjhjvBR4RRjN6zOMUk1nfntKpdXHx9haFkISEhfKK3
         TbJaYMrFXR717ui97z39VNeodX4PBg4B8f6lFwuw8o+tbl7CpsiHgW6BChO8ZHLNS1
         l1Pbrz4B1hd7DQpylfEwz8nV++K6CHraNO2kKYpe82utvQLUF0XRYnph1tn4vkD8DN
         9AzI4JQi0V8hvmasTv5GmyBaq5ud728XK1cRKTFhUCLfUUP97zLa+kFTNvNx1toUp4
         Fgy7ZJTnwehHo0pmg8ldlTH4SsUzpLqzbWBnCAegbBgF4aZ9a039Sz5o6FljmKkYVH
         YOlbe0f64csFw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1otPqK-0002Ug-Fp; Fri, 11 Nov 2022 09:56:56 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 19/22] phy: qcom-qmp-combo: clean up device-tree parsing
Date:   Fri, 11 Nov 2022 09:56:40 +0100
Message-Id: <20221111085643.9478-20-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.37.4
In-Reply-To: <20221111085643.9478-1-johan+linaro@kernel.org>
References: <20221111085643.9478-1-johan+linaro@kernel.org>
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

Since the QMP driver split there will be precisely two child nodes so
drop the obsolete iteration construct.

While at it, drop the verbose error logging that would have been printed
also on probe deferrals.

Note that there is no need to check if there are additional child nodes
(the kernel is not a devicetree validator), but let's return an error if
either child node is missing.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp-combo.c | 82 ++++++++---------------
 1 file changed, 28 insertions(+), 54 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
index 43b7ea5d2edc..a4df228d8ae2 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
@@ -2598,13 +2598,12 @@ static int qmp_combo_probe(struct platform_device *pdev)
 {
 	struct qmp_combo *qmp;
 	struct device *dev = &pdev->dev;
-	struct device_node *child;
+	struct device_node *dp_np, *usb_np;
 	struct phy_provider *phy_provider;
 	void __iomem *serdes;
 	void __iomem *usb_serdes;
 	void __iomem *dp_serdes = NULL;
 	const struct qmp_phy_cfg *cfg = NULL;
-	int num, id, expected_phys;
 	int ret;
 
 	qmp = devm_kzalloc(dev, sizeof(*qmp), GFP_KERNEL);
@@ -2630,8 +2629,6 @@ static int qmp_combo_probe(struct platform_device *pdev)
 	if (IS_ERR(dp_serdes))
 		return PTR_ERR(dp_serdes);
 
-	expected_phys = 2;
-
 	mutex_init(&qmp->phy_mutex);
 
 	ret = qmp_combo_clk_init(dev, cfg);
@@ -2646,75 +2643,52 @@ static int qmp_combo_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	num = of_get_available_child_count(dev->of_node);
-	/* do we have a rogue child node ? */
-	if (num > expected_phys)
+	usb_np = of_get_child_by_name(dev->of_node, "usb3-phy");
+	if (!usb_np)
+		return -EINVAL;
+
+	dp_np = of_get_child_by_name(dev->of_node, "dp-phy");
+	if (!dp_np) {
+		of_node_put(usb_np);
 		return -EINVAL;
+	}
 
 	pm_runtime_set_active(dev);
 	ret = devm_pm_runtime_enable(dev);
 	if (ret)
-		return ret;
+		goto err_node_put;
 	/*
 	 * Prevent runtime pm from being ON by default. Users can enable
 	 * it using power/control in sysfs.
 	 */
 	pm_runtime_forbid(dev);
 
-	id = 0;
-	for_each_available_child_of_node(dev->of_node, child) {
-		if (of_node_name_eq(child, "dp-phy")) {
-			serdes = dp_serdes;
-
-			/* Create per-lane phy */
-			ret = qmp_combo_create_dp(dev, child, serdes, cfg);
-			if (ret) {
-				dev_err(dev, "failed to create lane%d phy, %d\n",
-					id, ret);
-				goto err_node_put;
-			}
-
-			ret = phy_dp_clks_register(qmp, child);
-			if (ret) {
-				dev_err(qmp->dev,
-					"failed to register DP clock source\n");
-				goto err_node_put;
-			}
-		} else if (of_node_name_eq(child, "usb3-phy")) {
-			serdes = usb_serdes;
-
-			/* Create per-lane phy */
-			ret = qmp_combo_create_usb(dev, child, serdes, cfg);
-			if (ret) {
-				dev_err(dev, "failed to create lane%d phy, %d\n",
-					id, ret);
-				goto err_node_put;
-			}
-
-			/*
-			 * Register the pipe clock provided by phy.
-			 * See function description to see details of this pipe clock.
-			 */
-			ret = phy_pipe_clk_register(qmp, child);
-			if (ret) {
-				dev_err(qmp->dev,
-					"failed to register pipe clock source\n");
-				goto err_node_put;
-			}
-		}
+	ret = qmp_combo_create_usb(dev, usb_np, usb_serdes, cfg);
+	if (ret)
+		goto err_node_put;
 
-		id++;
-	}
+	ret = phy_pipe_clk_register(qmp, usb_np);
+	if (ret)
+		goto err_node_put;
 
-	if (!qmp->usb_phy)
-		return -EINVAL;
+	ret = qmp_combo_create_dp(dev, dp_np, dp_serdes, cfg);
+	if (ret)
+		goto err_node_put;
+
+	ret = phy_dp_clks_register(qmp, dp_np);
+	if (ret)
+		goto err_node_put;
 
 	phy_provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
 
+	of_node_put(usb_np);
+	of_node_put(dp_np);
+
 	return PTR_ERR_OR_ZERO(phy_provider);
 
 err_node_put:
-	of_node_put(child);
+	of_node_put(usb_np);
+	of_node_put(dp_np);
 	return ret;
 }
 
-- 
2.37.4

