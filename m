Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB46B5EA9D0
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 17:11:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235816AbiIZPLg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 11:11:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235798AbiIZPK6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 11:10:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37A4BEA5B0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 06:46:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C97D4B80171
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 13:46:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 701D2C433C1;
        Mon, 26 Sep 2022 13:46:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664199980;
        bh=tioJWFYkysGC8WIumPriS20WDTm/jOCQy81oCCbLu4M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mg2mt6MX4tNhi8sme+qIlr1DKI6mi8WgUhFkcgdSp7ffPDrc9MIQeUuey5TbfoQaT
         P78bUCcYGjy6jC0UltmvQYkTqfjnRoexEwr5YgoivHLkfFuAdKpZhsn7BVu9Sevik2
         CapT2i9Z7RAaJtJsaCdNxtO7jf2PZh/UFDCIUaz0OHhTdZzlfttiasaAlYOWs/rn+b
         eEUHI57dTiMo1cBzH6Mq7wpvspt8SEdPeIkA6RihbWlF5sGYdppB5sQRUjKmiY7v5u
         0FECip8fOlqU43HkPGuPfznpMuqdIXDyohzsYJxCWEN4K2GRtVqoXyiq9hGxsNNZWk
         7Y55lHkHmn7Cw==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Dani Liberman <dliberman@habana.ai>
Subject: [PATCH 2/2] habanalabs: refactor razwi event notification
Date:   Mon, 26 Sep 2022 16:46:14 +0300
Message-Id: <20220926134614.592875-2-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220926134614.592875-1-ogabbay@kernel.org>
References: <20220926134614.592875-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dani Liberman <dliberman@habana.ai>

This event notification was compatible only with gaudi, where razwi
and page fault happens together.

To make it compatible with all ASICs, this refactor contains:

1. Razwi notification will only notify about razwi info.
   New notification will be added in future patch, to retrieve data
   about page fault error.

2. Changed razwi info structure to support all ASICs.

Signed-off-by: Dani Liberman <dliberman@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/device.c       | 22 +++++++
 drivers/misc/habanalabs/common/habanalabs.h   | 31 ++-------
 .../misc/habanalabs/common/habanalabs_drv.c   |  2 +-
 .../misc/habanalabs/common/habanalabs_ioctl.c | 12 +---
 drivers/misc/habanalabs/gaudi/gaudi.c         | 64 +++++++++----------
 include/uapi/misc/habanalabs.h                | 45 ++++++++-----
 6 files changed, 90 insertions(+), 86 deletions(-)

diff --git a/drivers/misc/habanalabs/common/device.c b/drivers/misc/habanalabs/common/device.c
index 1aaaa2004e34..30ddaaae67e5 100644
--- a/drivers/misc/habanalabs/common/device.c
+++ b/drivers/misc/habanalabs/common/device.c
@@ -2253,3 +2253,25 @@ inline void hl_wreg(struct hl_device *hdev, u32 reg, u32 val)
 {
 	writel(val, hdev->rmmio + reg);
 }
+
+void hl_capture_razwi(struct hl_device *hdev, u64 addr, u16 *engine_id, u16 num_of_engines,
+			u8 flags)
+{
+	if (num_of_engines > HL_RAZWI_MAX_NUM_OF_ENGINES_PER_RTR) {
+		dev_err(hdev->dev,
+				"Number of possible razwi initiators (%u) exceeded limit (%u)\n",
+				num_of_engines, HL_RAZWI_MAX_NUM_OF_ENGINES_PER_RTR);
+		return;
+	}
+
+	/* In case it's the first razwi since the device was opened, capture its parameters */
+	if (atomic_cmpxchg(&hdev->captured_err_info.razwi_info_recorded, 0, 1))
+		return;
+
+	hdev->captured_err_info.razwi.timestamp = ktime_to_ns(ktime_get());
+	hdev->captured_err_info.razwi.addr = addr;
+	hdev->captured_err_info.razwi.num_of_possible_engines = num_of_engines;
+	memcpy(&hdev->captured_err_info.razwi.engine_id[0], &engine_id[0],
+			num_of_engines * sizeof(u16));
+	hdev->captured_err_info.razwi.flags = flags;
+}
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index 2ffb8378f565..cdc50c2c4de8 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -2925,30 +2925,6 @@ struct cs_timeout_info {
 	u64		seq;
 };
 
