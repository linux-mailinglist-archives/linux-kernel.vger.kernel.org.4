Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D6626ACE98
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 20:56:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230250AbjCFTz6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 14:55:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbjCFTzl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 14:55:41 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E898D59427;
        Mon,  6 Mar 2023 11:55:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678132540; x=1709668540;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EDvZyVrBDVc7Nwzs9i+qoHy3DJw3++NSTTOOF+lSAxI=;
  b=elBBbmFOveSrjoKIlVza1kPML3XJ5AJUUtkLgfZNLpnRkRuHjhVbfdJe
   rQctpexiGsmUo6FV68vzAAFz6RyIULnAlT5M8Zg2MhcfaMA9aS43upntQ
   abIg7o/rcOYiGhqQwSgc2y04OZyYbp9IykiEbWtxG1sjthg04FHkw8QNE
   d3LxlNLJgFxLi0/gAHzpDCqTF5IvPdfm7gbKl+QAHeV+Xq4t0mDfi0Gip
   gLLfI45hSwTDMeksA80JlY3Cy/wXS5PMP4e7JFqj/sJlh2buhUNuNo+uu
   9Y8M0YwrtogbtbwZY5uwW+mwkRuD3ga5XZt3wO7ooqHIOMAUQBHXNi2JJ
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="400483922"
X-IronPort-AV: E=Sophos;i="5.98,238,1673942400"; 
   d="scan'208";a="400483922"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2023 11:55:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="1005549582"
X-IronPort-AV: E=Sophos;i="5.98,238,1673942400"; 
   d="scan'208";a="1005549582"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 06 Mar 2023 11:55:34 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id C33FB5F8; Mon,  6 Mar 2023 21:56:12 +0200 (EET)
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
Subject: [PATCH v1 12/16] gpio: stmpe: Utilize helpers from string_choices.h
Date:   Mon,  6 Mar 2023 21:55:52 +0200
Message-Id: <20230306195556.55475-13-andriy.shevchenko@linux.intel.com>
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
 drivers/gpio/gpio-stmpe.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/drivers/gpio/gpio-stmpe.c b/drivers/gpio/gpio-stmpe.c
index 0fa4f0a93378..ca8a98b252c2 100644
--- a/drivers/gpio/gpio-stmpe.c
+++ b/drivers/gpio/gpio-stmpe.c
@@ -14,6 +14,7 @@
 #include <linux/mfd/stmpe.h>
 #include <linux/seq_file.h>
 #include <linux/bitops.h>
+#include <linux/string_choices.h>
 
 /*
  * These registers are modified under the irq bus lock and cached to avoid
@@ -264,12 +265,12 @@ static void stmpe_dbg_show_one(struct seq_file *s,
 	ret = stmpe_reg_read(stmpe, dir_reg);
 	if (ret < 0)
 		return;
-	dir = !!(ret & mask);
 
+	dir = !!(ret & mask);
+	seq_printf(s, " gpio-%-3d (%-20.20s) %-3.3s %-2.2s ", gpio,
+		   label ?: "(none)", str_out_in(dir), str_hi_lo(val));
 	if (dir) {
-		seq_printf(s, " gpio-%-3d (%-20.20s) out %s",
-			   gpio, label ?: "(none)",
-			   val ? "hi" : "lo");
+		seq_putc(s, '\n');
 	} else {
 		u8 edge_det_reg;
 		u8 rise_reg;
@@ -336,11 +337,9 @@ static void stmpe_dbg_show_one(struct seq_file *s,
 			return;
 		irqen = !!(ret & mask);
 
-		seq_printf(s, " gpio-%-3d (%-20.20s) in  %s %13s %13s %25s %25s",
-			   gpio, label ?: "(none)",
-			   val ? "hi" : "lo",
+		seq_printf(s, "%13s IRQ-%9s %25s %25s\n",
 			   edge_det_values[edge_det],
-			   irqen ? "IRQ-enabled" : "IRQ-disabled",
+			   str_enabled_disabled(irqen),
 			   rise_values[rise],
 			   fall_values[fall]);
 	}
@@ -351,10 +350,8 @@ static void stmpe_dbg_show(struct seq_file *s, struct gpio_chip *gc)
 	unsigned i;
 	unsigned gpio = gc->base;
 
-	for (i = 0; i < gc->ngpio; i++, gpio++) {
+	for (i = 0; i < gc->ngpio; i++, gpio++)
 		stmpe_dbg_show_one(s, gc, i, gpio);
-		seq_putc(s, '\n');
-	}
 }
 
 static struct irq_chip stmpe_gpio_irq_chip = {
-- 
2.39.1

