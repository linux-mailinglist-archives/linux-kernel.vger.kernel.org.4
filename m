Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A228694B86
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 16:45:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230399AbjBMPpJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 10:45:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231247AbjBMPpA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 10:45:00 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23332193E5;
        Mon, 13 Feb 2023 07:45:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676303100; x=1707839100;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ll159MuJ96PpKE3mCeyHLSWBuVer23prtFbhwbeYB74=;
  b=Y9tMvkc3pXsONTpcyl6yEE/DM0tzD1dwOU+CtILPKQ0v8fNr5nECiViK
   MT662o7/oShMuOsiQvGI0TkfjOqNd/ch/zb06OeBkk8Yp4CRlbf5gxMrY
   /1sL8rUcRz/dSFhwTuOqrX1UnVukpjtqoouuPMfQDip5XCgrlXB05mZId
   TgS1cAD8s6wFSvmjYCQwdHhAE2pr/iyLKALGHHC0UPXuTLHSzb/2soMw/
   SXk4pWnhJHaC5iNuo5D2+iDdmIThklYRAF6NJ/8y4r/eG6LIUqW7B0yGw
   7Xxd/Kb5W3/4PRPhNnodnPL0+dXfBPxMa99w25gYZrRGPFVcHVJV2tUr9
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10620"; a="318938342"
X-IronPort-AV: E=Sophos;i="5.97,294,1669104000"; 
   d="scan'208";a="318938342"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2023 07:44:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10620"; a="618682263"
X-IronPort-AV: E=Sophos;i="5.97,294,1669104000"; 
   d="scan'208";a="618682263"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 13 Feb 2023 07:44:55 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 21B551F8; Mon, 13 Feb 2023 17:45:35 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ludovic Desroches <ludovic.desroches@microchip.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 2/5] pinctrl: at91: Don't mix non-devm calls with devm ones
Date:   Mon, 13 Feb 2023 17:45:29 +0200
Message-Id: <20230213154532.32992-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230213154532.32992-1-andriy.shevchenko@linux.intel.com>
References: <20230213154532.32992-1-andriy.shevchenko@linux.intel.com>
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

Replace devm_clk_get() by devm_clk_get_enabled() and drop
unneeded code pieces. This will make sure we keep the ordering
of the resource allocation correct.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pinctrl/pinctrl-at91.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-at91.c b/drivers/pinctrl/pinctrl-at91.c
index 5c01765c7a2a..6d9015ed8a3b 100644
--- a/drivers/pinctrl/pinctrl-at91.c
+++ b/drivers/pinctrl/pinctrl-at91.c
@@ -1849,19 +1849,13 @@ static int at91_gpio_probe(struct platform_device *pdev)
 	at91_chip->pioc_virq = irq;
 	at91_chip->pioc_idx = alias_idx;
 
-	at91_chip->clock = devm_clk_get(&pdev->dev, NULL);
+	at91_chip->clock = devm_clk_get_enabled(&pdev->dev, NULL);
 	if (IS_ERR(at91_chip->clock)) {
 		dev_err(&pdev->dev, "failed to get clock, ignoring.\n");
 		ret = PTR_ERR(at91_chip->clock);
 		goto err;
 	}
 
-	ret = clk_prepare_enable(at91_chip->clock);
-	if (ret) {
-		dev_err(&pdev->dev, "failed to prepare and enable clock, ignoring.\n");
-		goto clk_enable_err;
-	}
-
 	at91_chip->chip = at91_gpio_template;
 	at91_chip->id = alias_idx;
 
@@ -1882,7 +1876,7 @@ static int at91_gpio_probe(struct platform_device *pdev)
 	names = devm_kasprintf_strarray(dev, "pio", chip->ngpio);
 	if (!names) {
 		ret = -ENOMEM;
-		goto clk_enable_err;
+		goto err;
 	}
 
 	for (i = 0; i < chip->ngpio; i++)
@@ -1915,8 +1909,6 @@ static int at91_gpio_probe(struct platform_device *pdev)
 	return 0;
 
 gpiochip_add_err:
-clk_enable_err:
-	clk_disable_unprepare(at91_chip->clock);
 err:
 	dev_err(&pdev->dev, "Failure %i for GPIO %i\n", ret, alias_idx);
 
-- 
2.39.1

