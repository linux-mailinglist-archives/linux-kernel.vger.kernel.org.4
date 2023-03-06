Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 379D86AC891
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 17:46:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbjCFQqT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 11:46:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230365AbjCFQoZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 11:44:25 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B05D537B50;
        Mon,  6 Mar 2023 08:44:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678121042; x=1709657042;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hnUCmjmIybHYZHdFEp6Xh+18Pfsb0B0IDLJ2/svp4fg=;
  b=MMfWZynaAEG0jPCpaipD2oGWrNYzvJx5dI6I+1cCCD464/iMGKvtv/40
   4JiQj/yZdYr0cbmVI4KeE5g6FuBC6NbRtM9jMDavLfEzXN4RozsncTDfh
   1wtZiQuSzJXeLTopq+PyRR1PugYKFQ/uzSZOoyP+/WGhG/FAhH5R7oW5L
   IiuYVFGAaTNNkEl0QBQa5WtpqlZTAxVATGe5cigQYh2rt4s83/j8g5kYs
   hMhUIY0e5LjhBnqe2es/VN1TDnPf5ftn3D+sY2PRwkY7LkFN7bBi00kY7
   yC1nNMWyJd7am4J89FKtodt6USrXswsfkqv6jClbw76fjpEowsnbseOV5
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="398181171"
X-IronPort-AV: E=Sophos;i="5.98,238,1673942400"; 
   d="scan'208";a="398181171"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2023 08:31:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="669504531"
X-IronPort-AV: E=Sophos;i="5.98,238,1673942400"; 
   d="scan'208";a="669504531"
Received: from fyu1.sc.intel.com ([172.25.103.126])
  by orsmga007.jf.intel.com with ESMTP; 06 Mar 2023 08:31:58 -0800
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Vinod Koul" <vkoul@kernel.org>,
        "Dave Jiang" <dave.jiang@intel.com>
Cc:     dmaengine@vger.kernel.org,
        "linux-kernel" <linux-kernel@vger.kernel.org>,
        Tony Zhu <tony.zhu@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH v2 09/16] dmaengine: idxd: process user page faults for completion record
Date:   Mon,  6 Mar 2023 08:31:31 -0800
Message-Id: <20230306163138.587484-10-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230306163138.587484-1-fenghua.yu@intel.com>
References: <20230306163138.587484-1-fenghua.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dave Jiang <dave.jiang@intel.com>

DSA supports page fault handling through PRS. However, the DMA engine
that's processing the descriptor is blocked until the PRS response is
received. Other workqueues sharing the engine are also blocked.
Page fault handing by the driver with PRS disabled can be used to
mitigate the stalling.

With PRS disabled while ATS remain enabled, DSA handles page faults on
a completion record by reporting an event in the event log. In this
instance, the descriptor is completed and the event log contains the
completion record address and the contents of the completion record. Add
support to the event log handling code to fault in the completion record
and copy the content of the completion record to user memory.

A bitmap is introduced to keep track of discarded event log entries. When
the user process initiates ->release() of the char device, it no longer is
interested in any remaining event log entries tied to the relevant wq and
PASID. The driver will mark the event log entry index in the bitmap. Upon
encountering the entries during processing, the event log handler will just
clear the bitmap bit and skip the entry rather than attempt to process the
event log entry.

Tested-by: Tony Zhu <tony.zhu@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Co-developed-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
---
v2:
- Call iommu_access_remote_vm() to copy completion record to user.

 drivers/dma/Kconfig       |  1 +
 drivers/dma/idxd/cdev.c   | 34 ++++++++++++++++-
 drivers/dma/idxd/device.c | 22 ++++++++++-
 drivers/dma/idxd/idxd.h   |  2 +
 drivers/dma/idxd/init.c   |  2 +
 drivers/dma/idxd/irq.c    | 79 ++++++++++++++++++++++++++++++++++++---
 include/uapi/linux/idxd.h |  1 +
 7 files changed, 133 insertions(+), 8 deletions(-)

diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index fb7073fc034f..c8a2d255930e 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -297,6 +297,7 @@ config INTEL_IDXD
 	depends on PCI_PASID
 	depends on SBITMAP
 	select DMA_ENGINE
+	select IOMMU_SVA
 	help
 	  Enable support for the Intel(R) data accelerators present
 	  in Intel Xeon CPU.
diff --git a/drivers/dma/idxd/cdev.c b/drivers/dma/idxd/cdev.c
index cbe29e1a6a44..51a5b8ab160e 100644
--- a/drivers/dma/idxd/cdev.c
+++ b/drivers/dma/idxd/cdev.c
@@ -136,6 +136,35 @@ static int idxd_cdev_open(struct inode *inode, struct file *filp)
 	return rc;
 }
 
