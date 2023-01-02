Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DA2765B5F7
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 18:34:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234608AbjABRec (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 12:34:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232634AbjABReY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 12:34:24 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD815A0;
        Mon,  2 Jan 2023 09:34:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672680863; x=1704216863;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MJGT5Ng6SxRubq/uFYarUZ2wwevXbyU19KA8rQmlL2U=;
  b=KQuYz9ODOuLPtayNqwNfI3M24KQp0XlqtWiLfpdok8JVUviHaLinaaZJ
   P2X7VfLY+4V1Xryc7AF14O7BosVGFfTNh3Q9e04Vx+XP3f44N6w1+R+s1
   yh7rnFDFI3+ygEFFe/qHWvaJJlMdrzeUlDZKVQA2Qp2cou9SK8ca4pCwa
   Ua1WYRMdE9OU9C1H5HQC7GVCMi0g2UmWxT5JnTQ9ZuXoYzee98D0pKAxD
   G/RQKIODe4rRW8CPflwiDMdDGtGO//fVfu1iKX7S7ETLRY7iywkNiC4Dt
   sHbrMZDBWO8hNJWpTPWsaQkVjiz34iUiLjWShLMLA7I8B3afzZLK/+wVS
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10578"; a="321583641"
X-IronPort-AV: E=Sophos;i="5.96,294,1665471600"; 
   d="scan'208";a="321583641"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2023 09:34:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10578"; a="717862167"
X-IronPort-AV: E=Sophos;i="5.96,294,1665471600"; 
   d="scan'208";a="717862167"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 02 Jan 2023 09:34:21 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id AC96C84; Mon,  2 Jan 2023 19:34:53 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v2 1/3] iio: adc: ti-adc128s052: Switch to use spi_get_device_match_data()
Date:   Mon,  2 Jan 2023 19:34:48 +0200
Message-Id: <20230102173450.29882-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230102173450.29882-1-andriy.shevchenko@linux.intel.com>
References: <20230102173450.29882-1-andriy.shevchenko@linux.intel.com>
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

The spi_get_device_match_data() helps to get driver data from the
firmware node or SPI ID table. Use it instead of open coding.

While at it, switch ID tables to provide an acrual pointers to
the configuration data.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/adc/ti-adc128s052.c | 43 +++++++++++++++------------------
 1 file changed, 20 insertions(+), 23 deletions(-)

diff --git a/drivers/iio/adc/ti-adc128s052.c b/drivers/iio/adc/ti-adc128s052.c
index b3d5b9b7255b..4a15b6bea310 100644
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
@@ -160,8 +155,10 @@ static int adc128_probe(struct spi_device *spi)
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->info = &adc128_info;
 
-	indio_dev->channels = adc128_config[config].channels;
-	indio_dev->num_channels = adc128_config[config].num_channels;
+	config = spi_get_device_match_data(spi);
+
+	indio_dev->channels = config->channels;
+	indio_dev->num_channels = config->num_channels;
 
 	adc->reg = devm_regulator_get(&spi->dev, "vref");
 	if (IS_ERR(adc->reg))
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

