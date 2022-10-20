Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F6A160691B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 21:45:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbiJTTpZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 15:45:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbiJTTpP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 15:45:15 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13C4765255;
        Thu, 20 Oct 2022 12:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666295106; x=1697831106;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=InX6kdnk54UP7BwE44PrXA1cQrsW+VErocObGJ8rYEU=;
  b=WtlUhxKr9cOAko0S7A2PD3tHUdr5CAyfpfy3qWh6OTbkQWIa+V3WUfBs
   SCgPD9D/zWUEo61qki6aRFILML5j34nbqFoTM+xrS8gOZyZ7QF5RGFzcA
   qhxmSBHq+WqkMyPw+vDjdbv+9IgMqfnXSe1ajzYb0oEvdkA/al3farv6y
   Ras7RYmL6CLo47heS0bk2pWP5Q/TsNaHJAKV4jOq74S4B6yztqh2u62Ss
   e2iivQ7fSIUG7Z3obx+ZpLnf03a9uTJZMM2gHpyW8utswdHcr+rm0xUTZ
   F3K468O70pEWrUcWG4Qeepdfe+bSsDCT4Joq40qEs01V6I7DOb60EFp/6
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="333392718"
X-IronPort-AV: E=Sophos;i="5.95,199,1661842800"; 
   d="scan'208";a="333392718"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2022 12:44:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="875210384"
X-IronPort-AV: E=Sophos;i="5.95,199,1661842800"; 
   d="scan'208";a="875210384"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 20 Oct 2022 12:44:45 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 1AEEA6DC; Thu, 20 Oct 2022 22:45:04 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Mark Brown <broonie@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v4 5/5] spi: pxa2xx: Switch from PM ifdeffery to pm_ptr()
Date:   Thu, 20 Oct 2022 22:45:00 +0300
Message-Id: <20221020194500.10225-6-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221020194500.10225-1-andriy.shevchenko@linux.intel.com>
References: <20221020194500.10225-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
index 00c07e93d414..d47c14c89ff4 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -1686,7 +1686,6 @@ static int pxa2xx_spi_remove(struct platform_device *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int pxa2xx_spi_suspend(struct device *dev)
 {
 	struct driver_data *drv_data = dev_get_drvdata(dev);
@@ -1721,9 +1720,7 @@ static int pxa2xx_spi_resume(struct device *dev)
 	/* Start the queue running */
 	return spi_controller_resume(drv_data->controller);
 }
-#endif
 
-#ifdef CONFIG_PM
 static int pxa2xx_spi_runtime_suspend(struct device *dev)
 {
 	struct driver_data *drv_data = dev_get_drvdata(dev);
@@ -1738,12 +1735,10 @@ static int pxa2xx_spi_runtime_resume(struct device *dev)
 
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
@@ -1768,7 +1763,7 @@ MODULE_DEVICE_TABLE(of, pxa2xx_spi_of_match);
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

