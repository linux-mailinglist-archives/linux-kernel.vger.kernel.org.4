Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C9846DB543
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 22:32:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231343AbjDGUbj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 16:31:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230194AbjDGUb3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 16:31:29 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 005C47A83;
        Fri,  7 Apr 2023 13:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680899488; x=1712435488;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FSCaayDId8H93j6VR235Gf8Zmkc6Oy5V7pdFVmhZINE=;
  b=bbLSUdFUUU4yCcZdP/WIJrncT9QENUGA9DoHgcsVoNxP5PRrzAxGu0jU
   4jjrHvm823yyzXo8rmOVo56gwGd1CMqG9PaH3A66xd6vEEWQ/4v4uNVfN
   ziMUb4ofWTa6QdLfMVj3boCmzaW9Src0OscSMRJmneuS3DLB4McHNJqUr
   9bLJRoqrzeVtXKe/WFX/gT/TPCvFFLUgGPr5t6WhlyLCO6LtatUZpUatT
   udnJ30V4BnD5vQPw1iXgTj6ae4sOMj4T46M8PQk+HoBBD0k4A0cyg4X0R
   IgwSfGCWpqkwhoTCpBskuTrTLkdWFqDfNyIAr10R8xo9MdGx10a1RjEgE
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10673"; a="408196854"
X-IronPort-AV: E=Sophos;i="5.98,327,1673942400"; 
   d="scan'208";a="408196854"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2023 13:31:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10673"; a="681125870"
X-IronPort-AV: E=Sophos;i="5.98,327,1673942400"; 
   d="scan'208";a="681125870"
Received: from fyu1.sc.intel.com ([172.25.103.126])
  by orsmga007.jf.intel.com with ESMTP; 07 Apr 2023 13:31:26 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Vinod Koul" <vkoul@kernel.org>,
        "Dave Jiang" <dave.jiang@intel.com>
Cc:     dmaengine@vger.kernel.org,
        "linux-kernel" <linux-kernel@vger.kernel.org>,
        Tony Zhu <tony.zhu@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH v4 03/16] dmaengine: idxd: setup event log configuration
Date:   Fri,  7 Apr 2023 13:31:30 -0700
Message-Id: <20230407203143.2189681-4-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230407203143.2189681-1-fenghua.yu@intel.com>
References: <20230407203143.2189681-1-fenghua.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dave Jiang <dave.jiang@intel.com>

Add setup of event log feature for supported device. Event log addresses
error reporting that was lacking in gen 1 DSA devices where a second error
event does not get reported when a first event is pending software
handling. The event log allows a circular buffer that the device can push
error events to. It is up to the user to create a large enough event log
ring in order to capture the expected events. The evl size can be set in
the device sysfs attribute. By default 64 entries are supported as minimal
when event log is enabled.

Tested-by: Tony Zhu <tony.zhu@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Co-developed-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
---
 drivers/dma/idxd/device.c    | 89 +++++++++++++++++++++++++++++++++++-
 drivers/dma/idxd/idxd.h      | 19 ++++++++
 drivers/dma/idxd/init.c      |  1 +
 drivers/dma/idxd/registers.h | 72 ++++++++++++++++++++++++++++-
 drivers/dma/idxd/sysfs.c     |  3 +-
 include/uapi/linux/idxd.h    |  1 +
 6 files changed, 181 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
index 5f321f3b4242..230fe9bb56ae 100644
--- a/drivers/dma/idxd/device.c
+++ b/drivers/dma/idxd/device.c
@@ -752,6 +752,83 @@ void idxd_device_clear_state(struct idxd_device *idxd)
 	spin_unlock(&idxd->dev_lock);
 }
 
