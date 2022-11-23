Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C495E636A13
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 20:51:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236147AbiKWTum (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 14:50:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238414AbiKWTuh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 14:50:37 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C44C7EBC6
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 11:50:27 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id v1so30978601wrt.11
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 11:50:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OWE5odQr9uwbAPXo98XT/VJdrKGLtEkOCmjLsOJcJq0=;
        b=hZnEFECyQL1+n2wfSAqy4e2QMQPeofedZjJ9fV9u+QyaxIcNYHc5DAyCyuB2XJwCT/
         5QrAt3traWHzQBAFJjr0Pi3+TFGK51x+wZvk/r2o4/HM/0FsQGd5PyO9pmOZTZPlKjwp
         nEUGEVHHa3UkWO+4hMMvSb3nRJ47xg/Ih6ei7kmyT5Z/+7ECrtdxSaEK+4+O4Fd2Ge9+
         comcYuZsT5/thZCjPjsx239e3urwp7TZUBe+6mhfxqbd3LmFz6vTar5u0GVAspqNXP2L
         xLxr+sMN6Og2pmRvFXy5ggidS+j+cyf3h2QRVTPy3klt/n7LocRxZr2TwiSh215kObhJ
         G4WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OWE5odQr9uwbAPXo98XT/VJdrKGLtEkOCmjLsOJcJq0=;
        b=YaP+JT+NVb2vJbTbwOP64G8EQ2zfsfMwrn8uHPxKzh9WuVUrbGvp3fAn/9E3i9BtOw
         fAla06IaO/nXORfqidmbKJT3Uu+XIwPdCjKpzxYVh0t1KY2NUyio0tr/N4xk4l7BNUxS
         ICmhzL9ge4Q1JfHkW5c8ScIEltjdm8gsssmq50QW2KlLe2Yaik4rVnHJFrZc/7ArCu+6
         MS7I0GKkWhGjITyG4PNmMdlF2DSX+M6wqRv54LuawrLAMt3g5/6A78JHbglN/xbkkqeh
         PHRMonAhMfrYMtFxduZdn3mAdsBg0YwqaBF/VdoeODf+M7yOdaGJJ5Zuvgh3s388RHzm
         7DSw==
X-Gm-Message-State: ANoB5pmmmsd3Wq3DgxUtE1OflFIIz18h9yWf2x1Gn8fAddgjFoQrfLLp
        cFWN/eoEX6WR287Xqm8oowGthA==
X-Google-Smtp-Source: AA0mqf7pGV2fW+qWAoJpxe1Z8v01hk4UyP6ifecpXjUcuLZroCfRIaR4XkJdw67x3nMsXGB63+ktgg==
X-Received: by 2002:adf:edd1:0:b0:241:7d0a:65ef with SMTP id v17-20020adfedd1000000b002417d0a65efmr11097121wro.491.1669233026179;
        Wed, 23 Nov 2022 11:50:26 -0800 (PST)
Received: from linaro.org ([2a00:23c5:6809:2201:fcbc:7b5d:8d6c:43a4])
        by smtp.gmail.com with ESMTPSA id w5-20020a5d6805000000b002364c77bcacsm7267414wru.38.2022.11.23.11.50.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 11:50:25 -0800 (PST)
From:   Mike Leach <mike.leach@linaro.org>
To:     coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     mathieu.poirier@linaro.org, suzuki.poulose@arm.com,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        linux-perf-users@vger.kernel.org, leo.yan@linaro.org,
        quic_jinlmao@quicinc.com, Mike Leach <mike.leach@linaro.org>
Subject: [PATCH v6 05/14] coresight: etm4x: Update ETM4 driver to use Trace ID API
Date:   Wed, 23 Nov 2022 19:50:01 +0000
Message-Id: <20221123195010.6859-6-mike.leach@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221123195010.6859-1-mike.leach@linaro.org>
References: <20221123195010.6859-1-mike.leach@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The trace ID API is now used to allocate trace IDs for ETM4.x / ETE
devices.

For perf sessions, these will be allocated on enable, and released on
disable.

For sysfs sessions, these will be allocated on enable, but only released
on reset. This allows the sysfs session to interrogate the Trace ID used
after the session is over - maintaining functional consistency with the
previous allocation scheme.

The trace ID will also be allocated on read of the mgmt/trctraceid file.
This ensures that if perf or sysfs read this before enabling trace, the
value will be the one used for the trace session.

Trace ID initialisation is removed from the _probe() function.

Signed-off-by: Mike Leach <mike.leach@linaro.org>
Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 .../coresight/coresight-etm4x-core.c          | 73 +++++++++++++++++--
 .../coresight/coresight-etm4x-sysfs.c         | 27 ++++++-
 drivers/hwtracing/coresight/coresight-etm4x.h |  3 +
 3 files changed, 93 insertions(+), 10 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
index 9dc0d7f57565..0656577d7e30 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
@@ -42,6 +42,7 @@
 #include "coresight-etm4x-cfg.h"
 #include "coresight-self-hosted-trace.h"
 #include "coresight-syscfg.h"
+#include "coresight-trace-id.h"
 
 static int boot_enable;
 module_param(boot_enable, int, 0444);
@@ -237,6 +238,30 @@ static int etm4_trace_id(struct coresight_device *csdev)
 	return drvdata->trcid;
 }
 
