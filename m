Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B9F05EAEF5
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 20:02:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230159AbiIZSCE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 14:02:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229903AbiIZSBj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 14:01:39 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B0D625CD;
        Mon, 26 Sep 2022 10:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664214156; x=1695750156;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=cG2DvqSDLyI1J+v9C/CXBPyOFA8Bzn/CTqdg+/ubto0=;
  b=jcLuSexnv1HK6URTVRO/UFQfnxcICphtiQZYCCgIlmIWVhMosPL9TC8Q
   4CgrhYguKwR0XaQ/QFNrmW3XPqpBHMYRc52vkyIrQES4hPkKxYgzD/5Nt
   e0kH1X7Ymsvxe9copiD6JoPXry4+WDfD9TxhowUTkrYgoGElKAGAEeQJV
   nehO6GE8yT8vQ4aNimLxmv8O3V3cbZ0UGie2WqnPxR17JTNMxL4sWCohP
   3QS6NC2puTKhtC3Tf4Iot6TDD8+MfyulTIh2YfQ6jVt4fluLRmwcwN4Ut
   y25PeeHlWVgHJYQ4TMGlu1u9zpWsISL7uluoO29AlmKaxnz1ClEEYqPkc
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10482"; a="302569735"
X-IronPort-AV: E=Sophos;i="5.93,346,1654585200"; 
   d="scan'208";a="302569735"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2022 10:42:35 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10482"; a="651920180"
X-IronPort-AV: E=Sophos;i="5.93,346,1654585200"; 
   d="scan'208";a="651920180"
Received: from unknown (HELO rajath-NUC10i7FNH..) ([10.223.165.55])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2022 10:42:33 -0700
From:   Rajat Khandelwal <rajat.khandelwal@intel.com>
To:     jic23@kernel.org, lars@metafoo.de
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rajat Khandelwal <rajat.khandelwal@intel.com>
Subject: [PATCH v2] iio: pressure: mpl115: Implementing low power mode by shutdown gpio
Date:   Tue, 27 Sep 2022 23:12:12 +0530
Message-Id: <20220927174212.1776567-1-rajat.khandelwal@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_12_24,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MPL115 supports shutdown gpio which can be used to set the default
state to low power mode. Power from all internal circuits and
registers is removed. This is done by pulling the SHDN pin to low.
This patch sets the default mode to low-power and only exits when
a reading is required from the chip. This maximises power savings.

According to spec., a wakeup time period of ~5 ms exists between
waking up and actually communicating with the device. This is
implemented using sleep delay.

Signed-off-by: Rajat Khandelwal <rajat.khandelwal@intel.com>
---

v2: Grammatically completing subject line

 drivers/iio/pressure/mpl115.c | 33 +++++++++++++++++++++++++++++----
 1 file changed, 29 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/pressure/mpl115.c b/drivers/iio/pressure/mpl115.c
index 5bf5b9abe6f1..c0ad3e941d05 100644
--- a/drivers/iio/pressure/mpl115.c
+++ b/drivers/iio/pressure/mpl115.c
@@ -3,13 +3,12 @@
  * mpl115.c - Support for Freescale MPL115A pressure/temperature sensor
  *
  * Copyright (c) 2014 Peter Meerwald <pmeerw@pmeerw.net>
- *
- * TODO: shutdown pin
  */
 
 #include <linux/module.h>
 #include <linux/iio/iio.h>
 #include <linux/delay.h>
+#include <linux/gpio/consumer.h>
 
 #include "mpl115.h"
 
@@ -27,6 +26,7 @@ struct mpl115_data {
 	s16 a0;
 	s16 b1, b2;
 	s16 c12;
+	struct gpio_desc *shutdown;
 	const struct mpl115_ops *ops;
 };
 
@@ -102,13 +102,27 @@ static int mpl115_read_raw(struct iio_dev *indio_dev,
 
 	switch (mask) {
 	case IIO_CHAN_INFO_PROCESSED:
-		ret = mpl115_comp_pressure(data, val, val2);
+		if (data->shutdown) {
+			gpiod_set_value(data->shutdown, 0);
+			usleep_range(5000, 6000);
+			ret = mpl115_comp_pressure(data, val, val2);
+			gpiod_set_value(data->shutdown, 1);
+		} else
+			ret = mpl115_comp_pressure(data, val, val2);
+
 		if (ret < 0)
 			return ret;
 		return IIO_VAL_INT_PLUS_MICRO;
 	case IIO_CHAN_INFO_RAW:
 		/* temperature -5.35 C / LSB, 472 LSB is 25 C */
-		ret = mpl115_read_temp(data);
+		if (data->shutdown) {
+			gpiod_set_value(data->shutdown, 0);
+			usleep_range(5000, 6000);
+			ret = mpl115_read_temp(data);
+			gpiod_set_value(data->shutdown, 1);
+		} else
+			ret = mpl115_read_temp(data);
+
 		if (ret < 0)
 			return ret;
 		*val = ret >> 6;
@@ -185,6 +199,17 @@ int mpl115_probe(struct device *dev, const char *name,
 		return ret;
 	data->c12 = ret;
 
+	data->shutdown = devm_gpiod_get_optional(dev, "shutdown",
+						 GPIOD_OUT_HIGH);
+	if (IS_ERR(data->shutdown))
+		return dev_err_probe(dev, PTR_ERR(data->shutdown),
+				     "cannot get shutdown gpio\n");
+
+	if (data->shutdown)
+		dev_dbg(dev, "low-power mode enabled");
+	else
+		dev_dbg(dev, "low-power mode disabled");
+
 	return devm_iio_device_register(dev, indio_dev);
 }
 EXPORT_SYMBOL_NS_GPL(mpl115_probe, IIO_MPL115);
-- 
2.34.1

