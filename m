Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD43F74DC4D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 19:23:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232608AbjGJRXj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 13:23:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231702AbjGJRXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 13:23:36 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1200CA;
        Mon, 10 Jul 2023 10:23:34 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.2.0)
 id ef76e861deac5928; Mon, 10 Jul 2023 19:23:33 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id F273B660DCF;
        Mon, 10 Jul 2023 19:23:32 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Bob Moore <robert.moore@intel.com>,
        Saket Dumbre <saket.dumbre@intel.com>
Subject: [PATCH 13/14] ACPICA: RHCT: Add flags, CMO and MMU nodes
Date:   Mon, 10 Jul 2023 19:22:41 +0200
Message-ID: <3437779.QJadu78ljV@kreacher>
In-Reply-To: <5698695.DvuYhMxLoT@kreacher>
References: <5698695.DvuYhMxLoT@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 195.136.19.94
X-CLIENT-HOSTNAME: 195.136.19.94
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedviedrvdekgddutdefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepledtieekkeekveeikeetgffgteeuteefjeevjeegudelvdduheeiuedvieehieevnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeegpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhosggvrhhtrdhmohhorhgvsehinhhtvghlrdgtohhmpdhrtghpthhtohepshgrkhgvthdrughumhgsrhgv
 sehinhhtvghlrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=4 Fuz1=4 Fuz2=4
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sunil V L <sunilvl@ventanamicro.com>

ACPICA commit 2eded5a6a13d892b7dc3be6096e7b1e8d4407600

Update RHCT table with below details.

 1) Add additional structure to describe the Cache Management
    Operation (CMO) related information.

 2) Add structure to describe MMU type.

 3) Convert the current reserved field to flags and define
    a flag to indicate timer capability.

This codefirst ECR is approved by UEFI forum and will
be part of next ACPI spec version.

Link: https://github.com/acpica/acpica/commit/2eded5a6
Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 include/acpi/actbl2.h | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
index 280ab4c7f77a..3751ae69432f 100644
--- a/include/acpi/actbl2.h
+++ b/include/acpi/actbl2.h
@@ -2778,12 +2778,15 @@ enum acpi_rgrt_image_type {
 
 struct acpi_table_rhct {
 	struct acpi_table_header header;	/* Common ACPI table header */
-	u32 reserved;
+	u32 flags;		/* RHCT flags */
 	u64 time_base_freq;
 	u32 node_count;
 	u32 node_offset;
 };
 
+/* RHCT Flags */
+
+#define ACPI_RHCT_TIMER_CANNOT_WAKEUP_CPU       (1)
 /*
  * RHCT subtables
  */
@@ -2797,6 +2800,9 @@ struct acpi_rhct_node_header {
 
 enum acpi_rhct_node_type {
 	ACPI_RHCT_NODE_TYPE_ISA_STRING = 0x0000,
+	ACPI_RHCT_NODE_TYPE_CMO = 0x0001,
+	ACPI_RHCT_NODE_TYPE_MMU = 0x0002,
+	ACPI_RHCT_NODE_TYPE_RESERVED = 0x0003,
 	ACPI_RHCT_NODE_TYPE_HART_INFO = 0xFFFF,
 };
 
@@ -2810,6 +2816,24 @@ struct acpi_rhct_isa_string {
 	char isa[];
 };
 
+struct acpi_rhct_cmo_node {
+	u8 reserved;		/* Must be zero */
+	u8 cbom_size;		/* CBOM size in powerof 2 */
+	u8 cbop_size;		/* CBOP size in powerof 2 */
+	u8 cboz_size;		/* CBOZ size in powerof 2 */
+};
+
+struct acpi_rhct_mmu_node {
+	u8 reserved;		/* Must be zero */
+	u8 mmu_type;		/* Virtual Address Scheme */
+};
+
+enum acpi_rhct_mmu_type {
+	ACPI_RHCT_MMU_TYPE_SV39 = 0,
+	ACPI_RHCT_MMU_TYPE_SV48 = 1,
+	ACPI_RHCT_MMU_TYPE_SV57 = 2
+};
+
 /* Hart Info node structure */
 struct acpi_rhct_hart_info {
 	u16 num_offsets;
-- 
2.35.3




