Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C13F96A6C36
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 13:21:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbjCAMVN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 07:21:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbjCAMVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 07:21:10 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on20618.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe59::618])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7E053D092
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 04:20:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mqoo0HZGFpi6Imiu1dqsn+DBThFJ5hXlMoh2capuWFEXB0hjZ5nDdhgLMVtMOcs/3h15w9GxHC75GllCk5yWzJttnjdsOXddB9LcSwz50WGWa3xvaOaWUGcYtEetzns2Dqm7V/+xLz35J7VgkmM4DXW2b/UEDcWer8DOHn1HzpgRbPl3A2afnbeM46vSpeo2xBn18KwoFvGIRXgCM+rXBPGOcRhxhNC3FZ8ebQHVEGKr9OOKfIZKQyAOTP8/wy8CPfdfIEK7gPVoqeBHCoSSrnzNAWiLH1lUGEXsXPJBxU71Hk1Zowl5lhDh0mGfWrfXpQwqnl5qSXKWKvWMM7cubw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xrS+mOKGYPTmQ3CQudaB16CCkEM1wtpv0h3WebetnPQ=;
 b=Od6gmgFPln3BousDU++1kCDiFhLGIRf9jAe5ZCZqFHNgQ/npZcEi8A99gFBB2l45UDRMLcBtuTGNUnTSZhfDI6EpiJU1WnjhJeg8pyvgfL90pKwFcBMWpv8tXRH8NNYryqQScyH2j3lSf8SLOP63ms8pZLa5rIMqhcTyZX6UcI8uYexoNEa7pp86M6Q2wkZxL+5sXhpvs14zt3U/Wzl/x0BqRIhs4CUyzVaJBaYH5kLH2bZK7970BEDkXAnD/Pk1Xdz7O4terGP+KRV2UTwbjoGMtKGfs5Dh9CHwgTwjPGLTRzgVROFELhMvqr5DeQRnS51Cr2ky+yvqSSCS6hyo2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xrS+mOKGYPTmQ3CQudaB16CCkEM1wtpv0h3WebetnPQ=;
 b=5umNEK01ubL4TqDe0KGq3pBYTj3dqnjI20JqKkCMEKIRauU93AWVsTei6ub0h6rlWDHn3BbklSEwm3EO+phP60dJMIpZGrM9/6uvJcifnimP8JNSB43LJXRs2FguIGkATqghRtT3XdfeQnOpJfQ7oZ7rv7nbrmB3hRg2qsyU5vI=
