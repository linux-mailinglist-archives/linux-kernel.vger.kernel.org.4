Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7838708CC7
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 02:19:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231148AbjESATS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 20:19:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230487AbjESASm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 20:18:42 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C2101BC9
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 17:18:23 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-5341737d7aeso2340730a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 17:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684455488; x=1687047488;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dP0ycHF3kegqOyAJTyq+wPxH3acuLsvoILr7u3u5EHc=;
        b=IyUzdnaX1NrXHVvlHaGsPqPFrRaEZKMAqOMS4nlxP+217jmvVu1728V6o7dJvRXtxh
         29q3cW/DfHaqKyc7vOxwLC760DwmPzrLQo+kF4Qv0KBHbJzWwJZfYOU9NukkRuuUrqVk
         OlcNSTex/cxWXizFC+Pf59CeGdYZ4YIbOwE+HxNu7uaHltKE+uBX2/dsT0+vINyXhpvc
         AB/AuFS3ygiofTa0lUbqjDN9ARYI0a/DP1Uu7nHJWsnYlwALfiByLZmMtY9oikBSFk9a
         V662pSq68eYANl0/a0omQF6o3wAG6lFqRraqVEumaf2FRgoXOgvIk/PYdRg6DjHpImbb
         CiSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684455488; x=1687047488;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dP0ycHF3kegqOyAJTyq+wPxH3acuLsvoILr7u3u5EHc=;
        b=gU3WcX54z/KjQ8U/aJc3BNlVGhDlHTMGzlwdz1MCyPOqEtDfEVYQ09s8EhU+IpXe/7
         RWQzPpGPzdUiYfEQ7+m8tIJFeB1Kqu7v4HnlALEdO7BghOYW3bgs0X4V33XqswFoNuNV
         12R/mfbdaW0U2SivIO1N3Rb5tCq12XFSwOEEmbPhROTmxdAJNmPQKc6L3f9GgOF/bYTE
         ohbJtfn3/xxbAQjDx+yxYIM+Sf0MCLxIGAH/IUJQk1F/tas5cgt15zpJesMqDbNJXcRD
         7mjTYRYKz4QNtkyns3k/WnG1n29ect4G9GxX0JQuE2tFVrO6WLTVsjV/GKPSFeyhjKrf
         Zvqw==
X-Gm-Message-State: AC+VfDwe6QmKMxFQY5fotvIfimExqTdjL1OP9+CJ8EOm7f214j3UTgIu
        vIyQEoXtqBP3JScLfCfdYng=
X-Google-Smtp-Source: ACHHUZ5nzBuaqU968+lUbS2w3H/JKv9i5cGG1KNsPIMzliMK6DrbtIgWD7P63jNisdIuRBHRcwIWAw==
X-Received: by 2002:a17:902:f809:b0:1ab:11c8:777a with SMTP id ix9-20020a170902f80900b001ab11c8777amr794836plb.13.1684455488053;
        Thu, 18 May 2023 17:18:08 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id u2-20020a170902b28200b001ac7c6fd12asm2051881plr.104.2023.05.18.17.18.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 17:18:07 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
From:   Tejun Heo <tj@kernel.org>
To:     jiangshanlai@gmail.com
Cc:     torvalds@linux-foundation.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com,
        joshdon@google.com, brho@google.com, briannorris@chromium.org,
        nhuck@google.com, agk@redhat.com, snitzer@kernel.org,
        void@manifault.com, Tejun Heo <tj@kernel.org>
Subject: [PATCH 17/24] workqueue: Add multiple affinity scopes and interface to select them
Date:   Thu, 18 May 2023 14:17:02 -1000
Message-Id: <20230519001709.2563-18-tj@kernel.org>
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

Add three more affinity scopes - WQ_AFFN_CPU, SMT and CACHE - and make CACHE
the default. The code changes to actually add the additional scopes are
trivial.

Also add module parameter "workqueue.default_affinity_scope" to override the
default scope and "affinity_scope" sysfs file to configure it per workqueue.
wq_dump.py and documentations are updated accordingly.

This enables significant flexibility in configuring how unbound workqueues
behave. If affinity scope is set to "cpu", it'll behave close to a per-cpu
workqueue. On the other hand, "system" removes all locality boundaries.

Many modern machines have multiple L3 caches often while being mostly
uniform in terms of memory access. Thus, workqueue's previous behavior of
spreading work items in each NUMA node had negative performance implications
from unncessarily crossing L3 boundaries between issue and execution.
However, picking a finer grained affinity scope also has a downside in that
an issuer in one group can't utilize CPUs in other groups.

