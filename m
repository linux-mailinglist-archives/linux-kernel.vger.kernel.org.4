Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92A3D740FF5
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 13:19:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231691AbjF1LTF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 07:19:05 -0400
Received: from mx5.didiglobal.com ([111.202.70.122]:48772 "HELO
        mx5.didiglobal.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S230498AbjF1LSq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 07:18:46 -0400
Received: from mail.didiglobal.com (unknown [10.79.65.12])
        by mx5.didiglobal.com (Maildata Gateway V2.8) with ESMTPS id 59374B002422E;
        Wed, 28 Jun 2023 19:18:42 +0800 (CST)
Received: from didi-ThinkCentre-M930t-N000 (10.79.64.101) by
 ZJY02-ACTMBX-02.didichuxing.com (10.79.65.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 28 Jun 2023 19:18:41 +0800
Date:   Wed, 28 Jun 2023 19:18:34 +0800
X-MD-Sfrom: tiozhang@didiglobal.com
X-MD-SrcIP: 10.79.65.12
From:   tiozhang <tiozhang@didiglobal.com>
To:     <tj@kernel.org>
CC:     <rdunlap@infradead.org>, <frederic@kernel.org>,
        <jiangshanlai@gmail.com>, <linux-kernel@vger.kernel.org>,
        <zyhtheonly@gmail.com>, <zyhtheonly@yeah.net>,
        <zwp10758@gmail.com>, <tiozhang@didiglobal.com>,
        <fuyuanli@didiglobal.com>
Subject: [PATCH v4] workqueue: add cmdline parameter `workqueue.unbound_cpus`
 to further constrain wq_unbound_cpumask at boot time
Message-ID: <20230628111722.GA31661@didi-ThinkCentre-M930t-N000>
Mail-Followup-To: tj@kernel.org, rdunlap@infradead.org, frederic@kernel.org,
        jiangshanlai@gmail.com, linux-kernel@vger.kernel.org,
        zyhtheonly@gmail.com, zyhtheonly@yeah.net, zwp10758@gmail.com,
        fuyuanli@didiglobal.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZJn8bQd6EdHolayS@slm.duckdns.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [10.79.64.101]
X-ClientProxiedBy: ZJY01-PUBMBX-01.didichuxing.com (10.79.64.32) To
 ZJY02-ACTMBX-02.didichuxing.com (10.79.65.12)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Motivation of doing this is to better improve boot times for devices when
we want to prevent our workqueue works from running on some specific CPUs,
e,g, some CPUs are busy with interrupts.

Signed-off-by: tiozhang <tiozhang@didiglobal.com>
---
 .../admin-guide/kernel-parameters.txt         |  7 +++++++
 kernel/workqueue.c                            | 20 +++++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index a465d5242774..a88b133ab09b 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -6780,6 +6780,13 @@
 			disables both lockup detectors. Default is 10
 			seconds.
 
+	workqueue.unbound_cpus=
+			[KNL,SMP] Specify to constrain one or some CPUs
+			to use in unbound workqueues.
+			Format: <cpu-list>
+			By default, all online CPUs are available for
+			unbound workqueues.
+
 	workqueue.watchdog_thresh=
 			If CONFIG_WQ_WATCHDOG is configured, workqueue can
 			warn stall conditions and dump internal state to
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 7cd5f5e7e0a1..29e8254edd63 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -329,6 +329,9 @@ static bool workqueue_freezing;		/* PL: have wqs started freezing? */
 /* PL: allowable cpus for unbound wqs and work items */
 static cpumask_var_t wq_unbound_cpumask;
 
+/* for further constrain wq_unbound_cpumask by cmdline parameter*/
+static struct cpumask wq_cmdline_cpumask __initdata;
+
 /* CPU where unbound work was last round robin scheduled from this CPU */
 static DEFINE_PER_CPU(int, wq_rr_cpu_last);
 
@@ -6006,6 +6009,9 @@ void __init workqueue_init_early(void)
 	cpumask_copy(wq_unbound_cpumask, housekeeping_cpumask(HK_TYPE_WQ));
 	cpumask_and(wq_unbound_cpumask, wq_unbound_cpumask, housekeeping_cpumask(HK_TYPE_DOMAIN));
 
+	if (!cpumask_empty(&wq_cmdline_cpumask))
+		cpumask_and(wq_unbound_cpumask, wq_unbound_cpumask, &wq_cmdline_cpumask);
+
 	pwq_cache = KMEM_CACHE(pool_workqueue, SLAB_PANIC);
 
 	/* initialize CPU pools */
@@ -6129,3 +6135,17 @@ void __init workqueue_init(void)
  */
 void __warn_flushing_systemwide_wq(void) { }
 EXPORT_SYMBOL(__warn_flushing_systemwide_wq);
+
+static int __init workqueue_unbound_cpus_setup(char *str)
+{
+	int ret;
+
+	ret = cpulist_parse(str, &wq_cmdline_cpumask);
+	if (ret < 0) {
+		cpumask_clear(&wq_cmdline_cpumask);
+		pr_warn("workqueue.unbound_cpus: incorrect CPU range\n");
+	}
+
+	return ret;
+}
+__setup("workqueue.unbound_cpus=", workqueue_unbound_cpus_setup);
-- 
2.17.1

