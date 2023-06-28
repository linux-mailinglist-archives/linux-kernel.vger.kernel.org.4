Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BE2274151B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 17:37:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232285AbjF1Pcc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 11:32:32 -0400
Received: from mga02.intel.com ([134.134.136.20]:53515 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232242AbjF1PcT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 11:32:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687966338; x=1719502338;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Ud9mOLRXe2468JTAmvr7pvOnXoRBmeLuDYPpo8mbgqM=;
  b=XTWEzvdVo3V4B+QKMA+hJJgJXoIEMbZAq7lGNT3H1UwvyljQSQyUe0gI
   22Vsxx6tFx8b5eDY8Spo1R7fBSu6tvjVEz2l7HRplpjaZx21B5bhSD1oJ
   EzlntW6WtfqCHCdIOl5ryxm15aC8V+XX3EfGwa97R65lC1jlT5h8oeu3i
   Rb2c9HdM6DHyPTm2ORJFdFvNAugFt9S5+GVXO2LXo3r+i7Wnu8tWb2pBe
   pSBAx3ggdvNS7ECePE5mSsHQmJoPa/E0IGBd/4AEEOVg8WTrFdfj1ndWA
   28eMaS67ejrTpw7aRkY0mjrbgSIiW17eGtSsHt1aBl77Wk4UyjXUyDDM2
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10755"; a="351666434"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; 
   d="scan'208";a="351666434"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2023 08:32:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10755"; a="720270171"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; 
   d="scan'208";a="720270171"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 28 Jun 2023 08:32:13 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 83997E1; Wed, 28 Jun 2023 18:32:14 +0300 (EEST)
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
Subject: [PATCH v1 0/4] clk: Add kstrdup_and_replace() helper and use it
Date:   Wed, 28 Jun 2023 18:32:07 +0300
Message-Id: <20230628153211.52988-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are a few existing users and more might come which would like
to have the kstrdup_and_replace() functionality.

Provide this new API and reuse it in a few users.

Since most of that is under CCF, perhaps it makes sense to route it
via that tree.

Andy Shevchenko (4):
  lib/string_helpers: Add kstrdup_and_replace() helper
  driver core: Replace kstrdup() + strreplace() with
    kstrdup_and_replace()
  clk: tegra: Replace kstrdup() + strreplace() with
    kstrdup_and_replace()
  clk: ti: Replace kstrdup() + strreplace() with kstrdup_and_replace()

 drivers/base/core.c            |  5 ++---
 drivers/clk/tegra/clk.c        |  6 ++----
 drivers/clk/ti/clk.c           |  4 ++--
 drivers/clk/ti/clkctrl.c       |  9 +++++----
 include/linux/string_helpers.h |  2 ++
 lib/string_helpers.c           | 15 +++++++++++++++
 6 files changed, 28 insertions(+), 13 deletions(-)

-- 
2.40.0.1.gaa8946217a0b

