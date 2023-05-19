Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0023B708CC2
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 02:18:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230455AbjESASk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 20:18:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230459AbjESASV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 20:18:21 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8070910E9
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 17:18:01 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1aaebed5bd6so19812905ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 17:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684455479; x=1687047479;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2/PmvqTHj42j0r/UUkQ7A13IJ6p9nJcrSOrJzi5sT4U=;
        b=SXbGSvXs/T97X71btC61wJsmE6c2w62rr/iKuh4OFsgvGHIqccEztj09hVhHp3Km/7
         eTJh8LYaWSTlMf7xekF+HUb6J79K1vzYjuE4ThwgDo6mRXMPQcEasv5Va/Erd8dekSDU
         Uyl2usw79bcsq429z2L9yE9kxpmOITmP0L20DDtkhRsPQIN2uQB7OCKujuQeXtJUWyyq
         kOW2jy7CHvYTVCLOcKCk/CO5xgBoE2+lHjbK8uQ71ZueiQYQrCBd9B4HR9boPR97gcFy
         1yg6lgcCpsBj7Lu5UnML5DH6jpmasEFLWo1x6GWZm/sxz+kTmd5IxLWvAs3Lt4pNDA4a
         iy/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684455479; x=1687047479;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2/PmvqTHj42j0r/UUkQ7A13IJ6p9nJcrSOrJzi5sT4U=;
        b=bSR3CR1M5B+pkS+UcsLrA+FWQ65k4hfFLFkPL5ivpoQ2GK1O9/qsNgXAySLvEXt7Ia
         wKsvKEj9A+lwuLwl062nJpcJTJbVyAeJSM1ZlScYERlSrbOTF1Th+4FRuCctz6V1OP/p
         slnZvTz3y6HdZ9hVv4PlpTAUbJX1NbgZg2ACe5wP0inP1HQxISv6Q1kw8gK3bvFbDcsE
         Pnp5tOJ8QL1HbeSqOUeybt4TCBfGCxJfnNDqtkH3TU8hFEionHG8PQAZ6mlCaRxwblXh
         RqcdcPj2HQFxKWy+fZkCScM2+/1uWsu69GXa4icBGj5KtNrU6MKlZAMIugEMow1Y6xhx
         o8bA==
X-Gm-Message-State: AC+VfDyVpYRmUrEu4P3+Hhvwt+GuMgSHiiiOrOanTwBh+1IC9OkwPD2I
        EKccaUCKuZ8NP4OqP2m8wnA=
X-Google-Smtp-Source: ACHHUZ6Ye4ApIcRNN6Tyk+cemFhvhMBmz+Hsg7o/GVyVpkQHeABax3FZgtchKKlCv0Ci4Ocm+Pnj5Q==
X-Received: by 2002:a17:902:8d8a:b0:1ad:7bc5:b9ea with SMTP id v10-20020a1709028d8a00b001ad7bc5b9eamr656437plo.60.1684455478667;
        Thu, 18 May 2023 17:17:58 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id t4-20020a1709028c8400b001ae197fdbb2sm2013295plo.274.2023.05.18.17.17.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 17:17:58 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
From:   Tejun Heo <tj@kernel.org>
To:     jiangshanlai@gmail.com
Cc:     torvalds@linux-foundation.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com,
        joshdon@google.com, brho@google.com, briannorris@chromium.org,
        nhuck@google.com, agk@redhat.com, snitzer@kernel.org,
        void@manifault.com, Tejun Heo <tj@kernel.org>
Subject: [PATCH 12/24] workqueue: Move wq_pod_init() below workqueue_init()
Date:   Thu, 18 May 2023 14:16:57 -1000
Message-Id: <20230519001709.2563-13-tj@kernel.org>
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

wq_pod_init() is called from workqueue_init() and responsible for
initializing unbound CPU pods according to NUMA node. Workqueue is in the
process of improving affinity awareness and wants to use other topology
information to initialize unbound CPU pods; however, unlike NUMA nodes,
other topology information isn't yet available in workqueue_init().

