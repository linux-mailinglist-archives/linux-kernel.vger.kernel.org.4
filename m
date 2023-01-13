Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E112669C2C
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 16:29:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230192AbjAMP30 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 10:29:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230210AbjAMP2U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 10:28:20 -0500
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2041.outbound.protection.outlook.com [40.107.96.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6C52848F4;
        Fri, 13 Jan 2023 07:21:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f02XeDn6wn3i3CLQv+P28YYXIHSqmrf2F2BmMt27Gt8mdOZckRCLcQE3Hf2CP7FQgHNVOD8DzFKZAdafauze2p5K6CXlQ5zHKBOtDryrB+d9rjFWOvXxWDDNhlTqifTUi1g243iTK6jMzdTx6kuKfS300E9pcsRjuXCpcVUtgfBhbm9QqzQmK0S/3EZ9q09j/XMvvhZ7dRv0nLJRW1SnIEHLsa/nEiYz/YIapOkFS9o49zxf7QWJjKwBzE1nzZqhc4+w4MZb84Yc0RjqpKSS1TJqAaY9/hbn50fAd4KIOUR62Y19XleR7vvxme7y8FU4kN42ks5IazHq3xQJ6f77lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KiGaBgNs34OVtg/o76sSHoa/Gi5RWgxUe3AGT5rQyXk=;
 b=ODMsHxqBOBMndwy48wlYpROgu0DQCpa00HNNibyJCwypjRbwIrPZJFqKIXRcQ42n+ANKaWG9UIR/IcSj11WIqmu7Yel149a5wmgrOTvUWDixoOMKcREvjfZkeKSup+gkWW0W1ZvEerHncdDQfp0hwXL8Owsbi9FHOMdvFnqpU8CgJqX1NdxE4cutmrUHF6m5+P6ORcD8v4yOXI6Wr1Bv525e/lj6GSlkS74nhIHOqUX6Hmqj69O47tNrH30NUoGLwj/EbJ02hxqKukZtwuym4uVB2uZn4/yTNANhoNd7Ubz9Y2B51bh2RZArZlHWZDItnMh6+sIEG8bn8ezrx2GX4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KiGaBgNs34OVtg/o76sSHoa/Gi5RWgxUe3AGT5rQyXk=;
 b=MTl0uHqTR8RpmkriE+m+udu3BkbHrLUGvcwN/7/RUmkTB72tNpVeJ5IMeDvqWw0yNF05nhROqORwPjaozr6Elnfw8wDqYkVVfYTThKDc/po5RzCJT38Q2gBkT1SjBwPLao9iiXg15HVgKYWOgNp0UMMsQBwqCLbjiytSzWkMvRI=
Received: from BN9PR03CA0474.namprd03.prod.outlook.com (2603:10b6:408:139::29)
 by DM4PR12MB6448.namprd12.prod.outlook.com (2603:10b6:8:8a::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5986.18; Fri, 13 Jan 2023 15:21:49 +0000
Received: from BN8NAM11FT065.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:139:cafe::80) by BN9PR03CA0474.outlook.office365.com
 (2603:10b6:408:139::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13 via Frontend
 Transport; Fri, 13 Jan 2023 15:21:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT065.mail.protection.outlook.com (10.13.177.63) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6002.13 via Frontend Transport; Fri, 13 Jan 2023 15:21:48 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 13 Jan
 2023 09:21:02 -0600
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
Subject: [PATCH v12 04/13] x86/cpufeatures: Add Bandwidth Monitoring Event Configuration feature flag
Date:   Fri, 13 Jan 2023 09:20:30 -0600
Message-ID: <20230113152039.770054-5-babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230113152039.770054-1-babu.moger@amd.com>
References: <20230113152039.770054-1-babu.moger@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT065:EE_|DM4PR12MB6448:EE_
X-MS-Office365-Filtering-Correlation-Id: fa4d8ce7-b154-4ef4-6573-08daf579e3f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gq0zv9d3Zo+NQyMNKWO/zSG2OUxpNZqq4sRjNRqjHKvuBO/U7sW2U8QsF8bt7CxjjOD1JSU9n7r1g2CCsPMNZ/Pe7qnUDBHJ4lURN6qezS6APbaFTYnz95DZyvGrs2jt9OK2Nhao3S2ULAUpP/rod9SOe+w7p+CeaCavcmo3mUVzhQWNXgeJL8Th5lHPh4xbwxco+FQwVKIxj6KYk3Wn6UP9PRZ4CR7om5vxL6k1WtRfgV1+d+ep3u4SQ/UGHZgi44SM9QS1ZiIxBt78ysbW7UXk/oDiVWU/1LoS3G7XVlxIrPDm1Bk7IlmdFWQ8rHvqkkYFZzzLqE82XSrysNqRRPPSW2jvRPszQlciGeFb4mamb5F+LSp0hYu4eXVqq6recEAnyCF/R0nCLhOf2Og2BybOb/SJ0OqE4F+fV40c4QjCLtNaPapDfqR+hT4hRN3Gx3ZjFik+xTylNacvE7O0+r2hSnSDlqkN5sINVAKzp8Of0PQuStYpmvtFlnPmzQQh34aI2v31AHNTQQULg9mVG0w0lJmDnP5QTPeOvK0d5tqlSCdX1WHjtacqeWjmudLTvlQR+WQMWKNJ0y0p1uHrT6fpgTSPp2I4DbgKNfPR/xMRuS7YVGA74lg8tVbhmq2OSM6NGLX7wEBUlfeK8XROZ1WrylENSBYPJvyTYiXGu0EC0XpHsCGuk28zBugR10s40dA7hNn08ISuaHDsGxFCkncnSYkb23jQWEJm9mDIk1rkjz29N616ckjsaDdOfLCKNCNJHxQCSfIdHcgjtClgkyDCuj32TgCeMtLtP7EQ0bNRmIgPKyai+vctpIJUZOHW
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(396003)(39860400002)(136003)(451199015)(36840700001)(40470700004)(46966006)(44832011)(2906002)(82310400005)(83380400001)(47076005)(336012)(36860700001)(426003)(1076003)(7406005)(7416002)(40480700001)(5660300002)(16526019)(186003)(8936002)(26005)(6666004)(36756003)(7696005)(2616005)(70586007)(41300700001)(70206006)(110136005)(81166007)(478600001)(8676002)(86362001)(54906003)(966005)(356005)(316002)(40460700003)(4326008)(82740400003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2023 15:21:48.9973
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa4d8ce7-b154-4ef4-6573-08daf579e3f1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT065.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6448
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
index fbf243a7937e..123613cdae93 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -308,6 +308,7 @@
 #define X86_FEATURE_CALL_DEPTH		(11*32+19) /* "" Call depth tracking for RSB stuffing */
 #define X86_FEATURE_MSR_TSX_CTRL	(11*32+20) /* "" MSR IA32_TSX_CTRL (Intel) implemented */
 #define X86_FEATURE_SMBA		(11*32+21) /* "" Slow Memory Bandwidth Allocation */
+#define X86_FEATURE_BMEC		(11*32+22) /* "" Bandwidth Monitoring Event Configuration */
 
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

