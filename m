Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6A3B6EE40C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 16:38:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234465AbjDYOhd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 10:37:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234463AbjDYOhK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 10:37:10 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F150D146D5
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 07:36:56 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AF99BD75;
        Tue, 25 Apr 2023 07:37:40 -0700 (PDT)
Received: from localhost.localdomain (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0E6B73F587;
        Tue, 25 Apr 2023 07:36:54 -0700 (PDT)
From:   James Clark <james.clark@arm.com>
To:     coresight@lists.linaro.org, quic_jinlmao@quicinc.com,
        mike.leach@linaro.org, suzuki.poulose@arm.com
Cc:     James Clark <james.clark@arm.com>, Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 10/13] coresight: Make refcount a property of the connection
Date:   Tue, 25 Apr 2023 15:35:37 +0100
Message-Id: <20230425143542.2305069-11-james.clark@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230425143542.2305069-1-james.clark@arm.com>
References: <20230425143542.2305069-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This removes the need to do an additional lookup for the total number
of ports used and also removes the need to allocate an array of
refcounts which is just another representation of a connection array.

This was only used for link type devices, for regular devices a single
refcount on the coresight device is used.

There is a both an input and output refcount in case two link type
devices are connected together so that they don't overwrite each other's
counts.

Reviewed-by: Mike Leach <mike.leach@linaro.org>
Signed-off-by: James Clark <james.clark@arm.com>
---
 drivers/hwtracing/coresight/coresight-core.c  | 116 ++++++------------
 drivers/hwtracing/coresight/coresight-etb10.c |  10 +-
 .../hwtracing/coresight/coresight-funnel.c    |  26 ++--
 .../hwtracing/coresight/coresight-platform.c  | 109 +---------------
 .../coresight/coresight-replicator.c          |  23 ++--
 .../hwtracing/coresight/coresight-tmc-etf.c   |  24 ++--
 .../hwtracing/coresight/coresight-tmc-etr.c   |  12 +-
 drivers/hwtracing/coresight/coresight-tpda.c  |  23 ++--
 drivers/hwtracing/coresight/coresight-tpiu.c  |   4 +-
 drivers/hwtracing/coresight/ultrasoc-smb.c    |   8 +-
 include/linux/coresight.h                     |  14 ++-
 11 files changed, 126 insertions(+), 243 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
index a0a0ea2c626b..939b7fb751b5 100644
--- a/drivers/hwtracing/coresight/coresight-core.c
+++ b/drivers/hwtracing/coresight/coresight-core.c
@@ -112,40 +112,24 @@ struct coresight_device *coresight_get_percpu_sink(int cpu)
 }
 EXPORT_SYMBOL_GPL(coresight_get_percpu_sink);
 
