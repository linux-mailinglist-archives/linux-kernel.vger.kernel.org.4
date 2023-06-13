Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 425EB72E4A2
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 15:51:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242537AbjFMNuu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 09:50:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242594AbjFMNuf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 09:50:35 -0400
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A89AD2;
        Tue, 13 Jun 2023 06:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1686664234;
  x=1718200234;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=y1ZK5fRvKQed3EHZU1Se0rdL7hF8b6kv6RD25LPaf2M=;
  b=B7j1gElqnp9N7/ABZqMqRn1nSpiyBrAlGbz9dhwcmaQNEAY8VX11veJF
   A9YcrUqSjlKz/6pbiKW885L5Ol4f+a8zLj0FsLV0XIgPjwOYROnreue1l
   rb2A22YUqCb5Z7OLx7xZrdvaJe5IHNv5tUsBdb496ITCuk6CazxkUt9pu
   AxKJg2RO4eAF4fyEz0Xix9AUW1zm85k1OOpDRL3LjqFywnXp3d7rm2f0n
   +QXZYcxAUUEyeHAUdMHr0I1GZWaYKSj6lvohj2B6pBMZv4R3Kwjob7Lh+
   05rcKBVTH58xQVDUyd6d7tWHmEJMRG5+eGCExZ0hFJiH+Tqjd88wdfVMq
   Q==;
From:   Astrid Rost <astrid.rost@axis.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
CC:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel@axis.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Mathieu Othacehe <m.othacehe@gmail.com>,
        Astrid Rost <astrid.rost@axis.com>
Subject: [PATCH v6 6/8] iio: light: vcnl4000: Add period for vcnl4040/4200
Date:   Tue, 13 Jun 2023 15:50:22 +0200
Message-ID: <20230613135025.2596641-7-astrid.rost@axis.com>
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

Add read/write attribute for proximity and illuminance period. The
period is set in the interrupt persistence flags(PS_PERS and ALS_PERS).
An interrupt will not be asserted if the raw value is not over (or lower)
than the threshold for the set continued amount of measurements.
The time in seconds is calculated by the number of continued refreshes
multiplied with the integration time.
It will always pick the next lower possible value. The period changes,
if the integration time is changed.

Signed-off-by: Astrid Rost <astrid.rost@axis.com>
---
 drivers/iio/light/vcnl4000.c | 161 ++++++++++++++++++++++++++++++++++-
 1 file changed, 159 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
index 0f4c39adc68a..435bf57eb4c8 100644
--- a/drivers/iio/light/vcnl4000.c
+++ b/drivers/iio/light/vcnl4000.c
@@ -24,6 +24,7 @@
 #include <linux/delay.h>
 #include <linux/pm_runtime.h>
 #include <linux/interrupt.h>
+#include <linux/units.h>
 
 #include <linux/iio/buffer.h>
 #include <linux/iio/events.h>
@@ -84,8 +85,10 @@
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
@@ -153,6 +156,9 @@ static const int vcnl4200_als_it_times[][2] = {
 	{0, 400000},
 };
 
+static const int vcnl4040_als_persistence[] = {1, 2, 4, 8};
+static const int vcnl4040_ps_persistence[] = {1, 2, 3, 4};
+
 #define VCNL4000_SLEEP_DELAY_MS	2000 /* before we enter pm_runtime_suspend */
 
 enum vcnl4000_device_ids {
@@ -641,6 +647,129 @@ static ssize_t vcnl4040_write_ps_it(struct vcnl4000_data *data, int val)
 	return ret;
 }
 
