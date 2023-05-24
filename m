Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEB1070E9EC
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 02:02:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238916AbjEXAB7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 20:01:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238567AbjEXAB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 20:01:57 -0400
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A99BC1A4;
        Tue, 23 May 2023 17:01:41 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id 6B18B5FD03;
        Wed, 24 May 2023 03:01:39 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1684886499;
        bh=axVJ7641uXabYayO/3wTwP3lkBTzWLtoTnUTKuJMnlU=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
        b=N6Dn84VO8YczLUkTXu1/6KwcMcOKfsCHELP7x2SJ4mj8q9TdMGlZEIraS3Mi4DHzB
         2Zp4RAVgmCp/ZFW4MaBjMvD3k7PseFKJMtsJXxQdJUBkcutFURW64Fi3uxWqKQUWOS
         EGWjnerpyp2Od6HiiriocffF3q0chriYYjDKgIvwOLl//DaA+/JO+oB5D0noGvYUfy
         4xTT1V28WmZ6YIwo8GZ/K/W5EqOSUcj7z4PfHbiwrcEBDIYD2dIvMfYHiRD3ickzIt
         PvSobGwPaaxhEbKm8VBkV3CaAaAPpxo2FR/lYMdjxBg72sFgoCtWpaTyP8AgZhgFrH
         +EB2MFhAkG8eQ==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Wed, 24 May 2023 03:01:36 +0300 (MSK)
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
Subject: [PATCH v1] meson saradc: add iio device attrib to switch channel 7 mux
Date:   Wed, 24 May 2023 03:01:11 +0300
Message-ID: <20230524000111.14370-1-gnstark@sberdevices.ru>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.16.1.6]
X-ClientProxiedBy: S-MS-EXCH02.sberdevices.ru (172.16.1.5) To
 S-MS-EXCH01.sberdevices.ru (172.16.1.4)
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2023/05/23 21:43:00 #21378639
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

Patch adds two sysfs nodes: chan7_mux to set mux state
and chan7_mux_available to show available mux states.
Mux can be used to debug and calibrate adc by
switching and measuring well-known inputs like gnd, vdd etc.

Signed-off-by: George Stark <GNStark@sberdevices.ru>
---
 drivers/iio/adc/meson_saradc.c | 66 ++++++++++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/drivers/iio/adc/meson_saradc.c b/drivers/iio/adc/meson_saradc.c
index e05e51900c35..77ef2b55f6f4 100644
--- a/drivers/iio/adc/meson_saradc.c
+++ b/drivers/iio/adc/meson_saradc.c
@@ -11,6 +11,7 @@
 #include <linux/delay.h>
 #include <linux/io.h>
 #include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/nvmem-consumer.h>
@@ -320,6 +321,7 @@ struct meson_sar_adc_priv {
 	bool					temperature_sensor_calibrated;
 	u8					temperature_sensor_coefficient;
 	u16					temperature_sensor_adc_val;
+	u8					chan7_mux_sel;
 };
 
 static const struct regmap_config meson_sar_adc_regmap_config_gxbb = {
@@ -483,6 +485,7 @@ static void meson_sar_adc_set_chan7_mux(struct iio_dev *indio_dev,
 	regmap_update_bits(priv->regmap, MESON_SAR_ADC_REG3,
 			   MESON_SAR_ADC_REG3_CTRL_CHAN7_MUX_SEL_MASK, regval);
 
+	priv->chan7_mux_sel = sel;
 	usleep_range(10, 20);
 }
 
@@ -1130,8 +1133,71 @@ static int meson_sar_adc_calib(struct iio_dev *indio_dev)
 	return ret;
 }
 
+static const char * const chan7_vol[] = {
+	"gnd",
+	"vdd/4",
+	"vdd/2",
+	"vdd*3/4",
+	"vdd",
+	"ch7_input",
+};
+
+static ssize_t chan7_mux_show(struct device *dev, struct device_attribute *attr,
+			      char *buf)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct meson_sar_adc_priv *priv = iio_priv(indio_dev);
+	unsigned int index = priv->chan7_mux_sel;
+
+	if (index >= ARRAY_SIZE(chan7_vol))
+		index = ARRAY_SIZE(chan7_vol) - 1;
+
+	return sysfs_emit(buf, "%s\n", chan7_vol[index]);
+}
+
+static ssize_t chan7_mux_store(struct device *dev,
+			       struct device_attribute *attr,
+			       const char *buf, size_t count)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(chan7_vol); i++)
+		if (!strcmp(chan7_vol[i], buf)) {
+			meson_sar_adc_set_chan7_mux(indio_dev, i);
+			return count;
+		}
+
+	return -EINVAL;
+}
+
+static ssize_t chan7_mux_available_show(struct device *dev, struct device_attribute *attr,
+			      char *buf)
+{
+	int i, len = 0;
+
+	for (i = 0; i < ARRAY_SIZE(chan7_vol); i++)
+		len += sysfs_emit_at(buf, len, "%s ", chan7_vol[i]);
+
+	return len;
+}
+
+static IIO_DEVICE_ATTR_RW(chan7_mux, -1);
+static IIO_DEVICE_ATTR_RO(chan7_mux_available, -1);
+
+static struct attribute *meson_sar_adc_attrs[] = {
+	&iio_dev_attr_chan7_mux_available.dev_attr.attr,
+	&iio_dev_attr_chan7_mux.dev_attr.attr,
+	NULL,
+};
+
+static const struct attribute_group meson_sar_adc_attr_group = {
+	.attrs = meson_sar_adc_attrs,
+};
+
 static const struct iio_info meson_sar_adc_iio_info = {
 	.read_raw = meson_sar_adc_iio_info_read_raw,
+	.attrs = &meson_sar_adc_attr_group,
 };
 
 static const struct meson_sar_adc_param meson_sar_adc_meson8_param = {
-- 
2.38.4

