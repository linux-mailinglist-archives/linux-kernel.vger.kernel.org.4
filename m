Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B864D73B99E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 16:14:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231522AbjFWOOM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 10:14:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231715AbjFWON7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 10:13:59 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12D752139;
        Fri, 23 Jun 2023 07:13:49 -0700 (PDT)
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35NDXevK001402;
        Fri, 23 Jun 2023 16:13:31 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=TepZ7nQFBI2aQe+ZWfC+VWWrhNbF7JAtvbWR1OD4MEw=;
 b=XSzD767QiA4+XrUM+CeodbLmWZ42xmPDz5NUwXu8OJehCwk1Nh8QTTt2outH5q2jmEYX
 1MGDcX1qiAJjRTigiVvO3FAy3gkiSbQkzi8ekyNwuks3CAwZy0woCzjwZ7X9a7zltc7D
 Fswt38FWScvziU4ne+PSdnEv2kgdhhnqQixf00MDNCtOpApodQeJx0/WHwXKsL81yiCK
 WkyRbjHZ79sJkPFrUoKhqdt5XBe+jcw8Fj1p/S2scvb4ZPcdgbZjLd+PD4yOAyRzOmaN
 P7Wq7gMH01zdndVZm6Rd0K4HVBYKzZEXlsNj2eBt/9yPkgZQYvA2jYkKYpIpVt3MJEIn yw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3rd1t6vbe2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Jun 2023 16:13:31 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 425DB100075;
        Fri, 23 Jun 2023 16:13:31 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 349E122D170;
        Fri, 23 Jun 2023 16:13:31 +0200 (CEST)
Received: from localhost (10.252.5.198) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Fri, 23 Jun
 2023 16:13:30 +0200
From:   Olivier Moysan <olivier.moysan@foss.st.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
CC:     Olivier Moysan <olivier.moysan@foss.st.com>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [RFC PATCH 6/7] iio: adc: stm32-dfsdm: add scaling support to dfsdm
Date:   Fri, 23 Jun 2023 16:09:42 +0200
Message-ID: <20230623140944.2613002-7-olivier.moysan@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230623140944.2613002-1-olivier.moysan@foss.st.com>
References: <20230623140944.2613002-1-olivier.moysan@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.252.5.198]
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-23_08,2023-06-22_02,2023-05-22_02
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add scaling support to STM32 DFSDM.

Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
---
 drivers/iio/adc/sd_adc_modulator.c | 31 ++++++++++++++-
 drivers/iio/adc/stm32-dfsdm-adc.c  | 64 ++++++++++++++++++++++++++++--
 2 files changed, 91 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/sd_adc_modulator.c b/drivers/iio/adc/sd_adc_modulator.c
index 61246a52dc79..749c46da9c72 100644
--- a/drivers/iio/adc/sd_adc_modulator.c
+++ b/drivers/iio/adc/sd_adc_modulator.c
@@ -12,15 +12,23 @@
 #include <linux/module.h>
 #include <linux/mod_devicetable.h>
 #include <linux/platform_device.h>
+#include <linux/regulator/consumer.h>
 
 struct iio_sd_mod_priv {
+	struct regulator *vref;
+	int vref_mv;
 };
 
 static int sd_mod_enable(struct iio_backend *backend)
 {
 	struct iio_sd_mod_priv *priv = backend->priv;
+	int ret;
 
 	/* PM resume */
+	ret = regulator_enable(priv->vref);
+
+	ret = regulator_get_voltage(priv->vref);
+	priv->vref_mv = ret / 1000;
 
 	return 0;
 };
@@ -30,6 +38,7 @@ static int sd_mod_disable(struct iio_backend *backend)
 	struct iio_sd_mod_priv *priv = backend->priv;
 
 	/* PM suspend */
+	regulator_disable(priv->vref);
 
 	return 0;
 };
