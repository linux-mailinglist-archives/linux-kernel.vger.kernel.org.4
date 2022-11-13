Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E2786271F4
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Nov 2022 20:10:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235273AbiKMTKP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 14:10:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235317AbiKMTKK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 14:10:10 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0142213D69
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 11:10:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668366609; x=1699902609;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=cXvk/lfUOGyjHOe2uztoH6XTJP4Hv46hzt35fKtKj1Q=;
  b=QBR99jOIrBhC1rzNueF2K3gIuEGquB2c1/OBE23laSqeBYzi32rxiw0C
   RCAw3avywWzzn2QDWkwqMrYteSU8w1UpobNgsYLOk5hZyjVSyeevFVSGy
   qs6lQbcvFh1ydJpGi1Hpbg9slgWT+PUajtr9OGshtfWThaQU6y/gIMKxZ
   5ke2uQeAOsEcBS5YWGgzndGjkF9EanCbwlGRt7drDRcB0usUPb/9RIJB3
   zWAEz2L4/T3Ha3mYuZa9ztnesFqi4orBSVPCm9noXoPjcKMqOfUoKE3PQ
   TCCxQNS4LyWZLQZZA8jOk35SoSdfJIrNcYCl5t08C/CL+FMRI8/NnG8fR
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10530"; a="291551679"
X-IronPort-AV: E=Sophos;i="5.96,161,1665471600"; 
   d="scan'208";a="291551679"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2022 11:10:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10530"; a="743867540"
X-IronPort-AV: E=Sophos;i="5.96,161,1665471600"; 
   d="scan'208";a="743867540"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 13 Nov 2022 11:10:07 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id B7780F7; Sun, 13 Nov 2022 21:10:31 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Lee Jones <lee@kernel.org>, Liviu Dudau <liviu.dudau@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v1 1/1] mfd: vexpress-sysreg: Fix resource compound literal assignments
Date:   Sun, 13 Nov 2022 21:10:27 +0200
Message-Id: <20221113191027.2327-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since DEFINE_RES_*() macros were converted to provide a compound literal
the user doesn't need to repeat it. Moreover, it may not be compiled.

Fixes: 9c973ce7f9cf ("resource: Convert DEFINE_RES_NAMED() to be compound literal")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---

Should go via Greg's tree where ioport.h has been changed.

 drivers/mfd/vexpress-sysreg.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/mfd/vexpress-sysreg.c b/drivers/mfd/vexpress-sysreg.c
index aaf24af287dd..eab82619ec31 100644
--- a/drivers/mfd/vexpress-sysreg.c
+++ b/drivers/mfd/vexpress-sysreg.c
@@ -61,35 +61,27 @@ static struct mfd_cell vexpress_sysreg_cells[] = {
 		.name = "basic-mmio-gpio",
 		.of_compatible = "arm,vexpress-sysreg,sys_led",
 		.num_resources = 1,
-		.resources = (struct resource []) {
-			DEFINE_RES_MEM_NAMED(SYS_LED, 0x4, "dat"),
-		},
+		.resources = &DEFINE_RES_MEM_NAMED(SYS_LED, 0x4, "dat"),
 		.platform_data = &vexpress_sysreg_sys_led_pdata,
 		.pdata_size = sizeof(vexpress_sysreg_sys_led_pdata),
 	}, {
 		.name = "basic-mmio-gpio",
 		.of_compatible = "arm,vexpress-sysreg,sys_mci",
 		.num_resources = 1,
-		.resources = (struct resource []) {
-			DEFINE_RES_MEM_NAMED(SYS_MCI, 0x4, "dat"),
-		},
+		.resources = &DEFINE_RES_MEM_NAMED(SYS_MCI, 0x4, "dat"),
 		.platform_data = &vexpress_sysreg_sys_mci_pdata,
 		.pdata_size = sizeof(vexpress_sysreg_sys_mci_pdata),
 	}, {
 		.name = "basic-mmio-gpio",
 		.of_compatible = "arm,vexpress-sysreg,sys_flash",
 		.num_resources = 1,
-		.resources = (struct resource []) {
-			DEFINE_RES_MEM_NAMED(SYS_FLASH, 0x4, "dat"),
-		},
+		.resources = &DEFINE_RES_MEM_NAMED(SYS_FLASH, 0x4, "dat"),
 		.platform_data = &vexpress_sysreg_sys_flash_pdata,
 		.pdata_size = sizeof(vexpress_sysreg_sys_flash_pdata),
 	}, {
 		.name = "vexpress-syscfg",
 		.num_resources = 1,
-		.resources = (struct resource []) {
-			DEFINE_RES_MEM(SYS_MISC, 0x4c),
-		},
+		.resources = &DEFINE_RES_MEM(SYS_MISC, 0x4c),
 	}
 };
 
-- 
2.35.1

