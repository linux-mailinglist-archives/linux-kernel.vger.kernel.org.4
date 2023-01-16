Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3584F66D18A
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 23:11:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235036AbjAPWLF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 17:11:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233990AbjAPWKI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 17:10:08 -0500
Received: from relay08.th.seeweb.it (relay08.th.seeweb.it [IPv6:2001:4b7a:2000:18::169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 246242A17C;
        Mon, 16 Jan 2023 14:10:01 -0800 (PST)
Received: from localhost.localdomain (94-211-6-86.cable.dynamic.v4.ziggo.nl [94.211.6.86])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 67A4E3F257;
        Mon, 16 Jan 2023 23:09:59 +0100 (CET)
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     phone-devel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 2/5] iio: adc: qcom-spmi-adc5: Use driver datasheet_name instead of DT label
Date:   Mon, 16 Jan 2023 23:09:06 +0100
Message-Id: <20230116220909.196926-3-marijn.suijten@somainline.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230116220909.196926-1-marijn.suijten@somainline.org>
References: <20230116220909.196926-1-marijn.suijten@somainline.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

iio_chan_spec::datasheet_name expects a channel/pin name on the hardware
part, i.e. from its datasheet, instead of a friendly name from DT which
typically describes the use of said channel.  GPIO channels are commonly
specialized in QCOM board DTS based on what a - typically thermistor -
is connected to.

Also rename adc5_channel_prop::datasheet_name to channel_name to that
effect.

Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
---
 drivers/iio/adc/qcom-spmi-adc5.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/adc/qcom-spmi-adc5.c b/drivers/iio/adc/qcom-spmi-adc5.c
index e90c299c913a..26144a086fac 100644
--- a/drivers/iio/adc/qcom-spmi-adc5.c
+++ b/drivers/iio/adc/qcom-spmi-adc5.c
@@ -114,7 +114,7 @@ enum adc5_cal_val {
  *	that is an average of multiple measurements.
  * @scale_fn_type: Represents the scaling function to convert voltage
  *	physical units desired by the client for the channel.
- * @datasheet_name: Channel name used in device tree.
+ * @channel_name: Channel name used in device tree.
  */
 struct adc5_channel_prop {
 	unsigned int		channel;
@@ -126,7 +126,7 @@ struct adc5_channel_prop {
 	unsigned int		hw_settle_time;
 	unsigned int		avg_samples;
 	enum vadc_scale_fn_type	scale_fn_type;
-	const char		*datasheet_name;
+	const char		*channel_name;
 };
 
 /**
@@ -663,7 +663,7 @@ static int adc5_get_fw_channel_data(struct adc5_chip *adc,
 	if (ret)
 		channel_name = name;
 
-	prop->datasheet_name = channel_name;
+	prop->channel_name = channel_name;
 
 	ret = fwnode_property_read_u32(fwnode, "qcom,decimation", &value);
 	if (!ret) {
@@ -853,8 +853,8 @@ static int adc5_get_fw_data(struct adc5_chip *adc)
 		adc_chan = &adc->data->adc_chans[prop.channel];
 
 		iio_chan->channel = prop.channel;
-		iio_chan->datasheet_name = prop.datasheet_name;
-		iio_chan->extend_name = prop.datasheet_name;
+		iio_chan->datasheet_name = adc_chan->datasheet_name;
+		iio_chan->extend_name = prop.channel_name;
 		iio_chan->info_mask_separate = adc_chan->info_mask;
 		iio_chan->type = adc_chan->type;
 		iio_chan->address = index;
-- 
2.39.0

