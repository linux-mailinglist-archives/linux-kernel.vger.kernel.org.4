Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0888E62E165
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 17:20:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239679AbiKQQUE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 11:20:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234725AbiKQQUB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 11:20:01 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD12978D7F
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 08:19:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7CE4CB820F9
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 16:19:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29C9BC433D6;
        Thu, 17 Nov 2022 16:19:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668701997;
        bh=gALm3Hj+xZ0hQpaXHl63IdMmEC4JCRNy1Wtv4B5EeLM=;
        h=From:To:Cc:Subject:Date:From;
        b=kALXWhCy21vpoPQaephaJAbUr8h/wNM+n/xlXwVITLI0vziijFplKMFVuxQFp/C87
         MmQVVgn8Luu96mzfZgxSbxJZGT/DxwfV2AO1mLj60bigF4wKYh6SrYZlaEK8Wg/PqO
         2CHxbe4M8sXzFZ4Sc/j2o1z2G6x99gtIyGsX0PqO7BF6NvJJ/FjcDKceHcsCjMAonY
         EwI2m+3sbNKcGjtx6kiW6i94FZuNknn5XVBA6IspbDcNw/q2c49p+VtsiSDx5pYFVB
         1JB7Pwzmk9eDrjBQuRk3HLV7KpNvUJaQtTyZ8gwO0OQ0hggoUNUp0boBK06JRLfSP0
         nQzE/WrEj8t1Q==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ofir Bitton <obitton@habana.ai>
Subject: [PATCH 01/20] habanalabs/gaudi2: add PCI revision 2 support
Date:   Thu, 17 Nov 2022 18:19:32 +0200
Message-Id: <20221117161951.845454-1-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ofir Bitton <obitton@habana.ai>

Add support for Gaudi2 Device with PCI revision 2.
Functionality is exactly the same as revision 1, the only difference
is device name exposed to user.

Signed-off-by: Ofir Bitton <obitton@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/device.c       |  4 +++
 drivers/misc/habanalabs/common/habanalabs.h   |  2 ++
 .../misc/habanalabs/common/habanalabs_drv.c   | 26 +++++++++++++------
 .../misc/habanalabs/common/habanalabs_ioctl.c |  6 +++--
 drivers/misc/habanalabs/common/mmu/mmu.c      |  1 +
 drivers/misc/habanalabs/common/sysfs.c        |  2 ++
 drivers/misc/habanalabs/gaudi2/gaudi2.c       |  6 +----
 drivers/misc/habanalabs/gaudi2/gaudi2P.h      |  2 --
 .../include/hw_ip/pci/pci_general.h           |  7 +++++
 include/uapi/misc/habanalabs.h                |  7 +++++
 10 files changed, 46 insertions(+), 17 deletions(-)

diff --git a/drivers/misc/habanalabs/common/device.c b/drivers/misc/habanalabs/common/device.c
index 3ea1ee1ec8ef..35ed494fcfdf 100644
--- a/drivers/misc/habanalabs/common/device.c
+++ b/drivers/misc/habanalabs/common/device.c
@@ -748,6 +748,10 @@ static int device_early_init(struct hl_device *hdev)
 		gaudi2_set_asic_funcs(hdev);
 		strscpy(hdev->asic_name, "GAUDI2", sizeof(hdev->asic_name));
 		break;
