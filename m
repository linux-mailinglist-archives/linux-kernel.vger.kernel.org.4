Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0D9E74DC5B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 19:24:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233074AbjGJRX6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 13:23:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232646AbjGJRXk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 13:23:40 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7E5ECC;
        Mon, 10 Jul 2023 10:23:38 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.2.0)
 id 044bb7188abbf2dc; Mon, 10 Jul 2023 19:23:37 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id E2282660DCF;
        Mon, 10 Jul 2023 19:23:36 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Bob Moore <robert.moore@intel.com>,
        Saket Dumbre <saket.dumbre@intel.com>
Subject: [PATCH 07/14] ACPICA: Add interrupt command to acpiexec
Date:   Mon, 10 Jul 2023 19:16:15 +0200
Message-ID: <2240040.iZASKD2KPV@kreacher>
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

ACPICA commit ef7cf185a046d76119b631f16e7c991543c80edc

This commit add the Interrupt command to acpiexec.

The Interrupt command simulates an interrupt with a int_ID (GSIV)
equal to the first argument of the call.

The acpiexec code simulates the behaviour by OSPM: execute the _EVT
method of the GED device associated with that int_ID.

Link: https://github.com/acpica/acpica/commit/ef7cf185
Signed-off-by: Jose Marinho <jose.marinho@arm.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/acpica/acdebug.h |  2 ++
 drivers/acpi/acpica/dbcmds.c  | 58 +++++++++++++++++++++++++++++++++++
 drivers/acpi/acpica/dbinput.c |  8 +++++
 3 files changed, 68 insertions(+)

diff --git a/drivers/acpi/acpica/acdebug.h b/drivers/acpi/acpica/acdebug.h
index 22f1f7a9e5a3..911875c5a5f1 100644
--- a/drivers/acpi/acpica/acdebug.h
+++ b/drivers/acpi/acpica/acdebug.h
@@ -287,4 +287,6 @@ struct acpi_namespace_node *acpi_db_local_ns_lookup(char *name);
 
 void acpi_db_uint32_to_hex_string(u32 value, char *buffer);
 
+void acpi_db_generate_interrupt(char *gsiv_arg);
+
 #endif				/* __ACDEBUG_H__ */
diff --git a/drivers/acpi/acpica/dbcmds.c b/drivers/acpi/acpica/dbcmds.c
index 9eb68e0751c7..3d99a9048585 100644
--- a/drivers/acpi/acpica/dbcmds.c
+++ b/drivers/acpi/acpica/dbcmds.c
@@ -1010,6 +1010,64 @@ void acpi_db_display_resources(char *object_arg)
 	acpi_db_set_output_destination(ACPI_DB_CONSOLE_OUTPUT);
 }
 
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_db_generate_ged
+ *
+ * PARAMETERS:  ged_arg             - Raw GED number, ascii string
+ *
+ * RETURN:      None
+ *
+ * DESCRIPTION: Simulate firing of a GED
+ *
+ ******************************************************************************/
+
+void acpi_db_generate_interrupt(char *gsiv_arg)
+{
+	u32 gsiv_number;
+	struct acpi_ged_handler_info *ged_info = acpi_gbl_ged_handler_list;
+
+	if (!ged_info) {
+		acpi_os_printf("No GED handling present\n");
+	}
+
+	gsiv_number = strtoul(gsiv_arg, NULL, 0);
+
+	while (ged_info) {
+
+		if (ged_info->int_id == gsiv_number) {
+			struct acpi_object_list arg_list;
+			union acpi_object arg0;
+			acpi_handle evt_handle = ged_info->evt_method;
+			acpi_status status;
+
+			acpi_os_printf("Evaluate GED _EVT (GSIV=%d)\n",
+				       gsiv_number);
+
+			if (!evt_handle) {
+				acpi_os_printf("Undefined _EVT method\n");
+				return;
+			}
+
+			arg0.integer.type = ACPI_TYPE_INTEGER;
+			arg0.integer.value = gsiv_number;
+
+			arg_list.count = 1;
+			arg_list.pointer = &arg0;
+
+			status =
+			    acpi_evaluate_object(evt_handle, NULL, &arg_list,
+						 NULL);
+			if (ACPI_FAILURE(status)) {
+				acpi_os_printf("Could not evaluate _EVT\n");
+				return;
+			}
+
+		}
+		ged_info = ged_info->next;
+	}
+}
+
 #if (!ACPI_REDUCED_HARDWARE)
 /*******************************************************************************
  *
diff --git a/drivers/acpi/acpica/dbinput.c b/drivers/acpi/acpica/dbinput.c
index b8a48923064f..861b12c334ab 100644
--- a/drivers/acpi/acpica/dbinput.c
+++ b/drivers/acpi/acpica/dbinput.c
@@ -106,6 +106,7 @@ enum acpi_ex_debugger_commands {
 	CMD_THREADS,
 
 	CMD_TEST,
+	CMD_INTERRUPT,
 #endif
 };
 
@@ -185,6 +186,7 @@ static const struct acpi_db_command_info acpi_gbl_db_commands[] = {
 	{"THREADS", 3},
 
 	{"TEST", 1},
+	{"INTERRUPT", 1},
 #endif
 	{NULL, 0}
 };
@@ -318,6 +320,7 @@ static const struct acpi_db_command_help acpi_gbl_db_command_help[] = {
 	{1, "  Gpes", "Display info on all GPE devices\n"},
 	{1, "  Sci", "Generate an SCI\n"},
 	{1, "  Sleep [SleepState]", "Simulate sleep/wake sequence(s) (0-5)\n"},
+	{1, "  Interrupt <GSIV>", "Simulate an interrupt\n"},
 #endif
 	{0, NULL, NULL}
 };
@@ -1064,6 +1067,11 @@ acpi_db_command_dispatch(char *input_buffer,
 		acpi_os_printf("Event command not implemented\n");
 		break;
 
+	case CMD_INTERRUPT:
+
+		acpi_db_generate_interrupt(acpi_gbl_db_args[1]);
+		break;
+
 	case CMD_GPE:
 
 		acpi_db_generate_gpe(acpi_gbl_db_args[1], acpi_gbl_db_args[2]);
-- 
2.35.3




