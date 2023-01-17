Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAB0066DA25
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 10:41:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236684AbjAQJll (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 04:41:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236514AbjAQJku (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 04:40:50 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E64212F23;
        Tue, 17 Jan 2023 01:39:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673948357; x=1705484357;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=D/jhirtyfFnEDy4/rsjYJANSLHw3P8R2e4OpVFJvmSo=;
  b=Snh29fRWaeuIplCH8i75oshiwK2NY26LT5CKo4G3m7BmRRY1rsKAQVWg
   /MYc+cdMxiGB6cwIB/IsNPBUifpsPcojaZGKDFPSoqYPKBSCAJVQ7tmlq
   3zakjOsTD1tP8XoO8J8qw2loDokavpH3xkl/RwuRnTEPOPROv+yAPjes4
   ryPJ1CIQCDxhZ8TCkt1TThgxPwxd9vDFAlKgiDecynC0n3jdyPxjMHG8h
   sq9jc8Rpk+QSjGPgCHuNGQ8edWqAzkEcK+EWg3hSlIPdnyh+Lq+MJhrk9
   T0snOfWODrw70/vSDPXTgtg9nbusuG/q7tJ7llDU87qC/YDXnbbS3vTHY
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10592"; a="410890557"
X-IronPort-AV: E=Sophos;i="5.97,222,1669104000"; 
   d="scan'208";a="410890557"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2023 01:39:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10592"; a="722588293"
X-IronPort-AV: E=Sophos;i="5.97,222,1669104000"; 
   d="scan'208";a="722588293"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 17 Jan 2023 01:39:13 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 51A5A130; Tue, 17 Jan 2023 11:39:48 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Marijn Suijten <marijn.suijten@somainline.org>
Subject: [PATCH v1 1/1] iio: adc: qcom-spmi-adc5: Fix the channel name
Date:   Tue, 17 Jan 2023 11:39:44 +0200
Message-Id: <20230117093944.72271-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The node name can contain an address part which is not used by
the driver. Cut it out before assigning the channel name.

Fixes: 4f47a236a23d ("iio: adc: qcom-spmi-adc5: convert to device properties")
Reported-by: Marijn Suijten <marijn.suijten@somainline.org>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/adc/qcom-spmi-adc5.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/qcom-spmi-adc5.c b/drivers/iio/adc/qcom-spmi-adc5.c
index e90c299c913a..c52bf6722a6a 100644
--- a/drivers/iio/adc/qcom-spmi-adc5.c
+++ b/drivers/iio/adc/qcom-spmi-adc5.c
@@ -628,12 +628,19 @@ static int adc5_get_fw_channel_data(struct adc5_chip *adc,
 				    struct fwnode_handle *fwnode,
 				    const struct adc5_data *data)
 {
-	const char *name = fwnode_get_name(fwnode), *channel_name;
+	const char *name, *channel_name;
 	u32 chan, value, varr[2];
 	u32 sid = 0;
 	int ret;
 	struct device *dev = adc->dev;
 
+	name = devm_kasprintf(dev, GFP_KERNEL, "%pfwP", fwnode);
+	if (!name)
+		return -ENOMEM;
+
+	/* Cut the address part */
+	name[strchrnul(name, '@') - name] = '\0';
+
 	ret = fwnode_property_read_u32(fwnode, "reg", &chan);
 	if (ret) {
 		dev_err(dev, "invalid channel number %s\n", name);
-- 
2.39.0

