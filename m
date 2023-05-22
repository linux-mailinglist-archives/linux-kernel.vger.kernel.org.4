Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C974270C107
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 16:26:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233522AbjEVO0j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 10:26:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231695AbjEVO0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 10:26:32 -0400
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BB75A3;
        Mon, 22 May 2023 07:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1684765590;
  x=1716301590;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WSfkxVBv8f37msGKdmNCBmbjoy/DrcehpWEs6TZDZOI=;
  b=l3zAXsoFJX1cYU7PggwWJ+dp/KwrabHt1AwPm6oPagXBaNgpBR/mZG6u
   Hpf+I0Bpbv0isJB7hC7Cb63U7a2Vr76jflWGzj0pNqHNNg/+dDrMkHATo
   KNcF5of2/kwGlvW70BWXWxQqaxp0jnSVqbDkJOdtJqRqBqywOb+G4Mj3a
   +BRPnhCCeHRJlSG3D4z88jmai55lWgX1qbvRPi2uXFO6n/Nm0//Ud/e/J
   5u3W1U9tdU8v2WGLsT3TsJ78GCmogrYINJziwLj68kuHDuD+ZdmGXPAQp
   8h0fa7n1dKDYEneSRHGMXafmJeCKL3kBrP72cnsfZM6wRJQ9dsUAimJle
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
Subject: [PATCH v4 3/7] iio: light: vcnl4000: Add als_it for vcnl4040/4200
Date:   Mon, 22 May 2023 16:26:17 +0200
Message-ID: <20230522142621.1680563-4-astrid.rost@axis.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230522142621.1680563-1-astrid.rost@axis.com>
References: <20230522142621.1680563-1-astrid.rost@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add illuminance integration time for vcnl4040 and vcnl4200.
Add read/write attribute for illuminance integration time and read
attribute for available integration times.
Set scale and sampling rate according to the integration time.

Signed-off-by: Astrid Rost <astrid.rost@axis.com>
---
 drivers/iio/light/vcnl4000.c | 121 ++++++++++++++++++++++++++++++++---
 1 file changed, 113 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
index 086a493fb6e5..285f1dd314d8 100644
--- a/drivers/iio/light/vcnl4000.c
+++ b/drivers/iio/light/vcnl4000.c
@@ -80,6 +80,7 @@
 #define VCNL4000_SELF_TIMED_EN	BIT(0) /* start self-timed measurement */
 
 #define VCNL4040_ALS_CONF_ALS_SHUTDOWN	BIT(0)
+#define VCNL4040_ALS_CONF_IT		GENMASK(7, 6) /* Ambient integration time */
 #define VCNL4040_PS_CONF1_PS_SHUTDOWN	BIT(0)
 #define VCNL4040_PS_CONF2_PS_IT	GENMASK(3, 1) /* Proximity integration time */
 #define VCNL4040_PS_CONF2_PS_INT	GENMASK(9, 8) /* Proximity interrupt mode */
@@ -133,6 +134,20 @@ static const int vcnl4200_ps_it_times[][2] = {
 	{0, 864},
 };
 
+static const int vcnl4040_als_it_times[][2] = {
+	{0, 80000},
+	{0, 160000},
+	{0, 320000},
+	{0, 640000},
+};
+
+static const int vcnl4200_als_it_times[][2] = {
+	{0, 50000},
+	{0, 100000},
+	{0, 200000},
+	{0, 400000},
+};
+
 #define VCNL4000_SLEEP_DELAY_MS	2000 /* before we enter pm_runtime_suspend */
 
 enum vcnl4000_device_ids {
@@ -177,6 +192,8 @@ struct vcnl4000_chip_spec {
 	u8 int_reg;
 	const int(*ps_it_times)[][2];
 	const int num_ps_it_times;
+	const int(*als_it_times)[][2];
+	const int num_als_it_times;
 };
 
 static const struct i2c_device_id vcnl4000_id[] = {
@@ -337,7 +354,7 @@ static int vcnl4200_init(struct vcnl4000_data *data)
 		data->vcnl4200_al.sampling_rate = ktime_set(0, 96000 * 1000);
 		/* Default wait time is 5ms, add 20% tolerance. */
 		data->vcnl4200_ps.sampling_rate = ktime_set(0, 6000 * 1000);
-		data->al_scale = 120000;
+		data->al_scale = 100000;
 		break;
 	}
 	mutex_init(&data->vcnl4200_al.lock);
@@ -509,6 +526,65 @@ static int vcnl4000_set_pm_runtime_state(struct vcnl4000_data *data, bool on)
 	return ret;
 }
 
