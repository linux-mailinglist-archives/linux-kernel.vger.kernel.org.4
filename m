Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7119670F5A1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 13:49:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232990AbjEXLtE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 07:49:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231947AbjEXLsq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 07:48:46 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BFB7189;
        Wed, 24 May 2023 04:48:33 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.2.0)
 id ca10f55b2dd24e7e; Wed, 24 May 2023 13:48:32 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 07B7669D7E2;
        Wed, 24 May 2023 13:48:32 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 2/6] ACPI: scan: Extract CSI-2 connection graph from _CRS
Date:   Wed, 24 May 2023 13:43:11 +0200
Message-ID: <7531225.EvYhyI6sBW@kreacher>
In-Reply-To: <13276375.uLZWGnKmhe@kreacher>
References: <13276375.uLZWGnKmhe@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 195.136.19.94
X-CLIENT-HOSTNAME: 195.136.19.94
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvhedrfeejhedggeefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepkedtvdevieejkeevkedvffeiffehiedtheekkeefieehffekgfeltdehleehvddunecuffhomhgrihhnpehuvghfihdrohhrghenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeehpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshgrkhgrrhhirdgrihhluhhssehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohephhguvghgohgvuggv
 sehrvgguhhgrthdrtghomhdprhgtphhtthhopegrnhgurhhihidrshhhvghvtghhvghnkhhosehlihhnuhigrdhinhhtvghlrdgtohhm
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

Find ACPI CSI-2 resource descriptors defined since ACPI 6.4 (for
CSI-2 and camera configuration) in _CRS for all device objects in
the given scope of the ACPI namespace that have them, identify the
corresponding "remote endpoint" device objects for them and
allocate memory for software nodes needed to create a DT-like data
structure representing the CSI-2 connection graph for drivers.

The code needed to populate these software nodes will be added by
subsequent change sets.

Link: https://uefi.org/specs/ACPI/6.5/06_Device_Configuration.html#camera-serial-interface-csi-2-connection-resource-descriptor
Co-developed-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/Makefile             |    2 
 drivers/acpi/internal.h           |    8 
 drivers/acpi/mipi-disco-imaging.c |  305 ++++++++++++++++++++++++++++++++++++++
 drivers/acpi/scan.c               |   49 ++++--
 include/acpi/acpi_bus.h           |   11 +
 5 files changed, 365 insertions(+), 10 deletions(-)
 create mode 100644 drivers/acpi/mipi-disco-imaging.c

Index: linux-pm/drivers/acpi/Makefile
===================================================================
--- linux-pm.orig/drivers/acpi/Makefile
+++ linux-pm/drivers/acpi/Makefile
@@ -37,7 +37,7 @@ acpi-$(CONFIG_ACPI_SLEEP)	+= proc.o
 # ACPI Bus and Device Drivers
 #
 acpi-y				+= bus.o glue.o
-acpi-y				+= scan.o
+acpi-y				+= scan.o mipi-disco-imaging.o
 acpi-y				+= resource.o
 acpi-y				+= acpi_processor.o
 acpi-y				+= processor_core.o
Index: linux-pm/drivers/acpi/internal.h
===================================================================
--- linux-pm.orig/drivers/acpi/internal.h
+++ linux-pm/drivers/acpi/internal.h
@@ -282,4 +282,12 @@ void acpi_init_lpit(void);
 static inline void acpi_init_lpit(void) { }
 #endif
 
+/*--------------------------------------------------------------------------
+		ACPI _CRS CSI-2 and MIPI DisCo for Imaging
+  -------------------------------------------------------------------------- */
+
+void acpi_mipi_check_crs_csi2(acpi_handle handle);
+void acpi_mipi_scan_crs_csi2(void);
+void acpi_mipi_crs_csi2_cleanup(void);
+
 #endif /* _ACPI_INTERNAL_H_ */
