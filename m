Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D22D16ACE96
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 20:55:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230196AbjCFTzw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 14:55:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbjCFTzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 14:55:37 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C681664C6;
        Mon,  6 Mar 2023 11:55:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678132536; x=1709668536;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tShFWIVCdDeqrNoh0yuO5Gnio4e4ieLf0f/Lj6I9KNA=;
  b=iWklsGNCdF7Ojl6Kg8e0oXm2Nx7aPDdgCHsQh1fJKxL2Lh07gg47Kq2d
   8VFTbdrUsY+CgTuyiHJjAfsTEsKMEdWtODqG18yOTPLl0y3/klNgkON2K
   tx91bJ0jUUXz0eZ91VDs8cSwEvvTaWoCvt5V8P1+fIqgc8/G8hMi1bf0b
   DHAH5CdwLW4rSqvf91WpJYwMbI0Re5I7sLtOYFXoDG7T9HPyG4VRhYKrQ
   riZgxayVbjdEHRGLIijYZB17T8YZSitikw8Hbn4XUI9iP0jTdpCgL0etm
   18IKiTRXw7QZxzpiHTdeeHFPd7sYjRHNtB34bLPBu9ZJvye5npleBB/Vb
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="400483899"
X-IronPort-AV: E=Sophos;i="5.98,238,1673942400"; 
   d="scan'208";a="400483899"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2023 11:55:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="1005549565"
X-IronPort-AV: E=Sophos;i="5.98,238,1673942400"; 
   d="scan'208";a="1005549565"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 06 Mar 2023 11:55:29 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 8366246E; Mon,  6 Mar 2023 21:56:12 +0200 (EET)
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
Subject: [PATCH v1 06/16] gpio: adnp: Utilize helpers from string_choices.h
Date:   Mon,  6 Mar 2023 21:55:46 +0200
Message-Id: <20230306195556.55475-7-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230306195556.55475-1-andriy.shevchenko@linux.intel.com>
References: <20230306195556.55475-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
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
 drivers/gpio/gpio-adnp.c | 24 ++++++------------------
 1 file changed, 6 insertions(+), 18 deletions(-)

diff --git a/drivers/gpio/gpio-adnp.c b/drivers/gpio/gpio-adnp.c
index a6439e3daff0..823cad855ee8 100644
--- a/drivers/gpio/gpio-adnp.c
+++ b/drivers/gpio/gpio-adnp.c
@@ -11,6 +11,7 @@
 #include <linux/property.h>
 #include <linux/seq_file.h>
 #include <linux/slab.h>
+#include <linux/string_choices.h>
 
 #define GPIO_DDR(gpio) (0x00 << (gpio)->reg_shift)
 #define GPIO_PLR(gpio) (0x01 << (gpio)->reg_shift)
@@ -211,25 +212,12 @@ static void adnp_gpio_dbg_show(struct seq_file *s, struct gpio_chip *chip)
 
 		for (j = 0; j < 8; j++) {
 			unsigned int bit = (i << adnp->reg_shift) + j;
-			const char *direction = "input ";
-			const char *level = "low ";
-			const char *interrupt = "disabled";
-			const char *pending = "";
 
-			if (ddr & BIT(j))
-				direction = "output";
-
-			if (plr & BIT(j))
-				level = "high";
-
-			if (ier & BIT(j))
-				interrupt = "enabled ";
-
-			if (isr & BIT(j))
-				pending = "pending";
-
-			seq_printf(s, "%2u: %s %s IRQ %s %s\n", bit,
-				   direction, level, interrupt, pending);
+			seq_printf(s, "%2u: %-6.6s %-4.4s IRQ %-8.8s %s\n", bit,
+				   str_output_input(ddr & BIT(j)),
+				   str_high_low(plr & BIT(j)),
+				   str_enabled_disabled(ier & BIT(j)),
+				   (isr & BIT(j)) ? "pending" : "");
 		}
 	}
 
-- 
2.39.1

