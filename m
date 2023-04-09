Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08D826DC136
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Apr 2023 21:25:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbjDITZi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Apr 2023 15:25:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjDITZh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Apr 2023 15:25:37 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9159B270F;
        Sun,  9 Apr 2023 12:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681068336; x=1712604336;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=d8y4zcDo3RUvXohTtriNL5tmru6NFlkUE+wPH0iIbgI=;
  b=GMwVg2FK4ksywPwud7/AgcZt54yYpaz7U3tpY6mysiSHuuRY3+Mto+Wj
   IOlQCMpNBj1R7NpoI5FuIUVyg1wk7LUP7E+sBhFQNrgkQLKCSNB33HUh6
   gsgngEKouvNYkr2tBAMssnbg8X0YknX4GiYtNYb5URiYZWHWN6i07k2RV
   4zgYxU0Tkd/hWpUnUcy+P/BrbSQfcUWqCBFbY68dByEsOxXsaYMxSS7DO
   Gp0MGc9b/r7kV8riBfjyZMZgREU7frzbbQ3u2P1Wup9wuz32YkiMzwqdT
   lMBOMZDa9jAf+p6efvv8r/pNrWq2BOwzn9v8gJFokcBLy9GyD//ksyHX7
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10675"; a="323609759"
X-IronPort-AV: E=Sophos;i="5.98,331,1673942400"; 
   d="scan'208";a="323609759"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2023 12:25:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10675"; a="1017778879"
X-IronPort-AV: E=Sophos;i="5.98,331,1673942400"; 
   d="scan'208";a="1017778879"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga005.fm.intel.com with ESMTP; 09 Apr 2023 12:25:35 -0700
Received: from debox1-desk4.lan (unknown [10.251.5.84])
        by linux.intel.com (Postfix) with ESMTP id AE71C580BF6;
        Sun,  9 Apr 2023 12:25:35 -0700 (PDT)
From:   "David E. Box" <david.e.box@linux.intel.com>
To:     srinivas.pandruvada@linux.intel.com, irenic.rajneesh@gmail.com,
        david.e.box@intel.com, hdegoede@redhat.com, markgross@kernel.org,
        rjw@rjwysocki.net
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2] platform/x86/intel/pmc/mtl: Put GNA/IPU/VPU devices in D3
Date:   Sun,  9 Apr 2023 12:25:35 -0700
Message-Id: <20230409192535.914540-1-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Meteor Lake, the GNA, IPU, and VPU devices are booted in D0 power state
and will block the SoC from going into the deepest Package C-state if a
driver is not present. Put each device in D3hot if no driver is found.

Signed-off-by: David E. Box <david.e.box@linux.intel.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
---

V2 - Fix missing static reported by lkp

 drivers/platform/x86/intel/pmc/mtl.c | 31 ++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/platform/x86/intel/pmc/mtl.c b/drivers/platform/x86/intel/pmc/mtl.c
index eeb3bd8c2502..33aa98b54049 100644
--- a/drivers/platform/x86/intel/pmc/mtl.c
+++ b/drivers/platform/x86/intel/pmc/mtl.c
@@ -8,6 +8,7 @@
  *
  */
 
+#include <linux/pci.h>
 #include "core.h"
 
 const struct pmc_reg_map mtl_reg_map = {
@@ -45,8 +46,38 @@ void mtl_core_configure(struct pmc_dev *pmcdev)
 	pmc_core_send_ltr_ignore(pmcdev, 3);
 }
 
+#define MTL_GNA_PCI_DEV	0x7e4c
+#define MTL_IPU_PCI_DEV	0x7d19
+#define MTL_VPU_PCI_DEV	0x7d1d
+static void mtl_set_device_d3(unsigned int device)
+{
+	struct pci_dev *pcidev;
+
+	pcidev = pci_get_device(PCI_VENDOR_ID_INTEL, device, NULL);
+	if (pcidev) {
+		if (!device_trylock(&pcidev->dev)) {
+			pci_dev_put(pcidev);
+			return;
+		}
+		if (!pcidev->dev.driver) {
+			dev_info(&pcidev->dev, "Setting to D3hot\n");
+			pci_set_power_state(pcidev, PCI_D3hot);
+		}
+		device_unlock(&pcidev->dev);
+		pci_dev_put(pcidev);
+	}
+}
+
 void mtl_core_init(struct pmc_dev *pmcdev)
 {
 	pmcdev->map = &mtl_reg_map;
 	pmcdev->core_configure = mtl_core_configure;
+
+	/*
+	 * Set power state of select devices that do not have drivers to D3
+	 * so that they do not block Package C entry.
+	 */
+	mtl_set_device_d3(MTL_GNA_PCI_DEV);
+	mtl_set_device_d3(MTL_IPU_PCI_DEV);
+	mtl_set_device_d3(MTL_VPU_PCI_DEV);
 }

base-commit: 4f59630a5ed0a4e7d275bd7e5d253a8f5a425c5a
-- 
2.34.1

