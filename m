Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BD785B45F5
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Sep 2022 12:54:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbiIJKxz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Sep 2022 06:53:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbiIJKxx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Sep 2022 06:53:53 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2089.outbound.protection.outlook.com [40.107.101.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 114F67549D
        for <linux-kernel@vger.kernel.org>; Sat, 10 Sep 2022 03:53:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m2Qr43MHn60Byf9JeZErMIY6BzJp4L6RUb0EW4Ank63COxYQJiGLlj8o4/BnFOI3lCBfIF0nqHXX4539exxC//yROOm0cs/c8xOSaADsgc3wB1sLkjX0zoKOUad8rPVVIql7aMuWpi3ArI9YRcgNEyIyKuIKl3Y3V1s5VHpHwAFKHpAAY01h5IGGd9Qc28CUvgVjcFQNP3UfD1LCOXcZGDgjJVk/Z1lNmSIFVzYGGTHD1JFAM9fF4OEMMA2HVv9U+yytL+Z8IKQXO6xuS4xwja0ARKVvtlx2mbJDnWDE0kj/LaXoh+WukpoisHv8NkG+NqUapit+LtYNiCgZnm87Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/GhwUJMEGW3N43+xSTWMogKsy0ydFMMvwXSWl7ylyv8=;
 b=FQE7DWx+uDpGnvcUXKTOf0iR5eQg1j/OL+PEHMYZUB8VTMcWgL/K4ka4MYGcMJLHHajLn+FYOb5blXmNHmwkMFJe78k7yICk5g9XpGEm//7KVekzdc17Xx8a3F81d3XxiUyKDg4C3KedQhteyr+JGoIK/8iZ9Zi2qsX+3EI++hxAOzG3tjkhX8Q1VZobZna/MyJWRoxGBI+IJu4eV5AMl1R+nx+ecet/5wmXY5OQ+qvA61m9+o7prd+n64oZXKnFvElzlIW3UvrXLfnrADm1Fg8oHsSTPiexLe5rKXwfmvCCJww0nqFnlgrYYlFNo3+WSKuhDAQjnnqZ0atv8nxySQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/GhwUJMEGW3N43+xSTWMogKsy0ydFMMvwXSWl7ylyv8=;
 b=h+HwhWE6JaB1w1g45EWLzek2rCBeDG0qcXs3fY8tP8BguJXDonXF5NjCNF+ab2Vwb6lNr6tQufR5mI/Gb3LJuu03MMfqbWMB8i18mDHo4nUk3dioP6rdDtkZsNXM8SsIQ1bV5Ipb7+MxGQedOSkHIXiYnEg0s0AXoq/VMAcvmy0=
Received: from DS7PR07CA0016.namprd07.prod.outlook.com (2603:10b6:5:3af::18)
 by CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.18; Sat, 10 Sep
 2022 10:53:46 +0000
Received: from DM6NAM11FT104.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3af:cafe::b6) by DS7PR07CA0016.outlook.office365.com
 (2603:10b6:5:3af::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.12 via Frontend
 Transport; Sat, 10 Sep 2022 10:53:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT104.mail.protection.outlook.com (10.13.173.232) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.13 via Frontend Transport; Sat, 10 Sep 2022 10:53:46 +0000
Received: from BLR5CG134614W.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Sat, 10 Sep
 2022 05:53:39 -0500
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
Subject: [RFC PATCH 0/5] sched: Userspace Hinting for Task Placement
Date:   Sat, 10 Sep 2022 16:23:21 +0530
Message-ID: <20220910105326.1797-1-kprateek.nayak@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT104:EE_|CY5PR12MB6405:EE_
X-MS-Office365-Filtering-Correlation-Id: 91352f8a-4cd0-4ebc-2811-08da931abc89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B/ucg0BzP7cG8669SAy+1nq5GQXrN3MWWDbCh+eupHUnQmC8XyqkRyYGiWCIuUAdoPuRV4WFPt0XKTJcviQ4dIy9mjJsGe6IUWaJGvOPGzvCU/eEthad2OD0jOZ8NYmNEPCnWTnV8QrpzFG0J4cPOmdA83HfCxp7T45DWlsztUKcm7Um3RYC+0hErNK1SBiMcn2OiXl4dmTw9NpdZWbBeVSbS6ms9wigctzRQFmb8pFlznZeLvJ+1fE/t7ie28vqp2KV1pG0/NJyQJFcsi1HBtNugo5kenHhF9Ygz0hqkxjEPpntChigCb+Ztu5y298RnNMkOXg0LyCC/ET0XOeuGSExGJjGxy9imDGuIco11OF7WPivKsfkVyrcLTPZOH49KffFU6fdyrEDfWlxouahL9qsNv1KCo0rCk/T1GbM5g028rTHJK51ixa723ZgI4uf3B+6ePgN0LmoEVvAOaAg5sTKD/e/sg8yS9ZOckgIZBVzVP5xxgpIlvDEPQwThvzwT5ku4uWJSd9SHHIgC4jZHgZIWyKcJeV/JvZQOubhNLDZ8pSU0uGPldWrEsXPchRhKQ/E61SP9iE3KTTc4rNRq6FDTX5rR7CKBtAUuFj+F1iovkZqPBNaGlfyItcdRLl/uQEbhhl+fM+5EqXJNpVJWCwwjb0t0d2PgnUWiBPDRPnZ53yj8Ifz6ndjCXIxNHYTURacQNUDcmR37tQTSZrv3PouG5We/JmqASjZUG1GJz4TxkNlRB8Pv5zsqouGWL4lX12EU3vkkZ5dvZdwvRaQdxXNwOijEZxVpAhFH8YlWeCIZX6hsX1uzPNEzyMCtXk+owkMuTtb49wvdXK3cJ66DyJjI60JpQfhHbyI4JPzetVZEWojqg8brvu3HtPyAlhr
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(396003)(376002)(136003)(346002)(36840700001)(46966006)(40470700004)(40460700003)(36860700001)(54906003)(2906002)(82310400005)(86362001)(70206006)(316002)(6916009)(82740400003)(8936002)(40480700001)(81166007)(30864003)(356005)(70586007)(7416002)(4326008)(6666004)(8676002)(36756003)(2616005)(426003)(83380400001)(5660300002)(47076005)(336012)(1076003)(186003)(16526019)(7696005)(41300700001)(478600001)(26005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2022 10:53:46.6947
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 91352f8a-4cd0-4ebc-2811-08da931abc89
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT104.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6405
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series implements one possible mechanism of Userspace Hinting
for scheduler aimed at influencing task placement. This work will be
discussed as a part of the talk "Linux Kernel Scheduling and split-LLC
architectures: Overview, Challenges and Opportunities"
(https://lpc.events/event/16/contributions/1274/)
in the "Real-time and Scheduling MC" at Linux Plumbers Conference 2022.

Note: This is an experimental patchset that exposes some low-level knobs
to influence task placement decision at various decision points in
the scheduler. The current API design is experimental and is only
capable of setting low-level hints. This API is not meant for public
consumption and only serves as a means to test and demonstrate the
efficacy of hints in helping the scheduler make optimal placement
decisions based on the requirements provided by the applications.
Scheduler is free to ignore the hints set by the user if it believes
that following the hints will put the system in a suboptimal state.

- Motivation

The heuristics used by the scheduler today, such as the WF_SYNC flag,
wake_wide() logic, etc., fall short at accurately inferring the nature
of the workload in terms of whether it is preferable to consolidate a
group of threads close together or if they should be spread apart. The
inability to infer the nature of the workload can lead to a series of
incorrect placement decisions that can be detrimental to the workload
performance. The penalty seems to be severe on systems with split-LLC
such as AMD EPYC.

Consider a workload like schbench. It is observed that the 99th
percentile latency reported by schebench improves drastically if
the messenger and worker are on the same LLC. However, the signaling
between the messenger and the workers happens via a futex which does
not set the WF_SYNC flag when waking up the waiting tasks. In such a
scenario, scheduler will not pull the worker thread towards the
messenger, leaving it in a suboptimal state, on an external LLC even
though there is room on the messenger's LLC to accommodate the worker.

Another example is that of tbench where tasks sleep soon after the
initial wakeup. In such a scenario, with only few running tasks in the
system, the NUMA imbalance threshold is never crossed and all the
following placements of new tasks exhibiting similar behavior will
happen on the same NUMA node and more often on a select few LLCs
within it. When all the tbench threads are forked, a wakeup signal will
lead to all the waiting tasks waking up at once, storming the LLCs,
overloading them. The imbalance at subsequent wakeup is due to the
non-uniform distribution of task across the system during the initial
placement. tbench could have benefited from spreading the tasks early
on, reducing the many migrations it would require later to reach an
optimal state however the current heuristics do not allow for this to
happen.

Peter Zijlstra, almost a year ago, had indicated that a high-level
hinting framework is needed to prevent addition of more low-level
heuristics, complicating the scheduler logic.
(https://lore.kernel.org/lkml/YVwnsrZWrnWHaoqN@hirez.programming.kicks-ass.net/)
Peter suggested that the high-level hints can describe the type of
workload the user is running and internally, the scheduler can take
care of modifying few parameters and heuristics to make the workload
run optimally on a best effort basis.

Following are, and I quote, the hints described by Peter in his
response:

```
- tail latency; prepared to waste time to increase the odds of running
  sooner. Possible effect: have this task always do a full
  select_idle_sibling() scan.

  (there's also the anti case, which I'm not sure how to enumerate,
  basically they don't want select_idle_sibling(), just place the task
  wherever)

- non-interactive; doesn't much care about wakeup latency; can suffer
  packing?

- background; (implies non-interactive?) doesn't much care about
  completion time either, just cares about efficiency

- interactive; cares much about wakeup-latency; cares less about
  throughput.

- (energy) efficient; cares more about energy usage than performance
```

Although the focus is on how to bias CPU time based on the workload
characteristics and modifying the idle CPU search space for the same,
the choice of an LLC to place the task on is equally important,
especially in split-LLC architectures.

In this experiment, we show the importance of task placement, its
effect on workload performance, and how influencing the task placement
in the right direction using the low-level knobs can have significant
performance impact on a split-LLC systems such as the AMD EPYC, where
the performance penalty of getting a task placement decision wrong can
be very high.

- Design

The patch series exposes low-level hints, that instructs the scheduler
of the requested behavior at each decision points in the scheduler.
These hints can be categorized into 3 types:

- Hints for initial wakeup

  These hints include:
    o PR_SCHED_HINT_FORK_AFFINE: Place the task close to the parent as
      long as there is an equivalent of an idle core in the local group.
    o PR_SCHED_HINT_FORK_SPREAD: When there is a tie in number of idle
      CPUs between the local group and the idlest group during initial
      task placement, go with the group with least utilization.

  The implementation currently overlooks any NUMA bias at the time of
  initial placement.

- Hints for subsequent wakeup

  These hints include:
    o PR_SCHED_HINT_WAKE_AFFINE: Bias task placement towards the
      MC Domain of the waker task.
    o PR_SCHED_HINT_WAKE_HOLD: Bias task placement towards the
      MC Domain where the task previously ran.

  These hints are followed on a best effort basis. If the targeted MC
  Domain advertises it has an idle core through the sched_domain_shared
  object, the wakeup hints are followed.

Only one hint from each category can be set at once to ensure a defined
behavior. Hits from different category can be combined at once as they
are independent of each other.

Load balancer is aware of the hints and will try to not migrate a task as
long as the LLC is not overloaded.

Children will inherit hints from parent. This was done so that hints can be
set from a wrapper script and did not need any modification of the
workload.

- Potential Hints for the Future

  o PR_SCHED_HINT_WAKE_WIDE

  Setting PR_SCHED_HINT_WAKE_WIDE will lead to the scheduler searching
  the CPUs outside the targeted MC Domain (and within the parent
  domain) if the MC Domain is fully loaded and no idle CPU can be found.

  This can be realised as a generic extension to Yicong Yang's efforts to
  optimize task placement in a clustered system where the scheduler
  searches the CPU cluster for an idle CPU before searching the rest of the
  CPUs in the MC domain.
  (https://lore.kernel.org/lkml/20220822073610.27205-1-yangyicong@huawei.com/)
  For non-clustered system, this can be extended to first search the
  CPUs of the MC domain and then look for a CPU in the higher domain,
  if necessary, with the feature being gated behind a hint.

  Although unimplemented, this hint has been mentioned here to promote
  discussion on the concept and possible design.

- Workflow Illustration

  o For Initial Task Placement:
									 Yes
	Parent Task ----------> Group has an equivalent of idle core? ------------> Local Group
	    | 					^ 			|
	    | fork() 				| 			|   No
	    v 					| 			|---------> Default Behavior
	New Task --------------> PR_SCHED_HINT_FORK_AFFINE
	(Inherits 	|
	 Hints) 	|------> tie in number of idle CPUs 					    Yes
				between local and idlest group? --> PR_SCHED_HINT_FORK_SPREAD set? ------> Group with lowest
						| 			     	| 				utilization
					     No | 				| No
						v 				|
					Default Behavior <-----------------------

  o For Subsequent Wakeup:

								Yes
	Waker Task ------------------------> MC has idle core? ------------> Wake up on waker's MC Domain
	    | 						^ 		|
	    | ttwu 					| 		|    No
	    v 						| 		|---------> Default Behavior
	Wakee Task -- prev_cpu and --------> PR_SCHED_HINT_WAKE_AFFINE 				^
		       current CPU 		|						|
		      do not share 		|						|
		        L3 cache 		|						|
		    and wakeup hints		|						|
			are set.		|--------> PR_SCHED_HINT_WAKE_HOLD 		|
								| 			  	|
								| 				| No
								v 				|
							Previous MC has idle core?  -------------
					        		|
								v
							Wake on MC Domain where
					  		  task previously ran

- API

Note: This is a highly experimental and barebone API designed to
prototype hinting. This is not intended for public consumption.

The hint can be set from the prctl() interface as follows:

	#include <sys/prctl.h>

	prctl(PR_SCHED_HINT /* prctl cmd */,
	      PR_SCHED_HINT_FORK_AFFINE | PR_SCHED_HINT_WAKE_AFFINE /* Combination of hints */,
	      0 /* pid of task to set hint for. 0 is current task */,
	      0, 0);

Once the hint is set, the scheduler tries its best to follow the hints
when it hits a decision point.

- Results and Explanation on AMD EPYC

Changes are based on tip:sched/core at
commit: 5531ecffa4b9 "sched: Add update_current_exec_runtime helper"

For ease of the readers, following short forms are used to refer to the
hints:

	fork_affine: PR_SCHED_HINT_FORK_AFFINE
	fork_spread: PR_SCHED_HINT_FORK_SPREAD
	wake_affine: PR_SCHED_HINT_WAKE_AFFINE
	wake_hold:   PR_SCHED_HINT_WAKE_HOLD

Following are results from tests carried out on a dual socket Zen3
system (2 x 64C/128T) in NPS1 mode:

- Hackbench

  o Fork Time Hint

	  Test:                   tip                   no-hint              fork_affine             fork_spread
 	 1-groups:         4.31 (0.00 pct)         4.46 (-3.48 pct)        4.27 (0.92 pct)         4.28 (0.69 pct)
 	 2-groups:         4.93 (0.00 pct)         4.85 (1.62 pct)         4.91 (0.40 pct)         5.15 (-4.46 pct)
 	 4-groups:         5.38 (0.00 pct)         5.35 (0.55 pct)         5.36 (0.37 pct)         5.31 (1.30 pct)
 	 8-groups:         5.59 (0.00 pct)         5.49 (1.78 pct)         5.51 (1.43 pct)         5.51 (1.43 pct)
	16-groups:         7.18 (0.00 pct)         7.38 (-2.78 pct)        7.31 (-1.81 pct)        7.25 (-0.97 pct)

    Due to the communicating nature of the hackbench threads, they
    prefer to placed on the same LLC to maximize cache efficiency.
    It does not prefer spreading at fork time.

  o Wakeup Hint

	  Test:                   tip                     no-hint            wake_affine         wake_hold    
 	 1-groups:         4.31 (0.00 pct)         4.46 (-3.48 pct)      4.20 (2.55 pct)    4.11 (4.64 pct) 
 	 2-groups:         4.93 (0.00 pct)         4.85 (1.62 pct)       4.74 (3.85 pct)    5.15 (-4.46 pct)
 	 4-groups:         5.38 (0.00 pct)         5.35 (0.55 pct)       5.04 (6.31 pct)    4.54 (15.61 pct)
	 8-groups:         5.59 (0.00 pct)         5.49 (1.78 pct)       5.39 (3.57 pct)    5.71 (-2.14 pct)
	16-groups:         7.18 (0.00 pct)         7.38 (-2.78 pct)      7.24 (-0.83 pct)   7.76 (-8.07 pct)
    
    As the tasks within a groups have a producer consumer behavior,
    hackbench threads benefit from following the waker task. Hence an
    affine wakeup leads to better performance.

  o Combination of Hints

	  Test:                   tip          fork_affine + wake_affine   fork_spread + wake_hold
	 1-groups:         4.31 (0.00 pct)     	  4.20 (2.55 pct)          4.81 (-11.60 pct)
	 2-groups:         4.93 (0.00 pct)     	  4.74 (3.85 pct)          5.09 (-3.24 pct)
 	 4-groups:         5.38 (0.00 pct)     	  5.01 (6.87 pct)          5.62 (-4.46 pct)
 	 8-groups:         5.59 (0.00 pct)     	  5.38 (3.75 pct)          5.69 (-1.78 pct)
	16-groups:         7.18 (0.00 pct)     	  7.25 (-0.97 pct)         7.97 (-11.00 pct)

    A combination of the hints showing good result from above continue
    to benefit the hackbench threads.

    *Hackbench works best with the combination of relevant hints*

- schbench

  o Fork Time Hint

	#workers:     tip                     no-hint                fork_affine            fork_spread
	  1:      37.00 (0.00 pct)        38.00 (-2.70 pct)       17.00 (54.05 pct)       34.00 (8.10 pct)
	  2:      39.00 (0.00 pct)        36.00 (7.69 pct)        21.00 (46.15 pct)       39.00 (0.00 pct)
	  4:      41.00 (0.00 pct)        41.00 (0.00 pct)        28.00 (31.70 pct)       40.00 (2.43 pct)
	  8:      53.00 (0.00 pct)        54.00 (-1.88 pct)       39.00 (26.41 pct)       53.00 (0.00 pct)
	 16:      73.00 (0.00 pct)        74.00 (-1.36 pct)       68.00 (6.84 pct)        73.00 (0.00 pct)
	 32:     116.00 (0.00 pct)       124.00 (-6.89 pct)      113.00 (2.58 pct)       119.00 (-2.58 pct)
	 64:     217.00 (0.00 pct)       215.00 (0.92 pct)       205.00 (5.52 pct)       222.00 (-2.30 pct)
	128:     477.00 (0.00 pct)       440.00 (7.75 pct)       445.00 (6.70 pct)       453.00 (5.03 pct)
	256:     1062.00 (0.00 pct)      1026.00 (3.38 pct)      1007.00 (5.17 pct)      1021.00 (3.86 pct)
	512:     47552.00 (0.00 pct)     47168.00 (0.80 pct)     47296.00 (0.53 pct)     47552.00 (0.00 pct)

    schbench tasks prefer an affine fork keeping most worker task on the
    same LLC and only migrating necessary tasks out later. This reduces
    the p99 latency significantly.

  o Wakeup Hint

	#workers:     tip                     no-hint                 wake_affine		     wake_hold
	  1:      37.00 (0.00 pct)        38.00 (-2.70 pct)        18.00 (51.35 pct)      	 32.00 (13.51 pct)
	  2:      39.00 (0.00 pct)        36.00 (7.69 pct)         18.00 (53.84 pct)      	 36.00 (7.69 pct)
	  4:      41.00 (0.00 pct)        41.00 (0.00 pct)         21.00 (48.78 pct)      	 33.00 (19.51 pct)
	  8:      53.00 (0.00 pct)        54.00 (-1.88 pct)        31.00 (41.50 pct)      	 51.00 (3.77 pct)
	 16:      73.00 (0.00 pct)        74.00 (-1.36 pct)      2636.00 (-3510.95 pct)   	 75.00 (-2.73 pct)
	 32:     116.00 (0.00 pct)       124.00 (-6.89 pct)     15696.00 (-13431.03 pct)        124.00 (-6.89 pct)
	 64:     217.00 (0.00 pct)       215.00 (0.92 pct)      15280.00 (-6941.47 pct)         224.00 (-3.22 pct)
	128:     477.00 (0.00 pct)       440.00 (7.75 pct)      14800.00 (-3002.72 pct)         493.00 (-3.35 pct)
	256:     1062.00 (0.00 pct)      1026.00 (3.38 pct)     15696.00 (-1377.96 pct)         1026.00 (3.38 pct)
	512:     47552.00 (0.00 pct)     47168.00 (0.80 pct)    60736.00 (-27.72 pct)  	       49856.00 (-4.84 pct)
    
    "wake_affine" hint is beneficial as long as the number of messengers
    and the workers is fewer than the number of CPUs in the LLC, beyond
    that point it causes overloading and thus causing the workers to wait
    behind one another which makes the tail-latency worse. Wake hold
    shows some improvements and minimal regression by avoiding cross LLC
    migration as a result of the hint.

  o Combination of Hints

	#workers:     tip                     no-hint   	fork_affine + wake_affine    fork_spread + wake_hold
	  1:      37.00 (0.00 pct)        38.00 (-2.70 pct)          17.00 (54.05 pct)   	 40.00 (-8.10 pct)
	  2:      39.00 (0.00 pct)        36.00 (7.69 pct)           18.00 (53.84 pct)   	 40.00 (-2.56 pct)
	  4:      41.00 (0.00 pct)        41.00 (0.00 pct)           20.00 (51.21 pct)   	 40.00 (2.43 pct)
	  8:      53.00 (0.00 pct)        54.00 (-1.88 pct)          31.00 (41.50 pct)   	 54.00 (-1.88 pct)
	 16:      73.00 (0.00 pct)        74.00 (-1.36 pct)        2884.00 (-3850.68 pct)        80.00 (-9.58 pct)
	 32:     116.00 (0.00 pct)       124.00 (-6.89 pct)       15408.00 (-13182.75 pct)      123.00 (-6.03 pct)
	 64:     217.00 (0.00 pct)       215.00 (0.92 pct)        15344.00 (-6970.96 pct)       224.00 (-3.22 pct)
	128:     477.00 (0.00 pct)       440.00 (7.75 pct)        14896.00 (-3022.85 pct)       450.00 (5.66 pct)
	256:     1062.00 (0.00 pct)      1026.00 (3.38 pct)       15664.00 (-1374.95 pct)       997.00 (6.12 pct)
	512:     47552.00 (0.00 pct)     47168.00 (0.80 pct)      60992.00 (-28.26 pct)       55232.00 (-16.15 pct)
    
    Combination of hints bring out worst of the scenarios.

    *schbench works best with only fork hint set*

- tbench

  o Fork Time Hints

	Clients:      tip                    no-hint               fork_affine              fork_spread
	    1    573.26 (0.00 pct)       572.29 (-0.16 pct)      572.70 (-0.09 pct)      569.64 (-0.63 pct)
	    2    1131.19 (0.00 pct)      1119.57 (-1.02 pct)     1131.97 (0.06 pct)      1101.03 (-2.66 pct)
	    4    2100.07 (0.00 pct)      2070.66 (-1.40 pct)     2094.80 (-0.25 pct)     2011.64 (-4.21 pct)
	    8    3809.88 (0.00 pct)      3784.16 (-0.67 pct)     3458.94 (-9.21 pct)     3867.70 (1.51 pct)
	   16    6560.72 (0.00 pct)      6449.64 (-1.69 pct)     6342.78 (-3.32 pct)     6700.50 (2.13 pct)
	   32    12203.23 (0.00 pct)     12180.02 (-0.19 pct)    10411.44 (-14.68 pct)   13104.29 (7.38 pct)
	   64    22389.81 (0.00 pct)     23084.51 (3.10 pct)     16614.14 (-25.79 pct)   24353.76 (8.77 pct)
	  128    32449.37 (0.00 pct)     33561.28 (3.42 pct)     19971.67 (-38.45 pct)   36201.16 (11.56 pct)
	  256    58962.40 (0.00 pct)     59118.43 (0.26 pct)     26836.13 (-54.48 pct)   61721.06 (4.67 pct)
	  512    59608.71 (0.00 pct)     60246.78 (1.07 pct)     36889.55 (-38.11 pct)   59696.57 (0.14 pct)
	 1024    58037.02 (0.00 pct)     58532.41 (0.85 pct)     39936.06 (-31.18 pct)   57445.62 (-1.01 pct)

    tbench showcases the thundering herd problem where the task after
    initial wakeup quickly go to sleep. For such a case, finding an
    idle group based on utilization using the fork spread allows for a
    better distribution of tasks early on and lesser migrations later to
    reach a stable state.
    
    *tbench can gain some more performance with fork spread hint on a split-LLC system such as AMD EPYC*

- Results from Unified LLC

Changes are based on tip:sched/core at
commit: 5531ecffa4b9 "sched: Add update_current_exec_runtime helper"

For ease of the readers, same short forms are followed.

Following are results from tests carried out on a dual socket
system based on  3rd Generation Intel Xeon Scalable Processors
(2 x 32C/64T):

- Hackbench

0 Fork time hint

  Test:                   tip                   no-hint                fork_affine             fork_spread           
   1-groups:         2.38 (0.00 pct)         2.33 (2.10 pct)         2.25 (5.46 pct)         2.49 (-4.62 pct)        
   2-groups:         3.84 (0.00 pct)         3.64 (5.20 pct)         3.80 (1.04 pct)         3.77 (1.82 pct)         
   4-groups:         4.50 (0.00 pct)         4.39 (2.44 pct)         4.38 (2.66 pct)         4.40 (2.22 pct)         
   8-groups:         5.84 (0.00 pct)         5.94 (-1.71 pct)        5.96 (-2.05 pct)        5.92 (-1.36 pct)        
  16-groups:        11.91 (0.00 pct)        12.37 (-3.86 pct)       12.80 (-7.47 pct)       12.68 (-6.46 pct)

  For lower number of groups, the hints show benefit for the test
  system, however, the performance degrades for larger number of groups
  for both the type of fork time hints.

o Wakeup Hint

  Test:                   tip                   no-hint               wake_affine              wake_hold      
   1-groups:         2.38 (0.00 pct)         2.33 (2.10 pct)        1.98 (16.80 pct)        2.01 (15.54 pct)  
   2-groups:         3.84 (0.00 pct)         3.64 (5.20 pct)        3.39 (11.71 pct)        3.96 (-3.12 pct)  
   4-groups:         4.50 (0.00 pct)         4.39 (2.44 pct)        4.13 (8.22 pct)         4.83 (-7.33 pct)  
   8-groups:         5.84 (0.00 pct)         5.94 (-1.71 pct)       6.03 (-3.25 pct)        6.11 (-4.62 pct)  
  16-groups:        11.91 (0.00 pct)        12.37 (-3.86 pct)       9.47 (20.48 pct)       10.78 (9.48 pct)   

  Affine wakeup seems to benefit a unified LLC system too. However,
  wake_hold has inconsistent behavior here too like in case of split-LLC
  systems.

o Combination of hint

  Test:                   tip                   no-hint          fork_affine+wake_affine   fork_spread+wake_hold
   1-groups:         2.38 (0.00 pct)         2.33 (2.10 pct)        1.98 (16.80 pct)         3.44 (-44.53 pct)
   2-groups:         3.84 (0.00 pct)         3.64 (5.20 pct)        3.43 (10.67 pct)         4.39 (-14.32 pct)
   4-groups:         4.50 (0.00 pct)         4.39 (2.44 pct)        4.16 (7.55 pct)          4.52 (-0.44 pct)
   8-groups:         5.84 (0.00 pct)         5.94 (-1.71 pct)       6.01 (-2.91 pct)         5.99 (-2.56 pct)
  16-groups:        11.91 (0.00 pct)        12.37 (-3.86 pct)       9.65 (18.97 pct)        10.63 (10.74 pct)

  With fork affine and wake affine, the benefit compounds based on the
  test results.

- schbench

o fork time hints

  #workers:     tip                     no-hint                fork_affine            fork_spread
    1:      18.00 (0.00 pct)        14.00 (22.22 pct)       16.00 (11.11 pct)       15.00 (16.66 pct)
    2:      17.00 (0.00 pct)        18.00 (-5.88 pct)       16.00 (5.88 pct)        19.00 (-11.76 pct)
    4:      20.00 (0.00 pct)        21.00 (-5.00 pct)       19.00 (5.00 pct)        21.00 (-5.00 pct)
    8:      28.00 (0.00 pct)        29.00 (-3.57 pct)       27.00 (3.57 pct)        28.00 (0.00 pct)
   16:      45.00 (0.00 pct)        46.00 (-2.22 pct)       42.00 (6.66 pct)        45.00 (0.00 pct)
   32:      79.00 (0.00 pct)        79.00 (0.00 pct)        74.00 (6.32 pct)        79.00 (0.00 pct)
   64:     166.00 (0.00 pct)       167.00 (-0.60 pct)      163.00 (1.80 pct)       165.00 (0.60 pct)
  128:     270.00 (0.00 pct)       291.00 (-7.77 pct)      276.00 (-2.22 pct)      297.00 (-10.00 pct)
  256:     42432.00 (0.00 pct)     42560.00 (-0.30 pct)    42816.00 (-0.90 pct)    42304.00 (0.30 pct)
  512:     90240.00 (0.00 pct)     90240.00 (0.00 pct)     90240.00 (0.00 pct)     90496.00 (-0.28 pct)

  An affine fork benefits the test system however the spread at fork is
  not ideal for it.

o Wakeup hints

  #workers:     tip                     no-hint               wake_affine                        wake_hold
    1:      18.00 (0.00 pct)        14.00 (22.22 pct)       15.00 (16.66 pct)               17.00 (5.55 pct)
    2:      17.00 (0.00 pct)        18.00 (-5.88 pct)       15.00 (11.76 pct)               18.00 (-5.88 pct)
    4:      20.00 (0.00 pct)        21.00 (-5.00 pct)       19.00 (5.00 pct)                21.00 (-5.00 pct)
    8:      28.00 (0.00 pct)        29.00 (-3.57 pct)       27.00 (3.57 pct)                29.00 (-3.57 pct)
   16:      45.00 (0.00 pct)        46.00 (-2.22 pct)       45.00 (0.00 pct)                48.00 (-6.66 pct)
   32:      79.00 (0.00 pct)        79.00 (0.00 pct)        80.00 (-1.26 pct)               82.00 (-3.79 pct)
   64:     166.00 (0.00 pct)       167.00 (-0.60 pct)      144.00 (13.25 pct)              165.00 (0.60 pct)
  128:     270.00 (0.00 pct)       291.00 (-7.77 pct)      28384.00 (-10412.59 pct)        256.00 (5.18 pct)
  256:     42432.00 (0.00 pct)     42560.00 (-0.30 pct)    60352.00 (-42.23 pct)         43584.00 (-2.71 pct)
  512:     90240.00 (0.00 pct)     90240.00 (0.00 pct)     116608.00 (-29.21 pct)        91008.00 (-0.85 pct)

  Affine wakeup is beneficial as long as the number of workers is less
  than the CPUs in each socket. Beyond that, the socket gets overloaded
  and leads to massive increase in tail latency like what was seen
  in the split-LLC case. Staying on same LLC benefits from initial
  distribution and having an idle CPU in the same LLC unless system is
  heavily overloaded.

o Combination of hints

  #workers:     tip                     no-hint            fork_affine+wake_affine       fork_spread+wake_hold
    1:      18.00 (0.00 pct)        14.00 (22.22 pct)        14.00 (22.22 pct)              14.00 (22.22 pct)
    2:      17.00 (0.00 pct)        18.00 (-5.88 pct)        14.00 (17.64 pct)              16.00 (5.88 pct)
    4:      20.00 (0.00 pct)        21.00 (-5.00 pct)        19.00 (5.00 pct)               21.00 (-5.00 pct)
    8:      28.00 (0.00 pct)        29.00 (-3.57 pct)        26.00 (7.14 pct)               28.00 (0.00 pct)
   16:      45.00 (0.00 pct)        46.00 (-2.22 pct)        40.00 (11.11 pct)              46.00 (-2.22 pct)
   32:      79.00 (0.00 pct)        79.00 (0.00 pct)         81.00 (-2.53 pct)              80.00 (-1.26 pct)
   64:     166.00 (0.00 pct)       167.00 (-0.60 pct)       142.00 (14.45 pct)             166.00 (0.00 pct)
  128:     270.00 (0.00 pct)       291.00 (-7.77 pct)     28192.00 (-10341.48 pct)         251.00 (7.03 pct)
  256:     42432.00 (0.00 pct)     42560.00 (-0.30 pct)   62016.00 (-46.15 pct)          42816.00 (-0.90 pct)
  512:     90240.00 (0.00 pct)     90240.00 (0.00 pct)   108672.00 (-20.42 pct)          93056.00 (-3.12 pct)

  Combination the right hints compounds the benefit. Affine hints show
  good improvements until the LLC threshold is crossed. A good spread
  and holding the position helps in reducing expensive cross socket
  migration benefiting the benchmark in some cases.

- tbench

o Fork time hints

  Clients:      tip                     no-hint               fork_affine             fork_spread
      1    122.36 (0.00 pct)       121.33 (-0.84 pct)      121.49 (-0.71 pct)      134.69 (10.07 pct)
      2    247.13 (0.00 pct)       266.78 (7.95 pct)       271.97 (10.05 pct)      245.39 (-0.70 pct)
      4    516.31 (0.00 pct)       537.59 (4.12 pct)       511.37 (-0.95 pct)      508.46 (-1.52 pct)
      8    1033.53 (0.00 pct)      1106.22 (7.03 pct)      1010.87 (-2.19 pct)     1175.12 (13.69 pct)
     16    3094.23 (0.00 pct)      2509.74 (-18.88 pct)    3410.97 (10.23 pct)     2588.06 (-16.35 pct)
     32    10757.40 (0.00 pct)     10585.54 (-1.59 pct)    10481.10 (-2.56 pct)    10711.71 (-0.42 pct)
     64    16170.10 (0.00 pct)     15864.99 (-1.88 pct)    15856.51 (-1.93 pct)    16009.95 (-0.99 pct)
    128    15168.29 (0.00 pct)     16547.25 (9.09 pct)     23796.79 (56.88 pct)    14229.63 (-6.18 pct)
    256    32474.25 (0.00 pct)     32100.39 (-1.15 pct)    31633.93 (-2.58 pct)    32513.67 (0.12 pct)
    512    29543.03 (0.00 pct)     29537.67 (-0.01 pct)    29282.98 (-0.88 pct)    29894.14 (1.18 pct)

   An affine fork seems to benefit tbench when the system is fully
   loaded in case of workloads such as tbench on the test system. This
   is quite opposite of the unified LLC system which benefitted from
   spreading on fork.

- Stream

  - 10 runs

  o 1 thread
  
  Test:        tip                     no_hint                 fork_spread
   Copy:   28127.35 (0.00 pct)     28367.72 (0.85 pct)     27293.80 (-2.96 pct)
  Scale:   16248.13 (0.00 pct)     16332.26 (0.51 pct)     15901.45 (-2.13 pct)
    Add:   17146.86 (0.00 pct)     17491.69 (2.01 pct)     17062.82 (-0.49 pct)
  Triad:   17552.85 (0.00 pct)     17723.45 (0.97 pct)     17301.79 (-1.43 pct)
  
  o 2 threads
  
  Test:        tip                     no_hint                 fork_spread
   Copy:   48920.60 (0.00 pct)     49831.92 (1.86 pct)     53687.16 (9.74 pct)
  Scale:   27370.11 (0.00 pct)     27560.13 (0.69 pct)     32197.46 (17.63 pct)
    Add:   29909.84 (0.00 pct)     30363.41 (1.51 pct)     34311.99 (14.71 pct)
  Triad:   30225.18 (0.00 pct)     30520.83 (0.97 pct)     34982.68 (15.74 pct)
  
  o 4 threads
  
  Test:        tip                     no_hint                 fork_spread
   Copy:   79603.85 (0.00 pct)     80394.36 (0.99 pct)     89379.42 (12.28 pct)
  Scale:   46870.97 (0.00 pct)     47417.41 (1.16 pct)     54352.83 (15.96 pct)
    Add:   52066.71 (0.00 pct)     52623.44 (1.06 pct)     59269.40 (13.83 pct)
  Triad:   52069.18 (0.00 pct)     52646.49 (1.10 pct)     59830.77 (14.90 pct)
  
  o 8 threads
  
  Test:         tip                     no_hint                 fork_spread
   Copy:   113566.60 (0.00 pct)    113613.06 (0.04 pct)    128656.04 (13.28 pct)
  Scale:   71443.07 (0.00 pct)     71722.27 (0.39 pct)     79848.75 (11.76 pct)
    Add:   81408.48 (0.00 pct)     81491.98 (0.10 pct)     90695.65 (11.40 pct)
  Triad:   81987.96 (0.00 pct)     81992.01 (0.00 pct)     92047.47 (12.26 pct)
  
  o 16 threads
  
  Test:          tip                     no_hint                 fork_spread
   Copy:   152139.80 (0.00 pct)    151279.55 (-0.56 pct)   148607.24 (-2.32 pct)
  Scale:   103163.08 (0.00 pct)    103628.35 (0.45 pct)    102184.90 (-0.94 pct)
    Add:   113404.79 (0.00 pct)    113284.87 (-0.10 pct)   111183.33 (-1.95 pct)
  Triad:   115388.28 (0.00 pct)    116244.97 (0.74 pct)    114411.79 (-0.84 pct)
  
  o 32 threads
  
  Test:          tip                     no_hint                 fork_spread
   Copy:   161240.24 (0.00 pct)    161470.60 (0.14 pct)    162977.90 (1.07 pct)
  Scale:   124507.68 (0.00 pct)    126147.95 (1.31 pct)    126678.26 (1.74 pct)
    Add:   130164.90 (0.00 pct)    130225.95 (0.04 pct)    131567.75 (1.07 pct)
  Triad:   132933.44 (0.00 pct)    134431.69 (1.12 pct)    135044.50 (1.58 pct)
  
  - 100 runs
  
  o 1 thread
  
  Test:        tip                     no_hint                 fork_spread
   Copy:   28087.03 (0.00 pct)     28391.25 (1.08 pct)     27232.70 (-3.04 pct)
  Scale:   16187.98 (0.00 pct)     16295.17 (0.66 pct)     15827.29 (-2.22 pct)
    Add:   17122.77 (0.00 pct)     17497.03 (2.18 pct)     16987.19 (-0.79 pct)
  Triad:   17524.57 (0.00 pct)     17770.79 (1.40 pct)     17220.50 (-1.73 pct)
  
  o 2 threads
  
  Test:        tip                     no_hint                 fork_spread
   Copy:   49153.60 (0.00 pct)     49578.59 (0.86 pct)     52587.24 (6.98 pct)
  Scale:   27712.34 (0.00 pct)     27634.70 (-0.28 pct)    30989.75 (11.82 pct)
    Add:   30252.12 (0.00 pct)     30473.89 (0.73 pct)     33258.64 (9.93 pct)
  Triad:   30526.42 (0.00 pct)     30643.25 (0.38 pct)     33795.72 (10.70 pct)
  o 4 threads
  
  Test:        tip                     no_hint                 fork_spread
   Copy:   81401.84 (0.00 pct)     81154.71 (-0.30 pct)    92914.24 (14.14 pct)
  Scale:   47690.70 (0.00 pct)     47356.46 (-0.70 pct)    54671.55 (14.63 pct)
    Add:   52859.84 (0.00 pct)     52586.28 (-0.51 pct)    59958.56 (13.42 pct)
  Triad:   52931.46 (0.00 pct)     52647.24 (-0.53 pct)    60669.41 (14.61 pct)
  
  o 8 threads
  
  Test:         tip                     no_hint                 fork_spread
   Copy:   115285.88 (0.00 pct)    116381.75 (0.95 pct)    132874.03 (15.25 pct)
  Scale:   72189.01 (0.00 pct)     72751.02 (0.77 pct)     82349.53 (14.07 pct)
    Add:   82438.52 (0.00 pct)     82758.78 (0.38 pct)     93489.17 (13.40 pct)
  Triad:   82791.24 (0.00 pct)     83446.12 (0.79 pct)     95010.20 (14.75 pct)
  
  o 16 threads
  
  Test:         tip                     no_hint                 fork_spread
   Copy:   152361.42 (0.00 pct)    151922.38 (-0.28 pct)   152300.21 (-0.04 pct)
  Scale:   103042.94 (0.00 pct)    103833.81 (0.76 pct)    104310.93 (1.23 pct)
    Add:   114032.41 (0.00 pct)    113004.05 (-0.90 pct)   113682.56 (-0.30 pct)
  Triad:   115319.73 (0.00 pct)    116174.81 (0.74 pct)    116782.15 (1.26 pct)

  o 32 threads

  Test:         tip                     no_hint                 fork_spread
   Copy:   161485.98 (0.00 pct)    162183.58 (0.43 pct)    163371.33 (1.16 pct)
  Scale:   125366.83 (0.00 pct)    126356.26 (0.78 pct)    126856.35 (1.18 pct)
    Add:   129846.24 (0.00 pct)    130469.97 (0.48 pct)    131863.96 (1.55 pct)
  Triad:   133523.78 (0.00 pct)    134498.68 (0.73 pct)    134996.96 (1.10 pct)

  In case of Stream, the benchmark is benefiting from spreading early as
  it reduces cache-contention and has an added advantage of the higher
  cross-socket bandwidth. After Mel Gorman's NUMA imbalance rework for
  split-LLC systems, (commit: e496132ebedd "sched/fair: Adjust the
  allowed NUMA imbalance when SD_NUMA spans multiple LLCs") systems such
  as AMD EPYC spread tasks by default once the number of tasks in NUMA
  domain crosses the number of LLCs in it thus not needing a hint anymore
  to spread the Stream threads optimally.

- Limitations in current implementation

o The wakeup path uses sd_shared->has_idle_core as a bailout metric for
  hint in the subsequent wakeup path. This metric is not accurate and
  can lead to tasks piling on the same CPU. There exist other
  alternatives such as atomically reading sd_shared->nr_busy_cpus that
  can lead to higher scheduling latency.

o Considerations are not made for task pinning and asymmetric CPU
  capacity. The logic today assumes all CPUs in the system as equal.

o Parts of implementation assume a SMT-2 system to calculate the number
  of cores in sched group. This can be improved by adding a generic
  logic that counts number of online cores when the topology is
  generated to account for systems with different SMT configurations
  and be accurate after a CPU hotplug.

o The API exposes low-level decision points which might not be ideal
  for user with little to no knowledge of scheduler internals.
  As such, an abstract user hint should map to an appropriate
  combination of these low-level hints.

# Future Work

o Fix the shortcomings exposed by the prototype - mainly the bailout
  point in the wakeup path.
o Explore other possible hints to influence task placement that can
  benefit other workloads.
o Test hinting on larger workloads containing tasks exhibiting different
  behavior.
o Make hinting a usable feature based on community feedback.
o Deciding on an interface through which users can provide hints to the
  scheduler.
o Enumerating the hints that are sensible to the user.

Any feedback on the prototype, approach, and design is
highly appreciated.

--
K Prateek Nayak (5):
  task_struct: Add field for per-task userspace scheduler hint
  prctl: Add interface and helper functions to set hints
  sched/fair: Add support for hints in the subsequent wakeup path
  sched/fair: Consider hints in the initial task wakeup path
  sched/fair: Add exception for hints in load balancing path

 include/linux/sched.h      |  2 +
 include/uapi/linux/prctl.h |  9 ++++
 init/init_task.c           |  1 +
 kernel/sched/core.c        | 83 ++++++++++++++++++++++++++++++++
 kernel/sched/fair.c        | 98 ++++++++++++++++++++++++++++++++++++--
 kernel/sys.c               |  5 ++
 6 files changed, 195 insertions(+), 3 deletions(-)

-- 
2.25.1

