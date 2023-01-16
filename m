Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4287866D185
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 23:10:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235148AbjAPWKj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 17:10:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235059AbjAPWKK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 17:10:10 -0500
Received: from relay05.th.seeweb.it (relay05.th.seeweb.it [5.144.164.166])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A9D827D71;
        Mon, 16 Jan 2023 14:10:03 -0800 (PST)
Received: from localhost.localdomain (94-211-6-86.cable.dynamic.v4.ziggo.nl [94.211.6.86])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 5BB483F279;
        Mon, 16 Jan 2023 23:10:01 +0100 (CET)
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
Subject: [RFC PATCH v2 5/5] iio: adc: qcom-spmi-vadc: Propagate fw node label to userspace
Date:   Mon, 16 Jan 2023 23:09:09 +0100
Message-Id: <20230116220909.196926-6-marijn.suijten@somainline.org>
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

Set the read_label() callback to return a friendly name provided in DT
(firmware), in order to make in_{therm,voltage}X_label attributes show
up in sysfs for userspace to consume a channel name.  This is
particularly useful for custom thermistors being attached to otherwise
generically named GPIOs, where the name is known by the board DT.

If the channel name isn't set in DT, use the datasheet_name hardcoded in
the driver instead.

Note that this doesn't fall back to fwnode_get_name() as that provides
suboptimally readable names, with an @xx address suffix from board DT.

Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
---
 drivers/iio/adc/qcom-spmi-vadc.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/qcom-spmi-vadc.c b/drivers/iio/adc/qcom-spmi-vadc.c
index bcff0f62b70e..f5c6f1f27b2c 100644
--- a/drivers/iio/adc/qcom-spmi-vadc.c
+++ b/drivers/iio/adc/qcom-spmi-vadc.c
@@ -84,6 +84,7 @@
  *	that is an average of multiple measurements.
  * @scale_fn_type: Represents the scaling function to convert voltage
  *	physical units desired by the client for the channel.
+ * @channel_name: Channel name used in device tree.
  */
 struct vadc_channel_prop {
 	unsigned int channel;
@@ -93,6 +94,7 @@ struct vadc_channel_prop {
 	unsigned int hw_settle_time;
 	unsigned int avg_samples;
 	enum vadc_scale_fn_type scale_fn_type;
+	const char *channel_name;
 };
 
 /**
@@ -495,8 +497,18 @@ static int vadc_fwnode_xlate(struct iio_dev *indio_dev,
 	return -EINVAL;
 }
 
+static int vadc_read_label(struct iio_dev *indio_dev,
+			   struct iio_chan_spec const *chan, char *label)
+{
+	struct vadc_priv *vadc = iio_priv(indio_dev);
+	const char *name = vadc->chan_props[chan->address].channel_name;
+
+	return sysfs_emit(label, "%s\n", name);
+}
+
 static const struct iio_info vadc_info = {
 	.read_raw = vadc_read_raw,
+	.read_label = vadc_read_label,
 	.fwnode_xlate = vadc_fwnode_xlate,
 };
 
@@ -652,7 +664,7 @@ static int vadc_get_fw_channel_data(struct device *dev,
 				    struct vadc_channel_prop *prop,
 				    struct fwnode_handle *fwnode)
 {
-	const char *name = fwnode_get_name(fwnode);
+	const char *name = fwnode_get_name(fwnode), *label;
 	u32 chan, value, varr[2];
 	int ret;
 
@@ -667,6 +679,11 @@ static int vadc_get_fw_channel_data(struct device *dev,
 		return -EINVAL;
 	}
 
+	ret = fwnode_property_read_string(fwnode, "label", &label);
+	if (ret)
+		label = vadc_chans[chan].datasheet_name;
+	prop->channel_name = label;
+
 	/* the channel has DT description */
 	prop->channel = chan;
 
-- 
2.39.0

