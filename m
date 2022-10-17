Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 550B7601C4D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 00:26:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230196AbiJQW0Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 18:26:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230165AbiJQW0T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 18:26:19 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2069.outbound.protection.outlook.com [40.107.244.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAB895300B;
        Mon, 17 Oct 2022 15:26:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DNnuKhoTKCpQisdXz+HZ0KNT3HUd7nevMlBb6TbK4p9zvHwhLDTmY9EBG3s6JClDZJdz8SDmqC0cFakx0hTjwDJn9IWt/YSqK7Ymw6AZwB9rNcEge+rB7fp3+ZnbcnQ+6ct5IuZCFk23y0YeoYPfpUkckia3rMDXl4ZgnoyUN3/gbVVIk9UifIF666FNJvLb8Ww0kFqenzMkzMq5KKU5wqKPuWA/N+4OobHbLhNOXIVVOrdVVJAV0ujgR9zAwBB3OuMjtZmKr3iM/3bWir3PZ0wuHoOhPQAL3Km/Dprl9JaBeXhZB5kidTW9Mrr49jdf7Hp/ilIqQXzXiXULp9hY4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8LKWgeD3hP7ms++Tx/Hqi8WhP/oP/gSM4BuTbR/8xwA=;
 b=YsiHOl3y07ihSYUgB/8LJbzVazv4aS81CJAYJiuoyj40+mR+igOMgP46G1jizbnNMSOQZ9791oHfuttZqh16O53vJNg0vjglkuOM3eC6sE1rDX62hRhcKdZT6Ib79AaQxuPbayvjLBtkKmGFFyeFumSdCT+Is0qzRYKnGxIz2hdDgTRgE8ocE/yQP3QfsbGG4LZSRtliJg9M6JROQXU79ruUJfhpBZzSXBdHsHK7tVJXmvg5NUroAIlBF8W9Tx73m4BwiKR5na+iS5sXs2bOf3dywGUEK3vnRInPYbzVUtmNd0v9mZYN/QlSnPUOS3I0wtcLG2C3YVNrLao3pTwdpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8LKWgeD3hP7ms++Tx/Hqi8WhP/oP/gSM4BuTbR/8xwA=;
 b=t76q8TvtzbPnzkiUqqYFmSSzv2edL0gZKwWHrV7S5/eXTd+FUJIUDXxHA+/O9krKMDZDKJmg09mavFKZIbvScH1kcPCNgoXszjNFwLX69rFuqcraBIinUgq55ClhvIISMERhsnQYZDdJRKsNQGYDEGeYYksH4+f+YQoAlzzH6Gw=
Received: from BN9PR03CA0638.namprd03.prod.outlook.com (2603:10b6:408:13b::13)
 by SJ0PR12MB6782.namprd12.prod.outlook.com (2603:10b6:a03:44d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26; Mon, 17 Oct
 2022 22:26:14 +0000
Received: from BN8NAM11FT086.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13b:cafe::7d) by BN9PR03CA0638.outlook.office365.com
 (2603:10b6:408:13b::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.31 via Frontend
 Transport; Mon, 17 Oct 2022 22:26:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT086.mail.protection.outlook.com (10.13.176.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5723.20 via Frontend Transport; Mon, 17 Oct 2022 22:26:13 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 17 Oct
 2022 17:26:11 -0500
Subject: [PATCH v7 01/12] x86/cpufeatures: Add Slow Memory Bandwidth
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
Date:   Mon, 17 Oct 2022 17:26:11 -0500
Message-ID: <166604557098.5345.506719195181543985.stgit@bmoger-ubuntu>
In-Reply-To: <166604543832.5345.9696970469830919982.stgit@bmoger-ubuntu>
References: <166604543832.5345.9696970469830919982.stgit@bmoger-ubuntu>
User-Agent: StGit/1.1.dev103+g5369f4c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT086:EE_|SJ0PR12MB6782:EE_
X-MS-Office365-Filtering-Correlation-Id: 819b0636-76f7-465f-c32f-08dab08e9993
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ILQD466BywDQy5894ZxmjJoBOlM/UfUbERSf47UPTLLFGA5pe4W1qJXNKk69D5V5sJ1KjTdxiTZmriCD3dhufb1ttiRn6L4zkZYR7JOmX4gvbP0PhCeuR9kkpNOUjlL6c8Jsgy52RXb+2RxmFxfERsPQWqIrBzmBsUV1UWeLsMesOik7u0vM3zTR/qTaErmvuzw5TdVcxPpZLQpl81RthedILb702xuvHA7MPzZJ0WL+kksNrTz5BYS0huDC1ZVL508MHPlXLERdMMdAvyhV1j+GG68evUueSoIiGDGJKUlRbEVmfVALMHuvZfnpBeMMzy9YfyEA41Xq1fYVjiRlVRamKCay+CiZckBp/kbu7GNUZZI4+OViSmIQI5rmpEg1t2eJfPHtZ1zc4f4KOlJ17STT9BSmw6I+YAgO0EqEx9DGwXpL/TWHvao6SaCIfHvhrn4OYPB3AoMAX3kGrEQ3w9FgxO6yO6FofzvwleHKBwBjn9mw4ACSqy6h7aQT4OVwzo0kv1FhU3DY8OKNXW/9WKI+HxsvO2hplAzwLzano99v0jo2zol+LPcW64CtDMf+wutNvNGJiLaNArtWgpmOjTSP+ll4nxYIo2xYTkeCxuyQR+wwQTWPs/Pat6TH3WaKDc9Tbyll36LfaXZQEkANVuLz1XQ4a+pdpZO7s4jAyjs/C0Z71iVP3bDiEfASvkx2anDuMo/ieFSx8GJ1DIxgbiE/KI3UHVAKUdJqcxfjrjp4TzAk6H/0MMUezExJVyULNKxzrjdIL8SwbkbeeWjRIRT0F6GcWCouItBAUl5WH/k5feDuSg/oMSpo6adrMQHj/fk1krqEQSj9dx33049EaIj7ecLwHrSm0/FAiXjjy9ErYP6mVYj3t+oHNW6Y/3RO3kFVf7AgVKWbPFPBp6k+Mg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(7916004)(39860400002)(376002)(346002)(136003)(396003)(451199015)(40470700004)(36840700001)(46966006)(16526019)(40480700001)(2906002)(4326008)(26005)(9686003)(82740400003)(16576012)(186003)(33716001)(8936002)(70206006)(86362001)(110136005)(336012)(54906003)(8676002)(103116003)(478600001)(966005)(356005)(82310400005)(5660300002)(44832011)(316002)(7416002)(40460700003)(70586007)(81166007)(36860700001)(426003)(47076005)(83380400001)(41300700001)(71626007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2022 22:26:13.3695
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 819b0636-76f7-465f-c32f-08dab08e9993
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT086.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6782
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

