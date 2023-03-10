Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A7B46B4C3C
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 17:10:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230419AbjCJQKq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 11:10:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231696AbjCJQKH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 11:10:07 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 826A3EFA8
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 08:08:11 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DBBA61762;
        Fri, 10 Mar 2023 08:07:42 -0800 (PST)
Received: from e127643.. (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0566E3F5A1;
        Fri, 10 Mar 2023 08:06:57 -0800 (PST)
From:   James Clark <james.clark@arm.com>
To:     coresight@lists.linaro.org
Cc:     James Clark <james.clark@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/9] coresight: Dynamically add connections
Date:   Fri, 10 Mar 2023 16:06:04 +0000
Message-Id: <20230310160610.742382-6-james.clark@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230310160610.742382-1-james.clark@arm.com>
References: <20230310160610.742382-1-james.clark@arm.com>
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
 2 files changed, 64 insertions(+), 20 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-platform.c b/drivers/hwtracing/coresight/coresight-platform.c
index c77238cdf448..16553f7dde12 100644
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
+		if (i->remote_fwnode && conn->port != -1 &&
+		    i->port == conn->port) {
+			dev_warn(dev, "Duplicate output port %d\n", i->port);
+			return -EINVAL;
+		}
+		if (!i->remote_fwnode && !free_conn)
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
-		if (conn->remote_fwnode) {
-			dev_warn(dev, "Duplicate output port %d\n",
-				 endpoint.port);
-			ret = -EINVAL;
-			break;
-		}
-		conn->port = endpoint.port;
+		conn.port = endpoint.port;
 		/*
 		 * Hold the refcount to the target device. This could be
 		 * released via:
@@ -267,8 +303,14 @@ static int of_coresight_parse_endpoint(struct device *dev,
 		 * 2) While removing the target device via
 		 *    coresight_remove_match()
 		 */
-		conn->remote_fwnode = fwnode_handle_get(rdev_fwnode);
-		conn->remote_port = rendpoint.port;
+		conn.remote_fwnode = fwnode_handle_get(rdev_fwnode);
+		conn.remote_port = rendpoint.port;
+
+		ret = coresight_add_conn(dev, pdata, &conn);
+		if (ret) {
+			fwnode_handle_put(conn.remote_fwnode);
+			return ret;
+		}
 		/* Connection record updated */
 	} while (0);
 
@@ -741,13 +783,10 @@ static int acpi_coresight_parse_graph(struct acpi_device *adev,
 
 	/* Copy the connection information to the final location */
 	for (i = 0; conns + i < ptr; i++) {
-		int port = conns[i].port;
-
-		/* Duplicate output port */
-		WARN_ON(pdata->out_conns[port].remote_fwnode);
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
index 64bb5fc95afa..47fa58d6981d 100644
--- a/include/linux/coresight.h
+++ b/include/linux/coresight.h
@@ -173,7 +173,9 @@ struct coresight_desc {
  *		 on the remote device.
  * @remote_fwnode: remote component's fwnode handle.
  * @remote_dev:  a @coresight_device representation of the component
- *		 connected to @port.
+ *               connected to @port. Will be looked up using
+ *               @remote_fwnode once the remote's coresight_device has
+ *               been created.
  * @link: Representation of the connection as a sysfs link.
  */
 struct coresight_connection {
@@ -614,5 +616,8 @@ static inline void coresight_write64(struct coresight_device *csdev, u64 val, u3
 extern int coresight_get_cpu(struct device *dev);
 
 struct coresight_platform_data *coresight_get_platform_data(struct device *dev);
+int coresight_add_conn(struct device *dev,
+		       struct coresight_platform_data *pdata,
+		       const struct coresight_connection *conn);
 
 #endif		/* _LINUX_COREISGHT_H */
-- 
2.34.1

