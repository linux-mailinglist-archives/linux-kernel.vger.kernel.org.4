Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D0CB745C0A
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 14:18:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230246AbjGCMSw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 08:18:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbjGCMSs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 08:18:48 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1195A109;
        Mon,  3 Jul 2023 05:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688386728; x=1719922728;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iKjfzmoGgKnWfJYiwCW1KqBhCHm32seAtWfANjROfaY=;
  b=NlmUCFI5JKFFsAeEoLj1uo0WdMQyTwXWEBDhPcoDAJkWtxoByrvCHO2E
   UsNHbRiKGdJOO/qgAaVtD2yMjsCAn82URxivD2cBy1zFTwEL4hwcoVOTB
   uVtOt8HElUrwo40onnheSdUW61jhnyPce8p1qsDEW/pOMeO6v2loetP9I
   aQOAssOUbn+vmbgwhxDxKb1xBt4BA9DArnR83Bh8mYpTRzhLiKp8cZxhO
   dqGGCfSyYvJQJ4ohu1z0J8HEtJR6mNklcsA/GjRGhShHY58UE4DdTnBb5
   XOn7r6Fntae+Gz9I88y8uxBJlmyLKFoh1PXCJCZvEQKYsqe5f3zZVyFkr
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10759"; a="449242335"
X-IronPort-AV: E=Sophos;i="6.01,178,1684825200"; 
   d="scan'208";a="449242335"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2023 05:18:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10759"; a="863065884"
X-IronPort-AV: E=Sophos;i="6.01,178,1684825200"; 
   d="scan'208";a="863065884"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 03 Jul 2023 05:18:39 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 372D617C; Mon,  3 Jul 2023 15:18:42 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH v1 3/3] gpiolib: Do not alter GPIO chip fwnode member
Date:   Mon,  3 Jul 2023 15:18:38 +0300
Message-Id: <20230703121838.70898-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20230703121838.70898-1-andriy.shevchenko@linux.intel.com>
References: <20230703121838.70898-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ideally we should not touch data in the given GPIO chip structure.
Let's become closer to it by avoid altering fwnode member.

The GPIO library must use fwnode from GPIO device and the drivers
might use one from GPIO chip in case they initialized it.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpio/gpiolib.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index bc8b9d6afe0e..8b7032300039 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -708,13 +708,6 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
 	int base = 0;
 	int ret = 0;
 
-	/*
-	 * If the calling driver did not initialize firmware node, do it here
-	 * using the parent device, if any.
-	 */
-	if (!gc->fwnode && gc->parent)
-		gc->fwnode = dev_fwnode(gc->parent);
-
 	/*
 	 * First: allocate and populate the internal stat container, and
 	 * set up the struct device.
@@ -729,7 +722,14 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
 	gc->gpiodev = gdev;
 	gpiochip_set_data(gc, data);
 
-	device_set_node(&gdev->dev, gc->fwnode);
+	/*
+	 * If the calling driver did not initialize firmware node,
+	 * do it here using the parent device, if any.
+	 */
+	if (gc->fwnode)
+		device_set_node(&gdev->dev, gc->fwnode);
+	else if (gc->parent)
+		device_set_node(&gdev->dev, dev_fwnode(gc->parent));
 
 	gdev->id = ida_alloc(&gpio_ida, GFP_KERNEL);
 	if (gdev->id < 0) {
-- 
2.40.0.1.gaa8946217a0b

