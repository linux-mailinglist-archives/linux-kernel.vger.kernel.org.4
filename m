Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAEB5686127
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 09:03:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232001AbjBAIDo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 03:03:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231985AbjBAIDh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 03:03:37 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D63D53D912
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 00:03:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EaisipyW1DNecXe/OL8nAK6OSSIwpNOx0jfBHm7SEMEY9I3la64UaqB+2679vkJ1I/X6Wm4OAnFV4eja279oqg6F71z4lcTfsmmmmAw3OP50+z9u3Fx9U1mB1nopLbhKC2NAvit5ul0zHffO5q7uycBk2GQUq4Ph0TysYd8rt50jnLj5PMcdr7GF3GNXWKQs4/Q9Os5gXdSg5tBP2HHLmgYwNHkrwoX6wmpEV0mMNb/oXiOPnvhIDlXM56IoQReG2fHo3N5XANltCgrSVzBuGVLv1w/XcK5uyWEP3KxVdSzU/gHz9F5CpTxesA0BVm1Q2udIiEMrAmFePDglZVppUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1R9KAiSIKM0EdbYofwwJVHMq44auVW63YveLhtMSQ3A=;
 b=fEpiMe2C2Xd93Q4f0+OwDRVDogTu5jIwL8ROm7N68EYy1wuKsgiNSzWyAVwG4AWQp6bYv/XauLL9YnHuug3R+ZkPhur3htRYUTNLWzOC6Cz9Jr6sFJUfkM3+Gx1vIRE918iBZABglicdB3jBWluxcCzWIPJZYObwj9smbMFztqPC/BCFxHi9SPxw/SBthQNYrAp3yxdCIaVEzHdDgRKA+NBeiCwvwO2mBKhlXY6ILIrGTOmKgBtQcgg/mt7DOe1pwlnaXcKyUPktVndFjtrEKkYvU7n66ZTbfX4tFg/eT6XV363RWzYKra89OPZ4LbQzr80+/AkQhfwEiq/DRl4YwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1R9KAiSIKM0EdbYofwwJVHMq44auVW63YveLhtMSQ3A=;
 b=TtZGqDs1IjOIhDWRY8F4GtSlIuDzjxWQq9V96wz5C88B+zMctmpv9PpPg0Y8kZxdeJ/t5aflF15zs/cJo8QLyhAwvlgbepVLWBQr6Tfewa5bC6/XppcyiEuHaerWVi72GxA2nDnMbtXCB9ghkg67RNeudzwJ8Vt55Br0d2YLs8s=
Received: from BN1PR12CA0029.namprd12.prod.outlook.com (2603:10b6:408:e1::34)
 by CH3PR12MB7689.namprd12.prod.outlook.com (2603:10b6:610:14d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36; Wed, 1 Feb
 2023 08:03:29 +0000
Received: from BN8NAM11FT096.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e1:cafe::ee) by BN1PR12CA0029.outlook.office365.com
 (2603:10b6:408:e1::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.24 via Frontend
 Transport; Wed, 1 Feb 2023 08:03:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT096.mail.protection.outlook.com (10.13.177.195) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6064.24 via Frontend Transport; Wed, 1 Feb 2023 08:03:29 +0000
Received: from BLR-L-RKODSARA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 1 Feb
 2023 02:03:25 -0600
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
Subject: [PATCH V2 2/3] sched/numa: Enhance vma scanning logic
Date:   Wed, 1 Feb 2023 13:32:21 +0530
Message-ID: <5f0872657ddb164aa047a2231f8dc1086fe6adf6.1675159422.git.raghavendra.kt@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT096:EE_|CH3PR12MB7689:EE_
X-MS-Office365-Filtering-Correlation-Id: 84e0c807-f189-4def-00f7-08db042ace20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1x5Eufv38AZdDH+X32cME7v+8pJxC7VkM+4RaTgfaFTEGV+5Hmh59KNIC6uH7TaaloDWI+XpkEslufPnVS9HVJouLjrm5i2diGoO6gSmRky022Yl94Q+pZkUaCAnbJmll0nAfxlT66qcNYrivpR8bZbYYDd772Kdip0gEbLbtczngrLLYs+T+XRt5Uhvf7dbPcobVbx2iZzBosMCNEO7PqEyTATMotHLYcFyG/nNUmVXdtOGBS8QaSusXbdW0iDR8RURSV2edkvkYpYLNjKgmYhQtR1HoAdlk7QZ785P3txKCOzkUO/kOAXdffwc9u3/t05JpV7EuljVjtu/wyxXdAqlnccRwaX0++BIJ36ZeQQFj45frhMSpkOBXTRWjItTknNrnoKbQ7r8RarJvcigu3Ot/WVd5Ar4zt+g1goWhfvF/FvjVC1JlImGsbeUK/5raAGeqKgeytcjbnynmX6ht6wMF89EvWiY0ZUM73Ry1/pwyinvN11Vib8/b4dFUBkb1mjl+HV2vmPYlSxOZSun4yhEIjorMw9VPcEMzfTJ3kYXJ/3bbgAENyi5rfZGtgfHeCuDVuLrhI0YSKJfwc/4z3YRQnz+XF1GgzJuYFFoRBOmmVTpxD5foh2HpG67YyucvrF3kwA0NxilSEkeoqntFoASK9jmvCO1RnFbj/VwSUSrhAUS5nbO4+oqe2sQ0iK/SNYTAOfGslx6GxG/PDMl36ER4BX9hON07cRL/FZCjKOuKQluvoRoJfAsIE5ex0Ux
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(396003)(346002)(376002)(136003)(39860400002)(451199018)(40470700004)(36840700001)(46966006)(8676002)(81166007)(36860700001)(356005)(82740400003)(70206006)(316002)(36756003)(82310400005)(8936002)(5660300002)(4326008)(110136005)(41300700001)(70586007)(2906002)(40460700003)(2616005)(336012)(40480700001)(83380400001)(426003)(7696005)(478600001)(47076005)(26005)(186003)(16526019)(6666004)(54906003)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2023 08:03:29.5929
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 84e0c807-f189-4def-00f7-08db042ace20
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT096.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7689
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
tasks no longer scan all vma.

Logic used:
1) 6 bits of PID used to mark active bit in vma numab status during
 fault to remember PIDs accessing vma. (Thanks Mel)

