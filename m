Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9F156F5A3C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 16:38:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbjECOic (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 10:38:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbjECOia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 10:38:30 -0400
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 565E961B2;
        Wed,  3 May 2023 07:38:26 -0700 (PDT)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 343EAxtw032370;
        Wed, 3 May 2023 07:38:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=pfpt0220; bh=GV0dgBPLF4cwsgyf5x0qGgyGRlL7zBSYZfgOKHEMyFU=;
 b=YMC9d8rOqkzXCK909t4cPACfO0ufGljrLsghQuGLrXu6weaR0mFJ9gkEROgqGCw0ODux
 DlyY2Rd/1kFo52K5u0Cyadoo8xVDgZqOCpQg1XmLy/K1OBBLhndIuZcZHK1+EWuS05fQ
 whN8PXJsnEVO3ArJPgqMfoBSIinmGunk2anjgEbpHZritLRgKTzfa/4Ko97qEKtDZzqE
 NSX2eU5jFORJW/AL8Da1upRdRGN0rIr7i88Q1jcCYslod7NgCAYkl4p2zP55xItlKc2g
 6eX+BdkPFSgQJGmWvq9ddZpiaYgn22q/bdxlumebhAac1c4/Y5WWxLQtu5ZlEU0jWRMG mg== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3q92rp4r2y-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 03 May 2023 07:38:04 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Wed, 3 May
 2023 07:38:02 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Wed, 3 May 2023 07:38:02 -0700
Received: from localhost.localdomain (unknown [10.110.150.250])
        by maili.marvell.com (Postfix) with ESMTP id 7AD853F7065;
        Wed,  3 May 2023 07:38:02 -0700 (PDT)
From:   Piyush Malgujar <pmalgujar@marvell.com>
To:     <linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <dan.j.williams@intel.com>, <xueshuai@linux.alibaba.com>,
        <jaylu102@amd.com>, <benjamin.cheatham@amd.com>, <bp@alien8.de>,
        <tony.luck@intel.com>, <james.morse@arm.com>, <lenb@kernel.org>,
        <rafael@kernel.org>
CC:     <jannadurai@marvell.com>, <cchavva@marvell.com>,
        Piyush Malgujar <pmalgujar@marvell.com>
Subject: [PATCH] ACPI: APEI: EINJ: EINJV2 support added
Date:   Wed, 3 May 2023 07:37:59 -0700
Message-ID: <20230503143759.10485-1-pmalgujar@marvell.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: lee1DzXC1kXTJD51HYSuosgNr6VxNFy4
X-Proofpoint-GUID: lee1DzXC1kXTJD51HYSuosgNr6VxNFy4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-03_10,2023-05-03_01,2023-02-09_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added changes to support EINJV2 from ACPI V6.5. This adds
new additional actions: EINJV2_SET_ERROR_TYPE and
EINJV2_GET_ERROR_TYPE which supports PCIe,processor and
memory error for single component syndrome.

Signed-off-by: Piyush Malgujar <pmalgujar@marvell.com>
---
 drivers/acpi/apei/einj.c | 172 +++++++++++++++++++++++++++++++++++----
 include/acpi/actbl1.h    |   4 +-
 2 files changed, 157 insertions(+), 19 deletions(-)

diff --git a/drivers/acpi/apei/einj.c b/drivers/acpi/apei/einj.c
index 013eb621dc92a7c11b00577a890c06fc64453a2c..97f87ad125af79b2a6f73c0741f728cb9c799992 100644
--- a/drivers/acpi/apei/einj.c
+++ b/drivers/acpi/apei/einj.c
@@ -32,6 +32,7 @@
 #define SLEEP_UNIT_MAX		5000			/* 5ms */
 /* Firmware should respond within 1 seconds */
 #define FIRMWARE_TIMEOUT	(1 * USEC_PER_SEC)
+#define ACPI65_EINJV2_SUPP	BIT(30)
 #define ACPI5_VENDOR_BIT	BIT(31)
 #define MEM_ERROR_MASK		(ACPI_EINJ_MEMORY_CORRECTABLE | \
 				ACPI_EINJ_MEMORY_UNCORRECTABLE | \
@@ -42,6 +43,51 @@
  */
 static int acpi5;
 
+/*
+ * ACPI version 6.5 provides a EINJV2_SET_ERROR_TYPE action.
+ */
+static int einjv2_supp;
+
+struct syndrome_array {
+	union {
+		u32	acpi_id;
+		u32	device_id;
+		u32	pcie_sbdf;
+		u8	fru_id[16];
+	} comp_id;
+	union {
+		u32	proc_synd;
+		u32	mem_synd;
+		u32	pcie_synd;
+		u8	vendor_synd[16];
+	} comp_synd;
+};
+
+struct einjv2_set_error_type {
+	u32	type;
+	u8	type_code;
+	u8	flags[3];
+	u32	length;
+	u32	severity;
+	u64	memory_address;
+	u64	memory_address_range;
+	u32	syndrome_count;
+	struct	syndrome_array array[0];
+};
+
+enum {
+	EINJV2_PROCESSOR_ERROR = 0x1,
+	EINJV2_MEMORY_ERROR = 0x2,
+	EINJV2_PCIE_ERROR = 0x4,
+};
+
+enum {
+	EINJV2_FLAG_ADD_VALID = 0x1,
+	EINJV2_FLAG_ADD_RANGE_VALID = 0x2,
+	EINJV2_FLAG_SEVERITY_VALID = 0x4,
+	EINJV2_FLAG_COMP_VALID = 0x8,
+};
+
 struct set_error_type_with_address {
 	u32	type;
 	u32	vendor_extension;
@@ -155,6 +201,13 @@ static int __einj_get_available_error_type(u32 *type)
 		return rc;
 	*type = apei_exec_ctx_get_output(&ctx);
 
+	if (*type & ACPI65_EINJV2_SUPP) {
+		rc = apei_exec_run(&ctx, ACPI_EINJV2_GET_ERROR_TYPE);
+		if (rc)
+			return rc;
+		*type = apei_exec_ctx_get_output(&ctx);
+	}
+
 	return 0;
 }
 
@@ -205,7 +258,7 @@ static void check_vendor_extension(u64 paddr,
 static void *einj_get_parameter_address(void)
 {
 	int i;
-	u64 pa_v4 = 0, pa_v5 = 0;
+	u64 pa_v4 = 0, pa_v5 = 0, pa_v65 = 0;
 	struct acpi_whea_header *entry;
 
 	entry = EINJ_TAB_ENTRY(einj_tab);
@@ -220,8 +273,22 @@ static void *einj_get_parameter_address(void)
 		    entry->register_region.space_id ==
 		    ACPI_ADR_SPACE_SYSTEM_MEMORY)
 			pa_v5 = get_unaligned(&entry->register_region.address);
+		if (entry->action == ACPI_EINJV2_SET_ERROR_TYPE &&
+		    entry->instruction == ACPI_EINJ_WRITE_REGISTER &&
+		    entry->register_region.space_id ==
+		    ACPI_ADR_SPACE_SYSTEM_MEMORY)
+			pa_v65 = get_unaligned(&entry->register_region.address);
 		entry++;
 	}
+	if (pa_v65) {
+		struct einjv2_set_error_type *v65param;
+
+		v65param = acpi_os_map_iomem(pa_v65, sizeof(*v65param));
+		if (v65param) {
+			einjv2_supp = 1;
+			return v65param;
+		}
+	}
 	if (pa_v5) {
 		struct set_error_type_with_address *v5param;
 
@@ -356,7 +423,9 @@ static int __einj_error_trigger(u64 trigger_paddr, u32 type,
 	 * This will cause resource conflict with regular memory.  So
 	 * remove it from trigger table resources.
 	 */
-	if ((param_extension || acpi5) && (type & MEM_ERROR_MASK) && param2) {
+	if ((param_extension || acpi5 || einjv2_supp) &&
+	    ((einjv2_supp && (type & EINJV2_MEMORY_ERROR)) ||
+	     type & MEM_ERROR_MASK) && param2) {
 		struct apei_resources addr_resources;
 
 		apei_resources_init(&addr_resources);
@@ -402,7 +471,7 @@ static int __einj_error_trigger(u64 trigger_paddr, u32 type,
 }
 
 static int __einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
-			       u64 param3, u64 param4)
+			       u64 param3, u64 param4, u64 param5)
 {
 	struct apei_exec_context ctx;
 	u64 val, trigger_paddr, timeout = FIRMWARE_TIMEOUT;
@@ -414,7 +483,46 @@ static int __einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
 	if (rc)
 		return rc;
 	apei_exec_ctx_set_input(&ctx, type);
-	if (acpi5) {
+
+	if (einjv2_supp) {
+		struct einjv2_set_error_type *v65param = einj_param;
+
+		v65param->type = type;
+		v65param->flags[0] = flags;
+
+		if (v65param->flags[0] & EINJV2_FLAG_COMP_VALID) {
+			switch (v65param->type) {
+			case EINJV2_PROCESSOR_ERROR:
+				v65param->array[0].comp_id.acpi_id = param1;
+				v65param->array[0].comp_synd.proc_synd = param2;
+				break;
+			case EINJV2_MEMORY_ERROR:
+				v65param->array[0].comp_id.device_id = param3;
+				v65param->array[0].comp_synd.mem_synd = param4;
+				break;
+			case EINJV2_PCIE_ERROR:
+				v65param->array[0].comp_id.pcie_sbdf = param1;
+				v65param->array[0].comp_synd.pcie_synd = param2;
+				break;
+			}
+		}
+
+		if (v65param->type & EINJV2_MEMORY_ERROR) {
+			if (v65param->flags[0] & EINJV2_FLAG_ADD_VALID)
+				v65param->memory_address = param1;
+			if (v65param->flags[0] & EINJV2_FLAG_ADD_RANGE_VALID)
+				v65param->memory_address_range = param2;
+			if (v65param->flags[0] & EINJV2_FLAG_SEVERITY_VALID)
+				v65param->severity = param5;
+		} else {
+			if (v65param->flags[0] & EINJV2_FLAG_SEVERITY_VALID)
+				v65param->severity = param3;
+		}
+		v65param->syndrome_count = 1;
+		v65param->length = sizeof(struct einjv2_set_error_type) +
+				  ((v65param->syndrome_count) *
+				  sizeof(struct syndrome_array));
+	} else if (acpi5) {
 		struct set_error_type_with_address *v5param = einj_param;
 
 		v5param->type = type;
@@ -514,15 +622,23 @@ static int __einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
 
 /* Inject the specified hardware error */
 static int einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
-			     u64 param3, u64 param4)
+			     u64 param3, u64 param4, u64 param5)
 {
 	int rc;
 	u64 base_addr, size;
 
 	/* If user manually set "flags", make sure it is legal */
-	if (flags && (flags &
-		~(SETWA_FLAGS_APICID|SETWA_FLAGS_MEM|SETWA_FLAGS_PCIE_SBDF)))
-		return -EINVAL;
+	if (einjv2_supp) {
+		if (flags && (flags &
+			~(EINJV2_FLAG_ADD_VALID | EINJV2_FLAG_ADD_RANGE_VALID |
+			  EINJV2_FLAG_SEVERITY_VALID | EINJV2_FLAG_COMP_VALID)))
+			return -EINVAL;
+	} else {
+		if (flags && (flags &
+			~(SETWA_FLAGS_APICID | SETWA_FLAGS_MEM |
+			  SETWA_FLAGS_PCIE_SBDF)))
+			return -EINVAL;
+	}
 
 	/*
 	 * We need extra sanity checks for memory errors.
@@ -530,11 +646,13 @@ static int einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
 	 */
 
 	/* ensure param1/param2 existed */
-	if (!(param_extension || acpi5))
+	if (!(param_extension || acpi5 || einjv2_supp))
 		goto inject;
 
 	/* ensure injection is memory related */
-	if (type & ACPI5_VENDOR_BIT) {
+	if (einjv2_supp && !(type & EINJV2_MEMORY_ERROR)) {
+		goto inject;
+	} else if (type & ACPI5_VENDOR_BIT) {
 		if (vendor_flags != SETWA_FLAGS_MEM)
 			goto inject;
 	} else if (!(type & MEM_ERROR_MASK) && !(flags & SETWA_FLAGS_MEM))
@@ -564,7 +682,7 @@ static int einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
 
 inject:
 	mutex_lock(&einj_mutex);
-	rc = __einj_error_inject(type, flags, param1, param2, param3, param4);
+	rc = __einj_error_inject(type, flags, param1, param2, param3, param4, param5);
 	mutex_unlock(&einj_mutex);
 
 	return rc;
@@ -576,7 +694,15 @@ static u64 error_param1;
 static u64 error_param2;
 static u64 error_param3;
 static u64 error_param4;
+static u64 error_param5;
 static struct dentry *einj_debug_dir;
+
+static const char * const einjv2_error_type_string[] = {
+	"0x00000001\tEINJV2 Processor Error\n",
+	"0x00000002\tEINJV2 Memory Error\n",
+	"0x00000004\tEINJV2 PCI Express Error\n",
+};
+
 static const char * const einj_error_type_string[] = {
 	"0x00000001\tProcessor Correctable\n",
 	"0x00000002\tProcessor Uncorrectable non-fatal\n",
@@ -600,15 +726,22 @@ static const char * const einj_error_type_string[] = {
 
 static int available_error_type_show(struct seq_file *m, void *v)
 {
-	int rc;
+	int rc, pos;
 	u32 available_error_type = 0;
 
 	rc = einj_get_available_error_type(&available_error_type);
 	if (rc)
 		return rc;
-	for (int pos = 0; pos < ARRAY_SIZE(einj_error_type_string); pos++)
-		if (available_error_type & BIT(pos))
-			seq_puts(m, einj_error_type_string[pos]);
+
+	if (einjv2_supp) {
+		for (pos = 0; pos < ARRAY_SIZE(einjv2_error_type_string); pos++)
+			if (available_error_type & BIT(pos))
+				seq_puts(m, einjv2_error_type_string[pos]);
+	} else {
+		for (pos = 0; pos < ARRAY_SIZE(einj_error_type_string); pos++)
+			if (available_error_type & BIT(pos))
+				seq_puts(m, einj_error_type_string[pos]);
+	}
 
 	return 0;
 }
@@ -662,8 +795,9 @@ static int error_inject_set(void *data, u64 val)
 	if (!error_type)
 		return -EINVAL;
 
-	return einj_error_inject(error_type, error_flags, error_param1, error_param2,
-		error_param3, error_param4);
+	return einj_error_inject(error_type, error_flags, error_param1,
+				 error_param2, error_param3, error_param4,
+				 error_param5);
 }
 
 DEFINE_DEBUGFS_ATTRIBUTE(error_inject_fops, NULL, error_inject_set, "%llu\n");
@@ -743,7 +877,7 @@ static int __init einj_init(void)
 	}
 
 	einj_param = einj_get_parameter_address();
-	if ((param_extension || acpi5) && einj_param) {
+	if ((param_extension || acpi5 || einjv2_supp) && einj_param) {
 		debugfs_create_x32("flags", S_IRUSR | S_IWUSR, einj_debug_dir,
 				   &error_flags);
 		debugfs_create_x64("param1", S_IRUSR | S_IWUSR, einj_debug_dir,
@@ -754,6 +888,8 @@ static int __init einj_init(void)
 				   &error_param3);
 		debugfs_create_x64("param4", S_IRUSR | S_IWUSR, einj_debug_dir,
 				   &error_param4);
+		debugfs_create_x64("param5", S_IRUSR | S_IWUSR, einj_debug_dir,
+				   &error_param5);
 		debugfs_create_x32("notrigger", S_IRUSR | S_IWUSR,
 				   einj_debug_dir, &notrigger);
 	}
diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
index 58b0490a2ad12e26cab30209e461429a1f5dec30..de89c18f3443489683c9aafaf6a894e60d98374b 100644
--- a/include/acpi/actbl1.h
+++ b/include/acpi/actbl1.h
@@ -1026,7 +1026,9 @@ enum acpi_einj_actions {
 	ACPI_EINJ_GET_COMMAND_STATUS = 7,
 	ACPI_EINJ_SET_ERROR_TYPE_WITH_ADDRESS = 8,
 	ACPI_EINJ_GET_EXECUTE_TIMINGS = 9,
-	ACPI_EINJ_ACTION_RESERVED = 10,	/* 10 and greater are reserved */
+	ACPI_EINJV2_SET_ERROR_TYPE = 0x10,
+	ACPI_EINJV2_GET_ERROR_TYPE = 0x11,
+	ACPI_EINJ_ACTION_RESERVED = 0x12, /* 12 and greater are reserved */
 	ACPI_EINJ_TRIGGER_ERROR = 0xFF	/* Except for this value */
 };
 
-- 
2.17.1

