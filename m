Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB8DC6BDC23
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 23:58:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230235AbjCPW5j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 18:57:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbjCPW5i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 18:57:38 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46061C5ADD;
        Thu, 16 Mar 2023 15:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679007457; x=1710543457;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=qwfHlTCxA1ylkKrdEJyrKd/vE/qqC1tP3ZmUkPiWOKY=;
  b=I4xDHW40p8EE9wt69Ocf10NcFBsI8hwCZHSMs45osnvkKkKdJgFC8eGv
   ppuak4UO1ifYIFtjwFE/ag6uzB1/cThcXdYqyi54UViEyTwD7zbJ+R1Kq
   ycnKNp7WWK+EbeIVPf8CNIOxW0xxHHgM/OP8HHI8kvu/k0e+Od9XHcIG2
   yaglbW0WSjNox1prC/Ome/s58P96u+p+zxgyBZ5PWOTAWsYs4WELFSBVM
   adIhVNNKALYkNtvPKwqpssIJonb6vVbkbX1q5JRbRyvIq2PPncs46y+mY
   FhNSXq5Wu0AUkdqn6r2HVuaE5Z8axqoMHIg1BwBXGK/Vr2hiHUERiE71q
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10651"; a="321984196"
X-IronPort-AV: E=Sophos;i="5.98,267,1673942400"; 
   d="scan'208";a="321984196"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2023 15:57:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10651"; a="803914129"
X-IronPort-AV: E=Sophos;i="5.98,267,1673942400"; 
   d="scan'208";a="803914129"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga004.jf.intel.com with ESMTP; 16 Mar 2023 15:57:36 -0700
Received: from debox1-desk4.intel.com (unknown [10.212.175.15])
        by linux.intel.com (Postfix) with ESMTP id 6A7D6580C1F;
        Thu, 16 Mar 2023 15:57:36 -0700 (PDT)
From:   "David E. Box" <david.e.box@linux.intel.com>
To:     irenic.rajneesh@gmail.com, david.e.box@intel.com,
        hdegoede@redhat.com, markgross@kernel.org,
        andy.shevchenko@gmail.com
Cc:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: [PATCH 1/2] platform/x86/intel/pmt: Add INTEL_PMT module namespace
Date:   Thu, 16 Mar 2023 15:57:35 -0700
Message-Id: <20230316225736.2856521-1-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the currently exported symbols in pmt_class are only used by other
Intel PMT drivers, create an INTEL_PMT module namespace for them.

Signed-off-by: David E. Box <david.e.box@linux.intel.com>
---
 drivers/platform/x86/intel/pmt/class.c     | 6 +++---
 drivers/platform/x86/intel/pmt/crashlog.c  | 1 +
 drivers/platform/x86/intel/pmt/telemetry.c | 1 +
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/x86/intel/pmt/class.c b/drivers/platform/x86/intel/pmt/class.c
index 46598dcb634a..0b96d75f5924 100644
--- a/drivers/platform/x86/intel/pmt/class.c
+++ b/drivers/platform/x86/intel/pmt/class.c
@@ -33,7 +33,7 @@ bool intel_pmt_is_early_client_hw(struct device *dev)
 	 */
 	return !!(ivdev->info->quirks & VSEC_QUIRK_EARLY_HW);
 }
-EXPORT_SYMBOL_GPL(intel_pmt_is_early_client_hw);
+EXPORT_SYMBOL_NS_GPL(intel_pmt_is_early_client_hw, INTEL_PMT);
 
 static inline int
 pmt_memcpy64_fromio(void *to, const u64 __iomem *from, size_t count)
@@ -327,7 +327,7 @@ int intel_pmt_dev_create(struct intel_pmt_entry *entry, struct intel_pmt_namespa
 	return intel_pmt_dev_register(entry, ns, dev);
 
 }
-EXPORT_SYMBOL_GPL(intel_pmt_dev_create);
+EXPORT_SYMBOL_NS_GPL(intel_pmt_dev_create, INTEL_PMT);
 
 void intel_pmt_dev_destroy(struct intel_pmt_entry *entry,
 			   struct intel_pmt_namespace *ns)
@@ -343,7 +343,7 @@ void intel_pmt_dev_destroy(struct intel_pmt_entry *entry,
 	device_unregister(dev);
 	xa_erase(ns->xa, entry->devid);
 }
-EXPORT_SYMBOL_GPL(intel_pmt_dev_destroy);
+EXPORT_SYMBOL_NS_GPL(intel_pmt_dev_destroy, INTEL_PMT);
 
 static int __init pmt_class_init(void)
 {
diff --git a/drivers/platform/x86/intel/pmt/crashlog.c b/drivers/platform/x86/intel/pmt/crashlog.c
index ace1239bc0a0..bbb3d61d09f4 100644
--- a/drivers/platform/x86/intel/pmt/crashlog.c
+++ b/drivers/platform/x86/intel/pmt/crashlog.c
@@ -328,3 +328,4 @@ module_exit(pmt_crashlog_exit);
 MODULE_AUTHOR("Alexander Duyck <alexander.h.duyck@linux.intel.com>");
 MODULE_DESCRIPTION("Intel PMT Crashlog driver");
 MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS(INTEL_PMT);
diff --git a/drivers/platform/x86/intel/pmt/telemetry.c b/drivers/platform/x86/intel/pmt/telemetry.c
index 5e4009c05ecf..71cdef42084a 100644
--- a/drivers/platform/x86/intel/pmt/telemetry.c
+++ b/drivers/platform/x86/intel/pmt/telemetry.c
@@ -160,3 +160,4 @@ module_exit(pmt_telem_exit);
 MODULE_AUTHOR("David E. Box <david.e.box@linux.intel.com>");
 MODULE_DESCRIPTION("Intel PMT Telemetry driver");
 MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS(INTEL_PMT);

base-commit: 79df06733435e2773eb5e9ab9c0ce13c23e4cd88
-- 
2.34.1

