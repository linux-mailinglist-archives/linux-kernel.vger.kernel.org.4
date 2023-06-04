Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6477721831
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jun 2023 17:24:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231773AbjFDPYv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jun 2023 11:24:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230354AbjFDPYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jun 2023 11:24:37 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6822D3;
        Sun,  4 Jun 2023 08:24:35 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.2.0)
 id d5d90b075636b89b; Sun, 4 Jun 2023 17:24:34 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id EC066961C82;
        Sun,  4 Jun 2023 17:24:33 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Michal Wilczynski <michal.wilczynski@intel.com>
Subject: [RFT][PATCH v1 1/4] ACPI: button: Eliminate the driver notify callback
Date:   Sun, 04 Jun 2023 17:19:06 +0200
Message-ID: <2176493.Icojqenx9y@kreacher>
In-Reply-To: <1847933.atdPhlSkOF@kreacher>
References: <1847933.atdPhlSkOF@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 195.136.19.94
X-CLIENT-HOSTNAME: 195.136.19.94
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvhedrfeeljedgkeekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepfedprhgtphhtthhopehlihhnuhigqdgrtghpihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehmihgthhgrlhdrfihilhgtiiihnhhskhhisehinhhtvghlrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=3 Fuz1=3 Fuz2=3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Rework the ACPI button driver to install notify handlers or fixed
event handlers for the devices it binds to by itself, reduce the
indentation level in its notify handler routine and drop its
notify callback.

This will allow acpi_device_install_notify_handler() and
acpi_device_remove_notify_handler() to be simplified going forward
and it will allow the driver to use different notify handlers for the
lid and for the power and sleep buttons.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/button.c |  140 ++++++++++++++++++++++++++++++++++----------------
 1 file changed, 96 insertions(+), 44 deletions(-)

Index: linux-pm/drivers/acpi/button.c
===================================================================
--- linux-pm.orig/drivers/acpi/button.c
+++ linux-pm/drivers/acpi/button.c
@@ -135,7 +135,6 @@ static const struct dmi_system_id dmi_li
 
 static int acpi_button_add(struct acpi_device *device);
 static void acpi_button_remove(struct acpi_device *device);
-static void acpi_button_notify(struct acpi_device *device, u32 event);
 
 #ifdef CONFIG_PM_SLEEP
 static int acpi_button_suspend(struct device *dev);
@@ -153,7 +152,6 @@ static struct acpi_driver acpi_button_dr
 	.ops = {
 		.add = acpi_button_add,
 		.remove = acpi_button_remove,
-		.notify = acpi_button_notify,
 	},
 	.drv.pm = &acpi_button_pm,
 };
@@ -409,45 +407,55 @@ static void acpi_lid_initialize_state(st
 	button->lid_state_initialized = true;
 }
 
