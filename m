Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4881072E49F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 15:51:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242646AbjFMNuy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 09:50:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242472AbjFMNuf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 09:50:35 -0400
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D07B810E6;
        Tue, 13 Jun 2023 06:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1686664233;
  x=1718200233;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kgNTlD4z0T4E+uI10IZA/4tKLCxHr/VPJvF4z3YcRjE=;
  b=C/daK4LSaA16TUEOamIex9/1nCyN57NXgopQKIYbO9bNAp3Jrg1yaCcy
   KwjdG18VHwYxA1DNey6kLj/sQuZ6PyXGdX4bvSjP1pHqGykuge10qQaPJ
   e+ISJyqezNZhvjrANHdODEePt4FipohPNcaX1kHP+VWXBxHdvj/6q1y1D
   ePre7pJEVbksTINBfK6oSWaXB7LXn0X2sLiOgn3a4y92QUzCIo/GDoIpW
   TzqHkAr4nM+va8Iq+d5wiiA/b4w67UBh800TaUqNGHC1n+8K3/doOhdlx
   IhjnUYYk98BfT0aE6PODVK7L8eAnOxQR0o1u88RHSsNAJoXaYVXQkY8L9
   g==;
From:   Astrid Rost <astrid.rost@axis.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
CC:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel@axis.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Mathieu Othacehe <m.othacehe@gmail.com>,
        Astrid Rost <astrid.rost@axis.com>
Subject: [PATCH v6 5/8] iio: light: vcnl4000: add illuminance irq vcnl4040/4200
Date:   Tue, 13 Jun 2023 15:50:21 +0200
Message-ID: <20230613135025.2596641-6-astrid.rost@axis.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230613135025.2596641-1-astrid.rost@axis.com>
References: <20230613135025.2596641-1-astrid.rost@axis.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support to configure ambient light sensor interrupts and threshold
limits for vcnl4040 and vcnl4200. If an interrupt is detected an event
will be pushed to the event interface.

Signed-off-by: Astrid Rost <astrid.rost@axis.com>
---
 drivers/iio/light/vcnl4000.c | 94 +++++++++++++++++++++++++++++++++++-
 1 file changed, 92 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
index 0a96e9451ec7..0f4c39adc68a 100644
--- a/drivers/iio/light/vcnl4000.c
+++ b/drivers/iio/light/vcnl4000.c
@@ -62,6 +62,8 @@
 #define VCNL4200_PS_CONF1	0x03 /* Proximity configuration */
 #define VCNL4040_PS_THDL_LM	0x06 /* Proximity threshold low */
 #define VCNL4040_PS_THDH_LM	0x07 /* Proximity threshold high */
+#define VCNL4040_ALS_THDL_LM	0x02 /* Ambient light threshold low */
+#define VCNL4040_ALS_THDH_LM	0x01 /* Ambient light threshold high */
 #define VCNL4200_PS_DATA	0x08 /* Proximity data */
 #define VCNL4200_AL_DATA	0x09 /* Ambient light data */
 #define VCNL4040_INT_FLAGS	0x0b /* Interrupt register */
@@ -81,11 +83,14 @@
 
 #define VCNL4040_ALS_CONF_ALS_SHUTDOWN	BIT(0)
 #define VCNL4040_ALS_CONF_IT		GENMASK(7, 6) /* Ambient integration time */
+#define VCNL4040_ALS_CONF_INT_EN	BIT(1) /* Ambient light Interrupt enable */
 #define VCNL4040_PS_CONF1_PS_SHUTDOWN	BIT(0)
 #define VCNL4040_PS_CONF2_PS_IT	GENMASK(3, 1) /* Proximity integration time */
 #define VCNL4040_PS_CONF2_PS_INT	GENMASK(9, 8) /* Proximity interrupt mode */
 #define VCNL4040_PS_IF_AWAY		BIT(8) /* Proximity event cross low threshold */
 #define VCNL4040_PS_IF_CLOSE		BIT(9) /* Proximity event cross high threshold */
+#define VCNL4040_ALS_RISING		BIT(12) /* Ambient Light cross high threshold */
+#define VCNL4040_ALS_FALLING		BIT(13) /* Ambient Light cross low threshold */
 
 /* Bit masks for interrupt registers. */
 #define VCNL4010_INT_THR_SEL	BIT(0) /* Select threshold interrupt source */
