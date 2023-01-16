Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A673466BE28
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 13:50:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231139AbjAPMuM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 07:50:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230458AbjAPMtp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 07:49:45 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A1CD1E5F6
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 04:49:41 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id o17-20020a05600c511100b003db021ef437so685810wms.4
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 04:49:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lCju1LMq2OWW1UktMiBxt+Fk7jLfBTROHVEwsuq9EaA=;
        b=Ku9QDRhll4G8vRoi2lMxWFa8r17ZN7DPZT5TlTcVTGnuzjb3zkc6Y9WnF94SNqyp/S
         OVTkbIvl5UUkSzxf3j7FgiugnzK/Z1WYsZ42oc3H2pNBBJd2qIq5WTjfz26xmMBeSzx0
         nBIASh+D551p/4jfE8X3JZ44bOSF25zsZxvmxEBlsmXf/blNQLniibR2aIKqb0cNISTI
         NTfHS1iflMgAWHVRWiBqK9YpHg9l/cWSbmrhaN2ugrnE2vkg1LyAe41fETeOOEOU6iFE
         xXu3gsKsrTbAVOITAI4T4Wztk9yNJ6R/ut6ilq9N6ly3KyXfXd59q4DM7OF7qXSKZEh6
         QFXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lCju1LMq2OWW1UktMiBxt+Fk7jLfBTROHVEwsuq9EaA=;
        b=f6ocMM+wJFnk+Mh8Mwld1Y1HTbrBnrQKKIcfcNkdB+jblhkrMixcYk2ORU5TdWElNI
         Gm+mc3jAlq+AuYNEe19NZPP2SSxdazpjXu3A/wHR2E2NL7UIYmPQhaj12Jm1ZAb+9ZG3
         DjsYQD3gvZDPedj66kiA7/DM/XyFVEYTV9e5jFvRYKJLLxNjzKXBMbtFQgS3U41hEa7V
         s3RaSZQFFySY2/JYbrNwbOcRqh7GEtgoPvg1+tetxTwQJHJC/KV6smVr/RzVhPdELJ9x
         Ql8GKf9TMm06AGMXt6/9EwhyXsMwy3qQf+KzpPnSBst+siVfP5i95nuFz3Uu0HyP60t5
         gFNQ==
X-Gm-Message-State: AFqh2ko/tFysxvun+Z21fqsWX+cQCznq1NrcRmrb25KhPgMIWtf3Zo48
        EinzPZPny25NWcXHsqSNccL9Pw==
X-Google-Smtp-Source: AMrXdXuhSLaBqsBq2Uyn8nh6/XRFe2N7Ww1wD7Zc9jq9wdYPR7xX1ZnCNaWCaXWpdiSvAfDbifNNow==
X-Received: by 2002:a05:600c:4349:b0:3da:f665:5b6b with SMTP id r9-20020a05600c434900b003daf6655b6bmr5170220wme.25.1673873379854;
        Mon, 16 Jan 2023 04:49:39 -0800 (PST)
Received: from linaro.org ([2a00:23c5:6809:2201:6c91:710d:9433:e868])
        by smtp.gmail.com with ESMTPSA id fl12-20020a05600c0b8c00b003dab40f9eafsm6896832wmb.35.2023.01.16.04.49.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jan 2023 04:49:39 -0800 (PST)
From:   Mike Leach <mike.leach@linaro.org>
To:     coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     mathieu.poirier@linaro.org, suzuki.poulose@arm.com,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        linux-perf-users@vger.kernel.org, leo.yan@linaro.org,
        quic_jinlmao@quicinc.com, Mike Leach <mike.leach@linaro.org>
Subject: [PATCH v7 05/15] coresight: etm4x: Update ETM4 driver to use Trace ID API
Date:   Mon, 16 Jan 2023 12:49:18 +0000
Message-Id: <20230116124928.5440-6-mike.leach@linaro.org>
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
index 1cc052979e01..370826179c0b 100644
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

