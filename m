Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2612D6FC86F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 16:03:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235765AbjEIOCa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 10:02:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235703AbjEIOCS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 10:02:18 -0400
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B21CE3C2F;
        Tue,  9 May 2023 07:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1683640930;
  x=1715176930;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nEWUnzqUancZEDgCdUHbJi7L256SDtVllaAQFWxuOJY=;
  b=VReudFy5yk/LNooiy0EPq6oNPuwFZciUA3d0QF6pPKQRWJtk3tnd2mhD
   1ykbJrCdLqEC+nftBfTKHKaDKh5jvh1Ta9fL92RMQ0fvmTpx51HWtxvAN
   hsiHpWVEqpCu7/JhARenXXOFnpaSe2irQ1Bf4OvEHTa+U19+iA8PjQonK
   mK5C591q8MEUp14bQ/+zgkwBjmeJAdPQOwTotGFzQPxcfBoNA9J4HXvnS
   VJwncQAL/3umsMBdcomH4Rr9n0klMitlFhztROjL5HBCnPA1+rJ8Btvy2
   rk2wNJeeCANJDKHZ6ygdSThraPyRmnYNK6163stbU3gA8gj1ZVDNOmN5b
   Q==;
From:   Astrid Rost <astrid.rost@axis.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
CC:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel@axis.com>, Astrid Rost <astrid.rost@axis.com>
Subject: [PATCH v2 6/7] iio: light: vcnl4000: Add oversampling_ratio for 4040/4200
Date:   Tue, 9 May 2023 16:01:52 +0200
Message-ID: <20230509140153.3279288-7-astrid.rost@axis.com>
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

Add the proximity multi pulse (PS_MPS) as oversampling_ratio.
One raw value is calculated out of the set amount of pulses.
Add read/write attribute for proximity oversampling-ratio and read
attribute for available oversampling-ratio.
This is supported for vcnl4040 and vcnl4200.

Signed-off-by: Astrid Rost <astrid.rost@axis.com>
---
 drivers/iio/light/vcnl4000.c | 86 +++++++++++++++++++++++++++++++++++-
 1 file changed, 84 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
index b8ce4ed6b0bb..1fd1eaaa4620 100644
--- a/drivers/iio/light/vcnl4000.c
+++ b/drivers/iio/light/vcnl4000.c
@@ -60,6 +60,7 @@
 
 #define VCNL4200_AL_CONF	0x00 /* Ambient light configuration */
 #define VCNL4200_PS_CONF1	0x03 /* Proximity configuration */
+#define VCNL4200_PS_CONF3	0x04 /* Proximity configuration */
 #define VCNL4040_PS_THDL_LM	0x06 /* Proximity threshold low */
 #define VCNL4040_PS_THDH_LM	0x07 /* Proximity threshold high */
 #define VCNL4040_ALS_THDL_LM	0x02 /* Ambient light threshold low */
@@ -89,6 +90,7 @@
 #define VCNL4040_PS_CONF2_PS_IT	GENMASK(3, 1) /* Proximity integration time */
 #define VCNL4040_CONF1_PS_PERS	GENMASK(5, 4) /* Proximity interrupt persistence setting */
 #define VCNL4040_PS_CONF2_PS_INT	GENMASK(9, 8) /* Proximity interrupt mode */
+#define VCNL4040_PS_CONF3_MPS		GENMASK(6, 5) /* Proximity multi pulse number */
 #define VCNL4040_PS_IF_AWAY		BIT(8) /* Proximity event cross low threshold */
 #define VCNL4040_PS_IF_CLOSE		BIT(9) /* Proximity event cross high threshold */
 #define VCNL4040_ALS_RISING		BIT(12) /* Ambient Light cross high threshold */
