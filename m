Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE5C86FC86E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 16:03:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235704AbjEIOCW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 10:02:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235729AbjEIOCS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 10:02:18 -0400
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BF0C83;
        Tue,  9 May 2023 07:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1683640930;
  x=1715176930;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HyeQ1SkxMIsCZ+1+CHtohT95Afv+FFaCviNOkxFUrnA=;
  b=arttQ/ka0Bzv3Q/oc0MbEIGaenJM5I8cRwkndLo1wJdCQ9wzNQThykpe
   /R1p5QC0IUzS+JFvVY0XYz9M162jbfbRmGWzJsOg+BBMlRx5khVT13uke
   DmUQAZ5D+Hy3nhBMTK/Lxio+ctFN89ddVUYhfAsxvJhnfDtwBkyhuSUne
   1mB4GtA8LINdMi1lwZ5hcCThIiO71MOPBgxaWo34LFo2dtRa4Fud4rqto
   l1ryQAOVclwrSXdXK9fhy9ZOA03unMy+3uOmUJMv6FdTs5Y6lghgCWpSA
   OWpr4gzNYjvWbzo67w4b2uitFjfqPke/n2R1VXhieCq+WmOydqlY2bn3V
   g==;
From:   Astrid Rost <astrid.rost@axis.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
CC:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel@axis.com>, Astrid Rost <astrid.rost@axis.com>
Subject: [PATCH v2 2/7] iio: light: vcnl4000: Add proximity ps_it for vcnl4200
Date:   Tue, 9 May 2023 16:01:48 +0200
Message-ID: <20230509140153.3279288-3-astrid.rost@axis.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230509140153.3279288-1-astrid.rost@axis.com>
References: <20230509140153.3279288-1-astrid.rost@axis.com>
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
 drivers/iio/light/vcnl4000.c | 52 +++++++++++++++++++++++++++++++-----
 1 file changed, 45 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
index 13568454baff..e14475070ac3 100644
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
@@ -500,6 +509,16 @@ static int vcnl4000_set_pm_runtime_state(struct vcnl4000_data *data, bool on)
 static int vcnl4040_read_ps_it(struct vcnl4000_data *data, int *val, int *val2)
 {
 	int ret;
+	const int(*ps_it_times)[][2];
+	int size;
+
+	if (data->id == VCNL4200) {
+		ps_it_times = &vcnl4200_ps_it_times;
+		size = ARRAY_SIZE(vcnl4200_ps_it_times);
+	} else {
+		ps_it_times = &vcnl4040_ps_it_times;
+		size = ARRAY_SIZE(vcnl4040_ps_it_times);
+	}
 
 	ret = i2c_smbus_read_word_data(data->client, VCNL4200_PS_CONF1);
 	if (ret < 0)
@@ -507,11 +526,11 @@ static int vcnl4040_read_ps_it(struct vcnl4000_data *data, int *val, int *val2)
 
 	ret = FIELD_GET(VCNL4040_PS_CONF2_PS_IT, ret);
 
-	if (ret >= ARRAY_SIZE(vcnl4040_ps_it_times))
+	if (ret >= size)
 		return -EINVAL;
 
-	*val = vcnl4040_ps_it_times[ret][0];
-	*val2 = vcnl4040_ps_it_times[ret][1];
+	*val = (*ps_it_times)[ret][0];
+	*val2 = (*ps_it_times)[ret][1];
 
 	return 0;
 }
@@ -521,9 +540,19 @@ static ssize_t vcnl4040_write_ps_it(struct vcnl4000_data *data, int val)
 	unsigned int i;
 	int ret, index = -1;
 	u16 regval;
+	const int(*ps_it_times)[][2];
+	int size;
 
-	for (i = 0; i < ARRAY_SIZE(vcnl4040_ps_it_times); i++) {
-		if (val == vcnl4040_ps_it_times[i][1]) {
+	if (data->id == VCNL4200) {
+		ps_it_times = &vcnl4200_ps_it_times;
+		size = ARRAY_SIZE(vcnl4200_ps_it_times);
+	} else {
+		ps_it_times = &vcnl4040_ps_it_times;
+		size = ARRAY_SIZE(vcnl4040_ps_it_times);
+	}
+
+	for (i = 0; i < size; i++) {
+		if (val == (*ps_it_times)[i][1]) {
 			index = i;
 			break;
 		}
@@ -532,6 +561,8 @@ static ssize_t vcnl4040_write_ps_it(struct vcnl4000_data *data, int val)
 	if (index < 0)
 		return -EINVAL;
 
+	data->vcnl4200_ps.sampling_rate = ktime_set(0, val * 60000);
+
 	mutex_lock(&data->vcnl4000_lock);
 
 	ret = i2c_smbus_read_word_data(data->client, VCNL4200_PS_CONF1);
@@ -619,11 +650,18 @@ static int vcnl4040_read_avail(struct iio_dev *indio_dev,
 			       const int **vals, int *type, int *length,
 			       long mask)
 {
+	struct vcnl4000_data *data = iio_priv(indio_dev);
+
 	switch (mask) {
 	case IIO_CHAN_INFO_INT_TIME:
-		*vals = (int *)vcnl4040_ps_it_times;
+		if (data->id == VCNL4200) {
+			*vals = (int *)vcnl4200_ps_it_times;
+			*length = 2 * ARRAY_SIZE(vcnl4200_ps_it_times);
+		} else {
+			*vals = (int *)vcnl4040_ps_it_times;
+			*length = 2 * ARRAY_SIZE(vcnl4040_ps_it_times);
+		}
 		*type = IIO_VAL_INT_PLUS_MICRO;
-		*length = 2 * ARRAY_SIZE(vcnl4040_ps_it_times);
 		return IIO_AVAIL_LIST;
 	default:
 		return -EINVAL;
-- 
2.30.2

