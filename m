Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8175A708CBC
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 02:18:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbjESASD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 20:18:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230329AbjESARy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 20:17:54 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 948681703
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 17:17:48 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1ae4e49727eso26967695ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 17:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684455467; x=1687047467;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v0ZsecRYaEvYJeTDSDmHpi6RDj4O0XfHKhELiT004Zs=;
        b=eop8BSJfdrQRbEwHV/yxjHa0y/3t+6vbROqMroHcX9Bn8nJHDTRQ7MGWjUSYUc371o
         TvYCtLGvIk6AR4pvw3fFVChsdFFYqYjVxAzZGlBFQ4VdDCXffRB9L16h7sLmzeYFpFjE
         lWSIqCCqitwCmVZ6LYqN3RpmUOeyk7gd/4kjrMRMqd2LRxdGX79vP7+w1NZQQp2efAt6
         knsBLgp/7WpwV7O9s1j7T7kqptEHRq+4663OKSICBA3Il8Sxj+7XhDFIKcSbNd3BH0F5
         aiai7A6LnT1k1jpSRNQJewNuQNEiIc5C5GtDCrLjodwZx843nlqC9T/GqTT9oBr9mMUt
         hQmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684455467; x=1687047467;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=v0ZsecRYaEvYJeTDSDmHpi6RDj4O0XfHKhELiT004Zs=;
        b=hHWl0XjkT++wePYQ8U3A1nhDo99gnp4r4AeAwwz3G6iWrFUuvrCijTC0oD60Zs/VGQ
         LI4cgDCoOqbnap4j1oS8zFBg0MBKuyENnUA41UIdtHy+ogNqpAF43nD+2wCt3aUiKS97
         qL/6aOCPuUAZNBJIfuLSv4a9hjJj5ZDxSrZ+olCXPkNNgiQnGlASuMNvuv2ZhS3kUdkH
         WMmVkP14V4XGzn7K3/OxL/JxlW+LWymvPMilwU/kFj+ZyXtnk/P6K4ZV1oqb1u/Gp7Sx
         EawgYRhDnVy0ecpbhn4fApFhSswNWDkAhwVDhyd/i74x3w5ybVZ/UuwJMBuaaTOwUxua
         Hw1w==
X-Gm-Message-State: AC+VfDy73BC/i2/xyMF0u5lcBmlcBkpmeBMcoR36QZhPAjyXmCRZ9ewz
        UjLMo9LlECDqSz80w/gAFk8=
X-Google-Smtp-Source: ACHHUZ5JaV3kqamsur05FZYCTVPz4kCtFvIjFtcXsFdiFq8rEqNcRZmLRLxz0uFkyJNXZeUuV9owrA==
X-Received: by 2002:a17:903:2595:b0:1ad:1c22:1b53 with SMTP id jb21-20020a170903259500b001ad1c221b53mr806630plb.40.1684455467212;
        Thu, 18 May 2023 17:17:47 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id jh18-20020a170903329200b001ac741db80csm2074225plb.88.2023.05.18.17.17.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 17:17:46 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
From:   Tejun Heo <tj@kernel.org>
To:     jiangshanlai@gmail.com
Cc:     torvalds@linux-foundation.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com,
        joshdon@google.com, brho@google.com, briannorris@chromium.org,
        nhuck@google.com, agk@redhat.com, snitzer@kernel.org,
        void@manifault.com, Tejun Heo <tj@kernel.org>
Subject: [PATCH 06/24] workqueue: Remove module param disable_numa and sysfs knobs pool_ids and numa
Date:   Thu, 18 May 2023 14:16:51 -1000
Message-Id: <20230519001709.2563-7-tj@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230519001709.2563-1-tj@kernel.org>
References: <20230519001709.2563-1-tj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unbound workqueue CPU affinity is going to receive an overhaul and the NUMA
specific knobs won't make sense anymore. Remove them. Also, the pool_ids
knob was used for debugging and not really meaningful given that there is no
visibility into the pools associated with those IDs. Remove it too. A future
patch will improve overall visibility.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 .../admin-guide/kernel-parameters.txt         |  9 ---
 kernel/workqueue.c                            | 73 -------------------
 2 files changed, 82 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 3ed7dda4c994..042275425c32 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -6943,15 +6943,6 @@
 			threshold repeatedly. They are likely good
 			candidates for using WQ_UNBOUND workqueues instead.
 
-	workqueue.disable_numa
-			By default, all work items queued to unbound
-			workqueues are affine to the NUMA nodes they're
-			issued on, which results in better behavior in
-			general.  If NUMA affinity needs to be disabled for
-			whatever reason, this option can be used.  Note
-			that this also can be controlled per-workqueue for
-			workqueues visible under /sys/bus/workqueue/.
-
 	workqueue.power_efficient
 			Per-cpu workqueues are generally preferred because
 			they show better performance thanks to cache
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 6ec22eb87283..f39d04e7e5f9 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -337,9 +337,6 @@ static cpumask_var_t *wq_numa_possible_cpumask;
 static unsigned long wq_cpu_intensive_thresh_us = 10000;
 module_param_named(cpu_intensive_thresh_us, wq_cpu_intensive_thresh_us, ulong, 0644);
 
