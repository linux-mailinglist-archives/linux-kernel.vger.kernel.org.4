Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA2356112FF
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 15:37:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231215AbiJ1NhU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 09:37:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230371AbiJ1Ngv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 09:36:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D5F91D8F03;
        Fri, 28 Oct 2022 06:36:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A04E262886;
        Fri, 28 Oct 2022 13:36:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD7B2C43470;
        Fri, 28 Oct 2022 13:36:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666964208;
        bh=3R9BPW6QSUhhXBNcO5z3mLwkQgvqyw63TThHmZ5QLXM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R2wDTLBefPKWZu1r7cjfbTWE5jvgEbEvuMgfOU2viChfnBuJsfqUsx+C4Yx+Ex2jN
         T057xObRhaCEhMyWALpPBvQpaQng0VxmoZS798kyiglzf2JPlJrKhzFtS2qEIooFPK
         v34xY4VOLhfm77VnzlsHRSVJXGuNjD2mLW666xbdNFLREfX39+SRctd1RYfswAK0Gg
         eq3k4Djf9XIQUCLsLuK1SkXFsxg2+TVHb8mtIfjhY4VRv+RADQ0PI5Tz54DAiVD5gx
         67pOdTaLnCW5ykLV+uyaC9d+i4iZb5mtgdGvz9nxJWqpRJ4LxN/yQ9M/k/JeAfAGXz
         GjT9DU8bJ4lig==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1ooPXH-0004r1-5H; Fri, 28 Oct 2022 15:36:35 +0200
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
Subject: [PATCH v4 04/16] phy: qcom-qmp-pcie: clean up device-tree parsing
Date:   Fri, 28 Oct 2022 15:35:51 +0200
Message-Id: <20221028133603.18470-5-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221028133603.18470-1-johan+linaro@kernel.org>
References: <20221028133603.18470-1-johan+linaro@kernel.org>
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

