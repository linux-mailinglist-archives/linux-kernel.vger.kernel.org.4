Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78FB8636A14
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 20:51:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238487AbiKWTvA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 14:51:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238624AbiKWTuj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 14:50:39 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CD8A9152D
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 11:50:29 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id v7so13870556wmn.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 11:50:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RtSgePzwEvpHnL4zEatW6jx79yBYxDpuuEtOcrGOVNM=;
        b=f4JRlTiN0DgNTemMjtYw4ESytWJpnbJ8IkpJFIIkI1ze4rBOTr5oRYh4lXaCZPXZ0J
         +NvXxJbd0VTQkHzTP7vd1slsZjuVI/Y+eWfodDDNvzB98AOADwBCkCBuNYutO0Gl6uJc
         Ggz39d5RcuhMa6/mDnGkYNYJcz6ThKphQLG8mqjwitM/n0eslY31TyzNl9VNAgwAnKSG
         9zgULtb+bu1RfCY34Flnjhl28SsyRAJz+nMXIEkr6lF9/v2Fd1EMilUwqU4A15sAmmXC
         c7MZ6KcoWPLi+fo5t1BXqjYB11ySXSW/AkYPtsxRaVaqzoiK19NP6wXkKVT0lbL3dq1+
         CvuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RtSgePzwEvpHnL4zEatW6jx79yBYxDpuuEtOcrGOVNM=;
        b=ycbPL6rYHe/HJaSc21oID27zQQeyhkXkA+NH8ZS3iH2scCvnVW12dk2pbAy+auCnfm
         vxBW1QRt+UffU3PVfceaT5PHni2/lz8axuNaD+jv2Sdsa/kPOCgqjt2B7Nr1WLCKlwq3
         tCll44JqgSRiMVLKI7squ3zpkiJPIfv9Uj+OUlWLkJlOrBRUhSX24Y5ieOqx5bJn8rcq
         aYfhFyo1P2+tVFG97lH5Bxcc+4XAgAeCCRaYSS8FUldQaOLxY+j66lGWQpbMrJfmdWyR
         jOgUq3b49bzpYeVcafFLbLelg1yj54OSz9FPmPCkVjqmFLen/RkSjHAwbErbKpYs2r0g
         PLTg==
X-Gm-Message-State: ANoB5pkQC3EUloyas1cI/4eBurX55ftHobwtzmTDgT3liNYy7Xqhl0qf
        4aF9eHfhliI6cFwfBoxVSPn76Q==
X-Google-Smtp-Source: AA0mqf7XUBOh/sVWA6npPutPzcIQMHrg+MIiA9WozaN+pwN71Gc4Ur2WR7UfWxQZ0qoFjjBGLiYcGg==
X-Received: by 2002:a1c:6a01:0:b0:3cf:a895:a9cb with SMTP id f1-20020a1c6a01000000b003cfa895a9cbmr24658925wmc.96.1669233028490;
        Wed, 23 Nov 2022 11:50:28 -0800 (PST)
Received: from linaro.org ([2a00:23c5:6809:2201:fcbc:7b5d:8d6c:43a4])
        by smtp.gmail.com with ESMTPSA id w5-20020a5d6805000000b002364c77bcacsm7267414wru.38.2022.11.23.11.50.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 11:50:27 -0800 (PST)
From:   Mike Leach <mike.leach@linaro.org>
To:     coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     mathieu.poirier@linaro.org, suzuki.poulose@arm.com,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        linux-perf-users@vger.kernel.org, leo.yan@linaro.org,
        quic_jinlmao@quicinc.com, Mike Leach <mike.leach@linaro.org>
Subject: [PATCH v6 07/14] coresight: etmX.X: stm: Remove trace_id() callback
Date:   Wed, 23 Nov 2022 19:50:03 +0000
Message-Id: <20221123195010.6859-8-mike.leach@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221123195010.6859-1-mike.leach@linaro.org>
References: <20221123195010.6859-1-mike.leach@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CoreSight sources provide a callback (.trace_id) in the standard source
ops which returns the ID to the core code. This was used to check that
sources all had a unique Trace ID.

Uniqueness is now gauranteed by the Trace ID allocation system, and the
check code has been removed from the core.

This patch removes the unneeded and unused .trace_id source ops
from the ops structure and implementations in etm3x, etm4x and stm.

Signed-off-by: Mike Leach <mike.leach@linaro.org>
Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight-etm.h   |  1 -
 .../coresight/coresight-etm3x-core.c          | 37 -------------------
 .../coresight/coresight-etm4x-core.c          |  8 ----
 drivers/hwtracing/coresight/coresight-stm.c   |  8 ----
 include/linux/coresight.h                     |  3 --
 5 files changed, 57 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm.h b/drivers/hwtracing/coresight/coresight-etm.h
