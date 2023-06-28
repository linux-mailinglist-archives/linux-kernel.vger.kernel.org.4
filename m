Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7077A741519
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 17:37:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230413AbjF1Pco (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 11:32:44 -0400
Received: from mga09.intel.com ([134.134.136.24]:19763 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232246AbjF1PcZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 11:32:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687966345; x=1719502345;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ICZEGmnjo8mIWqvcZaLyV+IHFzcjkKGkir9xoI+1F50=;
  b=Pe4JDV6hj+t1pbcIG166ayBe1LxLcekIvU0GVBDZPgQHgc724ZKeJGdd
   NqtufppbfzFRrOEYRHgDEv+hKCnmEZPYeJG55DTZEpo971gGfja5X57ye
   GdULcXQrxQzGgSKNBblr0hDwRRicqhcbRpI+X4CCbeu0CkJv2kK6QdzaI
   4J77zu67GDvCqejQU1OAgGiEU6wHwuzOXFPWi6XtLuFIsvKdlswo8FcjQ
   1nHqqcn1GApCU8wV9P1ZewlTl1qDX8niBqYx6p6hS+0Dq9XC0v1rIMpw8
   ELLY+gm+NfoCZI42izQCEnNcnI6cQQMBzweWCOEN1t7rNR478AO58GZdP
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10755"; a="364426989"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; 
   d="scan'208";a="364426989"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2023 08:32:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10755"; a="782344681"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; 
   d="scan'208";a="782344681"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 28 Jun 2023 08:32:13 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 967CE4DA; Wed, 28 Jun 2023 18:32:14 +0300 (EEST)
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
Subject: [PATCH v1 2/4] driver core: Replace kstrdup() + strreplace() with kstrdup_and_replace()
Date:   Wed, 28 Jun 2023 18:32:09 +0300
Message-Id: <20230628153211.52988-3-andriy.shevchenko@linux.intel.com>
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
 drivers/base/core.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 3dff5037943e..af0ee691520a 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -17,7 +17,6 @@
 #include <linux/kstrtox.h>
 #include <linux/module.h>
 #include <linux/slab.h>
-#include <linux/string.h>
 #include <linux/kdev_t.h>
 #include <linux/notifier.h>
 #include <linux/of.h>
@@ -28,6 +27,7 @@
 #include <linux/netdevice.h>
 #include <linux/sched/signal.h>
 #include <linux/sched/mm.h>
+#include <linux/string_helpers.h>
 #include <linux/swiotlb.h>
 #include <linux/sysfs.h>
 #include <linux/dma-map-ops.h> /* for dma_default_coherent */
@@ -3910,10 +3910,9 @@ const char *device_get_devnode(const struct device *dev,
 		return dev_name(dev);
 
 	/* replace '!' in the name with '/' */
-	s = kstrdup(dev_name(dev), GFP_KERNEL);
+	s = kstrdup_and_replace(dev_name(dev), '!', '/', GFP_KERNEL);
 	if (!s)
 		return NULL;
-	strreplace(s, '!', '/');
 	return *tmp = s;
 }
 
-- 
2.40.0.1.gaa8946217a0b

