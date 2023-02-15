Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FD0E697DB1
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 14:42:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbjBONmS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 08:42:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbjBONmL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 08:42:11 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F098303DE;
        Wed, 15 Feb 2023 05:42:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676468530; x=1708004530;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9qzTqX1sMvCGDOOgeEkNzNV/AlsmIikK7nhU2r1jSzs=;
  b=PC6OegviLdS3ifY6mmEURo1n3MvnZbdzZLrYKqfrNHT29WyrIss/3RK5
   fq6YPBTjSEGFdRLCZLQhhZjwE4MtfdUUCLkflu7US3NtQ9y5GEiIPZVmB
   AxwGJ1RrIDii4sZ0vyXvPsZnp31d3iVfS9flpz51q/30HiHLT13XTofUh
   5xXvEJMu4ndZboBzfn6oh8uXhXXULmsjG8HHoWpsEe0+QxtC8QoLKF3Th
   pb7TyNBZZewudP4yivqF9C6shboK8tHJeUIYDNEEFNp4Jx6hIHjXX9sgb
   Rrmsen9xEtots4x47ACFVec9rvMJ8LZpa3+dmqOLP94t2R+XohxPvY7Zl
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="358849431"
X-IronPort-AV: E=Sophos;i="5.97,299,1669104000"; 
   d="scan'208";a="358849431"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2023 05:42:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="793502740"
X-IronPort-AV: E=Sophos;i="5.97,299,1669104000"; 
   d="scan'208";a="793502740"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 15 Feb 2023 05:42:04 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 54DF31C5; Wed, 15 Feb 2023 15:42:44 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ludovic Desroches <ludovic.desroches@microchip.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v3 2/5] pinctrl: at91: Don't mix non-devm calls with devm ones
Date:   Wed, 15 Feb 2023 15:42:39 +0200
Message-Id: <20230215134242.37618-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230215134242.37618-1-andriy.shevchenko@linux.intel.com>
References: <20230215134242.37618-1-andriy.shevchenko@linux.intel.com>
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
Reviewed-by: Claudiu Beznea <claudiu.beznea@microchip.com>
Tested-by: Claudiu Beznea <claudiu.beznea@microchip.com>
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

