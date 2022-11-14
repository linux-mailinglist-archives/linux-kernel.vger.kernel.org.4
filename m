Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 695AC6283B7
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 16:20:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236162AbiKNPUw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 10:20:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235995AbiKNPUq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 10:20:46 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2F66BC93;
        Mon, 14 Nov 2022 07:20:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668439245; x=1699975245;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=YVDBh+y0ly+b4i0yQLk+Z5Rg5geOVQUbRk4A9jNUDPY=;
  b=a5J1BfO+lTpqa9ibGiOAO4sXZonVy3vmExzp0VYEp28kZAitB+nB5zKp
   tj9kT9pOSTPFmteS611loSirRdJ6CbfwO5uWWOW+REKJl3gUZDjIt7knx
   hlgCaiKPaHADczwICEWrS6NaxEMXap9/KFEbwHwByHzvqEfEOvXl6hccu
   DYaau5gYRmb8up5EwhDooGi+vBIl2RE7rrad+MoijnaQLD1Oy0Mt8Lpg/
   mWHSlNNkfhWx0Igd1n0xxXWuB3Buse8iE2WtBmR88L5Li5CvG5g35cMR5
   3qX8eAidS/7LcVA8BYukK9aSMz93rKtglX8Xoo4X/GhCEquCq4dOiSWIq
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="398286157"
X-IronPort-AV: E=Sophos;i="5.96,164,1665471600"; 
   d="scan'208";a="398286157"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2022 07:17:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="763518987"
X-IronPort-AV: E=Sophos;i="5.96,164,1665471600"; 
   d="scan'208";a="763518987"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 14 Nov 2022 07:17:51 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 90C8F2F3; Mon, 14 Nov 2022 17:18:15 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Magnus Damm <damm+renesas@opensource.se>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v3 1/1] serdev: Replace poll loop by readx_poll_timeout() macro
Date:   Mon, 14 Nov 2022 17:18:13 +0200
Message-Id: <20221114151813.37294-1-andriy.shevchenko@linux.intel.com>
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

The readx_poll_timeout() consolidates the necessary code under
macro. Replace current code with it.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v3: avoided vdso/time64.h usage (Greg)
 include/linux/serdev.h | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/include/linux/serdev.h b/include/linux/serdev.h
index 66f624fc618c..5f6bfe4f6d95 100644
--- a/include/linux/serdev.h
+++ b/include/linux/serdev.h
@@ -7,6 +7,7 @@
 
 #include <linux/types.h>
 #include <linux/device.h>
+#include <linux/iopoll.h>
 #include <linux/uaccess.h>
 #include <linux/termios.h>
 #include <linux/delay.h>
@@ -279,18 +280,10 @@ static inline bool serdev_device_get_cts(struct serdev_device *serdev)
 
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
+				  2000, timeout_ms * 1000);
 }
 
 static inline int serdev_device_set_rts(struct serdev_device *serdev, bool enable)
-- 
2.35.1

