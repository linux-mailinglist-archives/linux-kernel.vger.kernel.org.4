Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EDF3737B67
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 08:39:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbjFUG1o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 02:27:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbjFUG1i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 02:27:38 -0400
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF2F21AC;
        Tue, 20 Jun 2023 23:27:36 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id 1E9B35FD5F;
        Wed, 21 Jun 2023 09:27:35 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1687328855;
        bh=1HCYzQCWt+fRi1jUgBj1XLHgZN68PTMiptoPlI6IIWk=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
        b=PMlBL9RC8nMPIi5Kr5U9w97+BUgNfviyi54qKXXimeW+pRY/sFgGmqO9f/8ysXWcB
         VC9oGlrxC0B7K4DPMg4hfQwINDjCnAvFNWJwpOIXoYDCXtl6qoJoJWW7QkYXPFAg2Q
         scDZNVCQzNTnaY08NI5wuRFFJ7BNHeuWJsgpbMMeL/osJdzXwQ84hiYTcxHbaUsIcz
         2IwHetI79PUWQQ+nYFN09uyYpqvfFKDLZplHQVkbFXNnk4fLfwNIMk1YqxBYThirYz
         oJxy+V6706Bbt+KJJ/StoiTw0kKJ8OoZtWgXPVx7/zhyNjE6XXYN5BuqXXr7WIOubp
         WriTf1lvp5VtA==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Wed, 21 Jun 2023 09:27:34 +0300 (MSK)
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
Subject: [PATCH v1 1/3] meson saradc: code refactoring
Date:   Wed, 21 Jun 2023 09:26:08 +0300
Message-ID: <20230621062715.455652-2-gnstark@sberdevices.ru>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230621062715.455652-1-gnstark@sberdevices.ru>
References: <20230621062715.455652-1-gnstark@sberdevices.ru>
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
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2023/06/20 23:30:00 #21539802
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

- remove channel array double definition
- add channel index enum
- move enums declaration before variables declaration
- move meson_sar_adc_set_chan7_mux routine upper

Signed-off-by: George Stark <GNStark@sberdevices.ru>
---
 drivers/iio/adc/meson_saradc.c | 97 ++++++++++++++++------------------
 1 file changed, 46 insertions(+), 51 deletions(-)

diff --git a/drivers/iio/adc/meson_saradc.c b/drivers/iio/adc/meson_saradc.c
index 18937a262af6..42f0389e123d 100644
--- a/drivers/iio/adc/meson_saradc.c
+++ b/drivers/iio/adc/meson_saradc.c
@@ -189,9 +189,8 @@
 	.datasheet_name = "SAR_ADC_CH"#_chan,				\
 }
 
-#define MESON_SAR_ADC_TEMP_CHAN(_chan) {				\
+#define MESON_SAR_ADC_TEMP_CHAN() {					\
 	.type = IIO_TEMP,						\
-	.channel = _chan,						\
 	.address = MESON_SAR_ADC_VOLTAGE_AND_TEMP_CHANNEL,		\
 	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |			\
 				BIT(IIO_CHAN_INFO_AVERAGE_RAW),		\
@@ -202,31 +201,6 @@
 	.datasheet_name = "TEMP_SENSOR",				\
 }
 
-static const struct iio_chan_spec meson_sar_adc_iio_channels[] = {
-	MESON_SAR_ADC_CHAN(0),
-	MESON_SAR_ADC_CHAN(1),
-	MESON_SAR_ADC_CHAN(2),
-	MESON_SAR_ADC_CHAN(3),
-	MESON_SAR_ADC_CHAN(4),
-	MESON_SAR_ADC_CHAN(5),
-	MESON_SAR_ADC_CHAN(6),
-	MESON_SAR_ADC_CHAN(7),
-	IIO_CHAN_SOFT_TIMESTAMP(8),
-};
-
-static const struct iio_chan_spec meson_sar_adc_and_temp_iio_channels[] = {
-	MESON_SAR_ADC_CHAN(0),
-	MESON_SAR_ADC_CHAN(1),
-	MESON_SAR_ADC_CHAN(2),
-	MESON_SAR_ADC_CHAN(3),
-	MESON_SAR_ADC_CHAN(4),
-	MESON_SAR_ADC_CHAN(5),
-	MESON_SAR_ADC_CHAN(6),
-	MESON_SAR_ADC_CHAN(7),
-	MESON_SAR_ADC_TEMP_CHAN(8),
-	IIO_CHAN_SOFT_TIMESTAMP(9),
-};
-
 enum meson_sar_adc_avg_mode {
 	NO_AVERAGING = 0x0,
 	MEAN_AVERAGING = 0x1,
@@ -249,6 +223,31 @@ enum meson_sar_adc_chan7_mux_sel {
 	CHAN7_MUX_CH7_INPUT = 0x7,
 };
 
+enum meson_sar_adc_channel_index {
+	INDEX_CHAN_0,
+	INDEX_CHAN_1,
+	INDEX_CHAN_2,
+	INDEX_CHAN_3,
+	INDEX_CHAN_4,
+	INDEX_CHAN_5,
+	INDEX_CHAN_6,
+	INDEX_CHAN_7,
+	INDEX_CHAN_SOFT_TIMESTAMP,
+};
+
+static const struct iio_chan_spec meson_sar_adc_iio_channels[] = {
+	MESON_SAR_ADC_CHAN(INDEX_CHAN_0),
+	MESON_SAR_ADC_CHAN(INDEX_CHAN_1),
+	MESON_SAR_ADC_CHAN(INDEX_CHAN_2),
+	MESON_SAR_ADC_CHAN(INDEX_CHAN_3),
+	MESON_SAR_ADC_CHAN(INDEX_CHAN_4),
+	MESON_SAR_ADC_CHAN(INDEX_CHAN_5),
+	MESON_SAR_ADC_CHAN(INDEX_CHAN_6),
+	MESON_SAR_ADC_CHAN(INDEX_CHAN_7),
+	IIO_CHAN_SOFT_TIMESTAMP(INDEX_CHAN_SOFT_TIMESTAMP),
+	MESON_SAR_ADC_TEMP_CHAN(), /* must be the last item */
+};
+
 struct meson_sar_adc_param {
 	bool					has_bl30_integration;
 	unsigned long				clock_rate;
@@ -338,6 +337,19 @@ static int meson_sar_adc_wait_busy_clear(struct iio_dev *indio_dev)
 					       1, 10000);
 }
 
