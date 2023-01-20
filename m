Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 272706758F6
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 16:44:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231239AbjATPoT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 10:44:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbjATPoJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 10:44:09 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C49596A329;
        Fri, 20 Jan 2023 07:44:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674229448; x=1705765448;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RqbRnx0DzcmLHk0wnUNW8548wFkwKC+fI9KpOtosq6c=;
  b=cYsOsDUjw27nWLQLH4VBWH6bwvvKtz1R6gUnnMCtD8O09Z694vixs/97
   SHAO4t5Lz7bVRkLGp6PiyL+3RiAmK4dz2hHxOzMk9oPHqhnOzIZ/ngC55
   1bEuBtgvJsCUKJHlZ2rUROQyDIO34Rqpg+ExCeVDKW9Vy8sLxtUD86RLe
   Y4j30Qu3CqjOUejgEOT0nPsBmmVXIegtazJP9y0672g64hYeVjGGw9mtX
   T3CD3HgY/6Wsw2irboAHaO6WfwAo6jmp1mOnWsU4a4wtPYMB1srxKDEPp
   KznMItBFZQbO25kB1Wy9m/o+/olbOs2sBtHGuhku6Skw+adWUgydLzggc
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10596"; a="390114961"
X-IronPort-AV: E=Sophos;i="5.97,232,1669104000"; 
   d="scan'208";a="390114961"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2023 07:44:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10596"; a="989427702"
X-IronPort-AV: E=Sophos;i="5.97,232,1669104000"; 
   d="scan'208";a="989427702"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 20 Jan 2023 07:44:05 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 134CE38F; Fri, 20 Jan 2023 17:44:40 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 4/5] usb: fotg210: Switch to use dev_err_probe()
Date:   Fri, 20 Jan 2023 17:44:36 +0200
Message-Id: <20230120154437.22025-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230120154437.22025-1-andriy.shevchenko@linux.intel.com>
References: <20230120154437.22025-1-andriy.shevchenko@linux.intel.com>
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

Switch to use dev_err_probe() to simplify the error paths and
unify message template.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/usb/fotg210/fotg210-core.c | 6 ++----
 drivers/usb/fotg210/fotg210-hcd.c  | 8 +++-----
 drivers/usb/fotg210/fotg210-udc.c  | 2 +-
 3 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/usb/fotg210/fotg210-core.c b/drivers/usb/fotg210/fotg210-core.c
index c06f8eb3acbd..ce00d9407ce5 100644
--- a/drivers/usb/fotg210/fotg210-core.c
+++ b/drivers/usb/fotg210/fotg210-core.c
@@ -50,10 +50,8 @@ static int fotg210_gemini_init(struct fotg210 *fotg, struct resource *res,
 	int ret;
 
 	map = syscon_regmap_lookup_by_phandle(np, "syscon");
-	if (IS_ERR(map)) {
-		dev_err(dev, "no syscon\n");
-		return PTR_ERR(map);
-	}
+	if (IS_ERR(map))
+		return dev_err_probe(dev, PTR_ERR(map), "no syscon\n");
 	fotg->map = map;
 	wakeup = of_property_read_bool(np, "wakeup-source");
 
diff --git a/drivers/usb/fotg210/fotg210-hcd.c b/drivers/usb/fotg210/fotg210-hcd.c
index 5a934f5343a7..613d29f04bcb 100644
--- a/drivers/usb/fotg210/fotg210-hcd.c
+++ b/drivers/usb/fotg210/fotg210-hcd.c
@@ -5575,8 +5575,7 @@ int fotg210_hcd_probe(struct platform_device *pdev, struct fotg210 *fotg)
 	hcd = usb_create_hcd(&fotg210_fotg210_hc_driver, dev,
 			dev_name(dev));
 	if (!hcd) {
-		dev_err(dev, "failed to create hcd\n");
-		retval = -ENOMEM;
+		retval = dev_err_probe(dev, -ENOMEM, "failed to create hcd\n");
 		goto fail_create_hcd;
 	}
 
@@ -5600,7 +5599,7 @@ int fotg210_hcd_probe(struct platform_device *pdev, struct fotg210 *fotg)
 
 	retval = usb_add_hcd(hcd, irq, IRQF_SHARED);
 	if (retval) {
-		dev_err(dev, "failed to add hcd with err %d\n", retval);
+		dev_err_probe(dev, retval, "failed to add hcd\n");
 		goto failed_put_hcd;
 	}
 	device_wakeup_enable(hcd->self.controller);
@@ -5611,8 +5610,7 @@ int fotg210_hcd_probe(struct platform_device *pdev, struct fotg210 *fotg)
 failed_put_hcd:
 	usb_put_hcd(hcd);
 fail_create_hcd:
-	dev_err(dev, "init %s fail, %d\n", dev_name(dev), retval);
-	return retval;
+	return dev_err_probe(dev, retval, "init %s fail\n", dev_name(dev));
 }
 
 /*
diff --git a/drivers/usb/fotg210/fotg210-udc.c b/drivers/usb/fotg210/fotg210-udc.c
index 18d254125186..5b515f5cb2d7 100644
--- a/drivers/usb/fotg210/fotg210-udc.c
+++ b/drivers/usb/fotg210/fotg210-udc.c
@@ -1258,7 +1258,7 @@ int fotg210_udc_probe(struct platform_device *pdev, struct fotg210 *fotg)
 	ret = request_irq(irq, fotg210_irq, IRQF_SHARED,
 			  udc_name, fotg210);
 	if (ret < 0) {
-		dev_err(dev, "request_irq error (%d)\n", ret);
+		dev_err_probe(dev, ret, "request_irq error\n");
 		goto err_req;
 	}
 
-- 
2.39.0

