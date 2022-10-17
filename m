Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2F86601238
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 17:00:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231683AbiJQPAH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 11:00:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231667AbiJQO6s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 10:58:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65DEF6B8C8;
        Mon, 17 Oct 2022 07:56:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 66FE8611B1;
        Mon, 17 Oct 2022 14:54:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1B46C43146;
        Mon, 17 Oct 2022 14:54:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666018478;
        bh=3R9BPW6QSUhhXBNcO5z3mLwkQgvqyw63TThHmZ5QLXM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=i60zkr9MASFPcL30p8Ir1wUheuzLJgxNhDALpA+2hErpLnwI76fh+kmUbaKN7OFm2
         KbIuejJNyq8m6HpMnIkwsJnaJpkP3ZVRu2/ix49biDcE4sISNFxF44YTiaE3MCANKC
         C6NwYY8AfW0xn1marrhP7FmkoOyLPzwWf+APyJTaRuawkjiC8Mt/JRZ1BkcKsbxAzx
         2a2Sj5nSYYmEkMcB0eNrAhTmqwhd2+oAoBVS4OswgJdt1rxFm9AKTc0IVF1WsRTivl
         I2S5PyV1ixxRjekxu0jBEqMlicBYygsaCrFwVtTx8OLoCkR9wNLXziYfU7E0Lg85TU
         4WJ/EcfGIGVuw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1okRVc-0005m3-P5; Mon, 17 Oct 2022 16:54:28 +0200
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
Subject: [PATCH 04/15] phy: qcom-qmp-pcie: clean up device-tree parsing
Date:   Mon, 17 Oct 2022 16:53:17 +0200
Message-Id: <20221017145328.22090-5-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221017145328.22090-1-johan+linaro@kernel.org>
References: <20221017145328.22090-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the QMP driver split there will be at most a single child node so
drop the obsolete iteration construct.

While at it, drop the verbose error logging that would have been
printed also on probe deferrals.

Note that there's no need to check if there are additional child nodes
(the kernel is not a devicetree validator), but let's return an error if
there are no child nodes at all for now.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp-pcie.c | 34 +++++++-----------------
 1 file changed, 9 insertions(+), 25 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
index 667a87e7c917..bc96518ad6b0 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
@@ -2250,7 +2250,6 @@ static int qmp_pcie_probe(struct platform_device *pdev)
 	void __iomem *serdes;
 	const struct qmp_phy_cfg *cfg = NULL;
 	struct qmp_pcie *qmp;
-	int num, id;
 	int ret;
 
 	qmp = devm_kzalloc(dev, sizeof(*qmp), GFP_KERNEL);
@@ -2283,34 +2282,19 @@ static int qmp_pcie_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	num = of_get_available_child_count(dev->of_node);
-	/* do we have a rogue child node ? */
-	if (num > 1)
+	child = of_get_next_available_child(dev->of_node, NULL);
+	if (!child)
 		return -EINVAL;
 
-	id = 0;
-	for_each_available_child_of_node(dev->of_node, child) {
-		/* Create per-lane phy */
-		ret = qmp_pcie_create(dev, child, serdes, cfg);
-		if (ret) {
-			dev_err(dev, "failed to create lane%d phy, %d\n",
-				id, ret);
-			goto err_node_put;
-		}
+	ret = qmp_pcie_create(dev, child, serdes, cfg);
+	if (ret)
+		goto err_node_put;
 
-		/*
-		 * Register the pipe clock provided by phy.
-		 * See function description to see details of this pipe clock.
-		 */
-		ret = phy_pipe_clk_register(qmp, child);
-		if (ret) {
-			dev_err(qmp->dev,
-				"failed to register pipe clock source\n");
-			goto err_node_put;
-		}
+	ret = phy_pipe_clk_register(qmp, child);
+	if (ret)
+		goto err_node_put;
 
-		id++;
-	}
+	of_node_put(child);
 
 	phy_provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
 
-- 
2.37.3

