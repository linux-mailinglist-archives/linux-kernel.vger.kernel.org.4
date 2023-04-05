Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B3606D7E7D
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 16:04:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238181AbjDEOEC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 10:04:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238116AbjDEODM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 10:03:12 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F40972A2;
        Wed,  5 Apr 2023 07:01:32 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.1.0)
 id 23896dadccd63884; Wed, 5 Apr 2023 16:01:19 +0200
Received: from kreacher.localnet (unknown [213.134.163.219])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id E75991B4EA6F;
        Wed,  5 Apr 2023 16:01:18 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Bob Moore <robert.moore@intel.com>
Subject: [PATCH 07/32] ACPICA: Add support for Arm's MPAM ACPI table version 2
Date:   Wed, 05 Apr 2023 15:37:35 +0200
Message-ID: <7533327.EvYhyI6sBW@kreacher>
In-Reply-To: <4845957.31r3eYUQgx@kreacher>
References: <4845957.31r3eYUQgx@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.163.219
X-CLIENT-HOSTNAME: 213.134.163.219
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvhedrvdejuddgjeduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdfhjedtgfekvdeitdeiiefgkeeljeegffelleeuheehfedugffhfeefvedtgfehnecuffhomhgrihhnpegrrhhmrdgtohhmpdhgihhthhhusgdrtghomhenucfkphepvddufedrudefgedrudeifedrvdduleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvudefrddufeegrdduieefrddvudelpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeefpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhosggvrhhtrdhmohhorhgvsehinhhtvghlrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=3 Fuz1=3 Fuz2=3
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hesham Almatary <hesham.almatary@huawei.com>

ACPICA commit 005e24bcaa6e4c7db327b4f81fb63b2715aac7e6

Complies with ACPI for Memory System Resource Partitioning and
Monitoring 2.0 [1]. Document number: DEN0065, as of December 2022.

Support for all types of MPAM resources. No support yet for:
1) MPAM PCC Interface Type
2) The optional Resource-specific data per MSC node, introduced in v2 of the
MPAM ACPI spec.

[1] https://developer.arm.com/documentation/den0065/latest

Link: https://github.com/acpica/acpica/commit/005e24bc
Signed-off-by: Hesham Almatary <hesham.almatary@huawei.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 include/acpi/actbl2.h | 116 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 116 insertions(+)

diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
index 65f9e834e921..b082175906ba 100644
--- a/include/acpi/actbl2.h
+++ b/include/acpi/actbl2.h
@@ -35,6 +35,7 @@
 #define ACPI_SIG_MADT           "APIC"	/* Multiple APIC Description Table */
 #define ACPI_SIG_MCFG           "MCFG"	/* PCI Memory Mapped Configuration table */
 #define ACPI_SIG_MCHI           "MCHI"	/* Management Controller Host Interface table */
+#define ACPI_SIG_MPAM           "MPAM"	/* Memory System Resource Partitioning and Monitoring Table */
 #define ACPI_SIG_MPST           "MPST"	/* Memory Power State Table */
 #define ACPI_SIG_MSDM           "MSDM"	/* Microsoft Data Management Table */
 #define ACPI_SIG_NFIT           "NFIT"	/* NVDIMM Firmware Interface Table */
@@ -1332,6 +1333,121 @@ struct acpi_table_mchi {
 	u8 pci_function;
 };
 
