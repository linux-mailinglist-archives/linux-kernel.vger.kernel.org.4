Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38C0E6B104C
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 18:40:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbjCHRkM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 12:40:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbjCHRjx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 12:39:53 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CE3D3CB65C
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 09:39:32 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EA2A11063;
        Wed,  8 Mar 2023 09:40:15 -0800 (PST)
Received: from e127643.arm.com (unknown [10.57.48.148])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id F10CF3F67D;
        Wed,  8 Mar 2023 09:39:30 -0800 (PST)
From:   James Clark <james.clark@arm.com>
To:     coresight@lists.linaro.org
Cc:     James Clark <james.clark@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 6/8] coresight: Refactor out buffer allocation function for ETR
Date:   Wed,  8 Mar 2023 17:39:00 +0000
Message-Id: <20230308173904.3449231-7-james.clark@arm.com>
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

When CATU is moved to the generic enable/disable path system in the
next commit, it will need to call into ETR and get it to pre-allocate
its buffer so add a function for it.

No functional changes

Signed-off-by: James Clark <james.clark@arm.com>
---
 .../hwtracing/coresight/coresight-tmc-etr.c   | 49 ++++++++++++++++---
 drivers/hwtracing/coresight/coresight-tmc.h   |  2 +
 2 files changed, 44 insertions(+), 7 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
index 4711dfa7418c..e9327778d751 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
@@ -1169,7 +1169,7 @@ void tmc_etr_disable_hw(struct tmc_drvdata *drvdata)
 	drvdata->etr_buf = NULL;
 }
 
-static int tmc_enable_etr_sink_sysfs(struct coresight_device *csdev)
+static struct etr_buf *tmc_etr_get_sysfs_buffer(struct coresight_device *csdev)
 {
 	int ret = 0;
 	unsigned long flags;
@@ -1192,7 +1192,7 @@ static int tmc_enable_etr_sink_sysfs(struct coresight_device *csdev)
 		/* Allocate memory with the locks released */
 		free_buf = new_buf = tmc_etr_setup_sysfs_buf(drvdata);
 		if (IS_ERR(new_buf))
-			return PTR_ERR(new_buf);
+			return new_buf;
 
 		/* Let's try again */
 		spin_lock_irqsave(&drvdata->spinlock, flags);
@@ -1223,17 +1223,33 @@ static int tmc_enable_etr_sink_sysfs(struct coresight_device *csdev)
 		drvdata->sysfs_buf = new_buf;
 	}
 
-	ret = tmc_etr_enable_hw(drvdata, drvdata->sysfs_buf);
-	if (!ret) {
-		drvdata->mode = CS_MODE_SYSFS;
-		atomic_inc(csdev->refcnt);
-	}
 out:
 	spin_unlock_irqrestore(&drvdata->spinlock, flags);
 
 	/* Free memory outside the spinlock if need be */
 	if (free_buf)
 		tmc_etr_free_sysfs_buf(free_buf);
+	return drvdata->sysfs_buf;
+}
+
+static int tmc_enable_etr_sink_sysfs(struct coresight_device *csdev)
+{
+	int ret;
+	unsigned long flags;
+	struct tmc_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
+	struct etr_buf *sysfs_buf = tmc_etr_get_sysfs_buffer(csdev);
+
+	if (IS_ERR(sysfs_buf))
+		return PTR_ERR(sysfs_buf);
+
+	spin_lock_irqsave(&drvdata->spinlock, flags);
+	ret = tmc_etr_enable_hw(drvdata, sysfs_buf);
+	if (!ret) {
+		drvdata->mode = CS_MODE_SYSFS;
+		atomic_inc(csdev->refcnt);
+	}
+
+	spin_unlock_irqrestore(&drvdata->spinlock, flags);
 
 	if (!ret)
 		dev_dbg(&csdev->dev, "TMC-ETR enabled\n");
@@ -1241,6 +1257,25 @@ static int tmc_enable_etr_sink_sysfs(struct coresight_device *csdev)
 	return ret;
 }
 
+struct etr_buf *tmc_etr_get_buffer(struct coresight_device *csdev,
+				   enum cs_mode mode, void *data)
+{
+	struct perf_output_handle *handle = data;
+	struct etr_perf_buffer *etr_perf = etm_perf_sink_config(handle);
+
+	switch (mode) {
+	case CS_MODE_SYSFS:
+		return tmc_etr_get_sysfs_buffer(csdev);
+	case CS_MODE_PERF:
+		if (WARN_ON(!etr_perf || !etr_perf->etr_buf))
+			return ERR_PTR(-EINVAL);
+		return etr_perf->etr_buf;
+	default:
+		return ERR_PTR(-EINVAL);
+	}
+}
+EXPORT_SYMBOL_GPL(tmc_etr_get_buffer);
+
 /*
  * alloc_etr_buf: Allocate ETR buffer for use by perf.
  * The size of the hardware buffer is dependent on the size configured
diff --git a/drivers/hwtracing/coresight/coresight-tmc.h b/drivers/hwtracing/coresight/coresight-tmc.h
index 01c0382a29c0..b97da39652d2 100644
--- a/drivers/hwtracing/coresight/coresight-tmc.h
+++ b/drivers/hwtracing/coresight/coresight-tmc.h
@@ -332,5 +332,7 @@ struct coresight_device *tmc_etr_get_catu_device(struct tmc_drvdata *drvdata);
 
 void tmc_etr_set_catu_ops(const struct etr_buf_operations *catu);
 void tmc_etr_remove_catu_ops(void);
+struct etr_buf *tmc_etr_get_buffer(struct coresight_device *csdev,
+				   enum cs_mode mode, void *data);
 
 #endif
-- 
2.34.1

