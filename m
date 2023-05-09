Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A3506FC875
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 16:03:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235770AbjEIOCd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 10:02:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235719AbjEIOCT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 10:02:19 -0400
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 066A6359D;
        Tue,  9 May 2023 07:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1683640932;
  x=1715176932;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QuK79GFmYf4uj+jtkzxxrSS2hQm5roAwqGNt6wwbEl0=;
  b=PocDJragBqIn/j2KtFUZHrqhqa89oJ9H5rFwVZKndjEZxeeNUjZpWlYe
   LPII0oY3hP3a+lRmiCfZb/JMpBBCtcBEXW9CBInjXPtEX6YPk0kR20wAw
   bLYaW77ebyRzZKXyNqw0MeY89bknHYZtuBt14knlZYaKcPxxAwzrbnQel
   1B2eeXQKInI22BEpUSVVvWGU8u5UWS/vIrxuLRn7Ao4P3JIoGu++/SUHm
   XJGXf/4h1lkH7OoIpGLDxGA4MsG4PoQI45A9A/JcreYakko8Gda+L61ZM
   ATdp6XdLU0LY9RHd7YnVZtMovpNpkBTA7bkMUBK9eHobDPrwUtMusjeZb
   A==;
From:   Astrid Rost <astrid.rost@axis.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
CC:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel@axis.com>, Astrid Rost <astrid.rost@axis.com>
Subject: [PATCH v2 5/7] iio: light: vcnl4000: Add debounce count for vcnl4040/4200
Date:   Tue, 9 May 2023 16:01:51 +0200
Message-ID: <20230509140153.3279288-6-astrid.rost@axis.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230509140153.3279288-1-astrid.rost@axis.com>
References: <20230509140153.3279288-1-astrid.rost@axis.com>
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

Add read/write attribute for proximity and illumination debounce-count
and read attribute for available debounce-counts.
The debounce-count is set in the interrupt persistence flags
(PS_PERS and ALS_PERS). An interrupt will not be asserted if the raw
value is not over (or lower) than the threshold for the set
continued refresh times.
This is supported for vcnl4040 vcnl4200.

Signed-off-by: Astrid Rost <astrid.rost@axis.com>
---
 drivers/iio/light/vcnl4000.c | 156 ++++++++++++++++++++++++++++++++++-
 1 file changed, 152 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
index 68eea686b2dc..b8ce4ed6b0bb 100644
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
@@ -153,6 +155,9 @@ static const int vcnl4200_als_it_times[][2] = {
 	{0, 400000},
 };
 
+static const int vcnl4040_als_debounce_count[] = {1, 2, 4, 8};
+static const int vcnl4040_ps_debounce_count[] = {1, 2, 3, 4};
+
 #define VCNL4000_SLEEP_DELAY_MS	2000 /* before we enter pm_runtime_suspend */
 
 enum vcnl4000_device_ids {
@@ -680,6 +685,106 @@ static ssize_t vcnl4040_write_ps_it(struct vcnl4000_data *data, int val)
 	return ret;
 }
 
