Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C555C74D23F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 11:51:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbjGJJvu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 05:51:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233109AbjGJJu6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 05:50:58 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D04F3EE;
        Mon, 10 Jul 2023 02:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688982404; x=1720518404;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=uXugLi1fmKBrAebmGx6Upi+jSUgvd/xrP2azX6cr4N0=;
  b=maSyQDt7L9uJOQdhION68YRr+o06eyy13nTBVStVQHSDRviFJdBqjWYw
   Yyrrq9ThsOoUx+DO5DPHSRlkoc5+icNaKqCOqVtLJOLvqCTjyehLXHWxv
   cv5wWbzuNTAHyhJ0I7BaGZvRUVgjUWcxDFGKTqOvOS2iOssrycLviUfO2
   gFDhmr8FmnDb0OlUDGdHN0v3cXq3Hm1Fd+rQNijyym6QkXIcSresIZyR4
   wnY+JJZPc/k4CWgUAlsbQqJMEqxYeTtae3jwGYohtiAOGJ/W1WTRCFkAN
   2+luX6iX5H8r6xIYPtBh3d3Sx8rATm/BeVWD5zsyTxrhVn1mbR90+CoaP
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10766"; a="367796426"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="367796426"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2023 02:46:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10766"; a="844813161"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="844813161"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 10 Jul 2023 02:46:41 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 8193A1FC; Mon, 10 Jul 2023 12:46:46 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Bin Liu <b-liu@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v2 1/1] usb: musb: Use read_poll_timeout()
Date:   Mon, 10 Jul 2023 12:46:45 +0300
Message-Id: <20230710094645.42111-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use read_poll_timeout() instead of open coding it.
In the same time, fix the typo in the error message.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: added tag (Linus), bumped sleep_us to descrease number of attempts
 drivers/usb/musb/tusb6010.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/usb/musb/tusb6010.c b/drivers/usb/musb/tusb6010.c
index cbc707fe570f..461587629bf2 100644
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
+	ret = read_poll_timeout(gpiod_get_value, reg, !reg, 5000, 100000, true,
+				glue->intpin);
+	if (ret) {
+		pr_err("tusb: Powerup response failed\n");
+		return ret;
 	}
 
 	spin_lock_irqsave(&musb->lock, flags);
-- 
2.40.0.1.gaa8946217a0b

