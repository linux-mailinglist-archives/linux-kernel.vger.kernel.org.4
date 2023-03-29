Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB7A86CD8CB
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 13:54:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbjC2LyA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 07:54:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbjC2Lxy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 07:53:54 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 30FAD4487
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 04:53:53 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3F0A42F4;
        Wed, 29 Mar 2023 04:54:37 -0700 (PDT)
Received: from localhost.localdomain (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 30D073F6C4;
        Wed, 29 Mar 2023 04:53:51 -0700 (PDT)
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
Subject: [PATCH v3 01/13] coresight: Use enum type for cs_mode wherever possible
Date:   Wed, 29 Mar 2023 12:53:14 +0100
Message-Id: <20230329115329.2747724-2-james.clark@arm.com>
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

mode is stored as a local_t, but it is also passed around a lot as a
plain u32, so use the correct type wherever local_t isn't currently
used. This helps a little bit with readability.

Reviewed-by: Mike Leach <mike.leach@linaro.org>
Signed-off-by: James Clark <james.clark@arm.com>
---
 drivers/hwtracing/coresight/coresight-core.c       |  7 ++++---
 drivers/hwtracing/coresight/coresight-etb10.c      |  3 ++-
 drivers/hwtracing/coresight/coresight-etm3x-core.c |  6 +++---
 drivers/hwtracing/coresight/coresight-etm4x-core.c |  6 +++---
 drivers/hwtracing/coresight/coresight-priv.h       |  9 ++-------
 drivers/hwtracing/coresight/coresight-stm.c        |  6 +++---
 drivers/hwtracing/coresight/coresight-tmc-etf.c    |  2 +-
 drivers/hwtracing/coresight/coresight-tmc-etr.c    |  7 +++----
 drivers/hwtracing/coresight/coresight-tpdm.c       |  4 ++--
 drivers/hwtracing/coresight/coresight-tpiu.c       |  3 ++-
 drivers/hwtracing/coresight/coresight-trbe.c       |  3 ++-
 drivers/hwtracing/coresight/ultrasoc-smb.c         |  3 ++-
 drivers/hwtracing/coresight/ultrasoc-smb.h         |  2 +-
 include/linux/coresight.h                          | 13 ++++++++++---
 14 files changed, 40 insertions(+), 34 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
index d3bf82c0de1d..e3b63fd52b9c 100644
--- a/drivers/hwtracing/coresight/coresight-core.c
+++ b/drivers/hwtracing/coresight/coresight-core.c
@@ -308,7 +308,7 @@ void coresight_set_assoc_ectdev_mutex(struct coresight_device *csdev,
 EXPORT_SYMBOL_GPL(coresight_set_assoc_ectdev_mutex);
 
 static int coresight_enable_sink(struct coresight_device *csdev,
-				 u32 mode, void *data)
+				 enum cs_mode mode, void *data)
 {
 	int ret;
 
@@ -416,7 +416,8 @@ static void coresight_disable_link(struct coresight_device *csdev,
 	csdev->enable = false;
 }
 
-static int coresight_enable_source(struct coresight_device *csdev, u32 mode)
+static int coresight_enable_source(struct coresight_device *csdev,
+				   enum cs_mode mode)
 {
 	int ret;
 
@@ -516,7 +517,7 @@ void coresight_disable_path(struct list_head *path)
 }
 EXPORT_SYMBOL_GPL(coresight_disable_path);
 
-int coresight_enable_path(struct list_head *path, u32 mode, void *sink_data)
+int coresight_enable_path(struct list_head *path, enum cs_mode mode, void *sink_data)
 {
 
 	int ret = 0;
diff --git a/drivers/hwtracing/coresight/coresight-etb10.c b/drivers/hwtracing/coresight/coresight-etb10.c
index 8aa6e4f83e42..eb99c445015a 100644
--- a/drivers/hwtracing/coresight/coresight-etb10.c
+++ b/drivers/hwtracing/coresight/coresight-etb10.c
@@ -225,7 +225,8 @@ static int etb_enable_perf(struct coresight_device *csdev, void *data)
 	return ret;
 }
 
-static int etb_enable(struct coresight_device *csdev, u32 mode, void *data)
+static int etb_enable(struct coresight_device *csdev, enum cs_mode mode,
+		      void *data)
 {
 	int ret;
 
diff --git a/drivers/hwtracing/coresight/coresight-etm3x-core.c b/drivers/hwtracing/coresight/coresight-etm3x-core.c
index afc57195ee52..116a91d90ac2 100644
--- a/drivers/hwtracing/coresight/coresight-etm3x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm3x-core.c
@@ -552,8 +552,8 @@ static int etm_enable_sysfs(struct coresight_device *csdev)
 	return ret;
 }
 
-static int etm_enable(struct coresight_device *csdev,
-		      struct perf_event *event, u32 mode)
+static int etm_enable(struct coresight_device *csdev, struct perf_event *event,
+		      enum cs_mode mode)
 {
 	int ret;
 	u32 val;
@@ -671,7 +671,7 @@ static void etm_disable_sysfs(struct coresight_device *csdev)
 static void etm_disable(struct coresight_device *csdev,
 			struct perf_event *event)
 {
-	u32 mode;
+	enum cs_mode mode;
 	struct etm_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
 
 	/*
diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
index 1ea8f173cca0..2ff4c42ea688 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
@@ -822,8 +822,8 @@ static int etm4_enable_sysfs(struct coresight_device *csdev)
 	return ret;
 }
 
-static int etm4_enable(struct coresight_device *csdev,
-		       struct perf_event *event, u32 mode)
+static int etm4_enable(struct coresight_device *csdev, struct perf_event *event,
+		       enum cs_mode mode)
 {
 	int ret;
 	u32 val;
@@ -989,7 +989,7 @@ static void etm4_disable_sysfs(struct coresight_device *csdev)
 static void etm4_disable(struct coresight_device *csdev,
 			 struct perf_event *event)
 {
-	u32 mode;
+	enum cs_mode mode;
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
 
 	/*
diff --git a/drivers/hwtracing/coresight/coresight-priv.h b/drivers/hwtracing/coresight/coresight-priv.h
index 595ce5862056..788ff19c60f6 100644
--- a/drivers/hwtracing/coresight/coresight-priv.h
+++ b/drivers/hwtracing/coresight/coresight-priv.h
@@ -82,12 +82,6 @@ enum etm_addr_type {
 	ETM_ADDR_TYPE_STOP,
 };
 
-enum cs_mode {
-	CS_MODE_DISABLED,
-	CS_MODE_SYSFS,
-	CS_MODE_PERF,
-};
-
 /**
  * struct cs_buffer - keep track of a recording session' specifics
  * @cur:	index of the current buffer
@@ -133,7 +127,8 @@ static inline void CS_UNLOCK(void __iomem *addr)
 }
 
 void coresight_disable_path(struct list_head *path);
-int coresight_enable_path(struct list_head *path, u32 mode, void *sink_data);
+int coresight_enable_path(struct list_head *path, enum cs_mode mode,
+			  void *sink_data);
 struct coresight_device *coresight_get_sink(struct list_head *path);
 struct coresight_device *
 coresight_get_enabled_sink(struct coresight_device *source);
diff --git a/drivers/hwtracing/coresight/coresight-stm.c b/drivers/hwtracing/coresight/coresight-stm.c
index 66a614c5492c..a1c27c901ad1 100644
--- a/drivers/hwtracing/coresight/coresight-stm.c
+++ b/drivers/hwtracing/coresight/coresight-stm.c
@@ -119,7 +119,7 @@ DEFINE_CORESIGHT_DEVLIST(stm_devs, "stm");
  * @spinlock:		only one at a time pls.
  * @chs:		the channels accociated to this STM.
  * @stm:		structure associated to the generic STM interface.
- * @mode:		this tracer's mode, i.e sysFS, or disabled.
+ * @mode:		this tracer's mode (enum cs_mode), i.e sysFS, or disabled.
  * @traceid:		value of the current ID for this component.
  * @write_bytes:	Maximus bytes this STM can write at a time.
  * @stmsper:		settings for register STMSPER.
@@ -192,8 +192,8 @@ static void stm_enable_hw(struct stm_drvdata *drvdata)
 	CS_LOCK(drvdata->base);
 }
 
-static int stm_enable(struct coresight_device *csdev,
-		      struct perf_event *event, u32 mode)
+static int stm_enable(struct coresight_device *csdev, struct perf_event *event,
+		      enum cs_mode mode)
 {
 	u32 val;
 	struct stm_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
diff --git a/drivers/hwtracing/coresight/coresight-tmc-etf.c b/drivers/hwtracing/coresight/coresight-tmc-etf.c
index 0ab1f73c2d06..14d3c1472455 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etf.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etf.c
@@ -302,7 +302,7 @@ static int tmc_enable_etf_sink_perf(struct coresight_device *csdev, void *data)
 }
 
 static int tmc_enable_etf_sink(struct coresight_device *csdev,
-			       u32 mode, void *data)
+			       enum cs_mode mode, void *data)
 {
 	int ret;
 
diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
index 918d461fcf4a..ed589cfff1b5 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
@@ -1666,17 +1666,16 @@ static int tmc_enable_etr_sink_perf(struct coresight_device *csdev, void *data)
 }
 
 static int tmc_enable_etr_sink(struct coresight_device *csdev,
-			       u32 mode, void *data)
+			       enum cs_mode mode, void *data)
 {
 	switch (mode) {
 	case CS_MODE_SYSFS:
 		return tmc_enable_etr_sink_sysfs(csdev);
 	case CS_MODE_PERF:
 		return tmc_enable_etr_sink_perf(csdev, data);
+	default:
+		return -EINVAL;
 	}
-
-	/* We shouldn't be here */
-	return -EINVAL;
 }
 
 static int tmc_disable_etr_sink(struct coresight_device *csdev)
diff --git a/drivers/hwtracing/coresight/coresight-tpdm.c b/drivers/hwtracing/coresight/coresight-tpdm.c
index 9479a5e8c672..f4854af0431e 100644
--- a/drivers/hwtracing/coresight/coresight-tpdm.c
+++ b/drivers/hwtracing/coresight/coresight-tpdm.c
@@ -42,8 +42,8 @@ static void __tpdm_enable(struct tpdm_drvdata *drvdata)
 	CS_LOCK(drvdata->base);
 }
 
-static int tpdm_enable(struct coresight_device *csdev,
-		       struct perf_event *event, u32 mode)
+static int tpdm_enable(struct coresight_device *csdev, struct perf_event *event,
+		       enum cs_mode mode)
 {
 	struct tpdm_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
 
diff --git a/drivers/hwtracing/coresight/coresight-tpiu.c b/drivers/hwtracing/coresight/coresight-tpiu.c
index 34d37abd2c8d..b0179f761c98 100644
--- a/drivers/hwtracing/coresight/coresight-tpiu.c
+++ b/drivers/hwtracing/coresight/coresight-tpiu.c
@@ -69,7 +69,8 @@ static void tpiu_enable_hw(struct csdev_access *csa)
 	CS_LOCK(csa->base);
 }
 
-static int tpiu_enable(struct coresight_device *csdev, u32 mode, void *__unused)
+static int tpiu_enable(struct coresight_device *csdev, enum cs_mode mode,
+		       void *__unused)
 {
 	tpiu_enable_hw(&csdev->access);
 	atomic_inc(csdev->refcnt);
diff --git a/drivers/hwtracing/coresight/coresight-trbe.c b/drivers/hwtracing/coresight/coresight-trbe.c
index 1fc4fd79a1c6..5406e338c280 100644
--- a/drivers/hwtracing/coresight/coresight-trbe.c
+++ b/drivers/hwtracing/coresight/coresight-trbe.c
@@ -1005,7 +1005,8 @@ static int __arm_trbe_enable(struct trbe_buf *buf,
 	return ret;
 }
 
-static int arm_trbe_enable(struct coresight_device *csdev, u32 mode, void *data)
+static int arm_trbe_enable(struct coresight_device *csdev, enum cs_mode mode,
+			   void *data)
 {
 	struct trbe_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
 	struct trbe_cpudata *cpudata = dev_get_drvdata(&csdev->dev);
diff --git a/drivers/hwtracing/coresight/ultrasoc-smb.c b/drivers/hwtracing/coresight/ultrasoc-smb.c
index b317342c7ce5..a2ced0b3c3cd 100644
--- a/drivers/hwtracing/coresight/ultrasoc-smb.c
+++ b/drivers/hwtracing/coresight/ultrasoc-smb.c
@@ -256,7 +256,8 @@ static int smb_enable_perf(struct coresight_device *csdev, void *data)
 	return 0;
 }
 
-static int smb_enable(struct coresight_device *csdev, u32 mode, void *data)
+static int smb_enable(struct coresight_device *csdev, enum cs_mode mode,
+		      void *data)
 {
 	struct smb_drv_data *drvdata = dev_get_drvdata(csdev->dev.parent);
 	int ret = 0;
diff --git a/drivers/hwtracing/coresight/ultrasoc-smb.h b/drivers/hwtracing/coresight/ultrasoc-smb.h
index 7dfbe42e37a0..d2e14e8d2c8a 100644
--- a/drivers/hwtracing/coresight/ultrasoc-smb.h
+++ b/drivers/hwtracing/coresight/ultrasoc-smb.h
@@ -119,7 +119,7 @@ struct smb_drv_data {
 	struct mutex mutex;
 	bool reading;
 	pid_t pid;
-	u32 mode;
+	enum cs_mode mode;
 };
 
 #endif
diff --git a/include/linux/coresight.h b/include/linux/coresight.h
index f19a47b9bb5a..1f878e8ed8c4 100644
--- a/include/linux/coresight.h
+++ b/include/linux/coresight.h
@@ -272,6 +272,12 @@ static struct coresight_dev_list (var) = {				\
 
 #define to_coresight_device(d) container_of(d, struct coresight_device, dev)
 
+enum cs_mode {
+	CS_MODE_DISABLED,
+	CS_MODE_SYSFS,
+	CS_MODE_PERF,
+};
+
 #define source_ops(csdev)	csdev->ops->source_ops
 #define sink_ops(csdev)		csdev->ops->sink_ops
 #define link_ops(csdev)		csdev->ops->link_ops
@@ -288,7 +294,8 @@ static struct coresight_dev_list (var) = {				\
  * @update_buffer:	update buffer pointers after a trace session.
  */
 struct coresight_ops_sink {
-	int (*enable)(struct coresight_device *csdev, u32 mode, void *data);
+	int (*enable)(struct coresight_device *csdev, enum cs_mode mode,
+		      void *data);
 	int (*disable)(struct coresight_device *csdev);
 	void *(*alloc_buffer)(struct coresight_device *csdev,
 			      struct perf_event *event, void **pages,
@@ -320,8 +327,8 @@ struct coresight_ops_link {
  */
 struct coresight_ops_source {
 	int (*cpu_id)(struct coresight_device *csdev);
-	int (*enable)(struct coresight_device *csdev,
-		      struct perf_event *event,  u32 mode);
+	int (*enable)(struct coresight_device *csdev, struct perf_event *event,
+		      enum cs_mode mode);
 	void (*disable)(struct coresight_device *csdev,
 			struct perf_event *event);
 };
-- 
2.34.1

