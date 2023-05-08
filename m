Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABB976FA0AA
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 09:10:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233330AbjEHHKZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 03:10:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233450AbjEHHJ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 03:09:59 -0400
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 925831E9A2;
        Mon,  8 May 2023 00:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1683529781;
  x=1715065781;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HyeQ1SkxMIsCZ+1+CHtohT95Afv+FFaCviNOkxFUrnA=;
  b=eMs2+QQHDJhPUJvKf+2rsrBURqZVOM6MGZUn1jSoCw6So2wt2O9QSyz0
   mg9NZh/vFID3hNuSUK5nZwQ8rXJgpbGceSb9M61AMl9BMfLA4KTI6JF9P
   PgntJBhHaaO5DEf+Mphs7b0nC4VqDu5T3WqSJrfk+Nw1tf7n2DgIgBSTs
   u9u4E25iPLDRohOtYAeBuDYIpG8ZA+7+Tg9/Trhxm/5+vtD3C+y9ZPkDt
   FrrJFkI9EMraN4yf9RcShTN3idfE/xqjytFFjbblCNyiPAsA5SPc7yeYq
   eOvl3p2sUBCDCzpi0H/dmkKtktjZ0ph6xd+PftQ+rSusKlEyfRUX8yaai
   g==;
From:   Astrid Rost <astrid.rost@axis.com>
To:     Jonathan Cameron <jic23@kernel.org>
CC:     <kernel@axis.com>, Astrid Rost <astridr@axis.com>,
        Astrid Rost <astrid.rost@axis.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 2/7] iio: light: vcnl4000: Add proximity ps_it for vcnl4200
Date:   Mon, 8 May 2023 09:09:20 +0200
Message-ID: <20230508070925.2123265-3-astrid.rost@axis.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230508070925.2123265-1-astrid.rost@axis.com>
References: <20230508070925.2123265-1-astrid.rost@axis.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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

