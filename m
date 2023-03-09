Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACFDA6B2D3B
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 19:56:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231140AbjCIS4H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 13:56:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjCIS4F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 13:56:05 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2160637FB;
        Thu,  9 Mar 2023 10:56:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678388164; x=1709924164;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=6hOXmOXtJFVPOFkTP/FI7Gap65pkHG6+MiLkeFpe28A=;
  b=E8d8uGcDJnAW6R6tMSOcmUG6lGuZNhTc/AqfSdI/tppxT+DhkX7KlJyz
   vjxHYUl3rTl0f4npAW8s82usFoOe1WjdJhKH3CAyVh3niazl4gKtdqHGl
   zeWV7lz328jM//LlZoIIbnbHOVVO4bIt1YZNxUB/w458kZErZq+XdrikE
   ngzGqSMxtVRLK2jXT2PDY6cCG5jDnXgd495TAhZ91tNMrqEtaI1fF8JnN
   AVPd7OghQKdQ9FgsJglD5AG3k3RNZGO1gxCn7hFhccuCyeW6vEdUwYBz/
   eBb4GfZMPeWWDxmnXQzRLEYUFJjNCtyoxD8EojzcFMCfKwFSDwR5SJWwL
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10644"; a="336550865"
X-IronPort-AV: E=Sophos;i="5.98,247,1673942400"; 
   d="scan'208";a="336550865"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2023 10:55:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10644"; a="1006849488"
X-IronPort-AV: E=Sophos;i="5.98,247,1673942400"; 
   d="scan'208";a="1006849488"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 09 Mar 2023 10:55:47 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id ED31D143; Thu,  9 Mar 2023 20:56:31 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH v1 1/1] gpiolib: Remove duplicative check in gpiod_find_and_request()
Date:   Thu,  9 Mar 2023 20:56:26 +0200
Message-Id: <20230309185626.84997-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.39.1
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

The gpiod_find_by_fwnode() already checks for NULL and returns
correct error code in case fwnode is invalid. Drop the respective
check and assignment in the gpiod_find_and_request().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpio/gpiolib.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 8ecfe3afde1e..333ccd44e2b2 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -3927,13 +3927,10 @@ static struct gpio_desc *gpiod_find_and_request(struct device *consumer,
 						bool platform_lookup_allowed)
 {
 	unsigned long lookupflags = GPIO_LOOKUP_FLAGS_DEFAULT;
-	struct gpio_desc *desc = ERR_PTR(-ENOENT);
+	struct gpio_desc *desc;
 	int ret;
 
-	if (!IS_ERR_OR_NULL(fwnode))
-		desc = gpiod_find_by_fwnode(fwnode, consumer, con_id, idx,
-					    &flags, &lookupflags);
-
+	desc = gpiod_find_by_fwnode(fwnode, consumer, con_id, idx, &flags, &lookupflags);
 	if (gpiod_not_found(desc) && platform_lookup_allowed) {
 		/*
 		 * Either we are not using DT or ACPI, or their lookup did not
-- 
2.39.1

