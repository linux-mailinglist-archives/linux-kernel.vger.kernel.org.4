Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7231C64C862
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 12:49:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238079AbiLNLtY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 06:49:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbiLNLtV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 06:49:21 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21A94313;
        Wed, 14 Dec 2022 03:49:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671018561; x=1702554561;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=SVgFMAfjfuxrKEN25v+tJjLoBKU5Ql7lsjAKQ0yd+gs=;
  b=LVVlYe+8uTnb+ltN+WI8PNlXeO7OuaAwtQYpLhXRzdiS2JvWZ8clAo+J
   aAITRJUzzoAzf60+dYZqlFf84RWh5K6Y64JElWo43q8E+bnCK5R0mpLVO
   RBy931XLUdG2NcEEMFw0kwxgHs4EvzueruwgF65DwzsU3U+R5XXyKXKnt
   zoD7kNAJGo31Mn6HK2hYJIV5OrO8V1fnG+cVUt+TyRxt31hTKBirHQOcX
   tjJeUw8YEacY7kwan3uofGDDa/RRYSQQgjPRCOJCVnXeLnlaPjlmNgiNq
   0FM+Ow8HIePM6oi1ni5oS7BGD5J9qS/O2X8L3VWq2W+v4/4fJnnd8KSCx
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10560"; a="316017147"
X-IronPort-AV: E=Sophos;i="5.96,244,1665471600"; 
   d="scan'208";a="316017147"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2022 03:49:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10560"; a="977805633"
X-IronPort-AV: E=Sophos;i="5.96,244,1665471600"; 
   d="scan'208";a="977805633"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 14 Dec 2022 03:49:19 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 46BA5F7; Wed, 14 Dec 2022 13:49:48 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v1 1/2] iio: adc: ti-adc128s052: Switch to use spi_get_device_match_data()
Date:   Wed, 14 Dec 2022 13:49:43 +0200
Message-Id: <20221214114944.83790-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The spi_get_device_match_data() helps to get driver data from the
firmware node or SPI ID table. Use it instead of open coding.

While at it, switch ID tables to provide an acrual pointers to
the configuration data.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---

Requires aea672d054a2 ("spi: Introduce spi_get_device_match_data()
helper") which is part of upstream as of today.

 drivers/iio/adc/ti-adc128s052.c | 39 +++++++++++++++------------------
 1 file changed, 18 insertions(+), 21 deletions(-)

diff --git a/drivers/iio/adc/ti-adc128s052.c b/drivers/iio/adc/ti-adc128s052.c
index b3d5b9b7255b..9dfc625100b6 100644
--- a/drivers/iio/adc/ti-adc128s052.c
+++ b/drivers/iio/adc/ti-adc128s052.c
@@ -139,16 +139,11 @@ static void adc128_disable_regulator(void *reg)
 
 static int adc128_probe(struct spi_device *spi)
 {
+	const struct adc128_configuration *config;
 	struct iio_dev *indio_dev;
-	unsigned int config;
 	struct adc128 *adc;
 	int ret;
 
-	if (dev_fwnode(&spi->dev))
-		config = (unsigned long) device_get_match_data(&spi->dev);
-	else
-		config = spi_get_device_id(spi)->driver_data;
-
 	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*adc));
 	if (!indio_dev)
 		return -ENOMEM;
@@ -160,6 +155,8 @@ static int adc128_probe(struct spi_device *spi)
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->info = &adc128_info;
 
+	config = spi_get_device_match_data(&spi->dev);
+
 	indio_dev->channels = adc128_config[config].channels;
 	indio_dev->num_channels = adc128_config[config].num_channels;
 
@@ -181,32 +178,32 @@ static int adc128_probe(struct spi_device *spi)
 }
 
 static const struct of_device_id adc128_of_match[] = {
-	{ .compatible = "ti,adc128s052", .data = (void*)0L, },
-	{ .compatible = "ti,adc122s021", .data = (void*)1L, },
-	{ .compatible = "ti,adc122s051", .data = (void*)1L, },
-	{ .compatible = "ti,adc122s101", .data = (void*)1L, },
-	{ .compatible = "ti,adc124s021", .data = (void*)2L, },
-	{ .compatible = "ti,adc124s051", .data = (void*)2L, },
-	{ .compatible = "ti,adc124s101", .data = (void*)2L, },
+	{ .compatible = "ti,adc128s052", .data = &adc128_config[0] },
+	{ .compatible = "ti,adc122s021", .data = &adc128_config[1] },
+	{ .compatible = "ti,adc122s051", .data = &adc128_config[1] },
+	{ .compatible = "ti,adc122s101", .data = &adc128_config[1] },
+	{ .compatible = "ti,adc124s021", .data = &adc128_config[2] },
+	{ .compatible = "ti,adc124s051", .data = &adc128_config[2] },
+	{ .compatible = "ti,adc124s101", .data = &adc128_config[2] },
 	{ /* sentinel */ },
 };
 MODULE_DEVICE_TABLE(of, adc128_of_match);
 
 static const struct spi_device_id adc128_id[] = {
-	{ "adc128s052", 0 },	/* index into adc128_config */
-	{ "adc122s021",	1 },
-	{ "adc122s051",	1 },
-	{ "adc122s101",	1 },
-	{ "adc124s021", 2 },
-	{ "adc124s051", 2 },
-	{ "adc124s101", 2 },
+	{ "adc128s052", (kernel_ulong_t)&adc128_config[0] },
+	{ "adc122s021",	(kernel_ulong_t)&adc128_config[1] },
+	{ "adc122s051",	(kernel_ulong_t)&adc128_config[1] },
+	{ "adc122s101",	(kernel_ulong_t)&adc128_config[1] },
+	{ "adc124s021", (kernel_ulong_t)&adc128_config[2] },
+	{ "adc124s051", (kernel_ulong_t)&adc128_config[2] },
+	{ "adc124s101", (kernel_ulong_t)&adc128_config[2] },
 	{ }
 };
 MODULE_DEVICE_TABLE(spi, adc128_id);
 
 #ifdef CONFIG_ACPI
 static const struct acpi_device_id adc128_acpi_match[] = {
-	{ "AANT1280", 2 }, /* ADC124S021 compatible ACPI ID */
+	{ "AANT1280", (kernel_ulong_t)&adc128_config[2] },
 	{ }
 };
 MODULE_DEVICE_TABLE(acpi, adc128_acpi_match);
-- 
2.35.1

