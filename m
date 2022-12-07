Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 438A8646175
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 20:04:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229878AbiLGTEZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 14:04:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbiLGTEE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 14:04:04 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A73470616;
        Wed,  7 Dec 2022 11:04:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670439843; x=1701975843;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pgSWEefpffGm7xw97UuMKoDF6VmW2ivy1224gocEp4U=;
  b=gqdFOQFNPNFK+0am7/MNlQ0RAXfxIeZr6dMEIqsCUYEEhk+Az/okP7aU
   hWaO/2D4cclnFq9BOxizvopuqOE+KCfKCffYrKP5q6Z2Rg7BBIxWr9tIZ
   EyUrqji/fMEqrC8HD/C8ey38xqr4cfpRW5KkUXvGYh/yuvHAVEk4+A6Xv
   XlH87ksMiGuvadPmyDXX1mI/87Hv18uI+/1PWZFsgD3aiUHXduKboTiJn
   MQ1Q5yN/KV6pOGFZKLgBcg84rSfVWRruhPPlp6yjZnJXCp+gj4kh4jJng
   Wz+r3cSoPieZBHFbXabs+SqI7wYp5JY8KSnfbJbA1Mrei+8Mc13oAww9o
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10554"; a="315690234"
X-IronPort-AV: E=Sophos;i="5.96,225,1665471600"; 
   d="scan'208";a="315690234"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2022 11:03:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10554"; a="821060671"
X-IronPort-AV: E=Sophos;i="5.96,225,1665471600"; 
   d="scan'208";a="821060671"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 07 Dec 2022 11:03:43 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 2FFA954F; Wed,  7 Dec 2022 21:04:09 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Ferry Toth <ftoth@exalondelft.nl>
Subject: [PATCH v1 07/11] iio: light: tsl2563: Drop legacy platform data code
Date:   Wed,  7 Dec 2022 21:03:44 +0200
Message-Id: <20221207190348.9347-7-andriy.shevchenko@linux.intel.com>
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

There is no in-kernel user for legacy platform data.
Otherwise, a new one can use software nodes instead.
Hence, drop legacy platform data code.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Tested-by: Ferry Toth <ftoth@exalondelft.nl>
---
 drivers/iio/light/tsl2563.c           | 12 ++----------
 include/linux/platform_data/tsl2563.h |  9 ---------
 2 files changed, 2 insertions(+), 19 deletions(-)
 delete mode 100644 include/linux/platform_data/tsl2563.h

diff --git a/drivers/iio/light/tsl2563.c b/drivers/iio/light/tsl2563.c
index cce044556293..ed193a3da91e 100644
--- a/drivers/iio/light/tsl2563.c
+++ b/drivers/iio/light/tsl2563.c
@@ -29,7 +29,6 @@
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
 #include <linux/iio/events.h>
-#include <linux/platform_data/tsl2563.h>
 
 /* Use this many bits for fraction part. */
 #define ADC_FRAC_BITS		14
@@ -698,7 +697,6 @@ static int tsl2563_probe(struct i2c_client *client)
 	struct device *dev = &client->dev;
 	struct iio_dev *indio_dev;
 	struct tsl2563_chip *chip;
-	struct tsl2563_platform_data *pdata = client->dev.platform_data;
 	unsigned long irq_flags;
 	u8 id = 0;
 	int err;
@@ -730,14 +728,8 @@ static int tsl2563_probe(struct i2c_client *client)
 	chip->calib0 = tsl2563_calib_from_sysfs(CALIB_BASE_SYSFS);
 	chip->calib1 = tsl2563_calib_from_sysfs(CALIB_BASE_SYSFS);
 
-	if (pdata) {
-		chip->cover_comp_gain = pdata->cover_comp_gain;
-	} else {
-		err = device_property_read_u32(&client->dev, "amstaos,cover-comp-gain",
-					       &chip->cover_comp_gain);
-		if (err)
-			chip->cover_comp_gain = 1;
-	}
+	chip->cover_comp_gain = 1;
+	device_property_read_u32(dev, "amstaos,cover-comp-gain", &chip->cover_comp_gain);
 
 	dev_info(&client->dev, "model %d, rev. %d\n", id >> 4, id & 0x0f);
 	indio_dev->name = client->name;
diff --git a/include/linux/platform_data/tsl2563.h b/include/linux/platform_data/tsl2563.h
deleted file mode 100644
index 9cf9309c3f24..000000000000
--- a/include/linux/platform_data/tsl2563.h
+++ /dev/null
@@ -1,9 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef __LINUX_TSL2563_H
-#define __LINUX_TSL2563_H
-
-struct tsl2563_platform_data {
-	int cover_comp_gain;
-};
-
-#endif /* __LINUX_TSL2563_H */
-- 
2.35.1

