Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7016A63965F
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 15:17:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbiKZOR4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Nov 2022 09:17:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiKZORv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Nov 2022 09:17:51 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A09F920341;
        Sat, 26 Nov 2022 06:17:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669472269; x=1701008269;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XCP49we+GzcR7CAEn/BKujEcmW+ItDZgyYbuqmySPzI=;
  b=F9jugEsTP4gvGTi28CYrEuKgn8CDdyN6h8/+SdsCz13CI39hg1dHgW25
   Qj/u0xlPB2HresxXVdCyMm5HT5sK+0hda5QyvycC/uEtqyyEL9iotjcJ3
   bpLyRNjM08ICv07H+D8/aaU88EbLA4pAOV3mO5ecZxUunhsDJCGMWCHiE
   H1KZK903Re/6O+jf67zb9I+28frl/1DRVy2WKYXuJbx3sfegY7AqWqjnF
   NYsHyaHsDYhFZxwdukyVKXal1LlcSgeeB4aH/eOz66lpnA1+Xc6Cxi0aS
   Q3RuFps0DPaKa/gxUgG8uK/GKhB1pEEOq72cGpautq6PGj/8FqNPwZ6rh
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10543"; a="315755385"
X-IronPort-AV: E=Sophos;i="5.96,196,1665471600"; 
   d="scan'208";a="315755385"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2022 06:17:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10543"; a="971800595"
X-IronPort-AV: E=Sophos;i="5.96,196,1665471600"; 
   d="scan'208";a="971800595"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 26 Nov 2022 06:17:44 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 181CD179; Sat, 26 Nov 2022 16:18:11 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 3/5] rtc: isl12022: Drop unneeded OF guards and of_match_ptr()
Date:   Sat, 26 Nov 2022 16:18:04 +0200
Message-Id: <20221126141806.62205-3-andriy.shevchenko@linux.intel.com>
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
2.35.1

