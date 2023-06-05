Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADEAA7226B2
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 14:59:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232251AbjFEM7N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 08:59:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbjFEM7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 08:59:10 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DED33FE;
        Mon,  5 Jun 2023 05:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685969924; x=1717505924;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=MEgj/vZSUbGWWbHpadQGpjjG8bL7wedFUW38lNf/E18=;
  b=CfrTuHpJSvspT0vkEl95OEKv7UvgfrTaJRt1W64IXIGVDfLGM3shrGFb
   56v460ZRJ7xhFUJTSLl8hMzLSBR0r++GHyeQnS4VsH0f420Aex0HlgN/F
   Mp3r7K68OPTrmd4crs9+PoJnPpStZYtF41VY1G4+Qh/ZU4scYDcDNFo8R
   FDtygqxn/0Dz7iWE4wJYSjEsZPDqEW8ZzjlKSoAb4p50RnEO5hcVSNCHN
   +E9HaVlmgyaiAMsqvCKgWNVlT0+plSttJp6VVB/lWdRxMbB0agMpd+RzJ
   OcUPM9qft1hYC5rnOKUrtxJm/s7Qevsi734N85HKSTv21BBFuwMUTkjW5
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10731"; a="356369588"
X-IronPort-AV: E=Sophos;i="6.00,217,1681196400"; 
   d="scan'208";a="356369588"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2023 05:58:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10731"; a="832798144"
X-IronPort-AV: E=Sophos;i="6.00,217,1681196400"; 
   d="scan'208";a="832798144"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 05 Jun 2023 05:58:05 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 0A75C2A6; Mon,  5 Jun 2023 15:58:11 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH v2 1/1] gpiolib: Do not unexport GPIO on freeing
Date:   Mon,  5 Jun 2023 15:58:10 +0300
Message-Id: <20230605125810.61456-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
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

Since the legacy exporting is gone with 2f804aca4832 ("gpiolib:
Kill unused GPIOF_EXPORT and Co") there is no need to unexport
GPIO on freeing. Remove that call.

Note, the other users of this functionality do that explicitly,
except one SH and one OMAP boardfile which don't free GPIO anyways,
so it is safe to drop the call.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: mentioned OMAP boardfile as well
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