While dependent on the specifics of workload, there's usually a noticeable
penalty in crossing L3 boundaries, so let's default to CACHE. This issue
will be further addressed and documented with examples in future patches.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 .../admin-guide/kernel-parameters.txt         |  12 ++
 Documentation/core-api/workqueue.rst          |  63 ++++++++++
 include/linux/workqueue.h                     |   5 +-
 kernel/workqueue.c                            | 110 +++++++++++++++++-
 tools/workqueue/wq_dump.py                    |  15 ++-
 5 files changed, 193 insertions(+), 12 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 042275425c32..0aa7fd68a024 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -6958,6 +6958,18 @@
 			The default value of this parameter is determined by
 			the config option CONFIG_WQ_POWER_EFFICIENT_DEFAULT.
 
+        workqueue.default_affinity_scope=
+			Select the default affinity scope to use for unbound
+			workqueues. Can be one of "cpu", "smt", "cache",
+			"numa" and "system". Default is "cache". For more
+			information, see the Affinity Scopes section in
+			Documentation/core-api/workqueue.rst.
+
+			This can be updated after boot through the matching
+			file under /sys/module/workqueue/parameters.
+			However, the changed default will only apply to
+			unbound workqueues created afterwards.
+
 	workqueue.debug_force_rr_cpu
 			Workqueue used to implicitly guarantee that work
 			items queued without explicit CPU specified are put
diff --git a/Documentation/core-api/workqueue.rst b/Documentation/core-api/workqueue.rst
index c9e46acd339b..56af317508c9 100644
--- a/Documentation/core-api/workqueue.rst
+++ b/Documentation/core-api/workqueue.rst
@@ -347,6 +347,51 @@ Guidelines
   level of locality in wq operations and work item execution.
 
 
+Affinity Scopes
+===============
+
+An unbound workqueue groups CPUs according to its affinity scope to improve
+cache locality. For example, if a workqueue is using the default affinity
+scope of "cache", it will group CPUs according to last level cache
+boundaries. A work item queued on the workqueue will be processed by a
+worker running on one of the CPUs which share the last level cache with the
+issuing CPU.
+
+Workqueue currently supports the following five affinity scopes.
+
+``cpu``
+  CPUs are not grouped. A work item issued on one CPU is processed by a
+  worker on the same CPU. This makes unbound workqueues behave as per-cpu
+  workqueues without concurrency management.
+
+``smt``
+  CPUs are grouped according to SMT boundaries. This usually means that the
+  logical threads of each physical CPU core are grouped together.
+
+``cache``
+  CPUs are grouped according to cache boundaries. Which specific cache
+  boundary is used is determined by the arch code. L3 is used in a lot of
+  cases. This is the default affinity scope.
+
+``numa``
+  CPUs are grouped according to NUMA bounaries.
+
+``system``
+  All CPUs are put in the same group. Workqueue makes no effort to process a
+  work item on a CPU close to the issuing CPU.
+
+The default affinity scope can be changed with the module parameter
+``workqueue.default_affinity_scope`` and a specific workqueue's affinity
+scope can be changed using ``apply_workqueue_attrs()``.
+
+If ``WQ_SYSFS`` is set, the workqueue will have the following affinity scope
+related interface files under its ``/sys/devices/virtual/WQ_NAME/``
+directory.
+
+``affinity_scope``
+  Read to see the current affinity scope. Write to change.
+
+
 Examining Configuration
 =======================
 
@@ -358,6 +403,24 @@ Use tools/workqueue/wq_dump.py to examine unbound CPU affinity
   ===============
   wq_unbound_cpumask=0000000f
 
+  CPU
+    nr_pods  4
+    pod_cpus [0]=00000001 [1]=00000002 [2]=00000004 [3]=00000008
+    pod_node [0]=0 [1]=0 [2]=1 [3]=1
+    cpu_pod  [0]=0 [1]=1 [2]=2 [3]=3
+
+  SMT
+    nr_pods  4
+    pod_cpus [0]=00000001 [1]=00000002 [2]=00000004 [3]=00000008
+    pod_node [0]=0 [1]=0 [2]=1 [3]=1
+    cpu_pod  [0]=0 [1]=1 [2]=2 [3]=3
+
+  CACHE (default)
+    nr_pods  2
+    pod_cpus [0]=00000003 [1]=0000000c
+    pod_node [0]=0 [1]=1
+    cpu_pod  [0]=0 [1]=0 [2]=1 [3]=1
+
   NUMA
     nr_pods  2
     pod_cpus [0]=00000003 [1]=0000000c