Index: linux-pm/drivers/acpi/mipi-disco-imaging.c
===================================================================
--- /dev/null
+++ linux-pm/drivers/acpi/mipi-disco-imaging.c
@@ -0,0 +1,305 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * MIPI DisCo for Imaging support.
+ *
+ * Copyright (C) 2023 Intel Corporation
+ *
+ * Support MIPI DisCo for Imaging by parsing ACPI _CRS CSI-2 records defined in
+ * Section 6.4.3.8.2.4 "Camera Serial Interface (CSI-2) Connection Resource
+ * Descriptor" of ACPI 6.5.
+ *
+ * The implementation looks for the information in the ACPI namespace (CSI-2
+ * resource descriptors in _CRS) and constructs software nodes compatible with
+ * Documentation/firmware-guide/acpi/dsd/graph.rst to represent the CSI-2
+ * connection graph.
+ */
+
+#include <linux/acpi.h>
+#include <linux/limits.h>
+#include <linux/list.h>
+#include <linux/module.h>
+#include <linux/overflow.h>
+#include <linux/types.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+
+#include "internal.h"
+
+static LIST_HEAD(acpi_mipi_crs_csi2_list);
+
+static void acpi_mipi_data_tag(acpi_handle handle, void *context)
+{
+}
+
+/* Connection data extracted from one _CRS CSI-2 resource descriptor. */
+struct crs_csi2_connection {
+	struct list_head entry;
+	struct acpi_resource_csi2_serialbus csi2_data;
+	acpi_handle remote_handle;
+	char remote_name[];
+};
+
+/* Data extracted from _CRS CSI-2 resource descriptors for one device. */
+struct crs_csi2 {
+	struct list_head entry;
+	acpi_handle handle;
+	struct acpi_device_software_nodes *swnodes;
+	struct list_head connections;
+	u32 port_count;
+};
+
+struct csi2_res_walk_data {
+	acpi_handle handle;
+	struct list_head connections;
+};
+
+static acpi_status acpi_parse_csi2_resource(struct acpi_resource *res,
+					    void *context)
+{
+	struct csi2_res_walk_data *crwd = context;
+	struct acpi_resource_csi2_serialbus *csi2_res;
+	struct acpi_resource_source *csi2_res_src;
+	u16 csi2_res_src_length;
+	struct crs_csi2_connection *conn;
+	acpi_handle remote_handle;
+
+	if (res->type != ACPI_RESOURCE_TYPE_SERIAL_BUS)
+		return AE_OK;
+
+	csi2_res = &res->data.csi2_serial_bus;
+
+	if (csi2_res->type != ACPI_RESOURCE_SERIAL_TYPE_CSI2)
+		return AE_OK;
+
+	csi2_res_src = &csi2_res->resource_source;
+	if (ACPI_FAILURE(acpi_get_handle(NULL, csi2_res_src->string_ptr,
+					 &remote_handle))) {
+		acpi_handle_debug(crwd->handle,
+				  "unable to find resource source\n");
+		return AE_OK;
+	}
+	csi2_res_src_length = csi2_res_src->string_length;
+	if (!csi2_res_src_length) {
+		acpi_handle_debug(crwd->handle,
+				  "invalid resource source string length\n");
+		return AE_OK;
+	}
+
+	conn = kmalloc(struct_size(conn, remote_name, csi2_res_src_length + 1),
+		       GFP_KERNEL);
+	if (!conn)
+		return AE_OK;
+
+	conn->csi2_data = *csi2_res;
+	strscpy(conn->remote_name, csi2_res_src->string_ptr, csi2_res_src_length);
+	conn->csi2_data.resource_source.string_ptr = conn->remote_name;
+	conn->remote_handle = remote_handle;
+
+	list_add(&conn->entry, &crwd->connections);
+
+	return AE_OK;
+}
+
+static struct crs_csi2 *acpi_mipi_add_crs_csi2(acpi_handle handle,
+					       struct list_head *list)
+{
+	struct crs_csi2 *csi2;
+
+	csi2 = kzalloc(sizeof(*csi2), GFP_KERNEL);
+	if (!csi2)
+		return NULL;
+
+	csi2->handle = handle;
+	INIT_LIST_HEAD(&csi2->connections);
+	csi2->port_count = 1;
+
+	if (ACPI_FAILURE(acpi_attach_data(handle, acpi_mipi_data_tag, csi2))) {
+		kfree(csi2);
+		return NULL;
+	}
+
+	list_add(&csi2->entry, list);
+
+	return csi2;
+}
+
+static struct crs_csi2 *acpi_mipi_get_crs_csi2(acpi_handle handle)
+{
+	struct crs_csi2 *csi2;
+
+	if (ACPI_FAILURE(acpi_get_data_full(handle, acpi_mipi_data_tag,
+					    (void **)&csi2, NULL)))
+		return NULL;
+
+	return csi2;
+}
+
+static void csi_csr2_release_connections(struct list_head *list)
+{
+	struct crs_csi2_connection *conn, *conn_tmp;
+
+	list_for_each_entry_safe(conn, conn_tmp, list, entry) {
+		list_del(&conn->entry);
+		kfree(conn);
+	}
+}
+
+static void acpi_mipi_del_crs_csi2(struct crs_csi2 *csi2)
+{
+	csi_csr2_release_connections(&csi2->connections);
+	list_del(&csi2->entry);
+	acpi_detach_data(csi2->handle, acpi_mipi_data_tag);
+	kfree(csi2);
+}
+
+/**
+ * acpi_mipi_check_crs_csi2 - Look for devices with _CRS CSI-2 resources
+ * @handle: ACPI namespace walk starting point.
+ *
+ * Find all devices with _CRS CSI-2 resource descriptors in the ACPI namespace
+ * branch starting at @handle and collect them into a list.
+ */
+void acpi_mipi_check_crs_csi2(acpi_handle handle)
+{
+	struct csi2_res_walk_data crwd = {
+		.handle = handle,
+		.connections = LIST_HEAD_INIT(crwd.connections),
+	};
+	struct crs_csi2 *csi2;
+
+	/*
+	 * Avoid allocating _CRS CSI-2 objects for devices without any CSI-2
+	 * resource descriptions in _CRS to reduce overhead.
+	 */
+	acpi_walk_resources(handle, METHOD_NAME__CRS, acpi_parse_csi2_resource,
+			    &crwd);
+	if (list_empty(&crwd.connections))
+		return;
+
+	/*
+	 * Create a _CRS CSI-2 entry to store the extracted connection
+	 * information and add it to the global list.
+	 */
+	csi2 = acpi_mipi_add_crs_csi2(handle, &acpi_mipi_crs_csi2_list);
+	if (!csi2) {
+		csi_csr2_release_connections(&crwd.connections);
+		return; /* Nothing really can be done about this. */
+	}
+
+	list_replace(&crwd.connections, &csi2->connections);
+}
+
+#define NO_CSI2_PORT (UINT_MAX - 1)
+
+static bool alloc_crs_csi2_swnodes(struct crs_csi2 *csi2)
+{
+	acpi_handle handle = csi2->handle;
+	size_t port_count = csi2->port_count;
+	struct acpi_device_software_nodes *swnodes;
+	size_t alloc_size;
+	unsigned int i;
+	bool overflow;
+
+	/*
+	 * Allocate memory for ports, node pointers (number of nodes +
+	 * 1 (guardian), nodes (root + number of ports * 2 (because for
+	 * every port there is an endpoint)).
+	 */
+	overflow = check_mul_overflow(sizeof(*swnodes->ports) +
+				      sizeof(*swnodes->nodes) * 2 +
+				      sizeof(*swnodes->nodeptrs) * 2,
+				      port_count, &alloc_size);
+	overflow = overflow ||
+		   check_add_overflow(sizeof(*swnodes) +
+				      sizeof(*swnodes->nodes) +
+				      sizeof(*swnodes->nodeptrs) * 2,
+				      alloc_size, &alloc_size);
+	if (overflow) {
+		acpi_handle_info(handle,
+				 "too many _CRS CSI-2 resource handles (%zu)",
+				 port_count);
+		return false;
+	}
+
+	swnodes = kmalloc(alloc_size, GFP_KERNEL);
+	if (!swnodes)
+		return false;
+
+	swnodes->ports = (struct acpi_device_software_node_port *)(swnodes + 1);
+	swnodes->nodes = (struct software_node *)(swnodes->ports + port_count);
+	swnodes->nodeptrs = (const struct software_node **)(swnodes->nodes + 1 +
+				2 * port_count);
+	swnodes->num_ports = port_count;
+
+	for (i = 0; i < 2 * port_count + 1; i++)
+		swnodes->nodeptrs[i] = &swnodes->nodes[i];
+
+	swnodes->nodeptrs[i] = NULL;
+
+	for (i = 0; i < port_count; i++)
+		swnodes->ports[i].port_nr = NO_CSI2_PORT;
+
+	csi2->swnodes = swnodes;
+
+	return true;
+}
+
+/**
+ * acpi_mipi_scan_crs_csi2 - Allocate ACPI _CRS CSI-2 software nodes
+ *
+ * Note that this function must be called before any struct acpi_device objects
+ * are bound to any ACPI drivers or scan handlers, so it cannot assume the
+ * existence of struct acpi_device objects for every device present in the ACPI
+ * namespace.
+ *
+ * acpi_scan_lock in scan.c must be held when calling this function.
+ */
+void acpi_mipi_scan_crs_csi2(void)
+{
+	struct crs_csi2 *csi2, *csi2_tmp;
+	LIST_HEAD(aux_list);
+
+	/* Count references to each ACPI handle in the CSI-2 connection graph. */
+	list_for_each_entry(csi2, &acpi_mipi_crs_csi2_list, entry) {
+		struct crs_csi2_connection *conn;
+
+		list_for_each_entry(conn, &csi2->connections, entry) {
+			struct crs_csi2 *remote_csi2;
+
+			remote_csi2 = acpi_mipi_get_crs_csi2(conn->remote_handle);
+			if (remote_csi2) {
+				remote_csi2->port_count++;
+				continue;
+			}
+			/*
+			 * The remote endpoint has no _CRS CSI-2 list entry yet,
+			 * so create one for it and add it to the list.
+			 */
+			acpi_mipi_add_crs_csi2(conn->remote_handle, &aux_list);
+		}
+	}
+	list_splice(&aux_list, &acpi_mipi_crs_csi2_list);
+
+	/* Allocate softwware nodes for representing the CSI-2 information. */
+	list_for_each_entry_safe(csi2, csi2_tmp, &acpi_mipi_crs_csi2_list, entry) {
+		/*
+		 * Drop the list entry on failure, because in that case it will
+		 * not be used going forward anyway.
+		 */
+		if (!alloc_crs_csi2_swnodes(csi2))
+			acpi_mipi_del_crs_csi2(csi2);
+	}
+}
+
+/**
+ * acpi_mipi_crs_csi2_cleanup - Free _CRS CSI-2 temporary data
+ */
+void acpi_mipi_crs_csi2_cleanup(void)
+{
+	struct crs_csi2 *csi2, *csi2_tmp;
+
+	list_for_each_entry_safe(csi2, csi2_tmp, &acpi_mipi_crs_csi2_list, entry) {
+		kfree(csi2->swnodes);
+		acpi_mipi_del_crs_csi2(csi2);
+	}
+}
Index: linux-pm/include/acpi/acpi_bus.h
===================================================================
--- linux-pm.orig/include/acpi/acpi_bus.h
+++ linux-pm/include/acpi/acpi_bus.h
@@ -363,6 +363,17 @@ struct acpi_device_data {
 
 struct acpi_gpio_mapping;
 
+struct acpi_device_software_node_port {
+	unsigned int port_nr;
+};
+
+struct acpi_device_software_nodes {
+	struct software_node *nodes;
+	const struct software_node **nodeptrs;
+	struct acpi_device_software_node_port *ports;
+	unsigned int num_ports;
+};
+
 /* Device */
 struct acpi_device {
 	u32 pld_crc;
Index: linux-pm/drivers/acpi/scan.c
===================================================================
--- linux-pm.orig/drivers/acpi/scan.c
+++ linux-pm/drivers/acpi/scan.c
@@ -1970,7 +1970,7 @@ static void acpi_scan_init_hotplug(struc
 	}
 }
 
-static u32 acpi_scan_check_dep(acpi_handle handle, bool check_dep)
+static u32 acpi_scan_check_dep(acpi_handle handle)
 {
 	struct acpi_handle_list dep_devices;
 	acpi_status status;
@@ -1983,8 +1983,7 @@ static u32 acpi_scan_check_dep(acpi_hand
 	 * 2. ACPI nodes describing USB ports.
 	 * Still, checking for _HID catches more then just these cases ...
 	 */
-	if (!check_dep || !acpi_has_method(handle, "_DEP") ||
-	    !acpi_has_method(handle, "_HID"))
+	if (!acpi_has_method(handle, "_DEP") || !acpi_has_method(handle, "_HID"))
 		return 0;
 
 	status = acpi_evaluate_reference(handle, "_DEP", NULL, &dep_devices);
@@ -2029,7 +2028,14 @@ static u32 acpi_scan_check_dep(acpi_hand
 	return count;
 }
 
-static acpi_status acpi_bus_check_add(acpi_handle handle, bool check_dep,
+static acpi_status acpi_scan_check_crs_csi2_cb(acpi_handle handle, u32 not_used_1,
+					       void *not_used_2, void **not_used_3)
+{
+	acpi_mipi_check_crs_csi2(handle);
+	return AE_OK;
+}
+
+static acpi_status acpi_bus_check_add(acpi_handle handle, bool first_pass,
 				      struct acpi_device **adev_p)
 {
 	struct acpi_device *device = acpi_fetch_acpi_dev(handle);
@@ -2047,9 +2053,25 @@ static acpi_status acpi_bus_check_add(ac
 		if (acpi_device_should_be_hidden(handle))
 			return AE_OK;
 
-		/* Bail out if there are dependencies. */
-		if (acpi_scan_check_dep(handle, check_dep) > 0)
-			return AE_CTRL_DEPTH;
+		if (first_pass) {
+			acpi_mipi_check_crs_csi2(handle);
+
+			/* Bail out if there are dependencies. */
+			if (acpi_scan_check_dep(handle) > 0) {
+				/*
+				 * The entire CSI-2 connection graph needs to be
+				 * extracted before any drivers or scan handlers
+				 * are bound to struct device objects, so scan
+				 * _CRS CSI-2 resource descriptors for all
+				 * devices below the current handle.
+				 */
+				acpi_walk_namespace(ACPI_TYPE_DEVICE, handle,
+						    ACPI_UINT32_MAX,
+						    acpi_scan_check_crs_csi2_cb,
+						    NULL, NULL, NULL);
+				return AE_CTRL_DEPTH;
+			}
+		}
 
 		fallthrough;
 	case ACPI_TYPE_ANY:	/* for ACPI_ROOT_OBJECT */
@@ -2072,10 +2094,10 @@ static acpi_status acpi_bus_check_add(ac
 	}
 
 	/*
-	 * If check_dep is true at this point, the device has no dependencies,
+	 * If first_pass is true at this point, the device has no dependencies,
 	 * or the creation of the device object would have been postponed above.
 	 */
-	acpi_add_single_object(&device, handle, type, !check_dep);
+	acpi_add_single_object(&device, handle, type, !first_pass);
 	if (!device)
 		return AE_CTRL_DEPTH;
 
@@ -2487,12 +2509,21 @@ int acpi_bus_scan(acpi_handle handle)
 	if (!device)
 		return -ENODEV;
 
+	/*
+	 * Allocate ACPI _CRS CSI-2 software nodes using information extracted
+	 * from the _CRS CSI-2 resource descriptors during the ACPI namespace
+	 * walk above.
+	 */
+	acpi_mipi_scan_crs_csi2();
+
 	acpi_bus_attach(device, (void *)true);
 
 	/* Pass 2: Enumerate all of the remaining devices. */
 
 	acpi_scan_postponed();
 
+	acpi_mipi_crs_csi2_cleanup();
+
 	return 0;
 }
 EXPORT_SYMBOL(acpi_bus_scan);



