Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FFF25B45FA
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Sep 2022 12:55:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbiIJKzh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Sep 2022 06:55:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbiIJKzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Sep 2022 06:55:35 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2063.outbound.protection.outlook.com [40.107.93.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E14D3E754
        for <linux-kernel@vger.kernel.org>; Sat, 10 Sep 2022 03:55:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gJkGPWwU/8r/SfLFIphC8czIPnhNahE0gkYOI8yuqrGCBnxaqJal8qsxi3TMSWKC4Snfc0iesP7FyDAxeWAKPzt2MRvsDDSuDvhEGeXSyX+eEcPeWrASfXnaqOGyexaDnUYqN8J4wNUckyftYjUwxfjxFiEyhTELlEwZ1qWvIQa6tEiRKEGBPz+IHfPlcjpUruY1AgttSrI79G7crOkzoXL+o/6R4kRekkQuaj7hPEdbWoPuCVujuWDZeqtn5mPOnnjrD2p8PeJ+eQPVMuDsLUDFf4zJjy7yrTZP0j+sHb6DgI3M1iIH1psO1YC/vfe9YQJ/7LItWHIZ72OtJk9sdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RR+hODHNRtmmtv8nY5zuwhWWokgI7eCNKilMB5xtB7w=;
 b=gB8/sOwaqECnrfk/ugebbDwxhpjscRJO0cK/fJNJbCxv6z0YWWL7AbJ7QKx7JvsTMK9KXkvkiWhFBxAqQQT2TM5oA/FJorXbvq3kvjbDJXyIC+k0XMycFC9XqoQVj1djz5iXPmtKOLHx3I3pKS6ZvQwzO6lKcvf0YnFq00bqslzLvhi404Xp+AJ4cngEhSROomW+ye3sSNhAl35R3+Jpj0qKiubQsIAFcXHneaIKbLiG5Y4bRFANc5dplVRKQJ2jMAM+hi7wt6gtjAIYU6g5nDtsBzS5pPl/uiVLhFxcqn8S0I6LzfqUt7ifOL4YkTxe9qDx6RiReIbvANbw5D7lpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RR+hODHNRtmmtv8nY5zuwhWWokgI7eCNKilMB5xtB7w=;
 b=DntdcvGZq5EbscCMWVtmDXvQRaIl5kbgBLZqIBYBOSvMw7T094Z2G323Oytasfld1tMfEPxxuMfPwv1zVyS5daTEq65owl44YMEXLIDJmn5XGS0ZQ+K4I9Ud11VuIK4pHI7p5oARAt5X/iAOzzX+5MYir7yqNCO7iOMVhN04nn8=
Received: from DS7PR07CA0008.namprd07.prod.outlook.com (2603:10b6:5:3af::21)
 by LV2PR12MB5920.namprd12.prod.outlook.com (2603:10b6:408:172::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14; Sat, 10 Sep
 2022 10:55:28 +0000
Received: from DM6NAM11FT110.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3af:cafe::91) by DS7PR07CA0008.outlook.office365.com
 (2603:10b6:5:3af::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.12 via Frontend
 Transport; Sat, 10 Sep 2022 10:55:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT110.mail.protection.outlook.com (10.13.173.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.13 via Frontend Transport; Sat, 10 Sep 2022 10:55:28 +0000
Received: from BLR5CG134614W.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Sat, 10 Sep
 2022 05:55:21 -0500
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
Subject: [PATCH 4/5] sched/fair: Consider hints in the initial task wakeup path
Date:   Sat, 10 Sep 2022 16:23:25 +0530
Message-ID: <20220910105326.1797-5-kprateek.nayak@amd.com>
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
X-MS-TrafficTypeDiagnostic: DM6NAM11FT110:EE_|LV2PR12MB5920:EE_
X-MS-Office365-Filtering-Correlation-Id: 4bce9af0-c5b2-4b8c-d544-08da931af8ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FLGjKzaAab9WmVnYzH3e4mk3kEKSDhR7bwxqLmwsTnFkA+YJBNTYBNQrrEl803JEdfWo6pYh+FNE7IBG+aJ+kmkBdngmtxh/5gPQyjxnovIivAmYL92H/IBTkyqcyTwl2YKTBfOekhJYOz4+yjS/c08L5L1cmk1Vm5z/+wJjGFdqTbuizmR2IOVCrIfxSJfFZGyieGnuWFYTJV16M20x7AwGX1NPWPeRL7gP2ZdeC8gfxnOUBGqyPu8m8JQXWqeIXfzEpNi34aPA+/c4iYtQxHC8cPTEwAAGzxFivGN0WgzRSk3za39tCNU7savE3hfd/W9S0PpL/QbIXacZpsVyLFObufHZGL0se6G5o8qTmXDvTRIhaWZdXy1RoPfpiNu5k4WdQF+yGsZzff5r33w3l1RGUmvRs+LLZiE/Psmy0gJQL8Oo9fuQO30WnvhPWpU8pj9oUr8kMxvjaydSI1pjAagtcKUxRub+A8paCwHfohl2aGXnQkbG1QMqE/kesbAu9O99eilIdr5eC4CCohMKD5fPYExLlqyXGxdoqLWR1O92T/woyRFOujQsAErrGsdg6FFoc0mX0FXop+Fdt9W1V5sWgmcROw0Yzisf4yEhMiLv2o1QBZkoafFErQfFVxQhhTLVAFowCNcQZ3z36Zbfi7aM83ugBiLK1IU8YATbUL4LRr46o45eWhbVuhDiVwLyrxQS728P2nuD84e4O8uceiYZlyFbulwsV3lA8Y/v5oXMp6MXnGIpnqApIgtX6gSFOLPAHJ6bMMvRPdp8/+1OeX5WZZ4ObI8UDsEPDwSnZrQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(346002)(376002)(39860400002)(136003)(396003)(40470700004)(36840700001)(46966006)(426003)(186003)(7696005)(2616005)(47076005)(16526019)(336012)(1076003)(70586007)(8936002)(70206006)(4326008)(2906002)(8676002)(5660300002)(7416002)(82310400005)(40480700001)(36756003)(26005)(86362001)(83380400001)(41300700001)(478600001)(40460700003)(81166007)(356005)(82740400003)(36860700001)(316002)(6916009)(54906003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2022 10:55:28.0152
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bce9af0-c5b2-4b8c-d544-08da931af8ef
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT110.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5920
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These hints influence the behavior of the initial task placement and bias
the placement towards or away from the CPU where the task is forked.

The flow is as follows:
- When a fork time hint is set, the NUMA biases are overlooked and only
  the sched_group's statistics computed by update_sg_wakeup_stats()
  (Number of idle CPUs and total utilization of the group) for the local
  group and the idlest group is considered while making initial task
  placement decision when both groups have idle CPUs.
- In case a bias towards local group is hinted, go for the local group as
  long as an equivalent of idle core is present.
  Note: The current implements assume the system running the patch is
  SMT-2. Further optimizations can be made for systems with SMT-4,
  SMT-8, or with no SMT.
- If a hint for spread is set, and there is a tie in number of idle CPUs
  in local group and idlest group, use the utilization of group as the
  tie breaking metric.

PR_SCHED_HINT_FORK_AFFINE enables consolidation until half of the local
group is filled. PR_SCHED_HINT_FORK_SPREAD will choose the target group
based on the utilization if there is a tie in number of idle CPUs.

These hints can be set individually in addition to wakeup hints.

- Results

Following are results from using individual fork time hints and
combination of fork time hints and wakeup hints on various benchmark on
a dual socket Zen3 system:

o Only fork time hint:

- Hackbench

Test:                   tip                     no-hint              fork_affine             fork_spread
 1-groups:         4.31 (0.00 pct)         4.46 (-3.48 pct)        4.27 (0.92 pct)         4.28 (0.69 pct)
 2-groups:         4.93 (0.00 pct)         4.85 (1.62 pct)         4.91 (0.40 pct)         5.15 (-4.46 pct)
 4-groups:         5.38 (0.00 pct)         5.35 (0.55 pct)         5.36 (0.37 pct)         5.31 (1.30 pct)
 8-groups:         5.59 (0.00 pct)         5.49 (1.78 pct)         5.51 (1.43 pct)         5.51 (1.43 pct)
16-groups:         7.18 (0.00 pct)         7.38 (-2.78 pct)        7.31 (-1.81 pct)        7.25 (-0.97 pct)

- schbench

 workers:     tip                     no-hint                fork_affine
  1:      37.00 (0.00 pct)        38.00 (-2.70 pct)       17.00 (54.05 pct)
  2:      39.00 (0.00 pct)        36.00 (7.69 pct)        21.00 (46.15 pct)
  4:      41.00 (0.00 pct)        41.00 (0.00 pct)        28.00 (31.70 pct)
  8:      53.00 (0.00 pct)        54.00 (-1.88 pct)       39.00 (26.41 pct)
 16:      73.00 (0.00 pct)        74.00 (-1.36 pct)       68.00 (6.84 pct)
 32:     116.00 (0.00 pct)       124.00 (-6.89 pct)      113.00 (2.58 pct)
 64:     217.00 (0.00 pct)       215.00 (0.92 pct)       205.00 (5.52 pct)
128:     477.00 (0.00 pct)       440.00 (7.75 pct)       445.00 (6.70 pct)
256:     1062.00 (0.00 pct)      1026.00 (3.38 pct)      1007.00 (5.17 pct)
512:     47552.00 (0.00 pct)     47168.00 (0.80 pct)     47296.00 (0.53 pct)

- tbench

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

 All these benchmarks show noticeable improvements only with a slightly
 different initial placement. A placement in line with benchmark
 behavior improves benchmark results.

o Combination of hints

- Hackbench

Test:                   tip                     no-hint       fork_affine + wake_affine   fork_spread + wake_hold
 1-groups:         4.31 (0.00 pct)         4.46 (-3.48 pct)    	  4.20 (2.55 pct)          4.81 (-11.60 pct)
 2-groups:         4.93 (0.00 pct)         4.85 (1.62 pct)     	  4.74 (3.85 pct)          5.09 (-3.24 pct)
 4-groups:         5.38 (0.00 pct)         5.35 (0.55 pct)     	  5.01 (6.87 pct)          5.62 (-4.46 pct)
 8-groups:         5.59 (0.00 pct)         5.49 (1.78 pct)     	  5.38 (3.75 pct)          5.69 (-1.78 pct)
16-groups:         7.18 (0.00 pct)         7.38 (-2.78 pct)    	  7.25 (-0.97 pct)         7.97 (-11.00 pct)

Hackbench improves further with pairing of correct wakeup hint with
correct fork time hint. The regression is equally bad with wrong hints
set.

Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
 kernel/sched/fair.c | 34 ++++++++++++++++++++++++++++++++--
 1 file changed, 32 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 90e523cd8de8..4c61bd0e93b3 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9262,6 +9262,7 @@ find_idlest_group(struct sched_domain *sd, struct task_struct *p, int this_cpu)
 	struct sg_lb_stats local_sgs, tmp_sgs;
 	struct sg_lb_stats *sgs;
 	unsigned long imbalance;
+	unsigned int task_hint, fork_hint;
 	struct sg_lb_stats idlest_sgs = {
 			.avg_load = UINT_MAX,
 			.group_type = group_overloaded,
@@ -9365,8 +9366,14 @@ find_idlest_group(struct sched_domain *sd, struct task_struct *p, int this_cpu)
 		break;
 
 	case group_has_spare:
+		task_hint = READ_ONCE(p->hint);
+		fork_hint = task_hint &
+			(PR_SCHED_HINT_FORK_SPREAD | PR_SCHED_HINT_FORK_AFFINE);
 #ifdef CONFIG_NUMA
-		if (sd->flags & SD_NUMA) {
+		/*
+		 * If a hint is set, override any NUMA preference behavior.
+		 */
+		if ((sd->flags & SD_NUMA) && !fork_hint) {
 			int imb_numa_nr = sd->imb_numa_nr;
 #ifdef CONFIG_NUMA_BALANCING
 			int idlest_cpu;
@@ -9406,14 +9413,37 @@ find_idlest_group(struct sched_domain *sd, struct task_struct *p, int this_cpu)
 		}
 #endif /* CONFIG_NUMA */
 
+		/*
+		 * FIXME: Currently the system is assumed to be SMT-2
+		 * and that the number of cores in a group can be
+		 * estimated by halving the group_weight. Determine a
+		 * more generic logic for other SMT possibilities or
+		 * derive it at runtime from the topology.
+		 */
+		if ((task_hint & PR_SCHED_HINT_FORK_AFFINE) &&
+		    local_sgs.idle_cpus > local->group_weight / 2)
+			return NULL;
 		/*
 		 * Select group with highest number of idle CPUs. We could also
 		 * compare the utilization which is more stable but it can end
 		 * up that the group has less spare capacity but finally more
 		 * idle CPUs which means more opportunity to run task.
 		 */
-		if (local_sgs.idle_cpus >= idlest_sgs.idle_cpus)
+		if (local_sgs.idle_cpus > idlest_sgs.idle_cpus)
+			return NULL;
+
+		if (local_sgs.idle_cpus == idlest_sgs.idle_cpus) {
+			/*
+			 * In case of a tie between number of idle CPUs and if
+			 * the task hints a benefit from spreading, go with the
+			 * group with the lesser utilization.
+			 */
+			if ((task_hint & PR_SCHED_HINT_FORK_SPREAD) &&
+			    local_sgs.group_util > idlest_sgs.group_util)
+				return idlest;
+
 			return NULL;
+		}
 		break;
 	}
 
-- 
2.25.1

