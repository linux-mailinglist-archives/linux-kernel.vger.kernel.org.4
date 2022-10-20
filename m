Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 005686065BD
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 18:26:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbiJTQ0f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 12:26:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbiJTQ0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 12:26:22 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CBA01372BF;
        Thu, 20 Oct 2022 09:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666283181; x=1697819181;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0AkAdKQ3EDQm469XbLB15BS+d5aKGhLhD/NPpezR/co=;
  b=JgD/1XJ9qcDuj7U3kWpOQ7I6cCKpwXssVqmYJ50/WeXrSNOALpXzp+b3
   ZNhFCz43Ss0EgVe2MlanWI6hsyL0Mya6vu7UkE2CTKY21Tx7kl9Zn7yYS
   +11Tms/GUkj/sTAoeSB1s3KyZgo2AY1MmdCPTUW0lDoEiatQv2kkeaDFc
   06EGE6kxhO+jZfTurrGYYl9kqMRWZ5IOuMqKVP6L03gAEuCoYZ4itq5BJ
   cRShA8nDQHBB2JCAkn310yK30y8ukPwXSFoClKr0R4LHx27c730IQAbIt
   MnW9O08zK0Kfsrd1nvAIf2QVjL2coP9t2ZLgf7MvKMKmk6h2keP6cKlvM
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="287164950"
X-IronPort-AV: E=Sophos;i="5.95,199,1661842800"; 
   d="scan'208";a="287164950"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2022 09:26:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="581004389"
X-IronPort-AV: E=Sophos;i="5.95,199,1661842800"; 
   d="scan'208";a="581004389"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 20 Oct 2022 09:26:14 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id D31EF6DA; Thu, 20 Oct 2022 19:26:32 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Mark Brown <broonie@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v3 5/5] spi: pxa2xx: Switch from PM ifdeffery to pm_ptr()
Date:   Thu, 20 Oct 2022 19:26:31 +0300
Message-Id: <20221020162631.68914-6-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221020162631.68914-1-andriy.shevchenko@linux.intel.com>
References: <20221020162631.68914-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cleaning up the driver to use pm_ptr() macro instead of ifdeffery
that makes it simpler and allows the compiler to remove those functions
if built without CONFIG_PM and CONFIG_PM_SLEEP support.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/spi/spi-pxa2xx.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 76046612466d..60cab241200b 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -1680,7 +1680,6 @@ static int pxa2xx_spi_remove(struct platform_device *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int pxa2xx_spi_suspend(struct device *dev)
 {
 	struct driver_data *drv_data = dev_get_drvdata(dev);
@@ -1715,9 +1714,7 @@ static int pxa2xx_spi_resume(struct device *dev)
 	/* Start the queue running */
 	return spi_controller_resume(drv_data->controller);
 }
-#endif
 
-#ifdef CONFIG_PM
 static int pxa2xx_spi_runtime_suspend(struct device *dev)
 {
 	struct driver_data *drv_data = dev_get_drvdata(dev);
@@ -1732,12 +1729,10 @@ static int pxa2xx_spi_runtime_resume(struct device *dev)
 
 	return clk_prepare_enable(drv_data->ssp->clk);
 }
-#endif
 
 static const struct dev_pm_ops pxa2xx_spi_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(pxa2xx_spi_suspend, pxa2xx_spi_resume)
-	SET_RUNTIME_PM_OPS(pxa2xx_spi_runtime_suspend,
-			   pxa2xx_spi_runtime_resume, NULL)
+	SYSTEM_SLEEP_PM_OPS(pxa2xx_spi_suspend, pxa2xx_spi_resume)
+	RUNTIME_PM_OPS(pxa2xx_spi_runtime_suspend, pxa2xx_spi_runtime_resume, NULL)
 };
 
 #ifdef CONFIG_ACPI
@@ -1762,7 +1757,7 @@ MODULE_DEVICE_TABLE(of, pxa2xx_spi_of_match);
 static struct platform_driver driver = {
 	.driver = {
 		.name	= "pxa2xx-spi",
-		.pm	= &pxa2xx_spi_pm_ops,
+		.pm	= pm_ptr(&pxa2xx_spi_pm_ops),
 		.acpi_match_table = ACPI_PTR(pxa2xx_spi_acpi_match),
 		.of_match_table = of_match_ptr(pxa2xx_spi_of_match),
 	},
-- 
2.35.1

