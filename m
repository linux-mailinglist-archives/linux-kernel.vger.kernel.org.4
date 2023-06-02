Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64D84720776
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 18:23:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236730AbjFBQXT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 12:23:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236669AbjFBQXP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 12:23:15 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EA71134;
        Fri,  2 Jun 2023 09:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685722988; x=1717258988;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=D6Q5rWGlpmHtwgVhN5Hie8Q59qagQZGIMKL1f1NJt28=;
  b=Up1ywTy7RRBKFG9CRzBRSc1c3jIjZUSDsJYlUu1C9n9Ui82bT19/7GrQ
   9hgz+STt6aTZawW4a31cbsvY3WrTYO4DW0RrREZ21eHtU5ZXsDpNpWkD+
   IP/ny+dwp5DAdLGEyqrewMyIkVsJAkXJgjznjuX/E1spEOe9zeyw/tEpv
   /yYI7SNjRM0Q2yOKxx9k0NjDEclyxe8OITNbZOX+6+PKwHAU4y/lZHeZr
   BYRSTDFjU51SHdzvIT7EsE6B2xpxj5z3qVssq18/qel9VRrq+ncRnsz4j
   /PPcS74+DNki8ZbJQq2d1683DVj64sZknIW7xbXMix/d7t/KOS2oM6AaR
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10729"; a="336271614"
X-IronPort-AV: E=Sophos;i="6.00,213,1681196400"; 
   d="scan'208";a="336271614"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2023 09:22:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10729"; a="852214151"
X-IronPort-AV: E=Sophos;i="6.00,213,1681196400"; 
   d="scan'208";a="852214151"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 02 Jun 2023 09:22:53 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 7488A467; Fri,  2 Jun 2023 19:22:59 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH v1 1/1] gpiolib: Do not unexport GPIO on freeing
Date:   Fri,  2 Jun 2023 19:22:58 +0300
Message-Id: <20230602162258.63853-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the legacy exporting is gone with 2f804aca4832 ("gpiolib:
Kill unused GPIOF_EXPORT and Co") there is no need to unexport
GPIO on freeing. Remove that call.

Note, the other users of this functionality do that explicitly,
except one SH boardfile which doesn't free GPIO anyways, so it
is safe to drop the call.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpio/gpiolib.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index a8da38ee721a..7a9c9934365a 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -2117,8 +2117,6 @@ static bool gpiod_free_commit(struct gpio_desc *desc)
 
 	might_sleep();
 
-	gpiod_unexport(desc);
-
 	spin_lock_irqsave(&gpio_lock, flags);
 
 	gc = desc->gdev->chip;
-- 
2.40.0.1.gaa8946217a0b

