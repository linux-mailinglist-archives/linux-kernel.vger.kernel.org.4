Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C4BE607E8A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 21:00:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230235AbiJUTAu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 15:00:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230089AbiJUTAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 15:00:20 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05FCB13C1FC;
        Fri, 21 Oct 2022 12:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666378814; x=1697914814;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=epUZWl24Whc6/mF0K7H32C3+H5vtLX0wA/mFXmwrq9w=;
  b=hjww3bd1Sa0AmD6E7Auu1qJKOsr3tUB+Eum9BaE7Tt3kh6BE52t9Z5v2
   zgfEYI60O8OYJickJn9Xy+S979KGnGWyyzfOByKIqz4fxl5lntfDi9SMe
   J1mn76ct1wPZxndu06ELugqnizD0p7n8bHePUYFjvg5hQ0GWPTrZ/N3eg
   Wk+0j8E0n1qv9q1gE3GLN2p/SDL67+CRviTzG24JRtDpuNV0SDP0N0bSY
   ZIaDjPpyO1I2Wv5HOtk+v5UnmyRnQnJF4hz/vumHTK2NeXhC706pUhN0r
   atX9WY8fcUO0eBRhWSgxlHM6lJVCz8dRLOu7UrKFJWJUkFqPgi7XvQtYJ
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10507"; a="307071106"
X-IronPort-AV: E=Sophos;i="5.95,202,1661842800"; 
   d="scan'208";a="307071106"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2022 12:00:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10507"; a="875798625"
X-IronPort-AV: E=Sophos;i="5.95,202,1661842800"; 
   d="scan'208";a="875798625"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 21 Oct 2022 12:00:01 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id F06C43F9; Fri, 21 Oct 2022 22:00:22 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v5 4/4] spi: pxa2xx: Move OF and ACPI ID tables closer to their user
Date:   Fri, 21 Oct 2022 22:00:18 +0300
Message-Id: <20221021190018.63646-5-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221021190018.63646-1-andriy.shevchenko@linux.intel.com>
References: <20221021190018.63646-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no code that uses ID tables directly, except the
struct device_driver at the end of the file. Hence, move
tables closer to its user. It's always possible to access
them via pointer to a platform device.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/spi/spi-pxa2xx.c | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 38b8af8a9c12..32cc82a89ec1 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -1321,25 +1321,6 @@ static void cleanup(struct spi_device *spi)
 	kfree(chip);
 }
 
-#ifdef CONFIG_ACPI
-static const struct acpi_device_id pxa2xx_spi_acpi_match[] = {
-	{ "INT33C0", LPSS_LPT_SSP },
-	{ "INT33C1", LPSS_LPT_SSP },
-	{ "INT3430", LPSS_LPT_SSP },
-	{ "INT3431", LPSS_LPT_SSP },
-	{ "80860F0E", LPSS_BYT_SSP },
-	{ "8086228E", LPSS_BSW_SSP },
-	{ },
-};
-MODULE_DEVICE_TABLE(acpi, pxa2xx_spi_acpi_match);
-#endif
-
-static const struct of_device_id pxa2xx_spi_of_match[] = {
-	{ .compatible = "marvell,mmp2-ssp", .data = (void *)MMP2_SSP },
-	{},
-};
-MODULE_DEVICE_TABLE(of, pxa2xx_spi_of_match);
-
 static bool pxa2xx_spi_idma_filter(struct dma_chan *chan, void *param)
 {
 	return param == chan->device->dev;
@@ -1762,6 +1743,25 @@ static const struct dev_pm_ops pxa2xx_spi_pm_ops = {
 	RUNTIME_PM_OPS(pxa2xx_spi_runtime_suspend, pxa2xx_spi_runtime_resume, NULL)
 };
 
+#ifdef CONFIG_ACPI
+static const struct acpi_device_id pxa2xx_spi_acpi_match[] = {
+	{ "80860F0E", LPSS_BYT_SSP },
+	{ "8086228E", LPSS_BSW_SSP },
+	{ "INT33C0", LPSS_LPT_SSP },
+	{ "INT33C1", LPSS_LPT_SSP },
+	{ "INT3430", LPSS_LPT_SSP },
+	{ "INT3431", LPSS_LPT_SSP },
+	{}
+};
+MODULE_DEVICE_TABLE(acpi, pxa2xx_spi_acpi_match);
+#endif
+
+static const struct of_device_id pxa2xx_spi_of_match[] = {
+	{ .compatible = "marvell,mmp2-ssp", .data = (void *)MMP2_SSP },
+	{}
+};
+MODULE_DEVICE_TABLE(of, pxa2xx_spi_of_match);
+
 static struct platform_driver driver = {
 	.driver = {
 		.name	= "pxa2xx-spi",
-- 
2.35.1

