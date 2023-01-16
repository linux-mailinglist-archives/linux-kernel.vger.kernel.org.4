Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1004A66B549
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 02:36:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231739AbjAPBgs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Jan 2023 20:36:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231714AbjAPBgl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jan 2023 20:36:41 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2083.outbound.protection.outlook.com [40.107.223.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC08D6585
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 17:36:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WlGNRgk22heYPNbXlMTi3TdpDCFlWwpsS7SwmxMdeJscZXrS+wPEInOmQJsRjT6fZ6dLxVCcvdeYXw4Bnronamx4oIaeGRDjN7oQiqKFXpqYCbYCPPbrFfYurDdI8dxfRfTIBE+WfQxr41tNLAGS9a/FjiDVqkD9GZz8VUO0WXQXjCPJ70154eictphMEkiaYv3qTPKiH3SupRfyiBhUiuiRY4uo2kbO3rgp7ktsu/2Zf1WUu6GFs6f53K8df5I/M5LMHlpYwy2pqxSCQGE4lOlbHXG6KzqRKeaGRQZUVOKBJZxrFJBL97uZ5s+FRYMGEUmwTOk9XZYqpQWhXJeC7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DGViPS79Hq47ap0uZ+MNivHipa9LifEmNltzYckCmo8=;
 b=ak/aDtSFcyQDd4lH4K70S+xFhCRC7DszwsKETMrWW9HOhFHy7AaeapMgD3eFwiGGE6X0GA35TIHWUISY+NFYYfSmoX0BMQ/8P4f+y+wOGmszDgsriiNAmGPkZa8tXokPDxB536DTLT/1unTUlMCI9ICLdi49eNwdJUfXoUL6BJhEDd1Wlx+EHQM0PqiHE9i545SGmQJaKD6E899431J6eUuRP6aWzb+j53g/b0ukqnHBCegv8hjosVjKwKQ4tMTY+8sAXuc8gU+9KZMiAVcr16MdaUGoEqsiJ2hnPvxQ51n+PHYIP8+mtMLpqUjzmUi4jo+l2ivp2qxNlkHJmcl0DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DGViPS79Hq47ap0uZ+MNivHipa9LifEmNltzYckCmo8=;
 b=l5ZYbObUzt99q3r3vXdkG7XnQj/01M7otSwstdE4l3fmQKaydRT1uPtDE0pXY2jCsMNPgc+2cWNRrJv30R/u5+ZpNn8mcYxYzkc0D493A2r03/zCjEkObn676VHdXK7Bruog8CxRDsqTntp/jvO7HsLPv9ygYdClmjsw9vyac1c=
Received: from MW2PR16CA0012.namprd16.prod.outlook.com (2603:10b6:907::25) by
 IA1PR12MB8189.namprd12.prod.outlook.com (2603:10b6:208:3f0::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Mon, 16 Jan
 2023 01:36:37 +0000
Received: from CO1NAM11FT047.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:0:cafe::46) by MW2PR16CA0012.outlook.office365.com
 (2603:10b6:907::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.19 via Frontend
 Transport; Mon, 16 Jan 2023 01:36:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT047.mail.protection.outlook.com (10.13.174.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6002.13 via Frontend Transport; Mon, 16 Jan 2023 01:36:36 +0000
Received: from BLR-L-RKODSARA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Sun, 15 Jan
 2023 19:36:28 -0600
From:   Raghavendra K T <raghavendra.kt@amd.com>
To:     = <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        --cc=Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        "Valentin Schneider" <vschneid@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@Oracle.com>,
        Peter Xu <peterx@redhat.com>,
        "David Hildenbrand" <david@redhat.com>,
        xu xin <cgel.zte@gmail.com>, Yu Zhao <yuzhao@google.com>,
        Colin Cross <ccross@google.com>, Arnd Bergmann <arnd@arndb.de>,
        Hugh Dickins <hughd@google.com>,
        Bharata B Rao <bharata@amd.com>,
        Disha Talreja <dishaa.talreja@amd.com>
CC:     Raghavendra K T <raghavendra.kt@amd.com>
Subject: [RFC PATCH V1 1/1] sched/numa: Enhance vma scanning logic
Date:   Mon, 16 Jan 2023 07:05:34 +0530
Message-ID: <67bf778d592c39d02444825c416c2ed11d2ef4b2.1673610485.git.raghavendra.kt@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1673610485.git.raghavendra.kt@amd.com>
References: <cover.1673610485.git.raghavendra.kt@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT047:EE_|IA1PR12MB8189:EE_
X-MS-Office365-Filtering-Correlation-Id: 8495d533-7a2b-45d1-67db-08daf7621ba7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p/9lSMPmrWmKrO96Rt1f74PaxbW0TA2QfEhdk6DdofoGZaDAioqBhhmXzR9YETsE5tkhWK7zUgu5V1k+O7EGwNWXrhP6x6Bf1vb+Xrom1XmNfwytBekDXs86c2CJxxHJqq81ZOl9rRqN78yJ7lAscaoHnouU3oMI0yy17VnVwZr1d9/Oveo73j/pe1MwQpPj0MaqNBeiXn+SHPVvzurgEF8qvHrTAjdKUoKY39oQ63PLl3BZzuZDlSff2ZI9s8qzpSNNmrtPPUOgus/KThldm0a6tPeMu0E5enVxJtTJOoLpL8l8SaiK88TBOI0MeON/ndf2wpI1m0LhP7B+7TZDJkXolqH1exKorN/XHsTTxDo97+u0UDkbzmxjfgP325ETm96dscgETJYalY4phOJBsHgG9es327RQF6Pf3gomQ9CTkpQoNPZuED1l7it6nGbWMOo4+UWfKttA93V39+b7/Yszc1lkNWRDJhik5NY+0F2Mk5Hb7IriMXHi9oVYXb7uidf+aD6PRFCXCXTU59WT6dm5DPWC9qssK96C8of31DP/72w0Ht5RPBZ1FDbMOwxirKBD+a3HTuMNCtdarcND/zZImJJy0H2puAE0cwijm5CX4rFESAj9AMEhZg6HOkRXOHncjehlH3fll1PB0hokjYI33Kn0t76Ult8fs7uNsVI+f/peTfFWBGgaTo5MbqSXN4cdm0q6luRNE6E2UGnmz83sOnBLJYIsxLJBI/eWrHViyRzIq4rBoq/zk4K/Yh/tUZcwRZaYWpzpaWi8xMWQFhnLqg4438kcjZtE6LyWTK0=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(39860400002)(346002)(376002)(451199015)(46966006)(36840700001)(40470700004)(36756003)(36860700001)(7416002)(6666004)(2906002)(70206006)(82310400005)(5660300002)(83380400001)(8936002)(8676002)(16526019)(4326008)(921005)(82740400003)(356005)(41300700001)(81166007)(47076005)(478600001)(426003)(70586007)(336012)(186003)(40480700001)(7696005)(26005)(40460700003)(2616005)(316002)(110136005)(6636002)(36900700001)(83996005)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2023 01:36:36.7439
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8495d533-7a2b-45d1-67db-08daf7621ba7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT047.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8189
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 During the Numa scanning make sure only relevant vmas of the
tasks are scanned.

Logic:
1) For the first two time allow unconditional scanning of vmas
2) Store recent 4 unique tasks (last 8bits of PIDs) accessed the vma.
  False negetives in case of collison should be fine here.
3) If more than 4 pids exist assume task indeed accessed vma to
 to avoid false negetives

