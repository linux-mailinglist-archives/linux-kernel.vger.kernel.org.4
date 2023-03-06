Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE4976ACC9A
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 19:30:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbjCFSat (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 13:30:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbjCFSak (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 13:30:40 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C38A8301B1;
        Mon,  6 Mar 2023 10:30:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678127439; x=1709663439;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JPcoNFmGiGsUtQhMFEvvIYMF9pcbCxGWNO7kulXjTb8=;
  b=aSvqLyRk71r2sJ6t7kut+GYRtZY5OUqQCLQFdVYw+++yfbVTfC/lIe1p
   tlW1ekO7kVwdFnistDQZJ7/j6HBUsD5YxcFxZsO4xkwmerp4aj1+m8iJu
   NBJxCodcsvW73TIyuyMqFNWf3lbqLmnyuZgs09aK9D+v032vR3C8Bjh2y
   l0swk32RSABE4BfDAvUlH+eKEKpk1nZeN7QnmoW81oCbXbfL5On0QHn8i
   nHTwwAHOYiWis5A0PbwTxUF1tJxtcANHr/c/Y8AVERWJOswsB0PB2hlNX
   AHHJ1MT2raJePuK3AZV/bqX5SJy87LtNctF63zH6r6e5r9S05Dzbw741c
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="333109225"
X-IronPort-AV: E=Sophos;i="5.98,238,1673942400"; 
   d="scan'208";a="333109225"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2023 10:30:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="669559043"
X-IronPort-AV: E=Sophos;i="5.98,238,1673942400"; 
   d="scan'208";a="669559043"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 06 Mar 2023 10:30:36 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 76B25354; Mon,  6 Mar 2023 20:31:19 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 3/5] spi: mpc5xxx-psc: use devm_clk_get_enabled() for core clock
Date:   Mon,  6 Mar 2023 20:31:13 +0200
Message-Id: <20230306183115.87314-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230306183115.87314-1-andriy.shevchenko@linux.intel.com>
References: <20230306183115.87314-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_clk_get_enabled() to simplify the code.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi-mpc512x-psc.c | 39 ++++-------------------------------
 1 file changed, 4 insertions(+), 35 deletions(-)

diff --git a/drivers/spi/spi-mpc512x-psc.c b/drivers/spi/spi-mpc512x-psc.c
index 8a436d1906eb..739df2b241e9 100644
--- a/drivers/spi/spi-mpc512x-psc.c
+++ b/drivers/spi/spi-mpc512x-psc.c
@@ -54,8 +54,6 @@ struct mpc512x_psc_spi {
 	struct mpc512x_psc_fifo __iomem *fifo;
 	unsigned int irq;
 	u8 bits_per_word;
-	struct clk *clk_mclk;
-	struct clk *clk_ipg;
 	u32 mclk_rate;
 
 	struct completion txisrdone;
@@ -499,25 +497,15 @@ static int mpc512x_psc_spi_of_probe(struct platform_device *pdev)
 		return ret;
 	init_completion(&mps->txisrdone);
 
-	clk = devm_clk_get(dev, "mclk");
+	clk = devm_clk_get_enabled(dev, "mclk");
 	if (IS_ERR(clk))
 		return PTR_ERR(clk);
 
-	ret = clk_prepare_enable(clk);
-	if (ret)
-		return ret;
-	mps->clk_mclk = clk;
 	mps->mclk_rate = clk_get_rate(clk);
 
-	clk = devm_clk_get(dev, "ipg");
-	if (IS_ERR(clk)) {
-		ret = PTR_ERR(clk);
-		goto free_mclk_clock;
-	}
-	ret = clk_prepare_enable(clk);
-	if (ret)
-		goto free_mclk_clock;
-	mps->clk_ipg = clk;
+	clk = devm_clk_get_enabled(dev, "ipg");
+	if (IS_ERR(clk))
+		return PTR_ERR(clk);
 
 	ret = mpc512x_psc_spi_port_config(master, mps);
 	if (ret < 0)
@@ -528,24 +516,6 @@ static int mpc512x_psc_spi_of_probe(struct platform_device *pdev)
 		goto free_ipg_clock;
 
 	return ret;
-
-free_ipg_clock:
-	clk_disable_unprepare(mps->clk_ipg);
-free_mclk_clock:
-	clk_disable_unprepare(mps->clk_mclk);
-
-	return ret;
-}
-
-static int mpc512x_psc_spi_of_remove(struct platform_device *pdev)
-{
-	struct spi_master *master = dev_get_drvdata(&pdev->dev);
-	struct mpc512x_psc_spi *mps = spi_master_get_devdata(master);
-
-	clk_disable_unprepare(mps->clk_mclk);
-	clk_disable_unprepare(mps->clk_ipg);
-
-	return 0;
 }
 
 static const struct of_device_id mpc512x_psc_spi_of_match[] = {
@@ -558,7 +528,6 @@ MODULE_DEVICE_TABLE(of, mpc512x_psc_spi_of_match);
 
 static struct platform_driver mpc512x_psc_spi_of_driver = {
 	.probe = mpc512x_psc_spi_of_probe,
-	.remove = mpc512x_psc_spi_of_remove,
 	.driver = {
 		.name = "mpc512x-psc-spi",
 		.of_match_table = mpc512x_psc_spi_of_match,
-- 
2.39.1

