Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E184B6B104A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 18:40:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbjCHRkG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 12:40:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbjCHRjm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 12:39:42 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3BE1EC9A4A
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 09:39:29 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 71227150C;
        Wed,  8 Mar 2023 09:40:12 -0800 (PST)
Received: from e127643.arm.com (unknown [10.57.48.148])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 783263F67D;
        Wed,  8 Mar 2023 09:39:27 -0800 (PST)
From:   James Clark <james.clark@arm.com>
To:     coresight@lists.linaro.org
Cc:     James Clark <james.clark@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/8] coresight: Store in-connections as well as out-connections
Date:   Wed,  8 Mar 2023 17:38:59 +0000
Message-Id: <20230308173904.3449231-6-james.clark@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230308173904.3449231-1-james.clark@arm.com>
References: <20230308173904.3449231-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This will allow CATU to get its associated ETR in a generic way where
currently the enable path has some hard coded searches which avoid
the need to store input connections.

Signed-off-by: James Clark <james.clark@arm.com>
---
 drivers/hwtracing/coresight/coresight-core.c  | 56 +++++++++++++++--
 .../hwtracing/coresight/coresight-platform.c  | 61 ++++++++++++++++---
 drivers/hwtracing/coresight/coresight-sysfs.c |  1 -
 include/linux/coresight.h                     | 33 +++++++++-
 4 files changed, 136 insertions(+), 15 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
index 617be08883da..fe9fb11ab283 100644
--- a/drivers/hwtracing/coresight/coresight-core.c
+++ b/drivers/hwtracing/coresight/coresight-core.c
@@ -59,6 +59,7 @@ const u32 coresight_barrier_pkt[4] = {0x7fffffff, 0x7fffffff, 0x7fffffff, 0x7fff
 EXPORT_SYMBOL_GPL(coresight_barrier_pkt);
 
 static const struct cti_assoc_op *cti_assoc_ops;
+static int coresight_fixup_inputs(struct coresight_device *csdev);
 
 ssize_t coresight_simple_show_pair(struct device *_dev,
 			      struct device_attribute *attr, char *buf)
@@ -1369,6 +1370,35 @@ static int coresight_fixup_orphan_conns(struct coresight_device *csdev)
 			 csdev, coresight_orphan_match);
 }
 
+/*
+ * Device connections are discovered before one/both devices have been created,
+ * so inputs must be added later.
+ */
+static int coresight_fixup_inputs(struct coresight_device *csdev)
+{
+	int i, ret = 0;
+	struct coresight_connection *out_conn;
+	struct coresight_connection in_conn;
+
+	for (i = 0; i < csdev->pdata->nr_outconns; i++) {
+		out_conn = &csdev->pdata->out_conns[i];
+		if (!out_conn->child_dev || !out_conn->child_dev->pdata)
+			continue;
+
+		/* Reverse in/out/child/parent relationships for inputs */
+		in_conn.child_dev = csdev;
+		in_conn.child_port = out_conn->outport;
+		in_conn.outport = out_conn->child_port;
+		in_conn.child_fwnode = csdev->dev.fwnode;
+		ret = coresight_add_in_conn(out_conn->child_dev->dev.parent,
+					    out_conn->child_dev->pdata,
+					    &in_conn);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
 
 static int coresight_fixup_device_conns(struct coresight_device *csdev)
 {
@@ -1427,11 +1457,20 @@ static int coresight_remove_match(struct device *dev, void *data)
 			 */
 			fwnode_handle_put(conn->child_fwnode);
 			conn->child_fwnode = NULL;
+			conn->child_dev = NULL;
+			/* No need to continue */
+			break;
+		}
+	}
+	for (i = 0; i < iterator->pdata->nr_inconns; i++) {
+		conn = &iterator->pdata->in_conns[i];
+		if (csdev == conn->child_dev) {
+			conn->child_fwnode = NULL;
+			conn->child_dev = NULL;
 			/* No need to continue */
 			break;
 		}
 	}
-
 	/*
 	 * Returning '0' ensures that all known component on the
 	 * bus will be checked.
@@ -1552,21 +1591,28 @@ void coresight_release_platform_data(struct coresight_device *csdev,
 
 	for (i = 0; i < pdata->nr_outconns; i++) {
 		/* If we have made the links, remove them now */
-		if (csdev && conns[i].child_dev)
+		if (csdev && conns[i].child_dev) {
 			coresight_remove_links(csdev, &conns[i]);
+			conns[i].child_dev = NULL;
+		}
+
 		/*
 		 * Drop the refcount and clear the handle as this device
 		 * is going away
 		 */
 		if (conns[i].child_fwnode) {
 			fwnode_handle_put(conns[i].child_fwnode);
-			pdata->out_conns[i].child_fwnode = NULL;
+			conns[i].child_fwnode = NULL;
 		}
 	}
