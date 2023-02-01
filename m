Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42CF6686125
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 09:03:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231915AbjBAIDl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 03:03:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230437AbjBAIDg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 03:03:36 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2044.outbound.protection.outlook.com [40.107.243.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61C4A2BF3A
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 00:03:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mvsd5PIG9G1vJY0uDpjV3o1hPM7aBxusFhRgoWan/BGg8YWM8Ho4fhUvoz470GV/sZ23w1BumzF1K0jYVFYteHuyEpa61GM2pReYrjpNXpcGm3ua0pYjtgfKW90wvYek6rt1eqWhkg+7CvLTC8HXSObkyvkXy3GbCU0tgjJTXufCOmJhllazG6PAjgB62t34dko59qxLJQlBaYWwvw4XZyvFcGchSfAJSYAzsZ8Fhqmv3aARpdvCON2rHvFZEymhtBO6h3Nol7NZI1ug4xCtWPrQF38ncNkLukx1Sbj8barPrvB1g/I5MIr3qe21pQ/VckFauVy9cJ4ClhhgNg+Q4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AhcuMGmyMR6wFmrQd9SM/5hyh6AFl2dn/jX8xfA+fTk=;
 b=etD+lxv6XdLA/T2Myd7/YFDB4Z1HxELSMpa+/0tLmP2jADZDSYoYqrHC9NwySwXNlr67+gaqCyAO7rOY+OuALoIb8CbdSdi8bebXEnIq/7j5yio6KLMqiYkyBb5unqlc6Zah4yTPTZwpHmJo0HOvSmzPdkVI1E7Hy6oCAYwFz0Fg9W+vna+19KxVzRx5N1xK2BiNdH/4dM+fGCm40d2rIvTAAXR8j1uSqe6T8YaDJzUOpN1bmGg1ISwHGGALZtfSh3a3CH5l6mK/KkXPL/8asck/ieQFJ1Q57OGbkNePVivRN4yDSQ64cpRI0/fnyiwb1l8DbPRhBQmGIIjEwKXBtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AhcuMGmyMR6wFmrQd9SM/5hyh6AFl2dn/jX8xfA+fTk=;
 b=RxcmXlieyT4aNlBaMdoa68K87VGD0TBpMjYRJVq2wmpnq7veMTzPq50p82cjoPt10eJ7t+ivKbziPkcANnrfBwUfkXJRpg6uXcFiyju7PAaJxYQvWkbNHxMqvZMSio+04WwOaRbPKHP+aZCbJ+J9x85Cyiua6he5W47yaOAetkY=
Received: from BN9P223CA0019.NAMP223.PROD.OUTLOOK.COM (2603:10b6:408:10b::24)
 by CH3PR12MB8511.namprd12.prod.outlook.com (2603:10b6:610:15c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.38; Wed, 1 Feb
 2023 08:03:26 +0000
Received: from BN8NAM11FT082.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10b:cafe::36) by BN9P223CA0019.outlook.office365.com
 (2603:10b6:408:10b::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.38 via Frontend
 Transport; Wed, 1 Feb 2023 08:03:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT082.mail.protection.outlook.com (10.13.176.94) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6064.22 via Frontend Transport; Wed, 1 Feb 2023 08:03:25 +0000
Received: from BLR-L-RKODSARA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 1 Feb
 2023 02:03:22 -0600
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
Subject: [PATCH V2 1/3] sched/numa: Apply the scan delay to every vma instead of tasks
Date:   Wed, 1 Feb 2023 13:32:20 +0530
Message-ID: <1aebc55030925998a3df3cafb79c5cd28b199ea8.1675159422.git.raghavendra.kt@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT082:EE_|CH3PR12MB8511:EE_
X-MS-Office365-Filtering-Correlation-Id: 510611f5-71e3-49c2-9d40-08db042acbef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /SRV4htTNbr7JEQTc+CKomAgA6e1uQtQT7+e74B3FoFmk66xOXpU5iqvOZ4kljvy6KwcH/DsdEX0hUnJlt/DgtUq1ZGjWh90uqDpL/BzgD5wjwX1jkwqGfBCa7pf1C30QN7RwAUEytf04cnHYb59cPTS4Revv6OOY1OD8Pb/4dV6oinvQ3TnYWcGC37eIoyHV2FpmYnRd0MaJgFgA3gRNX2GE1h84X0D0IggUOGZSCvMgI92UZVdc+X+D7L0un7r6Y1ggh8NRJ1ZYCJa7xuBT/MeXYvTPCysXLDyCD+EZH0cKZomBK+hT9h68Uyge2d1pPcKtj4jPJhPQfCfM7XqFfgQ9uKA25zH04fScUXebJla/L1F5gbD+BreG1CCburGOKUvHXj0D8p6LrEwHWzu9B01I1D9kJf8TE9EMLjetS1vroXTi9zgxhbhz+OB5WUqawekepNfg0/16czmXpmFmZn5m6TuxIuCSfAHILG32p2VpkRbsVIfRDFhYiVzfi9qaoyfw+NuA6BhRX9Eft6I2D3fAQSN8D54Av3mYkXLuaMK2jPlZ6/9kdVovXq6u49q+p4h8P8XZZPeM8P3BVSn3J1OZhZ82uACNFqMCQdsCKD5C/acJfcahgwprlvkFYxlJpxDzewXUk1rIOJ5OF9deeozAuIcUTKaybDBq928Zps7kdNudPiNLFS3PhTa/34JAIP3NgfCjNqB8SE/ErhPKO1HrJdMijTaUH09qFQ8LTQjkdjUp6o0hhWA/cxZfzmg
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(376002)(396003)(136003)(346002)(39860400002)(451199018)(46966006)(36840700001)(40470700004)(54906003)(316002)(8936002)(110136005)(4326008)(70586007)(8676002)(41300700001)(70206006)(356005)(40480700001)(82740400003)(36756003)(36860700001)(81166007)(40460700003)(186003)(26005)(2906002)(82310400005)(7696005)(47076005)(478600001)(426003)(83380400001)(2616005)(5660300002)(16526019)(336012)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2023 08:03:25.9204
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 510611f5-71e3-49c2-9d40-08db042acbef
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT082.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8511
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

 Avoid scanning new or very short-lived VMAs.

(Raghavendra: Add initialization in vm_area_dup())

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
Signed-off-by: Raghavendra K T <raghavendra.kt@amd.com>
---
 include/linux/mm.h       |  9 +++++++++
 include/linux/mm_types.h |  7 +++++++
 kernel/fork.c            |  2 ++
 kernel/sched/fair.c      | 17 +++++++++++++++++
 4 files changed, 35 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 974ccca609d2..74d9df1d8982 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -611,6 +611,14 @@ struct vm_operations_struct {
 					  unsigned long addr);
 };
 
+#ifdef CONFIG_NUMA_BALANCING
+#define vma_numab_init(vma) do { (vma)->numab = NULL; } while (0)
+#define vma_numab_free(vma) do { kfree((vma)->numab); } while (0)
+#else
+static inline void vma_numab_init(struct vm_area_struct *vma) {}
+static inline void vma_numab_free(struct vm_area_struct *vma) {}
+#endif /* CONFIG_NUMA_BALANCING */
+
 static inline void vma_init(struct vm_area_struct *vma, struct mm_struct *mm)
 {
 	static const struct vm_operations_struct dummy_vm_ops = {};
@@ -619,6 +627,7 @@ static inline void vma_init(struct vm_area_struct *vma, struct mm_struct *mm)
 	vma->vm_mm = mm;
 	vma->vm_ops = &dummy_vm_ops;
 	INIT_LIST_HEAD(&vma->anon_vma_chain);
+	vma_numab_init(vma);
 }
 
 static inline void vma_set_anonymous(struct vm_area_struct *vma)
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 500e536796ca..e84f95a77321 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -435,6 +435,10 @@ struct anon_vma_name {
 	char name[];
 };
 
+struct vma_numab {
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
+	struct vma_numab *numab;	/* NUMA Balancing state */
 #endif
 	struct vm_userfaultfd_ctx vm_userfaultfd_ctx;
 } __randomize_layout;
diff --git a/kernel/fork.c b/kernel/fork.c
index 08969f5aa38d..ac6f0477cf6e 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -474,6 +474,7 @@ struct vm_area_struct *vm_area_dup(struct vm_area_struct *orig)
 		 */
 		*new = data_race(*orig);
 		INIT_LIST_HEAD(&new->anon_vma_chain);
+		vma_numab_init(new);
 		dup_anon_vma_name(orig, new);
 	}
 	return new;
