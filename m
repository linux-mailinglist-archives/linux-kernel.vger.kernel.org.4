Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 381BE6D7E85
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 16:04:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238100AbjDEOEW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 10:04:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238232AbjDEODO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 10:03:14 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A412372A0;
        Wed,  5 Apr 2023 07:01:35 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.1.0)
 id e95ffb0460b9d498; Wed, 5 Apr 2023 16:01:21 +0200
Received: from kreacher.localnet (unknown [213.134.163.219])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id EFB311B4EA6F;
        Wed,  5 Apr 2023 16:01:20 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Bob Moore <robert.moore@intel.com>
Subject: [PATCH 06/32] ACPICA: Add support for ASPT table in disassembler
Date:   Wed, 05 Apr 2023 15:36:51 +0200
Message-ID: <1953193.PYKUYFuaPT@kreacher>
In-Reply-To: <4845957.31r3eYUQgx@kreacher>
References: <4845957.31r3eYUQgx@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.163.219
X-CLIENT-HOSTNAME: 213.134.163.219
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvhedrvdejuddgjeduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepieeuhedtkeejffdtieehheegveegueegteehudeikeetvdffgfdtgeffudehteeunecuffhomhgrihhnpehgihhthhhusgdrtghomhdpmhhitghrohhsohhfthdrtghomhenucfkphepvddufedrudefgedrudeifedrvdduleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvudefrddufeegrdduieefrddvudelpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeefpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhosggvrhhtrdhmohhorhgvsehinhhtvghlrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=3 Fuz1=3 Fuz2=3
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>

ACPICA commit 6771f8b758299bd383bab145d5fd36ec229b2d70

ASPT is the AMD Secure Processor table, found in Hyper-V VMs when SNP
isolation is exposed to the VM and in some high-end AMD servers. This
commit adds support for rev 1 of the ASPT spec in the disassembler.

Link: https://github.com/acpica/acpica/commit/6771f8b7
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 include/acpi/actbl1.h | 46 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
index 81b9e794424d..b5e011da5271 100644
--- a/include/acpi/actbl1.h
+++ b/include/acpi/actbl1.h
@@ -26,6 +26,7 @@
  */
 #define ACPI_SIG_AEST           "AEST"	/* Arm Error Source Table */
 #define ACPI_SIG_ASF            "ASF!"	/* Alert Standard Format table */
+#define ACPI_SIG_ASPT           "ASPT"	/* AMD Secure Processor Table */
 #define ACPI_SIG_BERT           "BERT"	/* Boot Error Record Table */
 #define ACPI_SIG_BGRT           "BGRT"	/* Boot Graphics Resource Table */
 #define ACPI_SIG_BOOT           "BOOT"	/* Simple Boot Flag Table */
@@ -109,6 +110,51 @@ struct acpi_whea_header {
 	u64 mask;		/* Bitmask required for this register instruction */
 };
 
+/* https://docs.microsoft.com/en-us/windows-hardware/drivers/ddi/acpitabl/ns-acpitabl-aspt_table */
+#define ASPT_REVISION_ID 0x01
+struct acpi_table_aspt {
+	struct acpi_table_header header;
+	u32 num_entries;
+};
+
+struct acpi_aspt_header {
+	u16 type;
+	u16 length;
+};
+
+enum acpi_aspt_type {
+	ACPI_ASPT_TYPE_GLOBAL_REGS = 0,
+	ACPI_ASPT_TYPE_SEV_MBOX_REGS = 1,
+	ACPI_ASPT_TYPE_ACPI_MBOX_REGS = 2,
+};
+
+/* 0: ASPT Global Registers */
+struct acpi_aspt_global_regs {
+	struct acpi_aspt_header header;
+	u32 reserved;
+	u64 feature_reg_addr;
+	u64 irq_en_reg_addr;
+	u64 irq_st_reg_addr;
+};
+
+/* 1: ASPT SEV Mailbox Registers */
+struct acpi_aspt_sev_mbox_regs {
+	struct acpi_aspt_header header;
+	u8 mbox_irq_id;
+	u8 reserved[3];
+	u64 cmd_resp_reg_addr;
+	u64 cmd_buf_lo_reg_addr;
+	u64 cmd_buf_hi_reg_addr;
+};
+
+/* 2: ASPT ACPI Mailbox Registers */
+struct acpi_aspt_acpi_mbox_regs {
+	struct acpi_aspt_header header;
+	u32 reserved1;
+	u64 cmd_resp_reg_addr;
+	u64 reserved2[2];
+};
+
 /*******************************************************************************
  *
  * ASF - Alert Standard Format table (Signature "ASF!")
-- 
2.35.3





