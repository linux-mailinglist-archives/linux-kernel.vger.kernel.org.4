Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46DEE73AE90
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 04:24:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231228AbjFWCYG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 22:24:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230423AbjFWCX6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 22:23:58 -0400
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 394BE2136;
        Thu, 22 Jun 2023 19:23:56 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id 81B195FD28;
        Fri, 23 Jun 2023 05:23:54 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1687487034;
        bh=xJtb2PxI0po9bYawG64NHJS7+zf3ZJH0TBfB5YdKzHY=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
        b=bRX+++1zU1HV0IKkDfv0xOuRU+k1BLIBZe+MGgmJ+N/JDnCju1VqjIBgTMULDJmFU
         8mBlLVrl8ZaOMIgDjBT0LX1YyFPllOqcIch3Ms5MqCVTWAVquKk1HeTFMpj8/dRPBS
         JH23tbqSBVSBWsu+39m404IllChX1E8fnfmDwqPq8e2t8pK4Frf9c46XVHC0zUPNrs
         ZnUed4CBwvaKITRjhjA2RwOLWqxmksCf2CuBLa+uNFRYN5rqGQJaVli2gOzWSbFtMN
         5kku/rKn/WTzGBq5wa6XC3LP4USU/wfR/7wiRu+AkUXo+UBEniQg021JYTIKgVmPo9
         2TTDL0Ln/wCPA==
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
Subject: [PATCH v2 4/6] meson saradc: add enum for iio channel array indexes
Date:   Fri, 23 Jun 2023 05:20:12 +0300
Message-ID: <20230623022334.791026-5-gnstark@sberdevices.ru>
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

Add enum for iio channel array indexes.

Signed-off-by: George Stark <GNStark@sberdevices.ru>
---
 drivers/iio/adc/meson_saradc.c | 34 +++++++++++++++++++++++-----------
 1 file changed, 23 insertions(+), 11 deletions(-)

diff --git a/drivers/iio/adc/meson_saradc.c b/drivers/iio/adc/meson_saradc.c
index ffd4de950a63..7ef006650982 100644
--- a/drivers/iio/adc/meson_saradc.c
+++ b/drivers/iio/adc/meson_saradc.c
@@ -223,16 +223,28 @@ enum meson_sar_adc_chan7_mux_sel {
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
 static const struct iio_chan_spec meson_sar_adc_iio_channels[] = {
-	MESON_SAR_ADC_CHAN(0),
-	MESON_SAR_ADC_CHAN(1),
-	MESON_SAR_ADC_CHAN(2),
-	MESON_SAR_ADC_CHAN(3),
-	MESON_SAR_ADC_CHAN(4),
-	MESON_SAR_ADC_CHAN(5),
-	MESON_SAR_ADC_CHAN(6),
-	MESON_SAR_ADC_CHAN(7),
-	IIO_CHAN_SOFT_TIMESTAMP(8),
+	MESON_SAR_ADC_CHAN(INDEX_CHAN_0),
+	MESON_SAR_ADC_CHAN(INDEX_CHAN_1),
+	MESON_SAR_ADC_CHAN(INDEX_CHAN_2),
+	MESON_SAR_ADC_CHAN(INDEX_CHAN_3),
+	MESON_SAR_ADC_CHAN(INDEX_CHAN_4),
+	MESON_SAR_ADC_CHAN(INDEX_CHAN_5),
+	MESON_SAR_ADC_CHAN(INDEX_CHAN_6),
+	MESON_SAR_ADC_CHAN(INDEX_CHAN_7),
+	IIO_CHAN_SOFT_TIMESTAMP(INDEX_CHAN_SOFT_TIMESTAMP),
 	MESON_SAR_ADC_TEMP_CHAN(), /* must be the last item */
 };
 
@@ -1003,7 +1015,7 @@ static int meson_sar_adc_calib(struct iio_dev *indio_dev)
 	meson_sar_adc_set_chan7_mux(indio_dev, CHAN7_MUX_VDD_DIV4);
 	usleep_range(10, 20);
 	ret = meson_sar_adc_get_sample(indio_dev,
-				       &indio_dev->channels[7],
+				       &indio_dev->channels[INDEX_CHAN_7],
 				       MEAN_AVERAGING, EIGHT_SAMPLES, &value0);
 	if (ret < 0)
 		goto out;
@@ -1011,7 +1023,7 @@ static int meson_sar_adc_calib(struct iio_dev *indio_dev)
 	meson_sar_adc_set_chan7_mux(indio_dev, CHAN7_MUX_VDD_MUL3_DIV4);
 	usleep_range(10, 20);
 	ret = meson_sar_adc_get_sample(indio_dev,
-				       &indio_dev->channels[7],
+				       &indio_dev->channels[INDEX_CHAN_7],
 				       MEAN_AVERAGING, EIGHT_SAMPLES, &value1);
 	if (ret < 0)
 		goto out;
-- 
2.38.4

