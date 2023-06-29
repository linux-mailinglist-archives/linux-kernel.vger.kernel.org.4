Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B296A741EE6
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 05:52:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231509AbjF2DwF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 23:52:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232047AbjF2Dv0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 23:51:26 -0400
Received: from mx6.didiglobal.com (mx6.didiglobal.com [111.202.70.123])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id CC7D23A81
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 20:51:01 -0700 (PDT)
Received: from mail.didiglobal.com (unknown [10.79.65.12])
        by mx6.didiglobal.com (Maildata Gateway V2.8) with ESMTPS id 9528711002B827;
        Thu, 29 Jun 2023 11:50:58 +0800 (CST)
Received: from didi-ThinkCentre-M930t-N000 (10.79.64.101) by
 ZJY02-ACTMBX-02.didichuxing.com (10.79.65.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 29 Jun 2023 11:50:58 +0800
Date:   Thu, 29 Jun 2023 11:50:50 +0800
X-MD-Sfrom: tiozhang@didiglobal.com
X-MD-SrcIP: 10.79.65.12
From:   tiozhang <tiozhang@didiglobal.com>
To:     <tj@kernel.org>, <rdunlap@infradead.org>
CC:     <frederic@kernel.org>, <jiangshanlai@gmail.com>,
        <linux-kernel@vger.kernel.org>, <zyhtheonly@gmail.com>,
        <zyhtheonly@yeah.net>, <zwp10758@gmail.com>,
        <tiozhang@didiglobal.com>, <fuyuanli@gmail.com>
Subject: [PATCH v5] workqueue: add cmdline parameter `workqueue.unbound_cpus`
 to further constrain wq_unbound_cpumask at boot time
Message-ID: <20230629035050.GA17223@didi-ThinkCentre-M930t-N000>
Mail-Followup-To: tj@kernel.org, rdunlap@infradead.org, frederic@kernel.org,
        jiangshanlai@gmail.com, linux-kernel@vger.kernel.org,
        zyhtheonly@gmail.com, zyhtheonly@yeah.net, zwp10758@gmail.com,
        fuyuanli@gmail.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <fd34114d-d2e4-0d10-475c-61585753a639@infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [10.79.64.101]
X-ClientProxiedBy: ZJY01-PUBMBX-01.didichuxing.com (10.79.64.32) To
 ZJY02-ACTMBX-02.didichuxing.com (10.79.65.12)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Motivation of doing this is to better improve boot times for devices when
we want to prevent our workqueue works from running on some specific CPUs,
e,g, some CPUs are busy with interrupts.

Signed-off-by: tiozhang <tiozhang@didiglobal.com>
---
 Documentation/admin-guide/kernel-parameters.txt |  7 +++++++
 kernel/workqueue.c                              | 17 +++++++++++++++++
 2 files changed, 24 insertions(+)

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
index 7cd5f5e7e0a1..70145031acdb 100644
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
@@ -6129,3 +6135,14 @@ void __init workqueue_init(void)
  */
 void __warn_flushing_systemwide_wq(void) { }
 EXPORT_SYMBOL(__warn_flushing_systemwide_wq);
+
+static int __init workqueue_unbound_cpus_setup(char *str)
+{
+	if (cpulist_parse(str, &wq_cmdline_cpumask) < 0) {
+		cpumask_clear(&wq_cmdline_cpumask);
+		pr_warn("workqueue.unbound_cpus: incorrect CPU range, using default\n");
+	}
+
+	return 1;
+}
+__setup("workqueue.unbound_cpus=", workqueue_unbound_cpus_setup);
-- 
2.17.1

