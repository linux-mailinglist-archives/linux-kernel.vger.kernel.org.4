Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CF25639660
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 15:18:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbiKZOR7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Nov 2022 09:17:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbiKZORv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Nov 2022 09:17:51 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 215F118E23;
        Sat, 26 Nov 2022 06:17:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669472271; x=1701008271;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ll+1FVMo/UXGN2SeeyQhin6WVr2RA2XTjdyAG4/biUo=;
  b=FY8AE7KUgRk7HOwBqmFh2USuaOx4AjWGqjVElFnjZJaODgh4kJlCw1en
   qLmXynFBR1a4XU5s2Ml7ACxpYDcziXC7VINOraMRAQ6H6XKuRtP33atXw
   SqgnjRnGnMxv8EQtvFkLlmFCw9FcmGHVjbxKmlol5yCRg3rGs1P40pIya
   v8NehovDAJZmorWm5+/6Co6xQGGbY1wN8V3M75m/JqTGSCJYOaUib+BId
   Kjp6kv93rzP/v+XI/OGXM/ddPe5i8iikdvZD8BWk9rBFuJXdVDYGffEHy
   tB0+/z2HV4qpW87yvDr57SimH/4g7xSqsO2fhRER8kpTGlWyxFBQzaJrG
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10543"; a="315755386"
X-IronPort-AV: E=Sophos;i="5.96,196,1665471600"; 
   d="scan'208";a="315755386"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2022 06:17:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10543"; a="971800597"
X-IronPort-AV: E=Sophos;i="5.96,196,1665471600"; 
   d="scan'208";a="971800597"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 26 Nov 2022 06:17:44 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 0BA05B7; Sat, 26 Nov 2022 16:18:11 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 2/5] rtc: isl12022: Explicitly use __le16 type for ISL12022_REG_TEMP_L
Date:   Sat, 26 Nov 2022 16:18:03 +0200
Message-Id: <20221126141806.62205-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221126141806.62205-1-andriy.shevchenko@linux.intel.com>
References: <20221126141806.62205-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We are reading 10-bit value in a 16-bit register in LE format.
Make this explicit by using __le16 type for it and corresponding
conversion function.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
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
2.35.1