-static bool wq_disable_numa;
-module_param_named(disable_numa, wq_disable_numa, bool, 0444);
-
 /* see the comment above the definition of WQ_POWER_EFFICIENT */
 static bool wq_power_efficient = IS_ENABLED(CONFIG_WQ_POWER_EFFICIENT_DEFAULT);
 module_param_named(power_efficient, wq_power_efficient, bool, 0444);
@@ -5777,10 +5774,8 @@ int workqueue_set_unbound_cpumask(cpumask_var_t cpumask)
  *
  * Unbound workqueues have the following extra attributes.
  *
- *  pool_ids	RO int	: the associated pool IDs for each node
  *  nice	RW int	: nice value of the workers
  *  cpumask	RW mask	: bitmask of allowed CPUs for the workers
- *  numa	RW bool	: whether enable NUMA affinity
  */
 struct wq_device {
 	struct workqueue_struct		*wq;
@@ -5833,28 +5828,6 @@ static struct attribute *wq_sysfs_attrs[] = {
 };
 ATTRIBUTE_GROUPS(wq_sysfs);
 
-static ssize_t wq_pool_ids_show(struct device *dev,
-				struct device_attribute *attr, char *buf)
-{
-	struct workqueue_struct *wq = dev_to_wq(dev);
-	const char *delim = "";
-	int node, written = 0;
-
-	cpus_read_lock();
-	rcu_read_lock();
-	for_each_node(node) {
-		written += scnprintf(buf + written, PAGE_SIZE - written,
-				     "%s%d:%d", delim, node,
-				     unbound_pwq_by_node(wq, node)->pool->id);
-		delim = " ";
-	}
-	written += scnprintf(buf + written, PAGE_SIZE - written, "\n");
-	rcu_read_unlock();
-	cpus_read_unlock();
-
-	return written;
-}
-
 static ssize_t wq_nice_show(struct device *dev, struct device_attribute *attr,
 			    char *buf)
 {
@@ -5945,50 +5918,9 @@ static ssize_t wq_cpumask_store(struct device *dev,
 	return ret ?: count;
 }
 
-static ssize_t wq_numa_show(struct device *dev, struct device_attribute *attr,
-			    char *buf)
-{
-	struct workqueue_struct *wq = dev_to_wq(dev);
-	int written;
-
-	mutex_lock(&wq->mutex);
-	written = scnprintf(buf, PAGE_SIZE, "%d\n",
-			    !wq->unbound_attrs->no_numa);
-	mutex_unlock(&wq->mutex);
-
-	return written;
-}
-
-static ssize_t wq_numa_store(struct device *dev, struct device_attribute *attr,
-			     const char *buf, size_t count)
-{
-	struct workqueue_struct *wq = dev_to_wq(dev);
-	struct workqueue_attrs *attrs;
-	int v, ret = -ENOMEM;
-
-	apply_wqattrs_lock();
-
-	attrs = wq_sysfs_prep_attrs(wq);
-	if (!attrs)
-		goto out_unlock;
-
-	ret = -EINVAL;
-	if (sscanf(buf, "%d", &v) == 1) {
-		attrs->no_numa = !v;
-		ret = apply_workqueue_attrs_locked(wq, attrs);
-	}
-
-out_unlock:
-	apply_wqattrs_unlock();
-	free_workqueue_attrs(attrs);
-	return ret ?: count;
-}
-
 static struct device_attribute wq_sysfs_unbound_attrs[] = {
-	__ATTR(pool_ids, 0444, wq_pool_ids_show, NULL),
 	__ATTR(nice, 0644, wq_nice_show, wq_nice_store),
 	__ATTR(cpumask, 0644, wq_cpumask_show, wq_cpumask_store),
-	__ATTR(numa, 0644, wq_numa_show, wq_numa_store),
 	__ATTR_NULL,
 };
 
@@ -6362,11 +6294,6 @@ static void __init wq_numa_init(void)
 	if (num_possible_nodes() <= 1)
 		return;
 
-	if (wq_disable_numa) {
-		pr_info("workqueue: NUMA affinity support disabled\n");
-		return;
-	}
-
 	for_each_possible_cpu(cpu) {
 		if (WARN_ON(cpu_to_node(cpu) == NUMA_NO_NODE)) {
 			pr_warn("workqueue: NUMA node mapping not available for cpu%d, disabling NUMA support\n", cpu);
-- 
2.40.1