+int etm4_read_alloc_trace_id(struct etmv4_drvdata *drvdata)
+{
+	int trace_id;
+
+	/*
+	 * This will allocate a trace ID to the cpu,
+	 * or return the one currently allocated.
+	 * The trace id function has its own lock
+	 */
+	trace_id = coresight_trace_id_get_cpu_id(drvdata->cpu);
+	if (IS_VALID_CS_TRACE_ID(trace_id))
+		drvdata->trcid = (u8)trace_id;
+	else
+		dev_err(&drvdata->csdev->dev,
+			"Failed to allocate trace ID for %s on CPU%d\n",
+			dev_name(&drvdata->csdev->dev), drvdata->cpu);
+	return trace_id;
+}
+
+void etm4_release_trace_id(struct etmv4_drvdata *drvdata)
+{
+	coresight_trace_id_put_cpu_id(drvdata->cpu);
+}
+
 struct etm4_enable_arg {
 	struct etmv4_drvdata *drvdata;
 	int rc;
@@ -720,7 +745,7 @@ static int etm4_parse_event_config(struct coresight_device *csdev,
 static int etm4_enable_perf(struct coresight_device *csdev,
 			    struct perf_event *event)
 {
-	int ret = 0;
+	int ret = 0, trace_id;
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
 
 	if (WARN_ON_ONCE(drvdata->cpu != smp_processor_id())) {
@@ -732,6 +757,24 @@ static int etm4_enable_perf(struct coresight_device *csdev,
 	ret = etm4_parse_event_config(csdev, event);
 	if (ret)
 		goto out;
+
+	/*
+	 * perf allocates cpu ids as part of _setup_aux() - device needs to use
+	 * the allocated ID. This reads the current version without allocation.
+	 *
+	 * This does not use the trace id lock to prevent lock_dep issues
+	 * with perf locks - we know the ID cannot change until perf shuts down
+	 * the session
+	 */
+	trace_id = coresight_trace_id_read_cpu_id(drvdata->cpu);
+	if (!IS_VALID_CS_TRACE_ID(trace_id)) {
+		dev_err(&drvdata->csdev->dev, "Failed to set trace ID for %s on CPU%d\n",
+			dev_name(&drvdata->csdev->dev), drvdata->cpu);
+		ret = -EINVAL;
+		goto out;
+	}
+	drvdata->trcid = (u8)trace_id;
+
 	/* And enable it */
 	ret = etm4_enable_hw(drvdata);
 
@@ -756,6 +799,11 @@ static int etm4_enable_sysfs(struct coresight_device *csdev)
 
 	spin_lock(&drvdata->spinlock);
 
+	/* sysfs needs to read and allocate a trace ID */
+	ret = etm4_read_alloc_trace_id(drvdata);
+	if (ret < 0)
+		goto unlock_sysfs_enable;
+
 	/*
 	 * Executing etm4_enable_hw on the cpu whose ETM is being enabled
 	 * ensures that register writes occur when cpu is powered.
@@ -767,6 +815,11 @@ static int etm4_enable_sysfs(struct coresight_device *csdev)
 		ret = arg.rc;
 	if (!ret)
 		drvdata->sticky_enable = true;
+
+	if (ret)
+		etm4_release_trace_id(drvdata);
+
+unlock_sysfs_enable:
 	spin_unlock(&drvdata->spinlock);
 
 	if (!ret)
@@ -898,6 +951,11 @@ static int etm4_disable_perf(struct coresight_device *csdev,
 	/* TRCVICTLR::SSSTATUS, bit[9] */
 	filters->ssstatus = (control & BIT(9));
 
+	/*
+	 * perf will release trace ids when _free_aux() is
+	 * called at the end of the session.
+	 */
+
 	return 0;
 }
 
@@ -923,6 +981,13 @@ static void etm4_disable_sysfs(struct coresight_device *csdev)
 	spin_unlock(&drvdata->spinlock);
 	cpus_read_unlock();
 
+	/*
+	 * we only release trace IDs when resetting sysfs.
+	 * This permits sysfs users to read the trace ID after the trace
+	 * session has completed. This maintains operational behaviour with
+	 * prior trace id allocation method
+	 */
+
 	dev_dbg(&csdev->dev, "ETM tracing disabled\n");
 }
 
@@ -1565,11 +1630,6 @@ static int etm4_dying_cpu(unsigned int cpu)
 	return 0;
 }
 
-static void etm4_init_trace_id(struct etmv4_drvdata *drvdata)
-{
-	drvdata->trcid = coresight_get_trace_id(drvdata->cpu);
-}
-
 static int __etm4_cpu_save(struct etmv4_drvdata *drvdata)
 {
 	int i, ret = 0;
@@ -1946,7 +2006,6 @@ static int etm4_add_coresight_dev(struct etm4_init_arg *init_arg)
 	if (!desc.name)
 		return -ENOMEM;
 
-	etm4_init_trace_id(drvdata);
 	etm4_set_default(&drvdata->config);
 
 	pdata = coresight_get_platform_data(dev);
diff --git a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
index 9cac848cffaf..5e62aa40ecd0 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
@@ -266,10 +266,11 @@ static ssize_t reset_store(struct device *dev,
 	config->vmid_mask0 = 0x0;
 	config->vmid_mask1 = 0x0;
 
-	drvdata->trcid = drvdata->cpu + 1;
-
 	spin_unlock(&drvdata->spinlock);
 
+	/* for sysfs - only release trace id when resetting */
+	etm4_release_trace_id(drvdata);
+
 	cscfg_csdev_reset_feats(to_coresight_device(dev));
 
 	return size;
@@ -2392,6 +2393,26 @@ static struct attribute *coresight_etmv4_attrs[] = {
 	NULL,
 };
 
+/*
+ * Trace ID allocated dynamically on enable - but also allocate on read
+ * in case sysfs or perf read before enable to ensure consistent metadata
+ * information for trace decode
+ */
+static ssize_t trctraceid_show(struct device *dev,
+			       struct device_attribute *attr,
+			       char *buf)
+{
+	int trace_id;
+	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
+
+	trace_id = etm4_read_alloc_trace_id(drvdata);
+	if (trace_id < 0)
+		return trace_id;
+
+	return sysfs_emit(buf, "0x%x\n", trace_id);
+}
+static DEVICE_ATTR_RO(trctraceid);
+
 struct etmv4_reg {
 	struct coresight_device *csdev;
 	u32 offset;
@@ -2528,7 +2549,7 @@ static struct attribute *coresight_etmv4_mgmt_attrs[] = {
 	coresight_etm4x_reg(trcpidr3, TRCPIDR3),
 	coresight_etm4x_reg(trcoslsr, TRCOSLSR),
 	coresight_etm4x_reg(trcconfig, TRCCONFIGR),
-	coresight_etm4x_reg(trctraceid, TRCTRACEIDR),
+	&dev_attr_trctraceid.attr,
 	coresight_etm4x_reg(trcdevarch, TRCDEVARCH),
 	NULL,
 };
diff --git a/drivers/hwtracing/coresight/coresight-etm4x.h b/drivers/hwtracing/coresight/coresight-etm4x.h
index 4b21bb79f168..434f4e95ee17 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.h
+++ b/drivers/hwtracing/coresight/coresight-etm4x.h
@@ -1095,4 +1095,7 @@ static inline bool etm4x_is_ete(struct etmv4_drvdata *drvdata)
 {
 	return drvdata->arch >= ETM_ARCH_ETE;
 }
+
+int etm4_read_alloc_trace_id(struct etmv4_drvdata *drvdata);
+void etm4_release_trace_id(struct etmv4_drvdata *drvdata);
 #endif
-- 
2.17.1