-/**
- * struct razwi_info - info about last razwi error occurred.
- * @timestamp: razwi timestamp.
- * @write_enable: if set writing to razwi parameters in the structure is enabled.
- *                otherwise - disabled, so the first (root cause) razwi will not be overwritten.
- * @addr: address that caused razwi.
- * @engine_id_1: engine id of the razwi initiator, if it was initiated by engine that does
- *               not have engine id it will be set to U16_MAX.
- * @engine_id_2: second engine id of razwi initiator. Might happen that razwi have 2 possible
- *               engines which one them caused the razwi. In that case, it will contain the
- *               second possible engine id, otherwise it will be set to U16_MAX.
- * @non_engine_initiator: in case the initiator of the razwi does not have engine id.
- * @type: cause of razwi, page fault or access error, otherwise it will be set to U8_MAX.
- */
-struct razwi_info {
-	ktime_t		timestamp;
-	atomic_t	write_enable;
-	u64		addr;
-	u16		engine_id_1;
-	u16		engine_id_2;
-	u8		non_engine_initiator;
-	u8		type;
-};
-
 #define MAX_QMAN_STREAMS_INFO		4
 #define OPCODE_INFO_MAX_ADDR_SIZE	8
 /**
@@ -2985,11 +2961,14 @@ struct undefined_opcode_info {
  * struct hl_error_info - holds information collected during an error.
  * @cs_timeout: CS timeout error information.
  * @razwi: razwi information.
+ * @razwi_info_recorded: if set writing to razwi information is enabled.
+ *                otherwise - disabled, so the first (root cause) razwi will not be overwritten.
  * @undef_opcode: undefined opcode information
  */
 struct hl_error_info {
 	struct cs_timeout_info		cs_timeout;
-	struct razwi_info		razwi;
+	struct hl_info_razwi_event	razwi;
+	atomic_t			razwi_info_recorded;
 	struct undefined_opcode_info	undef_opcode;
 };
 
@@ -3800,6 +3779,8 @@ hl_mmap_mem_buf_alloc(struct hl_mem_mgr *mmg,
 		      struct hl_mmap_mem_buf_behavior *behavior, gfp_t gfp,
 		      void *args);
 __printf(2, 3) void hl_engine_data_sprintf(struct engines_data *e, const char *fmt, ...);
+void hl_capture_razwi(struct hl_device *hdev, u64 addr, u16 *engine_id, u16 num_of_engines,
+			u8 flags);
 
 #ifdef CONFIG_DEBUG_FS
 
diff --git a/drivers/misc/habanalabs/common/habanalabs_drv.c b/drivers/misc/habanalabs/common/habanalabs_drv.c
index 3ee44ea58d5c..d87434b9bc16 100644
--- a/drivers/misc/habanalabs/common/habanalabs_drv.c
+++ b/drivers/misc/habanalabs/common/habanalabs_drv.c
@@ -212,7 +212,7 @@ int hl_device_open(struct inode *inode, struct file *filp)
 	hl_debugfs_add_file(hpriv);
 
 	atomic_set(&hdev->captured_err_info.cs_timeout.write_enable, 1);
-	atomic_set(&hdev->captured_err_info.razwi.write_enable, 1);
+	atomic_set(&hdev->captured_err_info.razwi_info_recorded, 0);
 	hdev->captured_err_info.undef_opcode.write_enable = true;
 
 	hdev->open_counter++;
