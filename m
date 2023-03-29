Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28DAA6CD8E4
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 13:55:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbjC2Lzs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 07:55:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjC2Lz3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 07:55:29 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BC5984693
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 04:55:09 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2E2D61655;
        Wed, 29 Mar 2023 04:55:26 -0700 (PDT)
Received: from localhost.localdomain (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 207BD3F6C4;
        Wed, 29 Mar 2023 04:54:40 -0700 (PDT)
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
Subject: [PATCH v3 12/13] coresight: Enable and disable helper devices adjacent to the path
Date:   Wed, 29 Mar 2023 12:53:25 +0100
Message-Id: <20230329115329.2747724-13-james.clark@arm.com>
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

Currently CATU is the only helper device, and its enable and disable
calls are hard coded. To allow more helper devices to be added in a
generic way, remove these hard coded calls and just enable and disable
all helper devices.

This has to apply to helpers adjacent to the path, because they will
never be in the path. CATU was already discovered in this way, so
there is no change there.

One change that is needed is for CATU to call back into ETR to allocate
the buffer. Because the enable call was previously hard coded, it was
done at a point where the buffer was already allocated, but this is no
longer the case.

Signed-off-by: James Clark <james.clark@arm.com>
---
 drivers/hwtracing/coresight/coresight-catu.c  |  21 ++-
 drivers/hwtracing/coresight/coresight-core.c  | 147 +++++++++++++++++-
 .../hwtracing/coresight/coresight-etm-perf.c  |   4 +-
 drivers/hwtracing/coresight/coresight-priv.h  |   3 +
 .../hwtracing/coresight/coresight-tmc-etr.c   |  43 +----
 include/linux/coresight.h                     |  11 +-
 6 files changed, 177 insertions(+), 52 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-catu.c b/drivers/hwtracing/coresight/coresight-catu.c
index bc90a03f478f..3949ded0d4fa 100644
--- a/drivers/hwtracing/coresight/coresight-catu.c
+++ b/drivers/hwtracing/coresight/coresight-catu.c
@@ -395,13 +395,18 @@ static inline int catu_wait_for_ready(struct catu_drvdata *drvdata)
 	return coresight_timeout(csa, CATU_STATUS, CATU_STATUS_READY, 1);
 }
 
