Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDB1370F59B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 13:48:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231960AbjEXLst (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 07:48:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231494AbjEXLsf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 07:48:35 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41E72184;
        Wed, 24 May 2023 04:48:33 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.2.0)
 id 97744957bbb3a929; Wed, 24 May 2023 13:48:31 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 4C45D69D7E2;
        Wed, 24 May 2023 13:48:31 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 3/6] ACPI: scan: Extract _CRS CSI-2 connection information into swnodes
Date:   Wed, 24 May 2023 13:43:26 +0200
Message-ID: <3745206.kQq0lBPeGt@kreacher>
In-Reply-To: <13276375.uLZWGnKmhe@kreacher>
References: <13276375.uLZWGnKmhe@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 195.136.19.94
X-CLIENT-HOSTNAME: 195.136.19.94
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvhedrfeejhedggeefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepkedtvdevieejkeevkedvffeiffehiedtheekkeefieehffekgfeltdehleehvddunecuffhomhgrihhnpehuvghfihdrohhrghenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeehpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshgrkhgrrhhirdgrihhluhhssehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohephhguvghgohgvuggv
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

Use the connection information extracted from the _CRS CSI-2 resource
descriptors for all devices that have them to populate port names and the
"reg", "bus-type" and "remote-endpoint" properties in the software nodes
representing the CSI-2 connection graph.

Link: https://uefi.org/specs/ACPI/6.5/06_Device_Configuration.html#camera-serial-interface-csi-2-connection-resource-descriptor
Co-developed-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/mipi-disco-imaging.c |  140 ++++++++++++++++++++++++++++++++++++++
 include/acpi/acpi_bus.h           |   68 ++++++++++++++++++
 2 files changed, 208 insertions(+)

