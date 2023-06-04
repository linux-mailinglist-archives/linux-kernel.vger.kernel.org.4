Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CC3F721830
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jun 2023 17:24:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229569AbjFDPYo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jun 2023 11:24:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230005AbjFDPYg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jun 2023 11:24:36 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 118FBD2;
        Sun,  4 Jun 2023 08:24:34 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.2.0)
 id 80b17cd337c071f1; Sun, 4 Jun 2023 17:24:33 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 1D1C1961C82;
        Sun,  4 Jun 2023 17:24:33 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Michal Wilczynski <michal.wilczynski@intel.com>
Subject: [RFT][PATCH v1 2/4] ACPI: button: Use different notify handlers for lid and buttons
Date:   Sun, 04 Jun 2023 17:20:27 +0200
Message-ID: <2438693.jE0xQCEvom@kreacher>
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

Since the lid handling in acpi_button_notify() is special, introduce
acpi_lid_notify() specifically for handling lid notifications.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/button.c |   33 ++++++++++++++++++++++++---------
 1 file changed, 24 insertions(+), 9 deletions(-)

Index: linux-pm/drivers/acpi/button.c
===================================================================
--- linux-pm.orig/drivers/acpi/button.c
+++ linux-pm/drivers/acpi/button.c
@@ -407,12 +407,10 @@ static void acpi_lid_initialize_state(st
 	button->lid_state_initialized = true;
 }
 
-static void acpi_button_notify(acpi_handle handle, u32 event, void *data)
+static void acpi_lid_notify(acpi_handle handle, u32 event, void *data)
 {
 	struct acpi_device *device = data;
 	struct acpi_button *button;
-	struct input_dev *input;
-	int keycode;
 
 	if (event != ACPI_BUTTON_NOTIFY_STATUS) {
 		acpi_handle_debug(device->handle, "Unsupported event [0x%x]\n",
@@ -421,16 +419,28 @@ static void acpi_button_notify(acpi_hand
 	}
 
 	button = acpi_driver_data(device);
+	if (!button->lid_state_initialized)
+		return;
 
-	if (button->type == ACPI_BUTTON_TYPE_LID) {
-		if (button->lid_state_initialized)
-			acpi_lid_update_state(device, true);
+	acpi_lid_update_state(device, true);
+}
 
+static void acpi_button_notify(acpi_handle handle, u32 event, void *data)
+{
+	struct acpi_device *device = data;
+	struct acpi_button *button;
+	struct input_dev *input;
+	int keycode;
+
+	if (event != ACPI_BUTTON_NOTIFY_STATUS) {
+		acpi_handle_debug(device->handle, "Unsupported event [0x%x]\n",
+				  event);
 		return;
 	}
 
 	acpi_pm_wakeup_event(&device->dev);
 
+	button = acpi_driver_data(device);
 	if (button->suspended)
 		return;
 
@@ -497,6 +507,7 @@ static int acpi_lid_input_open(struct in
 
 static int acpi_button_add(struct acpi_device *device)
 {
+	acpi_notify_handler handler;
 	struct acpi_button *button;
 	struct input_dev *input;
 	const char *hid = acpi_device_hid(device);
@@ -526,17 +537,20 @@ static int acpi_button_add(struct acpi_d
 	if (!strcmp(hid, ACPI_BUTTON_HID_POWER) ||
 	    !strcmp(hid, ACPI_BUTTON_HID_POWERF)) {
 		button->type = ACPI_BUTTON_TYPE_POWER;
+		handler = acpi_button_notify;
 		strcpy(name, ACPI_BUTTON_DEVICE_NAME_POWER);
 		sprintf(class, "%s/%s",
 			ACPI_BUTTON_CLASS, ACPI_BUTTON_SUBCLASS_POWER);
 	} else if (!strcmp(hid, ACPI_BUTTON_HID_SLEEP) ||
 		   !strcmp(hid, ACPI_BUTTON_HID_SLEEPF)) {
 		button->type = ACPI_BUTTON_TYPE_SLEEP;
+		handler = acpi_button_notify;
 		strcpy(name, ACPI_BUTTON_DEVICE_NAME_SLEEP);
 		sprintf(class, "%s/%s",
 			ACPI_BUTTON_CLASS, ACPI_BUTTON_SUBCLASS_SLEEP);
 	} else if (!strcmp(hid, ACPI_BUTTON_HID_LID)) {
 		button->type = ACPI_BUTTON_TYPE_LID;
+		handler = acpi_lid_notify;
 		strcpy(name, ACPI_BUTTON_DEVICE_NAME_LID);
 		sprintf(class, "%s/%s",
 			ACPI_BUTTON_CLASS, ACPI_BUTTON_SUBCLASS_LID);
@@ -594,8 +608,7 @@ static int acpi_button_add(struct acpi_d
 		break;
 	default:
 		status = acpi_install_notify_handler(device->handle,
-						     ACPI_DEVICE_NOTIFY,
-						     acpi_button_notify,
+						     ACPI_DEVICE_NOTIFY, handler,
 						     device);
 		break;
 	}
@@ -640,7 +653,9 @@ static void acpi_button_remove(struct ac
 		break;
 	default:
 		acpi_remove_notify_handler(device->handle, ACPI_DEVICE_NOTIFY,
-					   acpi_button_notify);
+					   button->type == ACPI_BUTTON_TYPE_LID ?
+					   	acpi_lid_notify :
+					   	acpi_button_notify);
 		break;
 	}
 	acpi_os_wait_events_complete();



