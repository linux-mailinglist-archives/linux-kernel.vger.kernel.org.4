Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42B1C62E050
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 16:51:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233886AbiKQPvE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 10:51:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232330AbiKQPvA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 10:51:00 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7BAA701A3;
        Thu, 17 Nov 2022 07:50:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668700260; x=1700236260;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cYyJRRqnn9LuozWNUU94VNSroJbrg0Ie5N7Qf+vQFFo=;
  b=i07X19J3FLnKXHXXo2G24rT3ifV8NOgsOb3hlsjIm/VJ5m5VV3FBXQeD
   jpwSmhHHMiBc7ekkzuoRZaZ6l221UGRs3loAKzrVJCfPuXHIaOfHSOg0J
   aB5vJR1GtsZFTzNlHWBRn+PTwzr+yfVbzI4Si6gSdorKYo768zg4BDuqX
   FDhv8merY8So21tUclfQEX/2RP3AJ+4ZShZf/UpTdgqAn4ScRfMROKmsH
   jaS+WjFPE532tJtHqT9pX2VBHeh3fODiXuIwhAAayCHb0bS+UByTDZ1/r
   wWZbo/qW59OCkTylgff+d2SLFcbTjMpH2Jtc1X+fFEIqAybM48JqwOt61
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10534"; a="312898971"
X-IronPort-AV: E=Sophos;i="5.96,171,1665471600"; 
   d="scan'208";a="312898971"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2022 07:50:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10534"; a="968919504"
X-IronPort-AV: E=Sophos;i="5.96,171,1665471600"; 
   d="scan'208";a="968919504"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 17 Nov 2022 07:50:48 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 0EEEC385; Thu, 17 Nov 2022 17:51:14 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Subject: [PATCH v1 3/3] clk: fractional-divider: Regroup inclusions
Date:   Thu, 17 Nov 2022 17:51:05 +0200
Message-Id: <20221117155105.1486-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221117155105.1486-1-andriy.shevchenko@linux.intel.com>
References: <20221117155105.1486-1-andriy.shevchenko@linux.intel.com>
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

For the better maintenance regroup inclusions as follows:
- split CCF related headers in its own group
- order groups from generic to particular
- sort each group alphabetically

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/clk/clk-fractional-divider.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/clk-fractional-divider.c b/drivers/clk/clk-fractional-divider.c
index b6b52b79d671..ebd007f5ce5d 100644
--- a/drivers/clk/clk-fractional-divider.c
+++ b/drivers/clk/clk-fractional-divider.c
@@ -40,12 +40,14 @@
 
 #include <linux/clk-provider.h>
 #include <linux/debugfs.h>
+#include <linux/device.h>
 #include <linux/io.h>
 #include <linux/math.h>
 #include <linux/module.h>
-#include <linux/device.h>
-#include <linux/slab.h>
 #include <linux/rational.h>
+#include <linux/slab.h>
+
+#include <linux/clk-provider.h>
 
 #include "clk-fractional-divider.h"
 
-- 
2.35.1

