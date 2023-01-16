Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B4EC66D17A
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 23:10:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235039AbjAPWKM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 17:10:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235016AbjAPWKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 17:10:06 -0500
Received: from relay07.th.seeweb.it (relay07.th.seeweb.it [5.144.164.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0985429E00
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 14:10:00 -0800 (PST)
Received: from localhost.localdomain (94-211-6-86.cable.dynamic.v4.ziggo.nl [94.211.6.86])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 1EF3D3F251;
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
Subject: [RFC PATCH v2 0/5] iio: adc: qcom-spmi-vadc: Propagate fw node label to userspace
Date:   Mon, 16 Jan 2023 23:09:04 +0100
Message-Id: <20230116220909.196926-1-marijn.suijten@somainline.org>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement read_label in qcom-spmi-vadc to see DT-specified label names
in userspace.  At the same time clear up some documentation around
extend_name to promote read_label, and normalize similar code in
qcom-spmi-adc5.

Changes since v1:
- qcom-spmi-vadc: Use read_label instead of extend_name;

New since v1:
- core: Point users of extend_name field to read_label callback
- qcom-spmi-adc5: Use datasheet_name string literal for
  iio_chan_spec::datasheet_name;
- qcom-spmi-adc5: Fall back to datasheet_name instead of
  fwnode_get_name() for iio_chan_spec::extend_name (gets rid of @xx in
  sysfs filenames and labels);
- qcom-spmi-adc5: Remove unnecessary datasheet_name NULL check.

v1: https://lore.kernel.org/linux-arm-msm/20221106193018.270106-1-marijn.suijten@somainline.org/

Marijn Suijten (5):
  iio: core: Point users of extend_name field to read_label callback
  iio: adc: qcom-spmi-adc5: Use driver datasheet_name instead of DT
    label
  iio: adc: qcom-spmi-adc5: Fall back to datasheet_name instead of
    fwnode name
  iio: adc: qcom-spmi-adc5: Remove unnecessary datasheet_name NULL check
  iio: adc: qcom-spmi-vadc: Propagate fw node label to userspace

 drivers/iio/adc/qcom-spmi-adc5.c | 15 +++++++--------
 drivers/iio/adc/qcom-spmi-vadc.c | 19 ++++++++++++++++++-
 include/linux/iio/iio.h          |  3 +++
 3 files changed, 28 insertions(+), 9 deletions(-)

--
2.39.0

