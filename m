Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 668E76D6424
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 15:56:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235615AbjDDN4Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 09:56:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235632AbjDDNz4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 09:55:56 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CE3954C25
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 06:55:20 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 21890FEC;
        Tue,  4 Apr 2023 06:56:05 -0700 (PDT)
Received: from e127643.broadband (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 049A53F762;
        Tue,  4 Apr 2023 06:55:18 -0700 (PDT)
From:   James Clark <james.clark@arm.com>
To:     coresight@lists.linaro.org, quic_jinlmao@quicinc.com,
        mike.leach@linaro.org, suzuki.poulose@arm.com
Cc:     James Clark <james.clark@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 06/13] coresight: Dynamically add connections
Date:   Tue,  4 Apr 2023 14:53:52 +0100
Message-Id: <20230404135401.1728919-7-james.clark@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230404135401.1728919-1-james.clark@arm.com>
References: <20230404135401.1728919-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a function for adding connections dynamically. This also removes
the 1:1 mapping between port number and the index into the connections
array. The only place this mapping was used was in the warning for
duplicate output ports, which has been replaced by a search. Other
uses of the port number already use the port member variable.

Being able to dynamically add connections will allow other devices like
CTI to re-use the connection mechanism despite not having explicit
connections described in the DT.

The connections array is now no longer sparse, so child_fwnode doesn't
need to be checked as all connections have a target node. Because the
array is no longer sparse, the high in and out port numbers are required
for the refcount arrays. But these will also be removed in a later
commit when the refcount is made a property of the connection.

Signed-off-by: James Clark <james.clark@arm.com>
---
 drivers/hwtracing/coresight/coresight-core.c  |  23 ++--
 .../hwtracing/coresight/coresight-platform.c  | 124 +++++++++---------
 include/linux/coresight.h                     |   8 +-
 3 files changed, 77 insertions(+), 78 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
