Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4522A6B104D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 18:40:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbjCHRkZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 12:40:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229905AbjCHRkB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 12:40:01 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D06A7CB075
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 09:39:36 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 83BA0168F;
        Wed,  8 Mar 2023 09:40:19 -0800 (PST)
Received: from e127643.arm.com (unknown [10.57.48.148])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 8A46D3F67D;
        Wed,  8 Mar 2023 09:39:34 -0800 (PST)
From:   James Clark <james.clark@arm.com>
To:     coresight@lists.linaro.org
Cc:     James Clark <james.clark@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 7/8] coresight: Enable and disable helper devices adjacent to the path
Date:   Wed,  8 Mar 2023 17:39:01 +0000
Message-Id: <20230308173904.3449231-8-james.clark@arm.com>
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
 drivers/hwtracing/coresight/coresight-catu.c  | 34 ++++++++--
 drivers/hwtracing/coresight/coresight-core.c  | 68 ++++++++++++++++++-
 .../hwtracing/coresight/coresight-tmc-etr.c   | 28 --------
 include/linux/coresight.h                     |  3 +-
 4 files changed, 99 insertions(+), 34 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-catu.c b/drivers/hwtracing/coresight/coresight-catu.c
index bc90a03f478f..56e68360833f 100644
--- a/drivers/hwtracing/coresight/coresight-catu.c
+++ b/drivers/hwtracing/coresight/coresight-catu.c
@@ -395,13 +395,32 @@ static inline int catu_wait_for_ready(struct catu_drvdata *drvdata)
 	return coresight_timeout(csa, CATU_STATUS, CATU_STATUS_READY, 1);
 }
 
-static int catu_enable_hw(struct catu_drvdata *drvdata, void *data)
+static struct coresight_device *
+catu_get_etr_device(struct coresight_device *csdev)
+{
+	int i;
+	struct coresight_device *tmp;
+
+	for (i = 0; i < csdev->pdata->nr_inconns; i++) {
+		tmp = csdev->pdata->in_conns[i].child_dev;
+		if (tmp && tmp->type == CORESIGHT_DEV_TYPE_SINK &&
+		    tmp->subtype.sink_subtype ==
+			    CORESIGHT_DEV_SUBTYPE_SINK_SYSMEM)
+			return tmp;
+	}
+
+	return NULL;
+}
+
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
 
 	if (catu_wait_for_ready(drvdata))
 		dev_warn(dev, "Timeout while waiting for READY\n");
@@ -416,6 +435,12 @@ static int catu_enable_hw(struct catu_drvdata *drvdata, void *data)
 	if (rc)
 		return rc;
 
+	etrdev = catu_get_etr_device(csdev);
+	if (etrdev) {
+		etr_buf = tmc_etr_get_buffer(etrdev, cs_mode, data);
+		if (IS_ERR(etr_buf))
+			return PTR_ERR(etr_buf);
+	}
 	control |= BIT(CATU_CONTROL_ENABLE);
 
 	if (etr_buf && etr_buf->mode == ETR_MODE_CATU) {
@@ -441,13 +466,14 @@ static int catu_enable_hw(struct catu_drvdata *drvdata, void *data)
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
index fe9fb11ab283..7554307f0d88 100644
--- a/drivers/hwtracing/coresight/coresight-core.c
+++ b/drivers/hwtracing/coresight/coresight-core.c
@@ -441,6 +441,34 @@ static int coresight_enable_source(struct coresight_device *csdev,
 	return 0;
 }
 
+static int coresight_enable_helper(struct coresight_device *csdev,
+				   enum cs_mode mode, void *sink_data)
+{
+	int ret;
+
+	if (!helper_ops(csdev)->enable)
+		return 0;
+	ret = helper_ops(csdev)->enable(csdev, mode, sink_data);
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
 /**
  *  coresight_disable_source - Drop the reference count by 1 and disable
  *  the device if there are no users left.
@@ -460,6 +488,18 @@ static bool coresight_disable_source(struct coresight_device *csdev)
 	return !csdev->enable;
 }
 
+static void coresight_disable_helpers(struct coresight_device *csdev)
+{
+	int i;
+	struct coresight_device *helper;
+
+	for (i = 0; i < csdev->pdata->nr_outconns; ++i) {
+		helper = csdev->pdata->out_conns[i].child_dev;
+		if (helper && helper->type == CORESIGHT_DEV_TYPE_HELPER)
+			coresight_disable_helper(helper);
+	}
+}
+
 /*
  * coresight_disable_path_from : Disable components in the given path beyond
  * @nd in the list. If @nd is NULL, all the components, except the SOURCE are
@@ -509,6 +549,9 @@ static void coresight_disable_path_from(struct list_head *path,
 		default:
 			break;
 		}
+
+		/* Disable all helpers adjacent along the path last */
+		coresight_disable_helpers(csdev);
 	}
 }
 
