Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87D0D68E91F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 08:37:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231220AbjBHHhZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 02:37:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbjBHHhJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 02:37:09 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BBDBDBE8
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 23:36:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bZd/jWjDorDrpLnBdh6JKxIin6tcG6TfVfGReEiHSKV9rIB12xtNFy+RXD6UZitFTkVsul72R2Z5Pk/rxfgwWr9r58tv8+SKJrSEVL6dht4ySwefRieIP+xw5UwBVAUbOa6WDdAY+KKPs3V/oxryHOTFNY2tNxy0fd4EOcGCyR00vDdnIUW8lCKVdsNMp4ORuvr3lwngI/vuWT4YIYASSjrBqFn6X/7pK6aqpQ1M5Gi/70XIOCs+iSxeBVV7VwZJta1LbwXJu0Mp95NxiPsGyL/PgrvjkMyDL1JSGIf2/RupGgKQybulzjFxvEc5cYMdojmuXacbPckXvfbfP5fRxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FZkhBw3sxi8I3UCl/z/e/2WFGv+lgV25p4wF9bJi1T0=;
 b=GXbjyIwTjlq0BbxO/Ratyi0hFgdXRVN4qSRcwHpmr/gXRV4u/71ef0/PDj73gDZrCznqf08Dq9eUF2yBlUSC2zNV+VSwZKfu4cpYKiDYb6uin/gM6p/XUg0yDpAx5vvoLNN0GycbXT31KMopgc4wV99B8mt4VOpcDU5Yr/AM9QrDp6K4RmR8ogt3xnSyLUh/IZ549O9o4w/14V/793fcGqYBrkIwMCORLdMYn1WibVpORZgvG+CSnEIwyWXp94Ts2AsiQ/5+2JWhFzEhygi4n/6JVseEgHlCNI30Bl7k7/d4Sr/x2UwceEbTWRt5ALxX/5UxvaRYU9SYSUuMSwJgmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FZkhBw3sxi8I3UCl/z/e/2WFGv+lgV25p4wF9bJi1T0=;
 b=SixPSUxfPmOApGwqC7n05HkJvW0mkfJSZSYwJUJuo8RPkrxj4skVqLegGnvbITNK2SJMVPy3kX/6VyjjLmS+U3OqzjaN2/rdIeGKsfyKsPDMLVtovOVs+6jc6CfkMT+ew7O/86kqZTMfXpAv8DTrnkL+FDjEvNGucJtfcZ1Ih84=
