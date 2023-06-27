Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 769557406D0
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 01:19:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229985AbjF0XTX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 19:19:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbjF0XTJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 19:19:09 -0400
X-Greylist: delayed 1199 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 27 Jun 2023 16:19:06 PDT
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E564F1FDC
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 16:19:06 -0700 (PDT)
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
        by mx1.sberdevices.ru (Postfix) with ESMTP id 83EED120009;
        Wed, 28 Jun 2023 01:40:35 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 83EED120009
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1687905635;
        bh=/nXs1QTCOgVuqC90/F/82Lr9gLgnyYrcMrhAe+Ak+A8=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
        b=II6D6D8yALXlZYhyx2StOS0NnI7U6YQxYaoLr7frfYHzAeY4Bu1sxiCz7IFpUdcE1
         IVHyS2zfiOCQ8FTFSrwbJXYeS1SIvYyTYZ9krw4UGFhHcp1Z+rGu1PethwaNKc/y1g
         8AuW2ns+DsMghnrkpW7nfep8d+6mm0I0ok37XbVNay1XqnZvTz65/eOlAb1ABISGwf
         Ixi4mFEMb4z+7+gGY65TpmfxHTOOIMslhu8vDp198WcOG8Os3qE5929yDWzduLw/4r
         ZhTkboMjsUsl06t/Yn0gez87vQ9Eukx+Z8KnkUla3noCEf6txF11uH8hTZHRw9F1Sx
         YnNVUnjs4FdEg==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.sberdevices.ru (Postfix) with ESMTPS;
        Wed, 28 Jun 2023 01:40:34 +0300 (MSK)
