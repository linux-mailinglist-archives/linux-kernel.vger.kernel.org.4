Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3792573AE87
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 04:24:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230512AbjFWCX7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 22:23:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbjFWCX6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 22:23:58 -0400
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CAC72134;
        Thu, 22 Jun 2023 19:23:55 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id D03AE5FD26;
        Fri, 23 Jun 2023 05:23:53 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1687487033;
        bh=rc3qX8KRQTMzSGALx1FQDUphrLTDt4aHKYVi/7eAovo=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
        b=qKuCdlW3r6B6aRyuTHJYiu/Xm+Sn9B+bM/zMkqA9X1KQcfG1oawH6mWNcJNTYJqOZ
         tLVZJqoYy7eznJkWaHbBc2yqVKoaBS5eXB2RII+Cnb8/I71IFf0/+VBbsXxGwgXJEt
         OzVBoYJfqFc9rZYAGYcMwxCnnN9wZVbmtNYhrDDynx8DZMAnTc7dceiHyV5BNs8VS6
         fT4yaD+E5VqJEjnby3f535trLC6AhfGYFZuky/3qkCD+0sQDXV8e7j0JOb08cbdfBc
         Z7ZyEy6qQxot1b47qOiuynxfy61G5dNNFrdKyRAWf1Ad8Gt0d+YMDIktlm6DtZcdL4
         tjo2rkzp+BUFQ==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Fri, 23 Jun 2023 05:23:53 +0300 (MSK)
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
Subject: [PATCH v2 2/6] meson saradc: move meson_sar_adc_set_chan7_mux routine upper
Date:   Fri, 23 Jun 2023 05:20:10 +0300
Message-ID: <20230623022334.791026-3-gnstark@sberdevices.ru>
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

Move meson_sar_adc_set_chan7_mux routine upper.

Signed-off-by: George Stark <GNStark@sberdevices.ru>
---
 drivers/iio/adc/meson_saradc.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/iio/adc/meson_saradc.c b/drivers/iio/adc/meson_saradc.c
index af38d95bd504..6e69b40b3309 100644
--- a/drivers/iio/adc/meson_saradc.c
+++ b/drivers/iio/adc/meson_saradc.c
@@ -338,6 +338,19 @@ static int meson_sar_adc_wait_busy_clear(struct iio_dev *indio_dev)
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
@@ -434,19 +447,6 @@ static void meson_sar_adc_enable_channel(struct iio_dev *indio_dev,
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
-- 
2.38.4

