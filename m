Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84697667BF2
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 17:52:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240583AbjALQwn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 11:52:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241016AbjALQro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 11:47:44 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1F4F1A21E;
        Thu, 12 Jan 2023 08:38:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673541537; x=1705077537;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=DjhbpXJ4UzxzTVG+1M3vVGXgk0odHr0Gd679xzGxvLM=;
  b=Fh+RnI58gc4uWiVLFarYWY/GKsi15vZgJoa6Q4WDRzfZXnuixGMAC405
   w6+4a0xu6q82IPgXj9Y3ud5Wo07BWnjSB9F1XYKdY4PwZGKm8T6rUEt6r
   oQDIPK8tKfg2x/Pgauj7+eUcY7YZ98gnQHumfYatojLYDyCr16TJG0Yd6
   NM+AHKqKw2oau4yyjs4phgeHc0w/UUiXQHxR9fmne0d6gnGRdaGhT7Fpl
   Jcht2/nt/m55EHkGQY8TEtSm//et1K6CR50N5ERMblmt4bU8pF6qOIgYF
   nXB6NZdOgNjSJaGeWiUyF2VhMAOmJQgWmTk7mEE3Euq8pbmLgsYb2DLo9
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="386092098"
X-IronPort-AV: E=Sophos;i="5.97,211,1669104000"; 
   d="scan'208";a="386092098"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2023 08:38:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="659871828"
X-IronPort-AV: E=Sophos;i="5.97,211,1669104000"; 
   d="scan'208";a="659871828"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 12 Jan 2023 08:38:27 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 2ECE0E1; Thu, 12 Jan 2023 18:39:01 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Devarsh Thakkar <devarsht@ti.com>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Keerthy <j-keerthy@ti.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] gpio: davinci: Remove duplicate assignment of of_gpio_n_cells
Date:   Thu, 12 Jan 2023 18:38:55 +0200
Message-Id: <20230112163855.73032-1-andriy.shevchenko@linux.intel.com>
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
 drivers/gpio/gpio-davinci.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpio/gpio-davinci.c b/drivers/gpio/gpio-davinci.c
index e1c1b9a527db..26b1f7465e09 100644
--- a/drivers/gpio/gpio-davinci.c
+++ b/drivers/gpio/gpio-davinci.c
@@ -252,7 +252,6 @@ static int davinci_gpio_probe(struct platform_device *pdev)
 	chips->chip.base = pdata->no_auto_base ? pdata->base : -1;
 
 #ifdef CONFIG_OF_GPIO
-	chips->chip.of_gpio_n_cells = 2;
 	chips->chip.parent = dev;
 	chips->chip.request = gpiochip_generic_request;
 	chips->chip.free = gpiochip_generic_free;
-- 
2.39.0

