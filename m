Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0BC1647292
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 16:14:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbiLHPOI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 10:14:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbiLHPOF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 10:14:05 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDABE7B55F
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 07:14:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 3BC55CE24AF
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 15:13:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D565C433D7;
        Thu,  8 Dec 2022 15:13:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670512437;
        bh=tlXEVAOSNK/nYsqgZwBYGiq4v7wig4HlBnsvgqzMN2A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MovZCgAPFk/WPqZwWJs4Y7v8Vtrb0NF2/tMi+K440G6DVaRkx/b3w9pyKZfopjlCo
         x4jMKSGW2klF3ME+Z+CxcZhYj4BFTIZuwjZq9D8YXaEdVpVWBi2mjjKB3AKqBmk0kE
         +CXl3wBYXtNkTUDemahzZUbheK9T2Pl5xkUzAer6Aghrk2JbBXPTHktfwRCiNRjU3i
         1ZJ8vFVyr1IT76LbFifrkajIR77GVK4rkHPD8hGpJ2Qj6xB2VcctpLPrSjmNqRNOkV
         YfuKdtpJXRERc2AzK+GYyEWmoHRV2KwQ7ORL/tPthvYb96UkOjNvyNyCdWLzJgOjLV
         7uckjoEBs/6qA==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     farah kassabri <fkassabri@habana.ai>
Subject: [PATCH 02/26] habanalabs: read binning info from preboot
Date:   Thu,  8 Dec 2022 17:13:26 +0200
Message-Id: <20221208151350.1833823-2-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221208151350.1833823-1-ogabbay@kernel.org>
References: <20221208151350.1833823-1-ogabbay@kernel.org>
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

From: farah kassabri <fkassabri@habana.ai>

Sometimes we need the binning info at a very early state of the
driver initialization. Therefore, support was added in preboot to
provide the binning info as part of the f/w descriptor and the driver
can now use that.

Signed-off-by: farah kassabri <fkassabri@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/firmware_if.c  | 24 +++++++++++++-
 drivers/misc/habanalabs/common/habanalabs.h   |  5 +++
 .../habanalabs/include/common/hl_boot_if.h    | 31 +++++++++++++------
 3 files changed, 50 insertions(+), 10 deletions(-)

