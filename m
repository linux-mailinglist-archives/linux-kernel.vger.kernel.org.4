Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89E4168E920
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 08:37:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231194AbjBHHh1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 02:37:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231224AbjBHHhN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 02:37:13 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2087.outbound.protection.outlook.com [40.107.92.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 928DC1A971
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 23:36:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fX+iaam+5szrGbaySOxlfuSb7niha0Wg+a+b4Xqg+HbVgPavlaFrvFlAcnS3BxfvkPy4Wyh2nzPhgFR54wYFNSOV1tkV4tzbNC1ab4lMhAO9gEG1bfQ3Yoy76mWt4UM8W1ixdcxy/6hx4qDFP9M6a/7/y+jc62TG4x9U1gI1Pb4DtBU03H+Bxo/VS2pAc2FqAdITfvJ6DGSnu2g9MOM57ZB279pi9iG1kA8v1Zqvf1X2YEoFWj2G3WHGhEDh4KijijHdieco0LbIyLLD+Rw4zCYRn41qJlPvxs3pW0ZKQ2PZdBtvutQtl2LqTM4yJZU7wj4uthQJRGCH9mgUy/oPJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IVShu4+QzQHsTFEmQ4HZTu3XYpXXfIe/NUivxg9UnAs=;
 b=APentNT8N3Ykv7fIPXf+KWpZ8hD+LQfcsSDOyT535gDotgHZ7X6/2FDMEwvKH5fFLsw/SF640iO8XjM1AopT1Jr4Uwxm1Ra8zUMBpY/MPBpFygul+NmKPa81RPft3L3/cckcrl13GTliRa3hjX43Eeh/GG2jiZzQcLwLbetpvigF/Ykmr4leKZyYH48GIQtJv0Bj2Du+0XCnaPpCd13Ai196zuqApLDkL+K3o6arLief5U9Ii0BXKyfFjXIZD8D1ybnqRiljT5Am39hlXUgheDiPkjNR2oBUXeSqhvyLGniLJHLXa7k1rDw+xafCQ5J4UK8oYPSvAcaDoBov8n3FHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IVShu4+QzQHsTFEmQ4HZTu3XYpXXfIe/NUivxg9UnAs=;
 b=qPvQNPFiYKAMqgQNyLOGu4M9PWS6NyZXYyiU7VWz2J5rKhDSnnyIRyQuY0eTx2InKPM5f2RWlOkjRPs4zm/sndZ5rkjPN+UqUYCmEd7i8xtlUfKPE0u0YGVSOjMemr2qtuEZpUUL3FF+OXFqBP7+3USckDjQ6CvazdqBRqyj7rk=
Received: from BN0PR03CA0023.namprd03.prod.outlook.com (2603:10b6:408:e6::28)
 by IA0PR12MB8328.namprd12.prod.outlook.com (2603:10b6:208:3dd::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.17; Wed, 8 Feb
 2023 07:36:51 +0000
Received: from BN8NAM11FT059.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e6:cafe::c0) by BN0PR03CA0023.outlook.office365.com
 (2603:10b6:408:e6::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.17 via Frontend
 Transport; Wed, 8 Feb 2023 07:36:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT059.mail.protection.outlook.com (10.13.177.120) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6086.17 via Frontend Transport; Wed, 8 Feb 2023 07:36:51 +0000
Received: from BLR-5CG1133937.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 8 Feb
 2023 01:36:46 -0600
From:   Bharata B Rao <bharata@amd.com>
To:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
CC:     <mgorman@suse.de>, <peterz@infradead.org>, <mingo@redhat.com>,
        <bp@alien8.de>, <dave.hansen@linux.intel.com>, <x86@kernel.org>,
        <akpm@linux-foundation.org>, <luto@kernel.org>,
        <tglx@linutronix.de>, <yue.li@memverge.com>,
        <Ravikumar.Bangoria@amd.com>, Bharata B Rao <bharata@amd.com>
Subject: [RFC PATCH 5/5] x86/ibs: Delay the collection of HW-provided access info
Date:   Wed, 8 Feb 2023 13:05:33 +0530
Message-ID: <20230208073533.715-6-bharata@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT059:EE_|IA0PR12MB8328:EE_
X-MS-Office365-Filtering-Correlation-Id: f743052a-3f22-48a8-74c3-08db09a73e62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9iibJvhHoow1en+liIen4YbhYWJUdjq/E2YIyw3XoGlVLHubOMYyjwcLOGee0oZSjlBXe5M2+GBy8eWVmP21ReKnTmy7NUfRYSO5fwTEa0Sqtzzvgcd613A9XNTUr7cbn2JSDqOR9UJyErTeCOBE4732KTeLUQBpwxBxAZIlhKc+rOFSRLJ7EHrt0TLqWdE7hmUOtANit6fuXCgW154H3+PIO5cWp9t4+2ArGyiGC5rfRi5MWXjoxfba4RDTwohbqGngL7/ulRdhUkON7i1HSAvzstZpJ/FMYoN5/L9C8lx75XdpXLQGsSV5h4HAhNLZhgWaTxLS957MCcSA1prIjjGuOiQRW6aK+LHWty1j8LaOe2RoQSp4fZk4Glh8CnZ1+pDov3cHnFjRxI5/aO23FFJveKWffRXQMZRbyGCWCusXZa8G9xw04h+h0KTRDq7j3ukeVm4lraVvfbCZusRa9HGmlTdM2joTOasXXVGr5Kygxg/H5YancHQgP/nbShYUDnd6QESpgntuhpK9PA9SHePharJvB8WFQBl9RpZFI5fymyPxHiK+VRen2rduaZ/07G8HzNHEJXI2BfDP0aZiF0NGNF1gediDAr4Gpoe+HfPY8Qqw4tgoCwvdNQUzRtZhiJIQ16QlmVO5qWJk7JVPCkDWIrGg4yItBYfuOuG5NTXBZfSgfokdwGVSMPWkEWJfufkt77J+rDLE5Kn22y3s9Fb6Z1DSDwMnb37sFwpJNM+wowfkXqoWT9VWJIP9S+h9
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(346002)(136003)(39860400002)(396003)(376002)(451199018)(40470700004)(36840700001)(46966006)(5660300002)(16526019)(86362001)(7416002)(81166007)(356005)(26005)(186003)(8936002)(6666004)(2906002)(82740400003)(8676002)(82310400005)(70206006)(70586007)(4326008)(41300700001)(36860700001)(316002)(40480700001)(426003)(2616005)(1076003)(40460700003)(478600001)(47076005)(7696005)(54906003)(110136005)(36756003)(336012)(83380400001)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2023 07:36:51.3416
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f743052a-3f22-48a8-74c3-08db09a73e62
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT059.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8328
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow an initial delay before enabling the collection
of IBS provided access info.

Signed-off-by: Bharata B Rao <bharata@amd.com>
---
 arch/x86/mm/ibs.c        | 18 ++++++++++++++++++
 include/linux/mm.h       |  2 ++
 include/linux/mm_types.h |  3 +++
 kernel/sched/debug.c     |  2 ++
 kernel/sched/fair.c      |  3 +++
 5 files changed, 28 insertions(+)

diff --git a/arch/x86/mm/ibs.c b/arch/x86/mm/ibs.c
index a479029e9262..dfe5246954c0 100644
--- a/arch/x86/mm/ibs.c
+++ b/arch/x86/mm/ibs.c
@@ -16,6 +16,21 @@ struct ibs_access_work {
 	u64 laddr, paddr;
 };
 
+static bool delay_hw_access_profiling(struct mm_struct *mm)
+{
+	unsigned long delay, now = jiffies;
+
+	if (!mm->numa_hw_access_delay)
+		mm->numa_hw_access_delay = now +
+			msecs_to_jiffies(sysctl_numa_balancing_access_faults_delay);
+
+	delay = mm->numa_hw_access_delay;
+	if (time_before(now, delay))
+		return true;
+
+	return false;
+}
+
 void hw_access_sched_in(struct task_struct *prev, struct task_struct *curr)
 {
 	u64 config = 0;
@@ -28,6 +43,9 @@ void hw_access_sched_in(struct task_struct *prev, struct task_struct *curr)
 	if (!curr->mm)
 		goto out;
 
+	if (delay_hw_access_profiling(curr->mm))
+		goto out;
+
 	if (curr->numa_sample_period)
 		period = curr->numa_sample_period;
 	else
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 8f857163ac89..118705a296ef 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1397,6 +1397,8 @@ static inline int folio_nid(const struct folio *folio)
 }
 
 #ifdef CONFIG_NUMA_BALANCING
+extern unsigned int sysctl_numa_balancing_access_faults_delay;
+
 /* page access time bits needs to hold at least 4 seconds */
 #define PAGE_ACCESS_TIME_MIN_BITS	12
 #if LAST_CPUPID_SHIFT < PAGE_ACCESS_TIME_MIN_BITS
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 9757067c3053..8a2fb8bf2d62 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -750,6 +750,9 @@ struct mm_struct {
 
 		/* numa_scan_seq prevents two threads remapping PTEs. */
 		int numa_scan_seq;
+
+		/* HW-provided access info is collected after this initial delay */
+		unsigned long numa_hw_access_delay;
 #endif
 		/*
 		 * An operation with batched TLB flushing is going on. Anything
diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 1cf19778a232..5c76a7594358 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -342,6 +342,8 @@ static __init int sched_init_debug(void)
 			   &sysctl_numa_balancing_sample_period_max);
 	debugfs_create_u32("access_faults_threshold", 0644, numa,
 			   &sysctl_numa_balancing_access_faults_threshold);
+	debugfs_create_u32("access_faults_delay", 0644, numa,
+			   &sysctl_numa_balancing_access_faults_delay);
 #endif
 
 	debugfs_create_file("debug", 0444, debugfs_sched, NULL, &sched_debug_fops);
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 1b0665b034d0..2e2b1e706a24 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1097,6 +1097,7 @@ unsigned int sysctl_numa_balancing_sample_period_def = 10000;
 unsigned int sysctl_numa_balancing_sample_period_min = 5000;
 unsigned int sysctl_numa_balancing_sample_period_max = 20000;
 unsigned int sysctl_numa_balancing_access_faults_threshold = 250;
+unsigned int sysctl_numa_balancing_access_faults_delay = 1000;
 
 /*
  * Approximate time to scan a full NUMA task in ms. The task scan period is
@@ -3189,6 +3190,8 @@ void init_numa_balancing(unsigned long clone_flags, struct task_struct *p)
 		if (mm_users == 1) {
 			mm->numa_next_scan = jiffies + msecs_to_jiffies(sysctl_numa_balancing_scan_delay);
 			mm->numa_scan_seq = 0;
+			mm->numa_hw_access_delay = jiffies +
+				msecs_to_jiffies(sysctl_numa_balancing_access_faults_delay);
 		}
 	}
 	p->node_stamp			= 0;
-- 
2.25.1

