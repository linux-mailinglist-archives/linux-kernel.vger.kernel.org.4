Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 897E76A6C30
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 13:20:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbjCAMUh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 07:20:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbjCAMU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 07:20:26 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2078.outbound.protection.outlook.com [40.107.237.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1850B36FD6
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 04:20:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W4RYe5igQgDx6XoYSk8vvpQnT+8q7nILPJlTyjK4L+GCQE0Z4LlD0azRWYVEXO+rA0olLi1tmF3m1Gz/YM72DFGbdWxdkQy1zQrjDGt/t2bezpPRp92orT8B6lSfVKZinjwbifHOrtKNbdccUFgdwetVhRHmhC48A4s4MGPv3KGZDwrACr5yuRJ0H1ZQwsq9fQi7KSil+fO5z1sZkY7ayrFJCuZk5RwHKGLYXIJAmUv9rN3diIEQdfqizB5/aXLQ/Kz5zs3D3lsnzsKUEilwheD/zE4MV8kayqHgk8WgkV5NZkH1WBZtrALuxLxO3vi7ZW4rDn8Dc6XY/fVvNnXI1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tDXLvwqwbuijg3/rtfuFEB9A4LWMIALLerkzU7QFDYQ=;
 b=i90zdrBaRfCBGPWdhPv5vU9U0jKSY1tPL6ll3qyu3f6nwS0IHR7Elrxa5GCnaAduMuf60dx3RDm1QnDpc4q0p4DvGLi6/S2CxCKDhxjGeMx7028VDkepNZPBNC2CMWYDX3K8zB5oE0sv2K+eQ7UR4Xb4qKgYqDzyYzjFuwvWAZeR15obO82/DvsrLl4VfQviI6C26gr0QNJTw7oTGF2e6njSLF6H+QtI7qhg4eRQoQE6WJObeUf58vpo/TVdr2bNhWzzaZJzlO3A8Y2sPvPX4N+tVEEHL/XtnPv0aeqR+k3yy5SdZZIdQeEvPtni3AwyhxNYI3he8/yItZb8/s4ZSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
Received: from DS7PR05CA0034.namprd05.prod.outlook.com (2603:10b6:8:2f::35) by
 IA0PR12MB8713.namprd12.prod.outlook.com (2603:10b6:208:48e::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6156.18; Wed, 1 Mar 2023 12:20:22 +0000
Received: from DS1PEPF0000E639.namprd02.prod.outlook.com
 (2603:10b6:8:2f:cafe::61) by DS7PR05CA0034.outlook.office365.com
 (2603:10b6:8:2f::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.18 via Frontend
 Transport; Wed, 1 Mar 2023 12:20:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000E639.mail.protection.outlook.com (10.167.17.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6156.12 via Frontend Transport; Wed, 1 Mar 2023 12:20:21 +0000
Received: from BLR-L-RKODSARA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 1 Mar
 2023 06:20:17 -0600
From:   Raghavendra K T <raghavendra.kt@amd.com>
To:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
CC:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Mel Gorman" <mgorman@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        "David Hildenbrand" <david@redhat.com>, <rppt@kernel.org>,
        Bharata B Rao <bharata@amd.com>,
        Disha Talreja <dishaa.talreja@amd.com>,
        Raghavendra K T <raghavendra.kt@amd.com>
Subject: [PATCH REBASE V3 2/4] sched/numa: Enhance vma scanning logic
Date:   Wed, 1 Mar 2023 17:49:01 +0530
Message-ID: <092f03105c7c1d3450f4636b1ea350407f07640e.1677672277.git.raghavendra.kt@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1677672277.git.raghavendra.kt@amd.com>
References: <cover.1677672277.git.raghavendra.kt@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E639:EE_|IA0PR12MB8713:EE_
X-MS-Office365-Filtering-Correlation-Id: 712bc024-5db1-408b-d395-08db1a4f541a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jXySr1HB2yOBeR3bu2An4Dyr08vgaUZ1V+3NDTwfz722UW6rd5AMRXtFJhKIBVnBhAFvtd44ABYIuTYag4YuU5YdrHahrhn8VfvqfMsRd7Uh2dVYux9vTBLPRUo/GGYAjUjtLKbaKWM2qmYhlA5QRekpX/qwMyr1fBzu3kAjOg9Z5kNITWhyZ0BKtoV5/3GHzLih2MLU9RMLj/hf2I16aqjPl7vVZODsqMGV+5w1ggkO8/nOqg+WBxv+LEXmGLVSz3oKlnL1nPIH3MMZlSp7KIPSG6+aCG7nkQEWqRar5IpjnQ3+TaY7INUgrJBXum2vwy5W7nBL5xOczKXUiAuDXjGaq6Xs14IO29fTKP5cRgjVS7CZH30E6iqzwe3+q8/i1PhohotB/OYcCHLkZZ8LcVkFGcSXHYF7VwBbo2fpHdr2bQOmuFNkEPz8k6yluFj4rN+eKnxVs/QpLEsqpsGsQ4S0kMvTyXCfFaSO5eD+PjQaNF7eOkWe3oy1Ez1HNOT9BwRpKRdQLhi1s+OMPQwM/+FjZfQH9dcsJ9o+ZPfkRGMtU0newVIWS78Sz1WL5rRIAraT8ulEcnaWbJulShb2Hirjzp6WWnYY6w2OzqOitTsKrzg5vki6GiSY36T1ZGe0dYzhbF7TknY2mgyTKWb924SesFSePpjuOM3sdbBl4FSZ8OOyNxcBq4RM5cboDBQpVJBng9P5pl2LLY/O8zXyMNYixGONZQh8B2CQuvnMKRwsFcrbfDLdCNGVEeDNOfvg
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(346002)(39860400002)(136003)(376002)(396003)(451199018)(40470700004)(36840700001)(46966006)(36756003)(41300700001)(40480700001)(5660300002)(8936002)(4326008)(8676002)(2906002)(356005)(36860700001)(82740400003)(81166007)(6666004)(7696005)(478600001)(316002)(54906003)(70586007)(82310400005)(70206006)(83380400001)(110136005)(426003)(47076005)(2616005)(40460700003)(186003)(336012)(16526019)(26005)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2023 12:20:21.6183
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 712bc024-5db1-408b-d395-08db1a4f541a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E639.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8713
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 During the Numa scanning make sure only relevant vmas of the
tasks are scanned.

Before:
 All the tasks of a process participate in scanning the vma
even if they do not access vma in it's lifespan.

Now:
 Except cases of first few unconditional scans, if a process do
not touch vma (exluding false positive cases of PID collisions)
tasks no longer scan all vma

Logic used:
1) 6 bits of PID used to mark active bit in vma numab status during
 fault to remember PIDs accessing vma. (Thanks Mel)

2) Subsequently in scan path, vma scanning is skipped if current PID
had not accessed vma.

3) First two times we do allow unconditional scan to preserve earlier
 behaviour of scanning.

Acknowledgement to Bharata B Rao <bharata@amd.com> for initial patch
to store pid information and Peter Zijlstra <peterz@infradead.org>
(Usage of test and set bit)

Suggested-by: Mel Gorman <mgorman@techsingularity.net>
Signed-off-by: Raghavendra K T <raghavendra.kt@amd.com>
---
 include/linux/mm.h       | 14 ++++++++++++++
 include/linux/mm_types.h |  1 +
 kernel/sched/fair.c      | 19 +++++++++++++++++++
 mm/memory.c              |  3 +++
 4 files changed, 37 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 2cce434a5e55..b7e4484af05b 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1666,6 +1666,16 @@ static inline int xchg_page_access_time(struct page *page, int time)
 	last_time = page_cpupid_xchg_last(page, time >> PAGE_ACCESS_TIME_BUCKETS);
 	return last_time << PAGE_ACCESS_TIME_BUCKETS;
 }
