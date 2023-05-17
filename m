Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44F35706C66
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 17:14:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231932AbjEQPO3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 11:14:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231447AbjEQPOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 11:14:19 -0400
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BB6710E0;
        Wed, 17 May 2023 08:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1684336458;
  x=1715872458;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=r2iio70x0Z8VwDgRt4sa+LIGwccHUc0SAq3QTo10zPI=;
  b=YDtOXM5DYjS0+qJxYPUDL26wt1p6eIyJsZtsvxqAknWqMQ0dxlUsuMVp
   oRBnrNg1QQmiyMA4mLx/B5xvrA2laruuEbIP2vlnX0p72n44IKgiQApd9
   Om62qaOA++/J+HqgtkqFibBbI7T1nvd0SADfsqaXlD0LYvXG7wNSqJcyu
   yM6Ah0bG7pEnFODRnZB2aUHD87YaSXJBpNgfRCg5GmyQFALWBGsE+4mDX
   /vNqxNc5qzS2Iwn4Jy44ZZWGeP6d7orKDmVbKH2qUFOdjhiWSMdLOXDRx
   IbS6XRGopL4sewOuvnCYeO5937+mGoBmmAg3KYO0cqehpHl+75bvjwsrA
   A==;
From:   Astrid Rost <astrid.rost@axis.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
CC:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel@axis.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Mathieu Othacehe <m.othacehe@gmail.com>,
        Astrid Rost <astrid.rost@axis.com>
Subject: [PATCH v3 5/7] iio: light: vcnl4000: Add period for vcnl4040/4200
Date:   Wed, 17 May 2023 17:14:04 +0200
Message-ID: <20230517151406.368219-6-astrid.rost@axis.com>
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

Add read/write attribute for proximity and illuminance period.
The period is set in the interrupt persistence flags
(PS_PERS and ALS_PERS). An interrupt will not be asserted if the raw
value is not over (or lower) than the threshold for the set
continued amount of measurements.
The time in seconds is calculated by the number of continued refreshes
multiplied with the integration time.
It will always pick the next lower possible value. The period changes,
if the integration time is changed.

Signed-off-by: Astrid Rost <astrid.rost@axis.com>
---
 drivers/iio/light/vcnl4000.c | 255 ++++++++++++++++++++++++++++++-----
 1 file changed, 220 insertions(+), 35 deletions(-)

diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
index 73158bde5686..a0b99f82f8c4 100644
--- a/drivers/iio/light/vcnl4000.c
+++ b/drivers/iio/light/vcnl4000.c
@@ -84,8 +84,10 @@
 #define VCNL4040_ALS_CONF_ALS_SHUTDOWN	BIT(0)
 #define VCNL4040_ALS_CONF_IT		GENMASK(7, 6) /* Ambient integration time */
 #define VCNL4040_ALS_CONF_INT_EN	BIT(1) /* Ambient light Interrupt enable */
+#define VCNL4040_ALS_CONF_PERS	GENMASK(3, 2) /* Ambient interrupt persistence setting */
 #define VCNL4040_PS_CONF1_PS_SHUTDOWN	BIT(0)
 #define VCNL4040_PS_CONF2_PS_IT	GENMASK(3, 1) /* Proximity integration time */
+#define VCNL4040_CONF1_PS_PERS	GENMASK(5, 4) /* Proximity interrupt persistence setting */
 #define VCNL4040_PS_CONF2_PS_INT	GENMASK(9, 8) /* Proximity interrupt mode */
 #define VCNL4040_PS_IF_AWAY		BIT(8) /* Proximity event cross low threshold */
 #define VCNL4040_PS_IF_CLOSE		BIT(9) /* Proximity event cross high threshold */
@@ -152,6 +154,8 @@ static const int vcnl4200_als_it_times[][2] = {
 	{0, 200000},
 	{0, 400000},
 };
