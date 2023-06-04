Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5106272182F
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jun 2023 17:24:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231326AbjFDPYl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jun 2023 11:24:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjFDPYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jun 2023 11:24:35 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 632CBCD;
        Sun,  4 Jun 2023 08:24:34 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.2.0)
 id 08b175b11797ce0d; Sun, 4 Jun 2023 17:24:32 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id B326F961C82;
        Sun,  4 Jun 2023 17:24:31 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Michal Wilczynski <michal.wilczynski@intel.com>
Subject: [RFT][PATCH v1 4/4] ACPI: bus: Simplify installation and removal of notify callback
Date:   Sun, 04 Jun 2023 17:23:40 +0200
Message-ID: <2130740.OBFZWjSADL@kreacher>
In-Reply-To: <1847933.atdPhlSkOF@kreacher>
References: <1847933.atdPhlSkOF@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 195.136.19.94
X-CLIENT-HOSTNAME: 195.136.19.94
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvhedrfeeljedgkeelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepfedprhgtphhtthhopehlihhnuhigqdgrtghpihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehmihgthhgrlhdrfihilhgtiiihnhhskhhisehinhhtvghlrdgtohhm
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

Because the only drivers that cared about button fixed events take care
of those events by themselves now, eliminate the code related to them
from acpi_device_install_notify_handler() and
acpi_device_remove_notify_handler().

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/bus.c |   53 +++++++++--------------------------------------------
 1 file changed, 9 insertions(+), 44 deletions(-)

Index: linux-pm/drivers/acpi/bus.c
===================================================================
--- linux-pm.orig/drivers/acpi/bus.c
+++ linux-pm/drivers/acpi/bus.c
@@ -530,65 +530,30 @@ static void acpi_notify_device(acpi_hand
 	acpi_drv->ops.notify(device, event);
 }
 
-static void acpi_notify_device_fixed(void *data)
-{
-	struct acpi_device *device = data;
-
-	/* Fixed hardware devices have no handles */
-	acpi_notify_device(NULL, ACPI_FIXED_HARDWARE_EVENT, device);
-}
-
-static u32 acpi_device_fixed_event(void *data)
-{
-	acpi_os_execute(OSL_NOTIFY_HANDLER, acpi_notify_device_fixed, data);
-	return ACPI_INTERRUPT_HANDLED;
-}
-
 static int acpi_device_install_notify_handler(struct acpi_device *device,
 					      struct acpi_driver *acpi_drv)
 {
-	acpi_status status;
-
-	if (device->device_type == ACPI_BUS_TYPE_POWER_BUTTON) {
-		status =
-		    acpi_install_fixed_event_handler(ACPI_EVENT_POWER_BUTTON,
-						     acpi_device_fixed_event,
-						     device);
-	} else if (device->device_type == ACPI_BUS_TYPE_SLEEP_BUTTON) {
-		status =
-		    acpi_install_fixed_event_handler(ACPI_EVENT_SLEEP_BUTTON,
-						     acpi_device_fixed_event,
-						     device);
-	} else {
-		u32 type = acpi_drv->flags & ACPI_DRIVER_ALL_NOTIFY_EVENTS ?
+	u32 type = acpi_drv->flags & ACPI_DRIVER_ALL_NOTIFY_EVENTS ?
 				ACPI_ALL_NOTIFY : ACPI_DEVICE_NOTIFY;
+	acpi_status status;
 
-		status = acpi_install_notify_handler(device->handle, type,
-						     acpi_notify_device,
-						     device);
-	}
-
+	status = acpi_install_notify_handler(device->handle, type,
+					     acpi_notify_device, device);
 	if (ACPI_FAILURE(status))
 		return -EINVAL;
+
 	return 0;
 }
 
 static void acpi_device_remove_notify_handler(struct acpi_device *device,
 					      struct acpi_driver *acpi_drv)
 {
-	if (device->device_type == ACPI_BUS_TYPE_POWER_BUTTON) {
-		acpi_remove_fixed_event_handler(ACPI_EVENT_POWER_BUTTON,
-						acpi_device_fixed_event);
-	} else if (device->device_type == ACPI_BUS_TYPE_SLEEP_BUTTON) {
-		acpi_remove_fixed_event_handler(ACPI_EVENT_SLEEP_BUTTON,
-						acpi_device_fixed_event);
-	} else {
-		u32 type = acpi_drv->flags & ACPI_DRIVER_ALL_NOTIFY_EVENTS ?
+	u32 type = acpi_drv->flags & ACPI_DRIVER_ALL_NOTIFY_EVENTS ?
 				ACPI_ALL_NOTIFY : ACPI_DEVICE_NOTIFY;
 
-		acpi_remove_notify_handler(device->handle, type,
-					   acpi_notify_device);
-	}
+	acpi_remove_notify_handler(device->handle, type,
+				   acpi_notify_device);
+
 	acpi_os_wait_events_complete();
 }
 



