Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46C586035F3
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 00:34:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbiJRWeP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 18:34:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbiJRWeK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 18:34:10 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2D86B3B0F;
        Tue, 18 Oct 2022 15:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666132449; x=1697668449;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=S8OvzsmBz70zqLUsYZeuT443cTPIx6whiHpbqZl3NAM=;
  b=Yq/TTMtDGn64Gl9ZMUnjhg14WSE6T9Siw3Bz7hJqqG9jXnVKzl6Z6H05
   /Ok4Za8UlBJp4uf8kSDkhZMWWd1VTvA9aJtxa4zWyA798nLmTo+q+rFil
   JWqg2n7J29hCREyNvYFXg/ly9uOCecoVHNHa4iusKcv1lDPPk898/H0da
   Glo1Gb2UbPvpCYRhHWVLEHm423PDsK2gx61SOLlFLUYG/ob4F3WWUsMDx
   YexH8HvAhVsniR1STGiAXelXDaQm1gyUY0l1MmEWgS2oRh6nhRl+I5ZMG
   ynU4i/WbEHan0bn77qcs0vpVxbwQt3MPfEndaJgCWI4SwEyqC3sj7XefU
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="306236225"
X-IronPort-AV: E=Sophos;i="5.95,194,1661842800"; 
   d="scan'208";a="306236225"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2022 15:34:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="697745780"
X-IronPort-AV: E=Sophos;i="5.95,194,1661842800"; 
   d="scan'208";a="697745780"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 18 Oct 2022 15:34:07 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id BDA901C7; Wed, 19 Oct 2022 01:34:28 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v1 3/5] pinctrl: icelake: Deduplicate COMMUNITY macro code
Date:   Wed, 19 Oct 2022 01:34:25 +0300
Message-Id: <20221018223427.43579-3-andriy.shevchenko@linux.intel.com>
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
 drivers/pinctrl/intel/pinctrl-icelake.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pinctrl/intel/pinctrl-icelake.c b/drivers/pinctrl/intel/pinctrl-icelake.c
index 4cca5ff6c3d6..637f5fdc0827 100644
--- a/drivers/pinctrl/intel/pinctrl-icelake.c
+++ b/drivers/pinctrl/intel/pinctrl-icelake.c
@@ -30,14 +30,14 @@
 		.gpio_base = (g),			\
 	}
 
-#define ICL_COMMUNITY(b, s, e, ie, g)			\
+#define ICL_COMMUNITY(b, s, e, g, v)			\
 	{						\
 		.barno = (b),				\
 		.padown_offset = ICL_PAD_OWN,		\
 		.padcfglock_offset = ICL_PADCFGLOCK,	\
 		.hostown_offset = ICL_HOSTSW_OWN,	\
 		.is_offset = ICL_GPI_IS,		\
-		.ie_offset = (ie),			\
+		.ie_offset = ICL_##v##_GPI_IE,		\
 		.pin_base = (s),			\
 		.npins = ((e) - (s) + 1),		\
 		.gpps = (g),				\
@@ -45,10 +45,10 @@
 	}
 
 #define ICL_LP_COMMUNITY(b, s, e, g)			\
-	ICL_COMMUNITY(b, s, e, ICL_LP_GPI_IE, g)
+	ICL_COMMUNITY(b, s, e, g, LP)
 
 #define ICL_N_COMMUNITY(b, s, e, g)			\
-	ICL_COMMUNITY(b, s, e, ICL_N_GPI_IE, g)
+	ICL_COMMUNITY(b, s, e, g, N)
 
 /* Ice Lake-LP */
 static const struct pinctrl_pin_desc icllp_pins[] = {
-- 
2.35.1