+static ssize_t vcnl4040_read_als_period(struct vcnl4000_data *data, int *val, int *val2)
+{
+	int ret, ret_pers, it;
+	int64_t val_c;
+
+	ret = i2c_smbus_read_word_data(data->client, VCNL4200_AL_CONF);
+	if (ret < 0)
+		return ret;
+
+	ret_pers = FIELD_GET(VCNL4040_ALS_CONF_PERS, ret);
+	if (ret_pers >= ARRAY_SIZE(vcnl4040_als_persistence))
+		return -EINVAL;
+
+	it = FIELD_GET(VCNL4040_ALS_CONF_IT, ret);
+	if (it >= data->chip_spec->num_als_it_times)
+		return -EINVAL;
+
+	val_c = mul_u32_u32((*data->chip_spec->als_it_times)[it][1],
+			    vcnl4040_als_persistence[ret_pers]);
+	*val = div_u64_rem(val_c, MICRO, val2);
+
+	return IIO_VAL_INT_PLUS_MICRO;
+}
+
+static ssize_t vcnl4040_write_als_period(struct vcnl4000_data *data, int val, int val2)
+{
+	unsigned int i;
+	int ret, it;
+	u16 regval;
+	u64 val_n = mul_u32_u32(val, MICRO) + val2;
+
+	ret = i2c_smbus_read_word_data(data->client, VCNL4200_AL_CONF);
+	if (ret < 0)
+		return ret;
+
+	it = FIELD_GET(VCNL4040_ALS_CONF_IT, ret);
+	if (it >= data->chip_spec->num_als_it_times)
+		return -EINVAL;
+
+	for (i = 0; i < ARRAY_SIZE(vcnl4040_als_persistence) - 1; i++) {
+		if (val_n < mul_u32_u32(vcnl4040_als_persistence[i],
+					(*data->chip_spec->als_it_times)[it][1]))
+			break;
+	}
+
+	mutex_lock(&data->vcnl4000_lock);
+
+	ret = i2c_smbus_read_word_data(data->client, VCNL4200_AL_CONF);
+	if (ret < 0)
+		goto out_unlock;
+
+	regval = FIELD_PREP(VCNL4040_ALS_CONF_PERS, i);
+	regval |= (ret & ~VCNL4040_ALS_CONF_PERS);
+	ret = i2c_smbus_write_word_data(data->client, VCNL4200_AL_CONF,
+					regval);
+
+out_unlock:
+	mutex_unlock(&data->vcnl4000_lock);
+	return ret;
+}
+
+static ssize_t vcnl4040_read_ps_period(struct vcnl4000_data *data, int *val, int *val2)
+{
+	int ret, ret_pers, it;
+
+	ret = i2c_smbus_read_word_data(data->client, VCNL4200_PS_CONF1);
+	if (ret < 0)
+		return ret;
+
+	ret_pers = FIELD_GET(VCNL4040_CONF1_PS_PERS, ret);
+	if (ret_pers >= ARRAY_SIZE(vcnl4040_ps_persistence))
+		return -EINVAL;
+
+	it = FIELD_GET(VCNL4040_PS_CONF2_PS_IT, ret);
+	if (it >= data->chip_spec->num_ps_it_times)
+		return -EINVAL;
+
+	*val = (*data->chip_spec->ps_it_times)[it][0];
+	*val2 = (*data->chip_spec->ps_it_times)[it][1] *
+		vcnl4040_ps_persistence[ret_pers];
+
+	return IIO_VAL_INT_PLUS_MICRO;
+}
+
+static ssize_t vcnl4040_write_ps_period(struct vcnl4000_data *data, int val, int val2)
+{
+	int ret, it, i;
+	u16 regval;
+
+	ret = i2c_smbus_read_word_data(data->client, VCNL4200_PS_CONF1);
+	if (ret < 0)
+		return ret;
+
+	it = FIELD_GET(VCNL4040_PS_CONF2_PS_IT, ret);
+	if (it >= data->chip_spec->num_ps_it_times)
+		return -EINVAL;
+
+	if (val > 0)
+		i = ARRAY_SIZE(vcnl4040_ps_persistence) - 1;
+	else {
+		for (i = 0; i < ARRAY_SIZE(vcnl4040_ps_persistence) - 1; i++) {
+			if (val2 <= vcnl4040_ps_persistence[i] *
+					(*data->chip_spec->ps_it_times)[it][1])
+				break;
+		}
+	}
+
+	mutex_lock(&data->vcnl4000_lock);
+
+	ret = i2c_smbus_read_word_data(data->client, VCNL4200_PS_CONF1);
+	if (ret < 0)
+		goto out_unlock;
+
+	regval = FIELD_PREP(VCNL4040_CONF1_PS_PERS, i);
+	regval |= (ret & ~VCNL4040_CONF1_PS_PERS);
+	ret = i2c_smbus_write_word_data(data->client, VCNL4200_PS_CONF1,
+					regval);
+
+out_unlock:
+	mutex_unlock(&data->vcnl4000_lock);
+	return ret;
+}
+
 static int vcnl4000_read_raw(struct iio_dev *indio_dev,
 				struct iio_chan_spec const *chan,
 				int *val, int *val2, long mask)
@@ -939,6 +1068,8 @@ static int vcnl4040_read_event(struct iio_dev *indio_dev,
 	switch (chan->type) {
 	case IIO_LIGHT:
 		switch (info) {
+		case IIO_EV_INFO_PERIOD:
+			return vcnl4040_read_als_period(data, val, val2);
 		case IIO_EV_INFO_VALUE:
 			switch (dir) {
 			case IIO_EV_DIR_RISING:
@@ -959,6 +1090,8 @@ static int vcnl4040_read_event(struct iio_dev *indio_dev,
 		break;
 	case IIO_PROXIMITY:
 		switch (info) {
+		case IIO_EV_INFO_PERIOD:
+			return vcnl4040_read_ps_period(data, val, val2);
 		case IIO_EV_INFO_VALUE:
 			switch (dir) {
 			case IIO_EV_DIR_RISING:
@@ -999,6 +1132,8 @@ static int vcnl4040_write_event(struct iio_dev *indio_dev,
 	switch (chan->type) {
 	case IIO_LIGHT:
 		switch (info) {
+		case IIO_EV_INFO_PERIOD:
+			return vcnl4040_write_als_period(data, val, val2);
 		case IIO_EV_INFO_VALUE:
 			switch (dir) {
 			case IIO_EV_DIR_RISING:
@@ -1021,6 +1156,8 @@ static int vcnl4040_write_event(struct iio_dev *indio_dev,
 		break;
 	case IIO_PROXIMITY:
 		switch (info) {
+		case IIO_EV_INFO_PERIOD:
+			return vcnl4040_write_ps_period(data, val, val2);
 		case IIO_EV_INFO_VALUE:
 			switch (dir) {
 			case IIO_EV_DIR_RISING:
@@ -1425,6 +1562,22 @@ static const struct iio_event_spec vcnl4000_event_spec[] = {
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
+		.mask_separate = BIT(IIO_EV_INFO_ENABLE) | BIT(IIO_EV_INFO_PERIOD),
+	},
+};
+
 static const struct iio_event_spec vcnl4040_event_spec[] = {
 	{
 		.type = IIO_EV_TYPE_THRESH,
@@ -1434,6 +1587,10 @@ static const struct iio_event_spec vcnl4040_event_spec[] = {
 		.type = IIO_EV_TYPE_THRESH,
 		.dir = IIO_EV_DIR_FALLING,
 		.mask_separate = BIT(IIO_EV_INFO_VALUE) | BIT(IIO_EV_INFO_ENABLE),
+	}, {
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_EITHER,
+		.mask_separate = BIT(IIO_EV_INFO_PERIOD),
 	},
 };
 
@@ -1481,8 +1638,8 @@ static const struct iio_chan_spec vcnl4040_channels[] = {
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

