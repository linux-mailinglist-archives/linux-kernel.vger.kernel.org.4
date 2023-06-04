Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD8EF72182C
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jun 2023 17:24:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230513AbjFDPYh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jun 2023 11:24:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjFDPYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jun 2023 11:24:35 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63349CE;
        Sun,  4 Jun 2023 08:24:34 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.2.0)
 id 4b94dd63f174b4c0; Sun, 4 Jun 2023 17:24:32 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 69A92961C82;
        Sun,  4 Jun 2023 17:24:32 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Michal Wilczynski <michal.wilczynski@intel.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Hanjun Guo <guohanjun@huawei.com>
Subject: [RFT][PATCH v1 3/4] ACPI: tiny-power-button: Eliminate the driver notify callback
Date:   Sun, 04 Jun 2023 17:22:48 +0200
Message-ID: <5392458.Sb9uPGUboI@kreacher>
In-Reply-To: <1847933.atdPhlSkOF@kreacher>
References: <1847933.atdPhlSkOF@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 195.136.19.94
X-CLIENT-HOSTNAME: 195.136.19.94
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvhedrfeeljedgkeekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohephedprhgtphhtthhopehlihhnuhigqdgrtghpihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehmihgthhgrlhdrfihilhgtiiihnhhskhhisehinhhtvghlrdgtohhmpdhrtghpthhtohepjhhoshhhsehjohhshhhtrhhiphhlvghtthdrohhrghdprhgtphht
 thhopehguhhohhgrnhhjuhhnsehhuhgrfigvihdrtghomh
X-DCC--Metrics: v370.home.net.pl 1024; Body=5 Fuz1=5 Fuz2=5
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Rework the ACPI tiny-power-button driver to install a notify handler or
a fixed event handler for the device it binds to by itself and drop its
notify callback.

This will allow acpi_device_install_notify_handler() and
acpi_device_remove_notify_handler() to be simplified going forward.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/tiny-power-button.c |   49 ++++++++++++++++++++++++++++++++-------
 1 file changed, 41 insertions(+), 8 deletions(-)

Index: linux-pm/drivers/acpi/tiny-power-button.c
===================================================================
--- linux-pm.orig/drivers/acpi/tiny-power-button.c
+++ linux-pm/drivers/acpi/tiny-power-button.c
@@ -19,18 +19,52 @@ static const struct acpi_device_id tiny_
 };
 MODULE_DEVICE_TABLE(acpi, tiny_power_button_device_ids);
 
-static int acpi_noop_add(struct acpi_device *device)
+static void acpi_tiny_power_button_notify(acpi_handle handle, u32 event, void *data)
 {
-	return 0;
+	kill_cad_pid(power_signal, 1);
 }
 
-static void acpi_noop_remove(struct acpi_device *device)
+static void acpi_tiny_power_button_notify_run(void *not_used)
 {
+	acpi_tiny_power_button_notify(NULL, ACPI_FIXED_HARDWARE_EVENT, NULL);
 }
 
-static void acpi_tiny_power_button_notify(struct acpi_device *device, u32 event)
+static u32 acpi_tiny_power_button_event(void *not_used)
 {
-	kill_cad_pid(power_signal, 1);
+	acpi_os_execute(OSL_NOTIFY_HANDLER, acpi_tiny_power_button_notify_run, NULL);
+	return ACPI_INTERRUPT_HANDLED;
+}
+
+static int acpi_tiny_power_button_add(struct acpi_device *device)
+{
+	acpi_status status;
+
+	if (device->device_type == ACPI_BUS_TYPE_POWER_BUTTON) {
+		status = acpi_install_fixed_event_handler(ACPI_EVENT_POWER_BUTTON,
+							  acpi_tiny_power_button_event,
+							  NULL);
+	} else {
+		status = acpi_install_notify_handler(device->handle,
+						     ACPI_DEVICE_NOTIFY,
+						     acpi_tiny_power_button_notify,
+						     NULL);
+	}
+	if (ACPI_FAILURE(status))
+		return -ENODEV;
+
+	return 0;
+}
+
+static void acpi_tiny_power_button_remove(struct acpi_device *device)
+{
+	if (device->device_type == ACPI_BUS_TYPE_POWER_BUTTON) {
+		acpi_remove_fixed_event_handler(ACPI_EVENT_POWER_BUTTON,
+						acpi_tiny_power_button_event);
+	} else {
+		acpi_remove_notify_handler(device->handle, ACPI_DEVICE_NOTIFY,
+					   acpi_tiny_power_button_notify);
+	}
+	acpi_os_wait_events_complete();
 }
 
 static struct acpi_driver acpi_tiny_power_button_driver = {
@@ -38,9 +72,8 @@ static struct acpi_driver acpi_tiny_powe
 	.class = "tiny-power-button",
 	.ids = tiny_power_button_device_ids,
 	.ops = {
-		.add = acpi_noop_add,
-		.remove = acpi_noop_remove,
-		.notify = acpi_tiny_power_button_notify,
+		.add = acpi_tiny_power_button_add,
+		.remove = acpi_tiny_power_button_remove,
 	},
 };
 



