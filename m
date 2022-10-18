Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B52606035F2
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 00:34:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbiJRWeM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 18:34:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiJRWeJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 18:34:09 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FE132BB35;
        Tue, 18 Oct 2022 15:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666132449; x=1697668449;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=F9JP4Rut70+5vMxDTp1Mi/+AlzNzYRFFWAXbDZNeCb8=;
  b=ndtSk4JPgG2dy4m44i8jkEP5Nv3Prpv7oONtT+dHjkTW5WGA+uLnvswp
   PgeqAbPeWtrSoHhEDCZWgB9nTNd2CG54kWtKk3Vca74DYM0V0ostvnwIm
   f+6DdhIDAEns9oe04j/oIIZtHXLYBWHluWLUMkN8SYaP3edmfiRJo3QfM
   7tz+1oDcLqi3nUCgHEa695Ya+aFIfPO2i/wMGCOOcBpqzN3xFOmjDTIo/
   zlXWCrFE5s8eNl4pKBRbYTNowxX8ViEcQE20+Hazx/KQnkaoIbmSihNqk
   yPFjnEOeFDy2buKh89KAbj2xIDliNSS2Fbb03dU/2nUqXmcfIqbzTIswD
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="306236223"
X-IronPort-AV: E=Sophos;i="5.95,194,1661842800"; 
   d="scan'208";a="306236223"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2022 15:34:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="697745778"
X-IronPort-AV: E=Sophos;i="5.95,194,1661842800"; 
   d="scan'208";a="697745778"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 18 Oct 2022 15:34:07 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 9E203B9; Wed, 19 Oct 2022 01:34:28 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v1 1/5] pinctrl: alderlake: Deduplicate COMMUNITY macro code
Date:   Wed, 19 Oct 2022 01:34:23 +0300
Message-Id: <20221018223427.43579-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
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
 drivers/pinctrl/intel/pinctrl-alderlake.c | 40 +++++++++--------------
 1 file changed, 16 insertions(+), 24 deletions(-)

diff --git a/drivers/pinctrl/intel/pinctrl-alderlake.c b/drivers/pinctrl/intel/pinctrl-alderlake.c
index 1bf24ab7b380..19ecc0596bf5 100644
--- a/drivers/pinctrl/intel/pinctrl-alderlake.c
+++ b/drivers/pinctrl/intel/pinctrl-alderlake.c
@@ -34,33 +34,25 @@
 		.gpio_base = (g),			\
 	}
 
-#define ADL_N_COMMUNITY(b, s, e, g)			\
-	{						\
-		.barno = (b),				\
-		.padown_offset = ADL_N_PAD_OWN,		\
-		.padcfglock_offset = ADL_N_PADCFGLOCK,	\
-		.hostown_offset = ADL_N_HOSTSW_OWN,	\
-		.is_offset = ADL_N_GPI_IS,		\
-		.ie_offset = ADL_N_GPI_IE,		\
-		.pin_base = (s),			\
-		.npins = ((e) - (s) + 1),		\
-		.gpps = (g),				\
-		.ngpps = ARRAY_SIZE(g),			\
+#define ADL_COMMUNITY(b, s, e, g, v)				\
+	{							\
+		.barno = (b),					\
+		.padown_offset = ADL_##v##_PAD_OWN,		\
+		.padcfglock_offset = ADL_##v##_PADCFGLOCK,	\
+		.hostown_offset = ADL_##v##_HOSTSW_OWN,		\
+		.is_offset = ADL_##v##_GPI_IS,			\
+		.ie_offset = ADL_##v##_GPI_IE,			\
+		.pin_base = (s),				\
+		.npins = ((e) - (s) + 1),			\
+		.gpps = (g),					\
+		.ngpps = ARRAY_SIZE(g),				\
 	}
 
+#define ADL_N_COMMUNITY(b, s, e, g)			\
+	ADL_COMMUNITY(b, s, e, g, N)
+
 #define ADL_S_COMMUNITY(b, s, e, g)			\
-	{						\
-		.barno = (b),				\
-		.padown_offset = ADL_S_PAD_OWN,		\
-		.padcfglock_offset = ADL_S_PADCFGLOCK,	\
-		.hostown_offset = ADL_S_HOSTSW_OWN,	\
-		.is_offset = ADL_S_GPI_IS,		\
-		.ie_offset = ADL_S_GPI_IE,		\
-		.pin_base = (s),			\
-		.npins = ((e) - (s) + 1),		\
-		.gpps = (g),				\
-		.ngpps = ARRAY_SIZE(g),			\
-	}
+	ADL_COMMUNITY(b, s, e, g, S)
 
 /* Alder Lake-N */
 static const struct pinctrl_pin_desc adln_pins[] = {
-- 
2.35.1