@@ -170,6 +175,7 @@ struct vcnl4000_data {
 	int rev;
 	int al_scale;
 	u8 ps_int;		/* proximity interrupt mode */
+	u8 als_int;		/* ambient light interrupt mode*/
 	const struct vcnl4000_chip_spec *chip_spec;
 	struct mutex vcnl4000_lock;
 	struct vcnl4200_channel vcnl4200_al;
@@ -295,7 +301,7 @@ static int vcnl4200_set_power_state(struct vcnl4000_data *data, bool on)
 	int ret;
 
 	/* Do not power down if interrupts are enabled */
-	if (!on && data->ps_int)
+	if (!on && (data->ps_int || data->als_int))
 		return 0;
 
 	ret = vcnl4000_write_als_enable(data, on);
@@ -340,6 +346,7 @@ static int vcnl4200_init(struct vcnl4000_data *data)
 
 	data->rev = (ret >> 8) & 0xf;
 	data->ps_int = 0;
+	data->als_int = 0;
 
 	data->vcnl4200_al.reg = VCNL4200_AL_DATA;
 	data->vcnl4200_ps.reg = VCNL4200_PS_DATA;
@@ -930,6 +937,26 @@ static int vcnl4040_read_event(struct iio_dev *indio_dev,
 	struct vcnl4000_data *data = iio_priv(indio_dev);
 
 	switch (chan->type) {
+	case IIO_LIGHT:
+		switch (info) {
+		case IIO_EV_INFO_VALUE:
+			switch (dir) {
+			case IIO_EV_DIR_RISING:
+				ret = i2c_smbus_read_word_data(data->client,
+							       VCNL4040_ALS_THDH_LM);
+				break;
+			case IIO_EV_DIR_FALLING:
+				ret = i2c_smbus_read_word_data(data->client,
+							       VCNL4040_ALS_THDL_LM);
+				break;
+			default:
+				return -EINVAL;
+			}
+			break;
+		default:
+			return -EINVAL;
+		}
+		break;
 	case IIO_PROXIMITY:
 		switch (info) {
 		case IIO_EV_INFO_VALUE:
@@ -970,6 +997,28 @@ static int vcnl4040_write_event(struct iio_dev *indio_dev,
 	struct vcnl4000_data *data = iio_priv(indio_dev);
 
 	switch (chan->type) {
+	case IIO_LIGHT:
+		switch (info) {
+		case IIO_EV_INFO_VALUE:
+			switch (dir) {
+			case IIO_EV_DIR_RISING:
+				ret = i2c_smbus_write_word_data(data->client,
+								VCNL4040_ALS_THDH_LM,
+								val);
+				break;
+			case IIO_EV_DIR_FALLING:
+				ret = i2c_smbus_write_word_data(data->client,
+								VCNL4040_ALS_THDL_LM,
+								val);
+				break;
+			default:
+				return -EINVAL;
+			}
+			break;
+		default:
+			return -EINVAL;
+		}
+		break;
 	case IIO_PROXIMITY:
 		switch (info) {
 		case IIO_EV_INFO_VALUE:
@@ -1091,6 +1140,14 @@ static int vcnl4040_read_event_config(struct iio_dev *indio_dev,
 	struct vcnl4000_data *data = iio_priv(indio_dev);
 
 	switch (chan->type) {
+	case IIO_LIGHT:
+		ret = i2c_smbus_read_word_data(data->client, VCNL4200_AL_CONF);
+		if (ret < 0)
+			return ret;
+
+		data->als_int = FIELD_GET(VCNL4040_ALS_CONF_INT_EN, ret);
+
+		return data->als_int;
 	case IIO_PROXIMITY:
 		ret = i2c_smbus_read_word_data(data->client, VCNL4200_PS_CONF1);
 		if (ret < 0)
@@ -1118,6 +1175,21 @@ static int vcnl4040_write_event_config(struct iio_dev *indio_dev,
 	mutex_lock(&data->vcnl4000_lock);
 
 	switch (chan->type) {
+	case IIO_LIGHT:
+		ret = i2c_smbus_read_word_data(data->client, VCNL4200_AL_CONF);
+		if (ret < 0)
+			goto out;
+
+		mask = VCNL4040_ALS_CONF_INT_EN;
+		if (state)
+			val = (ret | mask);
+		else
+			val = (ret & ~mask);
+
+		data->als_int = FIELD_GET(VCNL4040_ALS_CONF_INT_EN, val);
+		ret = i2c_smbus_write_word_data(data->client, VCNL4200_AL_CONF,
+						val);
+		break;
 	case IIO_PROXIMITY:
 		ret = i2c_smbus_read_word_data(data->client, VCNL4200_PS_CONF1);
 		if (ret < 0)
@@ -1140,7 +1212,7 @@ static int vcnl4040_write_event_config(struct iio_dev *indio_dev,
 
 out:
 	mutex_unlock(&data->vcnl4000_lock);
-	data->chip_spec->set_power_state(data, data->ps_int != 0);
+	data->chip_spec->set_power_state(data, data->ps_int || data->als_int);
 
 	return ret;
 }
@@ -1171,6 +1243,22 @@ static irqreturn_t vcnl4040_irq_thread(int irq, void *p)
 			       iio_get_time_ns(indio_dev));
 	}
 
+	if (ret & VCNL4040_ALS_FALLING) {
+		iio_push_event(indio_dev,
+			       IIO_UNMOD_EVENT_CODE(IIO_LIGHT, 0,
+						    IIO_EV_TYPE_THRESH,
+						    IIO_EV_DIR_FALLING),
+			       iio_get_time_ns(indio_dev));
+	}
+
+	if (ret & VCNL4040_ALS_RISING) {
+		iio_push_event(indio_dev,
+			       IIO_UNMOD_EVENT_CODE(IIO_LIGHT, 0,
+						    IIO_EV_TYPE_THRESH,
+						    IIO_EV_DIR_RISING),
+			       iio_get_time_ns(indio_dev));
+	}
+
 	return IRQ_HANDLED;
 }
 
@@ -1393,6 +1481,8 @@ static const struct iio_chan_spec vcnl4040_channels[] = {
 			BIT(IIO_CHAN_INFO_SCALE) |
 			BIT(IIO_CHAN_INFO_INT_TIME),
 		.info_mask_separate_available = BIT(IIO_CHAN_INFO_INT_TIME),
+		.event_spec = vcnl4000_event_spec,
+		.num_event_specs = ARRAY_SIZE(vcnl4000_event_spec),
 	}, {
 		.type = IIO_PROXIMITY,
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
-- 
2.30.2

