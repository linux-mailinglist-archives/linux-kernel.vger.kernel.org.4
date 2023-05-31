Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42B37717573
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 06:26:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234387AbjEaE0d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 00:26:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234056AbjEaE0O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 00:26:14 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19AE5194
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 21:26:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EHp0y3EzSUGFnFbzwUfdrviP/FdV1g7OFrk136YZRkQEeECUBKAvScArz08qikHKbLByV1+O6tCmWLs6nk5qE6Mk1UoVwQBv6hxTWyCemmmrJM9sbD5LhyOVUacFDmcEnAWcds8dblfbFXHaynGDjP8l0b3y/efOzkg8wKZbXMHUSp2Zbud5Y/Q2RHgnQWEhK7GPgA1ReQWO3vdU4g71EcxEeP+eJRWYaR3qItA25o1HqLGCAde2naKsMk3FlHWgg4rxSCXgJCtPEgKxmDQ25H8Qk4S6uWyrIPckS/BLke02ztHHXqNEbrehhuem6z1u/fCEcV/VdA+8yjsR7wXo8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/As/PBtaSVbliupJmvoyzyddZIx9ICCL6mDp0EafHsY=;
 b=iKHqmEbVrRRKBcXkLR4o3vkiwq7C1xtXaPoZ8ftUaSlslO/r5+6jzwJ3jP57R0sqhK3vhYM15requKkiMiAGpJ6QzM69qs/F7lHQyEkabTRwiSDYzTmmhfIC72BMfNExURiyC2GpKRLxJc4VJuRgBwvN0Shh8Vs+bzJUNCCc5lBrdxTvAg3uYw3mmPqXuIBU00MnYisKRi2aAFk8BqBUr5wd5opSy7IwoJLDfFYJJd9gjVB3hhMRcIcNB3icb5LVOhhc3wJlqxeOjZZsC8i042rz6hhKC519BloBc9UYdXWLBaoqzLBJiZ5MtjHp61ats1V6B8eWz0jXr09sVxdwIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/As/PBtaSVbliupJmvoyzyddZIx9ICCL6mDp0EafHsY=;
 b=T/RB9ffYCCZszC7MZhhwsYlsfkDS4m+KtNIHfpOqpgbkehz2g6heD99DWz8jkcPArShroSFgAC7cwlsCDxCCzdulWPCvtMWGS55MM1DXmUkJi02wlHck0kpSHlviZ9XzTHtZ2YdWFQ3ynBrr2G7pCPAd8hnRn7DNpg1soCWwf2A=
