Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8E0A650B75
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 13:27:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231996AbiLSM0q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 07:26:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231749AbiLSM0a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 07:26:30 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F329DDF7C;
        Mon, 19 Dec 2022 04:26:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671452789; x=1702988789;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9H3NXshAzg/RDaoFhIoQKl84tEskXKz1FHtjrazybbU=;
  b=EK6hJzUI6B1jax7sAIFQmjxAEum8yyYiVskia7hm1QQizfhu0BD8s6ct
   e3S2TZ/7/rtOvkYku4PAowTUtOhp4O1bdzReNJX1pLk9HBVSg1OrSfveJ
   XfbP6OV3wsIhiSXUogxtIqmhbfBN6kFIbS6soX46vTJip/2ofJmcpBq2L
   z2KgUw2sglOQdEly3QgC2vps/j0iUkVMWTQ3MGcpxD8NtNlqiR6gF+RMX
   eyX/xY3ilz13RPcthgcNby98LZ+JZvFTdwZYBRx0K2EcHf9jQM0uFi6Do
   zVL9dlvXWHMLIzEoOnNEhGn+U1NaAts09sV8JBRQ9dwSqUhxhg05UmFGt
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10565"; a="319382665"
X-IronPort-AV: E=Sophos;i="5.96,255,1665471600"; 
   d="scan'208";a="319382665"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2022 04:26:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10565"; a="628283700"
X-IronPort-AV: E=Sophos;i="5.96,255,1665471600"; 
   d="scan'208";a="628283700"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 19 Dec 2022 04:26:27 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id F29A0529; Mon, 19 Dec 2022 14:26:54 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v1 09/17] pinctrl: geminilake: Replace GLK_COMMUNITY() by INTEL_COMMUNITY_SIZE()
Date:   Mon, 19 Dec 2022 14:26:35 +0200
Message-Id: <20221219122643.3513-9-andriy.shevchenko@linux.intel.com>
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

Use INTEL_COMMUNITY_SIZE() common macro instead custom GLK_COMMUNITY().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pinctrl/intel/pinctrl-geminilake.c | 21 ++++++---------------
 1 file changed, 6 insertions(+), 15 deletions(-)

diff --git a/drivers/pinctrl/intel/pinctrl-geminilake.c b/drivers/pinctrl/intel/pinctrl-geminilake.c
index df02028b40f3..918cc9f261cf 100644
--- a/drivers/pinctrl/intel/pinctrl-geminilake.c
+++ b/drivers/pinctrl/intel/pinctrl-geminilake.c
@@ -20,17 +20,8 @@
 #define GLK_GPI_IS	0x100
 #define GLK_GPI_IE	0x110
 
-#define GLK_COMMUNITY(s, e)				\
-	{						\
-		.padown_offset = GLK_PAD_OWN,		\
-		.padcfglock_offset = GLK_PADCFGLOCK,	\
-		.hostown_offset = GLK_HOSTSW_OWN,	\
-		.is_offset = GLK_GPI_IS,		\
-		.ie_offset = GLK_GPI_IE,		\
-		.gpp_size = 32,                         \
-		.pin_base = (s),			\
-		.npins = ((e) - (s) + 1),		\
-	}
+#define GLK_COMMUNITY(b, s, e)				\
+	INTEL_COMMUNITY_SIZE(b, s, e, 32, 4, GLK)
 
 /* GLK */
 static const struct pinctrl_pin_desc glk_northwest_pins[] = {
@@ -173,7 +164,7 @@ static const struct intel_function glk_northwest_functions[] = {
 };
 
 static const struct intel_community glk_northwest_communities[] = {
-	GLK_COMMUNITY(0, 79),
+	GLK_COMMUNITY(0, 0, 79),
 };
 
 static const struct intel_pinctrl_soc_data glk_northwest_soc_data = {
@@ -306,7 +297,7 @@ static const struct intel_function glk_north_functions[] = {
 };
 
 static const struct intel_community glk_north_communities[] = {
-	GLK_COMMUNITY(0, 79),
+	GLK_COMMUNITY(0, 0, 79),
 };
 
 static const struct intel_pinctrl_soc_data glk_north_soc_data = {
@@ -345,7 +336,7 @@ static const struct pinctrl_pin_desc glk_audio_pins[] = {
 };
 
 static const struct intel_community glk_audio_communities[] = {
-	GLK_COMMUNITY(0, 19),
+	GLK_COMMUNITY(0, 0, 19),
 };
 
 static const struct intel_pinctrl_soc_data glk_audio_soc_data = {
@@ -427,7 +418,7 @@ static const struct intel_function glk_scc_functions[] = {
 };
 
 static const struct intel_community glk_scc_communities[] = {
-	GLK_COMMUNITY(0, 34),
+	GLK_COMMUNITY(0, 0, 34),
 };
 
 static const struct intel_pinctrl_soc_data glk_scc_soc_data = {
-- 
2.35.1

