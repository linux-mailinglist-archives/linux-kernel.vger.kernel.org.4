Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F77964902D
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Dec 2022 19:36:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbiLJSgt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Dec 2022 13:36:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiLJSgr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Dec 2022 13:36:47 -0500
Received: from smtp.smtpout.orange.fr (smtp-28.smtpout.orange.fr [80.12.242.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EB3417412
        for <linux-kernel@vger.kernel.org>; Sat, 10 Dec 2022 10:36:46 -0800 (PST)
Received: from pop-os.home ([86.243.100.34])
        by smtp.orange.fr with ESMTPA
        id 44iJpNwaA1SdM44iJpAGuk; Sat, 10 Dec 2022 19:36:44 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 10 Dec 2022 19:36:44 +0100
X-ME-IP: 86.243.100.34
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Tony Huang <tonyhuang.sunplus@gmail.com>,
        Li-hao Kuo <lhjeff911@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-mmc@vger.kernel.org
Subject: [PATCH 1/3] mmc: sunlpus: Fix an error handling path in spmmc_drv_probe()
Date:   Sat, 10 Dec 2022 19:36:37 +0100
Message-Id: <7c686fecb11b4ec1f55cd7075dc7cfcdd9b445ba.1670697358.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If an error occurs after successful clk_prepare_enable() call in the probe,
the clk is not clk_disable_unprepare()'ed.

Use devm_clk_get_enabled() instead of devm_clk_get() to fix, and simplify
the probe and the remove function accordingly.

Fixes: 4e268fed8b18 ("mmc: Add mmc driver for Sunplus SP7021")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
This changes the order of resource releasing when the driver is removed,
but it looks ok to me.
---
 drivers/mmc/host/sunplus-mmc.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/mmc/host/sunplus-mmc.c b/drivers/mmc/host/sunplus-mmc.c
index db5e0dcdfa7f..3e8856a82188 100644
--- a/drivers/mmc/host/sunplus-mmc.c
+++ b/drivers/mmc/host/sunplus-mmc.c
@@ -878,7 +878,7 @@ static int spmmc_drv_probe(struct platform_device *pdev)
 	if (IS_ERR(host->base))
 		return PTR_ERR(host->base);
 
-	host->clk = devm_clk_get(&pdev->dev, NULL);
+	host->clk = devm_clk_get_enabled(&pdev->dev, NULL);
 	if (IS_ERR(host->clk))
 		return dev_err_probe(&pdev->dev, PTR_ERR(host->clk), "clk get fail\n");
 
@@ -896,10 +896,6 @@ static int spmmc_drv_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	ret = clk_prepare_enable(host->clk);
-	if (ret)
-		return dev_err_probe(&pdev->dev, ret, "failed to enable clk\n");
-
 	ret = mmc_of_parse(mmc);
 	if (ret)
 		goto probe_free_host;
@@ -944,7 +940,6 @@ static int spmmc_drv_remove(struct platform_device *dev)
 
 	mmc_remove_host(host->mmc);
 	pm_runtime_get_sync(&dev->dev);
-	clk_disable_unprepare(host->clk);
 	pm_runtime_put_noidle(&dev->dev);
 	pm_runtime_disable(&dev->dev);
 	platform_set_drvdata(dev, NULL);
-- 
2.34.1