Received: from DM6PR11CA0067.namprd11.prod.outlook.com (2603:10b6:5:14c::44)
 by PH0PR12MB7886.namprd12.prod.outlook.com (2603:10b6:510:26e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.18; Wed, 31 May
 2023 04:26:02 +0000
Received: from DM6NAM11FT015.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:14c:cafe::7) by DM6PR11CA0067.outlook.office365.com
 (2603:10b6:5:14c::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23 via Frontend
 Transport; Wed, 31 May 2023 04:26:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT015.mail.protection.outlook.com (10.13.172.133) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.22 via Frontend Transport; Wed, 31 May 2023 04:26:02 +0000
Received: from BLR-L-RKODSARA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 30 May
 2023 23:25:58 -0500
From:   Raghavendra K T <raghavendra.kt@amd.com>
To:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
CC:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Mel Gorman" <mgorman@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        "David Hildenbrand" <david@redhat.com>, <rppt@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Bharata B Rao <bharata@amd.com>,
        Aithal Srikanth <sraithal@amd.com>,
        "kernel test robot" <oliver.sang@intel.com>,
        Raghavendra K T <raghavendra.kt@amd.com>
Subject: [RFC PATCH V3 1/1] sched/numa: Fix disjoint set vma scan regression
Date:   Wed, 31 May 2023 09:55:26 +0530
Message-ID: <8581ca937d4064b3cd138845d5bd418580d177da.1685506205.git.raghavendra.kt@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1685506205.git.raghavendra.kt@amd.com>
References: <cover.1685506205.git.raghavendra.kt@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT015:EE_|PH0PR12MB7886:EE_
X-MS-Office365-Filtering-Correlation-Id: b8ad0177-7e0e-427d-9012-08db618f24a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GyxF2ed525yNG2cyphFRUrSqCx5RMBxIBvhbbcCqGnIOeS5SCPHUlZQqyhiFXqb+285snsO+IC6x+tN4DSgdK+sXQPZWa9s0iXWXgUZqlKE/n/E5i03yh5JVbgLaD/Wr4Rfwf+y4iwB3u06ckKk4AUNfDGucL8YeWxEo4WMD6kDUyZyaIO8QycN5bRUCFh4D0mq+uAZ6n6BiWojv0c0suMSNRbrD/gtLjqEJtWjSm88ULGNjqQcoZ/nWuv5TiOzTAtBjYbJuHee0pVmTy2JCbZQTcjIcBE2/4RZnMsHe2uU6hF90ga54Q7lq+2TBstHng6cICXkgq8BO8HFcUqtbu/wAFjz/sJ3HXb1dOMav1z8QRuF/APYH+ZnvOq5IkvdG19drXZ7ZdSM18pOtpWAj874e/mDd+a/fpme90BTo3F6aBeph8xvYIjU9Mw3ZDt5WbCqypLwWT+qcmGcnmt5zaB9cj5etpHr4EoYupiOdlXUlHb3ztXC5AozWQfDOee3ll7Z35k9ghJfdLZkgkq0gd/EbXe7pFL/eIFeHkC4qakYHd+nSbo0Q6Gt9E57HWSytA4mBKNDk8a/64CrpubzBOr2GWMP1FesB2VkmyWziAYHVd1MJm1m9v8AjWO5idnRCWP+zspygKL6TDpk1E+JFwnpZxc4LnD2SuH+KzlzjH9MwTBl6FUbfQt1hQfQmrNmwrU5c2HdgFTsj8lYrWBAQdJ2SobJHIe6Eb89GuugREduAFif0w0Nps0HkhKTGSfEgEjzIKGRzHXG/iy6ElZkm6JfP8OkSYx4O0b+LL8INBmUvOZFEfC1B3ECKMbhC0BGT
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(39860400002)(346002)(396003)(451199021)(46966006)(40470700004)(36840700001)(36860700001)(70586007)(4326008)(54906003)(110136005)(356005)(82740400003)(70206006)(478600001)(316002)(6666004)(7696005)(41300700001)(40460700003)(186003)(81166007)(2906002)(40480700001)(26005)(16526019)(8676002)(7416002)(966005)(2616005)(82310400005)(83380400001)(36756003)(426003)(336012)(5660300002)(8936002)(47076005)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2023 04:26:02.5127
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b8ad0177-7e0e-427d-9012-08db618f24a2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT015.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7886
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 With the numa scan enhancements [1], only the threads which had previously
accessed vma are allowed to scan.

While this had improved significant system time overhead, there were corner
cases, which genuinely need some relaxation. For e.g.,

1) Concern raised by PeterZ, where if there are N partition sets of vmas
belonging to tasks, then unfairness in allowing these threads to scan could
potentially amplify the side effect of some of the vmas being left
unscanned.

2) Below reports of LKP numa01 benchmark regression.

Currently this is handled by allowing first two scanning unconditional
as indicated by mm->numa_scan_seq. This is imprecise since for some
benchmark vma scanning might itself start at numa_scan_seq > 2.

Solution:
Allow unconditional scanning of vmas of tasks depending on vma size. This
is achieved by maintaining a per vma scan counter, where

f(allowed_to_scan) = f(scan_counter <  vma_size / scan_size)

Result:
numa01_THREAD_ALLOC result on 6.4.0-rc2 (that has numascan enhancement)
                	base-numascan	base		base+fix
real    		1m1.507s	1m23.259s	1m2.632s
user    		213m51.336s	251m46.363s	220m35.528s
sys     		3m3.397s	0m12.492s	2m41.393s

