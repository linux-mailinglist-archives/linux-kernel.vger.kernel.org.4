Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF5F06C0617
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 23:39:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbjCSWjy convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 19 Mar 2023 18:39:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbjCSWjm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 18:39:42 -0400
Received: from ste-pvt-msa1.bahnhof.se (ste-pvt-msa1.bahnhof.se [213.80.101.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06E181B553;
        Sun, 19 Mar 2023 15:39:38 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTP id 0F3A63F6C8;
        Sun, 19 Mar 2023 23:39:37 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Score: -1.9
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_FAIL,SPF_HELO_NONE autolearn=no autolearn_force=no version=3.4.6
Received: from ste-pvt-msa1.bahnhof.se ([127.0.0.1])
        by localhost (ste-pvt-msa1.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 2of0CKLjTdBz; Sun, 19 Mar 2023 23:39:35 +0100 (CET)
Received: by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTPA id 9AA8A3F312;
        Sun, 19 Mar 2023 23:39:35 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.dalakolonin.se (Postfix) with ESMTP id EFE9A8EBD9;
        Sun, 19 Mar 2023 22:39:28 +0000 (UTC)
Received: from zimbra.dalakolonin.se ([127.0.0.1])
        by localhost (zimbra.dalakolonin.se [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id PkoJ02eyUkIm; Sun, 19 Mar 2023 22:39:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.dalakolonin.se (Postfix) with ESMTP id 532BB8EBC7;
        Sun, 19 Mar 2023 22:39:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at dalakolonin.se
Received: from zimbra.dalakolonin.se ([127.0.0.1])
        by localhost (zimbra.dalakolonin.se [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 7hh3nitNxso3; Sun, 19 Mar 2023 22:39:20 +0000 (UTC)
Received: from rack-server-1.dalakolonin.se (unknown [172.17.0.1])
        by zimbra.dalakolonin.se (Postfix) with ESMTPSA id 5F6EA8EBB5;
        Sun, 19 Mar 2023 22:39:20 +0000 (UTC)
From:   =?UTF-8?q?Patrik=20Dahlstr=C3=B6m?= <risca@dalakolonin.se>
To:     linux-iio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org,
        kernel@pyra-handheld.com, pgoudagunta@nvidia.com,
        hns@goldelico.com, jic23@kernel.org, lars@metafoo.de,
        =?UTF-8?q?Patrik=20Dahlstr=C3=B6m?= <risca@dalakolonin.se>
Subject: [PATCH 1/3] iio: adc: palmas_gpadc: add support for iio threshold events
Date:   Sun, 19 Mar 2023 23:39:06 +0100
Message-Id: <20230319223908.108540-2-risca@dalakolonin.se>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230319223908.108540-1-risca@dalakolonin.se>
References: <20230319223908.108540-1-risca@dalakolonin.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The palmas gpadc block has support for monitoring up to 2 ADC channels
and issue an interrupt if they reach past a set threshold. The gpadc
driver had limited support for this through the adc_wakeup{1,2}_data
platform data. This however only allow a fixed threshold to be set at
boot, and would only enable it when entering sleep mode.

This change hooks into the IIO events system and exposes to userspace
the ability to configure threshold values for each channel individually,
but only allow up to 2 such thresholds to be enabled at any given time.

The logic around suspend and resume had to be adjusted so that user
space configuration don't get reset on resume. Instead, any configured
adc auto wakeup gets enabled during probe.

Enabling a threshold from userspace will overwrite the adc wakeup
configuration set during probe. Depending on how you look at it, this
could also mean we allow userspace to update the adc wakeup thresholds.

Signed-off-by: Patrik Dahlström <risca@dalakolonin.se>
---
 drivers/iio/adc/palmas_gpadc.c | 495 +++++++++++++++++++++++++++++----
 1 file changed, 438 insertions(+), 57 deletions(-)

diff --git a/drivers/iio/adc/palmas_gpadc.c b/drivers/iio/adc/palmas_gpadc.c
index 24d7c096e4b8..84c6e3b66205 100644
--- a/drivers/iio/adc/palmas_gpadc.c
+++ b/drivers/iio/adc/palmas_gpadc.c
@@ -20,6 +20,7 @@
 #include <linux/completion.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
+#include <linux/iio/events.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/machine.h>
 #include <linux/iio/driver.h>
@@ -76,6 +77,16 @@ static struct palmas_gpadc_info palmas_gpadc_info[] = {
 	PALMAS_ADC_INFO(IN15, 0, 0, 0, 0, INVALID, INVALID, true),
 };
 
+struct palmas_gpadc_thresholds {
+	int high_thresh;
+	int low_thresh;
+};
+
+struct palmas_adc_event {
+	int channel;
+	enum iio_event_direction direction;
+};
+
 /*
  * struct palmas_gpadc - the palmas_gpadc structure
  * @ch0_current:	channel 0 current source setting
@@ -117,8 +128,30 @@ struct palmas_gpadc {
 	bool				wakeup2_enable;
 	int				auto_conversion_period;
 	struct mutex			lock;
+	struct palmas_adc_event		event0;
+	struct palmas_adc_event		event1;
+	struct palmas_gpadc_thresholds	thresh_data[PALMAS_ADC_CH_MAX];
 };
 
+static struct palmas_adc_event *palmas_gpadc_get_event_channel(
+	struct palmas_gpadc *adc, int adc_chan, enum iio_event_direction dir)
+{
+	if (adc_chan == adc->event0.channel && dir == adc->event0.direction)
+		return &adc->event0;
+
+	if (adc_chan == adc->event1.channel && dir == adc->event1.direction)
+		return &adc->event1;
+
+	return NULL;
+}
+
+static bool palmas_gpadc_channel_is_freerunning(struct palmas_gpadc *adc,
+						int adc_chan)
+{
+	return palmas_gpadc_get_event_channel(adc, adc_chan, IIO_EV_DIR_RISING) ||
+		palmas_gpadc_get_event_channel(adc, adc_chan, IIO_EV_DIR_FALLING);
+}
+
 /*
  * GPADC lock issue in AUTO mode.
  * Impact: In AUTO mode, GPADC conversion can be locked after disabling AUTO
@@ -188,11 +221,24 @@ static irqreturn_t palmas_gpadc_irq(int irq, void *data)
 
 static irqreturn_t palmas_gpadc_irq_auto(int irq, void *data)
 {
-	struct palmas_gpadc *adc = data;
+	struct iio_dev *indio_dev = data;
+	struct palmas_gpadc *adc = iio_priv(indio_dev);
+	struct palmas_adc_event *ev;
 
 	dev_dbg(adc->dev, "Threshold interrupt %d occurs\n", irq);
 	palmas_disable_auto_conversion(adc);
 
+	ev = (irq == adc->irq_auto_0) ? &adc->event0 : &adc->event1;
+	if (ev->channel != -1) {
+		enum iio_event_direction dir;
+		u64 code;
+
+		dir = ev->direction;
+		code = IIO_UNMOD_EVENT_CODE(IIO_VOLTAGE, ev->channel,
+					    IIO_EV_TYPE_THRESH, dir);
+		iio_push_event(indio_dev, code, iio_get_time_ns(indio_dev));
+	}
+
 	return IRQ_HANDLED;
 }
 
@@ -280,6 +326,9 @@ static int palmas_gpadc_read_prepare(struct palmas_gpadc *adc, int adc_chan)
 {
 	int ret;
 
+	if (palmas_gpadc_channel_is_freerunning(adc, adc_chan))
+		return 0; // ADC already running
+
 	ret = palmas_gpadc_enable(adc, adc_chan, true);
 	if (ret < 0)
 		return ret;
@@ -339,28 +388,44 @@ static int palmas_gpadc_start_conversion(struct palmas_gpadc *adc, int adc_chan)
 	unsigned int val;
 	int ret;
 
-	init_completion(&adc->conv_completion);
-	ret = palmas_update_bits(adc->palmas, PALMAS_GPADC_BASE,
-				PALMAS_GPADC_SW_SELECT,
-				PALMAS_GPADC_SW_SELECT_SW_START_CONV0,
-				PALMAS_GPADC_SW_SELECT_SW_START_CONV0);
-	if (ret < 0) {
-		dev_err(adc->dev, "SELECT_SW_START write failed: %d\n", ret);
-		return ret;
-	}
+	if (palmas_gpadc_channel_is_freerunning(adc, adc_chan)) {
+		int event = (adc_chan == adc->event0.channel) ? 0 : 1;
+		unsigned int reg = (event == 0) ?
+			PALMAS_GPADC_AUTO_CONV0_LSB :
+			PALMAS_GPADC_AUTO_CONV1_LSB;
 
-	ret = wait_for_completion_timeout(&adc->conv_completion,
-				PALMAS_ADC_CONVERSION_TIMEOUT);
-	if (ret == 0) {
-		dev_err(adc->dev, "conversion not completed\n");
-		return -ETIMEDOUT;
+		ret = palmas_bulk_read(adc->palmas, PALMAS_GPADC_BASE,
+					reg, &val, 2);
+		if (ret < 0) {
+			dev_err(adc->dev, "AUTO_CONV%x_LSB read failed: %d\n",
+				event, ret);
+			return ret;
+		}
 	}
+	else {
+		init_completion(&adc->conv_completion);
+		ret = palmas_update_bits(adc->palmas, PALMAS_GPADC_BASE,
+					PALMAS_GPADC_SW_SELECT,
+					PALMAS_GPADC_SW_SELECT_SW_START_CONV0,
+					PALMAS_GPADC_SW_SELECT_SW_START_CONV0);
+		if (ret < 0) {
+			dev_err(adc->dev, "SELECT_SW_START write failed: %d\n", ret);
+			return ret;
+		}
 
-	ret = palmas_bulk_read(adc->palmas, PALMAS_GPADC_BASE,
-				PALMAS_GPADC_SW_CONV0_LSB, &val, 2);
-	if (ret < 0) {
-		dev_err(adc->dev, "SW_CONV0_LSB read failed: %d\n", ret);
-		return ret;
+		ret = wait_for_completion_timeout(&adc->conv_completion,
+					PALMAS_ADC_CONVERSION_TIMEOUT);
+		if (ret == 0) {
+			dev_err(adc->dev, "conversion not completed\n");
+			return -ETIMEDOUT;
+		}
+
+		ret = palmas_bulk_read(adc->palmas, PALMAS_GPADC_BASE,
+					PALMAS_GPADC_SW_CONV0_LSB, &val, 2);
+		if (ret < 0) {
+			dev_err(adc->dev, "SW_CONV0_LSB read failed: %d\n", ret);
+			return ret;
+		}
 	}
 
 	ret = val & 0xFFF;
@@ -385,6 +450,80 @@ static int palmas_gpadc_get_calibrated_code(struct palmas_gpadc *adc,
 	return val;
 }
 
+static int palmas_gpadc_get_high_threshold_raw(struct palmas_gpadc *adc,
+					       struct palmas_adc_event *ev)
+{
+	const int INL = 2;
+	const int adc_chan = ev->channel;
+	const int orig = adc->thresh_data[adc_chan].high_thresh;
+	int val = orig;
+	int gain_drift;
+	int offset_drift;
+
+	if (!val)
+		return 0;
+
+	val = (val * 1000) / adc->adc_info[adc_chan].gain;
+
+	if (!adc->adc_info[adc_chan].is_uncalibrated) {
+		val = (val * adc->adc_info[adc_chan].gain_error +
+		       adc->adc_info[adc_chan].offset) /
+			1000;
+		gain_drift = 1002;
+		offset_drift = 2;
+	}
+	else {
+		gain_drift = 1022;
+		offset_drift = 36;
+	}
+
+	// add tolerance to threshold
+	val = ((val + INL) * gain_drift) / 1000 + offset_drift;
+
+	// clamp to max possible value
+	if (val > 0xFFF)
+		val = 0xFFF;
+
+	return val;
+}
+
+static int palmas_gpadc_get_low_threshold_raw(struct palmas_gpadc *adc,
+					      struct palmas_adc_event *ev)
+{
+	const int INL = 2;
+	const int adc_chan = ev->channel;
+	const int orig = adc->thresh_data[adc_chan].low_thresh;
+	int val = orig;
+	int gain_drift;
+	int offset_drift;
+
+	if (!val)
+		return val;
+
+	val = (val * 1000) / adc->adc_info[adc_chan].gain;
+
+        if (!adc->adc_info[adc_chan].is_uncalibrated) {
+            val = (val * adc->adc_info[adc_chan].gain_error -
+		   adc->adc_info[adc_chan].offset) /
+		    1000;
+            gain_drift = 998;
+            offset_drift = 2;
+        }
+        else {
+            gain_drift = 978;
+            offset_drift = 36;
+        }
+
+	// calculate tolerances
+	val = ((val - INL) * gain_drift) / 1000 - offset_drift;
+
+	// clamp to minimum 0
+	if (val < 0)
+		val = 0;
+
+	return val;
+}
+
 static int palmas_gpadc_read_raw(struct iio_dev *indio_dev,
 	struct iio_chan_spec const *chan, int *val, int *val2, long mask)
 {
@@ -431,8 +570,239 @@ static int palmas_gpadc_read_raw(struct iio_dev *indio_dev,
 	return ret;
 }
 
+static int palmas_gpadc_read_event_config(struct iio_dev *indio_dev,
+	const struct iio_chan_spec *chan, enum iio_event_type type,
+	enum iio_event_direction dir)
+{
+	struct palmas_gpadc *adc = iio_priv(indio_dev);
+	int adc_chan = chan->channel;
+	int ret = 0;
+
+	if (adc_chan > PALMAS_ADC_CH_MAX || type != IIO_EV_TYPE_THRESH)
+		return -EINVAL;
+
+	mutex_lock(&adc->lock);
+
+	if (palmas_gpadc_get_event_channel(adc, adc_chan, dir)) {
+		ret = 1;
+	}
+
+	mutex_unlock(&adc->lock);
+
+	return ret;
+}
+
+static void palmas_adc_event_to_wakeup(struct palmas_gpadc *adc,
+				       struct palmas_adc_event *ev,
+				       struct palmas_adc_wakeup_property *wakeup)
+{
+	wakeup->adc_channel_number = ev->channel;
+	if (ev->direction == IIO_EV_DIR_RISING) {
+		wakeup->adc_low_threshold = 0;
+		wakeup->adc_high_threshold =
+			palmas_gpadc_get_high_threshold_raw(adc, &adc->event0);
+	}
+	else {
+		wakeup->adc_low_threshold =
+			palmas_gpadc_get_low_threshold_raw(adc, &adc->event0);
+		wakeup->adc_high_threshold = 0;
+	}
+}
+
+static int palmas_adc_wakeup_configure(struct palmas_gpadc *adc);
+static int palmas_adc_wakeup_reset(struct palmas_gpadc *adc);
+
+static int palmas_gpadc_reconfigure_event_channels(struct palmas_gpadc *adc)
+{
+	bool was_enabled = adc->wakeup1_enable || adc->wakeup2_enable;
+	bool enable;
+
+	adc->wakeup1_enable = adc->event0.channel == -1 ? false : true;
+	adc->wakeup2_enable = adc->event1.channel == -1 ? false : true;
+
+	enable = adc->wakeup1_enable || adc->wakeup2_enable;
+	if (!was_enabled && enable)
+		device_wakeup_enable(adc->dev);
+	else if (was_enabled && !enable)
+		device_wakeup_disable(adc->dev);
+
+	if (!enable)
+		return palmas_adc_wakeup_reset(adc);
+
+	// adjust levels
+	if (adc->wakeup1_enable)
+		palmas_adc_event_to_wakeup(adc, &adc->event0, &adc->wakeup1_data);
+	if (adc->wakeup2_enable)
+		palmas_adc_event_to_wakeup(adc, &adc->event1, &adc->wakeup2_data);
+
+	return palmas_adc_wakeup_configure(adc);
+}
+
+static int palmas_gpadc_enable_event_config(struct palmas_gpadc *adc,
+	const struct iio_chan_spec *chan, enum iio_event_direction dir)
+{
+	struct palmas_adc_event *ev;
+	int adc_chan = chan->channel;
+
+	if (palmas_gpadc_get_event_channel(adc, adc_chan, dir))
+		/* already enabled */
+		return 0;
+
+	if (adc->event0.channel == -1)
+		ev = &adc->event0;
+	else if (adc->event1.channel == -1) {
+		/* event0 has to be the lowest channel */
+		if (adc_chan < adc->event0.channel) {
+			adc->event1 = adc->event0;
+			ev = &adc->event0;
+		}
+		else
+			ev = &adc->event1;
+	}
+	else /* both AUTO channels already in use */ {
+		dev_warn(adc->dev, "event0 - %d, event1 - %d\n",
+			 adc->event0.channel, adc->event1.channel);
+		return -EBUSY;
+	}
+
+	ev->channel = adc_chan;
+	ev->direction = dir;
+
+	return palmas_gpadc_reconfigure_event_channels(adc);
+}
+
+static int palmas_gpadc_disable_event_config(struct palmas_gpadc *adc,
+	const struct iio_chan_spec *chan, enum iio_event_direction dir)
+{
+	int adc_chan = chan->channel;
+	struct palmas_adc_event *ev =
+		palmas_gpadc_get_event_channel(adc, adc_chan, dir);
+
+	if (!ev)
+		return 0;
+
+	if (ev == &adc->event0) {
+		adc->event0 = adc->event1;
+		ev = &adc->event1;
+	}
+
+	ev->channel = -1;
+	ev->direction = IIO_EV_DIR_NONE;
+
+	return palmas_gpadc_reconfigure_event_channels(adc);
+}
+
+static int palmas_gpadc_write_event_config(struct iio_dev *indio_dev,
+	const struct iio_chan_spec *chan, enum iio_event_type type,
+	enum iio_event_direction dir, int state)
+{
+	struct palmas_gpadc *adc = iio_priv(indio_dev);
+	int adc_chan = chan->channel;
+	int ret = 0;
+
+	if (adc_chan > PALMAS_ADC_CH_MAX || type != IIO_EV_TYPE_THRESH)
+		return -EINVAL;
+
+	mutex_lock(&adc->lock);
+
+	if (state)
+		ret = palmas_gpadc_enable_event_config(adc, chan, dir);
+	else
+		ret = palmas_gpadc_disable_event_config(adc, chan, dir);
+
+	mutex_unlock(&adc->lock);
+
+	return ret;
+}
+
+static int palmas_gpadc_read_event_value(struct iio_dev *indio_dev,
+	const struct iio_chan_spec *chan, enum iio_event_type type,
+	enum iio_event_direction dir, enum iio_event_info info, int *val,
+	int *val2)
+{
+	struct palmas_gpadc *adc = iio_priv(indio_dev);
+	int adc_chan = chan->channel;
+	int ret = 0;
+
+	if (adc_chan > PALMAS_ADC_CH_MAX || type != IIO_EV_TYPE_THRESH)
+		return -EINVAL;
+
+	mutex_lock(&adc->lock);
+
+	switch (info) {
+	case IIO_EV_INFO_VALUE:
+		*val = (dir == IIO_EV_DIR_RISING) ?
+			adc->thresh_data[adc_chan].high_thresh :
+			adc->thresh_data[adc_chan].low_thresh;
+		ret = IIO_VAL_INT;
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+	mutex_unlock(&adc->lock);
+
+	return ret;
+}
+
+static int palmas_gpadc_write_event_value(struct iio_dev *indio_dev,
+	const struct iio_chan_spec *chan, enum iio_event_type type,
+	enum iio_event_direction dir, enum iio_event_info info, int val,
+	int val2)
+{
+	struct palmas_gpadc *adc = iio_priv(indio_dev);
+	int adc_chan = chan->channel;
+	int ret = 0;
+
+	if (adc_chan > PALMAS_ADC_CH_MAX || type != IIO_EV_TYPE_THRESH)
+		return -EINVAL;
+
+	mutex_lock(&adc->lock);
+	switch (info) {
+	case IIO_EV_INFO_VALUE:
+		if (val < 0 || val > 0xFFF) {
+			ret = -EINVAL;
+			break;
+		}
+		if (dir == IIO_EV_DIR_RISING)
+			adc->thresh_data[adc_chan].high_thresh = val;
+		else
+			adc->thresh_data[adc_chan].low_thresh = val;
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+	if (palmas_gpadc_get_event_channel(adc, adc_chan, dir))
+		ret = palmas_gpadc_reconfigure_event_channels(adc);
+
+	mutex_unlock(&adc->lock);
+
+	return ret;
+}
+
 static const struct iio_info palmas_gpadc_iio_info = {
 	.read_raw = palmas_gpadc_read_raw,
+	.read_event_config = palmas_gpadc_read_event_config,
+	.write_event_config = palmas_gpadc_write_event_config,
+	.read_event_value = palmas_gpadc_read_event_value,
+	.write_event_value = palmas_gpadc_write_event_value,
+};
+
+static const struct iio_event_spec palmas_gpadc_events[] = {
+	{
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_RISING,
+		.mask_separate = BIT(IIO_EV_INFO_VALUE) |
+				BIT(IIO_EV_INFO_ENABLE),
+	}, {
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_FALLING,
+		.mask_separate = BIT(IIO_EV_INFO_VALUE) |
+				BIT(IIO_EV_INFO_ENABLE),
+	},
 };
 
 #define PALMAS_ADC_CHAN_IIO(chan, _type, chan_info)	\
@@ -443,6 +813,8 @@ static const struct iio_info palmas_gpadc_iio_info = {
 			BIT(chan_info),			\
 	.indexed = 1,					\
 	.channel = PALMAS_ADC_CH_##chan,		\
+	.event_spec = palmas_gpadc_events,		\
+	.num_event_specs = ARRAY_SIZE(palmas_gpadc_events)	\
 }
 
 static const struct iio_chan_spec palmas_gpadc_iio_channel[] = {
@@ -492,9 +864,12 @@ static int palmas_gpadc_get_adc_dt_data(struct platform_device *pdev,
 	return 0;
 }
 
-static void palmas_disable_wakeup(void *dev)
+static void palmas_disable_wakeup(void *data)
 {
-	device_wakeup_disable(dev);
+	struct palmas_gpadc *adc = data;
+
+	if (adc->wakeup1_enable || adc->wakeup2_enable)
+		device_wakeup_disable(adc->dev);
 }
 
 static int palmas_gpadc_probe(struct platform_device *pdev)
@@ -547,36 +922,49 @@ static int palmas_gpadc_probe(struct platform_device *pdev)
 		return dev_err_probe(adc->dev, ret,
 				     "request irq %d failed\n", adc->irq);
 
+	adc->irq_auto_0 = platform_get_irq(pdev, 1);
+	if (adc->irq_auto_0 < 0)
+		return dev_err_probe(adc->dev, adc->irq_auto_0,
+				     "get auto0 irq failed\n");
+
+	ret = devm_request_threaded_irq(&pdev->dev, adc->irq_auto_0, NULL,
+					palmas_gpadc_irq_auto, IRQF_ONESHOT,
+					"palmas-adc-auto-0", indio_dev);
+	if (ret < 0)
+		return dev_err_probe(adc->dev, ret,
+				     "request auto0 irq %d failed\n",
+				     adc->irq_auto_0);
+
+	adc->irq_auto_1 = platform_get_irq(pdev, 2);
+	if (adc->irq_auto_1 < 0)
+		return dev_err_probe(adc->dev, adc->irq_auto_1,
+				     "get auto1 irq failed\n");
+
+	ret = devm_request_threaded_irq(&pdev->dev, adc->irq_auto_1, NULL,
+					palmas_gpadc_irq_auto, IRQF_ONESHOT,
+					"palmas-adc-auto-1", indio_dev);
+	if (ret < 0)
+		return dev_err_probe(adc->dev, ret,
+				     "request auto1 irq %d failed\n",
+				     adc->irq_auto_1);
+
 	if (gpadc_pdata->adc_wakeup1_data) {
 		memcpy(&adc->wakeup1_data, gpadc_pdata->adc_wakeup1_data,
 			sizeof(adc->wakeup1_data));
 		adc->wakeup1_enable = true;
-		adc->irq_auto_0 =  platform_get_irq(pdev, 1);
-		ret = devm_request_threaded_irq(&pdev->dev, adc->irq_auto_0,
-						NULL, palmas_gpadc_irq_auto,
-						IRQF_ONESHOT,
-						"palmas-adc-auto-0", adc);
-		if (ret < 0)
-			return dev_err_probe(adc->dev, ret,
-					     "request auto0 irq %d failed\n",
-					     adc->irq_auto_0);
 	}
 
 	if (gpadc_pdata->adc_wakeup2_data) {
 		memcpy(&adc->wakeup2_data, gpadc_pdata->adc_wakeup2_data,
 				sizeof(adc->wakeup2_data));
 		adc->wakeup2_enable = true;
-		adc->irq_auto_1 =  platform_get_irq(pdev, 2);
-		ret = devm_request_threaded_irq(&pdev->dev, adc->irq_auto_1,
-						NULL, palmas_gpadc_irq_auto,
-						IRQF_ONESHOT,
-						"palmas-adc-auto-1", adc);
-		if (ret < 0)
-			return dev_err_probe(adc->dev, ret,
-					     "request auto1 irq %d failed\n",
-					     adc->irq_auto_1);
 	}
 
+	adc->event0.channel = -1;
+	adc->event0.direction = IIO_EV_DIR_NONE;
+	adc->event1.channel = -1;
+	adc->event1.direction = IIO_EV_DIR_NONE;
+
 	/* set the current source 0 (value 0/5/15/20 uA => 0..3) */
 	if (gpadc_pdata->ch0_current <= 1)
 		adc->ch0_current = PALMAS_ADC_CH0_CURRENT_SRC_0;
@@ -610,20 +998,23 @@ static int palmas_gpadc_probe(struct platform_device *pdev)
 		return dev_err_probe(adc->dev, ret,
 				     "iio_device_register() failed\n");
 
-	device_set_wakeup_capable(&pdev->dev, 1);
 	for (i = 0; i < PALMAS_ADC_CH_MAX; i++) {
 		if (!(adc->adc_info[i].is_uncalibrated))
 			palmas_gpadc_calibrate(adc, i);
 	}
 
+	device_set_wakeup_capable(&pdev->dev, 1);
 	if (adc->wakeup1_enable || adc->wakeup2_enable) {
-		device_wakeup_enable(&pdev->dev);
-		ret = devm_add_action_or_reset(&pdev->dev,
-					       palmas_disable_wakeup,
-					       &pdev->dev);
+		ret = palmas_adc_wakeup_configure(adc);
 		if (ret)
 			return ret;
+		device_wakeup_enable(&pdev->dev);
 	}
+	ret = devm_add_action_or_reset(&pdev->dev,
+				       palmas_disable_wakeup,
+				       adc);
+	if (ret)
+		return ret;
 
 	return 0;
 }
@@ -755,16 +1146,11 @@ static int palmas_gpadc_suspend(struct device *dev)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct palmas_gpadc *adc = iio_priv(indio_dev);
-	int wakeup = adc->wakeup1_enable || adc->wakeup2_enable;
 	int ret;
 
-	if (!device_may_wakeup(dev) || !wakeup)
+	if (!device_may_wakeup(dev))
 		return 0;
 
-	ret = palmas_adc_wakeup_configure(adc);
-	if (ret < 0)
-		return ret;
-
 	if (adc->wakeup1_enable)
 		enable_irq_wake(adc->irq_auto_0);
 
@@ -778,16 +1164,11 @@ static int palmas_gpadc_resume(struct device *dev)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct palmas_gpadc *adc = iio_priv(indio_dev);
-	int wakeup = adc->wakeup1_enable || adc->wakeup2_enable;
 	int ret;
 
-	if (!device_may_wakeup(dev) || !wakeup)
+	if (!device_may_wakeup(dev))
 		return 0;
 
-	ret = palmas_adc_wakeup_reset(adc);
-	if (ret < 0)
-		return ret;
-
 	if (adc->wakeup1_enable)
 		disable_irq_wake(adc->irq_auto_0);
 
-- 
2.25.1

