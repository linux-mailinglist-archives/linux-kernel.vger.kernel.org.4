Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C9125F627E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 10:23:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230486AbiJFIX2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 04:23:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231145AbiJFIXU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 04:23:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53AB38D0C0
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 01:23:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EF06DB82019
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 08:23:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 879B6C43140;
        Thu,  6 Oct 2022 08:23:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665044596;
        bh=5b5FcFSXpPvczpSI+j8k5hV+bPdv7/c7btHMBWqG6mE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aM96yXgicHPk7BOWam37YLAKpTT/LZAZ59Odl4/SPbmdHD8+bngHFMb05e7u1m+Wn
         T80aTARisoZwvxY/s6JG7OM7IULUD352zn42O5fwtzeq2bkuzn7thoqJB5ZPPftS7b
         B6YLaqnZzaCTLXACeCW1GeWFmQgotyro5XfOu8Mjz7gXyceVJjDkfCv5uUPEGmzt+H
         /ayhoFApDV9O3KiFz05gqFt+0bJ634e8W1orJjBTCOLagy+qjEJcN7lC06w190UyUW
         iwFa27MuH1wZa4OXrnJ/G2IEtfoBwYGgPy8ss9P7dZRwiUtmept+k3wetU3jgZgmaD
         C9o2ZwsVLyM/g==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Dani Liberman <dliberman@habana.ai>
Subject: [PATCH 03/13] habanalabs: add page fault info uapi
Date:   Thu,  6 Oct 2022 11:22:58 +0300
Message-Id: <20221006082308.1266716-3-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221006082308.1266716-1-ogabbay@kernel.org>
References: <20221006082308.1266716-1-ogabbay@kernel.org>
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

From: Dani Liberman <dliberman@habana.ai>

Only the first page fault will be saved.
Besides the address which caused the page fault, the driver captures
all of the mmu user mappings.
User can retrieve this data via the new uapi (new opcode in INFO ioctl).

Signed-off-by: Dani Liberman <dliberman@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/device.c       | 58 +++++++++++++++++++
 drivers/misc/habanalabs/common/habanalabs.h   | 22 ++++++-
 .../misc/habanalabs/common/habanalabs_drv.c   |  1 +
 .../misc/habanalabs/common/habanalabs_ioctl.c | 42 ++++++++++++++
 drivers/misc/habanalabs/gaudi/gaudi.c         |  2 +
 include/uapi/misc/habanalabs.h                | 31 ++++++++++
 6 files changed, 155 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/habanalabs/common/device.c b/drivers/misc/habanalabs/common/device.c
index 30ddaaae67e5..5dc6c77b4721 100644
--- a/drivers/misc/habanalabs/common/device.c
+++ b/drivers/misc/habanalabs/common/device.c
@@ -12,6 +12,7 @@
 
 #include <linux/pci.h>
 #include <linux/hwmon.h>
+#include <linux/vmalloc.h>
 
 #include <trace/events/habanalabs.h>
 
@@ -2199,6 +2200,8 @@ void hl_device_fini(struct hl_device *hdev)
 
 	hl_mmu_fini(hdev);
 
+	vfree(hdev->captured_err_info.pgf_info.user_mappings);
+
 	hl_eq_fini(hdev, &hdev->event_queue);
 
 	kfree(hdev->shadow_cs_queue);
@@ -2275,3 +2278,58 @@ void hl_capture_razwi(struct hl_device *hdev, u64 addr, u16 *engine_id, u16 num_
 			num_of_engines * sizeof(u16));
 	hdev->captured_err_info.razwi.flags = flags;
 }
+static void hl_capture_user_mappings(struct hl_device *hdev)
+{
+	struct page_fault_info *pgf_info = &hdev->captured_err_info.pgf_info;
+	struct hl_vm_hash_node *hnode;
+	struct hl_userptr *userptr;
+	struct hl_ctx *ctx;
+	u32 map_idx = 0;
+	int i;
+
+	ctx = hl_get_compute_ctx(hdev);
+	if (!ctx) {
+		dev_err(hdev->dev, "Can't get user context for user mappings\n");
+		return;
+	}
+
+	mutex_lock(&ctx->mem_hash_lock);
+	hash_for_each(ctx->mem_hash, i, hnode, node)
+	pgf_info->num_of_user_mappings++;
+
+	if (!pgf_info->num_of_user_mappings)
+		goto finish;
+
+	/* In case we already allocated in previous session, need to release it before
+	 * allocating new buffer.
+	 */
+	vfree(pgf_info->user_mappings);
+	pgf_info->user_mappings =
+			vmalloc(pgf_info->num_of_user_mappings * sizeof(struct hl_user_mapping));
+	if (!pgf_info->user_mappings) {
+		pgf_info->num_of_user_mappings = 0;
+		goto finish;
+	}
+
+	hash_for_each(ctx->mem_hash, i, hnode, node) {
+		userptr = hnode->ptr;
+		pgf_info->user_mappings[map_idx].dev_va = hnode->vaddr;
+		pgf_info->user_mappings[map_idx].size = userptr->size;
+		map_idx++;
+	}
+finish:
+	mutex_unlock(&ctx->mem_hash_lock);
+	hl_ctx_put(ctx);
+}
+
+void hl_capture_page_fault(struct hl_device *hdev, u64 addr, u16 eng_id, bool is_pmmu)
+{
+	/* Capture only the first page fault */
+	if (atomic_cmpxchg(&hdev->captured_err_info.pgf_info_recorded, 0, 1))
+		return;
+
+	hdev->captured_err_info.pgf_info.pgf.timestamp = ktime_to_ns(ktime_get());
+	hdev->captured_err_info.pgf_info.pgf.addr = addr;
+	hdev->captured_err_info.pgf_info.pgf.engine_id = eng_id;
+	hl_capture_user_mappings(hdev);
+}
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index f4b3fa4b0976..1489240d5a3a 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -2957,19 +2957,38 @@ struct undefined_opcode_info {
 	bool write_enable;
 };
 
