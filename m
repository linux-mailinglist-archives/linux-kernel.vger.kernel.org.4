Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E6A860FFA0
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 19:59:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235850AbiJ0R7N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 13:59:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235700AbiJ0R7I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 13:59:08 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E31101781C4;
        Thu, 27 Oct 2022 10:59:05 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.0.0)
 id b1e4d3273bfb39a8; Thu, 27 Oct 2022 19:59:02 +0200
Received: from kreacher.localnet (unknown [213.134.169.45])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 1E03066D838;
        Thu, 27 Oct 2022 19:59:02 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Bob Moore <robert.moore@intel.com>
Subject: [PATCH 11/11] ACPICA: Finish support for the CDAT table
Date:   Thu, 27 Oct 2022 19:58:36 +0200
Message-ID: <2537172.Lt9SDvczpP@kreacher>
In-Reply-To: <4756726.GXAFRqVoOG@kreacher>
References: <4756726.GXAFRqVoOG@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.169.45
X-CLIENT-HOSTNAME: 213.134.169.45
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvgedrtdeggdduudejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepledtieekkeekveeikeetgffgteeuteefjeevjeegudelvdduheeiuedvieehieevnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucfkphepvddufedrudefgedrudeiledrgeehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvddufedrudefgedrudeiledrgeehpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeefpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhosggvrhhtrdhmohhorhgvsehinhhtvghlrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=3 Fuz1=3 Fuz2=3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

ACPICA commit 8ac4e5116f59d6f9ba2fbeb9ce22ab58237a278f

Finish support for the CDAT table, in both the data table compiler and
the disassembler.

Link: https://github.com/acpica/acpica/commit/8ac4e511
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/acpica/Makefile             |    1 
 drivers/acpi/acpica/acglobal.h           |    1 
 drivers/acpi/acpica/actables.h           |    5 
 drivers/acpi/acpica/acutils.h            |   13 ++
 drivers/acpi/acpica/tbdata.c             |    2 
 drivers/acpi/acpica/tbfadt.c             |    2 
 drivers/acpi/acpica/tbprint.c            |   77 --------------
 drivers/acpi/acpica/tbutils.c            |    2 
 drivers/acpi/acpica/tbxfroot.c           |    4 
 drivers/acpi/acpica/utcksum.c            |  170 +++++++++++++++++++++++++++++++
 include/acpi/actbl1.h                    |  116 ++++++++++++++++++++-
 include/acpi/actbl2.h                    |    2 
 tools/power/acpi/tools/acpidump/apdump.c |    4 
 13 files changed, 311 insertions(+), 88 deletions(-)

