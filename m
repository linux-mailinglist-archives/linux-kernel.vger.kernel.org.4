Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9395074B467
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 17:33:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232682AbjGGPdn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 11:33:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbjGGPdi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 11:33:38 -0400
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D40DE6E;
        Fri,  7 Jul 2023 08:33:35 -0700 (PDT)
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
        by mx1.sberdevices.ru (Postfix) with ESMTP id C746A120013;
        Fri,  7 Jul 2023 18:33:33 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru C746A120013
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1688744013;
        bh=JSydivd3FU78noI+uH9qQ/p74cncRISu8zSqHemHcXk=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
        b=BJW6yjGM3mqSgeU+EEDM4eu0apnv5NXb2IHQQvPMus408rWdkN/KG8aiL+uIEeVqB
         S+uRkDcgZcaX4xDwgK9U3mRP1uBlzQfwk7di3vJF7oQuQsD7ag48h5p5fWvjy3YtGg
         pSxhrpH7n8qbrR7ap3cB/aLGjmkx832HdNoaKfqDMeoCkwz0FhPv2/hV5fNKaMrID6
         d1De3nF+IytfepSfrzxnHrzTbYwdXN3dff0SjX9IrLWpvWyfjedsh/9RQm6jBhPLyz
         Ifkep7RHgYdnbmgvZljd8erl1G64iijZ2yRb1BDCGhrQy6kl2v55Ufk+fpFMGCG9qy
         5Qc6MCDz2UmPA==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.sberdevices.ru (Postfix) with ESMTPS;
        Fri,  7 Jul 2023 18:33:33 +0300 (MSK)