Co-developed-by: Bharata B Rao <bharata@amd.com>
(initial patch to store pid information)

Suggested-by: Mel Gorman <mgorman@techsingularity.net>
Signed-off-by: Bharata B Rao <bharata@amd.com>
Signed-off-by: Raghavendra K T <raghavendra.kt@amd.com>
---
 include/linux/mm_types.h |  2 ++
 kernel/sched/fair.c      | 32 ++++++++++++++++++++++++++++++++
 mm/memory.c              | 21 +++++++++++++++++++++
 3 files changed, 55 insertions(+)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 500e536796ca..07feae37b8e6 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -506,6 +506,8 @@ struct vm_area_struct {
 	struct mempolicy *vm_policy;	/* NUMA policy for the VMA */
 #endif
 	struct vm_userfaultfd_ctx vm_userfaultfd_ctx;
+	unsigned int accessing_pids;
+	int next_pid_slot;
 } __randomize_layout;
 
 struct kioctx_table;
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index e4a0b8bd941c..944d2e3b0b3c 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -2916,6 +2916,35 @@ static void reset_ptenuma_scan(struct task_struct *p)
 	p->mm->numa_scan_offset = 0;
 }
 
+static bool vma_is_accessed(struct vm_area_struct *vma)
+{
+	int i;
+	bool more_pids_exist;
+	unsigned long pid, max_pids;
+	unsigned long current_pid = current->pid & LAST__PID_MASK;
+
+	max_pids = sizeof(unsigned int) * BITS_PER_BYTE / LAST__PID_SHIFT;
+
+	/* By default we assume >= max_pids exist */
+	more_pids_exist = true;
+
+	if (READ_ONCE(current->mm->numa_scan_seq) < 2)
+		return true;
+
+	for (i = 0; i < max_pids; i++) {
+		pid = (vma->accessing_pids >> i * LAST__PID_SHIFT) &
+			LAST__PID_MASK;
+		if (pid == current_pid)
+			return true;
+		if (pid == 0) {
+			more_pids_exist = false;
+			break;
+		}
+	}
+
+	return more_pids_exist;
+}
+
 /*
  * The expensive part of numa migration is done from task_work context.
  * Triggered from task_tick_numa().
@@ -3015,6 +3044,9 @@ static void task_numa_work(struct callback_head *work)
 		if (!vma_is_accessible(vma))
 			continue;
 
+		if (!vma_is_accessed(vma))
+			continue;
+
 		do {
 			start = max(start, vma->vm_start);
 			end = ALIGN(start + (pages << PAGE_SHIFT), HPAGE_SIZE);
diff --git a/mm/memory.c b/mm/memory.c
index 8c8420934d60..fafd78d87a51 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4717,7 +4717,28 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
 	pte_t pte, old_pte;
 	bool was_writable = pte_savedwrite(vmf->orig_pte);
 	int flags = 0;
+	int pid_slot = vma->next_pid_slot;
 
+	int i;
+	unsigned long pid, max_pids;
+	unsigned long current_pid = current->pid & LAST__PID_MASK;
+
+	max_pids = sizeof(unsigned int) * BITS_PER_BYTE / LAST__PID_SHIFT;
+
+	/* Avoid duplicate PID updation */
+	for (i = 0; i < max_pids; i++) {
+		pid = (vma->accessing_pids >> i * LAST__PID_SHIFT) &
+			LAST__PID_MASK;
+		if (pid == current_pid)
+			goto skip_update;
+	}
+
+	vma->next_pid_slot = (++pid_slot) % max_pids;
+	vma->accessing_pids &= ~(LAST__PID_MASK << (pid_slot * LAST__PID_SHIFT));
+	vma->accessing_pids |= ((current_pid) <<
+			(pid_slot * LAST__PID_SHIFT));
+
+skip_update:
 	/*
 	 * The "pte" at this point cannot be used safely without
 	 * validation through pte_unmap_same(). It's of NUMA type but
-- 
2.34.1

