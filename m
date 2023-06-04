Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62B9272173E
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jun 2023 15:12:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231898AbjFDNMQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jun 2023 09:12:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbjFDNMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jun 2023 09:12:13 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1622B8;
        Sun,  4 Jun 2023 06:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685884332; x=1717420332;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=dO9+hudmBeE13l32Rylh0J5QaZhOfbdLqdQbEuq7Ixc=;
  b=iXAUuG4aunE4Pky+EBDpPBfr+J6bAZFwYXMJ38YAKd4QXpAvDzQCXmxb
   ZTWvrLuLdPQV8kh5Xln0Ssvmt4mLq12I/5UdeRiKDxAwr36/TFAPdchMI
   CEkVg3w5N3NXdcyuoImJOuwzGKd3GKUdg5FPNEdJMafHdX98sE33nR9hJ
   G468H2BSCcafkaLlS0X8Tzd+J52TnerK7ce2AyHiDFw2N4VVr+/k1esQ6
   PFbhiGIeNGxkZoHMpufXWw2DuOv/N/FKpP/V4z+fYPtXAYRaiWYfiTKJa
   o4i+m6ik2LV7B36exO+8EDZXp4+a50VjtH04LlnmAPjvLD6vgfU20UzPE
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10731"; a="422008643"
X-IronPort-AV: E=Sophos;i="6.00,217,1681196400"; 
   d="scan'208";a="422008643"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2023 06:12:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10731"; a="778251865"
X-IronPort-AV: E=Sophos;i="6.00,217,1681196400"; 
   d="scan'208";a="778251865"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 04 Jun 2023 06:12:10 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 2F082204; Sun,  4 Jun 2023 16:12:17 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v1 1/2] pinctrl: Duplicate user memory in one go in pinmux_select()
Date:   Sun,  4 Jun 2023 16:12:14 +0300
Message-Id: <20230604131215.78847-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
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

Current code is suboptimal in three ways:
1) it explicitly terminates the string which is not needed;
2) it might provoke additional faults, because asked lenght might be
   bigger than the real one;
3) it consumes more than needed lines in the source.

Instead of using kmalloc() + strncpy_from_user() + terminating, just
utilize memdup_user_nul().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pinctrl/pinmux.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/pinctrl/pinmux.c b/drivers/pinctrl/pinmux.c
index 021382632608..2d2f3bd164d5 100644
--- a/drivers/pinctrl/pinmux.c
+++ b/drivers/pinctrl/pinmux.c
@@ -692,14 +692,9 @@ static ssize_t pinmux_select(struct file *file, const char __user *user_buf,
 	if (len > PINMUX_SELECT_MAX)
 		return -ENOMEM;
 
-	buf = kzalloc(PINMUX_SELECT_MAX, GFP_KERNEL);
-	if (!buf)
-		return -ENOMEM;
-
-	ret = strncpy_from_user(buf, user_buf, PINMUX_SELECT_MAX);
-	if (ret < 0)
-		goto exit_free_buf;
-	buf[len-1] = '\0';
+	buf = memdup_user_nul(user_buf, len);
+	if (IS_ERR(buf))
+		return PTR_ERR(buf);
 
 	/* remove leading and trailing spaces of input buffer */
 	gname = strstrip(buf);
-- 
2.40.0.1.gaa8946217a0b

