Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B047D6F3AFA
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 01:18:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232749AbjEAXS3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 19:18:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbjEAXSU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 19:18:20 -0400
Received: from relay05.th.seeweb.it (relay05.th.seeweb.it [IPv6:2001:4b7a:2000:18::166])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FF903A86;
        Mon,  1 May 2023 16:18:17 -0700 (PDT)
Received: from localhost.localdomain (94-211-6-86.cable.dynamic.v4.ziggo.nl [94.211.6.86])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 36F1B40E59;
        Tue,  2 May 2023 01:18:15 +0200 (CEST)
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
Subject: [PATCH RESEND v3 3/5] iio: adc: qcom-spmi-adc5: Fall back to datasheet_name instead of fwnode name
Date:   Tue,  2 May 2023 01:17:35 +0200
Message-Id: <20230502-iio-adc-propagate-fw-node-label-v3-3-6be5db6e6b5a@somainline.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230502-iio-adc-propagate-fw-node-label-v3-0-6be5db6e6b5a@somainline.org>
References: <20230502-iio-adc-propagate-fw-node-label-v3-0-6be5db6e6b5a@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.2
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
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
 drivers/iio/adc/qcom-spmi-adc5.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/qcom-spmi-adc5.c b/drivers/iio/adc/qcom-spmi-adc5.c
index 6e4e5cb5cbbb7..fe2000209d97d 100644
--- a/drivers/iio/adc/qcom-spmi-adc5.c
+++ b/drivers/iio/adc/qcom-spmi-adc5.c
@@ -669,7 +669,7 @@ static int adc5_get_fw_channel_data(struct adc5_chip *adc,
 
 	ret = fwnode_property_read_string(fwnode, "label", &channel_name);
 	if (ret)
-		channel_name = name;
+		channel_name = data->adc_chans[chan].datasheet_name;
 
 	prop->channel_name = channel_name;
 

-- 
2.40.1

