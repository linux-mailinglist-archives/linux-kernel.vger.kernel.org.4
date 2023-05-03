Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 871CA6F4EBC
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 04:07:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbjECCGq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 22:06:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjECCGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 22:06:43 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2059.outbound.protection.outlook.com [40.107.93.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F22119BE
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 19:06:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HD8HeAy/i88DWSkG6wfyuBbUrB2m3xS5Sti6djynH3AjcdEkZRtjWeYCmFssOwOaacygPxLkAw5rLwd8czC0647UfG+F5/m8YsClKotoq6sqdWOcgNyvNfQ0r/Q/Vid9fi2n5stC4V4AAfR969l/UZZboQn7QHaEQF0EHGLYofUXZAnIEPUdIi3Ez49kqfAzsRzcabpvLtw55yG44USozsCDteiOb8Z/VQZAFoJTnIwmnvqM0co0jqHo/4droTZrD65NB6dEhT4ZHzHdyfATjtdBYSwSzWR8YPOdcf9YbXLYBa305Kl+HjPT0TUnQKDTUaLhiISuV7t/3AV8EPQ1UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XRFZzU6RWuHttsW+R6U0rWTSI9QV998SO9eAEjJvhs0=;
 b=kTQj9uT6vf+Z6YdHxnG5iJSzERfWQgDekahSBh0OjHNws7aIl9s1dejIFs7lj57ZrqjHDr8147GN2cUdAavAHMO6k4M79ZnGZvfRz2I716z/X2x4AcqktL/907+K06lI9kgC4bb6VgAOoPTo4c20Jks9AgZzlqLtO5LbU+6ET25e1HZzouRzh7jHvqv9FjwVZnTQNchCKqbFaAiX9uROvq5/6TQtwoLI8vczysZXwDMy26UEj+D6ACaMjqZgjLndbiccf0OgzEZzN5jMyzz6eBDZjTKWhhvinQw0ZGKXlc+nEN/4DK5AFSJpavhgdJ6mG1F6LMsA6bvftEoH0r8a2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XRFZzU6RWuHttsW+R6U0rWTSI9QV998SO9eAEjJvhs0=;
 b=1EQOKnSJ8TQhWcOkcnUGphbfkYzMDGvn6/htBYVdutzbRlQXRRUwYexucICLXcb1rofi+5khDgicK27OQ7mRMkLPcax/ecfjUiVmpRNaznwIL5C4iYkeumdEBPkANpnQde+ei0KiGkcA4CU2Z5IVR0lZQ4o+ijEmwKiWmJrkTeM=
Received: from DS7PR03CA0021.namprd03.prod.outlook.com (2603:10b6:5:3b8::26)
 by LV2PR12MB6014.namprd12.prod.outlook.com (2603:10b6:408:170::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.24; Wed, 3 May
 2023 02:06:37 +0000
Received: from DM6NAM11FT100.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b8:cafe::a7) by DS7PR03CA0021.outlook.office365.com
 (2603:10b6:5:3b8::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.31 via Frontend
 Transport; Wed, 3 May 2023 02:06:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT100.mail.protection.outlook.com (10.13.172.247) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6363.21 via Frontend Transport; Wed, 3 May 2023 02:06:36 +0000
Received: from BLR-L-RKODSARA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 2 May
 2023 21:06:32 -0500
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
        Raghavendra K T <raghavendra.kt@amd.com>
Subject: [RFC PATCH V1 1/2] sched/numa: Introduce per vma scan counter
Date:   Wed, 3 May 2023 07:35:48 +0530
Message-ID: <abd037023141f25f79c6bbbb801c8405e4c449a1.1683033105.git.raghavendra.kt@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1683033105.git.raghavendra.kt@amd.com>
References: <cover.1683033105.git.raghavendra.kt@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT100:EE_|LV2PR12MB6014:EE_
X-MS-Office365-Filtering-Correlation-Id: ca225477-f148-458f-8270-08db4b7b06b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GaWWE2a8aH4wq1brpUM3aZy651lHgYS9qioOGFgkFKO8ONZpuS0qZxu/wAYlMQnqScm4Ka7JQvmZfKgkQC73cdyo0BCfsTEB9wwpK2SzqxAsSr7vrG8RoY+HR2zd5eKhDoYtnUnObDh8wb1i8pi+skofl4VDVSTGA+pVQF61jxdSUttbocsOPx1xz9PWiQHfLPvozNVS4LzUvFC0wJraK9YhgUdlPJQ7yKpj2rHM8divMvNvbczp3MSRoXZ8owe95r4R/5BYKjXNYyh1/GH750hNDDtUyint+c9CPwaV7YwF8dpVE9urbCTuQb4ZxR3SAQVL3EOfHwYcmYhoDK5Qr94nWoowh2fhwKr1uNBWN2GqsWjJvNtcqnhQhUPALTI/+BgVlWysfztLJ8Y2362PzzyXRqXdQLCOX61h6TXez/7H8Lhmc5WlUS0Xdwe6oFKHykbKIuRFEoeLX/QBryCB1QXCiib0rXurfjzm8seNn8cHUJcK+L1Y2UOu/camWbNG7mB4ZYcrYPqsRpEPgaxQnwfJEMQvNrcB35Y/UpAnqoc5UqOtHPh7PcUeeGhcSGt+7nx/DTHypbAGA6xH/0eioAsBVcTodjdpow4X5uKp8xRmguMmGZ7aFuXXt7FE3dGcYUiesS5QIr6waglcRQun4YN+zBspfQ83Sd5dNi2v9+EDnleAoQcoiY9OMCSR2L0zZtTIFJ5gNBsPS/RMfi8lRbFjN+QWzE4zR71iTiJK6X9lQOf1qQEuGmds2O5+tuaB
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(346002)(136003)(396003)(451199021)(36840700001)(40470700004)(46966006)(81166007)(82740400003)(356005)(7696005)(26005)(6666004)(82310400005)(336012)(83380400001)(47076005)(426003)(70586007)(36860700001)(16526019)(186003)(2616005)(8936002)(36756003)(2906002)(40460700003)(5660300002)(8676002)(478600001)(110136005)(70206006)(54906003)(316002)(7416002)(41300700001)(4326008)(40480700001)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2023 02:06:36.8157
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ca225477-f148-458f-8270-08db4b7b06b9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT100.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB6014
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

With the recent numa scan enhancements, only the tasks which had
previously accessed vma are allowed to scan.

While this has improved significant system time overhead, there are
corner cases, which genuinely needs some relaxation for e.g., concern
raised by PeterZ where unfairness amongst the theread belonging to
disjoint set of VMSs can potentially amplify the side effects of vma
regions belonging to some of the tasks being left unscanned.

To address this, allow scanning for first few times with a per vma
counter.

Signed-off-by: Raghavendra K T <raghavendra.kt@amd.com>
---
 include/linux/mm_types.h |  1 +
 kernel/sched/fair.c      | 30 +++++++++++++++++++++++++++---
 2 files changed, 28 insertions(+), 3 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 3fc9e680f174..f66e6b4e0620 100644
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
index a29ca11bead2..3c50dc3893eb 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -2928,19 +2928,38 @@ static void reset_ptenuma_scan(struct task_struct *p)
 	p->mm->numa_scan_offset = 0;
 }
 
+/* Scan 1GB or 4 * scan_size */
+#define VMA_DISJOINT_SET_ACCESS_THRESH		4U
+
 static bool vma_is_accessed(struct vm_area_struct *vma)
 {
 	unsigned long pids;
+	unsigned int windows;
+	unsigned int scan_size = READ_ONCE(sysctl_numa_balancing_scan_size);
+
+	if (scan_size < MAX_SCAN_WINDOW)
+		windows = MAX_SCAN_WINDOW / scan_size;
+
+	/* Allow only half of the windows for disjoint set cases */
+	windows /= 2;
+
+	windows = max(VMA_DISJOINT_SET_ACCESS_THRESH, windows);
+
 	/*
-	 * Allow unconditional access first two times, so that all the (pages)
-	 * of VMAs get prot_none fault introduced irrespective of accesses.
+	 * Make sure to allow scanning of disjoint vma set for the first
+	 * few times.
+	 * OR At mm level allow unconditional access first two times, so that
+	 * all the (pages) of VMAs get prot_none fault introduced irrespective
+	 * of accesses.
 	 * This is also done to avoid any side effect of task scanning
 	 * amplifying the unfairness of disjoint set of VMAs' access.
 	 */
-	if (READ_ONCE(current->mm->numa_scan_seq) < 2)
+	if (READ_ONCE(vma->numab_state->scan_counter) < windows ||
+		READ_ONCE(current->mm->numa_scan_seq) < 2)
 		return true;
 
 	pids = vma->numab_state->access_pids[0] | vma->numab_state->access_pids[1];
+
 	return test_bit(hash_32(current->pid, ilog2(BITS_PER_LONG)), &pids);
 }
 
@@ -3058,6 +3077,8 @@ static void task_numa_work(struct callback_head *work)
 			/* Reset happens after 4 times scan delay of scan start */
 			vma->numab_state->next_pid_reset =  vma->numab_state->next_scan +
 				msecs_to_jiffies(VMA_PID_RESET_PERIOD);
+
+			WRITE_ONCE(vma->numab_state->scan_counter, 0);
 		}
 
 		/*
@@ -3084,6 +3105,9 @@ static void task_numa_work(struct callback_head *work)
 			vma->numab_state->access_pids[1] = 0;
 		}
 
+		WRITE_ONCE(vma->numab_state->scan_counter,
+				READ_ONCE(vma->numab_state->scan_counter) + 1);
+
 		do {
 			start = max(start, vma->vm_start);
 			end = ALIGN(start + (pages << PAGE_SHIFT), HPAGE_SIZE);
-- 
2.34.1

