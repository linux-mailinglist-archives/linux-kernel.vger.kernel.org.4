Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4DC164616F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 20:04:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbiLGTEM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 14:04:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbiLGTEC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 14:04:02 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C51216F0E5;
        Wed,  7 Dec 2022 11:04:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670439841; x=1701975841;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/H2fZdJPM8yMp96COjKrh0H4heUd+wkuErAFe2JcCKs=;
  b=WyNw65EYn29BnSj+k7OGR1qPv3lMSXhhNZRzqsh74F/iKmnr7fqTftaG
   HcL+iGXknU3Dw36o+3YaFmnYQvgrqF1rqyqvu5HqMNmw/gQpoMSgteKEU
   7ZvPvvNHvk4hJ7NrBEFBTFYkEsaI7xodQIY0bdumH67+E/pYA4cT9a2R9
   9iUi2JqdXetk1EAsof2YPXnFVLtuaUUWY3DrhibsXgutejwDLop9j3IZr
   yJPf2nIo1kLW0Jcx1eEes6CypFpguVt35j68nBn8KbeAhqk3WZv7LSUcI
   LY2uGDpZVGiQ1QEtCuqG4aNFICT2eQx6hPMhLYVzd8Io3VEE07h18sKW2
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10554"; a="315690219"
X-IronPort-AV: E=Sophos;i="5.96,225,1665471600"; 
   d="scan'208";a="315690219"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2022 11:03:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10554"; a="821060666"
X-IronPort-AV: E=Sophos;i="5.96,225,1665471600"; 
   d="scan'208";a="821060666"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 07 Dec 2022 11:03:40 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id E07C184; Wed,  7 Dec 2022 21:04:08 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Ferry Toth <ftoth@exalondelft.nl>
Subject: [PATCH v1 02/11] iio: light: tsl2563: Use i2c_smbus_write_word_data() in tsl2563_configure()
Date:   Wed,  7 Dec 2022 21:03:39 +0200
Message-Id: <20221207190348.9347-2-andriy.shevchenko@linux.intel.com>
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

Driver already uses the word accessors when it makes sense, but
in the tsl2563_configure(). Switch the latter to use word accessor.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Tested-by: Ferry Toth <ftoth@exalondelft.nl>
---
 drivers/iio/light/tsl2563.c | 52 ++++++++++++++-----------------------
 1 file changed, 19 insertions(+), 33 deletions(-)

diff --git a/drivers/iio/light/tsl2563.c b/drivers/iio/light/tsl2563.c
index 71302ae864d9..d836c15ba777 100644
--- a/drivers/iio/light/tsl2563.c
+++ b/drivers/iio/light/tsl2563.c
@@ -49,16 +49,12 @@
 
 #define TSL2563_REG_CTRL	0x00
 #define TSL2563_REG_TIMING	0x01
-#define TSL2563_REG_LOWLOW	0x02 /* data0 low threshold, 2 bytes */
-#define TSL2563_REG_LOWHIGH	0x03
-#define TSL2563_REG_HIGHLOW	0x04 /* data0 high threshold, 2 bytes */
-#define TSL2563_REG_HIGHHIGH	0x05
+#define TSL2563_REG_LOW		0x02 /* data0 low threshold, 2 bytes */
+#define TSL2563_REG_HIGH	0x04 /* data0 high threshold, 2 bytes */
 #define TSL2563_REG_INT		0x06
 #define TSL2563_REG_ID		0x0a
-#define TSL2563_REG_DATA0LOW	0x0c /* broadband sensor value, 2 bytes */
-#define TSL2563_REG_DATA0HIGH	0x0d
-#define TSL2563_REG_DATA1LOW	0x0e /* infrared sensor value, 2 bytes */
-#define TSL2563_REG_DATA1HIGH	0x0f
+#define TSL2563_REG_DATA0	0x0c /* broadband sensor value, 2 bytes */
+#define TSL2563_REG_DATA1	0x0e /* infrared sensor value, 2 bytes */
 
 #define TSL2563_CMD_POWER_ON	0x03
 #define TSL2563_CMD_POWER_OFF	0x00
@@ -161,24 +157,16 @@ static int tsl2563_configure(struct tsl2563_chip *chip)
 			chip->gainlevel->gaintime);
 	if (ret)
 		goto error_ret;
-	ret = i2c_smbus_write_byte_data(chip->client,
-			TSL2563_CMD | TSL2563_REG_HIGHLOW,
-			chip->high_thres & 0xFF);
-	if (ret)
-		goto error_ret;
-	ret = i2c_smbus_write_byte_data(chip->client,
-			TSL2563_CMD | TSL2563_REG_HIGHHIGH,
-			(chip->high_thres >> 8) & 0xFF);
+	ret = i2c_smbus_write_word_data(chip->client,
+			TSL2563_CMD | TSL2563_REG_HIGH,
+			chip->high_thres);
 	if (ret)
 		goto error_ret;
-	ret = i2c_smbus_write_byte_data(chip->client,
-			TSL2563_CMD | TSL2563_REG_LOWLOW,
-			chip->low_thres & 0xFF);
+	ret = i2c_smbus_write_word_data(chip->client,
+			TSL2563_CMD | TSL2563_REG_LOW,
+			chip->low_thres);
 	if (ret)
 		goto error_ret;
-	ret = i2c_smbus_write_byte_data(chip->client,
-			TSL2563_CMD | TSL2563_REG_LOWHIGH,
-			(chip->low_thres >> 8) & 0xFF);
 /*
  * Interrupt register is automatically written anyway if it is relevant
  * so is not here.
@@ -325,13 +313,13 @@ static int tsl2563_get_adc(struct tsl2563_chip *chip)
 
 	while (retry) {
 		ret = i2c_smbus_read_word_data(client,
-				TSL2563_CMD | TSL2563_REG_DATA0LOW);
+				TSL2563_CMD | TSL2563_REG_DATA0);
 		if (ret < 0)
 			goto out;
 		adc0 = ret;
 
 		ret = i2c_smbus_read_word_data(client,
-				TSL2563_CMD | TSL2563_REG_DATA1LOW);
+				TSL2563_CMD | TSL2563_REG_DATA1);
 		if (ret < 0)
 			goto out;
 		adc1 = ret;
@@ -584,20 +572,18 @@ static int tsl2563_write_thresh(struct iio_dev *indio_dev,
 {
 	struct tsl2563_chip *chip = iio_priv(indio_dev);
 	int ret;
-	u8 address;
+
+	mutex_lock(&chip->lock);
 
 	if (dir == IIO_EV_DIR_RISING)
-		address = TSL2563_REG_HIGHLOW;
+		ret = i2c_smbus_write_word_data(chip->client,
+						TSL2563_CMD | TSL2563_REG_HIGH, val);
 	else
-		address = TSL2563_REG_LOWLOW;
-	mutex_lock(&chip->lock);
-	ret = i2c_smbus_write_byte_data(chip->client, TSL2563_CMD | address,
-					val & 0xFF);
+		ret = i2c_smbus_write_word_data(chip->client,
+						TSL2563_CMD | TSL2563_REG_LOW, val);
 	if (ret)
 		goto error_ret;
-	ret = i2c_smbus_write_byte_data(chip->client,
-					TSL2563_CMD | (address + 1),
-					(val >> 8) & 0xFF);
+
 	if (dir == IIO_EV_DIR_RISING)
 		chip->high_thres = val;
 	else
-- 
2.35.1

