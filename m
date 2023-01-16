Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A70F366D187
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 23:11:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235162AbjAPWK6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 17:10:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233225AbjAPWKJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 17:10:09 -0500
Received: from relay05.th.seeweb.it (relay05.th.seeweb.it [5.144.164.166])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45A032A9BC
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 14:10:01 -0800 (PST)
Received: from localhost.localdomain (94-211-6-86.cable.dynamic.v4.ziggo.nl [94.211.6.86])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 102FC3F260;
        Mon, 16 Jan 2023 23:10:00 +0100 (CET)
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
Subject: [RFC PATCH v2 3/5] iio: adc: qcom-spmi-adc5: Fall back to datasheet_name instead of fwnode name
Date:   Mon, 16 Jan 2023 23:09:07 +0100
Message-Id: <20230116220909.196926-4-marijn.suijten@somainline.org>
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

Since the migration to fwnode_get_name in commit 4f47a236a23d ("iio:
adc: qcom-spmi-adc5: convert to device properties") the resulting
adc5_channel_prop::channel_name (renamed from datasheet_name in the
previous patch) - which is propagated into iio_chan_spec::extend_name -
was containing the DT node name including @xx suffix if a "label"
property is not present, while adc5_channels::datasheet_name was thus
far set by the macros but always remained unread.  Put it to use instead
of using a confusing name containing @xx in sysfs filenames (again, when
"label" is not set).

Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
---

Note that for this to make sense a successor to "arm64: dts: qcom: Use
labels with generic node names for ADC channels" [1] will have to land,
otherwise most channels that currently pull datasheet_name/extend_name
from DT fall back to datasheet_name hardcoded in this driver.

[1]: https://lore.kernel.org/linux-arm-msm/20221209215308.1781047-1-marijn.suijten@somainline.org/

 drivers/iio/adc/qcom-spmi-adc5.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/qcom-spmi-adc5.c b/drivers/iio/adc/qcom-spmi-adc5.c
index 26144a086fac..01aafd9df6c6 100644
--- a/drivers/iio/adc/qcom-spmi-adc5.c
+++ b/drivers/iio/adc/qcom-spmi-adc5.c
@@ -661,7 +661,7 @@ static int adc5_get_fw_channel_data(struct adc5_chip *adc,
 
 	ret = fwnode_property_read_string(fwnode, "label", &channel_name);
 	if (ret)
-		channel_name = name;
+		channel_name = data->adc_chans[chan].datasheet_name;
 
 	prop->channel_name = channel_name;
 
-- 
2.39.0

