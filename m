Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1283F708CC6
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 02:19:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231225AbjESATJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 20:19:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230454AbjESASk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 20:18:40 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 437771BC1
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 17:18:23 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1ae58e4b295so16276955ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 17:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684455486; x=1687047486;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yJzaB4sbD9GE0bBqwD3qd2EPr+nnQXrioLEXbrU0xdI=;
        b=LAr7MSHr9NiXJV6RgUD+SFsrlffaVq99Wt9GZB0wYhRZRnkjIdpagO/rR7FJHO4sSp
         oz31yRQpSVCZMZIRXIuKNan60IIEPiLxnv0KQFYz3YQp+f7LD/5TlWOH2dvH5UsQ/CCa
         FUSOD3TlUgJSO+sX8KuZVuR5erFWjgbEWs/A8Rlr2k+jkzDRIlZhN0JLz3yc0Af6YJ23
         GTubO+nDMbBDBhBZITsZ6G3NImOQOh5YJYbaSw7CgKcjG3+7DeZfi/KwkGooEYUJgiqZ
         Oi40MwnHSSkBLhha5nAQP4pfsGs9kjjV40nFgdXIrXWjSysQfVRrgjuqRQfKlemqmvqC
         AAxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684455486; x=1687047486;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yJzaB4sbD9GE0bBqwD3qd2EPr+nnQXrioLEXbrU0xdI=;
        b=DiW6ONpx4pjimaF6G7CJsrAXfTXowXWq9vOJYE62vEXFYT3nmuTGD9vZSH7nfUHoEZ
         h/riUnMkgZ+ZvJncqpQVnNEro3rPdZKtRwkpTOE3NISg9n8jqCOJG51lwGxGGWMktLj1
         FQMNQ1Vpbt4RVPCVYAecBaDfnZjbeOTwI6P/Acr3qnE2sD2F6pPxIPST/qC6mLzWSPSG
         9nQOpVpv7yfmO32tw+S0a1K2pIB+mqS4EVV9YM1LEDfskRkCbUOWGm/7WYhR3uy9PSrh
         ofi+rTlxn8xxNcxXbOA2auUmjSNujMX20V/YtDKwmpJwKLJKXg9v7iOmyovz4PxUX08N
         KfJg==
X-Gm-Message-State: AC+VfDz83Vnk1V5bwZfv/9oUhFc5PHSGbAMwNxndwe75I58quEWCqLL6
        35ksaBv9fo+4ceGEEzv5AZw=
X-Google-Smtp-Source: ACHHUZ6z9AZ/BCECnjyTl6JZER9pOoC+WHV2Q8QiY6WfjkswY9xuVOBbSjFN3Loi/eAI6n/b/RbM7w==
X-Received: by 2002:a17:903:248:b0:1a9:3b64:3747 with SMTP id j8-20020a170903024800b001a93b643747mr881330plh.17.1684455486100;
        Thu, 18 May 2023 17:18:06 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id iz22-20020a170902ef9600b001a4fecf79e4sm2068031plb.49.2023.05.18.17.18.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 17:18:05 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
From:   Tejun Heo <tj@kernel.org>
To:     jiangshanlai@gmail.com
Cc:     torvalds@linux-foundation.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com,
        joshdon@google.com, brho@google.com, briannorris@chromium.org,
        nhuck@google.com, agk@redhat.com, snitzer@kernel.org,
        void@manifault.com, Tejun Heo <tj@kernel.org>
Subject: [PATCH 16/24] workqueue: Modularize wq_pod_type initialization
Date:   Thu, 18 May 2023 14:17:01 -1000
Message-Id: <20230519001709.2563-17-tj@kernel.org>
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

While wq_pod_type[] can now group CPUs in any aribitrary way, WQ_AFFN_NUM
init is hard coded into workqueue_init_topology(). This patch modularizes
the init path by introducing init_pod_type() which takes a callback to
determine whether two CPUs should share a pod as an argument.

init_pod_type() first scans the CPU combinations testing for sharing to
assign consecutive pod IDs and initialize pod_type->cpu_pod[]. Once
->cpu_pod[] is determined, ->pod_cpus[] and ->pod_node[] are initialized
accordingly. WQ_AFFN_NUMA is now initialized by calling init_pod_type() with
cpus_share_numa() which tests whether the CPU belongs to the same NUMA node.

This patch may change the pod ID assigned to each NUMA node but that
shouldn't cause any behavior changes as the NUMA node to use for allocations
are tracked separately in pod_type->pod_node[]. This makes adding new
affinty types pretty easy.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/workqueue.c | 84 +++++++++++++++++++++++++++-------------------
 1 file changed, 50 insertions(+), 34 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index dae1787833cb..1734b8a11a4c 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -6395,6 +6395,54 @@ void __init workqueue_init(void)
 	wq_watchdog_init();
 }
 
