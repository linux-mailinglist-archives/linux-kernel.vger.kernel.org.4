Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 669C05F2465
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Oct 2022 19:48:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbiJBRs1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Oct 2022 13:48:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbiJBRsZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Oct 2022 13:48:25 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E84B436082;
        Sun,  2 Oct 2022 10:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664732903; x=1696268903;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ApulsrstOsE6sQgCr69j7S7zz4j5JHA7E5+uPVmJbGY=;
  b=AHrf1ahy4e0FoCRX1kdgNrahA+or7H6eCy6UCavsTLi0fSqh06/uu3RN
   q6rbJLNiNZxlHsM3RT8144fnxwYiFByUInMOSQO9g4mLni45uhLLRytj0
   ZuagzXropWnlTCP9/RqrHS17pxGDXwNTe+zLRBAGucci7ngkn1yqRFteq
   mrmuwxAFLC0rUPlUf0kK5ipdwLy9sui6qkSICVohjtPZIur8af5Mk+Qcg
   Zk/Q/YOzvjowtrxgNh+pOgqrWu8EohBsplh9ye1HvIUZLXOf7rO/biwxZ
   b3FfR4zNERhhiCNr7fyX3aAab0TgCA959ttyg4O+19jdWA8BW71JeVDHR
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10488"; a="388785888"
X-IronPort-AV: E=Sophos;i="5.93,363,1654585200"; 
   d="scan'208";a="388785888"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2022 10:48:23 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10488"; a="574401734"
X-IronPort-AV: E=Sophos;i="5.93,363,1654585200"; 
   d="scan'208";a="574401734"
Received: from unknown (HELO rajath-NUC10i7FNH..) ([10.223.165.55])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2022 10:48:21 -0700
From:   Rajat Khandelwal <rajat.khandelwal@linux.intel.com>
To:     jic23@kernel.org, lars@metafoo.de
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        rajat.khandelwal@intel.com,
        Rajat Khandelwal <rajat.khandelwal@linux.intel.com>
Subject: [PATCH v3] iio: pressure: mpl115: Implementing low power mode by shutdown gpio
Date:   Mon,  3 Oct 2022 23:17:43 +0530
Message-Id: <20221003174743.2693435-1-rajat.khandelwal@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_12_24,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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

Signed-off-by: Rajat Khandelwal <rajat.khandelwal@linux.intel.com>
---

v3: Using runtime PM for low power mode and not forcing shutdown pin

 drivers/iio/pressure/mpl115.c     | 61 ++++++++++++++++++++++++++++++-
 drivers/iio/pressure/mpl115.h     |  5 +++
 drivers/iio/pressure/mpl115_i2c.c |  1 +
 drivers/iio/pressure/mpl115_spi.c |  1 +
 4 files changed, 67 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/pressure/mpl115.c b/drivers/iio/pressure/mpl115.c
index 5bf5b9abe6f1..ec7527161844 100644
--- a/drivers/iio/pressure/mpl115.c
+++ b/drivers/iio/pressure/mpl115.c
@@ -4,12 +4,13 @@
  *
  * Copyright (c) 2014 Peter Meerwald <pmeerw@pmeerw.net>
  *
- * TODO: shutdown pin
+ * TODO: synchronization with system suspend
  */
 
 #include <linux/module.h>
 #include <linux/iio/iio.h>
 #include <linux/delay.h>
+#include <linux/gpio/consumer.h>
 
 #include "mpl115.h"
 
@@ -27,6 +28,7 @@ struct mpl115_data {
 	s16 a0;
 	s16 b1, b2;
 	s16 c12;
+	struct gpio_desc *shutdown;
 	const struct mpl115_ops *ops;
 };
 