Received: from BN8PR03CA0019.namprd03.prod.outlook.com (2603:10b6:408:94::32)
 by IA1PR12MB6436.namprd12.prod.outlook.com (2603:10b6:208:3ac::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.36; Wed, 8 Feb
 2023 07:36:47 +0000
Received: from BN8NAM11FT010.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:94:cafe::9b) by BN8PR03CA0019.outlook.office365.com
 (2603:10b6:408:94::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.17 via Frontend
 Transport; Wed, 8 Feb 2023 07:36:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT010.mail.protection.outlook.com (10.13.177.53) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6086.17 via Frontend Transport; Wed, 8 Feb 2023 07:36:47 +0000
Received: from BLR-5CG1133937.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 8 Feb
 2023 01:36:42 -0600
From:   Bharata B Rao <bharata@amd.com>
To:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
CC:     <mgorman@suse.de>, <peterz@infradead.org>, <mingo@redhat.com>,
        <bp@alien8.de>, <dave.hansen@linux.intel.com>, <x86@kernel.org>,
        <akpm@linux-foundation.org>, <luto@kernel.org>,
        <tglx@linutronix.de>, <yue.li@memverge.com>,
        <Ravikumar.Bangoria@amd.com>, Bharata B Rao <bharata@amd.com>
Subject: [RFC PATCH 4/5] x86/ibs: Adjust access faults sampling period
Date:   Wed, 8 Feb 2023 13:05:32 +0530
Message-ID: <20230208073533.715-5-bharata@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230208073533.715-1-bharata@amd.com>
References: <20230208073533.715-1-bharata@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT010:EE_|IA1PR12MB6436:EE_
X-MS-Office365-Filtering-Correlation-Id: f197b081-34c5-4bd7-5c6c-08db09a73bee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5ZY0fx/a8fXolnZRTIy4EFetIVVHpE8cOyBznCmmF25UGJHGGieYsOWYR+olbrwdOHS3HQ4YHlo81TU71tdH4gr650yD455tqTSOj1T0SOfJRt2DD7VEUpGm/Vy/vhAc49VEkBCP4DWWnAR8/mzjAbWhqZ912aeIvaYfn05HRpQyqe6LYI01UXgS6VGzVqthvT8jR6vJ1r9jBF1M7uUySCF4OZ8Ka59ZKAG+lSiZ4LZtLAsMKq5FS4hlu0ZJTZZ/jy6Dnyc6ZNnnz9hz5GMkoh+DCygTJc1etRIyIYgWUn9QZ0hli2ho6QAnHhfkjC7duMlNXz0H7GdN/PRmL6CliSw9v4rL/pUsQaTgU5FVyIY5lLV+7cMc0hNN477ySNG8kyJIwVglaSakk8UDh/XwQMbffNtaKb+2D7EWE0dxtfmdWFpgchcS4cEblG2yUrVxQkbNfHbB9RF/HlxM1Oy3lXXNW9FqoLpLU1mzuwRGRBJRky0d9toI0cZoj/rbV/T0HB86+/O4S0U7hVNV4BvE7xtwfGn33V/mcvaSfiDo15jPug2v3ZODPJLvCikSv2U/CdCPDS70iGhAQ5283OsAjd5MTQGPqJGZYQLnvcPavDwW21OJ5qhTdF6xH5O8Cm1S8XPi2kgjKiy3BSzvFHqJoRKn/bDQW4Va8ChB+0X7c3eN8FDuxM7dISfEcP7fNvEEZ7LXz6CiWucP3NWwlnDeqjRvOhzAqsqYCiu44y6/k8Dwbtfi+MTufl9OH6aPDBAk
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(346002)(396003)(39860400002)(136003)(376002)(451199018)(46966006)(40470700004)(36840700001)(54906003)(186003)(26005)(82310400005)(86362001)(110136005)(40480700001)(426003)(47076005)(36756003)(7696005)(8676002)(40460700003)(16526019)(2906002)(5660300002)(70586007)(7416002)(36860700001)(8936002)(70206006)(41300700001)(4326008)(478600001)(336012)(2616005)(6666004)(1076003)(82740400003)(356005)(316002)(83380400001)(81166007)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2023 07:36:47.2253
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f197b081-34c5-4bd7-5c6c-08db09a73bee
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT010.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6436
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adjust the access faults sampling period of a thread to be within
the fixed mininum and maximum value. The adjustment logic uses the
private/shared and local/remote access faults stats. The algorithm
is same as the logic followed to adjust the scan period.

Unlike hinting faults, the min and max sampling period aren't
adjusted (yet) for access based sampling.

Signed-off-by: Bharata B Rao <bharata@amd.com>
---
 include/linux/sched.h |   2 +
 kernel/sched/debug.c  |   8 +++
 kernel/sched/fair.c   | 130 +++++++++++++++++++++++++++++++++++++-----
 kernel/sched/sched.h  |   4 ++
 4 files changed, 130 insertions(+), 14 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 66c532418d38..101c6377abbc 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1257,6 +1257,8 @@ struct task_struct {
 	unsigned int			numa_sample_period;
 	int				numa_preferred_nid;
 	unsigned long			numa_migrate_retry;
+	unsigned int			numa_access_faults;
+	unsigned int			numa_access_faults_window;
 	/* Migration stamp: */
 	u64				node_stamp;
 	u64				last_task_numa_placement;
diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 1637b65ba07a..1cf19778a232 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -334,6 +334,14 @@ static __init int sched_init_debug(void)
 	debugfs_create_u32("scan_period_max_ms", 0644, numa, &sysctl_numa_balancing_scan_period_max);
 	debugfs_create_u32("scan_size_mb", 0644, numa, &sysctl_numa_balancing_scan_size);
 	debugfs_create_u32("hot_threshold_ms", 0644, numa, &sysctl_numa_balancing_hot_threshold);
+	debugfs_create_u32("sample_period_def", 0644, numa,
+			   &sysctl_numa_balancing_sample_period_def);
+	debugfs_create_u32("sample_period_min", 0644, numa,
+			   &sysctl_numa_balancing_sample_period_min);
+	debugfs_create_u32("sample_period_max", 0644, numa,
+			   &sysctl_numa_balancing_sample_period_max);
+	debugfs_create_u32("access_faults_threshold", 0644, numa,
+			   &sysctl_numa_balancing_access_faults_threshold);
 #endif
 
 	debugfs_create_file("debug", 0444, debugfs_sched, NULL, &sched_debug_fops);
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 3f617c799821..1b0665b034d0 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1093,6 +1093,11 @@ adjust_numa_imbalance(int imbalance, int dst_running, int imb_numa_nr)
 #endif /* CONFIG_NUMA */
 
 #ifdef CONFIG_NUMA_BALANCING
+unsigned int sysctl_numa_balancing_sample_period_def = 10000;
+unsigned int sysctl_numa_balancing_sample_period_min = 5000;
+unsigned int sysctl_numa_balancing_sample_period_max = 20000;
+unsigned int sysctl_numa_balancing_access_faults_threshold = 250;
+
 /*
  * Approximate time to scan a full NUMA task in ms. The task scan period is
  * calculated based on the tasks virtual memory size and
@@ -1572,6 +1577,7 @@ bool should_numa_migrate_memory(struct task_struct *p, struct page * page,
 	struct numa_group *ng = deref_curr_numa_group(p);
 	int dst_nid = cpu_to_node(dst_cpu);
 	int last_cpupid, this_cpupid;
+	bool early = false;
 
 	/*
 	 * The pages in slow memory node should be migrated according
@@ -1611,13 +1617,21 @@ bool should_numa_migrate_memory(struct task_struct *p, struct page * page,
 	    !node_is_toptier(src_nid) && !cpupid_valid(last_cpupid))
 		return false;
 
+	if (static_branch_unlikely(&hw_access_hints)) {
+		if (p->numa_access_faults < sysctl_numa_balancing_access_faults_threshold * 4)
+			early = true;
+	} else {
+		if (p->numa_scan_seq <= 4)
+			early = true;
+	}
+
 	/*
 	 * Allow first faults or private faults to migrate immediately early in
 	 * the lifetime of a task. The magic number 4 is based on waiting for
 	 * two full passes of the "multi-stage node selection" test that is
 	 * executed below.
 	 */
-	if ((p->numa_preferred_nid == NUMA_NO_NODE || p->numa_scan_seq <= 4) &&
+	if ((p->numa_preferred_nid == NUMA_NO_NODE || early) &&
 	    (cpupid_pid_unset(last_cpupid) || cpupid_match_pid(p, last_cpupid)))
 		return true;
 
@@ -2305,7 +2319,11 @@ static void numa_migrate_preferred(struct task_struct *p)
 		return;
 
 	/* Periodically retry migrating the task to the preferred node */
-	interval = min(interval, msecs_to_jiffies(p->numa_scan_period) / 16);
+	if (static_branch_unlikely(&hw_access_hints))
+		interval = min(interval, msecs_to_jiffies(p->numa_sample_period) / 16);
+	else
+		interval = min(interval, msecs_to_jiffies(p->numa_scan_period) / 16);
+
 	p->numa_migrate_retry = jiffies + interval;
 
 	/* Success if task is already running on preferred CPU */
@@ -2430,6 +2448,77 @@ static void update_task_scan_period(struct task_struct *p,
 	memset(p->numa_faults_locality, 0, sizeof(p->numa_faults_locality));
 }
 
+static void update_task_sample_period(struct task_struct *p,
+			unsigned long shared, unsigned long private)
+{
+	unsigned int period_slot;
+	int lr_ratio, ps_ratio;
+	int diff;
+
+	unsigned long remote = p->numa_faults_locality[0];
+	unsigned long local = p->numa_faults_locality[1];
+
+	/*
+	 * If there were no access faults then either the task is
+	 * completely idle or all activity is in areas that are not of interest
+	 * to automatic numa balancing. Related to that, if there were failed
+	 * migration then it implies we are migrating too quickly or the local
+	 * node is overloaded. In either case, increase the sampling rate.
+	 */
+	if (local + shared == 0 || p->numa_faults_locality[2]) {
+		p->numa_sample_period = min(sysctl_numa_balancing_sample_period_max,
+		p->numa_sample_period << 1);
+		return;
+	}
+
+	/*
+	 * Prepare to scale scan period relative to the current period.
+	 *	 == NUMA_PERIOD_THRESHOLD sample period stays the same
+	 *       <  NUMA_PERIOD_THRESHOLD sample period decreases
+	 *	 >= NUMA_PERIOD_THRESHOLD sample period increases
+	 */
+	period_slot = DIV_ROUND_UP(p->numa_sample_period, NUMA_PERIOD_SLOTS);
+	lr_ratio = (local * NUMA_PERIOD_SLOTS) / (local + remote);
+	ps_ratio = (private * NUMA_PERIOD_SLOTS) / (private + shared);
+
+	if (ps_ratio >= NUMA_PERIOD_THRESHOLD) {
+		/*
+		 * Most memory accesses are local. There is no need to
+		 * do fast access sampling, since memory is already local.
+		 */
+		int slot = ps_ratio - NUMA_PERIOD_THRESHOLD;
+
+		if (!slot)
+			slot = 1;
+		diff = slot * period_slot;
+	} else if (lr_ratio >= NUMA_PERIOD_THRESHOLD) {
+		/*
+		 * Most memory accesses are shared with other tasks.
+		 * There is no point in continuing fast access sampling,
+		 * since other tasks may just move the memory elsewhere.
+		 */
+		int slot = lr_ratio - NUMA_PERIOD_THRESHOLD;
+
+		if (!slot)
+			slot = 1;
+		diff = slot * period_slot;
+	} else {
+		/*
+		 * Private memory faults exceed (SLOTS-THRESHOLD)/SLOTS,
+		 * yet they are not on the local NUMA node. Speed up
+		 * access sampling to get the memory moved over.
+		 */
+		int ratio = max(lr_ratio, ps_ratio);
+
+		diff = -(NUMA_PERIOD_THRESHOLD - ratio) * period_slot;
+	}
+
+	p->numa_sample_period = clamp(p->numa_sample_period + diff,
+				      sysctl_numa_balancing_sample_period_min,
+				      sysctl_numa_balancing_sample_period_max);
+	memset(p->numa_faults_locality, 0, sizeof(p->numa_faults_locality));
+}
+
 /*
  * Get the fraction of time the task has been running since the last
  * NUMA placement cycle. The scheduler keeps similar statistics, but
@@ -2560,16 +2649,24 @@ static void task_numa_placement(struct task_struct *p)
 	spinlock_t *group_lock = NULL;
 	struct numa_group *ng;
 
-	/*
-	 * The p->mm->numa_scan_seq field gets updated without
-	 * exclusive access. Use READ_ONCE() here to ensure
-	 * that the field is read in a single access:
-	 */
-	seq = READ_ONCE(p->mm->numa_scan_seq);
-	if (p->numa_scan_seq == seq)
-		return;
-	p->numa_scan_seq = seq;
-	p->numa_scan_period_max = task_scan_max(p);
+	if (static_branch_unlikely(&hw_access_hints)) {
+		p->numa_access_faults_window++;
+		p->numa_access_faults++;
+		if (p->numa_access_faults_window < sysctl_numa_balancing_access_faults_threshold)
+			return;
+		p->numa_access_faults_window = 0;
+	} else {
+		/*
+		 * The p->mm->numa_scan_seq field gets updated without
+		 * exclusive access. Use READ_ONCE() here to ensure
+		 * that the field is read in a single access:
+		 */
+		seq = READ_ONCE(p->mm->numa_scan_seq);
+		if (p->numa_scan_seq == seq)
+			return;
+		p->numa_scan_seq = seq;
+		p->numa_scan_period_max = task_scan_max(p);
+	}
 
 	total_faults = p->numa_faults_locality[0] +
 		       p->numa_faults_locality[1];
@@ -2672,7 +2769,10 @@ static void task_numa_placement(struct task_struct *p)
 			sched_setnuma(p, max_nid);
 	}
 
-	update_task_scan_period(p, fault_types[0], fault_types[1]);
+	if (static_branch_unlikely(&hw_access_hints))
+		update_task_sample_period(p, fault_types[0], fault_types[1]);
+	else
+		update_task_scan_period(p, fault_types[0], fault_types[1]);
 }
 
 static inline int get_numa_group(struct numa_group *grp)
@@ -3094,7 +3194,9 @@ void init_numa_balancing(unsigned long clone_flags, struct task_struct *p)
 	p->node_stamp			= 0;
 	p->numa_scan_seq		= mm ? mm->numa_scan_seq : 0;
 	p->numa_scan_period		= sysctl_numa_balancing_scan_delay;
-	p->numa_sample_period		= 0;
+	p->numa_sample_period		= sysctl_numa_balancing_sample_period_def;
+	p->numa_access_faults           = 0;
+	p->numa_access_faults_window    = 0;
 	p->numa_migrate_retry		= 0;
 	/* Protect against double add, see task_tick_numa and task_numa_work */
 	p->numa_work.next		= &p->numa_work;
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 953d16c802d6..0367dc727cc4 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2473,6 +2473,10 @@ extern unsigned int sysctl_numa_balancing_scan_period_min;
 extern unsigned int sysctl_numa_balancing_scan_period_max;
 extern unsigned int sysctl_numa_balancing_scan_size;
 extern unsigned int sysctl_numa_balancing_hot_threshold;
+extern unsigned int sysctl_numa_balancing_sample_period_def;
+extern unsigned int sysctl_numa_balancing_sample_period_min;
+extern unsigned int sysctl_numa_balancing_sample_period_max;
+extern unsigned int sysctl_numa_balancing_access_faults_threshold;
 #endif
 
 #ifdef CONFIG_SCHED_HRTICK
-- 
2.25.1

