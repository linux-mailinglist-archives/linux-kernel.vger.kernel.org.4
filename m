Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC4C761E587
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 20:30:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbiKFTah (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 14:30:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbiKFTae (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 14:30:34 -0500
Received: from relay03.th.seeweb.it (relay03.th.seeweb.it [5.144.164.164])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B99EDF5A
        for <linux-kernel@vger.kernel.org>; Sun,  6 Nov 2022 11:30:32 -0800 (PST)
Received: from localhost.localdomain (94-209-172-39.cable.dynamic.v4.ziggo.nl [94.209.172.39])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id D1D381F517;
        Sun,  6 Nov 2022 20:30:27 +0100 (CET)
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     phone-devel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Luca Weiss <luca@z3ntu.xyz>, linux-arm-msm@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH] iio: adc: qcom-spmi-vadc: Propagate fw node name/label to extend_name
Date:   Sun,  6 Nov 2022 20:30:18 +0100
Message-Id: <20221106193018.270106-1-marijn.suijten@somainline.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Much like the ADC5 driver iio_chan_spec::extend_name has to be set for
friendly/useful names to show up in sysfs, allowing users to correlate
readout values with the corresponding probe.  This name is read from
firmware, taking both the node name and - if set - node label into
account.  This is particularly useful for custom thermistors being
attached to otherwise-generically-named GPIOs.

Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>

---

This RFC may seem a bit controversial as there are multiple patches
going around in DT-land changing how nodes are labeled [1] (or
introducing new ones: [2]), seemingly to appease binding conventions
without considering how the driver propagates them to IIO (and in turn
what userspace sees in sysfs).  I hope we can put together the right
conventions with this RFC.

Before getting started, note that ADC5 provides this DT/FW node
name/label in *both* extend_name *and* datasheet_name;
adc5_channels::datasheet_name provided by the macros remains *unread*
(except for a non-null check).
Since the names hardcoded in the driver seem to be somewhat
"datasheet"-y, and the names in DT typically take the form of a more
friendly "<device>-therm" indicating where the thermistor (or voltage
probe) is located on the board or attached to, I have opted to persist
the original use of vadc_channels::datasheet_name in
iio_chan_spec::datasheet_name, and only propagate the data from DT/FW
into extend_name.
(We should likely rename vadc_channel_prop::datasheet_name to
extend_name to this end.)

Back when I submitted patches for pm6125 [3] (utilizing ADC5)
4f47a236a23d ("iio: adc: qcom-spmi-adc5: convert to device properties")
didn't yet land, and these patches use the node name to convey a
useful/friendly name (again, the string literals in ADC5 are unused).
fwnode_get_name() however includes the `@xx` reg suffix, making for an
unpleasant reading experience in sysfs.

With all that context in mind, I feel like we should answer the
following questions:

1. Should we propagate names from DT/FW at all?
2. If so, how should a node be represented in DT?  Should it use generic
   node names (which we might not want to use anyway considering the
   `@xx` suffix highlighted above) or labels exclusively?
3. If only labels are going to be used in conjunction with generic node
   names, should ADC5 be changed to ignore the node name?
4. If a label (or node name) is not set, do we fall back to
   datasheet_name hardcoded in the driver?
5. What do we use for datasheet_name vs extend_name?
6. Any other vadc drivers that need the same treatment, when we come to
   a resolution?

[1]: https://lore.kernel.org/linux-arm-msm/20221031181022.947412-1-luca@z3ntu.xyz/T/#u
[2]: https://lore.kernel.org/linux-arm-msm/20221101161801.1058969-2-luca@z3ntu.xyz/
[3]: https://lore.kernel.org/linux-arm-msm/20220926190148.283805-1-marijn.suijten@somainline.org/T/#u

Thanks for considering this!
- Marijn

 drivers/iio/adc/qcom-spmi-vadc.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/qcom-spmi-vadc.c b/drivers/iio/adc/qcom-spmi-vadc.c
index bcff0f62b70e..8c6c7fa13cfe 100644
--- a/drivers/iio/adc/qcom-spmi-vadc.c
+++ b/drivers/iio/adc/qcom-spmi-vadc.c
@@ -84,6 +84,7 @@
  *	that is an average of multiple measurements.
  * @scale_fn_type: Represents the scaling function to convert voltage
  *	physical units desired by the client for the channel.
+ * @datasheet_name: Channel name used in device tree.
  */
 struct vadc_channel_prop {
 	unsigned int channel;
@@ -93,6 +94,7 @@ struct vadc_channel_prop {
 	unsigned int hw_settle_time;
 	unsigned int avg_samples;
 	enum vadc_scale_fn_type scale_fn_type;
+	const char *datasheet_name;
 };

 /**
@@ -652,7 +654,7 @@ static int vadc_get_fw_channel_data(struct device *dev,
 				    struct vadc_channel_prop *prop,
 				    struct fwnode_handle *fwnode)
 {
-	const char *name = fwnode_get_name(fwnode);
+	const char *name = fwnode_get_name(fwnode), *channel_name;
 	u32 chan, value, varr[2];
 	int ret;

@@ -670,6 +672,12 @@ static int vadc_get_fw_channel_data(struct device *dev,
 	/* the channel has DT description */
 	prop->channel = chan;

+	ret = fwnode_property_read_string(fwnode, "label", &channel_name);
+	if (ret)
+		channel_name = name;
+
+	prop->datasheet_name = channel_name;
+
 	ret = fwnode_property_read_u32(fwnode, "qcom,decimation", &value);
 	if (!ret) {
 		ret = qcom_vadc_decimation_from_dt(value);
@@ -771,6 +779,7 @@ static int vadc_get_fw_data(struct vadc_priv *vadc)

 		iio_chan->channel = prop.channel;
 		iio_chan->datasheet_name = vadc_chan->datasheet_name;
+		iio_chan->extend_name = prop.datasheet_name;
 		iio_chan->info_mask_separate = vadc_chan->info_mask;
 		iio_chan->type = vadc_chan->type;
 		iio_chan->indexed = 1;
--
2.38.1

