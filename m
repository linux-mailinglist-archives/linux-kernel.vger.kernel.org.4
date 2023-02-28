Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01DA46A5270
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 05:51:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbjB1Evs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 23:51:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbjB1Evo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 23:51:44 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2048.outbound.protection.outlook.com [40.107.244.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0260C26CF1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 20:51:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nZShD4lpYv+i0nK6bWP4Ouj/0xHZwo7ROlnxQNmDlVhr0Ra+SDIG9RH2mNr9s95r7BkAHcOflFXDpZUiGB/Kla/97Sh06CuRGTkDBkGv7R5JVP0+AUEkQXGdFAXXVdg2h1kjFP27wb06a6AEgoVDI//A7OBx0g4sPkvIDuZ8CJkwhLWym/DvzadW7nvTa3eXvY4IkGB9bMZj9NCYkTATu2DvjHTIxhdrBCtAW64hOpjHf06AHKhnhzoQ8LpSUXD2667qrDbe0U3cm4sTlGHQVqV8wmmXmdccFACMnG5CCT/RkQziZxtZwHpOELgPFajudcM7HAzhnIb+J5v/agyp1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q6pRaeAm2S0aSVYFRoe0W0nrXqMgPX0/7nNuAYxeMTY=;
 b=ImwK5qFbqn//e9r+1Gdi04FB5wWuxD6FIrvBM8sPXD+YrIGj2ywQ7ueZQMoY2gpZ+LLubyKd/1npWBo8ysHWtOuoya2WcVxzw7TBDs2R8WZ8pSpeGtntn5ljcfst2WhHzQQfCGSwKEl2lDbBimEvyRwwwRFyJljQhymoWuXF8l53c1By6e1pRB19IKaVtfm9FhKCBNMBqYHmzdxCcYFLv8bC0ZPn48aconEZtOlMqq/ksxET0TOkqKPY7MwbB2qfg81oofU8OIQ6ndKlJLC8MxzoD/6L92/A1qRLq6zsghn/7jR7A/cYaPjIAYSTXIGIPOt9VOgicBm0HFime6FPsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q6pRaeAm2S0aSVYFRoe0W0nrXqMgPX0/7nNuAYxeMTY=;
 b=fedlaKWwRNK/HB4XfJ0pgVUC1wmXCTxAVSK+aAA3ZsMNF5+s3dwtR223ihxAxSvt6lXTdANSDyZ0FuCoLLupd+rQvq334rK/hIbyMfLurZ9w1QjBe8yw/v0sS1SX99po5z7N8T5MjcajNMr8SIQIDlxngCvAbene1e2lutESl18=
Received: from MW4PR03CA0328.namprd03.prod.outlook.com (2603:10b6:303:dd::33)
 by SA1PR12MB5660.namprd12.prod.outlook.com (2603:10b6:806:238::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.27; Tue, 28 Feb
 2023 04:51:36 +0000
Received: from CO1NAM11FT040.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:dd:cafe::b1) by MW4PR03CA0328.outlook.office365.com
 (2603:10b6:303:dd::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.29 via Frontend
 Transport; Tue, 28 Feb 2023 04:51:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT040.mail.protection.outlook.com (10.13.174.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6156.17 via Frontend Transport; Tue, 28 Feb 2023 04:51:35 +0000
Received: from BLR-L-RKODSARA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 27 Feb
 2023 22:51:29 -0600
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
Subject: [PATCH V3 1/4] sched/numa: Apply the scan delay to every new vma
Date:   Tue, 28 Feb 2023 10:20:19 +0530
Message-ID: <85e573d315109507fccf8e1b0906d90cb2039cc8.1677557481.git.raghavendra.kt@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1NAM11FT040:EE_|SA1PR12MB5660:EE_
X-MS-Office365-Filtering-Correlation-Id: 02e3038c-2630-4515-c1c6-08db194778a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4x14G/ew6qo47jZ0L8C9jCWb3wfSsBKO9vcz4k6DNaFSxjLL3lw/B0+edEe1dnATi0lgxvHD5NmVjogZFzacp2AKtQ/vgdr03IXtgHlbDhi1XGxk/eH+JWC+RVObAWQTzPrqoYO8XB9ARO6E30rOsFip7tDcFfPHATnRKhirn+pFwUu9ePLo8yVznsqAh1kdaKHMbjMbI8bD4AyD9QLyl7VSxfPF5zzZsEChe4jN6Rc3f6Qa7hvPjVQkbIprVdaIGUUdRWCDH98sOI1tOK5DDlD0T9FZKqLtnZsNIcpQqqFO6X9vQKop156mdVrW1v4AoBg0424qK9M2yZmxuR2vhrEK9JWUdeFf8DCrSt252TdCiWUcab4IL/r2eeHmHXvugXM4/9/VeM6Ch4Nor+Zd9BE6nlJVA3NwjkjXJYZvz6pwHcoPv41fm7nSMZdhfO350vYvrog/LxYduSqmhYckRyu9olyMPVv51iUS242sdwwxjCXY3kz6RUj4onCE5AfFRmd1ZPkzPtgkwycMEvgqBSWpFyUq4YZjHuui+H9/ZFj9kVDL6EowSkk57bXnioPfNcIKWTSG1/Ox3CZPJTMsD7KlyIhKk/CZyQZ1CnUPmwaxoQpWR9ww3TYdem4Vm9zeipiYp2IF8f9pR+Fm2HRi7terUtP7dtzG6oT/II4VHKRjckRsTOqGR54YRSZndUsHBNSb61P45aM5BxbfddJfLfn6rht2I0wR2w1zItecvx5yUknFp/SbN1RIca3SPHpP
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(376002)(396003)(39860400002)(346002)(136003)(451199018)(40470700004)(46966006)(36840700001)(8936002)(5660300002)(41300700001)(70586007)(8676002)(4326008)(70206006)(2906002)(110136005)(316002)(54906003)(478600001)(7696005)(6666004)(36860700001)(426003)(47076005)(82310400005)(26005)(186003)(16526019)(2616005)(336012)(36756003)(83380400001)(356005)(82740400003)(81166007)(40460700003)(40480700001)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2023 04:51:35.8955
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 02e3038c-2630-4515-c1c6-08db194778a2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT040.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5660
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
index 974ccca609d2..41cc8997d4e5 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -29,6 +29,7 @@
 #include <linux/pgtable.h>
 #include <linux/kasan.h>
 #include <linux/memremap.h>
+#include <linux/slab.h>
 
 struct mempolicy;
 struct anon_vma;
@@ -611,6 +612,20 @@ struct vm_operations_struct {
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
 static inline void vma_init(struct vm_area_struct *vma, struct mm_struct *mm)
 {
 	static const struct vm_operations_struct dummy_vm_ops = {};
@@ -619,6 +634,7 @@ static inline void vma_init(struct vm_area_struct *vma, struct mm_struct *mm)
 	vma->vm_mm = mm;
 	vma->vm_ops = &dummy_vm_ops;
 	INIT_LIST_HEAD(&vma->anon_vma_chain);
+	vma_numab_state_init(vma);
 }
 
 static inline void vma_set_anonymous(struct vm_area_struct *vma)
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 500e536796ca..a4a1093870d3 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -435,6 +435,10 @@ struct anon_vma_name {
 	char name[];
 };
 
+struct vma_numab_state {
+	unsigned long next_scan;
+};
+
 /*
  * This struct describes a virtual memory area. There is one of these
  * per VM-area/task. A VM area is any part of the process virtual memory
@@ -504,6 +508,9 @@ struct vm_area_struct {
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
index 08969f5aa38d..6c19a3305990 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -474,6 +474,7 @@ struct vm_area_struct *vm_area_dup(struct vm_area_struct *orig)
 		 */
 		*new = data_race(*orig);
 		INIT_LIST_HEAD(&new->anon_vma_chain);
+		vma_numab_state_init(new);
 		dup_anon_vma_name(orig, new);
 	}
 	return new;
@@ -481,6 +482,7 @@ struct vm_area_struct *vm_area_dup(struct vm_area_struct *orig)
 
 void vm_area_free(struct vm_area_struct *vma)
 {
+	vma_numab_state_free(vma);
 	free_anon_vma_name(vma);
 	kmem_cache_free(vm_area_cachep, vma);
 }
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index e4a0b8bd941c..e39c36e71cec 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3015,6 +3015,25 @@ static void task_numa_work(struct callback_head *work)
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

