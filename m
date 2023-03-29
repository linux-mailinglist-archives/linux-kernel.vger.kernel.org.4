Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18F956CDB1B
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 15:47:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbjC2NrO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 09:47:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbjC2NrM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 09:47:12 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76AEB12B
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 06:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680097631; x=1711633631;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yixgjd44s0XfELjSEuxjT4sSEHUeg+Rlr7hga8v5ee0=;
  b=abFRDO2XZnPYAt1tuzJGPdMAZg1WKXsrTwhlMT0RCSyy8kqHh31E16P9
   Bbveg2dqQB7Wi4PIArCJeZc4NAapojl+6Q/TOG3DFSGoqjL5ScTlPiji4
   GG5FATc+FlPfMzzM+f80nHsOCB4txoXuMM1gj7owhNvAfetW88taJglh3
   sGTO7kQ5qBjmdDZXxlkDJFy3nj2oW2U3S6jXTQsR5EfmN1K2gysRETNEX
   UbNn+R+IZRoKnHYsSyepWc56oXUfqz0UPIYzaowaBZslXjophDGI0F+si
   7OPzkNz4awLxXMUAjGTNvohDyZ2AVoYPeA9cAvqeesbQM5VYakSqCux9F
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="403506231"
X-IronPort-AV: E=Sophos;i="5.98,300,1673942400"; 
   d="scan'208";a="403506231"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 06:47:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="677783357"
X-IronPort-AV: E=Sophos;i="5.98,300,1673942400"; 
   d="scan'208";a="677783357"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by orsmga007.jf.intel.com with ESMTP; 29 Mar 2023 06:47:05 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] iommu/vt-d: Remove unnecessary locking in intel_irq_remapping_alloc()
Date:   Wed, 29 Mar 2023 21:47:19 +0800
Message-Id: <20230329134721.469447-2-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230329134721.469447-1-baolu.lu@linux.intel.com>
References: <20230329134721.469447-1-baolu.lu@linux.intel.com>
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

The global rwsem dmar_global_lock was introduced by commit 3a5670e8ac932
("iommu/vt-d: Introduce a rwsem to protect global data structures"). It
is used to protect DMAR related global data from DMAR hotplug operations.

Using dmar_global_lock in intel_irq_remapping_alloc() is unnecessary as
the DMAR global data structures are not touched there. Remove it to avoid
below lockdep warning.

 ======================================================
 WARNING: possible circular locking dependency detected
 6.3.0-rc2 #468 Not tainted
 ------------------------------------------------------
 swapper/0/1 is trying to acquire lock:
 ff1db4cb40178698 (&domain->mutex){+.+.}-{3:3},
   at: __irq_domain_alloc_irqs+0x3b/0xa0

 but task is already holding lock:
 ffffffffa0c1cdf0 (dmar_global_lock){++++}-{3:3},
   at: intel_iommu_init+0x58e/0x880

 which lock already depends on the new lock.

 the existing dependency chain (in reverse order) is:

 -> #1 (dmar_global_lock){++++}-{3:3}:
        lock_acquire+0xd6/0x320
        down_read+0x42/0x180
        intel_irq_remapping_alloc+0xad/0x750
        mp_irqdomain_alloc+0xb8/0x2b0
        irq_domain_alloc_irqs_locked+0x12f/0x2d0
        __irq_domain_alloc_irqs+0x56/0xa0
        alloc_isa_irq_from_domain.isra.7+0xa0/0xe0
        mp_map_pin_to_irq+0x1dc/0x330
        setup_IO_APIC+0x128/0x210
        apic_intr_mode_init+0x67/0x110
        x86_late_time_init+0x24/0x40
        start_kernel+0x41e/0x7e0
        secondary_startup_64_no_verify+0xe0/0xeb

 -> #0 (&domain->mutex){+.+.}-{3:3}:
        check_prevs_add+0x160/0xef0
        __lock_acquire+0x147d/0x1950
        lock_acquire+0xd6/0x320
        __mutex_lock+0x9c/0xfc0
        __irq_domain_alloc_irqs+0x3b/0xa0
        dmar_alloc_hwirq+0x9e/0x120
        iommu_pmu_register+0x11d/0x200
        intel_iommu_init+0x5de/0x880
        pci_iommu_init+0x12/0x40
        do_one_initcall+0x65/0x350
        kernel_init_freeable+0x3ca/0x610
        kernel_init+0x1a/0x140
        ret_from_fork+0x29/0x50

 other info that might help us debug this:

 Possible unsafe locking scenario:

        CPU0                    CPU1
        ----                    ----
   lock(dmar_global_lock);
                                lock(&domain->mutex);
                                lock(dmar_global_lock);
   lock(&domain->mutex);

                *** DEADLOCK ***

Fixes: 9dbb8e3452ab ("irqdomain: Switch to per-domain locking")
Reviewed-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Tested-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Link: https://lore.kernel.org/r/20230314051836.23817-1-baolu.lu@linux.intel.com
---
 drivers/iommu/intel/irq_remapping.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/iommu/intel/irq_remapping.c b/drivers/iommu/intel/irq_remapping.c
index 6d01fa078c36..df9e261af0b5 100644
--- a/drivers/iommu/intel/irq_remapping.c
+++ b/drivers/iommu/intel/irq_remapping.c
@@ -311,14 +311,12 @@ static int set_ioapic_sid(struct irte *irte, int apic)
 	if (!irte)
 		return -1;
 
-	down_read(&dmar_global_lock);
 	for (i = 0; i < MAX_IO_APICS; i++) {
 		if (ir_ioapic[i].iommu && ir_ioapic[i].id == apic) {
 			sid = (ir_ioapic[i].bus << 8) | ir_ioapic[i].devfn;
 			break;
 		}
 	}
-	up_read(&dmar_global_lock);
 
 	if (sid == 0) {
 		pr_warn("Failed to set source-id of IOAPIC (%d)\n", apic);
@@ -338,14 +336,12 @@ static int set_hpet_sid(struct irte *irte, u8 id)
 	if (!irte)
 		return -1;
 
-	down_read(&dmar_global_lock);
 	for (i = 0; i < MAX_HPET_TBS; i++) {
 		if (ir_hpet[i].iommu && ir_hpet[i].id == id) {
 			sid = (ir_hpet[i].bus << 8) | ir_hpet[i].devfn;
 			break;
 		}
 	}
-	up_read(&dmar_global_lock);
 
 	if (sid == 0) {
 		pr_warn("Failed to set source-id of HPET block (%d)\n", id);
@@ -1339,9 +1335,7 @@ static int intel_irq_remapping_alloc(struct irq_domain *domain,
 	if (!data)
 		goto out_free_parent;
 
-	down_read(&dmar_global_lock);
 	index = alloc_irte(iommu, &data->irq_2_iommu, nr_irqs);
-	up_read(&dmar_global_lock);
 	if (index < 0) {
 		pr_warn("Failed to allocate IRTE\n");
 		kfree(data);
-- 
2.34.1

