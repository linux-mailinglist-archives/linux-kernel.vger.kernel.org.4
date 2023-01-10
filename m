Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB1686642DD
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 15:09:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238079AbjAJOJH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 09:09:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238663AbjAJOIL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 09:08:11 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F7768CBE5;
        Tue, 10 Jan 2023 06:08:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673359690; x=1704895690;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/W8mB5CAUSKdgh4t9azmzmb5WV1al8YW28UpUk33I4Q=;
  b=I9QAyZYuqdLhy83alIrBBYvwuBWe++oloKXQ5Kd1xW53btF1T4RDsqzP
   KudknnZpHFQgRBpvVsGj94jtnD+wEYiZ7AA9IHCSXQcM3jodBwwPp7+69
   DjbjkENR/Uhe8YgBoWGe9SJezWTTSA01c35rt9gXG4RuYf/oMnEcotUzz
   ndbGHdLpF5QrVIc9SVVHMtyYNHBC9Lhv0wd0+emI0IL2v5oiOSgQUMS9M
   fcaDo+jEE2TaBjtv1dbOWeZBxkWPOadn0LfzmyeEb3aqrqOPweK0nHNOC
   Z9CoERCBqluqYqqc9lGiaXcg5YYHOyZqKOqfw0FOtXzBBRGQ7g5FCZ+9d
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10585"; a="303513579"
X-IronPort-AV: E=Sophos;i="5.96,315,1665471600"; 
   d="scan'208";a="303513579"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2023 06:07:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10585"; a="725555662"
X-IronPort-AV: E=Sophos;i="5.96,315,1665471600"; 
   d="scan'208";a="725555662"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 10 Jan 2023 06:07:39 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 0BA2F330; Tue, 10 Jan 2023 16:08:13 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 4/5] rtc: isl12022: Join string literals back
Date:   Tue, 10 Jan 2023 16:08:05 +0200
Message-Id: <20230110140806.87432-5-andriy.shevchenko@linux.intel.com>
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

For easy grepping on debug purposes join string literals back in
the messages.

While at it, drop __func__ parameter from unique enough dev_dbg()
message as Dynamic Debug can retrieve this at run time.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/rtc/rtc-isl12022.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/rtc/rtc-isl12022.c b/drivers/rtc/rtc-isl12022.c
index 77b4763f2a70..ee38c5067ea8 100644
--- a/drivers/rtc/rtc-isl12022.c
+++ b/drivers/rtc/rtc-isl12022.c
@@ -143,16 +143,12 @@ static int isl12022_rtc_read_time(struct device *dev, struct rtc_time *tm)
 
 	if (buf[ISL12022_REG_SR] & (ISL12022_SR_LBAT85 | ISL12022_SR_LBAT75)) {
 		dev_warn(dev,
-			 "voltage dropped below %u%%, "
-			 "date and time is not reliable.\n",
+			 "voltage dropped below %u%%, date and time is not reliable.\n",
 			 buf[ISL12022_REG_SR] & ISL12022_SR_LBAT85 ? 85 : 75);
 	}
 
 	dev_dbg(dev,
-		"%s: raw data is sec=%02x, min=%02x, hr=%02x, "
-		"mday=%02x, mon=%02x, year=%02x, wday=%02x, "
-		"sr=%02x, int=%02x",
-		__func__,
+		"raw data is sec=%02x, min=%02x, hr=%02x, mday=%02x, mon=%02x, year=%02x, wday=%02x, sr=%02x, int=%02x",
 		buf[ISL12022_REG_SC],
 		buf[ISL12022_REG_MN],
 		buf[ISL12022_REG_HR],
-- 
2.39.0

