Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DA7E62E053
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 16:51:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239750AbiKQPvU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 10:51:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234851AbiKQPvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 10:51:10 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51A3270A06;
        Thu, 17 Nov 2022 07:51:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668700269; x=1700236269;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=BWDzsCwCXR7fUBoOm58dEqg3TsEeYspRHu9MmmNT8XE=;
  b=TUVfhWZ9+tB1Q2263cJigbnWMLw5ULJCLWiLWvAn0A7KATLeXKvWpAbx
   5v42wCp/ShxZ0uLUc8S6lOw3YYQ6TxbEex5c7AcDknYRWIcUOcNP1goho
   lmyDOj5+6sh32A/TQfQoh/6awqo42P+kY8zmcxF71zni9xzf8m7wm/J3V
   DGnEEnlRzXxth/ozquYHumyfbQUdwajqqqanzkEX8aukpVGBPDgkPXAKA
   A876czyXojg3QgqpttynY9s3O2pzEjkr7Pl0CMUy17DFbi18sUYzYPZEw
   YRaT7i1OEuWr5qsInqqa1jcVkDQGvVrNLCiFvJUVlqn8OHYlh2xt5+R2L
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10534"; a="375016483"
X-IronPort-AV: E=Sophos;i="5.96,171,1665471600"; 
   d="scan'208";a="375016483"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2022 07:50:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10534"; a="814557612"
X-IronPort-AV: E=Sophos;i="5.96,171,1665471600"; 
   d="scan'208";a="814557612"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 17 Nov 2022 07:50:49 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id E9D8A2B7; Thu, 17 Nov 2022 17:51:13 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Subject: [PATCH v1 1/3] clk: fractional-divider: Split out clk_fd_get_div() helper
Date:   Thu, 17 Nov 2022 17:51:03 +0200
Message-Id: <20221117155105.1486-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
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

Split out clk_fd_get_div() helper for the future use elsewhere.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/clk/clk-fractional-divider.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/clk-fractional-divider.c b/drivers/clk/clk-fractional-divider.c
index 8efa5142ff8c..5c6f1d0f8fb4 100644
--- a/drivers/clk/clk-fractional-divider.c
+++ b/drivers/clk/clk-fractional-divider.c
@@ -40,6 +40,7 @@
 
 #include <linux/clk-provider.h>
 #include <linux/io.h>
+#include <linux/math.h>
 #include <linux/module.h>
 #include <linux/device.h>
 #include <linux/slab.h>
@@ -63,14 +64,12 @@ static inline void clk_fd_writel(struct clk_fractional_divider *fd, u32 val)
 		writel(val, fd->reg);
 }
 
-static unsigned long clk_fd_recalc_rate(struct clk_hw *hw,
-					unsigned long parent_rate)
+static void clk_fd_get_div(struct clk_hw *hw, struct u32_fract *fract)
 {
 	struct clk_fractional_divider *fd = to_clk_fd(hw);
 	unsigned long flags = 0;
 	unsigned long m, n;
 	u32 val;
-	u64 ret;
 
 	if (fd->lock)
 		spin_lock_irqsave(fd->lock, flags);
@@ -92,11 +91,22 @@ static unsigned long clk_fd_recalc_rate(struct clk_hw *hw,
 		n++;
 	}
 
-	if (!n || !m)
+	fract->numerator = m;
+	fract->denominator = n;
+}
+
+static unsigned long clk_fd_recalc_rate(struct clk_hw *hw, unsigned long parent_rate)
+{
+	struct u32_fract fract;
+	u64 ret;
+
+	clk_fd_get_div(hw, &fract);
+
+	if (!fract.numerator || !fract.denominator)
 		return parent_rate;
 
-	ret = (u64)parent_rate * m;
-	do_div(ret, n);
+	ret = (u64)parent_rate * fract.numerator;
+	do_div(ret, fract.denominator);
 
 	return ret;
 }
-- 
2.35.1

