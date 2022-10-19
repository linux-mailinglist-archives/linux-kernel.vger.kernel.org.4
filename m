Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82EE260373E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 02:51:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbiJSAv1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 20:51:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbiJSAvU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 20:51:20 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23CF4B03F7
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 17:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666140679; x=1697676679;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3zwXomiEc0/Qr/lnU6GyoSXL6F5EdLCqksR4gooDUl0=;
  b=RCqiQj7lq4TlWFhUlaGAi79oapea7DoZN2NovOK4UJ49gYZDx4iDZ1L2
   5mrGCyxL0LXR4GLSo2Uq9KWSiyh6YxI6XnMljWw+GmSE8lvEAVueBYWS5
   1dslA0nWZFUCJLqKeH64JnxkOzjPuG8aAAPcUEOeoyV1TXEI36Zfi36xH
   jr7Qro7crVROp30OAgEgkqkJ+3/y59dwWDqTCfCzj3bzifl2agnHh6brL
   OJqXhjQoEXbTPROy8wR/RpvuNws2+ZMdvl0kN4eoa2oIfHH7DA327g2Sr
   dp4T53/l8nbqcujyYFirofGUG47DDRrXdJFktLT0TneQfRVsdbyR1GkJg
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="289591515"
X-IronPort-AV: E=Sophos;i="5.95,194,1661842800"; 
   d="scan'208";a="289591515"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2022 17:51:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="606824807"
X-IronPort-AV: E=Sophos;i="5.95,194,1661842800"; 
   d="scan'208";a="606824807"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by orsmga006.jf.intel.com with ESMTP; 18 Oct 2022 17:51:17 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Jerry Snitselaar <jsnitsel@redhat.com>,
        Charlotte Tan <charlotte@extrahop.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] iommu/vt-d: Use rcu_lock in get_resv_regions
Date:   Wed, 19 Oct 2022 08:44:45 +0800
Message-Id: <20221019004447.4563-3-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221019004447.4563-1-baolu.lu@linux.intel.com>
References: <20221019004447.4563-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 5f64ce5411b46 ("iommu/vt-d: Duplicate iommu_resv_region objects
per device list") converted rcu_lock in get_resv_regions to
dmar_global_lock to allow sleeping in iommu_alloc_resv_region(). This
introduced possible recursive locking if get_resv_regions is called from
within a section where intel_iommu_init() already holds dmar_global_lock.

Especially, after commit 57365a04c921 ("iommu: Move bus setup to IOMMU
device registration"), below lockdep splats could always be seen.

 ============================================
 WARNING: possible recursive locking detected
 6.0.0-rc4+ #325 Tainted: G          I
 --------------------------------------------
 swapper/0/1 is trying to acquire lock:
 ffffffffa8a18c90 (dmar_global_lock){++++}-{3:3}, at:
 intel_iommu_get_resv_regions+0x25/0x270

 but task is already holding lock:
 ffffffffa8a18c90 (dmar_global_lock){++++}-{3:3}, at:
 intel_iommu_init+0x36d/0x6ea

 ...

 Call Trace:
  <TASK>
  dump_stack_lvl+0x48/0x5f
  __lock_acquire.cold.73+0xad/0x2bb
  lock_acquire+0xc2/0x2e0
  ? intel_iommu_get_resv_regions+0x25/0x270
  ? lock_is_held_type+0x9d/0x110
  down_read+0x42/0x150
  ? intel_iommu_get_resv_regions+0x25/0x270
  intel_iommu_get_resv_regions+0x25/0x270
  iommu_create_device_direct_mappings.isra.28+0x8d/0x1c0
  ? iommu_get_dma_cookie+0x6d/0x90
  bus_iommu_probe+0x19f/0x2e0
  iommu_device_register+0xd4/0x130
  intel_iommu_init+0x3e1/0x6ea
  ? iommu_setup+0x289/0x289
  ? rdinit_setup+0x34/0x34
  pci_iommu_init+0x12/0x3a
  do_one_initcall+0x65/0x320
  ? rdinit_setup+0x34/0x34
  ? rcu_read_lock_sched_held+0x5a/0x80
  kernel_init_freeable+0x28a/0x2f3
  ? rest_init+0x1b0/0x1b0
  kernel_init+0x1a/0x130
  ret_from_fork+0x1f/0x30
  </TASK>

This rolls back dmar_global_lock to rcu_lock in get_resv_regions to avoid
the lockdep splat.

Fixes: 57365a04c921 ("iommu: Move bus setup to IOMMU device registration")
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Tested-by: Alex Williamson <alex.williamson@redhat.com>
Link: https://lore.kernel.org/r/20220927053109.4053662-3-baolu.lu@linux.intel.com
---
 drivers/iommu/intel/iommu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index d5965b4f8b60..b3cf0f991e29 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4534,7 +4534,7 @@ static void intel_iommu_get_resv_regions(struct device *device,
 	struct device *i_dev;
 	int i;
 
-	down_read(&dmar_global_lock);
+	rcu_read_lock();
 	for_each_rmrr_units(rmrr) {
 		for_each_active_dev_scope(rmrr->devices, rmrr->devices_cnt,
 					  i, i_dev) {
@@ -4553,14 +4553,14 @@ static void intel_iommu_get_resv_regions(struct device *device,
 
 			resv = iommu_alloc_resv_region(rmrr->base_address,
 						       length, prot, type,
-						       GFP_KERNEL);
+						       GFP_ATOMIC);
 			if (!resv)
 				break;
 
 			list_add_tail(&resv->list, head);
 		}
 	}
-	up_read(&dmar_global_lock);
+	rcu_read_unlock();
 
 #ifdef CONFIG_INTEL_IOMMU_FLOPPY_WA
 	if (dev_is_pci(device)) {
-- 
2.34.1

