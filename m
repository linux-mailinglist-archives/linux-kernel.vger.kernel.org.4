Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73F915FA63B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 22:30:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230141AbiJJUaX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 16:30:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbiJJU3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 16:29:45 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2060.outbound.protection.outlook.com [40.107.102.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0360B332;
        Mon, 10 Oct 2022 13:28:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nRFa7boUn0r4Q3OTdlPnRFdzFrDfUy9atItmPmjeu7b9OJ3982GBIoVFLE7A0Htamv0rlZ5CdPAGZv+JdFmyfOjwY6r2O0k0Lt/eYhCzEdkv3b3agXZXOjklpizrR+Hc5TeuKg4sZVPiPxVsgQYS1cuH/Y9FQJTyLd4K2EvsanRQTK1AlqVtd32b4yv2OewbAlAha0s9RIvLs7tKhxnf1QSdB9YHhleSrjekJXb4Y7MbuLN2lQZa2Qu1bPKpL8onZacg3sTMynlPKmJq7D9RYmn9edZijwWvbX6YUmCE1h7qGJD8KxzNlI7VTAg7Yz7IBb6P4gjQX/FogtH2hqVw5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jSm02XV3XZEFn04nLHzL7xnXTw3Dm4EvTrmeFsesXnk=;
 b=GSnTTXoTJ0Lekk6Pt3nwdFIPLNVcHq0ZhTlI6p1BS0TSvk3sEeU7m2/HQNYBY+jpmPo1Rgurzmkak2X8r/qS2Qhglp8+d5WUbAYr+5CzSF+hjwa71S7/dPgdYdi7s3kI2nEiZ68uGq4uflCRWUNNxJlRkGK6JQAiagtwQzj1us0Ab639xtorLdOip/aA003j1oUOMHpfsxIqDwb4+bZFRMwdkR0RBlhWkiQSjUxCIu31j5vAu7DOC33OXHFji/wZ9rLyg54FPVI+jwV8R6utKFaSOsOU/XE6wQXnX2b3k91NQC24buDz6kDwBZm2qhuVS0EZhb0YJLSmUlP7iS/8jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=opensource.wdc.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jSm02XV3XZEFn04nLHzL7xnXTw3Dm4EvTrmeFsesXnk=;
 b=uyPOS87WvVdRy2zrcEt++xjTBnOTW+37Zk5D0i1G0QLsnqR+A3vvyU+GeDSHdZbTwLzCEa/h7i0sf6ea7C9CudxJ7w3gNWKlPLktd34puMrjf3btDk79Xmlb+ike6lxhVubnOG408cu6bIMr+Tw8h1Y8cYgTdmX1JIb2L8oUzHg=
Received: from DM6PR02CA0150.namprd02.prod.outlook.com (2603:10b6:5:332::17)
 by MN2PR12MB4237.namprd12.prod.outlook.com (2603:10b6:208:1d6::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Mon, 10 Oct
 2022 20:28:55 +0000
Received: from DM6NAM11FT024.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:332:cafe::7b) by DM6PR02CA0150.outlook.office365.com
 (2603:10b6:5:332::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15 via Frontend
 Transport; Mon, 10 Oct 2022 20:28:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT024.mail.protection.outlook.com (10.13.172.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5709.10 via Frontend Transport; Mon, 10 Oct 2022 20:28:54 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 10 Oct
 2022 15:28:52 -0500
Subject: [PATCH v6 03/12] x86/cpufeatures: Add Bandwidth Monitoring Event
 Configuration feature flag
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
        <eranian@google.com>
Date:   Mon, 10 Oct 2022 15:28:52 -0500
Message-ID: <166543373210.23830.13288254739033595117.stgit@bmoger-ubuntu>
In-Reply-To: <166543345606.23830.3120625408601531368.stgit@bmoger-ubuntu>
References: <166543345606.23830.3120625408601531368.stgit@bmoger-ubuntu>
User-Agent: StGit/1.1.dev103+g5369f4c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT024:EE_|MN2PR12MB4237:EE_
X-MS-Office365-Filtering-Correlation-Id: 079137d6-572e-45af-dfca-08daaafe0d4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HjNOhKbMYidATYwXbZZd2crlW1ceYBxyNJ5kC+ovHWWP+i4r72ZZR7SNYFysfx0Y455P+ftgcYlTnxW8zKTt2cqXy+0COZCbq0nT16heDKCwYfFelj8f2zZHnm97CaoQmEEDOXJaLjFyh8Ozrn9C7pZjkVcSv+aob2IMtPP7SEPW8RY93m61wlp4UxlsfUWi7V+D1QMWL81hrXxob8HGlTHKnmhvza9jpW3fYHy8Zh6Qfd4fVG58u/BgKN4vz8IYL0UtZGV/1CHgDrIpWt4buMmmv3TLIlPq3qB2LMEO9/sNGk+JoDdHRtoRDD8FGQVimNyBeC+YC84bL8qYJEiBIUdmP9C+EAR9qXsg+7fXR0DBIlQZYkuQ9Ouv9A4r5se3tRm1pGrALikxwKg85NI1tu0gCkxPEXCfFOdHnJSUBbnU/al5FnCHVNMKv9LUZxhRcIAluNtZLvl+VHPcJCuGVtpsDHUniW3/X0ewwWZGaon2/3XICRT5b1B3tQmzK/AiwXIvuAHPYlZx3G7Sh1cq5garlinb6pEJj2ia/BaYTQrrVaGducb/bQgLMhHmZ7aahiEO+jft6HUcRO06ewpipdxP0j9SwaroM1u6209uSx0yvqiDBHtFX3ypTlaL9Sv7E414IRX875majQsDRGx886I4AV20YczwcRW3Q2sLivAlYvSXkZMkCRrKs0kHPwZqWxEvbxA4lRcSRMLKzhnIBszBx1X8k5rf52//Hjfis6jhW5BNcR+qrJp4q9GyImR6KtwRhaZ4zsKrhIvQGgwOOg3hOBR9+RkcSYkcSHlkRkRqrUAV8TIVcMf4GqDftSo4VJC7qtAE6YV0CSoCUY1dqAl8ltss6P13ggeJeQ/eBG5tn7sIQxFCrrQcs9UFrwSw7hdONvEHSyI+qCAoM3NG9g==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(7916004)(4636009)(346002)(376002)(136003)(39860400002)(396003)(451199015)(40470700004)(36840700001)(46966006)(316002)(47076005)(70206006)(70586007)(110136005)(16576012)(8676002)(7416002)(4326008)(2906002)(5660300002)(41300700001)(8936002)(103116003)(40480700001)(966005)(44832011)(36860700001)(478600001)(356005)(40460700003)(54906003)(86362001)(26005)(81166007)(82740400003)(9686003)(83380400001)(336012)(16526019)(186003)(426003)(33716001)(82310400005)(71626007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2022 20:28:54.7056
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 079137d6-572e-45af-dfca-08daaafe0d4b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT024.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4237
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Newer AMD processors support the new feature Bandwidth Monitoring Event=0A=
Configuration (BMEC).=0A=
=0A=
The feature support is identified via CPUID Fn8000_0020_EBX_x0 (ECX=3D0).=
=0A=
Bits    Field Name    Description=0A=
3       EVT_CFG       Bandwidth Monitoring Event Configuration (BMEC)=0A=
=0A=
Currently, the bandwidth monitoring events mbm_total_bytes and=0A=
mbm_local_bytes are set to count all the total and local reads/writes=0A=
respectively. With the introduction of slow memory, the two counters=0A=
are not enough to count all the different types of memory events. With=0A=
the feature BMEC, the users have the option to configure=0A=
mbm_total_bytes and mbm_local_bytes to count the specific type of=0A=
events.=0A=
=0A=
Each BMEC event has a configuration MSR, QOS_EVT_CFG (0xc000_0400h +=0A=
EventID) which contains one field for each bandwidth type that can be=0A=
used to configure the bandwidth event to track any combination of=0A=
supported bandwidth types. The event will count requests from every=0A=
bandwidth type bit that is set in the corresponding configuration=0A=
register.=0A=
=0A=
Following are the types of events supported:=0A=
=0A=
=3D=3D=3D=3D    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
Bits    Description=0A=
=3D=3D=3D=3D    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
6       Dirty Victims from the QOS domain to all types of memory=0A=
5       Reads to slow memory in the non-local NUMA domain=0A=
4       Reads to slow memory in the local NUMA domain=0A=
3       Non-temporal writes to non-local NUMA domain=0A=
2       Non-temporal writes to local NUMA domain=0A=
1       Reads to memory in the non-local NUMA domain=0A=
0       Reads to memory in the local NUMA domain=0A=
=3D=3D=3D=3D    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
=0A=
By default, the mbm_total_bytes configuration is set to 0x7F to count=0A=
all the event types and the mbm_local_bytes configuration is set to=0A=
0x15 to count all the local memory events.=0A=
=0A=
Feature description is available in the specification, "AMD64=0A=
Technology Platform Quality of Service Extensions, Revision: 1.03=0A=
Publication=0A=
=0A=
Link: https://www.amd.com/en/support/tech-docs/amd64-technology-platform-qu=
ality-service-extensions=0A=
Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D206537=0A=
Signed-off-by: Babu Moger <babu.moger@amd.com>=0A=
---=0A=
 arch/x86/include/asm/cpufeatures.h |    1 +=0A=
 arch/x86/kernel/cpu/cpuid-deps.c   |    1 +=0A=
 arch/x86/kernel/cpu/scattered.c    |    1 +=0A=
 3 files changed, 3 insertions(+)=0A=
=0A=
diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpuf=
eatures.h=0A=
index 583b88bcc7e1..bf0fd022e80a 100644=0A=
--- a/arch/x86/include/asm/cpufeatures.h=0A=
+++ b/arch/x86/include/asm/cpufeatures.h=0A=
@@ -305,6 +305,7 @@=0A=
 #define X86_FEATURE_USE_IBPB_FW		(11*32+16) /* "" Use IBPB during runtime =
firmware calls */=0A=
 #define X86_FEATURE_RSB_VMEXIT_LITE	(11*32+17) /* "" Fill RSB on VM exit w=
hen EIBRS is enabled */=0A=
 #define X86_FEATURE_SMBA		(11*32+18) /* Slow Memory Bandwidth Allocation *=
/=0A=
+#define X86_FEATURE_BMEC		(11*32+19) /* AMD Bandwidth Monitoring Event Con=
figuration (BMEC) */=0A=
 =0A=
 /* Intel-defined CPU features, CPUID level 0x00000007:1 (EAX), word 12 */=
=0A=
 #define X86_FEATURE_AVX_VNNI		(12*32+ 4) /* AVX VNNI instructions */=0A=
diff --git a/arch/x86/kernel/cpu/cpuid-deps.c b/arch/x86/kernel/cpu/cpuid-d=
eps.c=0A=
index c881bcafba7d..4555f9596ccf 100644=0A=
--- a/arch/x86/kernel/cpu/cpuid-deps.c=0A=
+++ b/arch/x86/kernel/cpu/cpuid-deps.c=0A=
@@ -68,6 +68,7 @@ static const struct cpuid_dep cpuid_deps[] =3D {=0A=
 	{ X86_FEATURE_CQM_OCCUP_LLC,		X86_FEATURE_CQM_LLC   },=0A=
 	{ X86_FEATURE_CQM_MBM_TOTAL,		X86_FEATURE_CQM_LLC   },=0A=
 	{ X86_FEATURE_CQM_MBM_LOCAL,		X86_FEATURE_CQM_LLC   },=0A=
+	{ X86_FEATURE_BMEC,			X86_FEATURE_CQM_LLC   },=0A=
 	{ X86_FEATURE_AVX512_BF16,		X86_FEATURE_AVX512VL  },=0A=
 	{ X86_FEATURE_AVX512_FP16,		X86_FEATURE_AVX512BW  },=0A=
 	{ X86_FEATURE_ENQCMD,			X86_FEATURE_XSAVES    },=0A=
diff --git a/arch/x86/kernel/cpu/scattered.c b/arch/x86/kernel/cpu/scattere=
d.c=0A=
index 5a5f17ed69a2..67c4d24e06ef 100644=0A=
--- a/arch/x86/kernel/cpu/scattered.c=0A=
+++ b/arch/x86/kernel/cpu/scattered.c=0A=
@@ -45,6 +45,7 @@ static const struct cpuid_bit cpuid_bits[] =3D {=0A=
 	{ X86_FEATURE_PROC_FEEDBACK,    CPUID_EDX, 11, 0x80000007, 0 },=0A=
 	{ X86_FEATURE_MBA,		CPUID_EBX,  6, 0x80000008, 0 },=0A=
 	{ X86_FEATURE_SMBA,		CPUID_EBX,  2, 0x80000020, 0 },=0A=
+	{ X86_FEATURE_BMEC,		CPUID_EBX,  3, 0x80000020, 0 },=0A=
 	{ X86_FEATURE_PERFMON_V2,	CPUID_EAX,  0, 0x80000022, 0 },=0A=
 	{ X86_FEATURE_AMD_LBR_V2,	CPUID_EAX,  1, 0x80000022, 0 },=0A=
 	{ 0, 0, 0, 0, 0 }=0A=
=0A=

