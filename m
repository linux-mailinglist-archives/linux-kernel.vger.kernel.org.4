Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B83F8706C65
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 17:14:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231899AbjEQPO0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 11:14:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230207AbjEQPOS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 11:14:18 -0400
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3440CA;
        Wed, 17 May 2023 08:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1684336458;
  x=1715872458;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3k4Tx4Lzm0vQpwHKjcS+BjHANHrTLb+VPfGE5Kb/GNI=;
  b=SLn8XyUeLt5drtHI6fYVr1zDIVlwN9ouTTznHl0UgeUCvTBv8bh0Q9bx
   K5v+TjcUhkqrFYlLP/ZrUjvxgmb6CGkWQYf7HySaxcGvUL1UNoRI0YiTg
   90ayZ5dCKU0kxvFwief2V6bAF/WV8W3e6r2PZy6yqYwoPBHfCTfdPH86r
   X861nk39pVjYxqi7vtXxMgEoF+cSlEly4hf4Xb7U0HIcjoevag/kfasW/
   D+ZWIe7oDdnCvi49UnojVN8Y57B1JLAxgxWsNrWnkAjtEREu+cdx5Mdyx
   I87z7jSp3PJCtli+dTOg5ItsrlQ2L+dDXnvMiIYqXKzwhrXHHzigluieF
   A==;
From:   Astrid Rost <astrid.rost@axis.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
CC:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel@axis.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Mathieu Othacehe <m.othacehe@gmail.com>,
        Astrid Rost <astrid.rost@axis.com>
Subject: [PATCH v3 2/7] iio: light: vcnl4000: Add proximity ps_it for vcnl4200
Date:   Wed, 17 May 2023 17:14:01 +0200
Message-ID: <20230517151406.368219-3-astrid.rost@axis.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230517151406.368219-1-astrid.rost@axis.com>
References: <20230517151406.368219-1-astrid.rost@axis.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add ps_it attributes for vcnl4200 (similar to vcnl4040).
Add read/write attribute for proximity integration time.
Read attribute for available proximity integration times.
Change sampling rate depending on integration time.

Signed-off-by: Astrid Rost <astrid.rost@axis.com>
---
 drivers/iio/light/vcnl4000.c | 34 +++++++++++++++++++++++++++-------
 1 file changed, 27 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
index 565b9c9ea470..ba558606d74b 100644
--- a/drivers/iio/light/vcnl4000.c
+++ b/drivers/iio/light/vcnl4000.c
@@ -124,6 +124,15 @@ static const int vcnl4040_ps_it_times[][2] = {
 	{0, 800},
 };
 
+static const int vcnl4200_ps_it_times[][2] = {
+	{0, 96},
+	{0, 144},
+	{0, 192},
+	{0, 384},
+	{0, 768},
+	{0, 864},
+};
+
 #define VCNL4000_SLEEP_DELAY_MS	2000 /* before we enter pm_runtime_suspend */
 
 enum vcnl4000_device_ids {
@@ -166,6 +175,8 @@ struct vcnl4000_chip_spec {
 	irqreturn_t (*irq_thread)(int irq, void *priv);
 	irqreturn_t (*trig_buffer_func)(int irq, void *priv);
 	u8 int_reg;
+	const int(*ps_it_times)[][2];
+	const int num_ps_it_times;
 };
 
 static const struct i2c_device_id vcnl4000_id[] = {
@@ -508,11 +519,11 @@ static int vcnl4040_read_ps_it(struct vcnl4000_data *data, int *val, int *val2)
 
 	ret = FIELD_GET(VCNL4040_PS_CONF2_PS_IT, ret);
 
-	if (ret >= ARRAY_SIZE(vcnl4040_ps_it_times))
+	if (ret >= data->chip_spec->num_ps_it_times)
 		return -EINVAL;
 
-	*val = vcnl4040_ps_it_times[ret][0];
-	*val2 = vcnl4040_ps_it_times[ret][1];
+	*val = (*data->chip_spec->ps_it_times)[ret][0];
+	*val2 = (*data->chip_spec->ps_it_times)[ret][1];
 
 	return 0;
 }
@@ -523,8 +534,9 @@ static ssize_t vcnl4040_write_ps_it(struct vcnl4000_data *data, int val)
 	int ret, index = -1;
 	u16 regval;
 
-	for (i = 0; i < ARRAY_SIZE(vcnl4040_ps_it_times); i++) {
-		if (val == vcnl4040_ps_it_times[i][1]) {
+
+	for (i = 0; i < data->chip_spec->num_ps_it_times; i++) {
+		if (val == (*data->chip_spec->ps_it_times)[i][1]) {
 			index = i;
 			break;
 		}
@@ -533,6 +545,8 @@ static ssize_t vcnl4040_write_ps_it(struct vcnl4000_data *data, int val)
 	if (index < 0)
 		return -EINVAL;
 
+	data->vcnl4200_ps.sampling_rate = ktime_set(0, val * 60000);
+
 	mutex_lock(&data->vcnl4000_lock);
 
 	ret = i2c_smbus_read_word_data(data->client, VCNL4200_PS_CONF1);
@@ -620,11 +634,13 @@ static int vcnl4040_read_avail(struct iio_dev *indio_dev,
 			       const int **vals, int *type, int *length,
 			       long mask)
 {
+	struct vcnl4000_data *data = iio_priv(indio_dev);
+
 	switch (mask) {
 	case IIO_CHAN_INFO_INT_TIME:
-		*vals = (int *)vcnl4040_ps_it_times;
+		*vals = (int *)(*data->chip_spec->ps_it_times);
 		*type = IIO_VAL_INT_PLUS_MICRO;
-		*length = 2 * ARRAY_SIZE(vcnl4040_ps_it_times);
+		*length = 2 * data->chip_spec->num_ps_it_times;
 		return IIO_AVAIL_LIST;
 	default:
 		return -EINVAL;
@@ -1317,6 +1333,8 @@ static const struct vcnl4000_chip_spec vcnl4000_chip_spec_cfg[] = {
 		.info = &vcnl4040_info,
 		.irq_thread = vcnl4040_irq_thread,
 		.int_reg = VCNL4040_INT_FLAGS,
+		.ps_it_times = &vcnl4040_ps_it_times,
+		.num_ps_it_times = ARRAY_SIZE(vcnl4040_ps_it_times),
 	},
 	[VCNL4200] = {
 		.prod = "VCNL4200",
@@ -1329,6 +1347,8 @@ static const struct vcnl4000_chip_spec vcnl4000_chip_spec_cfg[] = {
 		.info = &vcnl4040_info,
 		.irq_thread = vcnl4040_irq_thread,
 		.int_reg = VCNL4200_INT_FLAGS,
+		.ps_it_times = &vcnl4200_ps_it_times,
+		.num_ps_it_times = ARRAY_SIZE(vcnl4200_ps_it_times),
 	},
 };
 
-- 
2.30.2

