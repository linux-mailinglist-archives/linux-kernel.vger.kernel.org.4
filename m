Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C35D9639658
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 15:17:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbiKZORw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Nov 2022 09:17:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbiKZORt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Nov 2022 09:17:49 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF17D12601;
        Sat, 26 Nov 2022 06:17:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669472267; x=1701008267;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=MQc84tABIklxiwjd/JnPm2AoEMxnQw6t0O2sj0eZ5D4=;
  b=VqUTw/hJzygvYM2uqZxoRAkXgP9ajRa/2tM1WyOBIjw8dyKIoUnVqPEm
   GxbtRruMnjXjgDU6ulBkeDOTl1drUPKwYgwXRkeGemcV9g8BeQrdSFue9
   NjNVxYeqAY56xwPheDqa7g/ZldrUn/V6J8W4ykqUk+C+ncrQij3RITJ19
   5J612ePgqew1HSjbJugLLr4N6lUeGLJ6+waKxSVy+AmUG21GE70Mo106+
   oEYuTDVjxYE5ma8wJ8EM55YLe/IjYLH8X2y/Yk4cpsW620rXAGvDZMmKe
   m/COFIB0O+jkWZT2hXP77kDlmzJ/k29Uu9Lr01rA98e+l4P+IEMr55GZt
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10543"; a="315755383"
X-IronPort-AV: E=Sophos;i="5.96,196,1665471600"; 
   d="scan'208";a="315755383"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2022 06:17:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10543"; a="971800593"
X-IronPort-AV: E=Sophos;i="5.96,196,1665471600"; 
   d="scan'208";a="971800593"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 26 Nov 2022 06:17:44 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 007F710E; Sat, 26 Nov 2022 16:18:10 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/5] rtc: isl12022: Get rid of unneeded private struct isl12022
Date:   Sat, 26 Nov 2022 16:18:02 +0200
Message-Id: <20221126141806.62205-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

First of all, the struct rtc_device pointer is kept in the managed
resources, no need to keep it outside (no users in the driver).

Second, replace private struct isl12022 with a regmap.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/rtc/rtc-isl12022.c | 56 ++++++++++++++------------------------
 1 file changed, 21 insertions(+), 35 deletions(-)

diff --git a/drivers/rtc/rtc-isl12022.c b/drivers/rtc/rtc-isl12022.c
index a3b0de3393f5..44058fa27277 100644
--- a/drivers/rtc/rtc-isl12022.c
+++ b/drivers/rtc/rtc-isl12022.c
@@ -46,11 +46,6 @@
 
 static struct i2c_driver isl12022_driver;
 
-struct isl12022 {
-	struct rtc_device *rtc;
-	struct regmap *regmap;
-};
-
 static umode_t isl12022_hwmon_is_visible(const void *data,
 					 enum hwmon_sensor_types type,
 					 u32 attr, int channel)