numa_hit 		5615517		4560123		4963875
numa_local 		5615505		4560024		4963700
numa_other 		12		99		175
numa_pte_updates 	1822797		493		1559111
numa_hint_faults 	1307113		523		1469031
numa_hint_faults_local 	612617		488		884829
numa_pages_migrated 	694370		35		584202

Summary: Regression in base is recovered by allowing scanning as required.

[1] https://lore.kernel.org/lkml/cover.1677672277.git.raghavendra.kt@amd.com/T/#t

Fixes: fc137c0ddab2 ("sched/numa: enhance vma scanning logic")
regression.
Reported-by: Aithal Srikanth <sraithal@amd.com>
Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/lkml/db995c11-08ba-9abf-812f-01407f70a5d4@amd.com/T/
Signed-off-by: Raghavendra K T <raghavendra.kt@amd.com>
---
 include/linux/mm_types.h |  1 +
 kernel/sched/fair.c      | 31 ++++++++++++++++++++++++-------
 2 files changed, 25 insertions(+), 7 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 306a3d1a0fa6..992e460a713e 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -479,6 +479,7 @@ struct vma_numab_state {
 	unsigned long next_scan;
 	unsigned long next_pid_reset;
 	unsigned long access_pids[2];
+	unsigned int scan_counter;
 };
 
 /*
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 373ff5f55884..4e71fb58085b 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -2931,17 +2931,30 @@ static void reset_ptenuma_scan(struct task_struct *p)
 static bool vma_is_accessed(struct vm_area_struct *vma)
 {
 	unsigned long pids;
+	unsigned int vma_size;
+	unsigned int scan_threshold;
+	unsigned int scan_size;
+
+	pids = vma->numab_state->access_pids[0] | vma->numab_state->access_pids[1];
+
+	if (test_bit(hash_32(current->pid, ilog2(BITS_PER_LONG)), &pids))
+		return true;
+
+	scan_size = READ_ONCE(sysctl_numa_balancing_scan_size);
+	/* vma size in MB */
+	vma_size = (vma->vm_end - vma->vm_start) >> 20;
+
+	/* Total scans needed to cover VMA */
+	scan_threshold = vma_size / scan_size;
+
 	/*
-	 * Allow unconditional access first two times, so that all the (pages)
-	 * of VMAs get prot_none fault introduced irrespective of accesses.
+	 * Allow the scanning of half of disjoint set's VMA to induce
+	 * prot_none fault irrespective of accesses.
 	 * This is also done to avoid any side effect of task scanning
 	 * amplifying the unfairness of disjoint set of VMAs' access.
 	 */
-	if (READ_ONCE(current->mm->numa_scan_seq) < 2)
-		return true;
-
-	pids = vma->numab_state->access_pids[0] | vma->numab_state->access_pids[1];
-	return test_bit(hash_32(current->pid, ilog2(BITS_PER_LONG)), &pids);
+	scan_threshold = 1 + (scan_threshold >> 1);
+	return (vma->numab_state->scan_counter < scan_threshold);
 }
 
 #define VMA_PID_RESET_PERIOD (4 * sysctl_numa_balancing_scan_delay)
@@ -3058,6 +3071,8 @@ static void task_numa_work(struct callback_head *work)
 			/* Reset happens after 4 times scan delay of scan start */
 			vma->numab_state->next_pid_reset =  vma->numab_state->next_scan +
 				msecs_to_jiffies(VMA_PID_RESET_PERIOD);
+
+			vma->numab_state->scan_counter = 0;
 		}
 
 		/*
@@ -3084,6 +3099,8 @@ static void task_numa_work(struct callback_head *work)
 			vma->numab_state->access_pids[1] = 0;
 		}
 
+		vma->numab_state->scan_counter++;
+
 		do {
 			start = max(start, vma->vm_start);
 			end = ALIGN(start + (pages << PAGE_SHIFT), HPAGE_SIZE);
-- 
2.34.1

