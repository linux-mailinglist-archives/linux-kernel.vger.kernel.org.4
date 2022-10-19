Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2227604AD8
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 17:12:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232277AbiJSPMY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 11:12:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231755AbiJSPL7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 11:11:59 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A6AF33E00;
        Wed, 19 Oct 2022 08:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666191886; x=1697727886;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ADkxelsrZAI/xTgM7q/ZgWlu+FGtliIPT22gKCweeCM=;
  b=jLJil0CfGyR+xXapkSHN+BRKj6ua3n63A5TQ4VKTXFyt2k6utUmaNZ3x
   PQ9S7muznqk3IfU0d+WiloGZ/12Ian+GtrHOZnll9T6kQnjI2ExSrI/mx
   Eiwaw+LCyt2PSV8zwZWM8WFfHzWjPAUHy3nxdGTpolReEppR1Gwmt4e7u
   /JgGrYKTCN4TXZganaEw1U59ks2VxkneW9Ex2o1qULtpPE4XruCYg6DBy
   9hRcE5z38xWtoUzcBPrb3FDstyGGvcKJLqrrh4i+8R3fIk4nQ+tX5veNM
   gS1jPUJLx/gogYVLWTK2uTnESnV3QOIrkpnTw5WWejqE61YDIVJd8rZ4d
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10505"; a="305170525"
X-IronPort-AV: E=Sophos;i="5.95,196,1661842800"; 
   d="scan'208";a="305170525"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2022 08:04:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10505"; a="607135196"
X-IronPort-AV: E=Sophos;i="5.95,196,1661842800"; 
   d="scan'208";a="607135196"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 19 Oct 2022 08:04:12 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id B73F620B; Wed, 19 Oct 2022 18:04:33 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH v2 4/5] spi: pxa2xx: Move OF and ACPI ID tables closer to their user
Date:   Wed, 19 Oct 2022 18:04:29 +0300
Message-Id: <20221019150430.27142-5-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221019150430.27142-1-andriy.shevchenko@linux.intel.com>
References: <20221019150430.27142-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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
---
 drivers/spi/spi-pxa2xx.c | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 31927493eeb0..76046612466d 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -1321,25 +1321,6 @@ static void cleanup(struct spi_device *spi)
 	kfree(chip);
 }
 
-#ifdef CONFIG_ACPI
-static const struct acpi_device_id pxa2xx_spi_acpi_match[] = {
-	{ "INT33C0" },
-	{ "INT33C1" },
-	{ "INT3430" },
-	{ "INT3431" },
-	{ "80860F0E" },
-	{ "8086228E" },
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
@@ -1759,6 +1740,25 @@ static const struct dev_pm_ops pxa2xx_spi_pm_ops = {
 			   pxa2xx_spi_runtime_resume, NULL)
 };
 
+#ifdef CONFIG_ACPI
+static const struct acpi_device_id pxa2xx_spi_acpi_match[] = {
+	{ "80860F0E" },
+	{ "8086228E" },
+	{ "INT33C0" },
+	{ "INT33C1" },
+	{ "INT3430" },
+	{ "INT3431" },
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