-static int catu_enable_hw(struct catu_drvdata *drvdata, void *data)
+static int catu_enable_hw(struct catu_drvdata *drvdata, enum cs_mode cs_mode,
+			  void *data)
 {
 	int rc;
 	u32 control, mode;
-	struct etr_buf *etr_buf = data;
+	struct etr_buf *etr_buf = NULL;
 	struct device *dev = &drvdata->csdev->dev;
 	struct coresight_device *csdev = drvdata->csdev;
+	struct coresight_device *etrdev;
+	union coresight_dev_subtype etr_subtype = {
+		.sink_subtype = CORESIGHT_DEV_SUBTYPE_SINK_SYSMEM
+	};
 
 	if (catu_wait_for_ready(drvdata))
 		dev_warn(dev, "Timeout while waiting for READY\n");
@@ -416,6 +421,13 @@ static int catu_enable_hw(struct catu_drvdata *drvdata, void *data)
 	if (rc)
 		return rc;
 
+	etrdev = coresight_find_input_type(
+		csdev->pdata, CORESIGHT_DEV_TYPE_SINK, etr_subtype);
+	if (etrdev) {
+		etr_buf = tmc_etr_get_buffer(etrdev, cs_mode, data);
+		if (IS_ERR(etr_buf))
+			return PTR_ERR(etr_buf);
+	}
 	control |= BIT(CATU_CONTROL_ENABLE);
 
 	if (etr_buf && etr_buf->mode == ETR_MODE_CATU) {
@@ -441,13 +453,14 @@ static int catu_enable_hw(struct catu_drvdata *drvdata, void *data)
 	return 0;
 }
 
-static int catu_enable(struct coresight_device *csdev, void *data)
+static int catu_enable(struct coresight_device *csdev, enum cs_mode mode,
+		       void *data)
 {
 	int rc;
 	struct catu_drvdata *catu_drvdata = csdev_to_catu_drvdata(csdev);
 
 	CS_UNLOCK(catu_drvdata->base);
-	rc = catu_enable_hw(catu_drvdata, data);
+	rc = catu_enable_hw(catu_drvdata, mode, data);
 	CS_LOCK(catu_drvdata->base);
 	return rc;
 }
diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
index baa23aa53971..65f5bd8516d8 100644
--- a/drivers/hwtracing/coresight/coresight-core.c
+++ b/drivers/hwtracing/coresight/coresight-core.c
@@ -421,8 +421,8 @@ static void coresight_disable_link(struct coresight_device *csdev,
 	csdev->enable = false;
 }
 
-static int coresight_enable_source(struct coresight_device *csdev,
-				   enum cs_mode mode)
+int coresight_enable_source(struct coresight_device *csdev, void *data,
+			    enum cs_mode mode)
 {
 	int ret;
 
@@ -431,7 +431,7 @@ static int coresight_enable_source(struct coresight_device *csdev,
 			ret = coresight_control_assoc_ectdev(csdev, true);
 			if (ret)
 				return ret;
-			ret = source_ops(csdev)->enable(csdev, NULL, mode);
+			ret = source_ops(csdev)->enable(csdev, data, mode);
 			if (ret) {
 				coresight_control_assoc_ectdev(csdev, false);
 				return ret;
@@ -444,6 +444,47 @@ static int coresight_enable_source(struct coresight_device *csdev,
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(coresight_enable_source);
+
+static int coresight_enable_helper(struct coresight_device *csdev,
+				   enum cs_mode mode, void *data)
+{
+	int ret;
+
+	if (!helper_ops(csdev)->enable)
+		return 0;
+	ret = helper_ops(csdev)->enable(csdev, mode, data);
+	if (ret)
+		return ret;
+
+	csdev->enable = true;
+	return 0;
+}
+
+static void coresight_disable_helper(struct coresight_device *csdev)
+{
+	int ret;
+
+	if (!helper_ops(csdev)->disable)
+		return;
+
+	ret = helper_ops(csdev)->disable(csdev, NULL);
+	if (ret)
+		return;
+	csdev->enable = false;
+}
+
+static void coresight_disable_helpers(struct coresight_device *csdev)
+{
+	int i;
+	struct coresight_device *helper;
+
+	for (i = 0; i < csdev->pdata->nr_outconns; ++i) {
+		helper = csdev->pdata->out_conns[i]->dest_dev;
+		if (helper && helper->type == CORESIGHT_DEV_TYPE_HELPER)
+			coresight_disable_helper(helper);
+	}
+}
 
 /**
  *  coresight_disable_source - Drop the reference count by 1 and disable
@@ -453,16 +494,18 @@ static int coresight_enable_source(struct coresight_device *csdev,
  *
  *  Returns true if the device has been disabled.
  */
-static bool coresight_disable_source(struct coresight_device *csdev)
+bool coresight_disable_source(struct coresight_device *csdev, void *data)
 {
 	if (atomic_dec_return(&csdev->refcnt) == 0) {
 		if (source_ops(csdev)->disable)
-			source_ops(csdev)->disable(csdev, NULL);
+			source_ops(csdev)->disable(csdev, data);
 		coresight_control_assoc_ectdev(csdev, false);
+		coresight_disable_helpers(csdev);
 		csdev->enable = false;
 	}
 	return !csdev->enable;
 }
+EXPORT_SYMBOL_GPL(coresight_disable_source);
 
 /*
  * coresight_disable_path_from : Disable components in the given path beyond
@@ -513,6 +556,9 @@ static void coresight_disable_path_from(struct list_head *path,
 		default:
 			break;
 		}
+
+		/* Disable all helpers adjacent along the path last */
+		coresight_disable_helpers(csdev);
 	}
 }
 
@@ -522,9 +568,28 @@ void coresight_disable_path(struct list_head *path)
 }
 EXPORT_SYMBOL_GPL(coresight_disable_path);
 
-int coresight_enable_path(struct list_head *path, enum cs_mode mode, void *sink_data)
+static int coresight_enable_helpers(struct coresight_device *csdev,
+				    enum cs_mode mode, void *data)
 {
+	int i, ret = 0;
+	struct coresight_device *helper;
+
+	for (i = 0; i < csdev->pdata->nr_outconns; ++i) {
+		helper = csdev->pdata->out_conns[i]->dest_dev;
+		if (!helper || helper->type != CORESIGHT_DEV_TYPE_HELPER)
+			continue;
+
+		ret = coresight_enable_helper(helper, mode, data);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
 
+int coresight_enable_path(struct list_head *path, enum cs_mode mode,
+			  void *sink_data)
+{
 	int ret = 0;
 	u32 type;
 	struct coresight_node *nd;
@@ -534,6 +599,10 @@ int coresight_enable_path(struct list_head *path, enum cs_mode mode, void *sink_
 		csdev = nd->csdev;
 		type = csdev->type;
 
+		/* Enable all helpers adjacent to the path first */
+		ret = coresight_enable_helpers(csdev, mode, sink_data);
+		if (ret)
+			goto err;
 		/*
 		 * ETF devices are tricky... They can be a link or a sink,
 		 * depending on how they are configured.  If an ETF has been
@@ -1120,7 +1189,7 @@ int coresight_enable(struct coresight_device *csdev)
 	if (ret)
 		goto err_path;
 
-	ret = coresight_enable_source(csdev, CS_MODE_SYSFS);
+	ret = coresight_enable_source(csdev, NULL, CS_MODE_SYSFS);
 	if (ret)
 		goto err_source;
 
@@ -1177,7 +1246,7 @@ void coresight_disable(struct coresight_device *csdev)
 	if (ret)
 		goto out;
 
-	if (!csdev->enable || !coresight_disable_source(csdev))
+	if (!csdev->enable || !coresight_disable_source(csdev, NULL))
 		goto out;
 
 	switch (csdev->subtype.source_subtype) {
@@ -1653,6 +1722,68 @@ static inline int coresight_search_device_idx(struct coresight_dev_list *dict,
 	return -ENOENT;
 }
 
+static bool coresight_compare_type(enum coresight_dev_type type_a,
+				   union coresight_dev_subtype subtype_a,
+				   enum coresight_dev_type type_b,
+				   union coresight_dev_subtype subtype_b)
+{
+	if (type_a != type_b)
+		return false;
+
+	switch (type_a) {
+	case CORESIGHT_DEV_TYPE_SINK:
+		return subtype_a.sink_subtype == subtype_b.sink_subtype;
+	case CORESIGHT_DEV_TYPE_LINK:
+		return subtype_a.link_subtype == subtype_b.link_subtype;
+	case CORESIGHT_DEV_TYPE_LINKSINK:
+		return subtype_a.link_subtype == subtype_b.link_subtype &&
+		       subtype_a.sink_subtype == subtype_b.sink_subtype;
+	case CORESIGHT_DEV_TYPE_SOURCE:
+		return subtype_a.source_subtype == subtype_b.source_subtype;
+	case CORESIGHT_DEV_TYPE_HELPER:
+		return subtype_a.helper_subtype == subtype_b.helper_subtype;
+	default:
+		return false;
+	}
+}
+struct coresight_device *
+coresight_find_input_type(struct coresight_platform_data *pdata,
+			  enum coresight_dev_type type,
+			  union coresight_dev_subtype subtype)
+{
+	int i;
+	struct coresight_connection *conn;
+
+	for (i = 0; i < pdata->nr_inconns; ++i) {
+		conn = pdata->in_conns[i];
+		if (conn &&
+		    coresight_compare_type(type, subtype, conn->src_dev->type,
+					   conn->src_dev->subtype))
+			return conn->src_dev;
+	}
+	return NULL;
+}
+EXPORT_SYMBOL_GPL(coresight_find_input_type);
+
+struct coresight_device *
+coresight_find_output_type(struct coresight_platform_data *pdata,
+			   enum coresight_dev_type type,
+			   union coresight_dev_subtype subtype)
+{
+	int i;
+	struct coresight_connection *conn;
+
+	for (i = 0; i < pdata->nr_outconns; ++i) {
+		conn = pdata->out_conns[i];
+		if (conn->dest_dev &&
+		    coresight_compare_type(type, subtype, conn->dest_dev->type,
+					   conn->dest_dev->subtype))
+			return conn->dest_dev;
+	}
+	return NULL;
+}
+EXPORT_SYMBOL_GPL(coresight_find_output_type);
+
 bool coresight_loses_context_with_cpu(struct device *dev)
 {
 	return fwnode_property_present(dev_fwnode(dev),
diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
index a48c97da8165..1c24eb6b73e4 100644
--- a/drivers/hwtracing/coresight/coresight-etm-perf.c
+++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
@@ -492,7 +492,7 @@ static void etm_event_start(struct perf_event *event, int flags)
 		goto fail_end_stop;
 
 	/* Finally enable the tracer */
-	if (source_ops(csdev)->enable(csdev, event, CS_MODE_PERF))
+	if (coresight_enable_source(csdev, event, CS_MODE_PERF))
 		goto fail_disable_path;
 
 	/*
@@ -586,7 +586,7 @@ static void etm_event_stop(struct perf_event *event, int mode)
 		return;
 
 	/* stop tracer */
-	source_ops(csdev)->disable(csdev, event);
+	coresight_disable_source(csdev, event);
 
 	/* tell the core */
 	event->hw.state = PERF_HES_STOPPED;
diff --git a/drivers/hwtracing/coresight/coresight-priv.h b/drivers/hwtracing/coresight/coresight-priv.h
index 65ae6d161c57..a843f9d5c737 100644
--- a/drivers/hwtracing/coresight/coresight-priv.h
+++ b/drivers/hwtracing/coresight/coresight-priv.h
@@ -216,5 +216,8 @@ void coresight_set_assoc_ectdev_mutex(struct coresight_device *csdev,
 
 void coresight_set_percpu_sink(int cpu, struct coresight_device *csdev);
 struct coresight_device *coresight_get_percpu_sink(int cpu);
+int coresight_enable_source(struct coresight_device *csdev, void *data,
+			    enum cs_mode mode);
+bool coresight_disable_source(struct coresight_device *csdev, void *data);
 
 #endif
diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
index 00a0c2aa8481..37afe8b52760 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
@@ -775,40 +775,19 @@ static const struct etr_buf_operations etr_sg_buf_ops = {
 struct coresight_device *
 tmc_etr_get_catu_device(struct tmc_drvdata *drvdata)
 {
-	int i;
-	struct coresight_device *tmp, *etr = drvdata->csdev;
+	struct coresight_device *etr = drvdata->csdev;
+	union coresight_dev_subtype catu_subtype = {
+		.helper_subtype = CORESIGHT_DEV_SUBTYPE_HELPER_CATU
+	};
 
 	if (!IS_ENABLED(CONFIG_CORESIGHT_CATU))
 		return NULL;
 
-	for (i = 0; i < etr->pdata->nr_outconns; i++) {
-		tmp = etr->pdata->out_conns[i]->dest_dev;
-		if (tmp && coresight_is_catu_device(tmp))
-			return tmp;
-	}
-
-	return NULL;
+	return coresight_find_output_type(etr->pdata, CORESIGHT_DEV_TYPE_HELPER,
+					  catu_subtype);
 }
 EXPORT_SYMBOL_GPL(tmc_etr_get_catu_device);
 
-static inline int tmc_etr_enable_catu(struct tmc_drvdata *drvdata,
-				      struct etr_buf *etr_buf)
-{
-	struct coresight_device *catu = tmc_etr_get_catu_device(drvdata);
-
-	if (catu && helper_ops(catu)->enable)
-		return helper_ops(catu)->enable(catu, etr_buf);
-	return 0;
-}
-
-static inline void tmc_etr_disable_catu(struct tmc_drvdata *drvdata)
-{
-	struct coresight_device *catu = tmc_etr_get_catu_device(drvdata);
-
-	if (catu && helper_ops(catu)->disable)
-		helper_ops(catu)->disable(catu, drvdata->etr_buf);
-}
-
 static const struct etr_buf_operations *etr_buf_ops[] = {
 	[ETR_MODE_FLAT] = &etr_flat_buf_ops,
 	[ETR_MODE_ETR_SG] = &etr_sg_buf_ops,
@@ -1058,13 +1037,6 @@ static int tmc_etr_enable_hw(struct tmc_drvdata *drvdata,
 	if (WARN_ON(drvdata->etr_buf))
 		return -EBUSY;
 
-	/*
-	 * If this ETR is connected to a CATU, enable it before we turn
-	 * this on.
-	 */
-	rc = tmc_etr_enable_catu(drvdata, etr_buf);
-	if (rc)
-		return rc;
 	rc = coresight_claim_device(drvdata->csdev);
 	if (!rc) {
 		drvdata->etr_buf = etr_buf;
@@ -1072,7 +1044,6 @@ static int tmc_etr_enable_hw(struct tmc_drvdata *drvdata,
 		if (rc) {
 			drvdata->etr_buf = NULL;
 			coresight_disclaim_device(drvdata->csdev);
-			tmc_etr_disable_catu(drvdata);
 		}
 	}
 
@@ -1162,8 +1133,6 @@ static void __tmc_etr_disable_hw(struct tmc_drvdata *drvdata)
 void tmc_etr_disable_hw(struct tmc_drvdata *drvdata)
 {
 	__tmc_etr_disable_hw(drvdata);
-	/* Disable CATU device if this ETR is connected to one */
-	tmc_etr_disable_catu(drvdata);
 	coresight_disclaim_device(drvdata->csdev);
 	/* Reset the ETR buf used by hardware */
 	drvdata->etr_buf = NULL;
diff --git a/include/linux/coresight.h b/include/linux/coresight.h
index 98599210c180..d2739a0286f1 100644
--- a/include/linux/coresight.h
+++ b/include/linux/coresight.h
@@ -373,7 +373,8 @@ struct coresight_ops_source {
  * @disable	: Disable the device
  */
 struct coresight_ops_helper {
-	int (*enable)(struct coresight_device *csdev, void *data);
+	int (*enable)(struct coresight_device *csdev, enum cs_mode mode,
+		      void *data);
 	int (*disable)(struct coresight_device *csdev, void *data);
 };
 
@@ -643,5 +644,13 @@ int coresight_add_out_conn(struct device *dev,
 			   struct coresight_platform_data *pdata,
 			   const struct coresight_connection *new_conn);
 int coresight_add_in_conn(struct coresight_connection *conn);
+struct coresight_device *
+coresight_find_input_type(struct coresight_platform_data *pdata,
+			  enum coresight_dev_type type,
+			  union coresight_dev_subtype subtype);
+struct coresight_device *
+coresight_find_output_type(struct coresight_platform_data *pdata,
+			   enum coresight_dev_type type,
+			   union coresight_dev_subtype subtype);
 
 #endif		/* _LINUX_COREISGHT_H */
-- 
2.34.1

