Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CD605BBDA5
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Sep 2022 13:38:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbiIRLiA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Sep 2022 07:38:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbiIRLhd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Sep 2022 07:37:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DB1524F23
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 04:37:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 19DC16124F
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 11:37:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 890D4C433C1;
        Sun, 18 Sep 2022 11:37:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663501050;
        bh=ylDO5GPx2ThkkNRzAKeVBoJQCPjzwsO7RpIQ+VlBBIM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pAIj3ISk8YiGtfTT87mTeMjfoiMRRyvoAZsuyVi63LQ1rAUyJcAnxEGeT43W723KH
         LFSWNMBjmrAp893XS0TjrSXmKMlnvpfxVE6l2fDzhPjNnLNjDytzuqhhd/Lb0XUcVx
         Gz48m4nhwDm/872SeqPVf6mclyb5I4mrAvk43DGiXvN6wMCOCDe+X1RpTJb+VW3KtV
         qncpWAq74Z86bF+sHBLw32V0BYxRmfD7TObllofmNy9vbV7p6f4b59YEQIk/6uBqSA
         8d8ROJ3pKCgW0NwtoflUvEcjpP+hOXicqv3ZvpU/g32eQLhfXBq3aaLfPcrcRScAlj
         OY5gRl0Oq1ybQ==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Dani Liberman <dliberman@habana.ai>
Subject: [PATCH 7/7] habanalabs/gaudi2: add secured attestation info uapi
Date:   Sun, 18 Sep 2022 14:37:17 +0300
Message-Id: <20220918113717.2637094-7-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220918113717.2637094-1-ogabbay@kernel.org>
References: <20220918113717.2637094-1-ogabbay@kernel.org>
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

User will provide a nonce via the ioctl, and will retrieve
secured attestation data of the boot, generated using given
nonce.

Signed-off-by: Dani Liberman <dliberman@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/firmware_if.c  | 46 +++++++++++
 drivers/misc/habanalabs/common/habanalabs.h   |  3 +
 .../misc/habanalabs/common/habanalabs_ioctl.c | 52 +++++++++++++
 .../misc/habanalabs/include/common/cpucp_if.h | 77 ++++++++++++++++++-
 include/uapi/misc/habanalabs.h                | 43 +++++++++++
 5 files changed, 219 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/habanalabs/common/firmware_if.c b/drivers/misc/habanalabs/common/firmware_if.c
index c2375917fc02..26a7529083e1 100644
--- a/drivers/misc/habanalabs/common/firmware_if.c
+++ b/drivers/misc/habanalabs/common/firmware_if.c
@@ -2988,3 +2988,49 @@ void hl_fw_set_max_power(struct hl_device *hdev)
 	if (rc)
 		dev_err(hdev->dev, "Failed to set max power, error %d\n", rc);
 }
+
+static int hl_fw_get_sec_attest_data(struct hl_device *hdev, u32 packet_id, void *data, u32 size,
+					u32 nonce, u32 timeout)
+{
+	struct cpucp_packet pkt = {};
+	dma_addr_t req_dma_addr;
+	void *req_cpu_addr;
+	int rc;
+
+	req_cpu_addr = hl_cpu_accessible_dma_pool_alloc(hdev, size, &req_dma_addr);
+	if (!data) {
+		dev_err(hdev->dev,
+			"Failed to allocate DMA memory for CPU-CP packet %u\n", packet_id);
+		return -ENOMEM;
+	}
+
+	memset(data, 0, size);
+
+	pkt.ctl = cpu_to_le32(packet_id << CPUCP_PKT_CTL_OPCODE_SHIFT);
+	pkt.addr = cpu_to_le64(req_dma_addr);
+	pkt.data_max_size = cpu_to_le32(size);
+	pkt.nonce = cpu_to_le32(nonce);
+
+	rc = hdev->asic_funcs->send_cpu_message(hdev, (u32 *) &pkt, sizeof(pkt),
+					timeout, NULL);
+	if (rc) {
+		dev_err(hdev->dev,
+			"Failed to handle CPU-CP pkt %u, error %d\n", packet_id, rc);
+		goto out;
+	}
+
+	memcpy(data, req_cpu_addr, size);
+
+out:
+	hl_cpu_accessible_dma_pool_free(hdev, size, req_cpu_addr);
+
+	return rc;
+}
+
+int hl_fw_get_sec_attest_info(struct hl_device *hdev, struct cpucp_sec_attest_info *sec_attest_info,
+				u32 nonce)
+{
+	return hl_fw_get_sec_attest_data(hdev, CPUCP_PACKET_SEC_ATTEST_GET, sec_attest_info,
+					sizeof(struct cpucp_sec_attest_info), nonce,
+					HL_CPUCP_SEC_ATTEST_INFO_TINEOUT_USEC);
+}
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index 259eebdc2f1b..2ffb8378f565 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -66,6 +66,7 @@ struct hl_fpriv;
 #define HL_CPUCP_INFO_TIMEOUT_USEC	10000000 /* 10s */
 #define HL_CPUCP_EEPROM_TIMEOUT_USEC	10000000 /* 10s */
 #define HL_CPUCP_MON_DUMP_TIMEOUT_USEC	10000000 /* 10s */
