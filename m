Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1949D6035F5
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 00:34:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbiJRWeV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 18:34:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbiJRWeL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 18:34:11 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A908B40F7;
        Tue, 18 Oct 2022 15:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666132450; x=1697668450;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5zs148b4dkv4f38umRoJ2hh1+IVd8HBnRe5p9+7Hh64=;
  b=UxrhUFfIv27jA7LndH0DCYRNIu9HWebTRV7aviqSD385SfSxivIraSal
   1YE7IrzabxP7cAfhFxH3AplW90vWP/ixCjz8/c2650rMFi8EFOPxORFpy
   YxFv/J4h5TCQqYa6zT7q50akKJWrHEp7SqQOW2Yd/mOwAizj7TK2jl6Nt
   itOmyBuB0mSuiZ0q6prAmR16IOwjurXe6InUxj+WujhlRwRb3ZHafC8pp
   jwghzZX8SXXHKGzL4sSOTf0yiceuLMWHQwXwvj/UlnnyuTaCN+qDckHPX
   b6kOV1VMcW129usKpsRdGWA/SNoVo5zyqsIxJBpC1AmUsCXAEGNBUW4qg
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="306236226"
X-IronPort-AV: E=Sophos;i="5.95,194,1661842800"; 
   d="scan'208";a="306236226"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2022 15:34:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="697745781"
X-IronPort-AV: E=Sophos;i="5.95,194,1661842800"; 
   d="scan'208";a="697745781"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 18 Oct 2022 15:34:07 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id ACD249F; Wed, 19 Oct 2022 01:34:28 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v1 2/5] pinctrl: cannonlake: Deduplicate COMMUNITY macro code
Date:   Wed, 19 Oct 2022 01:34:24 +0300
Message-Id: <20221018223427.43579-2-andriy.shevchenko@linux.intel.com>
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
 drivers/pinctrl/intel/pinctrl-cannonlake.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pinctrl/intel/pinctrl-cannonlake.c b/drivers/pinctrl/intel/pinctrl-cannonlake.c
index 70e35dc7dd19..3af169ef4a06 100644
--- a/drivers/pinctrl/intel/pinctrl-cannonlake.c
+++ b/drivers/pinctrl/intel/pinctrl-cannonlake.c
@@ -30,12 +30,12 @@
 		.gpio_base = (g),			\
 	}
 
-#define CNL_COMMUNITY(b, s, e, ho, g)			\
+#define CNL_COMMUNITY(b, s, e, g, v)			\
 	{						\
 		.barno = (b),				\
 		.padown_offset = CNL_PAD_OWN,		\
 		.padcfglock_offset = CNL_PADCFGLOCK,	\
-		.hostown_offset = (ho),			\
+		.hostown_offset = CNL_##v##_HOSTSW_OWN,	\
 		.is_offset = CNL_GPI_IS,		\
 		.ie_offset = CNL_GPI_IE,		\
 		.pin_base = (s),			\
@@ -45,10 +45,10 @@
 	}
 
 #define CNL_LP_COMMUNITY(b, s, e, g)			\
-	CNL_COMMUNITY(b, s, e, CNL_LP_HOSTSW_OWN, g)
+	CNL_COMMUNITY(b, s, e, g, LP)
 
 #define CNL_H_COMMUNITY(b, s, e, g)			\
-	CNL_COMMUNITY(b, s, e, CNL_H_HOSTSW_OWN, g)
+	CNL_COMMUNITY(b, s, e, g, H)
 
 /* Cannon Lake-H */
 static const struct pinctrl_pin_desc cnlh_pins[] = {
-- 
2.35.1

