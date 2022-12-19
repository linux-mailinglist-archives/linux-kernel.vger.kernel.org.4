Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1234D650B8B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 13:28:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232155AbiLSM1s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 07:27:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231878AbiLSM0e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 07:26:34 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75E17DFA7;
        Mon, 19 Dec 2022 04:26:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671452793; x=1702988793;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wriakv1+mcnXnd3wAKx3rFcCp8RBbBGEcLAFkWv/D0w=;
  b=J65lwnoTYuRx8kfsNRea40X5NLlDi1sLVmarWg7X+/pD+2P0gxPOIupB
   rwojg2uEN3RIdcAAT4qv011XdpKlvc166jhco2SnVRf4RiebuWAyRrI0M
   g0NGbFfh+HwFFndI2vjh1r7pdoVmTQBp1BVMD/Mx7EYTGmmp91H6jE9y+
   LOBsgy5bq2Vjb/P34Y1piyEPnWe/HCALIYeOQnUkMLdR83jUJwIi+1B90
   fk4ZQZyzlpa6PWIgZAlivh9bpflYvqPtNNTh+qY2C5QHMMK6gY95HS6SN
   Tgw8pYPj2GeI6+KUqLuVkYmh86hcGBpwR4hVx3Vr8GXKmkhi85owu+dX3
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10565"; a="302762266"
X-IronPort-AV: E=Sophos;i="5.96,255,1665471600"; 
   d="scan'208";a="302762266"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2022 04:26:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10565"; a="824831640"
X-IronPort-AV: E=Sophos;i="5.96,255,1665471600"; 
   d="scan'208";a="824831640"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 19 Dec 2022 04:26:30 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 38C42704; Mon, 19 Dec 2022 14:26:55 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v1 16/17] pinctrl: sunrisepoint: Replace SPT_COMMUNITY() by INTEL_COMMUNITY_*()
Date:   Mon, 19 Dec 2022 14:26:42 +0200
Message-Id: <20221219122643.3513-16-andriy.shevchenko@linux.intel.com>
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

Use INTEL_COMMUNITY_*() common macro instead custom SPT_COMMUNITY().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pinctrl/intel/pinctrl-sunrisepoint.c | 37 +++++++-------------
 1 file changed, 13 insertions(+), 24 deletions(-)

diff --git a/drivers/pinctrl/intel/pinctrl-sunrisepoint.c b/drivers/pinctrl/intel/pinctrl-sunrisepoint.c
index 292b660067e9..f91e27feb7c3 100644
--- a/drivers/pinctrl/intel/pinctrl-sunrisepoint.c
+++ b/drivers/pinctrl/intel/pinctrl-sunrisepoint.c
@@ -15,31 +15,17 @@
 
 #include "pinctrl-intel.h"
 
-#define SPT_PAD_OWN		0x020
+#define SPT_H_PAD_OWN		0x020
 #define SPT_H_PADCFGLOCK	0x090
-#define SPT_LP_PADCFGLOCK	0x0a0
-#define SPT_HOSTSW_OWN		0x0d0
-#define SPT_GPI_IS		0x100
-#define SPT_GPI_IE		0x120
-
-#define SPT_COMMUNITY(b, s, e, g, n, v, gs, gn)			\
-	{							\
-		.barno = (b),					\
-		.padown_offset = SPT_PAD_OWN,			\
-		.padcfglock_offset = SPT_##v##_PADCFGLOCK,	\
-		.hostown_offset = SPT_HOSTSW_OWN,		\
-		.is_offset = SPT_GPI_IS,			\
-		.ie_offset = SPT_GPI_IE,			\
-		.gpp_size = (gs),				\
-		.gpp_num_padown_regs = (gn),			\
-		.pin_base = (s),				\
-		.npins = ((e) - (s) + 1),			\
-		.gpps = (g),					\
-		.ngpps = (n),					\
-	}
+#define SPT_H_HOSTSW_OWN	0x0d0
+#define SPT_H_GPI_IS		0x100
+#define SPT_H_GPI_IE		0x120
 
-#define SPT_LP_COMMUNITY(b, s, e)			\
-	SPT_COMMUNITY(b, s, e, NULL, 0, LP, 24, 4)
+#define SPT_LP_PAD_OWN		0x020
+#define SPT_LP_PADCFGLOCK	0x0a0
+#define SPT_LP_HOSTSW_OWN	0x0d0
+#define SPT_LP_GPI_IS		0x100
+#define SPT_LP_GPI_IE		0x120
 
 #define SPT_H_GPP(r, s, e, g)				\
 	{						\
@@ -50,7 +36,10 @@
 	}
 
 #define SPT_H_COMMUNITY(b, s, e, g)			\
-	SPT_COMMUNITY(b, s, e, g, ARRAY_SIZE(g), H, 0, 0)
+	INTEL_COMMUNITY_GPPS(b, s, e, g, SPT_H)
+
+#define SPT_LP_COMMUNITY(b, s, e)			\
+	INTEL_COMMUNITY_SIZE(b, s, e, 24, 4, SPT_LP)
 
 /* Sunrisepoint-LP */
 static const struct pinctrl_pin_desc sptlp_pins[] = {
-- 
2.35.1

