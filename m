Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EA73607FE9
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 22:40:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbiJUUkK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 16:40:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbiJUUjz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 16:39:55 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4204145F56;
        Fri, 21 Oct 2022 13:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666384794; x=1697920794;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0oi6a1r6EcPszIqWC+40MwHJFgZnvwStu7e0P4Y7NfE=;
  b=D87opjzQ56rckhXfyOOu2iltjphgKhcPa/DSPI4yCEm71iScmDG3peYE
   /xkiKqoItDIb5Hay5s7H2pUKATrkraasOwp+2N6i38ZQCgeaCN4f0TudT
   JupBpvc6LCiu4i0Sqx1gZ2W6eiQRBMZarvRfIOqt+Y+bdAmO1KYFItKHj
   qQ4qHbHQAPlWgXcJ6xc38rxJGMcqrPLr4N4VGMvDXcVRUO5CS8k/whbSw
   2juLq3wsSj7hrhxua9Vj7L3wtivhv5cy3S+v5XNC7g+vJjKKL264fliZ+
   fNzXxZDXZ1ra1jTvwgRGNzcpOAU0cfk5EwF4jMonkOuqgduebkfa3SXos
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10507"; a="369161176"
X-IronPort-AV: E=Sophos;i="5.95,203,1661842800"; 
   d="scan'208";a="369161176"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2022 13:35:34 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10507"; a="735701004"
X-IronPort-AV: E=Sophos;i="5.95,203,1661842800"; 
   d="scan'208";a="735701004"
Received: from jithujos.sc.intel.com ([172.25.103.66])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2022 13:35:34 -0700
From:   Jithu Joseph <jithu.joseph@intel.com>
To:     hdegoede@redhat.com, markgross@kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        gregkh@linuxfoundation.org, jithu.joseph@intel.com,
        ashok.raj@intel.com, tony.luck@intel.com,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        patches@lists.linux.dev, ravi.v.shankar@intel.com,
        thiago.macieira@intel.com, athenas.jimenez.gonzalez@intel.com
Subject: [PATCH 04/14] platform/x86/intel/ifs: Remove image loading during init
Date:   Fri, 21 Oct 2022 13:34:03 -0700
Message-Id: <20221021203413.1220137-5-jithu.joseph@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221021203413.1220137-1-jithu.joseph@intel.com>
References: <20221021203413.1220137-1-jithu.joseph@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Existing implementation loads IFS test image during the driver
init flow.

Dropping test image loading from the init path improves
module load time.

Prior to starting IFS tests, the user has to load one of
the IFS test images by writing to the current_batch sysfs file.

Removing IFS test image  loading during init also allows us to
make ifs_sem static as it is used only within sysfs.c.

Reviewed-by: Tony Luck <tony.luck@intel.com>
Suggested-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Jithu Joseph <jithu.joseph@intel.com>
---
 drivers/platform/x86/intel/ifs/ifs.h   | 2 --
 drivers/platform/x86/intel/ifs/core.c  | 6 +-----
 drivers/platform/x86/intel/ifs/sysfs.c | 2 +-
 3 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/platform/x86/intel/ifs/ifs.h b/drivers/platform/x86/intel/ifs/ifs.h
index 782bcc039ddb..be37512535f2 100644
--- a/drivers/platform/x86/intel/ifs/ifs.h
+++ b/drivers/platform/x86/intel/ifs/ifs.h
@@ -229,6 +229,4 @@ int ifs_load_firmware(struct device *dev);
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
index 4af4e1bea98d..766cee651bd6 100644
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

