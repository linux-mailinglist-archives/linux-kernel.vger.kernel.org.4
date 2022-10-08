Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BCE15F8733
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Oct 2022 21:44:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbiJHTow (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Oct 2022 15:44:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbiJHTop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Oct 2022 15:44:45 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F7E2E0D3;
        Sat,  8 Oct 2022 12:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665258284; x=1696794284;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=9lmz04rN+kLTMcQl6akRYapYbLeumDWgsbmmCsC6CtU=;
  b=WwLoRxANyePd6/AGKdL1KfiF92b/LIthMsuLpQ0WJcc7DG7Fu4ni3sTl
   sNETUMCieVwsPuUWdABqjin5uym3LOtv+Qi1bnmGhZUqKczh9NZnzvoGJ
   mb/AzvfCaeNkZjXJadTTpeMtNErWvWkQpmCZXewFERUPqPse05hcaitb4
   teRizaUltkxjnmv24RH8yFG/82CV3TEYKMjZ3+ocFp5a7MrQcs68ALe0y
   ALh9SPjQdorLQyKr5jGDpiBPQyiRoLZ6icAjwBEdxazDlxC6U40T+foFS
   JUb41YP4KtOWmT9hM+jVlXYO4atPSMUS+7MZUSsAu5Kh7UucoCaOdIW3k
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10494"; a="303961674"
X-IronPort-AV: E=Sophos;i="5.95,170,1661842800"; 
   d="scan'208";a="303961674"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2022 12:44:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10494"; a="730041067"
X-IronPort-AV: E=Sophos;i="5.95,170,1661842800"; 
   d="scan'208";a="730041067"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 08 Oct 2022 12:44:41 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 1C797D0; Sat,  8 Oct 2022 22:45:02 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] thunderbolt: Use str_enabled_disabled() helper
Date:   Sat,  8 Oct 2022 22:45:01 +0300
Message-Id: <20221008194501.38157-1-andriy.shevchenko@linux.intel.com>
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

Use str_enabled_disabled() helper instead of open coding the same.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/thunderbolt/switch.c  | 5 +++--
 drivers/thunderbolt/xdomain.c | 3 ++-
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/thunderbolt/switch.c b/drivers/thunderbolt/switch.c
index 60da5c23ccaf..363d712aa364 100644
--- a/drivers/thunderbolt/switch.c
+++ b/drivers/thunderbolt/switch.c
@@ -8,12 +8,13 @@
 
 #include <linux/delay.h>
 #include <linux/idr.h>
+#include <linux/module.h>
 #include <linux/nvmem-provider.h>
 #include <linux/pm_runtime.h>
 #include <linux/sched/signal.h>
 #include <linux/sizes.h>
 #include <linux/slab.h>
-#include <linux/module.h>
+#include <linux/string_helpers.h>
 
 #include "tb.h"
 
@@ -644,7 +645,7 @@ static int __tb_port_enable(struct tb_port *port, bool enable)
 	if (ret)
 		return ret;
 
-	tb_port_dbg(port, "lane %sabled\n", enable ? "en" : "dis");
+	tb_port_dbg(port, "lane %s\n", str_enabled_disabled(enable));
 	return 0;
 }
 
diff --git a/drivers/thunderbolt/xdomain.c b/drivers/thunderbolt/xdomain.c
index f00b2f62d8e3..ddd8fd2d06f8 100644
--- a/drivers/thunderbolt/xdomain.c
+++ b/drivers/thunderbolt/xdomain.c
@@ -13,6 +13,7 @@
 #include <linux/module.h>
 #include <linux/pm_runtime.h>
 #include <linux/prandom.h>
+#include <linux/string_helpers.h>
 #include <linux/utsname.h>
 #include <linux/uuid.h>
 #include <linux/workqueue.h>
@@ -1344,7 +1345,7 @@ static int tb_xdomain_bond_lanes_uuid_high(struct tb_xdomain *xd)
 	tb_port_update_credits(port);
 	tb_xdomain_update_link_attributes(xd);
 
-	dev_dbg(&xd->dev, "lane bonding %sabled\n", width == 2 ? "en" : "dis");
+	dev_dbg(&xd->dev, "lane bonding %s\n", str_enabled_disabled(width == 2));
 	return 0;
 }
 
-- 
2.35.1

