Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 696B36CD8D3
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 13:54:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbjC2LyS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 07:54:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbjC2LyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 07:54:12 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 74997469C
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 04:54:06 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8251C2F4;
        Wed, 29 Mar 2023 04:54:50 -0700 (PDT)
Received: from localhost.localdomain (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 75FEC3F6C4;
        Wed, 29 Mar 2023 04:54:04 -0700 (PDT)
From:   James Clark <james.clark@arm.com>
To:     coresight@lists.linaro.org, quic_jinlmao@quicinc.com,
        mike.leach@linaro.org, suzuki.poulose@arm.com
Cc:     James Clark <james.clark@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH v3 04/13] coresight: Rename connection members to make the direction explicit
Date:   Wed, 29 Mar 2023 12:53:17 +0100
Message-Id: <20230329115329.2747724-5-james.clark@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230329115329.2747724-1-james.clark@arm.com>
References: <20230329115329.2747724-1-james.clark@arm.com>
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

When input connections are added they will use the same connection
object as the output so parent and child could be misinterpreted. Making
the direction unambiguous in the names should improve readability.

Signed-off-by: James Clark <james.clark@arm.com>
---
 drivers/hwtracing/coresight/coresight-core.c  | 53 +++++++++----------
 .../hwtracing/coresight/coresight-platform.c  | 30 +++++------
 drivers/hwtracing/coresight/coresight-sysfs.c | 10 ++--
 .../hwtracing/coresight/coresight-tmc-etr.c   |  2 +-
 include/linux/coresight.h                     | 18 +++----
 5 files changed, 56 insertions(+), 57 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
