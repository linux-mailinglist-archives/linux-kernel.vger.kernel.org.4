Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D6AD73AE93
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 04:24:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231278AbjFWCYK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 22:24:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231138AbjFWCYA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 22:24:00 -0400
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5AF01BCA;
        Thu, 22 Jun 2023 19:23:58 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id CC5655FD8F;
        Fri, 23 Jun 2023 05:23:54 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1687487034;
        bh=kqNz9q85odOrDuiiTt1JEkfAd/EMGs7Y5SX22XNQeEE=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
        b=T39Jxks6azD91PZBhbkGc1NRepOEgTuS1Elqw6BHEExneu+lrGYZsXG2KIhgrdR1s
         qJU2/0uKFkHnCXw6cTC4aH7MzCltyBbjhl48/FJ0+SihFJlq1rMvuBu//8pzZjpUVe
         nvK7nQDr7ySW1ao5hJe8JkL0bW7cA3Wum7ENfunSXuL1fMJiEE5jEtS/5JEP6rvSPg
         fkCeOQ0htuogBhUDJZ5OhevrKV2zBmAUwc34R8DuNKDKPiTvyyWO9mrF5JBe+m3BBJ
         3q5NNsGZuOxmKlp4xX8jSHwcZPD1z8WMLE28i1oDMZbF3N9bYDZTajVxzkofbdmQZs
         dcc9GUDkPiYTw==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Fri, 23 Jun 2023 05:23:54 +0300 (MSK)
From:   George Stark <gnstark@sberdevices.ru>
To:     <jic23@kernel.org>, <lars@metafoo.de>, <neil.armstrong@linaro.org>,
        <khilman@baylibre.com>, <jbrunet@baylibre.com>,
        <martin.blumenstingl@googlemail.com>,
        <andriy.shevchenko@linux.intel.com>, <nuno.sa@analog.com>,
        <gnstark@sberdevices.ru>
CC:     <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-amlogic@lists.infradead.org>, <kernel@sberdevices.ru>,
        George Stark <GNStark@sberdevices.ru>
Subject: [PATCH v2 6/6] meson saradc: support reading from channel7 mux inputs
Date:   Fri, 23 Jun 2023 05:20:14 +0300
Message-ID: <20230623022334.791026-7-gnstark@sberdevices.ru>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230623022334.791026-1-gnstark@sberdevices.ru>
References: <20230623022334.791026-1-gnstark@sberdevices.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2023/06/22 21:10:00 #21557945
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add iio channel for every channel 7 muxer input.
Meson saradc channel 7 is connected to muxer that can switch channel
input to well-known sources like Vdd, GND and several Vdd dividers.

Signed-off-by: George Stark <GNStark@sberdevices.ru>
---

Changelog:
v1->v2: update commit message from [1]

[1] https://lore.kernel.org/lkml/20230621062715.455652-4-gnstark@sberdevices.ru/

---
 drivers/iio/adc/meson_saradc.c | 65 +++++++++++++++++++++++++++++++---
 1 file changed, 61 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/meson_saradc.c b/drivers/iio/adc/meson_saradc.c
index e7eb154b151f..ecaebb569e8e 100644
--- a/drivers/iio/adc/meson_saradc.c
+++ b/drivers/iio/adc/meson_saradc.c
@@ -163,6 +163,7 @@
 #define MESON_SAR_ADC_MAX_FIFO_SIZE				32
 #define MESON_SAR_ADC_TIMEOUT					100 /* ms */
 #define MESON_SAR_ADC_VOLTAGE_AND_TEMP_CHANNEL			6
+#define MESON_SAR_ADC_VOLTAGE_AND_MUX_CHANNEL			7
 #define MESON_SAR_ADC_TEMP_OFFSET				27
 
 /* temperature sensor calibration information in eFuse */
@@ -201,6 +202,19 @@
 	.datasheet_name = "TEMP_SENSOR",				\
 }
 