Received: from DM6PR12CA0015.namprd12.prod.outlook.com (2603:10b6:5:1c0::28)
 by CH2PR12MB4151.namprd12.prod.outlook.com (2603:10b6:610:78::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.30; Wed, 1 Mar
 2023 12:20:44 +0000
Received: from DS1PEPF0000E638.namprd02.prod.outlook.com
 (2603:10b6:5:1c0:cafe::b0) by DM6PR12CA0015.outlook.office365.com
 (2603:10b6:5:1c0::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.18 via Frontend
 Transport; Wed, 1 Mar 2023 12:20:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000E638.mail.protection.outlook.com (10.167.17.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6156.12 via Frontend Transport; Wed, 1 Mar 2023 12:20:44 +0000
Received: from BLR-L-RKODSARA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 1 Mar
 2023 06:20:21 -0600
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
Subject: [PATCH REBASE V3 3/4] sched/numa: implement access PID reset logic
Date:   Wed, 1 Mar 2023 17:49:02 +0530
Message-ID: <f7a675f66d1442d048b4216b2baf94515012c405.1677672277.git.raghavendra.kt@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1677672277.git.raghavendra.kt@amd.com>
References: <cover.1677672277.git.raghavendra.kt@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E638:EE_|CH2PR12MB4151:EE_
X-MS-Office365-Filtering-Correlation-Id: b7e09335-fc40-4582-bdfc-08db1a4f615d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tXzauHiLKryFz7iS8anZQ6eCS15J9HLyopJZ4G0CzLso9TG21vYXFzTkhOzZkyAJs21g79dhf4PzUk4BKGD+7fhjIu5M4MFwFOJagCpB7VSxiMOTuu1QaXpbMJsk88oPYIi/5HtEtClgyr3gRxY/xY+aw77V/dRv8qlCR4ZrLluX3E22MPjGEbIri2JiuQSaT+LC9a5PJ+ZP+IeTAZFCvqBaVvZGS1uOAaVqvt5SFfNbuWFEqJaQx394jXym4DsaWCrhGsTrFn3Z+yPzfbRVJGQfcXudbZ1vhpfbmQPCcXktmpoa5/IH7yt3SqpyS8Nx4FG95pRFPGhai7mRHkNXd4w572caOTLueIQ31k+UIwoUz4ZVG5+E8WV6JQY8c75lUL+FrijbVtBOQEEIJGibi0kZsMse8Mk/WfIYRnkZQNJv54CTMRzzgqXVtQ5nnY1B/y8H4oca/iHNoay0kXYFAqbS4twz/QVMocpQLQmNGKhkVtO/+l9o8z/dkhjm0TzWYgmTPiRUO9zPiXVUsKqIxvwmdggMsudzYDDH/nsdJMijhXXxXjEko6O3hEXzH3QQZOEmLv3q59Ju/yU+D0EBiVmdA9dWePBVvSdXRA9QM3hNAmE7BbaqzZ0Fg1PyPz92XgHlqKcygBRB6dkd7rjCOXuANNTWe5CQtlJvBle+LfaCGpoq8aBqwvPB7vK260fvOb6bJEoxh6pI9W7FxgLTYtL3RxDvQdNrZCIKUvlr0KZz0kSUCK+wToU/Vdjv6LuW
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(346002)(376002)(136003)(396003)(451199018)(46966006)(36840700001)(40470700004)(316002)(54906003)(83380400001)(40480700001)(426003)(47076005)(336012)(2616005)(356005)(82310400005)(82740400003)(81166007)(36860700001)(7696005)(478600001)(36756003)(26005)(16526019)(6666004)(186003)(110136005)(40460700003)(2906002)(41300700001)(5660300002)(8936002)(8676002)(4326008)(70206006)(70586007)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2023 12:20:44.0547
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b7e09335-fc40-4582-bdfc-08db1a4f615d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E638.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4151
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 This helps to ensure, only recently accessed PIDs scan the
VMAs.
Current implementation: (idea supported by PeterZ)
 1. Accessing PID information is maintained in two windows.
 access_pids[1] being newest.

 2. Reset old access PID info i.e. access_pid[0] every
(4 * sysctl_numa_balancing_scan_delay) interval after initial
scan delay period expires.

The above interval seemed to be experimentally optimum since it
avoids frequent reset of access info as well as helps clearing
the old access info regularly.
The reset logic is implemented in scan path.

Suggested-by: Mel Gorman <mgorman@techsingularity.net>
Signed-off-by: Raghavendra K T <raghavendra.kt@amd.com>
---
 include/linux/mm.h       |  4 ++--
 include/linux/mm_types.h |  3 ++-
 kernel/sched/fair.c      | 23 +++++++++++++++++++++--
 3 files changed, 25 insertions(+), 5 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index b7e4484af05b..5232ebb34145 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1672,8 +1672,8 @@ static inline void vma_set_access_pid_bit(struct vm_area_struct *vma)
 	unsigned int pid_bit;
 
 	pid_bit = current->pid % BITS_PER_LONG;
-	if (vma->numab_state && !test_bit(pid_bit, &vma->numab_state->access_pids)) {
-		__set_bit(pid_bit, &vma->numab_state->access_pids);
+	if (vma->numab_state && !test_bit(pid_bit, &vma->numab_state->access_pids[1])) {
+		__set_bit(pid_bit, &vma->numab_state->access_pids[1]);
 	}
 }
 #else /* !CONFIG_NUMA_BALANCING */
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index df4e0bc66d17..e17bdd10dc15 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -477,7 +477,8 @@ struct vma_lock {
 
 struct vma_numab_state {
 	unsigned long next_scan;
-	unsigned long access_pids;
+	unsigned long next_pid_reset;
+	unsigned long access_pids[2];
 };
 
 /*
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 9443ae9db028..a93e7a33281f 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -2930,6 +2930,7 @@ static void reset_ptenuma_scan(struct task_struct *p)
 
 static bool vma_is_accessed(struct vm_area_struct *vma)
 {
+	unsigned long pids;
 	/*
 	 * Allow unconditional access first two times, so that all the (pages)
 	 * of VMAs get prot_none fault introduced irrespective of accesses.
@@ -2939,10 +2940,12 @@ static bool vma_is_accessed(struct vm_area_struct *vma)
 	if (READ_ONCE(current->mm->numa_scan_seq) < 2)
 		return true;
 
-	return test_bit(current->pid % BITS_PER_LONG,
-				&vma->numab_state->access_pids);
+	pids = vma->numab_state->access_pids[0] | vma->numab_state->access_pids[1];
+	return test_bit(current->pid % BITS_PER_LONG, &pids);
 }
 
+#define VMA_PID_RESET_PERIOD (4 * sysctl_numa_balancing_scan_delay)
+
 /*
  * The expensive part of numa migration is done from task_work context.
  * Triggered from task_tick_numa().
@@ -3051,6 +3054,10 @@ static void task_numa_work(struct callback_head *work)
 
 			vma->numab_state->next_scan = now +
 				msecs_to_jiffies(sysctl_numa_balancing_scan_delay);
+
+			/* Reset happens after 4 times scan delay of scan start */
+			vma->numab_state->next_pid_reset =  vma->numab_state->next_scan +
+				msecs_to_jiffies(VMA_PID_RESET_PERIOD);
 		}
 
 		/*
@@ -3065,6 +3072,18 @@ static void task_numa_work(struct callback_head *work)
 		if (!vma_is_accessed(vma))
 			continue;
 
+		/*
+		 * RESET access PIDs regularly for old VMAs. Resetting after checking
+		 * vma for recent access to avoid clearing PID info before access..
+		 */
+		if (mm->numa_scan_seq &&
+				time_after(jiffies, vma->numab_state->next_pid_reset)) {
+			vma->numab_state->next_pid_reset = vma->numab_state->next_pid_reset +
+				msecs_to_jiffies(VMA_PID_RESET_PERIOD);
+			vma->numab_state->access_pids[0] = READ_ONCE(vma->numab_state->access_pids[1]);
+			vma->numab_state->access_pids[1] = 0;
+		}
+
 		do {
 			start = max(start, vma->vm_start);
 			end = ALIGN(start + (pages << PAGE_SHIFT), HPAGE_SIZE);
-- 
2.34.1

