Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 798C5654950
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 00:32:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235767AbiLVXcL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 18:32:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235759AbiLVXb6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 18:31:58 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2044.outbound.protection.outlook.com [40.107.220.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A73962CC83;
        Thu, 22 Dec 2022 15:31:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fK+uAVGbPbR69hkY2otEdcD72A5+qqRqaIiVFrCHkassVe9/REXULHyFGaHxhzMQHU1tIzk5h6YpYvjhXoZAb/NQmNlkKOwZrsLCZlRWa+aoCSjQDGbvwgKFjnwI5prkoTzK1esLFk9NCqa++KjBbFr664i4DmSaxr1kBZMNmsqbsjVSYZ8y5wJwdQVmKBvHoCiV0B6YLEiPuyWBAa8uNzBJTLM8Y8gAFR+QqOCPMfsIl0uaOBddsuoTQYrPDYl2pbfDW+rs/SCZ8XKeY8ezvjkdcXAlwCouZOYj0IrVRHCOkuNweC5jjqkyC6UhISsdRk83LdnxpdiJDfNTwG+EnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Twd7ddBJxwhZGfyhY4WBCZBaAd4nlAK3kbxKuE11Hk=;
 b=TG9q8+CMd3DCh0ttwYwSRsZYMMpTlX3RjjusAfACx+4of3WJWZTSD8u7EuiX+7yGIihB0MJrpinlQ6dTb3hlFGBn3QRjsny35oHbdAET7tuBXkoZr/9Qy5z+vcyE5yoY8DCg2YvPjP4yfeURSF3BSweyDV9rChWTyQKWqjKui/ec/7JgbvqxyoOH6B3eUMGfUzJeLP4njTSRlKa5uIlKVxNd4G8o9nST6radDCmk8SQNM2V6Kc1mpkes298/nhYI6IKOemcsT3eWX4CNnr+Nw9OGw/ONmzzSqMLOz3SwDDf4A08hjCxIUK0Sp0x9wmT+oqMEk1+mQ/QiQjc52386Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Twd7ddBJxwhZGfyhY4WBCZBaAd4nlAK3kbxKuE11Hk=;
 b=UMucEiSnl4gyeDc8fWbKYriL+KPmb7c9nCGl9UTxj1YTQqf9riAT58wzAMZmfjavuQmOHnXsYSmrpjilWssk4O8wpb/NpSi8Sxi7fvZY9/HqO2uFIQOXX3YnxO8pexc23of5V1mtOC8zu8WEGG+EY9NhCcdd1Bqe1KBGbvsNDPk=
Received: from CY5PR22CA0053.namprd22.prod.outlook.com (2603:10b6:930:1d::21)
 by DM4PR12MB6591.namprd12.prod.outlook.com (2603:10b6:8:8e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Thu, 22 Dec
 2022 23:31:48 +0000
Received: from CY4PEPF0000C97C.namprd02.prod.outlook.com
 (2603:10b6:930:1d:cafe::21) by CY5PR22CA0053.outlook.office365.com
 (2603:10b6:930:1d::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.12 via Frontend
 Transport; Thu, 22 Dec 2022 23:31:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000C97C.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5944.8 via Frontend Transport; Thu, 22 Dec 2022 23:31:43 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 22 Dec
 2022 17:31:40 -0600
From:   Babu Moger <babu.moger@amd.com>
To:     <corbet@lwn.net>, <reinette.chatre@intel.com>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>
CC:     <fenghua.yu@intel.com>, <dave.hansen@linux.intel.com>,
        <x86@kernel.org>, <hpa@zytor.com>, <paulmck@kernel.org>,
        <akpm@linux-foundation.org>, <quic_neeraju@quicinc.com>,
        <rdunlap@infradead.org>, <damien.lemoal@opensource.wdc.com>,
        <songmuchun@bytedance.com>, <peterz@infradead.org>,
        <jpoimboe@kernel.org>, <pbonzini@redhat.com>, <babu.moger@amd.com>,
        <chang.seok.bae@intel.com>, <pawan.kumar.gupta@linux.intel.com>,
        <jmattson@google.com>, <daniel.sneddon@linux.intel.com>,
        <sandipan.das@amd.com>, <tony.luck@intel.com>,
        <james.morse@arm.com>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <bagasdotme@gmail.com>,
        <eranian@google.com>, <christophe.leroy@csgroup.eu>,
        <jarkko@kernel.org>, <adrian.hunter@intel.com>,
        <quic_jiles@quicinc.com>, <peternewman@google.com>
Subject: [PATCH v10 04/13] x86/cpufeatures: Add Bandwidth Monitoring Event Configuration feature flag
Date:   Thu, 22 Dec 2022 17:31:18 -0600
Message-ID: <20221222233127.910538-5-babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221222233127.910538-1-babu.moger@amd.com>
References: <20221222233127.910538-1-babu.moger@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000C97C:EE_|DM4PR12MB6591:EE_
X-MS-Office365-Filtering-Correlation-Id: f8d00981-559e-43e9-044f-08dae474af3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RPafVrSZg9ZaZi3EugXwRiP0hJbtPbUZK2DK9DBiUhFo2Ugx3fX4UdRw6mxFN9sORmHe5a8JcO60/N7m2KZQjd7IJYi3rZbSmoGMi3bw46KMM0XL/YW/+5IT4IWztXTbGG36CE9/OLQYADmWQj8GXhWPsbLNSHN1CAix3qmMwdTkieCowrqB3BBrJYEOjZO/y6UTfHaZCi+DE7rmuJw+Ru0hUYCH2uctdeFv1cJ71h9F1olJlNJ2o51UmdBrAplAUB7gnTan4VL0UcV/BzKHs9sL2OSDhwvAk6jEbDkBFFeLoc/2opdPA7RS0FASBAYlcui/iX3eCTi4f941yPiMNWF7S1+6jUhNbrlJp5fl/LlWppZKylc86gZx8dklDOaG1PdpS4Y8V/yCNnic2+1OT/YuVEAU47EExujIS9KE4lU5c4OIrfGQAKtiOzZ7j8/P8jDLSNvQV/i7PUu5vUh+TWkDyGaUMXrzXiASREUspJ2nghO6xCz9KF+6Uip7Fmex5pbfv2UDYUsX5oUcAT+1U8VvSISCl43J+B+LxsFSwSLklDj/79sF2Ucjf9pXBThjevte/tjwD7S0uh8LwVe7I6/ESgjhJZ7FJUNPrUYJmRl289HB5QlbOXS9UWjdppOHdjHNUH+43g+SekXsqj0E30le6H2LEEya40z7HVR7HZZQ6PxP7rMQAO59TJVVoU4WaZ92+ZwomqCKOgJtAabdTBcaNkXQ5t3h68baJoGLEmVT4k/jLftqP+CkyfIBrD7oSJWk/9i/JxuEEAuOdFMMpcXK20lnjUVcfmhpfOhrkHVmXIQ3xIXIzG3EALa+LOcj
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(396003)(346002)(136003)(451199015)(40470700004)(36840700001)(46966006)(70206006)(2906002)(40480700001)(8676002)(86362001)(2616005)(336012)(4326008)(41300700001)(478600001)(83380400001)(1076003)(186003)(16526019)(6666004)(316002)(36860700001)(54906003)(110136005)(7696005)(356005)(81166007)(7416002)(82740400003)(40460700003)(7406005)(44832011)(426003)(8936002)(5660300002)(966005)(47076005)(26005)(82310400005)(36756003)(70586007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2022 23:31:43.1782
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f8d00981-559e-43e9-044f-08dae474af3a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000C97C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6591
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Newer AMD processors support the new feature Bandwidth Monitoring Event
Configuration (BMEC).

The feature support is identified via CPUID Fn8000_0020_EBX_x0 (ECX=0).
Bits    Field Name    Description
3       EVT_CFG       Bandwidth Monitoring Event Configuration (BMEC)

The bandwidth monitoring events mbm_total_bytes and mbm_local_bytes are
set to count all the total and local reads/writes respectively. With the
introduction of slow memory, the two counters are not enough to count
all the different types of memory events. With the feature BMEC, the
users have the option to configure mbm_total_bytes and mbm_local_bytes
to count the specific type of events.

Each BMEC event has a configuration MSR, which contains one field for
each bandwidth type that can be used to configure the bandwidth event
to track any combination of supported bandwidth types. The event will
count requests from every bandwidth type bit that is set in the
corresponding configuration register.

Following are the types of events supported:

====    ========================================================
Bits    Description
====    ========================================================
6       Dirty Victims from the QOS domain to all types of memory
5       Reads to slow memory in the non-local NUMA domain
4       Reads to slow memory in the local NUMA domain
3       Non-temporal writes to non-local NUMA domain
2       Non-temporal writes to local NUMA domain
1       Reads to memory in the non-local NUMA domain
0       Reads to memory in the local NUMA domain
====    ========================================================

By default, the mbm_total_bytes configuration is set to 0x7F to count
all the event types and the mbm_local_bytes configuration is set to
0x15 to count all the local memory events.

Feature description is available in the specification, "AMD64
Technology Platform Quality of Service Extensions, Revision: 1.03
Publication".

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Babu Moger <babu.moger@amd.com>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
Link: https://www.amd.com/en/support/tech-docs/amd64-technology-platform-quality-service-extensions
---
 arch/x86/include/asm/cpufeatures.h | 1 +
 arch/x86/kernel/cpu/cpuid-deps.c   | 2 ++
 arch/x86/kernel/cpu/scattered.c    | 1 +
 3 files changed, 4 insertions(+)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 00045123f418..db5287c06b65 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -308,6 +308,7 @@
 #define X86_FEATURE_CALL_DEPTH		(11*32+19) /* "" Call depth tracking for RSB stuffing */
 #define X86_FEATURE_MSR_TSX_CTRL	(11*32+20) /* "" MSR IA32_TSX_CTRL (Intel) implemented */
 #define X86_FEATURE_SMBA		(11*32+21) /* Slow Memory Bandwidth Allocation */
+#define X86_FEATURE_BMEC		(11*32+22) /* Bandwidth Monitoring Event Configuration */
 
 /* Intel-defined CPU features, CPUID level 0x00000007:1 (EAX), word 12 */
 #define X86_FEATURE_AVX_VNNI		(12*32+ 4) /* AVX VNNI instructions */
diff --git a/arch/x86/kernel/cpu/cpuid-deps.c b/arch/x86/kernel/cpu/cpuid-deps.c
index d95221117129..f6748c8bd647 100644
--- a/arch/x86/kernel/cpu/cpuid-deps.c
+++ b/arch/x86/kernel/cpu/cpuid-deps.c
@@ -68,6 +68,8 @@ static const struct cpuid_dep cpuid_deps[] = {
 	{ X86_FEATURE_CQM_OCCUP_LLC,		X86_FEATURE_CQM_LLC   },
 	{ X86_FEATURE_CQM_MBM_TOTAL,		X86_FEATURE_CQM_LLC   },
 	{ X86_FEATURE_CQM_MBM_LOCAL,		X86_FEATURE_CQM_LLC   },
+	{ X86_FEATURE_BMEC,			X86_FEATURE_CQM_MBM_TOTAL   },
+	{ X86_FEATURE_BMEC,			X86_FEATURE_CQM_MBM_LOCAL   },
 	{ X86_FEATURE_AVX512_BF16,		X86_FEATURE_AVX512VL  },
 	{ X86_FEATURE_AVX512_FP16,		X86_FEATURE_AVX512BW  },
 	{ X86_FEATURE_ENQCMD,			X86_FEATURE_XSAVES    },
diff --git a/arch/x86/kernel/cpu/scattered.c b/arch/x86/kernel/cpu/scattered.c
index d925753084fb..0dad49a09b7a 100644
--- a/arch/x86/kernel/cpu/scattered.c
+++ b/arch/x86/kernel/cpu/scattered.c
@@ -46,6 +46,7 @@ static const struct cpuid_bit cpuid_bits[] = {
 	{ X86_FEATURE_PROC_FEEDBACK,    CPUID_EDX, 11, 0x80000007, 0 },
 	{ X86_FEATURE_MBA,		CPUID_EBX,  6, 0x80000008, 0 },
 	{ X86_FEATURE_SMBA,		CPUID_EBX,  2, 0x80000020, 0 },
+	{ X86_FEATURE_BMEC,		CPUID_EBX,  3, 0x80000020, 0 },
 	{ X86_FEATURE_PERFMON_V2,	CPUID_EAX,  0, 0x80000022, 0 },
 	{ X86_FEATURE_AMD_LBR_V2,	CPUID_EAX,  1, 0x80000022, 0 },
 	{ 0, 0, 0, 0, 0 }
-- 
2.34.1

