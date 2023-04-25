Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F1996EE406
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 16:37:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233992AbjDYOgo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 10:36:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233801AbjDYOga (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 10:36:30 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AAF36A249
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 07:36:26 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 67C7BC14;
        Tue, 25 Apr 2023 07:37:10 -0700 (PDT)
Received: from localhost.localdomain (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D69863F587;
        Tue, 25 Apr 2023 07:36:24 -0700 (PDT)
From:   James Clark <james.clark@arm.com>
To:     coresight@lists.linaro.org, quic_jinlmao@quicinc.com,
        mike.leach@linaro.org, suzuki.poulose@arm.com
Cc:     James Clark <james.clark@arm.com>, Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 03/13] coresight: Change name of pdata->conns
Date:   Tue, 25 Apr 2023 15:35:30 +0100
Message-Id: <20230425143542.2305069-4-james.clark@arm.com>
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

conns is actually for output connections. Change the name to make it
clearer and so that we can add input connections later.

No functional changes.

Reviewed-by: Mike Leach <mike.leach@linaro.org>
Signed-off-by: James Clark <james.clark@arm.com>
---
 drivers/hwtracing/coresight/coresight-core.c  | 26 +++++++++----------
 .../hwtracing/coresight/coresight-platform.c  | 12 ++++-----
 .../hwtracing/coresight/coresight-tmc-etr.c   |  2 +-
 include/linux/coresight.h                     |  4 +--
 4 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
index c891078dffc6..04c9d52f8f4f 100644
--- a/drivers/hwtracing/coresight/coresight-core.c
+++ b/drivers/hwtracing/coresight/coresight-core.c
@@ -119,7 +119,7 @@ static int coresight_find_link_inport(struct coresight_device *csdev,
 	struct coresight_connection *conn;
 
 	for (i = 0; i < parent->pdata->nr_outport; i++) {
-		conn = &parent->pdata->conns[i];
+		conn = &parent->pdata->out_conns[i];
 		if (conn->child_dev == csdev)
 			return conn->child_port;
 	}
@@ -137,7 +137,7 @@ static int coresight_find_link_outport(struct coresight_device *csdev,
 	struct coresight_connection *conn;
 
 	for (i = 0; i < csdev->pdata->nr_outport; i++) {
-		conn = &csdev->pdata->conns[i];
+		conn = &csdev->pdata->out_conns[i];
 		if (conn->child_dev == child)
 			return conn->outport;
 	}
@@ -606,7 +606,7 @@ coresight_find_enabled_sink(struct coresight_device *csdev)
 	for (i = 0; i < csdev->pdata->nr_outport; i++) {
 		struct coresight_device *child_dev;
 
-		child_dev = csdev->pdata->conns[i].child_dev;
+		child_dev = csdev->pdata->out_conns[i].child_dev;
 		if (child_dev)
 			sink = coresight_find_enabled_sink(child_dev);
 		if (sink)
@@ -722,7 +722,7 @@ static int coresight_grab_device(struct coresight_device *csdev)
 	for (i = 0; i < csdev->pdata->nr_outport; i++) {
 		struct coresight_device *child;
 
-		child  = csdev->pdata->conns[i].child_dev;
+		child = csdev->pdata->out_conns[i].child_dev;
 		if (child && child->type == CORESIGHT_DEV_TYPE_HELPER)
 			if (!coresight_get_ref(child))
 				goto err;
@@ -733,7 +733,7 @@ static int coresight_grab_device(struct coresight_device *csdev)
 	for (i--; i >= 0; i--) {
 		struct coresight_device *child;
 
-		child  = csdev->pdata->conns[i].child_dev;
+		child = csdev->pdata->out_conns[i].child_dev;
 		if (child && child->type == CORESIGHT_DEV_TYPE_HELPER)
 			coresight_put_ref(child);
 	}
@@ -752,7 +752,7 @@ static void coresight_drop_device(struct coresight_device *csdev)
 	for (i = 0; i < csdev->pdata->nr_outport; i++) {
 		struct coresight_device *child;
 
-		child  = csdev->pdata->conns[i].child_dev;
+		child = csdev->pdata->out_conns[i].child_dev;
 		if (child && child->type == CORESIGHT_DEV_TYPE_HELPER)
 			coresight_put_ref(child);
 	}
@@ -794,7 +794,7 @@ static int _coresight_build_path(struct coresight_device *csdev,
 	for (i = 0; i < csdev->pdata->nr_outport; i++) {
 		struct coresight_device *child_dev;
 
-		child_dev = csdev->pdata->conns[i].child_dev;
+		child_dev = csdev->pdata->out_conns[i].child_dev;
 		if (child_dev &&
 		    _coresight_build_path(child_dev, sink, path) == 0) {
 			found = true;
@@ -964,7 +964,7 @@ coresight_find_sink(struct coresight_device *csdev, int *depth)
 		struct coresight_device *child_dev, *sink = NULL;
 		int child_depth = curr_depth;
 
-		child_dev = csdev->pdata->conns[i].child_dev;
+		child_dev = csdev->pdata->out_conns[i].child_dev;
 		if (child_dev)
 			sink = coresight_find_sink(child_dev, &child_depth);
 
@@ -1334,7 +1334,7 @@ static int coresight_orphan_match(struct device *dev, void *data)
 	 * an orphan connection whose name matches @csdev, link it.
 	 */
 	for (i = 0; i < i_csdev->pdata->nr_outport; i++) {
-		conn = &i_csdev->pdata->conns[i];
+		conn = &i_csdev->pdata->out_conns[i];
 
 		/* Skip the port if FW doesn't describe it */
 		if (!conn->child_fwnode)
@@ -1375,7 +1375,7 @@ static int coresight_fixup_device_conns(struct coresight_device *csdev)
 	int i, ret = 0;
 
 	for (i = 0; i < csdev->pdata->nr_outport; i++) {
-		struct coresight_connection *conn = &csdev->pdata->conns[i];
+		struct coresight_connection *conn = &csdev->pdata->out_conns[i];
 
 		if (!conn->child_fwnode)
 			continue;
@@ -1412,7 +1412,7 @@ static int coresight_remove_match(struct device *dev, void *data)
 	 * a connection whose name matches @csdev, remove it.
 	 */
 	for (i = 0; i < iterator->pdata->nr_outport; i++) {
-		conn = &iterator->pdata->conns[i];
+		conn = &iterator->pdata->out_conns[i];
 
 		if (conn->child_dev == NULL || conn->child_fwnode == NULL)
 			continue;
@@ -1543,7 +1543,7 @@ void coresight_release_platform_data(struct coresight_device *csdev,
 				     struct coresight_platform_data *pdata)
 {
 	int i;
-	struct coresight_connection *conns = pdata->conns;
+	struct coresight_connection *conns = pdata->out_conns;
 
 	for (i = 0; i < pdata->nr_outport; i++) {
 		/* If we have made the links, remove them now */
@@ -1555,7 +1555,7 @@ void coresight_release_platform_data(struct coresight_device *csdev,
 		 */
 		if (conns[i].child_fwnode) {
 			fwnode_handle_put(conns[i].child_fwnode);
-			pdata->conns[i].child_fwnode = NULL;
+			conns[i].child_fwnode = NULL;
 		}
 	}
 	if (csdev)
diff --git a/drivers/hwtracing/coresight/coresight-platform.c b/drivers/hwtracing/coresight/coresight-platform.c
index 475899714104..5085525a32bb 100644
--- a/drivers/hwtracing/coresight/coresight-platform.c
+++ b/drivers/hwtracing/coresight/coresight-platform.c
@@ -27,9 +27,9 @@ static int coresight_alloc_conns(struct device *dev,
 				 struct coresight_platform_data *pdata)
 {
 	if (pdata->nr_outport) {
-		pdata->conns = devm_kcalloc(dev, pdata->nr_outport,
-					    sizeof(*pdata->conns), GFP_KERNEL);
-		if (!pdata->conns)
+		pdata->out_conns = devm_kcalloc(dev, pdata->nr_outport,
+					    sizeof(*pdata->out_conns), GFP_KERNEL);
+		if (!pdata->out_conns)
 			return -ENOMEM;
 	}
 
@@ -251,7 +251,7 @@ static int of_coresight_parse_endpoint(struct device *dev,
 			break;
 		}
 
-		conn = &pdata->conns[endpoint.port];
+		conn = &pdata->out_conns[endpoint.port];
 		if (conn->child_fwnode) {
 			dev_warn(dev, "Duplicate output port %d\n",
 				 endpoint.port);
@@ -744,8 +744,8 @@ static int acpi_coresight_parse_graph(struct acpi_device *adev,
 		int port = conns[i].outport;
 
 		/* Duplicate output port */
-		WARN_ON(pdata->conns[port].child_fwnode);
-		pdata->conns[port] = conns[i];
+		WARN_ON(pdata->out_conns[port].child_fwnode);
+		pdata->out_conns[port] = conns[i];
 	}
 
 	devm_kfree(&adev->dev, conns);
diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
index ed589cfff1b5..86d4a08aa833 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
@@ -782,7 +782,7 @@ tmc_etr_get_catu_device(struct tmc_drvdata *drvdata)
 		return NULL;
 
 	for (i = 0; i < etr->pdata->nr_outport; i++) {
-		tmp = etr->pdata->conns[i].child_dev;
+		tmp = etr->pdata->out_conns[i].child_dev;
 		if (tmp && coresight_is_catu_device(tmp))
 			return tmp;
 	}
diff --git a/include/linux/coresight.h b/include/linux/coresight.h
index 1f878e8ed8c4..bf621d064ef8 100644
--- a/include/linux/coresight.h
+++ b/include/linux/coresight.h
@@ -104,12 +104,12 @@ union coresight_dev_subtype {
  *
  * @nr_inport:	Number of elements for the input connections.
  * @nr_outport:	Number of elements for the output connections.
- * @conns:	Sparse array of nr_outport connections from this component.
+ * @out_conns:	Sparse array of nr_outport connections from this component.
  */
 struct coresight_platform_data {
 	int nr_inport;
 	int nr_outport;
-	struct coresight_connection *conns;
+	struct coresight_connection *out_conns;
 };
 
 /**
-- 
2.34.1

