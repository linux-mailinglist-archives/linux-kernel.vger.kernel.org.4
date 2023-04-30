Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2C286F28F2
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Apr 2023 14:54:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230319AbjD3MyJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Apr 2023 08:54:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230287AbjD3MyF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Apr 2023 08:54:05 -0400
Received: from hust.edu.cn (mail.hust.edu.cn [202.114.0.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 993D1271C;
        Sun, 30 Apr 2023 05:54:02 -0700 (PDT)
Received: from ubuntu.localdomain ([10.12.172.67])
        (user=saraday@hust.edu.cn mech=LOGIN bits=0)
        by mx1.hust.edu.cn  with ESMTP id 33UCr6nY027403-33UCr6nZ027403
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Sun, 30 Apr 2023 20:53:11 +0800
From:   Ziliang Liao <saraday@hust.edu.cn>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     hust-os-kernel-patches@googlegroups.com,
        Ziliang Liao <saraday@hust.edu.cn>,
        Dongliang Mu <dzm91@hust.edu.cn>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] bus: qcom-ebi2: use prefix devm for clock resource allocation functions
Date:   Sun, 30 Apr 2023 20:51:53 +0800
Message-Id: <20230430125154.126863-1-saraday@hust.edu.cn>
X-Mailer: git-send-email 2.25.1
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

Smatch reports:

drivers/bus/qcom-ebi2.c:387 qcom_ebi2_probe() warn: 'ebi2clk' from
clk_prepare_enable() not released on lines: 358.

drivers/bus/qcom-ebi2.c:387 qcom_ebi2_probe() warn: 'ebi2xclk' from
clk_prepare_enabled() not released on lines: 358.

The clk_disable_unprepare() is only used to explicitly release resources
when the qcom_ebi2_probe() fails, and when executed correctly, it may
cause resource leakage due to unknown release time.

Replace devm_clk_get() and clk_prepare_enable() with
devm_clk_get_enabled() to automatically manage the allocated resources.

Fixes: 335a12754808 ("bus: qcom: add EBI2 driver")
Signed-off-by: Ziliang Liao <saraday@hust.edu.cn>
Reviewed-by: Dongliang Mu <dzm91@hust.edu.cn>
---
The issue is found by static analyzer. The patched code has passed
Smatch checker, but remains untested on real device.

 drivers/bus/qcom-ebi2.c | 35 ++++++++---------------------------
 1 file changed, 8 insertions(+), 27 deletions(-)

diff --git a/drivers/bus/qcom-ebi2.c b/drivers/bus/qcom-ebi2.c
index c1fef1b4bd89..3999e969e1cf 100644
--- a/drivers/bus/qcom-ebi2.c
+++ b/drivers/bus/qcom-ebi2.c
@@ -303,40 +303,28 @@ static int qcom_ebi2_probe(struct platform_device *pdev)
 	u32 val;
 	int ret;
 
-	ebi2xclk = devm_clk_get(dev, "ebi2x");
-	if (IS_ERR(ebi2xclk))
+	ebi2xclk = devm_clk_get_enabled(dev, "ebi2x");
+	if (IS_ERR(ebi2xclk)) {
+		dev_err(dev, "could not enable EBI2X clk");
 		return PTR_ERR(ebi2xclk);
-
-	ret = clk_prepare_enable(ebi2xclk);
-	if (ret) {
-		dev_err(dev, "could not enable EBI2X clk (%d)\n", ret);
-		return ret;
 	}
 
-	ebi2clk = devm_clk_get(dev, "ebi2");
+	ebi2clk = devm_clk_get_enabled(dev, "ebi2");
 	if (IS_ERR(ebi2clk)) {
-		ret = PTR_ERR(ebi2clk);
-		goto err_disable_2x_clk;
-	}
-
-	ret = clk_prepare_enable(ebi2clk);
-	if (ret) {
-		dev_err(dev, "could not enable EBI2 clk\n");
-		goto err_disable_2x_clk;
+		dev_err(dev, "could not enable EBI2 clk");
+		return PTR_ERR(ebi2clk);
 	}
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	ebi2_base = devm_ioremap_resource(dev, res);
 	if (IS_ERR(ebi2_base)) {
-		ret = PTR_ERR(ebi2_base);
-		goto err_disable_clk;
+		return PTR_ERR(ebi2_base);
 	}
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
 	ebi2_xmem = devm_ioremap_resource(dev, res);
 	if (IS_ERR(ebi2_xmem)) {
-		ret = PTR_ERR(ebi2_xmem);
-		goto err_disable_clk;
+		return PTR_ERR(ebi2_xmem);
 	}
 
 	/* Allegedly this turns the power save mode off */
@@ -378,13 +366,6 @@ static int qcom_ebi2_probe(struct platform_device *pdev)
 	if (have_children)
 		return of_platform_default_populate(np, NULL, dev);
 	return 0;
-
-err_disable_clk:
-	clk_disable_unprepare(ebi2clk);
-err_disable_2x_clk:
-	clk_disable_unprepare(ebi2xclk);
-
-	return ret;
 }
 
 static const struct of_device_id qcom_ebi2_of_match[] = {
-- 
2.25.1