The next patch will introduce a later stage init function for workqueue
which will be responsible for initializing unbound CPU pods. Relocate
wq_pod_init() below workqueue_init() where the new init function is going to
be located so that the diff can show the content differences.

Just a relocation. No functional changes.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/workqueue.c | 78 ++++++++++++++++++++++++----------------------
 1 file changed, 40 insertions(+), 38 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 08ab40371697..914a69f83d59 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -6222,44 +6222,7 @@ static inline void wq_watchdog_init(void) { }
 
 #endif	/* CONFIG_WQ_WATCHDOG */
 
-static void __init wq_pod_init(void)
-{
-	cpumask_var_t *tbl;
-	int node, cpu;
-
-	if (num_possible_nodes() <= 1)
-		return;
-
-	for_each_possible_cpu(cpu) {
-		if (WARN_ON(cpu_to_node(cpu) == NUMA_NO_NODE)) {
-			pr_warn("workqueue: NUMA node mapping not available for cpu%d, disabling NUMA support\n", cpu);
-			return;
-		}
-	}
-
-	wq_update_pod_attrs_buf = alloc_workqueue_attrs();
-	BUG_ON(!wq_update_pod_attrs_buf);
-
-	/*
-	 * We want masks of possible CPUs of each node which isn't readily
-	 * available.  Build one from cpu_to_node() which should have been
-	 * fully initialized by now.
-	 */
-	tbl = kcalloc(nr_node_ids, sizeof(tbl[0]), GFP_KERNEL);
-	BUG_ON(!tbl);
-
-	for_each_node(node)
-		BUG_ON(!zalloc_cpumask_var_node(&tbl[node], GFP_KERNEL,
-				node_online(node) ? node : NUMA_NO_NODE));
-
-	for_each_possible_cpu(cpu) {
-		node = cpu_to_node(cpu);
-		cpumask_set_cpu(cpu, tbl[node]);
-	}
-
-	wq_pod_cpus = tbl;
-	wq_pod_enabled = true;
-}
+static void wq_pod_init(void);
 
 /**
  * workqueue_init_early - early init for workqueue subsystem
@@ -6399,6 +6362,45 @@ void __init workqueue_init(void)
 	wq_watchdog_init();
 }
 
+static void __init wq_pod_init(void)
+{
+	cpumask_var_t *tbl;
+	int node, cpu;
+
+	if (num_possible_nodes() <= 1)
+		return;
+
+	for_each_possible_cpu(cpu) {
+		if (WARN_ON(cpu_to_node(cpu) == NUMA_NO_NODE)) {
+			pr_warn("workqueue: NUMA node mapping not available for cpu%d, disabling NUMA support\n", cpu);
+			return;
+		}
+	}
+
+	wq_update_pod_attrs_buf = alloc_workqueue_attrs();
+	BUG_ON(!wq_update_pod_attrs_buf);
+
+	/*
+	 * We want masks of possible CPUs of each node which isn't readily
+	 * available.  Build one from cpu_to_node() which should have been
+	 * fully initialized by now.
+	 */
+	tbl = kcalloc(nr_node_ids, sizeof(tbl[0]), GFP_KERNEL);
+	BUG_ON(!tbl);
+
+	for_each_node(node)
+		BUG_ON(!zalloc_cpumask_var_node(&tbl[node], GFP_KERNEL,
+				node_online(node) ? node : NUMA_NO_NODE));
+
+	for_each_possible_cpu(cpu) {
+		node = cpu_to_node(cpu);
+		cpumask_set_cpu(cpu, tbl[node]);
+	}
+
+	wq_pod_cpus = tbl;
+	wq_pod_enabled = true;
+}
+
 /*
  * Despite the naming, this is a no-op function which is here only for avoiding
  * link error. Since compile-time warning may fail to catch, we will need to
-- 
2.40.1

