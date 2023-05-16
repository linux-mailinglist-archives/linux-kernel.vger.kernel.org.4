Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09774704924
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 11:26:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231659AbjEPJ0N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 05:26:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231558AbjEPJZk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 05:25:40 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2060b.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e8a::60b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0C3C3AAC
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 02:25:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mhIAI5bUCkTBw1ybremaU6ZU7UYpPy2zJWVEK6AzRjX1eNufj24FWdaDNEcBqvBe7pIMepknKqUl4Rf1lLkAAlkmIb+ScuiJZe8Lq7s1DgohV9RO8X+I/RbPupXhKBQwrH0NLpl4NWx58/wFtr9jAA2Ww29EsLaQ2MoGx0E34UJOFF4AIf7E8lYS1u04Faf/TA9yLrLw34/7ap/OrFfQlsOqRaMsIVEx49RW28MXP2Z5Minh9BpWuNXF1qib6dc8FyN3IxkV+fOb2plx8GJxqeKoVfsiGLi13ttuAysCL9oG+9C40o6FwoAIPCrOCbNdaF9S3y4xTTH8RpF4rFTsPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pnEOg9KENk6RkcHXE75v3hu62NI4b/tyL+3+8m1Exbc=;
 b=VaOLpAiNKYHw6MyP72dJ6jTB+wTySXNQqvtJWDk3Q4ajeXeBXQh7GasyPhc2o8iJnC0+llQV/rAoOZoz00sw/q9HXcYage/pNFKxN3FC08vakk1GkCkEhnWJVh7mn0TogTSxrLsZGI18Z0iWJPFRegSbOlNujfBzldeR3n8nNpzrGO9SIBtCtq5bZB2n/P6gTxo8SRXLJSpzjOW8JBGPVTsRUY98Yg1/Dm1kOPbU8Q3wuKtZPQ8oh4nxsqU9wutUCPaOQ1zn+S9xoGHqmeWdV4fekJ+mf6jngAMDI15mUFyealzp8P/MXV9mDZWnUr+PtG8fgOcmcEo3hyqZ4ERIUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pnEOg9KENk6RkcHXE75v3hu62NI4b/tyL+3+8m1Exbc=;
 b=yg54mvsUuYtfwqtZS28NxuX9Jt9wXG9RK3BqIrCn/yjZEwyYaWsW2h5Zv27dUvkQja1L9XGJe0JnfhBDPVzBdElK7B8/zCIQ/pO2lyNGB3b9lF+SjuMHLhX9x1nOlbeUzAkpd5Lp1TNMLCH+6UxVF9ckGEXb9e2qQluBPlVA6k8=