+/*
+ * Initialize @pt by first initializing @pt->cpu_pod[] with pod IDs according to
+ * @cpu_shares_pod(). Each subset of CPUs that share a pod is assigned a unique
+ * and consecutive pod ID. The rest of @pt is initialized accordingly.
+ */
+static void __init init_pod_type(struct wq_pod_type *pt,
+				 bool (*cpus_share_pod)(int, int))
+{
+	int cur, pre, cpu, pod;
+
+	pt->nr_pods = 0;
+
+	/* init @pt->cpu_pod[] according to @cpus_share_pod() */
+	pt->cpu_pod = kcalloc(nr_cpu_ids, sizeof(pt->cpu_pod[0]), GFP_KERNEL);
+	BUG_ON(!pt->cpu_pod);
+
+	for_each_possible_cpu(cur) {
+		for_each_possible_cpu(pre) {
+			if (pre >= cur) {
+				pt->cpu_pod[cur] = pt->nr_pods++;
+				break;
+			}
+			if (cpus_share_pod(cur, pre)) {
+				pt->cpu_pod[cur] = pt->cpu_pod[pre];
+				break;
+			}
+		}
+	}
+
+	/* init the rest to match @pt->cpu_pod[] */
+	pt->pod_cpus = kcalloc(pt->nr_pods, sizeof(pt->pod_cpus[0]), GFP_KERNEL);
+	pt->pod_node = kcalloc(pt->nr_pods, sizeof(pt->pod_node[0]), GFP_KERNEL);
+	BUG_ON(!pt->pod_cpus || !pt->pod_node);
+
+	for (pod = 0; pod < pt->nr_pods; pod++)
+		BUG_ON(!zalloc_cpumask_var(&pt->pod_cpus[pod], GFP_KERNEL));
+
+	for_each_possible_cpu(cpu) {
+		cpumask_set_cpu(cpu, pt->pod_cpus[pt->cpu_pod[cpu]]);
+		pt->pod_node[pt->cpu_pod[cpu]] = cpu_to_node(cpu);
+	}
+}
+
+static bool __init cpus_share_numa(int cpu0, int cpu1)
+{
+	return cpu_to_node(cpu0) == cpu_to_node(cpu1);
+}
+
 /**
  * workqueue_init_topology - initialize CPU pods for unbound workqueues
  *
@@ -6404,45 +6452,13 @@ void __init workqueue_init(void)
  */
 void __init workqueue_init_topology(void)
 {
-	struct wq_pod_type *pt = &wq_pod_types[WQ_AFFN_NUMA];
 	struct workqueue_struct *wq;
-	int node, cpu;
-
-	if (num_possible_nodes() <= 1)
-		return;
+	int cpu;
 
-	for_each_possible_cpu(cpu) {
-		if (WARN_ON(cpu_to_node(cpu) == NUMA_NO_NODE)) {
-			pr_warn("workqueue: NUMA node mapping not available for cpu%d, disabling NUMA support\n", cpu);
-			return;
-		}
-	}
+	init_pod_type(&wq_pod_types[WQ_AFFN_NUMA], cpus_share_numa);
 
 	mutex_lock(&wq_pool_mutex);
 
-	/*
-	 * We want masks of possible CPUs of each node which isn't readily
-	 * available.  Build one from cpu_to_node() which should have been
-	 * fully initialized by now.
-	 */
-	pt->pod_cpus = kcalloc(nr_node_ids, sizeof(pt->pod_cpus[0]), GFP_KERNEL);
-	pt->pod_node = kcalloc(nr_node_ids, sizeof(pt->pod_node[0]), GFP_KERNEL);
-	pt->cpu_pod = kcalloc(nr_cpu_ids, sizeof(pt->cpu_pod[0]), GFP_KERNEL);
-	BUG_ON(!pt->pod_cpus || !pt->pod_node || !pt->cpu_pod);
-
-	for_each_node(node)
-		BUG_ON(!zalloc_cpumask_var_node(&pt->pod_cpus[node], GFP_KERNEL,
-				node_online(node) ? node : NUMA_NO_NODE));
-
-	for_each_possible_cpu(cpu) {
-		node = cpu_to_node(cpu);
-		cpumask_set_cpu(cpu, pt->pod_cpus[node]);
-		pt->pod_node[node] = node;
-		pt->cpu_pod[cpu] = node;
-	}
-
-	pt->nr_pods = nr_node_ids;
-
 	/*
 	 * Workqueues allocated earlier would have all CPUs sharing the default
 	 * worker pool. Explicitly call wq_update_pod() on all workqueue and CPU
-- 
2.40.1

