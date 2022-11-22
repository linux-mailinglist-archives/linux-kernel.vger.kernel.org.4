Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE0E1633D1B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 14:07:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233440AbiKVNHS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 08:07:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232849AbiKVNHM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 08:07:12 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D3826238B;
        Tue, 22 Nov 2022 05:07:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669122431; x=1700658431;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JvcE92gKvOcwLrDEGyRbhKXu2OVvTqGr3iFpwDsrMbM=;
  b=OMwSFDaN6gHOiW3OUAE00JJo8Netpm20PKeHLmIl7HrbW6RJ7sZZ+aQD
   I9T9gvxxYlHcORdZMir9nbGirXjB19UwRjJIcR/R7WCyqoL7iM6SPC01w
   mEqDu769XoYNMwmVyUu8+CqK/s8E9qphZCpP9gbDKFYkf0z1g0Jxc6Qfx
   EEfgGfBca+8MAJyEBBfezzXbXV11waaWmBdrBBI1bh3oEivVlxZRuXCik
   RVxUXYIbZ1wPtsYY6jrSXwlKyF6oXrH4kNI/BJP/wQKFcJP7ajrOdOzK/
   0nlfsDbz7K/jxyITJfhZvmGMJCdfQ+rAve68R5MjYSSMFQYYcEF2TD01N
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10538"; a="301358045"
X-IronPort-AV: E=Sophos;i="5.96,184,1665471600"; 
   d="scan'208";a="301358045"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2022 05:07:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10538"; a="619206110"
X-IronPort-AV: E=Sophos;i="5.96,184,1665471600"; 
   d="scan'208";a="619206110"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 22 Nov 2022 05:07:08 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id E0B95F7; Tue, 22 Nov 2022 15:07:33 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Subject: [PATCH v2 2/3] clk: fractional-divider: Show numerator and denominator in debugfs
Date:   Tue, 22 Nov 2022 15:07:31 +0200
Message-Id: <20221122130732.48537-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221122130732.48537-1-andriy.shevchenko@linux.intel.com>
References: <20221122130732.48537-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's very useful to see what are the values of the fractional divider.
For that, add respective debugfs files.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: no changes
 drivers/clk/clk-fractional-divider.c | 36 ++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/drivers/clk/clk-fractional-divider.c b/drivers/clk/clk-fractional-divider.c
index 5c6f1d0f8fb4..b6b52b79d671 100644
--- a/drivers/clk/clk-fractional-divider.c
+++ b/drivers/clk/clk-fractional-divider.c
@@ -39,6 +39,7 @@
  */
 
 #include <linux/clk-provider.h>
+#include <linux/debugfs.h>
 #include <linux/io.h>
 #include <linux/math.h>
 #include <linux/module.h>
@@ -193,10 +194,45 @@ static int clk_fd_set_rate(struct clk_hw *hw, unsigned long rate,
 	return 0;
 }
 
+#ifdef CONFIG_DEBUG_FS
+static int clk_fd_numerator_get(void *hw, u64 *val)
+{
+	struct u32_fract fract;
+
+	clk_fd_get_div(hw, &fract);
+
+	*val = fract.numerator;
+
+	return 0;
+}
+DEFINE_DEBUGFS_ATTRIBUTE(clk_fd_numerator_fops, clk_fd_numerator_get, NULL, "%llu\n");
+
+static int clk_fd_denominator_get(void *hw, u64 *val)
+{
+	struct u32_fract fract;
+
+	clk_fd_get_div(hw, &fract);
+
+	*val = fract.denominator;
+
+	return 0;
+}
+DEFINE_DEBUGFS_ATTRIBUTE(clk_fd_denominator_fops, clk_fd_denominator_get, NULL, "%llu\n");
+
+static void clk_fd_debug_init(struct clk_hw *hw, struct dentry *dentry)
+{
+	debugfs_create_file("numerator", 0444, dentry, hw, &clk_fd_numerator_fops);
+	debugfs_create_file("denominator", 0444, dentry, hw, &clk_fd_denominator_fops);
+}
+#endif
+
 const struct clk_ops clk_fractional_divider_ops = {
 	.recalc_rate = clk_fd_recalc_rate,
 	.round_rate = clk_fd_round_rate,
 	.set_rate = clk_fd_set_rate,
+#ifdef CONFIG_DEBUG_FS
+	.debug_init = clk_fd_debug_init,
+#endif
 };
 EXPORT_SYMBOL_GPL(clk_fractional_divider_ops);
 
-- 
2.35.1