-static void acpi_button_notify(struct acpi_device *device, u32 event)
+static void acpi_button_notify(acpi_handle handle, u32 event, void *data)
 {
-	struct acpi_button *button = acpi_driver_data(device);
+	struct acpi_device *device = data;
+	struct acpi_button *button;
 	struct input_dev *input;
+	int keycode;
 
-	switch (event) {
-	case ACPI_FIXED_HARDWARE_EVENT:
-		event = ACPI_BUTTON_NOTIFY_STATUS;
-		fallthrough;
-	case ACPI_BUTTON_NOTIFY_STATUS:
-		input = button->input;
-		if (button->type == ACPI_BUTTON_TYPE_LID) {
-			if (button->lid_state_initialized)
-				acpi_lid_update_state(device, true);
-		} else {
-			int keycode;
-
-			acpi_pm_wakeup_event(&device->dev);
-			if (button->suspended)
-				break;
-
-			keycode = test_bit(KEY_SLEEP, input->keybit) ?
-						KEY_SLEEP : KEY_POWER;
-			input_report_key(input, keycode, 1);
-			input_sync(input);
-			input_report_key(input, keycode, 0);
-			input_sync(input);
-
-			acpi_bus_generate_netlink_event(
-					device->pnp.device_class,
-					dev_name(&device->dev),
-					event, ++button->pushed);
-		}
-		break;
-	default:
+	if (event != ACPI_BUTTON_NOTIFY_STATUS) {
 		acpi_handle_debug(device->handle, "Unsupported event [0x%x]\n",
 				  event);
-		break;
+		return;
+	}
+
+	button = acpi_driver_data(device);
+
+	if (button->type == ACPI_BUTTON_TYPE_LID) {
+		if (button->lid_state_initialized)
+			acpi_lid_update_state(device, true);
+
+		return;
 	}
+
+	acpi_pm_wakeup_event(&device->dev);
+
+	if (button->suspended)
+		return;
+
+	input = button->input;
+	keycode = test_bit(KEY_SLEEP, input->keybit) ? KEY_SLEEP : KEY_POWER;
+
+	input_report_key(input, keycode, 1);
+	input_sync(input);
+	input_report_key(input, keycode, 0);
+	input_sync(input);
+
+	acpi_bus_generate_netlink_event(device->pnp.device_class,
+					dev_name(&device->dev),
+					event, ++button->pushed);
+}
+
+static void acpi_button_notify_run(void *data)
+{
+	acpi_button_notify(NULL, ACPI_BUTTON_NOTIFY_STATUS, data);
+}
+
+static u32 acpi_button_event(void *data)
+{
+	acpi_os_execute(OSL_NOTIFY_HANDLER, acpi_button_notify_run, data);
+	return ACPI_INTERRUPT_HANDLED;
 }
 
 #ifdef CONFIG_PM_SLEEP
@@ -492,8 +500,9 @@ static int acpi_button_add(struct acpi_d
 	struct acpi_button *button;
 	struct input_dev *input;
 	const char *hid = acpi_device_hid(device);
+	acpi_status status;
 	char *name, *class;
-	int error;
+	int error = 0;
 
 	if (!strcmp(hid, ACPI_BUTTON_HID_LID) &&
 	     lid_init_state == ACPI_BUTTON_LID_INIT_DISABLED)
@@ -535,12 +544,15 @@ static int acpi_button_add(struct acpi_d
 	} else {
 		pr_info("Unsupported hid [%s]\n", hid);
 		error = -ENODEV;
-		goto err_free_input;
 	}
 
-	error = acpi_button_add_fs(device);
-	if (error)
-		goto err_free_input;
+	if (!error)
+		error = acpi_button_add_fs(device);
+
+	if (error) {
+		input_free_device(input);
+		goto err_free_button;
+	}
 
 	snprintf(button->phys, sizeof(button->phys), "%s/button/input0", hid);
 
@@ -568,6 +580,30 @@ static int acpi_button_add(struct acpi_d
 	error = input_register_device(input);
 	if (error)
 		goto err_remove_fs;
+
+	switch (device->device_type) {
+	case ACPI_BUS_TYPE_POWER_BUTTON:
+		status = acpi_install_fixed_event_handler(ACPI_EVENT_POWER_BUTTON,
+							  acpi_button_event,
+							  device);
+		break;
+	case ACPI_BUS_TYPE_SLEEP_BUTTON:
+		status = acpi_install_fixed_event_handler(ACPI_EVENT_SLEEP_BUTTON,
+							  acpi_button_event,
+							  device);
+		break;
+	default:
+		status = acpi_install_notify_handler(device->handle,
+						     ACPI_DEVICE_NOTIFY,
+						     acpi_button_notify,
+						     device);
+		break;
+	}
+	if (ACPI_FAILURE(status)) {
+		error = -ENODEV;
+		goto err_input_unregister;
+	}
+
 	if (button->type == ACPI_BUTTON_TYPE_LID) {
 		/*
 		 * This assumes there's only one lid device, or if there are
@@ -580,11 +616,11 @@ static int acpi_button_add(struct acpi_d
 	pr_info("%s [%s]\n", name, acpi_device_bid(device));
 	return 0;
 
- err_remove_fs:
+err_input_unregister:
+	input_unregister_device(input);
+err_remove_fs:
 	acpi_button_remove_fs(device);
- err_free_input:
-	input_free_device(input);
- err_free_button:
+err_free_button:
 	kfree(button);
 	return error;
 }
@@ -593,6 +629,22 @@ static void acpi_button_remove(struct ac
 {
 	struct acpi_button *button = acpi_driver_data(device);
 
+	switch (device->device_type) {
+	case ACPI_BUS_TYPE_POWER_BUTTON:
+		acpi_remove_fixed_event_handler(ACPI_EVENT_POWER_BUTTON,
+						acpi_button_event);
+		break;
+	case ACPI_BUS_TYPE_SLEEP_BUTTON:
+		acpi_remove_fixed_event_handler(ACPI_EVENT_SLEEP_BUTTON,
+						acpi_button_event);
+		break;
+	default:
+		acpi_remove_notify_handler(device->handle, ACPI_DEVICE_NOTIFY,
+					   acpi_button_notify);
+		break;
+	}
+	acpi_os_wait_events_complete();
+
 	acpi_button_remove_fs(device);
 	input_unregister_device(button->input);
 	kfree(button);



