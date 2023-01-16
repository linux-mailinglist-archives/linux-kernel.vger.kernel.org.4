Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE5B666B59B
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 03:25:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231756AbjAPCZw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Jan 2023 21:25:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231674AbjAPCZr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jan 2023 21:25:47 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2068.outbound.protection.outlook.com [40.107.92.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 298B66A79
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 18:25:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fad+dIA9X2Yu9N3mDzVzgGuASiUpov4uLQTx411eL/KdMeWys0R7V7VV9WflUIFYefQcNd2Bo9uYwyWe7zx60grxIx+98qZoKiI4YKECBecnaYXerEziDKhxG6iNJZ0P8nFzRuu9/wcAcluheX5ycg4hxX0iLJxLQPvoawNbemlzIPEN3WlbPfB+4YUrH5lkz8cUO4ESp+oa6gdLrTlbL5Tx6RJOdhUnJtpoOk0O+cKWoG7BtcWdG4qjF4QbKNX07W1mT7tEvBLA+3UWzqo20Hy6XzCrDMS1XO5xyCAOT2rev/im/rWYXeQjq7lW+88fmVdncbr8VDNKHDzjnLINNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DGViPS79Hq47ap0uZ+MNivHipa9LifEmNltzYckCmo8=;
 b=i9LuU6rkITRBQVnMgOaChn1hh07jj3Jq3ie+7PvHv69wAkwZUcExYr6INYeK0Ur7EqwovSoeqzHoIEK06+LH04lfGXPFn6Zdlbk7X00lTrbkIlgWaAXFNHTDRywqOyg1SP/3h0bhs2PG4vZDVO8VwBSiF3b7cGp5onifto3ei/D4f0AmKuVoerorW1LiIESbP1LW/A63iToF0fUcA5yZc/EZqHGQ7y/c3UxE8L0XRq4Erq3tYiZWp9MnzVgmL8VcoYhDtALxHGL80Ld0ouVMRg7+jumqwbfzOqAfTdsDF/2wA39w/ZOTrWmNeXuqq63uoo7hGyYilTj7suLzVvDALg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DGViPS79Hq47ap0uZ+MNivHipa9LifEmNltzYckCmo8=;
 b=oXtykLX8fZiJmwBebKAdglwmTOhXjGVWlovgEXKMcUfYg2LQW3H2e22lcbnMmPmzQ9UIGt7BFIFNOMINWPVxKs0GNAwNVDLNxBAU6I0celtksZUDpDkQm0AeX5KldYzLqFzyxJ/e1t92UE5g8FJ/9oSh4wWN2zO+1Hy5gXHnLuo=
Received: from DS7PR03CA0208.namprd03.prod.outlook.com (2603:10b6:5:3b6::33)
 by CH3PR12MB8583.namprd12.prod.outlook.com (2603:10b6:610:15f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Mon, 16 Jan
 2023 02:25:42 +0000
Received: from DM6NAM11FT079.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b6:cafe::cb) by DS7PR03CA0208.outlook.office365.com
 (2603:10b6:5:3b6::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.19 via Frontend
 Transport; Mon, 16 Jan 2023 02:25:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT079.mail.protection.outlook.com (10.13.173.4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6002.13 via Frontend Transport; Mon, 16 Jan 2023 02:25:41 +0000
Received: from BLR-L-RKODSARA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Sun, 15 Jan
 2023 20:25:32 -0600
From:   Raghavendra K T <raghavendra.kt@amd.com>
To:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
CC:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        "Mel Gorman" <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Vlastimil Babka" <vbabka@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@Oracle.com>,
        "Peter Xu" <peterx@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        xu xin <cgel.zte@gmail.com>, Yu Zhao <yuzhao@google.com>,
        Colin Cross <ccross@google.com>, Arnd Bergmann <arnd@arndb.de>,
        Hugh Dickins <hughd@google.com>,
        Bharata B Rao <bharata@amd.com>,
        Disha Talreja <dishaa.talreja@amd.com>,
        Raghavendra K T <raghavendra.kt@amd.com>
Subject: [RFC PATCH V1 1/1] sched/numa: Enhance vma scanning logic
Date:   Mon, 16 Jan 2023 07:55:09 +0530
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
X-MS-TrafficTypeDiagnostic: DM6NAM11FT079:EE_|CH3PR12MB8583:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f46520e-597b-4237-7c75-08daf768f706
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q2NgDg7gHk/1jsmQaMeDHRqAj9eTT8TG9ONtwdBLRkVtMzxx91uxQ4+AQmT5aEds9hgDuYpP6CCukbX/oZSzRV5Z3ERx7vqjgFTdshcoFvuDrOZCGd9ukTWzVEyds+95V6KmbYUqM1AVvzIJy2knLgWjsrdXFlqFBoE3BUlQBflYhoZz5w9Rolmkqi71uwOSiSdVIv+h1913mfEKOB+8N94zbeUni8DL8kzsGQZkdA99NvV6MxiZUBa1weA4qHJN825prS99a1TzEDjbcGysZjpnkmWFFK6ZkDqv/zUAPXYcVLVHpyZ/T0cOhrUyIiJXHoo4i7SskhXuDz5RzYhrGf6f1dMk80QHo5LjyVgBkmtV7INtHZyTTq5zWNZYnpt8/470bXFdtsMQwFGLhUqrgdFHpK5uOcr4Y+Quh1JYooMOKKVGqG+f8Ss4LGGMTbd0OCDjb3hkUaaQFX1LrsFS5MCOt5xI6lKURXS0KIVmDlDfCLrvclhHLlqtnc04e2ut3JADFF6fshMUGnwS91GOTuYEgphkzvZpoJbISYcgqhgSOCb+3qRHbY2YeujJJawXWydoEpeJA2xz3ANwTCcc0ains6n4Gke+W8zIiABGm7EEhuzPGrpNX3wm0qL7eS1JFj64kwcQOHK74z1KjoHbHFyOBjfEgTJ4aQeGnUhnOzp6/+qIJNah0rQEigLCZHNewMGMTJwUMbynag7ty7QeZbWkuPo2Ed3YjTV34Mv5IJ8GRNCTt0F3MPDd8ToudFxK
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(39860400002)(136003)(396003)(451199015)(36840700001)(46966006)(40470700004)(82740400003)(81166007)(426003)(478600001)(41300700001)(356005)(47076005)(40460700003)(316002)(110136005)(54906003)(2616005)(336012)(186003)(40480700001)(70586007)(7696005)(26005)(70206006)(82310400005)(5660300002)(36860700001)(36756003)(2906002)(6666004)(7416002)(8676002)(4326008)(16526019)(8936002)(83380400001)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2023 02:25:41.8778
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f46520e-597b-4237-7c75-08daf768f706
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT079.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8583
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

