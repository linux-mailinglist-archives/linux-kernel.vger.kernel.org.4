Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4FF8663F0C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 12:11:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238298AbjAJLKy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 06:10:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233058AbjAJLIy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 06:08:54 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 996CC3752E
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 03:08:14 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 60D9FAD7;
        Tue, 10 Jan 2023 03:08:56 -0800 (PST)
Received: from e126815.warwick.arm.com (e126815.arm.com [10.32.32.26])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C528C3F587;
        Tue, 10 Jan 2023 03:08:12 -0800 (PST)
From:   James Clark <james.clark@arm.com>
To:     coresight@lists.linaro.org, quic_jinlmao@quicinc.com,
        suzuki.poulose@arm.com, mike.leach@linaro.org
Cc:     James Clark <james.clark@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/3] coresight: cti: Remove atomic type from enable_req_count
Date:   Tue, 10 Jan 2023 11:07:36 +0000
Message-Id: <20230110110736.2709917-4-james.clark@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230110110736.2709917-1-james.clark@arm.com>
References: <20230110110736.2709917-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

enable_req_count is only ever accessed inside the spinlock, so to avoid
confusion that there are concurrent accesses and simplify the code,
change it to an int.

One access outside of the spinlock is in enable_show() which appears to
allow partially written data to be displayed between enable_req_count,
powered and enabled so move this one inside the spin lock too.

Signed-off-by: James Clark <james.clark@arm.com>
---
 drivers/hwtracing/coresight/coresight-cti-core.c  | 14 +++++++-------
 drivers/hwtracing/coresight/coresight-cti-sysfs.c |  2 +-
 drivers/hwtracing/coresight/coresight-cti.h       |  2 +-
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-cti-core.c b/drivers/hwtracing/coresight/coresight-cti-core.c
index 838872f2484d..277c890a1f1f 100644
--- a/drivers/hwtracing/coresight/coresight-cti-core.c
+++ b/drivers/hwtracing/coresight/coresight-cti-core.c
@@ -107,12 +107,12 @@ static int cti_enable_hw(struct cti_drvdata *drvdata)
 	cti_write_all_hw_regs(drvdata);
 
 	config->hw_enabled = true;
-	atomic_inc(&drvdata->config.enable_req_count);
+	drvdata->config.enable_req_count++;
 	spin_unlock_irqrestore(&drvdata->spinlock, flags);
 	return rc;
 
 cti_state_unchanged:
-	atomic_inc(&drvdata->config.enable_req_count);
+	drvdata->config.enable_req_count++;
 
 	/* cannot enable due to error */
 cti_err_not_enabled:
@@ -129,7 +129,7 @@ static void cti_cpuhp_enable_hw(struct cti_drvdata *drvdata)
 	config->hw_powered = true;
 
 	/* no need to do anything if no enable request */
-	if (!atomic_read(&drvdata->config.enable_req_count))
+	if (!drvdata->config.enable_req_count)
 		goto cti_hp_not_enabled;
 
 	/* try to claim the device */
@@ -156,13 +156,13 @@ static int cti_disable_hw(struct cti_drvdata *drvdata)
 	spin_lock(&drvdata->spinlock);
 
 	/* don't allow negative refcounts, return an error */
-	if (!atomic_read(&drvdata->config.enable_req_count)) {
+	if (!drvdata->config.enable_req_count) {
 		ret = -EINVAL;
 		goto cti_not_disabled;
 	}
 
 	/* check refcount - disable on 0 */
-	if (atomic_dec_return(&drvdata->config.enable_req_count) > 0)
+	if (--drvdata->config.enable_req_count > 0)
 		goto cti_not_disabled;
 
 	/* no need to do anything if disabled or cpu unpowered */
@@ -239,7 +239,7 @@ static void cti_set_default_config(struct device *dev,
 	/* Most regs default to 0 as zalloc'ed except...*/
 	config->trig_filter_enable = true;
 	config->ctigate = GENMASK(config->nr_ctm_channels - 1, 0);
-	atomic_set(&config->enable_req_count, 0);
+	config->enable_req_count = 0;
 }
 
 /*
@@ -696,7 +696,7 @@ static int cti_cpu_pm_notify(struct notifier_block *nb, unsigned long cmd,
 		drvdata->config.hw_enabled = false;
 
 		/* check enable reference count to enable HW */
-		if (atomic_read(&drvdata->config.enable_req_count)) {
+		if (drvdata->config.enable_req_count) {
 			/* check we can claim the device as we re-power */
 			if (coresight_claim_device(csdev))
 				goto cti_notify_exit;
diff --git a/drivers/hwtracing/coresight/coresight-cti-sysfs.c b/drivers/hwtracing/coresight/coresight-cti-sysfs.c
index 71e7a8266bb3..e528cff9d4e2 100644
--- a/drivers/hwtracing/coresight/coresight-cti-sysfs.c
+++ b/drivers/hwtracing/coresight/coresight-cti-sysfs.c
@@ -84,8 +84,8 @@ static ssize_t enable_show(struct device *dev,
 	bool enabled, powered;
 	struct cti_drvdata *drvdata = dev_get_drvdata(dev->parent);
 
-	enable_req = atomic_read(&drvdata->config.enable_req_count);
 	spin_lock(&drvdata->spinlock);
+	enable_req = drvdata->config.enable_req_count;
 	powered = drvdata->config.hw_powered;
 	enabled = drvdata->config.hw_enabled;
 	spin_unlock(&drvdata->spinlock);
diff --git a/drivers/hwtracing/coresight/coresight-cti.h b/drivers/hwtracing/coresight/coresight-cti.h
index acf7b545e6b9..8b106b13a244 100644
--- a/drivers/hwtracing/coresight/coresight-cti.h
+++ b/drivers/hwtracing/coresight/coresight-cti.h
@@ -141,7 +141,7 @@ struct cti_config {
 	int nr_trig_max;
 
 	/* cti enable control */
-	atomic_t enable_req_count;
+	int enable_req_count;
 	bool hw_enabled;
 	bool hw_powered;
 
-- 
2.25.1

