Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 031BF606919
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 21:45:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbiJTTpI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 15:45:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbiJTTou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 15:44:50 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F190B495EF;
        Thu, 20 Oct 2022 12:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666295088; x=1697831088;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mvA9eCR+rKOtsB1zGltIo6l+ymy8s9rrgGnqv92uqD8=;
  b=aQLuDej1GSBC/RbxkcAjLL/O17aRqZD0FTpYURy1CMVnfd9P8ceCTks0
   HIKKEQ/3235MskZq2ZP+MUztUERpSWYZ6F+LiTvr931fo1FVLFlEOEstc
   SSInQ4zrwDkiJAMZtvJ90CxkKMhXTwpFCRGYtrc/EDPqQ7Q5ZBGrohhrR
   fQdPddrPLf6cMm7UL7u7Sy4s2ICeN372XrheSf6QPVpD7bUyDx65phaiG
   vT7ma/vX8+8a/gJyxWXPkY2tfvhXPW2Nd4QzuCb2P9Zm4CCVJXNaUQ2zz
   j0z1kCZNu91/P9Wa++PJotAyjyU+t4hhUkmx4S5ldu+XCT5r+G8PqNIBU
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="333392708"
X-IronPort-AV: E=Sophos;i="5.95,199,1661842800"; 
   d="scan'208";a="333392708"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2022 12:44:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="875210365"
X-IronPort-AV: E=Sophos;i="5.95,199,1661842800"; 
   d="scan'208";a="875210365"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 20 Oct 2022 12:44:42 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 0502B4FD; Thu, 20 Oct 2022 22:45:03 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Mark Brown <broonie@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v4 3/5] spi: pxa2xx: Move OF and ACPI ID tables closer to their user
Date:   Thu, 20 Oct 2022 22:44:58 +0300
Message-Id: <20221020194500.10225-4-andriy.shevchenko@linux.intel.com>
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
index 96c9bb7925de..0824965e894d 100644
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
@@ -1765,6 +1746,25 @@ static const struct dev_pm_ops pxa2xx_spi_pm_ops = {
 			   pxa2xx_spi_runtime_resume, NULL)
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

