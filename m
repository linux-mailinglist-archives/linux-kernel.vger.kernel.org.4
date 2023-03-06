Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A9566ACEAB
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 20:56:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbjCFT4i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 14:56:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230096AbjCFT4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 14:56:16 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C8D7664C7;
        Mon,  6 Mar 2023 11:55:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678132552; x=1709668552;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=z9mXunzTxFtyQxWYx0D3ZdzQzJ0LQXRYVBzePKOyr2Y=;
  b=Ih5XHDYMjtD0cz0TMSQiXyHKSDKfnufpV//bJv0nhLgh5Wbn6VNAkcXw
   bpYN+QoLmOa9H7/Lm0940umiZUNAJZIwFQaJ2HcreJpdGOzM5fFaYOHem
   xiV8QTV28OLCjWT14GoTtXIx4bd4TdYV7Sg7/86jtGwC4CWWa8NCDiwbz
   3MAGB+5ke+hfAaTIchNwV/1+nfWWu08UXf9sxQpWekfdAfnQliH+Ohy+R
   6I4g1VUZ4hqLFOk69zK60pfoUz11VVNM32ZIvrk5DENmn9wNxUYOWAB1x
   2r7bC38Wq2lUyO+R1d64CHuzasZKvhYqHGi6LJ+vXOXjhZBvPIvCRV/68
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="333129039"
X-IronPort-AV: E=Sophos;i="5.98,238,1673942400"; 
   d="scan'208";a="333129039"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2023 11:55:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="745185205"
X-IronPort-AV: E=Sophos;i="5.98,238,1673942400"; 
   d="scan'208";a="745185205"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 06 Mar 2023 11:55:36 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id EDC5787; Mon,  6 Mar 2023 21:56:12 +0200 (EET)
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
Subject: [PATCH v1 16/16] gpio: xra1403: Utilize helpers from string_choices.h
Date:   Mon,  6 Mar 2023 21:55:56 +0200
Message-Id: <20230306195556.55475-17-andriy.shevchenko@linux.intel.com>
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

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpio/gpio-xra1403.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-xra1403.c b/drivers/gpio/gpio-xra1403.c
index 49c878cfd5c6..bc17beaba9e7 100644
--- a/drivers/gpio/gpio-xra1403.c
+++ b/drivers/gpio/gpio-xra1403.c
@@ -15,6 +15,7 @@
 #include <linux/seq_file.h>
 #include <linux/spi/spi.h>
 #include <linux/regmap.h>
+#include <linux/string_choices.h>
 
 /* XRA1403 registers */
 #define XRA_GSR   0x00 /* GPIO State */
@@ -140,8 +141,8 @@ static void xra1403_dbg_show(struct seq_file *s, struct gpio_chip *chip)
 	for_each_requested_gpio(chip, i, label) {
 		seq_printf(s, " gpio-%-3d (%-12s) %s %s\n",
 			   chip->base + i, label,
-			   (gcr & BIT(i)) ? "in" : "out",
-			   (gsr & BIT(i)) ? "hi" : "lo");
+			   str_in_out(gcr & BIT(i)),
+			   str_hi_lo(gsr & BIT(i)));
 	}
 }
 #else
-- 
2.39.1

