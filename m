Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D28E56F3AFB
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 01:18:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232579AbjEAXSc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 19:18:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233209AbjEAXSV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 19:18:21 -0400
Received: from m-r2.th.seeweb.it (m-r2.th.seeweb.it [5.144.164.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53ED035BF;
        Mon,  1 May 2023 16:18:18 -0700 (PDT)
Received: from localhost.localdomain (94-211-6-86.cable.dynamic.v4.ziggo.nl [94.211.6.86])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 3EDB340E6D;
        Tue,  2 May 2023 01:18:16 +0200 (CEST)
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
Subject: [PATCH RESEND v3 5/5] iio: adc: qcom-spmi-vadc: Propagate fw node label to userspace
Date:   Tue,  2 May 2023 01:17:37 +0200
Message-Id: <20230502-iio-adc-propagate-fw-node-label-v3-5-6be5db6e6b5a@somainline.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230502-iio-adc-propagate-fw-node-label-v3-0-6be5db6e6b5a@somainline.org>
References: <20230502-iio-adc-propagate-fw-node-label-v3-0-6be5db6e6b5a@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.2
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
index bcff0f62b70e0..f5c6f1f27b2c7 100644
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
2.40.1

