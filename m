Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 344AF62866F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 18:01:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237954AbiKNRBB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 12:01:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238166AbiKNRAd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 12:00:33 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1716B22;
        Mon, 14 Nov 2022 08:59:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668445191; x=1699981191;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=epLPs0koHWXMcPOrbhPMFM2RiIGVQ5fe2evVJvud0Vs=;
  b=dJ1sGb7VtZPHL+6h7CYo7Sezm7g0lKEzDAEldEXw2xbznbhJILJlk/kW
   gQ7t5L9PUTt5Sjrf03OZONJ6TBPmCdyB5DqU0JiCGTLsPm57O+gsEZTiX
   8O9rc9JZmMAfuTEodmgVWpWpZpbJDIXLGQGQz1PwCKLSr7MfLEZbhy6x6
   VJkMf/Z7m4fGSM9QC9VdnNJSSYina2NxiQo1UWMl4+PYBCQ6nGZylXvtF
   F+Oxjpq1mLv49pl/E5fDVQBkQBa0+TBQWicbz3dtUZDrEgZYgWY44CSG+
   +Bx/o/VQvCX+ygrYO0Lie1PZJPMRnXYigOtqKJsL0XQwN8yFyzQlQwQaO
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="295384258"
X-IronPort-AV: E=Sophos;i="5.96,164,1665471600"; 
   d="scan'208";a="295384258"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2022 08:59:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="780997746"
X-IronPort-AV: E=Sophos;i="5.96,164,1665471600"; 
   d="scan'208";a="780997746"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 14 Nov 2022 08:59:42 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id F2CCFB7; Mon, 14 Nov 2022 19:00:06 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 2/2] pwm: core: Remove S_IFREG from debugfs_create_file()
Date:   Mon, 14 Nov 2022 19:00:05 +0200
Message-Id: <20221114170006.61751-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221114170006.61751-1-andriy.shevchenko@linux.intel.com>
References: <20221114170006.61751-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The debugfs_create_file() already has a check and adds S_IFREG
automatically. Remove unneeded flag.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: rebased with dropped wrong patch (LKP)
 drivers/pwm/core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 855abd0a776f..8f5cb665940f 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -1179,8 +1179,7 @@ DEFINE_SEQ_ATTRIBUTE(pwm_debugfs);
 
 static int __init pwm_debugfs_init(void)
 {
-	debugfs_create_file("pwm", S_IFREG | 0444, NULL, NULL,
-			    &pwm_debugfs_fops);
+	debugfs_create_file("pwm", 0444, NULL, NULL, &pwm_debugfs_fops);
 
 	return 0;
 }
-- 
2.35.1

