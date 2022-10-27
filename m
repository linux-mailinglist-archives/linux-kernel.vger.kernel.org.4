Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6798D60FFAD
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 20:00:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236172AbiJ0SAD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 14:00:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236019AbiJ0R7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 13:59:25 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7568B17F9BB;
        Thu, 27 Oct 2022 10:59:16 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.0.0)
 id fe07034ed0e76a0e; Thu, 27 Oct 2022 19:59:14 +0200
Received: from kreacher.localnet (unknown [213.134.169.45])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 70A4766D83E;
        Thu, 27 Oct 2022 19:59:13 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Bob Moore <robert.moore@intel.com>
Subject: [PATCH 04/11] ACPICA: Do not touch VGA memory when EBDA < 1ki_b
Date:   Thu, 27 Oct 2022 19:50:59 +0200
Message-ID: <1914944.PYKUYFuaPT@kreacher>
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

From: Vit Kabele <vit@kabele.me>

ACPICA commit a36eda9631e84f271319c41288889dd5b1329369

The ACPICA code assumes that EBDA region must be at least 1ki_b in size.
Because this is not guaranteed, it might happen that while scanning the
memory for RSDP pointer, the kernel touches memory above 640ki_b.

This is unwanted as the VGA memory range may not be decoded or
even present when running under virtualization.

Link: https://github.com/acpica/acpica/commit/a36eda96
Signed-off-by: Vit Kabele <vit@kabele.me>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/acpica/tbxfroot.c |   22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

Index: linux-pm/drivers/acpi/acpica/tbxfroot.c
===================================================================
--- linux-pm.orig/drivers/acpi/acpica/tbxfroot.c
+++ linux-pm/drivers/acpi/acpica/tbxfroot.c
@@ -114,6 +114,7 @@ acpi_find_root_pointer(acpi_physical_add
 	u8 *table_ptr;
 	u8 *mem_rover;
 	u32 physical_address;
+	u32 ebda_window_size;
 
 	ACPI_FUNCTION_TRACE(acpi_find_root_pointer);
 
@@ -145,24 +146,31 @@ acpi_find_root_pointer(acpi_physical_add
 	 */
 	if (physical_address > 0x400 && physical_address < 0xA0000) {
 		/*
-		 * 1b) Search EBDA paragraphs (EBDA is required to be a
-		 *     minimum of 1K length)
+		 * Calculate the scan window size
+		 * The EBDA is not guaranteed to be larger than a ki_b and in case
+		 * that it is smaller, the scanning function would leave the low
+		 * memory and continue to the VGA range.
+		 */
+		ebda_window_size = ACPI_MIN(ACPI_EBDA_WINDOW_SIZE,
+					    0xA0000 - physical_address);
+
+		/*
+		 * 1b) Search EBDA paragraphs
 		 */
 		table_ptr = acpi_os_map_memory((acpi_physical_address)
 					       physical_address,
-					       ACPI_EBDA_WINDOW_SIZE);
+					       ebda_window_size);
 		if (!table_ptr) {
 			ACPI_ERROR((AE_INFO,
 				    "Could not map memory at 0x%8.8X for length %u",
-				    physical_address, ACPI_EBDA_WINDOW_SIZE));
+				    physical_address, ebda_window_size));
 
 			return_ACPI_STATUS(AE_NO_MEMORY);
 		}
 
 		mem_rover =
-		    acpi_tb_scan_memory_for_rsdp(table_ptr,
-						 ACPI_EBDA_WINDOW_SIZE);
-		acpi_os_unmap_memory(table_ptr, ACPI_EBDA_WINDOW_SIZE);
+		    acpi_tb_scan_memory_for_rsdp(table_ptr, ebda_window_size);
+		acpi_os_unmap_memory(table_ptr, ebda_window_size);
 
 		if (mem_rover) {
 