@@ -518,9 +561,28 @@ void coresight_disable_path(struct list_head *path)
 }
 EXPORT_SYMBOL_GPL(coresight_disable_path);
 
-int coresight_enable_path(struct list_head *path, enum cs_mode mode, void *sink_data)
+static int coresight_enable_helpers(struct coresight_device *csdev,
+				    enum cs_mode mode, void *sink_data)
 {
+	int i, ret = 0;
+	struct coresight_device *helper;
+
+	for (i = 0; i < csdev->pdata->nr_outconns; ++i) {
+		helper = csdev->pdata->out_conns[i].child_dev;
+		if (!helper || helper->type != CORESIGHT_DEV_TYPE_HELPER)
+			continue;
 
+		ret = coresight_enable_helper(helper, mode, sink_data);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+int coresight_enable_path(struct list_head *path, enum cs_mode mode,
+			  void *sink_data)
+{
 	int ret = 0;
 	u32 type;
 	struct coresight_node *nd;
@@ -530,6 +592,10 @@ int coresight_enable_path(struct list_head *path, enum cs_mode mode, void *sink_
 		csdev = nd->csdev;
 		type = csdev->type;
 
+		/* Enable all helpers adjacent to the path first */
+		ret = coresight_enable_helpers(csdev, mode, sink_data);
+		if (ret)
+			goto err;
 		/*
 		 * ETF devices are tricky... They can be a link or a sink,
 		 * depending on how they are configured.  If an ETF has been
diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
index e9327778d751..74266bbdb09c 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
@@ -791,24 +791,6 @@ tmc_etr_get_catu_device(struct tmc_drvdata *drvdata)
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
@@ -1058,13 +1040,6 @@ static int tmc_etr_enable_hw(struct tmc_drvdata *drvdata,
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
@@ -1072,7 +1047,6 @@ static int tmc_etr_enable_hw(struct tmc_drvdata *drvdata,
 		if (rc) {
 			drvdata->etr_buf = NULL;
 			coresight_disclaim_device(drvdata->csdev);
-			tmc_etr_disable_catu(drvdata);
 		}
 	}
 
@@ -1162,8 +1136,6 @@ static void __tmc_etr_disable_hw(struct tmc_drvdata *drvdata)
 void tmc_etr_disable_hw(struct tmc_drvdata *drvdata)
 {
 	__tmc_etr_disable_hw(drvdata);
-	/* Disable CATU device if this ETR is connected to one */
-	tmc_etr_disable_catu(drvdata);
 	coresight_disclaim_device(drvdata->csdev);
 	/* Reset the ETR buf used by hardware */
 	drvdata->etr_buf = NULL;
diff --git a/include/linux/coresight.h b/include/linux/coresight.h
index daecee847b95..d61b0d12542e 100644
--- a/include/linux/coresight.h
+++ b/include/linux/coresight.h
@@ -369,7 +369,8 @@ struct coresight_ops_source {
  * @disable	: Disable the device
  */
 struct coresight_ops_helper {
-	int (*enable)(struct coresight_device *csdev, void *data);
+	int (*enable)(struct coresight_device *csdev, enum cs_mode mode,
+		      void *data);
 	int (*disable)(struct coresight_device *csdev, void *data);
 };
 
-- 
2.34.1

