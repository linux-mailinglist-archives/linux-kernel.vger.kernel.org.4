Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A1B7650B6E
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 13:27:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231858AbiLSM0b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 07:26:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231470AbiLSM01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 07:26:27 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C217DEC2;
        Mon, 19 Dec 2022 04:26:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671452787; x=1702988787;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aBBWQuPXnbfhPvrb4CBjtw/6n/4eAOzLR7/jixNxHD4=;
  b=Ig6QUFBOJbxo5couUek93JtsLZJ4Cj+p20okAS7hPxRBTn9dwos1+AKv
   /sFKc2Cw+hy7shmmMQkhPP4i0fESyAEdyzaz4YwXJcX1evolu2erQVOPI
   fTQQnWbiUj0FDOBswL58cZDHIa6xrxpE5bfZUZxsnoDccnUgFmR2+3uhs
   UU6c3TNjU7H1TWyXWq3DkAsW4p3aKCYXZJetrm+Wclv2ARgKLGtWJFyBF
   dSf5E/KtffHtnJheUP+xzow8OOHOOr0G5B/Lcs3CHeACrlEzmn0knfnbN
   V7hFsn4RBk1oLB3t1dNS0weLI24wVxgXPW/ngUjMm0Hmkzb3te6biSmz2
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10565"; a="319382653"
X-IronPort-AV: E=Sophos;i="5.96,255,1665471600"; 
   d="scan'208";a="319382653"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2022 04:26:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10565"; a="628283683"
X-IronPort-AV: E=Sophos;i="5.96,255,1665471600"; 
   d="scan'208";a="628283683"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 19 Dec 2022 04:26:24 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id AE93E11D; Mon, 19 Dec 2022 14:26:54 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v1 03/17] pinctrl: broxton: Replace BXT_COMMUNITY() by INTEL_COMMUNITY_SIZE()
Date:   Mon, 19 Dec 2022 14:26:29 +0200
Message-Id: <20221219122643.3513-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221219122643.3513-1-andriy.shevchenko@linux.intel.com>
References: <20221219122643.3513-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use INTEL_COMMUNITY_SIZE() common macro instead custom BXT_COMMUNITY().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pinctrl/intel/pinctrl-broxton.c | 31 +++++++++----------------
 1 file changed, 11 insertions(+), 20 deletions(-)

diff --git a/drivers/pinctrl/intel/pinctrl-broxton.c b/drivers/pinctrl/intel/pinctrl-broxton.c
index fb15cd10a32f..77e921b2178d 100644
--- a/drivers/pinctrl/intel/pinctrl-broxton.c
+++ b/drivers/pinctrl/intel/pinctrl-broxton.c
@@ -20,17 +20,8 @@
 #define BXT_GPI_IS	0x100
 #define BXT_GPI_IE	0x110
 
-#define BXT_COMMUNITY(s, e)				\
-	{						\
-		.padown_offset = BXT_PAD_OWN,		\
-		.padcfglock_offset = BXT_PADCFGLOCK,	\
-		.hostown_offset = BXT_HOSTSW_OWN,	\
-		.is_offset = BXT_GPI_IS,		\
-		.ie_offset = BXT_GPI_IE,		\
-		.gpp_size = 32,                         \
-		.pin_base = (s),			\
-		.npins = ((e) - (s) + 1),		\
-	}
+#define BXT_COMMUNITY(b, s, e)				\
+	INTEL_COMMUNITY_SIZE(b, s, e, 32, 4, BXT)
 
 /* BXT */
 static const struct pinctrl_pin_desc bxt_north_pins[] = {
@@ -172,7 +163,7 @@ static const struct intel_function bxt_north_functions[] = {
 };
 
 static const struct intel_community bxt_north_communities[] = {
-	BXT_COMMUNITY(0, 82),
+	BXT_COMMUNITY(0, 0, 82),
 };
 
 static const struct intel_pinctrl_soc_data bxt_north_soc_data = {
@@ -289,7 +280,7 @@ static const struct intel_function bxt_northwest_functions[] = {
 };
 
 static const struct intel_community bxt_northwest_communities[] = {
-	BXT_COMMUNITY(0, 71),
+	BXT_COMMUNITY(0, 0, 71),
 };
 
 static const struct intel_pinctrl_soc_data bxt_northwest_soc_data = {
@@ -396,7 +387,7 @@ static const struct intel_function bxt_west_functions[] = {
 };
 
 static const struct intel_community bxt_west_communities[] = {
-	BXT_COMMUNITY(0, 41),
+	BXT_COMMUNITY(0, 0, 41),
 };
 
 static const struct intel_pinctrl_soc_data bxt_west_soc_data = {
@@ -472,7 +463,7 @@ static const struct intel_function bxt_southwest_functions[] = {
 };
 
 static const struct intel_community bxt_southwest_communities[] = {
-	BXT_COMMUNITY(0, 30),
+	BXT_COMMUNITY(0, 0, 30),
 };
 
 static const struct intel_pinctrl_soc_data bxt_southwest_soc_data = {
@@ -511,7 +502,7 @@ static const struct pinctrl_pin_desc bxt_south_pins[] = {
 };
 
 static const struct intel_community bxt_south_communities[] = {
-	BXT_COMMUNITY(0, 19),
+	BXT_COMMUNITY(0, 0, 19),
 };
 
 static const struct intel_pinctrl_soc_data bxt_south_soc_data = {
@@ -650,7 +641,7 @@ static const struct intel_function apl_north_functions[] = {
 };
 
 static const struct intel_community apl_north_communities[] = {
-	BXT_COMMUNITY(0, 77),
+	BXT_COMMUNITY(0, 0, 77),
 };
 
 static const struct intel_pinctrl_soc_data apl_north_soc_data = {
@@ -770,7 +761,7 @@ static const struct intel_function apl_northwest_functions[] = {
 };
 
 static const struct intel_community apl_northwest_communities[] = {
-	BXT_COMMUNITY(0, 76),
+	BXT_COMMUNITY(0, 0, 76),
 };
 
 static const struct intel_pinctrl_soc_data apl_northwest_soc_data = {
@@ -880,7 +871,7 @@ static const struct intel_function apl_west_functions[] = {
 };
 
 static const struct intel_community apl_west_communities[] = {
-	BXT_COMMUNITY(0, 46),
+	BXT_COMMUNITY(0, 0, 46),
 };
 
 static const struct intel_pinctrl_soc_data apl_west_soc_data = {
@@ -972,7 +963,7 @@ static const struct intel_function apl_southwest_functions[] = {
 };
 
 static const struct intel_community apl_southwest_communities[] = {
-	BXT_COMMUNITY(0, 42),
+	BXT_COMMUNITY(0, 0, 42),
 };
 
 static const struct intel_pinctrl_soc_data apl_southwest_soc_data = {
-- 
2.35.1