Index: linux-pm/include/acpi/acpi_bus.h
===================================================================
--- linux-pm.orig/include/acpi/acpi_bus.h
+++ linux-pm/include/acpi/acpi_bus.h
@@ -363,11 +363,79 @@ struct acpi_device_data {
 
 struct acpi_gpio_mapping;
 
+#define ACPI_DEVICE_CSI2_DATA_LANES		4
+
+#define ACPI_DEVICE_SWNODE_ROOT			0
+#define ACPI_DEVICE_SWNODE_PORT_NAME_LENGTH	8
+
+enum acpi_device_swnode_dev_props {
+	ACPI_DEVICE_SWNODE_DEV_NUM_OF,
+	ACPI_DEVICE_SWNODE_DEV_NUM_ENTRIES
+};
+
+enum acpi_device_swnode_port_props {
+	ACPI_DEVICE_SWNODE_PORT_REG,
+	ACPI_DEVICE_SWNODE_PORT_NUM_OF,
+	ACPI_DEVICE_SWNODE_PORT_NUM_ENTRIES
+};
+
+enum acpi_device_swnode_ep_props {
+	ACPI_DEVICE_SWNODE_EP_REMOTE_EP,
+	ACPI_DEVICE_SWNODE_EP_BUS_TYPE,
+	ACPI_DEVICE_SWNODE_EP_REG,
+	ACPI_DEVICE_SWNODE_EP_CLOCK_LANES,
+	ACPI_DEVICE_SWNODE_EP_DATA_LANES,
+	ACPI_DEVICE_SWNODE_EP_LANE_POLARITIES,
+	/* TX only */
+	ACPI_DEVICE_SWNODE_EP_LINK_FREQUENCIES,
+	ACPI_DEVICE_SWNODE_EP_NUM_OF,
+	ACPI_DEVICE_SWNODE_EP_NUM_ENTRIES
+};
+
+/*
+ * Each device has a root software node plus two times as many nodes as the
+ * number of CSI-2 ports.
+ */
+#define ACPI_DEVICE_SWNODE_PORT(port)	(1 + 2 * (port))
+#define ACPI_DEVICE_SWNODE_EP(endpoint)	\
+		(ACPI_DEVICE_SWNODE_PORT(endpoint) + 1)
+
+/**
+ * struct acpi_device_software_node_port - MIPI DisCo for Imaging CSI-2 port
+ * @port_name: Port name
+ * @data_lanes: "data-lanes" property values
+ * @lane_polarities: "lane-polarities" property values
+ * @link_frequencies: "link_frequencies" property values
+ * @port_nr: Port number
+ * @crs_crs2_local: _CRS CSI2 record present (i.e. this is a transmitter one)
+ * @port_props: Port properties
+ * @ep_props: Endpoint properties
+ * @remote_ep: Reference to the remote endpoint
+ */
 struct acpi_device_software_node_port {
+	char port_name[ACPI_DEVICE_SWNODE_PORT_NAME_LENGTH];
+	u32 data_lanes[ACPI_DEVICE_CSI2_DATA_LANES];
+	u32 lane_polarities[ACPI_DEVICE_CSI2_DATA_LANES + 1 /* clock lane */];
+	u64 link_frequencies[ACPI_DEVICE_CSI2_DATA_LANES];
 	unsigned int port_nr;
+	bool crs_csi2_local;
+
+	struct property_entry port_props[ACPI_DEVICE_SWNODE_PORT_NUM_ENTRIES];
+	struct property_entry ep_props[ACPI_DEVICE_SWNODE_EP_NUM_ENTRIES];
+
+	struct software_node_ref_args remote_ep[1];
 };
 
+/**
+ * struct acpi_device_software_nodes - Software nodes for an ACPI device
+ * @dev_props: Device properties
+ * @nodes: Software nodes for root as well as ports and endpoints
+ * @nodeprts: Array of software node pointers, for (un)registering them
+ * @ports: Information related to each port and endpoint within a port
+ * @num_ports: The number of ports
+ */
 struct acpi_device_software_nodes {
+	struct property_entry dev_props[ACPI_DEVICE_SWNODE_DEV_NUM_ENTRIES];
 	struct software_node *nodes;
 	const struct software_node **nodeptrs;
 	struct acpi_device_software_node_port *ports;
Index: linux-pm/drivers/acpi/mipi-disco-imaging.c
===================================================================
--- linux-pm.orig/drivers/acpi/mipi-disco-imaging.c
+++ linux-pm/drivers/acpi/mipi-disco-imaging.c
@@ -23,6 +23,8 @@
 #include <linux/slab.h>
 #include <linux/string.h>
 
+#include <media/v4l2-fwnode.h>
+
 #include "internal.h"
 
 static LIST_HEAD(acpi_mipi_crs_csi2_list);
@@ -244,6 +246,137 @@ static bool alloc_crs_csi2_swnodes(struc
 	return true;
 }
 
+#define ACPI_CRS_CSI2_PHY_TYPE_C	0
+#define ACPI_CRS_CSI2_PHY_TYPE_D	1
+
+static unsigned int next_csi2_port_index(struct acpi_device_software_nodes *swnodes,
+					 unsigned int port_nr)
+{
+	unsigned int i;
+
+	for (i = 0; i < swnodes->num_ports; i++) {
+		struct acpi_device_software_node_port *port = &swnodes->ports[i];
+
+		if (port->port_nr == port_nr)
+			return i;
+
+		if (port->port_nr == NO_CSI2_PORT) {
+			port->port_nr = port_nr;
+			return i;
+		}
+	}
+
+	return NO_CSI2_PORT;
+}
+
+/* Print graph port name into a buffer, return non-zero on failure. */
+#define GRAPH_PORT_NAME(var, num)					    \
+	(snprintf((var), sizeof(var), SWNODE_GRAPH_PORT_NAME_FMT, (num)) >= \
+	 sizeof(var))
+
+static void extract_crs_csi2_conn_info(acpi_handle local_handle,
+				       struct acpi_device_software_nodes *local_swnodes,
+				       struct crs_csi2_connection *conn)
+{
+	struct crs_csi2 *remote_csi2 = acpi_mipi_get_crs_csi2(conn->remote_handle);
+	struct acpi_device_software_node_port *local_port, *remote_port;
+	struct software_node *local_node, *remote_node;
+	unsigned int local_index, remote_index;
+	struct acpi_device_software_nodes *remote_swnodes;
+	unsigned int bus_type;
+
+	/*
+	 * The previous steps have failed to set up a _CRS CSI-2 representation
+	 * for the remote end of the given connection, so skip it.
+	 */
+	if (!remote_csi2)
+		return;
+
+	remote_swnodes = remote_csi2->swnodes;
+
+	local_index = next_csi2_port_index(local_swnodes,
+					   conn->csi2_data.local_port_instance);
+	remote_index = next_csi2_port_index(remote_swnodes,
+					    conn->csi2_data.resource_source.index);
+
+	if (WARN_ON_ONCE(local_index >= local_swnodes->num_ports) ||
+	    WARN_ON_ONCE(remote_index >= remote_swnodes->num_ports))
+		return;
+
+	switch (conn->csi2_data.phy_type) {
+	case ACPI_CRS_CSI2_PHY_TYPE_C:
+		bus_type = V4L2_FWNODE_BUS_TYPE_CSI2_CPHY;
+		break;
+
+	case ACPI_CRS_CSI2_PHY_TYPE_D:
+		bus_type = V4L2_FWNODE_BUS_TYPE_CSI2_DPHY;
+		break;
+
+	default:
+		acpi_handle_info(local_handle, "unknown CSI-2 PHY type %u\n",
+				 conn->csi2_data.phy_type);
+		return;
+	}
+
+	local_port = &local_swnodes->ports[local_index];
+	local_node = &local_swnodes->nodes[ACPI_DEVICE_SWNODE_EP(local_index)];
+	local_port->crs_csi2_local = true;
+
+	remote_port = &remote_swnodes->ports[remote_index];
+	remote_node = &remote_swnodes->nodes[ACPI_DEVICE_SWNODE_EP(remote_index)];
+
+	local_port->remote_ep[0] = SOFTWARE_NODE_REFERENCE(remote_node);
+	remote_port->remote_ep[0] = SOFTWARE_NODE_REFERENCE(local_node);
+
+	local_port->ep_props[ACPI_DEVICE_SWNODE_EP_REMOTE_EP] =
+			PROPERTY_ENTRY_REF_ARRAY("remote-endpoint",
+						 local_port->remote_ep);
+
+	local_port->ep_props[ACPI_DEVICE_SWNODE_EP_BUS_TYPE] =
+			PROPERTY_ENTRY_U32("bus-type", bus_type);
+
+	local_port->ep_props[ACPI_DEVICE_SWNODE_EP_REG] =
+			PROPERTY_ENTRY_U32("reg", 0);
+
+	local_port->port_props[ACPI_DEVICE_SWNODE_PORT_REG] =
+			PROPERTY_ENTRY_U32("reg",
+					   conn->csi2_data.local_port_instance);
+
+	if (GRAPH_PORT_NAME(local_port->port_name,
+			    conn->csi2_data.local_port_instance))
+		acpi_handle_info(local_handle, "local port %u name too long",
+				 conn->csi2_data.local_port_instance);
+
+	remote_port->ep_props[ACPI_DEVICE_SWNODE_EP_REMOTE_EP] =
+			PROPERTY_ENTRY_REF_ARRAY("remote-endpoint",
+						 remote_port->remote_ep);
+
+	remote_port->ep_props[ACPI_DEVICE_SWNODE_EP_BUS_TYPE] =
+			PROPERTY_ENTRY_U32("bus-type", bus_type);
+
+	remote_port->ep_props[ACPI_DEVICE_SWNODE_EP_REG] =
+			PROPERTY_ENTRY_U32("reg", 0);
+
+	remote_port->port_props[ACPI_DEVICE_SWNODE_PORT_REG] =
+			PROPERTY_ENTRY_U32("reg",
+					   conn->csi2_data.resource_source.index);
+
+	if (GRAPH_PORT_NAME(remote_port->port_name,
+			    conn->csi2_data.resource_source.index))
+		acpi_handle_info(local_handle, "remote port %u name too long",
+				 conn->csi2_data.resource_source.index);
+}
+
+static void prepare_crs_csi2_swnodes(struct crs_csi2 *csi2)
+{
+	struct acpi_device_software_nodes *local_swnodes = csi2->swnodes;
+	acpi_handle local_handle = csi2->handle;
+	struct crs_csi2_connection *conn;
+
+	list_for_each_entry(conn, &csi2->connections, entry)
+		extract_crs_csi2_conn_info(local_handle, local_swnodes, conn);
+}
+
 /**
  * acpi_mipi_scan_crs_csi2 - Allocate ACPI _CRS CSI-2 software nodes
  *
@@ -289,6 +422,13 @@ void acpi_mipi_scan_crs_csi2(void)
 		if (!alloc_crs_csi2_swnodes(csi2))
 			acpi_mipi_del_crs_csi2(csi2);
 	}
+
+	/*
+	 * Set up software node properties using data from _CRS CSI-2 resource
+	 * descriptors.
+	 */
+	list_for_each_entry(csi2, &acpi_mipi_crs_csi2_list, entry)
+		prepare_crs_csi2_swnodes(csi2);
 }
 
 /**