-static int coresight_find_link_inport(struct coresight_device *csdev,
-				      struct coresight_device *parent)
+static struct coresight_connection *
+coresight_find_out_connection(struct coresight_device *src_dev,
+			      struct coresight_device *dest_dev)
 {
 	int i;
 	struct coresight_connection *conn;
 
-	for (i = 0; i < parent->pdata->nr_outconns; i++) {
-		conn = parent->pdata->out_conns[i];
-		if (conn->dest_dev == csdev)
-			return conn->dest_port;
+	for (i = 0; i < src_dev->pdata->nr_outconns; i++) {
+		conn = src_dev->pdata->out_conns[i];
+		if (conn->dest_dev == dest_dev)
+			return conn;
 	}
 
-	dev_err(&csdev->dev, "couldn't find inport, parent: %s, child: %s\n",
-		dev_name(&parent->dev), dev_name(&csdev->dev));
+	dev_err(&src_dev->dev,
+		"couldn't find output connection, src_dev: %s, dest_dev: %s\n",
+		dev_name(&src_dev->dev), dev_name(&dest_dev->dev));
 
-	return -ENODEV;
-}
-
-static int coresight_find_link_outport(struct coresight_device *csdev,
-				       struct coresight_device *child)
-{
-	int i;
-	struct coresight_connection *conn;
-
-	for (i = 0; i < csdev->pdata->nr_outconns; i++) {
-		conn = csdev->pdata->out_conns[i];
-		if (conn->dest_dev == child)
-			return conn->src_port;
-	}
-
-	dev_err(&csdev->dev, "couldn't find outport, parent: %s, child: %s\n",
-		dev_name(&csdev->dev), dev_name(&child->dev));
-
-	return -ENODEV;
+	return ERR_PTR(-ENODEV);
 }
 
 static inline u32 coresight_read_claim_tags(struct coresight_device *csdev)
@@ -352,24 +336,24 @@ static int coresight_enable_link(struct coresight_device *csdev,
 {
 	int ret = 0;
 	int link_subtype;
-	int inport, outport;
+	struct coresight_connection *inconn, *outconn;
 
 	if (!parent || !child)
 		return -EINVAL;
 
-	inport = coresight_find_link_inport(csdev, parent);
-	outport = coresight_find_link_outport(csdev, child);
+	inconn = coresight_find_out_connection(parent, csdev);
+	outconn = coresight_find_out_connection(csdev, child);
 	link_subtype = csdev->subtype.link_subtype;
 
-	if (link_subtype == CORESIGHT_DEV_SUBTYPE_LINK_MERG && inport < 0)
-		return inport;
-	if (link_subtype == CORESIGHT_DEV_SUBTYPE_LINK_SPLIT && outport < 0)
-		return outport;
+	if (link_subtype == CORESIGHT_DEV_SUBTYPE_LINK_MERG && IS_ERR(inconn))
+		return PTR_ERR(inconn);
+	if (link_subtype == CORESIGHT_DEV_SUBTYPE_LINK_SPLIT && IS_ERR(outconn))
+		return PTR_ERR(outconn);
 
 	if (link_ops(csdev)->enable) {
 		ret = coresight_control_assoc_ectdev(csdev, true);
 		if (!ret) {
-			ret = link_ops(csdev)->enable(csdev, inport, outport);
+			ret = link_ops(csdev)->enable(csdev, inconn, outconn);
 			if (ret)
 				coresight_control_assoc_ectdev(csdev, false);
 		}
@@ -385,33 +369,36 @@ static void coresight_disable_link(struct coresight_device *csdev,
 				   struct coresight_device *parent,
 				   struct coresight_device *child)
 {
-	int i, nr_conns;
+	int i;
 	int link_subtype;
-	int inport, outport;
+	struct coresight_connection *inconn, *outconn;
 
 	if (!parent || !child)
 		return;
 
-	inport = coresight_find_link_inport(csdev, parent);
-	outport = coresight_find_link_outport(csdev, child);
+	inconn = coresight_find_out_connection(parent, csdev);
+	outconn = coresight_find_out_connection(csdev, child);
 	link_subtype = csdev->subtype.link_subtype;
 
-	if (link_subtype == CORESIGHT_DEV_SUBTYPE_LINK_MERG) {
-		nr_conns = csdev->pdata->high_inport;
-	} else if (link_subtype == CORESIGHT_DEV_SUBTYPE_LINK_SPLIT) {
-		nr_conns = csdev->pdata->high_outport;
-	} else {
-		nr_conns = 1;
-	}
-
 	if (link_ops(csdev)->disable) {
-		link_ops(csdev)->disable(csdev, inport, outport);
+		link_ops(csdev)->disable(csdev, inconn, outconn);
 		coresight_control_assoc_ectdev(csdev, false);
 	}
 
-	for (i = 0; i < nr_conns; i++)
-		if (atomic_read(&csdev->refcnt[i]) != 0)
+	if (link_subtype == CORESIGHT_DEV_SUBTYPE_LINK_MERG) {
+		for (i = 0; i < csdev->pdata->nr_inconns; i++)
+			if (atomic_read(&csdev->pdata->in_conns[i]->dest_refcnt) !=
+			    0)
+				return;
+	} else if (link_subtype == CORESIGHT_DEV_SUBTYPE_LINK_SPLIT) {
+		for (i = 0; i < csdev->pdata->nr_outconns; i++)
+			if (atomic_read(&csdev->pdata->out_conns[i]->src_refcnt) !=
+			    0)
+				return;
+	} else {
+		if (atomic_read(&csdev->refcnt) != 0)
 			return;
+	}
 
 	csdev->enable = false;
 }
@@ -435,7 +422,7 @@ static int coresight_enable_source(struct coresight_device *csdev,
 		csdev->enable = true;
 	}
 
-	atomic_inc(csdev->refcnt);
+	atomic_inc(&csdev->refcnt);
 
 	return 0;
 }
@@ -450,7 +437,7 @@ static int coresight_enable_source(struct coresight_device *csdev,
  */
 static bool coresight_disable_source(struct coresight_device *csdev)
 {
-	if (atomic_dec_return(csdev->refcnt) == 0) {
+	if (atomic_dec_return(&csdev->refcnt) == 0) {
 		if (source_ops(csdev)->disable)
 			source_ops(csdev)->disable(csdev, NULL);
 		coresight_control_assoc_ectdev(csdev, false);
@@ -1094,7 +1081,7 @@ int coresight_enable(struct coresight_device *csdev)
 		 * source is already enabled.
 		 */
 		if (subtype == CORESIGHT_DEV_SUBTYPE_SOURCE_SOFTWARE)
-			atomic_inc(csdev->refcnt);
+			atomic_inc(&csdev->refcnt);
 		goto out;
 	}
 
@@ -1308,7 +1295,6 @@ static void coresight_device_release(struct device *dev)
 	struct coresight_device *csdev = to_coresight_device(dev);
 
 	fwnode_handle_put(csdev->dev.fwnode);
-	kfree(csdev->refcnt);
 	kfree(csdev);
 }
 
@@ -1537,9 +1523,6 @@ void coresight_release_platform_data(struct coresight_device *csdev,
 struct coresight_device *coresight_register(struct coresight_desc *desc)
 {
 	int ret;
-	int link_subtype;
-	int nr_refcnts = 1;
-	atomic_t *refcnts = NULL;
 	struct coresight_device *csdev;
 	bool registered = false;
 
@@ -1549,25 +1532,6 @@ struct coresight_device *coresight_register(struct coresight_desc *desc)
 		goto err_out;
 	}
 
-	if (desc->type == CORESIGHT_DEV_TYPE_LINK ||
-	    desc->type == CORESIGHT_DEV_TYPE_LINKSINK) {
-		link_subtype = desc->subtype.link_subtype;
-
-		if (link_subtype == CORESIGHT_DEV_SUBTYPE_LINK_MERG)
-			nr_refcnts = desc->pdata->high_inport;
-		else if (link_subtype == CORESIGHT_DEV_SUBTYPE_LINK_SPLIT)
-			nr_refcnts = desc->pdata->high_outport;
-	}
-
-	refcnts = kcalloc(nr_refcnts, sizeof(*refcnts), GFP_KERNEL);
-	if (!refcnts) {
-		ret = -ENOMEM;
-		kfree(csdev);
-		goto err_out;
-	}
-
-	csdev->refcnt = refcnts;
-
 	csdev->pdata = desc->pdata;
 
 	csdev->type = desc->type;
diff --git a/drivers/hwtracing/coresight/coresight-etb10.c b/drivers/hwtracing/coresight/coresight-etb10.c
index eb99c445015a..fa80039e0821 100644
--- a/drivers/hwtracing/coresight/coresight-etb10.c
+++ b/drivers/hwtracing/coresight/coresight-etb10.c
@@ -163,7 +163,7 @@ static int etb_enable_sysfs(struct coresight_device *csdev)
 		drvdata->mode = CS_MODE_SYSFS;
 	}
 
-	atomic_inc(csdev->refcnt);
+	atomic_inc(&csdev->refcnt);
 out:
 	spin_unlock_irqrestore(&drvdata->spinlock, flags);
 	return ret;
@@ -199,7 +199,7 @@ static int etb_enable_perf(struct coresight_device *csdev, void *data)
 	 * use for this session.
 	 */
 	if (drvdata->pid == pid) {
-		atomic_inc(csdev->refcnt);
+		atomic_inc(&csdev->refcnt);
 		goto out;
 	}
 
@@ -217,7 +217,7 @@ static int etb_enable_perf(struct coresight_device *csdev, void *data)
 		/* Associate with monitored process. */
 		drvdata->pid = pid;
 		drvdata->mode = CS_MODE_PERF;
-		atomic_inc(csdev->refcnt);
+		atomic_inc(&csdev->refcnt);
 	}
 
 out:
@@ -356,7 +356,7 @@ static int etb_disable(struct coresight_device *csdev)
 
 	spin_lock_irqsave(&drvdata->spinlock, flags);
 
-	if (atomic_dec_return(csdev->refcnt)) {
+	if (atomic_dec_return(&csdev->refcnt)) {
 		spin_unlock_irqrestore(&drvdata->spinlock, flags);
 		return -EBUSY;
 	}
@@ -447,7 +447,7 @@ static unsigned long etb_update_buffer(struct coresight_device *csdev,
 	spin_lock_irqsave(&drvdata->spinlock, flags);
 
 	/* Don't do anything if another tracer is using this sink */
-	if (atomic_read(csdev->refcnt) != 1)
+	if (atomic_read(&csdev->refcnt) != 1)
 		goto out;
 
 	__etb_disable_hw(drvdata);
diff --git a/drivers/hwtracing/coresight/coresight-funnel.c b/drivers/hwtracing/coresight/coresight-funnel.c
index b363dd6bc510..b8e150e45b27 100644
--- a/drivers/hwtracing/coresight/coresight-funnel.c
+++ b/drivers/hwtracing/coresight/coresight-funnel.c
@@ -74,8 +74,9 @@ static int dynamic_funnel_enable_hw(struct funnel_drvdata *drvdata, int port)
 	return rc;
 }
 
-static int funnel_enable(struct coresight_device *csdev, int inport,
-			 int outport)
+static int funnel_enable(struct coresight_device *csdev,
+			 struct coresight_connection *in,
+			 struct coresight_connection *out)
 {
 	int rc = 0;
 	struct funnel_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
@@ -83,18 +84,19 @@ static int funnel_enable(struct coresight_device *csdev, int inport,
 	bool first_enable = false;
 
 	spin_lock_irqsave(&drvdata->spinlock, flags);
-	if (atomic_read(&csdev->refcnt[inport]) == 0) {
+	if (atomic_read(&in->dest_refcnt) == 0) {
 		if (drvdata->base)
-			rc = dynamic_funnel_enable_hw(drvdata, inport);
+			rc = dynamic_funnel_enable_hw(drvdata, in->dest_port);
 		if (!rc)
 			first_enable = true;
 	}
 	if (!rc)
-		atomic_inc(&csdev->refcnt[inport]);
+		atomic_inc(&in->dest_refcnt);
 	spin_unlock_irqrestore(&drvdata->spinlock, flags);
 
 	if (first_enable)
-		dev_dbg(&csdev->dev, "FUNNEL inport %d enabled\n", inport);
+		dev_dbg(&csdev->dev, "FUNNEL inport %d enabled\n",
+			in->dest_port);
 	return rc;
 }
 
@@ -117,23 +119,25 @@ static void dynamic_funnel_disable_hw(struct funnel_drvdata *drvdata,
 	CS_LOCK(drvdata->base);
 }
 
-static void funnel_disable(struct coresight_device *csdev, int inport,
-			   int outport)
+static void funnel_disable(struct coresight_device *csdev,
+			   struct coresight_connection *in,
+			   struct coresight_connection *out)
 {
 	struct funnel_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
 	unsigned long flags;
 	bool last_disable = false;
 
 	spin_lock_irqsave(&drvdata->spinlock, flags);
-	if (atomic_dec_return(&csdev->refcnt[inport]) == 0) {
+	if (atomic_dec_return(&in->dest_refcnt) == 0) {
 		if (drvdata->base)
-			dynamic_funnel_disable_hw(drvdata, inport);
+			dynamic_funnel_disable_hw(drvdata, in->dest_port);
 		last_disable = true;
 	}
 	spin_unlock_irqrestore(&drvdata->spinlock, flags);
 
 	if (last_disable)
-		dev_dbg(&csdev->dev, "FUNNEL inport %d disabled\n", inport);
+		dev_dbg(&csdev->dev, "FUNNEL inport %d disabled\n",
+			in->dest_port);
 }
 
 static const struct coresight_ops_link funnel_link_ops = {
diff --git a/drivers/hwtracing/coresight/coresight-platform.c b/drivers/hwtracing/coresight/coresight-platform.c
index 257ad48925a1..3e2e135cb8f6 100644
--- a/drivers/hwtracing/coresight/coresight-platform.c
+++ b/drivers/hwtracing/coresight/coresight-platform.c
@@ -146,41 +146,6 @@ static inline bool of_coresight_legacy_ep_is_input(struct device_node *ep)
 	return of_property_read_bool(ep, "slave-mode");
 }
 
-static void of_coresight_get_ports_legacy(const struct device_node *node,
-					  int *nr_inconns, int *nr_outconns)
-{
-	struct device_node *ep = NULL;
-	struct of_endpoint endpoint;
-	int in = 0, out = 0;
-
-	/*
-	 * Avoid warnings in of_graph_get_next_endpoint()
-	 * if the device doesn't have any graph connections
-	 */
-	if (!of_graph_is_present(node))
-		return;
-	do {
-		ep = of_graph_get_next_endpoint(node, ep);
-		if (!ep)
-			break;
-
-		if (of_graph_parse_endpoint(ep, &endpoint))
-			continue;
-
-		if (of_coresight_legacy_ep_is_input(ep)) {
-			in = (endpoint.port + 1 > in) ?
-				endpoint.port + 1 : in;
-		} else {
-			out = (endpoint.port + 1) > out ?
-				endpoint.port + 1 : out;
-		}
-
-	} while (ep);
-
-	*nr_inconns = in;
-	*nr_outconns = out;
-}
-
 static struct device_node *of_coresight_get_port_parent(struct device_node *ep)
 {
 	struct device_node *parent = of_graph_get_port_parent(ep);
@@ -196,59 +161,12 @@ static struct device_node *of_coresight_get_port_parent(struct device_node *ep)
 	return parent;
 }
 
-static inline struct device_node *
-of_coresight_get_input_ports_node(const struct device_node *node)
-{
-	return of_get_child_by_name(node, "in-ports");
-}
-
 static inline struct device_node *
 of_coresight_get_output_ports_node(const struct device_node *node)
 {
 	return of_get_child_by_name(node, "out-ports");
 }
 
-static inline int
-of_coresight_count_ports(struct device_node *port_parent)
-{
-	int i = 0;
-	struct device_node *ep = NULL;
-	struct of_endpoint endpoint;
-
-	while ((ep = of_graph_get_next_endpoint(port_parent, ep))) {
-		/* Defer error handling to parsing */
-		if (of_graph_parse_endpoint(ep, &endpoint))
-			continue;
-		if (endpoint.port + 1 > i)
-			i = endpoint.port + 1;
-	}
-
-	return i;
-}
-
-static void of_coresight_get_ports(const struct device_node *node,
-				   int *nr_inconns, int *nr_outconns)
-{
-	struct device_node *input_ports = NULL, *output_ports = NULL;
-
-	input_ports = of_coresight_get_input_ports_node(node);
-	output_ports = of_coresight_get_output_ports_node(node);
-
-	if (input_ports || output_ports) {
-		if (input_ports) {
-			*nr_inconns = of_coresight_count_ports(input_ports);
-			of_node_put(input_ports);
-		}
-		if (output_ports) {
-			*nr_outconns = of_coresight_count_ports(output_ports);
-			of_node_put(output_ports);
-		}
-	} else {
-		/* Fall back to legacy DT bindings parsing */
-		of_coresight_get_ports_legacy(node, nr_inconns, nr_outconns);
-	}
-}
-
 static int of_coresight_get_cpu(struct device *dev)
 {
 	int cpu;
@@ -351,13 +269,6 @@ static int of_get_coresight_platform_data(struct device *dev,
 	bool legacy_binding = false;
 	struct device_node *node = dev->of_node;
 
-	/* Get the number of input and output port for this component */
-	of_coresight_get_ports(node, &pdata->high_inport, &pdata->high_outport);
-
-	/* If there are no output connections, we are done */
-	if (!pdata->high_outport)
-		return 0;
-
 	parent = of_coresight_get_output_ports_node(node);
 	/*
 	 * If the DT uses obsoleted bindings, the ports are listed
@@ -365,6 +276,12 @@ static int of_get_coresight_platform_data(struct device *dev,
 	 * ports.
 	 */
 	if (!parent) {
+		/*
+		 * Avoid warnings in of_graph_get_next_endpoint()
+		 * if the device doesn't have any graph connections
+		 */
+		if (!of_graph_is_present(node))
+			return 0;
 		legacy_binding = true;
 		parent = node;
 		dev_warn_once(dev, "Uses obsolete Coresight DT bindings\n");
@@ -751,7 +668,6 @@ static int acpi_coresight_parse_graph(struct device *dev,
 	struct coresight_connection conn, zero_conn = {};
 	struct coresight_connection *new_conn;
 
-	pdata->nr_inconns = pdata->nr_outconns = 0;
 	graph = acpi_get_coresight_graph(adev);
 	if (!graph)
 		return -ENOENT;
@@ -770,22 +686,9 @@ static int acpi_coresight_parse_graph(struct device *dev,
 			return dir;
 
 		if (dir == ACPI_CORESIGHT_LINK_MASTER) {
-			if (conn.src_port >= pdata->high_outport)
-				pdata->high_outport = conn.src_port + 1;
 			new_conn = coresight_add_out_conn(dev, pdata, &conn);
 			if (IS_ERR(new_conn))
 				return PTR_ERR(new_conn);
-		} else {
-			WARN_ON(pdata->high_inport == conn.dest_port + 1);
-			/*
-			 * We do not track input port connections for a device.
-			 * However we need the highest port number described,
-			 * which can be recorded now and reuse this connection
-			 * record for an output connection. Hence, do not move
-			 * the ptr for input connections
-			 */
-			if (conn.dest_port >= pdata->high_inport)
-				pdata->high_inport = conn.dest_port + 1;
 		}
 	}
 
diff --git a/drivers/hwtracing/coresight/coresight-replicator.c b/drivers/hwtracing/coresight/coresight-replicator.c
index 4dd50546d7e4..b6be73034996 100644
--- a/drivers/hwtracing/coresight/coresight-replicator.c
+++ b/drivers/hwtracing/coresight/coresight-replicator.c
@@ -114,8 +114,9 @@ static int dynamic_replicator_enable(struct replicator_drvdata *drvdata,
 	return rc;
 }
 
-static int replicator_enable(struct coresight_device *csdev, int inport,
-			     int outport)
+static int replicator_enable(struct coresight_device *csdev,
+			     struct coresight_connection *in,
+			     struct coresight_connection *out)
 {
 	int rc = 0;
 	struct replicator_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
@@ -123,15 +124,15 @@ static int replicator_enable(struct coresight_device *csdev, int inport,
 	bool first_enable = false;
 
 	spin_lock_irqsave(&drvdata->spinlock, flags);
-	if (atomic_read(&csdev->refcnt[outport]) == 0) {
+	if (atomic_read(&out->src_refcnt) == 0) {
 		if (drvdata->base)
-			rc = dynamic_replicator_enable(drvdata, inport,
-						       outport);
+			rc = dynamic_replicator_enable(drvdata, in->dest_port,
+						       out->src_port);
 		if (!rc)
 			first_enable = true;
 	}
 	if (!rc)
-		atomic_inc(&csdev->refcnt[outport]);
+		atomic_inc(&out->src_refcnt);
 	spin_unlock_irqrestore(&drvdata->spinlock, flags);
 
 	if (first_enable)
@@ -168,17 +169,19 @@ static void dynamic_replicator_disable(struct replicator_drvdata *drvdata,
 	CS_LOCK(drvdata->base);
 }
 
-static void replicator_disable(struct coresight_device *csdev, int inport,
-			       int outport)
+static void replicator_disable(struct coresight_device *csdev,
+			       struct coresight_connection *in,
+			       struct coresight_connection *out)
 {
 	struct replicator_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
 	unsigned long flags;
 	bool last_disable = false;
 
 	spin_lock_irqsave(&drvdata->spinlock, flags);
-	if (atomic_dec_return(&csdev->refcnt[outport]) == 0) {
+	if (atomic_dec_return(&out->src_refcnt) == 0) {
 		if (drvdata->base)
-			dynamic_replicator_disable(drvdata, inport, outport);
+			dynamic_replicator_disable(drvdata, in->dest_port,
+						   out->src_port);
 		last_disable = true;
 	}
 	spin_unlock_irqrestore(&drvdata->spinlock, flags);
diff --git a/drivers/hwtracing/coresight/coresight-tmc-etf.c b/drivers/hwtracing/coresight/coresight-tmc-etf.c
index 14d3c1472455..79d8c64eac49 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etf.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etf.c
@@ -206,7 +206,7 @@ static int tmc_enable_etf_sink_sysfs(struct coresight_device *csdev)
 	 * touched.
 	 */
 	if (drvdata->mode == CS_MODE_SYSFS) {
-		atomic_inc(csdev->refcnt);
+		atomic_inc(&csdev->refcnt);
 		goto out;
 	}
 
@@ -229,7 +229,7 @@ static int tmc_enable_etf_sink_sysfs(struct coresight_device *csdev)
 	ret = tmc_etb_enable_hw(drvdata);
 	if (!ret) {
 		drvdata->mode = CS_MODE_SYSFS;
-		atomic_inc(csdev->refcnt);
+		atomic_inc(&csdev->refcnt);
 	} else {
 		/* Free up the buffer if we failed to enable */
 		used = false;
@@ -284,7 +284,7 @@ static int tmc_enable_etf_sink_perf(struct coresight_device *csdev, void *data)
 		 * use for this session.
 		 */
 		if (drvdata->pid == pid) {
-			atomic_inc(csdev->refcnt);
+			atomic_inc(&csdev->refcnt);
 			break;
 		}
 
@@ -293,7 +293,7 @@ static int tmc_enable_etf_sink_perf(struct coresight_device *csdev, void *data)
 			/* Associate with monitored process. */
 			drvdata->pid = pid;
 			drvdata->mode = CS_MODE_PERF;
-			atomic_inc(csdev->refcnt);
+			atomic_inc(&csdev->refcnt);
 		}
 	} while (0);
 	spin_unlock_irqrestore(&drvdata->spinlock, flags);
@@ -338,7 +338,7 @@ static int tmc_disable_etf_sink(struct coresight_device *csdev)
 		return -EBUSY;
 	}
 
-	if (atomic_dec_return(csdev->refcnt)) {
+	if (atomic_dec_return(&csdev->refcnt)) {
 		spin_unlock_irqrestore(&drvdata->spinlock, flags);
 		return -EBUSY;
 	}
@@ -357,7 +357,8 @@ static int tmc_disable_etf_sink(struct coresight_device *csdev)
 }
 
 static int tmc_enable_etf_link(struct coresight_device *csdev,
-			       int inport, int outport)
+			       struct coresight_connection *in,
+			       struct coresight_connection *out)
 {
 	int ret = 0;
 	unsigned long flags;
@@ -370,7 +371,7 @@ static int tmc_enable_etf_link(struct coresight_device *csdev,
 		return -EBUSY;
 	}
 
-	if (atomic_read(&csdev->refcnt[0]) == 0) {
+	if (atomic_read(&csdev->refcnt) == 0) {
 		ret = tmc_etf_enable_hw(drvdata);
 		if (!ret) {
 			drvdata->mode = CS_MODE_SYSFS;
@@ -378,7 +379,7 @@ static int tmc_enable_etf_link(struct coresight_device *csdev,
 		}
 	}
 	if (!ret)
-		atomic_inc(&csdev->refcnt[0]);
+		atomic_inc(&csdev->refcnt);
 	spin_unlock_irqrestore(&drvdata->spinlock, flags);
 
 	if (first_enable)
@@ -387,7 +388,8 @@ static int tmc_enable_etf_link(struct coresight_device *csdev,
 }
 
 static void tmc_disable_etf_link(struct coresight_device *csdev,
-				 int inport, int outport)
+				 struct coresight_connection *in,
+				 struct coresight_connection *out)
 {
 	unsigned long flags;
 	struct tmc_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
@@ -399,7 +401,7 @@ static void tmc_disable_etf_link(struct coresight_device *csdev,
 		return;
 	}
 
-	if (atomic_dec_return(&csdev->refcnt[0]) == 0) {
+	if (atomic_dec_return(&csdev->refcnt) == 0) {
 		tmc_etf_disable_hw(drvdata);
 		drvdata->mode = CS_MODE_DISABLED;
 		last_disable = true;
@@ -487,7 +489,7 @@ static unsigned long tmc_update_etf_buffer(struct coresight_device *csdev,
 	spin_lock_irqsave(&drvdata->spinlock, flags);
 
 	/* Don't do anything if another tracer is using this sink */
-	if (atomic_read(csdev->refcnt) != 1)
+	if (atomic_read(&csdev->refcnt) != 1)
 		goto out;
 
 	CS_UNLOCK(drvdata->base);
diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
index 1bbe5410a23d..689ba6abc70b 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
@@ -1209,7 +1209,7 @@ static int tmc_enable_etr_sink_sysfs(struct coresight_device *csdev)
 	 * touched, even if the buffer size has changed.
 	 */
 	if (drvdata->mode == CS_MODE_SYSFS) {
-		atomic_inc(csdev->refcnt);
+		atomic_inc(&csdev->refcnt);
 		goto out;
 	}
 
@@ -1226,7 +1226,7 @@ static int tmc_enable_etr_sink_sysfs(struct coresight_device *csdev)
 	ret = tmc_etr_enable_hw(drvdata, drvdata->sysfs_buf);
 	if (!ret) {
 		drvdata->mode = CS_MODE_SYSFS;
-		atomic_inc(csdev->refcnt);
+		atomic_inc(&csdev->refcnt);
 	}
 out:
 	spin_unlock_irqrestore(&drvdata->spinlock, flags);
@@ -1535,7 +1535,7 @@ tmc_update_etr_buffer(struct coresight_device *csdev,
 	spin_lock_irqsave(&drvdata->spinlock, flags);
 
 	/* Don't do anything if another tracer is using this sink */
-	if (atomic_read(csdev->refcnt) != 1) {
+	if (atomic_read(&csdev->refcnt) != 1) {
 		spin_unlock_irqrestore(&drvdata->spinlock, flags);
 		goto out;
 	}
@@ -1647,7 +1647,7 @@ static int tmc_enable_etr_sink_perf(struct coresight_device *csdev, void *data)
 	 * use for this session.
 	 */
 	if (drvdata->pid == pid) {
-		atomic_inc(csdev->refcnt);
+		atomic_inc(&csdev->refcnt);
 		goto unlock_out;
 	}
 
@@ -1657,7 +1657,7 @@ static int tmc_enable_etr_sink_perf(struct coresight_device *csdev, void *data)
 		drvdata->pid = pid;
 		drvdata->mode = CS_MODE_PERF;
 		drvdata->perf_buf = etr_perf->etr_buf;
-		atomic_inc(csdev->refcnt);
+		atomic_inc(&csdev->refcnt);
 	}
 
 unlock_out:
@@ -1690,7 +1690,7 @@ static int tmc_disable_etr_sink(struct coresight_device *csdev)
 		return -EBUSY;
 	}
 
-	if (atomic_dec_return(csdev->refcnt)) {
+	if (atomic_dec_return(&csdev->refcnt)) {
 		spin_unlock_irqrestore(&drvdata->spinlock, flags);
 		return -EBUSY;
 	}
diff --git a/drivers/hwtracing/coresight/coresight-tpda.c b/drivers/hwtracing/coresight/coresight-tpda.c
index f712e112ecff..8d2b9d29237d 100644
--- a/drivers/hwtracing/coresight/coresight-tpda.c
+++ b/drivers/hwtracing/coresight/coresight-tpda.c
@@ -54,18 +54,20 @@ static void __tpda_enable(struct tpda_drvdata *drvdata, int port)
 	CS_LOCK(drvdata->base);
 }
 
-static int tpda_enable(struct coresight_device *csdev, int inport, int outport)
+static int tpda_enable(struct coresight_device *csdev,
+		       struct coresight_connection *in,
+		       struct coresight_connection *out)
 {
 	struct tpda_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
 
 	spin_lock(&drvdata->spinlock);
-	if (atomic_read(&csdev->refcnt[inport]) == 0)
-		__tpda_enable(drvdata, inport);
+	if (atomic_read(&in->dest_refcnt) == 0)
+		__tpda_enable(drvdata, in->dest_port);
 
-	atomic_inc(&csdev->refcnt[inport]);
+	atomic_inc(&in->dest_refcnt);
 	spin_unlock(&drvdata->spinlock);
 
-	dev_dbg(drvdata->dev, "TPDA inport %d enabled.\n", inport);
+	dev_dbg(drvdata->dev, "TPDA inport %d enabled.\n", in->dest_port);
 	return 0;
 }
 
@@ -82,18 +84,19 @@ static void __tpda_disable(struct tpda_drvdata *drvdata, int port)
 	CS_LOCK(drvdata->base);
 }
 
-static void tpda_disable(struct coresight_device *csdev, int inport,
-			   int outport)
+static void tpda_disable(struct coresight_device *csdev,
+			 struct coresight_connection *in,
+			 struct coresight_connection *out)
 {
 	struct tpda_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
 
 	spin_lock(&drvdata->spinlock);
-	if (atomic_dec_return(&csdev->refcnt[inport]) == 0)
-		__tpda_disable(drvdata, inport);
+	if (atomic_dec_return(&in->dest_refcnt) == 0)
+		__tpda_disable(drvdata, in->dest_port);
 
 	spin_unlock(&drvdata->spinlock);
 
-	dev_dbg(drvdata->dev, "TPDA inport %d disabled\n", inport);
+	dev_dbg(drvdata->dev, "TPDA inport %d disabled\n", in->dest_port);
 }
 
 static const struct coresight_ops_link tpda_link_ops = {
diff --git a/drivers/hwtracing/coresight/coresight-tpiu.c b/drivers/hwtracing/coresight/coresight-tpiu.c
index b0179f761c98..59eac93fd6bb 100644
--- a/drivers/hwtracing/coresight/coresight-tpiu.c
+++ b/drivers/hwtracing/coresight/coresight-tpiu.c
@@ -73,7 +73,7 @@ static int tpiu_enable(struct coresight_device *csdev, enum cs_mode mode,
 		       void *__unused)
 {
 	tpiu_enable_hw(&csdev->access);
-	atomic_inc(csdev->refcnt);
+	atomic_inc(&csdev->refcnt);
 	dev_dbg(&csdev->dev, "TPIU enabled\n");
 	return 0;
 }
@@ -96,7 +96,7 @@ static void tpiu_disable_hw(struct csdev_access *csa)
 
 static int tpiu_disable(struct coresight_device *csdev)
 {
-	if (atomic_dec_return(csdev->refcnt))
+	if (atomic_dec_return(&csdev->refcnt))
 		return -EBUSY;
 
 	tpiu_disable_hw(&csdev->access);
diff --git a/drivers/hwtracing/coresight/ultrasoc-smb.c b/drivers/hwtracing/coresight/ultrasoc-smb.c
index a2ced0b3c3cd..e9a32a97fbee 100644
--- a/drivers/hwtracing/coresight/ultrasoc-smb.c
+++ b/drivers/hwtracing/coresight/ultrasoc-smb.c
@@ -106,7 +106,7 @@ static int smb_open(struct inode *inode, struct file *file)
 		goto out;
 	}
 
-	if (atomic_read(drvdata->csdev->refcnt)) {
+	if (atomic_read(&drvdata->csdev->refcnt)) {
 		ret = -EBUSY;
 		goto out;
 	}
@@ -290,7 +290,7 @@ static int smb_enable(struct coresight_device *csdev, enum cs_mode mode,
 	if (ret)
 		goto out;
 
-	atomic_inc(csdev->refcnt);
+	atomic_inc(&csdev->refcnt);
 
 	dev_dbg(&csdev->dev, "Ultrasoc SMB enabled\n");
 out:
@@ -311,7 +311,7 @@ static int smb_disable(struct coresight_device *csdev)
 		goto out;
 	}
 
-	if (atomic_dec_return(csdev->refcnt)) {
+	if (atomic_dec_return(&csdev->refcnt)) {
 		ret = -EBUSY;
 		goto out;
 	}
@@ -411,7 +411,7 @@ static unsigned long smb_update_buffer(struct coresight_device *csdev,
 	mutex_lock(&drvdata->mutex);
 
 	/* Don't do anything if another tracer is using this sink. */
-	if (atomic_read(csdev->refcnt) != 1)
+	if (atomic_read(&csdev->refcnt) != 1)
 		goto out;
 
 	smb_disable_hw(drvdata);
diff --git a/include/linux/coresight.h b/include/linux/coresight.h
index e9c52c5ca7f3..b97edd24f3ec 100644
--- a/include/linux/coresight.h
+++ b/include/linux/coresight.h
@@ -111,8 +111,6 @@ union coresight_dev_subtype {
  *            unloaded the connection leaves an empty slot.
  */
 struct coresight_platform_data {
-	int high_inport;
-	int high_outport;
 	int nr_inconns;
 	int nr_outconns;
 	struct coresight_connection **out_conns;
@@ -205,6 +203,8 @@ struct coresight_connection {
 	struct coresight_device *dest_dev;
 	struct coresight_sysfs_link *link;
 	struct coresight_device *src_dev;
+	atomic_t src_refcnt;
+	atomic_t dest_refcnt;
 };
 
 /**
@@ -256,7 +256,7 @@ struct coresight_device {
 	const struct coresight_ops *ops;
 	struct csdev_access access;
 	struct device dev;
-	atomic_t *refcnt;
+	atomic_t refcnt;
 	bool orphan;
 	bool enable;	/* true only if configured as part of a path */
 	/* sink specific fields */
@@ -341,8 +341,12 @@ struct coresight_ops_sink {
  * @disable:	disables flow between iport and oport.
  */
 struct coresight_ops_link {
-	int (*enable)(struct coresight_device *csdev, int iport, int oport);
-	void (*disable)(struct coresight_device *csdev, int iport, int oport);
+	int (*enable)(struct coresight_device *csdev,
+		      struct coresight_connection *in,
+		      struct coresight_connection *out);
+	void (*disable)(struct coresight_device *csdev,
+			struct coresight_connection *in,
+			struct coresight_connection *out);
 };
 
 /**
-- 
2.34.1

