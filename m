Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5BCA65C238
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 15:48:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237577AbjACOsl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 09:48:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237826AbjACOsf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 09:48:35 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 832CE11A3B;
        Tue,  3 Jan 2023 06:48:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672757314; x=1704293314;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=5ZC0zGJVe4t6odSKDeAaJZXfvO1+WKLgsjDkfk5MYEQ=;
  b=gc5tlWHHVt3J5QVOrFSPgzVLNcoXFGauHyANIZhfNYj6NJMxswM98UL7
   SXEA3eDSM8oCHZpZ4iXLYLoTQ6gou5MTBvD2qJ0o3w1rkIKuXsfgSJ+Cl
   Hl2JYpPzc3xGlD0+V0uczSrlIHvsf32iUvt66e9A+lnLMSnXMNH8vzYGI
   lwi1bjJASCYj1RJITbMTrfBH0CArPtcs8MeEdPiBVe/kDG0W2j/H+18e5
   CzRTCIw7Yl0iuWPqj6L2R8udYEraXhAHoku+sTojgutX/rR5dGuNT0IOT
   MMr2hawPd99Na/CUwCHV2+a89SFtpBPq469JEbCtRCicnwvDs3+BmDC/E
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10579"; a="319382076"
X-IronPort-AV: E=Sophos;i="5.96,297,1665471600"; 
   d="scan'208";a="319382076"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2023 06:48:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10579"; a="723290714"
X-IronPort-AV: E=Sophos;i="5.96,297,1665471600"; 
   d="scan'208";a="723290714"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 03 Jan 2023 06:48:32 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 9CD34F4; Tue,  3 Jan 2023 16:49:04 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] iio: adc: max11410: Use asm intead of asm-generic
Date:   Tue,  3 Jan 2023 16:49:03 +0200
Message-Id: <20230103144903.39905-1-andriy.shevchenko@linux.intel.com>
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

There is no point to specify asm-generic for the unaligned.h.
Drop the 'generic' suffix and move the inclusion to be after
the non-IIO linux/* ones.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/adc/max11410.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/max11410.c b/drivers/iio/adc/max11410.c
index fdc9f03135b5..b74b689ee7de 100644
--- a/drivers/iio/adc/max11410.c
+++ b/drivers/iio/adc/max11410.c
@@ -4,7 +4,6 @@
  *
  * Copyright 2022 Analog Devices Inc.
  */
-#include <asm-generic/unaligned.h>
 #include <linux/bitfield.h>
 #include <linux/delay.h>
 #include <linux/device.h>
@@ -16,6 +15,8 @@
 #include <linux/regulator/consumer.h>
 #include <linux/spi/spi.h>
 
+#include <asm/unaligned.h>
+
 #include <linux/iio/buffer.h>
 #include <linux/iio/sysfs.h>
 #include <linux/iio/trigger.h>
-- 
2.35.1

