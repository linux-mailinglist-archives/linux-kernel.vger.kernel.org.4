Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA916706C68
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 17:14:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231851AbjEQPOi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 11:14:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231611AbjEQPOV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 11:14:21 -0400
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B397AE43;
        Wed, 17 May 2023 08:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1684336460;
  x=1715872460;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3poRGkN41jkJEPK9lG1921iFSsg6JH985dOEIMJ4fYk=;
  b=fUZxErfBnrEDkU6igRTtXEklEyTGK9kiaGlpqMzwY5QwJrzBfCyvLCp7
   UDRd1G0UESXDyKpBNqaWapaVXhBxBtRZyCPiiGUoeSqdw7tqhIwH0dbOl
   qQovt8HYfFSga/Gs7pKz5tbgv41ZfYtBSey0CPtKfZ/5Cu6vfUaPvx4on
   VQVPfip7gfuKq+fLc5u2fXevZ56aXmkLQglSMOAkcK3j5ol515vgV3LPm
   GCyB1lkTTWW7/DTGGK1jGRucWG7CApzjHvxLoq7Mn4wWY7izbPhNCz+L0
   LleXstvmRRFIwIw7zqfZVegoMV+Gi6W5X8bxCS4+lnNcWjaWDfucJ49ay
   w==;
From:   Astrid Rost <astrid.rost@axis.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
CC:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel@axis.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Mathieu Othacehe <m.othacehe@gmail.com>,
        Astrid Rost <astrid.rost@axis.com>
Subject: [PATCH v3 4/7] iio: light: vcnl4000: add illuminance irq vcnl4040/4200
Date:   Wed, 17 May 2023 17:14:03 +0200
Message-ID: <20230517151406.368219-5-astrid.rost@axis.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230517151406.368219-1-astrid.rost@axis.com>
References: <20230517151406.368219-1-astrid.rost@axis.com>
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
 drivers/iio/light/vcnl4000.c | 197 ++++++++++++++++++++++++++---------
 1 file changed, 146 insertions(+), 51 deletions(-)

diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
index 8508fb197e2e..73158bde5686 100644
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
@@ -293,7 +299,7 @@ static int vcnl4200_set_power_state(struct vcnl4000_data *data, bool on)
 	int ret;
 
 	/* Do not power down if interrupts are enabled */
-	if (!on && data->ps_int)
+	if (!on && (data->ps_int || data->als_int))
 		return 0;
 
 	ret = vcnl4000_write_als_enable(data, on);
@@ -338,6 +344,7 @@ static int vcnl4200_init(struct vcnl4000_data *data)
 
 	data->rev = (ret >> 8) & 0xf;
 	data->ps_int = 0;
+	data->als_int = 0;
 
 	data->vcnl4200_al.reg = VCNL4200_AL_DATA;
 	data->vcnl4200_ps.reg = VCNL4200_PS_DATA;
