Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CE766DC963
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 18:37:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbjDJQhC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 12:37:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbjDJQhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 12:37:00 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2084.outbound.protection.outlook.com [40.107.93.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CF93E60;
        Mon, 10 Apr 2023 09:36:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HJeTNzFZOsqUo5NeDnNUuhFEqTJJY3zLzAID8tJH41cuFInAaAbi1jvJEycKWPTX5ZVYXcNlTuklYRLaO7QzkA/CkZTkpV7hGqQ4BLrPeR1YkxJrxNjTQe4vb/C/XFjOPtyjZmKGRbRisfWrBV0w2bXjLwqgM3HM6RkvUNgEpDGAO5/pZH6EnEzPVEL60BoDjzAMiBurS8DMRhI5KSfM4AtrElmodJO/LobPjKgK6qOAsLpnyFBKx+nBaPDzxVVjgd+qpJ3f+L3I375323jaMBGRkDcNHEEy5vE9sXLAoz5r+hj9+Feda7XinKGGxM0hNaN0OWWipSa8k8ltg7Z0oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fQXJuqO8juoH20vbkU/ZUIPc/4O4JURjD1VQ/3DgaYk=;
 b=WFi8aSVssG6/CWVLxQ/kQvDYwu+223n+W29H/gY4OT39BEU/+6mgCiwYgc3G22T3JMn3L/A6EMH6l8pJrJ3MEN744vSlBAkwv9D6TJdxsgakcySNlS4khPuQzXDdu5bY9kS68kXYxxc3zdfwqZTBmMPVTgn8e65GNlZ6+1QC5y6XGZGrKEa5vj1NRrieQzR3oONrI4xsO+LoQOLbAF+O56Cf1RE6EL6G5Y+yLUAYDQMGfmhKJCvzVRS1SjbKaFIQiz5/tgR+LatgDUgYrQ1eN0xdsCf5kdrQnwd+/rKkRlrnXficqzT+ODrCbuv5//VpU0VdYBqi4e4ibaeeNQRjQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fQXJuqO8juoH20vbkU/ZUIPc/4O4JURjD1VQ/3DgaYk=;
 b=CrXZACgGaT4cl4JcZI/1K+mbrRXor+CuItAYvXo89UCilB9Rz6bwEQvLzNDLFBPAX3qKFpvhMWpD8gT1OS4Nd+xLJ8qevnLpludX+BcVihXXkVJ/VQHWaIibJBSW3uMrVjC5Rb9esjk7sDLKi+CnPMrqdK6kKL5W9eg1Nb58nYE=
Received: from MN2PR03CA0004.namprd03.prod.outlook.com (2603:10b6:208:23a::9)
 by BY5PR12MB4918.namprd12.prod.outlook.com (2603:10b6:a03:1df::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.35; Mon, 10 Apr
 2023 16:36:55 +0000
Received: from BL02EPF000145B9.namprd05.prod.outlook.com
 (2603:10b6:208:23a::4) by MN2PR03CA0004.outlook.office365.com
 (2603:10b6:208:23a::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.36 via Frontend
 Transport; Mon, 10 Apr 2023 16:36:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF000145B9.mail.protection.outlook.com (10.167.241.209) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6298.25 via Frontend Transport; Mon, 10 Apr 2023 16:36:54 +0000
Received: from BLR5CG134614W.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 10 Apr
 2023 11:36:05 -0500
From:   K Prateek Nayak <kprateek.nayak@amd.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <hpa@zytor.com>, <corbet@lwn.net>,
        <jgross@suse.com>, <andrew.cooper3@citrix.com>,
        <peterz@infradead.org>, <Jason@zx2c4.com>,
        <thomas.lendacky@amd.com>, <puwen@hygon.cn>, <x86@kernel.org>,
        <linux-doc@vger.kernel.org>
Subject: [PATCH 1/2] arch/x86: Set L2 Cache ID on AMD processors
Date:   Mon, 10 Apr 2023 22:05:26 +0530
Message-ID: <20230410163527.1626-2-kprateek.nayak@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230410163527.1626-1-kprateek.nayak@amd.com>
References: <20230410163527.1626-1-kprateek.nayak@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000145B9:EE_|BY5PR12MB4918:EE_
X-MS-Office365-Filtering-Correlation-Id: 8960ad6b-9f52-47e7-5777-08db39e1cb26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Rvj8oGPFabELz5JbgxkgqfqW+WNbSyuvkpM0xcvNofi28zmrytxJbBTCP4jixW5pE2cPe2N9shk9//tOYmBysQExDoduBjjN5Ad+xPp9APd19fo3qDXhJCWshVQWXM5PglH1h0QkAhLCljm0i6rbCPgn6xtjaI70s7TKeIpQswxdfXz7jXOeWgGhNx0MP//nfNOrMklXFMpnUclqJX9XoZ4AJqAuR/YXBNnUNrmz/MKix+bkdgBO/JgKf/CW3aZ7v9bdVEcIDQcSdxgLBgzzUeWyqRBA/LxjXfQjxgWihVXyVeoPcfgVwSAFcVRcDqwXfxeteLW6v1HYPP0xhhCRWCq7QteuBmnmyv9i5HMULJolmN+ENBIyQAjDivf1bolkjYaCb4QoGTc5j9lmtHdfcRzWPH105tkYHfveIEDTuPtV/pwvCcTe7JGQ9dzzFt4s8q7JQ2CPgNBhqghS/f8BcrD0wZ1dBBI9yfx8b6lQU1/nXt+4GWz+pGa52+1VsBqQJ1Ya2rpLcn02fu4XPYdsMsQ0Ygh7SWP6Q8CIjcumzfkhmXl3Kz8VjwNeuQkc4zo4PdrF0B5mndNQoz8xhw2CXe7yMN2fgC2ElRmlwrz14FJmpH0I9vk1/nkr7+V/7AfjjpFHyw7E/+jpRPWnHvIcdC9RWjrvTgWopPNR6PV+XlAEabQwwWLvslHqn9KPZkatpzt2QPv8JDcXISFyYDdYHSTfXwnZCSeKUWXpzIxu8Ew=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(396003)(376002)(136003)(451199021)(40470700004)(46966006)(36840700001)(316002)(82310400005)(54906003)(356005)(36860700001)(82740400003)(81166007)(70586007)(8676002)(70206006)(86362001)(478600001)(6916009)(4326008)(83380400001)(336012)(426003)(47076005)(2616005)(186003)(16526019)(41300700001)(36756003)(2906002)(1076003)(26005)(7696005)(40460700003)(40480700001)(8936002)(6666004)(5660300002)(7416002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2023 16:36:54.1300
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8960ad6b-9f52-47e7-5777-08db39e1cb26
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000145B9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4918
X-Spam-Status: No, score=0.8 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On AMD processors supporting X86_FEATURE_TOPOEXT set the l2c_id using the
Extended APIC ID and the Cache Properties CPUID.

Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
 arch/x86/include/asm/cacheinfo.h |  1 +
 arch/x86/kernel/cpu/amd.c        |  1 +
 arch/x86/kernel/cpu/cacheinfo.c  | 36 ++++++++++++++++++++++++++++++++
 3 files changed, 38 insertions(+)

diff --git a/arch/x86/include/asm/cacheinfo.h b/arch/x86/include/asm/cacheinfo.h
index ce9685fc78d8..5e472fc364c8 100644
--- a/arch/x86/include/asm/cacheinfo.h
+++ b/arch/x86/include/asm/cacheinfo.h
@@ -7,6 +7,7 @@ extern unsigned int memory_caching_control;
 #define CACHE_MTRR 0x01
 #define CACHE_PAT  0x02
 
+void cacheinfo_amd_init_l2c_id(struct cpuinfo_x86 *c, int cpu);
 void cacheinfo_amd_init_llc_id(struct cpuinfo_x86 *c, int cpu);
 void cacheinfo_hygon_init_llc_id(struct cpuinfo_x86 *c, int cpu);
 
diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index f769d6d08b43..e68d31231666 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -358,6 +358,7 @@ static void amd_get_topology(struct cpuinfo_x86 *c)
 		if (!err)
 			c->x86_coreid_bits = get_count_order(c->x86_max_cores);
 
+		cacheinfo_amd_init_l2c_id(c, cpu);
 		cacheinfo_amd_init_llc_id(c, cpu);
 
 	} else if (cpu_has(c, X86_FEATURE_NODEID_MSR)) {
diff --git a/arch/x86/kernel/cpu/cacheinfo.c b/arch/x86/kernel/cpu/cacheinfo.c
index f4e5aa27eec6..0baf2d9b1595 100644
--- a/arch/x86/kernel/cpu/cacheinfo.c
+++ b/arch/x86/kernel/cpu/cacheinfo.c
@@ -659,6 +659,42 @@ static int find_num_cache_leaves(struct cpuinfo_x86 *c)
 	return i;
 }
 
+void cacheinfo_amd_init_l2c_id(struct cpuinfo_x86 *c, int cpu)
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
-- 
2.34.1

