Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0E3066BE2A
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 13:50:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231166AbjAPMuU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 07:50:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230469AbjAPMtp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 07:49:45 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 810201E5FB
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 04:49:42 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id o17-20020a05600c511100b003db021ef437so685850wms.4
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 04:49:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WFf6QYJ93ZftLmaA8MnS6VvqDhL35ulHDB2UhDbwt2I=;
        b=RARopVv2XXHMYTmpnQJWrZTf4kBes0IqZmogJFcs5CDVkTPaoCNIaRwIPrIugK9mfU
         2F2dNbs8w0F/qSTjyBDwYxMCUy1luf0JeKFQ0RC51aDlJi05WnJ8ppcRp9DW84WCkmyi
         i7IPaYL+tdSQq4EWhAwcZcJ9msghLn2i1s0UFOMl+oi0mLVx+SofEwcMN7HgGrkiiCcc
         fuNQuwqbzmGLcsXgFlLjNBVR/yXb5FA8tzy43ggFOInlq7RbezZVoEQEbsZc37xr+LpC
         G9ZuTRI8xXNUtB/v+BraGB/Q2DfCW9IYoLQMG9LClYPd750SaTgx7I2aLAXebafiZBf/
         kFWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WFf6QYJ93ZftLmaA8MnS6VvqDhL35ulHDB2UhDbwt2I=;
        b=FfxtIJKh82G+Nl04mNNewA9xMpl1PJIJ7d0pIa8PSvdLyGhuZxeFSfGxxJoFjQMVcG
         +N0zGCA2pXWFrxoR+xfCXeKAM/X0rO9XFY1v2AM0E/ElN12zS2O6ZQ+gf9bovFPeRNsC
         9EZgiqdgGykkTVq9O/8uaIbuRcDaCJw4usiFhXA3vfBHS8C6SMyHPQYzzkgjqSj9b779
         Y6Sso6wlw2y5lAgxhtdh4QBeh0wEn5tl7/LnpQUqiRa0/Z3ZP+5YQF1di6F2lMgg8OMr
         13vcnHiW7g7dfo6lzBK/oFDZ21oQToI9sYNs/YkMa/+q335lehn7USpUk6zfNvJVLRC7
         4Pxg==
X-Gm-Message-State: AFqh2ko4VtPIiEa0QifAQEBP4j2puBiGfALEdnKz3VaaeJK3nQtKVLX6
        sf4GGU3T/1MhNG+gH9x9BHm9PtdCUGrfZAY4
X-Google-Smtp-Source: AMrXdXtNlTmpaKZ1XV3Wum5F93eWQ147zJ0sc96UpxN62tYj/qMovr0agFuapgM69DnwMTeRhQwjXA==
X-Received: by 2002:a05:600c:1e0c:b0:3da:ff60:f5c9 with SMTP id ay12-20020a05600c1e0c00b003daff60f5c9mr1659624wmb.40.1673873380948;
        Mon, 16 Jan 2023 04:49:40 -0800 (PST)
Received: from linaro.org ([2a00:23c5:6809:2201:6c91:710d:9433:e868])
        by smtp.gmail.com with ESMTPSA id fl12-20020a05600c0b8c00b003dab40f9eafsm6896832wmb.35.2023.01.16.04.49.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jan 2023 04:49:40 -0800 (PST)
From:   Mike Leach <mike.leach@linaro.org>
To:     coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     mathieu.poirier@linaro.org, suzuki.poulose@arm.com,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        linux-perf-users@vger.kernel.org, leo.yan@linaro.org,
        quic_jinlmao@quicinc.com, Mike Leach <mike.leach@linaro.org>
Subject: [PATCH v7 06/15] coresight: etm3x: Update ETM3 driver to use Trace ID API
Date:   Mon, 16 Jan 2023 12:49:19 +0000
Message-Id: <20230116124928.5440-7-mike.leach@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230116124928.5440-1-mike.leach@linaro.org>
References: <20230116124928.5440-1-mike.leach@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the TraceID API to allocate ETM trace IDs dynamically.

As with the etm4x we allocate on enable / disable for perf,
allocate on enable / reset for sysfs.

Additionally we allocate on sysfs file read as both perf and sysfs
can read the ID before enabling the hardware.

Remove sysfs option to write trace ID - which is inconsistent with
both the dynamic allocation method and the fixed allocation method
previously used.

Signed-off-by: Mike Leach <mike.leach@linaro.org>
Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight-etm.h   |  2 +
 .../coresight/coresight-etm3x-core.c          | 72 +++++++++++++++++--
 .../coresight/coresight-etm3x-sysfs.c         | 27 ++-----
 3 files changed, 75 insertions(+), 26 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm.h b/drivers/hwtracing/coresight/coresight-etm.h
index f3ab96eaf44e..3667428d38b6 100644
--- a/drivers/hwtracing/coresight/coresight-etm.h
+++ b/drivers/hwtracing/coresight/coresight-etm.h
@@ -287,4 +287,6 @@ int etm_get_trace_id(struct etm_drvdata *drvdata);
 void etm_set_default(struct etm_config *config);
 void etm_config_trace_mode(struct etm_config *config);
 struct etm_config *get_etm_config(struct etm_drvdata *drvdata);
+int etm_read_alloc_trace_id(struct etm_drvdata *drvdata);
+void etm_release_trace_id(struct etm_drvdata *drvdata);
 #endif
