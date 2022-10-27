Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EC3860FFAA
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 19:59:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236136AbiJ0R7l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 13:59:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235988AbiJ0R7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 13:59:23 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C99B17D2B8;
        Thu, 27 Oct 2022 10:59:14 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.0.0)
 id eba0afe75c2e45be; Thu, 27 Oct 2022 19:59:12 +0200
Received: from kreacher.localnet (unknown [213.134.169.45])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 4D35066D838;
        Thu, 27 Oct 2022 19:59:11 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Bob Moore <robert.moore@intel.com>
Subject: [PATCH 05/11] ACPICA: iASL: Add CCEL table to both compiler/disassembler
Date:   Thu, 27 Oct 2022 19:51:51 +0200
Message-ID: <7449231.EvYhyI6sBW@kreacher>
In-Reply-To: <4756726.GXAFRqVoOG@kreacher>
References: <4756726.GXAFRqVoOG@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.169.45
X-CLIENT-HOSTNAME: 213.134.169.45
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvgedrtdeggdduudejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepledtieekkeekveeikeetgffgteeuteefjeevjeegudelvdduheeiuedvieehieevnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucfkphepvddufedrudefgedrudeiledrgeehnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehinhgvthepvddufedrudefgedrudeiledrgeehpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeefpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhosggvrhhtrdhmohhorhgvsehinhhtvghlrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=3 Fuz1=3 Fuz2=3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

ACPICA commit 10e4763f155eac0c60295a7e364b0316fc52c4f1

Link: https://github.com/acpica/acpica/commit/10e4763f
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 include/acpi/actbl2.h |   18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

Index: linux-pm/include/acpi/actbl2.h
===================================================================
--- linux-pm.orig/include/acpi/actbl2.h
+++ linux-pm/include/acpi/actbl2.h
@@ -27,6 +27,7 @@
 #define ACPI_SIG_AGDI           "AGDI"	/* Arm Generic Diagnostic Dump and Reset Device Interface */
 #define ACPI_SIG_APMT           "APMT"	/* Arm Performance Monitoring Unit table */
 #define ACPI_SIG_BDAT           "BDAT"	/* BIOS Data ACPI Table */
+#define ACPI_SIG_CCEL           "CCEL"	/* CC Event Log Table */
 #define ACPI_SIG_IORT           "IORT"	/* IO Remapping Table */
 #define ACPI_SIG_IVRS           "IVRS"	/* I/O Virtualization Reporting Structure */
 #define ACPI_SIG_LPIT           "LPIT"	/* Low Power Idle Table */
@@ -353,6 +354,23 @@ struct acpi_table_bdat {
 };
 
 /*******************************************************************************
+ *
+ * CCEL - CC-Event Log
+ *        From: "Guest-Host-Communication Interface (GHCI) for Intel
+ *        Trust Domain Extensions (Intel TDX)". Feb 2022
+ *
+ ******************************************************************************/
+
+struct acpi_table_ccel {
+	struct acpi_table_header header;	/* Common ACPI table header */
+	u8 CCtype;
+	u8 Ccsub_type;
+	u16 reserved;
+	u64 log_area_minimum_length;
+	u64 log_area_start_address;
+};
+
+/*******************************************************************************
  *
  * IORT - IO Remapping Table
  *



