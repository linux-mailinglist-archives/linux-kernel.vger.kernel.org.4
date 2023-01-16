Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B55066D180
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 23:10:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235127AbjAPWK2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 17:10:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235035AbjAPWKH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 17:10:07 -0500
Received: from relay07.th.seeweb.it (relay07.th.seeweb.it [IPv6:2001:4b7a:2000:18::168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DF722A172
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 14:10:01 -0800 (PST)
Received: from localhost.localdomain (94-211-6-86.cable.dynamic.v4.ziggo.nl [94.211.6.86])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id BF8153F254;
        Mon, 16 Jan 2023 23:09:58 +0100 (CET)
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
Subject: [RFC PATCH v2 1/5] iio: core: Point users of extend_name field to read_label callback
Date:   Mon, 16 Jan 2023 23:09:05 +0100
Message-Id: <20230116220909.196926-2-marijn.suijten@somainline.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230116220909.196926-1-marijn.suijten@somainline.org>
References: <20230116220909.196926-1-marijn.suijten@somainline.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
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
index 81413cd3a3e7..36c89f238fb9 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -221,6 +221,9 @@ struct iio_event_spec {
  * @extend_name:	Allows labeling of channel attributes with an
  *			informative name. Note this has no effect codes etc,
  *			unlike modifiers.
+ *			This field is deprecated in favour of overriding read_label
+ *			in iio_info, which unlike @extend_name does not affect sysfs
+ *			filenames.
  * @datasheet_name:	A name used in in-kernel mapping of channels. It should
  *			correspond to the first name that the channel is referred
  *			to by in the datasheet (e.g. IND), or the nearest
-- 
2.39.0

