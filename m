Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BD2D6490F5
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Dec 2022 23:05:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbiLJWFy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Dec 2022 17:05:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbiLJWFj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Dec 2022 17:05:39 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2883513CEB;
        Sat, 10 Dec 2022 14:05:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670709939; x=1702245939;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=N9GIhe+43+8kbtpf4SUGwC07xNhkTl9g7PMWCO7shEk=;
  b=DkaVK3Dy19fby5rI0Chy5g0tBZjq9GIA6u/6KMyOD206QsnwMudF8H7n
   Q1NDJPxnLT03QZOwEM5BD+ugLhp94A3C+nKB8HiSRCx8N5/UZrfwXPx4a
   goHIHIb5ki3nvw2wYRnYh/D6475mBp8pFtuWur37mRXx3yMGWg+OB2niO
   ZC4OiS0FxSglLvoQNFEbGXx3KtDcQvq0i+Xf9VAPzi2wjbnOB5GF3yHk3
   Pg2xre4QssOcVKxpnuVrOu9jjXliJ9r/rZc92SfOpltGlonBjOu1txsbc
   chh0gROadD904qt6C0xwb6yg6NI4Ou5uowKV8XX7qYdmGCZGxBCAJRsd1
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10557"; a="403907178"
X-IronPort-AV: E=Sophos;i="5.96,235,1665471600"; 
   d="scan'208";a="403907178"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2022 14:05:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10557"; a="625470513"
X-IronPort-AV: E=Sophos;i="5.96,235,1665471600"; 
   d="scan'208";a="625470513"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 10 Dec 2022 14:05:36 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 5D9946B1; Sun, 11 Dec 2022 00:06:05 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 3/4] gpio: pca953x: Clean up pcal6534_check_register()
Date:   Sun, 11 Dec 2022 00:06:00 +0200
Message-Id: <20221210220601.77648-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221210220601.77648-1-andriy.shevchenko@linux.intel.com>
References: <20221210220601.77648-1-andriy.shevchenko@linux.intel.com>
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

The pcal6534_check_register() is a bit too verbose.
Clean up it, by deduplicating some operations and
switching to the modulo operation as on some architectures
/ and % can become a single assembly instruction.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: new patch
 drivers/gpio/gpio-pca953x.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/drivers/gpio/gpio-pca953x.c b/drivers/gpio/gpio-pca953x.c
index 2c8586b3191f..8aba8df393bd 100644
--- a/drivers/gpio/gpio-pca953x.c
+++ b/drivers/gpio/gpio-pca953x.c
@@ -306,6 +306,7 @@ static bool pca953x_check_register(struct pca953x_chip *chip, unsigned int reg,
 static bool pcal6534_check_register(struct pca953x_chip *chip, unsigned int reg,
 				    u32 checkbank)
 {
+	int bank_shift;
 	int bank;
 	int offset;
 
@@ -314,26 +315,22 @@ static bool pcal6534_check_register(struct pca953x_chip *chip, unsigned int reg,
 		 * Handle lack of reserved registers after output port
 		 * configuration register to form a bank.
 		 */
-		int temp = reg - 0x54;
-
-		bank = temp / NBANK(chip);
-		offset = temp - (bank * NBANK(chip));
-		bank += 16;
+		reg -= 0x54;
+		bank_shift = 16;
 	} else if (reg >= 0x30) {
 		/*
 		 * Reserved block between 14h and 2Fh does not align on
 		 * expected bank boundaries like other devices.
 		 */
-		int temp = reg - 0x30;
-
-		bank = temp / NBANK(chip);
-		offset = temp - (bank * NBANK(chip));
-		bank += 8;
+		reg -= 0x30;
+		bank_shift = 8;
 	} else {
-		bank = reg / NBANK(chip);
-		offset = reg - (bank * NBANK(chip));
+		bank_shift = 0;
 	}
 
+	bank = bank_shift + reg / NBANK(chip);
+	offset = reg % NBANK(chip);
+
 	/* Register is not in the matching bank. */
 	if (!(BIT(bank) & checkbank))
 		return false;
-- 
2.35.1

