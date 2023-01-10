Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E4EA6642DC
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 15:09:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231556AbjAJOI5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 09:08:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238668AbjAJOIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 09:08:12 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A8523C38C;
        Tue, 10 Jan 2023 06:08:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673359691; x=1704895691;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=k3cvIiiipTOOOJMkBjXRIczi8x3kZeinL1bpJ1JiSWA=;
  b=iuPOA6Oico/UR5QcKxLppKjC5FrLlKFV+8MniAbPnhMwi5wnrapIapB0
   qwwzVz9xGgNr0aAjGXKr+Zm981C8bhsX6YCC2tYOq2bwtdLa4y2u0qEAJ
   NIx87KVvBFblkeGvr+cs7LHnBPMa5McUInVMjN8ljoGaSNjhTvrGgif+T
   egcrcrCDKkAU/J3psEW5QWvPOdxXKisqhhXro01FTT7seYrJ5K8HbG3Ct
   5vG/+3BMJnRjEjcgPe5WXIwP1nbPR7jJOtaKkuCb0qtvirTCoKPIqTMK1
   v4OFGThikhwpZYcijwfD4BAlREFv/3VsosA7JowM5JaAaaXLHW7mpl7sx
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10585"; a="303513589"
X-IronPort-AV: E=Sophos;i="5.96,315,1665471600"; 
   d="scan'208";a="303513589"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2023 06:07:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10585"; a="725555661"
X-IronPort-AV: E=Sophos;i="5.96,315,1665471600"; 
   d="scan'208";a="725555661"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 10 Jan 2023 06:07:39 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id F19D91A3; Tue, 10 Jan 2023 16:08:12 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 2/5] rtc: isl12022: Explicitly use __le16 type for ISL12022_REG_TEMP_L
Date:   Tue, 10 Jan 2023 16:08:03 +0200
Message-Id: <20230110140806.87432-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230110140806.87432-1-andriy.shevchenko@linux.intel.com>
References: <20230110140806.87432-1-andriy.shevchenko@linux.intel.com>
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

We are reading 10-bit value in a 16-bit register in LE format.
Make this explicit by using __le16 type for it and corresponding
conversion function.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/rtc/rtc-isl12022.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/rtc/rtc-isl12022.c b/drivers/rtc/rtc-isl12022.c
index 44058fa27277..bf1aa6f6560d 100644
--- a/drivers/rtc/rtc-isl12022.c
+++ b/drivers/rtc/rtc-isl12022.c
@@ -19,6 +19,8 @@
 #include <linux/regmap.h>
 #include <linux/hwmon.h>
 
+#include <asm/byteorder.h>
+
 /* ISL register offsets */
 #define ISL12022_REG_SC		0x00
 #define ISL12022_REG_MN		0x01
@@ -63,17 +65,16 @@ static umode_t isl12022_hwmon_is_visible(const void *data,
 static int isl12022_hwmon_read_temp(struct device *dev, long *mC)
 {
 	struct regmap *regmap = dev_get_drvdata(dev);
-	u8 temp_buf[2];
 	int temp, ret;
+	__le16 buf;
 
-	ret = regmap_bulk_read(regmap, ISL12022_REG_TEMP_L,
-			       temp_buf, sizeof(temp_buf));
+	ret = regmap_bulk_read(regmap, ISL12022_REG_TEMP_L, &buf, sizeof(buf));
 	if (ret)
 		return ret;
 	/*
 	 * Temperature is represented as a 10-bit number, unit half-Kelvins.
 	 */
-	temp = (temp_buf[1] << 8) | temp_buf[0];
+	temp = le16_to_cpu(buf);
 	temp *= 500;
 	temp -= 273000;
 
-- 
2.39.0