diff --git a/include/linux/workqueue.h b/include/linux/workqueue.h
index a2f826b6ec9a..a01b5dcbbeb9 100644
--- a/include/linux/workqueue.h
+++ b/include/linux/workqueue.h
@@ -125,12 +125,15 @@ struct rcu_work {
 };
 
 enum wq_affn_scope {
+	WQ_AFFN_CPU,			/* one pod per CPU */
+	WQ_AFFN_SMT,			/* one pod poer SMT */
+	WQ_AFFN_CACHE,			/* one pod per LLC */
 	WQ_AFFN_NUMA,			/* one pod per NUMA node */
 	WQ_AFFN_SYSTEM,			/* one pod across the whole system */
 
 	WQ_AFFN_NR_TYPES,
 
-	WQ_AFFN_DFL = WQ_AFFN_NUMA,
+	WQ_AFFN_DFL = WQ_AFFN_CACHE,
 };
 
 /**
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 1734b8a11a4c..bb0900602408 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -337,6 +337,15 @@ struct wq_pod_type {
 };
 
 static struct wq_pod_type wq_pod_types[WQ_AFFN_NR_TYPES];
+static enum wq_affn_scope wq_affn_dfl = WQ_AFFN_DFL;
+
+static const char *wq_affn_names[WQ_AFFN_NR_TYPES] = {
+	[WQ_AFFN_CPU]			= "cpu",
+	[WQ_AFFN_SMT]			= "smt",
+	[WQ_AFFN_CACHE]			= "cache",
+	[WQ_AFFN_NUMA]			= "numa",
+	[WQ_AFFN_SYSTEM]		= "system",
+};
 
 /*
  * Per-cpu work items which run for longer than the following threshold are
@@ -3644,7 +3653,7 @@ struct workqueue_attrs *alloc_workqueue_attrs(void)
 		goto fail;
 
 	cpumask_copy(attrs->cpumask, cpu_possible_mask);
-	attrs->affn_scope = WQ_AFFN_DFL;
+	attrs->affn_scope = wq_affn_dfl;
 	return attrs;
 fail:
 	free_workqueue_attrs(attrs);
@@ -5721,19 +5730,55 @@ int workqueue_set_unbound_cpumask(cpumask_var_t cpumask)
 	return ret;
 }
 
+static int parse_affn_scope(const char *val)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(wq_affn_names); i++) {
+		if (!strncasecmp(val, wq_affn_names[i], strlen(wq_affn_names[i])))
+			return i;
+	}
+	return -EINVAL;
+}
+
+static int wq_affn_dfl_set(const char *val, const struct kernel_param *kp)
+{
+	int affn;
+
+	affn = parse_affn_scope(val);
+	if (affn < 0)
+		return affn;
+
+	wq_affn_dfl = affn;
+	return 0;
+}
+
+static int wq_affn_dfl_get(char *buffer, const struct kernel_param *kp)
+{
+	return scnprintf(buffer, PAGE_SIZE, "%s\n", wq_affn_names[wq_affn_dfl]);
+}
+
+static const struct kernel_param_ops wq_affn_dfl_ops = {
+	.set	= wq_affn_dfl_set,
+	.get	= wq_affn_dfl_get,
+};
+
+module_param_cb(default_affinity_scope, &wq_affn_dfl_ops, NULL, 0644);
+
 #ifdef CONFIG_SYSFS
 /*
  * Workqueues with WQ_SYSFS flag set is visible to userland via
  * /sys/bus/workqueue/devices/WQ_NAME.  All visible workqueues have the
  * following attributes.
  *
- *  per_cpu	RO bool	: whether the workqueue is per-cpu or unbound
- *  max_active	RW int	: maximum number of in-flight work items
+ *  per_cpu		RO bool	: whether the workqueue is per-cpu or unbound
+ *  max_active		RW int	: maximum number of in-flight work items
  *
  * Unbound workqueues have the following extra attributes.
  *
- *  nice	RW int	: nice value of the workers
- *  cpumask	RW mask	: bitmask of allowed CPUs for the workers
+ *  nice		RW int	: nice value of the workers
+ *  cpumask		RW mask	: bitmask of allowed CPUs for the workers
+ *  affinity_scope	RW str  : worker CPU affinity scope (cache, numa, none)
  */
 struct wq_device {
 	struct workqueue_struct		*wq;
@@ -5876,9 +5921,47 @@ static ssize_t wq_cpumask_store(struct device *dev,
 	return ret ?: count;
 }
 
+static ssize_t wq_affn_scope_show(struct device *dev,
+				  struct device_attribute *attr, char *buf)
+{
+	struct workqueue_struct *wq = dev_to_wq(dev);
+	int written;
+
+	mutex_lock(&wq->mutex);
+	written = scnprintf(buf, PAGE_SIZE, "%s\n",
+			    wq_affn_names[wq->unbound_attrs->affn_scope]);
+	mutex_unlock(&wq->mutex);
+
+	return written;
+}
+
+static ssize_t wq_affn_scope_store(struct device *dev,
+				   struct device_attribute *attr,
+				   const char *buf, size_t count)
+{
+	struct workqueue_struct *wq = dev_to_wq(dev);
+	struct workqueue_attrs *attrs;
+	int affn, ret = -ENOMEM;
+
+	affn = parse_affn_scope(buf);
+	if (affn < 0)
+		return affn;
+
+	apply_wqattrs_lock();
+	attrs = wq_sysfs_prep_attrs(wq);
+	if (attrs) {
+		attrs->affn_scope = affn;
+		ret = apply_workqueue_attrs_locked(wq, attrs);
+	}
+	apply_wqattrs_unlock();
+	free_workqueue_attrs(attrs);
+	return ret ?: count;
+}
+
 static struct device_attribute wq_sysfs_unbound_attrs[] = {
 	__ATTR(nice, 0644, wq_nice_show, wq_nice_store),
 	__ATTR(cpumask, 0644, wq_cpumask_show, wq_cpumask_store),
+	__ATTR(affinity_scope, 0644, wq_affn_scope_show, wq_affn_scope_store),
 	__ATTR_NULL,
 };
 
@@ -6438,6 +6521,20 @@ static void __init init_pod_type(struct wq_pod_type *pt,
 	}
 }
 
