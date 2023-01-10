Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 483336642D8
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 15:09:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238319AbjAJOIr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 09:08:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238672AbjAJOIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 09:08:12 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B759C8CBF4;
        Tue, 10 Jan 2023 06:08:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673359691; x=1704895691;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bZMrAv2zUwB2PF0XruHl6FSmCHCHKSqmQ7n3sGCcVCE=;
  b=kGIN6TODYLjZv+PTgpD+w8v6ynn1FUnFiU7XJFmhDxUSBC8C0p/n2KuU
   NiJF7LEj1ZzVgleLe0vaizsPgmAPQCiZttNJ84/e/I/QiDTYiX87NVlsS
   gw/PFn6QWOHKmwlRXv1XQRbFw1oqR2scW657JSfvJv0h74tPuutH/6uNw
   D20FXNZcT9wMTjeMkJ7oyaORF4qn6EBXOgumBJ+jtz1rFtnOzqRUVGNy1
   veRU6Hv0WrvZ1UXdskaHvsiIiSqIIhxs96OgqgTydSuGWxAZ/6CGVq0mc
   JCPx3RUdpKh3zFFj9iK467Zn004eoZQjiygfiZNYAwFEBJs4fTDAe1Yyk
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10585"; a="303513595"
X-IronPort-AV: E=Sophos;i="5.96,315,1665471600"; 
   d="scan'208";a="303513595"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2023 06:07:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10585"; a="725555663"
X-IronPort-AV: E=Sophos;i="5.96,315,1665471600"; 
   d="scan'208";a="725555663"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 10 Jan 2023 06:07:39 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id E1B31E1; Tue, 10 Jan 2023 16:08:12 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 1/5] rtc: isl12022: Get rid of unneeded private struct isl12022
Date:   Tue, 10 Jan 2023 16:08:02 +0200
Message-Id: <20230110140806.87432-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230110140806.87432-1-andriy.shevchenko@linux.intel.com>
References: <20230110140806.87432-1-andriy.shevchenko@linux.intel.com>
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

First of all, the struct rtc_device pointer is kept in the managed
resources, no need to keep it outside (no users in the driver).

Second, replace private struct isl12022 with a regmap.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
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
2.39.0

