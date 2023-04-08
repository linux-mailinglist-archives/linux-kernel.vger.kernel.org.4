Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 324566DBAAA
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Apr 2023 13:50:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231149AbjDHLus (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Apr 2023 07:50:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231207AbjDHLue (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Apr 2023 07:50:34 -0400
Received: from pio-pvt-msa2.bahnhof.se (pio-pvt-msa2.bahnhof.se [79.136.2.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D88B6B76D;
        Sat,  8 Apr 2023 04:50:07 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa2.bahnhof.se (Postfix) with ESMTP id B4C2840505;
        Sat,  8 Apr 2023 13:49:57 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Score: -2.1
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
Authentication-Results: pio-pvt-msa2.bahnhof.se (amavisd-new);
        dkim=pass (2048-bit key) header.d=dalakolonin.se
Received: from pio-pvt-msa2.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id wUuAbJ9u5nL4; Sat,  8 Apr 2023 13:49:56 +0200 (CEST)
Received: by pio-pvt-msa2.bahnhof.se (Postfix) with ESMTPA id AA746403F0;
        Sat,  8 Apr 2023 13:49:56 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.dalakolonin.se (Postfix) with ESMTP id 7DE1E9602F;
        Sat,  8 Apr 2023 11:49:56 +0000 (UTC)
Received: from zimbra.dalakolonin.se ([127.0.0.1])
        by localhost (zimbra.dalakolonin.se [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 4k1x_U80Uto7; Sat,  8 Apr 2023 11:49:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.dalakolonin.se (Postfix) with ESMTP id 3B6CE9602B;
        Sat,  8 Apr 2023 11:49:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.10.3 zimbra.dalakolonin.se 3B6CE9602B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dalakolonin.se;
        s=D374B428-D0A7-11ED-A657-75977B426508; t=1680954593;
        bh=ozXExLLK749ql2WwoKfjB+Ge85Ngz7BDMw8CTZAqlOM=;
        h=From:To:Date:Message-Id:MIME-Version;
        b=XxN6/o9rYAa3dFX1rU8s0qBGgB6mr3mxOKqmfL/F+IU58f8TQgTjDP/y0ijw2LlPi
         V5wRXbAC/+z4lVP9Us3ONxLHMUBAsOZXU/PDyGZBQMTvVFoEfpVyMeUuCgUt1HF87M
         Qlwrgi7YLLiMDhJHbg6ieYzjdyubX3Tu505aynnpSBJAfOPtl5d4Ovw60/e84Oi4N7
         21yNVh/5QdrALhr84PTRqUlgAGf+0MyoKUdH/gbiA6ZywhGP/HhYIudO/myxfvkAOF
         MEEXoiF0Z7Zy6i4M+B84Y2KY5H/IWZZuAk7O7AJSVm7IcTa+VpUER2O9efaQlmkidP
         HYXnQlgWxSICg==
X-Virus-Scanned: amavisd-new at dalakolonin.se
Received: from zimbra.dalakolonin.se ([127.0.0.1])
        by localhost (zimbra.dalakolonin.se [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 5_n072qCZTPr; Sat,  8 Apr 2023 11:49:53 +0000 (UTC)
Received: from rack-server-1.dalakolonin.se (unknown [172.17.0.1])
        by zimbra.dalakolonin.se (Postfix) with ESMTPSA id DA94296028;
        Sat,  8 Apr 2023 11:49:52 +0000 (UTC)
From:   =?UTF-8?q?Patrik=20Dahlstr=C3=B6m?= <risca@dalakolonin.se>
To:     linux-iio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org,
        kernel@pyra-handheld.com, pgoudagunta@nvidia.com,
        hns@goldelico.com, jic23@kernel.org, lars@metafoo.de,
        linux-omap@vger.kernel.org,
        =?UTF-8?q?Patrik=20Dahlstr=C3=B6m?= <risca@dalakolonin.se>
Subject: [PATCH v4 8/9] iio: adc: palmas: add support for iio threshold events
Date:   Sat,  8 Apr 2023 13:48:24 +0200
Message-Id: <20230408114825.824505-9-risca@dalakolonin.se>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230408114825.824505-1-risca@dalakolonin.se>
References: <20230408114825.824505-1-risca@dalakolonin.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The palmas gpadc block has support for monitoring up to 2 ADC channels
and issue an interrupt if they reach past a set threshold. This change
hooks into the IIO events system and exposes to userspace the ability to
configure these threshold values for each channel, but only allow up to
2 such thresholds to be enabled at any given time. Trying to enable a
third channel will result in an error.

Userspace is expected to input calibrated, as opposed to raw, values as
threshold. However, it is not enough to do the opposite of what is done
when converting the other way around. To account for tolerances in the
ADC, the calculated raw threshold should be adjusted based on the ADC
specifications for the device. These specifications include the integral
nonlinearity (INL), offset, and gain error. To adjust the high
threshold, use the following equation:

  (calibrated value + INL) * Gain error + offset =3D maximum value  [1]

Likewise, use the following equation for the low threshold:

  (calibrated value - INL) * Gain error - offset =3D minimum value

The gain error is a combination of gain error, as listed in the
datasheet, and gain error drift due to temperature and supply. The exact
values for these specifications vary between palmas devices. This patch
sets the values found in TWL6035, TWL6037 datasheet.

[1] TI Application Report, SLIA087A, Guide to Using the GPADC in
    TPS65903x, TPS65917-Q1, TPS65919-Q1, and TPS65916 Devices.

Signed-off-by: Patrik Dahlstr=C3=B6m <risca@dalakolonin.se>
---

V3 -> V4:
* Avoid initializing variables unnecessarily.
* Minor cosmetic fixes to comments.

 drivers/iio/adc/palmas_gpadc.c | 444 +++++++++++++++++++++++++++++++--
 1 file changed, 420 insertions(+), 24 deletions(-)

diff --git a/drivers/iio/adc/palmas_gpadc.c b/drivers/iio/adc/palmas_gpad=
c.c
index da4908608a27..f16f4ef184e4 100644
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
@@ -79,10 +80,14 @@ static struct palmas_gpadc_info palmas_gpadc_info[] =3D=
 {
 struct palmas_adc_event {
 	bool enabled;
 	int channel;
-	int raw_thresh;
 	enum iio_event_direction direction;
 };
=20
+struct palmas_gpadc_thresholds {
+	int high;
+	int low;
+};
+
 /*
  * struct palmas_gpadc - the palmas_gpadc structure
  * @ch0_current:	channel 0 current source setting
@@ -120,10 +125,31 @@ struct palmas_gpadc {
 	struct completion		conv_completion;
 	struct palmas_adc_event		event0;
 	struct palmas_adc_event		event1;
+	struct palmas_gpadc_thresholds	thresholds[PALMAS_ADC_CH_MAX];
 	int				auto_conversion_period;
 	struct mutex			lock;
 };
=20
+static struct palmas_adc_event *palmas_gpadc_get_event(struct palmas_gpa=
dc *adc,
+						       int adc_chan,
+						       enum iio_event_direction dir)
+{
+	if (adc_chan =3D=3D adc->event0.channel && dir =3D=3D adc->event0.direc=
tion)
+		return &adc->event0;
+
+	if (adc_chan =3D=3D adc->event1.channel && dir =3D=3D adc->event1.direc=
tion)
+		return &adc->event1;
+
+	return NULL;
+}
+
+static bool palmas_gpadc_channel_is_freerunning(struct palmas_gpadc *adc=
,
+						int adc_chan)
+{
+	return palmas_gpadc_get_event(adc, adc_chan, IIO_EV_DIR_RISING) ||
+		palmas_gpadc_get_event(adc, adc_chan, IIO_EV_DIR_FALLING);
+}
+
 /*
  * GPADC lock issue in AUTO mode.
  * Impact: In AUTO mode, GPADC conversion can be locked after disabling =
AUTO
@@ -193,11 +219,24 @@ static irqreturn_t palmas_gpadc_irq(int irq, void *=
data)
=20
 static irqreturn_t palmas_gpadc_irq_auto(int irq, void *data)
 {
-	struct palmas_gpadc *adc =3D data;
+	struct iio_dev *indio_dev =3D data;
+	struct palmas_gpadc *adc =3D iio_priv(indio_dev);
+	struct palmas_adc_event *ev;
=20
 	dev_dbg(adc->dev, "Threshold interrupt %d occurs\n", irq);
 	palmas_disable_auto_conversion(adc);
=20
+	ev =3D (irq =3D=3D adc->irq_auto_0) ? &adc->event0 : &adc->event1;
+	if (ev->channel !=3D -1) {
+		enum iio_event_direction dir;
+		u64 code;
+
+		dir =3D ev->direction;
+		code =3D IIO_UNMOD_EVENT_CODE(IIO_VOLTAGE, ev->channel,
+					    IIO_EV_TYPE_THRESH, dir);
+		iio_push_event(indio_dev, code, iio_get_time_ns(indio_dev));
+	}
+
 	return IRQ_HANDLED;
 }
=20
@@ -285,6 +324,9 @@ static int palmas_gpadc_read_prepare(struct palmas_gp=
adc *adc, int adc_chan)
 {
 	int ret;
=20
+	if (palmas_gpadc_channel_is_freerunning(adc, adc_chan))
+		return 0; /* ADC already running */
+
 	ret =3D palmas_gpadc_enable(adc, adc_chan, true);
 	if (ret < 0)
 		return ret;
@@ -344,28 +386,43 @@ static int palmas_gpadc_start_conversion(struct pal=
mas_gpadc *adc, int adc_chan)
 	unsigned int val;
 	int ret;
=20
-	init_completion(&adc->conv_completion);
-	ret =3D palmas_update_bits(adc->palmas, PALMAS_GPADC_BASE,
-				PALMAS_GPADC_SW_SELECT,
-				PALMAS_GPADC_SW_SELECT_SW_START_CONV0,
-				PALMAS_GPADC_SW_SELECT_SW_START_CONV0);
-	if (ret < 0) {
-		dev_err(adc->dev, "SELECT_SW_START write failed: %d\n", ret);
-		return ret;
-	}
+	if (palmas_gpadc_channel_is_freerunning(adc, adc_chan)) {
+		int event =3D (adc_chan =3D=3D adc->event0.channel) ? 0 : 1;
+		unsigned int reg =3D (event =3D=3D 0) ?
+			PALMAS_GPADC_AUTO_CONV0_LSB :
+			PALMAS_GPADC_AUTO_CONV1_LSB;
=20
-	ret =3D wait_for_completion_timeout(&adc->conv_completion,
-				PALMAS_ADC_CONVERSION_TIMEOUT);
-	if (ret =3D=3D 0) {
-		dev_err(adc->dev, "conversion not completed\n");
-		return -ETIMEDOUT;
-	}
+		ret =3D palmas_bulk_read(adc->palmas, PALMAS_GPADC_BASE,
+					reg, &val, 2);
+		if (ret < 0) {
+			dev_err(adc->dev, "AUTO_CONV%x_LSB read failed: %d\n",
+				event, ret);
+			return ret;
+		}
+	} else {
+		init_completion(&adc->conv_completion);
+		ret =3D palmas_update_bits(adc->palmas, PALMAS_GPADC_BASE,
+					PALMAS_GPADC_SW_SELECT,
+					PALMAS_GPADC_SW_SELECT_SW_START_CONV0,
+					PALMAS_GPADC_SW_SELECT_SW_START_CONV0);
+		if (ret < 0) {
+			dev_err(adc->dev, "SELECT_SW_START write failed: %d\n", ret);
+			return ret;
+		}
=20
-	ret =3D palmas_bulk_read(adc->palmas, PALMAS_GPADC_BASE,
-				PALMAS_GPADC_SW_CONV0_LSB, &val, 2);
-	if (ret < 0) {
-		dev_err(adc->dev, "SW_CONV0_LSB read failed: %d\n", ret);
-		return ret;
+		ret =3D wait_for_completion_timeout(&adc->conv_completion,
+					PALMAS_ADC_CONVERSION_TIMEOUT);
+		if (ret =3D=3D 0) {
+			dev_err(adc->dev, "conversion not completed\n");
+			return -ETIMEDOUT;
+		}
+
+		ret =3D palmas_bulk_read(adc->palmas, PALMAS_GPADC_BASE,
+					PALMAS_GPADC_SW_CONV0_LSB, &val, 2);
+		if (ret < 0) {
+			dev_err(adc->dev, "SW_CONV0_LSB read failed: %d\n", ret);
+			return ret;
+		}
 	}
=20
 	ret =3D val & 0xFFF;
@@ -391,6 +448,98 @@ static int palmas_gpadc_get_calibrated_code(struct p=
almas_gpadc *adc,
 	return val;
 }
=20
+/*
+ * The high and low threshold values are calculated based on the advice =
given
+ * in TI Application Report SLIA087A, "Guide to Using the GPADC in PS659=
03x,
+ * TPS65917-Q1, TPS65919-Q1, and TPS65916 Devices". This document recomm=
end
+ * taking ADC tolerances into account and is based on the device integra=
l non-
+ * linearity (INL), offset error and gain error:
+ *
+ *   raw high threshold =3D (ideal threshold + INL) * gain error + offse=
t error
+ *
+ * The gain error include both gain error, as specified in the datasheet=
, and
+ * the gain error drift. These paramenters vary depending on device and =
whether
+ * the the channel is calibrated (trimmed) or not.
+ */
+static int palmas_gpadc_threshold_with_tolerance(int val, const int INL,
+						 const int gain_error,
+						 const int offset_error)
+{
+	val =3D ((val + INL) * (1000 + gain_error)) / 1000 + offset_error;
+
+	return clamp(val, 0, 0xFFF);
+}
+
+/*
+ * The values below are taken from the datasheet of TWL6035, TWL6037.
+ * todo: get max INL, gain error, and offset error from OF.
+ */
+static int palmas_gpadc_get_high_threshold_raw(struct palmas_gpadc *adc,
+					       struct palmas_adc_event *ev)
+{
+	const int adc_chan =3D ev->channel;
+	int val =3D adc->thresholds[adc_chan].high;
+	/* integral nonlinearity, measured in LSB */
+	const int max_INL =3D 2;
+	/* measured in LSB */
+	int max_offset_error;
+	/* 0.2% when calibrated */
+	int max_gain_error =3D 2;
+
+	val =3D (val * 1000) / adc->adc_info[adc_chan].gain;
+
+	if (adc->adc_info[adc_chan].is_uncalibrated) {
+		/* 2% worse */
+		max_gain_error +=3D 20;
+		max_offset_error =3D 36;
+	} else {
+		val =3D (val * adc->adc_info[adc_chan].gain_error +
+		       adc->adc_info[adc_chan].offset) /
+			1000;
+		max_offset_error =3D 2;
+	}
+
+	return palmas_gpadc_threshold_with_tolerance(val,
+						     max_INL,
+						     max_gain_error,
+						     max_offset_error);
+}
+
+/*
+ * The values below are taken from the datasheet of TWL6035, TWL6037.
+ * todo: get min INL, gain error, and offset error from OF.
+ */
+static int palmas_gpadc_get_low_threshold_raw(struct palmas_gpadc *adc,
+					      struct palmas_adc_event *ev)
+{
+	const int adc_chan =3D ev->channel;
+	int val =3D adc->thresholds[adc_chan].low;
+	/* integral nonlinearity, measured in LSB */
+	const int min_INL =3D -2;
+	/* measured in LSB */
+	int min_offset_error;
+	/* -0.6% when calibrated */
+	int min_gain_error =3D -6;
+
+	val =3D (val * 1000) / adc->adc_info[adc_chan].gain;
+
+        if (adc->adc_info[adc_chan].is_uncalibrated) {
+		/* 2% worse */
+		min_gain_error -=3D 20;
+		min_offset_error =3D -36;
+        } else {
+		val =3D (val * adc->adc_info[adc_chan].gain_error -
+		       adc->adc_info[adc_chan].offset) /
+			1000;
+		min_offset_error =3D -2;
+        }
+
+	return palmas_gpadc_threshold_with_tolerance(val,
+						     min_INL,
+						     min_gain_error,
+						     min_offset_error);
+}
+
 static int palmas_gpadc_read_raw(struct iio_dev *indio_dev,
 	struct iio_chan_spec const *chan, int *val, int *val2, long mask)
 {
@@ -437,8 +586,218 @@ static int palmas_gpadc_read_raw(struct iio_dev *in=
dio_dev,
 	return ret;
 }
=20
+static int palmas_gpadc_read_event_config(struct iio_dev *indio_dev,
+					  const struct iio_chan_spec *chan,
+					  enum iio_event_type type,
+					  enum iio_event_direction dir)
+{
+	struct palmas_gpadc *adc =3D iio_priv(indio_dev);
+	int adc_chan =3D chan->channel;
+	int ret =3D 0;
+
+	if (adc_chan > PALMAS_ADC_CH_MAX || type !=3D IIO_EV_TYPE_THRESH)
+		return -EINVAL;
+
+	mutex_lock(&adc->lock);
+
+	if (palmas_gpadc_get_event(adc, adc_chan, dir))
+		ret =3D 1;
+
+	mutex_unlock(&adc->lock);
+
+	return ret;
+}
+
+static int palmas_adc_configure_events(struct palmas_gpadc *adc);
+static int palmas_adc_reset_events(struct palmas_gpadc *adc);
+
+static int palmas_gpadc_reconfigure_event_channels(struct palmas_gpadc *=
adc)
+{
+	return (adc->event0.enabled || adc->event1.enabled) ?
+		palmas_adc_configure_events(adc) :
+		palmas_adc_reset_events(adc);
+}
+
+static int palmas_gpadc_enable_event_config(struct palmas_gpadc *adc,
+					    const struct iio_chan_spec *chan,
+					    enum iio_event_direction dir)
+{
+	struct palmas_adc_event *ev;
+	int adc_chan =3D chan->channel;
+
+	if (palmas_gpadc_get_event(adc, adc_chan, dir))
+		/* already enabled */
+		return 0;
+
+	if (adc->event0.channel =3D=3D -1) {
+		ev =3D &adc->event0;
+	} else if (adc->event1.channel =3D=3D -1) {
+		/* event0 has to be the lowest channel */
+		if (adc_chan < adc->event0.channel) {
+			adc->event1 =3D adc->event0;
+			ev =3D &adc->event0;
+		} else {
+			ev =3D &adc->event1;
+		}
+	} else { /* both AUTO channels already in use */
+		dev_warn(adc->dev, "event0 - %d, event1 - %d\n",
+			 adc->event0.channel, adc->event1.channel);
+		return -EBUSY;
+	}
+
+	ev->enabled =3D true;
+	ev->channel =3D adc_chan;
+	ev->direction =3D dir;
+
+	return palmas_gpadc_reconfigure_event_channels(adc);
+}
+
+static int palmas_gpadc_disable_event_config(struct palmas_gpadc *adc,
+					     const struct iio_chan_spec *chan,
+					     enum iio_event_direction dir)
+{
+	int adc_chan =3D chan->channel;
+	struct palmas_adc_event *ev =3D palmas_gpadc_get_event(adc, adc_chan, d=
ir);
+
+	if (!ev)
+		return 0;
+
+	if (ev =3D=3D &adc->event0) {
+		adc->event0 =3D adc->event1;
+		ev =3D &adc->event1;
+	}
+
+	ev->enabled =3D false;
+	ev->channel =3D -1;
+	ev->direction =3D IIO_EV_DIR_NONE;
+
+	return palmas_gpadc_reconfigure_event_channels(adc);
+}
+
+static int palmas_gpadc_write_event_config(struct iio_dev *indio_dev,
+					   const struct iio_chan_spec *chan,
+					   enum iio_event_type type,
+					   enum iio_event_direction dir,
+					   int state)
+{
+	struct palmas_gpadc *adc =3D iio_priv(indio_dev);
+	int adc_chan =3D chan->channel;
+	int ret;
+
+	if (adc_chan > PALMAS_ADC_CH_MAX || type !=3D IIO_EV_TYPE_THRESH)
+		return -EINVAL;
+
+	mutex_lock(&adc->lock);
+
+	if (state)
+		ret =3D palmas_gpadc_enable_event_config(adc, chan, dir);
+	else
+		ret =3D palmas_gpadc_disable_event_config(adc, chan, dir);
+
+	mutex_unlock(&adc->lock);
+
+	return ret;
+}
+
+static int palmas_gpadc_read_event_value(struct iio_dev *indio_dev,
+					 const struct iio_chan_spec *chan,
+					 enum iio_event_type type,
+					 enum iio_event_direction dir,
+					 enum iio_event_info info,
+					 int *val, int *val2)
+{
+	struct palmas_gpadc *adc =3D iio_priv(indio_dev);
+	int adc_chan =3D chan->channel;
+	int ret;
+
+	if (adc_chan > PALMAS_ADC_CH_MAX || type !=3D IIO_EV_TYPE_THRESH)
+		return -EINVAL;
+
+	mutex_lock(&adc->lock);
+
+	switch (info) {
+	case IIO_EV_INFO_VALUE:
+		*val =3D (dir =3D=3D IIO_EV_DIR_RISING) ?
+			adc->thresholds[adc_chan].high :
+			adc->thresholds[adc_chan].low;
+		ret =3D IIO_VAL_INT;
+		break;
+	default:
+		ret =3D -EINVAL;
+		break;
+	}
+
+	mutex_unlock(&adc->lock);
+
+	return ret;
+}
+
+static int palmas_gpadc_write_event_value(struct iio_dev *indio_dev,
+					  const struct iio_chan_spec *chan,
+					  enum iio_event_type type,
+					  enum iio_event_direction dir,
+					  enum iio_event_info info,
+					  int val, int val2)
+{
+	struct palmas_gpadc *adc =3D iio_priv(indio_dev);
+	int adc_chan =3D chan->channel;
+	int old;
+	int ret;
+
+	if (adc_chan > PALMAS_ADC_CH_MAX || type !=3D IIO_EV_TYPE_THRESH)
+		return -EINVAL;
+
+	mutex_lock(&adc->lock);
+	switch (info) {
+	case IIO_EV_INFO_VALUE:
+		if (val < 0 || val > 0xFFF) {
+			ret =3D -EINVAL;
+			break;
+		}
+		if (dir =3D=3D IIO_EV_DIR_RISING) {
+			old =3D adc->thresholds[adc_chan].high;
+			adc->thresholds[adc_chan].high =3D val;
+		}
+		else {
+			old =3D adc->thresholds[adc_chan].low;
+			adc->thresholds[adc_chan].low =3D val;
+		}
+		ret =3D 0;
+		break;
+	default:
+		ret =3D -EINVAL;
+		goto out_unlock;
+	}
+
+	if (val !=3D old && palmas_gpadc_get_event(adc, adc_chan, dir))
+		ret =3D palmas_gpadc_reconfigure_event_channels(adc);
+
+out_unlock:
+	mutex_unlock(&adc->lock);
+
+	return ret;
+}
+
 static const struct iio_info palmas_gpadc_iio_info =3D {
 	.read_raw =3D palmas_gpadc_read_raw,
+	.read_event_config =3D palmas_gpadc_read_event_config,
+	.write_event_config =3D palmas_gpadc_write_event_config,
+	.read_event_value =3D palmas_gpadc_read_event_value,
+	.write_event_value =3D palmas_gpadc_write_event_value,
+};
+
+static const struct iio_event_spec palmas_gpadc_events[] =3D {
+	{
+		.type =3D IIO_EV_TYPE_THRESH,
+		.dir =3D IIO_EV_DIR_RISING,
+		.mask_separate =3D BIT(IIO_EV_INFO_VALUE) |
+				BIT(IIO_EV_INFO_ENABLE),
+	}, {
+		.type =3D IIO_EV_TYPE_THRESH,
+		.dir =3D IIO_EV_DIR_FALLING,
+		.mask_separate =3D BIT(IIO_EV_INFO_VALUE) |
+				BIT(IIO_EV_INFO_ENABLE),
+	},
 };
=20
 #define PALMAS_ADC_CHAN_IIO(chan, _type, chan_info)	\
@@ -449,6 +808,8 @@ static const struct iio_info palmas_gpadc_iio_info =3D=
 {
 			BIT(chan_info),			\
 	.indexed =3D 1,					\
 	.channel =3D PALMAS_ADC_CH_##chan,		\
+	.event_spec =3D palmas_gpadc_events,		\
+	.num_event_specs =3D ARRAY_SIZE(palmas_gpadc_events)	\
 }
=20
 static const struct iio_chan_spec palmas_gpadc_iio_channel[] =3D {
@@ -555,6 +916,39 @@ static int palmas_gpadc_probe(struct platform_device=
 *pdev)
 		return dev_err_probe(adc->dev, ret,
 				     "request irq %d failed\n", adc->irq);
=20
+	adc->irq_auto_0 =3D platform_get_irq(pdev, 1);
+	if (adc->irq_auto_0 < 0)
+		return dev_err_probe(adc->dev, adc->irq_auto_0,
+				     "get auto0 irq failed\n");
+
+	ret =3D devm_request_threaded_irq(&pdev->dev, adc->irq_auto_0, NULL,
+					palmas_gpadc_irq_auto, IRQF_ONESHOT,
+					"palmas-adc-auto-0", indio_dev);
+	if (ret < 0)
+		return dev_err_probe(adc->dev, ret,
+				     "request auto0 irq %d failed\n",
+				     adc->irq_auto_0);
+
+	adc->irq_auto_1 =3D platform_get_irq(pdev, 2);
+	if (adc->irq_auto_1 < 0)
+		return dev_err_probe(adc->dev, adc->irq_auto_1,
+				     "get auto1 irq failed\n");
+
+	ret =3D devm_request_threaded_irq(&pdev->dev, adc->irq_auto_1, NULL,
+					palmas_gpadc_irq_auto, IRQF_ONESHOT,
+					"palmas-adc-auto-1", indio_dev);
+	if (ret < 0)
+		return dev_err_probe(adc->dev, ret,
+				     "request auto1 irq %d failed\n",
+				     adc->irq_auto_1);
+
+	adc->event0.enabled =3D false;
+	adc->event0.channel =3D -1;
+	adc->event0.direction =3D IIO_EV_DIR_NONE;
+	adc->event1.enabled =3D false;
+	adc->event1.channel =3D -1;
+	adc->event1.direction =3D IIO_EV_DIR_NONE;
+
 	/* set the current source 0 (value 0/5/15/20 uA =3D> 0..3) */
 	if (gpadc_pdata->ch0_current <=3D 1)
 		adc->ch0_current =3D PALMAS_ADC_CH0_CURRENT_SRC_0;
@@ -632,13 +1026,14 @@ static int palmas_adc_configure_events(struct palm=
as_gpadc *adc)
 		int polarity;
=20
 		ch0 =3D ev->channel;
-		thres =3D ev->raw_thresh;
 		conv |=3D PALMAS_GPADC_AUTO_CTRL_AUTO_CONV0_EN;
 		switch (ev->direction) {
 		case IIO_EV_DIR_RISING:
+			thres =3D palmas_gpadc_get_high_threshold_raw(adc, ev);
 			polarity =3D 0;
 			break;
 		case IIO_EV_DIR_FALLING:
+			thres =3D palmas_gpadc_get_low_threshold_raw(adc, ev);
 			polarity =3D PALMAS_GPADC_THRES_CONV0_MSB_THRES_CONV0_POL;
 			break;
 		default:
@@ -668,13 +1063,14 @@ static int palmas_adc_configure_events(struct palm=
as_gpadc *adc)
 		int polarity;
=20
 		ch1 =3D ev->channel;
-		thres =3D ev->raw_thresh;
 		conv |=3D PALMAS_GPADC_AUTO_CTRL_AUTO_CONV1_EN;
 		switch (ev->direction) {
 		case IIO_EV_DIR_RISING:
+			thres =3D palmas_gpadc_get_high_threshold_raw(adc, ev);
 			polarity =3D 0;
 			break;
 		case IIO_EV_DIR_FALLING:
+			thres =3D palmas_gpadc_get_low_threshold_raw(adc, ev);
 			polarity =3D PALMAS_GPADC_THRES_CONV1_MSB_THRES_CONV1_POL;
 			break;
 		default:
--=20
2.25.1

