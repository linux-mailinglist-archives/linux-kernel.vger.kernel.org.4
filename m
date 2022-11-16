Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8501062C0B5
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 15:17:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232915AbiKPOR2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 09:17:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233009AbiKPORZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 09:17:25 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 955B422BD4;
        Wed, 16 Nov 2022 06:17:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668608244; x=1700144244;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=OQO0TWqVhuXOlBW2yi+Jiv/ulHMt3UHPh/srl3YFKp4=;
  b=LHBV7vuUmUYSx4yRMnOzzQVU3j7pYAC3VemtCqQD9p99Y7vCGIhMEhBa
   Vs558Ev/sWMqYs2Tdm/nFQRs3CeLH7DpXE+ug0SDP1Bym9buG9ZR0xHqm
   OTycJMCcGUJp9/PBOY40BDHZ6zN/GNsdAyQLKLR3PjZCS/vH5ZYueCqrU
   lUlz9c9JCvfBpbtOD6FyRla3Y4FHOEwHZ0Ax9dQDVm+z8e7/TpIRJXVHs
   Xva779XWHOXzrvqp4+xm/+v+iqFe7/M9QdwdwdcbeBVGzFBkkJR0oPhft
   uZUtdRkWkoBI/SHwPmNoeNV3Dz/pb0CBlmEWf3wElOxwF7/dSseYV6tFl
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="311258687"
X-IronPort-AV: E=Sophos;i="5.96,167,1665471600"; 
   d="scan'208";a="311258687"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2022 06:17:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="641658846"
X-IronPort-AV: E=Sophos;i="5.96,167,1665471600"; 
   d="scan'208";a="641658846"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 16 Nov 2022 06:17:21 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 617522F3; Wed, 16 Nov 2022 16:17:46 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Brian Masney <bmasney@redhat.com>,
        Marijn Suijten <marijn.suijten@somainline.org>
Subject: [PATCH v1 1/1] gpiolib: Unify access to the device properties
Date:   Wed, 16 Nov 2022 16:17:28 +0200
Message-Id: <20221116141728.72491-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
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

Some of the functions are using struct fwnode_handle, some struct device
pointer. In the GPIO library the firmware node of the GPIO device is the
same as GPIO node of the GPIO chip. Due to this fact we may use former
to access properties everywhere in the code.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpio/gpiolib.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 51afdc6ac919..c163b354e727 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -367,12 +367,12 @@ static int gpiochip_set_desc_names(struct gpio_chip *gc)
 static int devprop_gpiochip_set_names(struct gpio_chip *chip)
 {
 	struct gpio_device *gdev = chip->gpiodev;
-	const struct fwnode_handle *fwnode = dev_fwnode(&gdev->dev);
+	struct device *dev = &gdev->dev;
 	const char **names;
 	int ret, i;
 	int count;
 
-	count = fwnode_property_string_array_count(fwnode, "gpio-line-names");
+	count = device_property_string_array_count(dev, "gpio-line-names");
 	if (count < 0)
 		return 0;
 
@@ -385,7 +385,7 @@ static int devprop_gpiochip_set_names(struct gpio_chip *chip)
 	 * gpiochips.
 	 */
 	if (count <= chip->offset) {
-		dev_warn(&gdev->dev, "gpio-line-names too short (length %d), cannot map names for the gpiochip at offset %u\n",
+		dev_warn(dev, "gpio-line-names too short (length %d), cannot map names for the gpiochip at offset %u\n",
 			 count, chip->offset);
 		return 0;
 	}
@@ -394,10 +394,9 @@ static int devprop_gpiochip_set_names(struct gpio_chip *chip)
 	if (!names)
 		return -ENOMEM;
 
-	ret = fwnode_property_read_string_array(fwnode, "gpio-line-names",
-						names, count);
+	ret = device_property_read_string_array(dev, "gpio-line-names", names, count);
 	if (ret < 0) {
-		dev_warn(&gdev->dev, "failed to read GPIO line names\n");
+		dev_warn(dev, "failed to read GPIO line names\n");
 		kfree(names);
 		return ret;
 	}
@@ -448,10 +447,11 @@ static unsigned long *gpiochip_allocate_mask(struct gpio_chip *gc)
 
 static unsigned int gpiochip_count_reserved_ranges(struct gpio_chip *gc)
 {
+	struct device *dev = &gc->gpiodev->dev;
 	int size;
 
 	/* Format is "start, count, ..." */
-	size = fwnode_property_count_u32(gc->fwnode, "gpio-reserved-ranges");
+	size = device_property_count_u32(dev, "gpio-reserved-ranges");
 	if (size > 0 && size % 2 == 0)
 		return size;
 
@@ -472,6 +472,7 @@ static int gpiochip_alloc_valid_mask(struct gpio_chip *gc)
 
 static int gpiochip_apply_reserved_ranges(struct gpio_chip *gc)
 {
+	struct device *dev = &gc->gpiodev->dev;
 	unsigned int size;
 	u32 *ranges;
 	int ret;
@@ -484,7 +485,7 @@ static int gpiochip_apply_reserved_ranges(struct gpio_chip *gc)
 	if (!ranges)
 		return -ENOMEM;
 
-	ret = fwnode_property_read_u32_array(gc->fwnode, "gpio-reserved-ranges", ranges, size);
+	ret = device_property_read_u32_array(dev, "gpio-reserved-ranges", ranges, size);
 	if (ret) {
 		kfree(ranges);
 		return ret;

base-commit: 40059212f99c31f26c69763e560325e59eac02c6
-- 
2.35.1

