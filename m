Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 516845B45FB
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Sep 2022 12:56:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbiIJK4B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Sep 2022 06:56:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbiIJKz5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Sep 2022 06:55:57 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2081.outbound.protection.outlook.com [40.107.223.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F101B40BDC
        for <linux-kernel@vger.kernel.org>; Sat, 10 Sep 2022 03:55:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ILXKVo7RiSXbR3IdLGgufI/fYyXqMPljbkroQwqha7hEcpprkR8Tl/Ur7/lpAZvbsYsLBevMZGh+bDYCmZAOQXalB48vyC0wT34B0UXR0fS7i2MLAn5nZo0CVy0K0IqqRHWPH5mNwgyujJKTQ/1F46V/j1Ytz+OIwimP+6jGv8ZMKL1UyCEY2rV6/zTUpdBOjYtuMiXD09BFybx4PXs2eGLWriENq87JBCbdcGC+coY4tJiDayAMiuG3fuqTEWaIZDQEm0lWU+nzNI144fe3Ic5zo818vU4+5+jOLXKAZhnx7a157VBKqpiRqz4LsPFk7COpZdcqHqaY00yq0RPj3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JH2TqdR7mrw9mV8XHYulf55CwYSKeriybmUS4AdUcPc=;
 b=AnX5o2+xxtFUC2NS3JOpIfmQyySqYOlZADE0jUhIiLGxsdLj+6dn1/13+pWb3h3pQs0akQTxy474P4AUvJTmyvYGk9oP3ph1ZPMA9IwZn4IguykCDpl2BTjtmYEayV31jCtDJ1NVX7auoXk5sbyXfzhY0cK7wBMNym4tMWYhCuc2Odw+1kRS5NOBKM+KZl4msDC6gUYyQ3XlJNoZLQhjrbph5w7vTGysSip9AWpwyMzz30mFtvxbp50Nr+XHIMB1aB+6voS5aPL5JBjdz4MmmqoYkj07LErq8e39kXXVJ4v2XM1KpTnKCKGkGbdLZJNSyYJ5v4Rn4UKhROWqY4wpow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JH2TqdR7mrw9mV8XHYulf55CwYSKeriybmUS4AdUcPc=;
 b=t5NI9AE6DKfqOi6bOOs61JkL3ArvzBImKiPcGaaLarpox9K/mqcKYZKp8p7J7orO4CaQlAO44hCqQHJ/RQHlcbRiEdDf3TQ6D6uESLUDDPU9d9NHsgf5m7t6uPEbe02GSNE3WGNsp5UephszbkAk7ad98ZB5gUAGAbr37l19v50=
Received: from DM5PR06CA0090.namprd06.prod.outlook.com (2603:10b6:3:4::28) by
 IA1PR12MB6436.namprd12.prod.outlook.com (2603:10b6:208:3ac::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.17; Sat, 10 Sep
 2022 10:55:53 +0000
Received: from DM6NAM11FT098.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:4:cafe::81) by DM5PR06CA0090.outlook.office365.com
 (2603:10b6:3:4::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.12 via Frontend
 Transport; Sat, 10 Sep 2022 10:55:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT098.mail.protection.outlook.com (10.13.173.61) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.13 via Frontend Transport; Sat, 10 Sep 2022 10:55:53 +0000
Received: from BLR5CG134614W.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Sat, 10 Sep
 2022 05:55:46 -0500
From:   K Prateek Nayak <kprateek.nayak@amd.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <aubrey.li@linux.intel.com>, <efault@gmx.de>,
        <gautham.shenoy@amd.com>, <libo.chen@oracle.com>,
        <mgorman@techsingularity.net>, <mingo@kernel.org>,
        <peterz@infradead.org>, <song.bao.hua@hisilicon.com>,
        <srikar@linux.vnet.ibm.com>, <tglx@linutronix.de>,
        <valentin.schneider@arm.com>, <vincent.guittot@linaro.org>,
        <wuyun.abel@bytedance.com>, <wyes.karny@amd.com>,
        <yu.c.chen@intel.com>, <yangyicong@huawei.com>
Subject: [PATCH 5/5] sched/fair: Add exception for hints in load balancing path
Date:   Sat, 10 Sep 2022 16:23:26 +0530
Message-ID: <20220910105326.1797-6-kprateek.nayak@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220910105326.1797-1-kprateek.nayak@amd.com>
References: <20220910105326.1797-1-kprateek.nayak@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT098:EE_|IA1PR12MB6436:EE_
X-MS-Office365-Filtering-Correlation-Id: d159c172-ed10-4567-afd6-08da931b07d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NtWIXWxTSGuBPKmWir0YRMcr0XlQ33KD+CY037p5F9/ai4IJWJTegTwH0GiBLy2Wb995yjZqZ2Cy9stQVOT24jj3Dz+/5rX1XuIAfmvQBmSuodSEoHryFQQm7xabm141N4Hk+IwhXo08bFQz0mZlH1896NBvnwNagdK8hR6BSZcQudiFf3OGPZioqeFDaPvACVkEWva+ebQINcyPzNFWCIbvlI8y0l1vt4HckIJwy7qkyCgwZ9iLwQ2nKLXauIb4sNAFXO6sgQkkGp8ekzNBaz9ZOkOlmsn8gXmN4tDqlw8s/bo2H1MTVYtsFQib55CYfqZbtGmQHRtHiwQPgvJkpEOajPvELYM6iHKKi5aFM0UKMJ7kGZRXmvXafyN5TR+1LSOxnpu9uVFP1IBsFogd7s2dMX2qYU+Zn0pIhckZZspZrEDC6Ywt6FsaC7Bp+X64KTU6/C5yBcPWfk6DeanrINdTm2lowob8yfe5mOT8qQ593hfNPTmBMAzeWopyas4c5bPrbfkHIAMXNJFnsfC5nU4wjBLHNDbqigpELfjtYd/cXkvrec/NEsZQaKRWk3cKPcUEsszpBO3caeJepFWgKdlOuJQLR8e7TF2uffJzi/BrjOxxoyctw06R9M/kFm50JQ/S2+bpqZ51LSIi3ka6LZpU4urTd7s6E3/hQx7wMO7Z4EZV5lz7fUJTxdpRmtICEqbPqLPrtb8qnZCnlK6muTTMpHY16h/7D6oEItDGc0IyFry+f35FEEGoTxoRfr09x7HyRULgXEMJtW8oren/QYT+XVutXBKrZ0o9bh3ATy3MrcRLGjt/HSq40FFC1qhe
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(346002)(396003)(136003)(376002)(39860400002)(46966006)(36840700001)(40470700004)(36860700001)(41300700001)(7696005)(81166007)(83380400001)(86362001)(2616005)(4326008)(40480700001)(70586007)(70206006)(8676002)(26005)(478600001)(1076003)(356005)(8936002)(2906002)(7416002)(5660300002)(6666004)(54906003)(40460700003)(426003)(316002)(82310400005)(47076005)(82740400003)(6916009)(36756003)(186003)(336012)(16526019)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2022 10:55:53.0384
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d159c172-ed10-4567-afd6-08da931b07d7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT098.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6436
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- Load balancing considerations

If we have more tasks than the CPUs in the MC Domain, ignore the hint
set by the user. This prevents losing the consolidation done at the
wakeup time.

- Considerations

Few trial and errors were done to find a good threshold to ignore hints.
Following are some of the wins and woes:

o Ignore hint if MC domain of src CPU does not have an idle core: This
  metric is not very accurate and led to losing consolidation early on.
o Ignore hint if sd_shared->nr_llc_scan is 0: This too, like the
  has_idle core metric was not always accurate.
o An atomic read of sd_shared->nr_busy_cpus doesn't encapsulate
  overloaded run queues.

Best results were found by scanning LLC and finding the number of
running tasks and comparing it with size of LLC. If the LLC is beyond
fully loaded, safely ignore hint.

- Possible Improvements

o Consider the status of hint: If a wake affine hint was ignored in
  the wakeup path, consider ignoring in the load balancer path as well
  as the running LLC is not the desired LLC in fact.

Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
 kernel/sched/fair.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 4c61bd0e93b3..8e1679b784fb 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7810,6 +7810,9 @@ struct lb_env {
 	unsigned int		loop_break;
 	unsigned int		loop_max;
 
+	/* Indicator to ignore hint if LLC is overloaded */
+	int			ignore_hint;
+
 	enum fbq_type		fbq_type;
 	enum migration_type	migration_type;
 	struct list_head	tasks;
@@ -7977,6 +7980,21 @@ int can_migrate_task(struct task_struct *p, struct lb_env *env)
 		return 0;
 	}
 
+	/*
+	 * Hints are followed only if the MC Domain is still ideal
+	 * for the task.
+	 */
+	if (!env->ignore_hint) {
+		/*
+		 * Only consider the hints from the wakeup path to maintain
+		 * data locality.
+		 */
+		if (READ_ONCE(p->hint) &
+		    (PR_SCHED_HINT_WAKE_AFFINE | PR_SCHED_HINT_WAKE_HOLD))
+			return 0;
+	}
+
+
 	/* Record that we found at least one task that could run on dst_cpu */
 	env->flags &= ~LBF_ALL_PINNED;
 
@@ -10182,6 +10200,7 @@ static int load_balance(int this_cpu, struct rq *this_rq,
 		.cpus		= cpus,
 		.fbq_type	= all,
 		.tasks		= LIST_HEAD_INIT(env.tasks),
+		.ignore_hint	= 1,
 	};
 
 	cpumask_and(cpus, sched_domain_span(sd), cpu_active_mask);
@@ -10213,6 +10232,30 @@ static int load_balance(int this_cpu, struct rq *this_rq,
 	env.src_cpu = busiest->cpu;
 	env.src_rq = busiest;
 
+	/*
+	 * Check if the hints can be followed during
+	 * this load balancing cycle.
+	 */
+	if (!(sd->flags & SD_SHARE_PKG_RESOURCES)) {
+		struct sched_domain *src_sd_llc = rcu_dereference(per_cpu(sd_llc, env.src_cpu));
+
+		if (src_sd_llc) {
+			int cpu, nr_llc_running = 0, llc_size = per_cpu(sd_llc_size, env.src_cpu);
+
+			for_each_cpu_wrap(cpu, sched_domain_span(src_sd_llc), env.src_cpu) {
+				struct rq *rq = cpu_rq(cpu);
+				nr_llc_running += rq->nr_running - rq->cfs.idle_h_nr_running;
+			}
+
+			/*
+			 * Don't ignore hint if we can have one task
+			 * per CPU in the LLC of the src_cpu.
+			 */
+			if (nr_llc_running <= llc_size)
+				env.ignore_hint = 0;
+		}
+	}
+
 	ld_moved = 0;
 	/* Clear this flag as soon as we find a pullable task */
 	env.flags |= LBF_ALL_PINNED;
@@ -10520,6 +10563,7 @@ static int active_load_balance_cpu_stop(void *data)
 			.src_rq		= busiest_rq,
 			.idle		= CPU_IDLE,
 			.flags		= LBF_ACTIVE_LB,
+			.ignore_hint	= sd->flags & SD_SHARE_PKG_RESOURCES,
 		};
 
 		schedstat_inc(sd->alb_count);
-- 
2.25.1

