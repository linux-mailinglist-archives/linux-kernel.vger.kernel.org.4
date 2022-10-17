Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D363160146D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 19:13:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230059AbiJQRMs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 13:12:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbiJQRMc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 13:12:32 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A1916C12C;
        Mon, 17 Oct 2022 10:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666026752; x=1697562752;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ADkxelsrZAI/xTgM7q/ZgWlu+FGtliIPT22gKCweeCM=;
  b=N0VcCb31/R50pCWXM8xRpfSFtwK/9Zccn4bIG8qvMP1cn/DnZKhsVQ6x
   AQdZenamRL96Jn6zMYSX6Mc/dlK1xkNttPOMXxJLeF3F0lXlzDrbhkXqh
   LrK6IiHJfzaR4aOrF+kaHtt260jcv3E3KTCgGSn/7DTPxBFRQciJbTZPR
   92n/fLGCYGYG00N4epWHHgrz0DEdL8v1/ToaNsNbqhOIsi9qVfBsRqNwa
   caRH2azvxu/hwPNgpkCWfR0ugtbs0bRI1iPr8e00YQ5EWWFx9PVPRPqJS
   bRXnBk8JiM3HeNpQNVhiW7QGNivKieGwAbJJuaSIPNTUh5Eo33DhbMxQv
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10503"; a="305849468"
X-IronPort-AV: E=Sophos;i="5.95,192,1661842800"; 
   d="scan'208";a="305849468"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2022 10:12:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10503"; a="957417124"
X-IronPort-AV: E=Sophos;i="5.95,192,1661842800"; 
   d="scan'208";a="957417124"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 17 Oct 2022 10:12:29 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 3123D26D; Mon, 17 Oct 2022 20:12:51 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH v1 5/6] spi: pxa2xx: Move OF and ACPI ID tables closer to their user
Date:   Mon, 17 Oct 2022 20:12:42 +0300
Message-Id: <20221017171243.57078-5-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221017171243.57078-1-andriy.shevchenko@linux.intel.com>
References: <20221017171243.57078-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
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