index 3667428d38b6..9a0d08b092ae 100644
--- a/drivers/hwtracing/coresight/coresight-etm.h
+++ b/drivers/hwtracing/coresight/coresight-etm.h
@@ -283,7 +283,6 @@ static inline unsigned int etm_readl(struct etm_drvdata *drvdata, u32 off)
 }
 
 extern const struct attribute_group *coresight_etm_groups[];
-int etm_get_trace_id(struct etm_drvdata *drvdata);
 void etm_set_default(struct etm_config *config);
 void etm_config_trace_mode(struct etm_config *config);
 struct etm_config *get_etm_config(struct etm_drvdata *drvdata);
diff --git a/drivers/hwtracing/coresight/coresight-etm3x-core.c b/drivers/hwtracing/coresight/coresight-etm3x-core.c
index 090b6fbf6305..afc57195ee52 100644
--- a/drivers/hwtracing/coresight/coresight-etm3x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm3x-core.c
@@ -455,42 +455,6 @@ static int etm_cpu_id(struct coresight_device *csdev)
 	return drvdata->cpu;
 }
 
-int etm_get_trace_id(struct etm_drvdata *drvdata)
-{
-	unsigned long flags;
-	int trace_id = -1;
-	struct device *etm_dev;
-
-	if (!drvdata)
-		goto out;
-
-	etm_dev = drvdata->csdev->dev.parent;
-	if (!local_read(&drvdata->mode))
-		return drvdata->traceid;
-
-	pm_runtime_get_sync(etm_dev);
-
-	spin_lock_irqsave(&drvdata->spinlock, flags);
-
-	CS_UNLOCK(drvdata->base);
-	trace_id = (etm_readl(drvdata, ETMTRACEIDR) & ETM_TRACEID_MASK);
-	CS_LOCK(drvdata->base);
-
-	spin_unlock_irqrestore(&drvdata->spinlock, flags);
-	pm_runtime_put(etm_dev);
-
-out:
-	return trace_id;
-
-}
-
-static int etm_trace_id(struct coresight_device *csdev)
-{
-	struct etm_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
-
-	return etm_get_trace_id(drvdata);
-}
-
 int etm_read_alloc_trace_id(struct etm_drvdata *drvdata)
 {
 	int trace_id;
@@ -737,7 +701,6 @@ static void etm_disable(struct coresight_device *csdev,
 
 static const struct coresight_ops_source etm_source_ops = {
 	.cpu_id		= etm_cpu_id,
-	.trace_id	= etm_trace_id,
 	.enable		= etm_enable,
 	.disable	= etm_disable,
 };
diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
index 0656577d7e30..bc576e254b8f 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
@@ -231,13 +231,6 @@ static int etm4_cpu_id(struct coresight_device *csdev)
 	return drvdata->cpu;
 }
 
-static int etm4_trace_id(struct coresight_device *csdev)
-{
-	struct etmv4_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
-
-	return drvdata->trcid;
-}
-
 int etm4_read_alloc_trace_id(struct etmv4_drvdata *drvdata)
 {
 	int trace_id;
@@ -1021,7 +1014,6 @@ static void etm4_disable(struct coresight_device *csdev,
 
 static const struct coresight_ops_source etm4_source_ops = {
 	.cpu_id		= etm4_cpu_id,
-	.trace_id	= etm4_trace_id,
 	.enable		= etm4_enable,
 	.disable	= etm4_disable,
 };
diff --git a/drivers/hwtracing/coresight/coresight-stm.c b/drivers/hwtracing/coresight/coresight-stm.c
index 6af1b996af6f..66a614c5492c 100644
--- a/drivers/hwtracing/coresight/coresight-stm.c
+++ b/drivers/hwtracing/coresight/coresight-stm.c
@@ -281,15 +281,7 @@ static void stm_disable(struct coresight_device *csdev,
 	}
 }
 
-static int stm_trace_id(struct coresight_device *csdev)
-{
-	struct stm_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
-
-	return drvdata->traceid;
-}
-
 static const struct coresight_ops_source stm_source_ops = {
-	.trace_id	= stm_trace_id,
 	.enable		= stm_enable,
 	.disable	= stm_disable,
 };
diff --git a/include/linux/coresight.h b/include/linux/coresight.h
index 1554021231f9..e241eb88dfb9 100644
--- a/include/linux/coresight.h
+++ b/include/linux/coresight.h
@@ -314,14 +314,11 @@ struct coresight_ops_link {
  * Operations available for sources.
  * @cpu_id:	returns the value of the CPU number this component
  *		is associated to.
- * @trace_id:	returns the value of the component's trace ID as known
- *		to the HW.
  * @enable:	enables tracing for a source.
  * @disable:	disables tracing for a source.
  */
 struct coresight_ops_source {
 	int (*cpu_id)(struct coresight_device *csdev);
-	int (*trace_id)(struct coresight_device *csdev);
 	int (*enable)(struct coresight_device *csdev,
 		      struct perf_event *event,  u32 mode);
 	void (*disable)(struct coresight_device *csdev,
-- 
2.17.1

