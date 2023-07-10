Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A78B74DC4F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 19:23:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232775AbjGJRXm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 13:23:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231373AbjGJRXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 13:23:36 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8255ACC;
        Mon, 10 Jul 2023 10:23:35 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.2.0)
 id 03179bec3a6c6835; Mon, 10 Jul 2023 19:23:34 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 8E2E4660DCF;
        Mon, 10 Jul 2023 19:23:33 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Bob Moore <robert.moore@intel.com>,
        Saket Dumbre <saket.dumbre@intel.com>
Subject: [PATCH 12/14] ACPICA: MADT: Add RISC-V external interrupt controllers
Date:   Mon, 10 Jul 2023 19:21:57 +0200
Message-ID: <8291255.NyiUUSuA9g@kreacher>
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

ACPICA commit 8c048cee4ea7b9ded8db3e1b3b9c14e21e084a2c

This adds 3 different external interrupt controller
definitions in MADT for RISC-V.

 1) RISC-V PLIC is a platform interrupt controller for
    handling wired interrupt in a RISC-V systems.

 2) RISC-V IMSIC is MSI interrupt controller to
    support MSI interrupts.

 3) RISC-V APLIC has dual functionality. First it can
    act like PLIC and direct all wired interrupts to
    the CPU which doesn't have MSI controller. Second,
    when the CPU has MSI controller (IMSIC), it will
    act as a converter from wired interrupts to MSI.

Update the existing RINTC structure also to support
these external interrupt controllers.

This codefirst ECR is approved by UEFI forum and will
be part of next ACPI spec version.

Link: https://github.com/acpica/acpica/commit/8c048cee
Signed-off-by: Haibo, Xu <haibo1.xu@intel.com>
Co-developed-by: Haibo, Xu <haibo1.xu@intel.com>
Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 include/acpi/actbl2.h | 50 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 49 insertions(+), 1 deletion(-)

diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
index 0029336775a9..280ab4c7f77a 100644
--- a/include/acpi/actbl2.h
+++ b/include/acpi/actbl2.h
@@ -893,7 +893,10 @@ enum acpi_madt_type {
 	ACPI_MADT_TYPE_BIO_PIC = 22,
 	ACPI_MADT_TYPE_LPC_PIC = 23,
 	ACPI_MADT_TYPE_RINTC = 24,
-	ACPI_MADT_TYPE_RESERVED = 25,	/* 25 to 0x7F are reserved */
+	ACPI_MADT_TYPE_IMSIC = 25,
+	ACPI_MADT_TYPE_APLIC = 26,
+	ACPI_MADT_TYPE_PLIC = 27,
+	ACPI_MADT_TYPE_RESERVED = 28,	/* 28 to 0x7F are reserved */
 	ACPI_MADT_TYPE_OEM_RESERVED = 0x80	/* 0x80 to 0xFF are reserved for OEM use */
 };
 
@@ -1261,6 +1264,9 @@ struct acpi_madt_rintc {
 	u32 flags;
 	u64 hart_id;
 	u32 uid;		/* ACPI processor UID */
+	u32 ext_intc_id;	/* External INTC Id */
+	u64 imsic_addr;		/* IMSIC base address */
+	u32 imsic_size;		/* IMSIC size */
 };
 
 /* Values for RISC-V INTC Version field above */
@@ -1271,6 +1277,48 @@ enum acpi_madt_rintc_version {
 	ACPI_MADT_RINTC_VERSION_RESERVED = 2	/* 2 and greater are reserved */
 };
 
+/* 25: RISC-V IMSIC */
+struct acpi_madt_imsic {
+	struct acpi_subtable_header header;
+	u8 version;
+	u8 reserved;
+	u32 flags;
+	u16 num_ids;
+	u16 num_guest_ids;
+	u8 guest_index_bits;
+	u8 hart_index_bits;
+	u8 group_index_bits;
+	u8 group_index_shift;
+};
+
+/* 26: RISC-V APLIC */
+struct acpi_madt_aplic {
+	struct acpi_subtable_header header;
+	u8 version;
+	u8 id;
+	u32 flags;
+	u8 hw_id[8];
+	u16 num_idcs;
+	u16 num_sources;
+	u32 gsi_base;
+	u64 base_addr;
+	u32 size;
+};
+
+/* 27: RISC-V PLIC */
+struct acpi_madt_plic {
+	struct acpi_subtable_header header;
+	u8 version;
+	u8 id;
+	u8 hw_id[8];
+	u16 num_irqs;
+	u16 max_prio;
+	u32 flags;
+	u32 size;
+	u64 base_addr;
+	u32 gsi_base;
+};
+
 /* 80: OEM data */
 
 struct acpi_madt_oem_data {
-- 
2.35.3




