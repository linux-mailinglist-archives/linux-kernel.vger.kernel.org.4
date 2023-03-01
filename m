Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C41CB6A6C2F
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 13:20:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229463AbjCAMUZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 07:20:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjCAMUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 07:20:21 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2059.outbound.protection.outlook.com [40.107.94.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D3931B556
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 04:20:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JMjTV+TFmvtj2TTkF5kFKMCp2CLRJXO6xI+DJZyAxoOoPf+D4YPTzj+K9Fi+pvEPt38LD9N/u9Avl4/LFd67XW7r1BGYKyKseaSBxE5WQvUFm5sPSbk55rZmQ/d3xBVULY9FB3Tzh0QSz8yJYnDvG1DGlEQ0lx/obMYo56pleAccASa0SxH98cOx/iJg160Gp9ZKt90avyZclMdqEZdHkEJQytt3gAOVPc6QwHosXU0JwdArB3AG0mygYJ4+cFYCppZlTa13aYSVv61we0R3MptToTXtFRtevHhRCVwNmVm6ht+klLrVi+tSLYmM0NNisA6dGuWARqeGuljfVhhGXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FK+nIUdqOR9KEr8+cJsJk2w1QgWI/Up4YGCy/MVVpRs=;
 b=lCKaZu1onHhJc0OyStm1wfCYqz/k9I3a49UiN78wYm4Ho0tYZqSwEZIGpmxJG2hq8IcHfNAO0QoFxLladWer/W/tPSQQpQ6UQaX4Dh7gaXppqHJguyNb/jrRVa1IG1vt6H0LNr044odLiyAzsSqeFdvYf23QebXsYeRuV+wenZkfdNnMzP/z8SB0A2wShD31k/IlENxVN2tg0X1FJV5c1pf7+q3uzCndzjQvY3DAxdvdUS7sU5N6MdP3qpffBmmGGUqZWHzgWaAffiHNtDQK6akPJoupQ+NsYIyUNhmU3GXv3OybnFUAk7JpdsgomzfvhIygFNclZlwdiV4mnlWc0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FK+nIUdqOR9KEr8+cJsJk2w1QgWI/Up4YGCy/MVVpRs=;
 b=DorsG1lS6n3Vzi/nbCIk5QBI+CtmmHJlvkOV1pNGEk7WpenhLjnwDg83iAvoAZlenhEAChef8oqMleWWydaOZ5Lv8VdKiIQoQKQn1vNCU5CmXVg+WWyIOgWOU4KEbXNMvBB4zap+dPYJyRaVXEI9Vr+CO8bz6xJcx/GtZiugW/A=
Received: from DM6PR12CA0033.namprd12.prod.outlook.com (2603:10b6:5:1c0::46)
 by CH2PR12MB4037.namprd12.prod.outlook.com (2603:10b6:610:7a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.30; Wed, 1 Mar
 2023 12:20:17 +0000
Received: from DS1PEPF0000E638.namprd02.prod.outlook.com
 (2603:10b6:5:1c0:cafe::84) by DM6PR12CA0033.outlook.office365.com
 (2603:10b6:5:1c0::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.18 via Frontend
 Transport; Wed, 1 Mar 2023 12:20:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000E638.mail.protection.outlook.com (10.167.17.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6156.12 via Frontend Transport; Wed, 1 Mar 2023 12:20:17 +0000
Received: from BLR-L-RKODSARA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 1 Mar
 2023 06:20:13 -0600
From:   Raghavendra K T <raghavendra.kt@amd.com>
To:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
CC:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Mel Gorman" <mgorman@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        "David Hildenbrand" <david@redhat.com>, <rppt@kernel.org>,
        Bharata B Rao <bharata@amd.com>,
        Disha Talreja <dishaa.talreja@amd.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Raghavendra K T <raghavendra.kt@amd.com>
Subject: [PATCH REBASE V3 1/4] sched/numa: Apply the scan delay to every new vma
Date:   Wed, 1 Mar 2023 17:49:00 +0530
Message-ID: <7a6fbba87c8b51e67efd3e74285bb4cb311a16ca.1677672277.git.raghavendra.kt@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E638:EE_|CH2PR12MB4037:EE_
X-MS-Office365-Filtering-Correlation-Id: 06abf500-d09c-41ef-e142-08db1a4f51b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iCupr+U8pqM+HeB3EUDY8aiPF6whw0HnzU8F27CU2ulVAlOYYITuzkjld6vRGzY3Il4+sTK9J1kiGU/WniRBRczzLw38vqSfi2zAqTPmtD0fMEb8vCdvO8zY4lq4yXfHLBi8XIqtGhJPZ6P0ts2o67QgHx9YI8/9y2rEVIK/p+00Lrdl46feVc3ckEFPkInLWixYZMDh+Mkd8S+AYXmMH4Baq0J3WEdqTG+p5jqDZJS/r2UUYbJ/GBPXhszzT4KgAHsynFlO5ItZwrXYGDwjLXm1Yf3cgUDxWQ6BIj0oRpM8MMPk+S0sy8tflCpI81qfvD1lHDBkhStmDnojzulO1gZbUV0yJN0ubEusMqOLHq1F4Ixx3xY8ygnXMtMci6HVfGIA5UQV9j5t4/SeVCI5ryyohL56S9R9i0cy1w5PlxzpCLB7bq2mUeN8tkLe8hiwxyhfLFTZFZMG1ix2LTXli3TPtIbfLxRrNiPeMHuV3F0QSRIw3pTbwkKellR7NQp4MISsYoN614MH7VaG11LqoMZ7ufCCZGYRJgo4tL0YSzdWdIkpfBjv7Qa/dXJGZ/Q1KKD2ONAvkGktgl/EdYiBqWIzCdOQObEZeDos8JLevk5Tvb7keXvxwbObWM8IthUnI7pNfkkzh7RO8xhA5R3U20iGgIXtWz9kg8nOq3iFSH7glqo35CmWHo1OghHNajRxRw9pk0A/ASgoKDbSkpZum2+vpyScX8laZ5td22HwPm75l/jf+iL+zW0m1/JUunxL
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(396003)(376002)(136003)(39860400002)(346002)(451199018)(40470700004)(36840700001)(46966006)(356005)(36860700001)(81166007)(82740400003)(36756003)(7696005)(41300700001)(2906002)(40480700001)(5660300002)(8676002)(4326008)(8936002)(82310400005)(70206006)(40460700003)(70586007)(2616005)(16526019)(336012)(186003)(47076005)(83380400001)(26005)(426003)(110136005)(478600001)(316002)(54906003)(6666004)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2023 12:20:17.7888
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 06abf500-d09c-41ef-e142-08db1a4f51b5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E638.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4037
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mel Gorman <mgorman@techsingularity.net>

Currently whenever a new task is created we wait for
sysctl_numa_balancing_scan_delay to avoid unnessary scanning
overhead. Extend the same logic to new or very short-lived VMAs.

(Raghavendra: Add initialization in vm_area_dup())

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
Signed-off-by: Raghavendra K T <raghavendra.kt@amd.com>
---
 include/linux/mm.h       | 16 ++++++++++++++++
 include/linux/mm_types.h |  7 +++++++
 kernel/fork.c            |  2 ++
 kernel/sched/fair.c      | 19 +++++++++++++++++++
 4 files changed, 44 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 3d4bb18dfcb7..2cce434a5e55 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -29,6 +29,7 @@
 #include <linux/pgtable.h>
 #include <linux/kasan.h>
 #include <linux/memremap.h>
+#include <linux/slab.h>
 
 struct mempolicy;
 struct anon_vma;
@@ -626,6 +627,20 @@ struct vm_operations_struct {
 					  unsigned long addr);
 };
 
+#ifdef CONFIG_NUMA_BALANCING
+static inline void vma_numab_state_init(struct vm_area_struct *vma)
+{
+	vma->numab_state = NULL;
+}
+static inline void vma_numab_state_free(struct vm_area_struct *vma)
+{
+	kfree(vma->numab_state);
+}
+#else
+static inline void vma_numab_state_init(struct vm_area_struct *vma) {}
+static inline void vma_numab_state_free(struct vm_area_struct *vma) {}
+#endif /* CONFIG_NUMA_BALANCING */
+
 #ifdef CONFIG_PER_VMA_LOCK
 /*
  * Try to read-lock a vma. The function is allowed to occasionally yield false
@@ -727,6 +742,7 @@ static inline void vma_init(struct vm_area_struct *vma, struct mm_struct *mm)
 	vma->vm_ops = &dummy_vm_ops;
 	INIT_LIST_HEAD(&vma->anon_vma_chain);
 	vma_mark_detached(vma, false);
+	vma_numab_state_init(vma);
 }
 
 /* Use when VMA is not part of the VMA tree and needs no locking */
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 89bbf7d8a312..1cea78f60011 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -475,6 +475,10 @@ struct vma_lock {
 	struct rw_semaphore lock;
 };
 
+struct vma_numab_state {
+	unsigned long next_scan;
+};
+
 /*
  * This struct describes a virtual memory area. There is one of these
  * per VM-area/task. A VM area is any part of the process virtual memory
@@ -565,6 +569,9 @@ struct vm_area_struct {
 #endif
 #ifdef CONFIG_NUMA
 	struct mempolicy *vm_policy;	/* NUMA policy for the VMA */
+#endif
+#ifdef CONFIG_NUMA_BALANCING
+	struct vma_numab_state *numab_state;	/* NUMA Balancing state */
 #endif
 	struct vm_userfaultfd_ctx vm_userfaultfd_ctx;
 } __randomize_layout;
diff --git a/kernel/fork.c b/kernel/fork.c
index 75792157f51a..305f963359dc 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -516,6 +516,7 @@ struct vm_area_struct *vm_area_dup(struct vm_area_struct *orig)
 		return NULL;
 	}
 	INIT_LIST_HEAD(&new->anon_vma_chain);
+	vma_numab_state_init(new);
 	dup_anon_vma_name(orig, new);
 
 	return new;
@@ -523,6 +524,7 @@ struct vm_area_struct *vm_area_dup(struct vm_area_struct *orig)
 
 void __vm_area_free(struct vm_area_struct *vma)
 {
+	vma_numab_state_free(vma);
 	free_anon_vma_name(vma);
 	vma_lock_free(vma);
 	kmem_cache_free(vm_area_cachep, vma);
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 7a1b1f855b96..7c2bbc8d618b 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3027,6 +3027,25 @@ static void task_numa_work(struct callback_head *work)
 		if (!vma_is_accessible(vma))
 			continue;
 
+		/* Initialise new per-VMA NUMAB state. */
+		if (!vma->numab_state) {
+			vma->numab_state = kzalloc(sizeof(struct vma_numab_state),
+				GFP_KERNEL);
+			if (!vma->numab_state)
+				continue;
+
+			vma->numab_state->next_scan = now +
+				msecs_to_jiffies(sysctl_numa_balancing_scan_delay);
+		}
+
+		/*
+		 * Scanning the VMA's of short lived tasks add more overhead. So
+		 * delay the scan for new VMAs.
+		 */
+		if (mm->numa_scan_seq && time_before(jiffies,
+						vma->numab_state->next_scan))
+			continue;
+
 		do {
 			start = max(start, vma->vm_start);
 			end = ALIGN(start + (pages << PAGE_SHIFT), HPAGE_SIZE);
-- 
2.34.1