+/**
+ * struct page_fault_info - info about page fault
+ * @pgf_info: page fault information.
+ * @user_mappings: buffer containing user mappings.
+ * @num_of_user_mappings: number of user mappings.
+ */
+struct page_fault_info {
+	struct hl_page_fault_info	pgf;
+	struct hl_user_mapping		*user_mappings;
+	u64				num_of_user_mappings;
+};
+
 /**
  * struct hl_error_info - holds information collected during an error.
  * @cs_timeout: CS timeout error information.
  * @razwi: razwi information.
  * @razwi_info_recorded: if set writing to razwi information is enabled.
- *                otherwise - disabled, so the first (root cause) razwi will not be overwritten.
+ *                       otherwise - disabled, so the first (root cause) razwi will not be
+ *                       overwritten.
  * @undef_opcode: undefined opcode information
+ * @pgf_info: page fault information.
+ * @pgf_info_recorded: if set writing to page fault information is enabled.
+ *                     otherwise - disabled, so the first (root cause) page fault will not be
+ *                     overwritten.
  */
 struct hl_error_info {
 	struct cs_timeout_info		cs_timeout;
 	struct hl_info_razwi_event	razwi;
 	atomic_t			razwi_info_recorded;
 	struct undefined_opcode_info	undef_opcode;
+	struct page_fault_info		pgf_info;
+	atomic_t			pgf_info_recorded;
 };
 
 /**
@@ -3781,6 +3800,7 @@ hl_mmap_mem_buf_alloc(struct hl_mem_mgr *mmg,
 __printf(2, 3) void hl_engine_data_sprintf(struct engines_data *e, const char *fmt, ...);
 void hl_capture_razwi(struct hl_device *hdev, u64 addr, u16 *engine_id, u16 num_of_engines,
 			u8 flags);
+void hl_capture_page_fault(struct hl_device *hdev, u64 addr, u16 eng_id, bool is_pmmu);
 
 #ifdef CONFIG_DEBUG_FS
 
diff --git a/drivers/misc/habanalabs/common/habanalabs_drv.c b/drivers/misc/habanalabs/common/habanalabs_drv.c
index d87434b9bc16..714994725224 100644
--- a/drivers/misc/habanalabs/common/habanalabs_drv.c
+++ b/drivers/misc/habanalabs/common/habanalabs_drv.c
@@ -213,6 +213,7 @@ int hl_device_open(struct inode *inode, struct file *filp)
 
 	atomic_set(&hdev->captured_err_info.cs_timeout.write_enable, 1);
 	atomic_set(&hdev->captured_err_info.razwi_info_recorded, 0);
+	atomic_set(&hdev->captured_err_info.pgf_info_recorded, 0);
 	hdev->captured_err_info.undef_opcode.write_enable = true;
 
 	hdev->open_counter++;
diff --git a/drivers/misc/habanalabs/common/habanalabs_ioctl.c b/drivers/misc/habanalabs/common/habanalabs_ioctl.c
index 6aef4e24d122..cac2c7fb14f1 100644
--- a/drivers/misc/habanalabs/common/habanalabs_ioctl.c
+++ b/drivers/misc/habanalabs/common/habanalabs_ioctl.c
@@ -778,6 +778,42 @@ static int engine_status_info(struct hl_fpriv *hpriv, struct hl_info_args *args)
 	return rc;
 }
 
+static int page_fault_info(struct hl_fpriv *hpriv, struct hl_info_args *args)
+{
+	struct hl_device *hdev = hpriv->hdev;
+	u32 max_size = args->return_size;
+	struct hl_page_fault_info *info = &hdev->captured_err_info.pgf_info.pgf;
+	void __user *out = (void __user *) (uintptr_t) args->return_pointer;
+
+	if ((!max_size) || (!out))
+		return -EINVAL;
+
+	return copy_to_user(out, info, min_t(size_t, max_size, sizeof(struct hl_page_fault_info)))
+				? -EFAULT : 0;
+}
+
+static int user_mappings_info(struct hl_fpriv *hpriv, struct hl_info_args *args)
+{
+	void __user *out = (void __user *) (uintptr_t) args->return_pointer;
+	u32 user_buf_size = args->return_size;
+	struct hl_device *hdev = hpriv->hdev;
+	struct page_fault_info *pgf_info;
+	u64 actual_size;
+
+	pgf_info = &hdev->captured_err_info.pgf_info;
+	args->array_size = pgf_info->num_of_user_mappings;
+
+	if (!out)
+		return -EINVAL;
+
+	actual_size = pgf_info->num_of_user_mappings * sizeof(struct hl_user_mapping);
+	if (user_buf_size < actual_size)
+		return -ENOMEM;
+
+	return copy_to_user(out, pgf_info->user_mappings, min_t(size_t, user_buf_size, actual_size))
+				? -EFAULT : 0;
+}
+
 static int _hl_info_ioctl(struct hl_fpriv *hpriv, void *data,
 				struct device *dev)
 {
@@ -837,6 +873,12 @@ static int _hl_info_ioctl(struct hl_fpriv *hpriv, void *data,
 	case HL_INFO_GET_EVENTS:
 		return events_info(hpriv, args);
 
+	case HL_INFO_PAGE_FAULT_EVENT:
+		return page_fault_info(hpriv, args);
+
+	case HL_INFO_USER_MAPPINGS:
+		return user_mappings_info(hpriv, args);
+
 	default:
 		break;
 	}
diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index f856ac51fde1..1a99f7be8b60 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -6755,6 +6755,8 @@ static void gaudi_print_and_get_mmu_error_info(struct hl_device *hdev, u64 *addr
 		*addr |= RREG32(mmMMU_UP_PAGE_ERROR_CAPTURE_VA);
 
 		dev_err_ratelimited(hdev->dev, "MMU page fault on va 0x%llx\n", *addr);
+		hl_capture_page_fault(hdev, *addr, 0, true);
+
 		WREG32(mmMMU_UP_PAGE_ERROR_CAPTURE, 0);
 	}
 
diff --git a/include/uapi/misc/habanalabs.h b/include/uapi/misc/habanalabs.h
index d6f84cb35e3d..2b794f54e2ed 100644
--- a/include/uapi/misc/habanalabs.h
+++ b/include/uapi/misc/habanalabs.h
@@ -778,6 +778,9 @@ enum hl_server_type {
  * HL_INFO_UNREGISTER_EVENTFD - Unregister eventfd
  * HL_INFO_GET_EVENTS         - Retrieve the last occurred events
  * HL_INFO_UNDEFINED_OPCODE_EVENT - Retrieve last undefined opcode error information.
+ * HL_INFO_ENGINE_STATUS - Retrieve the status of all the h/w engines in the asic.
+ * HL_INFO_PAGE_FAULT_EVENT - Retrieve parameters of captured page fault.
+ * HL_INFO_USER_MAPPINGS - Retrieve user mappings, captured after page fault event.
  */
 #define HL_INFO_HW_IP_INFO			0
 #define HL_INFO_HW_EVENTS			1
