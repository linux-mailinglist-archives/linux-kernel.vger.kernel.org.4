Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2CA664DA4F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 12:32:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbiLOLbx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 06:31:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230057AbiLOLbp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 06:31:45 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5A5812AE1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 03:31:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 9BDBDCE1BBF
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 11:31:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D517C433EF;
        Thu, 15 Dec 2022 11:31:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671103899;
        bh=Op2bX+wSrLzDFbimJTytptPVa3j0n04JFP1WsO66bIo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AaqOhfUkQAgIlngEfAAtOXTcG2xqR7ilngR7Pg5qU39fnvPqJHNWTDL5ec7+JKsJd
         WnIUIrQ7JmZHHXPMvEoG4zXR0uhKCteX0m1wXiTni27jraSlhTwv3+DXmSCT41aekZ
         RYIf3v2G2Gxg2yQCIzBJTvGG5yGRXTITz/nDv0vs2xv9BLGKT1PNITGqDGi2vjuSyu
         I6sFfDVp9NKf1fV8YoIRyDV3qKJOZntzOIc/ag9mOeWYRVycu/85E7o3F/7FKRR/dK
         QUhdVy8zJZ8sSkwavI0BySQgyPpeTIZbms3729zCpHc4GUfSDCvjXv4KvbIUmTf9ya
         B66GIMTWYv4Hw==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     farah kassabri <fkassabri@habana.ai>
Subject: [PATCH 3/3] habanalabs: pass-through request from user to f/w
Date:   Thu, 15 Dec 2022 13:31:31 +0200
Message-Id: <20221215113131.2276739-3-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221215113131.2276739-1-ogabbay@kernel.org>
References: <20221215113131.2276739-1-ogabbay@kernel.org>
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

Add a uAPI, as part of the INFO IOCTL, to allow users to send
requests directly to f/w, according to a pre-defined set of opcodes
that the f/w exposes.

The f/w will put the result in a kernel-allocated buffer, which the
driver will then copy to the user-supplied buffer.

This will allow f/w tools to communicate directly with the f/w
without the need to add a new uAPI to the driver for each new type
of request.

Signed-off-by: farah kassabri <fkassabri@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/firmware_if.c  | 24 +++++++
 drivers/misc/habanalabs/common/habanalabs.h   |  2 +
 .../misc/habanalabs/common/habanalabs_ioctl.c | 51 +++++++++++++++
 .../misc/habanalabs/include/common/cpucp_if.h | 65 +++++++++++++++++--
 include/uapi/misc/habanalabs.h                |  4 ++
 5 files changed, 139 insertions(+), 7 deletions(-)

diff --git a/drivers/misc/habanalabs/common/firmware_if.c b/drivers/misc/habanalabs/common/firmware_if.c
index a8911e15d937..eb000e035026 100644
--- a/drivers/misc/habanalabs/common/firmware_if.c
+++ b/drivers/misc/habanalabs/common/firmware_if.c
@@ -3145,3 +3145,27 @@ int hl_fw_get_sec_attest_info(struct hl_device *hdev, struct cpucp_sec_attest_in
 					sizeof(struct cpucp_sec_attest_info), nonce,
 					HL_CPUCP_SEC_ATTEST_INFO_TINEOUT_USEC);
 }
