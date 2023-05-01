Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A8366F3AF4
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 01:18:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233135AbjEAXSW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 19:18:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231337AbjEAXST (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 19:18:19 -0400
Received: from relay07.th.seeweb.it (relay07.th.seeweb.it [5.144.164.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 797D13598;
        Mon,  1 May 2023 16:18:16 -0700 (PDT)
Received: from localhost.localdomain (94-211-6-86.cable.dynamic.v4.ziggo.nl [94.211.6.86])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id AA4D440E51;
        Tue,  2 May 2023 01:18:14 +0200 (CEST)
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH RESEND v3 2/5] iio: adc: qcom-spmi-adc5: Use driver datasheet_name instead of DT label
Date:   Tue,  2 May 2023 01:17:34 +0200
Message-Id: <20230502-iio-adc-propagate-fw-node-label-v3-2-6be5db6e6b5a@somainline.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230502-iio-adc-propagate-fw-node-label-v3-0-6be5db6e6b5a@somainline.org>
References: <20230502-iio-adc-propagate-fw-node-label-v3-0-6be5db6e6b5a@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.2
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
index c2d5e06f137a7..6e4e5cb5cbbb7 100644
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
@@ -671,7 +671,7 @@ static int adc5_get_fw_channel_data(struct adc5_chip *adc,
 	if (ret)
 		channel_name = name;
 
-	prop->datasheet_name = channel_name;
+	prop->channel_name = channel_name;
 
 	ret = fwnode_property_read_u32(fwnode, "qcom,decimation", &value);
 	if (!ret) {
@@ -861,8 +861,8 @@ static int adc5_get_fw_data(struct adc5_chip *adc)
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
2.40.1

