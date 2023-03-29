Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2D9C6CD8D0
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 13:54:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbjC2LyN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 07:54:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbjC2LyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 07:54:09 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 07DF349C6
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 04:54:01 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E0FB31FB;
        Wed, 29 Mar 2023 04:54:45 -0700 (PDT)
Received: from localhost.localdomain (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D37C33F6C4;
        Wed, 29 Mar 2023 04:53:59 -0700 (PDT)
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
Subject: [PATCH v3 03/13] coresight: Rename nr_outports to nr_outconns
Date:   Wed, 29 Mar 2023 12:53:16 +0100
Message-Id: <20230329115329.2747724-4-james.clark@arm.com>
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

Rename to avoid confusion between port number and the index in the
connection array. The port number is already stored in the connection,
and in a later commit the connection array will be appended to, so
the length of it will no longer reflect the number of ports.

No functional changes.

Reviewed-by: Mike Leach <mike.leach@linaro.org>
Signed-off-by: James Clark <james.clark@arm.com>
---
 drivers/hwtracing/coresight/coresight-core.c  | 32 ++++++++---------
 .../hwtracing/coresight/coresight-platform.c  | 34 +++++++++----------
 .../hwtracing/coresight/coresight-tmc-etr.c   |  2 +-
 include/linux/coresight.h                     | 10 +++---
 4 files changed, 39 insertions(+), 39 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
index c0eda7407fb8..617be08883da 100644
--- a/drivers/hwtracing/coresight/coresight-core.c
+++ b/drivers/hwtracing/coresight/coresight-core.c
@@ -118,7 +118,7 @@ static int coresight_find_link_inport(struct coresight_device *csdev,
 	int i;
 	struct coresight_connection *conn;
 
-	for (i = 0; i < parent->pdata->nr_outport; i++) {
+	for (i = 0; i < parent->pdata->nr_outconns; i++) {
 		conn = &parent->pdata->out_conns[i];
 		if (conn->child_dev == csdev)
 			return conn->child_port;
@@ -136,7 +136,7 @@ static int coresight_find_link_outport(struct coresight_device *csdev,
 	int i;
 	struct coresight_connection *conn;
 
-	for (i = 0; i < csdev->pdata->nr_outport; i++) {
+	for (i = 0; i < csdev->pdata->nr_outconns; i++) {
 		conn = &csdev->pdata->out_conns[i];
 		if (conn->child_dev == child)
 			return conn->outport;
@@ -397,9 +397,9 @@ static void coresight_disable_link(struct coresight_device *csdev,
 	link_subtype = csdev->subtype.link_subtype;
 
 	if (link_subtype == CORESIGHT_DEV_SUBTYPE_LINK_MERG) {
-		nr_conns = csdev->pdata->nr_inport;
+		nr_conns = csdev->pdata->nr_inconns;
 	} else if (link_subtype == CORESIGHT_DEV_SUBTYPE_LINK_SPLIT) {
-		nr_conns = csdev->pdata->nr_outport;
+		nr_conns = csdev->pdata->nr_outconns;
 	} else {
 		nr_conns = 1;
 	}
@@ -603,7 +603,7 @@ coresight_find_enabled_sink(struct coresight_device *csdev)
 	/*
 	 * Recursively explore each port found on this element.
 	 */
-	for (i = 0; i < csdev->pdata->nr_outport; i++) {
+	for (i = 0; i < csdev->pdata->nr_outconns; i++) {
 		struct coresight_device *child_dev;
 
 		child_dev = csdev->pdata->out_conns[i].child_dev;
@@ -719,7 +719,7 @@ static int coresight_grab_device(struct coresight_device *csdev)
 {
 	int i;
 
-	for (i = 0; i < csdev->pdata->nr_outport; i++) {
+	for (i = 0; i < csdev->pdata->nr_outconns; i++) {
 		struct coresight_device *child;
 
 		child = csdev->pdata->out_conns[i].child_dev;
@@ -749,7 +749,7 @@ static void coresight_drop_device(struct coresight_device *csdev)
 	int i;
 
 	coresight_put_ref(csdev);
-	for (i = 0; i < csdev->pdata->nr_outport; i++) {
+	for (i = 0; i < csdev->pdata->nr_outconns; i++) {
 		struct coresight_device *child;
 
 		child = csdev->pdata->out_conns[i].child_dev;
@@ -791,7 +791,7 @@ static int _coresight_build_path(struct coresight_device *csdev,
 	}
 
 	/* Not a sink - recursively explore each port found on this element */
-	for (i = 0; i < csdev->pdata->nr_outport; i++) {
+	for (i = 0; i < csdev->pdata->nr_outconns; i++) {
 		struct coresight_device *child_dev;
 
 		child_dev = csdev->pdata->out_conns[i].child_dev;
@@ -960,7 +960,7 @@ coresight_find_sink(struct coresight_device *csdev, int *depth)
 	 * Not a sink we want - or possible child sink may be better.
 	 * recursively explore each port found on this element.
 	 */
-	for (i = 0; i < csdev->pdata->nr_outport; i++) {
+	for (i = 0; i < csdev->pdata->nr_outconns; i++) {
 		struct coresight_device *child_dev, *sink = NULL;
 		int child_depth = curr_depth;
 
@@ -1333,7 +1333,7 @@ static int coresight_orphan_match(struct device *dev, void *data)
 	 * Circle throuch all the connection of that component.  If we find
 	 * an orphan connection whose name matches @csdev, link it.
 	 */
-	for (i = 0; i < i_csdev->pdata->nr_outport; i++) {
+	for (i = 0; i < i_csdev->pdata->nr_outconns; i++) {
 		conn = &i_csdev->pdata->out_conns[i];
 
 		/* Skip the port if FW doesn't describe it */
@@ -1374,7 +1374,7 @@ static int coresight_fixup_device_conns(struct coresight_device *csdev)
 {
 	int i, ret = 0;
 
-	for (i = 0; i < csdev->pdata->nr_outport; i++) {
+	for (i = 0; i < csdev->pdata->nr_outconns; i++) {
 		struct coresight_connection *conn = &csdev->pdata->out_conns[i];
 
 		if (!conn->child_fwnode)
@@ -1411,7 +1411,7 @@ static int coresight_remove_match(struct device *dev, void *data)
 	 * Circle throuch all the connection of that component.  If we find
 	 * a connection whose name matches @csdev, remove it.
 	 */
-	for (i = 0; i < iterator->pdata->nr_outport; i++) {
+	for (i = 0; i < iterator->pdata->nr_outconns; i++) {
 		conn = &iterator->pdata->out_conns[i];
 
 		if (conn->child_dev == NULL || conn->child_fwnode == NULL)
@@ -1451,7 +1451,7 @@ static void coresight_remove_conns(struct coresight_device *csdev)
 	 * doesn't have at least one input port, there is no point
 	 * in searching all the devices.
 	 */
-	if (csdev->pdata->nr_inport)
+	if (csdev->pdata->nr_inconns)
 		bus_for_each_dev(&coresight_bustype, NULL,
 				 csdev, coresight_remove_match);
 }
@@ -1550,7 +1550,7 @@ void coresight_release_platform_data(struct coresight_device *csdev,
 	int i;
 	struct coresight_connection *conns = pdata->out_conns;
 
-	for (i = 0; i < pdata->nr_outport; i++) {
+	for (i = 0; i < pdata->nr_outconns; i++) {
 		/* If we have made the links, remove them now */
 		if (csdev && conns[i].child_dev)
 			coresight_remove_links(csdev, &conns[i]);
@@ -1587,9 +1587,9 @@ struct coresight_device *coresight_register(struct coresight_desc *desc)
 		link_subtype = desc->subtype.link_subtype;
 
 		if (link_subtype == CORESIGHT_DEV_SUBTYPE_LINK_MERG)
-			nr_refcnts = desc->pdata->nr_inport;
+			nr_refcnts = desc->pdata->nr_inconns;
 		else if (link_subtype == CORESIGHT_DEV_SUBTYPE_LINK_SPLIT)
-			nr_refcnts = desc->pdata->nr_outport;
+			nr_refcnts = desc->pdata->nr_outconns;
 	}
 
 	refcnts = kcalloc(nr_refcnts, sizeof(*refcnts), GFP_KERNEL);
diff --git a/drivers/hwtracing/coresight/coresight-platform.c b/drivers/hwtracing/coresight/coresight-platform.c
index 5085525a32bb..ed865e0621a9 100644
--- a/drivers/hwtracing/coresight/coresight-platform.c
+++ b/drivers/hwtracing/coresight/coresight-platform.c
@@ -26,8 +26,8 @@
 static int coresight_alloc_conns(struct device *dev,
 				 struct coresight_platform_data *pdata)
 {
-	if (pdata->nr_outport) {
-		pdata->out_conns = devm_kcalloc(dev, pdata->nr_outport,
+	if (pdata->nr_outconns) {
+		pdata->out_conns = devm_kcalloc(dev, pdata->nr_outconns,
 					    sizeof(*pdata->out_conns), GFP_KERNEL);
 		if (!pdata->out_conns)
 			return -ENOMEM;
@@ -84,7 +84,7 @@ static inline bool of_coresight_legacy_ep_is_input(struct device_node *ep)
 }
 
 static void of_coresight_get_ports_legacy(const struct device_node *node,
-					  int *nr_inport, int *nr_outport)
+					  int *nr_inconns, int *nr_outconns)
 {
 	struct device_node *ep = NULL;
 	struct of_endpoint endpoint;
@@ -114,8 +114,8 @@ static void of_coresight_get_ports_legacy(const struct device_node *node,
 
 	} while (ep);
 
-	*nr_inport = in;
-	*nr_outport = out;
+	*nr_inconns = in;
+	*nr_outconns = out;
 }
 
 static struct device_node *of_coresight_get_port_parent(struct device_node *ep)
@@ -164,7 +164,7 @@ of_coresight_count_ports(struct device_node *port_parent)
 }
 
 static void of_coresight_get_ports(const struct device_node *node,
-				   int *nr_inport, int *nr_outport)
+				   int *nr_inconns, int *nr_outconns)
 {
 	struct device_node *input_ports = NULL, *output_ports = NULL;
 
@@ -173,16 +173,16 @@ static void of_coresight_get_ports(const struct device_node *node,
 
 	if (input_ports || output_ports) {
 		if (input_ports) {
-			*nr_inport = of_coresight_count_ports(input_ports);
+			*nr_inconns = of_coresight_count_ports(input_ports);
 			of_node_put(input_ports);
 		}
 		if (output_ports) {
-			*nr_outport = of_coresight_count_ports(output_ports);
+			*nr_outconns = of_coresight_count_ports(output_ports);
 			of_node_put(output_ports);
 		}
 	} else {
 		/* Fall back to legacy DT bindings parsing */
-		of_coresight_get_ports_legacy(node, nr_inport, nr_outport);
+		of_coresight_get_ports_legacy(node, nr_inconns, nr_outconns);
 	}
 }
 
@@ -289,10 +289,10 @@ static int of_get_coresight_platform_data(struct device *dev,
 	struct device_node *node = dev->of_node;
 
 	/* Get the number of input and output port for this component */
-	of_coresight_get_ports(node, &pdata->nr_inport, &pdata->nr_outport);
+	of_coresight_get_ports(node, &pdata->nr_inconns, &pdata->nr_outconns);
 
 	/* If there are no output connections, we are done */
-	if (!pdata->nr_outport)
+	if (!pdata->nr_outconns)
 		return 0;
 
 	ret = coresight_alloc_conns(dev, pdata);
@@ -690,7 +690,7 @@ static int acpi_coresight_parse_graph(struct acpi_device *adev,
 	const union acpi_object *graph;
 	struct coresight_connection *conns, *ptr;
 
-	pdata->nr_inport = pdata->nr_outport = 0;
+	pdata->nr_inconns = pdata->nr_outconns = 0;
 	graph = acpi_get_coresight_graph(adev);
 	if (!graph)
 		return -ENOENT;
@@ -718,11 +718,11 @@ static int acpi_coresight_parse_graph(struct acpi_device *adev,
 			return dir;
 
 		if (dir == ACPI_CORESIGHT_LINK_MASTER) {
-			if (ptr->outport >= pdata->nr_outport)
-				pdata->nr_outport = ptr->outport + 1;
+			if (ptr->outport >= pdata->nr_outconns)
+				pdata->nr_outconns = ptr->outport + 1;
 			ptr++;
 		} else {
-			WARN_ON(pdata->nr_inport == ptr->child_port + 1);
+			WARN_ON(pdata->nr_inconns == ptr->child_port + 1);
 			/*
 			 * We do not track input port connections for a device.
 			 * However we need the highest port number described,
@@ -730,8 +730,8 @@ static int acpi_coresight_parse_graph(struct acpi_device *adev,
 			 * record for an output connection. Hence, do not move
 			 * the ptr for input connections
 			 */
-			if (ptr->child_port >= pdata->nr_inport)
-				pdata->nr_inport = ptr->child_port + 1;
+			if (ptr->child_port >= pdata->nr_inconns)
+				pdata->nr_inconns = ptr->child_port + 1;
 		}
 	}
 
diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
index 86d4a08aa833..4711dfa7418c 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
@@ -781,7 +781,7 @@ tmc_etr_get_catu_device(struct tmc_drvdata *drvdata)
 	if (!IS_ENABLED(CONFIG_CORESIGHT_CATU))
 		return NULL;
 
-	for (i = 0; i < etr->pdata->nr_outport; i++) {
+	for (i = 0; i < etr->pdata->nr_outconns; i++) {
 		tmp = etr->pdata->out_conns[i].child_dev;
 		if (tmp && coresight_is_catu_device(tmp))
 			return tmp;
diff --git a/include/linux/coresight.h b/include/linux/coresight.h
index bf621d064ef8..daf392fcb67a 100644
--- a/include/linux/coresight.h
+++ b/include/linux/coresight.h
@@ -102,13 +102,13 @@ union coresight_dev_subtype {
  * struct coresight_platform_data - data harvested from the firmware
  * specification.
  *
- * @nr_inport:	Number of elements for the input connections.
- * @nr_outport:	Number of elements for the output connections.
- * @out_conns:	Sparse array of nr_outport connections from this component.
+ * @nr_inconns: Number of elements for the input connections.
+ * @nr_outconns: Number of elements for the output connections.
+ * @out_conns:	Sparse array of nr_outconns connections from this component.
  */
 struct coresight_platform_data {
-	int nr_inport;
-	int nr_outport;
+	int nr_inconns;
+	int nr_outconns;
 	struct coresight_connection *out_conns;
 };
 
-- 
2.34.1

