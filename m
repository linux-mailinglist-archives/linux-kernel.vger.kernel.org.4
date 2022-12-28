Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56B85657FC3
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 17:09:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234479AbiL1QIQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 11:08:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234386AbiL1QHk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 11:07:40 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD95011A33
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 08:07:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4CEFB6155B
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 16:07:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17AE3C433F0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 16:07:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672243658;
        bh=3Tg3cBkYrva227v6UWb3BQjuxMuOPbVDQ8QJQs+S92w=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=ARtv6LumjX8kBsQCNwXSIu5HVQmFzkDGM9rUepxyyYyJj0V4xHQtZzRm7YFNjtNXK
         inMrZ8RXlEOqtMyQhP8sts0oH7abxZBHoi1e5JHJqi2AOzpaD3GG3CdKz7AjiMnLcU
         GLELOdfZ412X/osNs8wIAGxAWLNyGFoUt37hx7HfZeRlFKjWiMfPOAdoIsQhhc0f9f
         +bShQvnhP00VIwaFi/KrQU5vGEhM8yPggN7wfs5CDcCcVNCsUK0eoEcFg8ccIJInKO
         DS48V2EXn46y+AvU18021mXbduDImEsAJHxveJtbUsMBcwESPf2H0VSDZd0pCIVLhw
         UA2hdAYYVqU2A==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 5/9] habanalabs: update f/w files
Date:   Wed, 28 Dec 2022 18:07:19 +0200
Message-Id: <20221228160723.387-5-ogabbay@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221228160723.387-1-ogabbay@kernel.org>
References: <20221228160723.387-1-ogabbay@kernel.org>
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

Update common firmware files with the latest version.
There is no functional change.

Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 .../habanalabs/include/common/cpucp_if.h      |  33 ++++--
 .../habanalabs/include/common/hl_boot_if.h    | 101 ++++++++++++++++++
 2 files changed, 127 insertions(+), 7 deletions(-)

diff --git a/drivers/accel/habanalabs/include/common/cpucp_if.h b/drivers/accel/habanalabs/include/common/cpucp_if.h
index 0a66b7f85164..d713252a4f13 100644
--- a/drivers/accel/habanalabs/include/common/cpucp_if.h
+++ b/drivers/accel/habanalabs/include/common/cpucp_if.h
@@ -344,6 +344,16 @@ struct hl_eq_engine_arc_intr_data {
 	__le64 pad[5];
 };
 
