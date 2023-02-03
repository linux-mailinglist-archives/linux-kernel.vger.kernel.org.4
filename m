Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF0C3688C60
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 02:17:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230173AbjBCBRW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 20:17:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjBCBRV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 20:17:21 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6271A6D5E5;
        Thu,  2 Feb 2023 17:17:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675387040; x=1706923040;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=DunWI0D1UYCD9oCFpos2SGm+zwZr0Xy0kTS7gmQZqD8=;
  b=J3N9I1sdpuWT/YZRoswX0sUjrk+5FtjgpsM4DYqY9QEFK4sUZezWaJn1
   aT+S+aq9KVDLq6GbCKWqX+iB1DzDJrJ7sdpMxh06WuI2aFVw/WMStrgl6
   bTt4vjfrrKXFqaBcco0LDx2R/u5Au36zLkkImm+SQH5TmxughBuc6UJhw
   3+LkHmHTN8BhMKVPkI6ickZNqFU8GQt0zLTQ91o0TP9xR0jMO2RSdLtCS
   aeCo6/BMjEEc1igSaPugoHiNY7K86juyTeT8S5K8lwD2cl11tRYRlHzWq
   t8HgrjMvuaFXFjB18Q8wMJ/NQ29vX7eg6u4+rRt/rtwDIhQT5oXXJI3GC
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10609"; a="391022888"
X-IronPort-AV: E=Sophos;i="5.97,269,1669104000"; 
   d="scan'208";a="391022888"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2023 17:17:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10609"; a="665532534"
X-IronPort-AV: E=Sophos;i="5.97,269,1669104000"; 
   d="scan'208";a="665532534"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga002.jf.intel.com with ESMTP; 02 Feb 2023 17:17:18 -0800
Received: from debox1-desk4.intel.com (unknown [10.209.17.79])
        by linux.intel.com (Postfix) with ESMTP id 9CC255808BA;
        Thu,  2 Feb 2023 17:17:18 -0800 (PST)
From:   "David E. Box" <david.e.box@linux.intel.com>
To:     david.e.box@linux.intel.com, hdegoede@redhat.com,
        markgross@kernel.org
Cc:     Gayatri Kammela <gayatri.kammela@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] platform/x86/intel/vsec: Add support for Meteor Lake
Date:   Thu,  2 Feb 2023 17:17:16 -0800
Message-Id: <20230203011716.1078003-1-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gayatri Kammela <gayatri.kammela@linux.intel.com>

Add Meteor Lake PMT telemetry support.

Signed-off-by: Gayatri Kammela <gayatri.kammela@linux.intel.com>
Signed-off-by: David E. Box <david.e.box@linux.intel.com>
---
 drivers/platform/x86/intel/vsec.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/platform/x86/intel/vsec.c b/drivers/platform/x86/intel/vsec.c
index 07ae77a3bbe4..bc38fe4962b2 100644
--- a/drivers/platform/x86/intel/vsec.c
+++ b/drivers/platform/x86/intel/vsec.c
@@ -419,14 +419,23 @@ static const struct intel_vsec_platform_info dg1_info = {
 	.quirks = VSEC_QUIRK_NO_DVSEC | VSEC_QUIRK_EARLY_HW,
 };
 
+/* MTL info */
+static const struct intel_vsec_platform_info mtl_info = {
+	.quirks = VSEC_QUIRK_NO_WATCHER | VSEC_QUIRK_NO_CRASHLOG,
+};
+
 #define PCI_DEVICE_ID_INTEL_VSEC_ADL		0x467d
 #define PCI_DEVICE_ID_INTEL_VSEC_DG1		0x490e
+#define PCI_DEVICE_ID_INTEL_VSEC_MTL_M		0x7d0d
+#define PCI_DEVICE_ID_INTEL_VSEC_MTL_S		0xad0d
 #define PCI_DEVICE_ID_INTEL_VSEC_OOBMSM		0x09a7
 #define PCI_DEVICE_ID_INTEL_VSEC_RPL		0xa77d
 #define PCI_DEVICE_ID_INTEL_VSEC_TGL		0x9a0d
 static const struct pci_device_id intel_vsec_pci_ids[] = {
 	{ PCI_DEVICE_DATA(INTEL, VSEC_ADL, &tgl_info) },
 	{ PCI_DEVICE_DATA(INTEL, VSEC_DG1, &dg1_info) },
+	{ PCI_DEVICE_DATA(INTEL, VSEC_MTL_M, &mtl_info) },
+	{ PCI_DEVICE_DATA(INTEL, VSEC_MTL_S, &mtl_info) },
 	{ PCI_DEVICE_DATA(INTEL, VSEC_OOBMSM, &(struct intel_vsec_platform_info) {}) },
 	{ PCI_DEVICE_DATA(INTEL, VSEC_RPL, &tgl_info) },
 	{ PCI_DEVICE_DATA(INTEL, VSEC_TGL, &tgl_info) },
-- 
2.34.1

