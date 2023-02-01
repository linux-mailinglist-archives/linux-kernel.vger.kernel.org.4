Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54F1368640B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 11:18:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232513AbjBAKR6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 05:17:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232018AbjBAKQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 05:16:35 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81E994E533;
        Wed,  1 Feb 2023 02:16:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DA34261756;
        Wed,  1 Feb 2023 10:16:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E55CAC4323E;
        Wed,  1 Feb 2023 10:16:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675246593;
        bh=DopQjRozUlqLm8kLLOiYmoJfcthKaCplFrQrtxG3j4o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y3t6mpcRXV0ZYGmIgJ8VKte6Xf6yMsefLMGHNVd5cR9LNCLofo3+VpLIGQ58jUjrQ
         kuyZhPev32rK9pmni6WgCf0cM4c6ZWGM3xQlaZQ+PD9UWhEYlRexFN4RXtf+t/16rV
         A9N+IR+FAU9CVOiZ79EX4GmkS/mHvmN1QfJ558IL52g5btRJaPXSAdhKxOAsynt0qH
         SEW0tLvqwzmqQrgIOJIC00K3fChnSvlvsJMFrmmSBSCjC0dbeAFj4/HuVYoA/Wj7L1
         8lUSVJGAj1covok8bXtFis5xVMvInuJEqCbxps55aSQu7j/wlVL4z4X500Opk8zzw5
         gBlsNepeoN3ow==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1pNAAg-00044D-4G; Wed, 01 Feb 2023 11:16:54 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Georgi Djakov <djakov@kernel.org>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        =?UTF-8?q?Artur=20=C5=9Awigo=C5=84?= <a.swigon@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>,
        Abel Vesa <abel.vesa@linaro.org>
Subject: [PATCH 13/23] interconnect: qcom: sm8550: fix registration race
Date:   Wed,  1 Feb 2023 11:15:49 +0100
Message-Id: <20230201101559.15529-14-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230201101559.15529-1-johan+linaro@kernel.org>
References: <20230201101559.15529-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current interconnect provider registration interface is inherently
racy as nodes are not added until the after adding the provider. This
can specifically cause racing DT lookups to fail.

Switch to using the new API where the provider is not registered until
after it has been fully initialised.

Fixes: e6f0d6a30f73 ("interconnect: qcom: Add SM8550 interconnect provider driver")
Cc: Abel Vesa <abel.vesa@linaro.org>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/interconnect/qcom/sm8550.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/interconnect/qcom/sm8550.c b/drivers/interconnect/qcom/sm8550.c
index 54fa027ab961..7ab492ca8fe0 100644
--- a/drivers/interconnect/qcom/sm8550.c
+++ b/drivers/interconnect/qcom/sm8550.c
@@ -2197,9 +2197,10 @@ static int qnoc_probe(struct platform_device *pdev)
 	provider->pre_aggregate = qcom_icc_pre_aggregate;
 	provider->aggregate = qcom_icc_aggregate;
 	provider->xlate_extended = qcom_icc_xlate_extended;
-	INIT_LIST_HEAD(&provider->nodes);
 	provider->data = data;
 
+	icc_provider_init(provider);
+
 	qp->dev = &pdev->dev;
 	qp->bcms = desc->bcms;
 	qp->num_bcms = desc->num_bcms;
@@ -2208,12 +2209,6 @@ static int qnoc_probe(struct platform_device *pdev)
 	if (IS_ERR(qp->voter))
 		return PTR_ERR(qp->voter);
 
-	ret = icc_provider_add(provider);
-	if (ret) {
-		dev_err_probe(&pdev->dev, ret,
-			      "error adding interconnect provider\n");
-		return ret;
-	}
 
 	for (i = 0; i < qp->num_bcms; i++)
 		qcom_icc_bcm_init(qp->bcms[i], &pdev->dev);
@@ -2227,7 +2222,7 @@ static int qnoc_probe(struct platform_device *pdev)
 		node = icc_node_create(qnodes[i]->id);
 		if (IS_ERR(node)) {
 			ret = PTR_ERR(node);
-			goto err;
+			goto err_remove_nodes;
 		}
 
 		node->name = qnodes[i]->name;
@@ -2241,12 +2236,17 @@ static int qnoc_probe(struct platform_device *pdev)
 	}
 	data->num_nodes = num_nodes;
 
+	ret = icc_provider_register(provider);
+	if (ret)
+		goto err_remove_nodes;
+
 	platform_set_drvdata(pdev, qp);
 
 	return 0;
-err:
+
+err_remove_nodes:
 	icc_nodes_remove(provider);
-	icc_provider_del(provider);
+
 	return ret;
 }
 
@@ -2254,8 +2254,8 @@ static int qnoc_remove(struct platform_device *pdev)
 {
 	struct qcom_icc_provider *qp = platform_get_drvdata(pdev);
 
+	icc_provider_deregister(&qp->provider);
 	icc_nodes_remove(&qp->provider);
-	icc_provider_del(&qp->provider);
 
 	return 0;
 }
-- 
2.39.1