@@ -102,16 +104,24 @@ static int mpl115_read_raw(struct iio_dev *indio_dev,
 
 	switch (mask) {
 	case IIO_CHAN_INFO_PROCESSED:
+		pm_runtime_get_sync(data->dev);
 		ret = mpl115_comp_pressure(data, val, val2);
 		if (ret < 0)
 			return ret;
+		pm_runtime_mark_last_busy(data->dev);
+		pm_runtime_put_autosuspend(data->dev);
+
 		return IIO_VAL_INT_PLUS_MICRO;
 	case IIO_CHAN_INFO_RAW:
+		pm_runtime_get_sync(data->dev);
 		/* temperature -5.35 C / LSB, 472 LSB is 25 C */
 		ret = mpl115_read_temp(data);
 		if (ret < 0)
 			return ret;
+		pm_runtime_mark_last_busy(data->dev);
+		pm_runtime_put_autosuspend(data->dev);
 		*val = ret >> 6;
+
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_OFFSET:
 		*val = -605;
@@ -168,6 +178,8 @@ int mpl115_probe(struct device *dev, const char *name,
 	if (ret)
 		return ret;
 
+	dev_set_drvdata(dev, indio_dev);
+
 	ret = data->ops->read(data->dev, MPL115_A0);
 	if (ret < 0)
 		return ret;
@@ -185,10 +193,58 @@ int mpl115_probe(struct device *dev, const char *name,
 		return ret;
 	data->c12 = ret;
 
+	data->shutdown = devm_gpiod_get_optional(dev, "shutdown",
+						 GPIOD_OUT_LOW);
+	if (IS_ERR(data->shutdown))
+		return dev_err_probe(dev, PTR_ERR(data->shutdown),
+				     "cannot get shutdown gpio\n");
+
+	if (data->shutdown) {
+		/* Enable runtime PM */
+		pm_runtime_get_noresume(dev);
+		pm_runtime_set_active(dev);
+		pm_runtime_enable(dev);
+
+		/*
+		 * As the device takes 3 ms to come up with a fresh
+		 * reading after power-on and 5 ms to actually power-on,
+		 * do not shut it down unnecessarily. Set autosuspend to
+		 * 200 ms.
+		 */
+		pm_runtime_set_autosuspend_delay(dev, 200);
+		pm_runtime_use_autosuspend(dev);
+		pm_runtime_put(dev);
+
+		dev_dbg(dev, "low-power mode enabled");
+	} else
+		dev_dbg(dev, "low-power mode disabled");
+
 	return devm_iio_device_register(dev, indio_dev);
 }
 EXPORT_SYMBOL_NS_GPL(mpl115_probe, IIO_MPL115);
 
+static int mpl115_runtime_suspend(struct device *dev)
+{
+	struct mpl115_data *data = iio_priv(dev_get_drvdata(dev));
+
+	gpiod_set_value(data->shutdown, 1);
+
+	return 0;
+}
+
+static int mpl115_runtime_resume(struct device *dev)
+{
+	struct mpl115_data *data = iio_priv(dev_get_drvdata(dev));
+
+	gpiod_set_value(data->shutdown, 0);
+	usleep_range(5000, 6000);
+
+	return 0;
+}
+
+DEFINE_RUNTIME_DEV_PM_OPS(mpl115_dev_pm_ops, mpl115_runtime_suspend,
+			  mpl115_runtime_resume, NULL);
+
 MODULE_AUTHOR("Peter Meerwald <pmeerw@pmeerw.net>");
 MODULE_DESCRIPTION("Freescale MPL115 pressure/temperature driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/iio/pressure/mpl115.h b/drivers/iio/pressure/mpl115.h
index 57d55eb8e661..78a0068a17bb 100644
--- a/drivers/iio/pressure/mpl115.h
+++ b/drivers/iio/pressure/mpl115.h
@@ -6,6 +6,8 @@
  * Copyright (c) 2016 Akinobu Mita <akinobu.mita@gmail.com>
  */
 
+#include <linux/pm_runtime.h>
+
 #ifndef _MPL115_H_
 #define _MPL115_H_
 
@@ -18,4 +20,7 @@ struct mpl115_ops {
 int mpl115_probe(struct device *dev, const char *name,
 			const struct mpl115_ops *ops);
 
+/*PM ops */
+extern const struct dev_pm_ops mpl115_dev_pm_ops;
+
 #endif
diff --git a/drivers/iio/pressure/mpl115_i2c.c b/drivers/iio/pressure/mpl115_i2c.c
index 099ab1c6832c..555bda1146fb 100644
--- a/drivers/iio/pressure/mpl115_i2c.c
+++ b/drivers/iio/pressure/mpl115_i2c.c
@@ -53,6 +53,7 @@ MODULE_DEVICE_TABLE(i2c, mpl115_i2c_id);
 static struct i2c_driver mpl115_i2c_driver = {
 	.driver = {
 		.name	= "mpl115",
+		.pm = pm_ptr(&mpl115_dev_pm_ops),
 	},
 	.probe = mpl115_i2c_probe,
 	.id_table = mpl115_i2c_id,
diff --git a/drivers/iio/pressure/mpl115_spi.c b/drivers/iio/pressure/mpl115_spi.c
index 7feec87e2704..58d218fd90dc 100644
--- a/drivers/iio/pressure/mpl115_spi.c
+++ b/drivers/iio/pressure/mpl115_spi.c
@@ -92,6 +92,7 @@ MODULE_DEVICE_TABLE(spi, mpl115_spi_ids);
 static struct spi_driver mpl115_spi_driver = {
 	.driver = {
 		.name   = "mpl115",
+		.pm = pm_ptr(&mpl115_dev_pm_ops),
 	},
 	.probe = mpl115_spi_probe,
 	.id_table = mpl115_spi_ids,
-- 
2.34.1

