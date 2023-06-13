Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D19872E493
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 15:51:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242620AbjFMNuo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 09:50:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242021AbjFMNud (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 09:50:33 -0400
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB31510DC;
        Tue, 13 Jun 2023 06:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1686664232;
  x=1718200232;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=A1yfNQfcbJmmOG+mu3rIMK0uri/rytmHhKhKs1H3mw0=;
  b=cRi97rYjj5zucpLIH9JHwNcD/acAMH8S19UguS7vf1+eG8sZFH2neSVI
   3yG+i/8gCd2tHflhf919i8CR50yXskgZW6RHraAIb6QRy9HmOvJlog9wM
   FgFx7OHRaecyvUty0xKsiKI9EESmZNgemRlNPKA1JwbtCduTyciPVAvoh
   /KrV1F70/xqFMu/oU+J7cSItII8hCICdmoeB62556mCanAYFvKhLeTECq
   F65ICZkJD+Gl1DVC5QGmSMfuHZGISXuEkhQ/5TTX13a5ORu+Q51TT8Wr5
   LP3fso73Wfka6p1q+5bZnzj2JE/1QCpnpoZ2kHSo0aPHrovwvW7oPZD9y
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
Subject: [PATCH v6 4/8] iio: light: vcnl4000: Add als_it for vcnl4040/4200
Date:   Tue, 13 Jun 2023 15:50:20 +0200
Message-ID: <20230613135025.2596641-5-astrid.rost@axis.com>
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

Add illuminance integration time for vcnl4040 and vcnl4200.
Add read/write attribute for illuminance integration time and read
attribute for available integration times.
Set scale and sampling rate according to the integration time.

Signed-off-by: Astrid Rost <astrid.rost@axis.com>
---
 drivers/iio/light/vcnl4000.c | 94 ++++++++++++++++++++++++++++++++++--
 1 file changed, 91 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
index b2dc9ca7325f..0a96e9451ec7 100644
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
@@ -178,6 +193,9 @@ struct vcnl4000_chip_spec {
 	u8 int_reg;
 	const int(*ps_it_times)[][2];
 	const int num_ps_it_times;
+	const int(*als_it_times)[][2];
+	const int num_als_it_times;
+	const unsigned int ulux_step;
 };
 
 static const struct i2c_device_id vcnl4000_id[] = {
@@ -331,16 +349,15 @@ static int vcnl4200_init(struct vcnl4000_data *data)
 		data->vcnl4200_al.sampling_rate = ktime_set(0, 60000 * 1000);
 		/* Default wait time is 4.8ms, add 20% tolerance. */
 		data->vcnl4200_ps.sampling_rate = ktime_set(0, 5760 * 1000);
-		data->al_scale = 24000;
 		break;
 	case VCNL4040_PROD_ID:
 		/* Default wait time is 80ms, add 20% tolerance. */
 		data->vcnl4200_al.sampling_rate = ktime_set(0, 96000 * 1000);
 		/* Default wait time is 5ms, add 20% tolerance. */
 		data->vcnl4200_ps.sampling_rate = ktime_set(0, 6000 * 1000);
-		data->al_scale = 120000;
 		break;
 	}
+	data->al_scale = data->chip_spec->ulux_step;
 	mutex_init(&data->vcnl4200_al.lock);
 	mutex_init(&data->vcnl4200_ps.lock);
 
@@ -510,6 +527,60 @@ static int vcnl4000_set_pm_runtime_state(struct vcnl4000_data *data, bool on)
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
+	int ret;
+	u16 regval;
+
+	for (i = 0; i < data->chip_spec->num_als_it_times; i++) {
+		if (val == (*data->chip_spec->als_it_times)[i][1])
+			break;
+	}
+
+	if (i == data->chip_spec->num_als_it_times)
+		return -EINVAL;
+
+	data->vcnl4200_al.sampling_rate = ktime_set(0, val * 1200);
+	data->al_scale = div_u64(mul_u32_u32(data->chip_spec->ulux_step,
+			 (*data->chip_spec->als_it_times)[0][1]),
+			 val);
+
+	mutex_lock(&data->vcnl4000_lock);
+
+	ret = i2c_smbus_read_word_data(data->client, VCNL4200_AL_CONF);
+	if (ret < 0)
+		goto out_unlock;
+
+	regval = FIELD_PREP(VCNL4040_ALS_CONF_IT, i);
+	regval |= (ret & ~VCNL4040_ALS_CONF_IT);
+	ret = i2c_smbus_write_word_data(data->client,
+					VCNL4200_AL_CONF,
+					regval);
+
+out_unlock:
+	mutex_unlock(&data->vcnl4000_lock);
+	return ret;
+}
+
 static int vcnl4040_read_ps_it(struct vcnl4000_data *data, int *val, int *val2)
 {
 	int ret;
@@ -601,6 +672,9 @@ static int vcnl4000_read_raw(struct iio_dev *indio_dev,
 		return IIO_VAL_INT_PLUS_MICRO;
 	case IIO_CHAN_INFO_INT_TIME:
 		switch (chan->type) {
+		case IIO_LIGHT:
+			ret = vcnl4040_read_als_it(data, val, val2);
+			break;
 		case IIO_PROXIMITY:
 			ret = vcnl4040_read_ps_it(data, val, val2);
 			break;
@@ -626,6 +700,8 @@ static int vcnl4040_write_raw(struct iio_dev *indio_dev,
 		if (val != 0)
 			return -EINVAL;
 		switch (chan->type) {
+		case IIO_LIGHT:
+			return vcnl4040_write_als_it(data, val2);
 		case IIO_PROXIMITY:
 			return vcnl4040_write_ps_it(data, val2);
 		default:
@@ -646,6 +722,10 @@ static int vcnl4040_read_avail(struct iio_dev *indio_dev,
 	switch (mask) {
 	case IIO_CHAN_INFO_INT_TIME:
 		switch (chan->type) {
+		case IIO_LIGHT:
+			*vals = (int *)(*data->chip_spec->als_it_times);
+			*length = 2 * data->chip_spec->num_als_it_times;
+			break;
 		case IIO_PROXIMITY:
 			*vals = (int *)(*data->chip_spec->ps_it_times);
 			*length = 2 * data->chip_spec->num_ps_it_times;
@@ -1310,7 +1390,9 @@ static const struct iio_chan_spec vcnl4040_channels[] = {
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
@@ -1383,6 +1465,9 @@ static const struct vcnl4000_chip_spec vcnl4000_chip_spec_cfg[] = {
 		.int_reg = VCNL4040_INT_FLAGS,
 		.ps_it_times = &vcnl4040_ps_it_times,
 		.num_ps_it_times = ARRAY_SIZE(vcnl4040_ps_it_times),
+		.als_it_times = &vcnl4040_als_it_times,
+		.num_als_it_times = ARRAY_SIZE(vcnl4040_als_it_times),
+		.ulux_step = 100000,
 	},
 	[VCNL4200] = {
 		.prod = "VCNL4200",
@@ -1397,6 +1482,9 @@ static const struct vcnl4000_chip_spec vcnl4000_chip_spec_cfg[] = {
 		.int_reg = VCNL4200_INT_FLAGS,
 		.ps_it_times = &vcnl4200_ps_it_times,
 		.num_ps_it_times = ARRAY_SIZE(vcnl4200_ps_it_times),
+		.als_it_times = &vcnl4200_als_it_times,
+		.num_als_it_times = ARRAY_SIZE(vcnl4200_als_it_times),
+		.ulux_step = 24000,
 	},
 };
 
-- 
2.30.2

