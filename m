Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D87568E91E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 08:37:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231304AbjBHHhH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 02:37:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231232AbjBHHg4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 02:36:56 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2087.outbound.protection.outlook.com [40.107.94.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75CF2213C
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 23:36:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W/1oo5aZfjIYzZIXXNpj5NSRuFEmAeI7wA+mrspqDZCNK2nKW5q3AGr9nkPP1+LMJ9EvALNCgZ/wFbhSEGgMemDgPJVoMviWfkVfWeCIl998x1DvxTXcu/g4htXJwZu3NVQUndHvd3nWnFDywR/KWfHrWDXKOXt8eBFhYKJpT4yuEeaWf/jFl035iBar0FMgp4UEv5gRL8VEV1HF269OoB/GjVPUrelzoMER7QpglH6jNYTTDagKdCkX+YkiWtIGTmnZZwmOmIk4MeOKKTVjYBPw+6WAIXyas0adSySCBaVk1FhmnhfuDFa94mCBYuQxQbAHzWIp1UpCyMYzJuRyMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MdjzojHcuBT96abEwzKozCOPIPJAXDc3x8XJ/bPfy5Q=;
 b=k7DA+t6UglK+1Q+c9VK3ZnFgRi6g7w0ty0OGJOcFatc9inttjcWmIP8c16761gjP93kgRRf3OEGvguYZ0gUw0LlMEpG8gZVNfFtum8DvbCvn/CKK/YRxXTADD/JsAAM/Jo+hH/VWvqMmNkS7Gyvym3ZjB1kO/3G/3pcRKsf2ffkmb41oN2HceuVm5qFNokahQDyVcKLdZPXuplM4kKsV7ODjqGvXCF+FKSMR5zpffpAkyvvKn06mjYzy3b9j85AYl0eVQV1O2KnZf+FYOZymI5BwEQa3Fpaoctw2LV+KwmsDYWoHyL+dK0PwqBk5/aXS+9Vwvy1dnOleEOzi/kSEHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MdjzojHcuBT96abEwzKozCOPIPJAXDc3x8XJ/bPfy5Q=;
 b=vIoOqa4mvMhnwt7c9P4c9z1Ys0wh9nq+NxBSf7EVsPkeOVlBRxplLZ4WHsOSOjdAikzJi8jqzdKY/dfVAkJhrE49wJ/MXuEDejTbMQWr7ltffgt1Tup+wfYnDJwN+z6Xpze7x6m+ir2+uT3xsKhN02toNYeIkfEDR9zeJsOJGHs=
Received: from BN1PR10CA0021.namprd10.prod.outlook.com (2603:10b6:408:e0::26)
 by DS7PR12MB5766.namprd12.prod.outlook.com (2603:10b6:8:75::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.34; Wed, 8 Feb
 2023 07:36:42 +0000
Received: from BN8NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e0:cafe::b5) by BN1PR10CA0021.outlook.office365.com
 (2603:10b6:408:e0::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.17 via Frontend
 Transport; Wed, 8 Feb 2023 07:36:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT031.mail.protection.outlook.com (10.13.177.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6086.17 via Frontend Transport; Wed, 8 Feb 2023 07:36:42 +0000
Received: from BLR-5CG1133937.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 8 Feb
 2023 01:36:37 -0600
From:   Bharata B Rao <bharata@amd.com>
To:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
CC:     <mgorman@suse.de>, <peterz@infradead.org>, <mingo@redhat.com>,
        <bp@alien8.de>, <dave.hansen@linux.intel.com>, <x86@kernel.org>,
        <akpm@linux-foundation.org>, <luto@kernel.org>,
        <tglx@linutronix.de>, <yue.li@memverge.com>,
        <Ravikumar.Bangoria@amd.com>, Bharata B Rao <bharata@amd.com>
Subject: [RFC PATCH 3/5] x86/ibs: Enable per-process IBS from sched switch path
Date:   Wed, 8 Feb 2023 13:05:31 +0530
Message-ID: <20230208073533.715-4-bharata@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT031:EE_|DS7PR12MB5766:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a363116-817e-43b1-5c51-08db09a738df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IdTCdkx5UyzbNDKrYc1PoxsP1Y2dCzUNsXnJggY4dBOSLyvfsHBaLBlXfiqGlVWtz3H0vdl+1OfrMRVCiJ3dZSrgKDKNWeCVnXy2Mlp1Dter99h1KbDBCYOSiQiJXIOcArvAMyaac1JOOc5iFWbxArQt60cxmdYOvbTSxez1UYu7RrtYs3PO88dxIX61z3xOYTkZVs6kNuwa+eXd4VvbC5RR5EVS9jDZL6eZnxNENQT+7dmZZ+jl79GL1hdKnVG9kMETXnvmoKJjmNS8tQ6iIZF5aisd/aVvvYvfUA0E7ohhsC6LgdF6lecxQbyy+ppTRagg9EK9qUK0dtFBSRDjB5azQavyyQR11nc1K9kxst10pNZgufjRdTt+gWOgUVjJ4qEhFuZQKlXA7ZajfwVJU7eS5ouheYXXaBrX3wBKjEuwRVaR0DJkxlLIglWoFg4MMIb01NUeQQpzCWvR/CcA4PVKD468yAketZqRFR+p00TMnWqzItIqq9eZt/WURbzT1rbjK0fY28AogW9j12EzD0ot84BABkdAzwTzLMi0G1RVTgnQuTiM/IYGPpimzxGc4ocz6+sL0Am8TaOZ9X46+o3Anz6NHkkTnLqnOrnAnMyxZnAH3O762kFyetNnNILxLnAqLIPiD0xLlknC2lVSOSFqcWBP3EbTi4kb3aRZI4cIBAVEYi7ia1H5CxzNTTBNi7afe2O/N0ASS4B6nwJiRTgRRPqLce2FJ09uxH0LXC6qgpAJ6sN/wh0p0kfp5Wu+
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(346002)(136003)(376002)(396003)(39860400002)(451199018)(36840700001)(40470700004)(46966006)(81166007)(426003)(83380400001)(47076005)(36756003)(5660300002)(2906002)(7416002)(1076003)(186003)(16526019)(82310400005)(26005)(8936002)(6666004)(41300700001)(478600001)(40460700003)(7696005)(86362001)(82740400003)(2616005)(40480700001)(336012)(356005)(110136005)(54906003)(4326008)(70206006)(70586007)(316002)(8676002)(36860700001)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2023 07:36:42.1095
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a363116-817e-43b1-5c51-08db09a738df
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT031.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5766
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Program IBS for access profiling for threads from the
task sched switch path. IBS is programmed with a period
that corresponds to the incoming thread. Kernel threads are
excluded from this.

The sample period is currently kept at a fixed value of 10000.

Signed-off-by: Bharata B Rao <bharata@amd.com>
---
 arch/x86/mm/ibs.c     | 27 +++++++++++++++++++++++++++
 include/linux/sched.h |  1 +
 kernel/sched/core.c   |  1 +
 kernel/sched/fair.c   |  1 +
 kernel/sched/sched.h  |  5 +++++
 5 files changed, 35 insertions(+)

diff --git a/arch/x86/mm/ibs.c b/arch/x86/mm/ibs.c
index adbc587b1767..a479029e9262 100644
--- a/arch/x86/mm/ibs.c
+++ b/arch/x86/mm/ibs.c
@@ -8,6 +8,7 @@
 #include <asm/perf_event.h> /* TODO: Move defns like IBS_OP_ENABLE into non-perf header */
 #include <asm/apic.h>
 
+#define IBS_SAMPLE_PERIOD      10000
 static u64 ibs_config __read_mostly;
 
 struct ibs_access_work {
@@ -15,6 +16,31 @@ struct ibs_access_work {
 	u64 laddr, paddr;
 };
 
+void hw_access_sched_in(struct task_struct *prev, struct task_struct *curr)
+{
+	u64 config = 0;
+	unsigned int period;
+
+	if (!static_branch_unlikely(&hw_access_hints))
+		return;
+
+	/* Disable IBS for kernel thread */
+	if (!curr->mm)
+		goto out;
+
+	if (curr->numa_sample_period)
+		period = curr->numa_sample_period;
+	else
+		period = IBS_SAMPLE_PERIOD;
+
+
+	config = (period >> 4)  & IBS_OP_MAX_CNT;
+	config |= (period & IBS_OP_MAX_CNT_EXT_MASK);
+	config |= ibs_config;
+out:
+	wrmsrl(MSR_AMD64_IBSOPCTL, config);
+}
+
 void task_ibs_access_work(struct callback_head *work)
 {
 	struct ibs_access_work *iwork = container_of(work, struct ibs_access_work, work);
@@ -198,6 +224,7 @@ int __init ibs_access_profiling_init(void)
 			  x86_amd_ibs_access_profile_startup,
 			  x86_amd_ibs_access_profile_teardown);
 
+	static_branch_enable(&hw_access_hints);
 	pr_info("IBS access profiling setup for NUMA Balancing\n");
 	return 0;
 }
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 19dd4ee07436..66c532418d38 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1254,6 +1254,7 @@ struct task_struct {
 	int				numa_scan_seq;
 	unsigned int			numa_scan_period;
 	unsigned int			numa_scan_period_max;
+	unsigned int			numa_sample_period;
 	int				numa_preferred_nid;
 	unsigned long			numa_migrate_retry;
 	/* Migration stamp: */
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index e838feb6adc5..1c13fed8bebc 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5165,6 +5165,7 @@ static struct rq *finish_task_switch(struct task_struct *prev)
 	prev_state = READ_ONCE(prev->__state);
 	vtime_task_switch(prev);
 	perf_event_task_sched_in(prev, current);
+	hw_access_sched_in(prev, current);
 	finish_task(prev);
 	tick_nohz_task_switch();
 	finish_lock_switch(rq);
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index c9b9e62da779..3f617c799821 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3094,6 +3094,7 @@ void init_numa_balancing(unsigned long clone_flags, struct task_struct *p)
 	p->node_stamp			= 0;
 	p->numa_scan_seq		= mm ? mm->numa_scan_seq : 0;
 	p->numa_scan_period		= sysctl_numa_balancing_scan_delay;
+	p->numa_sample_period		= 0;
 	p->numa_migrate_retry		= 0;
 	/* Protect against double add, see task_tick_numa and task_numa_work */
 	p->numa_work.next		= &p->numa_work;
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 771f8ddb7053..953d16c802d6 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1723,11 +1723,16 @@ extern int migrate_task_to(struct task_struct *p, int cpu);
 extern int migrate_swap(struct task_struct *p, struct task_struct *t,
 			int cpu, int scpu);
 extern void init_numa_balancing(unsigned long clone_flags, struct task_struct *p);
+void hw_access_sched_in(struct task_struct *prev, struct task_struct *curr);
 #else
 static inline void
 init_numa_balancing(unsigned long clone_flags, struct task_struct *p)
 {
 }
+static inline void hw_access_sched_in(struct task_struct *prev,
+				      struct task_struct *curr)
+{
+}
 #endif /* CONFIG_NUMA_BALANCING */
 
 #ifdef CONFIG_SMP
-- 
2.25.1

