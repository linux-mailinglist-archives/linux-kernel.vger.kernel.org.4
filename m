Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B91356E137E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 19:30:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbjDMRaK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 13:30:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbjDMRaJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 13:30:09 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2052.outbound.protection.outlook.com [40.107.93.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0478F8A7A;
        Thu, 13 Apr 2023 10:30:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UWJDihbEUiz+bFy668fRHvPb6t04Si5mMOcRZ35Crj5Huwm1cSRI3GHuEMwWBjpoFYjJB23AsvpKezS1cI+JG47/uEWNHvJTS3zXHUqIMNpB2GsK80rRjc/+g38e5ZdBfvKepxr39GySU5EzcQa3tALs6uXdBuZapORErWJr1BHjHPxs0VbHLrdcmUE4LXJ8KCOrpUCNycsHfHC+aeefyfAyMFNHmyJ/p08olUiZ/DxR5B8G77fzobBB0xGu21soUb3hqXevVjjtGqc+ByIbAkI1jkP4pelX0xlao5g2sVaBLX4PbCr8rC1CgdSGXLTP0WVNlDb3Q84Z3JTPxwjDJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aX+UNmZGjPbdcDnSygfIDAMYP1Cl0OQLSuFghgDqksA=;
 b=BU97Tdb0cm0pXJYRvcr0BFdVrLscbsEwJS4Xs+lUIJo5joT9o3eA9zNpYlgT1Ez+eSAJefiofvN4uZyBAnwEW8b/lTfBrlX+ljLiI+Vdqc26Ptq6jQtIT5djFNXZP/iUKcp158veB2MjvHWuTBkWghOzXvB8zHLEPb9CPK5gjFJzzu6U64JVaDUUgr3l8WdDNKsdDMXGBxVkkRK4JZXwWJrlSeXllip5ipdYLv5PNwvm9abZk+fR3KKQxGu/b14toQuoEve2t10o+43a6f8W7wln6t3W1LAxOne//vDby6z6S1E4/ER3OKahDamHZz+Ioc4jARbI/MYsw64zowZmiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aX+UNmZGjPbdcDnSygfIDAMYP1Cl0OQLSuFghgDqksA=;
 b=E5od4xEjNCV6cXddXDQtrHgdnFFBIDGPo418KVNc89TQ31kffmTQftJutCM66d+EGb6+Tj8NDBSALncKrI58kRbLZMfRA732LL5g9wxM1hvqFC36Jv086/uoyNphvLqpx+ER+ZOMwkbJC7CkbAjnHh4fNKxJhtOO4tTxun41ARw=
Received: from DM6PR02CA0139.namprd02.prod.outlook.com (2603:10b6:5:332::6) by
 DM6PR12MB4156.namprd12.prod.outlook.com (2603:10b6:5:218::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6298.30; Thu, 13 Apr 2023 17:30:01 +0000
Received: from DS1PEPF0000E63A.namprd02.prod.outlook.com
 (2603:10b6:5:332:cafe::65) by DM6PR02CA0139.outlook.office365.com
 (2603:10b6:5:332::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.32 via Frontend
 Transport; Thu, 13 Apr 2023 17:30:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000E63A.mail.protection.outlook.com (10.167.17.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6298.27 via Frontend Transport; Thu, 13 Apr 2023 17:30:00 +0000
Received: from BLR5CG134614W.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 13 Apr
 2023 12:29:55 -0500
From:   K Prateek Nayak <kprateek.nayak@amd.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <hpa@zytor.com>, <corbet@lwn.net>,
        <jgross@suse.com>, <andrew.cooper3@citrix.com>,
        <peterz@infradead.org>, <Jason@zx2c4.com>,
        <thomas.lendacky@amd.com>, <puwen@hygon.cn>, <x86@kernel.org>,
        <linux-doc@vger.kernel.org>, <oleksandr@natalenko.name>,
        <bagasdotme@gmail.com>
Subject: [PATCH v2 1/2] arch/x86: Set L2 Cache ID on AMD and Hygon processors
Date:   Thu, 13 Apr 2023 22:59:17 +0530
Message-ID: <20230413172918.1500-2-kprateek.nayak@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230413172918.1500-1-kprateek.nayak@amd.com>
References: <20230413172918.1500-1-kprateek.nayak@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E63A:EE_|DM6PR12MB4156:EE_
X-MS-Office365-Filtering-Correlation-Id: b2d414a9-8927-412a-2735-08db3c44b5ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7WsoFtEMUKCAZr2LudcZbN6Zkis5B4odE06Ux/8+cbDUG1C3oyIQ4/wRqOwk36k+h3zfX05r6rS94PMyzRYodzpXg2jMdN3gawTNfRyIHUxGbHzWv7Iw+0EXO9rj5pR3ZZj8Zq1mNOuLLh86zNyX7Fqa9sVWivUAB3LUQq87JRQTrIEI7yU1pPskqlOr0DQGbDWtj4qfP2HhCcb2MJYBHR2OBE4Bm+b/AoIk838iNFWg6CNJ3sHR2j3SyhoTU1vdtunxwahM27c3F3VCVEOBONw0RSjeGX0Vs2njejujEbxMPrKp4X91PqPrFWdhFjmcKLFtpYkLZQOhIuuvo/vQxQRFYH1QeUnz/krXVRUbMp/khoGMxpKZ2rRO3M9DSH6RCPQnCRtuAMGfZnSCNP9SdLdsWdczILz4hYkkVHIlg6Kaw9JUOqSZvAm3jGv9rTXolzreo1K0ZT/yJSISrF8WYSQE56OY/ZA0PZmhK7/pRfPZiTEa6QOe5foD5oqk58chgb2f1PdktUobriSl6Gy8JiWbsVmOO0DxFLAPouKgvSqL6cXAVpwuYZvPpsOUCY0Ogm6ccDqIx/YyOlvsUiGr6UvU7TjBBSHxOtaSsEFlDwekD4aCK4MiUCd/AqYuVzhLva8U5esnfqqpM7ojOjSjKVmLmxnnBiM6oGp/B4CMihCaVFqWrolFnGEo0hDlA+x96KTY5MGUfPh/+LreQZhczKL2yAuKrG7MFI2K9Ej6WZk=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(346002)(376002)(39860400002)(451199021)(40470700004)(36840700001)(46966006)(6666004)(7696005)(40460700003)(6916009)(70206006)(70586007)(4326008)(36756003)(2906002)(7416002)(86362001)(81166007)(82740400003)(356005)(41300700001)(5660300002)(82310400005)(8676002)(8936002)(316002)(478600001)(40480700001)(54906003)(1076003)(26005)(336012)(426003)(36860700001)(2616005)(186003)(16526019)(47076005)(83380400001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2023 17:30:00.9740
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b2d414a9-8927-412a-2735-08db3c44b5ea
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E63A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4156
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On AMD and Hygon processors supporting X86_FEATURE_TOPOEXT set the l2c_id
using the Extended APIC ID and the Cache Properties CPUID.

Tested-by: Oleksandr Natalenko <oleksandr@natalenko.name>
Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
o v1->v2
  - No functional changes since v1 for AMD processors.
  - Renamed cacheinfo_amd_init_l2c_id() to
    cacheinfo_topoext_init_l2c_id() and added the call to same in
    Hygon's topology init path.
  - Collected tags from v1.
---
 arch/x86/include/asm/cacheinfo.h |  1 +
 arch/x86/kernel/cpu/amd.c        |  1 +
 arch/x86/kernel/cpu/cacheinfo.c  | 36 ++++++++++++++++++++++++++++++++
 arch/x86/kernel/cpu/hygon.c      |  1 +
 4 files changed, 39 insertions(+)

diff --git a/arch/x86/include/asm/cacheinfo.h b/arch/x86/include/asm/cacheinfo.h
index ce9685fc78d8..2034cd556c07 100644
--- a/arch/x86/include/asm/cacheinfo.h
+++ b/arch/x86/include/asm/cacheinfo.h
@@ -7,6 +7,7 @@ extern unsigned int memory_caching_control;
 #define CACHE_MTRR 0x01
 #define CACHE_PAT  0x02
 
+void cacheinfo_topoext_init_l2c_id(struct cpuinfo_x86 *c, int cpu);
 void cacheinfo_amd_init_llc_id(struct cpuinfo_x86 *c, int cpu);
 void cacheinfo_hygon_init_llc_id(struct cpuinfo_x86 *c, int cpu);
 
diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index f769d6d08b43..500401b9e645 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -358,6 +358,7 @@ static void amd_get_topology(struct cpuinfo_x86 *c)
 		if (!err)
 			c->x86_coreid_bits = get_count_order(c->x86_max_cores);
 
+		cacheinfo_topoext_init_l2c_id(c, cpu);
 		cacheinfo_amd_init_llc_id(c, cpu);
 
 	} else if (cpu_has(c, X86_FEATURE_NODEID_MSR)) {
diff --git a/arch/x86/kernel/cpu/cacheinfo.c b/arch/x86/kernel/cpu/cacheinfo.c
index f4e5aa27eec6..bed7b9633451 100644
--- a/arch/x86/kernel/cpu/cacheinfo.c
+++ b/arch/x86/kernel/cpu/cacheinfo.c
@@ -659,6 +659,42 @@ static int find_num_cache_leaves(struct cpuinfo_x86 *c)
 	return i;
 }
 
+void cacheinfo_topoext_init_l2c_id(struct cpuinfo_x86 *c, int cpu)
+{
+	u32 eax, ebx, ecx, edx, num_sharing_cache;
+	int i = 0, bits;
+
+	/* Check if L2 cache identifiers exists. */
+	if (!cpuid_ecx(0x80000006))
+		return;
+
+	while (true) {
+		u32 level;
+
+		cpuid_count(0x8000001d, i, &eax, &ebx, &ecx, &edx);
+		if (!eax)
+			return;
+
+		/*
+		 * Check if the current leaf is for L2 cache using
+		 * eax[7:5] used to describe the cache level.
+		 */
+		level = (eax >> 5) & 0x7;
+		if (level == 2)
+			break;
+
+		++i;
+	}
+
+	/*
+	 * L2 ID is calculated from the number of threads
+	 * sharing the L2 cache.
+	 */
+	num_sharing_cache = ((eax >> 14) & 0xfff) + 1;
+	bits = get_count_order(num_sharing_cache);
+	per_cpu(cpu_l2c_id, cpu) = c->apicid >> bits;
+}
+
 void cacheinfo_amd_init_llc_id(struct cpuinfo_x86 *c, int cpu)
 {
 	/*
diff --git a/arch/x86/kernel/cpu/hygon.c b/arch/x86/kernel/cpu/hygon.c
index 5a2962c492d3..cb0025b4a2fd 100644
--- a/arch/x86/kernel/cpu/hygon.c
+++ b/arch/x86/kernel/cpu/hygon.c
@@ -89,6 +89,7 @@ static void hygon_get_topology(struct cpuinfo_x86 *c)
 		/* Socket ID is ApicId[6] for these processors. */
 		c->phys_proc_id = c->apicid >> APICID_SOCKET_ID_BIT;
 
+		cacheinfo_topoext_init_l2c_id(c, cpu);
 		cacheinfo_hygon_init_llc_id(c, cpu);
 	} else if (cpu_has(c, X86_FEATURE_NODEID_MSR)) {
 		u64 value;
-- 
2.34.1