+static const int vcnl4040_als_persistence[] = {1, 2, 4, 8};
+static const int vcnl4040_ps_persistence[] = {1, 2, 3, 4};
 
 #define VCNL4000_SLEEP_DELAY_MS	2000 /* before we enter pm_runtime_suspend */
 
@@ -646,6 +650,135 @@ static ssize_t vcnl4040_write_ps_it(struct vcnl4000_data *data, int val)
 	return ret;
 }
 
+static ssize_t vcnl4040_read_als_period(struct vcnl4000_data *data, int *val, int *val2)
+{
+	int ret, ret_pers, ret_it;
+	int64_t val_c;
+
+	ret = i2c_smbus_read_word_data(data->client, VCNL4200_AL_CONF);
+	if (ret < 0)
+		return ret;
+
+	ret_pers = FIELD_GET(VCNL4040_ALS_CONF_PERS, ret);
+
+	if (ret_pers >= ARRAY_SIZE(vcnl4040_als_persistence))
+		return -EINVAL;
+
+	ret_it = FIELD_GET(VCNL4040_ALS_CONF_IT, ret);
+
+	if (ret_it >= data->chip_spec->num_als_it_times)
+		return -EINVAL;
+
+	val_c = mul_u32_u32((*data->chip_spec->als_it_times)[ret_it][1],
+	      vcnl4040_als_persistence[ret_pers]);
+	*val = div_u64_rem(val_c, 1000000, val2);
+
+	return IIO_VAL_INT_PLUS_MICRO;
+}
+
+static ssize_t vcnl4040_write_als_period(struct vcnl4000_data *data, int val, int val2)
+{
+	unsigned int index;
+	int ret, ret_it;
+	u16 regval;
+	int64_t val_n = mul_u32_u32(val, 1000000) + val2;
+
+	ret = i2c_smbus_read_word_data(data->client, VCNL4200_AL_CONF);
+	if (ret < 0)
+		return ret;
+
+	ret_it = FIELD_GET(VCNL4040_ALS_CONF_IT, ret);
+
+	if (ret_it >= data->chip_spec->num_als_it_times)
+		return -EINVAL;
+
+	for (index = 0; index < ARRAY_SIZE(vcnl4040_als_persistence) - 1; index++)
+		if (val_n < mul_u32_u32(vcnl4040_als_persistence[index],
+				(*data->chip_spec->als_it_times)[ret_it][1]))
+			break;
+
+	mutex_lock(&data->vcnl4000_lock);
+
+	ret = i2c_smbus_read_word_data(data->client, VCNL4200_AL_CONF);
+	if (ret < 0)
+		goto out;
+
+	regval = (ret & ~VCNL4040_ALS_CONF_PERS) |
+	    FIELD_PREP(VCNL4040_ALS_CONF_PERS, index);
+	ret = i2c_smbus_write_word_data(data->client, VCNL4200_AL_CONF,
+					regval);
+
+out:
+	mutex_unlock(&data->vcnl4000_lock);
+	return ret;
+}
+
+static ssize_t vcnl4040_read_ps_period(struct vcnl4000_data *data, int *val, int *val2)
+{
+	int ret, ret_pers, ret_it;
+
+	ret = i2c_smbus_read_word_data(data->client, VCNL4200_PS_CONF1);
+	if (ret < 0)
+		return ret;
+
+	ret_pers = FIELD_GET(VCNL4040_CONF1_PS_PERS, ret);
+
+	if (ret_pers >= ARRAY_SIZE(vcnl4040_ps_persistence))
+		return -EINVAL;
+
+	ret_it = FIELD_GET(VCNL4040_PS_CONF2_PS_IT, ret);
+
+	if (ret_it >= data->chip_spec->num_ps_it_times)
+		return -EINVAL;
+
+	*val = (*data->chip_spec->ps_it_times)[ret_it][0];
+	*val2 = (*data->chip_spec->ps_it_times)[ret_it][1]
+		* vcnl4040_ps_persistence[ret_pers];
+
+	return IIO_VAL_INT_PLUS_MICRO;
+}
+
+static ssize_t vcnl4040_write_ps_period(struct vcnl4000_data *data, int val, int val2)
+{
+	int ret, ret_it, index;
+	u16 regval;
+
+	ret = i2c_smbus_read_word_data(data->client, VCNL4200_PS_CONF1);
+	if (ret < 0)
+		return ret;
+
+	ret_it = FIELD_GET(VCNL4040_PS_CONF2_PS_IT, ret);
+
+	if (ret_it >= data->chip_spec->num_ps_it_times)
+		return -EINVAL;
+
+	if (val > 9)
+		index = ARRAY_SIZE(vcnl4040_ps_persistence) - 1;
+	else {
+		for (index = 0; index < ARRAY_SIZE(vcnl4040_ps_persistence) - 1; index++) {
+			if (val2 <= vcnl4040_ps_persistence[index]
+					* (*data->chip_spec->ps_it_times)[ret_it][1])
+				break;
+		}
+	}
+
+	mutex_lock(&data->vcnl4000_lock);
+
+	ret = i2c_smbus_read_word_data(data->client, VCNL4200_PS_CONF1);
+	if (ret < 0)
+		goto out;
+
+	regval = (ret & ~VCNL4040_CONF1_PS_PERS) |
+	    FIELD_PREP(VCNL4040_CONF1_PS_PERS, index);
+	ret = i2c_smbus_write_word_data(data->client, VCNL4200_PS_CONF1,
+					regval);
+
+out:
+	mutex_unlock(&data->vcnl4000_lock);
+	return ret;
+}
+
+
 static int vcnl4000_read_raw(struct iio_dev *indio_dev,
 				struct iio_chan_spec const *chan,
 				int *val, int *val2, long mask)
