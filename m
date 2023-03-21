Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E6416C3356
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 14:52:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231240AbjCUNwm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 09:52:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbjCUNwk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 09:52:40 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB19937577;
        Tue, 21 Mar 2023 06:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679406758; x=1710942758;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ElaDzwECHs1yLLGCRJtXRT6LWmPM8YLMLk+UX7vVh/4=;
  b=bdqGiFBROYfXWK2+gIobHlkVq0P89SwNLz/Jp7zlE3/kDwrle6rNeeb9
   VtiX+7vv7mo6nPQ36oTOtjfqmI8AZV+FCJCy3/xFbN42j89Ye7CuIZ/5Y
   kjFMyeSAu5tuWswFNQ9aOF5riU7HvOyYmvMROZ50zu5EPWklNb4YemGIC
   QiH+/UjU0jHavJ3FNntmC2LnIcnK+Ck7lzq7a/I/cZY/u3TukeXZDgerG
   XinEoQ+pZ8FULvUkG3mpffUbw00krFuGoa2ev/TVoMxskhIbOwsS8N7Aw
   t2IcmTCI5RHbHuagf/qCdRzIiYr/J2uhHAzIXWIaXgnwyinnD8sygbn8t
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10656"; a="322782074"
X-IronPort-AV: E=Sophos;i="5.98,279,1673942400"; 
   d="scan'208";a="322782074"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2023 06:52:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10656"; a="745855523"
X-IronPort-AV: E=Sophos;i="5.98,279,1673942400"; 
   d="scan'208";a="745855523"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 21 Mar 2023 06:52:36 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 91FB93DD; Tue, 21 Mar 2023 15:53:22 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH v1 1/1] gpiolib: Split property name from the warning message
Date:   Tue, 21 Mar 2023 15:53:10 +0200
Message-Id: <20230321135310.73153-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Split property name from the warning message to make object file
shorter. The linker will use the single copy of it. It's fine
to pass a pointer to the printing function since it's a slow path
anyway.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpio/gpiolib.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 51a19cbe39a4..112d99a5eec4 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -403,8 +403,8 @@ static int gpiochip_set_names(struct gpio_chip *chip)
 	 * gpiochips.
 	 */
 	if (count <= chip->offset) {
-		dev_warn(dev, "gpio-line-names too short (length %d), cannot map names for the gpiochip at offset %u\n",
-			 count, chip->offset);
+		dev_warn(dev, "%s too short (length %d), cannot map names for the gpiochip at offset %u\n",
+			 "gpio-line-names", count, chip->offset);
 		return 0;
 	}
 
-- 
2.40.0.1.gaa8946217a0b