@@ -481,6 +482,7 @@ struct vm_area_struct *vm_area_dup(struct vm_area_struct *orig)
 
 void vm_area_free(struct vm_area_struct *vma)
 {
+	vma_numab_free(vma);
 	free_anon_vma_name(vma);
 	kmem_cache_free(vm_area_cachep, vma);
 }
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index e4a0b8bd941c..060b241ce3c5 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3015,6 +3015,23 @@ static void task_numa_work(struct callback_head *work)
 		if (!vma_is_accessible(vma))
 			continue;
 
+		/* Initialise new per-VMA NUMAB state. */
+		if (!vma->numab) {
+			vma->numab = kzalloc(sizeof(struct vma_numab), GFP_KERNEL);
+			if (!vma->numab)
+				continue;
+
+			vma->numab->next_scan = now +
+				msecs_to_jiffies(sysctl_numa_balancing_scan_delay);
+		}
+
+		/*
+		 * After the first scan is complete, delay the balancing scan
+		 * for new VMAs.
+		 */
+		if (mm->numa_scan_seq && time_before(jiffies, vma->numab->next_scan))
+			continue;
+
 		do {
 			start = max(start, vma->vm_start);
 			end = ALIGN(start + (pages << PAGE_SHIFT), HPAGE_SIZE);
-- 
2.34.1

