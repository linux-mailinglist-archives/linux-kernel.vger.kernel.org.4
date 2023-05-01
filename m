Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD7B56F3AF8
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 01:18:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233280AbjEAXS0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 19:18:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232197AbjEAXSU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 19:18:20 -0400
Received: from relay06.th.seeweb.it (relay06.th.seeweb.it [5.144.164.167])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5FD335B0
        for <linux-kernel@vger.kernel.org>; Mon,  1 May 2023 16:18:16 -0700 (PDT)
Received: from localhost.localdomain (94-211-6-86.cable.dynamic.v4.ziggo.nl [94.211.6.86])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 2D91740E42;
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
Subject: [PATCH RESEND v3 1/5] iio: core: Point users of extend_name field to read_label callback
Date:   Tue,  2 May 2023 01:17:33 +0200
Message-Id: <20230502-iio-adc-propagate-fw-node-label-v3-1-6be5db6e6b5a@somainline.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230502-iio-adc-propagate-fw-node-label-v3-0-6be5db6e6b5a@somainline.org>
References: <20230502-iio-adc-propagate-fw-node-label-v3-0-6be5db6e6b5a@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.2
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As mentioned and discussed in [1] extend_name should not be used for
full channel labels (and most drivers seem to only use it to express a
short type of a channel) as this affects sysfs filenames, while the
label name is supposed to be extracted from the *_label sysfs file
instead.  This appears to have been unclear to some drivers as
extend_name is also used when read_label is unset, achieving an initial
goal of providing sensible names in *_label sysfs files without noticing
that sysfs filenames are (negatively and likely unintentionally)
affected as well.

Point readers of iio_chan_spec::extend_name to iio_info::read_label by
mentioning deprecation and side-effects of this field.

[1]: https://lore.kernel.org/linux-arm-msm/20221221223432.si2aasbleiicayfl@SoMainline.org/

Suggested-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
---
 include/linux/iio/iio.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index 81413cd3a3e7a..6fc06063505a7 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -221,6 +221,9 @@ struct iio_event_spec {
  * @extend_name:	Allows labeling of channel attributes with an
  *			informative name. Note this has no effect codes etc,
  *			unlike modifiers.
+ *			This field is deprecated in favour of providing
+ *			iio_info->read_label() to override the label, which
+ *			unlike @extend_name does not affect sysfs filenames.
  * @datasheet_name:	A name used in in-kernel mapping of channels. It should
  *			correspond to the first name that the channel is referred
  *			to by in the datasheet (e.g. IND), or the nearest

-- 
2.40.1