diff --git a/drivers/misc/habanalabs/common/firmware_if.c b/drivers/misc/habanalabs/common/firmware_if.c
index 228b92278e48..4f364c3085fe 100644
--- a/drivers/misc/habanalabs/common/firmware_if.c
+++ b/drivers/misc/habanalabs/common/firmware_if.c
@@ -2560,13 +2560,35 @@ static int hl_fw_dynamic_init_cpu(struct hl_device *hdev,
 	}
 
 	if (!(hdev->fw_components & FW_TYPE_BOOT_CPU)) {
+		struct lkd_fw_binning_info *binning_info;
+
 		rc = hl_fw_dynamic_request_descriptor(hdev, fw_loader, 0);
 		if (rc)
 			goto protocol_err;
 
 		/* read preboot version */
-		return hl_fw_dynamic_read_device_fw_version(hdev, FW_COMP_PREBOOT,
+		rc = hl_fw_dynamic_read_device_fw_version(hdev, FW_COMP_PREBOOT,
 				fw_loader->dynamic_loader.comm_desc.cur_fw_ver);
+
+		if (rc)
+			goto out;
+
+		/* read binning info from preboot */
+		if (hdev->support_preboot_binning) {
+			binning_info = &fw_loader->dynamic_loader.comm_desc.binning_info;
+			hdev->tpc_binning = le64_to_cpu(binning_info->tpc_mask_l);
+			hdev->dram_binning = le32_to_cpu(binning_info->dram_mask);
+			hdev->edma_binning = le32_to_cpu(binning_info->edma_mask);
+			hdev->decoder_binning = le32_to_cpu(binning_info->dec_mask);
+			hdev->rotator_binning = le32_to_cpu(binning_info->rot_mask);
+
+			dev_dbg(hdev->dev,
+				"Read binning masks: tpc: 0x%llx, dram: 0x%llx, edma: 0x%x, dec: 0x%x, rot:0x%x\n",
+				hdev->tpc_binning, hdev->dram_binning, hdev->edma_binning,
+				hdev->decoder_binning, hdev->rotator_binning);
+		}
+out:
+		return rc;
 	}
 
 	/* load boot fit to FW */
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index e2527d976ee0..9e42d0e9ce33 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -3157,6 +3157,8 @@ struct hl_reset_info {
  * @edma_binning: contains mask of edma engines that is received from the f/w which
  *                   indicates which edma engines are binned-out
  * @device_release_watchdog_timeout_sec: device release watchdog timeout value in seconds.
+ * @rotator_binning: contains mask of rotators engines that is received from the f/w
+ *			which indicates which rotator engines are binned-out(Gaudi3 and above).
  * @id: device minor.
  * @id_control: minor of the control device.
  * @cdev_idx: char device index. Used for setting its name.
@@ -3214,6 +3216,7 @@ struct hl_reset_info {
  * @heartbeat: Controls if we want to enable the heartbeat mechanism vs. the f/w, which verifies
  *             that the f/w is always alive. Used only for testing.
  * @supports_ctx_switch: true if a ctx switch is required upon first submission.
+ * @support_preboot_binning: true if we support read binning info from preboot.
  */
 struct hl_device {
 	struct pci_dev			*pdev;
@@ -3322,6 +3325,7 @@ struct hl_device {
 	u32				decoder_binning;
 	u32				edma_binning;
 	u32				device_release_watchdog_timeout_sec;
+	u32				rotator_binning;
 	u16				id;
 	u16				id_control;
 	u16				cdev_idx;
@@ -3355,6 +3359,7 @@ struct hl_device {
 	u8				supports_mmu_prefetch;
 	u8				reset_upon_device_release;
 	u8				supports_ctx_switch;
+	u8				support_preboot_binning;
 
 	/* Parameters for bring-up */
 	u64				nic_ports_mask;
diff --git a/drivers/misc/habanalabs/include/common/hl_boot_if.h b/drivers/misc/habanalabs/include/common/hl_boot_if.h
index e0ea51cc7475..fe034111360e 100644
--- a/drivers/misc/habanalabs/include/common/hl_boot_if.h
+++ b/drivers/misc/habanalabs/include/common/hl_boot_if.h
@@ -439,7 +439,7 @@ struct cpu_dyn_regs {
 /* TODO: remove the desc magic after the code is updated to use message */
 /* HCDM - Habana Communications Descriptor Magic */
 #define HL_COMMS_DESC_MAGIC	0x4843444D
-#define HL_COMMS_DESC_VER	1
+#define HL_COMMS_DESC_VER	3
 
 /* HCMv - Habana Communications Message + header version */
 #define HL_COMMS_MSG_MAGIC_VALUE	0x48434D00
@@ -450,8 +450,10 @@ struct cpu_dyn_regs {
 					((ver) & HL_COMMS_MSG_MAGIC_VER_MASK))
 #define HL_COMMS_MSG_MAGIC_V0		HL_COMMS_DESC_MAGIC
 #define HL_COMMS_MSG_MAGIC_V1		HL_COMMS_MSG_MAGIC_VER(1)
+#define HL_COMMS_MSG_MAGIC_V2		HL_COMMS_MSG_MAGIC_VER(2)
+#define HL_COMMS_MSG_MAGIC_V3		HL_COMMS_MSG_MAGIC_VER(3)
 
-#define HL_COMMS_MSG_MAGIC		HL_COMMS_MSG_MAGIC_V1
+#define HL_COMMS_MSG_MAGIC		HL_COMMS_MSG_MAGIC_V3
 
 #define HL_COMMS_MSG_MAGIC_VALIDATE_MAGIC(magic)			\
 		(((magic) & HL_COMMS_MSG_MAGIC_MASK) ==			\
@@ -474,22 +476,31 @@ enum comms_msg_type {
 
 /*
  * Binning information shared between LKD and FW
- * @tpc_mask - TPC binning information
+ * @tpc_mask_l - TPC binning information lower 64 bit
  * @dec_mask - Decoder binning information
- * @hbm_mask - HBM binning information
+ * @dram_mask - DRAM binning information
  * @edma_mask - EDMA binning information
  * @mme_mask_l - MME binning information lower 32
  * @mme_mask_h - MME binning information upper 32
- * @reserved - reserved field for 64 bit alignment
+ * @rot_mask - Rotator binning information
+ * @xbar_mask - xBAR binning information
+ * @reserved - reserved field for future binning info w/o ABI change
+ * @tpc_mask_h - TPC binning information upper 64 bit
+ * @nic_mask - NIC binning information
  */
 struct lkd_fw_binning_info {
-	__le64 tpc_mask;
+	__le64 tpc_mask_l;
 	__le32 dec_mask;
-	__le32 hbm_mask;
+	__le32 dram_mask;
 	__le32 edma_mask;
 	__le32 mme_mask_l;
 	__le32 mme_mask_h;
-	__le32 reserved;
+	__le32 rot_mask;
+	__le32 xbar_mask;
+	__le32 reserved0;
+	__le64 tpc_mask_h;
+	__le64 nic_mask;
+	__le32 reserved1[8];
 };
 
 /* TODO: remove this struct after the code is updated to use message */
@@ -521,6 +532,7 @@ struct lkd_fw_comms_desc {
 	/* can be used for 1 more version w/o ABI change */
 	char reserved0[VERSION_MAX_LEN];
 	__le64 img_addr;	/* address for next FW component load */
+	struct lkd_fw_binning_info binning_info;
 };
 
 enum comms_reset_cause {
@@ -545,6 +557,7 @@ struct lkd_fw_comms_msg {
 			char reserved0[VERSION_MAX_LEN];
 			/* address for next FW component load */
 			__le64 img_addr;
+			struct lkd_fw_binning_info binning_info;
 		};
 		struct {
 			__u8 reset_cause;
@@ -552,7 +565,7 @@ struct lkd_fw_comms_msg {
 		struct {
 			__u8 fw_cfg_skip; /* 1 - skip, 0 - don't skip */
 		};
-		struct lkd_fw_binning_info binning_info;
+		struct lkd_fw_binning_info binning_conf;
 	};
 };
 
-- 
2.25.1

