Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E01D745C1B
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 14:20:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231367AbjGCMUL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 08:20:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231137AbjGCMUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 08:20:07 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B86D5E5A;
        Mon,  3 Jul 2023 05:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688386795; x=1719922795;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=k5UnOxzsmzHX8rVBq8egykKqk8gYOP5eLQBAC6d8nKg=;
  b=ci0LhAvfgk5AwN64rQLMqzfTDV39xDDgA27khQDT/+vYTQJmt1xJgjsF
   1OwWXB90AwveZprS+PLfUUrTvD4yad1uGbUq8oMo0KXpaINbTJ8jWDqef
   hTXfgEpmiXUA02dNloVDYf9zwDu9tl+77pqxQ9whWC9sBlTB7FnundAoV
   20lbSuRhHpz1QsDgrL6xBcOCPG1iZr34HrFF09iBxmnZCtnhPy6EoJ55U
   ZKN+pd0PPHS2SSBOzSlezRl0GVpmkXzWBylYoCcmwUlJzKonzOx04ee+4
   oYVysgsxgd3OakAbvjmO/rnNnPjDqU6zCsf/Q1ZudZRh9XnnLNIso4CZv
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10759"; a="365438266"
X-IronPort-AV: E=Sophos;i="6.01,178,1684825200"; 
   d="scan'208";a="365438266"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2023 05:19:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10759"; a="1049062932"
X-IronPort-AV: E=Sophos;i="6.01,178,1684825200"; 
   d="scan'208";a="1049062932"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 03 Jul 2023 05:19:36 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 6FC62170; Mon,  3 Jul 2023 15:19:39 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Bin Liu <b-liu@ti.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] usb: musb: Use read_poll_timeout()
Date:   Mon,  3 Jul 2023 15:19:36 +0300
Message-Id: <20230703121936.71623-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use read_poll_timeout() instead of open coding it.
In the same time, fix the typo in the error message.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/usb/musb/tusb6010.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/usb/musb/tusb6010.c b/drivers/usb/musb/tusb6010.c
index cbc707fe570f..2ae82e049f88 100644
--- a/drivers/usb/musb/tusb6010.c
+++ b/drivers/usb/musb/tusb6010.c
@@ -21,6 +21,7 @@
 #include <linux/usb.h>
 #include <linux/irq.h>
 #include <linux/io.h>
+#include <linux/iopoll.h>
 #include <linux/device.h>
 #include <linux/platform_device.h>
 #include <linux/dma-mapping.h>
@@ -1029,7 +1030,7 @@ static int tusb_musb_start(struct musb *musb)
 	void __iomem	*tbase = musb->ctrl_base;
 	unsigned long	flags;
 	u32		reg;
-	int		i;
+	int		ret;
 
 	/*
 	 * Enable or disable power to TUSB6010. When enabling, turn on 3.3 V and
@@ -1037,17 +1038,13 @@ static int tusb_musb_start(struct musb *musb)
 	 * provide then PGOOD signal to TUSB6010 which will release it from reset.
 	 */
 	gpiod_set_value(glue->enable, 1);
-	msleep(1);
 
 	/* Wait for 100ms until TUSB6010 pulls INT pin down */
-	i = 100;
-	while (i && gpiod_get_value(glue->intpin)) {
-		msleep(1);
-		i--;
-	}
-	if (!i) {
-		pr_err("tusb: Powerup respones failed\n");
-		return -ENODEV;
+	ret = read_poll_timeout(gpiod_get_value, reg, !reg, 1000, 100000, true,
+				glue->intpin);
+	if (ret) {
+		pr_err("tusb: Powerup response failed\n");
+		return ret;
 	}
 
 	spin_lock_irqsave(&musb->lock, flags);
-- 
2.40.0.1.gaa8946217a0b