+	for (i = 0; i < pdata->nr_inconns; i++) {
+		pdata->in_conns[i].child_dev = NULL;
+		pdata->in_conns[i].child_fwnode = NULL;
+	}
+
 	if (csdev)
 		coresight_remove_conns_sysfs_group(csdev);
 }
-
 struct coresight_device *coresight_register(struct coresight_desc *desc)
 {
 	int ret;
@@ -1659,6 +1705,8 @@ struct coresight_device *coresight_register(struct coresight_desc *desc)
 	ret = coresight_create_conns_sysfs_group(csdev);
 	if (!ret)
 		ret = coresight_fixup_device_conns(csdev);
+	if (!ret)
+		ret = coresight_fixup_inputs(csdev);
 	if (!ret)
 		ret = coresight_fixup_orphan_conns(csdev);
 
diff --git a/drivers/hwtracing/coresight/coresight-platform.c b/drivers/hwtracing/coresight/coresight-platform.c
index 8effce5937d9..3ebf490601f3 100644
--- a/drivers/hwtracing/coresight/coresight-platform.c
+++ b/drivers/hwtracing/coresight/coresight-platform.c
@@ -20,8 +20,7 @@
 
 #include "coresight-priv.h"
 /*
- * coresight_alloc_conns: Allocate connections record for each output
- * port from the device.
+ * coresight_alloc_conns: Allocate connections record for each input/output device.
  */
 static int coresight_alloc_conns(struct device *dev,
 				 struct coresight_platform_data *pdata)
@@ -33,7 +32,14 @@ static int coresight_alloc_conns(struct device *dev,
 		if (!pdata->out_conns)
 			return -ENOMEM;
 	}
-
+	if (pdata->nr_inconns) {
+		pdata->in_conns = devm_krealloc_array(dev, pdata->in_conns,
+						      pdata->nr_inconns,
+						      sizeof(*pdata->in_conns),
+						      GFP_KERNEL | __GFP_ZERO);
+		if (!pdata->in_conns)
+			return -ENOMEM;
+	}
 	return 0;
 }
 
@@ -79,6 +85,45 @@ int coresight_add_conn(struct device *dev,
 }
 EXPORT_SYMBOL_GPL(coresight_add_conn);
 
