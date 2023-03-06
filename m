Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1BFC6ACEA4
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 20:56:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbjCFT4U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 14:56:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230227AbjCFTzv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 14:55:51 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 730AE7585A;
        Mon,  6 Mar 2023 11:55:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678132545; x=1709668545;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5nB1Cjf4Z6soJzkyRCy4W4jPVtCrh+QSwebJoZzzTHU=;
  b=FwAUEpaSGExn5eC9NtNZP3rmPDDCbVPRnA04unX4cNxt6BF+5RgMmS/z
   aiVpd8KAoipbYjLJik9KfdN3CmOVc1jYc5ImuP5Fk678lXXam+r4WWEAX
   7TKec04RhLFu2TAdzhjKoegcM/iwGCDDeuH1UsraB2E+jzp38k5DZY+oL
   MLOL31JGoUgrUoL6vlenYMUddU8eWDPmOhB7vo8ncU/lhJ8rIT+CKFWVL
   iKpXoDUA0T8hFBWKwjjk/3+i1qRD+lu69DdEqvFf2y+qnO1BUR/aTrayO
   1lDU/6dgau1OcfrDFpwgDm38tX0QjH76sP+79YdqYmztuPj6aVgPSzgJ8
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="333129031"
X-IronPort-AV: E=Sophos;i="5.98,238,1673942400"; 
   d="scan'208";a="333129031"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2023 11:55:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="745185197"
X-IronPort-AV: E=Sophos;i="5.98,238,1673942400"; 
   d="scan'208";a="745185197"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 06 Mar 2023 11:55:34 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id D96A063E; Mon,  6 Mar 2023 21:56:12 +0200 (EET)
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
Subject: [PATCH v1 14/16] gpio: wm831x: Utilize helpers from string_choices.h
Date:   Mon,  6 Mar 2023 21:55:54 +0200
Message-Id: <20230306195556.55475-15-andriy.shevchenko@linux.intel.com>
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
 drivers/gpio/gpio-wm831x.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-wm831x.c b/drivers/gpio/gpio-wm831x.c
index 7eaf8a28638c..5456485ce801 100644
--- a/drivers/gpio/gpio-wm831x.c
+++ b/drivers/gpio/gpio-wm831x.c
@@ -15,6 +15,7 @@
 #include <linux/mfd/core.h>
 #include <linux/platform_device.h>
 #include <linux/seq_file.h>
+#include <linux/string_choices.h>
 
 #include <linux/mfd/wm831x/core.h>
 #include <linux/mfd/wm831x/pdata.h>
@@ -229,8 +230,8 @@ static void wm831x_gpio_dbg_show(struct seq_file *s, struct gpio_chip *chip)
 
 		seq_printf(s, " %s %s %s %s%s\n"
 			   "                                  %s%s (0x%4x)\n",
-			   reg & WM831X_GPN_DIR ? "in" : "out",
-			   wm831x_gpio_get(chip, i) ? "high" : "low",
+			   str_in_out(reg & WM831X_GPN_DIR),
+			   str_high_low(wm831x_gpio_get(chip, i)),
 			   pull,
 			   powerdomain,
 			   reg & WM831X_GPN_POL ? "" : " inverted",
-- 
2.39.1

