Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 776C36ACE9B
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 20:56:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230269AbjCFT4C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 14:56:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230018AbjCFTzp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 14:55:45 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5DB566D03;
        Mon,  6 Mar 2023 11:55:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678132541; x=1709668541;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eW58SfrFEF8kWU8i6jmdX+uDYLVUH74J/iJvZmyuLPI=;
  b=ID1AJ2P8jY4AqR7ZT1IypnLatK4OUlNCNNtsS7iHS2sdWLj7UGN2XroD
   72d9T4JndoF4bV40nzh9GAIT92bL/7xP5Y/jxtw+dYlrB9m7RILKR/yC9
   AE49h4ggQDKnlslXkN+LjA39BNZblQbRjOM7XH+2ciu5yrSBxsB761ObE
   IReKFSWbI7tURVD4Ybv4ZHF5nrRxRb4X1O13aoBZ9r9R4QL77xBcdjHXd
   EFG4mySsqSl6BHFfoh2T8P/vu95Sc2vemKnaZSb0FOLlkZAucLR0bujJV
   nhWTGsPsclCATNha3322BkZ2JVQ2/yJphO6PBnWvWYnSoSlCnqcesrhlV
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="333128988"
X-IronPort-AV: E=Sophos;i="5.98,238,1673942400"; 
   d="scan'208";a="333128988"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2023 11:55:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="745185193"
X-IronPort-AV: E=Sophos;i="5.98,238,1673942400"; 
   d="scan'208";a="745185193"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 06 Mar 2023 11:55:34 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id ACE8F14F; Mon,  6 Mar 2023 21:56:12 +0200 (EET)
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
Subject: [PATCH v1 10/16] gpio: mvebu: Utilize helpers from string_choices.h
Date:   Mon,  6 Mar 2023 21:55:50 +0200
Message-Id: <20230306195556.55475-11-andriy.shevchenko@linux.intel.com>
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
 drivers/gpio/gpio-mvebu.c | 27 ++++++++++++---------------
 1 file changed, 12 insertions(+), 15 deletions(-)

diff --git a/drivers/gpio/gpio-mvebu.c b/drivers/gpio/gpio-mvebu.c
index a68f682aec01..f2bbe928577c 100644
--- a/drivers/gpio/gpio-mvebu.c
+++ b/drivers/gpio/gpio-mvebu.c
@@ -48,6 +48,7 @@
 #include <linux/pwm.h>
 #include <linux/regmap.h>
 #include <linux/slab.h>
+#include <linux/string_choices.h>
 
 /*
  * GPIO unit register offsets.
@@ -897,32 +898,28 @@ static void mvebu_gpio_dbg_show(struct seq_file *s, struct gpio_chip *chip)
 	lvl_msk	= mvebu_gpio_read_level_mask(mvchip);
 
 	for_each_requested_gpio(chip, i, label) {
-		u32 msk;
-		bool is_out;
+		u32 msk = BIT(i);
 
-		msk = BIT(i);
-		is_out = !(io_conf & msk);
+		seq_printf(s, " gpio-%-3d (%-20.20s) %-3.3s ", chip->base + i, label,
+			   str_in_out(io_conf & msk));
 
-		seq_printf(s, " gpio-%-3d (%-20.20s)", chip->base + i, label);
-
-		if (is_out) {
-			seq_printf(s, " out %s %s\n",
-				   out & msk ? "hi" : "lo",
+		if (!(io_conf & msk)) {
+			seq_printf(s, "%-2.2s %s\n", str_hi_lo(out & msk),
 				   blink & msk ? "(blink )" : "");
 			continue;
 		}
 
-		seq_printf(s, " in  %s (act %s) - IRQ",
-			   (data_in ^ in_pol) & msk  ? "hi" : "lo",
-			   in_pol & msk ? "lo" : "hi");
+		seq_printf(s, "%-2.2s (act %-2.2s) - IRQ ",
+			   str_hi_lo((data_in ^ in_pol) & msk),
+			   str_lo_hi(in_pol & msk));
 		if (!((edg_msk | lvl_msk) & msk)) {
-			seq_puts(s, " disabled\n");
+			seq_puts(s, "disabled\n");
 			continue;
 		}
 		if (edg_msk & msk)
-			seq_puts(s, " edge ");
+			seq_puts(s, "edge ");
 		if (lvl_msk & msk)
-			seq_puts(s, " level");
+			seq_puts(s, "level");
 		seq_printf(s, " (%s)\n", cause & msk ? "pending" : "clear  ");
 	}
 }
-- 
2.39.1

