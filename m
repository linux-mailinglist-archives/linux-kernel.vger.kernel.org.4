Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68C7665C251
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 15:54:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238079AbjACOwK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 09:52:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237665AbjACOvx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 09:51:53 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41444F580;
        Tue,  3 Jan 2023 06:51:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672757513; x=1704293513;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=CJNxDWf0SDtHR1aktd5x50aZoSIoYakJYJ7HaKKk2NI=;
  b=nsHL1qcmTzhRqCU9XOPH7zaThnO6PR6gS6pH9WhhQfnT9x21FYFA7mx1
   ISoQJ8loKIhp5lWR582FbbhN9DZKJYfJYM1htwuncK1IlK3TKB9V73UAV
   5TU25E/KOM2O+m+7PX2BAEoIMtsBOyf//vH2RyAGlDpFaKJV51HNEOCuc
   O5iqZpfd4/cip2mRzgSdihGenNcZvEo4/Q1h5tVb7svcWHeuhH9vxKQdY
   hEt9sQvZHclKdvqHn9uYAtIR3sRvqlVBJv3sTZvPsGnjZ6BlCm/El0HT0
   RxCWUTnfelPLBQ/geucanwlLG8G6h6hau6yvs8LtPhltDw1ypDsVwjJo2
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10579"; a="302047054"
X-IronPort-AV: E=Sophos;i="5.96,297,1665471600"; 
   d="scan'208";a="302047054"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2023 06:51:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10579"; a="685422749"
X-IronPort-AV: E=Sophos;i="5.96,297,1665471600"; 
   d="scan'208";a="685422749"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 03 Jan 2023 06:51:50 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id C328CF4; Tue,  3 Jan 2023 16:52:22 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Benjamin Mugnier <benjamin.mugnier@foss.st.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Sylvain Petinot <sylvain.petinot@foss.st.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] media: i2c: st-vgxy61: Use asm intead of asm-generic
Date:   Tue,  3 Jan 2023 16:52:19 +0200
Message-Id: <20230103145219.40226-1-andriy.shevchenko@linux.intel.com>
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

There is no point to specify asm-generic for the unaligned.h.
Drop the 'generic' suffix and move the inclusion to be after
the non-media linux/* ones.

Cc: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/media/i2c/st-vgxy61.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/media/i2c/st-vgxy61.c b/drivers/media/i2c/st-vgxy61.c
index 826baf4e064d..5dcabee6677d 100644
--- a/drivers/media/i2c/st-vgxy61.c
+++ b/drivers/media/i2c/st-vgxy61.c
@@ -5,7 +5,6 @@
  * Copyright (C) 2022 STMicroelectronics SA
  */
 
-#include <asm-generic/unaligned.h>
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/gpio/consumer.h>
@@ -15,6 +14,9 @@
 #include <linux/pm_runtime.h>
 #include <linux/regulator/consumer.h>
 #include <linux/units.h>
+
+#include <asm/unaligned.h>
+
 #include <media/mipi-csi2.h>
 #include <media/v4l2-async.h>
 #include <media/v4l2-ctrls.h>
-- 
2.35.1

