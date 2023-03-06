Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 613F76ACE9C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 20:56:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbjCFT4H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 14:56:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbjCFTzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 14:55:47 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47CE96BC3E;
        Mon,  6 Mar 2023 11:55:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678132542; x=1709668542;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QkJilS+dwGD4FvKKeEiSHbIXGMw2cebK2jx0ihhp9MY=;
  b=bQFBSjbA1O63VyFiqxH+Re8QDSlT8fBH1nIv+NjCSeX3c394RVIDXOj9
   lfWEuPhedLMWHaqz8+yhckHMBLWfhMc94a6owa0Uo8udgbNjk0Sbh1Lt9
   i9l5u2uZHfAIwidDQ/rE8td+O8Hvs06k08smCKSMyW26o/k9AXB8xFhA0
   9kTSnK0iDEPzUHCTzRM0jXUcHjN6LXtWMVBxDDq0pIVoQpTRYlNfZqVbH
   ikQWHLAUNQgHFozG+P8LvC9s6B743/CdrYJEinirOzE28xmjFlDzHzmr2
   Y300ZykWeRbIDXOiGTgn5xJfssBV/5dadz2OJNkSqFKvU4oxrfsJURh94
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="333128974"
X-IronPort-AV: E=Sophos;i="5.98,238,1673942400"; 
   d="scan'208";a="333128974"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2023 11:55:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="745185191"
X-IronPort-AV: E=Sophos;i="5.98,238,1673942400"; 
   d="scan'208";a="745185191"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 06 Mar 2023 11:55:34 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 95E3959E; Mon,  6 Mar 2023 21:56:12 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Schspa Shi <schspa@gmail.com>, Marc Zyngier <maz@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        patches@opensource.cirrus.com
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Doug Berger <opendmb@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Andy Shevchenko <andy@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Nandor Han <nandor.han@ge.com>,
        Semi Malinen <semi.malinen@ge.com>
Subject: [PATCH v1 08/16] gpio: crystalcove: Utilize helpers from string_choices.h
Date:   Mon,  6 Mar 2023 21:55:48 +0200
Message-Id: <20230306195556.55475-9-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230306195556.55475-1-andriy.shevchenko@linux.intel.com>
References: <20230306195556.55475-1-andriy.shevchenko@linux.intel.com>
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

There are a few helpers available to convert a boolean variable
to the dedicated string literals depending on the application.
Use them in the driver.

While at, utilize specifier field for padding the strings where
it's required.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpio/gpio-crystalcove.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/gpio/gpio-crystalcove.c b/drivers/gpio/gpio-crystalcove.c
index 1ee62cd58582..56d628b18397 100644
--- a/drivers/gpio/gpio-crystalcove.c
+++ b/drivers/gpio/gpio-crystalcove.c
@@ -15,6 +15,7 @@
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 #include <linux/seq_file.h>
+#include <linux/string_choices.h>
 #include <linux/types.h>
 
 #define CRYSTALCOVE_GPIO_NUM	16
@@ -315,15 +316,15 @@ static void crystalcove_gpio_dbg_show(struct seq_file *s, struct gpio_chip *chip
 			    &irq);
 
 		offset = gpio % 8;
-		seq_printf(s, " gpio-%-2d %s %s %s %s ctlo=%2x,%s %s %s\n",
-			   gpio, ctlo & CTLO_DIR_OUT ? "out" : "in ",
-			   ctli & 0x1 ? "hi" : "lo",
-			   ctli & CTLI_INTCNT_NE ? "fall" : "    ",
-			   ctli & CTLI_INTCNT_PE ? "rise" : "    ",
+		seq_printf(s, " gpio-%-2d %-3.3s %-2.2s %-4.4s %-4.4s ctlo=%2x,%-9.9s %-9.9s %s\n",
+			   gpio, str_out_in(ctlo & CTLO_DIR_OUT),
+			   str_hi_lo(ctli & BIT(0)),
+			   ctli & CTLI_INTCNT_NE ? "fall" : "",
+			   ctli & CTLI_INTCNT_PE ? "rise" : "",
 			   ctlo,
-			   mirqs0 & BIT(offset) ? "s0 mask  " : "s0 unmask",
-			   mirqsx & BIT(offset) ? "sx mask  " : "sx unmask",
-			   irq & BIT(offset) ? "pending" : "       ");
+			   mirqs0 & BIT(offset) ? "s0 mask" : "s0 unmask",
+			   mirqsx & BIT(offset) ? "sx mask" : "sx unmask",
+			   irq & BIT(offset) ? "pending" : "");
 	}
 }
 
-- 
2.39.1

