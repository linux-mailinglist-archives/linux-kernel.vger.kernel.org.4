Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEE3B646162
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 20:03:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229701AbiLGTD5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 14:03:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbiLGTDz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 14:03:55 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 599726F0EE;
        Wed,  7 Dec 2022 11:03:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670439834; x=1701975834;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vdEVmZQNO9VO1F38YAk1ZaQw0SFXjy1f+wbWsIodxGs=;
  b=gWDaSw7FfteV9KHm5sQG6Nlu8UH9Pwbb31tB1xqerWvVPxffsfPHM1vb
   gz9aoNm3bS7PoCp7EFvzgZl1aWGKAuxKjFuopcqBYFxlNg4RwhzUTg39r
   fW1FtuIoNTsjcAfH1N88AlB7jHmSareyF7THCohTb1bBtKs+J5dhYZiCK
   LDP7XRfSjR9kOgapb384wv7FB9XV9XZjCyRpxXyIUwTKBnbNWn5L6TTGu
   KHjh6i5E16kLlXIOOD47kjMV10SioCqMbytLllcUm+ydSSvfEtG8D0jqo
   ndjc56iV2dkJ+U3bznCzqc+rLRRI1KzRLmTb/SoAPieCaCIs6lS1K5KJG
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10554"; a="297333237"
X-IronPort-AV: E=Sophos;i="5.96,225,1665471600"; 
   d="scan'208";a="297333237"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2022 11:03:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10554"; a="624411138"
X-IronPort-AV: E=Sophos;i="5.96,225,1665471600"; 
   d="scan'208";a="624411138"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 07 Dec 2022 11:03:40 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id E588F179; Wed,  7 Dec 2022 21:04:08 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Ferry Toth <ftoth@exalondelft.nl>
Subject: [PATCH v1 03/11] iio: light: tsl2563: Configure INT in one place
Date:   Wed,  7 Dec 2022 21:03:40 +0200
Message-Id: <20221207190348.9347-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221207190348.9347-1-andriy.shevchenko@linux.intel.com>
References: <20221207190348.9347-1-andriy.shevchenko@linux.intel.com>
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

Introduce tsl2563_configure_irq() to configure INT in one place.

While at it, make use of TSL2563_INT_LEVEL and newly introduced
TSL2563_INT_MASK.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Tested-by: Ferry Toth <ftoth@exalondelft.nl>
---
 drivers/iio/light/tsl2563.c | 42 ++++++++++++++++++++++---------------
 1 file changed, 25 insertions(+), 17 deletions(-)

diff --git a/drivers/iio/light/tsl2563.c b/drivers/iio/light/tsl2563.c
index d836c15ba777..d071805239ef 100644
--- a/drivers/iio/light/tsl2563.c
+++ b/drivers/iio/light/tsl2563.c
@@ -69,6 +69,7 @@
 
 #define TSL2563_INT_DISABLED	0x00
 #define TSL2563_INT_LEVEL	0x10
+#define TSL2563_INT_MASK	0x30
 #define TSL2563_INT_PERSIST(n)	((n) & 0x0F)
 
 struct tsl2563_gainlevel_coeff {
@@ -211,6 +212,24 @@ static int tsl2563_read_id(struct tsl2563_chip *chip, u8 *id)
 	return 0;
 }
 
+static int tsl2563_configure_irq(struct tsl2563_chip *chip, bool enable)
+{
+	int ret;
+
+	chip->intr &= ~TSL2563_INT_MASK;
+	if (enable)
+		chip->intr |= TSL2563_INT_LEVEL;
+
+	ret = i2c_smbus_write_byte_data(chip->client,
+					TSL2563_CMD | TSL2563_REG_INT,
+					chip->intr);
+	if (ret < 0)
+		return ret;
+
+	chip->int_enabled = enable;
+	return 0;
+}
+
 /*
  * "Normalized" ADC value is one obtained with 400ms of integration time and
  * 16x gain. This function returns the number of bits of shift needed to
@@ -620,9 +639,7 @@ static int tsl2563_write_interrupt_config(struct iio_dev *indio_dev,
 	int ret = 0;
 
 	mutex_lock(&chip->lock);
-	if (state && !(chip->intr & 0x30)) {
-		chip->intr &= ~0x30;
-		chip->intr |= 0x10;
+	if (state && !(chip->intr & TSL2563_INT_MASK)) {
 		/* ensure the chip is actually on */
 		cancel_delayed_work_sync(&chip->poweroff_work);
 		if (!tsl2563_get_power(chip)) {
@@ -633,18 +650,11 @@ static int tsl2563_write_interrupt_config(struct iio_dev *indio_dev,
 			if (ret)
 				goto out;
 		}
-		ret = i2c_smbus_write_byte_data(chip->client,
-						TSL2563_CMD | TSL2563_REG_INT,
-						chip->intr);
-		chip->int_enabled = true;
+		ret = tsl2563_configure_irq(chip, true);
 	}
 
-	if (!state && (chip->intr & 0x30)) {
-		chip->intr &= ~0x30;
-		ret = i2c_smbus_write_byte_data(chip->client,
-						TSL2563_CMD | TSL2563_REG_INT,
-						chip->intr);
-		chip->int_enabled = false;
+	if (!state && (chip->intr & TSL2563_INT_MASK)) {
+		ret = tsl2563_configure_irq(chip, false);
 		/* now the interrupt is not enabled, we can go to sleep */
 		schedule_delayed_work(&chip->poweroff_work, 5 * HZ);
 	}
@@ -668,7 +678,7 @@ static int tsl2563_read_interrupt_config(struct iio_dev *indio_dev,
 	if (ret < 0)
 		return ret;
 
-	return !!(ret & 0x30);
+	return !!(ret & TSL2563_INT_MASK);
 }
 
 static const struct iio_info tsl2563_info_no_irq = {
@@ -796,9 +806,7 @@ static void tsl2563_remove(struct i2c_client *client)
 	if (!chip->int_enabled)
 		cancel_delayed_work_sync(&chip->poweroff_work);
 	/* Ensure that interrupts are disabled - then flush any bottom halves */
-	chip->intr &= ~0x30;
-	i2c_smbus_write_byte_data(chip->client, TSL2563_CMD | TSL2563_REG_INT,
-				  chip->intr);
+	tsl2563_configure_irq(chip, false);
 	tsl2563_set_power(chip, 0);
 }
 
-- 
2.35.1