+static int idxd_device_evl_setup(struct idxd_device *idxd)
+{
+	union gencfg_reg gencfg;
+	union evlcfg_reg evlcfg;
+	union genctrl_reg genctrl;
+	struct device *dev = &idxd->pdev->dev;
+	void *addr;
+	dma_addr_t dma_addr;
+	int size;
+	struct idxd_evl *evl = idxd->evl;
+
+	if (!evl)
+		return 0;
+
+	size = evl_size(idxd);
+	/*
+	 * Address needs to be page aligned. However, dma_alloc_coherent() provides
+	 * at minimal page size aligned address. No manual alignment required.
+	 */
+	addr = dma_alloc_coherent(dev, size, &dma_addr, GFP_KERNEL);
+	if (!addr)
+		return -ENOMEM;
+
+	memset(addr, 0, size);
+
+	spin_lock(&evl->lock);
+	evl->log = addr;
+	evl->dma = dma_addr;
+	evl->log_size = size;
+
+	memset(&evlcfg, 0, sizeof(evlcfg));
+	evlcfg.bits[0] = dma_addr & GENMASK(63, 12);
+	evlcfg.size = evl->size;
+
+	iowrite64(evlcfg.bits[0], idxd->reg_base + IDXD_EVLCFG_OFFSET);
+	iowrite64(evlcfg.bits[1], idxd->reg_base + IDXD_EVLCFG_OFFSET + 8);
+
+	genctrl.bits = ioread32(idxd->reg_base + IDXD_GENCTRL_OFFSET);
+	genctrl.evl_int_en = 1;
+	iowrite32(genctrl.bits, idxd->reg_base + IDXD_GENCTRL_OFFSET);
+
+	gencfg.bits = ioread32(idxd->reg_base + IDXD_GENCFG_OFFSET);
+	gencfg.evl_en = 1;
+	iowrite32(gencfg.bits, idxd->reg_base + IDXD_GENCFG_OFFSET);
+
+	spin_unlock(&evl->lock);
+	return 0;
+}
+
+static void idxd_device_evl_free(struct idxd_device *idxd)
+{
+	union gencfg_reg gencfg;
+	union genctrl_reg genctrl;
+	struct device *dev = &idxd->pdev->dev;
+	struct idxd_evl *evl = idxd->evl;
+
+	gencfg.bits = ioread32(idxd->reg_base + IDXD_GENCFG_OFFSET);
+	if (!gencfg.evl_en)
+		return;
+
+	spin_lock(&evl->lock);
+	gencfg.evl_en = 0;
+	iowrite32(gencfg.bits, idxd->reg_base + IDXD_GENCFG_OFFSET);
+
+	genctrl.bits = ioread32(idxd->reg_base + IDXD_GENCTRL_OFFSET);
+	genctrl.evl_int_en = 0;
+	iowrite32(genctrl.bits, idxd->reg_base + IDXD_GENCTRL_OFFSET);
+
+	iowrite64(0, idxd->reg_base + IDXD_EVLCFG_OFFSET);
+	iowrite64(0, idxd->reg_base + IDXD_EVLCFG_OFFSET + 8);
+
+	dma_free_coherent(dev, evl->log_size, evl->log, evl->dma);
+	evl->log = NULL;
+	evl->size = IDXD_EVL_SIZE_MIN;
+	spin_unlock(&evl->lock);
+}
+
 static void idxd_group_config_write(struct idxd_group *group)
 {
 	struct idxd_device *idxd = group->idxd;
@@ -1451,15 +1528,24 @@ int idxd_device_drv_probe(struct idxd_dev *idxd_dev)
 	if (rc < 0)
 		return -ENXIO;
 
+	rc = idxd_device_evl_setup(idxd);
+	if (rc < 0) {
+		idxd->cmd_status = IDXD_SCMD_DEV_EVL_ERR;
+		return rc;
+	}
+
 	/* Start device */
 	rc = idxd_device_enable(idxd);
-	if (rc < 0)
+	if (rc < 0) {
+		idxd_device_evl_free(idxd);
 		return rc;
+	}
 
 	/* Setup DMA device without channels */
 	rc = idxd_register_dma_device(idxd);
 	if (rc < 0) {
 		idxd_device_disable(idxd);
+		idxd_device_evl_free(idxd);
 		idxd->cmd_status = IDXD_SCMD_DEV_DMA_ERR;
 		return rc;
 	}
@@ -1488,6 +1574,7 @@ void idxd_device_drv_remove(struct idxd_dev *idxd_dev)
 	idxd_device_disable(idxd);
 	if (test_bit(IDXD_FLAG_CONFIGURABLE, &idxd->flags))
 		idxd_device_reset(idxd);
+	idxd_device_evl_free(idxd);
 }
 
 static enum idxd_dev_type dev_types[] = {
diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
index 2a71273f1822..c74681f02b18 100644
--- a/drivers/dma/idxd/idxd.h
+++ b/drivers/dma/idxd/idxd.h
@@ -262,7 +262,15 @@ struct idxd_driver_data {
 };
 
 struct idxd_evl {
+	/* Lock to protect event log access. */
+	spinlock_t lock;
+	void *log;
+	dma_addr_t dma;
+	/* Total size of event log = number of entries * entry size. */
+	unsigned int log_size;
+	/* The number of entries in the event log. */
 	u16 size;
+	u16 head;
 };
 
 struct idxd_device {
@@ -324,6 +332,17 @@ struct idxd_device {
 	struct idxd_evl *evl;
 };
 
+static inline unsigned int evl_ent_size(struct idxd_device *idxd)
+{
+	return idxd->hw.gen_cap.evl_support ?
+	       (32 * (1 << idxd->hw.gen_cap.evl_support)) : 0;
+}
+
+static inline unsigned int evl_size(struct idxd_device *idxd)
+{
+	return idxd->evl->size * evl_ent_size(idxd);
+}
+
 /* IDXD software descriptor */
 struct idxd_desc {
 	union {
diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index d1fb01c115d8..2ffeb2f3a2c8 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -344,6 +344,7 @@ static int idxd_init_evl(struct idxd_device *idxd)
 	if (!evl)
 		return -ENOMEM;
 
+	spin_lock_init(&evl->lock);
 	evl->size = IDXD_EVL_SIZE_MIN;
 	idxd->evl = evl;
 	return 0;
diff --git a/drivers/dma/idxd/registers.h b/drivers/dma/idxd/registers.h
index ea3a499a3c3c..11bb97cf7481 100644
--- a/drivers/dma/idxd/registers.h
+++ b/drivers/dma/idxd/registers.h
@@ -3,6 +3,8 @@
 #ifndef _IDXD_REGISTERS_H_
 #define _IDXD_REGISTERS_H_
 
+#include <uapi/linux/idxd.h>
+
 /* PCI Config */
 #define PCI_DEVICE_ID_INTEL_DSA_SPR0	0x0b25
 #define PCI_DEVICE_ID_INTEL_IAX_SPR0	0x0cfe
@@ -119,7 +121,8 @@ union gencfg_reg {
 		u32 rdbuf_limit:8;
 		u32 rsvd:4;
 		u32 user_int_en:1;
-		u32 rsvd2:19;
+		u32 evl_en:1;
+		u32 rsvd2:18;
 	};
 	u32 bits;
 } __packed;
@@ -129,7 +132,8 @@ union genctrl_reg {
 	struct {
 		u32 softerr_int_en:1;
 		u32 halt_int_en:1;
-		u32 rsvd:30;
+		u32 evl_int_en:1;
+		u32 rsvd:29;
 	};
 	u32 bits;
 } __packed;
@@ -299,6 +303,21 @@ union iaa_cap_reg {
 
 #define IDXD_IAACAP_OFFSET	0x180
 
+#define IDXD_EVLCFG_OFFSET	0xe0
+union evlcfg_reg {
+	struct {
+		u64 pasid_en:1;
+		u64 priv:1;
+		u64 rsvd:10;
+		u64 base_addr:52;
+
+		u64 size:16;
+		u64 pasid:20;
+		u64 rsvd2:28;
+	};
+	u64 bits[2];
+} __packed;
+
 #define IDXD_EVL_SIZE_MIN	0x0040
 #define IDXD_EVL_SIZE_MAX	0xffff
 
@@ -539,4 +558,53 @@ union filter_cfg {
 	u64 val;
 } __packed;
 
+struct __evl_entry {
+	u64 rsvd:2;
+	u64 desc_valid:1;
+	u64 wq_idx_valid:1;
+	u64 batch:1;
+	u64 fault_rw:1;
+	u64 priv:1;
+	u64 err_info_valid:1;
+	u64 error:8;
+	u64 wq_idx:8;
+	u64 batch_id:8;
+	u64 operation:8;
+	u64 pasid:20;
+	u64 rsvd2:4;
+
+	u16 batch_idx;
+	u16 rsvd3;
+	union {
+		/* Invalid Flags 0x11 */
+		u32 invalid_flags;
+		/* Invalid Int Handle 0x19 */
+		/* Page fault 0x1a */
+		/* Page fault 0x06, 0x1f, only operand_id */
+		/* Page fault before drain or in batch, 0x26, 0x27 */
+		struct {
+			u16 int_handle;
+			u16 rci:1;
+			u16 ims:1;
+			u16 rcr:1;
+			u16 first_err_in_batch:1;
+			u16 rsvd4_2:9;
+			u16 operand_id:3;
+		};
+	};
+	u64 fault_addr;
+	u64 rsvd5;
+} __packed;
+
+struct dsa_evl_entry {
+	struct __evl_entry e;
+	struct dsa_completion_record cr;
+} __packed;
+
+struct iax_evl_entry {
+	struct __evl_entry e;
+	u64 rsvd[4];
+	struct iax_completion_record cr;
+} __packed;
+
 #endif
diff --git a/drivers/dma/idxd/sysfs.c b/drivers/dma/idxd/sysfs.c
index 85644e5bde83..163fdfaa5022 100644
--- a/drivers/dma/idxd/sysfs.c
+++ b/drivers/dma/idxd/sysfs.c
@@ -1605,7 +1605,8 @@ static ssize_t event_log_size_store(struct device *dev,
 	if (!test_bit(IDXD_FLAG_CONFIGURABLE, &idxd->flags))
 		return -EPERM;
 
-	if (val < IDXD_EVL_SIZE_MIN || val > IDXD_EVL_SIZE_MAX)
+	if (val < IDXD_EVL_SIZE_MIN || val > IDXD_EVL_SIZE_MAX ||
+	    (val * evl_ent_size(idxd) > ULONG_MAX - idxd->evl->dma))
 		return -EINVAL;
 
 	idxd->evl->size = val;
diff --git a/include/uapi/linux/idxd.h b/include/uapi/linux/idxd.h
index 1d553bedbdb5..96b552614ee7 100644
--- a/include/uapi/linux/idxd.h
+++ b/include/uapi/linux/idxd.h
@@ -30,6 +30,7 @@ enum idxd_scmd_stat {
 	IDXD_SCMD_WQ_NO_PRIV = 0x800f0000,
 	IDXD_SCMD_WQ_IRQ_ERR = 0x80100000,
 	IDXD_SCMD_WQ_USER_NO_IOMMU = 0x80110000,
+	IDXD_SCMD_DEV_EVL_ERR = 0x80120000,
 };
 
 #define IDXD_SCMD_SOFTERR_MASK	0x80000000
-- 
2.37.1

