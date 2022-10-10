Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01E8B5FA638
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 22:30:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbiJJUaH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 16:30:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiJJU3l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 16:29:41 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2065.outbound.protection.outlook.com [40.107.94.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DAF8E0A1;
        Mon, 10 Oct 2022 13:28:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nV0Au2KSPukHZS2h0gnYEgg59duIlzfUjblVkDvdV+fXPQo7Ve2RrLHnCYJxc91jEPQpjh6+NEoNT1peQBzpnwiafzIqZ6+riZuQkGokIkn5JOBluO/CYbp6KTqyfWoYok+IqiznTiYduIZ94PG8VA/n1FG2F+f4dkcHu/jV1yiuL7+BWKhk/NE6vJQbvHtsMNdhRH3JQrWVj3LOSALYJzyvVgD0JlbhVTE5HorY330+6c9PDgm/407PAXLW8T8u8yb7NvaBj7T2C4xeFyDeqRdQ8562qhs1BSD4mSGKulpiW71HQfxSerGNnK9wHhJixNM+IsgY5Z1OqAhE2dpRdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8LKWgeD3hP7ms++Tx/Hqi8WhP/oP/gSM4BuTbR/8xwA=;
 b=PNCDt6F3FdYfAZ3oU02RqiUgU9np7TLR1rtEhmEwm1ospTOTA2+cVVs5QkuAZPgPYCOQSzmUpk+vwTbsP8vOxKPyqrZJz/mgqWtzvdPGo+EktXv6QrBhOoyxmdM1EkcmmpCJ4TXHcxk+tsrcjXPTiJ8wCHAy2bxYZB3dWZjS6kRnXaeXDfOtaLUi90hEaRs9de3k0xlzPb+yqAkEt7XXz3iz3H26abbq0Ff0Ij9yR0R1XYMfthu4InrZXikr2bEFQqJpHzyf7p12RMb/hJkW8f9vMWAtXj47DXtIB2D1+6aEyKB81CKSaSVAP6xevYIBNKDdmBalGLcMBE7E2I3W6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=opensource.wdc.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8LKWgeD3hP7ms++Tx/Hqi8WhP/oP/gSM4BuTbR/8xwA=;
 b=kc4553c8SY8i2fod66NnyTqfgJpVIX3Itbc2555UFP2nQ/S7PUWHHSnFVMPjlYw867QdzgUgWFHrad+2ohPjsFNdnmQgUcvTfSZGsJunhiP1XzVixilDEm8vfmcyjheoK9/aDVM2DkQ/iDtpI4uvPJj5AmvM0fDXPmNT9NDlj30=
Received: from DM6PR18CA0020.namprd18.prod.outlook.com (2603:10b6:5:15b::33)
 by BN9PR12MB5337.namprd12.prod.outlook.com (2603:10b6:408:102::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Mon, 10 Oct
 2022 20:28:41 +0000
Received: from DM6NAM11FT105.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:15b:cafe::15) by DM6PR18CA0020.outlook.office365.com
 (2603:10b6:5:15b::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.19 via Frontend
 Transport; Mon, 10 Oct 2022 20:28:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT105.mail.protection.outlook.com (10.13.173.164) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5709.10 via Frontend Transport; Mon, 10 Oct 2022 20:28:41 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 10 Oct
 2022 15:28:38 -0500
Subject: [PATCH v6 01/12] x86/cpufeatures: Add Slow Memory Bandwidth
 Allocation feature flag
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
Date:   Mon, 10 Oct 2022 15:28:12 -0500
Message-ID: <166543369215.23830.17791885444109680031.stgit@bmoger-ubuntu>
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
X-MS-TrafficTypeDiagnostic: DM6NAM11FT105:EE_|BN9PR12MB5337:EE_
X-MS-Office365-Filtering-Correlation-Id: 66fd6e9f-5a64-49fd-95c9-08daaafe0554
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hTUkAK5NBgh0ltneENsdzqXAhe/dFEMvlLuQ0Gx6uUlE40wbclLJHGWj6hugU/oPcBQablajOflY7EspgmNWj4AJq3ulWyPtTooYN7KyRgfF31NgwoBIbNJgfZhnr7n76y0t3q7YFw9grxTMd0QHxO+sP+le2Vvsd6C4iAXPUfrsHZNCPlWZP/dcQb+6mtY6G0OQkrRr2WPm45ZR/dfpno4jKgQ/B21ZUtGppQU4Wik9ViqxVdRDKvsulP8HMm+xug8FqYiIlKR32NBXHfHueN5lRLoqbMPWPEljEzZRcR3durO+3v/ec7g7WZO6Gloc28/mAdMpMKwsv7Uakvq+OeoMAb+YdUNtctxda+rjAxWg75DjMSATPc77Sx8PdWA70zMbGDOMFoR642Nz/DwU1Jauza2oFo2cyj7AzP0EvOFK7Bfw9ADo7fNNct0MsoVF/PZmzORa1Lq/7YwIgrQLlZr7fevDiZNZKYCs6Fd6c3csVDwyEUA0YlBEdqSJTGWMzTPx6FyN2YS5ChFwLj31hO3Hl4JfJt/YmsTVDOXt8f2lym52XI92rx+1mys8jwXcPTX/TGL6V9Zop3NrLDaNYXpI67UoRhYKB9dllZ5WY4p3wTygdYIFmQyoJujWsU5IGT0GxO8oMRFjYvUIY2+iAO0pZnmf+NHWj5NkNcIFod/I9l7gBEj94IUwRMnHbdxkzwfRe1ZjASSPomFkwf6ZPyQ91Tn8I5nOakMrKanLQ1IPtUAku5QV3+bOD4sDWKB1jfAstaqVBvNGjSzd15RsykXFe/2Mk+TJnwj8yNC91v05jEJOsEauMGSQMgM7FvHgEH1y5SjFh4a0Zz/lsJlDorn62XD2g0ztlkR2kSTqGVU7CGp4BBzVeW/z0KU+Z8jDZ7pMJo/tZ5OzClOXYWxwaw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(7916004)(346002)(396003)(376002)(39860400002)(136003)(451199015)(40470700004)(36840700001)(46966006)(426003)(47076005)(16526019)(40460700003)(83380400001)(336012)(186003)(16576012)(36860700001)(33716001)(41300700001)(8936002)(82740400003)(7416002)(26005)(9686003)(2906002)(356005)(316002)(5660300002)(40480700001)(44832011)(4326008)(966005)(54906003)(110136005)(82310400005)(8676002)(478600001)(86362001)(81166007)(103116003)(70586007)(6666004)(70206006)(71626007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2022 20:28:41.3409
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 66fd6e9f-5a64-49fd-95c9-08daaafe0554
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT105.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5337
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the new AMD feature X86_FEATURE_SMBA. With this feature, the QOS=0A=
enforcement policies can be applied to external slow memory connected=0A=
to the host. QOS enforcement is accomplished by assigning a Class Of=0A=
Service (COS) to a processor and specifying allocations or limits for=0A=
that COS for each resource to be allocated.=0A=
=0A=
This feature is identified by the CPUID Function 8000_0020_EBX_x0.=0A=
=0A=
CPUID Fn8000_0020_EBX_x0 AMD Bandwidth Enforcement Feature Identifiers=0A=
(ECX=3D0)=0A=
=0A=
Bits    Field Name      Description=0A=
2       L3SBE           L3 external slow memory bandwidth enforcement=0A=
=0A=
Currently, CXL.memory is the only supported "slow" memory device. With=0A=
the support of SMBA feature, the hardware enables bandwidth allocation=0A=
on the slow memory devices. If there are multiple slow memory devices=0A=
in the system, then the throttling logic groups all the slow sources=0A=
together and applies the limit on them as a whole.=0A=
=0A=
The presence of the SMBA feature(with CXL.memory) is independent of=0A=
whether slow memory device is actually present in the system. If there=0A=
is no slow memory in the system, then setting a SMBA limit will have no=0A=
impact on the performance of the system.=0A=
=0A=
Presence of CXL memory can be identified by numactl command.=0A=
=0A=
$numactl -H=0A=
available: 2 nodes (0-1)=0A=
node 0 cpus: 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16=0A=
node 0 size: 63678 MB node 0 free: 59542 MB=0A=
node 1 cpus:=0A=
node 1 size: 16122 MB=0A=
node 1 free: 15627 MB=0A=
node distances:=0A=
node   0   1=0A=
   0:  10  50=0A=
   1:  50  10=0A=
=0A=
CPU list for CXL memory will be empty. The cpu-cxl node distance is=0A=
greater than cpu-to-cpu distances. Node 1 has the CXL memory in this=0A=
case. CXL memory can also be identified using ACPI SRAT table and=0A=
memory maps.=0A=
=0A=
Feature description is available in the specification, "AMD64=0A=
Technology Platform Quality of Service Extensions, Revision: 1.03=0A=
Publication # 56375 Revision: 1.03 Issue Date: February 2022".=0A=
=0A=
Link: https://www.amd.com/en/support/tech-docs/amd64-technology-platform-qu=
ality-service-extensions=0A=
Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D206537=0A=
Signed-off-by: Babu Moger <babu.moger@amd.com>=0A=
---=0A=
 arch/x86/include/asm/cpufeatures.h |    1 +=0A=
 arch/x86/kernel/cpu/scattered.c    |    1 +=0A=
 2 files changed, 2 insertions(+)=0A=
=0A=
diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpuf=
eatures.h=0A=
index b71f4f2ecdd5..583b88bcc7e1 100644=0A=
--- a/arch/x86/include/asm/cpufeatures.h=0A=
+++ b/arch/x86/include/asm/cpufeatures.h=0A=
@@ -304,6 +304,7 @@=0A=
 #define X86_FEATURE_UNRET		(11*32+15) /* "" AMD BTB untrain return */=0A=
 #define X86_FEATURE_USE_IBPB_FW		(11*32+16) /* "" Use IBPB during runtime =
firmware calls */=0A=
 #define X86_FEATURE_RSB_VMEXIT_LITE	(11*32+17) /* "" Fill RSB on VM exit w=
hen EIBRS is enabled */=0A=
+#define X86_FEATURE_SMBA		(11*32+18) /* Slow Memory Bandwidth Allocation *=
/=0A=
 =0A=
 /* Intel-defined CPU features, CPUID level 0x00000007:1 (EAX), word 12 */=
=0A=
 #define X86_FEATURE_AVX_VNNI		(12*32+ 4) /* AVX VNNI instructions */=0A=
diff --git a/arch/x86/kernel/cpu/scattered.c b/arch/x86/kernel/cpu/scattere=
d.c=0A=
index fc01f81f6e2a..5a5f17ed69a2 100644=0A=
--- a/arch/x86/kernel/cpu/scattered.c=0A=
+++ b/arch/x86/kernel/cpu/scattered.c=0A=
@@ -44,6 +44,7 @@ static const struct cpuid_bit cpuid_bits[] =3D {=0A=
 	{ X86_FEATURE_CPB,		CPUID_EDX,  9, 0x80000007, 0 },=0A=
 	{ X86_FEATURE_PROC_FEEDBACK,    CPUID_EDX, 11, 0x80000007, 0 },=0A=
 	{ X86_FEATURE_MBA,		CPUID_EBX,  6, 0x80000008, 0 },=0A=
+	{ X86_FEATURE_SMBA,		CPUID_EBX,  2, 0x80000020, 0 },=0A=
 	{ X86_FEATURE_PERFMON_V2,	CPUID_EAX,  0, 0x80000022, 0 },=0A=
 	{ X86_FEATURE_AMD_LBR_V2,	CPUID_EAX,  1, 0x80000022, 0 },=0A=
 	{ 0, 0, 0, 0, 0 }=0A=
=0A=