@@ -932,27 +939,45 @@ static int vcnl4040_read_event(struct iio_dev *indio_dev,
 			       enum iio_event_info info,
 			       int *val, int *val2)
 {
-	int ret;
+	int ret = -EINVAL;
 	struct vcnl4000_data *data = iio_priv(indio_dev);
 
-	switch (dir) {
-	case IIO_EV_DIR_RISING:
-		ret = i2c_smbus_read_word_data(data->client,
-					       VCNL4040_PS_THDH_LM);
-		if (ret < 0)
-			return ret;
-		*val = ret;
-		return IIO_VAL_INT;
-	case IIO_EV_DIR_FALLING:
-		ret = i2c_smbus_read_word_data(data->client,
-					       VCNL4040_PS_THDL_LM);
-		if (ret < 0)
-			return ret;
-		*val = ret;
-		return IIO_VAL_INT;
+	switch (chan->type) {
+	case IIO_LIGHT:
+		switch (dir) {
+		case IIO_EV_DIR_RISING:
+			ret = i2c_smbus_read_word_data(data->client,
+						       VCNL4040_ALS_THDH_LM);
+			break;
+		case IIO_EV_DIR_FALLING:
+			ret = i2c_smbus_read_word_data(data->client,
+						       VCNL4040_ALS_THDL_LM);
+			break;
+		default:
+			return -EINVAL;
+		}
+		break;
+	case IIO_PROXIMITY:
+		switch (dir) {
+		case IIO_EV_DIR_RISING:
+			ret = i2c_smbus_read_word_data(data->client,
+						       VCNL4040_PS_THDH_LM);
+			break;
+		case IIO_EV_DIR_FALLING:
+			ret = i2c_smbus_read_word_data(data->client,
+						       VCNL4040_PS_THDL_LM);
+			break;
+		default:
+			return -EINVAL;
+		}
+		break;
 	default:
 		return -EINVAL;
 	}
+	if (ret < 0)
+		return ret;
+	*val = ret;
+	return IIO_VAL_INT;
 }
 
 static int vcnl4040_write_event(struct iio_dev *indio_dev,
@@ -962,25 +987,43 @@ static int vcnl4040_write_event(struct iio_dev *indio_dev,
 				enum iio_event_info info,
 				int val, int val2)
 {
-	int ret;
+	int ret = -EINVAL;
 	struct vcnl4000_data *data = iio_priv(indio_dev);
-
-	switch (dir) {
-	case IIO_EV_DIR_RISING:
-		ret = i2c_smbus_write_word_data(data->client,
-						VCNL4040_PS_THDH_LM, val);
-		if (ret < 0)
-			return ret;
-		return IIO_VAL_INT;
-	case IIO_EV_DIR_FALLING:
-		ret = i2c_smbus_write_word_data(data->client,
-						VCNL4040_PS_THDL_LM, val);
-		if (ret < 0)
-			return ret;
-		return IIO_VAL_INT;
+	switch (chan->type) {
+	case IIO_LIGHT:
+		switch (dir) {
+		case IIO_EV_DIR_RISING:
+			ret = i2c_smbus_write_word_data(
+				data->client, VCNL4040_ALS_THDH_LM, val);
+			break;
+		case IIO_EV_DIR_FALLING:
+			ret = i2c_smbus_write_word_data(
+				data->client, VCNL4040_ALS_THDL_LM, val);
+			break;
+		default:
+			return -EINVAL;
+		}
+		break;
+	case IIO_PROXIMITY:
+		switch (dir) {
+		case IIO_EV_DIR_RISING:
+			ret = i2c_smbus_write_word_data(
+				data->client, VCNL4040_PS_THDH_LM, val);
+			break;
+		case IIO_EV_DIR_FALLING:
+			ret = i2c_smbus_write_word_data(
+				data->client, VCNL4040_PS_THDL_LM, val);
+			break;
+		default:
+			return -EINVAL;
+		}
+		break;
 	default:
 		return -EINVAL;
 	}
+	if (ret < 0)
+		return ret;
+	return IIO_VAL_INT;
 }
 
 static bool vcnl4010_is_thr_enabled(struct vcnl4000_data *data)
@@ -1072,16 +1115,28 @@ static int vcnl4040_read_event_config(struct iio_dev *indio_dev,
 {
 	int ret;
 	struct vcnl4000_data *data = iio_priv(indio_dev);
+	switch (chan->type) {
+	case IIO_LIGHT:
+		ret = i2c_smbus_read_word_data(data->client, VCNL4200_AL_CONF);
+		if (ret < 0)
+			return ret;
 
-	ret = i2c_smbus_read_word_data(data->client, VCNL4200_PS_CONF1);
-	if (ret < 0)
-		return ret;
+		data->als_int = FIELD_GET(VCNL4040_ALS_CONF_INT_EN, ret);
 
-	data->ps_int = FIELD_GET(VCNL4040_PS_CONF2_PS_INT, ret);
+		return data->als_int;
+	case IIO_PROXIMITY:
+		ret = i2c_smbus_read_word_data(data->client, VCNL4200_PS_CONF1);
+		if (ret < 0)
+			return ret;
+
+		data->ps_int = FIELD_GET(VCNL4040_PS_CONF2_PS_INT, ret);
 
-	return (dir == IIO_EV_DIR_RISING) ?
-		FIELD_GET(VCNL4040_PS_IF_AWAY, ret) :
-		FIELD_GET(VCNL4040_PS_IF_CLOSE, ret);
+		return (dir == IIO_EV_DIR_RISING) ?
+			FIELD_GET(VCNL4040_PS_IF_AWAY, ret) :
+			FIELD_GET(VCNL4040_PS_IF_CLOSE, ret);
+	default:
+		return -EINVAL;
+	}
 }
 
 static int vcnl4040_write_event_config(struct iio_dev *indio_dev,
@@ -1089,29 +1144,51 @@ static int vcnl4040_write_event_config(struct iio_dev *indio_dev,
 				       enum iio_event_type type,
 				       enum iio_event_direction dir, int state)
 {
-	int ret;
+	int ret = -EINVAL;
 	u16 val, mask;
 	struct vcnl4000_data *data = iio_priv(indio_dev);
 
 	mutex_lock(&data->vcnl4000_lock);
 
-	ret = i2c_smbus_read_word_data(data->client, VCNL4200_PS_CONF1);
-	if (ret < 0)
-		goto out;
+	switch (chan->type) {
+	case IIO_LIGHT:
+		ret = i2c_smbus_read_word_data(data->client, VCNL4200_AL_CONF);
+		if (ret < 0)
+			goto out;
 
-	if (dir == IIO_EV_DIR_RISING)
-		mask = VCNL4040_PS_IF_AWAY;
-	else
-		mask = VCNL4040_PS_IF_CLOSE;
+		mask = VCNL4040_ALS_CONF_INT_EN;
 
-	val = state ? (ret | mask) : (ret & ~mask);
+		val = state ? (ret | mask) : (ret & ~mask);
 
-	data->ps_int = FIELD_GET(VCNL4040_PS_CONF2_PS_INT, val);
-	ret = i2c_smbus_write_word_data(data->client, VCNL4200_PS_CONF1, val);
+		data->als_int = FIELD_GET(VCNL4040_ALS_CONF_INT_EN, val);
+		ret = i2c_smbus_write_word_data(data->client, VCNL4200_AL_CONF,
+						val);
+		break;
+	case IIO_PROXIMITY:
+
+		ret = i2c_smbus_read_word_data(data->client, VCNL4200_PS_CONF1);
+		if (ret < 0)
+			goto out;
+
+		if (dir == IIO_EV_DIR_RISING)
+			mask = VCNL4040_PS_IF_AWAY;
+		else
+			mask = VCNL4040_PS_IF_CLOSE;
+
+		val = state ? (ret | mask) : (ret & ~mask);
+
+		data->ps_int = FIELD_GET(VCNL4040_PS_CONF2_PS_INT, val);
+		ret = i2c_smbus_write_word_data(data->client, VCNL4200_PS_CONF1,
+						val);
+		break;
+	default:
+		break;
+	}
 
 out:
 	mutex_unlock(&data->vcnl4000_lock);
-	data->chip_spec->set_power_state(data, data->ps_int != 0);
+	data->chip_spec->set_power_state(data, data->ps_int ||
+						data->als_int);
 
 	return ret;
 }
@@ -1142,6 +1219,22 @@ static irqreturn_t vcnl4040_irq_thread(int irq, void *p)
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
 
@@ -1364,6 +1457,8 @@ static const struct iio_chan_spec vcnl4040_channels[] = {
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