Received: from BN9P220CA0021.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:13e::26)
 by PH7PR12MB5619.namprd12.prod.outlook.com (2603:10b6:510:136::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Tue, 16 May
 2023 09:19:29 +0000
Received: from BN8NAM11FT114.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13e:cafe::5) by BN9P220CA0021.outlook.office365.com
 (2603:10b6:408:13e::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30 via Frontend
 Transport; Tue, 16 May 2023 09:19:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT114.mail.protection.outlook.com (10.13.177.46) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.15 via Frontend Transport; Tue, 16 May 2023 09:19:29 +0000
Received: from BLR-L-RKODSARA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 16 May
 2023 04:19:24 -0500
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
Subject: [RFC PATCH V2 1/1] sched/numa: Fix disjoint set vma scan regression
Date:   Tue, 16 May 2023 14:49:32 +0530
Message-ID: <b0a8f3490b491d4fd003c3e0493e940afaea5f2c.1684228065.git.raghavendra.kt@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1684228065.git.raghavendra.kt@amd.com>
References: <cover.1684228065.git.raghavendra.kt@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT114:EE_|PH7PR12MB5619:EE_
X-MS-Office365-Filtering-Correlation-Id: a26a456e-ec64-4550-f6ec-08db55eea6c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vTh+DEUX1dy5eEwoKhFAvgf+r7zW9KQpX7a6/X+SU3wF72y4sMStxXA/8cOl9EX4tyRB84GiZCsroR4rDUEAIYANbSIC3lHFjYFJFkGsZ2xP7k9zb58HvYtsT6bsCDfgOVeMiTjtslzGeDisPZLb1LGOb+m14kiMACxbGE7ERCjZqdXrX0OZLg9CIqCLWVeS3GKJlnqOfCfRZHl+utwqFcMyNQQNTw4GHr7n4D4JE8dT7xRTO+gwcG/FKabb53kCwIzLgsR9onhtc5K2SaMs684Aha1PUGz3+hYavZNDL4C8DsO7dxHDWI7hoD31PNlVQc4nI7uBFt7z8ervVJlOelV3+8Yn78szMcTYduPGc96O8jTxPmCgi8sfniXnd0YoCpim5KjYCn+tqSMrfPKKmgBgfVW/dSG5ALVxshV0R5+h4rSfScfQlqrjo7G2rWhdmG4sMA79iUYdWjdALGKfYIQWi0h8uR4xjcRUs1iABdMzF8FvSg0/TzSEUZzyfZBcGWVfAykxpmdSxRxcQOI0kCHKhX9wCu1tvGLC7qAc8gougW6MwNA/QZomg5v+OkxA64QbwuKd8v00323igKAMrhkPUJxsQoscT/3DXa7rVvK7q9UOYmH6xcJ9TVuDaxf6pG4L5nqqjSfpP/PVpscgFjaimmociThE7pCXqnKYXRHbU5J7QfTXeyc96sZ+ui++Hm3YEJqTlv2AhrxRBL5GUiFE7Vr74w+kFtCT+4BwTJwsge55SnHYkC2maEwsoABeZY+5rwbUgOeFZajwyTEkFLTu4/6W2g6Alf5fS8/CdU4EDwRxw2h7NabXxqov010W
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(136003)(39860400002)(396003)(451199021)(36840700001)(40470700004)(46966006)(40460700003)(426003)(4326008)(70586007)(478600001)(70206006)(7696005)(316002)(110136005)(966005)(54906003)(36756003)(83380400001)(336012)(47076005)(186003)(36860700001)(26005)(7416002)(8936002)(8676002)(5660300002)(6666004)(2906002)(81166007)(2616005)(40480700001)(82740400003)(82310400005)(16526019)(356005)(41300700001)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2023 09:19:29.1288
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a26a456e-ec64-4550-f6ec-08db55eea6c7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT114.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5619
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
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

Currently this was handled by allowing first two scanning unconditional
as indicated by mm->numa_scan_seq. This is imprecise since for some
benchmark vma scanning might itself start at numa_scan_seq > 2.

Solution:
Allow unconditional scanning of vmas of tasks depending on vma size. This
is achieved by maintaining a per vma scan counter, where

f(allowed_to_scan) = f(scan_counter <  vma_size / scan_size)

Fixes: fc137c0ddab2 ("sched/numa: enhance vma scanning logic")
regression.

Result:
numa01_THREAD_ALLOC result on 6.4.0-rc1 (that has w/ numascan enhancement)
                base-numascan           base                    base+fix
real            1m3.025s                1m24.163s               1m3.551s
user            213m44.232s             251m3.638s              219m55.662s
sys             6m26.598s               0m13.056s               2m35.767s

numa_hit                5478165         4395752         4907431
numa_local              5478103         4395366         4907044
numa_other                   62             386             387
numa_pte_updates        1989274           11606         1265014
numa_hint_faults        1756059             515         1135804
numa_hint_faults_local   971500             486          558076
numa_pages_migrated      784211              29          577728

Summary: Regression in base is recovered by allowing scanning as required.

[1] https://lore.kernel.org/lkml/cover.1677672277.git.raghavendra.kt@amd.com/T/#t

Reported-by: Aithal Srikanth <sraithal@amd.com>
Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/lkml/db995c11-08ba-9abf-812f-01407f70a5d4@amd.com/T/
Signed-off-by: Raghavendra K T <raghavendra.kt@amd.com>
---
 include/linux/mm_types.h |  1 +
 kernel/sched/fair.c      | 41 ++++++++++++++++++++++++++++++++--------
 2 files changed, 34 insertions(+), 8 deletions(-)

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
index 373ff5f55884..2c3e17e7fc2f 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -2931,20 +2931,34 @@ static void reset_ptenuma_scan(struct task_struct *p)
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
+	scan_threshold = (vma_size / scan_size);
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
+	return (READ_ONCE(vma->numab_state->scan_counter) <= scan_threshold);
 }
 
-#define VMA_PID_RESET_PERIOD (4 * sysctl_numa_balancing_scan_delay)
+#define VMA_PID_RESET_PERIOD		(4 * sysctl_numa_balancing_scan_delay)
+#define DISJOINT_VMA_SCAN_RENEW_THRESH	16
 
 /*
  * The expensive part of numa migration is done from task_work context.
@@ -3058,6 +3072,8 @@ static void task_numa_work(struct callback_head *work)
 			/* Reset happens after 4 times scan delay of scan start */
 			vma->numab_state->next_pid_reset =  vma->numab_state->next_scan +
 				msecs_to_jiffies(VMA_PID_RESET_PERIOD);
+
+			WRITE_ONCE(vma->numab_state->scan_counter, 0);
 		}
 
 		/*
@@ -3068,6 +3084,13 @@ static void task_numa_work(struct callback_head *work)
 						vma->numab_state->next_scan))
 			continue;
 
+		/*
+		 * For long running tasks, renew the disjoint vma scanning
+		 * periodically.
+		 */
+		if (mm->numa_scan_seq && !(mm->numa_scan_seq % DISJOINT_VMA_SCAN_RENEW_THRESH))
+			WRITE_ONCE(vma->numab_state->scan_counter, 0);
+
 		/* Do not scan the VMA if task has not accessed */
 		if (!vma_is_accessed(vma))
 			continue;
@@ -3083,6 +3106,8 @@ static void task_numa_work(struct callback_head *work)
 			vma->numab_state->access_pids[0] = READ_ONCE(vma->numab_state->access_pids[1]);
 			vma->numab_state->access_pids[1] = 0;
 		}
+		WRITE_ONCE(vma->numab_state->scan_counter,
+				READ_ONCE(vma->numab_state->scan_counter) + 1);
 
 		do {
 			start = max(start, vma->vm_start);
-- 
2.34.1

