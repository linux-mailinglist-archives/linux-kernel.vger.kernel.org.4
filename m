Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0EE56B1049
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 18:39:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbjCHRjp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 12:39:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbjCHRj3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 12:39:29 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9D153C1C37
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 09:39:25 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D188D1063;
        Wed,  8 Mar 2023 09:40:08 -0800 (PST)
Received: from e127643.arm.com (unknown [10.57.48.148])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D882B3F67D;
        Wed,  8 Mar 2023 09:39:23 -0800 (PST)
From:   James Clark <james.clark@arm.com>
To:     coresight@lists.linaro.org
Cc:     James Clark <james.clark@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/8] coresight: Dynamically add connections
Date:   Wed,  8 Mar 2023 17:38:58 +0000
Message-Id: <20230308173904.3449231-5-james.clark@arm.com>
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

Add a function for adding connections dynamically. This also removes
the 1:1 mapping between port number and the index into the connections
array. The only place this mapping was used was in the warning for
duplicate output ports, which has been replaced by a search. Other
uses of the port number already use the port member variable.

Being able to dynamically add connections will allow other devices like
CTI to re-use the connection mechanism despite not having explicit
connections described in the DT.

Signed-off-by: James Clark <james.clark@arm.com>
---
 .../hwtracing/coresight/coresight-platform.c  | 77 ++++++++++++++-----
 include/linux/coresight.h                     |  7 +-
 2 files changed, 63 insertions(+), 21 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-platform.c b/drivers/hwtracing/coresight/coresight-platform.c
index ed865e0621a9..8effce5937d9 100644
--- a/drivers/hwtracing/coresight/coresight-platform.c
+++ b/drivers/hwtracing/coresight/coresight-platform.c
@@ -27,8 +27,9 @@ static int coresight_alloc_conns(struct device *dev,
 				 struct coresight_platform_data *pdata)
 {
 	if (pdata->nr_outconns) {
-		pdata->out_conns = devm_kcalloc(dev, pdata->nr_outconns,
-					    sizeof(*pdata->out_conns), GFP_KERNEL);
+		pdata->out_conns = devm_krealloc_array(
+			dev, pdata->out_conns, pdata->nr_outconns,
+			sizeof(*pdata->out_conns), GFP_KERNEL | __GFP_ZERO);
 		if (!pdata->out_conns)
 			return -ENOMEM;
 	}
@@ -36,6 +37,48 @@ static int coresight_alloc_conns(struct device *dev,
 	return 0;
 }
 
+/*
+ * Add a connection in the first free slot, or realloc
+ * if there is no space. @conn's contents is copied into the new slot.
+ *
+ * If the output port is already assigned on this device, return -EINVAL
+ */
+int coresight_add_conn(struct device *dev,
+		       struct coresight_platform_data *pdata,
+		       const struct coresight_connection *conn)
+{
+	int ret;
+	struct coresight_connection *free_conn = NULL;
+	struct coresight_connection *i;
+
+	/*
+	 * Search for a free slot, and while looking for one, warn
+	 * on any existing duplicate output port.
+	 */
+	for (i = pdata->out_conns; i < pdata->out_conns + pdata->nr_outconns;
+	     ++i) {
+		if (i->child_fwnode && conn->outport != -1 &&
+		    i->outport == conn->outport) {
+			dev_warn(dev, "Duplicate output port %d\n", i->outport);
+			return -EINVAL;
+		}
+		if (!i->child_fwnode && !free_conn)
+			free_conn = i;
+	}
+
+	if (!free_conn) {
+		pdata->nr_outconns++;
+		ret = coresight_alloc_conns(dev, pdata);
+		if (ret)
+			return ret;
+		free_conn = &pdata->out_conns[pdata->nr_outconns - 1];
+	}
+
+	*free_conn = *conn;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(coresight_add_conn);
+
 static struct device *
 coresight_find_device_by_fwnode(struct fwnode_handle *fwnode)
 {
@@ -224,7 +267,7 @@ static int of_coresight_parse_endpoint(struct device *dev,
 	struct device_node *rep = NULL;
 	struct device *rdev = NULL;
 	struct fwnode_handle *rdev_fwnode;
-	struct coresight_connection *conn;
+	struct coresight_connection conn;
 
 	do {
 		/* Parse the local port details */
@@ -251,14 +294,7 @@ static int of_coresight_parse_endpoint(struct device *dev,
 			break;
 		}
 
-		conn = &pdata->out_conns[endpoint.port];
-		if (conn->child_fwnode) {
-			dev_warn(dev, "Duplicate output port %d\n",
-				 endpoint.port);
-			ret = -EINVAL;
-			break;
-		}
-		conn->outport = endpoint.port;
+		conn.outport = endpoint.port;
 		/*
 		 * Hold the refcount to the target device. This could be
 		 * released via:
@@ -267,8 +303,14 @@ static int of_coresight_parse_endpoint(struct device *dev,
 		 * 2) While removing the target device via
 		 *    coresight_remove_match()
 		 */
-		conn->child_fwnode = fwnode_handle_get(rdev_fwnode);
-		conn->child_port = rendpoint.port;
+		conn.child_fwnode = fwnode_handle_get(rdev_fwnode);
+		conn.child_port = rendpoint.port;
+
+		ret = coresight_add_conn(dev, pdata, &conn);
+		if (ret) {
+			fwnode_handle_put(conn.child_fwnode);
+			return ret;
+		}
 		/* Connection record updated */
 	} while (0);
 
@@ -741,13 +783,10 @@ static int acpi_coresight_parse_graph(struct acpi_device *adev,
 
 	/* Copy the connection information to the final location */
 	for (i = 0; conns + i < ptr; i++) {
-		int port = conns[i].outport;
-
-		/* Duplicate output port */
-		WARN_ON(pdata->out_conns[port].child_fwnode);
-		pdata->out_conns[port] = conns[i];
+		rc = coresight_add_conn(&adev->dev, pdata, &conns[i]);
+		if (rc)
+			return rc;
 	}
-
 	devm_kfree(&adev->dev, conns);
 	return 0;
 }
diff --git a/include/linux/coresight.h b/include/linux/coresight.h
index cdf0d1def778..62cc8e43b6cb 100644
--- a/include/linux/coresight.h
+++ b/include/linux/coresight.h
@@ -167,8 +167,8 @@ struct coresight_desc {
  * @outport:	a connection's output port number.
  * @child_port:	remote component's port number @output is connected to.
  * @chid_fwnode: remote component's fwnode handle.
- * @child_dev:	a @coresight_device representation of the component
-		connected to @outport.
+ * @child_dev:  remote component's @coresight_device representation. Will
+ *		be looked up and assigned using @child_fwnode
  * @link: Representation of the connection as a sysfs link.
  */
 struct coresight_connection {
@@ -609,5 +609,8 @@ static inline void coresight_write64(struct coresight_device *csdev, u64 val, u3
 extern int coresight_get_cpu(struct device *dev);
 
 struct coresight_platform_data *coresight_get_platform_data(struct device *dev);
+int coresight_add_conn(struct device *dev,
+		       struct coresight_platform_data *pdata,
+		       const struct coresight_connection *conn);
 
 #endif		/* _LINUX_COREISGHT_H */
-- 
2.34.1

