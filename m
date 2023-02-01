Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5C96686129
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 09:04:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232018AbjBAIEC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 03:04:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232030AbjBAIDs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 03:03:48 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2076.outbound.protection.outlook.com [40.107.223.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A6225D122
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 00:03:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QutHDQm4lZeAIrwxYF/HoNq/20PqkqrHp+UedaZawYjNZfMVLUGMahVGSeIwQkpgGs0mpXNZRqCh/WlcqU3UdfJePrtjOJgb+AV+NDyq19nYXlU0v35hQNjDpfzcreIRrU3h5yVjz1UObAz+jds8X7Zpt7df4TZv2hBVgC4A7yJI0dHMjnXm9HBJ0mjaeS0UXY0gy4Ib5mVbYrGNocplsUBu3kHnsvGZKtb+D+GhVT/knKyeRkSYCdd/VqIUlzOaJU3pV7vpd4IlNpn8y06YtSo95Qj2eNvsDJ4IHIA7Gt11isAdUW9FamhAZaOrSpWnTbrRF4EwoasZUbzdqF8M2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zBy421iEXPoI1DU2317/qdpzKhPgWFnxaUG/6sW3lQg=;
 b=EVxB//Q5DkKMXQ+ICFbhLggcbgDfTtefYMDneP9KRL360VFdla2R3Uf4Vm8sVVx8gebO+PoTLQN8RmW1ETaKAV7qbCI7uSXivdGubmjpUdnbt96PkBQat+aiAHegartWGH/bpEV1jf8U6ILc3IUOa7deaCx/nJtUjgQ9/cWxDlxj+tY7btoPH/nx+aMh+/6lqB8nWA4C7K/2mtMWoK9NVvfzdA2lqoasdHiJbeitutXFPZ5oNNSDVlAaljxKwA5bamCQIPbfCe2md+mtKOUwwJa70ROfMf7GhNwDQHRxQKG5vpiyar1oXHIker9wiBIXX3LvwfAfXSEKwjwnMXiNgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zBy421iEXPoI1DU2317/qdpzKhPgWFnxaUG/6sW3lQg=;
 b=qirlsF8c/7kHm5TSItSbvRRqT6avHT5eRJREx0qNRCRuqsknuODdeUwxfE79Kx/tRwUrv6CpkRz2EHutgBB80NaBe6hUzYBAUMPyOXZ84sceCFCz2NiDP6yOsu7dZMKC6VE6qbSPxRHVuhKakwG4KRIwJsUtBZStMk+pMd4g7hE=
Received: from BN1PR14CA0014.namprd14.prod.outlook.com (2603:10b6:408:e3::19)
 by MN0PR12MB6272.namprd12.prod.outlook.com (2603:10b6:208:3c0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.38; Wed, 1 Feb
 2023 08:03:41 +0000
Received: from BN8NAM11FT086.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e3:cafe::fd) by BN1PR14CA0014.outlook.office365.com
 (2603:10b6:408:e3::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.38 via Frontend
 Transport; Wed, 1 Feb 2023 08:03:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT086.mail.protection.outlook.com (10.13.176.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6064.22 via Frontend Transport; Wed, 1 Feb 2023 08:03:41 +0000
Received: from BLR-L-RKODSARA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 1 Feb
 2023 02:03:29 -0600
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
Subject: [PATCH V2 3/3] sched/numa: Reset the accessing PID information periodically
Date:   Wed, 1 Feb 2023 13:32:22 +0530
Message-ID: <b0f273113fedffb02f9b1358c88813ff355a81d6.1675159422.git.raghavendra.kt@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1675159422.git.raghavendra.kt@amd.com>
References: <cover.1675159422.git.raghavendra.kt@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT086:EE_|MN0PR12MB6272:EE_
X-MS-Office365-Filtering-Correlation-Id: 753a8f99-9e26-4f55-bbcb-08db042ad528
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oLTh+cidC2YJSLzJPpFtDSWZ3aa4tbq+BHJD3eBC6XHLkMqyP9hHdLxDGiybeu5SHHs/kpch6WSBZhoXfUFK5xYGVaPOfwpkY/94OX9RiWssyqd9f9gb+TwEmz2ZLq58Ef2blCJxcQN3jO5l3XXwNQgyGike9bC8tmDCDzIdf8ScSMObuW/nq69xTH0h0PInmlUjH3SwHLXDaquVLALw23NPkhKM2hoVrmpNpQm5pfEUprNrM2+ddxBzwU7wcELSL/pzWU4MP6TxkQ+wXtyP+9Ed3papyn+MhAH6RpVvbjfa+dfdaBa/TSu5UBUbi9pDa987wufya1V50YG7e91qHLbq/snFoqj0m6hf7YRUnGqhQ4WoHlaDjMcP/4ycYQtOCCyJnI5tMLHiTH6P1t0sA8rGYqRreldX6xuMWlVaZ9BRtENHtqTO6/gfkZg0P+I9NIq7Jbxu/ziJnU3DlJJXbpnF8HH8hTlWlWfMuv3tEnIz2DOodjXTQyNtvH5HTTxjGUPmbnF9aLHwQP2IuWRZLTtd4BWX5+FqM+BL15qADgK1iv/iYaJCCDfleHHx6586LSrf/2s7NfR5hThK/bX2e8AlB3ii+6CkqQtrb4WrzqkeNEhRuOGDuF01hw4XksVZUvAbaGtFC1eqjZijvxWVZsoLsUrFz8b1y2VQ0U5/DCEidpIovQekiK+STLU+kpSuX1r7+tfitM1G1MG0Q8A+2LYBij/w1RoOuDUE3ikwaJJCjc5pWqLnWxJ6Rw15ws5Q
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(346002)(39860400002)(376002)(396003)(136003)(451199018)(46966006)(40470700004)(36840700001)(356005)(81166007)(82740400003)(40480700001)(82310400005)(36756003)(40460700003)(336012)(110136005)(426003)(7696005)(316002)(54906003)(47076005)(2616005)(6666004)(478600001)(26005)(16526019)(186003)(41300700001)(36860700001)(70206006)(70586007)(5660300002)(4326008)(83380400001)(2906002)(8676002)(8936002)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2023 08:03:41.3942
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 753a8f99-9e26-4f55-bbcb-08db042ad528
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT086.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6272
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 This helps to ensure, only recently accessed PIDs scan the
VMAs.

Current implementation:
 Reset accessing PIDs every (4 * sysctl_numa_balancing_scan_delay)
interval after initial scan delay period expires. The reset logic
is implemented in scan path

Suggested-by: Mel Gorman <mgorman@techsingularity.net>
Signed-off-by: Raghavendra K T <raghavendra.kt@amd.com>
---
Some of the potential ideas for clearing the accessing PIDs

1) Flag to indicate phase in life cycle of vma and tie with timestamp (reuse next_scan or so)

VMA life cycle

t1         t2         t3                    t4         t5                   t6
|<-  DS  ->|<-  US  ->|<-        CS       ->|<-  US  ->|<-        CS       ->|
flags used to indicate whether we are in DS/CS/US phase

DS (delay scan): Initial phase where scan is avoided for new VMA
US (unconditional scan): Brief period where scanning is allowed irrespective of task faulting the VMA
CS (conditional scan) :  Longer conditiona scanning phase where task scanning is allowed only for VMA of interest  


2) Maintain duplicate list of accessing PIDs to keep track of history of access. and switch/reset. use OR operation during iteration

 Two lists of PIDs maintained. At regular interval old list is reset and we make current list as old list
At any point of time tracking of PIDs accessing VMA is determined by ORing list1 and list2  

accessing_pids_list1 <-  current list
accessing_pids_list2 <-  old list

3) Maintain per vma numa_seq also
Currently numa_seq (how many times we are scanning entire set of VMAs) is maintained at mm level.
Having numa_seq (almost like how many times the current VMA considered for scanning) per VMA may be helpful
in some context (for e.g., whether we need to allow VMA scanning unconditionally for a newly created VMA).