index f3dc320b374c..91274e7e6944 100644
--- a/drivers/hwtracing/coresight/coresight-core.c
+++ b/drivers/hwtracing/coresight/coresight-core.c
@@ -397,9 +397,9 @@ static void coresight_disable_link(struct coresight_device *csdev,
 	link_subtype = csdev->subtype.link_subtype;
 
 	if (link_subtype == CORESIGHT_DEV_SUBTYPE_LINK_MERG) {
-		nr_conns = csdev->pdata->nr_inconns;
+		nr_conns = csdev->pdata->high_inport;
 	} else if (link_subtype == CORESIGHT_DEV_SUBTYPE_LINK_SPLIT) {
-		nr_conns = csdev->pdata->nr_outconns;
+		nr_conns = csdev->pdata->high_outport;
 	} else {
 		nr_conns = 1;
 	}
@@ -1336,9 +1336,6 @@ static int coresight_orphan_match(struct device *dev, void *data)
 	for (i = 0; i < i_csdev->pdata->nr_outconns; i++) {
 		conn = &i_csdev->pdata->out_conns[i];
 
-		/* Skip the port if FW doesn't describe it */
-		if (!conn->dest_fwnode)
-			continue;
 		/* We have found at least one orphan connection */
 		if (conn->dest_dev == NULL) {
 			/* Does it match this newly added device? */
@@ -1377,8 +1374,6 @@ static int coresight_fixup_device_conns(struct coresight_device *csdev)
 	for (i = 0; i < csdev->pdata->nr_outconns; i++) {
 		struct coresight_connection *conn = &csdev->pdata->out_conns[i];
 
-		if (!conn->dest_fwnode)
-			continue;
 		conn->dest_dev =
 			coresight_find_csdev_by_fwnode(conn->dest_fwnode);
 		if (conn->dest_dev && conn->dest_dev->has_conns_grp) {
@@ -1413,7 +1408,7 @@ static int coresight_remove_match(struct device *dev, void *data)
 	for (i = 0; i < iterator->pdata->nr_outconns; i++) {
 		conn = &iterator->pdata->out_conns[i];
 
-		if (conn->dest_dev == NULL || conn->dest_fwnode == NULL)
+		if (conn->dest_dev == NULL)
 			continue;
 
 		if (csdev->dev.fwnode == conn->dest_fwnode) {
@@ -1445,7 +1440,7 @@ static void coresight_remove_conns(struct coresight_device *csdev)
 	 * doesn't have at least one input port, there is no point
 	 * in searching all the devices.
 	 */
-	if (csdev->pdata->nr_inconns)
+	if (csdev->pdata->high_inport)
 		bus_for_each_dev(&coresight_bustype, NULL,
 				 csdev, coresight_remove_match);
 }
@@ -1552,10 +1547,8 @@ void coresight_release_platform_data(struct coresight_device *csdev,
 		 * Drop the refcount and clear the handle as this device
 		 * is going away
 		 */
-		if (conns[i].dest_fwnode) {
-			fwnode_handle_put(conns[i].dest_fwnode);
-			conns[i].dest_fwnode = NULL;
-		}
+		fwnode_handle_put(conns[i].dest_fwnode);
+		conns[i].dest_fwnode = NULL;
 	}
 	if (csdev)
 		coresight_remove_conns_sysfs_group(csdev);
@@ -1581,9 +1574,9 @@ struct coresight_device *coresight_register(struct coresight_desc *desc)
 		link_subtype = desc->subtype.link_subtype;
 
 		if (link_subtype == CORESIGHT_DEV_SUBTYPE_LINK_MERG)
-			nr_refcnts = desc->pdata->nr_inconns;
+			nr_refcnts = desc->pdata->high_inport;
 		else if (link_subtype == CORESIGHT_DEV_SUBTYPE_LINK_SPLIT)
-			nr_refcnts = desc->pdata->nr_outconns;
+			nr_refcnts = desc->pdata->high_outport;
 	}
 
 	refcnts = kcalloc(nr_refcnts, sizeof(*refcnts), GFP_KERNEL);
diff --git a/drivers/hwtracing/coresight/coresight-platform.c b/drivers/hwtracing/coresight/coresight-platform.c
index 566cc99a2c34..8c2029336161 100644
--- a/drivers/hwtracing/coresight/coresight-platform.c
+++ b/drivers/hwtracing/coresight/coresight-platform.c
@@ -19,22 +19,45 @@
 #include <asm/smp_plat.h>
 
 #include "coresight-priv.h"
+
 /*
- * coresight_alloc_conns: Allocate connections record for each output
- * port from the device.
+ * Add an entry to the connection list and assign @conn's contents to it.
+ *
+ * If the output port is already assigned on this device, return -EINVAL
  */
-static int coresight_alloc_conns(struct device *dev,
-				 struct coresight_platform_data *pdata)
+struct coresight_connection *
+coresight_add_out_conn(struct device *dev,
+		       struct coresight_platform_data *pdata,
+		       const struct coresight_connection *new_conn)
 {
-	if (pdata->nr_outconns) {
-		pdata->out_conns = devm_kcalloc(dev, pdata->nr_outconns,
-					    sizeof(*pdata->out_conns), GFP_KERNEL);
-		if (!pdata->out_conns)
-			return -ENOMEM;
+	int i;
+	struct coresight_connection *conn;
+
+	/*
+	 * Warn on any existing duplicate output port.
+	 */
+	for (i = 0; i < pdata->nr_outconns; ++i) {
+		conn = &pdata->out_conns[i];
+		/* Output == -1 means ignore the port for example for helpers */
+		if (conn->src_port != -1 &&
+		    conn->src_port == new_conn->src_port) {
+			dev_warn(dev, "Duplicate output port %d\n",
+				 conn->src_port);
+			return ERR_PTR(-EINVAL);
+		}
 	}
 
-	return 0;
+	pdata->nr_outconns++;
+	pdata->out_conns =
+		devm_krealloc_array(dev, pdata->out_conns, pdata->nr_outconns,
+				    sizeof(*pdata->out_conns), GFP_KERNEL);
+	if (!pdata->out_conns)
+		return ERR_PTR(-ENOMEM);
+
+	pdata->out_conns[pdata->nr_outconns - 1] = *new_conn;
+	return &pdata->out_conns[pdata->nr_outconns - 1];
 }
+EXPORT_SYMBOL_GPL(coresight_add_out_conn);
 
 static struct device *
 coresight_find_device_by_fwnode(struct fwnode_handle *fwnode)
@@ -224,7 +247,8 @@ static int of_coresight_parse_endpoint(struct device *dev,
 	struct device_node *rep = NULL;
 	struct device *rdev = NULL;
 	struct fwnode_handle *rdev_fwnode;
-	struct coresight_connection *conn;
+	struct coresight_connection conn = {};
+	struct coresight_connection *new_conn;
 
 	do {
 		/* Parse the local port details */
@@ -251,14 +275,7 @@ static int of_coresight_parse_endpoint(struct device *dev,
 			break;
 		}
 
-		conn = &pdata->out_conns[endpoint.port];
-		if (conn->dest_fwnode) {
-			dev_warn(dev, "Duplicate output port %d\n",
-				 endpoint.port);
-			ret = -EINVAL;
-			break;
-		}
-		conn->src_port = endpoint.port;
+		conn.src_port = endpoint.port;
 		/*
 		 * Hold the refcount to the target device. This could be
 		 * released via:
@@ -267,8 +284,14 @@ static int of_coresight_parse_endpoint(struct device *dev,
 		 * 2) While removing the target device via
 		 *    coresight_remove_match()
 		 */
-		conn->dest_fwnode = fwnode_handle_get(rdev_fwnode);
-		conn->dest_port = rendpoint.port;
+		conn.dest_fwnode = fwnode_handle_get(rdev_fwnode);
+		conn.dest_port = rendpoint.port;
+
+		new_conn = coresight_add_out_conn(dev, pdata, &conn);
+		if (IS_ERR_VALUE(new_conn)) {
+			fwnode_handle_put(conn.dest_fwnode);
+			return PTR_ERR(new_conn);
+		}
 		/* Connection record updated */
 	} while (0);
 
@@ -289,16 +312,12 @@ static int of_get_coresight_platform_data(struct device *dev,
 	struct device_node *node = dev->of_node;
 
 	/* Get the number of input and output port for this component */
-	of_coresight_get_ports(node, &pdata->nr_inconns, &pdata->nr_outconns);
+	of_coresight_get_ports(node, &pdata->high_inport, &pdata->high_outport);
 
 	/* If there are no output connections, we are done */
-	if (!pdata->nr_outconns)
+	if (!pdata->high_outport)
 		return 0;
 
-	ret = coresight_alloc_conns(dev, pdata);
-	if (ret)
-		return ret;
-
 	parent = of_coresight_get_output_ports_node(node);
 	/*
 	 * If the DT uses obsoleted bindings, the ports are listed
@@ -683,12 +702,14 @@ static int acpi_coresight_parse_link(struct acpi_device *adev,
  * connection information and populate the supplied coresight_platform_data
  * instance.
  */
-static int acpi_coresight_parse_graph(struct acpi_device *adev,
+static int acpi_coresight_parse_graph(struct device *dev,
+				      struct acpi_device *adev,
 				      struct coresight_platform_data *pdata)
 {
-	int rc, i, nlinks;
+	int i, nlinks;
 	const union acpi_object *graph;
-	struct coresight_connection *conns, *ptr;
+	struct coresight_connection conn, zero_conn = {};
+	struct coresight_connection *new_conn;
 
 	pdata->nr_inconns = pdata->nr_outconns = 0;
 	graph = acpi_get_coresight_graph(adev);
@@ -699,30 +720,23 @@ static int acpi_coresight_parse_graph(struct acpi_device *adev,
 	if (!nlinks)
 		return 0;
 
-	/*
-	 * To avoid scanning the table twice (once for finding the number of
-	 * output links and then later for parsing the output links),
-	 * cache the links information in one go and then later copy
-	 * it to the pdata.
-	 */
-	conns = devm_kcalloc(&adev->dev, nlinks, sizeof(*conns), GFP_KERNEL);
-	if (!conns)
-		return -ENOMEM;
-	ptr = conns;
 	for (i = 0; i < nlinks; i++) {
 		const union acpi_object *link = &graph->package.elements[3 + i];
 		int dir;
 
-		dir = acpi_coresight_parse_link(adev, link, ptr);
+		conn = zero_conn;
+		dir = acpi_coresight_parse_link(adev, link, &conn);
 		if (dir < 0)
 			return dir;
 
 		if (dir == ACPI_CORESIGHT_LINK_MASTER) {
-			if (ptr->src_port >= pdata->nr_outconns)
-				pdata->nr_outconns = ptr->src_port + 1;
-			ptr++;
+			if (conn.src_port >= pdata->high_outport)
+				pdata->high_outport = conn.src_port + 1;
+			new_conn = coresight_add_out_conn(dev, pdata, &conn);
+			if (IS_ERR(new_conn))
+				return PTR_ERR(new_conn);
 		} else {
-			WARN_ON(pdata->nr_inconns == ptr->dest_port + 1);
+			WARN_ON(pdata->high_inport == conn.dest_port + 1);
 			/*
 			 * We do not track input port connections for a device.
 			 * However we need the highest port number described,
@@ -730,25 +744,11 @@ static int acpi_coresight_parse_graph(struct acpi_device *adev,
 			 * record for an output connection. Hence, do not move
 			 * the ptr for input connections
 			 */
-			if (ptr->dest_port >= pdata->nr_inconns)
-				pdata->nr_inconns = ptr->dest_port + 1;
+			if (conn.dest_port >= pdata->high_inport)
+				pdata->high_inport = conn.dest_port + 1;
 		}
 	}
 
-	rc = coresight_alloc_conns(&adev->dev, pdata);
-	if (rc)
-		return rc;
-
-	/* Copy the connection information to the final location */
-	for (i = 0; conns + i < ptr; i++) {
-		int port = conns[i].src_port;
-
-		/* Duplicate output port */
-		WARN_ON(pdata->out_conns[port].dest_fwnode);
-		pdata->out_conns[port] = conns[i];
-	}
-
-	devm_kfree(&adev->dev, conns);
 	return 0;
 }
 
@@ -809,7 +809,7 @@ acpi_get_coresight_platform_data(struct device *dev,
 	if (!adev)
 		return -EINVAL;
 
-	return acpi_coresight_parse_graph(adev, pdata);
+	return acpi_coresight_parse_graph(dev, adev, pdata);
 }
 
 #else
diff --git a/include/linux/coresight.h b/include/linux/coresight.h
index b6f444804bf3..12fdbd03e2f7 100644
--- a/include/linux/coresight.h
+++ b/include/linux/coresight.h
@@ -104,9 +104,11 @@ union coresight_dev_subtype {
  *
  * @nr_inconns: Number of elements for the input connections.
  * @nr_outconns: Number of elements for the output connections.
- * @out_conns:	Sparse array of nr_outconns connections from this component.
+ * @out_conns:	Array of nr_outconns connections from this component.
  */
 struct coresight_platform_data {
+	int high_inport;
+	int high_outport;
 	int nr_inconns;
 	int nr_outconns;
 	struct coresight_connection *out_conns;
@@ -609,5 +611,9 @@ static inline void coresight_write64(struct coresight_device *csdev, u64 val, u3
 extern int coresight_get_cpu(struct device *dev);
 
 struct coresight_platform_data *coresight_get_platform_data(struct device *dev);
+struct coresight_connection *
+coresight_add_out_conn(struct device *dev,
+		       struct coresight_platform_data *pdata,
+		       const struct coresight_connection *new_conn);
 
 #endif		/* _LINUX_COREISGHT_H */
-- 
2.34.1

