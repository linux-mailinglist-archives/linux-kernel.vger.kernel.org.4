Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22D466D6427
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 15:56:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235620AbjDDN4k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 09:56:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235530AbjDDN4N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 09:56:13 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 49DA5558A
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 06:55:26 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6B7FA1576;
        Tue,  4 Apr 2023 06:56:09 -0700 (PDT)
Received: from e127643.broadband (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4CEEC3F762;
        Tue,  4 Apr 2023 06:55:23 -0700 (PDT)
From:   James Clark <james.clark@arm.com>
To:     coresight@lists.linaro.org, quic_jinlmao@quicinc.com,
        mike.leach@linaro.org, suzuki.poulose@arm.com
Cc:     James Clark <james.clark@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 07/13] coresight: Store pointers to connections rather than an array of them
Date:   Tue,  4 Apr 2023 14:53:53 +0100
Message-Id: <20230404135401.1728919-8-james.clark@arm.com>
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

This will allow the same connection object to be referenced via the
input connection list in a later commit rather than duplicating them.

Signed-off-by: James Clark <james.clark@arm.com>
---
 drivers/hwtracing/coresight/coresight-core.c  | 47 ++++++++++---------
 .../hwtracing/coresight/coresight-platform.c  | 10 ++--
 drivers/hwtracing/coresight/coresight-priv.h  |  1 +
 .../hwtracing/coresight/coresight-tmc-etr.c   |  2 +-
 include/linux/coresight.h                     |  5 +-
 5 files changed, 35 insertions(+), 30 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
