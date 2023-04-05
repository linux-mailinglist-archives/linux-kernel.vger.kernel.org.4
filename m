Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECEC26D7E4D
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 16:00:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238240AbjDEOA6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 10:00:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238151AbjDEOAp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 10:00:45 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A4E04C19;
        Wed,  5 Apr 2023 07:00:43 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.1.0)
 id 1a7314477c9562e1; Wed, 5 Apr 2023 16:00:41 +0200
Received: from kreacher.localnet (unknown [213.134.163.219])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id E3CF01B4EA57;
        Wed,  5 Apr 2023 16:00:40 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Bob Moore <robert.moore@intel.com>,
        Kees Cook <kees@outflux.net>
Subject: [PATCH 29/32] ACPICA: acpi_resource_irq: Replace 1-element arrays with flexible array
Date:   Wed, 05 Apr 2023 15:56:59 +0200
Message-ID: <2105135.bB369e8A3T@kreacher>
In-Reply-To: <4845957.31r3eYUQgx@kreacher>
References: <4845957.31r3eYUQgx@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.163.219
X-CLIENT-HOSTNAME: 213.134.163.219
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvhedrvdejuddgjeduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepledtieekkeekveeikeetgffgteeuteefjeevjeegudelvdduheeiuedvieehieevnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucfkphepvddufedrudefgedrudeifedrvdduleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvudefrddufeegrdduieefrddvudelpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeegpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhosggvrhhtrdhmohhorhgvsehinhhtvghlrdgtohhmpdhrtghpthhtohepkhgvvghssehouhht
 fhhluhigrdhnvght
X-DCC--Metrics: v370.home.net.pl 1024; Body=4 Fuz1=4 Fuz2=4
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kees Cook <kees@outflux.net>

ACPICA commit bfdd3446e7caf795c85c70326c137023942972c5

Similar to "Replace one-element array with flexible-array", replace the
1-element array with a proper flexible array member as defined by C99.

This allows the code to operate without tripping compile-time and run-
time bounds checkers (e.g. via __builtin_object_size(), -fsanitize=bounds,
and/or -fstrict-flex-arrays=3). Note that the spec requires there be at
least one interrupt, so use a union to keep space allocated for this.

The only binary change in .text and .data sections is some rearrangement
by the compiler of acpi_dm_address_common(), but appears to be harmless.

Link: https://github.com/acpica/acpica/commit/bfdd3446
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/acpica/amlresrc.h |  5 ++++-
 include/acpi/acrestyp.h        | 10 ++++++++--
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/acpica/amlresrc.h b/drivers/acpi/acpica/amlresrc.h
index 48df447ef5bb..4e88f9fc2a28 100644
--- a/drivers/acpi/acpica/amlresrc.h
+++ b/drivers/acpi/acpica/amlresrc.h
@@ -261,7 +261,10 @@ struct aml_resource_address16 {
 struct aml_resource_extended_irq {
 	AML_RESOURCE_LARGE_HEADER_COMMON u8 flags;
 	u8 interrupt_count;
-	u32 interrupts[1];
+	union {
+		u32 interrupt;
+		 ACPI_FLEX_ARRAY(u32, interrupts);
+	};
 	/* res_source_index, res_source optional fields follow */
 };
 
diff --git a/include/acpi/acrestyp.h b/include/acpi/acrestyp.h
index 4c3b7b393f82..b84cd316217f 100644
--- a/include/acpi/acrestyp.h
+++ b/include/acpi/acrestyp.h
@@ -142,7 +142,10 @@ struct acpi_resource_irq {
 	u8 shareable;
 	u8 wake_capable;
 	u8 interrupt_count;
-	u8 interrupts[1];
+	union {
+		u8 interrupt;
+		 ACPI_FLEX_ARRAY(u8, interrupts);
+	};
 };
 
 struct acpi_resource_dma {
@@ -335,7 +338,10 @@ struct acpi_resource_extended_irq {
 	u8 wake_capable;
 	u8 interrupt_count;
 	struct acpi_resource_source resource_source;
-	u32 interrupts[1];
+	union {
+		u32 interrupt;
+		 ACPI_FLEX_ARRAY(u32, interrupts);
+	};
 };
 
 struct acpi_resource_generic_register {
-- 
2.35.3