+/*******************************************************************************
+ *
+ * MPAM - Memory System Resource Partitioning and Monitoring
+ *
+ * Conforms to "ACPI for Memory System Resource Partitioning and Monitoring 2.0"
+ * Document number: ARM DEN 0065, December, 2022.
+ *
+ ******************************************************************************/
+
+/* MPAM RIS locator types. Table 11, Location types */
+enum acpi_mpam_locator_type {
+	ACPI_MPAM_LOCATION_TYPE_PROCESSOR_CACHE = 0,
+	ACPI_MPAM_LOCATION_TYPE_MEMORY = 1,
+	ACPI_MPAM_LOCATION_TYPE_SMMU = 2,
+	ACPI_MPAM_LOCATION_TYPE_MEMORY_CACHE = 3,
+	ACPI_MPAM_LOCATION_TYPE_ACPI_DEVICE = 4,
+	ACPI_MPAM_LOCATION_TYPE_INTERCONNECT = 5,
+	ACPI_MPAM_LOCATION_TYPE_UNKNOWN = 0xFF
+};
+
+/* MPAM Functional dependency descriptor. Table 10 */
+struct acpi_mpam_func_deps {
+	u32 producer;
+	u32 reserved;
+};
+
+/* MPAM Processor cache locator descriptor. Table 13 */
+struct acpi_mpam_resource_cache_locator {
+	u64 cache_reference;
+	u32 reserved;
+};
+
+/* MPAM Memory locator descriptor. Table 14 */
+struct acpi_mpam_resource_memory_locator {
+	u64 proximity_domain;
+	u32 reserved;
+};
+
+/* MPAM SMMU locator descriptor. Table 15 */
+struct acpi_mpam_resource_smmu_locator {
+	u64 smmu_interface;
+	u32 reserved;
+};
+
+/* MPAM Memory-side cache locator descriptor. Table 16 */
+struct acpi_mpam_resource_memcache_locator {
+	u8 reserved[7];
+	u8 level;
+	u32 reference;
+};
+
+/* MPAM ACPI device locator descriptor. Table 17 */
+struct acpi_mpam_resource_acpi_locator {
+	u64 acpi_hw_id;
+	u32 acpi_unique_id;
+};
+
+/* MPAM Interconnect locator descriptor. Table 18 */
+struct acpi_mpam_resource_interconnect_locator {
+	u64 inter_connect_desc_tbl_off;
+	u32 reserved;
+};
+
+/* MPAM Locator structure. Table 12 */
+struct acpi_mpam_resource_generic_locator {
+	u64 descriptor1;
+	u32 descriptor2;
+};
+
+union acpi_mpam_resource_locator {
+	struct acpi_mpam_resource_cache_locator cache_locator;
+	struct acpi_mpam_resource_memory_locator memory_locator;
+	struct acpi_mpam_resource_smmu_locator smmu_locator;
+	struct acpi_mpam_resource_memcache_locator mem_cache_locator;
+	struct acpi_mpam_resource_acpi_locator acpi_locator;
+	struct acpi_mpam_resource_interconnect_locator interconnect_ifc_locator;
+	struct acpi_mpam_resource_generic_locator generic_locator;
+};
+
+/* Memory System Component Resource Node Structure Table 9 */
+struct acpi_mpam_resource_node {
+	u32 identifier;
+	u8 ris_index;
+	u16 reserved1;
+	u8 locator_type;
+	union acpi_mpam_resource_locator locator;
+	u32 num_functional_deps;
+};
+
+/* Memory System Component (MSC) Node Structure. Table 4 */
+struct acpi_mpam_msc_node {
+	u16 length;
+	u8 interface_type;
+	u8 reserved;
+	u32 identifier;
+	u64 base_address;
+	u32 mmio_size;
+	u32 overflow_interrupt;
+	u32 overflow_interrupt_flags;
+	u32 reserved1;
+	u32 overflow_interrupt_affinity;
+	u32 error_interrupt;
+	u32 error_interrupt_flags;
+	u32 reserved2;
+	u32 error_interrupt_affinity;
+	u32 max_nrdy_usec;
+	u64 hardware_id_linked_device;
+	u32 instance_id_linked_device;
+	u32 num_resouce_nodes;
+};
+
+struct acpi_table_mpam {
+	struct acpi_table_header header;	/* Common ACPI table header */
+};
+
 /*******************************************************************************
  *
  * MPST - Memory Power State Table (ACPI 5.0)
-- 
2.35.3




