Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 717C660FFA5
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 19:59:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236047AbiJ0R7Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 13:59:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235922AbiJ0R7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 13:59:10 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 846801781C4;
        Thu, 27 Oct 2022 10:59:08 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.0.0)
 id a65cd5e508336162; Thu, 27 Oct 2022 19:59:06 +0200
Received: from kreacher.localnet (unknown [213.134.169.45])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 9A07266D838;
        Thu, 27 Oct 2022 19:59:05 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Bob Moore <robert.moore@intel.com>
Subject: [PATCH 09/11] ACPICA: Add CXL 3.0 structures (CXIMS & RDPAS) to the CEDT table
Date:   Thu, 27 Oct 2022 19:56:50 +0200
Message-ID: <1934788.usQuhbGJ8B@kreacher>
In-Reply-To: <4756726.GXAFRqVoOG@kreacher>
References: <4756726.GXAFRqVoOG@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.169.45
X-CLIENT-HOSTNAME: 213.134.169.45
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvgedrtdeggdduudejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnheptdehhfelgeevgeeifeevtddtffefieelffekveeltefftdegveekleevleefueevnecuffhomhgrihhnpegtohhmphhuthgvvgigphhrvghsshhlihhnkhdrohhrghdpghhithhhuhgsrdgtohhmnecukfhppedvudefrddufeegrdduieelrdegheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvudefrddufeegrdduieelrdeghedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepfedprhgtphhtthhopehlihhnuhigqdgrtghpihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehrohgsvghrthdrmhhoohhrvgesihhnthgv
 lhdrtghomh
X-DCC--Metrics: v370.home.net.pl 1024; Body=3 Fuz1=3 Fuz2=3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alison Schofield <alison.schofield@intel.com>

ACPICA commit 2d8dc0383d3c908389053afbdc329bbd52f009ce

The CXL 3.0 Specification [1] adds two new structures to
the CXL Early Discovery Table (CEDT). The CEDT may include
zero or more entries of these types:

CXIMS: CXL XOR Interleave Math Structure
       Enables the host to find a targets position in an
       Interleave Target List when XOR Math is used.

RDPAS: RCEC Downstream Post Association Structure
       Enables the host to locate the Downstream Port(s)
       that report errors to a given Root Complex Event
       Collector (RCEC).

Link: https://www.computeexpresslink.org/spec-landing # [1]
Link: https://github.com/acpica/acpica/commit/2d8dc038
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 include/acpi/actbl1.h |   35 ++++++++++++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

Index: linux-pm/include/acpi/actbl1.h
===================================================================
--- linux-pm.orig/include/acpi/actbl1.h
+++ linux-pm/include/acpi/actbl1.h
@@ -329,7 +329,9 @@ struct acpi_cedt_header {
 enum acpi_cedt_type {
 	ACPI_CEDT_TYPE_CHBS = 0,
 	ACPI_CEDT_TYPE_CFMWS = 1,
-	ACPI_CEDT_TYPE_RESERVED = 2,
+	ACPI_CEDT_TYPE_CXIMS = 2,
+	ACPI_CEDT_TYPE_RDPAS = 3,
+	ACPI_CEDT_TYPE_RESERVED = 4,
 };
 
 /* Values for version field above */
@@ -380,6 +382,7 @@ struct acpi_cedt_cfmws_target_element {
 /* Values for Interleave Arithmetic field above */
 
 #define ACPI_CEDT_CFMWS_ARITHMETIC_MODULO   (0)
+#define ACPI_CEDT_CFMWS_ARITHMETIC_XOR      (1)
 
 /* Values for Restrictions field above */
 
@@ -389,6 +392,36 @@ struct acpi_cedt_cfmws_target_element {
 #define ACPI_CEDT_CFMWS_RESTRICT_PMEM       (1<<3)
 #define ACPI_CEDT_CFMWS_RESTRICT_FIXED      (1<<4)
 
+/* 2: CXL XOR Interleave Math Structure */
+
+struct acpi_cedt_cxims {
+	struct acpi_cedt_header header;
+	u16 reserved1;
+	u8 hbig;
+	u8 nr_xormaps;
+	u64 xormap_list[];
+};
+
+/* 3: CXL RCEC Downstream Port Association Structure */
+
+struct acpi_cedt_rdpas {
+	struct acpi_cedt_header header;
+	u8 reserved1;
+	u16 length;
+	u16 segment;
+	u16 bdf;
+	u8 protocol;
+	u64 address;
+};
+
+/* Masks for bdf field above */
+#define ACPI_CEDT_RDPAS_BUS_MASK            0xff00
+#define ACPI_CEDT_RDPAS_DEVICE_MASK         0x00f8
+#define ACPI_CEDT_RDPAS_FUNCTION_MASK       0x0007
+
+#define ACPI_CEDT_RDPAS_PROTOCOL_IO        (0)
+#define ACPI_CEDT_RDPAS_PROTOCOL_CACHEMEM  (1)
+
 /*******************************************************************************
  *
  * CPEP - Corrected Platform Error Polling table (ACPI 4.0)