+static ssize_t vcnl4040_read_als_debounce_count(struct vcnl4000_data *data, int *val)
+{
+	int ret;
+
+	ret = i2c_smbus_read_word_data(data->client, VCNL4200_AL_CONF);
+	if (ret < 0)
+		return ret;
+
+	ret = FIELD_GET(VCNL4040_ALS_CONF_PERS, ret);
+
+	if (ret >= ARRAY_SIZE(vcnl4200_als_it_times))
+		return -EINVAL;
+
+	*val = vcnl4040_als_debounce_count[ret];
+
+	return ret;
+}
+
+static ssize_t vcnl4040_write_als_debounce_count(struct vcnl4000_data *data, int val)
+{
+	unsigned int i;
+	int ret, index = -1;
+	u16 regval;
+
+	for (i = 0; i < ARRAY_SIZE(vcnl4040_als_debounce_count); i++) {
+		if (val == vcnl4040_als_debounce_count[i]) {
+			index = i;
+			break;
+		}
+	}
+
+	if (index < 0)
+		return -EINVAL;
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
+static ssize_t vcnl4040_read_ps_debounce_count(struct vcnl4000_data *data, int *val)
+{
+	int ret;
+
+	ret = i2c_smbus_read_word_data(data->client, VCNL4200_PS_CONF1);
+	if (ret < 0)
+		return ret;
+
+	ret = FIELD_GET(VCNL4040_CONF1_PS_PERS, ret);
+
+	if (ret >= ARRAY_SIZE(vcnl4200_ps_it_times))
+		return -EINVAL;
+
+	*val = vcnl4040_ps_debounce_count[ret];
+
+	return ret;
+}
+
+static ssize_t vcnl4040_write_ps_debounce_count(struct vcnl4000_data *data, int val)
+{
+	unsigned int i;
+	int ret, index = -1;
+	u16 regval;
+
+	for (i = 0; i < ARRAY_SIZE(vcnl4040_ps_debounce_count); i++) {
+		if (val == vcnl4040_ps_debounce_count[i]) {
+			index = i;
+			break;
+		}
+	}
+
+	if (index < 0)
+		return -EINVAL;
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
 static int vcnl4000_read_raw(struct iio_dev *indio_dev,
 				struct iio_chan_spec const *chan,
 				int *val, int *val2, long mask)
@@ -730,6 +835,21 @@ static int vcnl4000_read_raw(struct iio_dev *indio_dev,
 		if (ret < 0)
 			return ret;
 		return IIO_VAL_INT_PLUS_MICRO;
+	case IIO_CHAN_INFO_DEBOUNCE_COUNT:
+		switch (chan->type) {
+		case IIO_LIGHT:
+			ret = vcnl4040_read_als_debounce_count(data, val);
+			break;
+		case IIO_PROXIMITY:
+			ret = vcnl4040_read_ps_debounce_count(data, val);
+			break;
+		default:
+			return -EINVAL;
+		}
+		if (ret < 0)
+			return ret;
+		return IIO_VAL_INT;
+
 	default:
 		return -EINVAL;
 	}
@@ -753,6 +873,15 @@ static int vcnl4040_write_raw(struct iio_dev *indio_dev,
 		default:
 			return -EINVAL;
 		}
+	case IIO_CHAN_INFO_DEBOUNCE_COUNT:
+		switch (chan->type) {
+		case IIO_LIGHT:
+			return vcnl4040_write_als_debounce_count(data, val);
+		case IIO_PROXIMITY:
+			return vcnl4040_write_ps_debounce_count(data, val);
+		default:
+			return -EINVAL;
+		}
 	default:
 		return -EINVAL;
 	}
@@ -791,6 +920,21 @@ static int vcnl4040_read_avail(struct iio_dev *indio_dev,
 		}
 		*type = IIO_VAL_INT_PLUS_MICRO;
 		return IIO_AVAIL_LIST;
+	case IIO_CHAN_INFO_DEBOUNCE_COUNT:
+		switch (chan->type) {
+		case IIO_LIGHT:
+			*vals = (int *)vcnl4040_als_debounce_count;
+			*length = ARRAY_SIZE(vcnl4040_als_debounce_count);
+			break;
+		case IIO_PROXIMITY:
+			*vals = (int *)vcnl4040_ps_debounce_count;
+			*length = ARRAY_SIZE(vcnl4040_ps_debounce_count);
+			break;
+		default:
+			return -EINVAL;
+		}
+		*type = IIO_VAL_INT;
+		return IIO_AVAIL_LIST;
 	default:
 		return -EINVAL;
 	}
@@ -1504,15 +1648,19 @@ static const struct iio_chan_spec vcnl4040_channels[] = {
 		.type = IIO_LIGHT,
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
 			BIT(IIO_CHAN_INFO_SCALE) |
-			BIT(IIO_CHAN_INFO_INT_TIME),
-		.info_mask_separate_available = BIT(IIO_CHAN_INFO_INT_TIME),
+			BIT(IIO_CHAN_INFO_INT_TIME) |
+			BIT(IIO_CHAN_INFO_DEBOUNCE_COUNT),
+		.info_mask_separate_available = BIT(IIO_CHAN_INFO_INT_TIME) |
+			BIT(IIO_CHAN_INFO_DEBOUNCE_COUNT),
 		.event_spec = vcnl4000_event_spec,
 		.num_event_specs = ARRAY_SIZE(vcnl4000_event_spec),
 	}, {
 		.type = IIO_PROXIMITY,
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
-			BIT(IIO_CHAN_INFO_INT_TIME),
-		.info_mask_separate_available = BIT(IIO_CHAN_INFO_INT_TIME),
+			BIT(IIO_CHAN_INFO_INT_TIME) |
+			BIT(IIO_CHAN_INFO_DEBOUNCE_COUNT),
+		.info_mask_separate_available = BIT(IIO_CHAN_INFO_INT_TIME) |
+			BIT(IIO_CHAN_INFO_DEBOUNCE_COUNT),
 		.ext_info = vcnl4000_ext_info,
 		.event_spec = vcnl4040_event_spec,
 		.num_event_specs = ARRAY_SIZE(vcnl4040_event_spec),
-- 
2.30.2