Received: from localhost.localdomain (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Fri, 7 Jul 2023 18:33:16 +0300
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
Subject: [PATCH v4 6/6] iio: adc: meson: support reading from channel 7 mux inputs
Date:   Fri, 7 Jul 2023 18:27:43 +0300
Message-ID: <20230707153322.114302-7-gnstark@sberdevices.ru>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230707153322.114302-1-gnstark@sberdevices.ru>
References: <20230707153322.114302-1-gnstark@sberdevices.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 178491 [Jul 07 2023]
X-KSMG-AntiSpam-Version: 5.9.59.0
X-KSMG-AntiSpam-Envelope-From: GNStark@sberdevices.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 520 520 ccb018a655251011855942a2571029252d3d69a2, {Tracking_from_domain_doesnt_match_to}, d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;sberdevices.ru:5.0.1,7.1.1;p-i-exch-sc-m01.sberdevices.ru:5.0.1,7.1.1;100.64.160.123:7.1.2, FromAlignment: s, {Tracking_white_helo}, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2023/07/07 03:24:00 #21575635
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

Add iio channel for every channel 7 mux input.
Meson saradc channel 7 is connected to a mux that can switch channel
input to well-known sources like Vdd, GND and several Vdd dividers.

Signed-off-by: George Stark <GNStark@sberdevices.ru>
---
 drivers/iio/adc/meson_saradc.c | 77 +++++++++++++++++++++++++++++++++-
 1 file changed, 75 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/meson_saradc.c b/drivers/iio/adc/meson_saradc.c
index 918bd5da3605..2411cc864ccd 100644
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
@@ -234,6 +248,27 @@ enum meson_sar_adc_channel_index {
 	NUM_CHAN_6,
 	NUM_CHAN_7,
 	NUM_CHAN_TEMP,
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
+	[CHAN7_MUX_VSS] = "gnd",
+	[CHAN7_MUX_VDD_DIV4] = "0.25vdd",
+	[CHAN7_MUX_VDD_DIV2] = "0.5vdd",
+	[CHAN7_MUX_VDD_MUL3_DIV4] = "0.75vdd",
+	[CHAN7_MUX_VDD] = "vdd",
 };
 
 static const struct iio_chan_spec meson_sar_adc_iio_channels[] = {
@@ -245,6 +280,11 @@ static const struct iio_chan_spec meson_sar_adc_iio_channels[] = {
 	MESON_SAR_ADC_CHAN(NUM_CHAN_5),
 	MESON_SAR_ADC_CHAN(NUM_CHAN_6),
 	MESON_SAR_ADC_CHAN(NUM_CHAN_7),
+	MESON_SAR_ADC_MUX(NUM_MUX_0_VSS, 0),
+	MESON_SAR_ADC_MUX(NUM_MUX_1_VDD_DIV4, 1),
+	MESON_SAR_ADC_MUX(NUM_MUX_2_VDD_DIV2, 2),
+	MESON_SAR_ADC_MUX(NUM_MUX_3_VDD_MUL3_DIV4, 3),
+	MESON_SAR_ADC_MUX(NUM_MUX_4_VDD, 4),
 };
 
 static const struct iio_chan_spec meson_sar_adc_and_temp_iio_channels[] = {
@@ -257,6 +297,11 @@ static const struct iio_chan_spec meson_sar_adc_and_temp_iio_channels[] = {
 	MESON_SAR_ADC_CHAN(NUM_CHAN_6),
 	MESON_SAR_ADC_CHAN(NUM_CHAN_7),
 	MESON_SAR_ADC_TEMP_CHAN(NUM_CHAN_TEMP),
+	MESON_SAR_ADC_MUX(NUM_MUX_0_VSS, 0),
+	MESON_SAR_ADC_MUX(NUM_MUX_1_VDD_DIV4, 1),
+	MESON_SAR_ADC_MUX(NUM_MUX_2_VDD_DIV2, 2),
+	MESON_SAR_ADC_MUX(NUM_MUX_3_VDD_MUL3_DIV4, 3),
+	MESON_SAR_ADC_MUX(NUM_MUX_4_VDD, 4),
 };
 
 struct meson_sar_adc_param {
@@ -295,6 +340,7 @@ struct meson_sar_adc_priv {
 	bool					temperature_sensor_calibrated;
 	u8					temperature_sensor_coefficient;
 	u16					temperature_sensor_adc_val;
+	enum meson_sar_adc_chan7_mux_sel	chan7_mux_sel;
 };
 
 static const struct regmap_config meson_sar_adc_regmap_config_gxbb = {
@@ -311,6 +357,17 @@ static const struct regmap_config meson_sar_adc_regmap_config_meson8 = {
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
@@ -359,6 +416,8 @@ static void meson_sar_adc_set_chan7_mux(struct iio_dev *indio_dev,
 			   MESON_SAR_ADC_REG3_CTRL_CHAN7_MUX_SEL_MASK, regval);
 
 	usleep_range(10, 20);
+
+	priv->chan7_mux_sel = sel;
 }
 
 static int meson_sar_adc_read_raw_sample(struct iio_dev *indio_dev,
@@ -454,6 +513,15 @@ static void meson_sar_adc_enable_channel(struct iio_dev *indio_dev,
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
 
@@ -1026,7 +1094,8 @@ static int meson_sar_adc_calib(struct iio_dev *indio_dev)
 	meson_sar_adc_set_chan7_mux(indio_dev, CHAN7_MUX_VDD_DIV4);
 	usleep_range(10, 20);
 	ret = meson_sar_adc_get_sample(indio_dev,
-				       &indio_dev->channels[7],
+				       find_channel_by_num(indio_dev,
+							   NUM_MUX_1_VDD_DIV4),
 				       MEAN_AVERAGING, EIGHT_SAMPLES, &value0);
 	if (ret < 0)
 		goto out;
@@ -1034,7 +1103,8 @@ static int meson_sar_adc_calib(struct iio_dev *indio_dev)
 	meson_sar_adc_set_chan7_mux(indio_dev, CHAN7_MUX_VDD_MUL3_DIV4);
 	usleep_range(10, 20);
 	ret = meson_sar_adc_get_sample(indio_dev,
-				       &indio_dev->channels[7],
+				       find_channel_by_num(indio_dev,
+							   NUM_MUX_3_VDD_MUL3_DIV4),
 				       MEAN_AVERAGING, EIGHT_SAMPLES, &value1);
 	if (ret < 0)
 		goto out;
@@ -1061,6 +1131,9 @@ static int read_label(struct iio_dev *indio_dev,
 {
 	if (chan->type == IIO_TEMP)
 		return sprintf(label, "temp-sensor\n");
+	if (chan->type == IIO_VOLTAGE && chan->channel >= NUM_MUX_0_VSS)
+		return sprintf(label, "%s\n",
+			       chan7_mux_names[chan->channel - NUM_MUX_0_VSS]);
 	if (chan->type == IIO_VOLTAGE)
 		return sprintf(label, "channel-%d\n", chan->channel);
 	return 0;
-- 
2.38.4