index 91274e7e6944..0b738960973b 100644
--- a/drivers/hwtracing/coresight/coresight-core.c
+++ b/drivers/hwtracing/coresight/coresight-core.c
@@ -119,7 +119,7 @@ static int coresight_find_link_inport(struct coresight_device *csdev,
 	struct coresight_connection *conn;
 
 	for (i = 0; i < parent->pdata->nr_outconns; i++) {
-		conn = &parent->pdata->out_conns[i];
+		conn = parent->pdata->out_conns[i];
 		if (conn->dest_dev == csdev)
 			return conn->dest_port;
 	}
@@ -137,7 +137,7 @@ static int coresight_find_link_outport(struct coresight_device *csdev,
 	struct coresight_connection *conn;
 
 	for (i = 0; i < csdev->pdata->nr_outconns; i++) {
-		conn = &csdev->pdata->out_conns[i];
+		conn = csdev->pdata->out_conns[i];
 		if (conn->dest_dev == child)
 			return conn->src_port;
 	}
@@ -606,7 +606,7 @@ coresight_find_enabled_sink(struct coresight_device *csdev)
 	for (i = 0; i < csdev->pdata->nr_outconns; i++) {
 		struct coresight_device *child_dev;
 
-		child_dev = csdev->pdata->out_conns[i].dest_dev;
+		child_dev = csdev->pdata->out_conns[i]->dest_dev;
 		if (child_dev)
 			sink = coresight_find_enabled_sink(child_dev);
 		if (sink)
@@ -722,7 +722,7 @@ static int coresight_grab_device(struct coresight_device *csdev)
 	for (i = 0; i < csdev->pdata->nr_outconns; i++) {
 		struct coresight_device *child;
 
-		child = csdev->pdata->out_conns[i].dest_dev;
+		child = csdev->pdata->out_conns[i]->dest_dev;
 		if (child && child->type == CORESIGHT_DEV_TYPE_HELPER)
 			if (!coresight_get_ref(child))
 				goto err;
@@ -733,7 +733,7 @@ static int coresight_grab_device(struct coresight_device *csdev)
 	for (i--; i >= 0; i--) {
 		struct coresight_device *child;
 
-		child = csdev->pdata->out_conns[i].dest_dev;
+		child = csdev->pdata->out_conns[i]->dest_dev;
 		if (child && child->type == CORESIGHT_DEV_TYPE_HELPER)
 			coresight_put_ref(child);
 	}
@@ -752,7 +752,7 @@ static void coresight_drop_device(struct coresight_device *csdev)
 	for (i = 0; i < csdev->pdata->nr_outconns; i++) {
 		struct coresight_device *child;
 
-		child = csdev->pdata->out_conns[i].dest_dev;
+		child = csdev->pdata->out_conns[i]->dest_dev;
 		if (child && child->type == CORESIGHT_DEV_TYPE_HELPER)
 			coresight_put_ref(child);
 	}
@@ -794,7 +794,7 @@ static int _coresight_build_path(struct coresight_device *csdev,
 	for (i = 0; i < csdev->pdata->nr_outconns; i++) {
 		struct coresight_device *child_dev;
 
-		child_dev = csdev->pdata->out_conns[i].dest_dev;
+		child_dev = csdev->pdata->out_conns[i]->dest_dev;
 		if (child_dev &&
 		    _coresight_build_path(child_dev, sink, path) == 0) {
 			found = true;
@@ -964,7 +964,7 @@ coresight_find_sink(struct coresight_device *csdev, int *depth)
 		struct coresight_device *child_dev, *sink = NULL;
 		int child_depth = curr_depth;
 
-		child_dev = csdev->pdata->out_conns[i].dest_dev;
+		child_dev = csdev->pdata->out_conns[i]->dest_dev;
 		if (child_dev)
 			sink = coresight_find_sink(child_dev, &child_depth);
 
@@ -1334,7 +1334,7 @@ static int coresight_orphan_match(struct device *dev, void *data)
 	 * an orphan connection whose name matches @csdev, link it.
 	 */
 	for (i = 0; i < i_csdev->pdata->nr_outconns; i++) {
-		conn = &i_csdev->pdata->out_conns[i];
+		conn = i_csdev->pdata->out_conns[i];
 
 		/* We have found at least one orphan connection */
 		if (conn->dest_dev == NULL) {
@@ -1372,7 +1372,7 @@ static int coresight_fixup_device_conns(struct coresight_device *csdev)
 	int i, ret = 0;
 
 	for (i = 0; i < csdev->pdata->nr_outconns; i++) {
-		struct coresight_connection *conn = &csdev->pdata->out_conns[i];
+		struct coresight_connection *conn = csdev->pdata->out_conns[i];
 
 		conn->dest_dev =
 			coresight_find_csdev_by_fwnode(conn->dest_fwnode);
@@ -1406,15 +1406,12 @@ static int coresight_remove_match(struct device *dev, void *data)
 	 * a connection whose name matches @csdev, remove it.
 	 */
 	for (i = 0; i < iterator->pdata->nr_outconns; i++) {
-		conn = &iterator->pdata->out_conns[i];
+		conn = iterator->pdata->out_conns[i];
 
-		if (conn->dest_dev == NULL)
-			continue;
-
-		if (csdev->dev.fwnode == conn->dest_fwnode) {
+		/* Child_dev being set signifies that the links were made */
+		if (csdev->dev.fwnode == conn->dest_fwnode && conn->dest_dev) {
 			iterator->orphan = true;
 			coresight_remove_links(iterator, conn);
-
 			conn->dest_dev = NULL;
 			/* No need to continue */
 			break;
@@ -1534,22 +1531,26 @@ void coresight_write64(struct coresight_device *csdev, u64 val, u32 offset)
  * to the output port of this device.
  */
 void coresight_release_platform_data(struct coresight_device *csdev,
+				     struct device *dev,
 				     struct coresight_platform_data *pdata)
 {
 	int i;
-	struct coresight_connection *conns = pdata->out_conns;
+	struct coresight_connection **conns = pdata->out_conns;
 
 	for (i = 0; i < pdata->nr_outconns; i++) {
 		/* If we have made the links, remove them now */
-		if (csdev && conns[i].dest_dev)
-			coresight_remove_links(csdev, &conns[i]);
+		if (csdev && conns[i]->dest_dev)
+			coresight_remove_links(csdev, conns[i]);
 		/*
 		 * Drop the refcount and clear the handle as this device
 		 * is going away
 		 */
-		fwnode_handle_put(conns[i].dest_fwnode);
-		conns[i].dest_fwnode = NULL;
+		fwnode_handle_put(conns[i]->dest_fwnode);
+		conns[i]->dest_fwnode = NULL;
+		devm_kfree(dev, conns[i]);
 	}
+	devm_kfree(dev, pdata->out_conns);
+	devm_kfree(dev, pdata);
 	if (csdev)
 		coresight_remove_conns_sysfs_group(csdev);
 }
@@ -1666,7 +1667,7 @@ struct coresight_device *coresight_register(struct coresight_desc *desc)
 
 err_out:
 	/* Cleanup the connection information */
-	coresight_release_platform_data(NULL, desc->pdata);
+	coresight_release_platform_data(NULL, desc->dev, desc->pdata);
 	return ERR_PTR(ret);
 }
 EXPORT_SYMBOL_GPL(coresight_register);
@@ -1679,7 +1680,7 @@ void coresight_unregister(struct coresight_device *csdev)
 		cti_assoc_ops->remove(csdev);
 	coresight_remove_conns(csdev);
 	coresight_clear_default_sink(csdev);
-	coresight_release_platform_data(csdev, csdev->pdata);
+	coresight_release_platform_data(csdev, csdev->dev.parent, csdev->pdata);
 	device_unregister(&csdev->dev);
 }
 EXPORT_SYMBOL_GPL(coresight_unregister);
diff --git a/drivers/hwtracing/coresight/coresight-platform.c b/drivers/hwtracing/coresight/coresight-platform.c
index 8c2029336161..017ea5762988 100644
--- a/drivers/hwtracing/coresight/coresight-platform.c
+++ b/drivers/hwtracing/coresight/coresight-platform.c
@@ -37,7 +37,7 @@ coresight_add_out_conn(struct device *dev,
 	 * Warn on any existing duplicate output port.
 	 */
 	for (i = 0; i < pdata->nr_outconns; ++i) {
-		conn = &pdata->out_conns[i];
+		conn = pdata->out_conns[i];
 		/* Output == -1 means ignore the port for example for helpers */
 		if (conn->src_port != -1 &&
 		    conn->src_port == new_conn->src_port) {
@@ -54,8 +54,10 @@ coresight_add_out_conn(struct device *dev,
 	if (!pdata->out_conns)
 		return ERR_PTR(-ENOMEM);
 
-	pdata->out_conns[pdata->nr_outconns - 1] = *new_conn;
-	return &pdata->out_conns[pdata->nr_outconns - 1];
+	pdata->out_conns[pdata->nr_outconns - 1] = devm_kmalloc(
+		dev, sizeof(struct coresight_connection), GFP_KERNEL);
+	*pdata->out_conns[pdata->nr_outconns - 1] = *new_conn;
+	return pdata->out_conns[pdata->nr_outconns - 1];
 }
 EXPORT_SYMBOL_GPL(coresight_add_out_conn);
 
@@ -863,7 +865,7 @@ coresight_get_platform_data(struct device *dev)
 error:
 	if (!IS_ERR_OR_NULL(pdata))
 		/* Cleanup the connection information */
-		coresight_release_platform_data(NULL, pdata);
+		coresight_release_platform_data(NULL, dev, pdata);
 	return ERR_PTR(ret);
 }
 EXPORT_SYMBOL_GPL(coresight_get_platform_data);
diff --git a/drivers/hwtracing/coresight/coresight-priv.h b/drivers/hwtracing/coresight/coresight-priv.h
index 788ff19c60f6..65ae6d161c57 100644
--- a/drivers/hwtracing/coresight/coresight-priv.h
+++ b/drivers/hwtracing/coresight/coresight-priv.h
@@ -207,6 +207,7 @@ static inline void *coresight_get_uci_data(const struct amba_id *id)
 }
 
 void coresight_release_platform_data(struct coresight_device *csdev,
+				     struct device *dev,
 				     struct coresight_platform_data *pdata);
 struct coresight_device *
 coresight_find_csdev_by_fwnode(struct fwnode_handle *r_fwnode);
diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
index 61234cb8052a..1bbe5410a23d 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
@@ -782,7 +782,7 @@ tmc_etr_get_catu_device(struct tmc_drvdata *drvdata)
 		return NULL;
 
 	for (i = 0; i < etr->pdata->nr_outconns; i++) {
-		tmp = etr->pdata->out_conns[i].dest_dev;
+		tmp = etr->pdata->out_conns[i]->dest_dev;
 		if (tmp && coresight_is_catu_device(tmp))
 			return tmp;
 	}
diff --git a/include/linux/coresight.h b/include/linux/coresight.h
index 12fdbd03e2f7..abf36a37fdb0 100644
--- a/include/linux/coresight.h
+++ b/include/linux/coresight.h
@@ -104,14 +104,15 @@ union coresight_dev_subtype {
  *
  * @nr_inconns: Number of elements for the input connections.
  * @nr_outconns: Number of elements for the output connections.
- * @out_conns:	Array of nr_outconns connections from this component.
+ * @out_conns: Array of nr_outconns pointers to connections from this
+ *	       component.
  */
 struct coresight_platform_data {
 	int high_inport;
 	int high_outport;
 	int nr_inconns;
 	int nr_outconns;
-	struct coresight_connection *out_conns;
+	struct coresight_connection **out_conns;
 };
 
 /**
-- 
2.34.1