index 617be08883da..f3abe6ad0b8f 100644
--- a/drivers/hwtracing/coresight/coresight-core.c
+++ b/drivers/hwtracing/coresight/coresight-core.c
@@ -120,8 +120,8 @@ static int coresight_find_link_inport(struct coresight_device *csdev,
 
 	for (i = 0; i < parent->pdata->nr_outconns; i++) {
 		conn = &parent->pdata->out_conns[i];
-		if (conn->child_dev == csdev)
-			return conn->child_port;
+		if (conn->dest_dev == csdev)
+			return conn->dest_port;
 	}
 
 	dev_err(&csdev->dev, "couldn't find inport, parent: %s, child: %s\n",
@@ -138,8 +138,8 @@ static int coresight_find_link_outport(struct coresight_device *csdev,
 
 	for (i = 0; i < csdev->pdata->nr_outconns; i++) {
 		conn = &csdev->pdata->out_conns[i];
-		if (conn->child_dev == child)
-			return conn->outport;
+		if (conn->dest_dev == child)
+			return conn->src_port;
 	}
 
 	dev_err(&csdev->dev, "couldn't find outport, parent: %s, child: %s\n",
@@ -606,7 +606,7 @@ coresight_find_enabled_sink(struct coresight_device *csdev)
 	for (i = 0; i < csdev->pdata->nr_outconns; i++) {
 		struct coresight_device *child_dev;
 
-		child_dev = csdev->pdata->out_conns[i].child_dev;
+		child_dev = csdev->pdata->out_conns[i].dest_dev;
 		if (child_dev)
 			sink = coresight_find_enabled_sink(child_dev);
 		if (sink)
@@ -722,7 +722,7 @@ static int coresight_grab_device(struct coresight_device *csdev)
 	for (i = 0; i < csdev->pdata->nr_outconns; i++) {
 		struct coresight_device *child;
 
-		child = csdev->pdata->out_conns[i].child_dev;
+		child = csdev->pdata->out_conns[i].dest_dev;
 		if (child && child->type == CORESIGHT_DEV_TYPE_HELPER)
 			if (!coresight_get_ref(child))
 				goto err;
@@ -733,7 +733,7 @@ static int coresight_grab_device(struct coresight_device *csdev)
 	for (i--; i >= 0; i--) {
 		struct coresight_device *child;
 
-		child = csdev->pdata->out_conns[i].child_dev;
+		child = csdev->pdata->out_conns[i].dest_dev;
 		if (child && child->type == CORESIGHT_DEV_TYPE_HELPER)
 			coresight_put_ref(child);
 	}
@@ -752,7 +752,7 @@ static void coresight_drop_device(struct coresight_device *csdev)
 	for (i = 0; i < csdev->pdata->nr_outconns; i++) {
 		struct coresight_device *child;
 
-		child = csdev->pdata->out_conns[i].child_dev;
+		child = csdev->pdata->out_conns[i].dest_dev;
 		if (child && child->type == CORESIGHT_DEV_TYPE_HELPER)
 			coresight_put_ref(child);
 	}
@@ -794,7 +794,7 @@ static int _coresight_build_path(struct coresight_device *csdev,
 	for (i = 0; i < csdev->pdata->nr_outconns; i++) {
 		struct coresight_device *child_dev;
 
-		child_dev = csdev->pdata->out_conns[i].child_dev;
+		child_dev = csdev->pdata->out_conns[i].dest_dev;
 		if (child_dev &&
 		    _coresight_build_path(child_dev, sink, path) == 0) {
 			found = true;
@@ -964,7 +964,7 @@ coresight_find_sink(struct coresight_device *csdev, int *depth)
 		struct coresight_device *child_dev, *sink = NULL;
 		int child_depth = curr_depth;
 
-		child_dev = csdev->pdata->out_conns[i].child_dev;
+		child_dev = csdev->pdata->out_conns[i].dest_dev;
 		if (child_dev)
 			sink = coresight_find_sink(child_dev, &child_depth);
 
@@ -1337,12 +1337,12 @@ static int coresight_orphan_match(struct device *dev, void *data)
 		conn = &i_csdev->pdata->out_conns[i];
 
 		/* Skip the port if FW doesn't describe it */
-		if (!conn->child_fwnode)
+		if (!conn->dest_fwnode)
 			continue;
 		/* We have found at least one orphan connection */
-		if (conn->child_dev == NULL) {
+		if (conn->dest_dev == NULL) {
 			/* Does it match this newly added device? */
-			if (conn->child_fwnode == csdev->dev.fwnode) {
+			if (conn->dest_fwnode == csdev->dev.fwnode) {
 				ret = coresight_make_links(i_csdev,
 							   conn, csdev);
 				if (ret)
@@ -1377,13 +1377,12 @@ static int coresight_fixup_device_conns(struct coresight_device *csdev)
 	for (i = 0; i < csdev->pdata->nr_outconns; i++) {
 		struct coresight_connection *conn = &csdev->pdata->out_conns[i];
 
-		if (!conn->child_fwnode)
+		if (!conn->dest_fwnode)
 			continue;
-		conn->child_dev =
-			coresight_find_csdev_by_fwnode(conn->child_fwnode);
-		if (conn->child_dev && conn->child_dev->has_conns_grp) {
-			ret = coresight_make_links(csdev, conn,
-						   conn->child_dev);
+		conn->dest_dev =
+			coresight_find_csdev_by_fwnode(conn->dest_fwnode);
+		if (conn->dest_dev && conn->dest_dev->has_conns_grp) {
+			ret = coresight_make_links(csdev, conn, conn->dest_dev);
 			if (ret)
 				break;
 		} else {
@@ -1414,10 +1413,10 @@ static int coresight_remove_match(struct device *dev, void *data)
 	for (i = 0; i < iterator->pdata->nr_outconns; i++) {
 		conn = &iterator->pdata->out_conns[i];
 
-		if (conn->child_dev == NULL || conn->child_fwnode == NULL)
+		if (conn->dest_dev == NULL || conn->dest_fwnode == NULL)
 			continue;
 
-		if (csdev->dev.fwnode == conn->child_fwnode) {
+		if (csdev->dev.fwnode == conn->dest_fwnode) {
 			iterator->orphan = true;
 			coresight_remove_links(iterator, conn);
 			/*
@@ -1425,8 +1424,8 @@ static int coresight_remove_match(struct device *dev, void *data)
 			 * device acquired in parsing the connections from
 			 * platform data.
 			 */
-			fwnode_handle_put(conn->child_fwnode);
-			conn->child_fwnode = NULL;
+			fwnode_handle_put(conn->dest_fwnode);
+			conn->dest_fwnode = NULL;
 			/* No need to continue */
 			break;
 		}
@@ -1552,15 +1551,15 @@ void coresight_release_platform_data(struct coresight_device *csdev,
 
 	for (i = 0; i < pdata->nr_outconns; i++) {
 		/* If we have made the links, remove them now */
-		if (csdev && conns[i].child_dev)
+		if (csdev && conns[i].dest_dev)
 			coresight_remove_links(csdev, &conns[i]);
 		/*
 		 * Drop the refcount and clear the handle as this device
 		 * is going away
 		 */
-		if (conns[i].child_fwnode) {
-			fwnode_handle_put(conns[i].child_fwnode);
-			pdata->out_conns[i].child_fwnode = NULL;
+		if (conns[i].dest_fwnode) {
+			fwnode_handle_put(conns[i].dest_fwnode);
+			pdata->out_conns[i].dest_fwnode = NULL;
 		}
 	}
 	if (csdev)
diff --git a/drivers/hwtracing/coresight/coresight-platform.c b/drivers/hwtracing/coresight/coresight-platform.c
index ed865e0621a9..566cc99a2c34 100644
--- a/drivers/hwtracing/coresight/coresight-platform.c
+++ b/drivers/hwtracing/coresight/coresight-platform.c
@@ -252,13 +252,13 @@ static int of_coresight_parse_endpoint(struct device *dev,
 		}
 
 		conn = &pdata->out_conns[endpoint.port];
-		if (conn->child_fwnode) {
+		if (conn->dest_fwnode) {
 			dev_warn(dev, "Duplicate output port %d\n",
 				 endpoint.port);
 			ret = -EINVAL;
 			break;
 		}
-		conn->outport = endpoint.port;
+		conn->src_port = endpoint.port;
 		/*
 		 * Hold the refcount to the target device. This could be
 		 * released via:
@@ -267,8 +267,8 @@ static int of_coresight_parse_endpoint(struct device *dev,
 		 * 2) While removing the target device via
 		 *    coresight_remove_match()
 		 */
-		conn->child_fwnode = fwnode_handle_get(rdev_fwnode);
-		conn->child_port = rendpoint.port;
+		conn->dest_fwnode = fwnode_handle_get(rdev_fwnode);
+		conn->dest_port = rendpoint.port;
 		/* Connection record updated */
 	} while (0);
 
@@ -649,8 +649,8 @@ static int acpi_coresight_parse_link(struct acpi_device *adev,
 
 	dir = fields[3].integer.value;
 	if (dir == ACPI_CORESIGHT_LINK_MASTER) {
-		conn->outport = fields[0].integer.value;
-		conn->child_port = fields[1].integer.value;
+		conn->src_port = fields[0].integer.value;
+		conn->dest_port = fields[1].integer.value;
 		rdev = coresight_find_device_by_fwnode(&r_adev->fwnode);
 		if (!rdev)
 			return -EPROBE_DEFER;
@@ -662,14 +662,14 @@ static int acpi_coresight_parse_link(struct acpi_device *adev,
 		 * 2) While removing the target device via
 		 *    coresight_remove_match().
 		 */
-		conn->child_fwnode = fwnode_handle_get(&r_adev->fwnode);
+		conn->dest_fwnode = fwnode_handle_get(&r_adev->fwnode);
 	} else if (dir == ACPI_CORESIGHT_LINK_SLAVE) {
 		/*
 		 * We are only interested in the port number
 		 * for the input ports at this component.
 		 * Store the port number in child_port.
 		 */
-		conn->child_port = fields[0].integer.value;
+		conn->dest_port = fields[0].integer.value;
 	} else {
 		/* Invalid direction */
 		return -EINVAL;
@@ -718,11 +718,11 @@ static int acpi_coresight_parse_graph(struct acpi_device *adev,
 			return dir;
 
 		if (dir == ACPI_CORESIGHT_LINK_MASTER) {
-			if (ptr->outport >= pdata->nr_outconns)
-				pdata->nr_outconns = ptr->outport + 1;
+			if (ptr->src_port >= pdata->nr_outconns)
+				pdata->nr_outconns = ptr->src_port + 1;
 			ptr++;
 		} else {
-			WARN_ON(pdata->nr_inconns == ptr->child_port + 1);
+			WARN_ON(pdata->nr_inconns == ptr->dest_port + 1);
 			/*
 			 * We do not track input port connections for a device.
 			 * However we need the highest port number described,
@@ -730,8 +730,8 @@ static int acpi_coresight_parse_graph(struct acpi_device *adev,
 			 * record for an output connection. Hence, do not move
 			 * the ptr for input connections
 			 */
-			if (ptr->child_port >= pdata->nr_inconns)
-				pdata->nr_inconns = ptr->child_port + 1;
+			if (ptr->dest_port >= pdata->nr_inconns)
+				pdata->nr_inconns = ptr->dest_port + 1;
 		}
 	}
 
@@ -741,10 +741,10 @@ static int acpi_coresight_parse_graph(struct acpi_device *adev,
 
 	/* Copy the connection information to the final location */
 	for (i = 0; conns + i < ptr; i++) {
-		int port = conns[i].outport;
+		int port = conns[i].src_port;
 
 		/* Duplicate output port */
-		WARN_ON(pdata->out_conns[port].child_fwnode);
+		WARN_ON(pdata->out_conns[port].dest_fwnode);
 		pdata->out_conns[port] = conns[i];
 	}
 
diff --git a/drivers/hwtracing/coresight/coresight-sysfs.c b/drivers/hwtracing/coresight/coresight-sysfs.c
index 34d2a2d31d00..a4a8e8e642e8 100644
--- a/drivers/hwtracing/coresight/coresight-sysfs.c
+++ b/drivers/hwtracing/coresight/coresight-sysfs.c
@@ -150,11 +150,11 @@ int coresight_make_links(struct coresight_device *orig,
 
 	do {
 		outs = devm_kasprintf(&orig->dev, GFP_KERNEL,
-				      "out:%d", conn->outport);
+				      "out:%d", conn->src_port);
 		if (!outs)
 			break;
 		ins = devm_kasprintf(&target->dev, GFP_KERNEL,
-				     "in:%d", conn->child_port);
+				     "in:%d", conn->dest_port);
 		if (!ins)
 			break;
 		link = devm_kzalloc(&orig->dev,
@@ -178,7 +178,7 @@ int coresight_make_links(struct coresight_device *orig,
 		 * Install the device connection. This also indicates that
 		 * the links are operational on both ends.
 		 */
-		conn->child_dev = target;
+		conn->dest_dev = target;
 		return 0;
 	} while (0);
 
@@ -198,9 +198,9 @@ void coresight_remove_links(struct coresight_device *orig,
 
 	coresight_remove_sysfs_link(conn->link);
 
-	devm_kfree(&conn->child_dev->dev, conn->link->target_name);
+	devm_kfree(&conn->dest_dev->dev, conn->link->target_name);
 	devm_kfree(&orig->dev, conn->link->orig_name);
 	devm_kfree(&orig->dev, conn->link);
 	conn->link = NULL;
-	conn->child_dev = NULL;
+	conn->dest_dev = NULL;
 }
diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
index 4711dfa7418c..61234cb8052a 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
@@ -782,7 +782,7 @@ tmc_etr_get_catu_device(struct tmc_drvdata *drvdata)
 		return NULL;
 
 	for (i = 0; i < etr->pdata->nr_outconns; i++) {
-		tmp = etr->pdata->out_conns[i].child_dev;
+		tmp = etr->pdata->out_conns[i].dest_dev;
 		if (tmp && coresight_is_catu_device(tmp))
 			return tmp;
 	}
diff --git a/include/linux/coresight.h b/include/linux/coresight.h
index daf392fcb67a..b6f444804bf3 100644
--- a/include/linux/coresight.h
+++ b/include/linux/coresight.h
@@ -164,18 +164,18 @@ struct coresight_desc {
 
 /**
  * struct coresight_connection - representation of a single connection
- * @outport:	a connection's output port number.
- * @child_port:	remote component's port number @output is connected to.
- * @chid_fwnode: remote component's fwnode handle.
- * @child_dev:	a @coresight_device representation of the component
-		connected to @outport.
+ * @src_port:	a connection's output port number.
+ * @dest_port:	destination's input port number @src_port is connected to.
+ * @dest_fwnode: destination component's fwnode handle.
+ * @dest_dev:	a @coresight_device representation of the component
+		connected to @src_port. NULL until the device is created
  * @link: Representation of the connection as a sysfs link.
  */
 struct coresight_connection {
-	int outport;
-	int child_port;
-	struct fwnode_handle *child_fwnode;
-	struct coresight_device *child_dev;
+	int src_port;
+	int dest_port;
+	struct fwnode_handle *dest_fwnode;
+	struct coresight_device *dest_dev;
 	struct coresight_sysfs_link *link;
 };
 
-- 
2.34.1

