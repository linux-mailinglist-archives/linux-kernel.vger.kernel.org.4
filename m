Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F24686626F9
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 14:27:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233884AbjAIN0z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 08:26:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbjAIN0x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 08:26:53 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08637CCB;
        Mon,  9 Jan 2023 05:26:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673270813; x=1704806813;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=bAHPKpx8104LaB0KsPUVZ4UAbNUE0Ufn60pvoDy2m2c=;
  b=mBccV+RZdD0zR6A7bVbtDWcsqc8K/yL0tOtO+z2yOf3k9BDXmVDhPxZE
   53lysMo0KnCYU0tnqPrKKMGd77yo01p/YVNqsPAa/VQxtH8/J2qTg6qvE
   Et3H+yjRjaV2gDTTOlXykUxgkL7f3aqkYYkwTwV6yGgvlO3Z5ZcjcGbRu
   QZysofnM5jm8LTpCu6d1Il07zMrBkPUzp+o8tcvUlX/vYgF5OSP/oR5xd
   1ioFEoLB8+tE4xWk0EZEOfAJbb/RNSjbKvMEbEVP3fxazDPXm3yfgmLjf
   uvHIl99Kud8Tjkl2BFRsWL1YcqP4TMQPk9LuaYh4MD5DMWO4iWze40411
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10584"; a="310663950"
X-IronPort-AV: E=Sophos;i="5.96,311,1665471600"; 
   d="scan'208";a="310663950"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2023 05:26:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10584"; a="830597505"
X-IronPort-AV: E=Sophos;i="5.96,311,1665471600"; 
   d="scan'208";a="830597505"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 09 Jan 2023 05:26:51 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 9F1F9F4; Mon,  9 Jan 2023 15:27:24 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v1 1/1] pinctrl: pinmux: Drop duplicate error message in pinmux_select()
Date:   Mon,  9 Jan 2023 15:27:19 +0200
Message-Id: <20230109132719.86009-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
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

pinctrl_get_group_selector() prints an error message when group
is not found in the list. No need to repeat this in the caller.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pinctrl/pinmux.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/pinctrl/pinmux.c b/drivers/pinctrl/pinmux.c
index 6bd7ac37a0e0..021382632608 100644
--- a/drivers/pinctrl/pinmux.c
+++ b/drivers/pinctrl/pinmux.c
@@ -744,10 +744,8 @@ static ssize_t pinmux_select(struct file *file, const char __user *user_buf,
 	}
 
 	ret = pinctrl_get_group_selector(pctldev, gname);
-	if (ret < 0) {
-		dev_err(pctldev->dev, "failed to get group selector for %s", gname);
+	if (ret < 0)
 		goto exit_free_buf;
-	}
 	gsel = ret;
 
 	ret = pmxops->set_mux(pctldev, fsel, gsel);
-- 
2.35.1

