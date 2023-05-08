Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8FAA6FA0B1
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 09:11:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233344AbjEHHKp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 03:10:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233155AbjEHHKM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 03:10:12 -0400
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 743E41A134;
        Mon,  8 May 2023 00:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1683529800;
  x=1715065800;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=W/xWbKcRNiw8Sn6/6Bh66R38/GASDSgCB4EIlMrvDZ0=;
  b=hTOSQTeQRv+QbPxMBHWJN/vMcrKjgAcxuLFW1tfDxciDgqFpYveCaY62
   WMY33Q2EvaLJfijdp8v3EVQivhqtkWERER4CBxZm13BcwQAAVcGhh0kxH
   qgFw4fv6adGrOfDwsElTSu6EuIRGdS7CElhEyMEFKdf/nNwF9GrIXB4B/
   dBP+YTWK6xhavw+7uRrXlNsZqbwN5NeVajRsvW+MVjJV7pKht76dnH1XN
   rUCOZB6S2M7kNACFbVxzrKIwVZwDMLp5JvmOLfNFyupfKieEmlW9Wl+4x
   DhO35gj6EZn3SI1LEz+57+sNBJZ5LFAgnlOtIEiStsswuZEoAkjOD07ZN
   w==;
From:   Astrid Rost <astrid.rost@axis.com>
To:     Jonathan Cameron <jic23@kernel.org>
CC:     <kernel@axis.com>, Astrid Rost <astridr@axis.com>,
        Astrid Rost <astrid.rost@axis.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 7/7] iio: light: vcnl4000: Add calibration bias for 4040/4200
Date:   Mon, 8 May 2023 09:09:25 +0200
Message-ID: <20230508070925.2123265-8-astrid.rost@axis.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230508070925.2123265-1-astrid.rost@axis.com>
References: <20230508070925.2123265-1-astrid.rost@axis.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The calibration bias is setting the LED current to change
the detection distance.
Add read/write attribute for proximity calibration bias and read
attribute for available values.
This is supported for vcnl4040 and vcnl4200.

Signed-off-by: Astrid Rost <astrid.rost@axis.com>
---
 drivers/iio/light/vcnl4000.c | 97 ++++++++++++++++++++++++++++++++++--
 1 file changed, 94 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
index ab70c6fd5520..cd5eae692dbf 100644
--- a/drivers/iio/light/vcnl4000.c
+++ b/drivers/iio/light/vcnl4000.c
@@ -91,6 +91,7 @@
 #define VCNL4040_CONF1_PS_PERS	GENMASK(5, 4) /* Proximity interrupt persistence setting */
 #define VCNL4040_PS_CONF2_PS_INT	GENMASK(9, 8) /* Proximity interrupt mode */
 #define VCNL4040_PS_CONF3_MPS		GENMASK(6, 5) /* Proximity multi pulse number */
+#define VCNL4040_PS_MS_LED_I		GENMASK(10, 8) /* Proximity current */
 #define VCNL4040_PS_IF_AWAY		BIT(8) /* Proximity event cross low threshold */
 #define VCNL4040_PS_IF_CLOSE		BIT(9) /* Proximity event cross high threshold */
 #define VCNL4040_ALS_RISING		BIT(12) /* Ambient Light cross high threshold */
@@ -157,6 +158,17 @@ static const int vcnl4200_als_it_times[][2] = {
 	{0, 400000},
 };
 
+static const int vcnl4040_ps_calibbias_ua[][2] = {
+	{0, 50000},
+	{0, 75000},
+	{0, 100000},
+	{0, 120000},
+	{0, 140000},
+	{0, 160000},
+	{0, 180000},
+	{0, 200000},
+};
+
 static const int vcnl4040_als_debounce_count[] = {1, 2, 4, 8};
 static const int vcnl4040_ps_debounce_count[] = {1, 2, 3, 4};
 static const int vcnl4040_ps_oversampling_ratio[] = {1, 2, 4, 8};
