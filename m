Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB14164616B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 20:04:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbiLGTEI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 14:04:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbiLGTEB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 14:04:01 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2990B6F0F8;
        Wed,  7 Dec 2022 11:04:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670439841; x=1701975841;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pMQGPBFtt905fG46sLXpc+j2JDZM7i+fIGP5das7BdQ=;
  b=cY36tAb9aRYRTxV2LhiHiafheZU07VD31ZuCbD/UMJqEKSmOMq4S1I0x
   1vJU6L0bjTtq7Fpd7eo3aTTJxOfLvNH6aKKQMGqSu9HWmOzfZ/LuWEkjM
   fQaQxsWnLQ3xyFajgH8MZRfnUDYbNdD52v4lC/6wuoOL5zapXKBNFOqoM
   eBpdRI4H63fGtpKOqhunJOVAiMV5CZRtS4Z0JW1vXuAojjNkqoh1m3BbB
   XJGSmd2zf4w7fk4fBV7C1FWOceV+vi1Kfuvcc7x9OvW2wgv9c7ape5nQL
   1uh/h7q2jTND+hVHOmkgjizI795/Q6DI6kzmNw1kfMHBHFQXj8LkVxBna
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10554"; a="315690216"
X-IronPort-AV: E=Sophos;i="5.96,225,1665471600"; 
   d="scan'208";a="315690216"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2022 11:03:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10554"; a="821060665"
X-IronPort-AV: E=Sophos;i="5.96,225,1665471600"; 
   d="scan'208";a="821060665"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 07 Dec 2022 11:03:40 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 087E33B3; Wed,  7 Dec 2022 21:04:08 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Ferry Toth <ftoth@exalondelft.nl>
Subject: [PATCH v1 04/11] iio: light: tsl2563: Make use of the macros from bits.h
Date:   Wed,  7 Dec 2022 21:03:41 +0200
Message-Id: <20221207190348.9347-4-andriy.shevchenko@linux.intel.com>
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

Make use of BIT() and GENMASK() where it makes sense.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Tested-by: Ferry Toth <ftoth@exalondelft.nl>
---
 drivers/iio/light/tsl2563.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/light/tsl2563.c b/drivers/iio/light/tsl2563.c
index d071805239ef..3b60d8000351 100644
--- a/drivers/iio/light/tsl2563.c
+++ b/drivers/iio/light/tsl2563.c
@@ -11,6 +11,7 @@
  * Amit Kucheria <amit.kucheria@verdurent.com>
  */
 
+#include <linux/bits.h>
 #include <linux/module.h>
 #include <linux/mod_devicetable.h>
 #include <linux/property.h>
@@ -33,19 +34,19 @@
 #define ADC_FRAC_BITS		14
 
 /* Given number of 1/10000's in ADC_FRAC_BITS precision. */
-#define FRAC10K(f)		(((f) * (1L << (ADC_FRAC_BITS))) / (10000))
+#define FRAC10K(f)		(((f) * BIT(ADC_FRAC_BITS)) / (10000))
 
 /* Bits used for fraction in calibration coefficients.*/
 #define CALIB_FRAC_BITS		10
 /* 0.5 in CALIB_FRAC_BITS precision */
-#define CALIB_FRAC_HALF		(1 << (CALIB_FRAC_BITS - 1))
+#define CALIB_FRAC_HALF		BIT(CALIB_FRAC_BITS - 1)
 /* Make a fraction from a number n that was multiplied with b. */
 #define CALIB_FRAC(n, b)	(((n) << CALIB_FRAC_BITS) / (b))
 /* Decimal 10^(digits in sysfs presentation) */
 #define CALIB_BASE_SYSFS	1000
 
-#define TSL2563_CMD		0x80
-#define TSL2563_CLEARINT	0x40
+#define TSL2563_CMD		BIT(7)
+#define TSL2563_CLEARINT	BIT(6)
 
 #define TSL2563_REG_CTRL	0x00
 #define TSL2563_REG_TIMING	0x01
@@ -58,19 +59,19 @@
 
 #define TSL2563_CMD_POWER_ON	0x03
 #define TSL2563_CMD_POWER_OFF	0x00
-#define TSL2563_CTRL_POWER_MASK	0x03
+#define TSL2563_CTRL_POWER_MASK	GENMASK(1, 0)
 
 #define TSL2563_TIMING_13MS	0x00
 #define TSL2563_TIMING_100MS	0x01
 #define TSL2563_TIMING_400MS	0x02
-#define TSL2563_TIMING_MASK	0x03
+#define TSL2563_TIMING_MASK	GENMASK(1, 0)
 #define TSL2563_TIMING_GAIN16	0x10
 #define TSL2563_TIMING_GAIN1	0x00
 
 #define TSL2563_INT_DISABLED	0x00
 #define TSL2563_INT_LEVEL	0x10
-#define TSL2563_INT_MASK	0x30
-#define TSL2563_INT_PERSIST(n)	((n) & 0x0F)
+#define TSL2563_INT_MASK	GENMASK(5, 4)
+#define TSL2563_INT_PERSIST(n)	((n) & GENMASK(3, 0))
 
 struct tsl2563_gainlevel_coeff {
 	u8 gaintime;
-- 
2.35.1

