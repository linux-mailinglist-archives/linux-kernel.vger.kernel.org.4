Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BC1B7032F2
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 18:31:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242706AbjEOQa6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 12:30:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241920AbjEOQa4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 12:30:56 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAC6495;
        Mon, 15 May 2023 09:30:54 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.1.0)
 id 93da85eeb3bfeff5; Mon, 15 May 2023 18:30:52 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 1461A795F02;
        Mon, 15 May 2023 18:30:52 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: [PATCH] ACPI: scan: Reduce overhead related to devices with dependencies
Date:   Mon, 15 May 2023 18:30:51 +0200
Message-ID: <2694293.mvXUDI8C0e@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 195.136.19.94
X-CLIENT-HOSTNAME: 195.136.19.94
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvhedrfeehjedguddtvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpeffffffkefgheehffelteeiveeffeevhfelteejvddvieejjeelvdeiheeuveeuffenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeegpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohephhguvghgohgvuggvsehrvgguhhgrthdrtghomhdprhgtphhtthhopehsrghkrghrihdrrghilhhusheslhhinhhugidrihhnthgvlhdrtghomh
X-DCC--Metrics: v370.home.net.pl 1024; Body=4 Fuz1=4 Fuz2=4
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Notice that all of the objects for which the acpi_scan_check_dep()
return value is greater than 0 are present in acpi_dep_list as consumers
(there may be multiple entries for one object, but that is not a
problem), so after carrying out the initial ACPI namespace walk in which
devices with dependencies are skipped, acpi_bus_scan() can simply walk
acpi_dep_list and enumerate all of the unique consumer objects from
there and their descendants instead of walking the entire target branch
of the ACPI namespace and looking for device objects that have not been
enumerated yet in it.

Because walking acpi_dep_list is generally less overhead than walking
the entire ACPI namespace, use the observation above to reduce the
system initialization overhead related to ACPI, which is particularly
important on large systems.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/scan.c     |   79 +++++++++++++++++++++++++++++++++++-------------
 include/acpi/acpi_bus.h |    2 +
 2 files changed, 61 insertions(+), 20 deletions(-)

Index: linux-pm/include/acpi/acpi_bus.h
===================================================================
--- linux-pm.orig/include/acpi/acpi_bus.h
+++ linux-pm/include/acpi/acpi_bus.h
@@ -289,6 +289,8 @@ struct acpi_dep_data {
 	acpi_handle supplier;
 	acpi_handle consumer;
 	bool honor_dep;
+	bool met;
+	bool free_when_met;
 };
 
 /* Performance Management */
Index: linux-pm/drivers/acpi/scan.c
===================================================================
--- linux-pm.orig/drivers/acpi/scan.c
+++ linux-pm/drivers/acpi/scan.c
@@ -2029,8 +2029,6 @@ static u32 acpi_scan_check_dep(acpi_hand
 	return count;
 }
 
-static bool acpi_bus_scan_second_pass;
-
 static acpi_status acpi_bus_check_add(acpi_handle handle, bool check_dep,
 				      struct acpi_device **adev_p)
 {
@@ -2050,10 +2048,8 @@ static acpi_status acpi_bus_check_add(ac
 			return AE_OK;
 
 		/* Bail out if there are dependencies. */
-		if (acpi_scan_check_dep(handle, check_dep) > 0) {
-			acpi_bus_scan_second_pass = true;
+		if (acpi_scan_check_dep(handle, check_dep) > 0)
 			return AE_CTRL_DEPTH;
-		}
 
 		fallthrough;
 	case ACPI_TYPE_ANY:	/* for ACPI_ROOT_OBJECT */
@@ -2301,6 +2297,12 @@ static bool acpi_scan_clear_dep_queue(st
 	return true;
 }
 
+static void acpi_scan_delete_dep_data(struct acpi_dep_data *dep)
+{
+	list_del(&dep->node);
+	kfree(dep);
+}
+
 static int acpi_scan_clear_dep(struct acpi_dep_data *dep, void *data)
 {
 	struct acpi_device *adev = acpi_get_acpi_dev(dep->consumer);
@@ -2311,8 +2313,10 @@ static int acpi_scan_clear_dep(struct ac
 			acpi_dev_put(adev);
 	}
 
-	list_del(&dep->node);
-	kfree(dep);
+	if (dep->free_when_met)
+		acpi_scan_delete_dep_data(dep);
+	else
+		dep->met = true;
 
 	return 0;
 }
@@ -2406,6 +2410,53 @@ struct acpi_device *acpi_dev_get_next_co
 }
 EXPORT_SYMBOL_GPL(acpi_dev_get_next_consumer_dev);
 
+static void acpi_scan_postponed_branch(acpi_handle handle)
+{
+	struct acpi_device *adev = NULL;
+
+	if (ACPI_FAILURE(acpi_bus_check_add(handle, false, &adev)))
+		return;
+
+	acpi_walk_namespace(ACPI_TYPE_ANY, handle, ACPI_UINT32_MAX,
+			    acpi_bus_check_add_2, NULL, NULL, (void **)&adev);
+	acpi_bus_attach(adev, NULL);
+}
+
+static void acpi_scan_postponed(void)
+{
+	struct acpi_dep_data *dep, *tmp;
+
+	mutex_lock(&acpi_dep_list_lock);
+
+	list_for_each_entry_safe(dep, tmp, &acpi_dep_list, node) {
+		acpi_handle handle = dep->consumer;
+
+		/*
+		 * Even though the lock is released here, tmp is guaranteed to
+		 * be valid, because none of the list entries following dep is
+		 * marked as "free when met" and so they cannot be deleted.
+		 */
+		mutex_unlock(&acpi_dep_list_lock);
+
+		/*
+		 * In case there are multiple acpi_dep_list entries with the
+		 * same consumer, skip the current entry if the consumer device
+		 * object corresponding to it is present already.
+		 */
+		if (!acpi_fetch_acpi_dev(handle))
+			acpi_scan_postponed_branch(handle);
+
+		mutex_lock(&acpi_dep_list_lock);
+
+		if (dep->met)
+			acpi_scan_delete_dep_data(dep);
+		else
+			dep->free_when_met = true;
+	}
+
+	mutex_unlock(&acpi_dep_list_lock);
+}
+
 /**
  * acpi_bus_scan - Add ACPI device node objects in a given namespace scope.
  * @handle: Root of the namespace scope to scan.
@@ -2424,8 +2475,6 @@ int acpi_bus_scan(acpi_handle handle)
 {
 	struct acpi_device *device = NULL;
 
-	acpi_bus_scan_second_pass = false;
-
 	/* Pass 1: Avoid enumerating devices with missing dependencies. */
 
 	if (ACPI_SUCCESS(acpi_bus_check_add(handle, true, &device)))
@@ -2438,19 +2487,9 @@ int acpi_bus_scan(acpi_handle handle)
 
 	acpi_bus_attach(device, (void *)true);
 
-	if (!acpi_bus_scan_second_pass)
-		return 0;
-
 	/* Pass 2: Enumerate all of the remaining devices. */
 
-	device = NULL;
-
-	if (ACPI_SUCCESS(acpi_bus_check_add(handle, false, &device)))
-		acpi_walk_namespace(ACPI_TYPE_ANY, handle, ACPI_UINT32_MAX,
-				    acpi_bus_check_add_2, NULL, NULL,
-				    (void **)&device);
-
-	acpi_bus_attach(device, NULL);
+	acpi_scan_postponed();
 
 	return 0;
 }