Index: linux-pm/drivers/acpi/acpica/acglobal.h
===================================================================
--- linux-pm.orig/drivers/acpi/acpica/acglobal.h
+++ linux-pm/drivers/acpi/acpica/acglobal.h
@@ -24,6 +24,7 @@ ACPI_GLOBAL(struct acpi_table_list, acpi
 
 ACPI_GLOBAL(struct acpi_table_header *, acpi_gbl_DSDT);
 ACPI_GLOBAL(struct acpi_table_header, acpi_gbl_original_dsdt_header);
+ACPI_INIT_GLOBAL(char *, acpi_gbl_CDAT, NULL);
 ACPI_INIT_GLOBAL(u32, acpi_gbl_dsdt_index, ACPI_INVALID_TABLE_INDEX);
 ACPI_INIT_GLOBAL(u32, acpi_gbl_facs_index, ACPI_INVALID_TABLE_INDEX);
 ACPI_INIT_GLOBAL(u32, acpi_gbl_xfacs_index, ACPI_INVALID_TABLE_INDEX);
Index: linux-pm/drivers/acpi/acpica/actables.h
===================================================================
--- linux-pm.orig/drivers/acpi/acpica/actables.h
+++ linux-pm/drivers/acpi/acpica/actables.h
@@ -124,11 +124,6 @@ void
 acpi_tb_print_table_header(acpi_physical_address address,
 			   struct acpi_table_header *header);
 
-u8 acpi_tb_checksum(u8 *buffer, u32 length);
-
-acpi_status
-acpi_tb_verify_checksum(struct acpi_table_header *table, u32 length);
-
 void acpi_tb_check_dsdt_header(void);
 
 struct acpi_table_header *acpi_tb_copy_dsdt(u32 table_index);
Index: linux-pm/drivers/acpi/acpica/acutils.h
===================================================================
--- linux-pm.orig/drivers/acpi/acpica/acutils.h
+++ linux-pm/drivers/acpi/acpica/acutils.h
@@ -159,6 +159,19 @@ u8 acpi_ut_valid_name_char(char characte
 void acpi_ut_check_and_repair_ascii(u8 *name, char *repaired_name, u32 count);
 
 /*
+ * utcksum - Checksum utilities
+ */
+u8 acpi_ut_generate_checksum(void *table, u32 length, u8 original_checksum);
+
+u8 acpi_ut_checksum(u8 *buffer, u32 length);
+
+acpi_status
+acpi_ut_verify_cdat_checksum(struct acpi_table_cdat *cdat_table, u32 length);
+
+acpi_status
+acpi_ut_verify_checksum(struct acpi_table_header *table, u32 length);
+
+/*
  * utnonansi - Non-ANSI C library functions
  */
 void acpi_ut_strupr(char *src_string);
Index: linux-pm/drivers/acpi/acpica/tbdata.c
===================================================================
--- linux-pm.orig/drivers/acpi/acpica/tbdata.c
+++ linux-pm/drivers/acpi/acpica/tbdata.c
@@ -522,7 +522,7 @@ acpi_tb_verify_temp_table(struct acpi_ta
 		/* Verify the checksum */
 
 		status =
-		    acpi_tb_verify_checksum(table_desc->pointer,
+		    acpi_ut_verify_checksum(table_desc->pointer,
 					    table_desc->length);
 		if (ACPI_FAILURE(status)) {
 			ACPI_EXCEPTION((AE_INFO, AE_NO_MEMORY,
Index: linux-pm/drivers/acpi/acpica/tbfadt.c
===================================================================
--- linux-pm.orig/drivers/acpi/acpica/tbfadt.c
+++ linux-pm/drivers/acpi/acpica/tbfadt.c
@@ -298,7 +298,7 @@ void acpi_tb_parse_fadt(void)
 	 * Validate the FADT checksum before we copy the table. Ignore
 	 * checksum error as we want to try to get the DSDT and FACS.
 	 */
-	(void)acpi_tb_verify_checksum(table, length);
+	(void)acpi_ut_verify_checksum(table, length);
 
 	/* Create a local copy of the FADT in common ACPI 2.0+ format */
 
Index: linux-pm/drivers/acpi/acpica/tbprint.c
===================================================================
--- linux-pm.orig/drivers/acpi/acpica/tbprint.c
+++ linux-pm/drivers/acpi/acpica/tbprint.c
@@ -10,6 +10,7 @@
 #include <acpi/acpi.h>
 #include "accommon.h"
 #include "actables.h"
+#include "acutils.h"
 
 #define _COMPONENT          ACPI_TABLES
 ACPI_MODULE_NAME("tbprint")
@@ -39,7 +40,7 @@ static void acpi_tb_fix_string(char *str
 {
 
 	while (length && *string) {
-		if (!isprint((int)*string)) {
+		if (!isprint((int)(u8)*string)) {
 			*string = '?';
 		}
 
@@ -135,77 +136,3 @@ acpi_tb_print_table_header(acpi_physical
 			   local_header.asl_compiler_revision));
 	}
 }
-
-/*******************************************************************************
- *
- * FUNCTION:    acpi_tb_validate_checksum
- *
- * PARAMETERS:  table               - ACPI table to verify
- *              length              - Length of entire table
- *
- * RETURN:      Status
- *
- * DESCRIPTION: Verifies that the table checksums to zero. Optionally returns
- *              exception on bad checksum.
- *
- ******************************************************************************/
-
-acpi_status acpi_tb_verify_checksum(struct acpi_table_header *table, u32 length)
-{
-	u8 checksum;
-
-	/*
-	 * FACS/S3PT:
-	 * They are the odd tables, have no standard ACPI header and no checksum
-	 */
-
-	if (ACPI_COMPARE_NAMESEG(table->signature, ACPI_SIG_S3PT) ||
-	    ACPI_COMPARE_NAMESEG(table->signature, ACPI_SIG_FACS)) {
-		return (AE_OK);
-	}
-
-	/* Compute the checksum on the table */
-
-	checksum = acpi_tb_checksum(ACPI_CAST_PTR(u8, table), length);
-
-	/* Checksum ok? (should be zero) */
-
-	if (checksum) {
-		ACPI_BIOS_WARNING((AE_INFO,
-				   "Incorrect checksum in table [%4.4s] - 0x%2.2X, "
-				   "should be 0x%2.2X",
-				   table->signature, table->checksum,
-				   (u8)(table->checksum - checksum)));
-
-#if (ACPI_CHECKSUM_ABORT)
-		return (AE_BAD_CHECKSUM);
-#endif
-	}
-
-	return (AE_OK);
-}
-
-/*******************************************************************************
- *
- * FUNCTION:    acpi_tb_checksum
- *
- * PARAMETERS:  buffer          - Pointer to memory region to be checked
- *              length          - Length of this memory region
- *
- * RETURN:      Checksum (u8)
- *
- * DESCRIPTION: Calculates circular checksum of memory region.
- *
- ******************************************************************************/
-
-u8 acpi_tb_checksum(u8 *buffer, u32 length)
-{
-	u8 sum = 0;
-	u8 *end = buffer + length;
-
-	while (buffer < end) {
-		sum = (u8)(sum + *(buffer++));
-	}
-
-	return (sum);
-}
Index: linux-pm/drivers/acpi/acpica/tbutils.c
===================================================================
--- linux-pm.orig/drivers/acpi/acpica/tbutils.c
+++ linux-pm/drivers/acpi/acpica/tbutils.c
@@ -299,7 +299,7 @@ acpi_tb_parse_root_table(acpi_physical_a
 
 	/* Validate the root table checksum */
 
-	status = acpi_tb_verify_checksum(table, length);
+	status = acpi_ut_verify_checksum(table, length);
 	if (ACPI_FAILURE(status)) {
 		acpi_os_unmap_memory(table, length);
 		return_ACPI_STATUS(status);
Index: linux-pm/drivers/acpi/acpica/tbxfroot.c
===================================================================
--- linux-pm.orig/drivers/acpi/acpica/tbxfroot.c
+++ linux-pm/drivers/acpi/acpica/tbxfroot.c
@@ -74,14 +74,14 @@ acpi_status acpi_tb_validate_rsdp(struct
 
 	/* Check the standard checksum */
 
-	if (acpi_tb_checksum((u8 *) rsdp, ACPI_RSDP_CHECKSUM_LENGTH) != 0) {
+	if (acpi_ut_checksum((u8 *)rsdp, ACPI_RSDP_CHECKSUM_LENGTH) != 0) {
 		return (AE_BAD_CHECKSUM);
 	}
 
 	/* Check extended checksum if table version >= 2 */
 
 	if ((rsdp->revision >= 2) &&
-	    (acpi_tb_checksum((u8 *) rsdp, ACPI_RSDP_XCHECKSUM_LENGTH) != 0)) {
+	    (acpi_ut_checksum((u8 *)rsdp, ACPI_RSDP_XCHECKSUM_LENGTH) != 0)) {
 		return (AE_BAD_CHECKSUM);
 	}
 
Index: linux-pm/drivers/acpi/acpica/utcksum.c
===================================================================
--- /dev/null
+++ linux-pm/drivers/acpi/acpica/utcksum.c
@@ -0,0 +1,170 @@
+// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+/******************************************************************************
+ *
+ * Module Name: utcksum - Support generating table checksums
+ *
+ * Copyright (C) 2000 - 2022, Intel Corp.
+ *
+ *****************************************************************************/
+
+#include <acpi/acpi.h>
+#include "accommon.h"
+#include "acutils.h"
+
+/* This module used for application-level code only */
+
+#define _COMPONENT          ACPI_CA_DISASSEMBLER
+ACPI_MODULE_NAME("utcksum")
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_ut_verify_checksum
+ *
+ * PARAMETERS:  table               - ACPI table to verify
+ *              length              - Length of entire table
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: Verifies that the table checksums to zero. Optionally returns
+ *              exception on bad checksum.
+ *              Note: We don't have to check for a CDAT here, since CDAT is
+ *              not in the RSDT/XSDT, and the CDAT table is never installed
+ *              via ACPICA.
+ *
+ ******************************************************************************/
+acpi_status acpi_ut_verify_checksum(struct acpi_table_header *table, u32 length)
+{
+	u8 checksum;
+
+	/*
+	 * FACS/S3PT:
+	 * They are the odd tables, have no standard ACPI header and no checksum
+	 */
+	if (ACPI_COMPARE_NAMESEG(table->signature, ACPI_SIG_S3PT) ||
+	    ACPI_COMPARE_NAMESEG(table->signature, ACPI_SIG_FACS)) {
+		return (AE_OK);
+	}
+
+	/* Compute the checksum on the table */
+
+	length = table->length;
+	checksum =
+	    acpi_ut_generate_checksum(ACPI_CAST_PTR(u8, table), length,
+				      table->checksum);
+
+	/* Computed checksum matches table? */
+
+	if (checksum != table->checksum) {
+		ACPI_BIOS_WARNING((AE_INFO,
+				   "Incorrect checksum in table [%4.4s] - 0x%2.2X, "
+				   "should be 0x%2.2X",
+				   table->signature, table->checksum,
+				   table->checksum - checksum));
+
+#if (ACPI_CHECKSUM_ABORT)
+		return (AE_BAD_CHECKSUM);
+#endif
+	}
+
+	return (AE_OK);
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_ut_verify_cdat_checksum
+ *
+ * PARAMETERS:  table               - CDAT ACPI table to verify
+ *              length              - Length of entire table
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: Verifies that the CDAT table checksums to zero. Optionally
+ *              returns an exception on bad checksum.
+ *
+ ******************************************************************************/
+
+acpi_status
+acpi_ut_verify_cdat_checksum(struct acpi_table_cdat *cdat_table, u32 length)
+{
+	u8 checksum;
+
+	/* Compute the checksum on the table */
+
+	checksum = acpi_ut_generate_checksum(ACPI_CAST_PTR(u8, cdat_table),
+					     cdat_table->length,
+					     cdat_table->checksum);
+
+	/* Computed checksum matches table? */
+
+	if (checksum != cdat_table->checksum) {
+		ACPI_BIOS_WARNING((AE_INFO,
+				   "Incorrect checksum in table [%4.4s] - 0x%2.2X, "
+				   "should be 0x%2.2X",
+				   acpi_gbl_CDAT, cdat_table->checksum,
+				   checksum));
+
+#if (ACPI_CHECKSUM_ABORT)
+		return (AE_BAD_CHECKSUM);
+#endif
+	}
+
+	cdat_table->checksum = checksum;
+	return (AE_OK);
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_ut_generate_checksum
+ *
+ * PARAMETERS:  table               - Pointer to table to be checksummed
+ *              length              - Length of the table
+ *              original_checksum   - Value of the checksum field
+ *
+ * RETURN:      8 bit checksum of buffer
+ *
+ * DESCRIPTION: Computes an 8 bit checksum of the table.
+ *
+ ******************************************************************************/
+
+u8 acpi_ut_generate_checksum(void *table, u32 length, u8 original_checksum)
+{
+	u8 checksum;
+
+	/* Sum the entire table as-is */
+
+	checksum = acpi_ut_checksum((u8 *)table, length);
+
+	/* Subtract off the existing checksum value in the table */
+
+	checksum = (u8)(checksum - original_checksum);
+
+	/* Compute and return the final checksum */
+
+	checksum = (u8)(0 - checksum);
+	return (checksum);
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_ut_checksum
+ *
+ * PARAMETERS:  buffer          - Pointer to memory region to be checked
+ *              length          - Length of this memory region
+ *
+ * RETURN:      Checksum (u8)
+ *
+ * DESCRIPTION: Calculates circular checksum of memory region.
+ *
+ ******************************************************************************/
+
+u8 acpi_ut_checksum(u8 *buffer, u32 length)
+{
+	u8 sum = 0;
+	u8 *end = buffer + length;
+
+	while (buffer < end) {
+		sum = (u8)(sum + *(buffer++));
+	}
+
+	return (sum);
+}
Index: linux-pm/include/acpi/actbl1.h
===================================================================
--- linux-pm.orig/include/acpi/actbl1.h
+++ linux-pm/include/acpi/actbl1.h
@@ -45,6 +45,7 @@
 #define ACPI_SIG_HMAT           "HMAT"	/* Heterogeneous Memory Attributes Table */
 #define ACPI_SIG_HPET           "HPET"	/* High Precision Event Timer table */
 #define ACPI_SIG_IBFT           "IBFT"	/* iSCSI Boot Firmware Table */
+#define ACPI_SIG_MSCT           "MSCT"	/* Maximum System Characteristics Table */
 
 #define ACPI_SIG_S3PT           "S3PT"	/* S3 Performance (sub)Table */
 #define ACPI_SIG_PCCS           "PCC"	/* PCC Shared Memory Region */
@@ -305,10 +306,123 @@ struct acpi_table_boot {
 
 /*******************************************************************************
  *
+ * CDAT - Coherent Device Attribute Table
+ *        Version 1
+ *
+ * Conforms to the "Coherent Device Attribute Table (CDAT) Specification
+ " (Revision 1.01, October 2020.)
+ *
+ ******************************************************************************/
+
+struct acpi_table_cdat {
+	u32 length;		/* Length of table in bytes, including this header */
+	u8 revision;		/* ACPI Specification minor version number */
+	u8 checksum;		/* To make sum of entire table == 0 */
+	u8 reserved[6];
+	u32 sequence;		/* Used to detect runtime CDAT table changes */
+};
+
+/* CDAT common subtable header */
+
+struct acpi_cdat_header {
+	u8 type;
+	u8 reserved;
+	u16 length;
+};
+
+/* Values for Type field above */
+
+enum acpi_cdat_type {
+	ACPI_CDAT_TYPE_DSMAS = 0,
+	ACPI_CDAT_TYPE_DSLBIS = 1,
+	ACPI_CDAT_TYPE_DSMSCIS = 2,
+	ACPI_CDAT_TYPE_DSIS = 3,
+	ACPI_CDAT_TYPE_DSEMTS = 4,
+	ACPI_CDAT_TYPE_SSLBIS = 5,
+	ACPI_CDAT_TYPE_RESERVED = 6	/* 6 through 0xFF are reserved */
+};
+
+/* Subtable 0: Device Scoped Memory Affinity Structure (DSMAS) */
+
+struct acpi_cadt_dsmas {
+	u8 dsmad_handle;
+	u8 flags;
+	u16 reserved;
+	u64 dpa_base_address;
+	u64 dpa_length;
+};
+
+/* Flags for subtable above */
+
+#define ACPI_CEDT_DSMAS_NON_VOLATILE        (1 << 2)
+
+/* Subtable 1: Device scoped Latency and Bandwidth Information Structure (DSLBIS) */
+
+struct acpi_cdat_dslbis {
+	u8 handle;
+	u8 flags;		/* If Handle matches a DSMAS handle, the definition of this field matches
+				 * Flags field in HMAT System Locality Latency */
+	u8 data_type;
+	u8 reserved;
+	u64 entry_base_unit;
+	u16 entry[3];
+	u16 reserved2;
+};
+
+/* Subtable 2: Device Scoped Memory Side Cache Information Structure (DSMSCIS) */
+
+struct acpi_cdat_dsmscis {
+	u8 dsmas_handle;
+	u8 reserved[3];
+	u64 side_cache_size;
+	u32 cache_attributes;
+};
+
+/* Subtable 3: Device Scoped Initiator Structure (DSIS) */
+
+struct acpi_cdat_dsis {
+	u8 flags;
+	u8 handle;
+	u16 reserved;
+};
+
+/* Flags for above subtable */
+
+#define ACPI_CDAT_DSIS_MEM_ATTACHED         (1 << 0)
+
+/* Subtable 4: Device Scoped EFI Memory Type Structure (DSEMTS) */
+
+struct acpi_cdat_dsemts {
+	u8 dsmas_handle;
+	u8 memory_type;
+	u16 reserved;
+	u64 dpa_offset;
+	u64 range_length;
+};
+
+/* Subtable 5: Switch Scoped Latency and Bandwidth Information Structure (SSLBIS) */
+
+struct acpi_cdat_sslbis {
+	u8 data_type;
+	u8 reserved[3];
+	u64 entry_base_unit;
+};
+
+/* Sub-subtable for above, sslbe_entries field */
+
+struct acpi_cdat_sslbe {
+	u16 portx_id;
+	u16 porty_id;
+	u16 latency_or_bandwidth;
+	u16 reserved;
+};
+
+/*******************************************************************************
+ *
  * CEDT - CXL Early Discovery Table
  *        Version 1
  *
- * Conforms to the "CXL Early Discovery Table" (CXL 2.0)
+ * Conforms to the "CXL Early Discovery Table" (CXL 2.0, October 2020)
  *
  ******************************************************************************/
 
Index: linux-pm/include/acpi/actbl2.h
===================================================================
--- linux-pm.orig/include/acpi/actbl2.h
+++ linux-pm/include/acpi/actbl2.h
@@ -28,6 +28,7 @@
 #define ACPI_SIG_APMT           "APMT"	/* Arm Performance Monitoring Unit table */
 #define ACPI_SIG_BDAT           "BDAT"	/* BIOS Data ACPI Table */
 #define ACPI_SIG_CCEL           "CCEL"	/* CC Event Log Table */
+#define ACPI_SIG_CDAT           "CDAT"	/* Coherent Device Attribute Table */
 #define ACPI_SIG_IORT           "IORT"	/* IO Remapping Table */
 #define ACPI_SIG_IVRS           "IVRS"	/* I/O Virtualization Reporting Structure */
 #define ACPI_SIG_LPIT           "LPIT"	/* Low Power Idle Table */
@@ -35,7 +36,6 @@
 #define ACPI_SIG_MCFG           "MCFG"	/* PCI Memory Mapped Configuration table */
 #define ACPI_SIG_MCHI           "MCHI"	/* Management Controller Host Interface table */
 #define ACPI_SIG_MPST           "MPST"	/* Memory Power State Table */
-#define ACPI_SIG_MSCT           "MSCT"	/* Maximum System Characteristics Table */
 #define ACPI_SIG_MSDM           "MSDM"	/* Microsoft Data Management Table */
 #define ACPI_SIG_NFIT           "NFIT"	/* NVDIMM Firmware Interface Table */
 #define ACPI_SIG_NHLT           "NHLT"	/* Non HD Audio Link Table */
Index: linux-pm/tools/power/acpi/tools/acpidump/apdump.c
===================================================================
--- linux-pm.orig/tools/power/acpi/tools/acpidump/apdump.c
+++ linux-pm/tools/power/acpi/tools/acpidump/apdump.c
@@ -78,7 +78,9 @@ u8 ap_is_valid_checksum(struct acpi_tabl
 		rsdp = ACPI_CAST_PTR(struct acpi_table_rsdp, table);
 		status = acpi_tb_validate_rsdp(rsdp);
 	} else {
-		status = acpi_tb_verify_checksum(table, table->length);
+		/* We don't have to check for a CDAT here, since CDAT is not in the RSDT/XSDT */
+
+		status = acpi_ut_verify_checksum(table, table->length);
 	}
 
 	if (ACPI_FAILURE(status)) {
Index: linux-pm/drivers/acpi/acpica/Makefile
===================================================================
--- linux-pm.orig/drivers/acpi/acpica/Makefile
+++ linux-pm/drivers/acpi/acpica/Makefile
@@ -155,6 +155,7 @@ acpi-y +=		\
 	utalloc.o	\
 	utascii.o	\
 	utbuffer.o	\
+	utcksum.o	\
 	utcopy.o	\
 	utexcep.o	\
 	utdebug.o	\