diff --git a/drivers/misc/habanalabs/common/habanalabs_ioctl.c b/drivers/misc/habanalabs/common/habanalabs_ioctl.c
index 43afe40966e5..6aef4e24d122 100644
--- a/drivers/misc/habanalabs/common/habanalabs_ioctl.c
+++ b/drivers/misc/habanalabs/common/habanalabs_ioctl.c
@@ -603,20 +603,14 @@ static int razwi_info(struct hl_fpriv *hpriv, struct hl_info_args *args)
 {
 	struct hl_device *hdev = hpriv->hdev;
 	u32 max_size = args->return_size;
-	struct hl_info_razwi_event info = {0};
+	struct hl_info_razwi_event *info = &hdev->captured_err_info.razwi;
 	void __user *out = (void __user *) (uintptr_t) args->return_pointer;
 
 	if ((!max_size) || (!out))
 		return -EINVAL;
 
-	info.timestamp = ktime_to_ns(hdev->captured_err_info.razwi.timestamp);
-	info.addr = hdev->captured_err_info.razwi.addr;
-	info.engine_id_1 = hdev->captured_err_info.razwi.engine_id_1;
-	info.engine_id_2 = hdev->captured_err_info.razwi.engine_id_2;
-	info.no_engine_id = hdev->captured_err_info.razwi.non_engine_initiator;
-	info.error_type = hdev->captured_err_info.razwi.type;
-
-	return copy_to_user(out, &info, min_t(size_t, max_size, sizeof(info))) ? -EFAULT : 0;
+	return copy_to_user(out, info, min_t(size_t, max_size, sizeof(struct hl_info_razwi_event)))
+				? -EFAULT : 0;
 }
 
 static int undefined_opcode_info(struct hl_fpriv *hpriv, struct hl_info_args *args)
diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 92560414e843..f856ac51fde1 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -6505,8 +6505,8 @@ static void gaudi_get_event_desc(u16 event_type, char *desc, size_t size)
 }
 
 static const char *gaudi_get_razwi_initiator_dma_name(struct hl_device *hdev, u32 x_y,
-							bool is_write, s32 *engine_id_1,
-							s32 *engine_id_2)
+							bool is_write, u16 *engine_id_1,
+							u16 *engine_id_2)
 {
 	u32 dma_id[2], dma_offset, err_cause[2], mask, i;
 
@@ -6603,7 +6603,7 @@ static const char *gaudi_get_razwi_initiator_dma_name(struct hl_device *hdev, u3
 }
 
 static const char *gaudi_get_razwi_initiator_name(struct hl_device *hdev, bool is_write,
-							u32 *engine_id_1, u32 *engine_id_2)
+							u16 *engine_id_1, u16 *engine_id_2)
 {
 	u32 val, x_y, axi_id;
 
@@ -6719,8 +6719,8 @@ static const char *gaudi_get_razwi_initiator_name(struct hl_device *hdev, bool i
 	return "unknown initiator";
 }
 
-static void gaudi_print_and_get_razwi_info(struct hl_device *hdev, u32 *engine_id_1,
-						u32 *engine_id_2)
+static void gaudi_print_and_get_razwi_info(struct hl_device *hdev, u16 *engine_id_1,
+						u16 *engine_id_2, bool *is_read, bool *is_write)
 {
 
 	if (RREG32(mmMMU_UP_RAZWI_WRITE_VLD)) {
@@ -6728,6 +6728,7 @@ static void gaudi_print_and_get_razwi_info(struct hl_device *hdev, u32 *engine_i
 			"RAZWI event caused by illegal write of %s\n",
 			gaudi_get_razwi_initiator_name(hdev, true, engine_id_1, engine_id_2));
 		WREG32(mmMMU_UP_RAZWI_WRITE_VLD, 0);
+		*is_write = true;
 	}
 
 	if (RREG32(mmMMU_UP_RAZWI_READ_VLD)) {
@@ -6735,10 +6736,11 @@ static void gaudi_print_and_get_razwi_info(struct hl_device *hdev, u32 *engine_i
 			"RAZWI event caused by illegal read of %s\n",
 			gaudi_get_razwi_initiator_name(hdev, false, engine_id_1, engine_id_2));
 		WREG32(mmMMU_UP_RAZWI_READ_VLD, 0);
+		*is_read = true;
 	}
 }
 
-static void gaudi_print_and_get_mmu_error_info(struct hl_device *hdev, u64 *addr, u8 *type)
+static void gaudi_print_and_get_mmu_error_info(struct hl_device *hdev, u64 *addr)
 {
 	struct gaudi_device *gaudi = hdev->asic_specific;
 	u32 val;
@@ -6753,8 +6755,6 @@ static void gaudi_print_and_get_mmu_error_info(struct hl_device *hdev, u64 *addr
 		*addr |= RREG32(mmMMU_UP_PAGE_ERROR_CAPTURE_VA);
 
 		dev_err_ratelimited(hdev->dev, "MMU page fault on va 0x%llx\n", *addr);
-		*type = HL_RAZWI_PAGE_FAULT;
-
 		WREG32(mmMMU_UP_PAGE_ERROR_CAPTURE, 0);
 	}
 
@@ -6765,7 +6765,6 @@ static void gaudi_print_and_get_mmu_error_info(struct hl_device *hdev, u64 *addr
 		*addr |= RREG32(mmMMU_UP_ACCESS_ERROR_CAPTURE_VA);
 
 		dev_err_ratelimited(hdev->dev, "MMU access error on va 0x%llx\n", *addr);
-		*type = HL_RAZWI_MMU_ACCESS_ERROR;
 
 		WREG32(mmMMU_UP_ACCESS_ERROR_CAPTURE, 0);
 	}
@@ -7302,46 +7301,41 @@ static void gaudi_handle_qman_err(struct hl_device *hdev, u16 event_type, u64 *e
 static void gaudi_print_irq_info(struct hl_device *hdev, u16 event_type,
 					bool razwi)
 {
-	u32 engine_id_1, engine_id_2;
+	bool is_read = false, is_write = false;
+	u16 engine_id[2], num_of_razwi_eng = 0;
 	char desc[64] = "";
 	u64 razwi_addr = 0;
-	u8 razwi_type;
-	int rc;
+	u8 razwi_flags = 0;
 
 	/*
 	 * Init engine id by default as not valid and only if razwi initiated from engine with
 	 * engine id it will get valid value.
-	 * Init razwi type to default, will be changed only if razwi caused by page fault of
-	 * MMU access error
 	 */
-	engine_id_1 = U16_MAX;
-	engine_id_2 = U16_MAX;
-	razwi_type = U8_MAX;
+	engine_id[0] = HL_RAZWI_NA_ENG_ID;
+	engine_id[1] = HL_RAZWI_NA_ENG_ID;
 
 	gaudi_get_event_desc(event_type, desc, sizeof(desc));
 	dev_err_ratelimited(hdev->dev, "Received H/W interrupt %d [\"%s\"]\n",
 		event_type, desc);
 
 	if (razwi) {
-		gaudi_print_and_get_razwi_info(hdev, &engine_id_1, &engine_id_2);
-		gaudi_print_and_get_mmu_error_info(hdev, &razwi_addr, &razwi_type);
-
-		/* In case it's the first razwi, save its parameters*/
-		rc = atomic_cmpxchg(&hdev->captured_err_info.razwi.write_enable, 1, 0);
-		if (rc) {
-			hdev->captured_err_info.razwi.timestamp = ktime_get();
-			hdev->captured_err_info.razwi.addr = razwi_addr;
-			hdev->captured_err_info.razwi.engine_id_1 = engine_id_1;
-			hdev->captured_err_info.razwi.engine_id_2 = engine_id_2;
-			/*
-			 * If first engine id holds non valid value the razwi initiator
-			 * does not have engine id
-			 */
-			hdev->captured_err_info.razwi.non_engine_initiator =
-									(engine_id_1 == U16_MAX);
-			hdev->captured_err_info.razwi.type = razwi_type;
-
+		gaudi_print_and_get_razwi_info(hdev, &engine_id[0], &engine_id[1], &is_read,
+						&is_write);
+		gaudi_print_and_get_mmu_error_info(hdev, &razwi_addr);
+
+		if (is_read)
+			razwi_flags |= HL_RAZWI_READ;
+		if (is_write)
+			razwi_flags |= HL_RAZWI_WRITE;
+
+		if (engine_id[0] != HL_RAZWI_NA_ENG_ID) {
+			if (engine_id[1] != HL_RAZWI_NA_ENG_ID)
+				num_of_razwi_eng = 2;
+			else
+				num_of_razwi_eng = 1;
 		}
+
+		hl_capture_razwi(hdev, razwi_addr, engine_id, num_of_razwi_eng, razwi_flags);
 	}
 }
 
diff --git a/include/uapi/misc/habanalabs.h b/include/uapi/misc/habanalabs.h
index e00ebe05097d..d6f84cb35e3d 100644
--- a/include/uapi/misc/habanalabs.h
+++ b/include/uapi/misc/habanalabs.h
@@ -1071,31 +1071,44 @@ struct hl_info_cs_timeout_event {
 	__u64 seq;
 };
 
-#define HL_RAZWI_PAGE_FAULT 0
-#define HL_RAZWI_MMU_ACCESS_ERROR 1
+#define HL_RAZWI_NA_ENG_ID U16_MAX
+#define HL_RAZWI_MAX_NUM_OF_ENGINES_PER_RTR 128
+#define HL_RAZWI_READ		BIT(0)
+#define HL_RAZWI_WRITE		BIT(1)
+#define HL_RAZWI_LBW		BIT(2)
+#define HL_RAZWI_HBW		BIT(3)
+#define HL_RAZWI_RR		BIT(4)
+#define HL_RAZWI_ADDR_DEC	BIT(5)
 
 /**
  * struct hl_info_razwi_event - razwi information.
  * @timestamp: timestamp of razwi.
  * @addr: address which accessing it caused razwi.
- * @engine_id_1: engine id of the razwi initiator, if it was initiated by engine that does not
- *               have engine id it will be set to U16_MAX.
- * @engine_id_2: second engine id of razwi initiator. Might happen that razwi have 2 possible
- *               engines which one them caused the razwi. In that case, it will contain the
- *               second possible engine id, otherwise it will be set to U16_MAX.
- * @no_engine_id: if razwi initiator does not have engine id, this field will be set to 1,
- *                otherwise 0.
- * @error_type: cause of razwi, page fault or access error, otherwise it will be set to U8_MAX.
- * @pad: padding to 64 bit.
+ * @engine_id: engine id of the razwi initiator, if it was initiated by engine that does not
+ *             have engine id it will be set to HL_RAZWI_NA_ENG_ID. If there are several possible
+ *             engines which caused the razwi, it will hold all of them.
+ * @num_of_possible_engines: contains number of possible engine ids. In some asics, razwi indication
+ *                           might be common for several engines and there is no way to get the
+ *                           exact engine. In this way, engine_id array will be filled with all
+ *                           possible engines caused this razwi. Also, there might be possibility
+ *                           in gaudi, where we don't indication on specific engine, in that case
+ *                           the value of this parameter will be zero.
+ * @flags: bitmask for additional data: HL_RAZWI_READ - razwi caused by read operation
+ *                                      HL_RAZWI_WRITE - razwi caused by write operation
+ *                                      HL_RAZWI_LBW - razwi caused by lbw fabric transaction
+ *                                      HL_RAZWI_HBW - razwi caused by hbw fabric transaction
+ *                                      HL_RAZWI_RR - razwi caused by range register
+ *                                      HL_RAZWI_ADDR_DEC - razwi caused by address decode error
+ *         Note: this data is not supported by all asics, in that case the relevant bits will not
+ *               be set.
  */
 struct hl_info_razwi_event {
 	__s64 timestamp;
 	__u64 addr;
-	__u16 engine_id_1;
-	__u16 engine_id_2;
-	__u8 no_engine_id;
-	__u8 error_type;
-	__u8 pad[2];
+	__u16 engine_id[HL_RAZWI_MAX_NUM_OF_ENGINES_PER_RTR];
+	__u16 num_of_possible_engines;
+	__u8 flags;
+	__u8 pad[5];
 };
 
 #define MAX_QMAN_STREAMS_INFO		4
-- 
2.25.1

