Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F71673AE91
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 04:24:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230423AbjFWCYI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 22:24:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230407AbjFWCX6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 22:23:58 -0400
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 164AE2135;
        Thu, 22 Jun 2023 19:23:56 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id 5F7A65FD27;
        Fri, 23 Jun 2023 05:23:54 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1687487034;
        bh=xNSHkYYB8/LbeA0+r7XGd/32WotV9MdYNPXVJkH92yU=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
        b=lfi4idW2RP2iu9BEegqhGovm8etD0Wx6LaaRwxwsBbi63WHmdk/Hx21WZRpymJg/D
         sFtp/N1nu5ICdl/vMcPJcvYZwYMM7Z7oPwOp6IQcro2xUB0GioQNbTarpIUrViOsAa
         KFsLw2A2DxWadmVEPCaQbjDaNpUEUrmmF5LMsoDl6cyT6dZ+HazCUauzyGQ88XEFHD
         Q7GIzC/Z7Tjua3hPpoPMjv3LwPKm9sj3iEWI739VfIzBhPvFrH7OMRKo+yoVizZh98
         o9RwRPNr11i2iX0xxscxtCySVkj8eNhGE6cUtm9vVS+hpvITEKRKXO7v7jUsEpstLv
         u7Z6pqVSnB8UQ==
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
Subject: [PATCH v2 3/6] meson saradc: unite iio channel array definitions
Date:   Fri, 23 Jun 2023 05:20:11 +0300
Message-ID: <20230623022334.791026-4-gnstark@sberdevices.ru>
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

Instead of having several similar channel arrays which are different
only by one item unite the arrays and put the unique item in the end.

Signed-off-by: George Stark <GNStark@sberdevices.ru>
---
 drivers/iio/adc/meson_saradc.c | 31 +++++++------------------------
 1 file changed, 7 insertions(+), 24 deletions(-)

diff --git a/drivers/iio/adc/meson_saradc.c b/drivers/iio/adc/meson_saradc.c
index 6e69b40b3309..ffd4de950a63 100644
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
@@ -234,19 +233,7 @@ static const struct iio_chan_spec meson_sar_adc_iio_channels[] = {
 	MESON_SAR_ADC_CHAN(6),
 	MESON_SAR_ADC_CHAN(7),
 	IIO_CHAN_SOFT_TIMESTAMP(8),
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
+	MESON_SAR_ADC_TEMP_CHAN(), /* must be the last item */
 };
 
 struct meson_sar_adc_param {
@@ -1242,15 +1229,11 @@ static int meson_sar_adc_probe(struct platform_device *pdev)
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
+	/* last item is temp channel */
+	if (!priv->temperature_sensor_calibrated)
+		indio_dev->num_channels--;
 
 	ret = meson_sar_adc_init(indio_dev);
 	if (ret)
-- 
2.38.4

