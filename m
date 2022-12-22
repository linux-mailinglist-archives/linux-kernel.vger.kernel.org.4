Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BA4265494E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 00:32:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbiLVXcC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 18:32:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235392AbiLVXbp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 18:31:45 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2040.outbound.protection.outlook.com [40.107.93.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1F2FDED8;
        Thu, 22 Dec 2022 15:31:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WvBYlRicDN0JMV22Ulk7p7tmehYMJlxv/k/IBUMth89Hy0/LM9FXhr5N3NCGInrvnfxfJG/rQHonLnRC6m/9NaB6B907mI3iKL8Y1xE9W6RSwS7ZQx4EyTXRu0hcVSqcqxnapThrCwJoxhXRPIEBSSBqVXIH2PV2jKo3GkyfgGZsH4YQBjjRvlvHD1uaIUNsGbmLCL5Zv3kxLieOqbAwbQ3P7jDNBgf/Owb8PpLQ7uiNBaCY5MnS6GRclNGnj0SP80jLm4i+1eY6hI+lc38u/7UfwafKti/jopd7VDQk3rjv/DAYnjOVg/QXazVIFuTHXB4W4SOQLRYzwH3V6yqJWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Bfz7NaQgOToWbH9FokuddOZoIT4xJvg949sQG3VCK0=;
 b=H7Erqs1jpYGFnT6RKrbfXcbVn7ey5fWoKd4/FEwSQsp56ggH4cq5Mh9iA1IbvcBj/9b8C0/gbPRni2ykaHHduG5kqlv9AFAXC93eRgZ9wrZzysNzQK67op1Br90vNTme+hXguNWegU2wy5JdeFouXWjvskT1tE5uoSYeLIVI68UPpBV4FMemyiCXH/sSKxmm8zElgPCzkFmOVWEfBbB+Tgn0bw9k8mR+NKkoflxBpk5rcMbfgzxhF2eCFivgTpMwsmL+vjPFLwK/nrGrDy0zsj+bh5x+Rn490DL97zp2ZKErWr1xMi/QcykaCh0m40H47Ostsz4Iog35+Uv41rgAJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Bfz7NaQgOToWbH9FokuddOZoIT4xJvg949sQG3VCK0=;
 b=zoGI14VXFTQTU5DXVS7xddHEE1ijn7sLxR9ye16IulE4UmL6k2tW4ScOhzyB9PC64clq8tGKF3BaaauT00b3WsvgCwBRG8MgPWNg6R1jFAxCTJCr5f5CwMTp+oQiLWNC9OURIDX2nG7AIzTrVSAv9rj1iFQD2Gic8mWoN0LAdMc=
Received: from CY5PR22CA0056.namprd22.prod.outlook.com (2603:10b6:930:1d::19)
 by BN9PR12MB5242.namprd12.prod.outlook.com (2603:10b6:408:11f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Thu, 22 Dec
 2022 23:31:42 +0000
Received: from CY4PEPF0000C97C.namprd02.prod.outlook.com
 (2603:10b6:930:1d:cafe::c4) by CY5PR22CA0056.outlook.office365.com
 (2603:10b6:930:1d::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.12 via Frontend
 Transport; Thu, 22 Dec 2022 23:31:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000C97C.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5944.8 via Frontend Transport; Thu, 22 Dec 2022 23:31:41 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 22 Dec
 2022 17:31:36 -0600
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
Subject: [PATCH v10 02/13] x86/cpufeatures: Add Slow Memory Bandwidth Allocation feature flag
Date:   Thu, 22 Dec 2022 17:31:16 -0600
Message-ID: <20221222233127.910538-3-babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000C97C:EE_|BN9PR12MB5242:EE_
X-MS-Office365-Filtering-Correlation-Id: accd1366-1f84-4c45-eab5-08dae474ae3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t6Bdqo/Yg3E1XwTr7KS7hkjXYCfSOlkDhzmcsDucwCiFBnaI0nFrIzykMO6slhvhE9CZQ/tfo7Ju38TdsJN+viNbeK2rTV91eBdWqUaoFyqtuKUGOcg5RTlPWKqiXcpeq5m18iEc5gA6b+lLHFMnD0G54/GRgDOJW3T8CSUXsBNSB19+iyMSSt32vRG0ospM/02OmQplY8HldLiKHegptS6cYkf0xDdER0AD70txZAZYR/L9UvM6yjlE3p/UuWXnken5gxTO2hm7gKj2S9J4Ghy9hr1q0swCV2uwF1/BNPW9lsY3GSwNzb1jbHUZJyfotuMus+EZUfSqETbZJ1ea5XytY7V9mN1B3lc3vPOmp3WwECX+8sgSkc01VG+UjcdE0yDwNistGOIfRxoAxkqqAhVqp6gwoXrUwBUmLHNYnTEibkPAD/6PsJGDumVbF441rjdXZu2buegRCcOEl0G1sB4aqdBsV2h9tGaSAbumT8xQZ69rwB3jQva34U7SbuY23oL3Vrs+Vve+kxiKNmMjvMtAcCPyCGG6HqsxYj5uGjQByxo2I9HbPbSSgUUSTpSmBL/YUNyEipbxM/TCHndsNcK2RVpXxrphFJAKlbFv8XE7Z2/wqE/IGVqyfnMFZ5I5BhPBo+Gn8ww4d3B2a5Cjo5ybjgW2Njer0DcH8TuZguDQnfPzk3k4Ny5yWIjBinXDxz+Obxgmi08Iec6WzHxkkg39yXcKPXTJaAp3vv3r6h8ql5NKyf3q1ruVy6bIlNPhN8jJReLFTG1+4sL+fMl3IB8L698Fq6++RjP70thlJn4UibjIIG0blcYMUV3YIsT/
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(346002)(39860400002)(396003)(451199015)(40470700004)(46966006)(36840700001)(36756003)(356005)(82740400003)(2906002)(81166007)(5660300002)(8936002)(7406005)(41300700001)(7416002)(44832011)(47076005)(426003)(1076003)(36860700001)(336012)(83380400001)(86362001)(40460700003)(110136005)(4326008)(8676002)(316002)(54906003)(82310400005)(6666004)(478600001)(40480700001)(966005)(7696005)(70586007)(16526019)(70206006)(186003)(26005)(2616005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2022 23:31:41.5532
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: accd1366-1f84-4c45-eab5-08dae474ae3a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000C97C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5242
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the new AMD feature X86_FEATURE_SMBA. With this feature, the QOS
enforcement policies can be applied to external slow memory connected
to the host. QOS enforcement is accomplished by assigning a Class Of
Service (COS) to a processor and specifying allocations or limits for
that COS for each resource to be allocated.

This feature is identified by the CPUID Function 8000_0020_EBX_x0.

CPUID Fn8000_0020_EBX_x0 AMD Bandwidth Enforcement Feature Identifiers
(ECX=0)

Bits    Field Name      Description
2       L3SBE           L3 external slow memory bandwidth enforcement

CXL.memory is the only supported "slow" memory device. With the support
of SMBA feature, the hardware enables bandwidth allocation on the slow
memory devices. If there are multiple slow memory devices in the system,
then the throttling logic groups all the slow sources together and
applies the limit on them as a whole.

The presence of the SMBA feature(with CXL.memory) is independent of
whether slow memory device is actually present in the system. If there
is no slow memory in the system, then setting a SMBA limit will have no
impact on the performance of the system.

Presence of CXL memory can be identified by numactl command.

$numactl -H
available: 2 nodes (0-1)
node 0 cpus: 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16
node 0 size: 63678 MB node 0 free: 59542 MB
node 1 cpus:
node 1 size: 16122 MB
node 1 free: 15627 MB
node distances:
node   0   1
   0:  10  50
   1:  50  10

CPU list for CXL memory will be empty. The cpu-cxl node distance is
greater than cpu-to-cpu distances. Node 1 has the CXL memory in this
case. CXL memory can also be identified using ACPI SRAT table and
memory maps.

Feature description is available in the specification, "AMD64
Technology Platform Quality of Service Extensions, Revision: 1.03
Publication # 56375 Revision: 1.03 Issue Date: February 2022".

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Babu Moger <babu.moger@amd.com>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
Link: https://www.amd.com/en/support/tech-docs/amd64-technology-platform-quality-service-extensions
---
 arch/x86/include/asm/cpufeatures.h | 1 +
 arch/x86/kernel/cpu/scattered.c    | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 61012476d66e..00045123f418 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -307,6 +307,7 @@
 #define X86_FEATURE_SGX_EDECCSSA	(11*32+18) /* "" SGX EDECCSSA user leaf function */
 #define X86_FEATURE_CALL_DEPTH		(11*32+19) /* "" Call depth tracking for RSB stuffing */
 #define X86_FEATURE_MSR_TSX_CTRL	(11*32+20) /* "" MSR IA32_TSX_CTRL (Intel) implemented */
+#define X86_FEATURE_SMBA		(11*32+21) /* Slow Memory Bandwidth Allocation */
 
 /* Intel-defined CPU features, CPUID level 0x00000007:1 (EAX), word 12 */
 #define X86_FEATURE_AVX_VNNI		(12*32+ 4) /* AVX VNNI instructions */
diff --git a/arch/x86/kernel/cpu/scattered.c b/arch/x86/kernel/cpu/scattered.c
index f53944fb8f7f..d925753084fb 100644
--- a/arch/x86/kernel/cpu/scattered.c
+++ b/arch/x86/kernel/cpu/scattered.c
@@ -45,6 +45,7 @@ static const struct cpuid_bit cpuid_bits[] = {
 	{ X86_FEATURE_CPB,		CPUID_EDX,  9, 0x80000007, 0 },
 	{ X86_FEATURE_PROC_FEEDBACK,    CPUID_EDX, 11, 0x80000007, 0 },
 	{ X86_FEATURE_MBA,		CPUID_EBX,  6, 0x80000008, 0 },
+	{ X86_FEATURE_SMBA,		CPUID_EBX,  2, 0x80000020, 0 },
 	{ X86_FEATURE_PERFMON_V2,	CPUID_EAX,  0, 0x80000022, 0 },
 	{ X86_FEATURE_AMD_LBR_V2,	CPUID_EAX,  1, 0x80000022, 0 },
 	{ 0, 0, 0, 0, 0 }
-- 
2.34.1

