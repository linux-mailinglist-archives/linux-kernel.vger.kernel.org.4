Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62FA55ECE66
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 22:26:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232836AbiI0U0Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 16:26:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232399AbiI0UZx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 16:25:53 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2064.outbound.protection.outlook.com [40.107.93.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E29FC6AE95;
        Tue, 27 Sep 2022 13:25:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gQ4yl85OCXmNPaLnA3AAKHRI8KlpE83zBsrC/sKG0cBHyk2bllNcfVCUxXT7Lby3xq+l4mUiurL76if41JYCEy9Ygo6zg98LHlHMyUN7Xz4aZQ/k02V2ugQFNj+q3596Yl2BAed1nHq+bqxdiKbfMxL/kz+OScWVfNKD7WF9UY6oYKLiZsiUdT7TG0u29nca/cTgt2rvT09ck3Xajr54riv+AMX3hCpOlRf2pRY42ZEkFWZCxWH+D//k8eXpcG5pmpjOHxR/1i5U8UXz1JqzbaaDz06OMuPHMEDK8yQab13hzAGTcwl09HFSIYsmJpzR/CDpYEjIO6Eb8Wdwhul+gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kG6NFCs0Kn6kwZG270I//c5dO4ikRyhKwpTvobARG1U=;
 b=FCOBT5Vcl6LUHc7fvHMlGs20Gx5yHezfGxUqt9LirlxwCjzwl1NnX3pY/IKJbtMsnDB0uvc/PG/dwkpoMUe2ilgV0+LQjLK4dJTktLp5zcA5DE6880WDcjS5KwIfrC1LOwfdlcAXmFsuSXhHC4/znxR1hvyZe5dL4R/NCakqqQrO3v1LZZOwQ4CzVt7Yn7qDYEwcS5G04bFx3rY1tHLv4PJyMgsiMCaAc2iVi0nOXiJqX+Nc/x44BjxbnFAqCFc0FTVDF3121kQm/pU8hBBC75kbPEY5l4/NL8dAZriISVMYC0Faj4rKjVtF0Pj1ygCCgdfw0TetDfrcsnMfHjQQpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kG6NFCs0Kn6kwZG270I//c5dO4ikRyhKwpTvobARG1U=;
 b=fyBe2k/Rj0bUlq1rZecFphhhDMgFrHgd5y2EXnUjxDnPAPN3JQBMUGRz7AuWpFEM+/PG6vZzDTeMauXBBOPqiATjfEb2j3M1JTNM4m4VLkx0pnGdA812UHyFuSAl6EgPNexiCkGgYow0RsfeljW5vppywUpy8SAt2dQEod0tUEI=
Received: from BN9PR03CA0922.namprd03.prod.outlook.com (2603:10b6:408:107::27)
 by BN9PR12MB5340.namprd12.prod.outlook.com (2603:10b6:408:105::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.26; Tue, 27 Sep
 2022 20:25:50 +0000
Received: from BN8NAM11FT070.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:107:cafe::87) by BN9PR03CA0922.outlook.office365.com
 (2603:10b6:408:107::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17 via Frontend
 Transport; Tue, 27 Sep 2022 20:25:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT070.mail.protection.outlook.com (10.13.177.50) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5676.17 via Frontend Transport; Tue, 27 Sep 2022 20:25:50 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 27 Sep
 2022 15:25:48 -0500
Subject: [PATCH v5 03/12] x86/cpufeatures: Add Bandwidth Monitoring Event
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
Date:   Tue, 27 Sep 2022 15:25:47 -0500
Message-ID: <166431034744.373387.16358042395909100441.stgit@bmoger-ubuntu>
In-Reply-To: <166431016617.373387.1968875281081252467.stgit@bmoger-ubuntu>
References: <166431016617.373387.1968875281081252467.stgit@bmoger-ubuntu>
User-Agent: StGit/1.1.dev103+g5369f4c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT070:EE_|BN9PR12MB5340:EE_
X-MS-Office365-Filtering-Correlation-Id: 05e592c7-dbcc-48bf-1f23-08daa0c677e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Qef2eJfbYtUsnFA0GZdagsYO2cTb9gIoXUpMtymGsnTEVx/SJnnNKVIvGW8RiGtvkNGhelW7XdC1U3zA3Um7vPE50RsMqDlekP83wEl8t0lZkB5cDNr67H5FSMh3/0JFsZC5p9WsPNyHagNz+vF9BdFNPoqJZhjAntTh9G1U4lfVS7FoM2LPPe3bQinj3Bf66OdFzOSFZk2HTOJPyHgeeGZ0kTIz9sLL0hjvu5aEWknM/CcXRCytbDxu5M50mS3qEmY0yVyMITm8ZRrtexgf6WD92pjkcstvTMNBc+JRRzFlcFTAVrug3jvga3dQZAH0xqX5nKnaKgIYd7LUiYFXvtAbhSfSsN7grCyizHwSh+qdUfX2ZKLCfWXjXnlJ9i7s+UaLbdLl9sLmVv17KM3lAbTkRxF01NySvrhkEM7vn/wmSUQ/b3zwzd5+EOgZ9PpbIiM70m5RlI5i6cPiDA2CCJ3V5DyJbMNVrsbW9+vzH0nYtLVP7EhaHfzWE88hvbsK9NqrzR6tNLoIAVdzQVDIn86E/h8Rm3JbwDRuJrFm1X1CORCKNhJn3umlzN8bs11KaAAz43YIeGmGVIRMOHBIGnfizUASav6rivREf6Ey161tuKL7bW1KcyZKXqWrp/0xjoY7jtIRSwJIWea3mbhSkdMRo9VtIxgHnPwTNlw+FYsy3n+n0tOnxDLEUmNHKfdWvTghWYvLiyvazyGJk7uDKqWvPADH8E67RG8CVNGVKmREvlrr+TvjvCcRZ4lrC3+usHAtY69X9ijDwHlE2rfBKsGHeE212rWgR57oXNYgSqi5rS8nSuMTZZcvcWdkx6FDd/yVqYDX7PVTWp9INoTuGTeCkYz7DVOSz+OlpTWE724d8Hhun2hfDeJKxYimZlriKWQpOaH7Ho9vxa+zaaCi/w==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(7916004)(376002)(39860400002)(136003)(346002)(396003)(451199015)(40470700004)(36840700001)(46966006)(82310400005)(103116003)(356005)(81166007)(40460700003)(36860700001)(478600001)(82740400003)(86362001)(44832011)(7416002)(2906002)(5660300002)(8936002)(70206006)(70586007)(316002)(110136005)(54906003)(4326008)(336012)(16526019)(33716001)(186003)(40480700001)(47076005)(16576012)(83380400001)(8676002)(426003)(966005)(41300700001)(9686003)(26005)(71626007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2022 20:25:50.1300
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 05e592c7-dbcc-48bf-1f23-08daa0c677e9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT070.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5340
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
EventID) which contains one field for each Bandwidth Type that can be=0A=
used to configure the bandwidth event to track any combination of=0A=
supported bandwidth types. The event will count requests from every=0A=
Bandwidth Type bit that is set in the corresponding configuration=0A=
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
index 349852b9daa4..896226c5470b 100644=0A=
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
index 885ecf46abb2..7981df0b910e 100644=0A=
--- a/arch/x86/kernel/cpu/scattered.c=0A=
+++ b/arch/x86/kernel/cpu/scattered.c=0A=
@@ -45,6 +45,7 @@ static const struct cpuid_bit cpuid_bits[] =3D {=0A=
 	{ X86_FEATURE_PROC_FEEDBACK,    CPUID_EDX, 11, 0x80000007, 0 },=0A=
 	{ X86_FEATURE_MBA,		CPUID_EBX,  6, 0x80000008, 0 },=0A=
 	{ X86_FEATURE_SMBA,             CPUID_EBX,  2, 0x80000020, 0 },=0A=
+	{ X86_FEATURE_BMEC,             CPUID_EBX,  3, 0x80000020, 0 },=0A=
 	{ X86_FEATURE_PERFMON_V2,	CPUID_EAX,  0, 0x80000022, 0 },=0A=
 	{ 0, 0, 0, 0, 0 }=0A=
 };=0A=
=0A=