@@ -67,8 +62,7 @@ static umode_t isl12022_hwmon_is_visible(const void *data,
  */
 static int isl12022_hwmon_read_temp(struct device *dev, long *mC)
 {
-	struct isl12022 *isl12022 = dev_get_drvdata(dev);
-	struct regmap *regmap = isl12022->regmap;
+	struct regmap *regmap = dev_get_drvdata(dev);
 	u8 temp_buf[2];
 	int temp, ret;
 
@@ -115,23 +109,21 @@ static const struct hwmon_chip_info isl12022_hwmon_chip_info = {
 
 static void isl12022_hwmon_register(struct device *dev)
 {
-	struct isl12022 *isl12022;
+	struct regmap *regmap = dev_get_drvdata(dev);
 	struct device *hwmon;
 	int ret;
 
 	if (!IS_REACHABLE(CONFIG_HWMON))
 		return;
 
-	isl12022 = dev_get_drvdata(dev);
-
-	ret = regmap_update_bits(isl12022->regmap, ISL12022_REG_BETA,
+	ret = regmap_update_bits(regmap, ISL12022_REG_BETA,
 				 ISL12022_BETA_TSE, ISL12022_BETA_TSE);
 	if (ret) {
 		dev_warn(dev, "unable to enable temperature sensor\n");
 		return;
 	}
 
-	hwmon = devm_hwmon_device_register_with_info(dev, "isl12022", isl12022,
+	hwmon = devm_hwmon_device_register_with_info(dev, "isl12022", regmap,
 						     &isl12022_hwmon_chip_info,
 						     NULL);
 	if (IS_ERR(hwmon))
@@ -144,8 +136,7 @@ static void isl12022_hwmon_register(struct device *dev)
  */
 static int isl12022_rtc_read_time(struct device *dev, struct rtc_time *tm)
 {
-	struct isl12022 *isl12022 = dev_get_drvdata(dev);
-	struct regmap *regmap = isl12022->regmap;
+	struct regmap *regmap = dev_get_drvdata(dev);
 	uint8_t buf[ISL12022_REG_INT + 1];
 	int ret;
 
@@ -190,8 +181,7 @@ static int isl12022_rtc_read_time(struct device *dev, struct rtc_time *tm)
 
 static int isl12022_rtc_set_time(struct device *dev, struct rtc_time *tm)
 {
-	struct isl12022 *isl12022 = dev_get_drvdata(dev);
-	struct regmap *regmap = isl12022->regmap;
+	struct regmap *regmap = dev_get_drvdata(dev);
 	int ret;
 	uint8_t buf[ISL12022_REG_DW + 1];
 
@@ -218,8 +208,7 @@ static int isl12022_rtc_set_time(struct device *dev, struct rtc_time *tm)
 
 	buf[ISL12022_REG_DW] = tm->tm_wday & 0x07;
 
-	return regmap_bulk_write(isl12022->regmap, ISL12022_REG_SC,
-				 buf, sizeof(buf));
+	return regmap_bulk_write(regmap, ISL12022_REG_SC, buf, sizeof(buf));
 }
 
 static const struct rtc_class_ops isl12022_rtc_ops = {
@@ -235,34 +224,31 @@ static const struct regmap_config regmap_config = {
 
 static int isl12022_probe(struct i2c_client *client)
 {
-	struct isl12022 *isl12022;
+	struct rtc_device *rtc;
+	struct regmap *regmap;
 
 	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C))
 		return -ENODEV;
 
-	isl12022 = devm_kzalloc(&client->dev, sizeof(struct isl12022),
-				GFP_KERNEL);
-	if (!isl12022)
-		return -ENOMEM;
-	dev_set_drvdata(&client->dev, isl12022);
-
-	isl12022->regmap = devm_regmap_init_i2c(client, &regmap_config);
-	if (IS_ERR(isl12022->regmap)) {
+	regmap = devm_regmap_init_i2c(client, &regmap_config);
+	if (IS_ERR(regmap)) {
 		dev_err(&client->dev, "regmap allocation failed\n");
-		return PTR_ERR(isl12022->regmap);
+		return PTR_ERR(regmap);
 	}
 
+	dev_set_drvdata(&client->dev, regmap);
+
 	isl12022_hwmon_register(&client->dev);
 
-	isl12022->rtc = devm_rtc_allocate_device(&client->dev);
-	if (IS_ERR(isl12022->rtc))
-		return PTR_ERR(isl12022->rtc);
+	rtc = devm_rtc_allocate_device(&client->dev);
+	if (IS_ERR(rtc))
+		return PTR_ERR(rtc);
 
-	isl12022->rtc->ops = &isl12022_rtc_ops;
-	isl12022->rtc->range_min = RTC_TIMESTAMP_BEGIN_2000;
-	isl12022->rtc->range_max = RTC_TIMESTAMP_END_2099;
+	rtc->ops = &isl12022_rtc_ops;
+	rtc->range_min = RTC_TIMESTAMP_BEGIN_2000;
+	rtc->range_max = RTC_TIMESTAMP_END_2099;
 
-	return devm_rtc_register_device(isl12022->rtc);
+	return devm_rtc_register_device(rtc);
 }
 
 #ifdef CONFIG_OF
-- 
2.35.1

