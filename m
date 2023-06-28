Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A808C741534
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 17:37:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232320AbjF1Pcj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 11:32:39 -0400
Received: from mga09.intel.com ([134.134.136.24]:19758 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232245AbjF1PcX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 11:32:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687966343; x=1719502343;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cHot3HUA6uOrNhNVHxLnKbqcAV9rKZZMtPBuH3yLtBI=;
  b=eI/yEPUZBMd4LGNsuMkMpQ2uOlQWJ/FyS7eO//dYWg5b02w12C2aie+s
   qcrCVe4NOsGcvyn47h5k5h4kCUP+yYDXv7UdjOJwuQAhFKPESHrRa6ru8
   WRuPN5NL++PdUkWCq4zvHfnnoEJ0m+1keDzyp8ObMH+DXvdICHpMUav9U
   ApohsoA8Rqk2/jXzbfazYPhUTOS3ZpGIPaa1vKDCBKZRLZ4Rs9vgUKFMO
   VWpHzCTXMCWuLDBbtOH3k9tp2YukOL0DInSF+nbfy9lK1xxFsr7/viEAM
   RE5Ras541Wx56zaZKGOgTEivYW3Q1VC3DiouxfRdrS8kAag0gGe3KBHik
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10755"; a="364426966"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; 
   d="scan'208";a="364426966"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2023 08:32:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10755"; a="782344683"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; 
   d="scan'208";a="782344683"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 28 Jun 2023 08:32:13 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 9FBAE516; Wed, 28 Jun 2023 18:32:14 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Saravana Kannan <saravanak@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-omap@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tero Kristo <kristo@kernel.org>,
        Andy Shevchenko <andy@kernel.org>
Subject: [PATCH v1 3/4] clk: tegra: Replace kstrdup() + strreplace() with kstrdup_and_replace()
Date:   Wed, 28 Jun 2023 18:32:10 +0300
Message-Id: <20230628153211.52988-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20230628153211.52988-1-andriy.shevchenko@linux.intel.com>
References: <20230628153211.52988-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace open coded functionalify of kstrdup_and_replace() with a call.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/clk/tegra/clk.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/tegra/clk.c b/drivers/clk/tegra/clk.c
index 26bda45813c0..071e72d1598a 100644
--- a/drivers/clk/tegra/clk.c
+++ b/drivers/clk/tegra/clk.c
@@ -14,7 +14,7 @@
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/reset-controller.h>
-#include <linux/string.h>
+#include <linux/string_helpers.h>
 
 #include <soc/tegra/fuse.h>
 
@@ -384,12 +384,10 @@ static struct device_node *tegra_clk_get_of_node(struct clk_hw *hw)
 	struct device_node *np;
 	char *node_name;
 
-	node_name = kstrdup(hw->init->name, GFP_KERNEL);
+	node_name = kstrdup_and_replace(hw->init->name, '_', '-', GFP_KERNEL);
 	if (!node_name)
 		return NULL;
 
-	strreplace(node_name, '_', '-');
-
 	for_each_child_of_node(tegra_car_np, np) {
 		if (!strcmp(np->name, node_name))
 			break;
-- 
2.40.0.1.gaa8946217a0b