+#define HL_CPUCP_SEC_ATTEST_INFO_TINEOUT_USEC 10000000 /* 10s */
 
 #define HL_FW_STATUS_POLL_INTERVAL_USEC		10000 /* 10ms */
 #define HL_FW_COMMS_STATUS_PLDM_POLL_INTERVAL_USEC	1000000 /* 1s */
@@ -3750,6 +3751,8 @@ int hl_get_pwm_info(struct hl_device *hdev, int sensor_index, u32 attr, long *va
 void hl_set_pwm_info(struct hl_device *hdev, int sensor_index, u32 attr, long value);
 long hl_fw_get_max_power(struct hl_device *hdev);
 void hl_fw_set_max_power(struct hl_device *hdev);
+int hl_fw_get_sec_attest_info(struct hl_device *hdev, struct cpucp_sec_attest_info *sec_attest_info,
+				u32 nonce);
 int hl_set_voltage(struct hl_device *hdev, int sensor_index, u32 attr, long value);
 int hl_set_current(struct hl_device *hdev, int sensor_index, u32 attr, long value);
 int hl_set_power(struct hl_device *hdev, int sensor_index, u32 attr, long value);
diff --git a/drivers/misc/habanalabs/common/habanalabs_ioctl.c b/drivers/misc/habanalabs/common/habanalabs_ioctl.c
index ab0be082f3a6..43afe40966e5 100644
--- a/drivers/misc/habanalabs/common/habanalabs_ioctl.c
+++ b/drivers/misc/habanalabs/common/habanalabs_ioctl.c
@@ -662,6 +662,55 @@ static int dev_mem_alloc_page_sizes_info(struct hl_fpriv *hpriv, struct hl_info_
 	return copy_to_user(out, &info, min_t(size_t, max_size, sizeof(info))) ? -EFAULT : 0;
 }
 
+static int sec_attest_info(struct hl_fpriv *hpriv, struct hl_info_args *args)
+{
+	void __user *out = (void __user *) (uintptr_t) args->return_pointer;
+	struct cpucp_sec_attest_info *sec_attest_info;
+	struct hl_info_sec_attest *info;
+	u32 max_size = args->return_size;
+	int rc;
+
+	if ((!max_size) || (!out))
+		return -EINVAL;
+
+	sec_attest_info = kmalloc(sizeof(*sec_attest_info), GFP_KERNEL);
+	if (!sec_attest_info)
+		return -ENOMEM;
+
+	info = kmalloc(sizeof(*info), GFP_KERNEL);
+	if (!info) {
+		rc = -ENOMEM;
+		goto free_sec_attest_info;
+	}
+
+	rc = hl_fw_get_sec_attest_info(hpriv->hdev, sec_attest_info, args->sec_attest_nonce);
+	if (rc)
+		goto free_info;
+
+	info->nonce = le32_to_cpu(sec_attest_info->nonce);
+	info->pcr_quote_len = le16_to_cpu(sec_attest_info->pcr_quote_len);
+	info->pub_data_len = le16_to_cpu(sec_attest_info->pub_data_len);
+	info->certificate_len = le16_to_cpu(sec_attest_info->certificate_len);
+	info->pcr_num_reg = sec_attest_info->pcr_num_reg;
+	info->pcr_reg_len = sec_attest_info->pcr_reg_len;
+	info->quote_sig_len = sec_attest_info->quote_sig_len;
+	memcpy(&info->pcr_data, &sec_attest_info->pcr_data, sizeof(info->pcr_data));
+	memcpy(&info->pcr_quote, &sec_attest_info->pcr_quote, sizeof(info->pcr_quote));
+	memcpy(&info->public_data, &sec_attest_info->public_data, sizeof(info->public_data));
+	memcpy(&info->certificate, &sec_attest_info->certificate, sizeof(info->certificate));
+	memcpy(&info->quote_sig, &sec_attest_info->quote_sig, sizeof(info->quote_sig));
+
+	rc = copy_to_user(out, info,
+				min_t(size_t, max_size, sizeof(*info))) ? -EFAULT : 0;
+
+free_info:
+	kfree(info);
+free_sec_attest_info:
+	kfree(sec_attest_info);
+
+	return rc;
+}
+
 static int eventfd_register(struct hl_fpriv *hpriv, struct hl_info_args *args)
 {
 	int rc;
@@ -844,6 +893,9 @@ static int _hl_info_ioctl(struct hl_fpriv *hpriv, void *data,
 	case HL_INFO_DRAM_PENDING_ROWS:
 		return dram_pending_rows_info(hpriv, args);
 
+	case HL_INFO_SECURED_ATTESTATION:
+		return sec_attest_info(hpriv, args);
+
 	case HL_INFO_REGISTER_EVENTFD:
 		return eventfd_register(hpriv, args);
 
diff --git a/drivers/misc/habanalabs/include/common/cpucp_if.h b/drivers/misc/habanalabs/include/common/cpucp_if.h
index 9593d1a26945..baa5aa43b6f4 100644
--- a/drivers/misc/habanalabs/include/common/cpucp_if.h
+++ b/drivers/misc/habanalabs/include/common/cpucp_if.h
@@ -629,6 +629,12 @@ enum pq_init_status {
  * CPUCP_PACKET_ENGINE_CORE_ASID_SET -
  *       Packet to perform engine core ASID configuration
  *
+ * CPUCP_PACKET_SEC_ATTEST_GET -
+ *       Get the attestaion data that is collected during various stages of the
+ *       boot sequence. the attestation data is also hashed with some unique
+ *       number (nonce) provided by the host to prevent replay attacks.
+ *       public key and certificate also provided as part of the FW response.
+ *
  * CPUCP_PACKET_MONITOR_DUMP_GET -
  *       Get monitors registers dump from the CpuCP kernel.
  *       The CPU will put the registers dump in the a buffer allocated by the driver
@@ -691,15 +697,15 @@ enum cpucp_packet_id {
 	CPUCP_PACKET_RESERVED,			/* not used */
 	CPUCP_PACKET_ENGINE_CORE_ASID_SET,	/* internal */
 	CPUCP_PACKET_RESERVED2,			/* not used */
+	CPUCP_PACKET_SEC_ATTEST_GET,		/* internal */
 	CPUCP_PACKET_RESERVED3,			/* not used */
 	CPUCP_PACKET_RESERVED4,			/* not used */
-	CPUCP_PACKET_RESERVED5,			/* not used */
 	CPUCP_PACKET_MONITOR_DUMP_GET,		/* debugfs */
+	CPUCP_PACKET_RESERVED5,			/* not used */
 	CPUCP_PACKET_RESERVED6,			/* not used */
 	CPUCP_PACKET_RESERVED7,			/* not used */
 	CPUCP_PACKET_RESERVED8,			/* not used */
 	CPUCP_PACKET_RESERVED9,			/* not used */
-	CPUCP_PACKET_RESERVED10,		/* not used */
 	CPUCP_PACKET_ACTIVE_STATUS_SET,		/* internal */
 	CPUCP_PACKET_ID_MAX			/* must be last */
 };
@@ -794,6 +800,9 @@ struct cpucp_packet {
 		 * result cannot be used to hold general purpose data.
 		 */
 		__le32 status_mask;
+
+		/* random, used once number, for security packets */
+		__le32 nonce;
 	};
 
 	/* For NIC requests */
@@ -1219,6 +1228,70 @@ enum cpu_reset_status {
 	CPU_RST_STATUS_SOFT_RST_DONE = 1,
 };
 
+#define SEC_PCR_DATA_BUF_SZ	256
+#define SEC_PCR_QUOTE_BUF_SZ	510	/* (512 - 2) 2 bytes used for size */
+#define SEC_SIGNATURE_BUF_SZ	255	/* (256 - 1) 1 byte used for size */
+#define SEC_PUB_DATA_BUF_SZ	510	/* (512 - 2) 2 bytes used for size */
+#define SEC_CERTIFICATE_BUF_SZ	2046	/* (2048 - 2) 2 bytes used for size */
+
+/*
+ * struct cpucp_sec_attest_info - attestation report of the boot
+ * @pcr_data: raw values of the PCR registers
+ * @pcr_num_reg: number of PCR registers in the pcr_data array
+ * @pcr_reg_len: length of each PCR register in the pcr_data array (bytes)
+ * @nonce: number only used once. random number provided by host. this also
+ *	    passed to the quote command as a qualifying data.
+ * @pcr_quote_len: length of the attestation quote data (bytes)
+ * @pcr_quote: attestation report data structure
+ * @quote_sig_len: length of the attestation report signature (bytes)
+ * @quote_sig: signature structure of the attestation report
+ * @pub_data_len: length of the public data (bytes)
+ * @public_data: public key for the signed attestation
+ *		 (outPublic + name + qualifiedName)
+ * @certificate_len: length of the certificate (bytes)
+ * @certificate: certificate for the attestation signing key
+ */
+struct cpucp_sec_attest_info {
+	__u8 pcr_data[SEC_PCR_DATA_BUF_SZ];
+	__u8 pcr_num_reg;
+	__u8 pcr_reg_len;
+	__le16 pad0;
+	__le32 nonce;
+	__le16 pcr_quote_len;
+	__u8 pcr_quote[SEC_PCR_QUOTE_BUF_SZ];
+	__u8 quote_sig_len;
+	__u8 quote_sig[SEC_SIGNATURE_BUF_SZ];
+	__le16 pub_data_len;
+	__u8 public_data[SEC_PUB_DATA_BUF_SZ];
+	__le16 certificate_len;
+	__u8 certificate[SEC_CERTIFICATE_BUF_SZ];
+};
+
+/*
+ * struct cpucp_dev_info_signed - device information signed by a secured device
+ * @info: device information structure as defined above
+ * @nonce: number only used once. random number provided by host. this number is
+ *	   hashed and signed along with the device information.
+ * @info_sig_len: length of the attestation signature (bytes)
+ * @info_sig: signature of the info + nonce data.
+ * @pub_data_len: length of the public data (bytes)
+ * @public_data: public key info signed info data
+ *		 (outPublic + name + qualifiedName)
+ * @certificate_len: length of the certificate (bytes)
+ * @certificate: certificate for the signing key
+ */
+struct cpucp_dev_info_signed {
+	struct cpucp_info info;	/* assumed to be 64bit aligned */
+	__le32 nonce;
+	__le32 pad0;
+	__u8 info_sig_len;
+	__u8 info_sig[SEC_SIGNATURE_BUF_SZ];
+	__le16 pub_data_len;
+	__u8 public_data[SEC_PUB_DATA_BUF_SZ];
+	__le16 certificate_len;
+	__u8 certificate[SEC_CERTIFICATE_BUF_SZ];
+};
+
 /*
  * struct dcore_monitor_regs_data - DCORE monitor regs data.
  * the structure follows sync manager block layout. relevant only to Gaudi.
diff --git a/include/uapi/misc/habanalabs.h b/include/uapi/misc/habanalabs.h
index a4bab0fd8223..e00ebe05097d 100644
--- a/include/uapi/misc/habanalabs.h
+++ b/include/uapi/misc/habanalabs.h
@@ -773,6 +773,7 @@ enum hl_server_type {
  *                            Razwi initiator.
  *                            Razwi cause, was it a page fault or MMU access error.
  * HL_INFO_DEV_MEM_ALLOC_PAGE_SIZES - Retrieve valid page sizes for device memory allocation
+ * HL_INFO_SECURED_ATTESTATION - Retrieve attestation report of the boot.
  * HL_INFO_REGISTER_EVENTFD   - Register eventfd for event notifications.
  * HL_INFO_UNREGISTER_EVENTFD - Unregister eventfd
  * HL_INFO_GET_EVENTS         - Retrieve the last occurred events
@@ -802,6 +803,7 @@ enum hl_server_type {
 #define HL_INFO_CS_TIMEOUT_EVENT		24
 #define HL_INFO_RAZWI_EVENT			25
 #define HL_INFO_DEV_MEM_ALLOC_PAGE_SIZES	26
+#define HL_INFO_SECURED_ATTESTATION		27
 #define HL_INFO_REGISTER_EVENTFD		28
 #define HL_INFO_UNREGISTER_EVENTFD		29
 #define HL_INFO_GET_EVENTS			30
@@ -1133,6 +1135,45 @@ struct hl_info_dev_memalloc_page_sizes {
 	__u64 page_order_bitmask;
 };
 
+#define SEC_PCR_DATA_BUF_SZ	256
+#define SEC_PCR_QUOTE_BUF_SZ	510	/* (512 - 2) 2 bytes used for size */
+#define SEC_SIGNATURE_BUF_SZ	255	/* (256 - 1) 1 byte used for size */
+#define SEC_PUB_DATA_BUF_SZ	510	/* (512 - 2) 2 bytes used for size */
+#define SEC_CERTIFICATE_BUF_SZ	2046	/* (2048 - 2) 2 bytes used for size */
+
+/*
+ * struct hl_info_sec_attest - attestation report of the boot
+ * @nonce: number only used once. random number provided by host. this also passed to the quote
+ *         command as a qualifying data.
+ * @pcr_quote_len: length of the attestation quote data (bytes)
+ * @pub_data_len: length of the public data (bytes)
+ * @certificate_len: length of the certificate (bytes)
+ * @pcr_num_reg: number of PCR registers in the pcr_data array
+ * @pcr_reg_len: length of each PCR register in the pcr_data array (bytes)
+ * @quote_sig_len: length of the attestation report signature (bytes)
+ * @pcr_data: raw values of the PCR registers
+ * @pcr_quote: attestation report data structure
+ * @quote_sig: signature structure of the attestation report
+ * @public_data: public key for the signed attestation
+ *		 (outPublic + name + qualifiedName)
+ * @certificate: certificate for the attestation signing key
+ */
+struct hl_info_sec_attest {
+	__u32 nonce;
+	__u16 pcr_quote_len;
+	__u16 pub_data_len;
+	__u16 certificate_len;
+	__u8 pcr_num_reg;
+	__u8 pcr_reg_len;
+	__u8 quote_sig_len;
+	__u8 pcr_data[SEC_PCR_DATA_BUF_SZ];
+	__u8 pcr_quote[SEC_PCR_QUOTE_BUF_SZ];
+	__u8 quote_sig[SEC_SIGNATURE_BUF_SZ];
+	__u8 public_data[SEC_PUB_DATA_BUF_SZ];
+	__u8 certificate[SEC_CERTIFICATE_BUF_SZ];
+	__u8 pad0[2];
+};
+
 enum gaudi_dcores {
 	HL_GAUDI_WS_DCORE,
 	HL_GAUDI_WN_DCORE,
@@ -1158,6 +1199,7 @@ enum gaudi_dcores {
  *                           driver. It is possible for the user to allocate buffer larger than
  *                           needed, hence updating this variable so user will know the exact amount
  *                           of bytes copied by the kernel to the buffer.
+ * @sec_attest_nonce: Nonce number used for attestation report.
  * @pad: Padding to 64 bit.
  */
 struct hl_info_args {
@@ -1172,6 +1214,7 @@ struct hl_info_args {
 		__u32 pll_index;
 		__u32 eventfd;
 		__u32 user_buffer_actual_size;
+		__u32 sec_attest_nonce;
 	};
 
 	__u32 pad;
-- 
2.25.1