+
+int hl_fw_send_generic_request(struct hl_device *hdev, enum hl_passthrough_type sub_opcode,
+						dma_addr_t buff, u32 *size)
+{
+	struct cpucp_packet pkt = {0};
+	u64 result;
+	int rc = 0;
+
+	pkt.ctl = cpu_to_le32(CPUCP_PACKET_GENERIC_PASSTHROUGH << CPUCP_PKT_CTL_OPCODE_SHIFT);
+	pkt.addr = cpu_to_le64(buff);
+	pkt.data_max_size = cpu_to_le32(*size);
+	pkt.pkt_subidx = cpu_to_le32(sub_opcode);
+
+	rc = hdev->asic_funcs->send_cpu_message(hdev, (u32 *)&pkt, sizeof(pkt),
+						HL_CPUCP_INFO_TIMEOUT_USEC, &result);
+	if (rc)
+		dev_err(hdev->dev, "failed to send CPUCP data of generic fw pkt\n");
+	else
+		dev_dbg(hdev->dev, "generic pkt was successful, result: 0x%llx\n", result);
+
+	*size = (u32)result;
+
+	return rc;
+}
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index 210dd607e18b..c609b2e44ad3 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -3790,6 +3790,8 @@ int hl_fw_get_clk_rate(struct hl_device *hdev, u32 *cur_clk, u32 *max_clk);
 void hl_fw_set_pll_profile(struct hl_device *hdev);
 void hl_sysfs_add_dev_clk_attr(struct hl_device *hdev, struct attribute_group *dev_clk_attr_grp);
 void hl_sysfs_add_dev_vrm_attr(struct hl_device *hdev, struct attribute_group *dev_vrm_attr_grp);
+int hl_fw_send_generic_request(struct hl_device *hdev, enum hl_passthrough_type sub_opcode,
+						dma_addr_t buff, u32 *size);
 
 void hw_sob_get(struct hl_hw_sob *hw_sob);
 void hw_sob_put(struct hl_hw_sob *hw_sob);
diff --git a/drivers/misc/habanalabs/common/habanalabs_ioctl.c b/drivers/misc/habanalabs/common/habanalabs_ioctl.c
index b6abfa7761a7..4d642987ad02 100644
--- a/drivers/misc/habanalabs/common/habanalabs_ioctl.c
+++ b/drivers/misc/habanalabs/common/habanalabs_ioctl.c
@@ -820,6 +820,54 @@ static int user_mappings_info(struct hl_fpriv *hpriv, struct hl_info_args *args)
 				? -EFAULT : 0;
 }
 