@@ -157,6 +159,7 @@ static const int vcnl4200_als_it_times[][2] = {
 
 static const int vcnl4040_als_debounce_count[] = {1, 2, 4, 8};
 static const int vcnl4040_ps_debounce_count[] = {1, 2, 3, 4};
+static const int vcnl4040_ps_oversampling_ratio[] = {1, 2, 4, 8};
 
 #define VCNL4000_SLEEP_DELAY_MS	2000 /* before we enter pm_runtime_suspend */
 
@@ -785,6 +788,56 @@ static ssize_t vcnl4040_write_ps_debounce_count(struct vcnl4000_data *data, int
 	return ret;
 }
 
+static ssize_t vcnl4040_read_ps_oversampling_ratio(struct vcnl4000_data *data, int *val)
+{
+	int ret;
+
+	ret = i2c_smbus_read_word_data(data->client, VCNL4200_PS_CONF3);
+	if (ret < 0)
+		return ret;
+
+	ret = FIELD_GET(VCNL4040_PS_CONF3_MPS, ret);
+
+	if (ret >= ARRAY_SIZE(vcnl4040_ps_oversampling_ratio))
+		return -EINVAL;
+
+	*val = vcnl4040_ps_oversampling_ratio[ret];
+
+	return ret;
+}
+
+static ssize_t vcnl4040_write_ps_oversampling_ratio(struct vcnl4000_data *data, int val)
+{
+	unsigned int i;
+	int ret, index = -1;
+	u16 regval;
+
+	for (i = 0; i < ARRAY_SIZE(vcnl4040_ps_oversampling_ratio); i++) {
+		if (val == vcnl4040_ps_oversampling_ratio[i]) {
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
+	ret = i2c_smbus_read_word_data(data->client, VCNL4200_PS_CONF3);
+	if (ret < 0)
+		goto out;
+
+	regval = (ret & ~VCNL4040_PS_CONF3_MPS) |
+	    FIELD_PREP(VCNL4040_PS_CONF3_MPS, index);
+	ret = i2c_smbus_write_word_data(data->client, VCNL4200_PS_CONF3,
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
@@ -849,6 +902,16 @@ static int vcnl4000_read_raw(struct iio_dev *indio_dev,
 		if (ret < 0)
 			return ret;
 		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
+		switch (chan->type) {
+		case IIO_PROXIMITY:
+			ret = vcnl4040_read_ps_oversampling_ratio(data, val);
+			if (ret < 0)
+				return ret;
+			return IIO_VAL_INT;
+		default:
+			return -EINVAL;
+		}
 
 	default:
 		return -EINVAL;
@@ -882,6 +945,13 @@ static int vcnl4040_write_raw(struct iio_dev *indio_dev,
 		default:
 			return -EINVAL;
 		}
+	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
+		switch (chan->type) {
+		case IIO_PROXIMITY:
+			return vcnl4040_write_ps_oversampling_ratio(data, val);
+		default:
+			return -EINVAL;
+		}
 	default:
 		return -EINVAL;
 	}
@@ -935,6 +1005,16 @@ static int vcnl4040_read_avail(struct iio_dev *indio_dev,
 		}
 		*type = IIO_VAL_INT;
 		return IIO_AVAIL_LIST;
+	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
+		switch (chan->type) {
+		case IIO_PROXIMITY:
+			*vals = (int *)vcnl4040_ps_oversampling_ratio;
+			*length = ARRAY_SIZE(vcnl4040_ps_oversampling_ratio);
+			*type = IIO_VAL_INT;
+			return IIO_AVAIL_LIST;
+		default:
+			return -EINVAL;
+		}
 	default:
 		return -EINVAL;
 	}
@@ -1658,9 +1738,11 @@ static const struct iio_chan_spec vcnl4040_channels[] = {
 		.type = IIO_PROXIMITY,
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
 			BIT(IIO_CHAN_INFO_INT_TIME) |
-			BIT(IIO_CHAN_INFO_DEBOUNCE_COUNT),
+			BIT(IIO_CHAN_INFO_DEBOUNCE_COUNT) |
+			BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
 		.info_mask_separate_available = BIT(IIO_CHAN_INFO_INT_TIME) |
-			BIT(IIO_CHAN_INFO_DEBOUNCE_COUNT),
+			BIT(IIO_CHAN_INFO_DEBOUNCE_COUNT) |
+			BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
 		.ext_info = vcnl4000_ext_info,
 		.event_spec = vcnl4040_event_spec,
 		.num_event_specs = ARRAY_SIZE(vcnl4040_event_spec),
-- 
2.30.2