+#define ADDR_DEC_ADDRESS_COUNT_MAX 4
+
+/* Data structure specifies details of ADDR_DEC interrupt */
+struct hl_eq_addr_dec_intr_data {
+	struct hl_eq_intr_cause intr_cause;
+	__le64 addr[ADDR_DEC_ADDRESS_COUNT_MAX];
+	__u8 addr_cnt;
+	__u8 pad[7];
+};
+
 struct hl_eq_entry {
 	struct hl_eq_header hdr;
 	union {
@@ -358,6 +368,7 @@ struct hl_eq_entry {
 		struct hl_eq_razwi_with_intr_cause razwi_with_intr_cause;
 		struct hl_eq_hbm_sei_data sei_data;	/* Gaudi2 HBM */
 		struct hl_eq_engine_arc_intr_data arc_data;
+		struct hl_eq_addr_dec_intr_data addr_dec;
 		__le64 data[7];
 	};
 };
@@ -643,7 +654,7 @@ enum pq_init_status {
  *       data corruption in case of mismatched driver/FW versions.
  *       Relevant only to Gaudi.
  *
- * * CPUCP_PACKET_GENERIC_PASSTHROUGH -
+ * CPUCP_PACKET_GENERIC_PASSTHROUGH -
  *      Generic opcode for all firmware info that is only passed to host
  *      through the LKD, without getting parsed there.
  *
@@ -734,6 +745,11 @@ enum cpucp_packet_id {
 #define CPUCP_PKT_RES_PLL_OUT3_SHIFT	48
 #define CPUCP_PKT_RES_PLL_OUT3_MASK	0xFFFF000000000000ull
 
+#define CPUCP_PKT_RES_EEPROM_OUT0_SHIFT	0
+#define CPUCP_PKT_RES_EEPROM_OUT0_MASK	0x000000000000FFFFull
+#define CPUCP_PKT_RES_EEPROM_OUT1_SHIFT	16
+#define CPUCP_PKT_RES_EEPROM_OUT1_MASK	0x0000000000FF0000ull
+
 #define CPUCP_PKT_VAL_PFC_IN1_SHIFT	0
 #define CPUCP_PKT_VAL_PFC_IN1_MASK	0x0000000000000001ull
 #define CPUCP_PKT_VAL_PFC_IN2_SHIFT	1
@@ -893,7 +909,9 @@ enum cpucp_in_attributes {
 	cpucp_in_max,
 	cpucp_in_lowest = 6,
 	cpucp_in_highest = 7,
-	cpucp_in_reset_history
+	cpucp_in_reset_history,
+	cpucp_in_intr_alarm_a,
+	cpucp_in_intr_alarm_b,
 };
 
 enum cpucp_curr_attributes {
@@ -1333,6 +1351,7 @@ struct cpucp_dev_info_signed {
 	__u8 certificate[SEC_CERTIFICATE_BUF_SZ];
 };
 
+#define DCORE_MON_REGS_SZ	512
 /*
  * struct dcore_monitor_regs_data - DCORE monitor regs data.
  * the structure follows sync manager block layout. relevant only to Gaudi.
@@ -1343,11 +1362,11 @@ struct cpucp_dev_info_signed {
  * @mon_status: array of monitor status.
  */
 struct dcore_monitor_regs_data {
-	__le32 mon_pay_addrl[512];
-	__le32 mon_pay_addrh[512];
-	__le32 mon_pay_data[512];
-	__le32 mon_arm[512];
-	__le32 mon_status[512];
+	__le32 mon_pay_addrl[DCORE_MON_REGS_SZ];
+	__le32 mon_pay_addrh[DCORE_MON_REGS_SZ];
+	__le32 mon_pay_data[DCORE_MON_REGS_SZ];
+	__le32 mon_arm[DCORE_MON_REGS_SZ];
+	__le32 mon_status[DCORE_MON_REGS_SZ];
 };
 
 /* contains SM data for each SYNC_MNGR (relevant only to Gaudi) */
diff --git a/drivers/accel/habanalabs/include/common/hl_boot_if.h b/drivers/accel/habanalabs/include/common/hl_boot_if.h
index 370e62d0a96a..2256add057c5 100644
--- a/drivers/accel/habanalabs/include/common/hl_boot_if.h
+++ b/drivers/accel/habanalabs/include/common/hl_boot_if.h
@@ -40,6 +40,19 @@ enum cpu_boot_err {
 	CPU_BOOT_ERR_LAST = 64 /* we have 2 registers of 32 bits */
 };
 
+/*
+ * Mask for fatal failures
+ * This mask contains all possible fatal failures, and a dynamic code
+ * will clear the non-relevant ones.
+ */
+#define CPU_BOOT_ERR_FATAL_MASK					\
+		((1 << CPU_BOOT_ERR_DRAM_INIT_FAIL) |		\
+		 (1 << CPU_BOOT_ERR_PLL_FAIL) |			\
+		 (1 << CPU_BOOT_ERR_DEVICE_UNUSABLE_FAIL) |	\
+		 (1 << CPU_BOOT_ERR_BINNING_FAIL) |		\
+		 (1 << CPU_BOOT_ERR_DRAM_SKIPPED) |		\
+		 (1 << CPU_BOOT_ERR_EEPROM_FAIL))
+
 /*
  * CPU error bits in BOOT_ERROR registers
  *
@@ -731,4 +744,92 @@ struct comms_status {
 	};
 };
 
+/**
+ * HL_MODULES_MAX_NUM is determined by the size of modules_mask in struct
+ *      hl_component_versions
+ */
+enum hl_modules {
+	HL_MODULES_BOOT_INFO = 0,
+	HL_MODULES_EEPROM,
+	HL_MODULES_FDT,
+	HL_MODULES_I2C,
+	HL_MODULES_LZ4,
+	HL_MODULES_MBEDTLS,
+	HL_MODULES_MAX_NUM = 16
+};
+
+/**
+ * HL_COMPONENTS_MAX_NUM is determined by the size of components_mask in
+ *      struct cpucp_versions
+ */
+enum hl_components {
+	HL_COMPONENTS_PID = 0,
+	HL_COMPONENTS_MGMT,
+	HL_COMPONENTS_PREBOOT,
+	HL_COMPONENTS_PPBOOT,
+	HL_COMPONENTS_ARMCP,
+	HL_COMPONENTS_CPLD,
+	HL_COMPONENTS_UBOOT,
+	HL_COMPONENTS_MAX_NUM = 16
+};
+
+/**
+ * struct hl_component_versions - versions associated with hl component.
+ * @struct_size: size of all the struct (including dynamic size of modules).
+ * @modules_offset: offset of the modules field in this struct.
+ * @component: version of the component itself.
+ * @fw_os: Firmware OS Version.
+ * @modules_mask: i'th bit (from LSB) is a flag - on if module i in enum
+ *              hl_modules is used.
+ * @modules_counter: number of set bits in modules_mask.
+ * @reserved: reserved for future use.
+ * @modules: versions of the component's modules. Elborated explanation in
+ *              struct cpucp_versions.
+ */
+struct hl_component_versions {
+	__le16 struct_size;
+	__le16 modules_offset;
+	__u8 component[VERSION_MAX_LEN];
+	__u8 fw_os[VERSION_MAX_LEN];
+	__le16 modules_mask;
+	__u8 modules_counter;
+	__u8 reserved[1];
+	__u8 modules[][VERSION_MAX_LEN];
+};
+
+/**
+ * struct hl_fw_versions - all versions (fuse, cpucp's components with their
+ *              modules)
+ * @struct_size: size of all the struct (including dynamic size of components).
+ * @components_offset: offset of the components field in this struct.
+ * @fuse: silicon production FUSE information.
+ * @components_mask: i'th bit (from LSB) is a flag - on if component i in enum
+ *              hl_components is used.
+ * @components_counter: number of set bits in components_mask.
+ * @reserved: reserved for future use.
+ * @components: versions of hl components. Index i corresponds to the i'th bit
+ *              that is *on* in components_mask. For example, if
+ *              components_mask=0b101, then *components represents arcpid and
+ *              *(hl_component_versions*)((char*)components + 1') represents
+ *              preboot, where 1' = components[0].struct_size.
+ */
+struct hl_fw_versions {
+	__le16 struct_size;
+	__le16 components_offset;
+	__u8 fuse[VERSION_MAX_LEN];
+	__le16 components_mask;
+	__u8 components_counter;
+	__u8 reserved[1];
+	struct hl_component_versions components[];
+};
+
+/* Max size of struct hl_component_versions */
+#define HL_COMPONENT_VERSIONS_MAX_SIZE \
+	(sizeof(struct hl_component_versions) + HL_MODULES_MAX_NUM * \
+	 VERSION_MAX_LEN)
+
+/* Max size of struct hl_fw_versions */
+#define HL_FW_VERSIONS_MAX_SIZE (sizeof(struct hl_fw_versions) + \
+		HL_COMPONENTS_MAX_NUM * HL_COMPONENT_VERSIONS_MAX_SIZE)
+
 #endif /* HL_BOOT_IF_H */
-- 
2.34.1

