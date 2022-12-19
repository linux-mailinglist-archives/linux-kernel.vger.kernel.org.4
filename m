Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC3FA650B72
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 13:27:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231938AbiLSM0j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 07:26:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231480AbiLSM02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 07:26:28 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4CD2DF80;
        Mon, 19 Dec 2022 04:26:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671452787; x=1702988787;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=K2LaJiLKaUW/4G+McBMfmTJMsJ8YFJbOAo1OVYBbZ7k=;
  b=EjZWE402lDdiArU7dwY495+RmlV5w/1vKLBAl9j8l8LosHZsKrpJwZeP
   RXDXYyo+m0xlmEYO5PrIVdmUC4MGAlsfBIM6V2Y4h8dGN7O3uNy1ZDTlo
   JLKU4+v1MrzzHZgFFdCrRTAv5XR+e1sgoFBgZasfJFiQHk9pUHPddpNI1
   /lqGaIgNA+HaOkB+2PUWlSwDnlO4imrpOs3FxTxEMtoG4D9KMzrPglEIt
   ZMByWkeeiYmNvZGUmkoN5tWtEXMsGIprQp8rvDF3d3ZGuMh7RWA8oeN/G
   ZBDDQfFx+6cOZ46fk4uk8JwrJmpqsq8U5EuxOcOpHn+0nMKd5fQawxH9i
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10565"; a="319382650"
X-IronPort-AV: E=Sophos;i="5.96,255,1665471600"; 
   d="scan'208";a="319382650"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2022 04:26:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10565"; a="628283682"
X-IronPort-AV: E=Sophos;i="5.96,255,1665471600"; 
   d="scan'208";a="628283682"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 19 Dec 2022 04:26:24 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 9E600F7; Mon, 19 Dec 2022 14:26:54 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v1 01/17] pinctrl: intel: Introduce INTEL_COMMUNITY_*() to unify community macros
Date:   Mon, 19 Dec 2022 14:26:27 +0200
Message-Id: <20221219122643.3513-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
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

Now it becomes visible that we can deduplicate SoC specific
*_COMMUNITY() macros across the Intel pin control drivers.
For that, introduce a common INTEL_COMMUNITY_GPPS() and
INTEL_COMMUNITY_SIZE() macros in the pinctrl-intel.h.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pinctrl/intel/pinctrl-intel.h | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/pinctrl/intel/pinctrl-intel.h b/drivers/pinctrl/intel/pinctrl-intel.h
index 65628423bf63..b0f2be4c1fd1 100644
--- a/drivers/pinctrl/intel/pinctrl-intel.h
+++ b/drivers/pinctrl/intel/pinctrl-intel.h
@@ -143,6 +143,28 @@ struct intel_community {
 #define PINCTRL_FEATURE_BLINK		BIT(4)
 #define PINCTRL_FEATURE_EXP		BIT(5)
 
+#define __INTEL_COMMUNITY(b, s, e, g, n, gs, gn, soc)		\
+	{							\
+		.barno = (b),					\
+		.padown_offset = soc ## _PAD_OWN,		\
+		.padcfglock_offset = soc ## _PADCFGLOCK,	\
+		.hostown_offset = soc ## _HOSTSW_OWN,		\
+		.is_offset = soc ## _GPI_IS,			\
+		.ie_offset = soc ## _GPI_IE,			\
+		.gpp_size = (gs),				\
+		.gpp_num_padown_regs = (gn),			\
+		.pin_base = (s),				\
+		.npins = ((e) - (s) + 1),			\
+		.gpps = (g),					\
+		.ngpps = (n),					\
+	}
+
+#define INTEL_COMMUNITY_GPPS(b, s, e, g, soc)			\
+	__INTEL_COMMUNITY(b, s, e, g, ARRAY_SIZE(g), 0, 0, soc)
+
+#define INTEL_COMMUNITY_SIZE(b, s, e, gs, gn, soc)		\
+	__INTEL_COMMUNITY(b, s, e, NULL, 0, gs, gn, soc)
+
 /**
  * PIN_GROUP - Declare a pin group
  * @n: Name of the group
-- 
2.35.1

