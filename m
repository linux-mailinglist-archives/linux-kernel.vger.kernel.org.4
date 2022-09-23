Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29A9F5E8067
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 19:10:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232216AbiIWRKj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 13:10:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbiIWRKg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 13:10:36 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B45CF370B;
        Fri, 23 Sep 2022 10:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663953034; x=1695489034;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=mn6yhKOElmfbXGir3ybNXHJ2hPzgirxFvVm3h7RTIzs=;
  b=jQnVJBEgIaabSat6yTuemPBuua7pbd0b6WtlrTgMsIh8RI1OSH14HaSy
   xBr8/6jUkF5qYe+L2VCvcnJP+hWGvg6+6OQhpIOkqMz5E7Unt+eXhxJKW
   NQ4cAQMZeTJEvzC+MHg2q/KYJiGf8R0IGPcbTVg3VdCSouczz6Eh6AyY6
   dNLvcU+oGyrwwZXGbdWS8fYqo1VLeCKzSYQ3KDo5GPk+82OzLGz7wQo39
   kR5YMbQ6BBL/h0BlbTIJY5ThBDuv7v67Y1yVQl30S5y6C+B4KdjQ45S+Q
   TfGeXuIXUlhllzPG0Kkl2qK4f4JEu+tBsbzhcLaETAsiL/eFo9cKH/NLY
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10479"; a="326969142"
X-IronPort-AV: E=Sophos;i="5.93,339,1654585200"; 
   d="scan'208";a="326969142"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2022 10:10:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,339,1654585200"; 
   d="scan'208";a="571440021"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 23 Sep 2022 10:10:31 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 812BEF7; Fri, 23 Sep 2022 20:10:49 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Magnus Damm <damm+renesas@opensource.se>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 1/1] serdev: Replace poll loop by readx_poll_timeout() macro
Date:   Fri, 23 Sep 2022 20:10:48 +0300
Message-Id: <20220923171048.37386-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The readx_poll_timeout() consolidates the necessary code under
macro. Replace current code with it.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: dropped TODO: in the Subject line
 include/linux/serdev.h | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/include/linux/serdev.h b/include/linux/serdev.h
index 66f624fc618c..69d9c3188065 100644
--- a/include/linux/serdev.h
+++ b/include/linux/serdev.h
@@ -7,9 +7,11 @@
 
 #include <linux/types.h>
 #include <linux/device.h>
+#include <linux/iopoll.h>
 #include <linux/uaccess.h>
 #include <linux/termios.h>
 #include <linux/delay.h>
+#include <vdso/time64.h>
 
 struct serdev_controller;
 struct serdev_device;
@@ -279,18 +281,10 @@ static inline bool serdev_device_get_cts(struct serdev_device *serdev)
 
 static inline int serdev_device_wait_for_cts(struct serdev_device *serdev, bool state, int timeout_ms)
 {
-	unsigned long timeout;
 	bool signal;
 
-	timeout = jiffies + msecs_to_jiffies(timeout_ms);
-	while (time_is_after_jiffies(timeout)) {
-		signal = serdev_device_get_cts(serdev);
-		if (signal == state)
-			return 0;
-		usleep_range(1000, 2000);
-	}
-
-	return -ETIMEDOUT;
+	return readx_poll_timeout(serdev_device_get_cts, serdev, signal, signal == state,
+				  2000, timeout_ms * USEC_PER_MSEC);
 }
 
 static inline int serdev_device_set_rts(struct serdev_device *serdev, bool enable)
-- 
2.35.1