+	case ASIC_GAUDI2B:
+		gaudi2_set_asic_funcs(hdev);
+		strscpy(hdev->asic_name, "GAUDI2B", sizeof(hdev->asic_name));
+		break;
 		break;
 	default:
 		dev_err(hdev->dev, "Unrecognized ASIC type %d\n",
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index 7d191f388953..e391e7951fb7 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -1192,6 +1192,7 @@ struct hl_dec {
  * @ASIC_GAUDI: Gaudi device (HL-2000).
  * @ASIC_GAUDI_SEC: Gaudi secured device (HL-2000).
  * @ASIC_GAUDI2: Gaudi2 device.
+ * @ASIC_GAUDI2B: Gaudi2B device.
  */
 enum hl_asic_type {
 	ASIC_INVALID,
@@ -1199,6 +1200,7 @@ enum hl_asic_type {
 	ASIC_GAUDI,
 	ASIC_GAUDI_SEC,
 	ASIC_GAUDI2,
+	ASIC_GAUDI2B,
 };
 
 struct hl_cs_parser;
diff --git a/drivers/misc/habanalabs/common/habanalabs_drv.c b/drivers/misc/habanalabs/common/habanalabs_drv.c
index e82af8989700..7815c60df54e 100644
--- a/drivers/misc/habanalabs/common/habanalabs_drv.c
+++ b/drivers/misc/habanalabs/common/habanalabs_drv.c
@@ -9,6 +9,7 @@
 #define pr_fmt(fmt)		"habanalabs: " fmt
 
 #include "habanalabs.h"
+#include "../include/hw_ip/pci/pci_general.h"
 
 #include <linux/pci.h>
 #include <linux/aer.h>
@@ -74,16 +75,17 @@ MODULE_DEVICE_TABLE(pci, ids);
 /*
  * get_asic_type - translate device id to asic type
  *
- * @device: id of the PCI device
+ * @hdev: pointer to habanalabs device structure.
  *
- * Translate device id to asic type.
+ * Translate device id and revision id to asic type.
  * In case of unidentified device, return -1
  */
-static enum hl_asic_type get_asic_type(u16 device)
+static enum hl_asic_type get_asic_type(struct hl_device *hdev)
 {
-	enum hl_asic_type asic_type;
+	struct pci_dev *pdev = hdev->pdev;
+	enum hl_asic_type asic_type = ASIC_INVALID;
 
-	switch (device) {
+	switch (pdev->device) {
 	case PCI_IDS_GOYA:
 		asic_type = ASIC_GOYA;
 		break;
@@ -94,10 +96,18 @@ static enum hl_asic_type get_asic_type(u16 device)
 		asic_type = ASIC_GAUDI_SEC;
 		break;
 	case PCI_IDS_GAUDI2:
-		asic_type = ASIC_GAUDI2;
+		switch (pdev->revision) {
+		case REV_ID_A:
+			asic_type = ASIC_GAUDI2;
+			break;
+		case REV_ID_B:
+			asic_type = ASIC_GAUDI2B;
+			break;
+		default:
+			break;
+		}
 		break;
 	default:
-		asic_type = ASIC_INVALID;
 		break;
 	}
 
@@ -416,7 +426,7 @@ static int create_hdev(struct hl_device **dev, struct pci_dev *pdev)
 	/* First, we must find out which ASIC are we handling. This is needed
 	 * to configure the behavior of the driver (kernel parameters)
 	 */
-	hdev->asic_type = get_asic_type(pdev->device);
+	hdev->asic_type = get_asic_type(hdev);
 	if (hdev->asic_type == ASIC_INVALID) {
 		dev_err(&pdev->dev, "Unsupported ASIC\n");
 		rc = -ENODEV;
diff --git a/drivers/misc/habanalabs/common/habanalabs_ioctl.c b/drivers/misc/habanalabs/common/habanalabs_ioctl.c
index 5ce5c42e2731..ee43017eb563 100644
--- a/drivers/misc/habanalabs/common/habanalabs_ioctl.c
+++ b/drivers/misc/habanalabs/common/habanalabs_ioctl.c
@@ -10,10 +10,11 @@
 #include <uapi/misc/habanalabs.h>
 #include "habanalabs.h"
 
-#include <linux/kernel.h>
 #include <linux/fs.h>
-#include <linux/uaccess.h>
+#include <linux/kernel.h>
+#include <linux/pci.h>
 #include <linux/slab.h>
+#include <linux/uaccess.h>
 #include <linux/vmalloc.h>
 
 static u32 hl_debug_struct_size[HL_DEBUG_OP_TIMESTAMP + 1] = {
@@ -105,6 +106,7 @@ static int hw_ip_info(struct hl_device *hdev, struct hl_info_args *args)
 	hw_ip.edma_enabled_mask = prop->edma_enabled_mask;
 	hw_ip.server_type = prop->server_type;
 	hw_ip.security_enabled = prop->fw_security_enabled;
+	hw_ip.revision_id = hdev->pdev->revision;
 
 	return copy_to_user(out, &hw_ip,
 		min((size_t) size, sizeof(hw_ip))) ? -EFAULT : 0;
diff --git a/drivers/misc/habanalabs/common/mmu/mmu.c b/drivers/misc/habanalabs/common/mmu/mmu.c
index 67d3e70cf571..2c1005f74cf4 100644
--- a/drivers/misc/habanalabs/common/mmu/mmu.c
+++ b/drivers/misc/habanalabs/common/mmu/mmu.c
@@ -635,6 +635,7 @@ int hl_mmu_if_set_funcs(struct hl_device *hdev)
 		hl_mmu_v1_set_funcs(hdev, &hdev->mmu_func[MMU_DR_PGT]);
 		break;
 	case ASIC_GAUDI2:
+	case ASIC_GAUDI2B:
 		/* MMUs in Gaudi2 are always host resident */
 		hl_mmu_v2_hr_set_funcs(hdev, &hdev->mmu_func[MMU_HR_PGT]);
 		break;
diff --git a/drivers/misc/habanalabs/common/sysfs.c b/drivers/misc/habanalabs/common/sysfs.c
index c924fc994bd9..735d8bed0066 100644
--- a/drivers/misc/habanalabs/common/sysfs.c
+++ b/drivers/misc/habanalabs/common/sysfs.c
@@ -248,6 +248,8 @@ static ssize_t device_type_show(struct device *dev,
 	case ASIC_GAUDI2:
 		str = "GAUDI2";
 		break;
+	case ASIC_GAUDI2B:
+		str = "GAUDI2B";
 		break;
 	default:
 		dev_err(hdev->dev, "Unrecognized ASIC type %d\n",
diff --git a/drivers/misc/habanalabs/gaudi2/gaudi2.c b/drivers/misc/habanalabs/gaudi2/gaudi2.c
index 03f8cf9bb136..f21b68be6d20 100644
--- a/drivers/misc/habanalabs/gaudi2/gaudi2.c
+++ b/drivers/misc/habanalabs/gaudi2/gaudi2.c
@@ -3968,11 +3968,7 @@ static void gaudi2_init_firmware_loader(struct hl_device *hdev)
 	fw_loader->skip_bmc = false;
 	fw_loader->sram_bar_id = SRAM_CFG_BAR_ID;
 	fw_loader->dram_bar_id = DRAM_BAR_ID;
-
-	if (hdev->asic_type == ASIC_GAUDI2)
-		fw_loader->cpu_timeout = GAUDI2_CPU_TIMEOUT_USEC;
-	else /* ASIC_GAUDI2_FPGA */
-		fw_loader->cpu_timeout = GAUDI2_FPGA_CPU_TIMEOUT;
+	fw_loader->cpu_timeout = GAUDI2_CPU_TIMEOUT_USEC;
 
 	/* here we update initial values for few specific dynamic regs (as
 	 * before reading the first descriptor from FW those value has to be
diff --git a/drivers/misc/habanalabs/gaudi2/gaudi2P.h b/drivers/misc/habanalabs/gaudi2/gaudi2P.h
index a99c348bbf39..b4383c199bbb 100644
--- a/drivers/misc/habanalabs/gaudi2/gaudi2P.h
+++ b/drivers/misc/habanalabs/gaudi2/gaudi2P.h
@@ -23,8 +23,6 @@
 
 #define GAUDI2_CPU_TIMEOUT_USEC		30000000	/* 30s */
 
-#define GAUDI2_FPGA_CPU_TIMEOUT		100000000	/* 100s */
-
 #define NUMBER_OF_PDMA_QUEUES		2
 #define NUMBER_OF_EDMA_QUEUES		8
 #define NUMBER_OF_MME_QUEUES		4
diff --git a/drivers/misc/habanalabs/include/hw_ip/pci/pci_general.h b/drivers/misc/habanalabs/include/hw_ip/pci/pci_general.h
index d232081d4e0f..f5d497dc9bdc 100644
--- a/drivers/misc/habanalabs/include/hw_ip/pci/pci_general.h
+++ b/drivers/misc/habanalabs/include/hw_ip/pci/pci_general.h
@@ -20,4 +20,11 @@
 #define PCI_CONFIG_ELBI_STS_MASK	(PCI_CONFIG_ELBI_STS_ERR | \
 					PCI_CONFIG_ELBI_STS_DONE)
 
+enum hl_revision_id {
+	/* PCI revision ID 0 is not legal */
+	REV_ID_INVALID				= 0x00,
+	REV_ID_A				= 0x01,
+	REV_ID_B				= 0x02,
+};
+
 #endif /* INCLUDE_PCI_GENERAL_H_ */
diff --git a/include/uapi/misc/habanalabs.h b/include/uapi/misc/habanalabs.h
index a4ceee681898..58343998bd63 100644
--- a/include/uapi/misc/habanalabs.h
+++ b/include/uapi/misc/habanalabs.h
@@ -868,6 +868,7 @@ enum hl_server_type {
  * @number_of_user_interrupts: The number of interrupts that are available to the userspace
  *                             application to use. Relevant for Gaudi2 and later.
  * @device_mem_alloc_default_page_size: default page size used in device memory allocation.
+ * @revision_id: PCI revision ID of the ASIC.
  */
 struct hl_info_hw_ip_info {
 	__u64 sram_base_address;
@@ -898,6 +899,12 @@ struct hl_info_hw_ip_info {
 	__u16 pad2;
 	__u64 reserved4;
 	__u64 device_mem_alloc_default_page_size;
+	__u64 reserved5;
+	__u64 reserved6;
+	__u32 reserved7;
+	__u8 reserved8;
+	__u8 revision_id;
+	__u8 pad[2];
 };
 
 struct hl_info_dram_usage {
-- 
2.25.1