+
+static inline void vma_set_access_pid_bit(struct vm_area_struct *vma)
+{
+	unsigned int pid_bit;
+
+	pid_bit = current->pid % BITS_PER_LONG;
+	if (vma->numab_state && !test_bit(pid_bit, &vma->numab_state->access_pids)) {
+		__set_bit(pid_bit, &vma->numab_state->access_pids);
+	}
+}
 #else /* !CONFIG_NUMA_BALANCING */
 static inline int page_cpupid_xchg_last(struct page *page, int cpupid)
 {
@@ -1715,6 +1725,10 @@ static inline bool cpupid_match_pid(struct task_struct *task, int cpupid)
 {
 	return false;
 }
+
+static inline void vma_set_access_pid_bit(struct vm_area_struct *vma)
+{
+}
 #endif /* CONFIG_NUMA_BALANCING */
 
 #if defined(CONFIG_KASAN_SW_TAGS) || defined(CONFIG_KASAN_HW_TAGS)
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 1cea78f60011..df4e0bc66d17 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -477,6 +477,7 @@ struct vma_lock {
 
 struct vma_numab_state {
 	unsigned long next_scan;
+	unsigned long access_pids;
 };
 
 /*
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 7c2bbc8d618b..9443ae9db028 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -2928,6 +2928,21 @@ static void reset_ptenuma_scan(struct task_struct *p)
 	p->mm->numa_scan_offset = 0;
 }
 
+static bool vma_is_accessed(struct vm_area_struct *vma)
+{
+	/*
+	 * Allow unconditional access first two times, so that all the (pages)
+	 * of VMAs get prot_none fault introduced irrespective of accesses.
+	 * This is also done to avoid any side effect of task scanning
+	 * amplifying the unfairness of disjoint set of VMAs' access.
+	 */
+	if (READ_ONCE(current->mm->numa_scan_seq) < 2)
+		return true;
+
+	return test_bit(current->pid % BITS_PER_LONG,
+				&vma->numab_state->access_pids);
+}
+
 /*
  * The expensive part of numa migration is done from task_work context.
  * Triggered from task_tick_numa().
@@ -3046,6 +3061,10 @@ static void task_numa_work(struct callback_head *work)
 						vma->numab_state->next_scan))
 			continue;
 
+		/* Do not scan the VMA if task has not accessed */
+		if (!vma_is_accessed(vma))
+			continue;
+
 		do {
 			start = max(start, vma->vm_start);
 			end = ALIGN(start + (pages << PAGE_SHIFT), HPAGE_SIZE);
diff --git a/mm/memory.c b/mm/memory.c
index 255b2f4fdd4a..8fac837cde9e 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4647,6 +4647,9 @@ int numa_migrate_prep(struct page *page, struct vm_area_struct *vma,
 {
 	get_page(page);
 
+	/* Record the current PID acceesing VMA */
+	vma_set_access_pid_bit(vma);
+
 	count_vm_numa_event(NUMA_HINT_FAULTS);
 	if (page_nid == numa_node_id()) {
 		count_vm_numa_event(NUMA_HINT_FAULTS_LOCAL);
-- 
2.34.1

