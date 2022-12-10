Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8E916490F8
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Dec 2022 23:06:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbiLJWGF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Dec 2022 17:06:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbiLJWFk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Dec 2022 17:05:40 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1599613D4F;
        Sat, 10 Dec 2022 14:05:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670709940; x=1702245940;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vkrxbHg3Pwn+h3sN0NMmjjLRRztZhfqgXCcqyghgbqc=;
  b=Mcd3mho+wz+ydv/W/CsTnxSVtDLUSfQA5Tb8F+QNAcRF9pw8e5fKGXne
   OVTxQO7eDL9zBLWHMjpRfYj3xvZkrWG05brxzdOSAHx2DUjISf5qeT6b7
   FbrlZhjI9jQBuI6gStl5g14q3rXQof/ER/J2qz9mLuRYcy9nMz6pHzsky
   vhafIpcKq5tKIUIeuX3SeTHBtbmG4IPiPm96tRQxuWf37ekzIlYu3lsz3
   PJFWq1p8n7/MiQS/DMnS6aFHyUkf6koTGZHOzhe1nLVW+n9NT6pIkrejW
   f3F73N4cs04ZnGsYPjtaFjOWYaZGC+OlKQe1krWv8V7mhPT9jqXipji3D
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10557"; a="403907181"
X-IronPort-AV: E=Sophos;i="5.96,235,1665471600"; 
   d="scan'208";a="403907181"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2022 14:05:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10557"; a="625470514"
X-IronPort-AV: E=Sophos;i="5.96,235,1665471600"; 
   d="scan'208";a="625470514"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 10 Dec 2022 14:05:36 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 4FB9BF7; Sun, 11 Dec 2022 00:06:05 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Haibo Chen <haibo.chen@nxp.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 2/4] gpio: pca953x: avoid logically dead code
Date:   Sun, 11 Dec 2022 00:05:59 +0200
Message-Id: <20221210220601.77648-2-andriy.shevchenko@linux.intel.com>
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

From: Haibo Chen <haibo.chen@nxp.com>

The current code logic make the condition "else if (reg >= 0x54)"
can't be true, cause the dead code. So fix it to match the coder
expectation. This is reported by Coverity.

Fixes: 13c5d4ce8060 ("gpio: pca953x: Add support for PCAL6534")
Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: shuffled code to check bigger value first (Andy)
 drivers/gpio/gpio-pca953x.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/gpio/gpio-pca953x.c b/drivers/gpio/gpio-pca953x.c
index 5299e5bb76d6..2c8586b3191f 100644
--- a/drivers/gpio/gpio-pca953x.c
+++ b/drivers/gpio/gpio-pca953x.c
@@ -309,26 +309,26 @@ static bool pcal6534_check_register(struct pca953x_chip *chip, unsigned int reg,
 	int bank;
 	int offset;
 
-	if (reg >= 0x30) {
+	if (reg >= 0x54) {
 		/*
-		 * Reserved block between 14h and 2Fh does not align on
-		 * expected bank boundaries like other devices.
+		 * Handle lack of reserved registers after output port
+		 * configuration register to form a bank.
 		 */
-		int temp = reg - 0x30;
+		int temp = reg - 0x54;
 
 		bank = temp / NBANK(chip);
 		offset = temp - (bank * NBANK(chip));
-		bank += 8;
-	} else if (reg >= 0x54) {
+		bank += 16;
+	} else if (reg >= 0x30) {
 		/*
-		 * Handle lack of reserved registers after output port
-		 * configuration register to form a bank.
+		 * Reserved block between 14h and 2Fh does not align on
+		 * expected bank boundaries like other devices.
 		 */
-		int temp = reg - 0x54;
+		int temp = reg - 0x30;
 
 		bank = temp / NBANK(chip);
 		offset = temp - (bank * NBANK(chip));
-		bank += 16;
+		bank += 8;
 	} else {
 		bank = reg / NBANK(chip);
 		offset = reg - (bank * NBANK(chip));
-- 
2.35.1

