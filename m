Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4BB96150F7
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 18:42:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231222AbiKARmm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 13:42:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbiKARmi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 13:42:38 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB5BA1D0E6;
        Tue,  1 Nov 2022 10:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667324556; x=1698860556;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SbsFTojRHajkqxc6yQDWgDcq4VABF214el1jsXeM55s=;
  b=UvmfhpiaRo9PXBsFqP7lwaYFwVpHuEjJuZ95TSl3D03DvPY5iOXrJcAc
   yzXCEJW0Hgg6GI1v8CWBUg2/GIXvr/OnHiTmFXD5RS6Y8PaSz8BfqMnPI
   6NdVm0Ya9UVk9Fop2Y7g13bsMk4F3719YJVLKg71AcpFKM3PHFtfZgfD7
   8vz9kK1ZZQdNGMuFHW3h8Iq1sfRBBQ111Gho8j1yvhUKjvZojuvN6gBdk
   rZwXhk1uX8a5SxiJ6nX8+o0YcGXQASgciaEW6XEjadf8tB0krJOEwmG5c
   zG7ZBS+ImcEoAT5Y2HBs5mi53FVOlzFGXCHp8zc8rEgDg1v7Fl3KcaxvN
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="310909163"
X-IronPort-AV: E=Sophos;i="5.95,231,1661842800"; 
   d="scan'208";a="310909163"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2022 10:42:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="667272870"
X-IronPort-AV: E=Sophos;i="5.95,231,1661842800"; 
   d="scan'208";a="667272870"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 01 Nov 2022 10:42:34 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id F008F155; Tue,  1 Nov 2022 19:42:57 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 3/3] pwm: core: Remove S_IFREG from debugfs_create_file()
Date:   Tue,  1 Nov 2022 19:42:55 +0200
Message-Id: <20221101174255.54452-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221101174255.54452-1-andriy.shevchenko@linux.intel.com>
References: <20221101174255.54452-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The debugfs_create_file() already has a check and adds S_IFREG
automatically. Remove unneeded flag.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pwm/core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 36128f3301ac..c004a8a662d6 100644
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

