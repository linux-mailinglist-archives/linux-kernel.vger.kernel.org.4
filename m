Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BD1772F710
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 09:56:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233592AbjFNH4a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 03:56:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233106AbjFNH41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 03:56:27 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC9E0106
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 00:56:25 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lgo@pengutronix.de>)
        id 1q9LMY-000071-TT; Wed, 14 Jun 2023 09:56:18 +0200
Received: from [2a0a:edc0:0:1101:1d::39] (helo=dude03.red.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <lgo@pengutronix.de>)
        id 1q9LMY-007ItU-1R; Wed, 14 Jun 2023 09:56:18 +0200
Received: from lgo by dude03.red.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <lgo@pengutronix.de>)
        id 1q9LMX-00EnXI-C0; Wed, 14 Jun 2023 09:56:17 +0200
From:   =?UTF-8?q?Leonard=20G=C3=B6hrs?= <l.goehrs@pengutronix.de>
To:     =?UTF-8?q?Leonard=20G=C3=B6hrs?= <l.goehrs@pengutronix.de>,
        kernel@pengutronix.de, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1] iio: adc: add buffering support to the TI LMP92064 ADC driver
Date:   Wed, 14 Jun 2023 09:55:36 +0200
Message-Id: <20230614075537.3525194-1-l.goehrs@pengutronix.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: lgo@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable buffered reading of samples from the LMP92064 ADC.
The main benefit of this change is being able to read out current and
voltage measurements in a single transfer, allowing instantaneous power
measurements.

Reads into the buffer can be triggered by any software triggers, e.g.
the iio-trig-hrtimer:

    $ mkdir /sys/kernel/config/iio/triggers/hrtimer/my-trigger
    $ cat /sys/bus/iio/devices/iio\:device3/name
    lmp92064
    $ iio_readdev -t my-trigger -b 16 iio:device3 | hexdump
    WARNING: High-speed mode not enabled
    0000000 0000 0176 0101 0001 5507 abd5 7645 1768
    0000010 0000 016d 0101 0001 ee1e ac6b 7645 1768
    ...

Signed-off-by: Leonard Göhrs <l.goehrs@pengutronix.de>
---
 drivers/iio/adc/ti-lmp92064.c | 54 +++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/drivers/iio/adc/ti-lmp92064.c b/drivers/iio/adc/ti-lmp92064.c
index c30ed824924f3..03765c4057dda 100644
--- a/drivers/iio/adc/ti-lmp92064.c
+++ b/drivers/iio/adc/ti-lmp92064.c
@@ -16,7 +16,10 @@
 #include <linux/spi/spi.h>
 
 #include <linux/iio/iio.h>
+#include <linux/iio/buffer.h>
 #include <linux/iio/driver.h>
+#include <linux/iio/triggered_buffer.h>
+#include <linux/iio/trigger_consumer.h>
 
 #define TI_LMP92064_REG_CONFIG_A 0x0000
 #define TI_LMP92064_REG_CONFIG_B 0x0001
@@ -91,6 +94,13 @@ static const struct iio_chan_spec lmp92064_adc_channels[] = {
 		.address = TI_LMP92064_CHAN_INC,
 		.info_mask_separate =
 			BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
+		.scan_index = 0,
+		.scan_type = {
+			.sign = 'u',
+			.realbits = 12,
+			.storagebits = 16,
+			.shift = 0,
+		},
 		.datasheet_name = "INC",
 	},
 	{
@@ -98,8 +108,16 @@ static const struct iio_chan_spec lmp92064_adc_channels[] = {
 		.address = TI_LMP92064_CHAN_INV,
 		.info_mask_separate =
 			BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
+		.scan_index = 1,
+		.scan_type = {
+			.sign = 'u',
+			.realbits = 12,
+			.storagebits = 16,
+			.shift = 0,
+		},
 		.datasheet_name = "INV",
 	},
+	IIO_CHAN_SOFT_TIMESTAMP(2),
 };
 
 static int lmp92064_read_meas(struct lmp92064_adc_priv *priv, u16 *res)
@@ -171,6 +189,37 @@ static int lmp92064_read_raw(struct iio_dev *indio_dev,
 	}
 }
 
+static irqreturn_t lmp92064_trigger_handler(int irq, void *p)
+{
+	struct iio_poll_func *pf = p;
+	struct iio_dev *indio_dev = pf->indio_dev;
+	struct lmp92064_adc_priv *priv = iio_priv(indio_dev);
+	int i = 0, j, ret;
+	u16 raw[2];
+	u16 *data;
+
+	ret = lmp92064_read_meas(priv, raw);
+	if (ret < 0)
+		goto done;
+
+	data = kmalloc(indio_dev->scan_bytes, GFP_KERNEL);
+	if (!data)
+		goto done;
+
+	for_each_set_bit(j, indio_dev->active_scan_mask, indio_dev->masklength)
+		data[i++] = raw[j];
+
+	iio_push_to_buffers_with_timestamp(indio_dev, data,
+					   iio_get_time_ns(indio_dev));
+
+	kfree(data);
+
+done:
+	iio_trigger_notify_done(indio_dev->trig);
+
+	return IRQ_HANDLED;
+}
+
 static int lmp92064_reset(struct lmp92064_adc_priv *priv,
 			  struct gpio_desc *gpio_reset)
 {
@@ -302,6 +351,11 @@ static int lmp92064_adc_probe(struct spi_device *spi)
 	indio_dev->num_channels = ARRAY_SIZE(lmp92064_adc_channels);
 	indio_dev->info = &lmp92064_adc_info;
 
+	ret = devm_iio_triggered_buffer_setup(dev, indio_dev, NULL,
+					      lmp92064_trigger_handler, NULL);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to setup buffered read\n");
+
 	return devm_iio_device_register(dev, indio_dev);
 }
 

base-commit: 9561de3a55bed6bdd44a12820ba81ec416e705a7
-- 
2.39.2

