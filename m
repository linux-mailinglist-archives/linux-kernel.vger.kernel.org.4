Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FEB672173F
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jun 2023 15:12:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231948AbjFDNMS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jun 2023 09:12:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230487AbjFDNMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jun 2023 09:12:14 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE84BCA;
        Sun,  4 Jun 2023 06:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685884333; x=1717420333;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5vg61FkTTaqJtLcNTfO3vDFQp7XbtULOPcw177woejk=;
  b=IrBDL5qQtkpLI0y1HgvscPKxqGxzgIYD2r0705Jmsj7Zwntx5Uh05epQ
   3k4obwcy8dTjjYq8ONPVGBNgThcKfig5Q29XP+QPPQ7lStBgX9gKqrgIe
   tPSRX4qVgL7X//DWhbpwj6xWs9ATyfsGgL5NgpqknjcQBAguQjQI+bKbm
   8MJLehGtPJfM6TewBDvYb3fAsHUJj0dWKuSRl+S0hCI41SemOLzBx2vMb
   JlOmHTWsmgVqwh3HtlA71ibdPhyv7hcH1S7UUyjMmjzuDvaKvtYdiO/tD
   oNEVbAK4+Xn2ASG2/X13kJ/4VGx2WFv0gJubPuKf/MmCnrsxu9QQz985Q
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10731"; a="422008645"
X-IronPort-AV: E=Sophos;i="6.00,217,1681196400"; 
   d="scan'208";a="422008645"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2023 06:12:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10731"; a="778251867"
X-IronPort-AV: E=Sophos;i="6.00,217,1681196400"; 
   d="scan'208";a="778251867"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 04 Jun 2023 06:12:11 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id D02A72A6; Sun,  4 Jun 2023 16:12:17 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v1 2/2] pinctrl: Relax user input size in pinmux_select()
Date:   Sun,  4 Jun 2023 16:12:15 +0300
Message-Id: <20230604131215.78847-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20230604131215.78847-1-andriy.shevchenko@linux.intel.com>
References: <20230604131215.78847-1-andriy.shevchenko@linux.intel.com>
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

This is debugfs and there is no much sense to strict the user from
sending as much data as they can. The memdup_user_nul() will anyway
fail if there is not enough memory.

Relax the user input size by removing an artificial limitaion.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pinctrl/pinmux.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/pinctrl/pinmux.c b/drivers/pinctrl/pinmux.c
index 2d2f3bd164d5..82c750a31952 100644
--- a/drivers/pinctrl/pinmux.c
+++ b/drivers/pinctrl/pinmux.c
@@ -677,7 +677,6 @@ void pinmux_show_setting(struct seq_file *s,
 DEFINE_SHOW_ATTRIBUTE(pinmux_functions);
 DEFINE_SHOW_ATTRIBUTE(pinmux_pins);
 
-#define PINMUX_SELECT_MAX 128
 static ssize_t pinmux_select(struct file *file, const char __user *user_buf,
 				   size_t len, loff_t *ppos)
 {
@@ -689,9 +688,6 @@ static ssize_t pinmux_select(struct file *file, const char __user *user_buf,
 	unsigned int num_groups;
 	int fsel, gsel, ret;
 
-	if (len > PINMUX_SELECT_MAX)
-		return -ENOMEM;
-
 	buf = memdup_user_nul(user_buf, len);
 	if (IS_ERR(buf))
 		return PTR_ERR(buf);
-- 
2.40.0.1.gaa8946217a0b