+static void meson_sar_adc_set_chan7_mux(struct iio_dev *indio_dev,
+					enum meson_sar_adc_chan7_mux_sel sel)
+{
+	struct meson_sar_adc_priv *priv = iio_priv(indio_dev);
+	u32 regval;
+
+	regval = FIELD_PREP(MESON_SAR_ADC_REG3_CTRL_CHAN7_MUX_SEL_MASK, sel);
+	regmap_update_bits(priv->regmap, MESON_SAR_ADC_REG3,
+			   MESON_SAR_ADC_REG3_CTRL_CHAN7_MUX_SEL_MASK, regval);
+
+	usleep_range(10, 20);
+}
+
 static int meson_sar_adc_read_raw_sample(struct iio_dev *indio_dev,
 					 const struct iio_chan_spec *chan,
 					 int *val)
@@ -434,19 +446,6 @@ static void meson_sar_adc_enable_channel(struct iio_dev *indio_dev,
 	}
 }
 
-static void meson_sar_adc_set_chan7_mux(struct iio_dev *indio_dev,
-					enum meson_sar_adc_chan7_mux_sel sel)
-{
-	struct meson_sar_adc_priv *priv = iio_priv(indio_dev);
-	u32 regval;
-
-	regval = FIELD_PREP(MESON_SAR_ADC_REG3_CTRL_CHAN7_MUX_SEL_MASK, sel);
-	regmap_update_bits(priv->regmap, MESON_SAR_ADC_REG3,
-			   MESON_SAR_ADC_REG3_CTRL_CHAN7_MUX_SEL_MASK, regval);
-
-	usleep_range(10, 20);
-}
-
 static void meson_sar_adc_start_sample_engine(struct iio_dev *indio_dev)
 {
 	struct meson_sar_adc_priv *priv = iio_priv(indio_dev);
@@ -1016,7 +1015,7 @@ static int meson_sar_adc_calib(struct iio_dev *indio_dev)
 	meson_sar_adc_set_chan7_mux(indio_dev, CHAN7_MUX_VDD_DIV4);
 	usleep_range(10, 20);
 	ret = meson_sar_adc_get_sample(indio_dev,
-				       &indio_dev->channels[7],
+				       &indio_dev->channels[INDEX_CHAN_7],
 				       MEAN_AVERAGING, EIGHT_SAMPLES, &value0);
 	if (ret < 0)
 		goto out;
@@ -1024,7 +1023,7 @@ static int meson_sar_adc_calib(struct iio_dev *indio_dev)
 	meson_sar_adc_set_chan7_mux(indio_dev, CHAN7_MUX_VDD_MUL3_DIV4);
 	usleep_range(10, 20);
 	ret = meson_sar_adc_get_sample(indio_dev,
-				       &indio_dev->channels[7],
+				       &indio_dev->channels[INDEX_CHAN_7],
 				       MEAN_AVERAGING, EIGHT_SAMPLES, &value1);
 	if (ret < 0)
 		goto out;
@@ -1242,15 +1241,11 @@ static int meson_sar_adc_probe(struct platform_device *pdev)
 			return ret;
 	}
 
-	if (priv->temperature_sensor_calibrated) {
-		indio_dev->channels = meson_sar_adc_and_temp_iio_channels;
-		indio_dev->num_channels =
-			ARRAY_SIZE(meson_sar_adc_and_temp_iio_channels);
-	} else {
-		indio_dev->channels = meson_sar_adc_iio_channels;
-		indio_dev->num_channels =
-			ARRAY_SIZE(meson_sar_adc_iio_channels);
-	}
+	indio_dev->channels = meson_sar_adc_iio_channels;
+	indio_dev->num_channels = ARRAY_SIZE(meson_sar_adc_iio_channels);
+	// last item is temp channel
+	if (!priv->temperature_sensor_calibrated)
+		indio_dev->num_channels--;
 
 	ret = meson_sar_adc_init(indio_dev);
 	if (ret)
-- 
2.38.4

