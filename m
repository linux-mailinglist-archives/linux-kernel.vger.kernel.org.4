Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51BEE6BBC2A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 19:34:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232153AbjCOSe1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 14:34:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231769AbjCOSeM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 14:34:12 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE156AD28;
        Wed, 15 Mar 2023 11:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678905250; x=1710441250;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SLZM9Rd4ZbAV+HV63P8xQDOFKv2CzGBHIeab4YXE1bU=;
  b=SxtjaWDHZuGsebxR2EtzSIvWNRtT3D9kLv/51mbZlFikK/GdSGLAVNh/
   6BqrYbrqGbVzxfKXGWlXrjhYMFGlrfhQxDh0C2Z9LMQ+LLK0uDW4WzLso
   Yk+2hTylaHyOdtJOwzmp1AxCp6qxgC2VT6Whd2HlXnFsHk9HS0izX63Dy
   CuoBkpgicWpkukjuaM/s5zQVY/1kdgYKLl+eCoHLQ6QvFvfnr6shqqJPB
   VLBkTK+gUoIKe/dbO8hDV9M0G/SeEZR9R4h6r5PPPfD7Xb2p5rBN6OBYF
   7gta8GwFKlrYHbMHdDpekiklzt2W183kH9kT52zAYAEoFRne80gbMV1jM
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10650"; a="340154538"
X-IronPort-AV: E=Sophos;i="5.98,262,1673942400"; 
   d="scan'208";a="340154538"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2023 11:34:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10650"; a="925435208"
X-IronPort-AV: E=Sophos;i="5.98,262,1673942400"; 
   d="scan'208";a="925435208"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga006.fm.intel.com with ESMTP; 15 Mar 2023 11:34:07 -0700
Received: from debox1-desk4.intel.com (unknown [10.209.75.205])
        by linux.intel.com (Postfix) with ESMTP id 19268580D2C;
        Wed, 15 Mar 2023 11:34:07 -0700 (PDT)
From:   "David E. Box" <david.e.box@linux.intel.com>
To:     irenic.rajneesh@gmail.com, david.e.box@linux.intel.com,
        hdegoede@redhat.com, markgross@kernel.org,
        andy.shevchenko@gmail.com, rajvi.jingar@linux.intel.com,
        xi.pardee@intel.com
Cc:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: [PATCH 04/11] platform/x86/intel/pmt: Add INTEL_PMT module namespace
Date:   Wed, 15 Mar 2023 11:33:58 -0700
Message-Id: <20230315183405.2465630-5-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230315183405.2465630-1-david.e.box@linux.intel.com>
References: <20230315183405.2465630-1-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
index 7136475d4ab5..acc96f0cc224 100644
--- a/drivers/platform/x86/intel/pmt/class.c
+++ b/drivers/platform/x86/intel/pmt/class.c
@@ -33,7 +33,7 @@ bool intel_pmt_is_early_client_hw(struct device *dev)
 	 */
 	return !!(ivdev->quirks & VSEC_QUIRK_EARLY_HW);
 }
-EXPORT_SYMBOL_GPL(intel_pmt_is_early_client_hw);
+EXPORT_SYMBOL_NS_GPL(intel_pmt_is_early_client_hw, INTEL_PMT);
 
 static inline int
 pmt_memcpy64_fromio(void *to, const u64 __iomem *from, size_t count)
@@ -335,7 +335,7 @@ int intel_pmt_dev_create(struct intel_pmt_entry *entry, struct intel_pmt_namespa
 	return intel_pmt_dev_register(entry, ns, dev);
 
 }
-EXPORT_SYMBOL_GPL(intel_pmt_dev_create);
+EXPORT_SYMBOL_NS_GPL(intel_pmt_dev_create, INTEL_PMT);
 
 void intel_pmt_dev_destroy(struct intel_pmt_entry *entry,
 			   struct intel_pmt_namespace *ns)
@@ -351,7 +351,7 @@ void intel_pmt_dev_destroy(struct intel_pmt_entry *entry,
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
-- 
2.34.1