+#define MESON_SAR_ADC_MUX(_chan, _sel) {				\
+	.type = IIO_VOLTAGE,						\
+	.channel = _chan,						\
+	.indexed = 1,							\
+	.address = MESON_SAR_ADC_VOLTAGE_AND_MUX_CHANNEL,		\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |			\
+				BIT(IIO_CHAN_INFO_AVERAGE_RAW),		\
+	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),		\
+	.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_CALIBBIAS) |	\
+				BIT(IIO_CHAN_INFO_CALIBSCALE),		\
+	.datasheet_name = "SAR_ADC_MUX_"#_sel,				\
+}
+
 enum meson_sar_adc_avg_mode {
 	NO_AVERAGING = 0x0,
 	MEAN_AVERAGING = 0x1,
@@ -233,6 +247,27 @@ enum meson_sar_adc_channel_index {
 	INDEX_CHAN_6,
 	INDEX_CHAN_7,
 	INDEX_CHAN_SOFT_TIMESTAMP,
+	INDEX_MUX_0_VSS,
+	INDEX_MUX_1_VDD_DIV4,
+	INDEX_MUX_2_VDD_DIV2,
+	INDEX_MUX_3_VDD_MUL3_DIV4,
+	INDEX_MUX_4_VDD,
+};
+
+static enum meson_sar_adc_chan7_mux_sel chan7_mux_values[] = {
+	CHAN7_MUX_VSS,
+	CHAN7_MUX_VDD_DIV4,
+	CHAN7_MUX_VDD_DIV2,
+	CHAN7_MUX_VDD_MUL3_DIV4,
+	CHAN7_MUX_VDD,
+};
+
+static const char * const chan7_mux_names[] = {
+	"gnd",
+	"0.25vdd",
+	"0.5vdd",
+	"0.75vdd",
+	"vdd",
 };
 
 static const struct iio_chan_spec meson_sar_adc_iio_channels[] = {
@@ -245,6 +280,11 @@ static const struct iio_chan_spec meson_sar_adc_iio_channels[] = {
 	MESON_SAR_ADC_CHAN(INDEX_CHAN_6),
 	MESON_SAR_ADC_CHAN(INDEX_CHAN_7),
 	IIO_CHAN_SOFT_TIMESTAMP(INDEX_CHAN_SOFT_TIMESTAMP),
+	MESON_SAR_ADC_MUX(INDEX_MUX_0_VSS, 0),
+	MESON_SAR_ADC_MUX(INDEX_MUX_1_VDD_DIV4, 1),
+	MESON_SAR_ADC_MUX(INDEX_MUX_2_VDD_DIV2, 2),
+	MESON_SAR_ADC_MUX(INDEX_MUX_3_VDD_MUL3_DIV4, 3),
+	MESON_SAR_ADC_MUX(INDEX_MUX_4_VDD, 4),
 	MESON_SAR_ADC_TEMP_CHAN(), /* must be the last item */
 };
 
@@ -284,6 +324,7 @@ struct meson_sar_adc_priv {
 	bool					temperature_sensor_calibrated;
 	u8					temperature_sensor_coefficient;
 	u16					temperature_sensor_adc_val;
+	enum meson_sar_adc_chan7_mux_sel	chan7_mux_sel;
 };
 
 static const struct regmap_config meson_sar_adc_regmap_config_gxbb = {
@@ -348,6 +389,8 @@ static void meson_sar_adc_set_chan7_mux(struct iio_dev *indio_dev,
 			   MESON_SAR_ADC_REG3_CTRL_CHAN7_MUX_SEL_MASK, regval);
 
 	usleep_range(10, 20);
+
+	priv->chan7_mux_sel = sel;
 }
 
 static int meson_sar_adc_read_raw_sample(struct iio_dev *indio_dev,
@@ -443,6 +486,15 @@ static void meson_sar_adc_enable_channel(struct iio_dev *indio_dev,
 		regmap_update_bits(priv->regmap,
 				   MESON_SAR_ADC_DELTA_10,
 				   MESON_SAR_ADC_DELTA_10_TEMP_SEL, regval);
+	} else if (chan->address == MESON_SAR_ADC_VOLTAGE_AND_MUX_CHANNEL) {
+		enum meson_sar_adc_chan7_mux_sel sel;
+
+		if (chan->channel == INDEX_CHAN_7)
+			sel = CHAN7_MUX_CH7_INPUT;
+		else
+			sel = chan7_mux_values[chan->channel - INDEX_MUX_0_VSS];
+		if (sel != priv->chan7_mux_sel)
+			meson_sar_adc_set_chan7_mux(indio_dev, sel);
 	}
 }
 
@@ -1015,7 +1067,7 @@ static int meson_sar_adc_calib(struct iio_dev *indio_dev)
 	meson_sar_adc_set_chan7_mux(indio_dev, CHAN7_MUX_VDD_DIV4);
 	usleep_range(10, 20);
 	ret = meson_sar_adc_get_sample(indio_dev,
-				       &indio_dev->channels[INDEX_CHAN_7],
+				       &indio_dev->channels[INDEX_MUX_1_VDD_DIV4],
 				       MEAN_AVERAGING, EIGHT_SAMPLES, &value0);
 	if (ret < 0)
 		goto out;
@@ -1023,7 +1075,7 @@ static int meson_sar_adc_calib(struct iio_dev *indio_dev)
 	meson_sar_adc_set_chan7_mux(indio_dev, CHAN7_MUX_VDD_MUL3_DIV4);
 	usleep_range(10, 20);
 	ret = meson_sar_adc_get_sample(indio_dev,
-				       &indio_dev->channels[INDEX_CHAN_7],
+				       &indio_dev->channels[INDEX_MUX_3_VDD_MUL3_DIV4],
 				       MEAN_AVERAGING, EIGHT_SAMPLES, &value1);
 	if (ret < 0)
 		goto out;
@@ -1050,8 +1102,13 @@ static int read_label(struct iio_dev *indio_dev,
 {
 	if (chan->type == IIO_TEMP)
 		return sprintf(label, "%s\n", "temp-sensor");
-	if (chan->type == IIO_VOLTAGE)
-		return sprintf(label, "channel-%d\n", chan->channel);
+	if (chan->type == IIO_VOLTAGE) {
+		if (chan->channel <= INDEX_CHAN_7)
+			return sprintf(label, "channel-%d\n", chan->channel);
+		if (chan->channel >= INDEX_MUX_0_VSS)
+			return sprintf(label, "%s\n",
+				chan7_mux_names[chan->channel - INDEX_MUX_0_VSS]);
+	}
 	return 0;
 }
 
-- 
2.38.4

