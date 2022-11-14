Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88287628888
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 19:46:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236681AbiKNSqM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 13:46:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236525AbiKNSqI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 13:46:08 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F182013F75;
        Mon, 14 Nov 2022 10:46:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668451568; x=1699987568;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=p9xXZ7oRWXft1etC6JnOSiiOdeH9ZPyYQGV7NIbMwgs=;
  b=euXhwPP/nmFaGJ25es547rF2Wb0U5pxtFlXQ0OdpvIrK86nvGYpnUik6
   isXFnqK/Z8Wf8siiXmVLNG6QNBsdoQl/7L5P9ZOoeJ9EwPY5C0wJV4tni
   qCHO0aGMqWyX+tw46ProB4DjwK4rke31N7rntOACQb8tLuhb9rwnLGSF8
   ed7LnaRKJMaNjlGC/nClm4mQIawUNmo/or0H75bcOGYPQQ/X0h1ekdYTT
   Vf0aCpd9S3CGrFXFP2/cyU+jwlu+2CEtZoo5QWw+DbwCdK/NM0wDqLCIP
   E+FBr6t6xKy1k+HSPqfXkBr621GuKnJ9/nKw/YTxKmC/fUjdmcH5XG0Pj
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="313197442"
X-IronPort-AV: E=Sophos;i="5.96,164,1665471600"; 
   d="scan'208";a="313197442"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2022 10:46:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="669773436"
X-IronPort-AV: E=Sophos;i="5.96,164,1665471600"; 
   d="scan'208";a="669773436"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 14 Nov 2022 10:46:05 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 8857DB7; Mon, 14 Nov 2022 20:46:29 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 2/2] gpiolib: of: Drop redundant check in of_mm_gpiochip_remove()
Date:   Mon, 14 Nov 2022 20:46:26 +0200
Message-Id: <20221114184626.64214-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221114184626.64214-1-andriy.shevchenko@linux.intel.com>
References: <20221114184626.64214-1-andriy.shevchenko@linux.intel.com>
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

The callers never call the function with invalid pointer.
Moreover, compiler quite likely dropped that check anyway
because we use that pointer before the check.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
v2: added tags (Linus, Dmitry)
 drivers/gpio/gpiolib-of.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
index d30a5210dfdd..f96cb6fe6831 100644
--- a/drivers/gpio/gpiolib-of.c
+++ b/drivers/gpio/gpiolib-of.c
@@ -962,9 +962,6 @@ void of_mm_gpiochip_remove(struct of_mm_gpio_chip *mm_gc)
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

