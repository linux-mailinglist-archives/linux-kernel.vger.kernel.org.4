Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C235622EBA
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 16:07:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231869AbiKIPHE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 10:07:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231758AbiKIPG4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 10:06:56 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AD301A810;
        Wed,  9 Nov 2022 07:06:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668006415; x=1699542415;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=vkdjifLpDIz2k79GbiPxj/nDQjo5PWlLax+xg6MpmuQ=;
  b=Dx3fWmbC83bjOofNg7hcMScn6sDLjHaojN+vk7xw31mLB0rJVrSSQWOG
   IE4cGnA46O+Sc2hQ3MHOR2o7x4B3YwydzJlX1RYEWRCAWOxzP6MeFvQtI
   YygVFSozW4h0ZOWRpTsVxEWY2UDMOt1OkYjopkBHOIZafvjR14iHF8KEG
   aCzo/zbjmYDidEODMSnOP+jUSBB3DKrdM0/+oF0aRKL8k9OtgE1ZQtnkZ
   gtdJdVMssfnXB1gnfXOj9sbqnusY41Md6ra1iHVAuv6V/dVoBzkLyr78n
   sN2QS5FjAfoAK96JmDvDUV3WXUbGUj/LvVENAOZ1m8HbOx5LdNB5+rED3
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10526"; a="291386812"
X-IronPort-AV: E=Sophos;i="5.96,150,1665471600"; 
   d="scan'208";a="291386812"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2022 07:06:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10526"; a="705736758"
X-IronPort-AV: E=Sophos;i="5.96,150,1665471600"; 
   d="scan'208";a="705736758"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 09 Nov 2022 07:06:45 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 4AF91155; Wed,  9 Nov 2022 17:07:09 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Raul E Rangel <rrangel@chromium.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v1 1/2] gpiolib: of: Drop redundant check in of_mm_gpiochip_remove()
Date:   Wed,  9 Nov 2022 17:07:05 +0200
Message-Id: <20221109150706.38823-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
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

