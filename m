Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBF267395DD
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 05:34:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbjFVDeb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 23:34:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjFVDe2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 23:34:28 -0400
Received: from mx5.didiglobal.com (mx5.didiglobal.com [111.202.70.122])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 599D41BD4
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 20:34:26 -0700 (PDT)
Received: from mail.didiglobal.com (unknown [10.79.65.12])
        by mx5.didiglobal.com (Maildata Gateway V2.8) with ESMTPS id 9A257B007D639;
        Thu, 22 Jun 2023 11:34:24 +0800 (CST)
Received: from didi-ThinkCentre-M930t-N000 (10.79.64.101) by
 ZJY02-ACTMBX-02.didichuxing.com (10.79.65.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 22 Jun 2023 11:34:24 +0800
Date:   Thu, 22 Jun 2023 11:34:09 +0800
X-MD-Sfrom: tiozhang@didiglobal.com
X-MD-SrcIP: 10.79.65.12
From:   tiozhang <tiozhang@didiglobal.com>
To:     <tj@kernel.org>
CC:     <jiangshanlai@gmail.com>, <linux-kernel@vger.kernel.org>,
        <zyhtheonly@yeah.net>, <zwp10758@gmail.com>,
        <zyhtheonly@gmail.com>, <tiozhang@didiglobal.com>
Subject: [PATCH] workqueue: add cmdline parameter `unbound_workqueue_cpus` to
 further constrain wq_unbound_cpumask at boot time
Message-ID: <20230622033353.GA29115@didi-ThinkCentre-M930t-N000>
Mail-Followup-To: tj@kernel.org, jiangshanlai@gmail.com,
        linux-kernel@vger.kernel.org, zyhtheonly@yeah.net,
        zwp10758@gmail.com, zyhtheonly@gmail.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
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
 kernel/workqueue.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 7cd5f5e7e0a1..47e7b29df5fe 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -329,6 +329,9 @@ static bool workqueue_freezing;		/* PL: have wqs started freezing? */
 /* PL: allowable cpus for unbound wqs and work items */
 static cpumask_var_t wq_unbound_cpumask;
 
+/* for further constrain wq_unbound_cpumask by cmdline parameter*/
+static cpumask_var_t wq_cmdline_cpumask;
+
 /* CPU where unbound work was last round robin scheduled from this CPU */
 static DEFINE_PER_CPU(int, wq_rr_cpu_last);
 
@@ -6006,6 +6009,10 @@ void __init workqueue_init_early(void)
 	cpumask_copy(wq_unbound_cpumask, housekeeping_cpumask(HK_TYPE_WQ));
 	cpumask_and(wq_unbound_cpumask, wq_unbound_cpumask, housekeeping_cpumask(HK_TYPE_DOMAIN));
 
+	if (!cpumask_empty(wq_cmdline_cpumask))
+		cpumask_and(wq_unbound_cpumask, wq_unbound_cpumask, wq_cmdline_cpumask);
+	free_bootmem_cpumask_var(wq_cmdline_cpumask);
+
 	pwq_cache = KMEM_CACHE(pool_workqueue, SLAB_PANIC);
 
 	/* initialize CPU pools */
@@ -6129,3 +6136,21 @@ void __init workqueue_init(void)
  */
 void __warn_flushing_systemwide_wq(void) { }
 EXPORT_SYMBOL(__warn_flushing_systemwide_wq);
+
+
+static int __init unbound_workqueue_cpus_setup(char *str)
+{
+	cpumask_var_t cpumask;
+
+	alloc_bootmem_cpumask_var(&wq_cmdline_cpumask);
+	alloc_bootmem_cpumask_var(&cpumask);
+	if (cpulist_parse(str, cpumask) < 0)
+		pr_warn("unbound_workqueue_cpus: incorrect CPU range\n");
+	else
+		cpumask_copy(wq_cmdline_cpumask, cpumask);
+
+	free_bootmem_cpumask_var(cpumask);
+
+	return 0;
+}
+__setup("unbound_workqueue_cpus=", unbound_workqueue_cpus_setup);
-- 
2.17.1

