Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 913706035F4
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 00:34:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbiJRWeT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 18:34:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229962AbiJRWeL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 18:34:11 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6559EB3B23;
        Tue, 18 Oct 2022 15:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666132450; x=1697668450;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9fcaWKO9aXLkv+dqa94dbpKX48/m+j1H+Zp+GyGjibU=;
  b=n45HdTeAaTbqPfR6L1v4dQUICHhAAtmTtyLOOxfNV/xUyl/KYzmwFdrH
   BKMn6HnF2ERaHmUhQf/fcRJjtCkEIYn6lXC7dn9237D9IQKUMphoDmM2N
   U3paM2TyYWrukzZ7EnvJkpkHOZJZazqmxLp0dufyHpS39RiyZU8sh5DKg
   /DWUgop8XLHN7MgX1//UOfWXfPelXbPcZhRYKtySx/KYI6rdTM6h8jbjG
   SxBbq8DzahG9K2wO9RfQHfF0/vA9Pnp5L5Co66K23svABTti1WWa3V54h
   LSrLwm0Yjmy23ZAm2lneY3OtxPIBSlhYDaWsXdQlTW0qN0PEHG0QYb6gO
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="306236224"
X-IronPort-AV: E=Sophos;i="5.95,194,1661842800"; 
   d="scan'208";a="306236224"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2022 15:34:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="697745779"
X-IronPort-AV: E=Sophos;i="5.95,194,1661842800"; 
   d="scan'208";a="697745779"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 18 Oct 2022 15:34:07 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id C9C0520B; Wed, 19 Oct 2022 01:34:28 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v1 4/5] pinctrl: sunrisepoint: Deduplicate COMMUNITY macro code
Date:   Wed, 19 Oct 2022 01:34:26 +0300
Message-Id: <20221018223427.43579-4-andriy.shevchenko@linux.intel.com>
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
 drivers/pinctrl/intel/pinctrl-sunrisepoint.c | 32 ++++++++++----------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/pinctrl/intel/pinctrl-sunrisepoint.c b/drivers/pinctrl/intel/pinctrl-sunrisepoint.c
index 026067e18349..be5bb0f4b1dc 100644
--- a/drivers/pinctrl/intel/pinctrl-sunrisepoint.c
+++ b/drivers/pinctrl/intel/pinctrl-sunrisepoint.c
@@ -22,24 +22,24 @@
 #define SPT_GPI_IS		0x100
 #define SPT_GPI_IE		0x120
 
-#define SPT_COMMUNITY(b, s, e, pl, gs, gn, g, n)	\
-	{						\
-		.barno = (b),				\
-		.padown_offset = SPT_PAD_OWN,		\
-		.padcfglock_offset = (pl),		\
-		.hostown_offset = SPT_HOSTSW_OWN,	\
-		.is_offset = SPT_GPI_IS,		\
-		.ie_offset = SPT_GPI_IE,		\
-		.gpp_size = (gs),			\
-		.gpp_num_padown_regs = (gn),		\
-		.pin_base = (s),			\
-		.npins = ((e) - (s) + 1),		\
-		.gpps = (g),				\
-		.ngpps = (n),				\
+#define SPT_COMMUNITY(b, s, e, g, n, v, gs, gn)			\
+	{							\
+		.barno = (b),					\
+		.padown_offset = SPT_PAD_OWN,			\
+		.padcfglock_offset = SPT_##v##_PADCFGLOCK,	\
+		.hostown_offset = SPT_HOSTSW_OWN,		\
+		.is_offset = SPT_GPI_IS,			\
+		.ie_offset = SPT_GPI_IE,			\
+		.gpp_size = (gs),				\
+		.gpp_num_padown_regs = (gn),			\
+		.pin_base = (s),				\
+		.npins = ((e) - (s) + 1),			\
+		.gpps = (g),					\
+		.ngpps = (n),					\
 	}
 
 #define SPT_LP_COMMUNITY(b, s, e)			\
-	SPT_COMMUNITY(b, s, e, SPT_LP_PADCFGLOCK, 24, 4, NULL, 0)
+	SPT_COMMUNITY(b, s, e, NULL, 0, LP, 24, 4)
 
 #define SPT_H_GPP(r, s, e, g)				\
 	{						\
@@ -50,7 +50,7 @@
 	}
 
 #define SPT_H_COMMUNITY(b, s, e, g)			\
-	SPT_COMMUNITY(b, s, e, SPT_H_PADCFGLOCK, 0, 0, g, ARRAY_SIZE(g))
+	SPT_COMMUNITY(b, s, e, g, ARRAY_SIZE(g), H, 0, 0)
 
 /* Sunrisepoint-LP */
 static const struct pinctrl_pin_desc sptlp_pins[] = {
-- 
2.35.1

