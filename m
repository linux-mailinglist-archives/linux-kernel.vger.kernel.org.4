Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22A376D7E5A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 16:01:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237966AbjDEOBp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 10:01:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238292AbjDEOBD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 10:01:03 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8838A659D;
        Wed,  5 Apr 2023 07:00:54 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.1.0)
 id dbc24bc88e5a9a01; Wed, 5 Apr 2023 16:00:52 +0200
Received: from kreacher.localnet (unknown [213.134.163.219])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 0B0B11B4EA62;
        Wed,  5 Apr 2023 16:00:52 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Bob Moore <robert.moore@intel.com>,
        Kees Cook <kees@outflux.net>,
        Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH 22/32] ACPICA: actbl2: Replace 1-element arrays with flexible arrays
Date:   Wed, 05 Apr 2023 15:50:18 +0200
Message-ID: <14903668.tv2OnDr8pf@kreacher>
In-Reply-To: <4845957.31r3eYUQgx@kreacher>
References: <4845957.31r3eYUQgx@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.163.219
X-CLIENT-HOSTNAME: 213.134.163.219
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvhedrvdejuddgjeduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepledtieekkeekveeikeetgffgteeuteefjeevjeegudelvdduheeiuedvieehieevnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucfkphepvddufedrudefgedrudeifedrvdduleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvudefrddufeegrdduieefrddvudelpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeehpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhosggvrhhtrdhmohhorhgvsehinhhtvghlrdgtohhmpdhrtghpthhtohepkhgvvghssehouhht
 fhhluhigrdhnvghtpdhrtghpthhtohepuggrnhdrjhdrfihilhhlihgrmhhssehinhhtvghlrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=5 Fuz1=5 Fuz2=5
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kees Cook <kees@outflux.net>

ACPICA commit 44f1af0664599e87bebc3a1260692baa27b2f264

Similar to "Replace one-element array with flexible-array", replace the
1-element array with a proper flexible array member as defined by C99.

This allows the code to operate without tripping compile-time and run-
time bounds checkers (e.g. via __builtin_object_size(), -fsanitize=bounds,
and/or -fstrict-flex-arrays=3).

The sizeof() uses with struct acpi_nfit_flush_address and struct
acpi_nfit_smbios have been adjusted to drop the open-coded subtraction
of the trailing single element. The result is no binary differences in
.text nor .data sections.

Link: https://github.com/acpica/acpica/commit/44f1af06
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/nfit/core.c |  2 +-
 include/acpi/actbl2.h    | 16 ++++++++--------
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
index 4e48d6db05eb..981f8b0f595d 100644
--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -3477,7 +3477,7 @@ static __init int nfit_init(void)
 	BUILD_BUG_ON(sizeof(struct acpi_nfit_system_address) != 64);
 	BUILD_BUG_ON(sizeof(struct acpi_nfit_memory_map) != 48);
 	BUILD_BUG_ON(sizeof(struct acpi_nfit_interleave) != 20);
-	BUILD_BUG_ON(sizeof(struct acpi_nfit_smbios) != 9);
+	BUILD_BUG_ON(sizeof(struct acpi_nfit_smbios) != 8);
 	BUILD_BUG_ON(sizeof(struct acpi_nfit_control_region) != 80);
 	BUILD_BUG_ON(sizeof(struct acpi_nfit_data_region) != 40);
 	BUILD_BUG_ON(sizeof(struct acpi_nfit_capabilities) != 16);
diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
index db292f325696..6d3251ea4c53 100644
--- a/include/acpi/actbl2.h
+++ b/include/acpi/actbl2.h
@@ -397,7 +397,7 @@ struct acpi_iort_node {
 	u32 identifier;
 	u32 mapping_count;
 	u32 mapping_offset;
-	char node_data[1];
+	char node_data[];
 };
 
 /* Values for subtable Type above */
@@ -453,14 +453,14 @@ struct acpi_iort_memory_access {
  */
 struct acpi_iort_its_group {
 	u32 its_count;
-	u32 identifiers[1];	/* GIC ITS identifier array */
+	u32 identifiers[];	/* GIC ITS identifier array */
 };
 
 struct acpi_iort_named_component {
 	u32 node_flags;
 	u64 memory_properties;	/* Memory access properties */
 	u8 memory_address_limit;	/* Memory address size limit */
-	char device_name[1];	/* Path of namespace object */
+	char device_name[];	/* Path of namespace object */
 };
 
 /* Masks for Flags field above */
@@ -474,7 +474,7 @@ struct acpi_iort_root_complex {
 	u32 pci_segment_number;
 	u8 memory_address_limit;	/* Memory address size limit */
 	u16 pasid_capabilities;	/* PASID Capabilities */
-	u8 reserved[1];		/* Reserved, must be zero */
+	u8 reserved[];		/* Reserved, must be zero */
 };
 
 /* Masks for ats_attribute field above */
@@ -496,7 +496,7 @@ struct acpi_iort_smmu {
 	u32 context_interrupt_offset;
 	u32 pmu_interrupt_count;
 	u32 pmu_interrupt_offset;
-	u64 interrupts[1];	/* Interrupt array */
+	u64 interrupts[];	/* Interrupt array */
 };
 
 /* Values for Model field above */
@@ -975,7 +975,7 @@ struct acpi_madt_local_sapic {
 	u8 reserved[3];		/* Reserved, must be zero */
 	u32 lapic_flags;
 	u32 uid;		/* Numeric UID - ACPI 3.0 */
-	char uid_string[1];	/* String UID  - ACPI 3.0 */
+	char uid_string[];	/* String UID  - ACPI 3.0 */
 };
 
 /* 8: Platform Interrupt Source */
@@ -1708,7 +1708,7 @@ struct acpi_nfit_interleave {
 struct acpi_nfit_smbios {
 	struct acpi_nfit_header header;
 	u32 reserved;		/* Reserved, must be zero */
-	u8 data[1];		/* Variable length */
+	u8 data[];		/* Variable length */
 };
 
 /* 4: NVDIMM Control Region Structure */
@@ -1765,7 +1765,7 @@ struct acpi_nfit_flush_address {
 	u32 device_handle;
 	u16 hint_count;
 	u8 reserved[6];		/* Reserved, must be zero */
-	u64 hint_address[1];	/* Variable length */
+	u64 hint_address[];	/* Variable length */
 };
 
 /* 7: Platform Capabilities Structure */
-- 
2.35.3





