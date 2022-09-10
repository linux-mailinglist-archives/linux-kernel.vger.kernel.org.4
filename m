Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36BE85B45F9
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Sep 2022 12:55:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229569AbiIJKzH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Sep 2022 06:55:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbiIJKzF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Sep 2022 06:55:05 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2059.outbound.protection.outlook.com [40.107.244.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B76522B30
        for <linux-kernel@vger.kernel.org>; Sat, 10 Sep 2022 03:55:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PgCIhvbxs1XKRL1sSNEczaP5nmYwPyMWrDr7tgZe7ex9chmMOrZMzekJnOCH1en8Dbt0OIbKDn+/inPpVChR3UcUvGJkncLQFfTTjRChVFTSJqiY7gFpNn6J4vMDA6VpAg0Q+GhzSjfwbEI4IzQTvWuUPmMm6LwP4M/Gs+v93CMGn34jJByme2X5lPykixz/zoX9Vj/X2SgrYdmhx+eisBLFg8kcTWdpUXP3YhRPlws38OO2zEmknPllO6e+yFEtdnXTFSySDhL8FpskEqKk5bbEBFrZt8pdkOBurDGaOgwoR4B36nFJWMUZx20TJNZHKTIk47NXEVd6pk94ZQwopg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mGwFg3aZaN8m5w++6OxvSrlMJ3pjF4/mPPFOhSsc9uE=;
 b=CWkb5iKG9mcKmre1P9tN9913JqcuHOHgHJ30nY7nP/ifh+1BYlJH6Jkc6mEKMw2AG+ZtdjMhm2HRFL1AKXUjaogC7jhASYNz3QVB0fCtbXprA2eqan9gCmJ61kpk2iBU4bHxrQBTbnR9HNxSLiESeKDXD2ZaO4O+7QYND4ntL4QOGsyfKrb2uJTaatw6VRaoL24hf7NS6vzqjgw1MUwraqP1NcThj1fwpgdknldHyMEW6S/AQIxczYy5drgPsHN/C2FVRsixHBE6hwa9s7lj5OhAW1ksHYPDIg/L7Qfag6DQU3Os6uiuV/RdnohPLc2p3CxHcbXx259ieSs5+NItzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mGwFg3aZaN8m5w++6OxvSrlMJ3pjF4/mPPFOhSsc9uE=;
 b=CfRWhaExr+z4NiEMk9WUzwPK4yoPA0IhGLEHYkTnKWLRTQv90EpPlPAWkNWvsgb+xKbxNhoeEbiTYWbc0HvRFPPo8S4qSX8NYgMKSeEYv8VJt88ik2m2gjHa7OODF8cRE9ar/yDz7DzQtay8cjSCgzYYAqzl+GKULHk3t73DuE0=
Received: from DS7PR06CA0029.namprd06.prod.outlook.com (2603:10b6:8:54::29) by
 CH0PR12MB5203.namprd12.prod.outlook.com (2603:10b6:610:ba::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5612.12; Sat, 10 Sep 2022 10:55:02 +0000
Received: from DM6NAM11FT097.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:54:cafe::d2) by DS7PR06CA0029.outlook.office365.com
 (2603:10b6:8:54::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.18 via Frontend
 Transport; Sat, 10 Sep 2022 10:55:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT097.mail.protection.outlook.com (10.13.172.72) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.13 via Frontend Transport; Sat, 10 Sep 2022 10:55:01 +0000
Received: from BLR5CG134614W.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Sat, 10 Sep
 2022 05:54:55 -0500
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
Subject: [PATCH 3/5] sched/fair: Add support for hints in the subsequent wakeup path
Date:   Sat, 10 Sep 2022 16:23:24 +0530
Message-ID: <20220910105326.1797-4-kprateek.nayak@amd.com>
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
X-MS-TrafficTypeDiagnostic: DM6NAM11FT097:EE_|CH0PR12MB5203:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d245d28-0bbd-4945-4e2b-08da931ae956
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iU+33jNXNMIpSMaqQ+Xle8+yVtSbWL2WF9bg5OtS0kceE53rpUsa7Nm2Lkp2BJWmPvNf9YEX5QDi9/Ywtc9r4IBAtWCKJEO6RtQO3gEMhEC7bZ+h/dBdts4inHpQZVwmgWNzdVb90Yldz6a56G+b1JX7Lz8hDTMG7CB9xYo3MnTE2Cmv9/vEcvF2N6CLhP8C0ASGjCTcOBFui4ofT9WxicdbL4vcNe0CWxmydgInxCFagCsKJ9JTjE1idVlGhSgU2KFpD7mIKFrEu9NA+paA+FtvkNSUWjctWhV7FvSCUP3oKzdTBcsc6ZCv5wzoavdTinZ3bzTTCVquh9TtDhK+pHf+SQDUUkBsL9CBhAEUBXwLaT5WIZ3YnrhIJrqpmtwxebkCS97G4FajakQ3yT2Vp9IE6ueXJhSqJ1AYdidzKJqMhglIBjEgT1Z4AkoAurhCh2laoYPxb7lxYQQiIF2mgV1+dFQzr2/Lx63HLKEI7GUv+GGEgoLNsW01MPa6ESUfs0TaS9QNTWLTp0In+gHdDfX4yrM75TzBWDupym5mHFcqfSyala2gIo3KZ8uJ7BZxkVWkzODNl9Kjg2g9GUgC/ChNl30psQrhwqULE7f55GyMswp6Bu5BS7dVpMt/31zCAf2D9d5bJF5XCRucF4Y1Q/2eQgS43fBX002AFdpvTz04KN8pdIDtxW4JT00bBbE1pLPPG2ab84cYv6a0QzgAc2Uf8LhEjXhDkko0uLS8MLcZhLuV9TyltkrKOTCDOqKnX+nDzGXTTRlGa3rYn36HzUJ14woQ4rqDkDx4c4Bx7QpKsZicjFMahGJeP0AEWa7R
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(136003)(376002)(396003)(346002)(39860400002)(40470700004)(36840700001)(46966006)(5660300002)(336012)(16526019)(2906002)(47076005)(426003)(36756003)(83380400001)(41300700001)(1076003)(186003)(36860700001)(8936002)(7416002)(2616005)(70586007)(7696005)(26005)(82740400003)(70206006)(82310400005)(8676002)(4326008)(6666004)(316002)(6916009)(54906003)(40480700001)(81166007)(86362001)(356005)(40460700003)(478600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2022 10:55:01.8589
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d245d28-0bbd-4945-4e2b-08da931ae956
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT097.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5203
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hints are adhered to as long as there are idle cores in the target MC
domain. Beyond that, the default behavior is followed.

- Hinting flow in the wakeup path

Following is the flow with wakeup hints:

o Check if the task has a wakeup hint set and whether the current
  CPU and the CPU where the task previously ran are on two different
  LLCs. If either is false, bail out and follow the default logic.
o Check whether the previous CPU or the current CPU is the desired
  CPU according to the set hint.
o Test for idle cores in the MC domain of the hinted CPU.
o If yes, set the desired CPU as the target for wakeup. The scheduler
  will then look for an idle CPU withing the MC domain of the target.
o If test_idle_cores returns false, follow the default wakeup path.

PR_SCHED_HINT_WAKE_AFFINE will favor an affine wakeup if the MC where
the waker is running advertises idle core. PR_SCHED_HINT_WAKE_HOLD will
bias the wakeup to MC domain where the task previously ran.

- Results

Following are results from running hackbench with only wakeup hints on a
dual socket Zen3 system in NPS1 mode:

o Hackbench

  Test:                   tip                     no-hint             wake_affine         wake_hold
   1-groups:         4.31 (0.00 pct)         4.46 (-3.48 pct)       4.20 (2.55 pct)    4.11 (4.64 pct)
   2-groups:         4.93 (0.00 pct)         4.85 (1.62 pct)        4.74 (3.85 pct)    5.15 (-4.46 pct)
   4-groups:         5.38 (0.00 pct)         5.35 (0.55 pct)        5.04 (6.31 pct)    4.54 (15.61 pct)
   8-groups:         5.59 (0.00 pct)         5.49 (1.78 pct)        5.39 (3.57 pct)    5.71 (-2.14 pct)
  16-groups:         7.18 (0.00 pct)         7.38 (-2.78 pct)       7.24 (-0.83 pct)   7.76 (-8.07 pct)

As we can observe, the hint PR_SCHED_HINT_WAKE_AFFINE helps performance
across all hackbench configurations. PR_SCHED_HINT_WAKE_HOLD does not
show any consistent behavior and can lead to unpredictable behavior in
hackbench.

- Shortcomings

In schbench, the delay to indicate that no idle core is available in
target MC domain leads to pileup and severe degradation in p99 latency

o schbench

   workers:     tip                     no-hint                 wake_affine		     wake_hold
    1:      37.00 (0.00 pct)        38.00 (-2.70 pct)        18.00 (51.35 pct)      	 32.00 (13.51 pct)
    2:      39.00 (0.00 pct)        36.00 (7.69 pct)         18.00 (53.84 pct)      	 36.00 (7.69 pct)
    4:      41.00 (0.00 pct)        41.00 (0.00 pct)         21.00 (48.78 pct)      	 33.00 (19.51 pct)
    8:      53.00 (0.00 pct)        54.00 (-1.88 pct)        31.00 (41.50 pct)      	 51.00 (3.77 pct)
   16:      73.00 (0.00 pct)        74.00 (-1.36 pct)      2636.00 (-3510.95 pct)   	 75.00 (-2.73 pct)
   32:     116.00 (0.00 pct)       124.00 (-6.89 pct)     15696.00 (-13431.03 pct)      124.00 (-6.89 pct)
   64:     217.00 (0.00 pct)       215.00 (0.92 pct)      15280.00 (-6941.47 pct)       224.00 (-3.22 pct)
  128:     477.00 (0.00 pct)       440.00 (7.75 pct)      14800.00 (-3002.72 pct)       493.00 (-3.35 pct)
  256:     1062.00 (0.00 pct)      1026.00 (3.38 pct)     15696.00 (-1377.96 pct)      1026.00 (3.38 pct)
  512:     47552.00 (0.00 pct)     47168.00 (0.80 pct)    60736.00 (-27.72 pct)       49856.00 (-4.84 pct)

Wake hold seems to still do well by reducing the larger latency samples
that we observe during task migration.

- Potential Solution

One potential solution is to atomically read nr_busy_cpus member of
sched_domain_shared struct but the performance impact of this is yet to
be evaluated in the wakeup path.

Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
 kernel/sched/fair.c | 43 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 42 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index efceb670e755..90e523cd8de8 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -51,6 +51,8 @@
 
 #include <linux/sched/cond_resched.h>
 
+#include <uapi/linux/prctl.h>
+
 #include "sched.h"
 #include "stats.h"
 #include "autogroup.h"
@@ -7031,6 +7033,10 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int wake_flags)
 	int want_affine = 0;
 	/* SD_flags and WF_flags share the first nibble */
 	int sd_flag = wake_flags & 0xF;
+	bool use_hint = false;
+	unsigned int task_hint = READ_ONCE(p->hint);
+	unsigned int wakeup_hint = task_hint &
+		(PR_SCHED_HINT_WAKE_AFFINE | PR_SCHED_HINT_WAKE_HOLD);
 
 	/*
 	 * required for stable ->cpus_allowed
@@ -7046,6 +7052,37 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int wake_flags)
 			new_cpu = prev_cpu;
 		}
 
+		/*
+		 * Handle the case where a hint is set and the current CPU
+		 * and the previous CPU where task ran don't share caches.
+		 */
+		if (wakeup_hint && !cpus_share_cache(cpu, prev_cpu)) {
+			/*
+			 * Start by assuming the hint is PR_SCHED_HINT_WAKE_AFFINE
+			 * setting the target_cpu to the current CPU.
+			 */
+			int target_cpu = cpu;
+
+			/*
+			 * If the hint is PR_SCHED_HINT_WAKE_HOLD
+			 * change target_cpu to the prev_cpu.
+			 */
+
+			if (wakeup_hint & PR_SCHED_HINT_WAKE_HOLD)
+				target_cpu = prev_cpu;
+
+			/*
+			 * If a wakeup hint is set, try to bias the
+			 * task placement towards the preferred node
+			 * as long as there is an idle core in the
+			 * targetted LLC.
+			 */
+			if (test_idle_cores(target_cpu, false)) {
+				use_hint = true;
+				new_cpu = target_cpu;
+			}
+		}
+
 		want_affine = !wake_wide(p) && cpumask_test_cpu(cpu, p->cpus_ptr);
 	}
 
@@ -7057,7 +7094,11 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int wake_flags)
 		 */
 		if (want_affine && (tmp->flags & SD_WAKE_AFFINE) &&
 		    cpumask_test_cpu(prev_cpu, sched_domain_span(tmp))) {
-			if (cpu != prev_cpu)
+			/*
+			 * In case it is optimal to follow the hints,
+			 * do not re-evaluate the target CPU.
+			 */
+			if (cpu != prev_cpu && !use_hint)
 				new_cpu = wake_affine(tmp, p, cpu, prev_cpu, sync);
 
 			sd = NULL; /* Prefer wake_affine over balance flags */
-- 
2.25.1