+static int vcnl4040_read_als_it(struct vcnl4000_data *data, int *val, int *val2)
+{
+	int ret;
+
+	ret = i2c_smbus_read_word_data(data->client, VCNL4200_AL_CONF);
+	if (ret < 0)
+		return ret;
+
+	ret = FIELD_GET(VCNL4040_ALS_CONF_IT, ret);
+
+	if (ret >= data->chip_spec->num_als_it_times)
+		return -EINVAL;
+
+	*val = (*data->chip_spec->als_it_times)[ret][0];
+	*val2 = (*data->chip_spec->als_it_times)[ret][1];
+
+	return 0;
+}
+
+static ssize_t vcnl4040_write_als_it(struct vcnl4000_data *data, int val)
+{
+	unsigned int i;
+	int ret, index = -1;
+	u16 regval;
+
+	for (i = 0; i < data->chip_spec->num_als_it_times; i++) {
+		if (val == (*data->chip_spec->als_it_times)[i][1]) {
+			index = i;
+			break;
+		}
+	}
+
+	if (index < 0)
+		return -EINVAL;
+
+	data->vcnl4200_al.sampling_rate = ktime_set(0, val * 1200000);
+	if (data->id == VCNL4200)
+		/* 24000 µlux/step * 50000 µs / val  */
+		data->al_scale = div_u64(1200000000, val);
+	else
+		/* 100000 µlux/step * 80000 µs / val */
+		data->al_scale = div_u64(8000000000, val);
+
+	mutex_lock(&data->vcnl4000_lock);
+
+	ret = i2c_smbus_read_word_data(data->client, VCNL4200_AL_CONF);
+	if (ret < 0)
+		goto out;
+
+	regval = (ret & ~VCNL4040_ALS_CONF_IT) |
+	    FIELD_PREP(VCNL4040_ALS_CONF_IT, index);
+	ret = i2c_smbus_write_word_data(data->client, VCNL4200_AL_CONF,
+					regval);
+
+out:
+	mutex_unlock(&data->vcnl4000_lock);
+	return ret;
+}
+
 static int vcnl4040_read_ps_it(struct vcnl4000_data *data, int *val, int *val2)
 {
 	int ret;
@@ -599,9 +675,16 @@ static int vcnl4000_read_raw(struct iio_dev *indio_dev,
 		*val2 = data->al_scale;
 		return IIO_VAL_INT_PLUS_MICRO;
 	case IIO_CHAN_INFO_INT_TIME:
-		if (chan->type != IIO_PROXIMITY)
+		switch (chan->type) {
+		case IIO_LIGHT:
+			ret = vcnl4040_read_als_it(data, val, val2);
+			break;
+		case IIO_PROXIMITY:
+			ret = vcnl4040_read_ps_it(data, val, val2);
+			break;
+		default:
 			return -EINVAL;
-		ret = vcnl4040_read_ps_it(data, val, val2);
+		}
 		if (ret < 0)
 			return ret;
 		return IIO_VAL_INT_PLUS_MICRO;
@@ -620,9 +703,14 @@ static int vcnl4040_write_raw(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_INT_TIME:
 		if (val != 0)
 			return -EINVAL;
-		if (chan->type != IIO_PROXIMITY)
+		switch (chan->type) {
+		case IIO_LIGHT:
+			return vcnl4040_write_als_it(data, val2);
+		case IIO_PROXIMITY:
+			return vcnl4040_write_ps_it(data, val2);
+		default:
 			return -EINVAL;
-		return vcnl4040_write_ps_it(data, val2);
+		}
 	default:
 		return -EINVAL;
 	}
@@ -637,9 +725,20 @@ static int vcnl4040_read_avail(struct iio_dev *indio_dev,
 
 	switch (mask) {
 	case IIO_CHAN_INFO_INT_TIME:
-		*vals = (int *)(*data->chip_spec->ps_it_times);
+
+		switch (chan->type) {
+		case IIO_LIGHT:
+			*vals = (int *)(*data->chip_spec->als_it_times);
+			*length = 2 * data->chip_spec->num_als_it_times;
+			break;
+		case IIO_PROXIMITY:
+			*vals = (int *)(*data->chip_spec->ps_it_times);
+			*length = 2 * data->chip_spec->num_ps_it_times;
+			break;
+		default:
+			return -EINVAL;
+		}
 		*type = IIO_VAL_INT_PLUS_MICRO;
-		*length = 2 * data->chip_spec->num_ps_it_times;
 		return IIO_AVAIL_LIST;
 	default:
 		return -EINVAL;
@@ -1261,7 +1360,9 @@ static const struct iio_chan_spec vcnl4040_channels[] = {
 	{
 		.type = IIO_LIGHT,
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
-			BIT(IIO_CHAN_INFO_SCALE),
+			BIT(IIO_CHAN_INFO_SCALE) |
+			BIT(IIO_CHAN_INFO_INT_TIME),
+		.info_mask_separate_available = BIT(IIO_CHAN_INFO_INT_TIME),
 	}, {
 		.type = IIO_PROXIMITY,
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
@@ -1334,6 +1435,8 @@ static const struct vcnl4000_chip_spec vcnl4000_chip_spec_cfg[] = {
 		.int_reg = VCNL4040_INT_FLAGS,
 		.ps_it_times = &vcnl4040_ps_it_times,
 		.num_ps_it_times = ARRAY_SIZE(vcnl4040_ps_it_times),
+		.als_it_times = &vcnl4040_als_it_times,
+		.num_als_it_times = ARRAY_SIZE(vcnl4040_als_it_times),
 	},
 	[VCNL4200] = {
 		.prod = "VCNL4200",
@@ -1348,6 +1451,8 @@ static const struct vcnl4000_chip_spec vcnl4000_chip_spec_cfg[] = {
 		.int_reg = VCNL4200_INT_FLAGS,
 		.ps_it_times = &vcnl4200_ps_it_times,
 		.num_ps_it_times = ARRAY_SIZE(vcnl4200_ps_it_times),
+		.als_it_times = &vcnl4200_als_it_times,
+		.num_als_it_times = ARRAY_SIZE(vcnl4200_als_it_times),
 	},
 };
 
-- 
2.30.2

