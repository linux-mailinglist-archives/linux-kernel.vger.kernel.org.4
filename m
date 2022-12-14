Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0704564C8A0
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 13:02:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238161AbiLNMCp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 07:02:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238283AbiLNMCU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 07:02:20 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BF6E26AA0;
        Wed, 14 Dec 2022 04:01:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671019307; x=1702555307;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=T2h0MiLbTfn4i9o+IaErqzz+faLKb8LWwG9yfT/PdDY=;
  b=iyOhikuo/y7q24VuLtnsZk7tnJ4DLkYOY+CIhZzncgCCXMBDGpG/3W3E
   0RN54eQxHU/UCV5lSPfWZ3io5KtQwnFZF3rWbPxQ5W1+56oDdyBJMar0q
   BL7+uHn9W1BPDdatTsTudFmBgSmeXSR5wd0Pb7nk/KBAwnz7v9WaYfOl3
   fAdGpfBXrE292igf1HQ3JS4mtsAFFpTxEgRyqi9wPDfoMJSfPAS3Z29fh
   qFa5eomOf4dBvNUvqb+K6n5c1jsoLDdvidSA35cPqT3VHwMVoiUosHwpj
   ZEUEPewYkS/mJvCXqAPevqEy2dZnmY4+Kpe7NH+n9C2wR6pU0QuIXyZRy
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10560"; a="320243476"
X-IronPort-AV: E=Sophos;i="5.96,244,1665471600"; 
   d="scan'208";a="320243476"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2022 04:01:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10560"; a="648999292"
X-IronPort-AV: E=Sophos;i="5.96,244,1665471600"; 
   d="scan'208";a="648999292"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 14 Dec 2022 04:01:33 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 2A684F7; Wed, 14 Dec 2022 14:02:03 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v1 1/2] iio: adc: ti-adc128s052: Use get_unaligned_beXX()
Date:   Wed, 14 Dec 2022 14:02:01 +0200
Message-Id: <20221214120202.4658-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
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

This makes the driver code slightly easier to read.
While at it, use GENMASK() as well.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/adc/ti-adc128s052.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ti-adc128s052.c b/drivers/iio/adc/ti-adc128s052.c
index fc09ee6bb174..7c4e8025861c 100644
--- a/drivers/iio/adc/ti-adc128s052.c
+++ b/drivers/iio/adc/ti-adc128s052.c
@@ -9,6 +9,7 @@
  * https://www.ti.com/lit/ds/symlink/adc124s021.pdf
  */
 
+#include <linux/bits.h>
 #include <linux/err.h>
 #include <linux/spi/spi.h>
 #include <linux/module.h>
@@ -17,6 +18,8 @@
 #include <linux/property.h>
 #include <linux/regulator/consumer.h>
 
+#include <asm/unaligned.h>
+
 struct adc128_configuration {
 	const struct iio_chan_spec	*channels;
 	u8				num_channels;
@@ -33,6 +36,7 @@ struct adc128 {
 
 static int adc128_adc_conversion(struct adc128 *adc, u8 channel)
 {
+	u16 value;
 	int ret;
 
 	mutex_lock(&adc->lock);
@@ -53,7 +57,8 @@ static int adc128_adc_conversion(struct adc128 *adc, u8 channel)
 	if (ret < 0)
 		return ret;
 
-	return ((adc->buffer[0] << 8 | adc->buffer[1]) & 0xFFF);
+	value = get_unaligned_be16(&adc->buffer);
+	return value & GENMASK(11, 0);
 }
 
 static int adc128_read_raw(struct iio_dev *indio_dev,
-- 
2.35.1