@@ -944,28 +1077,44 @@ static int vcnl4040_read_event(struct iio_dev *indio_dev,
 
 	switch (chan->type) {
 	case IIO_LIGHT:
-		switch (dir) {
-		case IIO_EV_DIR_RISING:
-			ret = i2c_smbus_read_word_data(data->client,
-						       VCNL4040_ALS_THDH_LM);
-			break;
-		case IIO_EV_DIR_FALLING:
-			ret = i2c_smbus_read_word_data(data->client,
-						       VCNL4040_ALS_THDL_LM);
+		switch (info) {
+		case IIO_EV_INFO_PERIOD:
+			return vcnl4040_read_als_period(data, val, val2);
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
 			break;
 		default:
 			return -EINVAL;
 		}
 		break;
 	case IIO_PROXIMITY:
-		switch (dir) {
-		case IIO_EV_DIR_RISING:
-			ret = i2c_smbus_read_word_data(data->client,
-						       VCNL4040_PS_THDH_LM);
-			break;
-		case IIO_EV_DIR_FALLING:
-			ret = i2c_smbus_read_word_data(data->client,
-						       VCNL4040_PS_THDL_LM);
+		switch (info) {
+		case IIO_EV_INFO_PERIOD:
+			return vcnl4040_read_ps_period(data, val, val2);
+		case IIO_EV_INFO_VALUE:
+			switch (dir) {
+			case IIO_EV_DIR_RISING:
+				ret = i2c_smbus_read_word_data(data->client,
+							       VCNL4040_PS_THDH_LM);
+				break;
+			case IIO_EV_DIR_FALLING:
+				ret = i2c_smbus_read_word_data(data->client,
+							       VCNL4040_PS_THDL_LM);
+				break;
+			default:
+				return -EINVAL;
+			}
 			break;
 		default:
 			return -EINVAL;
@@ -991,28 +1140,44 @@ static int vcnl4040_write_event(struct iio_dev *indio_dev,
 	struct vcnl4000_data *data = iio_priv(indio_dev);
 	switch (chan->type) {
 	case IIO_LIGHT:
-		switch (dir) {
-		case IIO_EV_DIR_RISING:
-			ret = i2c_smbus_write_word_data(
-				data->client, VCNL4040_ALS_THDH_LM, val);
-			break;
-		case IIO_EV_DIR_FALLING:
-			ret = i2c_smbus_write_word_data(
-				data->client, VCNL4040_ALS_THDL_LM, val);
+		switch (info) {
+		case IIO_EV_INFO_PERIOD:
+			return vcnl4040_write_als_period(data, val, val2);
+		case IIO_EV_INFO_VALUE:
+			switch (dir) {
+			case IIO_EV_DIR_RISING:
+				ret = i2c_smbus_write_word_data(
+					data->client, VCNL4040_ALS_THDH_LM, val);
+				break;
+			case IIO_EV_DIR_FALLING:
+				ret = i2c_smbus_write_word_data(
+					data->client, VCNL4040_ALS_THDL_LM, val);
+				break;
+			default:
+				return -EINVAL;
+			}
 			break;
 		default:
 			return -EINVAL;
 		}
 		break;
 	case IIO_PROXIMITY:
-		switch (dir) {
-		case IIO_EV_DIR_RISING:
-			ret = i2c_smbus_write_word_data(
-				data->client, VCNL4040_PS_THDH_LM, val);
-			break;
-		case IIO_EV_DIR_FALLING:
-			ret = i2c_smbus_write_word_data(
-				data->client, VCNL4040_PS_THDL_LM, val);
+		switch (info) {
+		case IIO_EV_INFO_PERIOD:
+			return vcnl4040_write_ps_period(data, val, val2);
+		case IIO_EV_INFO_VALUE:
+			switch (dir) {
+			case IIO_EV_DIR_RISING:
+				ret = i2c_smbus_write_word_data(
+					data->client, VCNL4040_PS_THDH_LM, val);
+				break;
+			case IIO_EV_DIR_FALLING:
+				ret = i2c_smbus_write_word_data(
+					data->client, VCNL4040_PS_THDL_LM, val);
+				break;
+			default:
+				return -EINVAL;
+			}
 			break;
 		default:
 			return -EINVAL;
@@ -1401,6 +1566,22 @@ static const struct iio_event_spec vcnl4000_event_spec[] = {
 	}
 };
 
+static const struct iio_event_spec vcnl4040_als_event_spec[] = {
+	{
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_RISING,
+		.mask_separate = BIT(IIO_EV_INFO_VALUE),
+	}, {
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_FALLING,
+		.mask_separate = BIT(IIO_EV_INFO_VALUE),
+	}, {
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_EITHER,
+		.mask_separate = BIT(IIO_EV_INFO_ENABLE) |  BIT(IIO_EV_INFO_PERIOD),
+	}
+};
+
 static const struct iio_event_spec vcnl4040_event_spec[] = {
 	{
 		.type = IIO_EV_TYPE_THRESH,
@@ -1410,7 +1591,11 @@ static const struct iio_event_spec vcnl4040_event_spec[] = {
 		.type = IIO_EV_TYPE_THRESH,
 		.dir = IIO_EV_DIR_FALLING,
 		.mask_separate = BIT(IIO_EV_INFO_VALUE) | BIT(IIO_EV_INFO_ENABLE),
-	},
+	}, {
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_EITHER,
+		.mask_separate = BIT(IIO_EV_INFO_PERIOD),
+	}
 };
 
 static const struct iio_chan_spec vcnl4000_channels[] = {
@@ -1457,8 +1642,8 @@ static const struct iio_chan_spec vcnl4040_channels[] = {
 			BIT(IIO_CHAN_INFO_SCALE) |
 			BIT(IIO_CHAN_INFO_INT_TIME),
 		.info_mask_separate_available = BIT(IIO_CHAN_INFO_INT_TIME),
-		.event_spec = vcnl4000_event_spec,
-		.num_event_specs = ARRAY_SIZE(vcnl4000_event_spec),
+		.event_spec = vcnl4040_als_event_spec,
+		.num_event_specs = ARRAY_SIZE(vcnl4040_als_event_spec),
 	}, {
 		.type = IIO_PROXIMITY,
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
-- 
2.30.2

