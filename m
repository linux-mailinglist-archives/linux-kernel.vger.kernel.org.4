Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B612460FFB4
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 20:00:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236316AbiJ0SAY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 14:00:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236146AbiJ0R75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 13:59:57 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D20A51843E6;
        Thu, 27 Oct 2022 10:59:21 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.0.0)
 id 6d90cd789da94385; Thu, 27 Oct 2022 19:59:19 +0200
Received: from kreacher.localnet (unknown [213.134.169.45])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 0EDE766D83D;
        Thu, 27 Oct 2022 19:59:19 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Bob Moore <robert.moore@intel.com>
Subject: [PATCH 01/11] ACPICA: MADT: Add loong_arch-specific APICs support
Date:   Thu, 27 Oct 2022 19:47:30 +0200
Message-ID: <3201025.aeNJFYEL58@kreacher>
In-Reply-To: <4756726.GXAFRqVoOG@kreacher>
References: <4756726.GXAFRqVoOG@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.169.45
X-CLIENT-HOSTNAME: 213.134.169.45
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvgedrtdeggdduudejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepueffffeugeehvdduveekueegvdeigefhfeegkeeuveetgfejhefhledtjeevledtnecuffhomhgrihhnpehgihhthhhusgdrtghomhdpuhgvfhhirdhorhhgnecukfhppedvudefrddufeegrdduieelrdegheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvudefrddufeegrdduieelrdeghedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepfedprhgtphhtthhopehlihhnuhigqdgrtghpihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehrohgsvghrthdrmhhoohhrvgesihhnthgvlhdrtghomh
X-DCC--Metrics: v370.home.net.pl 1024; Body=3 Fuz1=3 Fuz2=3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Huacai Chen <chenhuacai@loongson.cn>

ACPICA commit 1dc530059a3e6202e941e6a9478cf30f092bfb47

loong_arch-specific interrupt controllers (similar to APIC) are added
in the next revision of ACPI Specification (current revision is 6.4),
which including CORE_PIC (CPUINTC), LIO_PIC (LIOINTC), EIO_PIC (EIOINTC),
HT_PIC (HTVECINTC), BIO_PIC (PCHINTC), LPC_PIC (PCHLPC) and MSI_PIC
(PCHMSI). This patch add their definition.

ACPI changes of loong_arch-specific interrupt controllers have already
been approved in the ECRs, and will be public in the next revision of
ACPI Specification.

Link: https://github.com/acpica/acpica/commit/1dc53005
Reference: https://mantis.uefi.org/mantis/view.php?id=2203
Reference: https://mantis.uefi.org/mantis/view.php?id=2313
Co-developed-by: Jianmin Lv <lvjianmin@loongson.cn>
Signed-off-by: Jianmin Lv <lvjianmin@loongson.cn>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 include/acpi/actbl2.h |  139 +++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 137 insertions(+), 2 deletions(-)

Index: linux-pm/include/acpi/actbl2.h
===================================================================
--- linux-pm.orig/include/acpi/actbl2.h
+++ linux-pm/include/acpi/actbl2.h
@@ -865,7 +865,14 @@ enum acpi_madt_type {
 	ACPI_MADT_TYPE_GENERIC_REDISTRIBUTOR = 14,
 	ACPI_MADT_TYPE_GENERIC_TRANSLATOR = 15,
 	ACPI_MADT_TYPE_MULTIPROC_WAKEUP = 16,
-	ACPI_MADT_TYPE_RESERVED = 17,	/* 17 to 0x7F are reserved */
+	ACPI_MADT_TYPE_CORE_PIC = 17,
+	ACPI_MADT_TYPE_LIO_PIC = 18,
+	ACPI_MADT_TYPE_HT_PIC = 19,
+	ACPI_MADT_TYPE_EIO_PIC = 20,
+	ACPI_MADT_TYPE_MSI_PIC = 21,
+	ACPI_MADT_TYPE_BIO_PIC = 22,
+	ACPI_MADT_TYPE_LPC_PIC = 23,
+	ACPI_MADT_TYPE_RESERVED = 24,	/* 24 to 0x7F are reserved */
 	ACPI_MADT_TYPE_OEM_RESERVED = 0x80	/* 0x80 to 0xFF are reserved for OEM use */
 };
 
@@ -1096,7 +1103,135 @@ struct acpi_madt_multiproc_wakeup_mailbo
 
 #define ACPI_MP_WAKE_COMMAND_WAKEUP    1
 