diff --git a/drivers/hwtracing/coresight/coresight-etm3x-core.c b/drivers/hwtracing/coresight/coresight-etm3x-core.c
index d0ab9933472b..090b6fbf6305 100644
--- a/drivers/hwtracing/coresight/coresight-etm3x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm3x-core.c
@@ -32,6 +32,7 @@
 
 #include "coresight-etm.h"
 #include "coresight-etm-perf.h"
+#include "coresight-trace-id.h"
 
 /*
  * Not really modular but using module_param is the easiest way to
@@ -490,16 +491,59 @@ static int etm_trace_id(struct coresight_device *csdev)
 	return etm_get_trace_id(drvdata);
 }
 
+int etm_read_alloc_trace_id(struct etm_drvdata *drvdata)
+{
+	int trace_id;
+
+	/*
+	 * This will allocate a trace ID to the cpu,
+	 * or return the one currently allocated.
+	 *
+	 * trace id function has its own lock
+	 */
+	trace_id = coresight_trace_id_get_cpu_id(drvdata->cpu);
+	if (IS_VALID_CS_TRACE_ID(trace_id))
+		drvdata->traceid = (u8)trace_id;
+	else
+		dev_err(&drvdata->csdev->dev,
+			"Failed to allocate trace ID for %s on CPU%d\n",
+			dev_name(&drvdata->csdev->dev), drvdata->cpu);
+	return trace_id;
+}
+
+void etm_release_trace_id(struct etm_drvdata *drvdata)
+{
+	coresight_trace_id_put_cpu_id(drvdata->cpu);
+}
+
 static int etm_enable_perf(struct coresight_device *csdev,
 			   struct perf_event *event)
 {
 	struct etm_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
+	int trace_id;
 
 	if (WARN_ON_ONCE(drvdata->cpu != smp_processor_id()))
 		return -EINVAL;
 
 	/* Configure the tracer based on the session's specifics */
 	etm_parse_event_config(drvdata, event);
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
+		return -EINVAL;
+	}
+	drvdata->traceid = (u8)trace_id;
+
 	/* And enable it */
 	return etm_enable_hw(drvdata);
 }
@@ -512,6 +556,11 @@ static int etm_enable_sysfs(struct coresight_device *csdev)
 
 	spin_lock(&drvdata->spinlock);
 
+	/* sysfs needs to allocate and set a trace ID */
+	ret = etm_read_alloc_trace_id(drvdata);
+	if (ret < 0)
+		goto unlock_enable_sysfs;
+
 	/*
 	 * Configure the ETM only if the CPU is online.  If it isn't online
 	 * hw configuration will take place on the local CPU during bring up.
@@ -528,6 +577,10 @@ static int etm_enable_sysfs(struct coresight_device *csdev)
 		ret = -ENODEV;
 	}
 
+	if (ret)
+		etm_release_trace_id(drvdata);
+
+unlock_enable_sysfs:
 	spin_unlock(&drvdata->spinlock);
 
 	if (!ret)
@@ -611,6 +664,12 @@ static void etm_disable_perf(struct coresight_device *csdev)
 	coresight_disclaim_device_unlocked(csdev);
 
 	CS_LOCK(drvdata->base);
+
+	/*
+	 * perf will release trace ids when _free_aux()
+	 * is called at the end of the session
+	 */
+
 }
 
 static void etm_disable_sysfs(struct coresight_device *csdev)
@@ -635,6 +694,13 @@ static void etm_disable_sysfs(struct coresight_device *csdev)
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
 
@@ -781,11 +847,6 @@ static void etm_init_arch_data(void *info)
 	CS_LOCK(drvdata->base);
 }
 
-static void etm_init_trace_id(struct etm_drvdata *drvdata)
-{
-	drvdata->traceid = coresight_get_trace_id(drvdata->cpu);
-}
-
 static int __init etm_hp_setup(void)
 {
 	int ret;
@@ -871,7 +932,6 @@ static int etm_probe(struct amba_device *adev, const struct amba_id *id)
 	if (etm_arch_supported(drvdata->arch) == false)
 		return -EINVAL;
 
-	etm_init_trace_id(drvdata);
 	etm_set_default(&drvdata->config);
 
 	pdata = coresight_get_platform_data(dev);
diff --git a/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
index fd81eca3ec18..2f271b7fb048 100644
--- a/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
+++ b/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
@@ -85,6 +85,7 @@ static ssize_t reset_store(struct device *dev,
 		}
 
 		etm_set_default(config);
+		etm_release_trace_id(drvdata);
 		spin_unlock(&drvdata->spinlock);
 	}
 
@@ -1189,30 +1190,16 @@ static DEVICE_ATTR_RO(cpu);
 static ssize_t traceid_show(struct device *dev,
 			    struct device_attribute *attr, char *buf)
 {
-	unsigned long val;
-	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
-
-	val = etm_get_trace_id(drvdata);
-
-	return sprintf(buf, "%#lx\n", val);
-}
-
-static ssize_t traceid_store(struct device *dev,
-			     struct device_attribute *attr,
-			     const char *buf, size_t size)
-{
-	int ret;
-	unsigned long val;
+	int trace_id;
 	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
 
-	ret = kstrtoul(buf, 16, &val);
-	if (ret)
-		return ret;
+	trace_id = etm_read_alloc_trace_id(drvdata);
+	if (trace_id < 0)
+		return trace_id;
 
-	drvdata->traceid = val & ETM_TRACEID_MASK;
-	return size;
+	return sysfs_emit(buf, "%#x\n", trace_id);
 }
-static DEVICE_ATTR_RW(traceid);
+static DEVICE_ATTR_RO(traceid);
 
 static struct attribute *coresight_etm_attrs[] = {
 	&dev_attr_nr_addr_cmp.attr,
-- 
2.17.1