@@ -809,6 +812,8 @@ enum hl_server_type {
 #define HL_INFO_GET_EVENTS			30
 #define HL_INFO_UNDEFINED_OPCODE_EVENT		31
 #define HL_INFO_ENGINE_STATUS			32
+#define HL_INFO_PAGE_FAULT_EVENT		33
+#define HL_INFO_USER_MAPPINGS			34
 
 #define HL_INFO_VERSION_MAX_LEN			128
 #define HL_INFO_CARD_NAME_MAX_LEN		16
@@ -1187,6 +1192,29 @@ struct hl_info_sec_attest {
 	__u8 pad0[2];
 };
 
+/**
+ * struct hl_page_fault_info - page fault information.
+ * @timestamp: timestamp of page fault.
+ * @addr: address which accessing it caused page fault.
+ * @engine_id: engine id which caused the page fault, supported only in gaudi3.
+ */
+struct hl_page_fault_info {
+	__s64 timestamp;
+	__u64 addr;
+	__u16 engine_id;
+	__u8 pad[6];
+};
+
+/**
+ * struct hl_user_mapping - user mapping information.
+ * @dev_va: device virtual address.
+ * @size: virtual address mapping size.
+ */
+struct hl_user_mapping {
+	__u64 dev_va;
+	__u64 size;
+};
+
 enum gaudi_dcores {
 	HL_GAUDI_WS_DCORE,
 	HL_GAUDI_WN_DCORE,
@@ -1213,6 +1241,8 @@ enum gaudi_dcores {
  *                           needed, hence updating this variable so user will know the exact amount
  *                           of bytes copied by the kernel to the buffer.
  * @sec_attest_nonce: Nonce number used for attestation report.
+ * @array_size: Number of array members copied to user buffer.
+ *              Relevant for HL_INFO_USER_MAPPINGS info ioctl.
  * @pad: Padding to 64 bit.
  */
 struct hl_info_args {
@@ -1228,6 +1258,7 @@ struct hl_info_args {
 		__u32 eventfd;
 		__u32 user_buffer_actual_size;
 		__u32 sec_attest_nonce;
+		__u32 array_size;
 	};
 
 	__u32 pad;
-- 
2.25.1

