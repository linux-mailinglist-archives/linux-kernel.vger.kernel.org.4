Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A88E6065BC
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 18:26:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbiJTQ0c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 12:26:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbiJTQ0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 12:26:21 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 228CB53A43;
        Thu, 20 Oct 2022 09:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666283179; x=1697819179;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cfcsEqumavJluV35nSU7Tp0DTMNCGeUslHFIyDpA79w=;
  b=k6yYxprOyXnObrgX+y0yBNIgTY6a2TvOh6r5M0Rn4CXf9rRVqbqR5tmC
   svPFdq2SLPPmw6+lUtSZXcYKDDj/heOdoEQN8qI6ruCMDsQdYb9i4xIu2
   0er5gTZ0BuFNy5lWUsojgl+BSfUUAGV6OJ3FzZ5PB5dDrocKE8Ct6Z7ru
   yoNof3sJggrEMynFdCX1sqd14XDBdiibirJrZR7YpYJ9HQBfX+cUjXEMJ
   b6qoZ0wZ+n//TlrhDk+BxsBfryPsaAgjOw/i6lVYetXALRzaSlNHGxnVr
   koaQxmrIvnoJcwV00m4yxdi+KwMNqEW23N9PjfJv9cAhVJoEz7PxUAxXn
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="287164940"
X-IronPort-AV: E=Sophos;i="5.95,199,1661842800"; 
   d="scan'208";a="287164940"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2022 09:26:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="581004360"
X-IronPort-AV: E=Sophos;i="5.95,199,1661842800"; 
   d="scan'208";a="581004360"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 20 Oct 2022 09:26:11 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id CD6346DC; Thu, 20 Oct 2022 19:26:32 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Mark Brown <broonie@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v3 4/5] spi: pxa2xx: Move OF and ACPI ID tables closer to their user
Date:   Thu, 20 Oct 2022 19:26:30 +0300
Message-Id: <20221020162631.68914-5-andriy.shevchenko@linux.intel.com>
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

