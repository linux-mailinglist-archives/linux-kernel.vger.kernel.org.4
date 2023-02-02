Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E52F6872D0
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 02:09:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230479AbjBBBJQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 20:09:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjBBBJD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 20:09:03 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1F0A4ED26;
        Wed,  1 Feb 2023 17:09:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675300141; x=1706836141;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=l3Pi5pRFRYGc5u8IPh/RxqSovVxp2fgjAvKiIcXzht4=;
  b=HqUE/Ji8t4NpBP4KdByyyG6SiFnxtagafbT2GkZuoXCeNtpwSFCWxMgG
   Psyf452JjuaCw6WORY/6kOYsigAiEEnfsKA6MiRdn6LBccCivqy9NKhDW
   DYt8A0ryQNAaWtbP8RY7dEnrv6aWwzwYGFfTsd1zhFRZ1wHkDNmk/Kyb4
   2nvbYdK3Ji1cIjtg0RlCt/vZbBPd5WU8bSaPmOFKMV7Ym4Su4ehlNWO7n
   k7DV4YW9Fgi4EfcvRKeWUw6ryWZAZz4ATkoJSjQ9da1BAyv0U7UbUhWnt
   kN4yvv4K75ltez7KLWPNSGJmXTmZ2Mg7d5a8OTUaCL3Lu2p1WSE3rsWS3
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10608"; a="355654307"
X-IronPort-AV: E=Sophos;i="5.97,266,1669104000"; 
   d="scan'208";a="355654307"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2023 17:08:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10608"; a="665087925"
X-IronPort-AV: E=Sophos;i="5.97,266,1669104000"; 
   d="scan'208";a="665087925"
Received: from spandruv-desk.jf.intel.com ([10.54.75.8])
  by orsmga002.jf.intel.com with ESMTP; 01 Feb 2023 17:08:15 -0800
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     hdegoede@redhat.com, markgross@kernel.org
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        "David E . Box" <david.e.box@linux.intel.com>
Subject: [PATCH 2/7] platform/x86/intel/vsec: Enhance and Export intel_vsec_add_aux()
Date:   Wed,  1 Feb 2023 17:07:33 -0800
Message-Id: <20230202010738.2186174-3-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230202010738.2186174-1-srinivas.pandruvada@linux.intel.com>
References: <20230202010738.2186174-1-srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove static for intel_vsec_add_aux() and export this interface so that
it can be used by other vsec related modules.

This driver creates aux devices by parsing PCI-VSEC, which allows
individual drivers to load on those devices. Those driver may further
create more devices on aux bus by parsing the PCI MMIO region.

For example, TPMI (Topology Aware Register and PM Capsule Interface)
creates device nodes for power management features by parsing MMIO region.

When TPMI driver creates devices, it can reuse existing function
intel_vsec_add_aux() to create aux devices with TPMI device as the parent.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Acked-by: David E. Box <david.e.box@linux.intel.com>
---
 drivers/platform/x86/intel/vsec.c | 16 +++++++++++-----
 drivers/platform/x86/intel/vsec.h |  4 ++++
 2 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/platform/x86/intel/vsec.c b/drivers/platform/x86/intel/vsec.c
index a82b2a5ed99d..b936fc5776d7 100644
--- a/drivers/platform/x86/intel/vsec.c
+++ b/drivers/platform/x86/intel/vsec.c
@@ -138,8 +138,9 @@ static void intel_vsec_dev_release(struct device *dev)
 	kfree(intel_vsec_dev);
 }
 
-static int intel_vsec_add_aux(struct pci_dev *pdev, struct intel_vsec_device *intel_vsec_dev,
-			      const char *name)
+int intel_vsec_add_aux(struct pci_dev *pdev, struct device *parent,
+		       struct intel_vsec_device *intel_vsec_dev,
+		       const char *name)
 {
 	struct auxiliary_device *auxdev = &intel_vsec_dev->auxdev;
 	int ret, id;
@@ -150,9 +151,12 @@ static int intel_vsec_add_aux(struct pci_dev *pdev, struct intel_vsec_device *in
 		return ret;
 	}
 
+	if (!parent)
+		parent = &pdev->dev;
+
 	auxdev->id = ret;
 	auxdev->name = name;
-	auxdev->dev.parent = &pdev->dev;
+	auxdev->dev.parent = parent;
 	auxdev->dev.release = intel_vsec_dev_release;
 
 	ret = auxiliary_device_init(auxdev);
@@ -169,7 +173,7 @@ static int intel_vsec_add_aux(struct pci_dev *pdev, struct intel_vsec_device *in
 		return ret;
 	}
 
-	ret = devm_add_action_or_reset(&pdev->dev, intel_vsec_remove_aux,
+	ret = devm_add_action_or_reset(parent, intel_vsec_remove_aux,
 				       auxdev);
 	if (ret < 0)
 		return ret;
@@ -182,6 +186,7 @@ static int intel_vsec_add_aux(struct pci_dev *pdev, struct intel_vsec_device *in
 
 	return 0;
 }
+EXPORT_SYMBOL_NS_GPL(intel_vsec_add_aux, INTEL_VSEC);
 
 static int intel_vsec_add_dev(struct pci_dev *pdev, struct intel_vsec_header *header,
 			      struct intel_vsec_platform_info *info)
@@ -239,7 +244,8 @@ static int intel_vsec_add_dev(struct pci_dev *pdev, struct intel_vsec_header *he
 	else
 		intel_vsec_dev->ida = &intel_vsec_ida;
 
-	return intel_vsec_add_aux(pdev, intel_vsec_dev, intel_vsec_name(header->id));
+	return intel_vsec_add_aux(pdev, NULL, intel_vsec_dev,
+				  intel_vsec_name(header->id));
 }
 
 static bool intel_vsec_walk_header(struct pci_dev *pdev,
diff --git a/drivers/platform/x86/intel/vsec.h b/drivers/platform/x86/intel/vsec.h
index 3deeb05cf394..d02c340fd458 100644
--- a/drivers/platform/x86/intel/vsec.h
+++ b/drivers/platform/x86/intel/vsec.h
@@ -40,6 +40,10 @@ struct intel_vsec_device {
 	int num_resources;
 };
 
+int intel_vsec_add_aux(struct pci_dev *pdev, struct device *parent,
+		       struct intel_vsec_device *intel_vsec_dev,
+		       const char *name);
+
 static inline struct intel_vsec_device *dev_to_ivdev(struct device *dev)
 {
 	return container_of(dev, struct intel_vsec_device, auxdev.dev);
-- 
2.31.1

