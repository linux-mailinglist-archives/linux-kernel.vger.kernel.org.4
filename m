Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22706669C2B
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 16:29:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230199AbjAMP3Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 10:29:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbjAMP2U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 10:28:20 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2044.outbound.protection.outlook.com [40.107.237.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF90177AF2;
        Fri, 13 Jan 2023 07:21:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ejhzWW3Pb9ts8l5dvvmIx1yVhId2WWwrRQahFLBsM3OosBsxKRqSAfvDM/jfkH5sUajS+ne7PhO9YspLyk3lq0X6QVd34chlREVkN+qz575y0OsvwXZeXM1ugrapFRs6hVKMeA2pUCQgF0RaLbYxrCrH1LubGXhI9gp16BDCDdeV75vRfHJ2Zwxw5ES8wVoyxLj/cXFDo0qtEVLGJB6S3QRJP31nFWOArdLIpF4F3NAIDHfXGsAYBGh7Go11Zk90jBY2iMWIx2ZBLc9oy/0E3LYqqsoiqmraRuvDfuwKNunwsnnOmlAiiv3U9dVqmQ2pUxHcZI4k0DzdN2iIJ8jh/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FzDFKJ3+nyXUlwpkG749r2oh7fMs4dipjYKpYOgdLjg=;
 b=CUACCOowpZrjOj2frwTs6WogsBsQSaH5EAi21mkCGoLqTBRfJRzbq9JAkkaUn5eGbwrx9SP1TE+Rb0eSoYGpgjXNIBvXsdMKMie5Mq1OVIAhLJJXmDOjKJ9FJvsWUaXWM+vNsRoVH1KUX3vvfy8lzIravbnNGEaAzPzctvReI91E/4mvYUPRa5FczypzulVQXaGAFnT8Go9fd+QJY5HMW20/63GiibW7gWNK/nxLvFH1+WtQDY8XZA32Xx+IfgJ+5MyS5Y6EH/TCypI5kv7jcjY6NcwOFo51+GIJpITc/INQmwHDGxu489Gh1h25PBl50Wluz1BfOmSMBmQ2gFVSWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FzDFKJ3+nyXUlwpkG749r2oh7fMs4dipjYKpYOgdLjg=;
 b=O4amWdP3sloy1hyFwdYtgqpUq2RozzOQcuXRZNXji43NaMkknPe1TJTYR7j1cGhH4ZOrr0UMR9l3+aMBnqv/E49f/qZVrF8qB3/tgh603mWe/BVe1tWJN5EzN4YI7nNTu4X7UFJniWRt74PRyS4MQZxLEHgELcNbhT6MdaHucaU=
Received: from BN9PR03CA0464.namprd03.prod.outlook.com (2603:10b6:408:139::19)
 by SJ1PR12MB6123.namprd12.prod.outlook.com (2603:10b6:a03:45a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Fri, 13 Jan
 2023 15:21:48 +0000
Received: from BN8NAM11FT065.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:139:cafe::87) by BN9PR03CA0464.outlook.office365.com
 (2603:10b6:408:139::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.16 via Frontend
 Transport; Fri, 13 Jan 2023 15:21:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT065.mail.protection.outlook.com (10.13.177.63) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6002.13 via Frontend Transport; Fri, 13 Jan 2023 15:21:47 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 13 Jan
 2023 09:20:58 -0600
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
Subject: [PATCH v12 02/13] x86/cpufeatures: Add Slow Memory Bandwidth Allocation feature flag
Date:   Fri, 13 Jan 2023 09:20:28 -0600
Message-ID: <20230113152039.770054-3-babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT065:EE_|SJ1PR12MB6123:EE_
X-MS-Office365-Filtering-Correlation-Id: 183a7e72-111f-4ad8-492c-08daf579e330
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S+EJ5OzoZDBAVVh6UXnA+64wgR+89cHL2gfEpSlYxV7+JhuqJcZ0rZ3DUDEuduma8KHGxXRS7oAyNFkwt9MwuE8AaSTKBCTly7XslvGevonEfOmNK0difKK1vESziLM757rxr7v89T3HPFvOz6xkOkG9/Kc17nUea0IAierROkbavPm2s4W8ITLsESRbqc2apmvrVKBtHHnu15fLXpm2VunDCrqkFHL3r+2yC2nhwQhS4RR/NjzEM5W8gIrdSqlnioIdsN1AU/67dT8COUlMZTJQ5d5t9v98iMLLGH/jFN5vymJGKiuadwJG5xdQTVDnNreCKZmytvcGYzbeOvV0nohylIB2w8ddWVBA6piG9nXcT52zH+wY+6/G7zS/96g4WeokY5kwIlljZSI9AF2S60Y2YrdsBNF8+4y8mBPPzYNpVI981q3cVrVMdG/wT92XIHE3VtuZHTjBH3ermCMltBf3XLxdeFwB8MUZS+59lvlYpcCG0g1nO5ozcqvZCmpUhm76SFozg5vZx2Lv+Jx/PBh1mu+LY4mOsL7bbbeqLQeZPYe5BQCyVwac8zHVdPAA5ZBWGRmQ+p1zKZvFMK9eeANY285zoxX8XasAFCfuTyI6QTHXzq/15gj52NcRnEIKo20R7PzMuB51uWDYOz9P1eSdRY9HpjhbFVDcus8cfayLrQQ3tHlcxICHsTcfyHqqOp7vv8EwkiMTrdg0vZuwOlu5QFjQVnlmsy8Ha1hUQ/Yc/zF5cu9UYs5DXHRw5/Pk+jqWYmDmKXi/H0p+Sv2ggYebfJ05tWuAytgSzsquXLEEqecq1x1n0S1NaVPVD2Dj
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(346002)(376002)(136003)(451199015)(40470700004)(46966006)(36840700001)(8676002)(83380400001)(36860700001)(2906002)(8936002)(70586007)(7416002)(81166007)(356005)(4326008)(44832011)(7406005)(5660300002)(70206006)(82310400005)(186003)(41300700001)(47076005)(110136005)(40480700001)(16526019)(26005)(6666004)(1076003)(7696005)(2616005)(426003)(82740400003)(966005)(40460700003)(54906003)(478600001)(316002)(86362001)(336012)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2023 15:21:47.7318
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 183a7e72-111f-4ad8-492c-08daf579e330
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT065.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6123
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
index 6cfa7143c316..fbf243a7937e 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -307,6 +307,7 @@
 #define X86_FEATURE_SGX_EDECCSSA	(11*32+18) /* "" SGX EDECCSSA user leaf function */
 #define X86_FEATURE_CALL_DEPTH		(11*32+19) /* "" Call depth tracking for RSB stuffing */
 #define X86_FEATURE_MSR_TSX_CTRL	(11*32+20) /* "" MSR IA32_TSX_CTRL (Intel) implemented */
+#define X86_FEATURE_SMBA		(11*32+21) /* "" Slow Memory Bandwidth Allocation */
 
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

