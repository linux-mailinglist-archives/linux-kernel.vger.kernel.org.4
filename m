Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23F7B5ECE62
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 22:25:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbiI0UZv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 16:25:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232050AbiI0UZk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 16:25:40 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2071.outbound.protection.outlook.com [40.107.101.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B14A5A8A6;
        Tue, 27 Sep 2022 13:25:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I/p/XLOkYQF508GZ1VLIbu021TZKhvgXuB8ihr8etkHHuq5G0+a6WhLtadtFK/aVCZ5EL2jOQibWXxuDAnUVLX6Pj9tLj5KDcreihiEQb7QhmRbrkhFkWUSsEFvVsecJ3XNiBLF2HbNvEvs8kel2WAfWiohgkjQ695z7m5HZWC93PaJ9QF3rO1RmBWlSoqLCbEBRhY5Bm4hp/8/ahKB5OhQudVwP6fqNKCAJ33ifM4zBEn9Ive/8n15pevtTsFxqCW4qIJdtoMuI/txWQ7gUP1rFQUgr301Apx53+Nqk4pzTymbZZRFnu4ykl02iuuanuvrQoVfnq8ANYNj0Frg1bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dktYTaqWr/kPfL4tI86QNCALMEZQmsbyBQ26Wq1aj0Y=;
 b=WFdmWUa3e/+6eZ6gAwqNunstgJK00P/PZ31VCGW703tFAyX60nIHjJK3tb4y2ORrp2zjOH35YTEXKFDqWvQJozsub4Fmj1rwTrpjHbtiqEGlj7DvA8nkv35ygm1K1dA++J6XBsj/KpJ2/k0c9tkxUqfKqUmeYP6j0X4TAFkLPt7uHaWeR68DRjDN+CXOsUxoXR/D38g40xUTzPhcI1gkBbkU9Zm797jgxyibDRq9R7YwGWrJveKtp/A7HJFscuE4lRS/T5gtVQpEu0u1nVeKX9EvxBVbS3Kt9RmAhTsrvGb4igZqwdXoyeMJzxp1ZEWHo6YGA5X7d6TcsKPdUPB6gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dktYTaqWr/kPfL4tI86QNCALMEZQmsbyBQ26Wq1aj0Y=;
 b=mpfjCNP1KR7ltDLduDoJ6XFuPhpcTSzh1gQxHea+IhQAEOzfEXGBksSRtu+hoCXRS+AqiGF8Dqf1g7XvLzNDmxs7Zc/yE1UaFZoP3Ah8xwfXiG29ceNS+33QOIRPpGgyR5tcSE7O+SX+i+WNIgdDA59WlYwVfuR74LiBmiTKxk4=
Received: from BN9PR03CA0216.namprd03.prod.outlook.com (2603:10b6:408:f8::11)
 by SA0PR12MB4494.namprd12.prod.outlook.com (2603:10b6:806:94::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.26; Tue, 27 Sep
 2022 20:25:36 +0000
Received: from BN8NAM11FT013.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f8:cafe::9) by BN9PR03CA0216.outlook.office365.com
 (2603:10b6:408:f8::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.22 via Frontend
 Transport; Tue, 27 Sep 2022 20:25:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT013.mail.protection.outlook.com (10.13.176.182) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5676.17 via Frontend Transport; Tue, 27 Sep 2022 20:25:35 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 27 Sep
 2022 15:25:33 -0500
Subject: [PATCH v5 01/12] x86/cpufeatures: Add Slow Memory Bandwidth
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
Date:   Tue, 27 Sep 2022 15:25:31 -0500
Message-ID: <166431033184.373387.6520785024194837522.stgit@bmoger-ubuntu>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT013:EE_|SA0PR12MB4494:EE_
X-MS-Office365-Filtering-Correlation-Id: a22bb6c5-efe0-450e-5f82-08daa0c66f5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dORlo7ARgqlfsWOn2Qjd61kzlXm5E2ywKfYPEHeHaJN2Js6nFP3taXG6ZKdBF8c5oS29tnKhNhxBMCcT+m87a2wmCNGC4KybykhXq89Cb29KMUW1m3TPJd9vF8u/X7xmzP/BxOcMBUa99qsForbrdBdK5niSRj/Y12cEQq0OBlMXU80DcpjY+ZW6JLVDGP+uGsZF6HZnmb1eVqEaR496/bLgPBFif/8fc5+0YWcY1qD0zC6Ni/Du5NUEADizYyIpK+Z3jD0tu8rSqKG7rwTWtczUbD/9qcjmH7HyjQjvrESoegMj5enDRihVlEGZjhXAisD/X6L4SLa0y9sZ7hAnwv0+Q84uxFTMVTLCFkail1fhhcOPmzRyaKUzzBgoZzg7mgw941H8x3s0oTNbIqybjnj9roUyneh5V894vgQtTKgV0y3zYA5pL++qt4jHStbpmUmBV34dVDxy/t0fYLNrI2QSHw0h61XbbS7+nOSJXun1jyBwg1kYixHVEtN5Zfr4etiqrxHBpZkSNdcZbBdSVBqwLjRDrVrJSshO2Exh/ptXPE2+71ZYuMDwlikld1EtI+jlWKTXYfZ8lQr1B7NymKfZFvNpSrp61C554ILnRN8o6jxEMJYU4n5nZvOIop2f7zsPolP43hjtIY+R+PF+f+iNJ5i/vpjBCc2/D4ZkwwqMF9y76aGy4sSlwHGPPyiF4gc/CjJSAWqyhGTKvd0SUMVlHFwD1d8TskGo3zerGnhOAHjFgdRZCg2vNuWb5SkQsAW57X/AOEZy8wC1LQuzRLKTRMMFBYjRmhmCqZBm5BF3IYGRR2edYVgGkRZ7XtlAoHeV97FQ2kyuGk7xdl52VAit1Z/xXeiwibZHCiJI51sxD3vivC0P2ZS/5WxSDwxUzLm65iU0WwEFl5mZGL+Qsg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(7916004)(346002)(136003)(376002)(396003)(39860400002)(451199015)(36840700001)(46966006)(40470700004)(54906003)(356005)(81166007)(40480700001)(110136005)(316002)(70206006)(82740400003)(7416002)(40460700003)(8936002)(5660300002)(103116003)(44832011)(86362001)(33716001)(4326008)(8676002)(16576012)(70586007)(41300700001)(2906002)(9686003)(336012)(26005)(186003)(478600001)(16526019)(47076005)(82310400005)(966005)(36860700001)(83380400001)(426003)(71626007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2022 20:25:35.7949
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a22bb6c5-efe0-450e-5f82-08daa0c66f5b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT013.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4494
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
index ef4775c6db01..349852b9daa4 100644=0A=
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
index fd44b54c90d5..885ecf46abb2 100644=0A=
--- a/arch/x86/kernel/cpu/scattered.c=0A=
+++ b/arch/x86/kernel/cpu/scattered.c=0A=
@@ -44,6 +44,7 @@ static const struct cpuid_bit cpuid_bits[] =3D {=0A=
 	{ X86_FEATURE_CPB,		CPUID_EDX,  9, 0x80000007, 0 },=0A=
 	{ X86_FEATURE_PROC_FEEDBACK,    CPUID_EDX, 11, 0x80000007, 0 },=0A=
 	{ X86_FEATURE_MBA,		CPUID_EBX,  6, 0x80000008, 0 },=0A=
+	{ X86_FEATURE_SMBA,             CPUID_EBX,  2, 0x80000020, 0 },=0A=
 	{ X86_FEATURE_PERFMON_V2,	CPUID_EAX,  0, 0x80000022, 0 },=0A=
 	{ 0, 0, 0, 0, 0 }=0A=
 };=0A=
=0A=

