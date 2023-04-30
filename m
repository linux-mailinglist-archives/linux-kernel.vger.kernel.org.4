Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 528736F28F4
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Apr 2023 14:54:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbjD3MyW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Apr 2023 08:54:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbjD3MyR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Apr 2023 08:54:17 -0400
Received: from hust.edu.cn (unknown [202.114.0.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F30B2D67;
        Sun, 30 Apr 2023 05:54:10 -0700 (PDT)
Received: from ubuntu.localdomain ([10.12.172.67])
        (user=saraday@hust.edu.cn mech=LOGIN bits=0)
        by mx1.hust.edu.cn  with ESMTP id 33UCr6nY027403-33UCr6na027403
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Sun, 30 Apr 2023 20:53:26 +0800
From:   Ziliang Liao <saraday@hust.edu.cn>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     hust-os-kernel-patches@googlegroups.com,
        Ziliang Liao <saraday@hust.edu.cn>,
        Dongliang Mu <dzm91@hust.edu.cn>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] bus: qcom-ebi2: simplify the code in qcom_ebi2_probe()
Date:   Sun, 30 Apr 2023 20:51:54 +0800
Message-Id: <20230430125154.126863-2-saraday@hust.edu.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230430125154.126863-1-saraday@hust.edu.cn>
References: <20230430125154.126863-1-saraday@hust.edu.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-FEAS-AUTH-USER: saraday@hust.edu.cn
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The code use platform_get_resource() and devm_ioremap_resource() to
allocate memory resources for the device. It can be simplified by using
devm_platform_ioremap_resource().

Fixes: 335a12754808 ("bus: qcom: add EBI2 driver")
Signed-off-by: Ziliang Liao <saraday@hust.edu.cn>
Reviewed-by: Dongliang Mu <dzm91@hust.edu.cn>
---
 drivers/bus/qcom-ebi2.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/bus/qcom-ebi2.c b/drivers/bus/qcom-ebi2.c
index 3999e969e1cf..bd419398d1c1 100644
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
@@ -315,14 +314,12 @@ static int qcom_ebi2_probe(struct platform_device *pdev)
 		return PTR_ERR(ebi2clk);
 	}
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	ebi2_base = devm_ioremap_resource(dev, res);
+	ebi2_base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(ebi2_base)) {
 		return PTR_ERR(ebi2_base);
 	}
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
-	ebi2_xmem = devm_ioremap_resource(dev, res);
+	ebi2_xmem = devm_platform_ioremap_resource(pdev, 1);
 	if (IS_ERR(ebi2_xmem)) {
 		return PTR_ERR(ebi2_xmem);
 	}
-- 
2.25.1

