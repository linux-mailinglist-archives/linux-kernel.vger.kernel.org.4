Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0009D662B7C
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 17:45:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235031AbjAIQok (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 11:44:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234470AbjAIQoZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 11:44:25 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2075.outbound.protection.outlook.com [40.107.220.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6739DE0DC;
        Mon,  9 Jan 2023 08:44:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=InOwn97BQ4ngNty9EiI7miKhVX1SesP6sTb1bBwjw1WKjUVXCoIZVuBPG3xqpkmEZN1kxsL6MyHTphB8XsNigQTy5lC54IuoqXFjRQbIJiX5MVZIb2ofI3XqMOUnO6qm9fkX0TJjZnpbcrGOluuva0CtCXuoDpaETwP0521X+MNKgYthQWJkUYLbUWr+6q2h7+mRv9iM1396LTbHVYOMwn9qsWIGGDZGhA4rhGeNS+gVRA5bU+FeVqzz1FADiUJPF9i4uKwsG9GycLU/0R8HFlrl+8gRAHAlwQzfj9ZvF5imEO/YKjJpAP21x3JDsrqtZpfaXUIDw7/tt5h+LNpNJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Twd7ddBJxwhZGfyhY4WBCZBaAd4nlAK3kbxKuE11Hk=;
 b=ZYqLEVhvmkoci6ISIVDBN6WEx0Hurv+W9/oX5qY93fsEh2Quix/Z2lTlSTDKVmFXp1SQaYrbmvdWAW8J5nEOOZsysiDre8d/Wj2ArLhVaUd0+3C/YmbsMKN0ZAhivkZbw5KUbaUaPfdjkKSeUbQMP323oaDW55sP9+1r8wGUQwFTAhkscgyy13IG8i/21G9OX6vCEZHTX7MfASsrkBRyi0zPo3rara5PxrfC/I3A7rPzk5Tsv/VU56H6j+uRjLp6/+sfMXe/RnJZ0va09twTIHEJ+NGLNrS4UyhYdDT8Ov43gMRKIlOSt9/VK8ruyG4gKb5zfmBFqbxstvDzNMBBXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Twd7ddBJxwhZGfyhY4WBCZBaAd4nlAK3kbxKuE11Hk=;
 b=ZOGFTcPUANtHWtUyoV2/kn58gotm+tGi/8xqJa8QNkCt/LvPDAkUOo07MqxHzL8xhvPAm2Fb/tUE4jegO/IEp20W/Qz4nMXSbYuwTcdW0c6VtNYFjwTOEJcDUONmVUXIra8PewMt9saaoFibhZ8iSjwFndprM5NCsfLCBBHiAfQ=
Received: from DM6PR04CA0011.namprd04.prod.outlook.com (2603:10b6:5:334::16)
 by DS0PR12MB7948.namprd12.prod.outlook.com (2603:10b6:8:152::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Mon, 9 Jan
 2023 16:44:20 +0000
Received: from DM6NAM11FT033.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:334:cafe::70) by DM6PR04CA0011.outlook.office365.com
 (2603:10b6:5:334::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18 via Frontend
 Transport; Mon, 9 Jan 2023 16:44:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT033.mail.protection.outlook.com (10.13.172.221) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5986.18 via Frontend Transport; Mon, 9 Jan 2023 16:44:20 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 9 Jan
 2023 10:44:17 -0600
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
Subject: [PATCH v11 04/13] x86/cpufeatures: Add Bandwidth Monitoring Event Configuration feature flag
Date:   Mon, 9 Jan 2023 10:43:56 -0600
Message-ID: <20230109164405.569714-5-babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: DM6NAM11FT033:EE_|DS0PR12MB7948:EE_
X-MS-Office365-Filtering-Correlation-Id: 0310f62d-9f64-4044-d258-08daf260c1c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F0hhhGVqMfNMoIzHrE0bVU4qCr5xLOtIE+/bzZq0wlh7pTSeuE942X7ALxwZuMHcd4f4PnAU7GzwpbU4ZWLct4/2b17yxf7pTIirr9Sdp0c6T/tkI0wC3uZLJvcplqbrB15/VG4Ww2037DResvFhUKvy4r9eYP+N1mDfAVESXcAit4aLHCNJPC/uZz/86viQPpecuxYn5cSJAsZgRcxawJmSdOodhY5dQHrGzzTiyDqkn0FRT82YEleMw4UTXlWOtrphxUa9tcfFbrDh8uJJl2O6S1zKHSAoX9LqZvMX+ZiKdEuLdlfE1EL8HIy5M9Y+HajEXvtmKnpYJip5S8ShK+cfVJ1RudqBiC8GAQvAoE7/I1EHQ5vXYBxksFPLkD5O690bogO3uFqKyNOhtVAJnhrco+YZUgxuFeZCDwJAliiHowAG66dMCE9LGSc2qnKB/BEOSqm39Ce/SckZumtFUJXOVSwdDlsbiOTDVdQgG/MPzwEsNGuWhaJTdxw8wBWvSi7hl2YD7Al+mzq1ajHfPCC4PNqW+WHzxEokw9pfBM3rCmdU5CiN5eJbL3K6JbFtq8RYEpGYywtcZ0Wd7jTn7ebwtvMIl2de6l8NS9P4VVzL3FAFxZBFh94WLqFqIu5OJtNp5A7Wr4YhIeHoF1LTkQiNXWhT30s/f84EwmxCz2SQFjnG/eEFr0lfaMCfAsQh21gvEI0jEGuEC0GOxh3wQj77SEhS1NH/bhtzUNj+tPfzN/oyJP6ihSRvQQkXPVaLrv/jVV2PDQ6JYwKUVec2GCaZ1EKBIYjem6N/00xgoYDCzigWhxkvudViIOJ17Qfr
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(376002)(39860400002)(396003)(451199015)(40470700004)(46966006)(36840700001)(41300700001)(40460700003)(426003)(47076005)(54906003)(110136005)(316002)(2616005)(4326008)(8676002)(70206006)(36756003)(70586007)(336012)(1076003)(86362001)(82310400005)(36860700001)(81166007)(356005)(40480700001)(82740400003)(8936002)(44832011)(7406005)(7416002)(83380400001)(5660300002)(2906002)(966005)(186003)(6666004)(26005)(16526019)(7696005)(478600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2023 16:44:20.7183
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0310f62d-9f64-4044-d258-08daf260c1c3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT033.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7948
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

