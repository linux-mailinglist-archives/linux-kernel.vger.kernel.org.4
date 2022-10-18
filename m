Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B490F6035F6
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 00:34:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbiJRWeY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 18:34:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbiJRWeL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 18:34:11 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 391622BB35;
        Tue, 18 Oct 2022 15:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666132451; x=1697668451;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+vCoymx5NkqT+DCUBjvcufzqfyqPvwuEyg7xUD1Func=;
  b=MGWvVYPGJs7mcpKod8GqLcvj/TvRGAOrCMv5PGCfVI2AOSzsVeSOwKaW
   QjURn6DvKC9EQW2BM59Neac8LrpddC3TD8bXM6XiuYewQuQ0KzIVE9bIo
   Jy7vJci7eXpQp2mezT9IMkmIH6iBwivI1FkAU3UkvvSGxejtK5gdG4Rhq
   gx/gf3BPUgFoOFkQrQLtBd4g6CH59+/jT7qolGxKnT/hLwW6n/BJNE9rY
   Nk2zDIEiuX41Tf8ZbxgUQOiF7NzU1BJC+HZM0ScLpL8w+acqMH1TkvQrJ
   5y3l/Tmc4mw72TFiwCvJhqZeGv/fKkALrDrdW0oXOi8JbDT1gJ14CqZy8
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="306236227"
X-IronPort-AV: E=Sophos;i="5.95,194,1661842800"; 
   d="scan'208";a="306236227"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2022 15:34:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="697745782"
X-IronPort-AV: E=Sophos;i="5.95,194,1661842800"; 
   d="scan'208";a="697745782"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 18 Oct 2022 15:34:07 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id D16643FD; Wed, 19 Oct 2022 01:34:28 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v1 5/5] pinctrl: tigerlake: Deduplicate COMMUNITY macro code
Date:   Wed, 19 Oct 2022 01:34:27 +0300
Message-Id: <20221018223427.43579-5-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221018223427.43579-1-andriy.shevchenko@linux.intel.com>
References: <20221018223427.43579-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Define a common COMUNITY macro and supply a variant to it.
This removes some verbosity in macros.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pinctrl/intel/pinctrl-tigerlake.c | 28 +++++++++++------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/pinctrl/intel/pinctrl-tigerlake.c b/drivers/pinctrl/intel/pinctrl-tigerlake.c
index 5a4cd0d9a89f..4f5a3b80b72d 100644
--- a/drivers/pinctrl/intel/pinctrl-tigerlake.c
+++ b/drivers/pinctrl/intel/pinctrl-tigerlake.c
@@ -31,25 +31,25 @@
 		.gpio_base = (g),			\
 	}
 
-#define TGL_COMMUNITY(b, s, e, pl, ho, g)		\
-	{						\
-		.barno = (b),				\
-		.padown_offset = TGL_PAD_OWN,		\
-		.padcfglock_offset = (pl),		\
-		.hostown_offset = (ho),			\
-		.is_offset = TGL_GPI_IS,		\
-		.ie_offset = TGL_GPI_IE,		\
-		.pin_base = (s),			\
-		.npins = ((e) - (s) + 1),		\
-		.gpps = (g),				\
-		.ngpps = ARRAY_SIZE(g),			\
+#define TGL_COMMUNITY(b, s, e, g, v)				\
+	{							\
+		.barno = (b),					\
+		.padown_offset = TGL_PAD_OWN,			\
+		.padcfglock_offset = TGL_##v##_PADCFGLOCK,	\
+		.hostown_offset = TGL_##v##_HOSTSW_OWN,		\
+		.is_offset = TGL_GPI_IS,			\
+		.ie_offset = TGL_GPI_IE,			\
+		.pin_base = (s),				\
+		.npins = ((e) - (s) + 1),			\
+		.gpps = (g),					\
+		.ngpps = ARRAY_SIZE(g),				\
 	}
 
 #define TGL_LP_COMMUNITY(b, s, e, g)			\
-	TGL_COMMUNITY(b, s, e, TGL_LP_PADCFGLOCK, TGL_LP_HOSTSW_OWN, g)
+	TGL_COMMUNITY(b, s, e, g, LP)
 
 #define TGL_H_COMMUNITY(b, s, e, g)			\
-	TGL_COMMUNITY(b, s, e, TGL_H_PADCFGLOCK, TGL_H_HOSTSW_OWN, g)
+	TGL_COMMUNITY(b, s, e, g, H)
 
 /* Tiger Lake-LP */
 static const struct pinctrl_pin_desc tgllp_pins[] = {
-- 
2.35.1

