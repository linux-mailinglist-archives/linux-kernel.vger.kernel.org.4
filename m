Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C80306A5271
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 05:51:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbjB1Evz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 23:51:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbjB1Evx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 23:51:53 -0500
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2089.outbound.protection.outlook.com [40.107.101.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 979812887D
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 20:51:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ghAqonIqz7BbwH9VhodpgROfavqUfG1YsyLYxl/PiZakQ4LqM2fqG4tJgKEe3HEZi7c9hU9NRgY0m836MEo7axZd1Md8i8D4387VVsWRT5dwvk/tOAok6Ku0KyHPmX00mH8rZ+Jl6fMypx5NxW6kAjM96rTccFXEOc46BgxrdGqnLH1d+jWQkaUb/qegB5VoF6Cf8Fte+aNLdVFla8M/O8mKtmJY18oCXpcQf+w7JRv95TSuBAjVdS27Ig0bYQyKZcD3m+dsW0aGqrpaLEte1HgLVQjaLGj5eLnTKQ2V9yaT2ZHmsR2c1/lX1XjGpCB4k5SHjtk2JuKWWPPm5EETTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8uk+B5aAIEoEtArS6ZbOd9S+1f2u55Ig79YNUgY/D0U=;
 b=CYa4gzwEQgyXKabCm9s71bt7iXc44bBjdUBnMeZYlE9/lWI2UQ0xCZOfVzgXVNn3dFQhZHN+AS3CNHf0Pi6GT+qv5AGGPCO/DKgPZHOIjlNYHyOFR8cFVrFwJ5QYamFXEJR+SoTdyRy2vIAXSmvhsynrEWVy7KJ9nYbbP7nlJGLgtZ0NDbLgeuLEB/R6OTdDBXmsc90dlu4F8S6F/xqx8zstYctnk+Q0hsJgoUDuhKtELSQrLcZF4M3aokvpyfkDdNAM4lpjGksIqVkaNxvJyAtK7KOZdgUwrIGTPiqH5pPwACHpb6zxzcwjqpimCh/F6RdgttA1U5H/BiRAExsIkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8uk+B5aAIEoEtArS6ZbOd9S+1f2u55Ig79YNUgY/D0U=;
 b=QJ17y+GvfSnSPPZH3oqZ2nYtM/HSKbJk6sMgjivB8bkAKxJU3BNoG6rberOzk2t1bsSGuobtKFQbufjLnNKwINGRVSBquZIt7EVY0IutOZv95Y5dvJ4mtBhDPZngqzplyD4nDvp69ZuAM5yzqa7Blvzs8vfuisjtI0xUDiG86Aw=
Received: from MW4PR03CA0323.namprd03.prod.outlook.com (2603:10b6:303:dd::28)
 by CY8PR12MB7363.namprd12.prod.outlook.com (2603:10b6:930:51::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.29; Tue, 28 Feb
 2023 04:51:41 +0000
Received: from CO1NAM11FT040.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:dd:cafe::eb) by MW4PR03CA0323.outlook.office365.com
 (2603:10b6:303:dd::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.29 via Frontend
 Transport; Tue, 28 Feb 2023 04:51:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT040.mail.protection.outlook.com (10.13.174.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6156.17 via Frontend Transport; Tue, 28 Feb 2023 04:51:40 +0000
Received: from BLR-L-RKODSARA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 27 Feb
 2023 22:51:34 -0600
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
Subject: [PATCH V3 2/4] sched/numa: Enhance vma scanning logic
Date:   Tue, 28 Feb 2023 10:20:20 +0530
Message-ID: <b3eebd2c87cd8fbaa7bdc45d68c70ba6db57ca70.1677557481.git.raghavendra.kt@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1677557481.git.raghavendra.kt@amd.com>
References: <cover.1677557481.git.raghavendra.kt@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT040:EE_|CY8PR12MB7363:EE_
X-MS-Office365-Filtering-Correlation-Id: 42f6652f-98e9-48d2-9a56-08db19477ba9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o+PHmVvHK+CkANAn3yHvYQPV1SW4XB/dSatLsMTIRN3mqu13xl3Dc7thz43dMDwpxorEeYvQEiW9qLjl7jM5xCK3+Dp8YT1PUbqvil/5QAgU5MuXvLvVO9lMv/EcdNkCjz0oIT5AM4LqMadJn2+1/+qEmFOBSsOKcRMehtyKYjJk654EBxotZADEaFSbGAZKhrGuyyJMrlgTdORpj3JtDpL/4fhRKiulVc5METEUtgm3p9U8ZwqYyDLpnfVhvIpklzJQ0bNqGfCJRv+dXycgNeUIQ5lpibADfgHPXxnYcOawowhQAZxkn56d0KvYhSMnpay4F70Hp4OjPfZKT0dXfokjN/LgTt1iu5amvjj0B7aRM4Zwo+t9TOy1s86/RvQUH1EEFdFJ83I2Ox6bJHTbetnXwFbJXxkw4ZZrQpF4VEAJyjyMYAcvVGpxJmNcmDgtIh+0Y/AutcdJY9x4tencEApe4aKfMd3dszQLFG/mLUwxGwfDgqYK0dCUtRYnmguDFFIUKWdxjXe0M6q3CdicM11zc8ilgrxRLggOW/6JGs2Ixkf6TOUHi5BHeLLjdB2npCBnTK88g9VgOXSs0mGc7bIeGNvUoOvMBPmgDgXVBCtA0cFtYE76Lwo/SO8HmuYCZcNzXEQru7C5b+LMqsUYTRTwsKYOzipOLRozQ3R/N6hDFZzwMOYDKbUuHVihghGxsIqHkflezfVidBon75IFuT307g+7DgtYn/EeRSHrjdLM81HSSiz7N1xoHwkBqpFT
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(376002)(136003)(39860400002)(346002)(396003)(451199018)(40470700004)(46966006)(36840700001)(54906003)(16526019)(186003)(26005)(356005)(316002)(40480700001)(36756003)(478600001)(5660300002)(7696005)(2906002)(40460700003)(8936002)(6666004)(110136005)(426003)(47076005)(36860700001)(70206006)(83380400001)(8676002)(4326008)(82310400005)(2616005)(70586007)(336012)(81166007)(82740400003)(41300700001)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2023 04:51:40.9736
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 42f6652f-98e9-48d2-9a56-08db19477ba9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT040.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7363
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
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
index 41cc8997d4e5..097680aaca1e 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1388,6 +1388,16 @@ static inline int xchg_page_access_time(struct page *page, int time)
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
@@ -1437,6 +1447,10 @@ static inline bool cpupid_match_pid(struct task_struct *task, int cpupid)
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
index a4a1093870d3..582523e73546 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -437,6 +437,7 @@ struct anon_vma_name {
 
 struct vma_numab_state {
 	unsigned long next_scan;
+	unsigned long access_pids;
 };
 
 /*
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index e39c36e71cec..05490cb2d5c6 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -2916,6 +2916,21 @@ static void reset_ptenuma_scan(struct task_struct *p)
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
@@ -3034,6 +3049,10 @@ static void task_numa_work(struct callback_head *work)
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
index 8c8420934d60..150c03a3419c 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4698,6 +4698,9 @@ int numa_migrate_prep(struct page *page, struct vm_area_struct *vma,
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

