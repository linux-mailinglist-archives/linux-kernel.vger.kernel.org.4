Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C117562E051
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 16:51:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235124AbiKQPvG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 10:51:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234851AbiKQPvB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 10:51:01 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F64E701B1;
        Thu, 17 Nov 2022 07:51:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668700260; x=1700236260;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6MgUUvyelCWY06xmow9rc5WGciB3OvxEMw2tLw+abCI=;
  b=QvD1DJK3SUgCU5a0bnz3FiSqhtlwyE93sWDISpJ8HKzGMwzeD+s9zs8Y
   uDqJseOqu2wWqhEsjU11/GzXtwK6jMTV7TEMTfeYaPMXjUyqMJfMdR0QM
   n6w78EBI5gIhfaxdNqWuguf7XOJqWaH2LiyCf7FBsoBAtf+wCaeBotnuC
   SXSQlsU6AQ9+yAMrO+vjY9SzXBV4MFTbc93JLoCZEj1EBfCwxumEptULe
   JGfE/JLPZiGe/Jl/tWcCA0Fx+tDcFvqr8Yj8prdic3WtYiQ5a2IlSpOY0
   lFZ/x79gXgrMgSEraHGwXSgenwrbAh72XWmU53Zhlj0Fhb86MHVGlk/7O
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10534"; a="312898973"
X-IronPort-AV: E=Sophos;i="5.96,171,1665471600"; 
   d="scan'208";a="312898973"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2022 07:50:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10534"; a="968919505"
X-IronPort-AV: E=Sophos;i="5.96,171,1665471600"; 
   d="scan'208";a="968919505"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 17 Nov 2022 07:50:49 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 023D6B7; Thu, 17 Nov 2022 17:51:13 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Subject: [PATCH v1 2/3] clk: fractional-divider: Show numerator and denominator in debugfs
Date:   Thu, 17 Nov 2022 17:51:04 +0200
Message-Id: <20221117155105.1486-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221117155105.1486-1-andriy.shevchenko@linux.intel.com>
References: <20221117155105.1486-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's very useful to see what are the values of the fractional divider.
For that, add respective debugfs files.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
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

