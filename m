Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7642972451E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 16:00:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237533AbjFFOAT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 10:00:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237283AbjFFOAO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 10:00:14 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 608F28F;
        Tue,  6 Jun 2023 07:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686060013; x=1717596013;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+YfBe28FJBeWLtVuxtwibWtJc96Mf0mg0trJtgQ5LNo=;
  b=RaNkACGuPWjLX49AcNF2OIeE2kh2L9B2OBm73zV0cikAwhbcYybG0JHT
   HP1VeLo2k7SKVZZNtq32N7MBqeSQmI2BWE88d4SgbMRsharbNZ1qFDoxr
   1elRVUNcdRLC/+Ui/qUZ3u0BckD6GUaQh+xTOpemfj+1jZmMQsiqAyptX
   4tvwrEomkghPayjX4p91AwLZ0SqUnmrDOFsF2gA8UppeLRYbKqI7SnFer
   3+cfF5CrmWiBDN3CbCZE5J706juFi0TQ6PkvX4sgnaQ3vrSaZWFxiBZaz
   IuOZNoE91V8flp+CoU+nUiq+K8BV8kfDJDMbvyEu5HOdmd5usrSagOUXo
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="337030889"
X-IronPort-AV: E=Sophos;i="6.00,221,1681196400"; 
   d="scan'208";a="337030889"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2023 07:00:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="955762442"
X-IronPort-AV: E=Sophos;i="6.00,221,1681196400"; 
   d="scan'208";a="955762442"
Received: from lwang35-mobl1.ccr.corp.intel.com (HELO rzhang1-mobl7.ccr.corp.intel.com) ([10.254.212.138])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2023 07:00:11 -0700
From:   Zhang Rui <rui.zhang@intel.com>
To:     linux-pm@vger.kernel.org, rafael.j.wysocki@intel.com,
        daniel.lezcano@linaro.org
Cc:     linux-kernel@vger.kernel.org, arnd@arndb.de
Subject: [PATCH] powercap: intel_rapl: Fix CONFIG_IOSF_MBI dependency
Date:   Tue,  6 Jun 2023 22:00:00 +0800
Message-Id: <20230606140000.385223-1-rui.zhang@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After commit 3382388d7148 ("intel_rapl: abstract RAPL common code"),
accessing to IOSF_MBI interface is done in the RAPL common code.

Thus it is the CONFIG_INTEL_RAPL_CORE that has dependency of
CONFIG_IOSF_MBI, while CONFIG_INTEL_RAPL_MSR does not.

This problem was not exposed previously because all the previous RAPL
common code users, aka, the RAPL MSR and MMIO I/F drivers, have
CONFIG_IOSF_MBI selected.

Fix the CONFIG_IOSF_MBI dependency in RAPL code. This also fixes a build
time failure when the RAPL TPMI I/F driver is introduced without
selecting CONFIG_IOSF_MBI.

x86_64-linux-ld: vmlinux.o: in function `set_floor_freq_atom':
intel_rapl_common.c:(.text+0x2dac9b8): undefined reference to `iosf_mbi_write'
x86_64-linux-ld: intel_rapl_common.c:(.text+0x2daca66): undefined reference to `iosf_mbi_read'

Reference to iosf_mbi.h is also removed from the RAPL MSR I/F driver.

Fixes: 3382388d7148 ("intel_rapl: abstract RAPL common code")
Reported-by: Arnd Bergmann <arnd@arndb.de>
Link: https://lore.kernel.org/all/20230601213246.3271412-1-arnd@kernel.org
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/powercap/Kconfig          | 4 +++-
 drivers/powercap/intel_rapl_msr.c | 1 -
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/powercap/Kconfig b/drivers/powercap/Kconfig
index 90d33cd1b670..b063f7511773 100644
--- a/drivers/powercap/Kconfig
+++ b/drivers/powercap/Kconfig
@@ -18,10 +18,12 @@ if POWERCAP
 # Client driver configurations go here.
 config INTEL_RAPL_CORE
 	tristate
+	depends on PCI
+	select IOSF_MBI
 
 config INTEL_RAPL
 	tristate "Intel RAPL Support via MSR Interface"
-	depends on X86 && IOSF_MBI
+	depends on X86 && PCI
 	select INTEL_RAPL_CORE
 	help
 	  This enables support for the Intel Running Average Power Limit (RAPL)
diff --git a/drivers/powercap/intel_rapl_msr.c b/drivers/powercap/intel_rapl_msr.c
index a27673706c3d..be118d46f32e 100644
--- a/drivers/powercap/intel_rapl_msr.c
+++ b/drivers/powercap/intel_rapl_msr.c
@@ -22,7 +22,6 @@
 #include <linux/processor.h>
 #include <linux/platform_device.h>
 
-#include <asm/iosf_mbi.h>
 #include <asm/cpu_device_id.h>
 #include <asm/intel-family.h>
 
-- 
2.34.1

