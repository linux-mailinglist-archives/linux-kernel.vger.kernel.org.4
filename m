Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18BF774DC5C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 19:24:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233084AbjGJRYB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 13:24:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232603AbjGJRXk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 13:23:40 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8977B128;
        Mon, 10 Jul 2023 10:23:39 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.2.0)
 id 218b389494225233; Mon, 10 Jul 2023 19:23:38 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id A2206660DCF;
        Mon, 10 Jul 2023 19:23:37 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Bob Moore <robert.moore@intel.com>,
        Saket Dumbre <saket.dumbre@intel.com>
Subject: [PATCH 06/14] ACPICA: Detect GED device and keep track of _EVT
Date:   Mon, 10 Jul 2023 19:15:27 +0200
Message-ID: <8250865.T7Z3S40VBb@kreacher>
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

From: Jose Marinho <jose.marinho@arm.com>

ACPICA commit dc6fd1d12903015726a8a6f87f63e86141576a68

The GED device is described by a _HID of ACPI0013.
This code traverses the namespace identifying all GED devices.
For each GED device in the namespace we record 1) the Interrupt objects
and the _EVT method.

This information is used when an interrupt is simulate.

Link: https://github.com/acpica/acpica/commit/dc6fd1d1
Signed-off-by: Jose Marinho <jose.marinho@arm.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/acpica/acglobal.h | 1 +
 drivers/acpi/acpica/aclocal.h  | 8 ++++++++
 include/acpi/acnames.h         | 1 +
 3 files changed, 10 insertions(+)

diff --git a/drivers/acpi/acpica/acglobal.h b/drivers/acpi/acpica/acglobal.h
index 778241173ed4..f4c90fc99be2 100644
--- a/drivers/acpi/acpica/acglobal.h
+++ b/drivers/acpi/acpica/acglobal.h
@@ -129,6 +129,7 @@ ACPI_GLOBAL(acpi_table_handler, acpi_gbl_table_handler);
 ACPI_GLOBAL(void *, acpi_gbl_table_handler_context);
 ACPI_GLOBAL(acpi_interface_handler, acpi_gbl_interface_handler);
 ACPI_GLOBAL(struct acpi_sci_handler_info *, acpi_gbl_sci_handler_list);
+ACPI_GLOBAL(struct acpi_ged_handler_info *, acpi_gbl_ged_handler_list);
 
 /* Owner ID support */
 
diff --git a/drivers/acpi/acpica/aclocal.h b/drivers/acpi/acpica/aclocal.h
index 75a81b6c1a16..82563b44af35 100644
--- a/drivers/acpi/acpica/aclocal.h
+++ b/drivers/acpi/acpica/aclocal.h
@@ -543,6 +543,14 @@ struct acpi_field_info {
 	u32 pkg_length;
 };
 
+/* Information about the interrupt ID and _EVT of a GED device */
+
+struct acpi_ged_handler_info {
+	struct acpi_ged_handler_info *next;
+	u32 int_id;		/* The interrupt ID that triggers the execution ofthe evt_method. */
+	struct acpi_namespace_node *evt_method;	/* The _EVT method to be executed when an interrupt with ID = int_ID is received */
+};
+
 /*****************************************************************************
  *
  * Generic "state" object for stacks
diff --git a/include/acpi/acnames.h b/include/acpi/acnames.h
index d71291f25a80..76aa6aa346ba 100644
--- a/include/acpi/acnames.h
+++ b/include/acpi/acnames.h
@@ -22,6 +22,7 @@
 #define METHOD_NAME__DDN        "_DDN"
 #define METHOD_NAME__DIS        "_DIS"
 #define METHOD_NAME__DMA        "_DMA"
+#define METHOD_NAME__EVT        "_EVT"
 #define METHOD_NAME__HID        "_HID"
 #define METHOD_NAME__INI        "_INI"
 #define METHOD_NAME__PLD        "_PLD"
-- 
2.35.3