+static bool __init cpus_dont_share(int cpu0, int cpu1)
+{
+	return false;
+}
+
+static bool __init cpus_share_smt(int cpu0, int cpu1)
+{
+#ifdef CONFIG_SCHED_SMT
+	return cpumask_test_cpu(cpu0, cpu_smt_mask(cpu1));
+#else
+	return false;
+#endif
+}
+
 static bool __init cpus_share_numa(int cpu0, int cpu1)
 {
 	return cpu_to_node(cpu0) == cpu_to_node(cpu1);
@@ -6455,6 +6552,9 @@ void __init workqueue_init_topology(void)
 	struct workqueue_struct *wq;
 	int cpu;
 
+	init_pod_type(&wq_pod_types[WQ_AFFN_CPU], cpus_dont_share);
+	init_pod_type(&wq_pod_types[WQ_AFFN_SMT], cpus_share_smt);
+	init_pod_type(&wq_pod_types[WQ_AFFN_CACHE], cpus_share_cache);
 	init_pod_type(&wq_pod_types[WQ_AFFN_NUMA], cpus_share_numa);
 
 	mutex_lock(&wq_pool_mutex);
diff --git a/tools/workqueue/wq_dump.py b/tools/workqueue/wq_dump.py
index ddd0bb4395ea..43ab71a193b8 100644
--- a/tools/workqueue/wq_dump.py
+++ b/tools/workqueue/wq_dump.py
@@ -78,11 +78,16 @@ worker_pool_idr         = prog['worker_pool_idr']
 workqueues              = prog['workqueues']
 wq_unbound_cpumask      = prog['wq_unbound_cpumask']
 wq_pod_types            = prog['wq_pod_types']
+wq_affn_dfl             = prog['wq_affn_dfl']
+wq_affn_names           = prog['wq_affn_names']
 
 WQ_UNBOUND              = prog['WQ_UNBOUND']
 WQ_ORDERED              = prog['__WQ_ORDERED']
 WQ_MEM_RECLAIM          = prog['WQ_MEM_RECLAIM']
 
+WQ_AFFN_CPU             = prog['WQ_AFFN_CPU']
+WQ_AFFN_SMT             = prog['WQ_AFFN_SMT']
+WQ_AFFN_CACHE           = prog['WQ_AFFN_CACHE']
 WQ_AFFN_NUMA            = prog['WQ_AFFN_NUMA']
 WQ_AFFN_SYSTEM          = prog['WQ_AFFN_SYSTEM']
 
@@ -109,12 +114,10 @@ print(f'wq_unbound_cpumask={cpumask_str(wq_unbound_cpumask)}')
         print(f' [{cpu}]={pt.cpu_pod[cpu].value_()}', end='')
     print('')
 
-print('')
-print('NUMA')
-print_pod_type(wq_pod_types[WQ_AFFN_NUMA])
-print('')
-print('SYSTEM')
-print_pod_type(wq_pod_types[WQ_AFFN_SYSTEM])
+for affn in [WQ_AFFN_CPU, WQ_AFFN_SMT, WQ_AFFN_CACHE, WQ_AFFN_NUMA, WQ_AFFN_SYSTEM]:
+    print('')
+    print(f'{wq_affn_names[affn].string_().decode().upper()}{" (default)" if affn == wq_affn_dfl else ""}')
+    print_pod_type(wq_pod_types[affn])
 
 print('')
 print('Worker Pools')
-- 
2.40.1

