Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B99216642CC
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 15:08:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237885AbjAJOIA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 09:08:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238655AbjAJOHm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 09:07:42 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 291163FC83;
        Tue, 10 Jan 2023 06:07:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673359662; x=1704895662;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4eiyGTWXX+oD7HoJjkMNpYlz3/ZKnnaK5/dHNcnJkPA=;
  b=NbDDbR8iE534INn82Hz0vTgz0DWeEBxa9uJcVtPOpHXUhP9NeD3NE3qZ
   nXH3qnYx9oJL9Pw6MeAiZ2DiOs+SVJAmykHtXnVHgfcvrblN4a5B10Ggw
   c6NVhLbf2BAsKlPdXkTouiknofwOdelf7ZJf8L4LKQbdzS2O18E1DcBtf
   SQI8K5hoHM68gDqAKX4VU2umq/EK6tKSy27qogRlRPBD77CkTCjbaFOKZ
   M+wcDSZEXPJCOkMNyopqcx7gLM3kEVXVJWgVavgX2L+s+s90n1i2MKrmu
   nTmAENI8cMPFcHAIB0khak3v4UsmeriOGufEXrjP3fHFy9MfajuIlm8AB
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10585"; a="325156487"
X-IronPort-AV: E=Sophos;i="5.96,315,1665471600"; 
   d="scan'208";a="325156487"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2023 06:07:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10585"; a="606971782"
X-IronPort-AV: E=Sophos;i="5.96,315,1665471600"; 
   d="scan'208";a="606971782"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 10 Jan 2023 06:07:39 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 048AA31D; Tue, 10 Jan 2023 16:08:13 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 3/5] rtc: isl12022: Drop unneeded OF guards and of_match_ptr()
Date:   Tue, 10 Jan 2023 16:08:04 +0200
Message-Id: <20230110140806.87432-4-andriy.shevchenko@linux.intel.com>
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

Drop unneeded OF guards and of_match_ptr(). This allows use of
the driver with other types of firmware such as ACPI PRP0001 based
probing.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/rtc/rtc-isl12022.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/rtc/rtc-isl12022.c b/drivers/rtc/rtc-isl12022.c
index bf1aa6f6560d..77b4763f2a70 100644
--- a/drivers/rtc/rtc-isl12022.c
+++ b/drivers/rtc/rtc-isl12022.c
@@ -14,8 +14,6 @@
 #include <linux/slab.h>
 #include <linux/module.h>
 #include <linux/err.h>
-#include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/regmap.h>
 #include <linux/hwmon.h>
 
@@ -46,8 +44,6 @@
 
 #define ISL12022_BETA_TSE	(1 << 7)
 
-static struct i2c_driver isl12022_driver;
-
 static umode_t isl12022_hwmon_is_visible(const void *data,
 					 enum hwmon_sensor_types type,
 					 u32 attr, int channel)
@@ -252,14 +248,12 @@ static int isl12022_probe(struct i2c_client *client)
 	return devm_rtc_register_device(rtc);
 }
 
-#ifdef CONFIG_OF
 static const struct of_device_id isl12022_dt_match[] = {
 	{ .compatible = "isl,isl12022" }, /* for backward compat., don't use */
 	{ .compatible = "isil,isl12022" },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, isl12022_dt_match);
-#endif
 
 static const struct i2c_device_id isl12022_id[] = {
 	{ "isl12022", 0 },
@@ -270,9 +264,7 @@ MODULE_DEVICE_TABLE(i2c, isl12022_id);
 static struct i2c_driver isl12022_driver = {
 	.driver		= {
 		.name	= "rtc-isl12022",
-#ifdef CONFIG_OF
-		.of_match_table = of_match_ptr(isl12022_dt_match),
-#endif
+		.of_match_table = isl12022_dt_match,
 	},
 	.probe_new	= isl12022_probe,
 	.id_table	= isl12022_id,
-- 
2.39.0

