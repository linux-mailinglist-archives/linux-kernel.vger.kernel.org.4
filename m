Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54014662B84
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 17:45:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235414AbjAIQot (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 11:44:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234251AbjAIQoT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 11:44:19 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2057.outbound.protection.outlook.com [40.107.220.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E32E95F43;
        Mon,  9 Jan 2023 08:44:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nFjIMtNgFfFG1IhsGJL5vSxotpsI2JNq4/vnAw1NB6Lr1mmKc/KJ0jxIHG6VsxpI003NdX0KXz3/NfgJPaBFouhJqeuYaE/xMsjnOoKnfnBzD6jBtJTlTAesW5W8ptStX4nMg8TFgljC2jyHp0cFGgZ8NrAXL02oErGjxuPu4PS1JtASsbxOz/9jaD5BiJX50pKhBXkNHTsHt576cEbcz9zU8RrqRRCPJsa2vwSGgb6ILaSB65YuDEajNb+6pckAz8znv/CGSutiEqWBYUt+KS/QlR9nybenFtNFYpUnF+GP3smW/rKAveuo1TZRgh/LYl9cqFwoMqTaS1aM0tZ30w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Bfz7NaQgOToWbH9FokuddOZoIT4xJvg949sQG3VCK0=;
 b=Pk+dYxEvBVyw7W9kyMkiz+NLubpN6yDM6HNY88Slv0k6i9cxup0XuxKIYqd+fnKFJEIVc4JUixEpmlq6md4b7PhekfieR3H0d2Dwtbua3uUAfmqVM91qfgrMt9gxw7zVPybXPhs07iBqMmfvwMpEjjET4Z998qDtoYWHAxMWGbm5TFu8cVM2DKn5ZwTuwfCt1bR+ynOLLAAR3U5M5Yv6Ar4fAGwmAgWppXIltkTnV8EfQwA8ZJih+W9SbaQCnFvqg+MQMOY7ZlqRx8gOY7U+Z9dCRD/IO1yvQ8IjB1lTKlONLrytxeTM60xxgeOpUNVRAYXzTSh55+OCHGdfpXioYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Bfz7NaQgOToWbH9FokuddOZoIT4xJvg949sQG3VCK0=;
 b=Y2n5ohuc6OyiAQQm9+UtmE7mp9plql1aa1ER446jQwiK5UHaCOAcxe2LDw8LktoAE6+ODUFvRA59oM+4XSqgL3+K2kV4BPBwuwXheY3yFiI25sxNnFWAngqE6uvSSjxRLcBmdXvKAf6Ysh04MezkRm8LhOlu6fuwckm7dTB+SEs=
Received: from DM6PR14CA0054.namprd14.prod.outlook.com (2603:10b6:5:18f::31)
 by PH7PR12MB6835.namprd12.prod.outlook.com (2603:10b6:510:1b5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Mon, 9 Jan
 2023 16:44:16 +0000
Received: from DM6NAM11FT004.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:18f:cafe::be) by DM6PR14CA0054.outlook.office365.com
 (2603:10b6:5:18f::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18 via Frontend
 Transport; Mon, 9 Jan 2023 16:44:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT004.mail.protection.outlook.com (10.13.172.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5986.18 via Frontend Transport; Mon, 9 Jan 2023 16:44:16 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 9 Jan
 2023 10:44:14 -0600
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
Subject: [PATCH v11 02/13] x86/cpufeatures: Add Slow Memory Bandwidth Allocation feature flag
Date:   Mon, 9 Jan 2023 10:43:54 -0600
Message-ID: <20230109164405.569714-3-babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230109164405.569714-1-babu.moger@amd.com>
References: <20230109164405.569714-1-babu.moger@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT004:EE_|PH7PR12MB6835:EE_
X-MS-Office365-Filtering-Correlation-Id: 91a82631-b720-4838-c75e-08daf260bf2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Krm7jUKpXyFA8w3BmmWLWMO0j9rju+eNYy03FIEWZ2vmUJyJn25W/jDsuCyJ7youfv3WLztkJIsQC5yCRSrWXqtXYbOSwdLWimqnKKVpKoC0DsseBtdm6+3lMOofpV5fwy0BdfptK+KhO3c7QyZV4uXAUH0H9RRpKjNX1YVRGJUrL+p+57pTUq1CYqAw3bkggDYEtKOvBiNJN2Kn0iHhMyLmDyKK44fJyJTyuzM7FKYVIb+K7s8C+HcxGgpxHWnUiCQ5ngh0X95f/rU6TCy3bAAFJ3iMwTzLLKP7GCmKr9ZayFF8vI5mhe5Hn2QMgaP97z/thgqO2bVnfiIk8su8TUkLkw3aM6lnErnYiyu2tcrSmUuakerVPgMdpfIh87EJIm8HlaV9NlGsm9AnyR2j8RyvQQxAzILsK+EC6PvR6pzSJoIPHZj2SWpVsohtKSH9U3NKk46BBP+JKhmVaw/UvK6ooqA71IKoE2GjT+XNGyN2FhonoSNZQUlHj3MnHrcwLt43h4zkTjHrSCOoeBJePOagnq55UyJuWs7Dz0EM8suZjfWWJASwEBnE+R1QcgcOLEQmGDJ5ftji29UAtJgT8ZYPRF8coVC1NFQcAbzgaP2VFELWAFmIeieeEcll5U/XO516iel1FVIoCF28T/AGFim319fjKplmPVbCQtNn0X/rqNecqK39vaMWIRKgUJMM24XDOprd6cb+UvPZJFvVHAdmKv2aqgklHrzbuZM2IpowWUMm6RQ6/Qrn/CLjlBQC+6GWymUC8HKzISP2m7812CZAledkLqAlxJNZE1caWel2Mz1WYjf3Wwzu45fijZot
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(136003)(396003)(39860400002)(451199015)(46966006)(40470700004)(36840700001)(2906002)(44832011)(83380400001)(82310400005)(47076005)(336012)(36860700001)(426003)(54906003)(110136005)(16526019)(81166007)(1076003)(2616005)(7416002)(7406005)(5660300002)(7696005)(40480700001)(6666004)(26005)(186003)(36756003)(8936002)(478600001)(70586007)(70206006)(8676002)(41300700001)(86362001)(356005)(966005)(4326008)(40460700003)(316002)(82740400003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2023 16:44:16.3926
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 91a82631-b720-4838-c75e-08daf260bf2f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT004.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6835
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

