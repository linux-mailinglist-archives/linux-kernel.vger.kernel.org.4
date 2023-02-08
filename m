Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C84E468E91D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 08:36:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231214AbjBHHg6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 02:36:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231199AbjBHHgo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 02:36:44 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2074.outbound.protection.outlook.com [40.107.220.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0A0531E15
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 23:36:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L3JXANGiO7ULx4UR8fr+ic/O65KGykwk/upSpi9X5AmnAqp1rZShMpVhcKcubRC9z6mHV3VUQRcjd4DXAu5+3SCjQKZ41rd3p+1v9nzbYw0deVaimj+4CESx9QhsqMH44HfXC4WAPfyj/N/IdsItTfrAzbhyiUaOh2FbpusRDabYC6twgRhnN6Fu2+34iyOsStWVozcxYCCF4IQeofILYPPP7LUJaW8O0z92IrZvmh/ppR+c1N5iG7XzuJtjmG3naw9/pFq8H9gm4AjhPYXT9DgT/fMUXvWeL4GMHniHQVpoKfqs2OO58ZImdy+b63w+IykETzCxiPUBHJuoohtJiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ViNAZg1p+8A6g62o4FlB5zKdANwB07NQFEia8b4dS9A=;
 b=OMnWO1KVP4Cp0VYmguQvrPDOqydcLiRwZgL9Ow/VuC/VoHZRT37DP1aN2qbfRcmt0oRORNlZCIZmqovYFP7RTkraGAxcix805b8JxFvUZ4qJk57FZJjl/TJlDFWKpbgmbkcEPZVd8z+iCK7Iv+XtMWP1Pvor9SJPNJhfrbw6/NEiOFIu5NshWhcsMC8bkqgE8FgKsIfXE89WWqVfpP13/9oZBKBGZn7iL58LOiQ3nfmdzqXvQHo/JP7O4ZhVdjwNWmw54M4sK1CZA7g9XP0QT5C1UMBvajWhnZaxotlQpkIRTcOi48I/GYMZG/zeL0yTGIlxMHxZKhH5OXlGu1YonA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ViNAZg1p+8A6g62o4FlB5zKdANwB07NQFEia8b4dS9A=;
 b=jynYEohDEPxn+8NRettW2Nnbs3KboStqvZcvFgmto4Z0JUN6HD7SRW1dp8i7aAODAPgaV7E9zHplTxWEoTEhmPeCQcpSHAUFRJt4+O9NBhNaIjz0JLz9AD5Xs66AXR19/ZYXgnY7vAVkdDl91JCl674B/WWZCXZzRdAMh0ncf0E=
Received: from BN9PR03CA0505.namprd03.prod.outlook.com (2603:10b6:408:130::30)
 by CH2PR12MB4310.namprd12.prod.outlook.com (2603:10b6:610:a9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.17; Wed, 8 Feb
 2023 07:36:38 +0000
Received: from BN8NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:130:cafe::c7) by BN9PR03CA0505.outlook.office365.com
 (2603:10b6:408:130::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.18 via Frontend
 Transport; Wed, 8 Feb 2023 07:36:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT018.mail.protection.outlook.com (10.13.176.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6086.17 via Frontend Transport; Wed, 8 Feb 2023 07:36:37 +0000
Received: from BLR-5CG1133937.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 8 Feb
 2023 01:36:32 -0600
From:   Bharata B Rao <bharata@amd.com>
To:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
CC:     <mgorman@suse.de>, <peterz@infradead.org>, <mingo@redhat.com>,
        <bp@alien8.de>, <dave.hansen@linux.intel.com>, <x86@kernel.org>,
        <akpm@linux-foundation.org>, <luto@kernel.org>,
        <tglx@linutronix.de>, <yue.li@memverge.com>,
        <Ravikumar.Bangoria@amd.com>, Bharata B Rao <bharata@amd.com>
Subject: [RFC PATCH 2/5] x86/ibs: Drive NUMA balancing via IBS access data
Date:   Wed, 8 Feb 2023 13:05:30 +0530
Message-ID: <20230208073533.715-3-bharata@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230208073533.715-1-bharata@amd.com>
References: <20230208073533.715-1-bharata@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT018:EE_|CH2PR12MB4310:EE_
X-MS-Office365-Filtering-Correlation-Id: ce5579fc-c4d7-4c70-047f-08db09a7363c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5G7w4xQ3LiaDDy0exVQK3qNTLtPmW2idKELeFyLFM3W9h1ggDB4jnraqQHAo7jWLN8fDbX+vgtlyPUOot1IAASPPZL7+tl9G+y0GN0TDv1jXh6+EUj2KiesLOM7fF0koqQF09vStMpviF1LhGTcgH1PmthBlifXClQiNTXzSZFz6q6XCMbQpenAQhsN/SbanI8nJVxKmZBazqL3F2RRRVL5QEaavkF1gD5m5cerVG1op5d+n0Q+c7Oco16lf8EEeLBY8s5MtWYg6rgImMkKLOS/uStdgHbWEy7v8J+wNvPm+8I2h18kf0kxXLtM1dHac84NIsXXSMpOLhee5WFBN0oC2j7vIJw2DQOq+xSK+mrpefSGHlGnw4WOWV874QCx8xZnINb5yae24I5/S9Inc5SZ2XsK3xMd46f+eLTdo0GMONVrp3sbhVpYExIwXPhUN3ir9DM5ltlZjJgG0gTZ+YGnK1jXOTM4cl0wiGndxiwquWkVIarpcB9JcHjdGrgyZdfXENTz1xystDIf0QAyY0JSiM8fbJ7g9tAV5FlIrTE5uxrZxfk0vtVCnixW9wPwV+MibJiOTvM2VosBAdzkE6mmsx4oO+s6YZroYrRsHjGsIxLyhCqdOYd3oLnVgBL4QDejmdvO5u+53AicKprtRY8utWt5NOXS8RalQJGNf9gzy4VzhCL6aW9xRuWehTJQzQY8KX69TRDIaI13dzEM9Kme522kbHnXcJ44nN/TA/ZDK6P1eU2rbnrMrb2g2DUQs
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(396003)(376002)(346002)(136003)(39860400002)(451199018)(36840700001)(46966006)(40470700004)(8676002)(4326008)(70586007)(70206006)(316002)(54906003)(110136005)(2906002)(86362001)(82310400005)(36756003)(8936002)(40480700001)(41300700001)(81166007)(7416002)(5660300002)(40460700003)(356005)(1076003)(2616005)(26005)(83380400001)(426003)(16526019)(336012)(36860700001)(186003)(82740400003)(47076005)(478600001)(7696005)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2023 07:36:37.6679
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce5579fc-c4d7-4c70-047f-08db09a7363c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4310
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Feed the page access data obtained from IBS to NUMA balancing
as hint fault equivalents. The existing per-task and per-group
fault stats are now built from IBS-provided page access information.
With this it will not be necessary to scan the address space to
introduce NUMA hinting faults.

Use task_work framework to process the IBS sampled data. Actual
programming of IBS to generate page access information isn't
done yet.

Signed-off-by: Bharata B Rao <bharata@amd.com>
---
 arch/x86/mm/ibs.c             | 38 ++++++++++++++-
 include/linux/migrate.h       |  1 +
 include/linux/sched.h         |  1 +
 include/linux/vm_event_item.h |  1 +
 kernel/sched/fair.c           | 10 ++++
 mm/memory.c                   | 92 +++++++++++++++++++++++++++++++++++
 mm/vmstat.c                   |  1 +
 7 files changed, 143 insertions(+), 1 deletion(-)

diff --git a/arch/x86/mm/ibs.c b/arch/x86/mm/ibs.c
index 411dba2a88d1..adbc587b1767 100644
--- a/arch/x86/mm/ibs.c
+++ b/arch/x86/mm/ibs.c
@@ -1,6 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
 
 #include <linux/init.h>
+#include <linux/migrate.h>
+#include <linux/task_work.h>
 
 #include <asm/nmi.h>
 #include <asm/perf_event.h> /* TODO: Move defns like IBS_OP_ENABLE into non-perf header */
@@ -8,12 +10,30 @@
 
 static u64 ibs_config __read_mostly;
 
+struct ibs_access_work {
+	struct callback_head work;
+	u64 laddr, paddr;
+};
+
+void task_ibs_access_work(struct callback_head *work)
+{
+	struct ibs_access_work *iwork = container_of(work, struct ibs_access_work, work);
+	struct task_struct *p = current;
+
+	u64 laddr = iwork->laddr;
+	u64 paddr = iwork->paddr;
+
+	kfree(iwork);
+	do_numa_access(p, laddr, paddr);
+}
+
 static int ibs_overflow_handler(unsigned int cmd, struct pt_regs *regs)
 {
 	u64 ops_ctl, ops_data3, ops_data2;
 	u64 remote_access;
 	u64 laddr = -1, paddr = -1;
 	struct mm_struct *mm = current->mm;
+	struct ibs_access_work *iwork;
 
 	rdmsrl(MSR_AMD64_IBSOPCTL, ops_ctl);
 
@@ -86,8 +106,24 @@ static int ibs_overflow_handler(unsigned int cmd, struct pt_regs *regs)
 	/* Is phys addr valid? */
 	if (ops_data3 & MSR_AMD64_IBSOPDATA3_PADDR_VALID)
 		rdmsrl(MSR_AMD64_IBSDCPHYSAD, paddr);
-	else
+	else {
 		count_vm_event(IBS_PADDR_INVALID);
+		goto handled;
+	}
+
+	/*
+	 * TODO: GFP_ATOMIC!
+	 */
+	iwork = kzalloc(sizeof(*iwork), GFP_ATOMIC);
+	if (!iwork)
+		goto handled;
+
+	count_vm_event(IBS_USEFUL_SAMPLES);
+
+	iwork->laddr = laddr;
+	iwork->paddr = paddr;
+	init_task_work(&iwork->work, task_ibs_access_work);
+	task_work_add(current, &iwork->work, TWA_RESUME);
 
 handled:
 	return NMI_HANDLED;
diff --git a/include/linux/migrate.h b/include/linux/migrate.h
index 3ef77f52a4f0..4dcce7885b0c 100644
--- a/include/linux/migrate.h
+++ b/include/linux/migrate.h
@@ -216,6 +216,7 @@ void migrate_device_pages(unsigned long *src_pfns, unsigned long *dst_pfns,
 			unsigned long npages);
 void migrate_device_finalize(unsigned long *src_pfns,
 			unsigned long *dst_pfns, unsigned long npages);
+void do_numa_access(struct task_struct *p, u64 laddr, u64 paddr);
 
 #endif /* CONFIG_MIGRATION */
 
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 853d08f7562b..19dd4ee07436 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -2420,4 +2420,5 @@ static inline void sched_core_fork(struct task_struct *p) { }
 
 extern void sched_set_stop_task(int cpu, struct task_struct *stop);
 
+DECLARE_STATIC_KEY_FALSE(hw_access_hints);
 #endif
diff --git a/include/linux/vm_event_item.h b/include/linux/vm_event_item.h
index 1d55e347d16c..2ccc7dee3c13 100644
--- a/include/linux/vm_event_item.h
+++ b/include/linux/vm_event_item.h
@@ -159,6 +159,7 @@ enum vm_event_item { PGPGIN, PGPGOUT, PSWPIN, PSWPOUT,
 		IBS_LADDR_INVALID,
 		IBS_KERNEL_ADDR,
 		IBS_PADDR_INVALID,
+		IBS_USEFUL_SAMPLES,
 #endif
 #endif
 		NR_VM_EVENT_ITEMS
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 0f8736991427..c9b9e62da779 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -47,6 +47,7 @@
 #include <linux/psi.h>
 #include <linux/ratelimit.h>
 #include <linux/task_work.h>
+#include <linux/migrate.h>
 
 #include <asm/switch_to.h>
 
@@ -3125,6 +3126,8 @@ void init_numa_balancing(unsigned long clone_flags, struct task_struct *p)
 	}
 }
 
+DEFINE_STATIC_KEY_FALSE(hw_access_hints);
+
 /*
  * Drive the periodic memory faults..
  */
@@ -3133,6 +3136,13 @@ static void task_tick_numa(struct rq *rq, struct task_struct *curr)
 	struct callback_head *work = &curr->numa_work;
 	u64 period, now;
 
+	/*
+	 * If we are using access hints from hardware (like using
+	 * IBS), don't scan the address space.
+	 */
+	if (static_branch_unlikely(&hw_access_hints))
+		return;
+
 	/*
 	 * We don't care about NUMA placement if we don't have memory.
 	 */
diff --git a/mm/memory.c b/mm/memory.c
index aad226daf41b..79096aba197c 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4668,6 +4668,98 @@ int numa_migrate_prep(struct page *page, struct vm_area_struct *vma,
 	return mpol_misplaced(page, vma, addr);
 }
 
+/*
+ * Called from task_work context to act upon the page access.
+ *
+ * Physical address (provided by IBS) is used directly instead
+ * of walking the page tables to get to the PTE/page. Hence we
+ * don't check if PTE is writable for the TNF_NO_GROUP
+ * optimization, which means RO pages are considered for grouping.
+ */
+void do_numa_access(struct task_struct *p, u64 laddr, u64 paddr)
+{
+	struct mm_struct *mm = p->mm;
+	struct vm_area_struct *vma;
+	struct page *page = NULL;
+	int page_nid = NUMA_NO_NODE;
+	int last_cpupid;
+	int target_nid;
+	int flags = 0;
+
+	if (!mm)
+		return;
+
+	if (!mmap_read_trylock(mm))
+		return;
+
+	vma = find_vma(mm, laddr);
+	if (!vma)
+		goto out_unlock;
+
+	if (!vma_migratable(vma) || !vma_policy_mof(vma) ||
+		is_vm_hugetlb_page(vma) || (vma->vm_flags & VM_MIXEDMAP))
+		goto out_unlock;
+
+	if (!vma->vm_mm ||
+	    (vma->vm_file && (vma->vm_flags & (VM_READ|VM_WRITE)) == (VM_READ)))
+		goto out_unlock;
+
+	if (!vma_is_accessible(vma))
+		goto out_unlock;
+
+	page = pfn_to_online_page(PHYS_PFN(paddr));
+	if (!page || is_zone_device_page(page))
+		goto out_unlock;
+
+	if (unlikely(!PageLRU(page)))
+		goto out_unlock;
+
+	/* TODO: handle PTE-mapped THP */
+	if (PageCompound(page))
+		goto out_unlock;
+
+	/*
+	 * Flag if the page is shared between multiple address spaces. This
+	 * is later used when determining whether to group tasks together
+	 */
+	if (page_mapcount(page) > 1 && (vma->vm_flags & VM_SHARED))
+		flags |= TNF_SHARED;
+
+	last_cpupid = page_cpupid_last(page);
+	page_nid = page_to_nid(page);
+
+	/*
+	 * For memory tiering mode, cpupid of slow memory page is used
+	 * to record page access time.  So use default value.
+	 */
+	if ((sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING) &&
+	    !node_is_toptier(page_nid))
+		last_cpupid = (-1 & LAST_CPUPID_MASK);
+	else
+		last_cpupid = page_cpupid_last(page);
+
+	target_nid = numa_migrate_prep(page, vma, laddr, page_nid, &flags);
+	if (target_nid == NUMA_NO_NODE) {
+		put_page(page);
+		goto out;
+	}
+
+	/* Migrate to the requested node */
+	if (migrate_misplaced_page(page, vma, target_nid)) {
+		page_nid = target_nid;
+		flags |= TNF_MIGRATED;
+	} else {
+		flags |= TNF_MIGRATE_FAIL;
+	}
+
+out:
+	if (page_nid != NUMA_NO_NODE)
+		task_numa_fault(last_cpupid, page_nid, 1, flags);
+
+out_unlock:
+	mmap_read_unlock(mm);
+}
+
 static vm_fault_t do_numa_page(struct vm_fault *vmf)
 {
 	struct vm_area_struct *vma = vmf->vma;
diff --git a/mm/vmstat.c b/mm/vmstat.c
index c7a9d0d9ade8..33738426ae48 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1408,6 +1408,7 @@ const char * const vmstat_text[] = {
 	"ibs_invalid_laddr",
 	"ibs_kernel_addr",
 	"ibs_invalid_paddr",
+	"ibs_useful_samples",
 #endif
 #endif
 #endif /* CONFIG_VM_EVENT_COUNTERS || CONFIG_MEMCG */
-- 
2.25.1