2) Subsequently in scan path, vma scanning is skipped if current PID
had not accessed vma.

3) First two times we do allow unconditional scan to preserve earlier
 behaviour of scanning.

Acknowledgement to Bharata B Rao <bharata@amd.com> for initial patch
to store pid information.

Suggested-by: Mel Gorman <mgorman@techsingularity.net>
Signed-off-by: Raghavendra K T <raghavendra.kt@amd.com>
---
 include/linux/mm.h       | 14 ++++++++++++++
 include/linux/mm_types.h |  1 +
 kernel/sched/fair.c      | 15 +++++++++++++++
 mm/huge_memory.c         |  1 +
 mm/memory.c              |  1 +
 5 files changed, 32 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 74d9df1d8982..489422942482 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1381,6 +1381,16 @@ static inline int xchg_page_access_time(struct page *page, int time)
 	last_time = page_cpupid_xchg_last(page, time >> PAGE_ACCESS_TIME_BUCKETS);
 	return last_time << PAGE_ACCESS_TIME_BUCKETS;
 }
+
+static inline void vma_set_active_pid_bit(struct vm_area_struct *vma)
+{
+	unsigned int active_pid_bit;
+
+	if (vma->numab) {
+		active_pid_bit = current->pid % BITS_PER_LONG;
+		vma->numab->accessing_pids |= 1UL << active_pid_bit;
+	}
+}
 #else /* !CONFIG_NUMA_BALANCING */
 static inline int page_cpupid_xchg_last(struct page *page, int cpupid)
 {
@@ -1430,6 +1440,10 @@ static inline bool cpupid_match_pid(struct task_struct *task, int cpupid)
 {
 	return false;
 }
+
+static inline void vma_set_active_pid_bit(struct vm_area_struct *vma)
+{
+}
 #endif /* CONFIG_NUMA_BALANCING */
 
 #if defined(CONFIG_KASAN_SW_TAGS) || defined(CONFIG_KASAN_HW_TAGS)
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index e84f95a77321..980a6a4308b6 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -437,6 +437,7 @@ struct anon_vma_name {
 
 struct vma_numab {
 	unsigned long next_scan;
+	unsigned long accessing_pids;
 };
 
 /*
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 060b241ce3c5..3505ae57c07c 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -2916,6 +2916,18 @@ static void reset_ptenuma_scan(struct task_struct *p)
 	p->mm->numa_scan_offset = 0;
 }
 
+static bool vma_is_accessed(struct vm_area_struct *vma)
+{
+	unsigned int active_pid_bit;
+
+	if (READ_ONCE(current->mm->numa_scan_seq) < 2)
+		return true;
+
+	active_pid_bit = current->pid % BITS_PER_LONG;
+
+	return vma->numab->accessing_pids & (1UL << active_pid_bit);
+}
+
 /*
  * The expensive part of numa migration is done from task_work context.
  * Triggered from task_tick_numa().
@@ -3032,6 +3044,9 @@ static void task_numa_work(struct callback_head *work)
 		if (mm->numa_scan_seq && time_before(jiffies, vma->numab->next_scan))
 			continue;
 
+		if (!vma_is_accessed(vma))
+			continue;
+
 		do {
 			start = max(start, vma->vm_start);
 			end = ALIGN(start + (pages << PAGE_SHIFT), HPAGE_SIZE);
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 811d19b5c4f6..d908aa95f3c3 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1485,6 +1485,7 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf)
 	bool was_writable = pmd_savedwrite(oldpmd);
 	int flags = 0;
 
+	vma_set_active_pid_bit(vma);
 	vmf->ptl = pmd_lock(vma->vm_mm, vmf->pmd);
 	if (unlikely(!pmd_same(oldpmd, *vmf->pmd))) {
 		spin_unlock(vmf->ptl);
diff --git a/mm/memory.c b/mm/memory.c
index 8c8420934d60..2ec3045cb8b3 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4718,6 +4718,7 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
 	bool was_writable = pte_savedwrite(vmf->orig_pte);
 	int flags = 0;
 
+	vma_set_active_pid_bit(vma);
 	/*
 	 * The "pte" at this point cannot be used safely without
 	 * validation through pte_unmap_same(). It's of NUMA type but
-- 
2.34.1