@@ -833,6 +845,57 @@ static ssize_t vcnl4040_write_ps_oversampling_ratio(struct vcnl4000_data *data,
 	return ret;
 }
 
+static ssize_t vcnl4040_read_ps_calibbias(struct vcnl4000_data *data, int *val, int *val2)
+{
+	int ret;
+
+	ret = i2c_smbus_read_word_data(data->client, VCNL4200_PS_CONF3);
+	if (ret < 0)
+		return ret;
+
+	ret = FIELD_GET(VCNL4040_PS_MS_LED_I, ret);
+
+	if (ret >= ARRAY_SIZE(vcnl4040_ps_calibbias_ua))
+		return -EINVAL;
+
+	*val = vcnl4040_ps_calibbias_ua[ret][0];
+	*val2 = vcnl4040_ps_calibbias_ua[ret][1];
+
+	return ret;
+}
+
+static ssize_t vcnl4040_write_ps_calibbias(struct vcnl4000_data *data, int val)
+{
+	unsigned int i;
+	int ret, index = -1;
+	u16 regval;
+
+	for (i = 0; i < ARRAY_SIZE(vcnl4040_ps_calibbias_ua); i++) {
+		if (val == vcnl4040_ps_calibbias_ua[i][1]) {
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
+	regval = (ret & ~VCNL4040_PS_MS_LED_I) |
+	    FIELD_PREP(VCNL4040_PS_MS_LED_I, index);
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
@@ -907,7 +970,16 @@ static int vcnl4000_read_raw(struct iio_dev *indio_dev,
 		default:
 			return -EINVAL;
 		}
-
+	case IIO_CHAN_INFO_CALIBBIAS:
+		switch (chan->type) {
+		case IIO_PROXIMITY:
+			ret = vcnl4040_read_ps_calibbias(data, val, val2);
+			if (ret < 0)
+				return ret;
+			return IIO_VAL_INT_PLUS_MICRO;
+		default:
+			return -EINVAL;
+		}
 	default:
 		return -EINVAL;
 	}
@@ -947,6 +1019,13 @@ static int vcnl4040_write_raw(struct iio_dev *indio_dev,
 		default:
 			return -EINVAL;
 		}
+	case IIO_CHAN_INFO_CALIBBIAS:
+		switch (chan->type) {
+		case IIO_PROXIMITY:
+			return vcnl4040_write_ps_calibbias(data, val2);
+		default:
+			return -EINVAL;
+		}
 	default:
 		return -EINVAL;
 	}
@@ -1010,6 +1089,16 @@ static int vcnl4040_read_avail(struct iio_dev *indio_dev,
 		default:
 			return -EINVAL;
 		}
+	case IIO_CHAN_INFO_CALIBBIAS:
+		switch (chan->type) {
+		case IIO_PROXIMITY:
+			*vals = (int *)vcnl4040_ps_calibbias_ua;
+			*length = 2 * ARRAY_SIZE(vcnl4040_ps_calibbias_ua);
+			*type = IIO_VAL_INT_PLUS_MICRO;
+			return IIO_AVAIL_LIST;
+		default:
+			return -EINVAL;
+	}
 	default:
 		return -EINVAL;
 	}
@@ -1734,10 +1823,12 @@ static const struct iio_chan_spec vcnl4040_channels[] = {
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
 			BIT(IIO_CHAN_INFO_INT_TIME) |
 			BIT(IIO_CHAN_INFO_DEBOUNCE_COUNT) |
-			BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
+			BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO) |
+			BIT(IIO_CHAN_INFO_CALIBBIAS),
 		.info_mask_separate_available = BIT(IIO_CHAN_INFO_INT_TIME) |
 			BIT(IIO_CHAN_INFO_DEBOUNCE_COUNT) |
-			BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
+			BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO) |
+			BIT(IIO_CHAN_INFO_CALIBBIAS),
 		.ext_info = vcnl4000_ext_info,
 		.event_spec = vcnl4040_event_spec,
 		.num_event_specs = ARRAY_SIZE(vcnl4040_event_spec),
-- 
2.30.2

