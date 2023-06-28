Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9420774155A
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 17:37:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232395AbjF1Pcx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 11:32:53 -0400
Received: from mga02.intel.com ([134.134.136.20]:53515 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232234AbjF1Pc3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 11:32:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687966348; x=1719502348;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1tDiKollzsfCXGV+rVmP0hmFqWtqHNqcUethxH+1FHg=;
  b=GApZaMPlGRGY8SSVi8X594qIiWkpDh388LSvIQOwJ9BNCe7uXIkjucry
   UXFZ2IPswT787HTNF72SSsVTaIVI2yHhQMu5yexveYM52A7jpfFP7CZnc
   P+0ixHmBDsdr2YGPzHiOHf6rK0V/Bi8i3PrO4MHv7xN62m+d6Dy+fU40l
   AajzU5Bim1k7H57pDq9JDWUfijSxl0YgSEObe3wN4W1ZrRJHLb/RvpqU6
   7j4G0DLcRONI3yJSb/HlxTLv99m1y6D3avqpBsVc/4zDkceHsB81yIibG
   bdBUMfidqtaAOBIMuOCUqqAIG24lby+JvPTBHp9gmPxFWY3UfG4A6otqd
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10755"; a="351666446"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; 
   d="scan'208";a="351666446"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2023 08:32:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10755"; a="720270169"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; 
   d="scan'208";a="720270169"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 28 Jun 2023 08:32:13 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id ABFBB51E; Wed, 28 Jun 2023 18:32:14 +0300 (EEST)
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
Subject: [PATCH v1 4/4] clk: ti: Replace kstrdup() + strreplace() with kstrdup_and_replace()
Date:   Wed, 28 Jun 2023 18:32:11 +0300
Message-Id: <20230628153211.52988-5-andriy.shevchenko@linux.intel.com>
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
 drivers/clk/ti/clk.c     | 4 ++--
 drivers/clk/ti/clkctrl.c | 9 +++++----
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/ti/clk.c b/drivers/clk/ti/clk.c
index 3d636938a739..1862958ab412 100644
--- a/drivers/clk/ti/clk.c
+++ b/drivers/clk/ti/clk.c
@@ -16,6 +16,7 @@
 #include <linux/of_address.h>
 #include <linux/list.h>
 #include <linux/regmap.h>
+#include <linux/string_helpers.h>
 #include <linux/memblock.h>
 #include <linux/device.h>
 
@@ -123,10 +124,9 @@ static struct device_node *ti_find_clock_provider(struct device_node *from,
 	const char *n;
 	char *tmp;
 
-	tmp = kstrdup(name, GFP_KERNEL);
+	tmp = kstrdup_and_replace(name, '-', '_', GFP_KERNEL);
 	if (!tmp)
 		return NULL;
-	strreplace(tmp, '-', '_');
 
 	/* Node named "clock" with "clock-output-names" */
 	for_each_of_allnodes_from(from, np) {
diff --git a/drivers/clk/ti/clkctrl.c b/drivers/clk/ti/clkctrl.c
index 8c40f10280b7..607e34d8e289 100644
--- a/drivers/clk/ti/clkctrl.c
+++ b/drivers/clk/ti/clkctrl.c
@@ -13,6 +13,7 @@
 #include <linux/of_address.h>
 #include <linux/clk/ti.h>
 #include <linux/delay.h>
+#include <linux/string_helpers.h>
 #include <linux/timekeeping.h>
 #include "clock.h"
 
@@ -473,11 +474,11 @@ static const char * __init clkctrl_get_name(struct device_node *np)
 	const int prefix_len = 11;
 	const char *compat;
 	const char *output;
+	const char *end;
 	char *name;
 
 	if (!of_property_read_string_index(np, "clock-output-names", 0,
 					   &output)) {
-		const char *end;
 		int len;
 
 		len = strlen(output);
@@ -491,13 +492,13 @@ static const char * __init clkctrl_get_name(struct device_node *np)
 
 	of_property_for_each_string(np, "compatible", prop, compat) {
 		if (!strncmp("ti,clkctrl-", compat, prefix_len)) {
+			end = compat + prefix_len;
 			/* Two letter minimum name length for l3, l4 etc */
-			if (strnlen(compat + prefix_len, 16) < 2)
+			if (strnlen(end, 16) < 2)
 				continue;
-			name = kasprintf(GFP_KERNEL, "%s", compat + prefix_len);
+			name = kstrdup_and_replace(end, '-', '_', GFP_KERNEL);
 			if (!name)
 				continue;
-			strreplace(name, '-', '_');
 
 			return name;
 		}
-- 
2.40.0.1.gaa8946217a0b

