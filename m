Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 290AD622EBF
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 16:07:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231895AbiKIPHg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 10:07:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231940AbiKIPHY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 10:07:24 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41D9C1C429;
        Wed,  9 Nov 2022 07:07:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668006438; x=1699542438;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vkdjifLpDIz2k79GbiPxj/nDQjo5PWlLax+xg6MpmuQ=;
  b=WLrl5BtTzaQVD6Phu+j9qFgXnRGpIDylL/P7tuN3lr6tTcVQ+NxzDhSX
   TF7kVX/HPSXWkDNVLjUx/nRxGWFVpHcyOXKcgndaUaakfOb19+1erxxpq
   bb5vE4UtYAaHqMhMvFR5e42bpNunZBJYgGv9F+7h8qx4EjX/hiOlAZsDp
   o6sJu8BshdwGnFOItmVarDb2f9Ta+SkfnnWSlGeWJLMcjSWSxtdHfcatf
   Md4N8c/xI+uM7xYUs3YL8fkdJBV+3amfP/wi0mcV0JFMKln8NpV6q6JYL
   g7B/ilySBOzi1pjoHV9bNj0VYI+jpqipSpgiiyl3i/n8fN9s2ltMUztmG
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10526"; a="312798262"
X-IronPort-AV: E=Sophos;i="5.96,150,1665471600"; 
   d="scan'208";a="312798262"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2022 07:07:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10526"; a="705736999"
X-IronPort-AV: E=Sophos;i="5.96,150,1665471600"; 
   d="scan'208";a="705736999"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 09 Nov 2022 07:07:15 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 0D08C155; Wed,  9 Nov 2022 17:07:39 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 2/2] gpiolib: of: Drop redundant check in of_mm_gpiochip_remove()
Date:   Wed,  9 Nov 2022 17:07:34 +0200
Message-Id: <20221109150734.38874-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221109150734.38874-1-andriy.shevchenko@linux.intel.com>
References: <20221109150734.38874-1-andriy.shevchenko@linux.intel.com>
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

The callers never call the function with invalid pointer.
Moreover, compiler quite likely dropped that check anyway
because we use that pointer before the check.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpio/gpiolib-of.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
index feeb9e8e846d..83997434215e 100644
--- a/drivers/gpio/gpiolib-of.c
+++ b/drivers/gpio/gpiolib-of.c
@@ -963,9 +963,6 @@ void of_mm_gpiochip_remove(struct of_mm_gpio_chip *mm_gc)
 {
 	struct gpio_chip *gc = &mm_gc->gc;
 
-	if (!mm_gc)
-		return;
-
 	gpiochip_remove(gc);
 	iounmap(mm_gc->regs);
 	kfree(gc->label);
-- 
2.35.1

