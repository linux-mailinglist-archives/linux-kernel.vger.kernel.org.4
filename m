Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54C4162E25A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 17:58:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239890AbiKQQ57 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 11:57:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239739AbiKQQ5y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 11:57:54 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9397D6CA07;
        Thu, 17 Nov 2022 08:57:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668704273; x=1700240273;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=X+BKoSlnAvgnVtCrEEN+OHgzxsqaoTOIPZcETlqo8rc=;
  b=HdWThu0g41inQHMkFIfMbtz9FCkpmoKpsj1kg+IHKLZMsbzX+XPmTs+u
   D1s3hhLdClOW6ily+rt0gwZy1uHXUJ3TXGiU/9yjZiutv4kmakg90EIv4
   WwtoEOehsP48RCOmo+/0GPcv6VsG55dHGe+Nigr1PxNT8bMXbLHLvijUE
   k8KeFydjpui8YA83nrocBaA8io6USNKDhW2CHtYd1AZfdid0mNGxGHYAz
   H3s/MkvIobcz3VzK/DBY8Ehs4v38iEPYCum1msJ7hZMahs+YiKZaWb2hT
   JUFtDUBZaMlvXYWXrbEyjsPaGtI4O6LqjSbssn6Lph3cAqtK7OIEkF1xI
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10534"; a="314054695"
X-IronPort-AV: E=Sophos;i="5.96,172,1665471600"; 
   d="scan'208";a="314054695"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2022 08:57:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10534"; a="672877878"
X-IronPort-AV: E=Sophos;i="5.96,172,1665471600"; 
   d="scan'208";a="672877878"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 17 Nov 2022 08:57:51 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 7C3532B7; Thu, 17 Nov 2022 18:58:16 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Subject: [PATCH v3 1/1] pwm: core: Remove S_IFREG from debugfs_create_file()
Date:   Thu, 17 Nov 2022 18:58:12 +0200
Message-Id: <20221117165812.27757-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
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

The debugfs_create_file() already has a check and adds S_IFREG
automatically. Remove unneeded flag.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v3: resent as a standalone patch (Uwe)
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