+static void idxd_cdev_evl_drain_pasid(struct idxd_wq *wq, u32 pasid)
+{
+	struct idxd_device *idxd = wq->idxd;
+	struct idxd_evl *evl = idxd->evl;
+	union evl_status_reg status;
+	u16 h, t, size;
+	int ent_size = evl_ent_size(idxd);
+	struct __evl_entry *entry_head;
+
+	if (!evl)
+		return;
+
+	spin_lock(&evl->lock);
+	status.bits = ioread64(idxd->reg_base + IDXD_EVLSTATUS_OFFSET);
+	t = status.tail;
+	h = evl->head;
+	size = evl->size;
+
+	while (h != t) {
+		entry_head = (struct __evl_entry *)(evl->log + (h * ent_size));
+		if (entry_head->pasid == pasid && entry_head->wq_idx == wq->id)
+			set_bit(h, evl->bmap);
+		h = (h + 1) % size;
+	}
+	spin_unlock(&evl->lock);
+
+	drain_workqueue(wq->wq);
+}
+
 static int idxd_cdev_release(struct inode *node, struct file *filep)
 {
 	struct idxd_user_context *ctx = filep->private_data;
@@ -161,8 +190,11 @@ static int idxd_cdev_release(struct inode *node, struct file *filep)
 		}
 	}
 
-	if (ctx->sva)
+	if (ctx->sva) {
+		idxd_cdev_evl_drain_pasid(wq, ctx->pasid);
 		iommu_sva_unbind_device(ctx->sva);
+	}
+
 	kfree(ctx);
 	mutex_lock(&wq->wq_lock);
 	idxd_wq_put(wq);
diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
index 230fe9bb56ae..fd97b2b58734 100644
--- a/drivers/dma/idxd/device.c
+++ b/drivers/dma/idxd/device.c
@@ -762,18 +762,29 @@ static int idxd_device_evl_setup(struct idxd_device *idxd)
 	dma_addr_t dma_addr;
 	int size;
 	struct idxd_evl *evl = idxd->evl;
+	unsigned long *bmap;
+	int rc;
 
 	if (!evl)
 		return 0;
 
 	size = evl_size(idxd);
+
+	bmap = bitmap_zalloc(size, GFP_KERNEL);
+	if (!bmap) {
+		rc = -ENOMEM;
+		goto err_bmap;
+	}
+
 	/*
 	 * Address needs to be page aligned. However, dma_alloc_coherent() provides
 	 * at minimal page size aligned address. No manual alignment required.
 	 */
 	addr = dma_alloc_coherent(dev, size, &dma_addr, GFP_KERNEL);
-	if (!addr)
-		return -ENOMEM;
+	if (!addr) {
+		rc = -ENOMEM;
+		goto err_alloc;
+	}
 
 	memset(addr, 0, size);
 
@@ -781,6 +792,7 @@ static int idxd_device_evl_setup(struct idxd_device *idxd)
 	evl->log = addr;
 	evl->dma = dma_addr;
 	evl->log_size = size;
+	evl->bmap = bmap;
 
 	memset(&evlcfg, 0, sizeof(evlcfg));
 	evlcfg.bits[0] = dma_addr & GENMASK(63, 12);
@@ -799,6 +811,11 @@ static int idxd_device_evl_setup(struct idxd_device *idxd)
 
 	spin_unlock(&evl->lock);
 	return 0;
+
+err_alloc:
+	bitmap_free(bmap);
+err_bmap:
+	return rc;
 }
 
 static void idxd_device_evl_free(struct idxd_device *idxd)
@@ -824,6 +841,7 @@ static void idxd_device_evl_free(struct idxd_device *idxd)
 	iowrite64(0, idxd->reg_base + IDXD_EVLCFG_OFFSET + 8);
 
 	dma_free_coherent(dev, evl->log_size, evl->log, evl->dma);
+	bitmap_free(evl->bmap);
 	evl->log = NULL;
 	evl->size = IDXD_EVL_SIZE_MIN;
 	spin_unlock(&evl->lock);
diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
index c5d99c179902..48cdfd5ee44f 100644
--- a/drivers/dma/idxd/idxd.h
+++ b/drivers/dma/idxd/idxd.h
@@ -260,6 +260,7 @@ struct idxd_driver_data {
 	struct device_type *dev_type;
 	int compl_size;
 	int align;
+	int evl_cr_off;
 };
 
 struct idxd_evl {
@@ -272,6 +273,7 @@ struct idxd_evl {
 	/* The number of entries in the event log. */
 	u16 size;
 	u16 head;
+	unsigned long *bmap;
 };
 
 struct idxd_evl_fault {
diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index a7c98fac7a85..19324fbc238c 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -47,6 +47,7 @@ static struct idxd_driver_data idxd_driver_data[] = {
 		.compl_size = sizeof(struct dsa_completion_record),
 		.align = 32,
 		.dev_type = &dsa_device_type,
+		.evl_cr_off = offsetof(struct dsa_evl_entry, cr),
 	},
 	[IDXD_TYPE_IAX] = {
 		.name_prefix = "iax",
@@ -54,6 +55,7 @@ static struct idxd_driver_data idxd_driver_data[] = {
 		.compl_size = sizeof(struct iax_completion_record),
 		.align = 64,
 		.dev_type = &iax_device_type,
+		.evl_cr_off = offsetof(struct iax_evl_entry, cr),
 	},
 };
 
diff --git a/drivers/dma/idxd/irq.c b/drivers/dma/idxd/irq.c
index 52b8b7d9db22..24c688f0ca9e 100644
--- a/drivers/dma/idxd/irq.c
+++ b/drivers/dma/idxd/irq.c
@@ -7,6 +7,9 @@
 #include <linux/io-64-nonatomic-lo-hi.h>
 #include <linux/dmaengine.h>
 #include <linux/delay.h>
+#include <linux/ioasid.h>
+#include <linux/iommu.h>
+#include <linux/sched/mm.h>
 #include <uapi/linux/idxd.h>
 #include "../dmaengine.h"
 #include "idxd.h"
@@ -217,14 +220,80 @@ static void idxd_int_handle_revoke(struct work_struct *work)
 	kfree(revoke);
 }
 
-static void process_evl_entry(struct idxd_device *idxd, struct __evl_entry *entry_head)
+static void idxd_evl_fault_work(struct work_struct *work)
+{
+	struct idxd_evl_fault *fault = container_of(work, struct idxd_evl_fault, work);
+	struct idxd_wq *wq = fault->wq;
+	struct idxd_device *idxd = wq->idxd;
+	struct device *dev = &idxd->pdev->dev;
+	struct __evl_entry *entry_head = fault->entry;
+	void *cr = (void *)entry_head + idxd->data->evl_cr_off;
+	int cr_size = idxd->data->compl_size, copied;
+
+	switch (fault->status) {
+	case DSA_COMP_CRA_XLAT:
+	case DSA_COMP_DRAIN_EVL:
+		/*
+		 * Copy completion record to user address space that is found
+		 * by PASID.
+		 */
+		copied = iommu_access_remote_vm(entry_head->pasid,
+						entry_head->fault_addr, cr,
+						cr_size, FOLL_WRITE);
+		if (copied != cr_size) {
+			dev_err(dev, "Failed to write to completion record. (%d:%d)\n",
+				cr_size, copied);
+		}
+		break;
+	default:
+		dev_err(dev, "Unrecognized error code: %#x\n",
+			DSA_COMP_STATUS(entry_head->error));
+		break;
+	}
+
+	kmem_cache_free(idxd->evl_cache, fault);
+}
+
+static void process_evl_entry(struct idxd_device *idxd,
+			      struct __evl_entry *entry_head, unsigned int index)
 {
 	struct device *dev = &idxd->pdev->dev;
+	struct idxd_evl *evl = idxd->evl;
 	u8 status;
 
-	status = DSA_COMP_STATUS(entry_head->error);
-	dev_warn_ratelimited(dev, "Device error %#x operation: %#x fault addr: %#llx\n",
-			     status, entry_head->operation, entry_head->fault_addr);
+	if (test_bit(index, evl->bmap)) {
+		clear_bit(index, evl->bmap);
+	} else {
+		status = DSA_COMP_STATUS(entry_head->error);
+
+		if (status == DSA_COMP_CRA_XLAT || status == DSA_COMP_DRAIN_EVL) {
+			struct idxd_evl_fault *fault;
+			int ent_size = evl_ent_size(idxd);
+
+			if (entry_head->rci)
+				dev_dbg(dev, "Completion Int Req set, ignoring!\n");
+
+			if (!entry_head->rcr && status == DSA_COMP_DRAIN_EVL)
+				return;
+
+			fault = kmem_cache_alloc(idxd->evl_cache, GFP_ATOMIC);
+			if (fault) {
+				struct idxd_wq *wq = idxd->wqs[entry_head->wq_idx];
+
+				fault->wq = wq;
+				fault->status = status;
+				memcpy(&fault->entry, entry_head, ent_size);
+				INIT_WORK(&fault->work, idxd_evl_fault_work);
+				queue_work(wq->wq, &fault->work);
+			} else {
+				dev_warn(dev, "Failed to service fault work.\n");
+			}
+		} else {
+			dev_warn_ratelimited(dev, "Device error %#x operation: %#x fault addr: %#llx\n",
+					     status, entry_head->operation,
+					     entry_head->fault_addr);
+		}
+	}
 }
 
 static void process_evl_entries(struct idxd_device *idxd)
@@ -250,7 +319,7 @@ static void process_evl_entries(struct idxd_device *idxd)
 
 	while (h != t) {
 		entry_head = (struct __evl_entry *)(evl->log + (h * ent_size));
-		process_evl_entry(idxd, entry_head);
+		process_evl_entry(idxd, entry_head, h);
 		h = (h + 1) % size;
 	}
 
diff --git a/include/uapi/linux/idxd.h b/include/uapi/linux/idxd.h
index e86199d09a91..4b584d5afd87 100644
--- a/include/uapi/linux/idxd.h
+++ b/include/uapi/linux/idxd.h
@@ -135,6 +135,7 @@ enum dsa_completion_status {
 	DSA_COMP_HW_ERR1,
 	DSA_COMP_HW_ERR_DRB,
 	DSA_COMP_TRANSLATION_FAIL,
+	DSA_COMP_DRAIN_EVL = 0x26,
 };
 
 enum iax_completion_status {
-- 
2.37.1

