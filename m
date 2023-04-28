Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7AE06F1200
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 08:52:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345297AbjD1GwT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 02:52:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345379AbjD1GwR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 02:52:17 -0400
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A204E1FFB;
        Thu, 27 Apr 2023 23:52:15 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R431e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VhAKGsB_1682664731;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0VhAKGsB_1682664731)
          by smtp.aliyun-inc.com;
          Fri, 28 Apr 2023 14:52:12 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     agross@kernel.org
Cc:     andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH -next] bus: qcom: Use devm_platform_ioremap_resource()
Date:   Fri, 28 Apr 2023 14:52:10 +0800
Message-Id: <20230428065210.30095-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert platform_get_resource(),devm_ioremap_resource() to a single
call to devm_platform_ioremap_resource(), as this is exactly what this
function does.

Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/bus/qcom-ebi2.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/bus/qcom-ebi2.c b/drivers/bus/qcom-ebi2.c
index c1fef1b4bd89..01e76bb05218 100644
--- a/drivers/bus/qcom-ebi2.c
+++ b/drivers/bus/qcom-ebi2.c
@@ -294,7 +294,6 @@ static int qcom_ebi2_probe(struct platform_device *pdev)
 	struct device_node *np = pdev->dev.of_node;
 	struct device_node *child;
 	struct device *dev = &pdev->dev;
-	struct resource *res;
 	void __iomem *ebi2_base;
 	void __iomem *ebi2_xmem;
 	struct clk *ebi2xclk;
@@ -325,15 +324,13 @@ static int qcom_ebi2_probe(struct platform_device *pdev)
 		goto err_disable_2x_clk;
 	}
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	ebi2_base = devm_ioremap_resource(dev, res);
+	ebi2_base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(ebi2_base)) {
 		ret = PTR_ERR(ebi2_base);
 		goto err_disable_clk;
 	}
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
-	ebi2_xmem = devm_ioremap_resource(dev, res);
+	ebi2_xmem = devm_platform_ioremap_resource(pdev, 1);
 	if (IS_ERR(ebi2_xmem)) {
 		ret = PTR_ERR(ebi2_xmem);
 		goto err_disable_clk;
-- 
2.20.1.7.g153144c

