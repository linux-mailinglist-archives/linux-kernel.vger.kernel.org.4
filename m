Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F06F6FC86D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 16:03:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234758AbjEIOCR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 10:02:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235487AbjEIOCJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 10:02:09 -0400
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AB113C0D;
        Tue,  9 May 2023 07:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1683640919;
  x=1715176919;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0E7nCGFCJhjejEN5cK/dsj5gIRVtXVr2HbY1HbweKH8=;
  b=mv8psX0bcGtNIWCQ174PCq9W6sjA/w1LMlt9Ycgr35jkg6E+3vjQ3TY4
   glGb0rWVIbztNeyYNqNH1Mo+S/YK7tMdIIDU0FUiiA/lsWxeH1SfFyuXE
   DyrT8wLmk1w7AtsFnZdorerScrgEc28tb6Us+GbVOD870fGYO9CeiBZMu
   0JetZq+HIjifA0NsPiDd3NxOe8roixHNhEE3AbLOnMfsKObmJvsZ61Plt
   ga1p6vmwGesWOQEHpbF6CNkqxkFU/+M2jInoKAPfFsUAZAYqK/p37tdla
   doaQIQEFsS9jmaOdh30/d6gbJuuqaFfEvkP100ymKrhto5OM2kgz2Ho5R
   A==;
From:   Astrid Rost <astrid.rost@axis.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
CC:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel@axis.com>, Astrid Rost <astrid.rost@axis.com>
Subject: [PATCH v2 3/7] iio: light: vcnl4000: Add als_it for vcnl4040/4200
Date:   Tue, 9 May 2023 16:01:49 +0200
Message-ID: <20230509140153.3279288-4-astrid.rost@axis.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230509140153.3279288-1-astrid.rost@axis.com>
References: <20230509140153.3279288-1-astrid.rost@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="No"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add illumination integration time for vcnl4040 and vcnl4200.
Add read/write attribute for illumination integration time and read
attribute for available integration times.

Signed-off-by: Astrid Rost <astrid.rost@axis.com>
---
 drivers/iio/light/vcnl4000.c | 147 ++++++++++++++++++++++++++++++++---
 1 file changed, 135 insertions(+), 12 deletions(-)

diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
index e14475070ac3..d7445b6755fa 100644
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
@@ -334,7 +349,7 @@ static int vcnl4200_init(struct vcnl4000_data *data)
 		data->vcnl4200_al.sampling_rate = ktime_set(0, 96000 * 1000);
 		/* Default wait time is 5ms, add 20% tolerance. */
 		data->vcnl4200_ps.sampling_rate = ktime_set(0, 6000 * 1000);
-		data->al_scale = 120000;
+		data->al_scale = 100000;
 		break;
 	}
 	mutex_init(&data->vcnl4200_al.lock);
@@ -506,6 +521,85 @@ static int vcnl4000_set_pm_runtime_state(struct vcnl4000_data *data, bool on)
 	return ret;
 }
 
+static int vcnl4040_read_als_it(struct vcnl4000_data *data, int *val, int *val2)
+{
+	int ret;
+	const int(*als_it_times)[][2];
+	int size;
+
+	if (data->id == VCNL4200) {
+		als_it_times = &vcnl4200_als_it_times;
+		size = ARRAY_SIZE(vcnl4200_als_it_times);
+	} else {
+		als_it_times = &vcnl4040_als_it_times;
+		size = ARRAY_SIZE(vcnl4040_als_it_times);
+	}
+
+	ret = i2c_smbus_read_word_data(data->client, VCNL4200_AL_CONF);
+	if (ret < 0)
+		return ret;
+
+	ret = FIELD_GET(VCNL4040_ALS_CONF_IT, ret);
+
+	if (ret >= size)
+		return -EINVAL;
+
+	*val = (*als_it_times)[ret][0];
+	*val2 = (*als_it_times)[ret][1];
+
+	return 0;
+}
+
+static ssize_t vcnl4040_write_als_it(struct vcnl4000_data *data, int val)
+{
+	unsigned int i;
+	int ret, index = -1;
+	u16 regval;
+	const int(*als_it_times)[][2];
+	int size;
+
+	if (data->id == VCNL4200) {
+		als_it_times = &vcnl4200_als_it_times;
+		size = ARRAY_SIZE(vcnl4200_als_it_times);
+	} else {
+		als_it_times = &vcnl4040_als_it_times;
+		size = ARRAY_SIZE(vcnl4040_als_it_times);
+	}
+
+	for (i = 0; i < size; i++) {
+		if (val == (*als_it_times)[i][1]) {
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
@@ -616,9 +710,16 @@ static int vcnl4000_read_raw(struct iio_dev *indio_dev,
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
@@ -637,9 +738,14 @@ static int vcnl4040_write_raw(struct iio_dev *indio_dev,
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
@@ -654,12 +760,27 @@ static int vcnl4040_read_avail(struct iio_dev *indio_dev,
 
 	switch (mask) {
 	case IIO_CHAN_INFO_INT_TIME:
-		if (data->id == VCNL4200) {
-			*vals = (int *)vcnl4200_ps_it_times;
-			*length = 2 * ARRAY_SIZE(vcnl4200_ps_it_times);
-		} else {
-			*vals = (int *)vcnl4040_ps_it_times;
-			*length = 2 * ARRAY_SIZE(vcnl4040_ps_it_times);
+		switch (chan->type) {
+		case IIO_LIGHT:
+			if (data->id == VCNL4200) {
+				*vals = (int *)vcnl4200_als_it_times;
+				*length = 2 * ARRAY_SIZE(vcnl4200_als_it_times);
+			} else {
+				*vals = (int *)vcnl4040_als_it_times;
+				*length = 2 * ARRAY_SIZE(vcnl4040_als_it_times);
+			}
+			break;
+		case IIO_PROXIMITY:
+			if (data->id == VCNL4200) {
+				*vals = (int *)vcnl4200_ps_it_times;
+				*length = 2 * ARRAY_SIZE(vcnl4200_ps_it_times);
+			} else {
+				*vals = (int *)vcnl4040_ps_it_times;
+				*length = 2 * ARRAY_SIZE(vcnl4040_ps_it_times);
+			}
+			break;
+		default:
+			return -EINVAL;
 		}
 		*type = IIO_VAL_INT_PLUS_MICRO;
 		return IIO_AVAIL_LIST;
@@ -1289,7 +1410,9 @@ static const struct iio_chan_spec vcnl4040_channels[] = {
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
-- 
2.30.2

