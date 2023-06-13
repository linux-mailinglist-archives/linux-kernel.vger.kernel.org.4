Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86D8372E491
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 15:51:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242648AbjFMNu5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 09:50:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242598AbjFMNuh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 09:50:37 -0400
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BAD11B2;
        Tue, 13 Jun 2023 06:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1686664235;
  x=1718200235;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dR8MLCiL1MOfulFcpamRyyKR1UDqEV8kQFowQtsQaNM=;
  b=Lyx9+K/pN4qVGMEooTbKWlW9W6xHEAOsVXTxwLorei94JUnMRmBKirCj
   EbVkFQeCSlc8HPRFVjOaBqVyXhP0kopZPCIr0zP6hGJTHyr1ZxiUl9JRw
   KY3uTK6Yfus9wgrpBUGpxR9M623eRNxWo9Igi8El8LxrXsHYh4f9JM3I2
   LFaABkGR1rXoJaua+H+FLr5/29OmWC6fSc7n3vZbMhQL1lqRhZHBZUqwF
   jbJoix25A6zKDyNQuBN1cC2U7YvMx2AVn4sDXdjuZCPlRZadaT1bfpry3
   S49S2CVl9n6g6bx+dOlpS9IpjpTIv/TEJCTV61AnvsSxoQiWX5YVtQ9tX
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
Subject: [PATCH v6 3/8] iio: light: vcnl4000: Check type with switch case
Date:   Tue, 13 Jun 2023 15:50:19 +0200
Message-ID: <20230613135025.2596641-4-astrid.rost@axis.com>
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

Check IIO_PROXIMITY  with switch case in order to make it easier
to add further types like light.
Add check for IIO_EV_INFO_VALUE for writing rising or falling events.

Signed-off-by: Astrid Rost <astrid.rost@axis.com>
---
 drivers/iio/light/vcnl4000.c | 152 +++++++++++++++++++++++------------
 1 file changed, 100 insertions(+), 52 deletions(-)

diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
index 6059d9548158..b2dc9ca7325f 100644
--- a/drivers/iio/light/vcnl4000.c
+++ b/drivers/iio/light/vcnl4000.c
@@ -600,9 +600,13 @@ static int vcnl4000_read_raw(struct iio_dev *indio_dev,
 		*val2 = data->al_scale;
 		return IIO_VAL_INT_PLUS_MICRO;
 	case IIO_CHAN_INFO_INT_TIME:
-		if (chan->type != IIO_PROXIMITY)
+		switch (chan->type) {
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
@@ -621,9 +625,12 @@ static int vcnl4040_write_raw(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_INT_TIME:
 		if (val != 0)
 			return -EINVAL;
-		if (chan->type != IIO_PROXIMITY)
+		switch (chan->type) {
+		case IIO_PROXIMITY:
+			return vcnl4040_write_ps_it(data, val2);
+		default:
 			return -EINVAL;
-		return vcnl4040_write_ps_it(data, val2);
+		}
 	default:
 		return -EINVAL;
 	}
@@ -638,9 +645,15 @@ static int vcnl4040_read_avail(struct iio_dev *indio_dev,
 
 	switch (mask) {
 	case IIO_CHAN_INFO_INT_TIME:
-		*vals = (int *)(*data->chip_spec->ps_it_times);
+		switch (chan->type) {
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
@@ -836,24 +849,34 @@ static int vcnl4040_read_event(struct iio_dev *indio_dev,
 	int ret;
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
+	case IIO_PROXIMITY:
+		switch (info) {
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
@@ -866,22 +889,35 @@ static int vcnl4040_write_event(struct iio_dev *indio_dev,
 	int ret;
 	struct vcnl4000_data *data = iio_priv(indio_dev);
 
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
+	case IIO_PROXIMITY:
+		switch (info) {
+		case IIO_EV_INFO_VALUE:
+			switch (dir) {
+			case IIO_EV_DIR_RISING:
+				ret = i2c_smbus_write_word_data(data->client,
+								VCNL4040_PS_THDH_LM,
+								val);
+				break;
+			case IIO_EV_DIR_FALLING:
+				ret = i2c_smbus_write_word_data(data->client,
+								VCNL4040_PS_THDL_LM,
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
 	default:
 		return -EINVAL;
 	}
+	if (ret < 0)
+		return ret;
+	return IIO_VAL_INT;
 }
 
 static bool vcnl4010_is_thr_enabled(struct vcnl4000_data *data)
@@ -974,15 +1010,20 @@ static int vcnl4040_read_event_config(struct iio_dev *indio_dev,
 	int ret;
 	struct vcnl4000_data *data = iio_priv(indio_dev);
 
-	ret = i2c_smbus_read_word_data(data->client, VCNL4200_PS_CONF1);
-	if (ret < 0)
-		return ret;
+	switch (chan->type) {
+	case IIO_PROXIMITY:
+		ret = i2c_smbus_read_word_data(data->client, VCNL4200_PS_CONF1);
+		if (ret < 0)
+			return ret;
 
-	data->ps_int = FIELD_GET(VCNL4040_PS_CONF2_PS_INT, ret);
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
@@ -990,25 +1031,32 @@ static int vcnl4040_write_event_config(struct iio_dev *indio_dev,
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
+	case IIO_PROXIMITY:
+		ret = i2c_smbus_read_word_data(data->client, VCNL4200_PS_CONF1);
+		if (ret < 0)
+			goto out;
 
-	if (dir == IIO_EV_DIR_RISING)
-		mask = VCNL4040_PS_IF_AWAY;
-	else
-		mask = VCNL4040_PS_IF_CLOSE;
+		if (dir == IIO_EV_DIR_RISING)
+			mask = VCNL4040_PS_IF_AWAY;
+		else
+			mask = VCNL4040_PS_IF_CLOSE;
 
-	val = state ? (ret | mask) : (ret & ~mask);
+		val = state ? (ret | mask) : (ret & ~mask);
 
-	data->ps_int = FIELD_GET(VCNL4040_PS_CONF2_PS_INT, val);
-	ret = i2c_smbus_write_word_data(data->client, VCNL4200_PS_CONF1, val);
+		data->ps_int = FIELD_GET(VCNL4040_PS_CONF2_PS_INT, val);
+		ret = i2c_smbus_write_word_data(data->client, VCNL4200_PS_CONF1,
+						val);
+		break;
+	default:
+		break;
+	}
 
 out:
 	mutex_unlock(&data->vcnl4000_lock);
-- 
2.30.2

