Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61481667C03
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 17:54:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241028AbjALQxl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 11:53:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241649AbjALQvB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 11:51:01 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24C3263D32;
        Thu, 12 Jan 2023 08:39:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673541589; x=1705077589;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=fCnoikO59aYEJe3y7pYtBBoi1zVtcj8w0L1hqCtMZDc=;
  b=BeCHN4R7b2LeS2zURQ9KIGTdmsdeE2vj306BKsmq3vv+EKI+k1z8Uh/+
   04E0gdLBN6NbeQY8BCnqgOmVmyGr6MK4snIBruFz9WwuCN0EG7U8zy/mc
   igBv2ZY1W4S95H9dSwwA+0yQNfCXZlEfdMmkhSqNc7FM+M2WfjQYPCQJZ
   WS8Rt+K6LliP0bpHOwSrs3jeaiicqU5FN+ccR29zTaAOc3Sk+dY/2YhDX
   eOSWIDHhTGwkYSr1G5NOzzE8QiElIYd5dQnsd7K/+GRbVzaDxoSm+7Wyh
   5lmZOxGol/+19l56rYOPBGNwPAbxIDaQqcksl8IbQN5IcpJpQo6ndRFSD
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="323814543"
X-IronPort-AV: E=Sophos;i="5.97,211,1669104000"; 
   d="scan'208";a="323814543"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2023 08:39:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="721153141"
X-IronPort-AV: E=Sophos;i="5.97,211,1669104000"; 
   d="scan'208";a="721153141"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 12 Jan 2023 08:39:19 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 9FD4CE1; Thu, 12 Jan 2023 18:39:53 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
        Srinivas Neeli <srinivas.neeli@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH v1 1/1] gpio: xilinx: Remove duplicate assignment of of_gpio_n_cells
Date:   Thu, 12 Jan 2023 18:39:51 +0200
Message-Id: <20230112163951.73180-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.39.0
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

The of_gpio_n_cells default is 2 when ->of_xlate() callback is
not defined. No need to assign it explicitly in the driver.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpio/gpio-xilinx.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/gpio/gpio-xilinx.c b/drivers/gpio/gpio-xilinx.c
index 619a00ad71d4..bbcde91135b9 100644
--- a/drivers/gpio/gpio-xilinx.c
+++ b/drivers/gpio/gpio-xilinx.c
@@ -558,7 +558,6 @@ static int xgpio_probe(struct platform_device *pdev)
 	int status = 0;
 	struct device_node *np = pdev->dev.of_node;
 	u32 is_dual = 0;
-	u32 cells = 2;
 	u32 width[2];
 	u32 state[2];
 	u32 dir[2];
@@ -591,15 +590,6 @@ static int xgpio_probe(struct platform_device *pdev)
 
 	bitmap_from_arr32(chip->dir, dir, 64);
 
-	/* Update cells with gpio-cells value */
-	if (of_property_read_u32(np, "#gpio-cells", &cells))
-		dev_dbg(&pdev->dev, "Missing gpio-cells property\n");
-
-	if (cells != 2) {
-		dev_err(&pdev->dev, "#gpio-cells mismatch\n");
-		return -EINVAL;
-	}
-
 	/*
 	 * Check device node and parent device node for device width
 	 * and assume default width of 32
@@ -630,7 +620,6 @@ static int xgpio_probe(struct platform_device *pdev)
 	chip->gc.parent = &pdev->dev;
 	chip->gc.direction_input = xgpio_dir_in;
 	chip->gc.direction_output = xgpio_dir_out;
-	chip->gc.of_gpio_n_cells = cells;
 	chip->gc.get = xgpio_get;
 	chip->gc.set = xgpio_set;
 	chip->gc.request = xgpio_request;
-- 
2.39.0

