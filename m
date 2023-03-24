Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA79B6C7EDE
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 14:33:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231854AbjCXNdz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 09:33:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231773AbjCXNdv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 09:33:51 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A0112139;
        Fri, 24 Mar 2023 06:33:47 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.1.0)
 id 7f6f03f90c81f149; Fri, 24 Mar 2023 14:33:44 +0100
Received: from kreacher.localnet (unknown [213.134.163.171])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id ED3F522A0B14;
        Fri, 24 Mar 2023 14:33:42 +0100 (CET)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>,
        Pierre Asselin <pa@panix.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Uwe =?ISO-8859-1?Q?Kleine=2DK=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Subject: [PATCH v1] ACPI: bus: Rework system-level device notification handling
Date:   Fri, 24 Mar 2023 14:33:42 +0100
Message-ID: <5687037.DvuYhMxLoT@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.163.171
X-CLIENT-HOSTNAME: 213.134.163.171
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvhedrvdegiedgheefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepgeffhfdujeelhfdtgeffkeetudfhtefhhfeiteethfekvefgvdfgfeeikeeigfehnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepvddufedrudefgedrudeifedrudejudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvudefrddufeegrdduieefrddujedupdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeehpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgrsehprghnihigrdgtohhmpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuhdrkhhlvghinhgvqdhkohgvnhhighesphgvnhhg
 uhhtrhhonhhigidruggvpdhrtghpthhtoheprhgvghhrvghsshhiohhnsheslhgvvghmhhhuihhsrdhinhhfoh
X-DCC--Metrics: v370.home.net.pl 1024; Body=5 Fuz1=5 Fuz2=5
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

For ACPI drivers that provide a ->notify() callback and set
ACPI_DRIVER_ALL_NOTIFY_EVENTS in their flags, that callback can be
invoked while either the ->add() or the ->remove() callback is running
without any synchronization at the bus type level which is counter to
the common-sense expectation that notification handling should only be
enabled when the driver is actually bound to the device.  As a result,
if the driver is not careful enough, it's ->notify() callback may crash
when it is invoked too early or too late [1].