-/* 17: OEM data */
+/* 17: CPU Core Interrupt Controller (ACPI 6.5) */
+
+struct acpi_madt_core_pic {
+	struct acpi_subtable_header header;
+	u8 version;
+	u32 processor_id;
+	u32 core_id;
+	u32 flags;
+};
+
+/* Values for Version field above */
+
+enum acpi_madt_core_pic_version {
+	ACPI_MADT_CORE_PIC_VERSION_NONE = 0,
+	ACPI_MADT_CORE_PIC_VERSION_V1 = 1,
+	ACPI_MADT_CORE_PIC_VERSION_RESERVED = 2	/* 2 and greater are reserved */
+};
+
+/* 18: Legacy I/O Interrupt Controller (ACPI 6.5) */
+
+struct acpi_madt_lio_pic {
+	struct acpi_subtable_header header;
+	u8 version;
+	u64 address;
+	u16 size;
+	u8 cascade[2];
+	u32 cascade_map[2];
+};
+
+/* Values for Version field above */
+
+enum acpi_madt_lio_pic_version {
+	ACPI_MADT_LIO_PIC_VERSION_NONE = 0,
+	ACPI_MADT_LIO_PIC_VERSION_V1 = 1,
+	ACPI_MADT_LIO_PIC_VERSION_RESERVED = 2	/* 2 and greater are reserved */
+};
+
+/* 19: HT Interrupt Controller (ACPI 6.5) */
+
+struct acpi_madt_ht_pic {
+	struct acpi_subtable_header header;
+	u8 version;
+	u64 address;
+	u16 size;
+	u8 cascade[8];
+};
+
+/* Values for Version field above */
+
+enum acpi_madt_ht_pic_version {
+	ACPI_MADT_HT_PIC_VERSION_NONE = 0,
+	ACPI_MADT_HT_PIC_VERSION_V1 = 1,
+	ACPI_MADT_HT_PIC_VERSION_RESERVED = 2	/* 2 and greater are reserved */
+};
+
+/* 20: Extend I/O Interrupt Controller (ACPI 6.5) */
+
+struct acpi_madt_eio_pic {
+	struct acpi_subtable_header header;
+	u8 version;
+	u8 cascade;
+	u8 node;
+	u64 node_map;
+};
+
+/* Values for Version field above */
+
+enum acpi_madt_eio_pic_version {
+	ACPI_MADT_EIO_PIC_VERSION_NONE = 0,
+	ACPI_MADT_EIO_PIC_VERSION_V1 = 1,
+	ACPI_MADT_EIO_PIC_VERSION_RESERVED = 2	/* 2 and greater are reserved */
+};
+
+/* 21: MSI Interrupt Controller (ACPI 6.5) */
+
+struct acpi_madt_msi_pic {
+	struct acpi_subtable_header header;
+	u8 version;
+	u64 msg_address;
+	u32 start;
+	u32 count;
+};
+
+/* Values for Version field above */
+
+enum acpi_madt_msi_pic_version {
+	ACPI_MADT_MSI_PIC_VERSION_NONE = 0,
+	ACPI_MADT_MSI_PIC_VERSION_V1 = 1,
+	ACPI_MADT_MSI_PIC_VERSION_RESERVED = 2	/* 2 and greater are reserved */
+};
+
+/* 22: Bridge I/O Interrupt Controller (ACPI 6.5) */
+
+struct acpi_madt_bio_pic {
+	struct acpi_subtable_header header;
+	u8 version;
+	u64 address;
+	u16 size;
+	u16 id;
+	u16 gsi_base;
+};
+
+/* Values for Version field above */
+
+enum acpi_madt_bio_pic_version {
+	ACPI_MADT_BIO_PIC_VERSION_NONE = 0,
+	ACPI_MADT_BIO_PIC_VERSION_V1 = 1,
+	ACPI_MADT_BIO_PIC_VERSION_RESERVED = 2	/* 2 and greater are reserved */
+};
+
+/* 23: LPC Interrupt Controller (ACPI 6.5) */
+
+struct acpi_madt_lpc_pic {
+	struct acpi_subtable_header header;
+	u8 version;
+	u64 address;
+	u16 size;
+	u8 cascade;
+};
+
+/* Values for Version field above */
+
+enum acpi_madt_lpc_pic_version {
+	ACPI_MADT_LPC_PIC_VERSION_NONE = 0,
+	ACPI_MADT_LPC_PIC_VERSION_V1 = 1,
+	ACPI_MADT_LPC_PIC_VERSION_RESERVED = 2	/* 2 and greater are reserved */
+};
+
+/* 80: OEM data */
 
 struct acpi_madt_oem_data {
 	u8 oem_data[0];



