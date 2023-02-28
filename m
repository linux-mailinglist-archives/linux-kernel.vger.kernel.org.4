Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E840C6A5272
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 05:52:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbjB1Ewb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 23:52:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbjB1Ew3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 23:52:29 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2061.outbound.protection.outlook.com [40.107.244.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43636298CD
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 20:52:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YhIJBb1o2KENT2cFgBVVAqBzcLiF//tadsiqIxoVaLNr3j+M4h3Xhg9+0McGZNmjEj4V3RmuNmC0i+SpKhfk78WAj/38lmNBEg69mP24JrsRi9rqp0yB/WFOcctYMrhr1AjZsMxWcyKSGbrPNvHfAfyjndCr4izO7KA/ad3+Qtm3OgAjnNxWn9Qw2hhOzQZq1AtnUn1vdu2V6AaTFWNbAalGhuYS7+OYycFCTaQo9exz1rscJQm9+ICYIRPdi7uIFNoHCUX6RMPSlwTex3QsAQTotKRDMK0BmJLMPY+FZ3f5MjFE/Fte5jVRKrDVWvEivA8UXF5d33twI4IxH7nqxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eoXFYLxyn89pEiIdnnebivPOBHzu3rBSGjAxsggIL6A=;
 b=Rgui38NGuBKMkYHTTfoH6E5OSayQhOU91fhfxZz0TCDouyc/r3m/Y90PmF4NurswCLICsBZPsTARxcpk70JJzfXwovkeji9Y1m/G9VP8RMKJaeAPUWTUn9y+MGj3E7AbcBHtYK2i2s+gOzOMLp4mTV5RScYYQjQIgMiCj78SUdMph8cU/hBTxCpQZwKYKTG+FdbFdMip6dI925YpPtMLyHzq9Ts1aUYRycxU0oAhrPoy+fbBFiEhW2/4as2Wchc3jppih8El8u7IENTpIBn9w89R/t3Mo3AfHnnLCMdukAuLAAgA0M+wUOEy0N3magRsvGJ5QFzDXGiPa+XnNUk3sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eoXFYLxyn89pEiIdnnebivPOBHzu3rBSGjAxsggIL6A=;
 b=hdLjdHcOZ2KzIrR/7d57EsMSmNTqUxJkHLSnfzRBV8P2OOFlSlTNZhIiNIeFLUge15w2+8yaCyD2ZZDu8GVQ24vaOCpAOxzoh8cJZOfc6/vrVrT9lcbW8diQB8PtRdG7E6D3SJRAT0ZHVyk6Tfgy43+CALqfZNP6DkN8XuyD5Xw=
Received: from MW4PR04CA0124.namprd04.prod.outlook.com (2603:10b6:303:84::9)
 by IA0PR12MB8373.namprd12.prod.outlook.com (2603:10b6:208:40d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.25; Tue, 28 Feb
 2023 04:52:03 +0000
Received: from CO1NAM11FT058.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:84:cafe::4e) by MW4PR04CA0124.outlook.office365.com
 (2603:10b6:303:84::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.30 via Frontend
 Transport; Tue, 28 Feb 2023 04:52:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT058.mail.protection.outlook.com (10.13.174.164) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6156.12 via Frontend Transport; Tue, 28 Feb 2023 04:52:02 +0000
Received: from BLR-L-RKODSARA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 27 Feb
 2023 22:51:38 -0600
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
Subject: [PATCH V3 3/4] sched/numa: implement access PID reset logic
Date:   Tue, 28 Feb 2023 10:20:21 +0530
Message-ID: <235721608c912cc6c8983c22f11b145606d360d5.1677557481.git.raghavendra.kt@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1NAM11FT058:EE_|IA0PR12MB8373:EE_
X-MS-Office365-Filtering-Correlation-Id: b6a639e2-0ff8-41db-ad18-08db194788c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DwYGdgEPyZA8HRJd2TXs8HjbIve82CeXVpa/xJSvAgokHVojS/mAUcWqUzzC1kSVQpv/Mn00baOum6QInWtRbmVVck6BuDTZjPa+SO6W9KxVZDjiYi50Rb8fH65/bnTUIhIrLut8UHhwO1COYbqpgw6/IVHVa0or7m3fOdXBNnGCyQk0kYh02fBGsvjom0i0XuLsJw4lmaS4mZp7oPLy6R5fgpJX3A+hOFETqeIC+pNLhKTdf5tkbxW/bxW9iIIxbyTCEcHe5EfMFksEJFBYvbsijn7bCqRM2+t/ooZ96kMPyQBAk8AU4TRukOes5EXENGmfhWG6Vr6IXQAlGldpdY617A9RvjnzfJAjETrLzGE/PXu7rmAi6GqkAB7J4TDVZhxAU2UTPPeg+mPTdhlks/FcfL8FlLC3dSGt6AxQ+kf0S4QQWpfsshRFJQ3G/NUBN4XIZj9NWqFkJBy0xpGOKVEdczksKpqjOIaZnxe3W1DmOXb8r2s54htKJXKWaXHVJWo+B2It9p/n6tEUe90UZOUZeObSpW2jxQ9/+EI1PORotJ2mSSkVi27xYPTJo5H73dy63l/itX6v8i1DJ5eHHjxihwJUajL2Si6cZaII4uEl/g+LAmAmrmTpKcdVbxrEtV2PoQernkBTHXEpNp/lsyiCYXIftaTE/rVLcjL9MgXKEx+E507xw3pX5OoP3G0BcVPF2qjO4AW500YPCz7xkk8eD1E1p+6BSIQcMXrZTuEQIUD56gy0DbVxYUgoYvAl
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(346002)(39860400002)(396003)(376002)(136003)(451199018)(36840700001)(46966006)(40470700004)(110136005)(316002)(83380400001)(36756003)(82310400005)(54906003)(16526019)(40460700003)(8676002)(36860700001)(5660300002)(2906002)(4326008)(70586007)(41300700001)(70206006)(478600001)(426003)(2616005)(6666004)(26005)(47076005)(186003)(40480700001)(336012)(7696005)(81166007)(356005)(8936002)(82740400003)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2023 04:52:02.9483
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b6a639e2-0ff8-41db-ad18-08db194788c2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT058.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8373
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
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
index 097680aaca1e..bd07289fc68e 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1394,8 +1394,8 @@ static inline void vma_set_access_pid_bit(struct vm_area_struct *vma)
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
index 582523e73546..1f1f8bfeae36 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -437,7 +437,8 @@ struct anon_vma_name {
 
 struct vma_numab_state {
 	unsigned long next_scan;
-	unsigned long access_pids;
+	unsigned long next_pid_reset;
+	unsigned long access_pids[2];
 };
 
 /*
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 05490cb2d5c6..f76d5ecaf345 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -2918,6 +2918,7 @@ static void reset_ptenuma_scan(struct task_struct *p)
 
 static bool vma_is_accessed(struct vm_area_struct *vma)
 {
+	unsigned long pids;
 	/*
 	 * Allow unconditional access first two times, so that all the (pages)
 	 * of VMAs get prot_none fault introduced irrespective of accesses.
@@ -2927,10 +2928,12 @@ static bool vma_is_accessed(struct vm_area_struct *vma)
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
@@ -3039,6 +3042,10 @@ static void task_numa_work(struct callback_head *work)
 
 			vma->numab_state->next_scan = now +
 				msecs_to_jiffies(sysctl_numa_balancing_scan_delay);
+
+			/* Reset happens after 4 times scan delay of scan start */
+			vma->numab_state->next_pid_reset =  vma->numab_state->next_scan +
+				msecs_to_jiffies(VMA_PID_RESET_PERIOD);
 		}
 
 		/*
@@ -3053,6 +3060,18 @@ static void task_numa_work(struct callback_head *work)
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

