Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4734E650B73
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 13:27:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231952AbiLSM0m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 07:26:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231761AbiLSM02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 07:26:28 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7C40DFA7;
        Mon, 19 Dec 2022 04:26:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671452787; x=1702988787;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=F2kaFIJwpZLRN2gttdbsTFc1z4ASTxYvGJRufqUmT/s=;
  b=UfJmYLauj5+pRjEseC1JS/u3ajecrG8kehuEEmr+5+iY9YGIIqLGmIsC
   LotjF+fQFTVGuM4gZVouyuysd2ekXsM/m9NEf4cX6z22ceOwcvSxJmNuI
   QEOatHjeVpleIyhcaW/2gnSl4WzlkW/LeBPEEJFJsKa/84pz9S6RiGzaw
   uB5YKveHtEt9r02pJlwgmMLLnuI/hoYRDBxje65Q/EvoxGj5maGH3z+tB
   S2X15WckZsUd7uh5/MxUawocFok1XggQyHmaqRhQBFKso5XLbQO7PiynX
   wv3SSFf24SzHitagvxNlwIlB9vl5HmGe3H+JuD5YwxdT8amRZXPinnc5f
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10565"; a="302762240"
X-IronPort-AV: E=Sophos;i="5.96,255,1665471600"; 
   d="scan'208";a="302762240"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2022 04:26:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10565"; a="824831629"
X-IronPort-AV: E=Sophos;i="5.96,255,1665471600"; 
   d="scan'208";a="824831629"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 19 Dec 2022 04:26:24 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id BD3421C3; Mon, 19 Dec 2022 14:26:54 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v1 04/17] pinctrl: cannonlake: Replace CNL_COMMUNITY() by INTEL_COMMUNITY_GPPS()
Date:   Mon, 19 Dec 2022 14:26:30 +0200
Message-Id: <20221219122643.3513-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221219122643.3513-1-andriy.shevchenko@linux.intel.com>
References: <20221219122643.3513-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use INTEL_COMMUNITY_GPPS() common macro instead custom CNL_COMMUNITY().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pinctrl/intel/pinctrl-cannonlake.c | 31 ++++++++--------------
 1 file changed, 11 insertions(+), 20 deletions(-)

diff --git a/drivers/pinctrl/intel/pinctrl-cannonlake.c b/drivers/pinctrl/intel/pinctrl-cannonlake.c
index f8a8b9b14de9..88142ec57b25 100644
--- a/drivers/pinctrl/intel/pinctrl-cannonlake.c
+++ b/drivers/pinctrl/intel/pinctrl-cannonlake.c
@@ -15,12 +15,17 @@
 
 #include "pinctrl-intel.h"
 
-#define CNL_PAD_OWN		0x020
-#define CNL_PADCFGLOCK		0x080
+#define CNL_LP_PAD_OWN		0x020
+#define CNL_LP_PADCFGLOCK	0x080
 #define CNL_LP_HOSTSW_OWN	0x0b0
+#define CNL_LP_GPI_IS		0x100
+#define CNL_LP_GPI_IE		0x120
+
+#define CNL_H_PAD_OWN		0x020
+#define CNL_H_PADCFGLOCK	0x080
 #define CNL_H_HOSTSW_OWN	0x0c0
-#define CNL_GPI_IS		0x100
-#define CNL_GPI_IE		0x120
+#define CNL_H_GPI_IS		0x100
+#define CNL_H_GPI_IE		0x120
 
 #define CNL_GPP(r, s, e, g)				\
 	{						\
@@ -30,25 +35,11 @@
 		.gpio_base = (g),			\
 	}
 
-#define CNL_COMMUNITY(b, s, e, g, v)			\
-	{						\
-		.barno = (b),				\
-		.padown_offset = CNL_PAD_OWN,		\
-		.padcfglock_offset = CNL_PADCFGLOCK,	\
-		.hostown_offset = CNL_##v##_HOSTSW_OWN,	\
-		.is_offset = CNL_GPI_IS,		\
-		.ie_offset = CNL_GPI_IE,		\
-		.pin_base = (s),			\
-		.npins = ((e) - (s) + 1),		\
-		.gpps = (g),				\
-		.ngpps = ARRAY_SIZE(g),			\
-	}
-
 #define CNL_LP_COMMUNITY(b, s, e, g)			\
-	CNL_COMMUNITY(b, s, e, g, LP)
+	INTEL_COMMUNITY_GPPS(b, s, e, g, CNL_LP)
 
 #define CNL_H_COMMUNITY(b, s, e, g)			\
-	CNL_COMMUNITY(b, s, e, g, H)
+	INTEL_COMMUNITY_GPPS(b, s, e, g, CNL_H)
 
 /* Cannon Lake-H */
 static const struct pinctrl_pin_desc cnlh_pins[] = {
-- 
2.35.1