@@ -39,7 +48,15 @@ static int sd_mod_read(struct iio_backend *backend, int *val, int *val2, long ma
 	struct iio_sd_mod_priv *priv = backend->priv;
 
 	switch (mask) {
-		/* Process channel info */
+	case IIO_CHAN_INFO_SCALE:
+		*val = priv->vref_mv;
+		*val2 = 0;
+		return IIO_VAL_INT;
+
+	case IIO_CHAN_INFO_OFFSET:
+		*val = 0;
+		*val2 = 0;
+		return IIO_VAL_INT;
 	}
 
 	return -EINVAL;
@@ -54,12 +71,24 @@ static const struct iio_backend_ops sd_mod_ops = {
 static int iio_sd_mod_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
+	struct regulator *vref;
 	struct iio_backend *backend;
 	struct iio_sd_mod_priv *priv;
 	int ret;
 
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
 
+	vref = devm_regulator_get_optional(dev, "vref");
+	if (IS_ERR(vref)) {
+		ret = PTR_ERR(vref);
+		if (ret != -ENODEV) {
+			if (ret != -EPROBE_DEFER)
+				dev_err(dev, "vref get failed, %d\n", ret);
+			return ret;
+		}
+	}
+	priv->vref = vref;
+
 	backend = iio_backend_alloc(dev);
 
 	backend->priv = priv;
diff --git a/drivers/iio/adc/stm32-dfsdm-adc.c b/drivers/iio/adc/stm32-dfsdm-adc.c
index 2e76497cee51..468d72ab079d 100644
--- a/drivers/iio/adc/stm32-dfsdm-adc.c
+++ b/drivers/iio/adc/stm32-dfsdm-adc.c
@@ -9,6 +9,7 @@
 #include <linux/dmaengine.h>
 #include <linux/dma-mapping.h>
 #include <linux/iio/adc/stm32-dfsdm-adc.h>
+#include <linux/iio/backend.h>
 #include <linux/iio/buffer.h>
 #include <linux/iio/hw-consumer.h>
 #include <linux/iio/sysfs.h>
@@ -76,6 +77,7 @@ struct stm32_dfsdm_adc {
 
 	/* ADC specific */
 	unsigned int oversamp;
+	struct iio_backend **backend;
 	struct completion completion;
 	u32 *buffer;
 
@@ -599,6 +601,8 @@ static int stm32_dfsdm_channel_parse_of(struct stm32_dfsdm *dfsdm,
 					struct iio_chan_spec *ch)
 {
 	struct stm32_dfsdm_channel *df_ch;
+	struct stm32_dfsdm_adc *adc = iio_priv(indio_dev);
+	struct iio_backend *backend;
 	const char *of_str;
 	int ret, val;
 
@@ -647,6 +651,9 @@ static int stm32_dfsdm_channel_parse_of(struct stm32_dfsdm *dfsdm,
 	if (ret != -EINVAL)
 		df_ch->alt_si = 0;
 
+	backend = iio_backend_get(node->dev);
+	adc->backend[df_ch->id] = backend;
+
 	return 0;
 }
 
@@ -1090,7 +1097,7 @@ static int stm32_dfsdm_single_conv(struct iio_dev *indio_dev,
 {
 	struct stm32_dfsdm_adc *adc = iio_priv(indio_dev);
 	long timeout;
-	int ret;
+	int ret, idx = chan->scan_index;
 
 	reinit_completion(&adc->completion);
 
@@ -1100,6 +1107,8 @@ static int stm32_dfsdm_single_conv(struct iio_dev *indio_dev,
 	if (ret < 0)
 		return ret;
 
+	adc->backend[idx]->ops->enable(adc->backend[idx]);
+
 	ret = regmap_update_bits(adc->dfsdm->regmap, DFSDM_CR2(adc->fl_id),
 				 DFSDM_CR2_REOCIE_MASK, DFSDM_CR2_REOCIE(1));
 	if (ret < 0)
@@ -1133,6 +1142,8 @@ static int stm32_dfsdm_single_conv(struct iio_dev *indio_dev,
 	stm32_dfsdm_process_data(adc, res);
 
 stop_dfsdm:
+	adc->backend[idx]->ops->disable(adc->backend[idx]);
+
 	stm32_dfsdm_stop_dfsdm(adc->dfsdm);
 
 	return ret;
@@ -1197,7 +1208,14 @@ static int stm32_dfsdm_read_raw(struct iio_dev *indio_dev,
 				int *val2, long mask)
 {
 	struct stm32_dfsdm_adc *adc = iio_priv(indio_dev);
-	int ret;
+
+	struct stm32_dfsdm_filter *fl = &adc->dfsdm->fl_list[adc->fl_id];
+	struct stm32_dfsdm_filter_osr *flo = &fl->flo[fl->fast];
+	u32 max = flo->max << (flo->lshift - chan->scan_type.shift);
+	int ret, idx = chan->scan_index;
+
+	if (flo->lshift < chan->scan_type.shift)
+		max = flo->max >> (chan->scan_type.shift - flo->lshift);
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
@@ -1231,6 +1249,41 @@ static int stm32_dfsdm_read_raw(struct iio_dev *indio_dev,
 		*val = adc->sample_freq;
 
 		return IIO_VAL_INT;
+
+	case IIO_CHAN_INFO_SCALE:
+		/*
+		 * Scale is expressed in mV.
+		 * When fast mode is disabled, actual resolution may be lower
+		 * than 2^n, where n=realbits-1.
+		 * This leads to underestimating input voltage. To
+		 * compensate this deviation, the voltage reference can be
+		 * corrected with a factor = realbits resolution / actual max
+		 */
+		adc->backend[idx]->ops->read_raw(adc->backend[idx], val, val2, mask);
+
+		*val = div_u64((u64)*val * (u64)BIT(DFSDM_DATA_RES - 1), max);
+		*val2 = chan->scan_type.realbits;
+		if (chan->differential)
+			*val *= 2;
+		return IIO_VAL_FRACTIONAL_LOG2;
+
+	case IIO_CHAN_INFO_OFFSET:
+		/*
+		 * DFSDM output data are in the range [-2^n,2^n-1],
+		 * with n=realbits-1.
+		 * - Differential modulator:
+		 * Offset correspond to SD modulator offset.
+		 * - Single ended modulator:
+		 * Input is in [0V,Vref] range, where 0V corresponds to -2^n.
+		 * Add 2^n to offset. (i.e. middle of input range)
+		 * offset = offset(sd) * vref / res(sd) * max / vref.
+		 */
+		adc->backend[idx]->ops->read_raw(adc->backend[idx], val, val2, mask);
+
+		*val = div_u64((u64)max * *val, BIT(*val2 - 1));
+		if (chan->differential)
+			*val += max;
+		return IIO_VAL_INT;
 	}
 
 	return -EINVAL;
@@ -1358,7 +1411,10 @@ static int stm32_dfsdm_adc_chan_init_one(struct iio_dev *indio_dev,
 	 * IIO_CHAN_INFO_RAW: used to compute regular conversion
 	 * IIO_CHAN_INFO_OVERSAMPLING_RATIO: used to set oversampling
 	 */
-	ch->info_mask_separate = BIT(IIO_CHAN_INFO_RAW);
+	ch->info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+				 BIT(IIO_CHAN_INFO_SCALE) |
+				 BIT(IIO_CHAN_INFO_OFFSET);
+
 	ch->info_mask_shared_by_all = BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO) |
 					BIT(IIO_CHAN_INFO_SAMP_FREQ);
 
@@ -1454,6 +1510,8 @@ static int stm32_dfsdm_adc_init(struct device *dev, struct iio_dev *indio_dev)
 	if (ret < 0)
 		return ret;
 
+	adc->backend = devm_kzalloc(&indio_dev->dev, sizeof(*adc->backend) * num_ch, GFP_KERNEL);
+
 	indio_dev->num_channels = num_ch;
 	indio_dev->channels = ch;
 
-- 
2.25.1

