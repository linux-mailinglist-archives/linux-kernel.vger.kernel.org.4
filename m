Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37DEF6202B6
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 23:55:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232829AbiKGWzE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 17:55:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232448AbiKGWyr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 17:54:47 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AA0DCE0D;
        Mon,  7 Nov 2022 14:54:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667861686; x=1699397686;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Dcr0ozJ6OYs4trai4as92Ss4tTrZMrxeoFkgWXi5vd8=;
  b=cvcobvUuOxu0fgJ4zGlC1gTkVI+z5AXQ5E4yH86KYIsk97mSOBQGScvK
   2P6965l89T7qgNGaOQYGFrtf+Az7DwYKmen7pLozyuHCD0Ybv8U4wgGIc
   Mo3/UZ8zHlXgMgMiNR2rI8LSg/DYh2m+cU+vDm7Lvv5m2yD2TIRSvI30v
   EgxFg5AZxlrCt9y8uBvNRWghfeyEr67QuNSSwKo2Pi6kzVKwSuY40Ohmq
   /KVEDT7rgtu7IdVOtOx2oOOeNExEmpSEQ+ACsHo4OqxnLUvbCw4jIHpUD
   DMDqZTVMUTo8PkmNM2uOPBVB0vJ6U+k7FE3Mv5Z16YKPPe181tRxO9QHP
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="293911824"
X-IronPort-AV: E=Sophos;i="5.96,145,1665471600"; 
   d="scan'208";a="293911824"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2022 14:54:45 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="811012960"
X-IronPort-AV: E=Sophos;i="5.96,145,1665471600"; 
   d="scan'208";a="811012960"
Received: from jithujos.sc.intel.com ([172.25.103.66])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2022 14:54:45 -0800
From:   Jithu Joseph <jithu.joseph@intel.com>
To:     hdegoede@redhat.com, markgross@kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        gregkh@linuxfoundation.org, jithu.joseph@intel.com,
        ashok.raj@intel.com, tony.luck@intel.com,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        patches@lists.linux.dev, ravi.v.shankar@intel.com,
        thiago.macieira@intel.com, athenas.jimenez.gonzalez@intel.com,
        sohil.mehta@intel.com
Subject: [PATCH v2 03/14] platform/x86/intel/ifs: Remove image loading during init
Date:   Mon,  7 Nov 2022 14:53:12 -0800
Message-Id: <20221107225323.2733518-4-jithu.joseph@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221107225323.2733518-1-jithu.joseph@intel.com>
References: <20221021203413.1220137-1-jithu.joseph@intel.com>
 <20221107225323.2733518-1-jithu.joseph@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IFS test image is unnecessarily loaded during driver initialization.
Drop image loading during ifs_init() and improve module load time.
With this change, user has to load one when starting the tests.

As a consequence, make ifs_sem static as it is only used within sysfs.c

Reviewed-by: Tony Luck <tony.luck@intel.com>
Suggested-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Jithu Joseph <jithu.joseph@intel.com>
---
 drivers/platform/x86/intel/ifs/ifs.h   | 2 --
 drivers/platform/x86/intel/ifs/core.c  | 6 +-----
 drivers/platform/x86/intel/ifs/sysfs.c | 2 +-
 3 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/platform/x86/intel/ifs/ifs.h b/drivers/platform/x86/intel/ifs/ifs.h
index 73c8e91cf144..3ff1d9aaeaa9 100644
--- a/drivers/platform/x86/intel/ifs/ifs.h
+++ b/drivers/platform/x86/intel/ifs/ifs.h
@@ -229,6 +229,4 @@ void ifs_load_firmware(struct device *dev);
 int do_core_test(int cpu, struct device *dev);
 const struct attribute_group **ifs_get_groups(void);
 
-extern struct semaphore ifs_sem;
-
 #endif
diff --git a/drivers/platform/x86/intel/ifs/core.c b/drivers/platform/x86/intel/ifs/core.c
index 27204e3d674d..5fb7f655c291 100644
--- a/drivers/platform/x86/intel/ifs/core.c
+++ b/drivers/platform/x86/intel/ifs/core.c
@@ -51,12 +51,8 @@ static int __init ifs_init(void)
 	ifs_device.misc.groups = ifs_get_groups();
 
 	if ((msrval & BIT(ifs_device.data.integrity_cap_bit)) &&
-	    !misc_register(&ifs_device.misc)) {
-		down(&ifs_sem);
-		ifs_load_firmware(ifs_device.misc.this_device);
-		up(&ifs_sem);
+	    !misc_register(&ifs_device.misc))
 		return 0;
-	}
 
 	return -ENODEV;
 }
diff --git a/drivers/platform/x86/intel/ifs/sysfs.c b/drivers/platform/x86/intel/ifs/sysfs.c
index 37d8380d6fa8..65dd6fea5342 100644
--- a/drivers/platform/x86/intel/ifs/sysfs.c
+++ b/drivers/platform/x86/intel/ifs/sysfs.c
@@ -13,7 +13,7 @@
  * Protects against simultaneous tests on multiple cores, or
  * reloading can file while a test is in progress
  */
-DEFINE_SEMAPHORE(ifs_sem);
+static DEFINE_SEMAPHORE(ifs_sem);
 
 /*
  * The sysfs interface to check additional details of last test
-- 
2.25.1