+/*
+ * Add a connection in the first free slot, or realloc
+ * if there is no space.
+ *
+ * Do nothing if the connection already exists because inputs are
+ * fixed up multiple times.
+ */
+int coresight_add_in_conn(struct device *dev,
+			  struct coresight_platform_data *pdata,
+			  struct coresight_connection *conn)
+{
+	int ret;
+	struct coresight_connection *free_conn = NULL;
+	int i;
+
+	/* Search for a free slot or exit if a duplicate is found */
+	if (pdata->in_conns) {
+		for (i = 0; i < pdata->nr_inconns; ++i) {
+			if (!free_conn && !pdata->in_conns[i].child_fwnode)
+				free_conn = &pdata->in_conns[i];
+			if (pdata->in_conns[i].child_fwnode ==
+			    conn->child_fwnode)
+				return 0;
+		}
+	}
+
+	if (!free_conn) {
+		pdata->nr_inconns++;
+		ret = coresight_alloc_conns(dev, pdata);
+		if (ret)
+			return ret;
+		free_conn = &pdata->in_conns[pdata->nr_inconns - 1];
+	}
+
+	*free_conn = *conn;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(coresight_add_in_conn);
+
 static struct device *
 coresight_find_device_by_fwnode(struct fwnode_handle *fwnode)
 {
@@ -249,7 +294,7 @@ static int of_coresight_get_cpu(struct device *dev)
 
 /*
  * of_coresight_parse_endpoint : Parse the given output endpoint @ep
- * and fill the connection information in @conn
+ * and fill the connection information in @in_conn and @out_conn
  *
  * Parses the local port, remote device name and the remote port.
  *
@@ -333,14 +378,14 @@ static int of_get_coresight_platform_data(struct device *dev,
 	/* Get the number of input and output port for this component */
 	of_coresight_get_ports(node, &pdata->nr_inconns, &pdata->nr_outconns);
 
-	/* If there are no output connections, we are done */
-	if (!pdata->nr_outconns)
-		return 0;
-
 	ret = coresight_alloc_conns(dev, pdata);
 	if (ret)
 		return ret;
 
+	/* If there are no output connections, we are done */
+	if (!pdata->nr_outconns)
+		return 0;
+
 	parent = of_coresight_get_output_ports_node(node);
 	/*
 	 * If the DT uses obsoleted bindings, the ports are listed
diff --git a/drivers/hwtracing/coresight/coresight-sysfs.c b/drivers/hwtracing/coresight/coresight-sysfs.c
index 34d2a2d31d00..8c7cff502070 100644
--- a/drivers/hwtracing/coresight/coresight-sysfs.c
+++ b/drivers/hwtracing/coresight/coresight-sysfs.c
@@ -202,5 +202,4 @@ void coresight_remove_links(struct coresight_device *orig,
 	devm_kfree(&orig->dev, conn->link->orig_name);
 	devm_kfree(&orig->dev, conn->link);
 	conn->link = NULL;
-	conn->child_dev = NULL;
 }
diff --git a/include/linux/coresight.h b/include/linux/coresight.h
index 62cc8e43b6cb..daecee847b95 100644
--- a/include/linux/coresight.h
+++ b/include/linux/coresight.h
@@ -110,6 +110,7 @@ struct coresight_platform_data {
 	int nr_inconns;
 	int nr_outconns;
 	struct coresight_connection *out_conns;
+	struct coresight_connection *in_conns;
 };
 
 /**
@@ -167,9 +168,34 @@ struct coresight_desc {
  * @outport:	a connection's output port number.
  * @child_port:	remote component's port number @output is connected to.
  * @chid_fwnode: remote component's fwnode handle.
- * @child_dev:  remote component's @coresight_device representation. Will
- *		be looked up and assigned using @child_fwnode
+ * @child_dev:  remote component's @coresight_device representation connected
+ *              to @outport. Will be looked up and assigned using @child_fwnode
+ *		upon device registration.
+ * @parent_dev: a @coresight_device representation of the owner of this
+		connection. As in, the device connected to @child_port of the
+		target of the connection.
  * @link: Representation of the connection as a sysfs link.
+ *
+ * The full connection structure looks like this, where in_conns store references to
+ * the parent device in the same child_dev member as output connections.
+ *
+ *       +-----------------------------+            +-----------------------------+
+ *       |coresight_device             |            |coresight_connection         |
+ *       |-----------------------------|            |-----------------------------|
+ *  ---->|                             |            |                             |
+ *  |    |                             |            |                   child_dev*|------
+ *  |    |pdata->out_conns[nr_outconns]|----------->|                             |      |
+ *  |    |                             |            |                             |      |
+ *  |    +-----------------------------+            +-----------------------------+      |
+ *  |                                                                                    |
+ *  |    +-----------------------------+            +-----------------------------+      |
+ *  |    |coresight_connection         |            |coresight_device             |      |
+ *  |    |-----------------------------|            |------------------------------      |
+ *  |    |                             |            |                             |<-----
+ *  -----|child_dev*                   |            |                             |
+ *       |                             |<-----------|pdata->in_conns[nr_inconns]  |
+ *       |                             |            |                             |
+ *       +-----------------------------+            +-----------------------------+
  */
 struct coresight_connection {
 	int outport;
@@ -612,5 +638,8 @@ struct coresight_platform_data *coresight_get_platform_data(struct device *dev);
 int coresight_add_conn(struct device *dev,
 		       struct coresight_platform_data *pdata,
 		       const struct coresight_connection *conn);
+int coresight_add_in_conn(struct device *dev,
+			  struct coresight_platform_data *pdata,
+			  struct coresight_connection *conn);
 
 #endif		/* _LINUX_COREISGHT_H */
-- 
2.34.1