4) Reset accessing PIDs at regular intervals (current implementation)

t1       t2         t3         t4         t5         t6
|<- DS ->|<-  CS  ->|<-  CS  ->|<-  CS  ->|<-  CS  ->|

The current implementation resets accessing PIDs every 4*scan_delay intervals after initial scan delay
time expires. The reset logic is implemented in scan path

 include/linux/mm_types.h |  1 +
 kernel/sched/fair.c      | 17 +++++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 980a6a4308b6..08a007744ea1 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -437,6 +437,7 @@ struct anon_vma_name {
 
 struct vma_numab {
 	unsigned long next_scan;
+	unsigned long next_pid_reset;
 	unsigned long accessing_pids;
 };
 
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 3505ae57c07c..14db6d8a5090 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -2928,6 +2928,8 @@ static bool vma_is_accessed(struct vm_area_struct *vma)
 	return vma->numab->accessing_pids & (1UL << active_pid_bit);
 }
 
+#define VMA_PID_RESET_PERIOD (4 * sysctl_numa_balancing_scan_delay)
+
 /*
  * The expensive part of numa migration is done from task_work context.
  * Triggered from task_tick_numa().
@@ -3035,6 +3037,10 @@ static void task_numa_work(struct callback_head *work)
 
 			vma->numab->next_scan = now +
 				msecs_to_jiffies(sysctl_numa_balancing_scan_delay);
+
+			/* Reset happens after 4 times scan delay of scan start */
+			vma->numab->next_pid_reset =  vma->numab->next_scan +
+				msecs_to_jiffies(VMA_PID_RESET_PERIOD);
 		}
 
 		/*
@@ -3047,6 +3053,17 @@ static void task_numa_work(struct callback_head *work)
 		if (!vma_is_accessed(vma))
 			continue;
 
+		/*
+		 * RESET accessing PIDs regularly for old VMAs. Resetting after checking
+		 * vma for recent access to avoid clearing PID info before access..
+		 */
+		if (mm->numa_scan_seq &&
+				time_after(jiffies, vma->numab->next_pid_reset)) {
+			vma->numab->next_pid_reset =  vma->numab->next_pid_reset +
+				msecs_to_jiffies(VMA_PID_RESET_PERIOD);
+			vma->numab->accessing_pids = 0;
+		}
+
 		do {
 			start = max(start, vma->vm_start);
 			end = ALIGN(start + (pages << PAGE_SHIFT), HPAGE_SIZE);
-- 
2.34.1