+static int send_fw_generic_request(struct hl_device *hdev, struct hl_info_args *info_args)
+{
+	void __user *buff = (void __user *) (uintptr_t) info_args->return_pointer;
+	u32 size = info_args->return_size;
+	dma_addr_t dma_handle;
+	bool need_input_buff;
+	void *fw_buff;
+	int rc = 0;
+
+	switch (info_args->fw_sub_opcode) {
+	case HL_PASSTHROUGH_VERSIONS:
+		need_input_buff = false;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (size > SZ_1M) {
+		dev_err(hdev->dev, "buffer size cannot exceed 1MB\n");
+		return -EINVAL;
+	}
+
+	fw_buff = hl_cpu_accessible_dma_pool_alloc(hdev, size, &dma_handle);
+	if (!fw_buff)
+		return -ENOMEM;
+
+
+	if (need_input_buff && copy_from_user(fw_buff, buff, size)) {
+		dev_dbg(hdev->dev, "Failed to copy from user FW buff\n");
+		rc = -EFAULT;
+		goto free_buff;
+	}
+
+	rc = hl_fw_send_generic_request(hdev, info_args->fw_sub_opcode, dma_handle, &size);
+	if (rc)
+		goto free_buff;
+
+	if (copy_to_user(buff, fw_buff, min(size, info_args->return_size))) {
+		dev_dbg(hdev->dev, "Failed to copy to user FW generic req output\n");
+		rc = -EFAULT;
+	}
+
+free_buff:
+	hl_cpu_accessible_dma_pool_free(hdev, info_args->return_size, fw_buff);
+
+	return rc;
+}
+
 static int _hl_info_ioctl(struct hl_fpriv *hpriv, void *data,
 				struct device *dev)
 {
@@ -947,6 +995,9 @@ static int _hl_info_ioctl(struct hl_fpriv *hpriv, void *data,
 	case HL_INFO_ENGINE_STATUS:
 		return engine_status_info(hpriv, args);
 
+	case HL_INFO_FW_GENERIC_REQ:
+		return send_fw_generic_request(hdev, args);
+
 	default:
 		dev_err(dev, "Invalid request %d\n", args->op);
 		rc = -EINVAL;
diff --git a/drivers/misc/habanalabs/include/common/cpucp_if.h b/drivers/misc/habanalabs/include/common/cpucp_if.h
index baa5aa43b6f4..0a66b7f85164 100644
--- a/drivers/misc/habanalabs/include/common/cpucp_if.h
+++ b/drivers/misc/habanalabs/include/common/cpucp_if.h
@@ -643,6 +643,10 @@ enum pq_init_status {
  *       data corruption in case of mismatched driver/FW versions.
  *       Relevant only to Gaudi.
  *
+ * * CPUCP_PACKET_GENERIC_PASSTHROUGH -
+ *      Generic opcode for all firmware info that is only passed to host
+ *      through the LKD, without getting parsed there.
+ *
  * CPUCP_PACKET_ACTIVE_STATUS_SET -
  *       LKD sends FW indication whether device is free or in use, this indication is reported
  *       also to the BMC.
@@ -704,9 +708,12 @@ enum cpucp_packet_id {
 	CPUCP_PACKET_RESERVED5,			/* not used */
 	CPUCP_PACKET_RESERVED6,			/* not used */
 	CPUCP_PACKET_RESERVED7,			/* not used */
+	CPUCP_PACKET_GENERIC_PASSTHROUGH,	/* IOCTL */
 	CPUCP_PACKET_RESERVED8,			/* not used */
-	CPUCP_PACKET_RESERVED9,			/* not used */
 	CPUCP_PACKET_ACTIVE_STATUS_SET,		/* internal */
+	CPUCP_PACKET_RESERVED9,			/* not used */
+	CPUCP_PACKET_RESERVED10,		/* not used */
+	CPUCP_PACKET_RESERVED11,		/* not used */
 	CPUCP_PACKET_ID_MAX			/* must be last */
 };
 
@@ -805,8 +812,13 @@ struct cpucp_packet {
 		__le32 nonce;
 	};
 
-	/* For NIC requests */
-	__le32 port_index;
+	union {
+		/* For NIC requests */
+		__le32 port_index;
+
+		/* For Generic packet sub index */
+		__le32 pkt_subidx;
+	};
 };
 
 struct cpucp_unmask_irq_arr_packet {
@@ -976,6 +988,11 @@ enum pll_index {
 	IC_PLL = 16,
 	MC_PLL = 17,
 	EMMC_PLL = 18,
+	D2D_PLL = 19,
+	CS_PLL = 20,
+	C2C_PLL = 21,
+	NCH_PLL = 22,
+	C2M_PLL = 23,
 	PLL_MAX
 };
 
@@ -1135,8 +1152,9 @@ enum cpucp_serdes_type {
 	HLS1_SERDES_TYPE,
 	HLS1H_SERDES_TYPE,
 	HLS2_SERDES_TYPE,
-	UNKNOWN_SERDES_TYPE,
-	MAX_NUM_SERDES_TYPE = UNKNOWN_SERDES_TYPE
+	HLS2_TYPE_1_SERDES_TYPE,
+	MAX_NUM_SERDES_TYPE,		/* number of types */
+	UNKNOWN_SERDES_TYPE = 0xFFFF	/* serdes_type is u16 */
 };
 
 struct cpucp_nic_info {
@@ -1160,6 +1178,21 @@ struct page_discard_info {
 	__le32 mmu_page_idx[PAGE_DISCARD_MAX];
 };
 
+/*
+ * struct frac_val - fracture value represented by "integer.frac".
+ * @integer: the integer part of the fracture value;
+ * @frac: the fracture part of the fracture value.
+ */
+struct frac_val {
+	union {
+		struct {
+			__le16 integer;
+			__le16 frac;
+		};
+		__le32 val;
+	};
+};
+
 /*
  * struct ser_val - the SER (symbol error rate) value is represented by "integer * 10 ^ -exp".
  * @integer: the integer part of the SER value;
@@ -1183,8 +1216,12 @@ struct ser_val {
  * @pcs_link: has PCS link.
  * @phy_ready: is PHY ready.
  * @auto_neg: is Autoneg enabled.
- * @timeout_retransmission_cnt: timeout retransmission events
- * @high_ber_cnt: high ber events
+ * @timeout_retransmission_cnt: timeout retransmission events.
+ * @high_ber_cnt: high ber events.
+ * @pre_fec_ser: pre FEC SER value.
+ * @post_fec_ser: post FEC SER value.
+ * @throughput: measured throughput.
+ * @latency: measured latency.
  */
 struct cpucp_nic_status {
 	__le32 port;
@@ -1200,6 +1237,10 @@ struct cpucp_nic_status {
 	__u8 auto_neg;
 	__le32 timeout_retransmission_cnt;
 	__le32 high_ber_cnt;
+	struct ser_val pre_fec_ser;
+	struct ser_val post_fec_ser;
+	struct frac_val bandwidth;
+	struct frac_val lat;
 };
 
 enum cpucp_hbm_row_replace_cause {
@@ -1317,4 +1358,14 @@ struct cpucp_monitor_dump {
 	struct dcore_monitor_regs_data sync_mngr_e_n;
 };
 
+/*
+ * The Type of the generic request (and other input arguments) will be fetched from user by reading
+ * from "pkt_subidx" field in struct cpucp_packet.
+ *
+ * HL_PASSTHROUGHT_VERSIONS	- Fetch all firmware versions.
+ */
+enum hl_passthrough_type {
+	HL_PASSTHROUGH_VERSIONS,
+};
+
 #endif /* CPUCP_IF_H */
diff --git a/include/uapi/misc/habanalabs.h b/include/uapi/misc/habanalabs.h
index c67d18901c1d..90e628779264 100644
--- a/include/uapi/misc/habanalabs.h
+++ b/include/uapi/misc/habanalabs.h
@@ -789,6 +789,7 @@ enum hl_server_type {
  * HL_INFO_ENGINE_STATUS - Retrieve the status of all the h/w engines in the asic.
  * HL_INFO_PAGE_FAULT_EVENT - Retrieve parameters of captured page fault.
  * HL_INFO_USER_MAPPINGS - Retrieve user mappings, captured after page fault event.
+ * HL_INFO_FW_GENERIC_REQ - Send generic request to FW.
  */
 #define HL_INFO_HW_IP_INFO			0
 #define HL_INFO_HW_EVENTS			1
@@ -822,6 +823,7 @@ enum hl_server_type {
 #define HL_INFO_ENGINE_STATUS			32
 #define HL_INFO_PAGE_FAULT_EVENT		33
 #define HL_INFO_USER_MAPPINGS			34
+#define HL_INFO_FW_GENERIC_REQ			35
 
 #define HL_INFO_VERSION_MAX_LEN			128
 #define HL_INFO_CARD_NAME_MAX_LEN		16
@@ -1258,6 +1260,7 @@ enum gaudi_dcores {
  * @sec_attest_nonce: Nonce number used for attestation report.
  * @array_size: Number of array members copied to user buffer.
  *              Relevant for HL_INFO_USER_MAPPINGS info ioctl.
+ * @fw_sub_opcode: generic requests sub opcodes.
  * @pad: Padding to 64 bit.
  */
 struct hl_info_args {
@@ -1274,6 +1277,7 @@ struct hl_info_args {
 		__u32 user_buffer_actual_size;
 		__u32 sec_attest_nonce;
 		__u32 array_size;
+		__u32 fw_sub_opcode;
 	};
 
 	__u32 pad;
-- 
2.25.1

