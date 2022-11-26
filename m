Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01338639661
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 15:18:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbiKZOSC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Nov 2022 09:18:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbiKZORv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Nov 2022 09:17:51 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21F2B18E3B;
        Sat, 26 Nov 2022 06:17:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669472271; x=1701008271;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tzQvOKWf3TMH/Dd1rfQ3NBBo0TXSVQc4zhcPWFce9AM=;
  b=n0R/em1l38MVw5om6c33CY5DdL3jzuP5MyoXvcM0onYB+NKGbZDneGPI
   LTR7GQST1iow0kvbmrGkR6q+/MD1V6ZtXqvMsFfUkbwhSWA4klMxmLC6r
   S5BTqD3CY8YivGVAadEJjnM7KZvRNt2jDlPeU7d5Si/dTn6FZBPy8ZK2C
   z/8Keq8qZSe1M2CMi70sG1kFs03tHgawcQvgtwUb4qAdMz0QCOdYFPEJF
   byBes19Q5sZzqjFNpXkKZdxyLOPiCI1ckss2q29GZz9U+Tt8vWYB36NpV
   iiosdMv7FyR9ZlbFGv1gdCGxhyISlfBo1hq7EZN81wotF0KtCSZfTWtCq
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10543"; a="315755387"
X-IronPort-AV: E=Sophos;i="5.96,196,1665471600"; 
   d="scan'208";a="315755387"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2022 06:17:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10543"; a="971800596"
X-IronPort-AV: E=Sophos;i="5.96,196,1665471600"; 
   d="scan'208";a="971800596"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 26 Nov 2022 06:17:44 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 29EC03B3; Sat, 26 Nov 2022 16:18:11 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 4/5] rtc: isl12022: Join string literals back
Date:   Sat, 26 Nov 2022 16:18:05 +0200
Message-Id: <20221126141806.62205-4-andriy.shevchenko@linux.intel.com>
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

For easy grepping on debug purposes join string literals back in
the messages.

While at it, drop __func__ parameter from unique enough dev_dbg()
message as Dynamic Debug can retrieve this at run time.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
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
2.35.1

