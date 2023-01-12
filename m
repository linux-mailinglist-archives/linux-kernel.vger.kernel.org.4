Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05CF9667BF8
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 17:53:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240717AbjALQw6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 11:52:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240904AbjALQs2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 11:48:28 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBDFA18E2E;
        Thu, 12 Jan 2023 08:39:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673541540; x=1705077540;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ZL8A1wTXhOBdyvD5BIV3kuTI9N5P4VK0MECUqy3cfYg=;
  b=lyZ401xcGUj9VPQc4JIc9UBhYWIDlnkSlvPTuykD/TRF1mJw/rz7aGtL
   wegnpP6bCSkUYY58g2Pox1oMWFQV8ueejh9u1UKqGutCgsvWw9W4qMSnF
   g7QsME9qipzJhG9dQj6fnoXIlOp3M3SPFwbw5BVR8tMkZvW5wiOUdp1Ys
   fZWSsLI0w+GSdpJwObrgLNIiY9+rA855NXkQ/jca884R1MskxYhLYkx9d
   nlt5Ijg0sN5aCxUX6/5FxLQNajVIZq5E+yvAPI5AzPCz0DeyL41kpXbXT
   AteeJR5jt8UsGog8jPZDbAOyT0U8aB2Tm9tgkXysU0FfRrBTBQD8iPuMH
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="386092124"
X-IronPort-AV: E=Sophos;i="5.97,211,1669104000"; 
   d="scan'208";a="386092124"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2023 08:38:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="659871862"
X-IronPort-AV: E=Sophos;i="5.97,211,1669104000"; 
   d="scan'208";a="659871862"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 12 Jan 2023 08:38:35 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 30E15E1; Thu, 12 Jan 2023 18:39:08 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH v1 1/1] gpio: ge: Remove duplicate assignment of of_gpio_n_cells
Date:   Thu, 12 Jan 2023 18:39:05 +0200
Message-Id: <20230112163905.73065-1-andriy.shevchenko@linux.intel.com>
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
 drivers/gpio/gpio-ge.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpio/gpio-ge.c b/drivers/gpio/gpio-ge.c
index f6a3de99f7db..7bd4c2a4cc11 100644
--- a/drivers/gpio/gpio-ge.c
+++ b/drivers/gpio/gpio-ge.c
@@ -81,7 +81,6 @@ static int __init gef_gpio_probe(struct platform_device *pdev)
 
 	gc->base = -1;
 	gc->ngpio = (u16)(uintptr_t)of_device_get_match_data(&pdev->dev);
-	gc->of_gpio_n_cells = 2;
 
 	/* This function adds a memory mapped GPIO chip */
 	ret = devm_gpiochip_add_data(&pdev->dev, gc, NULL);
-- 
2.39.0