Received: from localhost.localdomain (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Wed, 28 Jun 2023 01:39:35 +0300
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
Subject: [PATCH v3 5/5] meson saradc: support reading from channel 7 mux inputs
Date:   Wed, 28 Jun 2023 01:37:18 +0300
Message-ID: <20230627224017.1724097-6-gnstark@sberdevices.ru>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230627224017.1724097-1-gnstark@sberdevices.ru>
References: <20230627224017.1724097-1-gnstark@sberdevices.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 178297 [Jun 27 2023]
X-KSMG-AntiSpam-Version: 5.9.59.0
X-KSMG-AntiSpam-Envelope-From: GNStark@sberdevices.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 517 517 b0056c19d8e10afbb16cb7aad7258dedb0179a79, {Tracking_from_domain_doesnt_match_to}, p-i-exch-sc-m01.sberdevices.ru:7.1.1,5.0.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;sberdevices.ru:7.1.1,5.0.1, FromAlignment: s, {Tracking_white_helo}, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2023/06/27 18:27:00 #21588965
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add iio channel for every channel 7 mux input.
Meson saradc channel 7 is connected to a mux that can switch channel
input to well-known sources like Vdd, GND and several Vdd dividers.

Signed-off-by: George Stark <GNStark@sberdevices.ru>
---
 drivers/iio/adc/meson_saradc.c | 83 ++++++++++++++++++++++++++++++++--
 1 file changed, 79 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/meson_saradc.c b/drivers/iio/adc/meson_saradc.c
index 4a9dacedb6c3..c99a55944ece 100644
--- a/drivers/iio/adc/meson_saradc.c
+++ b/drivers/iio/adc/meson_saradc.c
@@ -163,6 +163,7 @@
 #define MESON_SAR_ADC_MAX_FIFO_SIZE				32
 #define MESON_SAR_ADC_TIMEOUT					100 /* ms */
 #define MESON_SAR_ADC_VOLTAGE_AND_TEMP_CHANNEL			6
+#define MESON_SAR_ADC_VOLTAGE_AND_MUX_CHANNEL			7
 #define MESON_SAR_ADC_TEMP_OFFSET				27
 
 /* temperature sensor calibration information in eFuse */
@@ -202,6 +203,19 @@
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
@@ -235,6 +249,27 @@ enum meson_sar_adc_channel_index {
 	NUM_CHAN_7,
 	NUM_CHAN_TEMP,
 	NUM_CHAN_SOFT_TIMESTAMP,
+	NUM_MUX_0_VSS,
+	NUM_MUX_1_VDD_DIV4,
+	NUM_MUX_2_VDD_DIV2,
+	NUM_MUX_3_VDD_MUL3_DIV4,
+	NUM_MUX_4_VDD,
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
@@ -247,6 +282,11 @@ static const struct iio_chan_spec meson_sar_adc_iio_channels[] = {
 	MESON_SAR_ADC_CHAN(NUM_CHAN_6),
 	MESON_SAR_ADC_CHAN(NUM_CHAN_7),
 	IIO_CHAN_SOFT_TIMESTAMP(NUM_CHAN_SOFT_TIMESTAMP),
+	MESON_SAR_ADC_MUX(NUM_MUX_0_VSS, 0),
+	MESON_SAR_ADC_MUX(NUM_MUX_1_VDD_DIV4, 1),
+	MESON_SAR_ADC_MUX(NUM_MUX_2_VDD_DIV2, 2),
+	MESON_SAR_ADC_MUX(NUM_MUX_3_VDD_MUL3_DIV4, 3),
+	MESON_SAR_ADC_MUX(NUM_MUX_4_VDD, 4),
 };
 
 static const struct iio_chan_spec meson_sar_adc_and_temp_iio_channels[] = {
@@ -260,6 +300,11 @@ static const struct iio_chan_spec meson_sar_adc_and_temp_iio_channels[] = {
 	MESON_SAR_ADC_CHAN(NUM_CHAN_7),
 	MESON_SAR_ADC_TEMP_CHAN(NUM_CHAN_TEMP),
 	IIO_CHAN_SOFT_TIMESTAMP(NUM_CHAN_SOFT_TIMESTAMP),
+	MESON_SAR_ADC_MUX(NUM_MUX_0_VSS, 0),
+	MESON_SAR_ADC_MUX(NUM_MUX_1_VDD_DIV4, 1),
+	MESON_SAR_ADC_MUX(NUM_MUX_2_VDD_DIV2, 2),
+	MESON_SAR_ADC_MUX(NUM_MUX_3_VDD_MUL3_DIV4, 3),
+	MESON_SAR_ADC_MUX(NUM_MUX_4_VDD, 4),
 };
 
 struct meson_sar_adc_param {
@@ -298,6 +343,7 @@ struct meson_sar_adc_priv {
 	bool					temperature_sensor_calibrated;
 	u8					temperature_sensor_coefficient;
 	u16					temperature_sensor_adc_val;
+	enum meson_sar_adc_chan7_mux_sel	chan7_mux_sel;
 };
 
 static const struct regmap_config meson_sar_adc_regmap_config_gxbb = {
@@ -314,6 +360,17 @@ static const struct regmap_config meson_sar_adc_regmap_config_meson8 = {
 	.max_register = MESON_SAR_ADC_DELTA_10,
 };
 
+static const struct iio_chan_spec *
+find_channel_by_num(struct iio_dev *indio_dev, int num)
+{
+	int i;
+
+	for (i = 0; i < indio_dev->num_channels; i++)
+		if (indio_dev->channels[i].channel == num)
+			return &indio_dev->channels[i];
+	return NULL;
+}
+
 static unsigned int meson_sar_adc_get_fifo_count(struct iio_dev *indio_dev)
 {
 	struct meson_sar_adc_priv *priv = iio_priv(indio_dev);
@@ -362,6 +419,8 @@ static void meson_sar_adc_set_chan7_mux(struct iio_dev *indio_dev,
 			   MESON_SAR_ADC_REG3_CTRL_CHAN7_MUX_SEL_MASK, regval);
 
 	usleep_range(10, 20);
+
+	priv->chan7_mux_sel = sel;
 }
 
 static int meson_sar_adc_read_raw_sample(struct iio_dev *indio_dev,
@@ -457,6 +516,15 @@ static void meson_sar_adc_enable_channel(struct iio_dev *indio_dev,
 		regmap_update_bits(priv->regmap,
 				   MESON_SAR_ADC_DELTA_10,
 				   MESON_SAR_ADC_DELTA_10_TEMP_SEL, regval);
+	} else if (chan->address == MESON_SAR_ADC_VOLTAGE_AND_MUX_CHANNEL) {
+		enum meson_sar_adc_chan7_mux_sel sel;
+
+		if (chan->channel == NUM_CHAN_7)
+			sel = CHAN7_MUX_CH7_INPUT;
+		else
+			sel = chan7_mux_values[chan->channel - NUM_MUX_0_VSS];
+		if (sel != priv->chan7_mux_sel)
+			meson_sar_adc_set_chan7_mux(indio_dev, sel);
 	}
 }
 
@@ -1029,7 +1097,8 @@ static int meson_sar_adc_calib(struct iio_dev *indio_dev)
 	meson_sar_adc_set_chan7_mux(indio_dev, CHAN7_MUX_VDD_DIV4);
 	usleep_range(10, 20);
 	ret = meson_sar_adc_get_sample(indio_dev,
-				       &indio_dev->channels[7],
+				       find_channel_by_num(indio_dev,
+							   NUM_MUX_1_VDD_DIV4),
 				       MEAN_AVERAGING, EIGHT_SAMPLES, &value0);
 	if (ret < 0)
 		goto out;
@@ -1037,7 +1106,8 @@ static int meson_sar_adc_calib(struct iio_dev *indio_dev)
 	meson_sar_adc_set_chan7_mux(indio_dev, CHAN7_MUX_VDD_MUL3_DIV4);
 	usleep_range(10, 20);
 	ret = meson_sar_adc_get_sample(indio_dev,
-				       &indio_dev->channels[7],
+				       find_channel_by_num(indio_dev,
+							   NUM_MUX_3_VDD_MUL3_DIV4),
 				       MEAN_AVERAGING, EIGHT_SAMPLES, &value1);
 	if (ret < 0)
 		goto out;
@@ -1064,8 +1134,13 @@ static int read_label(struct iio_dev *indio_dev,
 {
 	if (chan->type == IIO_TEMP)
 		return sprintf(label, "%s\n", "temp-sensor");
-	if (chan->type == IIO_VOLTAGE)
-		return sprintf(label, "channel-%d\n", chan->channel);
+	if (chan->type == IIO_VOLTAGE) {
+		if (chan->channel <= NUM_CHAN_7)
+			return sprintf(label, "channel-%d\n", chan->channel);
+		if (chan->channel >= NUM_MUX_0_VSS)
+			return sprintf(label, "%s\n",
+				chan7_mux_names[chan->channel - NUM_MUX_0_VSS]);
+	}
 	return 0;
 }
 
-- 
2.38.4