This issue has been amplified by commit d6fb6ee1820c ("ACPI: bus: Drop
driver member of struct acpi_device") that made acpi_bus_notify() check
for the presence of the driver and its ->notify() callback directly
instead of using an extra driver pointer that was only set and cleared
by the bus type code, but it was present before that commit although
it was harder to reproduce then.

It can be addressed by using the observation that
acpi_device_install_notify_handler() can be modified to install the
handler for all types of events when ACPI_DRIVER_ALL_NOTIFY_EVENTS is
set in the driver flags, in which case acpi_bus_notify() will not need
to invoke the driver's ->notify() callback any more and that callback
will only be invoked after acpi_device_install_notify_handler() has run
and before acpi_device_remove_notify_handler() runs, which implies the
correct ordering with respect to the other ACPI driver callbacks.

Modify the code accordingly and while at it, drop two redundant local
variables from acpi_bus_notify() and turn its description comment into
a proper kerneldoc one.

Fixes: d6fb6ee1820c ("ACPI: bus: Drop driver member of struct acpi_device")
Link: https://lore.kernel.org/linux-acpi/9f6cba7a8a57e5a687c934e8e406e28c.squirrel@mail.panix.com # [1]
Reported-by: Pierre Asselin <pa@panix.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

Pierre, testing this would be much appreciated!

---
 drivers/acpi/bus.c |   83 +++++++++++++++++++++++------------------------------
 1 file changed, 37 insertions(+), 46 deletions(-)

Index: linux-pm/drivers/acpi/bus.c
===================================================================
--- linux-pm.orig/drivers/acpi/bus.c
+++ linux-pm/drivers/acpi/bus.c
@@ -459,85 +459,67 @@ out_free:
                              Notification Handling
    -------------------------------------------------------------------------- */
 
-/*
- * acpi_bus_notify
- * ---------------
- * Callback for all 'system-level' device notifications (values 0x00-0x7F).
+/**
+ * acpi_bus_notify - Global system-level (0x00-0x7F) notifications handler
+ * @handle: Target ACPI object.
+ * @type: Notification type.
+ * @data: Ignored.
+ *
+ * This only handles notifications related to device hotplug.
  */
 static void acpi_bus_notify(acpi_handle handle, u32 type, void *data)
 {
 	struct acpi_device *adev;
-	u32 ost_code = ACPI_OST_SC_NON_SPECIFIC_FAILURE;
-	bool hotplug_event = false;
 
 	switch (type) {
 	case ACPI_NOTIFY_BUS_CHECK:
 		acpi_handle_debug(handle, "ACPI_NOTIFY_BUS_CHECK event\n");
-		hotplug_event = true;
 		break;
 
 	case ACPI_NOTIFY_DEVICE_CHECK:
 		acpi_handle_debug(handle, "ACPI_NOTIFY_DEVICE_CHECK event\n");
-		hotplug_event = true;
 		break;
 
 	case ACPI_NOTIFY_DEVICE_WAKE:
 		acpi_handle_debug(handle, "ACPI_NOTIFY_DEVICE_WAKE event\n");
-		break;
+		return;
 
 	case ACPI_NOTIFY_EJECT_REQUEST:
 		acpi_handle_debug(handle, "ACPI_NOTIFY_EJECT_REQUEST event\n");
-		hotplug_event = true;
 		break;
 
 	case ACPI_NOTIFY_DEVICE_CHECK_LIGHT:
 		acpi_handle_debug(handle, "ACPI_NOTIFY_DEVICE_CHECK_LIGHT event\n");
 		/* TBD: Exactly what does 'light' mean? */
-		break;
+		return;
 
 	case ACPI_NOTIFY_FREQUENCY_MISMATCH:
 		acpi_handle_err(handle, "Device cannot be configured due "
 				"to a frequency mismatch\n");
-		break;
+		return;
 
 	case ACPI_NOTIFY_BUS_MODE_MISMATCH:
 		acpi_handle_err(handle, "Device cannot be configured due "
 				"to a bus mode mismatch\n");
-		break;
+		return;
 
 	case ACPI_NOTIFY_POWER_FAULT:
 		acpi_handle_err(handle, "Device has suffered a power fault\n");
-		break;
+		return;
 
 	default:
 		acpi_handle_debug(handle, "Unknown event type 0x%x\n", type);
-		break;
+		return;
 	}
 
 	adev = acpi_get_acpi_dev(handle);
-	if (!adev)
-		goto err;
-
-	if (adev->dev.driver) {
-		struct acpi_driver *driver = to_acpi_driver(adev->dev.driver);
-
-		if (driver && driver->ops.notify &&
-		    (driver->flags & ACPI_DRIVER_ALL_NOTIFY_EVENTS))
-			driver->ops.notify(adev, type);
-	}
-
-	if (!hotplug_event) {
-		acpi_put_acpi_dev(adev);
-		return;
-	}
 
-	if (ACPI_SUCCESS(acpi_hotplug_schedule(adev, type)))
+	if (adev && ACPI_SUCCESS(acpi_hotplug_schedule(adev, type)))
 		return;
 
 	acpi_put_acpi_dev(adev);
 
- err:
-	acpi_evaluate_ost(handle, type, ost_code, NULL);
+	acpi_evaluate_ost(handle, type, ACPI_OST_SC_NON_SPECIFIC_FAILURE, NULL);
 }
 
 static void acpi_notify_device(acpi_handle handle, u32 event, void *data)
@@ -562,42 +544,51 @@ static u32 acpi_device_fixed_event(void
 	return ACPI_INTERRUPT_HANDLED;
 }
 
-static int acpi_device_install_notify_handler(struct acpi_device *device)
+static int acpi_device_install_notify_handler(struct acpi_device *device,
+					      struct acpi_driver *acpi_drv)
 {
 	acpi_status status;
 
-	if (device->device_type == ACPI_BUS_TYPE_POWER_BUTTON)
+	if (device->device_type == ACPI_BUS_TYPE_POWER_BUTTON) {
 		status =
 		    acpi_install_fixed_event_handler(ACPI_EVENT_POWER_BUTTON,
 						     acpi_device_fixed_event,
 						     device);
-	else if (device->device_type == ACPI_BUS_TYPE_SLEEP_BUTTON)
+	} else if (device->device_type == ACPI_BUS_TYPE_SLEEP_BUTTON) {
 		status =
 		    acpi_install_fixed_event_handler(ACPI_EVENT_SLEEP_BUTTON,
 						     acpi_device_fixed_event,
 						     device);
-	else
-		status = acpi_install_notify_handler(device->handle,
-						     ACPI_DEVICE_NOTIFY,
+	} else {
+		u32 type = acpi_drv->flags & ACPI_DRIVER_ALL_NOTIFY_EVENTS ?
+				ACPI_ALL_NOTIFY : ACPI_DEVICE_NOTIFY;
+
+		status = acpi_install_notify_handler(device->handle, type,
 						     acpi_notify_device,
 						     device);
+	}
 
 	if (ACPI_FAILURE(status))
 		return -EINVAL;
 	return 0;
 }
 
-static void acpi_device_remove_notify_handler(struct acpi_device *device)
+static void acpi_device_remove_notify_handler(struct acpi_device *device,
+					      struct acpi_driver *acpi_drv)
 {
-	if (device->device_type == ACPI_BUS_TYPE_POWER_BUTTON)
+	if (device->device_type == ACPI_BUS_TYPE_POWER_BUTTON) {
 		acpi_remove_fixed_event_handler(ACPI_EVENT_POWER_BUTTON,
 						acpi_device_fixed_event);
-	else if (device->device_type == ACPI_BUS_TYPE_SLEEP_BUTTON)
+	} else if (device->device_type == ACPI_BUS_TYPE_SLEEP_BUTTON) {
 		acpi_remove_fixed_event_handler(ACPI_EVENT_SLEEP_BUTTON,
 						acpi_device_fixed_event);
-	else
-		acpi_remove_notify_handler(device->handle, ACPI_DEVICE_NOTIFY,
+	} else {
+		u32 type = acpi_drv->flags & ACPI_DRIVER_ALL_NOTIFY_EVENTS ?
+				ACPI_ALL_NOTIFY : ACPI_DEVICE_NOTIFY;
+
+		acpi_remove_notify_handler(device->handle, type,
 					   acpi_notify_device);
+	}
 }
 
 /* Handle events targeting \_SB device (at present only graceful shutdown) */
@@ -1039,7 +1030,7 @@ static int acpi_device_probe(struct devi
 		 acpi_drv->name, acpi_dev->pnp.bus_id);
 
 	if (acpi_drv->ops.notify) {
-		ret = acpi_device_install_notify_handler(acpi_dev);
+		ret = acpi_device_install_notify_handler(acpi_dev, acpi_drv);
 		if (ret) {
 			if (acpi_drv->ops.remove)
 				acpi_drv->ops.remove(acpi_dev);
@@ -1062,7 +1053,7 @@ static void acpi_device_remove(struct de
 	struct acpi_driver *acpi_drv = to_acpi_driver(dev->driver);
 
 	if (acpi_drv->ops.notify)
-		acpi_device_remove_notify_handler(acpi_dev);
+		acpi_device_remove_notify_handler(acpi_dev, acpi_drv);
 
 	if (acpi_drv->ops.remove)
 		acpi_drv->ops.remove(acpi_dev);



