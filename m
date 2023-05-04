Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F3DC6F6CFA
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 15:33:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230426AbjEDNdb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 09:33:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbjEDNd3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 09:33:29 -0400
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24DBE99;
        Thu,  4 May 2023 06:33:27 -0700 (PDT)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 344CEEvT024287;
        Thu, 4 May 2023 06:32:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=pfpt0220; bh=Rhzjf2FWYgzw4Bd6WtOqN1IFmnEnYlTy669BgkwQACI=;
 b=d38f5JYDuyYmi0ZI93qkPGK/G2YWJT2mWGY0Ab6N9hai7F3I3wBuj+p71tL7/gN0nht8
 84bKNcsb3zqNoSNpNGkTKpWcKR6hY+hYQI6y7lb2XP9rxFdfDsbsXB5wUzfZgf4TBVcX
 6LdhWAgnq74TusL8NpyVY8eDXmP37DZCP+Db0/HkkOVBMdDmlDxuQr4zCFqfHO1nwbLl
 i23cWcql26PiSYHDyAeodCxZAyXmM0yiciL8O8GzXgQZokypnAbJJCN5ytFrUYZi8B8A
 umbqJdMZBVUIpMdU5enY9qVZ5M0jG+KwPdYN1YGzJq0Rsta3EnWN6Sw+gmpilmbEflLD sQ== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3qc0ne9yxc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 04 May 2023 06:32:28 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Thu, 4 May
 2023 06:32:26 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Thu, 4 May 2023 06:32:26 -0700
Received: from localhost.localdomain (unknown [10.110.150.250])
        by maili.marvell.com (Postfix) with ESMTP id BC8BD3F706F;
        Thu,  4 May 2023 06:32:26 -0700 (PDT)
From:   Piyush Malgujar <pmalgujar@marvell.com>
To:     <linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <dan.j.williams@intel.com>, <xueshuai@linux.alibaba.com>,
        <jaylu102@amd.com>, <benjamin.cheatham@amd.com>, <bp@alien8.de>,
        <tony.luck@intel.com>, <james.morse@arm.com>, <lenb@kernel.org>,
        <rafael@kernel.org>
CC:     <jannadurai@marvell.com>, <cchavva@marvell.com>,
        Piyush Malgujar <pmalgujar@marvell.com>
Subject: [PATCH v2] ACPI: APEI: EINJ: EINJV2 support added
Date:   Thu, 4 May 2023 06:32:24 -0700
Message-ID: <20230504133224.2669-1-pmalgujar@marvell.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: WLVuU4EhUVtNc2sBstEIokhE-lWym15Z
X-Proofpoint-ORIG-GUID: WLVuU4EhUVtNc2sBstEIokhE-lWym15Z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-04_09,2023-05-04_01,2023-02-09_01
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
v1 ---> v2
- Added EINJ V2 details in einj.rst document.
---
 .../firmware-guide/acpi/apei/einj.rst         |  54 ++++++
 drivers/acpi/apei/einj.c                      | 172 ++++++++++++++++--
 include/acpi/actbl1.h                         |   4 +-
 3 files changed, 211 insertions(+), 19 deletions(-)

diff --git a/Documentation/firmware-guide/acpi/apei/einj.rst b/Documentation/firmware-guide/acpi/apei/einj.rst
index d6b61d22f52584a66f5f8aed51b0a9ce0d93c2d6..6e8640e7c0462c05b363d8f145e4c068ad98a7e7 100644
--- a/Documentation/firmware-guide/acpi/apei/einj.rst
+++ b/Documentation/firmware-guide/acpi/apei/einj.rst
@@ -57,6 +57,15 @@ The following files belong to it:
   0x00000800        Platform Uncorrectable fatal
   ================  ===================================
 
+  If EINJV2 is supported, this file shows which error types are for it:
+
+  ================  ===================================
+  Error Type Value	Error Description
+  ================  ===================================
+  0x00000001        EINJV2 Processor Error
+  0x00000002        EINJV2 Memory Error
+  0x00000004        EINJV2 PCI Express Error
+
   The format of the file contents are as above, except present are only
   the available error types.
 
@@ -88,6 +97,17 @@ The following files belong to it:
   If set to zero, legacy behavior is mimicked where the type of
   injection specifies just one bit set, and param1 is multiplexed.
 
+  EINJ V2 flags are detailed as per ACPI6.5 spec:
+
+    Bit 0
+      Address Valid
+    Bit 1
+      Address Range Valid
+    Bit 2
+      Severity Valid
+    Bit 3
+      Component Syndrome Count and Array is valid
+
 - param1
 
   This file is used to set the first error parameter value. Its effect
@@ -95,19 +115,37 @@ The following files belong to it:
   error type is memory related type, the param1 should be a valid
   physical memory address. [Unless "flag" is set - see above]
 
+  EINJ V2:
+    This depends upon error type specified in error_type. It can be
+    memory address/ACPI ID/PCIE SBDF.
+
 - param2
 
   Same use as param1 above. For example, if error type is of memory
   related type, then param2 should be a physical memory address mask.
   Linux requires page or narrower granularity, say, 0xfffffffffffff000.
 
+  EINJ V2:
+    Based on error type, this can be memory address range or processor/
+    PCIe syndrome which is vendor specific.
+
 - param3
 
   Used when the 0x1 bit is set in "flags" to specify the APIC id
 
+  EINJ V2:
+    For memory error, this will be device ID, for other type of errors,
+    this represents severity.
+
 - param4
   Used when the 0x4 bit is set in "flags" to specify target PCIe device
 
+  EINJ V2:
+    For memory error, this represents memory syndrome.
+
+- param5
+  For memory error, this represent the severity.
+
 - notrigger
 
   The error injection mechanism is a two-step process. First inject the
@@ -181,6 +219,22 @@ You should see something like this in dmesg::
   [22715.834759] EDAC sbridge MC3: PROCESSOR 0:306e7 TIME 1422553404 SOCKET 0 APIC 0
   [22716.616173] EDAC MC3: 1 CE memory read error on CPU_SrcID#0_Channel#0_DIMM#0 (channel:0 slot:0 page:0x12345 offset:0x0 grain:32 syndrome:0x0 -  area:DRAM err_code:0001:0090 socket:0 channel_mask:1 rank:0)
 
+ACPI 6.5 spec introduces two new error injection action: EINJV2_GET_ERROR_TYPE and EINJV2_SET_ERROR_TYPE.
+EINJv2 breaks out the Error Type from the severity.
+
+An error injection example::
+
+  # cd /sys/kernel/debug/apei/einj
+  # cat available_error_type		# See which errors can be injected
+  0x00000001	EINJV2 Processor Error
+  0x00000002	EINJV2 Memory Error
+  0x00000004	EINJV2 PCI Express Error
+  # echo 0x2 > error_type
+  # echo 0x5 > flags
+  # echo 0x12345000 > param1
+  # echo 0x2 > param5
+  # echo 1 > error_inject
+
 Special notes for injection into SGX enclaves:
 
 There may be a separate BIOS setup option to enable SGX injection.
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

